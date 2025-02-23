local deck = {
	name = "Hexed Deck",
	pos = { x = 4, y = 1 },
	loc_txt = {
		name = "Hexed Deck",
		text = {
			"{C:attention}One{} card played",
			"in hand becomes {C:spades}Spades{}",
			"during each {C:attention}Boss Blind{}"
		},
	},
}

deck.apply = function(self)
	return true
end

deck.trigger_effect = function(self, args)
	if G.GAME.blind.boss and args.context == "final_scoring_step" then
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.75,
			func = (function()
				
				attention_text({
					scale = 1.5,
					text = 'Hexed!',
					hold = 2,
					align = 'cm',
					offset = { x = 0, y = -2.7 },
					color = 'Tarot',
                    major = G
                    .play
				})

				local card_selected = pseudorandom_element(G.play.cards, pseudoseed(self.key))

				card_selected:flip()
				card_selected:juice_up(0.3, 0.3);
				card_selected:change_suit('Spades')
				play_sound('card1', 1)

				card_selected:flip()
				card_selected:juice_up(0.3, 0.3)
				play_sound('slbe_hexed', 1, 0.75)
				return true
			end)
		}))
	end
end

return deck