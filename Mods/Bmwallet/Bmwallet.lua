--- STEAMODDED HEADER
--- MOD_NAME: Bmwallet
--- MOD_ID: Bmwallet
--- MOD_AUTHOR: [BaiMao]
--- MOD_DESCRIPTION: Create your wallet that you can hide some cards
--- BADGE_COLOUR: D9D919
--- VERSION: 1.0.3e
----------------------------------------------
------------MOD CODE -------------------------

local CardArea_draw_ref = CardArea.draw
function CardArea:draw()
    CardArea_draw_ref(self)
    if self.config.type == 'bm_wallet' then
        for i = 1, #self.cards do
            if self.cards[i] ~= G.CONTROLLER.focused.target then
                if not self.cards[i].highlighted then
                    if G.CONTROLLER.dragging.target ~= self.cards[i] then
                        self.cards[i]:draw(v)
                    end
                end
            end
        end
        for i = 1, #self.cards do  
            if self.cards[i] ~= G.CONTROLLER.focused.target then
                if self.cards[i].highlighted then
                    if G.CONTROLLER.dragging.target ~= self.cards[i] then
                        self.cards[i]:draw(v)
                    end
                end
            end
        end
    end
end

local CardArea_align_cards_ref = CardArea.align_cards
function CardArea:align_cards()
    if self.config.type == 'bm_wallet' then
        for k, card in ipairs(self.cards) do
            if not card.states.drag.is then 
                card.T.r = 0.1*(-#self.cards/2 - 0.5 + k)/(#self.cards)+ (G.SETTINGS.reduced_motion and 0 or 1)*0.02*math.sin(2*G.TIMERS.REAL+card.T.x)
                local max_cards = math.max(#self.cards, self.config.temp_limit)
                card.T.x = self.T.x + (self.T.w-self.card_w)*((k-1)/math.max(max_cards-1, 1) - 0.5*(#self.cards-max_cards)/math.max(max_cards-1, 1)) + 0.5*(self.card_w - card.T.w)
                if #self.cards > 2 or (#self.cards > 1 and self == G.consumeables) or (#self.cards > 1 and self.config.spread) then
                    card.T.x = self.T.x + (self.T.w-self.card_w)*((k-1)/(#self.cards-1)) + 0.5*(self.card_w - card.T.w)
                elseif #self.cards > 1 and self ~= G.consumeables then
                    card.T.x = self.T.x + (self.T.w-self.card_w)*((k - 0.5)/(#self.cards)) + 0.5*(self.card_w - card.T.w)
                else
                    card.T.x = self.T.x + self.T.w/2 - self.card_w/2 + 0.5*(self.card_w - card.T.w)
                end
                local highlight_height = G.HIGHLIGHT_H/2
                if not card.highlighted then highlight_height = 0 end
                card.T.y = self.T.y + self.T.h/2 - card.T.h/2 - highlight_height+ (G.SETTINGS.reduced_motion and 0 or 1)*0.03*math.sin(0.666*G.TIMERS.REAL+card.T.x)
                card.T.x = card.T.x + card.shadow_parrallax.x/30
            end
        end
        table.sort(self.cards, function (a, b) return a.T.x + a.T.w/2 - 100*((a.pinned and not a.ignore_pinned) and a.sort_id or 0) < b.T.x + b.T.w/2 - 100*((b.pinned and not b.ignore_pinned) and b.sort_id or 0) end)
    end
    CardArea_align_cards_ref(self)
end

local CardArea_can_highlight_ref = CardArea.can_highlight
function CardArea:can_highlight(card)
    if self.config.type == 'bm_wallet' then
        return true
    end
    return CardArea_can_highlight_ref(self, card)
end

local CardArea_add_to_highlight_ref = CardArea.add_to_highlighted
function CardArea:add_to_highlighted(card, silent)
    if self.config.type == 'bm_wallet' then
        if #self.highlighted >= self.config.highlighted_limit then 
            self:remove_from_highlighted(self.highlighted[1])
        end
        self.highlighted[#self.highlighted+1] = card
        card:highlight(true)
        if not silent then play_sound('cardSlide1') end
    else
        CardArea_add_to_highlight_ref(self, card, silent)
    end
end

local Card_highlight_ref = Card.highlight
function Card:highlight(is_higlighted)
    self.highlighted = is_higlighted
    local x_off = (self.ability.consumeable and -0.1 or 0)
    if self.children.restore_button then
        self.children.restore_button:remove()
        self.children.restore_button = nil
    elseif self.children.hide_button then
        self.children.hide_button:remove()
        self.children.hide_button = nil
    elseif self.highlighted and self.area and self.area.config.type == 'bm_wallet' and self.children.restore_button == nil then
        self.children.restore_button = UIBox{
            definition = {
                n=G.UIT.ROOT, config = {padding = 0, colour = G.C.CLEAR}, nodes={
                    {n=G.UIT.C, config={padding = 0.15, align = 'cl'}, nodes={
                        {n=G.UIT.R, config={align = 'cl'}, nodes={
                            {n=G.UIT.C, config={align = "cr"}, nodes={
                                {n=G.UIT.C, config={ref_table = self, align = "cr",padding = 0.1, r=0.08, minw = 1.25, hover = true, shadow = true, colour = G.C.UI.BACKGROUND_INACTIVE, one_press = true, button = 'sell_card', func = 'can_sell_card_ref_2'}, nodes={
                                    {n=G.UIT.B, config = {w=0.1,h=0.6}},
                                    {n=G.UIT.C, config={align = "tm"}, nodes={
                                        {n=G.UIT.R, config={align = "cm", maxw = 1.25}, nodes={
                                            {n=G.UIT.T, config={text = localize('b_sell'),colour = G.C.UI.TEXT_LIGHT, scale = 0.4, shadow = true}}
                                        }},
                                        {n=G.UIT.R, config={align = "cm"}, nodes={
                                            {n=G.UIT.T, config={text = localize('$'),colour = G.C.WHITE, scale = 0.4, shadow = true}},
                                            {n=G.UIT.T, config={ref_table = self, ref_value = 'sell_cost_label',colour = G.C.WHITE, scale = 0.55, shadow = true}}
                                        }}
                                    }}
                                }},
                            }}
                        }},
                    }},
            }},
            config = {align = "cr",
                offset = {x = x_off - 0.4, y = 0},
                parent = self
            }
        }
    end
    Card_highlight_ref(self, is_higlighted)
end

G.FUNCS.can_sell_card_ref_2 = function(e)
    if e.config.ref_table:can_sell_card_ref_2() then 
        e.config.colour = G.C.GREEN
        e.config.button = 'sell_card'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end
    
function Card:can_sell_card_ref_2(context)
    if (G.play and #G.play.cards > 0) or
        (G.CONTROLLER.locked) or 
        (G.GAME.STOP_USE and G.GAME.STOP_USE > 0)
        then return false end
    if ((G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) and
        self.area and
        (self.area.config.type == 'bm_wallet') and
        not self.ability.eternal and (self.ability.consumeable or self.ability.set == 'Joker')) or (G.GAME.sell_license and not self.ability.eternal) then
        return true
    end
    return false
end

local Card_draw_ref = Card.draw
function Card:draw(layer)
    layer = layer or 'both'
    if (layer == 'card' or layer == 'both') then
        if self.children.restore_button and self.highlighted then self.children.restore_button:draw() end
    end
    Card_draw_ref(self, layer)
end

G.FUNCS.set_exchange = function(e)
    if G.GAME.exchange == nil then
        G.GAME.exchange = true
        play_sound('cardSlide1')
    elseif G.GAME.exchange == true then
        G.GAME.exchange = nil
        play_sound('cardSlide1')
    end
end

local generate_UIBox_ability_table_ref = Card.generate_UIBox_ability_table
function Card:generate_UIBox_ability_table()
    local generate_UIBox_ability_table_val = generate_UIBox_ability_table_ref(self)
    local main_text = generate_UIBox_ability_table_val.main
    if self.ability.f_chips and self.ability.f_chips > 0 and not self.debuff then
        localize{type = 'descriptions', key = 'f_chips', set = 'Forge', nodes = generate_UIBox_ability_table_val.main, vars = {self.ability.f_chips}}
    end
    if self.ability.f_mult and self.ability.f_mult > 0 and not self.debuff then
        localize{type = 'descriptions', key = 'f_mult', set = 'Forge', nodes = generate_UIBox_ability_table_val.main, vars = {self.ability.f_mult}}
    end
    if self.ability.f_x_mult and self.ability.f_x_mult > 1 and not self.debuff then
        localize{type = 'descriptions', key = 'f_x_mult', set = 'Forge', nodes = generate_UIBox_ability_table_val.main, vars = {self.ability.f_x_mult}}
    end
    if self.ability.f_level and self.ability.f_level > 0 and not self.debuff then
        if self.ability.f_level < 7 then
            localize{type = 'descriptions', key = 'f_low_level', set = 'Forge', nodes = generate_UIBox_ability_table_val.main, vars = {self.ability.f_level}}
        else
            localize{type = 'descriptions', key = 'f_high_level', set = 'Forge', nodes = generate_UIBox_ability_table_val.main, vars = {self.ability.f_level}}
        end
    end
    return generate_UIBox_ability_table_val
end

function Card:get_f_chips()
    if self.debuff then return 0 end
    if self.ability.f_chips == nil then return 0 end
    if self.ability.f_chips and self.ability.f_chips <= 0 then return 0 end
    return self.ability.f_chips
end

function Card:get_f_mult()
    if self.debuff then return 0 end
    if self.ability.f_mult == nil then return 0 end
    if self.ability.f_mult <= 0 then return 0 end
    return self.ability.f_mult
end

function Card:get_f_x_mult()
    if self.debuff then return 0 end
    if self.ability.f_x_mult == nil then return 0 end
    if self.ability.f_x_mult <= 0 then return 0 end
    return self.ability.f_x_mult
end

local CardArea_set_ranks_ref = CardArea.set_ranks
function CardArea:set_ranks()
    CardArea_set_ranks_ref(self)
    for k, card in ipairs(self.cards) do
        card.rank = k
        card.states.collide.can = true
        if self.config.type == 'shop' then
            card.states.drag.can = true
        end
    end
end

function Card:get_prev_area(context)
    local prev_area
    if self.ability.set == 'Joker' then
        prev_area = G.jokers
    elseif self.ability.consumeable then
        prev_area = G.consumeables
    elseif (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
        prev_area = G.hand
    end
    return prev_area
end

function Card:get_printing_cost(context)
    local printing_cost
    if self.edition == nil then
        printing_cost = 25
    elseif self.edition and self.edition.foil then
        printing_cost = 50
    elseif self.edition and self.edition.holo then
        printing_cost = 100
    elseif self.edition and self.edition.polychrome then
        printing_cost = 200
    end
    return printing_cost
end

function Card:can_mobile_card(context)
    local prev_area = self:get_prev_area()
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if self.area == prev_area or self.area == G.bm_wallet then
            if self.ability.set == 'Joker' then
                return true
            elseif self.ability.consumeable then
                return true
            elseif (self.ability.set == 'Default' or self.ability.set == 'Enhanced') then
                if G.hand and G.hand.cards[1] then
                    return true
                end
            end
        end
    end
    return false
end

G.FUNCS.can_hide_card_touch = function(_card)
    local prev_area = _card:get_prev_area()
    if _card:can_mobile_card() and _card.area == prev_area then
        if G.bm_wallet.config.card_limit > #G.bm_wallet.cards then
            return true
        end
    else
        return false
    end
end

G.FUNCS.hide_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        c1.area:remove_card(c1)
        G.bm_wallet:emplace(c1)
    return true end}))
end

G.FUNCS.can_restore_card_touch = function(_card)
    local prev_area = _card:get_prev_area()
    if _card:can_mobile_card() and _card.area == G.bm_wallet then
        if (prev_area.config.card_limit > #prev_area.cards) or prev_area == G.hand then
            return true
        end
    else
        return false
    end
end

G.FUNCS.restore_card = function(e)
    local c1 = e.config.ref_table
    local prev_area = c1:get_prev_area()
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        c1.area:remove_card(c1)
        prev_area:emplace(c1)
        if c1.ability.set == 'Joker' then
            G.E_MANAGER:add_event(Event({func = function()
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
            return true end}))
        end
    return true end}))
end

G.FUNCS.can_recycle_card_touch = function(_card)
    if _card:can_recycle_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_recycle_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if G.GAME.dollars - G.GAME.bankrupt_at >= 2 then
            return true
        end
    end
    return false
end

G.FUNCS.recycle_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        ease_dollars(-2)
        if c1.area then
            c1:remove_from_deck()
            c1.area:remove_card(c1)
        end
        G.shop_jokers:emplace(c1)
        create_shop_card_ui(c1)
        c1:juice_up(0.3, 0.5)
        G.E_MANAGER:add_event(Event({func = function()
            local _rarity = c1.config.center.rarity
            local _card = nil
            local para_rarity = 0
            if _rarity == 3 then
                para_rarity = 0.99
            elseif _rarity == 2 then
                para_rarity = 0.75
            end
            local _card = nil
            if _rarity ~= 4 then
                _card = create_card('Joker', G.shop_jokers, nil, para_rarity, nil, nil, nil, 'wallet')
            else
                _card = create_card('Joker', G.shop_jokers, true, nil, nil, nil, nil, 'wallet')
            end
            _card:add_to_deck()
            G.bm_wallet:emplace(_card)
            card_eval_status_text(_card, 'extra', nil, nil, nil, {message = localize('b_recycle'), colour = G.C.MULT})
        return true end}))
    return true end}))
end

G.FUNCS.can_maintenance_card_touch = function(_card)
    if _card:can_maintenance_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_maintenance_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if self.ability.perishable and self.ability.perish_tally < G.GAME.perishable_rounds then
            if G.GAME.dollars - G.GAME.bankrupt_at >= 3*(G.GAME.perishable_rounds - self.ability.perish_tally) then
                return true
            end
        end
    end
    return false
end

G.FUNCS.maintenance_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        ease_dollars(-3*(G.GAME.perishable_rounds - c1.ability.perish_tally))
        card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_maintenance_2'), colour = G.C.SECONDARY_SET.Tarot})
        c1.ability.perish_tally = G.GAME.perishable_rounds
        c1:set_debuff(false)
    return true end}))
end

G.FUNCS.can_package_card_touch = function(_card)
    if _card:can_package_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_package_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if G.GAME.dollars - G.GAME.bankrupt_at >= 3 then
            return true
        end
    end
    return false
end

G.FUNCS.package_card = function(e)
    local c1 = e.config.ref_table
    local common_arcana_list = {
        'p_arcana_jumbo_1',
        'p_arcana_jumbo_2',
        'p_arcana_mega_1',
        'p_arcana_mega_2',
    }
    local common_celestial_list = {
        'p_celestial_jumbo_1',
        'p_celestial_jumbo_2',
        'p_celestial_mega_1',
        'p_celestial_mega_2',
    }
    local common_spectral_list = {
        'p_spectral_jumbo_1',
        'p_spectral_mega_1',
    }
    local common_buffoon_list = {
        'p_buffoon_jumbo_1',
        'p_buffoon_mega_1',
    }
    local _pack = nil
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        ease_dollars(-3)
        G.GAME.used_times_consumeable_type = (G.GAME.used_times_consumeable_type or 0) + 1
        if c1.area then
            c1:remove_from_deck()
            c1.area:remove_card(c1)
        end
        G.shop_booster:emplace(c1)
        local card_type = c1.ability.set
        c1.getting_sliced = true
        c1:start_dissolve({G.C.MONEY}, nil, 1.6)
        if G.GAME.used_times_consumeable_type == 2 then
            G.E_MANAGER:add_event(Event({func = function()
                if card_type == 'Tarot' then
                    chosen_pack = pseudorandom_element(common_arcana_list, pseudoseed('wallet'))
                elseif card_type == 'Planet' then
                    chosen_pack = pseudorandom_element(common_celestial_list, pseudoseed('wallet'))
                elseif card_type == 'Spectral' then
                    chosen_pack = pseudorandom_element(common_spectral_list, pseudoseed('wallet'))
                elseif card_type == 'Joker' then
                    chosen_pack = pseudorandom_element(common_buffoon_list, pseudoseed('wallet'))
                end
                _pack = Card(G.shop_booster.T.x + G.shop_booster.T.w/2, G.shop_booster.T.y, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[chosen_pack], {bypass_discovery_center = true, bypass_discovery_ui = true})
                create_shop_card_ui(_pack, 'Booster', G.shop_booster)
                _pack:start_materialize()
                _pack.cost = 0
                _pack.ability.couponed = true
                G.shop_booster:emplace(_pack)
                G.GAME.used_times_consumeable_type = 0
                card_eval_status_text(_pack, 'extra', nil, nil, nil, {message = localize('b_package_3'), colour = G.C.SECONDARY_SET.Planet})
            return true end}))
        end
    return true end}))
end

G.FUNCS.can_printing_card_touch = function(_card)
    if _card:can_printing_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_printing_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if self.ability.set == 'Joker' then
            if self.edition == nil and G.GAME.dollars - G.GAME.bankrupt_at >= 25 then
                return true
            elseif self.edition and self.edition.foil and G.GAME.dollars - G.GAME.bankrupt_at >= 50 then
                return true
            elseif self.edition and self.edition.holo and G.GAME.dollars - G.GAME.bankrupt_at >= 100 then
                return true
            elseif self.edition and self.edition.polychrome and G.GAME.dollars - G.GAME.bankrupt_at >= 200 then
                return true
            end
        end
        if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if self.edition == nil and G.GAME.dollars - G.GAME.bankrupt_at >= 25 then
                return true
            elseif self.edition and self.edition.foil and G.GAME.dollars - G.GAME.bankrupt_at >= 50 then
                return true
            elseif self.edition and self.edition.holo and G.GAME.dollars - G.GAME.bankrupt_at >= 100 then
                return true
            end
        end
    end
    return false
end

G.FUNCS.printing_card = function(e)
    local c1 = e.config.ref_table
    local printing_cost = 0
    if c1.edition == nil then
        printing_cost = 25
    elseif c1.edition and c1.edition.foil then
        printing_cost = 50
    elseif c1.edition and c1.edition.holo then
        printing_cost = 100
    elseif c1.edition and c1.edition.polychrome then
        printing_cost = 200
    end
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        ease_dollars(-printing_cost)
        if printing_cost == 25 then
            c1:set_edition({foil = true}, true)
        elseif printing_cost == 50 then
            c1:set_edition({holo = true}, true)
        elseif printing_cost == 100 then
            c1:set_edition({polychrome = true}, true)
        elseif printing_cost == 200 then
            c1:set_edition({negative = true}, true)
        end
        card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_printing_2'), colour = G.C.SECONDARY_SET.Spectral})
    return true end}))
end

G.FUNCS.can_forge_card_touch = function(_card)
    if _card:can_forge_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_forge_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if self.ability.set == 'Joker' then
            if G.GAME.dollars - G.GAME.bankrupt_at >= 400 then
                return true
            end
        end
        if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if G.GAME.dollars - G.GAME.bankrupt_at >= (10 + (self.ability.f_level or 0)*3) then
                return true
            end
        end
    end
    return false
end

G.FUNCS.forge_card = function(e)
    local c1 = e.config.ref_table
    if c1.ability.set == 'Joker' then
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            ease_dollars(-400)
            c1.ability.retriggers = c1.ability.retriggers + 1
            card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_forge_preach'), colour = G.C.SECONDARY_SET.Spectral})
        return true end}))
    end
    if c1.ability.set == 'Default' or c1.ability.set == 'Enhanced' then
        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
            ease_dollars(-(10 + (c1.ability.f_level or 0)*3))
            if pseudorandom('forge_generic_chance') < G.GAME.probabilities.normal/(c1.ability.f_level and c1.ability.f_level/3 + 1 or 1) then
                local reward = pseudorandom(pseudoseed('forge_generic'))
                c1.ability.f_level = (c1.ability.f_level or 0) + 1
                if reward >= 0.8 then
                    if c1.ability.f_x_mult ~= 0 then
                        c1.ability.f_x_mult = c1.ability.f_x_mult + 0.5
                    else
                        c1.ability.f_x_mult = 1.5
                    end
                    card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_forge_gold'), colour = G.C.GOLD})
                elseif reward >= 0.5 and reward < 0.8 then
                    c1.ability.f_mult = c1.ability.f_mult + 5
                    card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_forge_red'), colour = G.C.RED})
                elseif reward >= 0 and reward < 0.5 then
                    c1.ability.f_chips = c1.ability.f_chips + 25
                    card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_forge_blue'), colour = G.C.BLUE})
                end
            else
                c1.ability.f_level = (c1.ability.f_level or 0) - 1
                card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_forge_lose'), colour = G.C.SECONDARY_SET.Enhanced})
            end
        return true end}))
    end
end

G.FUNCS.can_seal_card_touch = function(_card)
    if _card:can_seal_card() and _card.area == G.bm_wallet and G.STATE == G.STATES.SHOP then
        return true
    else
        return false
    end
end

function Card:can_seal_card(context)
    if (G.play and #G.play.cards > 0) or (G.CONTROLLER.locked) or (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
        return false
    end
    if (G.SETTINGS.tutorial_complete or G.GAME.pseudorandom.seed ~= 'TUTORIAL' or G.GAME.round_resets.ante > 1) then
        if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
            if G.GAME.dollars - G.GAME.bankrupt_at >= 15 then
                return true
            end
        end
    end
    return false
end

G.FUNCS.seal_card = function(e)
    local c1 = e.config.ref_table
    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
        ease_dollars(-15)
        c1:set_seal(SMODS.poll_seal({guaranteed = true, type_key = 'sealing'}))
        card_eval_status_text(c1, 'extra', nil, nil, nil, {message = localize('b_seal_2'), colour = G.C.SECONDARY_SET.Voucher})
    return true end}))
end

----------------------------------------------
------------MOD CODE END----------------------