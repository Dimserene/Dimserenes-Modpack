local blind = {
	name = "The Purity",
	boss = {
		min = 1,
		max = 10,
	},
	loc_txt = {
		name = 'The Purity',
		text = { 'All negative and polychrome',
			    'Jokers are debuffed',}
	},
	discovered = true,
	boss_colour = HEX("969696"), --nice B)
    pos = { x = 0, y = 11 },
}

blind.in_pool = function ()
    if not G.jokers then
        return false
    end
    for i, j in pairs(G.jokers.cards) do
        if j.edition == true then
            if j.edition.negative or j.edition.polychrome == true then
                return true
            end
        end
    end

    return false
end

blind.recalc_debuff = function (self, card, from_blind)
    if (card.area == G.jokers) and not G.GAME.blind.disabled and card.edition == true then
        if card.edition.negative or card.edition.negative == true then
            return true
        end
    end
    return false
end

return blind