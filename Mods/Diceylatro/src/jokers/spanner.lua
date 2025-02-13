local j = {
  loc_txt = {
    name = "Spanner",                                   
        text = {
            "When {C:attention}blind{} is selected with #1# or more planet,",            
            "destroy them and create a {C:spectral}Black Hole{}"                
        },
  },
  config = {extra = {planets = 2}},
  rarity = 2,
  cost = 5,
  atlas = 11,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = {card.ability.extra.planets} }
end


function j:calculate(self, context)
        if context.setting_blind and not self.getting_sliced then
           	local planets = 0
                for i=#G.consumeables.cards, 1, -1 do
                    	if G.consumeables.cards[i].ability.set == "Planet" then
				planets = planets + 1
			end
                end
		if planets >= self.ability.extra.planets then
			for i=#G.consumeables.cards, 1, -1 do
                    		if G.consumeables.cards[i].ability.set == "Planet" then
					G.consumeables.cards[i]:start_dissolve(nil, i == 1)							
				end
			end
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                                    trigger = 'before',
                                    delay = 0.0,
                                    func = (function()
                                            local card = create_card(nil,G.consumeables, nil, nil, nil, nil, 'c_black_hole', 'sup')
                                            card:add_to_deck()
                                            G.consumeables:emplace(card)
                                            G.GAME.consumeable_buffer = 0
                                    return true
                                    	   end)}))
		end
	end                       
end


if JokerDisplay then
    JokerDisplay.Definitions["j_dd_spanner"] = {
	text = {
            { ref_table = "card.joker_display_values", ref_value = "planets", colour = lighten(G.C.SECONDARY_SET.Planet, 0.1)},
            { text = " planets", colour = lighten(G.C.SECONDARY_SET.Planet, 0.1)},
        },
	reminder_text = {
            { ref_table = "card.joker_display_values", ref_value = "active_text" },
        },
        calc_function = function(card)
		local active = false
		local planets = 0
                for i=#G.consumeables.cards, 1, -1 do
                    	if G.consumeables.cards[i].ability.set == "Planet" then
				planets = planets + 1
			end
                end
		if planets >= card.ability.extra.planets then
			active = true
		end
		card.joker_display_values.planets = card.ability.extra.planets
		card.joker_display_values.active_text = active and localize("jdis_active") or localize("jdis_inactive")
        end
    }
end

return j
