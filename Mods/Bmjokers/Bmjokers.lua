--- STEAMODDED HEADER
--- MOD_NAME: Bmjokers
--- MOD_ID: Bmjokers
--- MOD_AUTHOR: [BaiMao]
--- MOD_DESCRIPTION: Create more powerful jokers
--- BADGE_COLOUR: A64E91
--- VERSION: 1.0.4g
----------------------------------------------
------------MOD CODE -------------------------

local Game_start_run_ref = Game.start_run
function Game:start_run(args)
    Game_start_run_ref(self, args)
    G.GAME.bmjokers = true
end

G.FUNCS.microchip_leftcompat = function(e)
    if e.config.ref_table.ability.leftblueprint_compat ~= e.config.ref_table.ability.leftblueprint_compat_check then
        if e.config.ref_table.ability.leftblueprint_compat == 'compatible' then 
            e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
            e.config.ref_table.ability.leftblueprint_compat_ui = localize('l_compatible')
        elseif e.config.ref_table.ability.leftblueprint_compat == 'incompatible' then
            e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
            e.config.ref_table.ability.leftblueprint_compat_ui = localize('l_incompatible')
        end
        e.config.ref_table.ability.leftblueprint_compat_check = e.config.ref_table.ability.leftblueprint_compat
    end
end

G.FUNCS.microchip_rightcompat = function(e)
    if e.config.ref_table.ability.rightblueprint_compat ~= e.config.ref_table.ability.rightblueprint_compat_check then
        if e.config.ref_table.ability.rightblueprint_compat == 'compatible' then 
            e.config.colour = mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
            e.config.ref_table.ability.rightblueprint_compat_ui = localize('r_compatible')
        elseif e.config.ref_table.ability.rightblueprint_compat == 'incompatible' then
            e.config.colour = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
            e.config.ref_table.ability.rightblueprint_compat_ui = localize('r_incompatible')
        end
        e.config.ref_table.ability.rightblueprint_compat_check = e.config.ref_table.ability.rightblueprint_compat
    end
end

local generate_UIBox_ability_table_ref = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local generate_UIBox_ability_table_val = generate_UIBox_ability_table_ref(self)

    if self.ability and self.ability.name == 'Microchip' and not self.debuff then
        self.ability.leftblueprint_compat_ui = self.ability.leftblueprint_compat_ui or ''; self.ability.leftblueprint_compat_check = nil
        self.ability.rightblueprint_compat_ui = self.ability.rightblueprint_compat_ui or ''; self.ability.rightblueprint_compat_check = nil
        local main_text = generate_UIBox_ability_table_val.main
        main_text[#main_text + 1] = (self.area and self.area == G.jokers) and {
            {
                n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                    {n=G.UIT.C, config={ref_table = self, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'microchip_leftcompat'}, nodes={
                        {n=G.UIT.T, config={ref_table = self.ability, ref_value = 'leftblueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
                    }}
                }
            }
        } or nil
        main_text[#main_text + 1] = (self.area and self.area == G.jokers) and {
            {
                n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
                    {n=G.UIT.C, config={ref_table = self, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'microchip_rightcompat'}, nodes={
                        {n=G.UIT.T, config={ref_table = self.ability, ref_value = 'rightblueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
                    }}
                }
            }
        } or nil
    end
    if self.ability.set == 'Joker' and self.ability.retriggers and self.ability.retriggers >= 1 and not self.debuff then
        generate_card_ui({key = 'Cultivation', set = 'Other', vars = {self.ability.retriggers}}, generate_UIBox_ability_table_val)
    end
    if self.ability and self.ability.name == 'Clover' and not self.debuff then
        generate_card_ui({key = 'High_Quality_Spectral_Card', set = 'Other'}, generate_UIBox_ability_table_val)
    end
    if self.ability and self.ability.name == 'Duke' and not self.debuff then
        generate_card_ui(G.P_CENTERS.m_steel, generate_UIBox_ability_table_val)
    end
    if self.ability and self.ability.name == 'RNA' and not self.debuff then
        generate_card_ui(G.P_CENTERS.c_death, generate_UIBox_ability_table_val)
    end
    return generate_UIBox_ability_table_val
end

local G_UIDEF_card_h_popup_ref = G.UIDEF.card_h_popup
function G.UIDEF.card_h_popup(card)
    local G_UIDEF_card_h_popup_val = G_UIDEF_card_h_popup_ref(card)
    if card.ability and card.ability.set == 'Joker' and card.ability.retriggers >= 1 then
        local badges = G_UIDEF_card_h_popup_val.nodes[1].nodes[1].nodes[1].nodes[3].nodes
        badges[#badges + 1] = create_badge(localize('cultivation', "labels"), HEX("6495ed"))
    end
    return G_UIDEF_card_h_popup_val
end

function shallow_copy(obj)
    local res = {}
    if type(obj) ~= "table" then
        return obj
    end
    for k, v in pairs(obj) do
        res[k] = v
    end
    return res
end

local SMODS_calculate_individual_effect_ref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
    if effect.card and effect.card.ability.retriggers >= 1 and not from_edition then
        if key == 'message' and effect[key] == localize('k_again_ex') then
        else
            for i = 1, effect.card.ability.retriggers do
                SMODS_calculate_individual_effect_ref(effect, scored_card, key, amount, from_edition)
            end
        end
    elseif scored_card and scored_card.ability.retriggers >= 1 and not from_edition then
        for i = 1, scored_card.ability.retriggers do
            SMODS_calculate_individual_effect_ref(effect, scored_card, key, amount, from_edition)
        end
    end
    return SMODS_calculate_individual_effect_ref(effect, scored_card, key, amount, from_edition)
end

local eval_card_ref = eval_card
function eval_card(card, context)
    local eval_card_ret, post_trig = eval_card_ref(card, context)
    if card.ability.retriggers >= 1 then
        for k, v in pairs(eval_card_ret) do
            if type(v) == "table" and v.repetitions then
                v.repetitions = v.repetitions*(1+card.ability.retriggers)
            end
        end
        for i = 1, card.ability.retriggers do
            eval_card_ref(card, context)
        end
    end
    return eval_card_ret, post_trig
end

local Card_calculate_dollar_bonus_ref = Card.calculate_dollar_bonus
function Card:calculate_dollar_bonus()
    local retri = self.ability.retriggers
    if retri >= 1 then
        local ret = nil
        for i = 1, retri + 1 do
            local pre_ret = Card_calculate_dollar_bonus_ref(self)
            if pre_ret and ret then
                ret = ret + pre_ret
            elseif pre_ret then
                ret = pre_ret
            end
        end
        return ret
    else
        return Card_calculate_dollar_bonus_ref(self)
    end
end

SMODS.optional_features.retrigger_joker = true

SMODS.Atlas{
    key = 'bmjokers',
    px = 71,
    py = 95,
    path = 'BmJokers.png'
}

SMODS.Joker{
    key = 'heart',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {price = 100, cost_lost = 100} },
    loc_vars = function(self, info_queue, card)
        local state
        if G.GAME.dollars >= card.ability.extra.price then
            state = localize('y_active')
        else
            state = localize('n_active')
        end
        return { vars = {card.ability.extra.price, card.ability.extra.cost_lost, state} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            if context.game_over and G.GAME.dollars >= card.ability.extra.price then
                G.E_MANAGER:add_event(Event({func = function()
                    ease_dollars(-card.ability.extra.cost_lost)
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                return true end}))
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'supermeteor',
    name = 'Supermeteor',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 0 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' then
            G.E_MANAGER:add_event(Event({func = function()
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_again_ex')})
                context.consumeable:use_consumeable(context.consumeable.area)
            return true end}))
        end
    end
}

SMODS.Joker{
    key = 'duke',
    name = 'Duke',
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 0 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {x_mult = 1.2, repetitions = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult, card.ability.extra.repetitions} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.hand then
            if not context.end_of_round then
                if context.individual and context.other_card:is_face() then
                    return{
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                elseif context.repetition and context.other_card:is_face() and context.other_card.ability.effect == 'Steel Card' then
                    return{
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.repetitions,
                        card = card
                    }
                end
            else
                if context.repetition and context.other_card:is_face() and context.other_card.ability.effect == 'Steel Card' then
                    return{
                        message = localize('k_again_ex'),
                        repetitions = card.ability.extra.repetitions,
                        card = card
                    }
                end
            end
        end
    end
}

SMODS.Joker{
    key = 'clover',
    name = 'Clover',
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 0 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {odd = 2, amount = 1, amounts = 1, joker_to_destroy = nil} },
    loc_vars = function(self, info_queue, card)
        return { vars = {''..(G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odd, card.ability.extra.amount, card.ability.extra.amounts} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not card.getting_sliced then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    local k = 1
                    while G.jokers.cards[i + k] and G.jokers.cards[i + k].getting_sliced do
                        k = k + 1
                    end
                    card.ability.extra.joker_to_destroy = G.jokers.cards[i + k]
                end
            end
            if card.ability.extra.joker_to_destroy and not card.ability.extra.joker_to_destroy.ability.eternal then
                local joker_to_destroy = card.ability.extra.joker_to_destroy
                joker_to_destroy.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    card:juice_up(0.8, 0.8)
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local consumeables_to_create = math.min(card.ability.extra.amounts, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + consumeables_to_create
                    if joker_to_destroy.sell_cost < 3 then
                        G.E_MANAGER:add_event(Event({func = function()
                            for i = 1, consumeables_to_create do
                                local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, nil, 'clo')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            end
                        return true end}))
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('f_leaves'), colour = G.C.GREEN})
                    elseif joker_to_destroy.sell_cost >= 3 then
                        local useful_list = {
                            "c_immolate",
                            "c_cryptid",
                            "c_talisman",
                            "c_deja_vu",
                            "c_trance",
                            "c_medium",
                        }
                        G.E_MANAGER:add_event(Event({func = function()
                            for i = 1, consumeables_to_create do
                                local chosen_spectral = pseudorandom_element(useful_list, pseudoseed('clo'))
                                local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, chosen_spectral, 'clo')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            end
                        return true end}))
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('f_leaves'), colour = G.C.GREEN})
                    end
                end
            end
        end
        if context.selling_card and context.card.ability.set == "Joker" then
            if (pseudorandom('clover') < G.GAME.probabilities.normal/card.ability.extra.odd) then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    local consumeables_to_create_2 = math.min(card.ability.extra.amount, G.consumeables.config.card_limit - (#G.consumeables.cards + G.GAME.consumeable_buffer))
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + consumeables_to_create_2
                    G.E_MANAGER:add_event(Event({func = function()
                        for i = 1, consumeables_to_create_2 do
                            local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil, nil, 'clo')
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                        end
                    return true end}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('f_leaves'), colour = G.C.GREEN}) 
                end
            end
        end
    end
}

SMODS.Joker{
    key = 'smartcowboy',
    name = 'Smartcowboy',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 0 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {perxmult = 0.3, perdollar = 30, x_mult = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.perxmult, card.ability.extra.perdollar, card.ability.extra.x_mult} }
    end,
    calculate = function(self, card, context)
        local smartcowboy_mult = math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.perdollar)
        card.ability.extra.x_mult = 1 + card.ability.extra.perxmult * math.abs(smartcowboy_mult)
        if context.joker_main then
            if card.ability.extra.x_mult > 1 then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult}},
                    Xmult_mod = card.ability.extra.x_mult
                }
            end
        end
    end
}

SMODS.Joker{
    key = 'supergodcard',
    name = 'Supergodcard',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 1 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {times = 1, suml = 0} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.times, card.ability.extra.suml, card.ability.extra.suml*card.ability.extra.times} }
    end,
    calculate = function(self, card, context)
        if G.GAME.blind.boss and context.end_of_round and not context.blueprint then
            for k, v in ipairs(G.consumeables.cards) do
                if not (v.edition and v.edition.type == 'negative') then
                    v:set_edition({negative =true}, true)
                end
            end
        end
        local sum = 0
        --for k, v in ipairs(G.consumeables.cards) do
            --sum = sum + G.consumeables.cards[k].sell_cost 等效替代
        --end
        for i = 1, #G.consumeables.cards do
            sum = sum + G.consumeables.cards[i].sell_cost 
        end
        card.ability.extra.suml = sum
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = math.abs(card.ability.extra.suml*card.ability.extra.times)
        if bonus > 0 then return bonus end
    end
}

SMODS.Joker{
    key = 'chef',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 1 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            if not (context.blueprint_card or card).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                local food_list = {
                    "j_popcorn",
                    "j_gros_michel",
                    "j_ice_cream",
                    "j_turtle_bean",
                    "j_ramen",
                    "j_selzer",
                    "j_diet_cola",
                    "j_cavendish",
                    "j_egg"
                }
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local chosen_joker = pseudorandom_element(food_list, pseudoseed('ctcfd'))
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, chosen_joker, nil)
                        local foodeffect = math.random(1, 5)
                        if foodeffect == 1 then
                            card:set_debuff(true)
                            card:set_perishable(true)
                            card.ability.perish_tally = 0
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('c_perishabled'), colour = G.C.MULT})
                        elseif foodeffect == 2 then
                            card:set_perishable(true)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('c_perishable'), colour = G.C.MULT})
                        elseif foodeffect == 3 then
                            card:set_rental(true)
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('c_rental'), colour = G.C.MULT})
                        elseif foodeffect == 4 then
                            card.ability.eternal = true
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('c_eternal'), colour = G.C.MULT})
                        elseif foodeffect == 5 then
                            card.pinned = true
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('c_pinned'), colour = G.C.MULT})
                        end
                        local foodedition = math.random(1, 30)
                        if foodedition == 1 then
                        card:set_edition({negative = true})
                        elseif foodedition == 2 then
                        card:set_edition({foil = true})
                        elseif foodedition == 3 then
                        card:set_edition({holo = true})
                        elseif foodedition == 4 then
                        card:set_edition({polychrome = true})
                        end
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        G.GAME.joker_buffer = 0
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE}) 
            end
        end
    end
}

SMODS.Joker{
    key = 'shifu',
    rarity = 3,
    cost = 15,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 1 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {amount = 1, magnitude = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.amount, card.ability.extra.magnitude} }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.boss then
            local preach_jokers = {}
            local allow_jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= (context.blueprint_card or card) and not G.jokers.cards[i].getting_sliced then
                    allow_jokers[#allow_jokers + 1] = G.jokers.cards[i]
                end
            end
            pseudoshuffle(allow_jokers, pseudoseed('shifu'))
            for i = 1, math.min(card.ability.extra.amount, #allow_jokers) do
                preach_jokers[i] = allow_jokers[i]
            end
            if preach_jokers[1] and not (context.blueprint_card or card).getting_sliced then
                for i = 1, #preach_jokers do
                    local mai = shallow_copy(preach_jokers[i].ability)
                    for k, v in pairs(mai) do
                        if (type(mai[k]) ~= "table") or type(mai[k]) == "number" then
                            if type(mai[k]) == "number" and k == "retriggers" then
                                mai[k] = mai[k] + card.ability.extra.magnitude
                            end
                        else
                            for _k, _v in pairs(mai[k]) do
                                if type(mai[k][_k]) == "number" and _k == "retriggers" then
                                    mai[k][_k] = mai[k][_k] + card.ability.extra.magnitude
                                end
                            end
                        end
                    end
                    preach_jokers[i].ability = mai
                    card_eval_status_text(preach_jokers[i], 'jokers', nil, nil, nil, {message = localize('s_preach'), colour = G.C.BLACK})
                    card_eval_status_text((context.blueprint_card or card), 'jokers', nil, nil, nil, {message = localize('s_sifu'), colour = G.C.BLACK})
                end
            end
        end
    end
}

SMODS.Joker{
    key = 'microchip',
    name = 'Microchip',
    rarity = 3,
    cost = 15,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 1 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        local left_joker = nil
        local right_joker = nil
        local transfer_ret = nil
        local green_list = {}
        if context.retrigger_joker_check then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == (context.blueprint_card or card) then
                    if G.jokers.cards[i-1] then
                        left_joker = G.jokers.cards[i-1]
                        green_list[#green_list+1] = left_joker
                    end
                    if G.jokers.cards[i+1] then
                        right_joker = G.jokers.cards[i+1]
                        green_list[#green_list+1] = right_joker
                    end
                end
            end
            if #green_list >= 1 then
                for i = 1, #green_list do
                    if context.other_card == green_list[i] then
                        return {
                            message = localize("k_again_ex"),
                            repetitions = 1,
                            message_card = card,
                        }
                    end
                end
            end
        end
    end
}

SMODS.Joker{
    key = 'rna',
    name = 'RNA',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 1 },
    loc_txt ={},
    atlas = 'bmjokers',
    config = { extra = {discard_check = false} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.pre_discard and G.GAME.current_round.discards_used == 0 and #context.full_hand == 1 and not context.blueprint then
            card.ability.extra.discard_check = true
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.RED})
            local eval = function() return G.GAME.current_round.discards_used == 1 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and G.GAME.current_round.discards_used == 1 and #context.full_hand == 1 and card.ability.extra.discard_check and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({func = function()
                local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_death', 'rna')
                _card:add_to_deck()
                G.consumeables:emplace(_card)
                G.GAME.consumeable_buffer = 0
            return true end}))
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot})
        end
        if context.end_of_round and not context.blueprint then
            card.ability.extra.discard_check = false
        end
    end
}

--[[
SMODS.Joker{
    key = 'heart',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc_txt ={
        name = '腐化之心',
        text = {
            '每次出牌时',
            '使{C:attention}已积累{}的分数{C:dark_edition}X2'
        }
    },
    atlas = 'heart',
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
            G.GAME.chips = G.GAME.chips*2
            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "X2已得分数", colour = G.C.DARK_EDITION})
        end
    end
}

SMODS.Joker{
    key = 'heart',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc_txt ={
        name = '腐化之心<杀戮模式>',
        text = {
            '每次出牌计分后',
            '无视永恒摧毁右侧的小丑牌',
            '并获得其售价{C:attention}#1#倍{}的{X:mult,C:white}X#2#{}倍率',
            '{C:inactive}(当前为{X:mult,C:white}X#3#{C:inactive})'
        }
    },
    atlas = 'heart',
    config = { extra = {persellcost = 2, perxmult = 0.5, x_mult = 1} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.persellcost, card.ability.extra.perxmult, card.ability.extra.x_mult} }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after and not (context.blueprint_card or card).getting_sliced and not card.debuff then
            local hea_pos = nil
            for k, v in pairs(G.jokers.cards) do
                if G.jokers.cards[k] == card then hea_pos = k end
            end
            if hea_pos and G.jokers.cards[hea_pos + 1] and not G.jokers.cards[hea_pos + 1].getting_sliced then
                local joker_to_destroy = G.jokers.cards[hea_pos + 1]
                joker_to_destroy.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = 0
                    card.ability.extra.x_mult = card.ability.extra.x_mult + joker_to_destroy.sell_cost*card.ability.extra.persellcost*card.ability.extra.perxmult
                    card:juice_up(0.8, 0.8)
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                return true end }))
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult + joker_to_destroy.sell_cost*card.ability.extra.persellcost*card.ability.extra.perxmult}}})
            end
        end
        if context.joker_main and context.cardarea == G.jokers then
            if card.ability.extra.x_mult > 1 then
            return {
                message = localize {type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult} },
                Xmult_mod = card.ability.extra.x_mult
            }
            end
        end
    end
}

SMODS.Joker{
    key = 'heart',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    loc_txt ={
        name = '腐化之心<骷髅模式>',
        text = {
            '拥有至少{C:money}$#1#{}时',
            '若最终得到的筹码',
            '{C:red}未达到{}所需筹码',
            '不会死亡并失去{C:money}$#2#{}',
            '{C:inactive}(#3#)'
        }
    },
    atlas = 'heart',
    config = { extra = {price = 100, cost_lost = 100} },
    loc_vars = function(self, info_queue, card)
        local state
        if G.GAME.dollars >= card.ability.extra.price then
            state = '已激活'
        else
            state = '未激活'
        end
        return { vars = {card.ability.extra.price, card.ability.extra.cost_lost, state} }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            if context.game_over and G.GAME.dollars >= card.ability.extra.price then
                G.E_MANAGER:add_event(Event({func = function()
                    ease_dollars(-card.ability.extra.cost_lost)
                    G.hand_text_area.blind_chips:juice_up()
                    G.hand_text_area.game_chips:juice_up()
                    play_sound('tarot1')
                return true end}))
                return {
                    message = localize('k_saved_ex'),
                    saved = true,
                    colour = G.C.RED
                }
            end
        end
    end
}
]]

----------------------------------------------
------------MOD CODE END----------------------
