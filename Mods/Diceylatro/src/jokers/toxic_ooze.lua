local j = {
  loc_txt = {
   name = "Toxic Ooze",                               
        text = {
            "{C:mult}+#2#{} Mult when each played",             		
            "{C:attention}3{} is scored, halves when",         
            "Boss Blind is defeated",
	    "{C:inactive}(Curently {C:mult}+#1# {C:inactive}Mult)"                        
        },
  },
  config = { extra = {mult = 6, mult_mod = 3} },
  rarity = 2,
  cost = 7,
  atlas = 12,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod} }
end


function j:calculate(self, context)                 
            if context.individual and context.cardarea == G.play then
                if context.other_card:get_id() == 3 and not context.blueprint then
                        self.ability.extra.mult = self.ability.extra.mult + self.ability.extra.mult_mod
                        return {
                            extra = {focus = self, message = localize('k_upgrade_ex')},
                            card = self,
                            colour = G.C.CHIPS
                        }
                end
	    end
	    if context.joker_main then
                return {
                    mult_mod = self.ability.extra.mult,
                    card = self,
                    message = localize { type = 'variable', key = 'a_mult', vars = { self.ability.extra.mult } }
                }		
            end
	    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint and G.GAME.blind.boss then
			self.ability.extra.mult = math.floor(self.ability.extra.mult / 2)
                        return {
                            message = localize('k_dd_halved'),
                            card = self,
                            colour = G.C.PURPLE
                        }
	    end             
end


if JokerDisplay then
    JokerDisplay.Definitions["j_dd_toxic_ooze"] = {
        text = {
            { text = '+', colour = lighten(G.C.MULT, 0.1)},
            { ref_table = 'card.joker_display_values', ref_value = 'mult', colour = lighten(G.C.MULT, 0.1)},
        },
	reminder_text = {
    	{ text = '(+'},
            { ref_table = 'card.joker_display_values', ref_value = 'mult_add'},
    	{ text = ' Mult)'},
        },
        calc_function = function(card)
		local mult_add = 0
            	local text, _, scoring_hand = JokerDisplay.evaluate_hand()
            	if text ~= 'Unknown' then
                	for _, scoring_card in pairs(scoring_hand) do
                    		if scoring_card:get_id() and scoring_card:get_id() == 3 then
                        		mult_add = mult_add +
                            		card.ability.extra.mult_mod *
                            		JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                    		end
                	end
            	end
		card.joker_display_values.mult = card.ability.extra.mult
		card.joker_display_values.mult_add = mult_add
        end
    }
end

return j
