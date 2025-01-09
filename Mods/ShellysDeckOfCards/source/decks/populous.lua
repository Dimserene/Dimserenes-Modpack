local deck = {
	name = "Populous Deck",
	pos = { x = 0, y = 0 },
	loc_txt = {
		name = "Populous Deck",
		text = {
			"All {C:attention}Face Cards{} have",
			"a {C:red}Red Seal{} on them"
		},
	},
	config = {},
}


deck.apply = function(self)
	G.E_MANAGER:add_event(Event({

		func = function()

			for _, card in ipairs(G.playing_cards) do
				if card:is_face() then
					card:set_seal("Red", true, true)
				end
			end
			return true
		end
	}))
end

return deck