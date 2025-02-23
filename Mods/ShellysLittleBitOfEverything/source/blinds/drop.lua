local blind = {
	name = 'The Drop',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Drop',
		text = {'Debuff all cards',
				'of ranks below 6'}
	},
	discovered = true,
	boss_colour = HEX('6262FF'),
	pos = { x = 0, y = 1 },
}

blind.recalc_debuff = function (self, card, from_blind)
	local card_debuffed = false
	for _, rank in ipairs({'Ace', '2', '3', '4', '5'}) do
		if card.base.value == rank then
			card_debuffed = true
		end
	end
	return card_debuffed
end

return blind