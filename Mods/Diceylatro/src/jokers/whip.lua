local j = {
  loc_txt = {
    name = "Whip",                                
        text = {
            "Add {C:purple}Enhanced 4{} per hand remaining,",
	    "then {C:red}lose all hand{} by end of the round"                       
        },
  },
  config = {extra = 0},
  rarity = 2,
  cost = 9,
  atlas = 14,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra} }
end


function j:calculate(self, context)
		if context.setting_blind or context.after then
			self.ability.extra = G.GAME.current_round.hands_left
		end 
		if context.end_of_round and self.ability.extra > 0 then
			local hands_left = self.ability.extra
			self.ability.extra = 0
			G.GAME.current_round.hands_left = 0
                    	G.E_MANAGER:add_event(Event({
               			trigger = 'after',
                		delay = 0.7,
                		func = function() 
                    			local cards = {}
                    			for i=1, hands_left do
                        			cards[i] = true
						local suit_prefix_list = {'S','H','D','C'}
                        			_rank = '4'
                            			_suit = pseudorandom_element(suit_prefix_list)
                        			local cen_pool = {}
                        			for k, v in pairs(G.P_CENTER_POOLS["Enhanced"]) do
                            			if v.key ~= 'm_stone' and v.key ~= "m_ortalab_ore" then 
                                			cen_pool[#cen_pool+1] = v
                            			end
                        		end
                        		create_playing_card({front = G.P_CARDS[_suit..'_'.._rank], center = pseudorandom_element(cen_pool, pseudoseed('spe_card'))}, G.deck, nil, i ~= 1, {G.C.SECONDARY_SET.Spectral})
                    		end
                    		playing_card_joker_effects(cards)
                    		return true end }))
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
