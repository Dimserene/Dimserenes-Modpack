SMODS.Joker {
    key = 'freejoker',
    loc_txt = {
        name = 'Free Parking',
        text = {
            '{C:chips}+10{} Chips per {C:tarot}Tarot{}',
            'card used this run',
            '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)',
        }
    },

    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = {x = 4, y = 0 },
    config = {
        extra = { chips = 0 }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.using_consumeable then
            if (context.consumeable.ability.set == "Tarot") then
                card.ability.extra.chips = G.GAME.consumeable_usage_total.tarot * 10
                return {
				    message = 'Upgraded!',
				    colour = G.C.CHIPS,
				    card = card
			    }
            end
        end
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.tarot > 0 then
            card.ability.extra.chips = G.GAME.consumeable_usage_total.tarot * 10
		    return {
			    chips = card.ability.extra.chips
		    }
	    end
    end
}
