function add_joker_to_game(arg_key, arg_loc, arg_joker)
	arg_joker.key = arg_key
	arg_joker.order = #G.P_CENTER_POOLS["Joker"] + 1

	G.P_CENTERS[arg_key] = arg_joker
	table.insert(G.P_CENTER_POOLS["Joker"], arg_joker)
	table.insert(G.P_JOKER_RARITY_POOLS[arg_joker.rarity], arg_joker)

	G.localization.descriptions.Joker[arg_key] = arg_loc
end

local card_calculate_joker_ref = Card.calculate_joker
function Card.calculate_joker(self, context)
	local calculate_joker_ref = card_calculate_joker_ref(self, context)

	return calculate_joker_ref
end

local function update_playing_card(card)
	local suit = string.sub(card.base.suit, 1, 1)
	local rank = tostring(card.base.id)
	if rank == "1" then
		rank = "T"
	elseif rank == "10" then
		rank = "T"
	elseif rank == "11" then
		rank = "J"
	elseif rank == "12" then
		rank = "Q"
	elseif rank == "13" then
		rank = "K"
	elseif rank == "14" then
		rank = "A"
	end

	if card.base.id < 10 then
		card:start_dissolve(nil, true)
	else
		if rank == "A" then
			card:set_ability(G.P_CENTERS.m_mult)
		elseif rank == "K" then
			card:set_ability(G.P_CENTERS.m_gold)
		elseif rank == "Q" then
			card:set_ability(G.P_CENTERS.m_lucky)
		elseif rank == "J" then
			card:set_ability(G.P_CENTERS.m_steel)
		elseif rank == "T" then
			card:set_ability(G.P_CENTERS.m_bonus)
		end
	end
end

local Back_apply_to_run_ref = Back.apply_to_run
function Back:apply_to_run(...)
	Back_apply_to_run_ref(self, ...)

	if self.effect.config.royalty then
		G.E_MANAGER:add_event(Event({
			func = function()
				for idx = #G.playing_cards, 1, -1 do
					update_playing_card(G.playing_cards[idx])
				end

				G.starting_deck_size = #G.playing_cards

				-- code for jokers
				local joker_list = {}
				for idx = 1, #joker_list, 1 do
					local card = create_card("Joker", G.jokers, false, nil, nil, nil, joker_list[idx], nil)
					card:add_to_deck()
					G.jokers:emplace(card)
				end
				return true
			end,
		}))
	end
end

SMODS.Atlas({
	key = "royal_deck",
	path = "royal_deck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	atlas = "royal_deck",
	config = {
		discards = -1,
		hands = -2,
		royalty = true,
		voucher = "v_seed_money",
	},
	key = "royal",
	loc_txt = {
		name = "Royal Deck",
		text = {
			"Start with {C:mult,T:m_mult}Mult{} Aces, {C:money,T:m_gold}Gold{}",
			"Kings, {C:green,T:m_lucky}Lucky{} Queens, {C:inactive,T:m_steel}Steel{}",
			"Jacks, and {C:chips,T:m_bonus}Bonus{} 10s",
			"Start with {C:attention,T:v_seed_money}Seed Money{}",
			"{C:blue}-2{} hands",
			"{C:red}-1{} discard{}",
		},
	},
	name = "Royal Deck",
	pos = { x = 0, y = 0 },
	prefix_config = {
		key = {
			mod = false,
		},
	},
})
