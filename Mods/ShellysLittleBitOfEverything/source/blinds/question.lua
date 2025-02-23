local blind = {
	name = 'The Question',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Question',
		text = {'-1 hand size',
				'per hand played'}
	},
	discovered = true,
	boss_colour = HEX('69CF9A'),
	pos = { x = 0, y = 12 },
}

local handsplayed = 0

         
blind.set_blind = function (self)
	handsplayed = 0
end

blind.press_play = function (self)
	handsplayed = handsplayed + 1
	G.hand:change_size(-1)
	G.GAME.blind:wiggle()
end

blind.defeat = function (self)
	G.hand:change_size(handsplayed)
end

blind.disable = function (self)
	G.hand:change_size(handsplayed)
end

return blind