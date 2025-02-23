local deck = {
	name = "Cluttered Deck",
	pos = { x = 5, y = 0 },
	loc_txt = {
		name = "Cluttered Deck",
		text = {
			"Start run with {C:attention}15{}",
			"cards in your deck",
			"{C:attention}enhanced{} at random"
		},
	},
	config = {},
}


deck.apply = function(self)
	local enhancements_added = 0
	G.E_MANAGER:add_event(Event({

		func = function()
			while enhancements_added < 15 do
				local card_procced = pseudorandom_element(G.playing_cards, pseudoseed(self.key))
				if card_procced.ability.set ~= 'Enhanced' then
					enhancements_added = enhancements_added + 1
					local enhancement_chosen = SMODS.poll_enhancement({key = self.key, guaranteed = true})
					card_procced:set_ability(G.P_CENTERS[enhancement_chosen], nil, true)
				end
			end
			return true
		end
	}))
end

return deck
