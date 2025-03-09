local loc_txt = SMODS.Atlas({
	key = "ddd_deck",
	path = "ddd_deck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	atlas = "ddd_deck",
	config = {
		voucher = "v_clearance_sale",
	},
	key = "ddd",
	loc_txt = {
		name = "Dealer's Discount Deck",
		text = {
			"Start with the",
			"{C:attention,T:v_clearance_sale}Clearance Sale{}",
			"Voucher",
		},
	},
	name = "Dealer's Discount Deck",
	pos = { x = 0, y = 0 },
	prefix_config = {
		key = {
			mod = false,
		},
	},
})
