joker = {
    pos = { x = 4, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Wealth",
        text = {"Gives {C:money}$#1#{} at end of round,",
                "increase amount by {C:money}$#2#{} when",
                "a {C:diamonds}Diamonds{} Flush is played",}
    },
    config = {extra = {dollars = 1, dollars_mod = 1}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod} }
end

joker.calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Flush']) then

        local all_diamonds = true
        for _, i in ipairs(G.play.cards) do
            if i.base.suit ~= 'Diamonds' then
                all_diamonds = false
            end
        end

        if all_diamonds then 
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.dollars_mod

            return {
                message = 'Upgraded!',
                colour = G.C.MONEY
            }
        end
	end
end

joker.calc_dollar_bonus = function(self, card)
    local bonus = card.ability.extra.dollars
    if bonus > 0 then return bonus end
end
return joker