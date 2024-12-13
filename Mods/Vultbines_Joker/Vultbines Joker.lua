--- STEAMODDED HEADER
--- MOD_NAME: Vultbines Joker
--- MOD_ID: Vultbines_Joker
--- MOD_AUTHOR: [itayfeder, amstd, Gappie]
--- MOD_DESCRIPTION: Adds the ability to fuse jokers into special new jokers!--requires FusionJokers to be loaded
--- BADGE_COLOUR: 3527C6
--- PRIORITY: -10000
----------------------------------------------
------------MOD CODE -------------------------

G.localization.misc.v_dictionary.sweet_theatre_combo = {"+#1#mult +#2#chips"}
G.localization.misc.v_dictionary.melancholy_phantom = {"X#1#mult +#2#chips"}

local Vultbines_Joker = {}
Vultbines_Joker.fusions = {
	{ jokers = {
		{ name = "j_popcorn", carry_stat = nil, extra_stat = false },
		{ name = "j_ice_cream", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_sweet_theatre_combo", cost = 5 },
	{ jokers = {
		{ name = "j_hallucination", carry_stat = nil, extra_stat = false },
		{ name = "j_red_card", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_bribery_clown", cost = 5 },
	{ jokers = {
		{ name = "j_marble", carry_stat = nil, extra_stat = false },
		{ name = "j_stone", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_moorstone", cost = 5 },
	{ jokers = {
		{ name = "j_sock_and_buskin", carry_stat = nil, extra_stat = false },
		{ name = "j_mime", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_oscar_best_actor", cost = 5 },
	{ jokers = {
		{ name = "j_troubadour", carry_stat = nil, extra_stat = false },
		{ name = "j_merry_andy", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_optimist", cost = 5 },
	{ jokers = {
		{ name = "j_bull", carry_stat = nil, extra_stat = false },
		{ name = "j_bootstraps", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_fight_a_bull", cost = 5 },
	{ jokers = {
		{ name = "j_blue_joker", carry_stat = nil, extra_stat = false },
		{ name = "j_hologram", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_melancholy_phantom", cost = 5 },
	{ jokers = {
		{ name = "j_space", carry_stat = nil, extra_stat = false },
		{ name = "j_burnt", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_solar_flare_joker", cost = 5 },
	{ jokers = {
		{ name = "j_gros_michel", carry_stat = nil, extra_stat = false },
		{ name = "j_cavendish", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_blue_java", cost = 5 },
	{ jokers = {
		{ name = "j_ceremonial", carry_stat = nil, extra_stat = false },
		{ name = "j_madness", carry_stat = nil, extra_stat = false }
	}, result_joker = "j_serial_killer", cost = 5 },
}

local function has_joker(val)
	for k, v in pairs(G.jokers.cards) do
		if v.ability.set == 'Joker' and v.config.center_key == val then 
			return k
		end
	end
	return -1
end

local add_to_deckref = Card.add_to_deck
function Card:add_to_deck(from_debuff)
  	if not self.added_to_deck then
		if self.ability.name == 'Optimist' then
			G.hand:change_size(self.ability.extra.h_size)
			
			G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.ability.extra.h_plays
        	ease_hands_played(self.ability.extra.h_plays)
            	
			G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.ability.extra.d_size
        	ease_discard(self.ability.extra.d_size)
		end
  	end
  	add_to_deckref(self, from_debuff)
end

local remove_from_deckref = Card.remove_from_deck
function Card:remove_from_deck(from_debuff)
	if self.added_to_deck then
		if self.ability.name == 'Optimist' then
			G.hand:change_size(-self.ability.extra.h_size)
			
			G.GAME.round_resets.hands = G.GAME.round_resets.hands - self.ability.extra.h_plays
        	ease_hands_played(-self.ability.extra.h_plays)
        	
			G.GAME.round_resets.discards = G.GAME.round_resets.discards - self.ability.extra.d_size
        	ease_discard(-self.ability.extra.d_size)
		end
	end
	remove_from_deckref(self, from_debuff)
end

function SMODS.INIT.Vultbines_Joker()
    --requires FusionJokers to be loaded
    if SMODS.INIT.FusionJokers then
    
    	local mod_id = "Vultbines_Joker"
    	local mod_obj = SMODS.findModByID(mod_id)
    	
        for _, fusion in ipairs(Vultbines_Joker.fusions) do
            table.insert(FusionJokers.fusions, fusion)
        end
    
    	--j_sweet_theatre_combo
    	local sweet_theatre_combo_def = {
    		name = "Sweet Theatre Combo",
    		text = {
                "{C:mult}+#1#{} Mult",
    			"{C:chips}+#2#{} Chips",
    			"Destroyed after {C:attention}#3#{} rounds",
    			"{C:inactive}(#4# + #5#)"
    		}
    	}
    	
    	local sweet_theatre_combo = SMODS.Joker:new("Sweet Theatre Combo", "sweet_theatre_combo", {extra = {mult = 30, chips = 150,count = 5, joker1 = "j_popcorn", joker2 = "j_ice_cream"
    	}}, { x = 0, y = 0 }, sweet_theatre_combo_def, 5, 12, true, true, true, false)
    	SMODS.Sprite:new("j_sweet_theatre_combo", mod_obj.path, "j_sweet_theatre_combo.png", 71, 95, "asset_atli"):register();
    	sweet_theatre_combo:register()
    
    	function SMODS.Jokers.j_sweet_theatre_combo.loc_def(card)
    		return {card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.count, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_sweet_theatre_combo.calculate(card, context)
    		if context.end_of_round and not (context.individual or context.repetition or context.blueprint) then
    		    card.ability.extra.count=card.ability.extra.count-1
                if card.ability.extra.count<=0 then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    })) 
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                end      
            end
            
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='sweet_theatre_combo',vars={card.ability.extra.mult,card.ability.extra.chips}},
    				mult_mod = card.ability.extra.mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    	end
    	
    	--j_bribery_clown
    	local bribery_clown_def = {
    		name = "Bribery Joker",
    		text = {
                "Gains {C:red}+#2#{} Mult when any",
                "{C:attention}Booster Pack{} is skipped,",
                "and create a {C:tarot}Tarot{} card",
                "{C:inactive}(Must have room)",
                "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)",
    			"{C:inactive}(#3# + #4#)"
    		}
    	}
    	
    	local bribery_clown = SMODS.Joker:new("Bribery Clown", "bribery_clown", {extra = {mult = 8, mult_add = 4, joker1 = "j_hallucination", joker2 = "j_red_card"
    	}}, { x = 0, y = 0 }, bribery_clown_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_bribery_clown", mod_obj.path, "j_bribery_clown.png", 71, 95, "asset_atli"):register();
    	bribery_clown:register()
    
    	function SMODS.Jokers.j_bribery_clown.loc_def(card)
    		return {card.ability.extra.mult, card.ability.extra.mult_add, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_bribery_clown.calculate(card, context)
    	    if context.skipping_booster and not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        card_eval_status_text(card, 'extra', nil, nil, nil, {
                            message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult_add}},
                            colour = G.C.RED,}) 
                        return true
                    end}))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local tarot = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'hal')
                                tarot:add_to_deck()
                                G.consumeables:emplace(tarot)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.PURPLE})
                end
            end
    		
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
    				mult_mod = card.ability.extra.mult,
    			}
    		end
    	end
    	
    	--j_moorstone
        local moorstone_def = {
    		name = "Moorstone",
    		text = {
                "This Joker gains {C:chips}+#1#{} Chips",
                "for each {C:attention}Stone Card",
                "in your full deck",
                "Adds one {C:attention}Stone{} card",
                "to deck when",
                "played {C:attention}#3#{} {C:attention}Stone{} card",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
    			"{C:inactive}(#4# + #5#)"
    		}
    	}
    
    	local moorstone = SMODS.Joker:new("Moorstone", "moorstone", {extra = {chips_add = 40, chips = 0, count = 2, joker1 = "j_marble", joker2 = "j_stone"
    	}}, { x = 0, y = 0 }, moorstone_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_moorstone", mod_obj.path, "j_moorstone.png", 71, 95, "asset_atli"):register();
    	moorstone:register()
    
    	function SMODS.Jokers.j_moorstone.loc_def(card)
    	    card.ability.stone_tally = 0
    	    if G.playing_cards then
                for k, v in pairs(G.playing_cards) do
                    if v.config.center == G.P_CENTERS.m_stone then card.ability.stone_tally = card.ability.stone_tally+1 end
                end
            end
    	    card.ability.extra.chips = card.ability.extra.chips_add*(card.ability.stone_tally or 0)
    		return {card.ability.extra.chips_add, card.ability.extra.chips, card.ability.extra.count, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_moorstone.calculate(card, context)
    	    if context.individual and context.cardarea == G.play and
    		context.other_card.ability.effect == 'Stone Card' and not (context.blueprint_card or card).getting_sliced then
    		    card.ability.extra.count = card.ability.extra.count - 1
    		    if card.ability.extra.count <= 0 then
    		        card.ability.extra.count = 2
    		        G.E_MANAGER:add_event(Event({
                        func = function() 
                            local front = pseudorandom_element(G.P_CARDS, pseudoseed('marb_fr'))
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_stone, {playing_card = G.playing_card})
                            card:start_materialize({G.C.SECONDARY_SET.Enhanced})
                            card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, card)
                            G.hand:emplace(card)
    
                            return true
                        end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_stone'), colour = G.C.SECONDARY_SET.Enhanced})
                   
                    playing_card_joker_effects({true})
    		    end
    		end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
    			card.ability.stone_tally = 0
                for k, v in pairs(G.playing_cards) do
                    if v.config.center == G.P_CENTERS.m_stone then card.ability.stone_tally = card.ability.stone_tally+1 end
                end
                card.ability.extra.chips = card.ability.extra.chips_add*(card.ability.stone_tally or 0)
                if card.ability.stone_tally > 0 then
                    return {
                        message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                        chip_mod = card.ability.extra.chips, 
                        colour = G.C.CHIPS
                    }
                end
    		end
    	end
    	
    	--j_oscar_best_actor
    	local oscar_best_actor_def = {
    		name = "Oscar Best Actor",
    		text = {
                "Retrigger #1# times all",
                "card {C:attention}held in",
                "{C:attention}hand{} abilities",
                "and all played {C:attention}face{} cards",
    			"{C:inactive}(#2# + #3#)"
    		}
    	}
    
    	local oscar_best_actor = SMODS.Joker:new("Oscar Best Actor", "oscar_best_actor", {extra = {count = 1,
    	    joker1 = "j_sock_and_buskin", joker2 = "j_mime"
    	}}, { x = 0, y = 0 }, oscar_best_actor_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_oscar_best_actor", mod_obj.path, "j_oscar_best_actor.png", 71, 95, "asset_atli"):register();
    	oscar_best_actor:register()
    
    	function SMODS.Jokers.j_oscar_best_actor.loc_def(card)
    		return {card.ability.extra.count,
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_oscar_best_actor.calculate(card, context)
    		if context.repetition then
                if context.cardarea == G.play then
                    if true or (context.other_card:is_face()) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = card.ability.extra.count,
                            card = card
                        }
                    end
                end
                if context.cardarea == G.hand then
                    if (next(context.card_effects[1]) or #context.card_effects > 1) then
                        return {
                            message = localize('k_again_ex'),
                            repetitions = card.ability.extra.count,
                            card = card
                        }
                    end
                end
            end
    	end
    	
    	--j_optimist
    	local optimist_def = {
    		name = "Optimist",
    		text = {
                "{C:red}+#1#{} hand size",
                "{C:red}#2#{} hands per round",
                "{C:red}+#3#{} discards",
    			"{C:inactive}(#4# + #5#)"
    		}
    	}
    
    	local optimist = SMODS.Joker:new("Optimist", "optimist", {extra = {
    		h_size = 2, h_plays = -1, d_size = 2, joker1 = "j_troubadour", joker2 = "j_merry_andy"
    	}}, { x = 0, y = 0 }, optimist_def, 5, 12, true, true, false, true)
    	SMODS.Sprite:new("j_optimist", mod_obj.path, "j_optimist.png", 71, 95, "asset_atli"):register();
    	optimist:register()
    
    	function SMODS.Jokers.j_optimist.loc_def(card)
    		return {card.ability.extra.h_size, card.ability.extra.h_plays, card.ability.extra.d_size, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    	
    	--j_fight_a_bull
    	local fight_a_bull_def = {
    		name = "Fight A Bull",
    		text = {
                "{C:mult}+2{} Mult and {C:chips}+8{} Chips",
                "for every {C:money}$#1#{} you have",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Mult)",
                "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)",
                "{C:inactive}(#4# + #5#)"
    		}
    	}
    	
    	local fight_a_bull = SMODS.Joker:new("Fight A Bull", "fight_a_bull", {extra = {dollars = 3, mult = 0, chips = 0, joker1 = "j_bull", joker2 = "j_bootstraps"
    	}}, { x = 0, y = 0 }, fight_a_bull_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_fight_a_bull", mod_obj.path, "j_fight_a_bull.png", 71, 95, "asset_atli"):register();
    	fight_a_bull:register()
    
    	function SMODS.Jokers.j_fight_a_bull.loc_def(card)
    	    card.ability.extra.mult = 2*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
            card.ability.extra.chips = 8*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
    		return {card.ability.extra.dollars, card.ability.extra.mult, card.ability.extra.chips, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_fight_a_bull.calculate(card, context)
            if context.cardarea == G.jokers and not context.after and not context.before then
                card.ability.extra.mult = 2*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
                card.ability.extra.chips = 8*math.max(0,math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars))
                
                return {
    				message = localize{type='variable',key='sweet_theatre_combo',vars={card.ability.extra.mult,card.ability.extra.chips}},
    				mult_mod = card.ability.extra.mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    	end
    	
    	--j_melancholy_phantom
    	local melancholy_phantom_def = {
    		name = "Melancholy Phantom",
    		text = {
                "Gains {X:mult,C:white} X0.1 {} Mult and {C:chips}+8{} Chips",
                "per {C:attention}playing card{} added",
                "to your deck",
                "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)",
                "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)",
                "{C:inactive}(#3# + #4#)"
    		}
    	}
    	
    	local melancholy_phantom = SMODS.Joker:new("Melancholy Phantom", "melancholy_phantom", {extra = {x_mult = 2, chips = 50, joker1 = "j_blue_joker", joker2 = "j_hologram"
    	}}, { x = 0, y = 0 }, melancholy_phantom_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_melancholy_phantom", mod_obj.path, "j_melancholy_phantom.png", 71, 95, "asset_atli"):register();
    	melancholy_phantom:register()
    
    	function SMODS.Jokers.j_melancholy_phantom.loc_def(card)
    		return {card.ability.extra.x_mult, card.ability.extra.chips, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_melancholy_phantom.calculate(card, context)
            if context.cardarea == G.jokers and not context.after and not context.before then
                return {
    				message = localize{type='variable',key='melancholy_phantom',vars={card.ability.extra.x_mult,card.ability.extra.chips}},
    				Xmult_mod = card.ability.extra.x_mult,
    				chip_mod = card.ability.extra.chips,
    			}
    		end
    		
    		if context.playing_card_added and not card.getting_sliced then
        		if (not context.blueprint) and context.cards and context.cards[1] then
                    card.ability.extra.x_mult = card.ability.extra.x_mult + #context.cards*0.1
                    card.ability.extra.chips = card.ability.extra.chips + #context.cards*8
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'melancholy_phantom', vars = {card.ability.extra.x_mult,card.ability.extra.chips}}})
                end
            end
    	end
    	
    	--j_solar_flare_joker
    	local solar_flare_joker_def = {
    		name = "Solar Flare Joker",
    		text = {
                "{C:green}#1# in #2#{} chance to",
                "upgrade level of",
                "played {C:attention}poker hand{}",
                "and {C:attention}discarded poker hand",
                "{C:inactive}(#3# + #4#)"
    		}
    	}
    	
    	local solar_flare_joker = SMODS.Joker:new("Solar Flare Joker", "solar_flare_joker", {extra = {odds = 2, joker1 = "j_space", joker2 = "j_burnt"
    	}}, { x = 0, y = 0 }, solar_flare_joker_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_solar_flare_joker", mod_obj.path, "j_solar_flare_joker.png", 71, 95, "asset_atli"):register();
    	solar_flare_joker:register()
    
    	function SMODS.Jokers.j_solar_flare_joker.loc_def(card)
    		return {''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_solar_flare_joker.calculate(card, context)
            if context.pre_discard then
                if pseudorandom('solar_radiation') < G.GAME.probabilities.normal/card.ability.extra.odds and not context.hook then
                local text,disp_text = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
                    level_up_hand(context.blueprint_card or card, text, nil, 1)
                    update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                end
            end
    		
    		if context.cardarea == G.jokers  and context.before then
                if pseudorandom('solar_radiation') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    return {
                        card = card,
                        level_up = true,
                        message = localize('k_level_up_ex')
                    }
                end
            end
    	end
    	
    	--j_blue_java
    	local blue_java_def = {
    		name = "Blue Java",
    		text = {
    			"{X:mult,C:white}X#1#{} Mult",
                "At the end of the round,",
                "{C:green}#2# in #3#{} chance to",
                "decrease by {X:mult,C:white}X1{} Mult",
                "{C:inactive}(#4# + #5#)"
    		}
    	}
    	
    	local blue_java = SMODS.Joker:new("Blue Java", "blue_java", {extra = {Xmult_mod = 0.5, Xmult = 7, odds = 6, joker1 = "j_ice_cream", joker2 = "j_cavendish"
    	}}, { x = 0, y = 0 }, blue_java_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_blue_java", mod_obj.path, "j_blue_java.png", 71, 95, "asset_atli"):register();
    	blue_java:register()
    
    	function SMODS.Jokers.j_blue_java.loc_def(card)
    		return {card.ability.extra.Xmult, ''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_blue_java.calculate(card, context)
            if context.after and not context.blueprint and not context.repetition and not context.individual then
                if pseudorandom('hybrid_banana') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    card.ability.extra.Xmult = card.ability.extra.Xmult - card.ability.extra.Xmult_mod
                    if card.ability.extra.Xmult < 1 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                    func = function()
                                            G.jokers:remove_card(card)
                                            card:remove()
                                            card = nil
                                        return true; end})) 
                                return true
                            end
                        })) 
                        return {
                            message = localize('k_eaten_ex'),
                            colour = G.C.FILTER
                        }
                    end
                    return {
                        message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                        Xmult_mod = card.ability.extra.Xmult,
                    }
                end
            end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult,
                }
    		end
    	end
    	
    	--j_serial_killer
    	local serial_killer_def = {
    		name = "Serial Killer",
    		text = {
                "When {C:attention}Blind{} is selected,",
                "destroy Joker to the right",
                "and permanently add {C:attention}25%",
                "its sell value to this {C:red}Mult",
                "{C:inactive}(Currently {X:mult,C:white} X#1# {} Mult)",
                "{C:inactive}(#2# + #3#)"
    		}
    	}
    	
    	local serial_killer = SMODS.Joker:new("Serial Killer", "serial_killer", {extra = {Xmult_per = 0.25, Xmult = 2, joker1 = "j_ceremonial", joker2 = "j_madness"
    	}}, { x = 0, y = 0 }, serial_killer_def, 5, 12, true, true, true, true)
    	SMODS.Sprite:new("j_serial_killer", mod_obj.path, "j_serial_killer.png", 71, 95, "asset_atli"):register();
    	serial_killer:register()
    
    	function SMODS.Jokers.j_serial_killer.loc_def(card)
    		return {card.ability.extra.Xmult, 
    		localize{type = 'name_text', key = card.ability.extra.joker1, set = 'Joker'}, 
    		localize{type = 'name_text', key = card.ability.extra.joker2, set = 'Joker'}}
    	end
    
    	function SMODS.Jokers.j_serial_killer.calculate(card, context)
            if context.setting_blind and not card.getting_sliced and not context.blueprint then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then my_pos = i; break end
                end
                if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
                    local sliced_card = G.jokers.cards[my_pos+1]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.Xmult = card.ability.extra.Xmult + sliced_card.sell_cost*card.ability.extra.Xmult_per
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                        play_sound('slice1', 0.96+math.random()*0.08)
                    return true end }))
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.Xmult+card.ability.extra.Xmult_per*sliced_card.sell_cost}}, colour = G.C.RED, no_juice = true})
                end
            end
    		
    		if context.cardarea == G.jokers and not context.after and not context.before then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult,
                }
    		end
    	end
	end
	

	----------------------------------------------
	----------------------------------------------

end

----------------------------------------------
------------MOD CODE END----------------------