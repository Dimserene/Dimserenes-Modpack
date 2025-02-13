local j = {
  loc_txt = {
    name = "Scrap Metal",                                   
        text = {
            "{C:chips,s:1.1}+#1#{} Chips. {C:red}Self destructs{} if any",            
            "card or joker is sold or destroyed"                       
        },
  },
  config = {extra = {chips = 60}},
  rarity = 1,
  cost = 4,
  atlas = 7,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.chips } }
end


function j:calculate(card, context)
        if not context.blueprint then
            if context.destroying_cards then
                if context.destroyed_card and context.destroyed_card ~= card then
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
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_dd_thrown_out'), colour = G.C.SECONDARY_SET.Enhanced})    
                end
            elseif context.remove_playing_cards then
                if context.removed and #context.removed > 0 then
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
			card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_dd_thrown_out'), colour = G.C.SECONDARY_SET.Enhanced})     
                end
            elseif context.selling_card then
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
		card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_dd_thrown_out'), colour = G.C.SECONDARY_SET.Enhanced})     
            end
	end

	if context.joker_main then
            return {
            	message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
        	chip_mod = card.ability.extra.chips, 
        	colour = G.C.CHIPS
            }
        end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_dd_scrap_metal"] = {
    	text = {
      		{ text = "+", colour = G.C.CHIPS },
      		{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "chips", colour = G.C.CHIPS },
    	},
	calc_function = function(card)
            	local chips = card.ability.extra.chips 
		card.joker_display_values.chips = chips
        end
    }
end
	
return j
