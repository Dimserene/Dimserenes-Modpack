local j = {
  loc_txt = {
    name = "Dust Cloud",                                
    text = {
            	 "Each {C:attention}face{} card can't be",            
            	 "{C:red}debuffed{} or {C:red}faced down{}"                       
     },
  },
  config = {},
  rarity = 2,
  cost = 5,
  atlas = 2,

  blueprint_compat = true,
}

if JokerDisplay then
    JokerDisplay.Definitions['j_dd_dust_cloud'] = {
        reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = G.C.ORANGE },
            { text = ")" },
        },
        calc_function = function(card)    
            card.joker_display_values.localized_text = localize("k_face_cards")
        end
     }
end
	
return j
