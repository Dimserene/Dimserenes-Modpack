local j = {
  loc_txt = {
    name = "Shovel",
        text = {	
            "{C:red}+#1#{} discard if played",
            "hand contains a {C:attention}2{}"                  
        },
  },
  config = { extra = {discards = 1} },
  rarity = 2,
  cost = 7,
  atlas = 9,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {card.ability.extra.discards} }
end


function j:calculate(self, context)
	if context.cardarea == G.jokers and context.before and not context.blueprint then
            	local two = 0
            	for i = 1, #context.full_hand do
                	if context.full_hand[i]:get_id() == 2 then
                    		two = two + 1
                	end
            	end
            	if two >= 1 then
			ease_discard(self.ability.extra.discards)
                	return {
                    		message = localize('k_dd_contains'),
                           	card = self,
                            	colour = G.C.MONEY
                	}
            	end
	end                              
end

if JokerDisplay then
    JokerDisplay.Definitions["j_dd_shovel"] = {
        text = {
            { text = '+', colour = lighten(G.C.RED, 0.1)},
            { ref_table = 'card.joker_display_values', ref_value = 'disc', colour = lighten(G.C.RED, 0.1)},
        },
        reminder_text = {
    		{ text = "(Discards)" },
        },
        text_config = {colour = G.C.MULT},
        calc_function = function(card)
        	local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
    	card.joker_display_values.disc = 0
    		for k, v in pairs(hand) do
    			if v:get_id() == 2 then
    				card.joker_display_values.disc = card.ability.extra.discards
    				break
    			end
    		end
        	end
    }
end
return j
