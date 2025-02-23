local deck = {
	name = "Cursed Deck",
	pos = { x = 2, y = 1 },
	loc_txt = {
		name = "Cursed Deck",
		text = {
			"{C:attention}Listed{} {C:dark_edition}probabilities{}",
            "{C:red}cannot{} trigger",
            "{C:red}+#1#{} discard"
		},
	},
    config = {discards = 1}
}

deck.loc_vars = function(self, info_queue, card)
    return { vars = {self.config.discards} }
end

deck.apply = function(self)
    G.E_MANAGER:add_event(Event({
        func = function()

            for k, v in pairs(G.GAME.probabilities) do
                G.GAME.probabilities[k] = 0
            end
            return true
        end
    }))
end

return deck