local blind = {
	name = 'Fuchsia Pillar',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10, showdown = true },

	loc_txt = {
		name = 'Fuchsia Pillar',
		text = {'Debuff all cards',
				'below rank 10'}
	},
	discovered = true,
	boss_colour = HEX('C66FC9'),
    pos = { x = 0, y = 14 },
}

blind.recalc_debuff = function (self, card, from_blind)
    local card_debuffed = false
    for _, rank in ipairs({'2', '3', '4', '5', '6', '7', '8', '9'}) do
        if card.base.value == rank then
            card_debuffed = true
        end
    end
    return card_debuffed
end

return blind