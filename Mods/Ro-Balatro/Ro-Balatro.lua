--- STEAMODDED HEADER

--- MOD_NAME: Ro-Balatro
--- MOD_ID: robalatro
--- MOD_AUTHOR: [AlexZGreat]
--- MOD_DESCRIPTION: A fusion between Balatro and Roblox
--- PRIORITY: -100
--- BADGE_COLOR: ff0000
--- PREFIX: robl
--- VERSION: 1.2.1
--- LOADER_VERSION_GEQ: 1.0.0

SMODS.Sound {
    key = 'SwordSwing',
    path = 'SwordSwing.mp3'
}
SMODS.Sound {
    key = 'SwordLunge',
    path = 'SwordLunge.mp3'
}
SMODS.Sound {
    key = 'RobloxBass',
    path = 'RobloxBass.ogg'
}
SMODS.Sound {
    key = 'BloxyCola',
    path = 'BloxyCola.mp3'
}
SMODS.Sound {
    key = 'RobloxButton',
    path = 'RobloxButton.mp3'
}
SMODS.Sound {
    key = 'RobloxGravityCoil',
    path = 'RobloxGravityCoil.mp3'
}
SMODS.Sound {
    key = 'RobloxSpeedCoil',
    path = 'RobloxSpeedCoil.mp3'
}
SMODS.Sound {
    key = 'RobloxRocketShot',
    path = 'RobloxRocketShot.ogg'
}
SMODS.Sound {
    key = 'RobloxSlingshot',
    path = 'RobloxSlingshot.ogg'
}
SMODS.Sound {
    key = 'RobloxSuperball',
    path = 'RobloxSuperball.ogg'
}
SMODS.Sound {
    key = 'RainingTacos',
    path = 'RainingTacos.wav'
}
SMODS.Sound {
    key = 'PaintballGun',
    path = 'PaintballGun.ogg'
}
SMODS.Sound {
    key = 'ZombieGroan',
    path = 'ZombieGroan.wav'
}
SMODS.Sound {
    key = 'RobloxBanHammer',
    path = 'RobloxBanHammer.mp3'
}

SMODS.Atlas{
    key = "modicon",
    path = "robalatro_modicon.png",
    px = 34,
    py = 34,
}

SMODS.Atlas {  
    key = 'jokeratlas',
    px = 71,
    py = 95,
    path = 'robalatro-jokers.png'
}

SMODS.Atlas {  
    key = 'gearatlas',
    px = 70,
    py = 95,
    path = 'robalatro-gears.png'
}

SMODS.ConsumableType { --Gear Consumable Type
    key = 'Gear',
    collection_rows = { 4,3 },
    primary_colour = G.C.CHIPS,
    secondary_colour = G.C.MONEY,
    loc_txt = {
        collection = 'Gear Cards',
        name = 'Gear',
        label = 'Gear'
    },
    shop_rate = 3,
    default = 'c_robl_sword'
}

SMODS.Joker {  --Noob
    key = 'noob',
    loc_txt = {
        name = 'Noob',
        text = {'+#1# {C:attention}Consumable Slot{}'}
    },
    config = {extra = {slots = 1}},
    rarity = 1,
    pos = {x = 0,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    loc_vars = function(self,info_queue,card)
        return {vars = {card.ability.extra.slots}}
    end,
    add_to_deck = function(self,card,from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
    end,
    remove_from_deck = function(self,card,from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
    end
}

SMODS.Joker { --Glass Houses
    key = 'glasshouses',
    loc_txt = {
        name = 'Glass Houses',
        text = { 'Scored {C:attention}Glass Cards{} have a',
        '{C:green}#1# in 4{} chance to be',
        '{C:attention}copied{} and drawn to hand'}
    },
    config = {},
    rarity = 2, 
    pos = {x = 2,y = 0}, 
    atlas = 'jokeratlas', 
    cost = 5,
    unlocked = true, 
    discovered = true,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.individual and context.cardarea == G.play then
            if context.other_card.ability.effect == "Glass Card" then
                if pseudorandom('glass houses') < G.GAME.probabilities.normal/4 then
                    local _card = copy_card(context.other_card, nil, nil, context.other_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card.states.visible = nil
                    
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card:start_materialize()
                            card:juice_up(0.3, 0.4)
                            return true
                        end
                    }))
                end
            end
        end
    end,

    loc_vars = function(self,info_queue,center)
        return {vars = {G.GAME.probabilities.normal}}
    end
}

SMODS.Joker { --1x1x1x1
    key = '1x1x1x1',
    loc_txt = {
        name = '1x1x1x1',
        text = { '{C:mult}+#1#{} Mult if played',
        'hand has {C:attention}4{} scoring {C:attention}Aces{}'}
    },
    config = {extra = {mult = 40}},
    rarity = 2, 
    pos = {x = 1,y = 0}, 
    atlas = 'jokeratlas', 
    cost = 5,
    unlocked = true, 
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult}}
    end,
    calculate = function(self,card,context)
        local acecount = 0
        if context.joker_main then
            if (next(context.poker_hands['Four of a Kind']) or next(context.poker_hands['Five of a Kind']) or next(context.poker_hands['Flush Five'])) then
                acecount = 0
                for i, v in pairs (context.full_hand) do
                    if v:get_id() == 14 then
                        acecount = acecount+1
                    end
                end
                if acecount >= 4 then
                    return {
                        message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                        mult_mod = card.ability.extra.mult
                    }
                end
            end
        end
    end
}

SMODS.Joker { --Banland
    key = 'banland',
    loc_txt = {
        name = 'Banland',
        text = {'When sold, {C:attention}destroy{} every {C:attention}consumable{}',
        'in your consumable area',
        'Gain {C:money}$#1#{} per consumable destroyed',
        '{C:inactive}Will give {C:money}$#2#'}
    },
    config = {extra = {dollars = 7, willgive = 0}},
    rarity = 1,
    pos = {x = 6,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.dollars, card.ability.extra.willgive}}
    end,
    calculate = function(self,card,context)
        if context.selling_self then
            local amount = 0
            for i, v in pairs (G.consumeables.cards) do
                v.getting_sliced = true
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.consumeable_buffer = 0
                    card:juice_up(0.8, 0.8)
                    v:start_dissolve(G.C.money, nil, 1.6)
                    play_sound('generic1', 0.96+math.random()*0.08)
                return true end }))
                amount = amount + 1
                delay(0.5)
            end
            if amount > 0 then
                G.E_MANAGER:add_event(Event({func = function()
                    ease_dollars(card.ability.extra.dollars*amount)
                return true end }))
            end
        end
    end,
    update = function(self,card,dt)
        card.ability.extra.willgive = 0
        if G.STAGE == G.STAGES.RUN then
            local amount = 0
            for i, v in pairs (G.consumeables.cards) do
                amount = amount + 1
            end
            card.ability.extra.willgive = card.ability.extra.dollars * amount
        end
    end
}

SMODS.Joker { --Egg Hunt
    key = 'egghunt',
    loc_txt = {
        name = 'Egg Hunt',
        text = {'{C:mult}+#1#{} Mult if full deck',
        'contains {C:attention}52 unique cards{}',
        '{C:inactive}[#2#]'}
    },
    config = {extra = {mult = 15, active = 'Inactive'}},
    rarity = 1,
    pos = {x = 3,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.mult,card.ability.extra.active}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            if card.ability.extra.active == 'Active' then
                return {
                    message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                    mult_mod = card.ability.extra.mult
                }
            end
        end
    end,
    update = function(self,card,dt)
        card.ability.extra.active = 'Inactive'
        if G.STAGE == G.STAGES.RUN then
            local uniquecards = {}
            for i, v in pairs (G.playing_cards) do
                local isunique = true
                for k, a in pairs (uniquecards) do
                    if a then
                        if v.base.value == a.base.value and v.base.suit == a.base.suit then
                            isunique = false
                        end
                    end
                end
                if isunique then
                    uniquecards[i] = v
                end
            end
            if #uniquecards >= 52 then
                card.ability.extra.active = 'Active'
            end
        end
    end
}

SMODS.Joker { --SFoTH
    key = 'sfoth',
    loc_txt = {
        name = 'SFoTH',
        text = {'When {C:attention}blind selected{}, {C:attention}destroy{}',
        'every {C:money}Gear{} in your consumable',
        'area and replace with a',
        '{C:dark_edition}Negative{} {C:purple}Spectral{} card'}
    },
    config = {extra = {spectrals = 1}},
    rarity = 3,
    pos = {x = 4,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    calculate = function(self,card,context)
        if context.setting_blind and not card.getting_sliced then
            local amount = 0
            for i, v in pairs (G.consumeables.cards) do
                if v.ability.set == 'Gear' then
                    v.getting_sliced = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                    G.E_MANAGER:add_event(Event({func = function()
                        G.GAME.consumeable_buffer = 0
                        card:juice_up(0.8, 0.8)
                        v:start_dissolve(G.C.money, nil, 1.6)
                        play_sound('generic1', 0.96+math.random()*0.08)
                    return true end }))
                    amount = amount + card.ability.extra.spectrals
                    delay(0.5)
                end
            end
            while amount > 0 do
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local _card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sfoth')
                        _card:set_edition({negative = true}, true)
                        _card:add_to_deck()
                        G.consumeables:emplace(_card)
                        G.GAME.consumeable_buffer = 0
                        return true
                end}))
                amount = amount - 1
                delay(0.5)
            end
        end
    end
}

SMODS.Joker {  --Bacon Hair
    key = 'baconhair',
    loc_txt = {
        name = 'Bacon Hair',
        text = {'{C:chips}+#2#{} Chips, {C:chips}+#3#{} additional',
            'Chips for each {C:attention}consumable{} in',
            'your consumable area',
            '{C:inactive}Currently {C:chips}+#1#{C:inactive} Chips'}
    },
    config = {extra = {chips = 40, freechips = 40, gainedchips = 40}},
    rarity = 1,
    pos = {x = 5,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.chips,card.ability.extra.freechips,card.ability.extra.gainedchips}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            local amount = 0
            for i, v in pairs (G.consumeables.cards) do
                amount = amount + 1
            end
            card.ability.extra.chips = card.ability.extra.freechips + card.ability.extra.gainedchips * amount
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,
    update = function(self,card,dt)
        card.ability.extra.chips = card.ability.extra.freechips
        if G.STAGE == G.STAGES.RUN then
            local amount = 0
            for i, v in pairs (G.consumeables.cards) do
                amount = amount + 1
            end
            card.ability.extra.chips = card.ability.extra.freechips + card.ability.extra.gainedchips * amount
        end
    end
}

SMODS.Joker { --Rthro
    key = 'rthro',
    loc_txt = {
        name = 'Rthro',
        text = {'{X:mult,C:white}X#1#{} Mult',
        'On blind select, all {C:attention}consumables{}',
        'in your consumable area are {C:attention}destroyed{}'}
    },
    config = {extra = {xmult = 2, money = 8}},
    rarity = 2,
    pos = {x = 7,y = 0},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult}}
    end,
    calculate = function(self,card,context)
        if context.setting_blind and not card.getting_sliced then
            for i, v in pairs (G.consumeables.cards) do
                v.getting_sliced = true
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.consumeable_buffer = 0
                    card:juice_up(0.8, 0.8)
                    v:start_dissolve(G.C.money, nil, 1.6)
                    play_sound('generic1', 0.96+math.random()*0.08)
                return true end }))
                delay(0.5)
            end
        end
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
                Xmult_mod = card.ability.extra.xmult
            }
        end
    end
}

SMODS.Joker { --Swordsman
    key = 'swordsman',
    loc_txt = {
        name = 'Swordsman',
        text = {'Gains {X:mult,C:white}X#2#{} Mult when',
        '{C:attention}consumable{} is used, loses {X:mult,C:white}X#3#{}',
        'Mult when {C:attention}shop is rerolled',
        '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'}
    },
    config = {extra = {xmult = 1, xmultgain = 0.1, xmultloss = 0.25}},
    rarity = 3,
    pos = {x = 0,y = 1},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult,card.ability.extra.xmultgain,card.ability.extra.xmultloss}}
    end,
    calculate = function(self,card,context)
        if context.using_consumeable and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmultgain
            G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')}); return true
                end}))
        end
        if context.reroll_shop and not context.blueprint then
            if card.ability.extra.xmult ~= 1 then
                card.ability.extra.xmult = math.max(1,card.ability.extra.xmult - card.ability.extra.xmultloss)
                G.E_MANAGER:add_event(Event({
                    func = function() card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Downgrade :('}); return true
                    end}))
            end
        end
        if context.joker_main then
            if card.ability.extra.xmult ~= 1 then
                return {
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
                    Xmult_mod = card.ability.extra.xmult
                }
            end
        end
    end
}

SMODS.Joker { --Adopt Me
    key = 'adoptme',
    loc_txt = {
        name = 'Adopt Me',
        text = {'{X:mult,C:white}X#1#{} Mult',
        'Gives {C:money}$#2#{} at end of blind'}
    },
    config = {extra = {xmult = 0.5, money = 8}},
    rarity = 2,
    pos = {x = 1,y = 1},
    atlas = 'jokeratlas',
    cost = 5,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.xmult, card.ability.extra.money}}
    end,
    calculate = function(self,card,context)
        if context.joker_main then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.xmult}},
                Xmult_mod = card.ability.extra.xmult
            }
        end
    end,
    calc_dollar_bonus = function(self)
		local bonus = self.ability.extra.money
        if bonus > 0 then return bonus end
	end
}

SMODS.Consumable { --Sword
    key = 'sword',
    loc_txt = {
        name = 'Sword',
        text = {'{C:attention}Destroys 2{} selected cards with',
        'a {C:green}#3# in 3{} chance or {C:attention}Duplicates 1{}',
        'selected card {C:attention}without its enhancement{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 0,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses,G.GAME.probabilities.normal*2}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if 2 >= #G.hand.highlighted and #G.hand.highlighted >= 1 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        if #G.hand.highlighted == 2 then
            if pseudorandom('sword') < G.GAME.probabilities.normal*2/3 then
                local destroyed_cards = {}
                for i=#G.hand.highlighted, 1, -1 do
                    destroyed_cards[#destroyed_cards+1] = G.hand.highlighted[i]
                end
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    return true end }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function() 
                        for i=#G.hand.highlighted, 1, -1 do
                            local card = G.hand.highlighted[i]
                            if card.ability.name == 'Glass Card' then 
                                card:shatter()
                            else
                                card:start_dissolve(nil, i == #G.hand.highlighted)
                            end
                        end
                        play_sound('robl_SwordSwing', 1, 1)
                        return true end }))
            else
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    attention_text({
                        text = 'Miss :(',
                        scale = 1.3, 
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.MONEY,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                        offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                        silent = true
                        })
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                            play_sound('robl_SwordSwing', 0.5, 1);return true end}))
                            play_sound('robl_SwordSwing', 1.5, 1)
                        card:juice_up(0.3, 0.5)
                return true end }))
            end
        elseif #G.hand.highlighted == 1 then
            local _card = copy_card(G.hand.highlighted[1], nil, nil, G.playing_card)
            _card:add_to_deck()
            G.deck.config.card_limit = G.deck.config.card_limit + 1
            table.insert(G.playing_cards, _card)
            G.hand:emplace(_card)
            _card:set_ability(G.P_CENTERS.c_base, nil, true)
            _card.states.visible = nil
                    
            G.E_MANAGER:add_event(Event({
                func = function()
                    _card:start_materialize()
                    play_sound('robl_SwordLunge', 1, 1)
                    return true
                end
                    }))
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Trowel
    key = 'trowel',
    loc_txt = {
        name = 'Trowel',
        text = {'Randomly convert {C:attention}2{} selected',
        'cards into {C:dark_edition}Foil{},',
        '{C:attention}Bonus{}, or {C:attention}Stone Cards{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 1,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if #G.hand.highlighted and #G.hand.highlighted == 1 or #G.hand.highlighted and #G.hand.highlighted == 2 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        local effect = pseudorandom(pseudoseed('trowel'))
        if effect > .66 then play_sound('robl_RobloxBass', 1, 1)
        elseif effect > .33 then play_sound('robl_RobloxBass', 1.2, 1)
        else play_sound('foil1', 1.2, 0.4)
        end
        for i, v in pairs (G.hand.highlighted) do
            if effect > .66 then v:set_ability(G.P_CENTERS.m_stone)
            elseif effect > .33 then v:set_ability(G.P_CENTERS.m_bonus)
            else v:set_edition({foil = true},true,true)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Bloxy Cola
    key = 'bloxycola',
    loc_txt = {
        name = 'Bloxy Cola',
        text = {'Randomly convert {C:attention}2{} selected',
        'cards into {C:dark_edition}Holographic{},',
        '{C:attention}Mult{}, or {C:attention}Lucky Cards{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 2,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if #G.hand.highlighted and #G.hand.highlighted == 1 or #G.hand.highlighted and #G.hand.highlighted == 2 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        local effect = pseudorandom(pseudoseed('cola'))
        if effect > .66 then play_sound('robl_BloxyCola', 1, 1)
        elseif effect > .33 then play_sound('robl_BloxyCola', 1.2, 1)
        else play_sound('holo1', 1.2*1.58, 0.4)
        end
        for i, v in pairs (G.hand.highlighted) do
            if effect > .66 then v:set_ability(G.P_CENTERS.m_lucky)
            elseif effect > .33 then v:set_ability(G.P_CENTERS.m_mult)
            else v:set_edition({holo = true},true,true)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Magic Carpet
    key = 'magiccarpet',
    loc_txt = {
        name = 'Magic Carpet',
        text = {'Randomly convert {C:attention}2{} selected',
        'cards into {C:dark_edition}Polychrome{},',
        '{C:attention}Glass{}, or {C:attention}Steel Cards{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 3,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 2, currentuses = 2}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if #G.hand.highlighted and #G.hand.highlighted == 1 or #G.hand.highlighted and #G.hand.highlighted == 2 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        local effect = pseudorandom(pseudoseed('carpet'))
        if effect > .66 then play_sound('robl_RobloxButton', 1, 1)
        elseif effect > .33 then play_sound('robl_RobloxButton', 1.2, 1)
        else play_sound('polychrome1', 1.2, 0.7)
        end
        for i, v in pairs (G.hand.highlighted) do
            if effect > .66 then v:set_ability(G.P_CENTERS.m_steel)
            elseif effect > .33 then v:set_ability(G.P_CENTERS.m_glass)
            else v:set_edition({polychrome = true},true,true)
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Slingshot
    key = 'slingshot',
    loc_txt = {
        name = 'Slingshot',
        text = {'Level up a {C:attention}random{}',
        'hand {C:attention}#3# times{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 4,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3, pokerhand = 'High Card', amount = 3}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses,card.ability.extra.amount}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if card.area ~= G.shop_jokers then
                return true
            end
        end
    end,
    use = function(self,card,area,copier)
        local _poker_hands = {}
        for k, v in pairs(G.GAME.hands) do
            if v.visible then _poker_hands[#_poker_hands+1] = k end
        end
        card.ability.extra.pokerhand = pseudorandom_element(_poker_hands, pseudoseed('slingshot'))
        play_sound('robl_RobloxSlingshot', 1, 1)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(card.ability.extra.pokerhand, 'poker_hands'),chips = G.GAME.hands[card.ability.extra.pokerhand].chips, mult = G.GAME.hands[card.ability.extra.pokerhand].mult, level=G.GAME.hands[card.ability.extra.pokerhand].level})
        level_up_hand(card,card.ability.extra.pokerhand,false,3)
        update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Superball
    key = 'superball',
    loc_txt = {
        name = 'Superball',
        text = {'Convert {C:attention}1{} selected card into a',
        '{C:attention}Wild Card{} or apply a random {C:attention}Seal{}',
        'to a selected {C:attention}Wild Card{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 5,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 6, currentuses = 6}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if #G.hand.highlighted and #G.hand.highlighted == 1 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        for i, v in pairs (G.hand.highlighted) do
            if v.ability.effect == 'Wild Card' then
                local seal_type = pseudorandom(pseudoseed('superball'))
                if seal_type > 0.75 then v:set_seal('Red', true)
                elseif seal_type > 0.5 then v:set_seal('Blue', true)
                elseif seal_type > 0.25 then v:set_seal('Gold', true)
                else v:set_seal('Purple', true)
                end
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up(0.3, 0.4)
                        return true
                    end
                }))
                play_sound('robl_RobloxSuperball', 1, 1)
            else
                v:set_ability(G.P_CENTERS.m_wild) 
                G.E_MANAGER:add_event(Event({
                    func = function()
                       v:juice_up(0.3, 0.4)
                        return true
                    end
                }))
                play_sound('robl_RobloxSuperball', 1.2, 1)
            end
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Boombox
    key = 'boombox',
    loc_txt = {
        name = 'Boombox',
        text = {'{C:green}#4# in 2{} chance to',
        'reduce {C:attention}Reroll{} cost by {C:money}$#3#{}',
        'for the {C:attention}rest of this shop{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 6,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 5, currentuses = 5, rerollreduce = 2,}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses,card.ability.extra.rerollreduce,G.GAME.probabilities.normal}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.shop_jokers then
                if card.area ~= G.shop_jokers then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        if pseudorandom('boombox') < G.GAME.probabilities.normal/2 then
            if G.GAME.round_resets.temp_reroll_cost then
                G.GAME.round_resets.temp_reroll_cost = math.max(G.GAME.round_resets.temp_reroll_cost - G.GAME.current_round.reroll_cost, G.GAME.round_resets.temp_reroll_cost - card.ability.extra.rerollreduce)
            else
                G.GAME.round_resets.temp_reroll_cost = math.max(G.GAME.round_resets.reroll_cost - G.GAME.current_round.reroll_cost, G.GAME.round_resets.reroll_cost - card.ability.extra.rerollreduce)
            end
            G.E_MANAGER:add_event(Event({func = function()
                calculate_reroll_cost(true)
                attention_text({
                    text = 'Reduced!',
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.MONEY,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    play_sound('robl_RainingTacos', 1, 1)
                card:juice_up(0.3, 0.5)
            return true end }))
        else
            G.E_MANAGER:add_event(Event({func = function()
                attention_text({
                    text = 'Sad :(',
                    scale = 1.3, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.MONEY,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    play_sound('robl_RobloxBass', 1, 1)
                card:juice_up(0.3, 0.5)
            return true end }))
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Paintball Gun
    key = 'paintballgun',
    loc_txt = {
        name = 'Paintball Gun',
        text = {'Convert all {C:attention}#3#{} in hand into',
        '{C:attention}random enhanced and sealed{} cards',
        '{C:money}#2#/#1# uses left{}',
        '{C:inactive}Suit changes every round{}'}
    },
    set = 'Gear',
    pos = {x = 7,y = 0}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 2, currentuses = 2}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses,G.GAME.current_round.castle_card.suit}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                return true
            end
        end
    end,
    use = function(self,card,area,copier)
        for i, v in ipairs(G.hand.cards) do 
            if v.base.suit == G.GAME.current_round.castle_card.suit then
                local rank_suffix = pseudorandom_element({'2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A'}, pseudoseed('pballgun_rank'))
                local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('pballgun_suit'))
                local suit_prefix = string.sub(_suit, 1, 1)..'_'
                local seal_type = pseudorandom(pseudoseed('pballgun_seal'))
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:set_base(G.P_CARDS[suit_prefix..rank_suffix])
                        v:set_ability(pseudorandom_element(G.P_CENTER_POOLS["Enhanced"], pseudoseed('pballgun_enhancement')))
                        if seal_type > 0.75 then v:set_seal('Red', true)
                        elseif seal_type > 0.5 then v:set_seal('Blue', true)
                        elseif seal_type > 0.25 then v:set_seal('Gold', true)
                        else v:set_seal('Purple', true)
                        end
                        v:juice_up(0.3, 0.4)
                        play_sound('robl_PaintballGun', 1, 1)
                        return true
                    end
                }))
                delay (0.5)
            end
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Gravity Coil
    key = 'gravitycoil',
    loc_txt = {
        name = 'Gravity Coil',
        text = {'If selected hand is a {C:attention}Straight{},',
        '{C:attention}Full House{}, or a {C:attention}Five of a Kind{},',
        'make all cards {C:attention}Wild Cards{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 0,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 2, currentuses = 2}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if G.hand.highlighted then
                    if G.FUNCS.get_poker_hand_info(G.hand.highlighted) == 'Straight' or G.FUNCS.get_poker_hand_info(G.hand.highlighted) == 'Full House' or G.FUNCS.get_poker_hand_info(G.hand.highlighted) == 'Five of a Kind' then
                        return true
                    end
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        play_sound('robl_RobloxGravityCoil', 1, 1)
        for i, v in pairs (G.hand.highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:set_ability(G.P_CENTERS.m_wild)
                    v:juice_up(0.3, 0.4)
                    play_sound('robl_RobloxButton', 1 + 0.1*i, 1)
                    return true
                end
            }))
            delay(0.5)
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Speed Coil
    key = 'speedcoil',
    loc_txt = {
        name = 'Speed Coil',
        text = {'Get a random {C:attention}Tag{}',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 1,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 4, currentuses = 4}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if card.area ~= G.shop_jokers then
                return true
            end
        end
    end,
    use = function(self,card,area,copier)
        tag = get_next_tag_key()
        G.E_MANAGER:add_event(Event({
            func = (function()
                local tag = Tag(get_next_tag_key('speedcoil')) --yoinked from cyptid's pickle
                if tag.name == 'Boss Tag' or tag.name == 'Orbital Tag' then
                    tag = tag_double
                else
                    add_tag(tag)
                end --end of yoinking
                play_sound('robl_RobloxSpeedCoil', 1, 1)
                return true
            end)
        }))
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Ban Hammer
    key = 'banhammer',
    loc_txt = {
        name = 'Ban Hammer',
        text = {'{C:attention}Destroy the {C:attention}leftmost{}',
        'Joker and apply an {C:dark_edition}Edition{}',
        'to a random Joker',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 2,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3, eligible_editionless_jokers = {}}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if card.area ~= G.shop_jokers then
                if #card.ability.extra.eligible_editionless_jokers > 0 and not G.jokers.cards[1].ability.eternal then 
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            G.jokers.cards[1]:start_dissolve({G.C.RED}, nil, 1.6)
            edition = poll_edition('banhammer', nil, false, true)
            pseudorandom_element(card.ability.extra.eligible_editionless_jokers,pseudoseed('banhammer_joker')):set_edition(edition, true)
            card:juice_up(0.3, 0.5)
            play_sound('robl_RobloxBanHammer', 1, 1)
            return true end }))
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end,
    update = function(self,card,dt)
        card.ability.extra.eligible_editionless_jokers = EMPTY(card.ability.extra.eligible_editionless_jokers)
        if G.STAGE == G.STAGES.RUN then
            for i, v in ipairs(G.jokers.cards) do
                if v.ability.set == 'Joker' and (not v.edition) and v ~= G.jokers.cards[1] then
                    table.insert(card.ability.extra.eligible_editionless_jokers, v)
                end
            end
        end
    end
}

SMODS.Consumable { --Zombie Staff
    key = 'zombiestaff',
    loc_txt = {
        name = 'Zombie Staff',
        text = {'Create a random {C:dark_edition}Negative',
        '{C:attention}Common Joker{} or {C:purple}Tarot{} Card',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 3,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 3, currentuses = 3}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if card.area ~= G.shop_jokers then
                return true
            end
        end
    end,
    use = function(self,card,area,copier)
        local isjoker = pseudorandom(pseudoseed('zombiestaff'))
        if isjoker > 0.4 then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'zombiestaff_jokers')
                    _card:add_to_deck()
                    G.jokers:emplace(_card)
                    _card:start_materialize()
                    G.GAME.joker_buffer = 0
                    _card:set_edition({negative = true},true)
                    card:juice_up(0.5,0.5)
                    play_sound('robl_ZombieGroan', 1, 1)
                    return true
                end}))   
        else
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function() 
                    local _card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'car')
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    G.GAME.consumeable_buffer = 0
                    _card:set_edition({negative = true},true)
                    card:juice_up(0.5,0.5)
                    play_sound('robl_ZombieGroan', 1.2, 1)
                    return true
                end}))   
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Rocket Launcher
    key = 'rocketlauncher',
    loc_txt = {
        name = 'Rocket Launcher',
        text = {'{C:attention}Destroy{} 1 selected card and either',
        'all cards of the same {C:attention}rank{} or',
        '{C:attention}suit{} in hand, chosen {C:attention}randomly',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 4,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 4, currentuses = 4}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.PLANET_PACK then
                if #G.hand.highlighted and #G.hand.highlighted == 1 then
                    return true
                end
            end
        end
    end,
    use = function(self,card,area,copier)
        local isrank = pseudorandom(pseudoseed('rocketlauncher'))
        local destroyedcards = {}
        if isrank > 0.5 then
            for i, v in pairs (G.hand.cards) do
                if v.base.suit == G.hand.highlighted[1].base.suit then
                    if destroyedcards then
                        destroyedcards[#destroyedcards+1] = v
                    else
                        destroyedcard[1] = v
                    end
                end
            end
        else
            for i, v in pairs (G.hand.cards) do
                if v.base.id == G.hand.highlighted[1].base.id then
                    if destroyedcards then
                        destroyedcards[#destroyedcards+1] = v
                    else
                        destroyedcard[1] = v
                    end
                end
            end
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                for i, v in pairs (destroyedcards) do
                    if v.ability.name == 'Glass Card' then 
                        v:shatter()
                    else
                        v:start_dissolve(nil, i == 1)
                    end
                end
                play_sound('robl_RobloxRocketShot', 1, 1)
                return true end }))
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}

SMODS.Consumable { --Bomb
    key = 'bomb',
    loc_txt = {
        name = 'Bomb',
        text = {'{C:attention}Remove{} all levels and randomly',
        'gain 1 {C:red}Discard{}, {C:blue}Hand{}, or {C:attention}Hand',
        '{C:attention}Size{} per {C:attention}5{} levels removed',
        '{C:money}#2#/#1# uses left{}'}
    },
    set = 'Gear',
    pos = {x = 5,y = 1}, 
    atlas = 'gearatlas', 
    config = {extra = {maxuses = 2, currentuses = 2}},
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.maxuses,card.ability.extra.currentuses}}
    end,
    keep_on_use = function(self,card)
        if card.ability.extra.currentuses > 1 then
            return true
        end
    end,
    can_use = function(self,card)
        if card.ability.extra.currentuses > 0 then
            if card.area ~= G.shop_jokers then
                return true
            end
        end
    end,
    use = function(self,card,area,copier)
        local _planet, _hand, _tally = nil, nil, -1 -- was yoinked from the cryptid white hole code
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                _hand = v
                _tally = G.GAME.hands[v].played
            end
        end
        if _hand then
            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                if v.config.hand_type == _hand then
                    _planet = v.key
                end
            end
        end
        local removed_levels = 0
        for k, v in ipairs(G.handlist) do
            if G.GAME.hands[v].level > 1 then
                local this_removed_levels = G.GAME.hands[v].level - 1
                removed_levels = removed_levels + this_removed_levels
                level_up_hand(card, v, true, -this_removed_levels)
            end
        end -- end of yoinking
        play_sound('robl_RobloxRocketShot', 0.7, 1)
        delay(1)
        if removed_levels < 5 then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                attention_text({
                    text = 'Lol, that was just sad.',
                    scale = 0.7, 
                    hold = 1.4,
                    major = card,
                    backdrop_colour = G.C.MONEY,
                    align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and 'tm' or 'cm',
                    offset = {x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK) and -0.2 or 0},
                    silent = true
                    })
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('robl_RobloxButton', 1, 1);return true end}))
                    play_sound('robl_RobloxButton', 1, 1)
                    card:juice_up(0.3, 0.5)
            return true end }))
        end
        while removed_levels >= 5 do
            local resource = pseudorandom(pseudoseed('bomb'))
            if resource > .66 then
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + 1
                ease_discard(1)
            elseif resource > .33 then 
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                ease_hands_played(1)
            else
                G.hand:change_size(1)
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        play_sound('robl_RobloxButton', 1.2, 1)
                        return true
                    end})) 
            end
            removed_levels = removed_levels - 5
            G.E_MANAGER:add_event(Event({
                func = function() 
                    card:juice_up(0.5,0.5)
                    return true
                end}))   
            delay(1)
        end
        card.ability.extra.currentuses = card.ability.extra.currentuses - 1
    end
}