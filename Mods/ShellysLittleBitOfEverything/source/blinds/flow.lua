local blind = {
	name = 'The Flow',
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Flow',
		text = { 'All hands start',
			    'at 3 Mult',}
	},
	discovered = true,
	boss_colour = HEX('C64280'),
	pos = { x = 0, y = 5 },
}

blind.modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
    return 3, hand_chips, true
end

return blind