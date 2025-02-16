----------------------------------------------
------------MOD CODE-------------------------
--[[ TODO
Rename all occurances of DomainExpansion to "Circus"
Rename all occurances of "dexp" to "skpac_cc"
Rename all occurances of "Slotmaster" to "Clown Car"
--]]


skpac_circus_mod = SMODS.current_mod
skpac_utils = SMODS.load_file("functions.lua")()

-- Define the custom atlas.
SMODS.Atlas {
	key = "skpac_circus",
	path = "circus.png",
	px = 71,
	py = 95
}

-- Slotmaster Joker definition.
SMODS.Joker(skpac_utils.create_joker {
	key = 'clowncar',
	loc_txt = {
		name = 'Clown Car',
		text = {
			"{C:red}+1{} Joker Slot when",
			"{C:attention}Boss Blind{} is Defeated",
			"{C:red}-1{} Joker Slot when",
			"{C:attention}Small/Big Blind{} is Skipped.",
			"{C:inactive}(If Joker Slots are full,{}",
			"{C:inactive}DESTROYS one random Joker){}"
		}
	},
	rarity = 3,
	atlas = 'skpac_circus',
	pos = { x = 0, y = 0 },
	cost = 12,
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	perishable_compat = false,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.entering_shop then 
			--skpac_utils.spawn_voucher()
		end
		mainMessage = nil
		extraMessage = nil
		-- End-of-round: add a joker slot.
		if context.end_of_round and context.main_eval and G.GAME.blind.boss then
			G.jokers.config.card_limit = G.jokers.config.card_limit + 1
			play_sound('negative', 1.5, 0.4)
			return {
				message = "+1 Joker Slot!"
			}
		-- Skip-blind: remove one slot and possibly destroy one joker.
		elseif context.skip_blind then
			-- Count protected jokers.
			local numProtected = 0
			for i = 1, #G.jokers.cards do
				local current = G.jokers.cards[i]
				if current == self or skpac_utils.getCardKey(current) == 'j_skpac_circus_clowncar' or (current.ability and current.ability.eternal) then
					numProtected = numProtected + 1
				end
			end
			local slotsToRemove = 1
			local new_limit = G.jokers.config.card_limit - slotsToRemove
			if G.jokers.config.card_limit ~= math.max(numProtected, new_limit) then
				play_sound('timpani')
				mainMessage = "-1 Joker Slot!"
			else
				play_sound('timpani')
				mainMessage = "Nothing to Destroy?!"
				extraMessage = "You're no fun..."
			end
			G.jokers.config.card_limit = math.max(numProtected, new_limit)
			-- If active jokers exceed allowed slots, remove one destructible joker.
			if #G.jokers.cards > G.jokers.config.card_limit then
				local destructable_jokers = {}
				for i = 1, #G.jokers.cards do
					local current = G.jokers.cards[i]
					if current ~= self and skpac_utils.getCardKey(current) ~= 'j_skpac_circus_clowncar' and not (current.ability and current.ability.eternal) and not current.getting_sliced then
						destructable_jokers[#destructable_jokers + 1] = current
					end
				end
				if #destructable_jokers > 0 then
					local joker_to_destroy = pseudorandom_element(destructable_jokers, pseudoseed('madness'))
					if joker_to_destroy then
						play_sound('slice1', 0.96 + math.random() * 0.08)
						extraMessage = "Random Joker Destroyed!"
						joker_to_destroy.getting_sliced = true
						G.E_MANAGER:add_event(Event({ func = function()
							joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
							return true
						end }))
					end
				end
			end
			return {
				message = mainMessage,
				extra = extraMessage and { message = extraMessage } or nil
			}
		end
	end
})

-- Circus Deck (spawns eternal Clown Car).
SMODS.Back{
	name = "Circus",
	key = "skpac_circus",
	atlas = "skpac_circus",
	pos = { x = 1, y = 0 },
	config = {},
	loc_txt = {
		name = "Circus",
		text = {
			"Starts with an",
			"Eternal {C:attention,T:j_skpac_circus_clowncar}Clown Car{} Joker!",
		},
	},
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				local find_clowncar = SMODS.find_card('j_skpac_circus_clowncar', true)
				if find_clowncar then
					local clowncar_card = SMODS.add_card(skpac_utils.create_joker({
						set = "Joker",
						key = "j_skpac_circus_clowncar",
						area = G.jokers,
						legendary = false,
						stickers = { 'eternal' },
						eternal = true,
						blueprint_compat = true,
					}))
				end
				return true
			end
		}))
	end
}
----------------------------------------------
------------MOD CODE END----------------------
