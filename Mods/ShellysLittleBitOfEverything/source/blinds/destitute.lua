local blind = {
    name = 'The Destitute',
    pos = { x = 0, y = 0 },
    loc_txt = {
        name = 'The Destitute',
        text = { 'All consumable cards are',
                'destroyed on hand played',}
    },
    boss = { min = 1, max = 10 },
    boss_colour = HEX('656CF7'),
    discovered = true
}

blind.press_play = function(self)
	if G.consumeables.cards[1] then
		G.E_MANAGER:add_event(Event({
			func = function() 
				for i in ipairs(G.consumeables.cards) do
					local card = G.consumeables.cards[i]
					card:start_dissolve()
					delay(0.23)
					G.GAME.blind:wiggle()
				end
				return true
			end}))
	end
end

return blind