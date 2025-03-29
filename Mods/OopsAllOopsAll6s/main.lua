local config = SMODS.current_mod.config
SMODS.Atlas{
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
}

SMODS.Atlas{
    key = 'OopsTags',
    path = 'tag.png',
    px = 34,
    py = 34,
}
local tag_center = SMODS.Tag{
    key = 'oops',
    loc_txt = {
        name = 'Oops Tag',
        text = {
            'Shop has a {C:attention}free',
            '{C:dark_edition}Negative{C:green} Oops! All 6s{}',
        }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = "e_negative", set = "Edition", config = {extra = G.P_CENTERS['e_negative'].config.card_limit}}
        info_queue[#info_queue + 1] = {key = "j_oops", set = "Joker"}
        return {}
    end,
    config = {},
    atlas = 'OopsTags',
    pos = {x = config.tag_sprite - 1, y = 0},
    in_pool = function(self, args)
        return not G.GAME.banned_keys["j_oops"]
    end,
    apply = function(self, tag, context)
        if context.type == 'store_joker_create' and not tag.triggered then
            local new = create_card("Joker", context.area, nil, nil, nil, nil, "j_oops")
            create_shop_card_ui(new, "Joker", context.area)
            new.states.visible = false
            tag:yep("+", G.C.GREEN, function()
                new:start_materialize()
                new:set_edition({negative = true}, true)
                new.ability.couponed = true
                new:set_cost()
                return true
            end)
            tag.triggered = true
            return new
        end
    end,
}

SMODS.Atlas{
    key = 'OopsDeck',
    path = 'deck.png',
    px = 71,
    py = 95,
}
SMODS.Back({
    key = 'oops',
    loc_txt = {
        name = '"Lucky" Deck',
        text = {
            'Start with #1# free',
            "{C:dark_edition,T:e_negative}Negative{} {C:green,T:j_oops}Oops! All 6s{}",
        },
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {config.deck_amount}}
    end,
    config = {},
    atlas = 'OopsDeck',
    pos = {x = 0, y = 0},
    apply = function(self, back)
        for i=1, config.deck_amount do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                local new = SMODS.create_card{key = 'j_oops', set = 'Joker', area = G.jokers}
                new:set_edition({negative = true}, true)

                new:add_to_deck()
                G.jokers:emplace(new)
                new:start_materialize()
                return true
            end}))
        end
    end,
})
if CardSleeves then
    CardSleeves.Sleeve({
        key = 'oops',
        loc_txt = {
            name = '"Lucky" Sleeve',
            text = {
                'Start with #1# free',
                "{C:dark_edition,T:e_negative}Negative{} {C:green,T:j_oops}Oops! All 6s{}",
            },
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {config.deck_amount}}
        end,
        config = {},
        atlas = 'OopsDeck',
        pos = {x = 1, y = 0},
        apply = function(self, back)
            for i=1, config.deck_amount do
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    local new = SMODS.create_card{key = 'j_oops', set = 'Joker', area = G.jokers}
                    new:set_edition({negative = true}, true)
    
                    new:add_to_deck()
                    G.jokers:emplace(new)
                    new:start_materialize()
                    return true
                end}))
            end
        end,
    })
end

G.FUNCS.OopsOops_sprite_config = function(e)
    config.tag_sprite = e.to_key
    tag_center.pos.x = config.tag_sprite - 1
    SMODS.save_mod_config(SMODS.current_mod)
end
G.FUNCS.OopsOops_deck_config = function(e)
    config.deck_amount = e.to_key
    SMODS.save_mod_config(SMODS.current_mod)
end
SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
        {n = G.UIT.C, config = {r = 0.1, minw = 4, align = "tc", padding = 0.2, colour = G.C.BLACK}, nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    r = 0.1,
                    emboss = 0.1,
                    outline = 1,
                    padding = 0.2
                },
                nodes = {
                    create_option_cycle({
                        label = localize("c_OopsOops_sprite"),
                        options = {'Default', 'Shaded', 'Drawn'},
                        ref_table = config,
                        ref_value = 'tag_sprite',
                        opt_callback = 'OopsOops_sprite_config',
                        current_option = config.tag_sprite,
                    }),
                },
            },
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    r = 0.1,
                    emboss = 0.1,
                    outline = 1,
                    padding = 0.2
                },
                nodes = {
                    create_option_cycle({
                        label = localize("c_OopsOops_deck"),
                        options = {'1', '2', '3', '4'},
                        ref_table = config,
                        ref_value = 'deck_amount',
                        opt_callback = 'OopsOops_deck_config',
                        current_option = config.deck_amount,
                    }),
                },
            },
        }},
    }}
end