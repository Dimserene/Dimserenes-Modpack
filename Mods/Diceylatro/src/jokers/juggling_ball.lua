local j = {
  loc_txt = {
    name = "Juggling Ball",                                
        text = {
            "When {C:attention}Boss Blind{} is defeated,",
	    "give {C:money}$#1#{} and {C:attention,T:tag_juggle}Juggle Tag"                       
        },
  },
  config = {extra = {dollars = 2}},
  rarity = 1,
  cost = 5,
  atlas = 15,
  loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = { set = "Tag", key = "tag_juggle", specific_vars = {3}}
		return {
			vars = {
				center.ability.extra.dollars,
			},
		}
  end,

  blueprint_compat = true,
}



function j:calculate(self, context)
		if context.end_of_round and G.GAME.blind.boss and not context.individual and not context.repetition then
			G.E_MANAGER:add_event(Event({
                    		func = (function()
                        		add_tag(Tag('tag_juggle'))
                        		play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        		play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        		return true
                    		end)
                	}))
                        return {
                            message = localize('$')..self.ability.extra.dollars,
                            dollars = self.ability.extra.dollars,
                            colour = G.C.MONEY
                        }
		end                
end


if JokerDisplay then
    JokerDisplay.Definitions["j_dd_whip"] = {
        reminder_text = {
    	{ text = '+', colour = lighten(G.C.FILTER, 0.1)},
            { ref_table = 'card.joker_display_values', ref_value = 'extra', colour = lighten(G.C.FILTER, 0.1)},
    	{ text = ' Enhanced 4', colour = lighten(G.C.PURPLE, 0.1)},
        },
        calc_function = function(card)
    	card.joker_display_values.extra = card.ability.extra
        end
    }
end

return j
