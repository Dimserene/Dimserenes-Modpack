local deck = {
	name = "Liquid Deck",
	pos = { x = 3, y = 1 },
	loc_txt = {
		name = "Liquid Deck",
		text = {
			"{C:planet}Leveling{} a {C:tarot}poker hand{}",
            "also {C:planet}levels{} up your",
			"{C:attention}lowest{} level {C:tarot}poker hand{}",
            "{C:inactive,s:0.7}(Upgrades lowest {}{C:attention,s:0.7}ranking{}{C:inactive,s:0.7} of lowest{}",
			"{C:inactive,s:0.7}level hands if there's a tie){}"
		},
	},
	config = {},
}

deck.apply = function(self)
	return true
end

deck.trigger_effect = function(self, args)
	if args.context == 'using_consumeable' and args.consumeable.ability.set == "Planet" then
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.2,
			func = (function()
				--this is all jenlib stuff
				local low_hand = jl.lowhand()

				jl.th(low_hand)
				level_up_hand(self, low_hand, nil)
				jl.ch()

				sendInfoMessage("Upgraded lowest level hand", "Shellular's Deck of Cards")
				return true

			end)
		}))
	end
end

return deck