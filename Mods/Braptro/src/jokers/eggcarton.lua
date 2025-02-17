SMODS.Joker {
    key = 'eggcarton',
    loc_txt = {
        name = 'Egg Carton',
        text = {
            'Gains {C:money}$8{} of',
            '{C:attention}sell value{} at',
            'end of round',
            '{C:green}#2# in 6{} chance',
            'of breaking',
        }
    },

    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = { x = 6, y = 0 },
    config = {
        extra = {}
    },

    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra_value , G.GAME.probabilities.normal} }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.main_eval and context.game_over == false and not context.repetition and not context.blueprint then
             if pseudorandom('eggcarton') < G.GAME.probabilities.normal / 6 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Cracked!'
                }
            else
                card.ability.extra_value = card.ability.extra_value + 8
                card:set_cost()
				return {
					message = 'Value Up!'
				}
            end
        end
    end
}
