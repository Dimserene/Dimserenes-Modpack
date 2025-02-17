SMODS.Joker {
    key = 'sandcastle',
    loc_txt = {
        name = 'Sandcastle',
        text = {
            'This Joker gains {C:mult}+3{} Mult',
            'per {C:attention}consecutive{} hand',
            'played without playing a',
            'different {C:attention}poker hand{}',
            '{C:inactive}(Currently {}{C:mult}+#1#{C:inactive} Mult){}',
        }
    },

    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true ,
    eternal_compat = true ,
    perishable_compat = true ,
    pos = {x = 7, y = 0 } ,
    config = {
        extra = { mult = 0, prev_hand }
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
    calculate = function (self, card, context)
        if context.joker_main then
            prev_hand = prev_hand or context.scoring_name
            if  prev_hand == context.scoring_name then
                card.ability.extra.mult = card.ability.extra.mult + 3
                return { mult = card.ability.extra.mult }
            else
                card.ability.extra.mult = 0
                prev_hand = context.scoring_name
            end
        end
    end
}
