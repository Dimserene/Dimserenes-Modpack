local j = {
  loc_txt = {
    name = "Snapdragon",                                   
        text = {
            	"Each {C:attention}5{} held in hand gain {C:money}$#1#{}, then",
		"destroy it for each at end of round"             
        },
  },
  config = {extra = {dollars = 5}},
  rarity = 2,
  cost = 5,
  atlas = 10,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {card.ability.extra.dollars} }
end


function j:calculate(self, context)
		if context.cardarea == G.hand and context.end_of_round and context.individual then
            		if context.other_card:get_id() == 5 and not context.other_card.debuff and not context.repetition then
				ease_dollars(self.ability.extra.dollars)
				local card_to_destroy = context.other_card
                    		card_to_destroy.getting_sliced = true
                    		card_to_destroy:start_dissolve() 
				return {
                    			extra = {focus = self, message = localize('$')..self.ability.extra.dollars, colour = G.C.MONEY},
                        		card = self
                		}
			end
			
    		end                         
end

if JokerDisplay then
    JokerDisplay.Definitions["j_dd_snapdragon"] = {
        text = {
            	{ ref_table = 'card.joker_display_values', ref_value = 'count', G.C.WHITE},
		{ text = 'x', G.C.WHITE},
    		{ text = '$', colour = lighten(G.C.MONEY, 0.1)},
            	{ ref_table = 'card.joker_display_values', ref_value = 'dollars', colour = lighten(G.C.MONEY, 0.1)},
        },
        calc_function = function(card)
		local playing_hand = next(G.play.cards)
            	local count = 0
		local dollars = card.ability.extra.dollars
            	for _, playing_card in ipairs(G.hand.cards) do
                	if playing_hand or not playing_card.highlighted then
                    		if not (playing_card.facing == 'back') and not playing_card.debuff and playing_card:get_id() and playing_card:get_id() == 5 then
                        		count = count + JokerDisplay.calculate_card_triggers(playing_card, nil, true)
                    		end
                	end
            	end
		card.joker_display_values.count = count
		card.joker_display_values.dollars = dollars
        end
    }
end
return j
