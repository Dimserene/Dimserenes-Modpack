local function update_playing_card(card)
	local suit_prefix = string.sub(card.base.suit, 1, 1)

	if suit_prefix == "H" then
		suit_prefix = "C"
	elseif suit_prefix == "C" then
		suit_prefix = "D"
	elseif suit_prefix == "D" then
		suit_prefix = "S"
	elseif suit_prefix == "S" then
		suit_prefix = "H"
	end

	local rank_suffix = card.base.id

	if rank_suffix < 10 then
		rank_suffix = tostring(rank_suffix)
	elseif rank_suffix == 10 then
		rank_suffix = "T"
	elseif rank_suffix == 11 then
		rank_suffix = "J"
	elseif rank_suffix == 12 then
		rank_suffix = "Q"
	elseif rank_suffix == 13 then
		rank_suffix = "K"
	elseif rank_suffix == 14 then
		rank_suffix = "A"
	end

	card:set_base(G.P_CARDS[suit_prefix .. "_" .. rank_suffix])
end

local Back_trigger_effect_ref = Back.trigger_effect
function Back:trigger_effect(args)
	sendInfoMessage(args.context)
	if self.effect.config.suit_up and args.context == "final_scoring_step" then
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				play_sound("card1", 1.15)
				for idx = #G.playing_cards, 1, -1 do
					G.playing_cards[idx]:flip()
					G.playing_cards[idx]:juice_up(0.3, 0.3)
				end
				return true
			end,
		}))

		delay(0.2)

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.1,
			func = function()
				for idx = #G.playing_cards, 1, -1 do
					update_playing_card(G.playing_cards[idx])
				end
				return true
			end,
		}))

		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.15,
			func = function()
				play_sound("tarot2", 0.85, 0.6)
				for idx = #G.playing_cards, 1, -1 do
					G.playing_cards[idx]:flip()
					G.playing_cards[idx]:juice_up(0.3, 0.3)
				end

				return true
			end,
		}))
	end

	return Back_trigger_effect_ref(self, args)
end

SMODS.Atlas({
	key = "suit_up_deck",
	path = "suit_up_deck.png",
	px = 71,
	py = 95,
})

SMODS.Back({
	atlas = "suit_up_deck",
	config = {
		suit_up = true,
	},
	key = "suit_up",
	loc_txt = {
		name = "Suit Up Deck",
		text = {
			"All card suits rotate",
			"every hand played",
			"{C:red}H{} > {C:green}C{} > {C:attention}D{} > {C:blue}S{}",
		},
	},
	name = "Suit Up Deck",
	pos = { x = 0, y = 0 },
	prefix_config = {
		key = {
			mod = false,
		},
	},
})
