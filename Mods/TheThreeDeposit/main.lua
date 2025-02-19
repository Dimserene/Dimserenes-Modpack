--- STEAMODDED HEADER
--- MOD_NAME: Three Deposit
--- MOD_ID: THREEDEPOSIT
--- MOD_AUTHOR: [jonnydeates]
--- MOD_DESCRIPTION: Jokers with casino mechanics.
--- PREFIX: txjd
----------------------------------------------
------------MOD CODE -------------------------
function SMODS.INIT.ThreeDeposit()
    sendDebugMessage("Loaded Three Deposit Mod")
end
SMODS.Atlas{
    key = 'ThreeDeposit',
    path = 'Three_Deposit.png',
    px = 71,
    py = 95
}
SMODS.Atlas{
    key = 'ThreeDeck',
    path = 'Three_Deck.png',
    px = 71,
    py = 95
}
SMODS.Back{
    name = "The Three Deck",
    key = "three_deck",
    atlas = "ThreeDeck",
    pos = {x = 0, y = 0},
    config = {
        hands = -1,
        consumable_slots = 1,
        dollars = -1,
    },
    loc_txt = {
        name ="Three Deck",
        text={
            "Start with the Joker,",
            "the Three Deposit.",
            "The Deck only",
            "contains only {C.attention} 3s{}",
        },
    },
    loc_vars = function(self)
        return { vars = { self.config.discards, self.config.hands }}
    end,
    apply = function(self)
        G.E_MANAGER:add_event(Event({
            func = function()
                for _, card in ipairs(G.playing_cards) do
                    assert(SMODS.change_base(card, nil, '3'))
                end
                local three_deposit_joker = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_three-deposit')
                three_deposit_joker:add_to_deck()
                three_deposit_joker:set_eternal(true)
                G.jokers:emplace(three_deposit_joker)
                return true
            end
        }))
    end
}
local base = {
        atlas = 'ThreeDeposit',
        key = 'three-deposit',
        rarity = 2,
        cost = 3,
        unlocked = true,
        discovered = true,
        blueprint_compat = true,
        eternal_compat = true,
        perishable_compat = true,
        pos = {x = 0, y = 0},
        in_pool = function(self, _, _)
            return true
        end,
        loc_txt = {
            name = 'The Three Deposit',
            text = {
                'Every played {C:attention}3{}',
                'destroy it, and get {C:money}$3{}',
                'Up to {C:attention}3{} per round.',
                '({C:attention}#1#/3{})',
            }
        },
        loc_vars = function(self, info_queue, center)
            return {
                vars = {
                    center.ability.extra.count_destroyed,
                }
            }
        end,
        config = {
            extra = {
                count_destroyed = 0,
            }
        },
        calculate = function(self, jokerCard, context)
            if context.destroying_card and not context.blueprint then
                if context.destroying_card.base.value == '3' and jokerCard.ability.extra.count_destroyed < 3 then
                    jokerCard.ability.extra.count_destroyed = jokerCard.ability.extra.count_destroyed + 1
                    return {
                        dollars = 3,
                        remove = true
                    }
                end
            end
            if context.end_of_round then
                jokerCard.ability.extra.count_destroyed  = 0
            end
        end
}

SMODS.Joker(base)

----------------------------------------------
------------MOD CODE END----------------------
