local deck = {
	name = "Romantic Deck",
	pos = { x = 6, y = 0 },
	loc_txt = {
		name = "Romantic Deck",
		text = {
			"All {C:hearts}Heart{} cards are",
			"now {C:attention,T:m_wild}Wild Cards{}",
		},
	},
	config = {},
}


deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
    
		func = function()
			for _, card in ipairs(G.playing_cards) do
				if card.base.suit == 'Hearts' then
					card:set_ability(G.P_CENTERS.m_wild, nil, true)
				end
			end
			return true
		end
	}))
end

return deck