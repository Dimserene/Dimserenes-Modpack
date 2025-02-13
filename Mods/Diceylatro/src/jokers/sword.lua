local j = {
  loc_txt = {
    name = "Sword",                                   
        text = {
            "{C:chips,s:1.1}+Between #1# to #2#{} Chips."                      
        },
  },
  config = {extra = {chips_min = 10, chips_max = 60}},
  rarity = 1,
  cost = 3,
  atlas = 17,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.chips_min, card.ability.extra.chips_max} }
end


function j:calculate(card, context)
	if context.joker_main then
	    local chip_rand = math.random(card.ability.extra.chips_min, card.ability.extra.chips_max)
            return {
            	message = localize{type='variable',key='a_chips',vars={chip_rand}},
        	chip_mod = chip_rand, 
        	colour = G.C.CHIPS
            }
        end
end

if JokerDisplay then
    JokerDisplay.Definitions["j_dd_sword"] = {
    	text = {
      		{ text = "+", colour = G.C.CHIPS },
      		{ ref_table = "card.joker_display_values", ref_value = "chips", retrigger_type = "chips", colour = G.C.CHIPS },
    	},
	calc_function = function(card)
		card.joker_display_values.chips = math.random(card.ability.extra.chips_min, card.ability.extra.chips_max) or 1
        end
    }
end
	
return j
