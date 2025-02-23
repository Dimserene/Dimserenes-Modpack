local blind = {
	name = 'The Negative',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Negative',
		text = {'+1 Discard,',
				'-2 Hand Size'}
	},
	discovered = true,
	boss_colour = HEX('Cf697A'),
	pos = { x = 0, y = 10 },
}

blind.set_blind = function (self)
	ease_discard(1)
	G.hand:change_size(-2)
end

blind.defeat = function (self)
	G.hand:change_size(2)
end

blind.disable = function (self)
	G.hand:change_size(2)
end

return blind