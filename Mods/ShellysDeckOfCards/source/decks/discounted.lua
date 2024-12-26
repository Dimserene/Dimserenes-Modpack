local deck = {
	name = "Discounted Deck",
	pos = { x = 3, y = 0 },
	loc_txt = {
		name = "Discounted Deck",
		text = {
			"Start game with {C:money,T:v_liquidation}Liquidation{}",
			"{C:attention}Big Blinds{} give no",
            "reward money"
		},
	},
	config = { vouchers = { 'v_clearance_sale', 'v_liquidation' } },
}

deck.apply = function(self)
	G.E_MANAGER:add_event(Event({
		func = function()
			G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
			G.GAME.modifiers.no_blind_reward.Big = true
			return true
		end
	}))
end

return deck