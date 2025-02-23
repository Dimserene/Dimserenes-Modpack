joker = {
    pos = { x = 3, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Labour",
        text = {"This card gains {X:mult,C:white} X#1# {} Mult",
                "if hand contains a {C:spades}Spades{} Flush",
                "{C:inactive}(Currently {X:mult,C:white} X#2# {}{C:inactive} Mult){}"}
    },
    config = {extra = {Xmult = 1, Xmult_mod = 0.25}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
end

joker.calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Flush']) then

        local all_spades = true
        for _, i in ipairs(G.play.cards) do
            if i.base.suit ~= 'Spades' then
                all_spades = false
            end
        end

        if all_spades then 
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod

            return {
                message = 'Upgraded!',
                colour = G.C.RED
            }
        end
	end

    if context.joker_main then
        return {
            message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult }, color = "mult" },
            Xmult_mod = card.ability.extra.Xmult
        }
    end
end
return joker