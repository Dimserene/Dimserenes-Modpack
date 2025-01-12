SMODS.Atlas {
  key = "atlas_test",
  px = 71,
  py = 95,
  path = "cards.png"
}

SMODS.Consumable {
  key = 'spectral_inversion',
  set = 'Spectral',
  loc_txt = {
    name = 'Inversion',
    text = {
      "Add {C:dark_edition}Negative{}",
	  "to {C:attention}1{} selected",
      "card in your hand"
    }
  },
  rarity = 4,
  atlas = 'atlas_test',
  pos = { x = 0, y = 0 },
  cost = 4,
    use = function(self, card, context, copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
		--local over = false
		--local edition = poll_edition('aura', nil, true, true)
			local aura_card = G.hand.highlighted[1]
			aura_card:set_edition({negative = true}, true)
			card:juice_up(0.3, 0.5)
        return true end }))
    end,
    can_use = function(self, card)
		if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] and (not G.hand.highlighted[1].edition) then
			return true
		else
			return false
		end
    end,
}

SMODS.Booster:take_ownership_by_kind("Standard", {
	create_card = function(self, card, i)
		local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, false)
		local _seal = SMODS.poll_seal({mod = 10})
		return {set = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
	end
})
