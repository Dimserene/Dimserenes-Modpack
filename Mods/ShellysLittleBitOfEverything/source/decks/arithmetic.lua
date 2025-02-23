local deck = {
	name = "Arithmetic Deck",
	pos = { x = 1, y = 0 },
	loc_txt = {
		name = "Arithmetic Deck",
		text = {
			"All {C:attention}Aces{}, {C:attention}3s{} and {C:attention}5s{}",
			"are {C:chips,T:m_bonus}Bonus Cards{}",
			"All {C:attention}2s{} and {C:attention}8s{}",
			"are {C:mult,T:m_mult}Mult Cards{}",
		},
	},
    config = {},
}

deck.apply = function(self)
	G.E_MANAGER:add_event(Event({

		func = function()

			for _, card in ipairs(G.playing_cards) do
				--for some ungodly reason the ID of aces are rank 14 not rank 1
				for _, rank in ipairs({3, 5, 14}) do
					if rank == card:get_id() then
						card:set_ability(G.P_CENTERS.m_bonus, true)
					end
				end

				for _, rank in ipairs({2, 8}) do
					if rank == card:get_id() then
						card:set_ability(G.P_CENTERS.m_mult, true)
					end
				end
			end

			return true
		end
	}))
end

return deck
