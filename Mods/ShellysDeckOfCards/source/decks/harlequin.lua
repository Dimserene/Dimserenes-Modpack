local deck = {
	name = "Harlequin Deck",
	pos = { x = 7, y = 0 },
	loc_txt = {
		name = "Harlequin Deck",
		text = {
            "{C:attention}Suits{} are tied to its",
			"respective card's {C:attention}rank{}",
			"{C:inactive,s:0.8}({}{C:spades,s:0.7}K, Q, J, {}{C:hearts,s:0.7}10, 9, 8, {}{C:clubs,s:0.7}7, 6, 5, {}{C:diamonds,s:0.7}4, 3, 2{}{C:inactive,s:0.7}){}",
			"{C:inactive,s:0.8}(Aces are removed){}"
		},
	},
	config = {},
}

deck.apply = function(self)

    G.E_MANAGER:add_event(Event({

		func = function()

			for _, card in ipairs(G.playing_cards) do
				for _, rank in ipairs({2, 3, 4}) do
					if card:get_id() == rank then
						card:change_suit('Diamonds')
					end
				end

				for _, rank in ipairs({5, 6, 7}) do
					if card:get_id() == rank then
						card:change_suit('Clubs')
					end
				end

				for _, rank in ipairs({8, 9, 10}) do
					if card:get_id() == rank then
						card:change_suit('Hearts')
					end
				end

				for _, rank in ipairs({11, 12, 13}) do
					if card:get_id() == rank then
						card:change_suit('Spades')
					end
				end
            end


			for _, card in ipairs(G.playing_cards) do
				if card:get_id() == 14 then
					card:remove()
				end
			end
            return true
        end}))
end

return deck