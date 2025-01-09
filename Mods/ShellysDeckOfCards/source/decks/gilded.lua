local deck = {
	name = "Gilded Deck",
	pos = { x = 0, y = 1 },
	loc_txt = {
		name = "Gilded Deck",
		text = {
			"Earn double {C:money}Interest{}",
            "Begin run at {C:red}-$#2#{}"
        }
	},
	config = {extra = {beginning_debt = 10}}
}

deck.loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.loan_amount, self.config.extra.beginning_debt} }
end

deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
		func = function()
            --subtracting it by G.GAME.dollars sets the money to 0, then subtracting it by the debt puts us in the desired amount of debt
            ease_dollars((G.GAME.dollars + self.config.extra.beginning_debt) * -1)
            G.GAME.interest_amount = G.GAME.interest_amount * 2
			return true
		end
	}))
end

return deck