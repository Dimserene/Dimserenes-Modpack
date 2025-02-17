SMODS.Joker {
    key = 'slotmachine',
    loc_txt = {
        name = 'Slot Machine',
        text = {
            'Each played {C:attention}7{} is',
            'counted as a random',
            '{C:attention}enhancement{} type',
        }
    },

    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 3, y = 0 },
    config = {
        extra = {}
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { } }
    end,

    calculate = function(self, card, context)
        if (context.individual) and (context.other_card:get_id() == 7) and (context.cardarea == G.play) then
            if pseudorandom('slotmachinespecial') <= G.GAME.probabilities.normal/30 then
                return {
                    chips = 80,
                    mult = 12,
                    xmult = 5,
                }
            end

            local rand = pseudorandom('slotmachine')
            if rand < 1/4 then
                return { chips = 30 }
            elseif rand <= 2/4 then
                return { mult = 4 }
            elseif rand <= 3/4 then
                return { xmult = 2 }
            elseif rand <= 1 then
                local result = {}
                if pseudorandom('slotmachine') <= G.GAME.probabilities.normal/5 then
                    result.mult = 20
                end
                if pseudorandom('slotmachine') <= G.GAME.probabilities.normal/15 then
                    result.dollars = 20
                end
                return result
            end
        end
        if context.cardarea == G.play and context.repetition then
            return {
                message = 'Again!',
                repetitions = 1,
                card = context.other_card
            }
        end
    end
}
