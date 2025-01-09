local deck = {
	name = "Ancient Deck",
	pos = { x = 2, y = 0 },
	loc_txt = {
		name = "Ancient Deck",
		text = {
			"All {C:attention}Face Cards{} are",
			"now {C:enhanced,T:m_stone}Stone Cards{}",
		},
	},
	config = {},
}


deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
    
		func = function()
			for _, card in ipairs(G.playing_cards) do
				if card:get_id() == 11 or
					card:get_id() == 12 or
					card:get_id() == 13 then
					card:set_ability(G.P_CENTERS.m_stone, nil, true)
				end
			end
			return true
		end
	}))
end

return deck