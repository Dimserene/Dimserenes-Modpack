local j = {
  loc_txt = {
    name = "Precious egg",                                   
        text = {
            	"After {C:attention}#2#{} rounds,",
      		"sell this card to create",
      		"a random {C:red}Rare{} {C:attention}joker{}",
      		"{C:inactive}(Currently {C:attention}#1#{C:inactive}/#2#)"                 
        },
  },
  config = {extra = {c_rounds = 0, rounds = 6}},
  rarity = 1,
  cost = 0,
  atlas = 6,

  blueprint_compat = true,
}

function j:loc_vars(_, card)
	return { vars = { card.ability.extra.c_rounds, card.ability.extra.rounds } }
end


function j:calculate(card, context)
        	if context.end_of_round and not context.individual and not context.repetition  and not context.blueprint then
      			card.ability.extra.c_rounds = card.ability.extra.c_rounds + 1
      			if card.ability.extra.c_rounds >= card.ability.extra.rounds and (card.ability.extra.c_rounds - 1) < card.ability.extra.rounds then 
        			local eval = function(card) return not card.REMOVED end
        			juice_card_until(card, eval, true)
      			end
      			return {
        			message = (card.ability.extra.c_rounds < card.ability.extra.rounds) and (card.ability.extra.c_rounds..'/'..card.ability.extra.rounds) or localize('k_active_ex'),
        			colour = G.C.FILTER
      			}
    		end
    		if context.selling_self and (card.ability.extra.c_rounds >= card.ability.extra.rounds) and not context.blueprint then
      			local eval = function(card) return (card.ability.loyalty_remaining == 0) and not G.RESET_JIGGLES end
        		juice_card_until(card, eval, true)
      			local newCard = create_card('Joker', G.jokers, nil, 2, nil, nil, nil, 'egg')
			newCard:add_to_deck()
			G.jokers:emplace(newCard)
		end   
end

if JokerDisplay then
    JokerDisplay.Definitions["j_dd_precious_egg"] = {
    	reminder_text = {
      	{ text = "(" },
      	{ ref_table = "card.joker_display_values", ref_value = "c_rounds" },
      	{ text = "/" },
      	{ ref_table = "card.joker_display_values", ref_value = "rounds" },
      	{ text = ")" },
    	},	
	calc_function = function(card)
            	local rounds = card.ability.extra.rounds 
		local c_rounds = card.ability.extra.c_rounds
		card.joker_display_values.rounds = rounds
		card.joker_display_values.c_rounds = c_rounds
        end
    }
end
	
return j
