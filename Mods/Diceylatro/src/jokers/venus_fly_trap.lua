local j = {
  loc_txt = {
   name = "Venus Fly Trap",                               
        text = {
            	"Each scored {C:attention}7{} has a {C:green}#1# in #2#{}",
		"chance to draw an extra card"             
        },
  },
  config = {extra = {draw = 0, odds = 2}},
  rarity = 2,
  cost = 7,
  atlas = 13,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { G.GAME.probabilities.normal, card.ability.extra.odds} }
end


function j:calculate(self, context)
		if context.individual and context.cardarea == G.play then
            		if context.other_card:get_id() == 7 and not context.other_card.debuff and pseudorandom('drawj') < G.GAME.probabilities.normal/self.ability.extra.odds then
				self.ability.extra.draw = self.ability.extra.draw + 1
				return {
                    			extra = {focus = self, message = localize('k_dd_extra_draw'), colour = G.C.GREEN},
                        		card = self
                		}
			end
			
    		end
		if context.end_of_round and self.ability.extra.draw > 0 then
			self.ability.extra.draw = 0
		end            
end


if JokerDisplay then
    JokerDisplay.Definitions["j_dd_venus_fly_trap"] = {
        reminder_text = {
    	{ text = '(+'},
            { ref_table = 'card.joker_display_values', ref_value = 'extra'},
    	{ text = ' Draw)'},
        },
        extra = {
                {
                    { text = "(" },
                    { ref_table = "card.joker_display_values", ref_value = "odds" },
                    { text = ")" },
                }
            },
            extra_config = { colour = G.C.GREEN, scale = 0.3 },
        calc_function = function(card)
    	card.joker_display_values.extra = card.ability.extra.draw
    	card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end
    }
end

return j
