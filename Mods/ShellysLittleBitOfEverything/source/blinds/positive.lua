local blind = {
	name = 'The Positive',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Positive',
		text = {'-2 Hands,',
				'+2 Hand Size'}
	},
	discovered = true,
	boss_colour = HEX('5078CF'),
	pos = { x = 0, y = 9 },
}

blind.in_pool = function ()
	if G.GAME.round_resets.hands > 1 then
		return true
	else
		return false
	end
	return false
end

blind.set_blind = function (self)
	ease_hands_played(-2)
	G.hand:change_size(2)
end

blind.defeat = function (self)
	G.hand:change_size(-2)
end

blind.disable = function (self)
	ease_hands_played(2)
	G.hand:change_size(-2)
end

return blind