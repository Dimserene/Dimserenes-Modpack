local blind = {
    name = 'The Love',
    pos = { x = 0, y = 8 },
	loc_txt = {
		name = 'The Love',
		text = { 'All hands start',
			    'at 15 Chips',}
	},
	discovered = true,
	boss_colour = HEX('E05E69'),
	boss = { min = 1, max = 10 },
}

blind.modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
	return mult, 15, true
end

return blind