--- STEAMODDED HEADER
--- MOD_NAME: Wild Bill Joker
--- MOD_ID: wildbill
--- MOD_AUTHOR: [skpacman]
--- MOD_DESCRIPTION: Add's Wild Bill Joker & Dead Man's Hand
--- BADGE_COLOUR: c20000
--- DISPLAY_NAME: Wild Bill Joker
--- PREFIX: wbill
--- VERSION: 0.5.7
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE-------------------------

-- Define the custom atlas.
SMODS.Atlas {
	key = "wbill",
	path = "wbill.png",
	px = 71,
	py = 95
}

SMODS.PokerHandPart{
	key = 'DeadMansHand',
	func = function(hand)
		local current_cards = {}
		for i = 1, #hand do
			table.insert(current_cards, hand[i])
		end
		if G.jokers ~= nil then
			for _, v in ipairs(G.jokers.cards) do
				if v.config.center.key == 'j_wbill_WildBill' then
					activated = true
				end
			end
		else
			activated = false
		end
		local cardS_8 = 0
		local cardS_A = 0
		local cardC_8 = 0
		local cardC_A = 0
		local handcount = 0
		for i = 1, #hand do
			if hand[i]:get_id() == 14 and hand[i]:is_suit("Spades", nil, true) then cardS_A = 1 end
			if hand[i]:get_id() == 14 and hand[i]:is_suit("Clubs", nil, true) then cardC_A = 1 end
			if hand[i]:get_id() == 8 and hand[i]:is_suit("Spades", nil, true) then cardS_8 = 1 end
			if hand[i]:get_id() == 8 and hand[i]:is_suit("Clubs", nil, true) then cardC_8 = 1 end
			handcount = handcount +1
		end
		deadhand_detect = cardS_8 + cardS_A + cardC_8 + cardC_A
		if activated and deadhand_detect == 4 and handcount == 4 then
			local scoring_cards = {}
			for i = 1, #hand do
				local card = hand[i]
				if (card:get_id() == 14 and card:is_suit("Spades", nil, true)) or
				   (card:get_id() == 14 and card:is_suit("Clubs", nil, true)) or
				   (card:get_id() == 8 and card:is_suit("Spades", nil, true)) or
				   (card:get_id() == 8 and card:is_suit("Clubs", nil, true)) then
					table.insert(scoring_cards, card)
				end
			end
		return {scoring_cards}
		end

		return {} 
	end
}

SMODS.Consumable {
    set = 'Planet',
    key = 'deadwood',
    config = { hand_type = 'wbill_DeadMansHand' },
    pos = {x = 1, y = 0 },
    atlas = 'wbill',
    set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize('k_planet_q'), get_type_colour(self or card.config, card), nil, 1.2)
    end,
    process_loc_text = function(self)
        local target_text = G.localization.descriptions[self.set]['c_mercury'].text
        SMODS.Consumable.process_loc_text(self)
        G.localization.descriptions[self.set][self.key].text = target_text
    end,
    generate_ui = 0,
    loc_txt = {
        ['en-us'] = {
            name = 'Deadwood'
        }
    }
}

SMODS.PokerHand{ -- Dead Man's Hand
	key = 'wbill_DeadMansHand',
	above_hand = 'Full House',
	visible = false,
	chips = 50,
	mult = 12,
	l_chips = 25,
	l_mult = 4,
	loc_txt = {
		name = "Dead Man's Hand",
		description = {"Two Pair. Black Aces and 8's ONLY."},
	},
	example = {
		{"C_A", true},
		{"S_A", true},
		{"C_8", true},
		{"S_8", true},
	},
	evaluate = function(parts)
		return parts.wbill_DeadMansHand
	end,
}
function set_xmult(self, card, context, val)
	-- did you specify a value?
	if not val then
		-- nope, didn't specify a value
		-- Has DMH been played before getting this card?
		if G.GAME.hands[card.ability.hand].played == 0 then
			-- if not, xmult should be 1
			card.ability.extra.Xmult = 1
		elseif G.GAME.hands[card.ability.hand].played > 0 then
			-- if so, xmult should be ..played + ..xmult_mod
			card.ability.extra.Xmult = G.GAME.hands[card.ability.hand].played + card.ability.extra.Xmult_mod
			return true
		end
	else
		-- you did specify a value! explicitly set it!
		card.ability.extra.Xmult = val
	end
end

-- Wild Bill Joker definition.
SMODS.Joker({
	key = 'WildBill',
	loc_txt = {
		name = 'Wild Bill',
		text = {
			"{X:mult,C:white}+X#4#{} for each {C:attention}Dead Man's Hand{}",
			"played this run",
			"{C:red}+#2#{} Mult and {X:mult,C:white}X#3#{} every hand",
		}
	},
	config = {
		d_size = 0,
		extra = {
			Hmult = 8,
			Xmult = 1,
			Xmult_mod = 1,
			initial_set = false,
			},
		hand = "wbill_DeadMansHand",
		},
	loc_vars = function(self, info_queue, card)
		set_xmult(self, card, context, nil)
		return {
			vars = {
				card.ability.d_size,
				card.ability.extra.Hmult,
				card.ability.extra.Xmult,
				card.ability.extra.Xmult_mod
			}
		}
	end,
	rarity = 2,
	atlas = 'wbill',
	pos = { x = 0, y = 0 },
	cost = 6,
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = true,
	calculate = function(self, card, context)
		-- Has the xmult been initially set? if not, set it.
		if card.ability.extra.initial_set == false then
			card.ability.extra.initial_set = true
			set_xmult(self, card, context, nil)
		end
		
		-- If DMH is played, increment xmult with message before scoring
		if context.before and card.ability.hand == context.scoring_name then 
			set_scored_xmult = set_xmult(self, card, context, nil)
			if set_scored_xmult then 
				return { message = "+X" ..  card.ability.extra.Xmult_mod}
			end
		end
		
		-- Process current stats every hand
		if context.joker_main then
			return {
				mult = card.ability.extra.Hmult,
				xmult = card.ability.extra.Xmult,
				card = card,
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
		-- Has the xmult been initially set? if not, set it.
		if card.ability.extra.initial_set == false then
			card.ability.extra.initial_set = true
			set_xmult(self, card, context, nil)
		end
	end,
})

SMODS.Back{
	name = "Mann's Gambit",
	key = "wbill_deck",
	atlas = "wbill",
	pos = { x = 2, y = 0 },
	config = {},
	loc_txt = {
		name = "Mann's Gambit",
		text = {
			"Starts with a",
			"{C:attention,T:j_wbill_WildBill}Wild Bill{} Joker!",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				SMODS.add_card({
					set = "Joker",
					key = "j_wbill_WildBill",
					area = G.jokers,
					blueprint_compat = true,
				})
				return true
			end
		}))
	end
}
----------------------------------------------
------------MOD CODE END----------------------
