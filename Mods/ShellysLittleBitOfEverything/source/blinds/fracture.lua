local blind = {
	name = 'The Fracture',
	dollars = 5,
	mult = 0.5,
	boss = { min = 3, max = 10 },
	loc_txt = {
		name = 'The Fracture',
		text = {'Destroy first played card',
				'if 2+ cards are played',}
	},
	discovered = true,
	boss_colour = HEX('672A62'),
    pos = { x = 0, y = 6 },
}

blind.press_play = function(self)
    G.E_MANAGER:add_event(Event({func = function()
        if #G.play.cards > 1 then
            G.play.cards[1]:start_dissolve()
            G.GAME.blind:wiggle()
        end
        return true
    end}))
    return true
end

return blind