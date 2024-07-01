--- STEAMODDED HEADER
--- MOD_NAME: Cruel Blinds
--- MOD_ID: CBL
--- PREFIX: cruel
--- MOD_AUTHOR: [mathguy]
--- MOD_DESCRIPTION: Cruel Blinds
--- VERSION: 1.2.0
----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas({ key = "blinds", atlas_table = "ANIMATION_ATLAS", path = "blinds.png", px = 34, py = 34, frames = 21 })

SMODS.Atlas({ key = "broken", atlas_table = "ASSET_ATLAS", path = "broken.png", px = 71, py = 95,
inject = function(self)
    local file_path = type(self.path) == 'table' and
        (self.path[G.SETTINGS.language] or self.path['default'] or self.path['en-us']) or self.path
    if file_path == 'DEFAULT' then return end
    -- language specific sprites override fully defined sprites only if that language is set
    if self.language and not (G.SETTINGS.language == self.language) then return end
    if not self.language and self.obj_table[('%s_%s'):format(self.key, G.SETTINGS.language)] then return end
    self.full_path = (self.mod and self.mod.path or SMODS.path) ..
        'assets/' .. G.SETTINGS.GRAPHICS.texture_scaling .. 'x/' .. file_path
    local file_data = assert(NFS.newFileData(self.full_path),
        ('Failed to collect file data for Atlas %s'):format(self.key))
    self.image_data = assert(love.image.newImageData(file_data),
        ('Failed to initialize image data for Atlas %s'):format(self.key))
    self.image = love.graphics.newImage(self.image_data,
        { mipmaps = true, dpiscale = G.SETTINGS.GRAPHICS.texture_scaling })
    G[self.atlas_table][self.key_noloc or self.key] = self
    G.shared_seals['Broken'] = Sprite(0, 0, G.CARD_W, G.CARD_H, G[self.atlas_table][self.key_noloc or self.key], {x = 0,y = 0})
end
})

SMODS.Blind	{loc_txt = {
    name = 'The Mind',
    text = { 'Only one card', 'face up' }
},
key = 'mind',
config = {},
boss = {min = 2, max = 10, hardcore = true}, 
boss_colour = HEX("777777"),
atlas = "blinds",
pos = { x = 0, y = 0},
vars = {},
dollars = 5,
mult = 2, 
drawn_to_hand = function(self)
    local any_flipped = nil
    for k, v in ipairs(G.hand.cards) do
        if v.facing == 'front' then
            any_flipped = true
        end
    end
    if not any_flipped then 
        local forced_card = pseudorandom_element(G.hand.cards, pseudoseed('mind_blind'))
        forced_card:flip()
    end

end,
stay_flipped = function(self, area, card)
    if area == G.hand then
        return true
    end
end,
disable = function(self)
    for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
    end
    for k, v in pairs(G.playing_cards) do
        v.ability.wheel_flipped = nil
    end
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Jaw',
    text = { 'Drawing cards costs', '$1 each' }
},
key = 'jaw',
name = 'The Jaw',
config = {},
boss = {min = 4, max = 10, hardcore = true}, 
boss_colour = HEX("777777"),
atlas = "blinds",
pos = { x = 0, y = 1},
vars = {},
dollars = 7,
mult = 2,
}

SMODS.Blind	{loc_txt = {
    name = 'The Steal',
    text = { '#1# isn\'t a', 'poker hand' }
},
key = 'steal',
name = 'The Steal',
config = {},
boss = {min = 3, max = 10, hardcore = true}, 
boss_colour = HEX("2222BB"),
atlas = "blinds",
pos = { x = 0, y = 2},
vars = {"(most played hand)"},
dollars = 5,
mult = 2,
loc_vars = function(self)
    result = {localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands')}
    -- if G.GAME.current_round.most_played_poker_hand == "High Card" then
    --     result = {localize("Pair", 'poker_hands')}
    -- end
    return {vars = result}
end,
debuff_hand = function(self, cards, hand, handname, check)
    if (G.GAME.current_round.most_played_poker_hand == 'High Card') and (handname == "High Card") and not G.GAME.blind.disabled then
        return true
    end
    return false
end,
get_loc_debuff_text = function(self)
    return "You must play a poker hand."
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Sink',
    text = { 'No hands allowed until', 'a Flush is discarded' }
},
key = 'sink',
name = 'The Sink',
config = {},
boss = {min = 1, max = 10, hardcore = true}, 
boss_colour = HEX("CCCCFF"),
atlas = "blinds",
pos = { x = 0, y = 3},
vars = {},
dollars = 5,
mult = 2,
debuff_hand = function(self, cards, hand, handname, check)
    G.GAME.blind.triggered = true
    return true
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Day',
    text = { 'Spades and Clubs are debuffed', 'and drawn face down' }
},
key = 'day',
config = {},
boss = {min = 1, max = 10, hardcore = true}, 
boss_colour = HEX("EEEE88"),
atlas = "blinds",
pos = { x = 0, y = 4},
vars = {},
dollars = 5,
mult = 2,
stay_flipped = function(self, area, card)
    if area == G.hand and (card:is_suit("Clubs", true) or card:is_suit("Spades", true)) and not G.GAME.blind.disabled then
        return true
    end
end,
debuff_card = function(self, card, from_blind)
    if (card.area ~= G.jokers) and (card:is_suit("Clubs", true) or card:is_suit("Spades", true)) and not G.GAME.blind.disabled then
        return true
    end
    return false
end,
disable = function(self)
    for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
    end
    for k, v in pairs(G.playing_cards) do
        v.ability.wheel_flipped = nil
    end
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Night',
    text = { 'Hearts and Diamonds are debuffed', 'and drawn face down' }
},
key = 'night',
config = {},
boss = {min = 1, max = 10, hardcore = true}, 
boss_colour = HEX("8888EE"),
atlas = "blinds",
pos = { x = 0, y = 5},
vars = {},
dollars = 5,
mult = 2,
stay_flipped = function(self, area, card)
    if area == G.hand and (card:is_suit("Hearts", true) or card:is_suit("Diamonds", true)) and not G.GAME.blind.disabled then
        return true
    end
end,
debuff_card = function(self, card, from_blind)
    if (card.area ~= G.jokers) and (card:is_suit("Hearts", true) or card:is_suit("Diamonds", true)) and not G.GAME.blind.disabled then
        return true
    end
    return false
end,
disable = function(self)
    for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
    end
    for k, v in pairs(G.playing_cards) do
        v.ability.wheel_flipped = nil
    end
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Tide',
    text = { 'Start with 0 discards', '-1 Hands' }
},
key = 'tide',
config = {},
boss = {min = 2, max = 10, hardcore = true}, 
boss_colour = HEX("AAAACC"),
atlas = "blinds",
pos = { x = 0, y = 6},
vars = {},
dollars = 5,
mult = 2,
set_blind = function(self, reset, silent)
    if not reset then
        G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
        ease_discard(-G.GAME.blind.discards_sub)
        if (G.GAME.round_resets.hands > 1) then
            G.GAME.blind.hands_sub = 1
            ease_hands_played(-G.GAME.blind.hands_sub)
        end
    end
end,
disable = function(self)
    ease_discard(G.GAME.blind.discards_sub)
    ease_hands_played(G.GAME.blind.hands_sub)
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Sword',
    text = { 'Play only 1 hand.', '-1 Discards' }
},
key = 'sword',
config = {},
boss = {min = 2, max = 10, hardcore = true}, 
boss_colour = HEX("116611"),
atlas = "blinds",
pos = { x = 0, y = 7},
vars = {},
dollars = 5,
mult = 1,
set_blind = function(self, reset, silent)
    if not reset then
        G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
        ease_hands_played(-G.GAME.blind.hands_sub)
        if (G.GAME.current_round.discards_left > 0) then
            G.GAME.blind.discards_sub = 1
            ease_discard(-G.GAME.blind.discards_sub)
        end
    end
end,
disable = function(self)
    ease_discard(G.GAME.blind.discards_sub)
    ease_hands_played(G.GAME.blind.hands_sub)
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Shackle',
    text = { '-2 Hand Size' }
},
key = 'shackle',
config = {},
boss = {min = 4, max = 10, hardcore = true}, 
boss_colour = HEX("444444"),
atlas = "blinds",
pos = { x = 0, y = 8},
vars = {},
dollars = 5,
mult = 2,
defeat = function(self)
    if not G.GAME.blind.disabled then
        G.hand:change_size(2)
    end
end,
set_blind = function(self, reset, silent)
    if not reset then
        G.hand:change_size(-2)
    end
end,
disable = function(self)
    G.hand:change_size(2)
    
    G.FUNCS.draw_from_deck_to_hand(2)
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Hurdle',
    text = { '+1 Ante permanently' }
},
key = 'hurdle',
config = {},
boss = {min = 2, max = 10, hardcore = true}, 
boss_colour = HEX("EEBB22"),
atlas = "blinds",
pos = { x = 0, y = 9},
vars = {},
dollars = 5,
mult = 2,
set_blind = function(self, reset, silent)
    if not reset then
        ease_ante(1)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante+1
        G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante+1)*G.GAME.blind.mult*G.GAME.starting_params.ante_scaling
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        G.GAME.blind:set_text()
    end
end,
disable = function(self)
    ease_ante(-1)
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante-1
    G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante-1)*G.GAME.blind.mult*G.GAME.starting_params.ante_scaling
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind:set_text()
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Collapse',
    text = { '+4% blind size each hand', 'per time poker hand played' }
},
key = 'collapse',
config = {},
boss = {min = 4, max = 10, hardcore = true}, 
boss_colour = HEX("443388"),
atlas = "blinds",
pos = { x = 0, y = 10},
vars = {},
dollars = 5,
mult = 2,
disable = function(self)
    G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante)*G.GAME.blind.mult*G.GAME.starting_params.ante_scaling
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind:set_text()
end,
debuff_hand = function(self, cards, hand, handname, check)
    G.GAME.blind.triggered = false
    if not check then
        G.GAME.blind.triggered = true
        local count = G.GAME.hands[handname].played - 1
        if (count > 0) then
            G.GAME.blind.chips = math.floor(G.GAME.blind.chips * (1 + (0.04 * count)))
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.GAME.blind:set_text()
            G.hand_text_area.blind_chips:juice_up()
        end
    end
end
}

SMODS.Blind	{loc_txt = {
    name = 'The Reach',
    text = { 'Disperse half of levels of played', 'poker hand amongst other poker hands' }
},
key = 'reach',
config = {},
boss = {min = 4, max = 10, hardcore = true}, 
boss_colour = HEX("881188"),
atlas = "blinds",
pos = { x = 0, y = 11},
vars = {},
dollars = 5,
mult = 2,
debuff_hand = function(self, cards, hand, handname, check)
    G.GAME.blind.triggered = false
    if not check then
        local count = math.min(G.GAME.hands[handname].level - 1, math.floor(G.GAME.hands[handname].level / 2))
        if (count > 0) then
            if not check then
                G.GAME.blind.triggered = true
                level_up_hand(G.GAME.blind.children.animatedSprite, handname, nil, -count)
                G.GAME.blind:wiggle()
                local disperse_table = {}
                local options = {}
                for i, j in pairs(G.GAME.hands) do
                    if j.visible and (i ~= handname) then
                        disperse_table[i] = 0
                        table.insert(options, i)
                    end
                end
                local all = math.floor(count / #options)
                for i2, j2 in ipairs(options) do
                    disperse_table[j2] = disperse_table[j2] + all
                end
                for i = 1, (count - (all * #options)) do
                    local choice = pseudorandom_element(options, pseudoseed('reach'))
                    disperse_table[choice] = disperse_table[choice] + 1
                    for i2, j2 in ipairs(options) do
                        if j2 == choice then
                            table.remove(options, i2)
                            break
                        end
                    end
                end
                for i, j in pairs(disperse_table) do
                    if (j ~= 0) then
                        level_up_hand(G.GAME.blind.children.animatedSprite, i, true, j)
                        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(i, 'poker_hands'),chips = G.GAME.hands[i].chips, mult = G.GAME.hands[i].mult, level=G.GAME.hands[i].level})
                        delay(0.35)
                        G.GAME.blind:wiggle()
                    end
                end
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(handname, 'poker_hands'),chips = G.GAME.hands[handname].chips, mult = G.GAME.hands[handname].mult, level=G.GAME.hands[handname].level})
            end
        end
    end
end
}

SMODS.Blind	{loc_txt = {
    name = 'Daring Group',
    text = { '#1#, #2#,', 'and #3#' }
},
key = 'daring',
name = "Daring Group",
config = {},
boss = {showdown = true, min = 10, max = 10, hardcore = true}, 
showdown = true,
boss_colour = HEX("730000"),
atlas = "blinds",
pos = { x = 0, y = 12},
vars = {"???", "???", "???"},
dollars = 8,
mult = 2,
loc_vars = function(self)
    if G.GAME.blind.config.blinds and G.GAME.blind.config.blinds[1] then
        keyTable = {}
        keyTable['Amber Acorn'] = "bl_final_acorn"
        keyTable['Cerulean Bell'] = "bl_final_bell"
        keyTable['Crimson Heart'] = "bl_final_heart"
        keyTable['Verdant Leaf'] = "bl_final_leaf"
        keyTable['Violet Vessel'] = "bl_final_vessel"
        return {vars = {localize{type ='name_text', key = keyTable[G.GAME.blind.config.blinds[1]] or '', set = 'Blind'},
                    localize{type ='name_text', key = keyTable[G.GAME.blind.config.blinds[2]] or '', set = 'Blind'},
                    localize{type ='name_text', key = keyTable[G.GAME.blind.config.blinds[3]] or '', set = 'Blind'} }}
    else
        return {vars = {"???", "???", "???"}}
    end
end,
set_blind = function(self, reset, silent)
    if not reset then
        G.GAME.blind.config.blinds = {}
        G.GAME.blind.config.joker_sold = false
    end
    if not reset then
        if G.GAME.blind.config.blinds[1] == 'Amber Acorn' or G.GAME.blind.config.blinds[2] == 'Amber Acorn' or G.GAME.blind.config.blinds[3] == 'Amber Acorn' then
            G.jokers:unhighlight_all()
            for k, v in ipairs(G.jokers.cards) do
                v:flip()
            end
            if #G.jokers.cards > 1 then 
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end })) 
                    delay(0.5)
                return true end })) 
            end
        end
    end
end,
drawn_to_hand = function(self)
    local orig = nil
    if #G.GAME.blind.config.blinds ~= 0 then
        orig = G.GAME.blind.config.blinds
    end
    local indexes = {}
    indexes['Amber Acorn'] = 1
    indexes['Cerulean Bell'] = 2
    indexes['Crimson Heart'] = 3
    indexes['Verdant Leaf'] = 4
    indexes['Violet Vessel'] = 5
    local options = {'Amber Acorn', 'Cerulean Bell', 'Crimson Heart', 'Verdant Leaf', 'Violet Vessel'}
    G.GAME.blind.config.blinds = {}
    local blind1 = pseudorandom_element(options, pseudoseed('daring'))
    table.insert(G.GAME.blind.config.blinds, blind1)
    table.remove(options, indexes[blind1])
    indexes = {}
    for i, j in pairs(options) do
        indexes[j] = i
    end
    local blind2 = pseudorandom_element(options, pseudoseed('daring'))
    table.insert(G.GAME.blind.config.blinds, blind2)
    table.remove(options, indexes[blind2])
    indexes = {}
    for i, j in pairs(options) do
        indexes[j] = i
    end
    local blind3 = pseudorandom_element(options, pseudoseed('daring'))
    table.insert(G.GAME.blind.config.blinds, blind3)
    local origs = {}
    local stays = {}
    local news = {}
    if (orig == nil) then
        news = {blind1, blind2, blind3}
    else
        if (orig[1] ~= blind1) and (orig[1] ~= blind2) and (orig[1] ~= blind3) then
            table.insert(origs, orig[1])
        end
        if (orig[1] == blind1) or (orig[1] == blind2) or (orig[1] == blind3) then
            table.insert(stays, orig[1])
        end
        if (orig[2] ~= blind1) and (orig[2] ~= blind2) and (orig[2] ~= blind3) then
            table.insert(origs, orig[2])
        end
        if (orig[2] == blind1) or (orig[2] == blind2) or (orig[2] == blind3) then
            table.insert(stays, orig[2])
        end
        if (orig[3] ~= blind1) and (orig[3] ~= blind2) and (orig[3] ~= blind3) then
            table.insert(origs, orig[3])
        end
        if (orig[3] == blind1) or (orig[3] == blind2) or (orig[3] == blind3) then
            table.insert(stays, orig[3])
        end
        if (orig[1] ~= blind1) and (orig[2] ~= blind1) and (orig[3] ~= blind1) then
            table.insert(news, blind1)
        end
        if (orig[1] ~= blind2) and (orig[2] ~= blind2) and (orig[3] ~= blind2) then
            table.insert(news, blind2)
        end
        if (orig[1] ~= blind3) and (orig[2] ~= blind3) and (orig[3] ~= blind3) then
            table.insert(news, blind3)
        end
    end
    for i, j in ipairs(stays) do
        if j == 'Cerulean Bell' then
            local any_forced = nil
            for k, v in ipairs(G.hand.cards) do
                if v.ability.forced_selection then
                    any_forced = true
                end
            end
            if not any_forced then 
                G.hand:unhighlight_all()
                local forced_card = pseudorandom_element(G.hand.cards, pseudoseed('cerulean_bell'))
                forced_card.ability.forced_selection = true
                G.hand:add_to_highlighted(forced_card)
            end
        elseif j == 'Crimson Heart' and G.GAME.blind.prepped and G.jokers.cards[1] then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then jokers[#jokers+1] =G.jokers.cards[i] end
                G.jokers.cards[i]:set_debuff(false)
            end 
            local _card = pseudorandom_element(jokers, pseudoseed('crimson_heart'))
            if _card then
                _card:set_debuff(true)
                _card:juice_up()
                G.GAME.blind:wiggle()
            end
        end
    end
    for i, j in ipairs(origs) do
        if (j == 'Cerulean Bell') then
            for k, v in ipairs(G.playing_cards) do
                v.ability.forced_selection = nil
            end
        elseif (j == 'Crimson Heart') and G.jokers.cards[1] then
            for _, v in ipairs(G.jokers.cards) do
                G.GAME.blind:debuff_card(v)
            end
        elseif (j == 'Amber Acorn') and G.jokers.cards[1] then
            G.jokers:unhighlight_all()
            for k, v in ipairs(G.jokers.cards) do
                v:flip()
            end
        elseif (j == 'Verdant Leaf') then
            for _, v in ipairs(G.playing_cards) do
                G.GAME.blind:debuff_card(v)
            end
        elseif (j == "Violet Vessel") then
            G.GAME.blind.chips = G.GAME.chips + math.floor((G.GAME.blind.chips - G.GAME.chips)/3)
            if (G.GAME.blind.chips == G.GAME.chips) then
                G.GAME.blind.chips = G.GAME.blind.chips + 1
            end
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end
    for i, j in ipairs(news) do
        if (j == 'Cerulean Bell') then
            local any_forced = nil
            for k, v in ipairs(G.hand.cards) do
                if v.ability.forced_selection then
                    any_forced = true
                end
            end
            if not any_forced then 
                G.hand:unhighlight_all()
                local forced_card = pseudorandom_element(G.hand.cards, pseudoseed('cerulean_bell'))
                forced_card.ability.forced_selection = true
                G.hand:add_to_highlighted(forced_card)
            end
        elseif (j == 'Crimson Heart') and G.jokers.cards[1] then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then jokers[#jokers+1] =G.jokers.cards[i] end
                G.jokers.cards[i]:set_debuff(false)
            end 
            local _card = pseudorandom_element(jokers, pseudoseed('crimson_heart'))
            if _card then
                _card:set_debuff(true)
                _card:juice_up()
                G.GAME.blind:wiggle()
            end
        elseif (j == 'Amber Acorn') and G.jokers.cards[1] then
            G.jokers:unhighlight_all()
            for k, v in ipairs(G.jokers.cards) do
                v:flip()
            end
            if #G.jokers.cards > 1 then 
                G.E_MANAGER:add_event(Event({ trigger = 'after', delay = 0.2, func = function() 
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 0.85);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1.15);return true end })) 
                    delay(0.15)
                    G.E_MANAGER:add_event(Event({ func = function() G.jokers:shuffle('aajk'); play_sound('cardSlide1', 1);return true end })) 
                    delay(0.5)
                return true end })) 
            end
        elseif (j == 'Verdant Leaf') then
            for _, v in ipairs(G.playing_cards) do
                G.GAME.blind:debuff_card(v)
            end
        elseif (j == "Violet Vessel") then
            G.GAME.blind.chips = G.GAME.chips + ((G.GAME.blind.chips - G.GAME.chips)*3)
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.GAME.blind:set_text()
        end
    end
    G.GAME.blind:set_text()
end,
debuff_card = function(self, card, from_blind)
    if ((G.GAME.blind.config.blinds[1] == 'Crimson Heart') or (G.GAME.blind.config.blinds[2] == 'Crimson Heart') or (G.GAME.blind.config.blinds[3] == 'Crimson Heart')) and not G.GAME.blind.disabled and card.area == G.jokers then 
        return false
    end
    if ((G.GAME.blind.config.blinds[1] == 'Verdant Leaf') or (G.GAME.blind.config.blinds[2] == 'Verdant Leaf') or (G.GAME.blind.config.blinds[3] == 'Verdant Leaf')) and (G.GAME.blind.config.joker_sold ~= true) and not G.GAME.blind.disabled and card.area ~= G.jokers then 
        return true
    end
    return false
end,
press_play = function(self)
    if G.jokers.cards[1] and not G.GAME.blind.disabled then
        G.GAME.blind.triggered = true
        G.GAME.blind.prepped = true
    end
end,
disable = function(self)
    if (G.GAME.blind.config.blinds[1] == 'Cerulean Bell') or (G.GAME.blind.config.blinds[2] == 'Cerulean Bell') or (G.GAME.blind.config.blinds[3] == 'Cerulean Bell') then
        for k, v in ipairs(G.playing_cards) do
            v.ability.forced_selection = nil
        end
    end
    G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante)*G.GAME.blind.mult*G.GAME.starting_params.ante_scaling
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind:set_text()
end
}

SMODS.Blind	{loc_txt = {
    name = 'Common Muck',
    text = { 'Debuff jokers which', 'are rare or better' }
},
key = 'muck',
config = {},
boss = {showdown = true, min = 10, max = 10, hardcore = true}, 
showdown = true,
boss_colour = HEX("CCCC22"),
atlas = "blinds",
pos = { x = 0, y = 13},
vars = {},
dollars = 8,
mult = 2,
debuff_card = function(self, card, from_blind)
    if (card.area == G.jokers) and not G.GAME.blind.disabled and not ((card.config.center.rarity == 1) or (card.config.center.rarity == 2)) then
        return true
    end
    return false
end
}

SMODS.Atlas({ key = "overshoot_blind", atlas_table = "ANIMATION_ATLAS", path = "overshoot.png", px = 34, py = 34, frames = 21 })

SMODS.Blind	{loc_txt = {
    name = 'Obscure Overshoot',
    text = { 'Raise blind size by 8%', 'for every 5% overscored' }
},
key = 'overshoot',
name = 'Obscure Overshoot',
config = {},
boss = {showdown = true, min = 10, max = 10, hardcore = true},
showdown = true,
boss_colour = HEX("CCCCCC"),
atlas = "overshoot_blind",
pos = { x = 0, y = 0},
vars = {},
dollars = 8,
mult = 1,
disable = function(self)
    G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante)*G.GAME.blind.mult*G.GAME.starting_params.ante_scaling
    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    G.GAME.blind:set_text()
end,
}

SMODS.Atlas({ key = "mist_blind", atlas_table = "ANIMATION_ATLAS", path = "mist.png", px = 34, py = 34, frames = 21 })

SMODS.Blind	{loc_txt = {
    name = 'The Mist',
    text = { '#1# in #2# cards are', 'drawn clouded' }
},
key = 'mist',
name = 'The Mist',
config = {},
boss = {min = 2, max = 10, hardcore = true},
boss_colour = HEX("88DDFF"),
atlas = "mist_blind",
pos = { x = 0, y = 0},
vars = {3, 4},
dollars = 5,
mult = 2,
drawn_to_hand = function(self, reset, silent)
    for k, v in ipairs(G.hand.cards) do
        if v.facing == 'back' then
            v.ability.confused = true
        end
    end
end,
stay_flipped = function(self, area, card)
    if (area == G.hand) and (pseudorandom(pseudoseed('lens')) < (3*G.GAME.probabilities.normal/4)) then
        return true
    end
    if (area == G.play) and card.ability.confused then
        return true
    end
    return false
end,
defeat = function(self)
    for k, v in ipairs(G.playing_cards) do
        v.ability.confused = false
    end
end,
loc_vars = function(self)
    return {vars = {3*G.GAME.probabilities.normal, 4}}
end,
press_play = function(self)
    for k, v in ipairs(G.play.cards) do
        if v.facing == 'back' then
            G.GAME.blind.show_confused = true
        end
    end
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        for k, v in ipairs(G.play.cards) do
            if v.facing == 'back' then
                G.GAME.blind.show_confused = true
                break
            end
        end
        return true end })) 
end,
disable = function(self)
    for k, v in ipairs(G.playing_cards) do
        v.ability.confused = false
    end
    for i = 1, #G.hand.cards do
        if G.hand.cards[i].facing == 'back' then
            G.hand.cards[i]:flip()
        end
    end
    for k, v in pairs(G.playing_cards) do
        v.ability.wheel_flipped = nil
    end
end,
}

SMODS.Atlas({ key = "puzzle_blind", atlas_table = "ANIMATION_ATLAS", path = "puzzle.png", px = 34, py = 34, frames = 21 })

SMODS.Blind	{loc_txt = {
    name = 'The Puzzle',
    text = { '#1# in #2# cards are', ' drawn permanenty puzzled' }
},
key = 'puzzle',
name = "The Puzzle",
config = {},
boss = {min = 1, max = 10, hardcore = true}, 
boss_colour = HEX("4444EE"),
atlas = "puzzle_blind",
pos = { x = 0, y = 0},
vars = {1, 3},
dollars = 5,
mult = 2,
stay_flipped = function(self, area, card)
    if (area == G.hand) and (pseudorandom(pseudoseed('puzzle')) < (G.GAME.probabilities.normal/3)) then
        card.ability.puzzled = true
    end
    return false
end,
loc_vars = function(self)
    return {vars = {G.GAME.probabilities.normal, 3}}
end,
}

SMODS.Atlas({ key = "fire_blind", atlas_table = "ANIMATION_ATLAS", path = "fire.png", px = 34, py = 34, frames = 21 })

SMODS.Blind	{loc_txt = {
    name = 'The Fire',
    text = { '0 base Chips and', '1 base Mult' }
},
key = 'fire',
name = "The Fire",
config = {},
boss = {min = 4, max = 10, hardcore = true}, 
boss_colour = HEX("FFA869"),
atlas = "fire_blind",
pos = { x = 0, y = 0},
vars = {},
dollars = 5,
mult = 2,
modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
    if (mult ~= 1) or (hand_chips ~= 0) then
        return 1, 0, true
    end
    return 1, 0, false
end
}

function create_UIBox_blind_choice(type, run_info)
    if not G.GAME.blind_on_deck then
        G.GAME.blind_on_deck = 'Small'
    end
    if not run_info then G.GAME.round_resets.blind_states[G.GAME.blind_on_deck] = 'Select' end

    local disabled = false
    type = type or 'Small'

    local blind_choice = {
        config = G.P_BLINDS[G.GAME.round_resets.blind_choices[type]],
    }

    local blind_atlas = 'blind_chips'
    if blind_choice.config and blind_choice.config.atlas then
        blind_atlas = blind_choice.config.atlas
    end
    blind_choice.animation = AnimatedSprite(0, 0, 1.4, 1.4, G.ANIMATION_ATLAS[blind_atlas], blind_choice.config.pos)
    blind_choice.animation:define_draw_steps({
        { shader = 'dissolve', shadow_height = 0.05 },
        { shader = 'dissolve' }
    })
    local extras = nil
    local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)

    G.GAME.orbital_choices = G.GAME.orbital_choices or {}
    G.GAME.orbital_choices[G.GAME.round_resets.ante] = G.GAME.orbital_choices[G.GAME.round_resets.ante] or {}

    if not G.GAME.orbital_choices[G.GAME.round_resets.ante][type] then
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then _poker_hands[#_poker_hands + 1] = k end
        end

        G.GAME.orbital_choices[G.GAME.round_resets.ante][type] = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
    end



    if type == 'Small' then
        extras = create_UIBox_blind_tag(type, run_info)
    elseif type == 'Big' then
        extras = create_UIBox_blind_tag(type, run_info)
    elseif not run_info then
        local dt1 = DynaText({ string = { { string = localize('ph_up_ante_1'), colour = G.C.FILTER } }, colours = { G.C.BLACK }, scale = 0.55, silent = true, pop_delay = 4.5, shadow = true, bump = true, maxw = 3 })
        local dt2 = DynaText({ string = { { string = localize('ph_up_ante_2'), colour = G.C.WHITE } }, colours = { G.C.CHANCE }, scale = 0.35, silent = true, pop_delay = 4.5, shadow = true, maxw = 3 })
        local dt3 = DynaText({ string = { { string = localize('ph_up_ante_3'), colour = G.C.WHITE } }, colours = { G.C.CHANCE }, scale = 0.35, silent = true, pop_delay = 4.5, shadow = true, maxw = 3 })
        extras =
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.R,
                    config = { align = "cm", padding = 0.07, r = 0.1, colour = { 0, 0, 0, 0.12 }, minw = 2.9 },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = "cm" },
                            nodes = {
                                { n = G.UIT.O, config = { object = dt1 } },
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm" },
                            nodes = {
                                { n = G.UIT.O, config = { object = dt2 } },
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm" },
                            nodes = {
                                { n = G.UIT.O, config = { object = dt3 } },
                            }
                        },
                    }
                },
            }
        }
    end
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    local loc_target = localize { type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') } }
    local loc_name = localize { type = 'name_text', key = blind_choice.config.key, set = 'Blind' }
    if loc_name == "Daring Group" then
        loc_target = localize { type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = { "???", "???", "???" } }
    end
    -- if loc_name == "The Steal" and (G.GAME.current_round.most_played_poker_hand == 'High Card') then
    --     loc_target = localize { type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = { localize("Pair", 'poker_hands') } }
    -- end
    if loc_name == "The Mist"then
        loc_target = localize { type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = { 3*G.GAME.probabilities.normal, 4 } }
    end
    if loc_name == "The Puzzle" then
        loc_target = localize { type = 'raw_descriptions', key = blind_choice.config.key, set = 'Blind', vars = { G.GAME.probabilities.normal, 3 } }
    end
    local text_table = loc_target
    local blind_col = get_blind_main_colour(type)
    local blind_amt = get_blind_amount(G.GAME.round_resets.blind_ante) * blind_choice.config.mult *
        G.GAME.starting_params.ante_scaling

    local blind_state = G.GAME.round_resets.blind_states[type]
    local _reward = true
    if G.GAME.modifiers.no_blind_reward and G.GAME.modifiers.no_blind_reward[type] then _reward = nil end
    if blind_state == 'Select' then blind_state = 'Current' end
    local run_info_colour = run_info and
        (blind_state == 'Defeated' and G.C.GREY or blind_state == 'Skipped' and G.C.BLUE or blind_state == 'Upcoming' and G.C.ORANGE or blind_state == 'Current' and G.C.RED or G.C.GOLD)
    local t =
    {
        n = G.UIT.R,
        config = { id = type, align = "tm", func = 'blind_choice_handler', minh = not run_info and 10 or nil, ref_table = { deck = nil, run_info = run_info }, r = 0.1, padding = 0.05 },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm", colour = mix_colours(G.C.BLACK, G.C.L_BLACK, 0.5), r = 0.1, outline = 1, outline_colour = G.C.L_BLACK },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.2 },
                        nodes = {
                            not run_info and
                            {
                                n = G.UIT.R,
                                config = { id = 'select_blind_button', align = "cm", ref_table = blind_choice.config, colour = disabled and G.C.UI.BACKGROUND_INACTIVE or G.C.ORANGE, minh = 0.6, minw = 2.7, padding = 0.07, r = 0.1, shadow = true, hover = true, one_press = true, button = 'select_blind' },
                                nodes = {
                                    { n = G.UIT.T, config = { ref_table = G.GAME.round_resets.loc_blind_states, ref_value = type, scale = 0.45, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.UI.TEXT_LIGHT, shadow = not disabled } }
                                }
                            } or
                            {
                                n = G.UIT.R,
                                config = { id = 'select_blind_button', align = "cm", ref_table = blind_choice.config, colour = run_info_colour, minh = 0.6, minw = 2.7, padding = 0.07, r = 0.1, emboss = 0.08 },
                                nodes = {
                                    { n = G.UIT.T, config = { text = localize(blind_state, 'blind_states'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true } }
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { id = 'blind_name', align = "cm", padding = 0.07 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", r = 0.1, outline = 1, outline_colour = blind_col, colour = darken(blind_col, 0.3), minw = 2.9, emboss = 0.1, padding = 0.07, line_emboss = 1 },
                                nodes = {
                                    { n = G.UIT.O, config = { object = DynaText({ string = loc_name, colours = { disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE }, shadow = not disabled, float = not disabled, y_offset = -4, scale = 0.45, maxw = 2.8 }) } },
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = { align = "cm", padding = 0.05 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { id = 'blind_desc', align = "cm", padding = 0.05 },
                                nodes = {
                                    {
                                        n = G.UIT.R,
                                        config = { align = "cm" },
                                        nodes = {
                                            {
                                                n = G.UIT.R,
                                                config = { align = "cm", minh = 1.5 },
                                                nodes = {
                                                    { n = G.UIT.O, config = { object = blind_choice.animation } },
                                                }
                                            },
                                            text_table[1] and
                                            {
                                                n = G.UIT.R,
                                                config = { align = "cm", minh = 0.7, padding = 0.05, minw = 2.9 },
                                                nodes = {
                                                    text_table[1] and {
                                                        n = G.UIT.R,
                                                        config = { align = "cm", maxw = 2.8 },
                                                        nodes = {
                                                            { n = G.UIT.T, config = { id = blind_choice.config.key, ref_table = { val = '' }, ref_value = 'val', scale = 0.32, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled, func = 'HUD_blind_debuff_prefix' } },
                                                            { n = G.UIT.T, config = { text = text_table[1] or '-', scale = 0.32, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled } }
                                                        }
                                                    } or nil,
                                                    text_table[2] and {
                                                        n = G.UIT.R,
                                                        config = { align = "cm", maxw = 2.8 },
                                                        nodes = {
                                                            { n = G.UIT.T, config = { text = text_table[2] or '-', scale = 0.32, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled } }
                                                        }
                                                    } or nil,
                                                }
                                            } or nil,
                                        }
                                    },
                                    {
                                        n = G.UIT.R,
                                        config = { align = "cm", r = 0.1, padding = 0.05, minw = 3.1, colour = G.C.BLACK, emboss = 0.05 },
                                        nodes = {
                                            {
                                                n = G.UIT.R,
                                                config = { align = "cm", maxw = 3 },
                                                nodes = {
                                                    { n = G.UIT.T, config = { text = localize('ph_blind_score_at_least'), scale = 0.3, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled } }
                                                }
                                            },
                                            {
                                                n = G.UIT.R,
                                                config = { align = "cm", minh = 0.6 },
                                                nodes = {
                                                    { n = G.UIT.O, config = { w = 0.5, h = 0.5, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false } },
                                                    { n = G.UIT.B, config = { h = 0.1, w = 0.1 } },
                                                    { n = G.UIT.T, config = { text = number_format(blind_amt), scale = score_number_scale(0.9, blind_amt), colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.RED, shadow = not disabled } }
                                                }
                                            },
                                            _reward and {
                                                n = G.UIT.R,
                                                config = { align = "cm" },
                                                nodes = {
                                                    { n = G.UIT.T, config = { text = localize('ph_blind_reward'), scale = 0.35, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.WHITE, shadow = not disabled } },
                                                    { n = G.UIT.T, config = { text = string.rep(localize("$"), blind_choice.config.dollars) .. '+', scale = 0.35, colour = disabled and G.C.UI.TEXT_INACTIVE or G.C.MONEY, shadow = not disabled } }
                                                }
                                            } or nil,
                                        }
                                    },
                                }
                            },
                        }
                    },
                }
            },
            {
                n = G.UIT.R,
                config = { id = 'blind_extras', align = "cm" },
                nodes = {
                    extras,
                }
            }

        }
    }
    return t
end

local old_get_poker_hand_info = G.FUNCS.get_poker_hand_info
function G.FUNCS.get_poker_hand_info(_cards)
	local text, loc_disp_text, poker_hands, scoring_hand, disp_text = old_get_poker_hand_info(_cards)
    if (text =='High Card') and G.GAME.blind and (G.GAME.blind.name == "The Steal") and not G.GAME.blind.disabled and (G.GAME.current_round.most_played_poker_hand == "High Card") then
        disp_text = 'No Hand'
        loc_disp_text = localize(disp_text, 'poker_hands')
    end
	return text, loc_disp_text, poker_hands, scoring_hand, disp_text
end

function SMODS.current_mod.process_loc_text()
    G.localization.misc.challenge_names["c_very_cruel"] = "Very Cruel"
    G.localization.misc.challenge_names["c_very_crueler"] = "Cruely Cruel"
    G.localization.misc.v_text.ch_c_cruel_blinds = {"All blinds past ante {C:attention}1{} are {C:attention}cruel blinds{}."}
    G.localization.descriptions.Other.puzzled = {name = "Puzzled", text = {"Randomize rank and suit", "each hand played."}}
    G.localization.misc.labels.puzzled = "Puzzled"
    G.localization.misc.poker_hands["No Hand"] = "No Hand"
end

table.insert(G.CHALLENGES,#G.CHALLENGES+1,
    {name = 'Very Cruel',
        id = 'c_very_cruel',
        rules = {
            custom = {
                {id = 'cruel_blinds'}
            },
            modifiers = {
            }
        },
        jokers = {       
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            type = 'Challenge Deck',
        },
        restrictions = {
            banned_cards = {
                {id = 'j_chicot'},
                {id = 'j_luchador'},
                {id = 'v_directors_cut'},
            },
            banned_tags = {
                {id = 'tag_boss'}
            },
            banned_other = {
            }
        }
    }
)

table.insert(G.CHALLENGES,#G.CHALLENGES+1,
    {name = 'Cruely Cruel',
        id = 'c_very_crueler',
        rules = {
            custom = {
                {id = 'cruel_blinds'},
                {id = 'no_reward_specific', value = 'Small'},
                {id = 'no_reward_specific', value = 'Big'}
            },
            modifiers = {
                {id = 'joker_slots', value = 3}
            }
        },
        jokers = {       
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            type = 'Challenge Deck',
        },
        restrictions = {
            banned_cards = {
                {id = 'j_chicot'},
                {id = 'j_luchador'},
                {id = 'v_directors_cut'},
            },
            banned_tags = {
                {id = 'tag_boss'}
            },
            banned_other = {
            }
        }
    }
)


----------------------------------------------
------------MOD CODE END----------------------
