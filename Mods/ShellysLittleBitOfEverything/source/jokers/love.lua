joker = {
    pos = { x = 2, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Love",
        text = {"This card gains {C:mult}+#1#{} Mult",
                "if hand contains a {C:hearts}Hearts{} Flush",
                "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult){}"}
    },
    config = {extra = {mult = 0, mult_mod = 9}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult} }
end

joker.calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Flush']) then

        local all_hearts = true
        for _, i in ipairs(G.play.cards) do
            if i.base.suit ~= 'Hearts' then
                all_hearts = false
            end
        end

        if all_hearts then 
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod

            return {
                message = 'Upgraded!',
                colour = G.C.RED
            }
        end
	end

    if context.joker_main then
        return {
            message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult }, color = "mult" },
            mult_mod = card.ability.extra.mult
        }
    end
end
return joker