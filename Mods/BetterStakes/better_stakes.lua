--- STEAMODDED HEADER
--- MOD_NAME: Better Stakes
--- MOD_ID: BetterStakes
--- MOD_AUTHOR: [kjossul]
--- MOD_DESCRIPTION: Rework of orange and gold stakes to, hopefully, reduce the need of constant resetting.

----------------------------------------------
------------MOD CODE -------------------------
function SMODS.INIT.BetterStakes()
    sendDebugMessage("Loaded BetterStakes~")

    -- orange stake modifications: packs with more than 2 cards have one less card instead
    -- gold stake: set probability of a card to be debuffed (doesn't get affected by "Oops! All 6s")
    local DEBUFF_CHANCE = 0.10

    -- change localization
    G.localization.descriptions.Stake.stake_orange.text = {
        "Booster Packs {C:attention}with 3 or more cards{}",
        "contain {C:red}1 less{} instead",
        "{s:0.8}Applies all previous Stakes"
    }
    G.localization.descriptions.Stake.stake_gold.text = {
        "Each card has {C:attention}" .. DEBUFF_CHANCE * 100  .. "% chance{}",
        "to be {C:red}debuffed{}",
        "{s:0.8}Applies all previous Stakes"
    }
    init_localization() 

    -- Reverts vanilla stake changes. A bit hacky to do it in this function but is called immediately after the stake modifiers, and nowhere else.
    local back_apply_to_run_ref = Back.apply_to_run
    function Back.apply_to_run(self)
        if G.GAME.stake >= 7 then G.GAME.modifiers.booster_ante_scaling = false end
        if G.GAME.stake >= 8 then 
            G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size + 1
        end
        return back_apply_to_run_ref(self)
    end

    -- orange stake
    local card_open_ref = Card.open
    function Card.open(self)
        if G.GAME.stake >= 7 and self.ability.set == "Booster" and self.ability.extra > 2 then
            self.ability.extra = self.ability.extra - 1
        end
        return card_open_ref(self)      
    end

    -- gold stake
    local blind_debuff_card_ref = Blind.debuff_card
    local rolls = {}
    function Blind.debuff_card(self, card, from_blind)
        result = blind_debuff_card_ref(self, card, from_blind)
        if G.STATE == G.STATES.BLIND_SELECT then
            rolls[card]  = pseudorandom(pseudoseed('gold_stake_debuff'))  -- sets rolls at the start so that arcanas don't change debuffs
        elseif G.STATE == G.STATES.ROUND_EVAL then
            rolls = {}  -- removes rolls after round finish, so that cards are not shown as debuffed in the menu
        end
        if card.area ~= G.jokers and G.GAME.stake >= 8 and rolls[card] and rolls[card] < DEBUFF_CHANCE then
            card:set_debuff(true)
        end
        return result
    end
end
----------------------------------------------
------------MOD CODE END----------------------