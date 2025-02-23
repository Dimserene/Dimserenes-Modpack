local blind = {
	name = 'The Symmetry',
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Symmetry',
		text = { 'All cards of even',
			    'ranks are debuffed',}
	},
    discovered = true,
	boss_colour = HEX('944B77'),
    pos = { x = 0, y = 13 },
}

blind.recalc_debuff = function (self, card, from_blind)
    local card_debuffed = false
    for _, rank in ipairs({'2', '4', '6', '8', '10'}) do
        if card.base.value == rank then
            card_debuffed = true
        end
    end
    return card_debuffed
end

return blind