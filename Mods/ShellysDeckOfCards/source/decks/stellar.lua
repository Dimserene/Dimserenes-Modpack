local deck = {
	name = "Stellar Deck",
	pos = { x = 1, y = 1 },
	loc_txt = {
		name = "Stellar Deck",
		text = {
			"{C:tarot}Poker hands{} start",
			"with {C:attention}+#1#{} {C:planet}level{}"
			
		},
	},
	config = {extra_levels = 1},
	
}

deck.loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra_levels} }
end


deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
    
		func = function()
			for k, v in pairs(G.GAME.hands) do
				local i = 0
				while i < self.config.extra_levels do
					level_up_hand(self, k, true)
					i = i + 1
				end
			end
			return true
		end
	}))
end

return deck