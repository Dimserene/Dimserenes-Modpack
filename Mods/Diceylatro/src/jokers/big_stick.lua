local j = {
  loc_txt = {
    name = "Big Stick",
    text = {
            	"Each {C:attention}8{} gain {C:chips}+#1#{} Chips when scored.",
		"Increases by {C:chips}+#2#{} Chips for scored {C:attention}8{}",
		"{C:inactive}(Resets after each hand played)"                       
    },
  },
  config = {extra = {chips = 16, chips_mod = 16}},
  rarity = 2,
  cost = 6,
  atlas = 1,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
  return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.chips_base } }
end

function j:calculate(card, context)
  	if context.individual and context.cardarea == G.play then
			if context.other_card:get_id() == 8 then
        			local chips_add = card.ability.extra.chips
        			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
        			return {
          				chips = chips_add,
          				card = card
        			}
      			end
	end
	if context.after and not context.blueprint then
      		card.ability.extra.chips = card.ability.extra.chips_mod
	end
end

if JokerDisplay then
    JokerDisplay.Definitions['j_dd_big_stick'] = {
        text = {
                { text = "+" },
                { ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "chips" }
            },
            text_config = { colour = G.C.CHIPS },
            calc_function = function(card)
                local chips = 0
    	    local chipsmod = card.ability.extra.chips_mod
                local text, _, scoring_hand = JokerDisplay.evaluate_hand()
                if text ~= 'Unknown' and scoring_hand then
                    for _, scoring_card in pairs(scoring_hand) do
                        if scoring_card:get_id() and scoring_card:get_id() == 8 then
    			local retriggers = JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
    				for i = 1, retriggers do
                            		chips = chips + chipsmod
    					chipsmod = chipsmod + card.ability.extra.chips_mod
    				end
                        end
                    end
                end
                card.joker_display_values.chips = chips
            end
    }
end
	
return j
