local j = {
  loc_txt = {
    name = "Hammer",                                
    text = {
            	"For each scored {C:attention}10{}",
		"gain {X:attention,C:white}X#1#{} Blind amount"                     
     },
  },
  config = {extra = {reduce_blind = 0.9, size = 1}},
  rarity = 2,
  cost = 5,
  atlas = 4,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
  return { vars = { card.ability.extra.reduce_blind } }
end

function j:calculate(self, context)
	if context.individual and context.cardarea == G.play then
            	if context.other_card:get_id() == 10 and not context.other_card.debuff then
			G.GAME.blind.chips = G.GAME.blind.chips * self.ability.extra.reduce_blind
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        		G.HUD_blind:recalculate(true)
      		end
    	end	
end

if JokerDisplay then
    JokerDisplay.Definitions['j_dd_hammer'] = {
        text = {
                { text = "X", colour = lighten(G.C.FILTER, 0.1)},
                { ref_table = "card.joker_display_values", ref_value = "reduce_blind", colour = lighten(G.C.FILTER, 0.1)}
            },
            calc_function = function(card)
                local reduce_blind = 1
          	local text, _, scoring_hand = JokerDisplay.evaluate_hand()
          	if text ~= 'Unknown' then
            		for _, scoring_card in pairs(scoring_hand) do
              			if scoring_card:get_id() and scoring_card:get_id() == 10 then
                				reduce_blind = reduce_blind * card.ability.extra.reduce_blind ^
                  				JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
    				end
    			end
		end
		card.joker_display_values.reduce_blind = reduce_blind
            end
    	}
end
	
return j
