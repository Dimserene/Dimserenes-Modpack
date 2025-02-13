local j = {
  loc_txt = {
    name = "Screwdriver",                                   
        text = {
            "Retrigger each {C:attention}6{} that are",
	    "played or held in hand"                      
        },
  },
  config = {},
  rarity = 2,
  cost = 6,
  atlas = 8,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {} }
end


function j:calculate(self, context)
	if context.repetition then
		if context.cardarea == G.play then
            		if context.other_card:get_id() == 6 then
                		return {
                    			message = localize('k_again_ex'),
                    			repetitions = 1,
                    			card = self
                		}		
            		end
		end
        end
        if context.repetition then
		if context.cardarea == G.hand then
            		if context.other_card:get_id() == 6 and (next(context.card_effects[1]) or #context.card_effects > 1) and not context.other_card.debuff then
                		return {
                    			message = localize('k_again_ex'),
                    			repetitions = 1,
                    			card = self
                		}
			end
            	end
        end                            
end

if JokerDisplay then
	JokerDisplay.Definitions["j_dd_screwdriver"] = {
		retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
			return playing_card:get_id()
					and playing_card:get_id() == 6
					and 1 * JokerDisplay.calculate_joker_triggers(joker_card)
				or 0
		end,
	}
end
return j
