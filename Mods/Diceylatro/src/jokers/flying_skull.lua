local j = {
  loc_txt = {
    name = "Flying Skull",                                   
    text = {
            	"Create a {C:spectral}Spectral{} card for",
		"every {C:attention}#1#{C:inactive} [#2#]{} discarded 9",
                "{C:inactive}(Must have room)",
     },
  },
  config = {extra = {skull_discards = 9, discards = 9}},
  rarity = 2,
  cost = 6,
  atlas = 3,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
  return { vars = { card.ability.extra.skull_discards, card.ability.extra.discards } }
end

function j:calculate(self, context)
		if context.discard and context.other_card:get_id() == 9 then
			if self.ability.extra.skull_discards <= 1 then
                    		self.ability.extra.skull_discards = self.ability.extra.discards
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
					G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                	G.E_MANAGER:add_event(Event({
                                    		trigger = 'before',
                                    		delay = 0.0,
                                    		func = (function()
                                            		local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sea')
                                            		card:add_to_deck()
                                            		G.consumeables:emplace(card)
                                            		G.GAME.consumeable_buffer = 0
                                        	     return true
                                    	    	end)}))
                                	return {
                                    		message = localize('k_plus_spectral'),
                                    		colour = G.C.SECONDARY_SET.Spectral,
                                    		card = self
                                	}
				end
                	else
				if not context.blueprint then
                   			self.ability.extra.skull_discards = self.ability.extra.skull_discards - 1
				end
                	end
		end
end

if JokerDisplay then
    JokerDisplay.Definitions['j_dd_flying_skull'] = {
	reminder_text = {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "skull_discards" },
            { text = "/" },
            { ref_table = "card.joker_display_values",        ref_value = "discards" },
            { text = ")" },
        },
        calc_function = function(card)
            	card.joker_display_values.skull_discards = card.ability.extra.skull_discards or card.ability.extra.discards
	   	card.joker_display_values.discards = card.ability.extra.discards
        end
    }
end
	
return j
