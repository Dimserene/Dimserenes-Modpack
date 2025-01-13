inversion_config = SMODS.current_mod.config

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
	  "to {C:attention}1{} #1#",
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
			local aura_card
			if inversion_config.inversionRandom then
				local uneditioned_cards = {}
				for i=1,#G.hand.cards do
					if G.hand.cards[i].edition == nil then
						table.insert(uneditioned_cards, G.hand.cards[i])
					end
				end
				
				aura_card = uneditioned_cards[math.min(math.floor(pseudorandom(pseudoseed('inversion'..G.GAME.round_resets.ante)) * #uneditioned_cards + 1), #uneditioned_cards)]
			else
				aura_card = G.hand.highlighted[1]
			end
			aura_card:set_edition({negative = true}, true)
			card:juice_up(0.3, 0.5)
        return true end }))
    end,
    can_use = function(self, card)
		if inversion_config.inversionRandom then
			local uneditioned_cards = {}
			for i=1,#G.hand.cards do
				if G.hand.cards[i].edition == nil then
					table.insert(uneditioned_cards, G.hand.cards[i])
				end
			end
			if #uneditioned_cards >= 1 then
				return true
			else
				return false
			end
		else
			if G.hand and (#G.hand.highlighted == 1) and G.hand.highlighted[1] and (not G.hand.highlighted[1].edition) then
				return true
			else
				return false
			end
		end
    end,
	loc_vars = function(self, info_queue, card)
		return {vars = {inversion_config.inversionRandom and "random" or "selected"}}
	end
}

SMODS.Booster:take_ownership_by_kind("Standard", {
	create_card = function(self, card, i)
		local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, not inversion_config.negativesInPacks)
		local _seal = SMODS.poll_seal({mod = 10})
		return {set = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
	end
})

SMODS.current_mod.config_tab = function()
	return {n = G.UIT.ROOT, config = {
		align = "tm",
		padding = 0.2,
		minw = 8,
		minh = 6,
		colour = G.C.BLACK,
		r = 0.1,
		hover = true,
		shadow = true,
		emboss = 0.05
	}, nodes = {
		{n = G.UIT.R, config = {padding = 0, align = "cm", minh = 0.1}, nodes = {
			{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Negatives in Packs", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = inversion_config, ref_value = "negativesInPacks" },
            }}
		}},
		{n = G.UIT.R, config = {padding = 0, align = "cm", minh = 0.1}, nodes = {
			{n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "Inversion Target is Random", scale = 0.45, colour = G.C.UI.TEXT_LIGHT }},
            }},
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
                create_toggle{ col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = inversion_config, ref_value = "inversionRandom", button = "update_inversion_desc" },
            }}
		}}
	}}
end

