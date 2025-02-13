local j = {
  loc_txt = {
    name = "Dagger",                                   
        text = {
            "Each {C:attention}Card{} held in hand",
	    "gives {C:mult}+#1#{} Mult"                     
        },
  },
  config = {extra = {mult = 3}},
  rarity = 1,
  cost = 4,
  atlas = 16,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {card.ability.extra.mult} }
end


function j:calculate(self, context)
	if not context.end_of_round and context.individual then
		if context.cardarea == G.hand then
            		if context.other_card.debuff then
                            return {
                                message = localize('k_debuffed'),
                                colour = G.C.RED,
                                card = self,
                            }
                        else
                            return {
                                h_mult = self.ability.extra.mult,
                                card = self
                            }
                        end
            	end
        end                            
end

if JokerDisplay then
	JokerDisplay.Definitions["j_dd_dagger"] = {
		text = {
            		{ text = "+" },
            		{ ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" },
       	 	},
        	text_config = { colour = G.C.MULT },
        	calc_function = function(card)
            		local playing_hand = next(G.play.cards)
            		local mult = 0
            		for _, playing_card in ipairs(G.hand.cards) do
                		if playing_hand or not playing_card.highlighted then
                    			if playing_card.facing and not playing_card.debuff then
                        			mult = mult + card.ability.extra.mult * JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    			end
                		end
            		end
            		card.joker_display_values.mult = mult
        	end
	}
end
return j
