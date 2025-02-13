local j = {
  loc_txt = {
    name = "Lament",                                   
    text = {
            	"Give {C:attention}#1#{} tag for every {C:attention}#2# Aces{} in full deck",
		"{C:inactive}(Currently #3# Aces, #4# tags)"            
    },
  },
  config = {extra = {tags = 1, aces = 4, cur_aces = 0, cur_tags = 0}},
  rarity = 2,
  cost = 7,
  atlas = 5,

  blueprint_compat = false,
}

function j:loc_vars(_, card)
	cur_aces = 0
	if G.playing_cards then
            	for k, v in pairs(G.playing_cards) do
                	if v:get_id() == 14 then cur_aces = cur_aces+1 end
            	end
	end
	return { vars = { card.ability.extra.tags, card.ability.extra.aces, cur_aces, card.ability.extra.cur_tags } }
end


if JokerDisplay then
    JokerDisplay.Definitions['j_dd_lament'] = {
        text = {
            	{ ref_table = 'card.joker_display_values', ref_value = 'left', colour = lighten(G.C.PURPLE, 0.1)},
		{ text = ' left', colour = lighten(G.C.PURPLE, 0.1)}
        },
        calc_function = function(card)
            	local left = card.ability.extra.aces - (card.ability.extra.cur_aces - card.ability.extra.aces * card.ability.extra.cur_tags)
		card.joker_display_values.left = left
        end
    }  
end
	
return j
