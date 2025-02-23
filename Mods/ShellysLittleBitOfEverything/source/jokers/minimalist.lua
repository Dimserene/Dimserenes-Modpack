joker = {
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Minimalist Joker",
        text = {"{C:chips}+#1#{} Chips per {C:attention}Joker{}",
                "slot if there is at",
                "least {C:attention}#3#{} empty slot",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"}
    },
    config = {extra = {chips_per_slot = 50, empty_needed = 1, chips = 0}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips_per_slot, card.ability.extra.chips, card.ability.extra.empty_needed } }
end

joker.update = function(self, card, dt)
    if G.jokers then
        if (G.jokers.config.card_limit - #G.jokers.cards) >= card.ability.extra.empty_needed then
            card.ability.extra.chips = card.ability.extra.chips_per_slot * G.jokers.config.card_limit

        elseif (G.jokers.config.card_limit - #G.jokers.cards) < card.ability.extra.empty_needed then
            card.ability.extra.chips = 0

        end
    end
end

joker.calculate = function(self, card, context)
    if context.joker_main then
        if (G.jokers.config.card_limit - #G.jokers.cards) >= card.ability.extra.empty_needed then
            return {
			    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
			    chip_mod = card.ability.extra.chips
            }
        end
    end
    
end
return joker