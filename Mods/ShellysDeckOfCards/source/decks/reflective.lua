local deck = {
	name = "Reflective Deck",
	pos = { x = 4, y = 0 },
	loc_txt = {
		name = "Reflective Deck",
		text = {
			"On hand played, one",
			"card in deck {C:attention}becomes{}",
            "another card played",
			"{C:red}-1{} discard"
		},
	},
	config = { discards = -1 },
}

deck.apply = function(self)
	return true
end

deck.trigger_effect = function(self, args)
	if args.context == 'final_scoring_step' then
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.2,
			func = (function()
				---card in deck finding
				local randomCardInDeck = pseudorandom_element(G.playing_cards, pseudoseed(self.key))
				---card in hand finding and conversion
				local randomCardInHand = pseudorandom_element(G.play.cards, pseudoseed(self.key))

				if randomCardInHand ~= randomCardInDeck then
					copy_card(randomCardInHand, randomCardInDeck)
				end
				randomCardInHand:juice_up(1, 0.5)

				attention_text({
					scale = 1,
					text = 'Reflected!',
					hold = 2,
					align = 'cm',
					offset = { x = 0, y = -2.7 },
                    major = G
                    .play
				})
				
				if math.random(1,2) == 1 then
					play_sound('sdoc_reflect', 1, 0.75)
				else
					play_sound('sdoc_reflect2', 1, 0.75)
				end
				return true
			end)
		}))
	end
end

return deck