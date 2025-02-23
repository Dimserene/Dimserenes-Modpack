local deck = {
	name = "Somber Deck",
	pos = { x = 9, y = 0 },
	loc_txt = {
		name = "Somber Deck",
		text = {
			"{C:attention}10{} non-{C:clubs}Club{} cards",
			"are converted to {C:clubs}Clubs{}",
			"All {C:hearts}Heart{} cards",
			"are then {C:attention}removed{}"
			
		},
	},
	config = {},
}


deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
    
		func = function()

			local i = 1
			while i <= 10 do
				local card_procced = pseudorandom_element(G.playing_cards, pseudoseed(self.key))
				if card_procced.base.suit ~= 'Clubs' then
					card_procced:change_suit('Clubs')
					i = i + 1
				end
			end

			local k = 1
			while k <= #G.playing_cards do
				v = G.playing_cards[k]
				if v.base.suit == 'Hearts' then
					v:remove()
				else
					k = k + 1
				end
			end

			return true
		end
	}))
end

return deck