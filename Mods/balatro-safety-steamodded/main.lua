--- STEAMODDED HEADER
--- MOD_NAME: Balatro Safety
--- MOD_ID: balatro-safety
--- MOD_AUTHOR: [Zei33]
--- MOD_DESCRIPTION: Protects you from accidentally making dangerous decisions. You'll be presented with a confirmation before some choices.
--- BADGE_COLOUR: 3576de
--- VERSION: 1.0.0
--- PREFIX: zei

local function create_multiline_text(text, text_scale, alignment, padding)
	local text = text or { }
	for i, v in ipairs(text) do
		text[i] = {
			n = G.UIT.R,
			config = {
				align = alignment or "cm",
				padding = padding or 0.05
			},
			nodes = {
				{
					n = G.UIT.T,
					config = {
						text = v,
						scale = text_scale or 1,
						colour = G.C.UI.TEXT_LIGHT,
						shadow = true
					}
				}
			}
		};
	end;

	return text
end

local function create_card_desc_text(card_desc) 
	local output = { }
	for i, v in ipairs(card_desc) do
		for i2, v2 in ipairs(v) do
			v2.config.scale = 0.45
			if v2.config.colour == G.C.UI.TEXT_DARK then
				v2.config.colour = G.C.SO_2.Hearts
			end
		end
		
		output[i] = {
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.05
			},
			nodes = v
		}
	end

	return output
end

local function create_UIBox_generic_container(options)
    options = options or {
		content = {}
	}

    return {
		{
			n = G.UIT.R,
			config = {
				align = "cm",
				padding = 0.03,
				colour = G.C.UI.TRANSPARENT_LIGHT,
				r = 1
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.05,
						colour = G.C.DYN_UI.MAIN,
						r = 1
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								colour = G.C.DYN_UI.BOSS_DARK,
								minw = options.width or 10,
								minh = options.height or 4,
								r = 1,
								padding = 0.08
							},
							nodes = options.content
						}
					}
				}
			}
		}
	}
end

local function create_UIBox_confirmation(options)
	options = options or {}

	return {
		{
			n = G.UIT.C,
			config = {
				align = "cm",
				padding = 0,
				minw = 5,
				minh = 4,
				r = 1
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0,
						minw = 5,
						minh = 4,
						r = 1
					},
					nodes = {
						{
							n = G.UIT.O,
							config = {
								align = "cm",
								object = options.card
							}
						}
					}
				},
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0,
						minw = 5,
						minh = 2.4,
						r = 1,
						colour = G.C.UI.BACKGROUND_WHITE
					},
					nodes = create_card_desc_text(options.card_desc)
				}
			}
		},
		{
			n = G.UIT.C,
			config = {
				align = "cr",
				padding = 0,
				minw = 5,
				minh = 4,
				r = 1,
				colour = G.C.UI.BACKGROUND_DARK
			},
			nodes = {
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.025,
						minw = 5,
						minh = 4,
						maxw = 5,
						r = 1
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								padding = 0.3,
								minw = 5,
								minh = 2,
								maxw = 5,
								r = 1
							},
							nodes = create_multiline_text({
								"Are you SURE",
								"you want to do this?"
							}, 0.75, "cm", 0.02, 1)
						}
					}
				},
				{
					n = G.UIT.R,
					config = {
						align = "cm",
						padding = 0.025,
						minw = 5,
						minh = 2,
						maxw = 5,
						r = 1
					},
					nodes = {
						{
							n = G.UIT.R,
							config = {
								align = "cm",
								padding = 0.025,
								minw = 5,
								minh = 2,
								maxw = 5,
								r = 1
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										padding = 0.05,
										minw = 4.75,
										minh = 1,
										maxw = 4.75,
										r = 1
									},
									nodes = {
										UIBox_button({
											button = 'safety_confirm_action', 
											label = { "CONFIRM" },
											minw = 4.75, 
											minh = 0.95, 
											scale = 0.5, 
											colour = G.C.GREEN,
											id = 'safety_confirm'
										})
									}
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										padding = 0.05,
										minw = 4.75,
										minh = 1,
										maxw = 5,
										r = 1
									},
									nodes = {
										UIBox_button({
											button = 'safety_cancel_action', 
											label = { "CANCEL" },
											minw = 4.75, 
											minh = 0.95, 
											scale = 0.5, 
											colour = G.C.RED,
											id = 'safety_cancel'
										})
									}
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										padding = 0,
										minw = 4.5,
										minh = 0.1,
										maxw = 5,
										r = 1
									}
								}
							}
						}
					}
				}
			}
		}
	}
end

local confirm_action = nil
local safety_card = nil
local danger_cards = { "c_hex", "c_ankh" }

local function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

G.UIDEF.safety_box = function(card)
	local display_card = Card(0, 0, G.CARD_W, G.CARD_H, card.config.center, card.config.center)
	display_card.no_ui = true
	card.area:unhighlight_all()
	
	card_desc = {}
	localize{type = 'descriptions', key = card.config.center.key, set = card.config.center.set, nodes = card_desc, vars = { } }
	
	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			padding = 0.1,
			r = 2
		},
		nodes = create_UIBox_generic_container({
			content = create_UIBox_confirmation({
				card = display_card,
				card_desc = card_desc
			})
		})
	}
end

G.FUNCS.safety_confirm_action = function()
	if confirm_action then
		confirm_action()
	end
end

G.FUNCS.safety_cancel_action = function()
	G.FUNCS.exit_overlay_menu()
	safety_card = nil
	confirm_action = nil
end

G.FUNCS.safety_use_card = G.FUNCS.use_card

G.FUNCS.use_card = function(e, mute, nosave)
	safety_card = e.config.ref_table
	
	if safety_card.config.center.set == "Spectral" and has_value(danger_cards, safety_card.config.center.key) then
		confirm_action = function()
			G.FUNCS.safety_use_card(e, mute, nosave)
			G.FUNCS.exit_overlay_menu()
		end

		G.FUNCS.overlay_menu({definition = G.UIDEF.safety_box(safety_card) })
	else
		confirm_action = nil
		safety_card = nil
		G.FUNCS.safety_use_card(e, mute, nosave)
	end
end