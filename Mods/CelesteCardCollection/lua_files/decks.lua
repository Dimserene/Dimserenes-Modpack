local trigger_effect_callbacks = {}
local start_run_after_callbacks = {}
-- region virus deck -----------------------

local eval_cardRef = eval_card
function eval_card(card, context) 
	local ret, post = eval_cardRef(card, context)

    if context.repetition_only and context.cardarea == G.play and G.GAME.selected_back.effect.config.virus then
		if not ret.seals then
			ret.seals = {
				message = localize('k_again_ex'),
				repetitions = 1,
				card = card
			}
		else
			ret.seals.repetitions = ret.seals.repetitions + 1
		end
    end

	return ret, post
end

local debuff_cardRef = Blind.debuff_card

function Blind.debuff_card(self, card, from_blind)
	if G.GAME.selected_back.effect.config.virus and card.ability.played_this_ante then
		card:set_debuff(true)
		return
	end

	debuff_cardRef(self, card, from_blind)
end

function virus_effect(self, args)
    if G.GAME.selected_back.effect.config.virus and args.context == 'final_scoring_step' then
		
        G.E_MANAGER:add_event(Event({
            func = (function()
				for _, v in ipairs(G.playing_cards) do
					if G.GAME.selected_back.effect.config.virus and v.ability.played_this_ante then
						v:set_debuff(true)
					end
				end
                return true
			end)
		}))
	end
end

table.insert(trigger_effect_callbacks, virus_effect)

local virus = SMODS.Back({
    name = "ccc_Virus Deck",
    key = "virus",
	config = {virus = true},
	pos = {x = 0, y = 0},
	loc_txt = {
        name = "Virus Deck",
        text = {
            "Each played card is retriggered",
            "then {C:red}debuffed{}",
	    "until the end of the ante"
        }
    },
    atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})

-- endregion virus deck-----------------------
-- region summit deck -----------------------

-- now displayed in ease_ante, this was old display in case we wanna switch back (end of round)
-- function summit_effect(self, args)
-- 	if self.effect.config.add_slot_each_ante and G.GAME.round_resets.ante > self.effect.config.add_slot_each_ante and args.context == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss then
-- 		G.E_MANAGER:add_event(Event({func = function()
-- 			if G.jokers then
-- 				local width = G.round_eval.T.w - 0.51
-- 				local slotAdded = {n=G.UIT.R, config={align = "cm", minw = width}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = {'+1 Joker Slot!'}, colours = {G.C.ORANGE},shadow = true, float = false, y_offset = 0, scale = 0.66, spacing = 0, font = G.LANGUAGES['en-us'].font, pop_in = 0})}}
-- 				}}
-- 				local spacer = {n=G.UIT.R, config={align = "cm", minw = width}, nodes={
-- 					{n=G.UIT.O, config={object = DynaText({string = {'......................................'}, colours = {G.C.WHITE},shadow = true, float = true, y_offset = -30, scale = 0.45, spacing = 13.5, font = G.LANGUAGES['en-us'].font, pop_in = 0})}}
-- 				}}
-- 				G.round_eval:add_child(spacer,G.round_eval:get_UIE_by_ID('base_round_eval'))
-- 				G.round_eval:add_child(slotAdded,G.round_eval:get_UIE_by_ID('base_round_eval'))
						
-- 			end
-- 			return true end }))
-- 	end
-- end

local ease_anteRef = ease_ante
function ease_ante(mod)
	ease_anteRef(mod)
	G.E_MANAGER:add_event(Event({
		trigger = 'immediate',
		func = function () 
			if G.GAME.selected_back.effect.config.add_slot_each_ante and G.GAME.round_resets.ante % G.GAME.win_ante ~= 0 and G.GAME.round_resets.ante > G.GAME.highest_ante then
						G.jokers.config.card_limit = G.jokers.config.card_limit + 1
						G.GAME.highest_ante = G.GAME.round_resets.ante
						attention_text({
							text = "+1 Joker Slot",
							scale = 0.5, 
							hold = 3.3,
							cover = G.jokers.children.area_uibox,
							cover_colour = G.C.CLEAR,
							offset = {x=-2.75,y=1.25}
						})
			end
			return true
		end
	}))

end


--table.insert(trigger_effect_callbacks, summit_effect)

local summit = SMODS.Back({
    name = "ccc_Summit Deck",
    key = "summit",
	config = {joker_slot = -4, add_slot_each_ante = 1},
	pos = {x = 1, y = 0},
	loc_txt = {
        name = "Summit Deck",
        text = {
	"{C:attention}-4{} Joker slots",
            "{C:attention}+1{} Joker slot each Ante",
			"without a {C:red}final boss{}",
	    	"{s:0.75}(if Ante has not been reached before){}"
        }
    },
    atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})


-- endregion summit deck-----------------------
-- region B-Side deck

local bside = SMODS.Back({
    name = "ccc_B-Side Deck",
    key = "bside",
	config = {everything_is_boss = true},
	pos = {x = 2, y = 0},
	loc_txt = {
        name = "B-Side Deck",
        text = {
            "Every blind is a {C:red}boss blind{}",
			"Start from {C:attention}Ante 0{}"
        }
    },
    atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Bred"
	}
})

local get_type_ref = Blind.get_type
function Blind:get_type()
	local ret = get_type_ref
	if G.GAME.blind_on_deck then 
		return G.GAME.blind_on_deck
	end
	
	return ret
end


local reset_blinds_ref = reset_blinds
function reset_blinds()
	local state = G.GAME.round_resets.blind_states or {Small = 'Select', Big = 'Upcoming', Boss = 'Upcoming'}
	reset_blinds_ref()
	if G.GAME.selected_back.effect.config.everything_is_boss and state.Boss == 'Defeated' then
		
		G.GAME.round_resets.blind_choices.Small = get_new_boss()
		G.GAME.round_resets.blind_choices.Big = get_new_boss()
	end
end

local end_round_ref = end_round
function end_round()
	if G.GAME.selected_back.effect.config.everything_is_boss and G.GAME.blind_on_deck ~= "Boss" then 
		
		-- campfire and ante not increasing and such
		G.GAME.blind.boss = nil

		-- no money red stake
        if G.GAME.modifiers.no_blind_reward and G.GAME.modifiers.no_blind_reward[G.GAME.blind:get_type()] then G.GAME.blind.dollars = 0 end
		-- game actually advancing to big/boss
		if G.GAME.blind:get_type() == "Small" then
			G.GAME.round_resets.blind = G.P_BLINDS.bl_small
		end
		if G.GAME.blind:get_type() == "Big" then
			G.GAME.round_resets.blind = G.P_BLINDS.bl_big
		end
	end
	return end_round_ref()
end

-- madness joker
local calculate_joker_ref = Card.calculate_joker
function Card:calculate_joker(context)
	local ret
	if context.setting_blind and G.GAME.selected_back.effect.config.everything_is_boss and G.GAME.blind_on_deck ~= "Boss" then
		local boss = context.blind.boss
		context.blind.boss = nil
		ret, post = calculate_joker_ref(self, context)
		context.blind.boss = boss 
	else 
		ret, post = calculate_joker_ref(self, context)
	end
	return ret, post
end

function bside_start_run(self)
	if G.GAME.selected_back.effect.config.everything_is_boss then
		G.GAME.round_resets.ante = 0
		G.GAME.round_resets.blind_ante = 0
		G.GAME.round_resets.blind_choices.Small = get_new_boss()
		G.GAME.round_resets.blind_choices.Big = get_new_boss()
	end
end

table.insert(start_run_after_callbacks, bside_start_run)


-- endregion B-Side deck

-- region Heartside Deck

local heartside = SMODS.Back({
    name = "ccc_Heartside Deck",
    key = "heartside",
	config = {all_jokers_modded = true},
	pos = {x = 3, y = 0},
	loc_txt = {
        name = "Heartside Deck",
        text = {
            "Only {C:attention}Modded{} Jokers may appear",
			"{s:0.75}(and maybe {C:legendary,E:1,s:0.75}jimbo{}{s:0.75})"
        }
    },
    atlas= "b_ccc_decks",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})


function heartside_start_run(self)
	if G.GAME.selected_back.effect.config.all_jokers_modded then
		local jokerPool = {}
		for k, v in pairs(G.P_CENTERS) do
			if (not v.mod) or (v.mod and v.mod.name ~= 'Celeste Card Collection') then
				G.GAME.banned_keys[k] = true
			end
		end
		G.GAME.pool_flags.heartside_deck = true
	else 
		G.GAME.pool_flags.heartside_deck = false
	end
end

table.insert(start_run_after_callbacks, heartside_start_run)

-- endregion 
-- region HOOKS

local trigger_effectRef = Back.trigger_effect

function Back.trigger_effect(self, args)
	for _, callback in ipairs(trigger_effect_callbacks) do
		callback(self, args)
	end
	return trigger_effectRef(self, args)
end

local start_run_ref = Game.start_run
function Game:start_run(args)
	local ret = start_run_ref(self, args)
	for _, callback in ipairs(start_run_after_callbacks) do
		callback(self)
	end

	self.GAME.highest_ante = self.GAME.highest_ante or 1
	return ret
end

-- endregion HOOKS

-- region CREDITS

function G.UIDEF.ccc_generate_credits(credits)
	return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and "Art by " or " ", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.art or " ", colours = {G.C.CCC_COLOUR}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and "Code by " or "", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.code or "Vanilla Deck", colours = {credits and G.C.CCC_COLOUR or G.C.DARK_EDITION}, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},
	{n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={object = DynaText({string = credits and "Concept by " or " ", colours = {G.C.WHITE}, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}},
		{n=G.UIT.O, config={object = DynaText({string = credits and credits.concept or " ", colours = {G.C.CCC_COLOUR }, float = true, shadow = true, offset_y = -0.05, silent = true, spacing = 1, scale = 0.25})}}}},}}
end

function ccc_generate_deck_credit_payload()
	local obj = Moveable()

	obj= UIBox{
		definition = G.UIDEF.ccc_generate_credits(G.GAME.viewed_back.effect.center.credit),
		config = {offset = {x=0,y=0}, align = 'cm'}
	}

	local e = {n=G.UIT.R, config={align = "cm"}, nodes={
		{n=G.UIT.O, config={id = G.GAME.viewed_back.name, func = 'RUN_SETUP_check_back_credits', object = obj}}
	}}  
	return e
end
function G.FUNCS.RUN_SETUP_check_back_credits(e)
	if G.GAME.viewed_back.name ~= e.config.id then 
		--removes the UI from the previously selected back and adds the new one
		if e.config.object then e.config.object:remove() end 
		e.config.object = UIBox{
			definition = G.UIDEF.ccc_generate_credits(G.GAME.viewed_back.effect.center.credit),
			config = {offset = {x=0,y=0}, align = 'cm', parent = e}
		}
		e.config.id = G.GAME.viewed_back.name
		e.config.object:recalculate()
	end
end

-- endregion CREDITS
sendDebugMessage("[CCC] Decks loaded")
----------------------------------------------
------------MOD CODE END----------------------
