
-- i have no idea if this is useful
SMODS.InstaPix = SMODS.Consumable:extend {
	set = 'InstaPix',
	can_use = function()
		return false
	end
}

local instapix = SMODS.ConsumableType({
	key = "InstaPix",
	primary_colour = HEX("090909"),
	secondary_colour = HEX("090909"),
	collection_rows = { 4, 4 },
	shop_rate = 0.0,
	loc_txt = {},
	default = "c_ccc_test",
	can_stack = false,
	can_divide = false,
	loc_txt = {
		name = 'InstaPix',
		collection = 'InstaPix',
		undiscovered = {
			name = 'Undiscovered',
			text = { 'discover this card', 'to discover' },
		}
	},
})


function G.UIDEF.ccc_sell_and_sticker_buttons(card)
  local sticker = nil
  if card.ability.consumeable then
    if (card.area == G.pack_cards and G.pack_cards) then
      return {
        n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
          {n=G.UIT.R, config={mid = true}, nodes={
          }},
          {n=G.UIT.R, config={ref_table = card, r = 0.08, padding = 0.1, align = "bm", minw = 0.5*card.T.w - 0.15, minh = 0.8*card.T.h, maxw = 0.7*card.T.w - 0.15, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
            {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
          }},
      }}
    end
    use = 
    {n=G.UIT.C, config={align = "cr"}, nodes={
      
      {n=G.UIT.C, config={ref_table = card, align = "cr",maxw = 1.25, padding = 0.1, r=0.08, minw = 1.25, minh = (card.area and card.area.config.type == 'joker') and 0 or 1, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'use_card', func = 'can_use_consumeable'}, nodes={
        {n=G.UIT.B, config = {w=0.1,h=0.6}},
        {n=G.UIT.T, config={text = localize('b_use'),colour = G.C.UI.TEXT_LIGHT, scale = 0.55, shadow = true}}
      }}
    }}
  end
    local t = {
      n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
        {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            sell
          }},
          {n=G.UIT.R, config={align = 'cl'}, nodes={
            use
          }},
        }},
    }}
  return t
end

local test = SMODS.InstaPix({
	name = "ccc_Test",
	key = "Test",
	config = {},
	pos = {x = 0, y = 0},
	loc_txt = {
		name = 'Test',
		text = {
			"Test thing",
		}
	},
	cost = 6,
	discovered = true,
	atlas = "i_ccc_instapix",
	credit = {
		art = "toneblock",
		code = "toneblock",
		concept = "toneblock"
	}
})