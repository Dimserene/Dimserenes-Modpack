--- STEAMODDED HEADER
--- MOD_NAME: Fortlatro
--- MOD_ID: Fortlatro
--- MOD_AUTHOR: [EricTheToon]
--- MOD_DESCRIPTION: A terribly coded mod to add Fortnite themed stuff + stuff for my friends to Balatro.
--- BADGE_COLOUR: 672A62
--- PREFIX: fn
--- PRIORITY: -69420
--- DEPENDENCIES: [Steamodded>=0.9.8, Cryptid>=0.5.3, ortalab, SnowMods>=0.2.0, ceres>=1.2.0b, BetmmaAbilities>=1.0.3.3(20241018), DiceSeal, CursedDiceSeal, Talisman>=2.0.0-beta8,]
--- VERSION: 1.0.3 Release
----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas({
    key = 'modicon',
    path = 'modicon.png',
    px = '34',
    py = '34'
})
----------------------------------------------
------------ERIC CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Eric', -- joker key
    loc_txt = { -- local text
        name = 'Eric',
        text = {
            'He stole your wallet but I think he\'s trying to help?',
            'When Blind is selected,',
            'create 3 random Jokers',
            '{C:inactive}(No need to have room)',
            'lose {C:money}$5{} at end of round'
        },
        --[[unlock = {
            'Be {C:legendary}cool{}',
        }]]
    },
    atlas = 'Jokers', -- atlas' key
    rarity = 4, -- rarity: 1 = Common, 2 = Uncommon, 3 = Rare, 4 = Legendary
    cost = 1, -- cost
    unlocked = true, -- if true, starts unlocked
    discovered = false, -- whether or not it starts discovered
    blueprint_compat = true, -- can it be blueprinted/brainstormed
    eternal_compat = true, -- can it be eternal
    perishable_compat = false, -- can it be perishable
    pos = {x = 0, y = 0}, -- position in atlas
    config = { 
        extra = {}
    },
    loc_vars = function(self, info_queue, center)
        if G.P_CENTERS and G.P_CENTERS.j_joker then
        end
    end,
    check_for_unlock = function(self, args)
        if args.type == 'eric_loves_you' then
            unlock_card(self)
        end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                card = card,
            }
        end

        if context.setting_blind then
            for i = 1, 3 do
                local new_card = create_card('Joker', G.jokers, is_soul, nil, nil, nil, nil, "mno")
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end
    end,
    in_pool = function(self, wawa, wawa2)
        -- whether or not this card is in the pool, return true if it is, false otherwise
        return true
    end,
    calc_dollar_bonus = function(self, card)
        return -5
    end,
}


----------------------------------------------
------------ERIC CODE END----------------------

----------------------------------------------
------------SWORD CODE BEGIN----------------------
SMODS.Sound({
	key = "error",
	path = "error.ogg",
})


SMODS.ConsumableType{
    key = 'LTMConsumableType', --consumable type key

    collection_rows = {5,5}, --amount of cards in one page
    primary_colour = G.C.PURPLE, --first color
    secondary_colour = G.C.DARK_EDITION, --second color
    loc_txt = {
        collection = 'LTM Cards', --name displayed in collection
        name = 'LTM Cards', --name displayed in badge
        undiscovered = {
            name = 'Hidden LTM', --undiscovered name
            text = {'you dont know the', 'playlist id'} --undiscovered text
        }
    },
    shop_rate = 1, --rate in shop out of 100
}


SMODS.UndiscoveredSprite{
    key = 'LTMConsumableType', --must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}


SMODS.Consumable{
    key = 'LTMSword', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 1, y = 0}, -- position in atlas
    loc_txt = {
        name = 'Eric\'s Sword', -- name of card
        text = { -- text of card
            'This thing seems VERY unstable',
            'Add a random edition to up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 5, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
		play_sound("slice1")
		play_sound("fn_error")
        if G and G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_edition(poll_edition('random key', nil, false, true))
            end
        end
    end,
}


----------------------------------------------
------------ERIC SWORD CODE END----------------------

----------------------------------------------
------------CRAC CODE BEGIN----------------------
SMODS.Sound({
	key = "arcana",
	path = "arcana.ogg",
})
SMODS.Sound({
	key = "persona",
	path = "persona.ogg",
})

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Crac',
    loc_txt = {
        ['en-us'] = {
            name = "Crac",
            text = {
                "The Arcana is the means by which all is revealed.",
                "Has a {C:green,E:1,S:1.1}#3# in #2#{} chance to do SOMETHING",
                "{C:inactive}(Currently {C:mult}#1#{}{C:inactive} Mult)",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 2, y = 0 },
    config = {
        extra = { odds = 13, multmod = 50, mult = 13, repetitions = 1 }
    },
    rarity = 3,
    order = 32,
    cost = 13,
    blueprint_compat = true,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.odds,
                '' .. (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.multmod
            }
        }
    end,

    calculate = function(self, card, context)
        if context.before then
            if pseudorandom('crac') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local outcome = pseudorandom('crac_outcome')

                if outcome == nil then
                    error("Outcome is nil. Something went wrong with the random generation or the way outcome is calculated.")
                end

                if outcome < 0.0667  then
                    -- x0 multiplier logic
                    card.ability.extra.mult = 0
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "FUCK"
                    }
                elseif outcome < 0.1334 then
                    -- x10 multiplier logic
                    card.ability.extra.mult = card.ability.extra.mult * 10
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "les goo!"
                    }
                elseif outcome < 0.2001 then
                    -- -50 multiplier logic
                    card.ability.extra.mult = card.ability.extra.mult - 50
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "Man wtf...."
                    }
                elseif outcome < 0.2668 then
                    -- Summon a random joker
                    local new_card = create_card('Joker', G.jokers, is_soul, nil, nil, nil, nil, "mno")
                    new_card:add_to_deck()
                    G.jokers:emplace(new_card)
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
					play_sound("fn_persona")
                    return {
                        message = "PERSONA!"
                    }
                elseif outcome < 0.3335 then
                    -- Summon an LTM consumable
                    local new_card = create_card('LTMConsumableType', G.consumeables)
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "Devious lick"
                    }
                elseif outcome < 0.4002 then
                    -- Multiply by -1
                    card.ability.extra.mult = card.ability.extra.mult * -1
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "This some bullshit!"
                    }
                elseif outcome < 0.4669 then
                    -- Summon a random Tarot card
                    local tarot_cards = {
                        'c_fool', 'c_magician', 'c_hanged_man',
                        'c_lovers', 'c_chariot', 'c_hermit',
                        'c_justice', 'c_death', 'c_temperance',
                        'c_devil', 'c_tower', 'c_star', 'c_moon', 'c_sun', 'c_judgement', 'c_world'
                    }
                    local random_card_id = tarot_cards[math.random(1, #tarot_cards)]
                    local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, random_card_id)
                    _card:add_to_deck()
                    G.consumeables:emplace(_card)
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
					play_sound("fn_arcana")
                    return {
                        message = "The Arcana is the means by which all is revealed."
                    }
                elseif outcome < 0.5336 then
                    -- Summon a Planet card
                    local card_type = 'Planet'
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            local _planet = 0
                            for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                if v.config.hand_type == context.scoring_name then
                                    _planet = v.key
                                end
                            end
                            local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, nil)
                            card:add_to_deck()
                            G.consumeables:emplace(card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "yo let me summon a fucking planet!"
                    }
                elseif outcome < 0.6003 then
                    -- Normal multiplier logic
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multmod
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "How lucky!"
                    }
                elseif outcome < 0.6670 then
                    -- +50 multiplier logic
                    card.ability.extra.mult = card.ability.extra.mult + 50
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "How lucky!"
                    }
                elseif outcome < 0.7337 then
                    -- Make all scored cards lucky
                    for k, v in ipairs(context.scoring_hand) do
                        v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        }))
                    end
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "Nagato Komado!"
                    }
                elseif outcome < 0.8004 then
                    -- Double reroll: Select 2 random outcomes
                    local outcomes = {}

                    -- Perform two rerolls
                    for i = 1, 2 do
                        local rerolled_outcome = pseudorandom('crac_outcome')

                        if rerolled_outcome == nil then
                            error("Rerolled outcome is nil. Something went wrong with the random generation.")
                        end

                        -- Determine the outcome of the reroll
                        if rerolled_outcome < 0.0714 then
                            table.insert(outcomes, "x0 multiplier logic")
                            -- x0 multiplier logic
                            card.ability.extra.mult = 0
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.1428 then
                            table.insert(outcomes, "x10 multiplier logic")
                            -- x10 multiplier logic
                            card.ability.extra.mult = card.ability.extra.mult * 10
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.2142 then
                            table.insert(outcomes, "-50 multiplier logic")
                            -- -50 multiplier logic
                            card.ability.extra.mult = card.ability.extra.mult - 50
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.2856 then
                            table.insert(outcomes, "Summon a random joker")
                            -- Summon a random joker
							play_sound("fn_persona")
                            local new_card = create_card('Joker', G.jokers, is_soul, nil, nil, nil, nil, "mno")
                            new_card:add_to_deck()
                            G.jokers:emplace(new_card)
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.3570 then
                            table.insert(outcomes, "Summon an LTM consumable")
                            -- Summon an LTM consumable
                            local new_card = create_card('LTMConsumableType', G.consumeables)
                            new_card:add_to_deck()
                            G.consumeables:emplace(new_card)
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.4284 then
                            table.insert(outcomes, "Multiply by -1")
                            -- Multiply by -1
                            card.ability.extra.mult = card.ability.extra.mult * -1
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.4998 then
                            table.insert(outcomes, "Summon a random Tarot card")
                            -- Summon a random Tarot card
							play_sound("fn_arcana")
                            local tarot_cards = {
                                'c_fool', 'c_magician', 'c_hanged_man',
                                'c_lovers', 'c_chariot', 'c_hermit',
                                'c_justice', 'c_death', 'c_temperance',
                                'c_devil', 'c_tower', 'c_star', 'c_moon', 'c_sun', 'c_judgement', 'c_world'
                            }
                            local random_card_id = tarot_cards[math.random(1, #tarot_cards)]
                            local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, random_card_id)
                            _card:add_to_deck()
                            G.consumeables:emplace(_card)
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.5712 then
                            table.insert(outcomes, "Summon a Planet card")
                            -- Summon a Planet card
                            local card_type = 'Planet'
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = function()
                                    local _planet = 0
                                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                        if v.config.hand_type == context.scoring_name then
                                            _planet = v.key
                                        end
                                    end
                                    local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, nil)
                                    card:add_to_deck()
                                    G.consumeables:emplace(card)
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            }))
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.6426 then
                            table.insert(outcomes, "Normal multiplier logic")
                            -- Normal multiplier logic
                            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.multmod
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.7140 then
                            table.insert(outcomes, "+50 multiplier logic")
                            -- +50 multiplier logic
                            card.ability.extra.mult = card.ability.extra.mult + 50
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.7854 then
                            table.insert(outcomes, "Make all scored cards lucky")
                            -- Make all scored cards lucky
                            for k, v in ipairs(context.scoring_hand) do
                                v:set_ability(G.P_CENTERS.m_lucky, nil, true)
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        v:juice_up()
                                        return true
                                    end
                                }))
                            end
                            G.GAME.pool_flags.crac_flag = true
                        elseif rerolled_outcome < 0.8568 then
                            table.insert(outcomes, "Double reroll")
                            -- Double reroll: Select 2 random outcomes
                        end
                    end
                    G.GAME.pool_flags.crac_flag = true
                    return {
                        message = "DOUBLE OR NOTHING"
                    }
                elseif outcome < 0.8671 then
                    -- Apply random seals to each scored card
                    for k, v in ipairs(context.scoring_hand) do
                        local seal_type = pseudorandom(pseudoseed('cracsealed'))  

                        -- Assign a random seal based on the generated number
                        if seal_type > 0.875 then 
                            v:set_seal('Red', true)
                        elseif seal_type > 0.75 then 
                            v:set_seal('Blue', true)
                        elseif seal_type > 0.625 then 
                            v:set_seal('Gold', true)
                        elseif seal_type > 0.5 then 
                            v:set_seal('Purple', true)
                        elseif seal_type > 0.375 then 
                            v:set_seal('curs_curseddice_seal', true)
                        elseif seal_type > 0.25 then 
                            v:set_seal('dice_seal', true)
                        elseif seal_type > 0.175 then 
                            v:set_seal('cry_azure', true)
                        elseif seal_type > 0.1 then 
                            v:set_seal('cry_green', true)
                        else 
                            v:set_seal('cere_green_seal', true)
                        end

                        -- Add an event to "juice up" the card after sealing
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up(0.3, 0.4)
                                return true
                            end
                        }))
                    end
                    G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
                    return {
                        message = "Lick and stick!"
                    }
                elseif outcome < 0.9338 then
                    -- Draw the whole deck
					G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
					G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
					return {
						message = "ALL OR NOTHIN'!"
					}
    
				elseif outcome < 1.0000 then
					-- Instant win 
					G.GAME.chips = G.GAME.blind.chips  -- Set chips to blind value
					G.GAME.pool_flags.crac_flag = true  -- Set Crac's unique flag
					return {
						message = "Nah, i'd win"
					}
                end
            end
        end
        
        if context.joker_main then
            return {
                message = localize {
                    type = 'variable',
                    key = 'sj_mult',
                    vars = { card.ability.extra.mult }
                },
                mult_mod = card.ability.extra.mult,
                card = self
            }
        end
    end
}







----------------------------------------------
------------CRAC CODE END----------------------

----------------------------------------------
------------EMILY CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
  key = 'Emily',
  loc_txt = {
    name = 'Emily',
    text = {
      "Retrigger EVERYTHING"
    }
  },
  atlas = "Jokers",
  pos = { x = 4, y = 0 },
  config = {}, -- No need for `extra.odds`
  rarity = 4,
  order = 32,
  cost = 14,
  no_pool_flag = 'clam',
  blueprint_compat = true,
  loc_vars = function(self, info_queue, center)
    return {
      vars = { "" .. (G.GAME and G.GAME.probabilities.normal or 1) }
    }
  end,
  calculate = function(self, card, context)
    -- Check for retrigger conditions
    if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= self then
      G.GAME.pool_flags.clam = true -- Ensure 'clam' flag is set
      return {
        message = "CLAM!",          -- Display "CLAM!" message
        colour = G.C.RED,           -- Add color if applicable
        repetitions = 1,            -- Retrigger action
        card = card,
      }
    end

    -- Check for repetition and update game state
    if context.repetition and context.cardarea == G.play then
      G.GAME.pool_flags.clam = true
      return {
        message = "CLAM!",
        colour = G.C.RED,
      }
    end
  end,
}

----------------------------------------------
------------EMILY CODE END----------------------

----------------------------------------------
------------TOILET GANG CODE BEGIN----------------------

SMODS.Sound({
	key = "flush",
	path = "flush.ogg",
})

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}

SMODS.Joker{
  key = 'Toilet Gang',
  loc_txt = {
    name = 'Toilet Gang',
    text = {
	 "This Joker Gains {X:mult,C:white}X#1#{} Mult",
     "if played hand",
     "contains a {C:attention}Flush{}",
     "{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult"
        }
    },
    rarity = 2,
    atlas = "Jokers", pos = {x = 3, y = 0},
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    blueprint_compat = true,
    perishable_compat = false,
    config = {extra = {Xmult_add = 0.2, Xmult = 1}},
    loc_vars = function(self, info_queue, card)
   return {vars = {card.ability.extra.Xmult_add, card.ability.extra.Xmult}}
  end, 
    calculate = function(self, card, context)
      if context.cardarea == G.jokers and context.before and not context.blueprint then 
        if context.scoring_name == "Flush" or context.scoring_name == "Straight Flush" or context.scoring_name == "Royal Flush" or context.scoring_name == "Flush Five" or context.scoring_name == "Flush House" then
                        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_add
                        return {
							play_sound("fn_flush"),
                            message = localize('k_upgrade_ex'),
                            colour = G.C.Mult,
                            card = card
                        }
                         end
        end
        if context.joker_main then
        return {
          message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
          Xmult_mod = card.ability.extra.Xmult,
      }
     end
    end,
}


----------------------------------------------
------------TOILET GANG CODE END----------------------

----------------------------------------------
------------GROUND GAME CODE BEGIN----------------------

SMODS.Sound({
	key = "bus",
	path = "bus.ogg",
})

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'GroundGame', 
    loc_txt = {
        ['en-us'] = {
            name = "Ground Game", 
            text = {
                "If played hand contains a scoring 6, 7, 2, 2, and 3",
                "Draw the entire deck and apply {C:dark_edition}Glitched{} to ALL cards and Jokers",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 0, y = 3 },
    config = {
        extra = {
            -- Define additional properties here if needed
        }
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = false,

    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_glitched
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
	
	calculate = function(self, card, context) -- Ground Game Logic
        if context.joker_main then
            local counts = { [6] = 0, [7] = 0, [2] = 0, [3] = 0 }
            
            -- Count occurrences of relevant scoring cards
            for _, scoring_card in ipairs(context.scoring_hand) do
                local value = scoring_card:get_id()
                if counts[value] ~= nil then
                    counts[value] = counts[value] + 1
                end
            end
            
            -- Check for the specific condition: 6, 7, 2 (x2), and 3
            if counts[6] >= 1 and counts[7] >= 1 and counts[2] >= 2 and counts[3] >= 1 then
                -- Draw the entire deck
				play_sound("fn_bus")
                G.FUNCS.draw_from_deck_to_hand(#G.deck.cards)
                
                -- Apply the GLITCHED effect to scoring hand
                for i = 1, #context.scoring_hand do
                    context.scoring_hand[i]:set_edition({ cry_glitched = true }, true, false)
                end

                -- Apply the GLITCHED effect to all cards in hand and Jokers
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.0,
                    func = function()
                        self:apply_glitched_effect_to_hand(card)
                        self:apply_glitched_effect_to_jokers(card)
                        return true
                    end
                }))
                return {
                    message = localize('k_glitched_applied'),
                    colour = G.C.SECONDARY_SET.Glitched,
                    card = card
                }
            end
        end
    end,

    apply_glitched_effect_to_hand = function(self, card)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                card:juice_up(0.3, 0.5)
                return true
            end,
        }))
        for i = 1, #G.hand.cards do
            local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.hand.cards[i]:flip()
                    play_sound("card1", percent)
                    G.hand.cards[i]:juice_up(0.3, 0.3)
                    return true
                end,
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.cards do
            local CARD = G.hand.cards[i]
            local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    CARD:flip()
                    CARD:set_edition({
                        cry_glitched = true,
                    })
                    play_sound("tarot2", percent)
                    CARD:juice_up(0.3, 0.3)
                    return true
                end,
            }))
        end
    end,

    apply_glitched_effect_to_jokers = function(self, card)
        local used_consumable = card
        local target = #G.jokers.cards == 1 and G.jokers.cards[1] or G.jokers.cards[math.random(#G.jokers.cards)]
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot1")
                used_consumable:juice_up(0.3, 0.5)
                return true
            end,
        }))
        for i = 1, #G.jokers.cards do
            local percent = 1.15 - (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    G.jokers.cards[i]:flip()
                    play_sound("card1", percent)
                    G.jokers.cards[i]:juice_up(0.3, 0.3)
                    return true
                end,
            }))
        end
        delay(0.2)
        for i = 1, #G.jokers.cards do
            local CARD = G.jokers.cards[i]
            local percent = 0.85 + (i - 0.999) / (#G.jokers.cards - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.15,
                func = function()
                    CARD:flip()
                    if not CARD.edition then
                        CARD:set_edition({ cry_glitched = true })
                    end
                    play_sound("card1", percent)
                    CARD:juice_up(0.3, 0.3)
                    return true
                end,
            }))
        end
        delay(0.2)
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("tarot2")
                used_consumable:juice_up(0.3, 0.5)
                return true
            end,
        }))
    end
}

----------------------------------------------
------------GROUND GAME CODE END----------------------

----------------------------------------------
------------DUB CODE BEGIN----------------------

SMODS.Sound({
	key = "dub",
	path = "dub.ogg",
})

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'TheDub',
    loc_txt = {
        ['en-us'] = {
            name = "The Dub",
            text = {
                "{C:green}#3#{} in {C:green}#2#{} chance to",
                "create a {C:dark_edition}LTM Card{}",
                "when {C:attention}Blind{} starts",
                "{C:inactive}(Must have room)"
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 1, y = 3 },
    config = {
        extra = { odds = 4 } -- 1 in 4 chance
    },
    rarity = 1,
    cost = 5,
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.odds,
                '' .. (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.multmod
            }
        }
    end,

    calculate = function(self, card, context)
        -- Check if the Blind effect is starting and that conditions are met (no blueprint card or slicing)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            -- Check if there's enough room in the consumables
            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit and pseudorandom('Krowe') < G.GAME.probabilities.normal/card.ability.extra.odds then
                -- Create and add the LTM card to the deck
                local new_card = create_card('LTMConsumableType', G.consumeables)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
				play_sound("fn_dub")
            end
        end
    end -- End of calculate function
} -- End of Joker

----------------------------------------------
------------DUB CODE END----------------------

----------------------------------------------
------------FLUSH FACTORY CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'FlushFactory',
    loc_txt = {
        ['en-us'] = {
            name = "Flush Factory",
            text = {
                "If the played hand contains a {C:attention}Flush{},",
                "summon a {C:planet}Planet{} card for that hand.",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 3, y = 3 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    config = { extra = { Xmult_add = 0.2, Xmult = 1 }},
    loc_vars = function(self, info_queue, card)
    end,
    calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.before and not context.blueprint then
        -- Check for flush types
        if context.scoring_name == "Flush" or context.scoring_name == "Straight Flush" or context.scoring_name == "Royal Flush" or context.scoring_name == "Flush Five" or context.scoring_name == "Flush House" then
            local card_type = 'Planet'
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            
            -- Add event for creating a planet card
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    local _planet = nil
                    
                    -- Iterate over the Planet pool to find a matching planet based on the flush hand type
                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                        if v.config.hand_type == context.scoring_name then
                            _planet = v.key
                            break  -- Stop iterating once a match is found
                        end
                    end
                    
                    -- If a planet is found, create and add it to the deck
                    if _planet then
                        local new_card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, nil)
                        
                        -- Ensure the card's extra field exists
                        if not new_card.extra then
                            new_card.extra = {}
                        end
                        
                        -- Add the card to the deck
                        new_card:add_to_deck()
                        G.consumeables:emplace(new_card)
                    end

                    -- Reset the consumeable buffer after adding the card
                    G.GAME.consumeable_buffer = 0
                    
                    return true
                end
            }))
            
            -- Set Crac's unique flag
            G.GAME.pool_flags.flush_flag = true
            
            -- Return the dynamic message based on the scoring hand type
            return {
                play_sound("fn_flush"),
				message = context.scoring_name .. "!"
            }
        end
    end
end,
}

----------------------------------------------
------------FLUSH FACTORY CODE END----------------------

----------------------------------------------
------------VICTORY CROWN CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'VictoryCrown', 
    loc_txt = {
        ['en-us'] = {
            name = "Victory Crown", 
            text = {
                "Scored cards gain a {C:mult}permanent{} {C:chips}Chip{} bonus", 
                "equal to their rank",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 4, y = 3 },
    config = {
        extra = {
            -- Define additional properties here if needed
        }
    },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    
    -- Calculate function for giving permanent rank-based chip bonus
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local currentCard = context.other_card
            if currentCard then
                -- Grant the played card's rank value as a permanent chip bonus
                currentCard.ability.perma_bonus = (currentCard.ability.perma_bonus or 0) + SMODS.Ranks[currentCard.base.value].nominal

                -- Replace the "big juice" effect with card:juice_up()
                if currentCard.juice_up then
                    currentCard:juice_up()
                else
                    print("Error: The card does not have the juice_up method.")
                end

                return {
                    extra = { message = "Upgrade!", colour = G.C.CHIPS },
                    colour = G.C.CHIPS,
                    card = currentCard
                }
            end
        end
    end
}
----------------------------------------------
------------VICTORY CROWN CODE END----------------------

----------------------------------------------
------------FORTNITE TRADING CARD CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Peely', 
    loc_txt = {
        ['en-us'] = {
            name = "Fortnite Trading Card", 
            text = {
                "If {C:attention}first hand{} of round",
                "has only 4 cards, destroy",
                "them and earn an {C:dark_edition}LTM Card{}", 
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 2, y = 4 },
    config = {
        extra = {
            -- Define additional properties here if needed
        }
    },
    rarity = 2,
    cost = 4,
    blueprint_compat = true,
    
    -- Calculate function for applying the Joker's effect
    calculate = function(self, card, context)
        if context.joker_main then
            -- Check if the current round has not played any hands yet
            if G.GAME.current_round.hands_played == 0 then
                -- Check if the hand has exactly 4 cards
                if #context.full_hand == 4 then
                    -- Destroy each card in the current hand using start_dissolve
                    for _, hand_card in ipairs(context.full_hand) do
                        hand_card:start_dissolve()  -- Initiates card dissolution
                    end

                    -- Create and add an LTM card to the consumables deck
                    local new_card = create_card('LTMConsumableType', G.consumeables)
                    new_card:add_to_deck()  -- Adds the card to the deck
                    G.consumeables:emplace(new_card)  -- Adds the card to the consumables collection

                    -- Set Crac's unique flag
                    G.GAME.pool_flags.peely_flag = true

                    -- Return the message and effect on the hand
                    return {
                        message = "+1 LTM Card!",
                        colour = G.C.DARK_EDITION,
                        card = card
                    }
                end
            end
        end
    end
}

----------------------------------------------
------------FORTNITE TRADING CARD CODE END----------------------

----------------------------------------------
------------ZORLODO ZORCODEO ZORBEGINDO----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'Zorlodo', 
    loc_txt = {
        ['en-us'] = {
            name = "Zorlodo", 
            text = {
                "Copies the abilities of left and right jokers",
                "but halves them if applicable"
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 3, y = 4 },
    config = {
        extra = {
            -- No additional properties required for now
        }
    },
    rarity = 3,
    cost = 4,
    blueprint_compat = true,

    calculate = function(self, card, context)
        -- Initialize a table for results
        local results = {}

        -- Identify left and right jokers
        local left_joker, right_joker
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                left_joker = G.jokers.cards[i - 1]
                right_joker = G.jokers.cards[i + 1]
                break
            end
        end

        -- Process the left joker, if it exists
        if left_joker and left_joker ~= self then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card

            if context.blueprint > #G.jokers.cards + 1 then
                return
            end

            local left_result, left_trig = left_joker:calculate_joker(context)
            if left_result or left_trig then
                if not left_result then
                    left_result = {}
                end

                left_result.card = context.blueprint_card or card
                left_result.colour = G.C.GREEN
                left_result.no_callback = true
                table.insert(results, left_result)
            end
        end

        -- Process the right joker, if it exists
        if right_joker and right_joker ~= self then
            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card

            if context.blueprint > #G.jokers.cards + 1 then
                return
            end

            local right_result, right_trig = right_joker:calculate_joker(context)
            if right_result or right_trig then
                if not right_result then
                    right_result = {}
                end

                right_result.card = context.blueprint_card or card
                right_result.colour = G.C.GREEN
                right_result.no_callback = true
                table.insert(results, right_result)
            end
        end

        -- Return the combined result
        if #results > 0 then
            return results[1] -- Return the first result (or adjust as needed)
        end
    end
}

----------------------------------------------
------------ZORLODO ZORCODEO ZORENDO----------------------

----------------------------------------------
------------SOLID GOLD CODE BEGIN----------------------

SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
SMODS.Joker{
    key = 'SolidGold',
    loc_txt = {
        ['en-us'] = {
            name = "Solid Gold",
            text = {
                "{C:green}#3# in #2#{} chance to",
                "turn each scored card {C:money}Gold{}",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 4, y = 4 },
    config = {
        extra = { 
            odds = 4,      -- 1 in 4 chance
            mult = 1,      -- Default multiplier
            multmod = 1,   -- Default multiplier modifier
        }
    },
    rarity = 1,          -- Common joker
    cost = 5,            -- Cost to purchase
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.odds,
                '' .. (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.multmod
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local odds = card.ability.extra.odds or 4
            local chance = 1 / odds
            local probability = G.GAME and G.GAME.probabilities.normal or 1
            chance = chance * probability -- Scale by global probability

            -- Apply the effect to each card in the scoring hand
            for _, scored_card in ipairs(context.scoring_hand) do
                if pseudorandom('solidgold_' .. tostring(scored_card)) < chance then
                    -- Turn the card to gold
                    scored_card:set_ability(G.P_CENTERS.m_gold, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end,
                    }))
                end
            end
        end
    end,
}

----------------------------------------------
------------SOLID GOLD CODE END----------------------

----------------------------------------------
------------BATTLE BUS CODE BEGIN----------------------
SMODS.Atlas{
    key = 'Jokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71.1, --width of one card
    py = 95 -- height of one card
}
local predefined_joker_names = { "Jimbo", "Crac", "Eric", "Emily", "Gavinia", "Ninja", "Lazarbeam", "Duality", "Zorlodo", "Krowe", "Epic Games", "MagmaReef", "90cranker", "ColonelChugJug", "Gatordile81", "JonseyForever35", "PositiveFeels", "TimeToGo80", "QueenBeet74", "AimLikeIdaho", "CrazyPea96", "GetItGotItGood", "JustABitEpic", "PrancingPwnee", "TooManyBeets", "MintElephant26", "AngryDuck51", "CrepeSalad", "GhostChicken12", "KittyCat80", "PrinceWombat", "WalkInThePark66", "BliceCake", "AthenaOrApollo", "DoctorLobby92", "Gooddoggo80", "Kregore73", "SergentSummer", "WildCactusBob", "BraunyBanana", "AtTheBeach321", "DoubleDaring", "Goosezilla13", "LetsBePals23", "ShadowArrow58", "Wondertail", "SoggyCookie26", "BagelBoy82", "DoubleDuel75", "Grandma40", "LewtGoblin7", "Shepard52", "Yeetman57", "AboveMule633", "BellyFlop40", "DoubleRainbow96", "HashtagToad57", "McCucumber71", "ShieldHorse63", "Beebitme", "PurpleCrayon85", "Blackjack31", "DrPlanet", "HeliumHog", "Meshuncle", "ShootyMcGee40", "SweetPenguin16", "SpiffyPowder6866", "BlinkImGone44", "DrumGunnar", "HeyThereFriend81", "Mouthful95", "SilverySilver", "PortableOx", "LootTrooper51", "BoatingIsLife", "ElPollo85", "Hoodwinked12", "N0nDa1ry", "SirTricksALot21", "ASweatyDog", "LousyCentaur", "BoldPrediction", "FlavorCaptain", "HotelBlankets", "NotAPalidome", "SteelGoose18", "&darkBeast&", "BrainInvader", "FlimsyGoat", "HowAreMy90s", "Number141", "TAgYOuRIt9", "BobDobaleena", "CactusDad80", "FlossPatrol82", "iHazHighGround", "ParanoidCactus", "ThermalDragon39", "OldWaterBottle28", "JesterJumps23", "LaughingLance89", "BalatroKing", "PranksterPie42", "CourtFool77", "SillySpecter", "MaskMischief91", "HarlequinHoop", "GrinGoblin", "ClownPrince44", "GiggleGoose66", "QuipMaster7", "FoolishFrolic", "ChuckleCharger", "WittyWanderer", "JestInTime", "LaughingLotus", "ComicCapper", "LoomingLaughter", "TricksterTango", "MockingMask", "FollyFellow", "SnarkyShadow", "MirthMaker42", "SardonicSprout", "CaperCrown", "GleefulGambit", "JugglingJack88", "TwirlingTrixie", "ChortlingChimp", "MerryMadcap", "SnickerSprite", "BalatroBard", "WitfulWraith", "PranceJester55", "LaughterLynx", "FoolhardyFox", "TumbleTrix89", "JovialJoker", "GleeGoblin79", "CourtroomClown", "WhimsicalWill", "RiddleRogue", "CaperingCrane", "MockeryMaven", "GiddyGambler", "JestfulJinx", "HarlequinHustler", "PantomimePrince", "BalatroBelle", "TrickyTroubadour", "SmirkSprite42", "Peter Griffin", "FoolishFencer", "JesterJourney", "MirthfulMage", "GiddyGladiator", "WhimsyWarden", "ChuckleChampion", "PranksterPuppeteer", "TwirlingTinker", "JovialJuggler", "BuffoonBard", "LaughingLancer", "SnickerSquire", "WittyWitch", "ClownishChronicler", "FoolishFlair", "TricksterTide", "GrinGryphon", "JesterJive", "TumbleTeller", "MimicMarauder", "ComicalCorsair", "QuipQueen", "PrankPirate", "LudicrousLynx", "GleamingGagster", "LaughterLynx", "FollyFiend", "SillySorcerer", "MockingMarauder", "CheerfulCoyote", "WitWhisperer", "FancifulFool", "TrixieTroll", "LaughingLad", "MerrymakingMonk", "BalatroBanshee", "CaperingCavalier", "PantomimePug", "SnickerSpecter", "Jolly Joker", "WaggishWitch", "FooleryFox", "SardonicSquire", "ChortlingClown", "TrixieTrickster", "DrollDruid", "PunnyPaladin", "GrinningGolem", "BanterBard", "MockingMimic", "WittyWraith", "GleefulGargoyle" }

SMODS.Joker {
    key = "BattleBus",
    name = "Battle Bus",
    atlas = 'Jokers',
    pos = { x = 0, y = 5 },
    rarity = 1,
    cost = 4,
    config = {
        extra = { jokers = 1, chips = 4, gainedchips = 4 },
    },
    loc_txt = {
        ['en-us'] = {
            name = "Battle Bus",
            text = {
                "Gains {C:attention}#1#{} {C:chips}Chips{} for each Joker when scoring",
                "{C:inactive}Currently{} {C:chips}#2#{} {C:inactive}Chips"
            }
        }
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.gainedchips, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local total_jokers = #predefined_joker_names
            local joker_name = predefined_joker_names[math.random(total_jokers)] or "Jimbo"

            local chips = card.ability.extra.chips  -- Base chips
            local jokers_bonus = card.ability.extra.gainedchips * #G.jokers.cards  -- Bonus chips based on dynamic jokers count

            card.ability.extra.chips = chips + jokers_bonus  -- Total chips calculation

            -- Debug log
			play_sound("fn_bus")
            print("" .. joker_name .. " has thanked the bus driver")
            SMODS.eval_this(card, {message = ("Beep Beep"), colour = G.C.BLUE})

            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        local num_jokers = #G.jokers.cards  -- Get the current number of Jokers
        card.ability.extra.jokers = num_jokers + 1
    end,
    remove_from_deck = function(self, card)
        local num_jokers = #G.jokers.cards  -- Get the current number of Jokers
        card.ability.extra.jokers = num_jokers - 1
    end
}

----------------------------------------------
------------BATTLE BUS CODE END----------------------

----------------------------------------------
------------STW CODE BEGIN----------------------

SMODS.Atlas
{
	key = 'Jokers',
	path = 'Jokers.png',
	px = 71.1,
	py = 95
}

SMODS.Joker
{
	key = 'SaveTheWorld',
	loc_txt = 
	{
		name = 'Save The World',
		text = 
		{
			'For every consecutive round without',
			'buying something at the {C:attention}Shop{},',
			'gain {X:mult,C:white}X0.5{} Mult.',
			'{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}'
		}
	},
	atlas = 'Jokers',
	pos = {x = 3, y = 5},
	rarity = 3,
	cost = 7,
	config = 
	{ 
		extra = 
		{
			Xmult = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return {vars = {center.ability.extra.Xmult}}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return
			{
				card = card,
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
		
		if context.buying_card or context.reroll_shop or context.open_booster then
			card.ability.extra.Xmult=1
			return
			{
				message = 'Reset!',
				colour = G.C.MULT
			}
		end
		
		if context.end_of_round and not context.repetition and not context.individual then
			card.ability.extra.Xmult=card.ability.extra.Xmult+0.5 
			return
			{
				
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
	end
}

----------------------------------------------
------------STW CODE END----------------------

----------------------------------------------
------------THE LOOP CODE BEGIN----------------------

SMODS.Joker{
    key = 'TheLoop',
    loc_txt = {
        ['en-us'] = {
            name = "The Loop",
            text = {
                "{C:green}#3# in #2#{} chance to",
                "give each scored card {C:cry_epic}Echo{}",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 2, y = 6 },
    config = {
        extra = { 
            odds = 4,      -- 1 in 4 chance
            mult = 1,      -- Default multiplier
            multmod = 1,   -- Default multiplier modifier
        }
    },
    rarity = 1,          -- Common joker
    cost = 10,            -- Cost to purchase
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_cry_echo
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.odds,
                '' .. (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.multmod
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local odds = card.ability.extra.odds or 4
            local chance = 1 / odds
            local probability = G.GAME and G.GAME.probabilities.normal or 1
            chance = chance * probability -- Scale by global probability

            -- Apply the effect to each card in the scoring hand
            for _, scored_card in ipairs(context.scoring_hand) do
                if pseudorandom('solidgold_' .. tostring(scored_card)) < chance then
                    -- Turn the card to gold
                    scored_card:set_ability(G.P_CENTERS.m_cry_echo, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end,
                    }))
                end
            end
        end
    end,
}
----------------------------------------------
------------THE LOOP CODE END----------------------

----------------------------------------------
------------CHUG JUG CODE BEGIN----------------------

SMODS.Sound({
	key = "chug",
	path = "chug.ogg",
})

SMODS.Atlas{
    key = 'Jokers', -- Atlas key
    path = 'Jokers.png', -- Path to the atlas file
    px = 71.1, -- Width of one card
    py = 95 -- Height of one card
}

SMODS.Joker{
    key = 'ChugJug',
    loc_txt = {
        ['en-us'] = {
            name = "Chug Jug",
            text = {
                "When {C:attention}Blind{} starts, stores your {C:chips}Hands{}",
                "If you run out of {C:chips}Hands{}, restore {C:chips}Hands{} to the stored value",
                "{C:mult}Self-destruct{} when triggered",
                "{C:chips}#1# {C:inactive}Stored{} {C:chips}hands{}"
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 3, y = 7 },
    config = {
        extra = { 
            hands = 0 -- Default hands
        }
    },
    rarity = 2,          -- Uncommon joker
    cost = 5,            -- Cost to purchase
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        -- Dynamically display the stored hands
        local stored_hands = self.config.extra.initial_hands or self.config.extra.hands
        return {
            vars = { stored_hands }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local round = G.GAME.current_round

            -- Store the initial hands at the start of the round
            if round.hands_played == 0 and not self.config.extra.initial_hands then
                self.config.extra.initial_hands = round.hands_left + 1
            end
            
            -- Check if hands are depleted and the player can't meet the blind
            if round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips then
				play_sound("fn_chug")
                -- Restore hands to the stored value
                local restore_value = self.config.extra.initial_hands or self.config.extra.hands
                round.hands_left = restore_value

                --trigger self-destruction
                card:start_dissolve()
            end
        end
    end
}
----------------------------------------------
------------CHUG JUG CODE END----------------------

----------------------------------------------
------------BIG POT CODE BEGIN----------------------
SMODS.Joker{
    key = 'BigPot',
    loc_txt = {
        ['en-us'] = {
            name = "Big Pot",
            text = {
                "When {C:attention}Blind{} starts, stores {C:attention}Half{} your {C:chips}Hands{}",
                "If you run out of {C:chips}Hands{}, restore {C:chips}Hands{} to the stored value",
                "{C:mult}Self-destruct{} when triggered",
                "{C:chips}#1# {C:inactive}Stored{} {C:chips}hands{}"
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 4, y = 7 },
    config = {
        extra = { 
            hands = 0 -- Default hands
        }
    },
    rarity = 1,          -- Uncommon joker
    cost = 2,            -- Cost to purchase
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        -- Dynamically display the stored hands
        local stored_hands = self.config.extra.initial_hands or self.config.extra.hands
        return {
            vars = { stored_hands }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local round = G.GAME.current_round

            -- Store the initial hands at the start of the round
            if round.hands_played == 0 and not self.config.extra.initial_hands then
                self.config.extra.initial_hands = round.hands_left / 2 +0.5
            end
            
            -- Check if hands are depleted and the player can't meet the blind
            if round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips then
				play_sound("fn_chug")
                -- Restore hands to the stored value
                local restore_value = self.config.extra.initial_hands or self.config.extra.hands
                round.hands_left = restore_value

                --trigger self-destruction
                card:start_dissolve()
            end
        end
    end
}

----------------------------------------------
------------BIG POT CODE END----------------------

----------------------------------------------
------------MINI CODE BEGIN----------------------

SMODS.Joker{
    key = 'Mini',
    loc_txt = {
        ['en-us'] = {
            name = "Mini Shield",
            text = {
                "When {C:attention}Blind{} starts, stores a {C:attention}Fourth{} of your {C:chips}Hands{}",
                "If you run out of {C:chips}Hands{}, restore {C:chips}Hands{} to the stored value",
                "{C:mult}Self-destruct{} when triggered",
                "{C:chips}#1# {C:inactive}Stored{} {C:chips}hands{}"
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 0, y = 8 },
    config = {
        extra = { 
            hands = 0 -- Default hands
        }
    },
    rarity = 1,          -- Uncommon joker
    cost = 1,            -- Cost to purchase
    blueprint_compat = false,

    loc_vars = function(self, info_queue, card)
        -- Dynamically display the stored hands
        local stored_hands = self.config.extra.initial_hands or self.config.extra.hands
        return {
            vars = { stored_hands }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local round = G.GAME.current_round

            -- Store the initial hands at the start of the round
            if round.hands_played == 0 and not self.config.extra.initial_hands then
                self.config.extra.initial_hands = round.hands_left / 4 +0.25
            end
            
            -- Check if hands are depleted and the player can't meet the blind
            if round.hands_left <= 0 and G.GAME.chips < G.GAME.blind.chips then
				play_sound("fn_chug")
                -- Restore hands to the stored value
                local restore_value = self.config.extra.initial_hands or self.config.extra.hands
                round.hands_left = restore_value

                --trigger self-destruction
                card:start_dissolve()
            end
        end
    end
}
----------------------------------------------
------------MINI CODE END----------------------
SMODS.Joker {
    key = 'Vbucks',
    loc_txt = {
        ['en-us'] = {
            name = "Vbucks",
            text = {
                "{C:green}#3#{} in {C:green}#2#{} chance to",
                "gain {C:money}$#1#{}",
                "when {C:attention}Blind{} starts",
            }
        }
    },
    atlas = 'Jokers',
    pos = { x = 1, y = 8 },
    config = {
        extra = { 
            dollars = 10,   -- Fixed Money Granted
            odds = 3,       -- Odds of getting the money
        }
    },
    rarity = 1,            -- Common joker
    cost = 10,             -- Cost to purchase
    blueprint_compat = true,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.dollars,
                card.ability.extra.odds,
                '' .. (G.GAME and G.GAME.probabilities.normal or 1),
            }
        }
    end,

    calculate = function(self, card, context)
        -- Check if the Blind effect is starting and that conditions are met (no blueprint card or slicing)
        if context.setting_blind and not (context.blueprint_card or self).getting_sliced then
            local money = card.ability.extra.dollars
            local odds = card.ability.extra.odds

            -- Check if you win the money
            if pseudorandom('Vbucks') < G.GAME.probabilities.normal / odds then
                if money > 0 then
                    ease_dollars(money)
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + money
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    return {
                        message = localize('$') .. money,
                        dollars = money,
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end
}






----------------------------------------------
------------GLASSES CODE BEGIN----------------------

SMODS.Consumable{
    key = 'LTMGlasses', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 0, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Eric\'s 3D Glasses', -- name of card
        text = { -- text of card
            'Everything has so much more depth',
            'Apply {C:mult}A{}{C:chips}n{}{C:mult}a{}{C:chips}g{}{C:mult}l{}{C:chips}y{}{C:mult}p{}{C:chips}h{}{C:mult}i{}{C:chips}c{} to up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 3, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_ortalab_anaglyphic
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        if G and G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                G.hand.highlighted[i]:set_edition({ortalab_anaglyphic = true},true)
            end
        end
    end,
}

----------------------------------------------
------------GLASSES CODE END----------------------

----------------------------------------------
------------BLOOD CODE BEGIN----------------------

SMODS.Consumable{
    key = 'LTMBlood', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 1, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Eric\'s Blood', -- name of card
        text = { -- text of card
            'You REALLY shouldn\'t touch that',
            'Apply {C:dark_edition}Glitched{} to up to {C:attention}#1#{} selected Cards, Jokers, or Consumables',
        }
    },
    config = {
        extra = {
            cards = 4, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_glitched
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards -1}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and card.ability and card.ability.extra and card.ability.extra.cards then
            local maxCards = card.ability.extra.cards
            local highlightedCardsCount = 0

            -- Count highlighted cards in hand, jokers, consumables, and pack cards
            highlightedCardsCount = highlightedCardsCount + #G.hand.highlighted
            highlightedCardsCount = highlightedCardsCount + #G.jokers.highlighted
            highlightedCardsCount = highlightedCardsCount + #G.consumeables.highlighted
            highlightedCardsCount = highlightedCardsCount + (G.pack_cards and #G.pack_cards.highlighted or 0)

            -- Check if the highlighted cards are within the allowed limit
            if highlightedCardsCount > 0 and highlightedCardsCount <= maxCards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        local highlightedCards = {}  -- Collect all the highlighted cards from each category

        -- Add selected cards from each category to the list
        for _, category in ipairs({G.hand.highlighted, G.jokers.highlighted, G.consumeables.highlighted, G.pack_cards and G.pack_cards.highlighted or {}}) do
            for i = 1, #category do
                table.insert(highlightedCards, category[i])
            end
        end

        -- Apply the effect to the selected cards, jokers, and consumables
        for i = 1, math.min(#highlightedCards, card.ability.extra.cards) do
            local cardToModify = highlightedCards[i]
            cardToModify:set_edition({cry_glitched = true}, true)
        end
    end,
}


----------------------------------------------
------------BLOOD CODE END----------------------

----------------------------------------------
------------PERK UP CODE BEGIN----------------------

SMODS.Sound({
	key = "perk",
	path = "perk.ogg",
})

SMODS.ConsumableType{
    key = 'LTMConsumableType', -- consumable type key

    collection_rows = {4,5}, -- amount of cards in one page
    primary_colour = G.C.PURPLE, -- first color
    secondary_colour = G.C.DARK_EDITION, -- second color
    loc_txt = {
        collection = 'LTM Cards', -- name displayed in collection
        name = 'LTM Cards', -- name displayed in badge
        undiscovered = {
            name = 'Hidden LTM', -- undiscovered name
            text = {'you dont know the', 'playlist id'} -- undiscovered text
        }
    },
    shop_rate = 1, -- rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'LTMConsumableType', -- must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}

SMODS.Consumable{
    key = 'LTMPerk', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 2, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Perk Up', -- name of card
        text = { -- text of card
            'Resource used to upgrade Cards',
			'Found in the Store or summoned by {C:mult}Crac',
            'Apply a random enhancement to up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 5, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
		play_sound("fn_perk")
        -- List of possible enhancements
        local enhancements = {
            G.P_CENTERS.m_bonus, G.P_CENTERS.m_mult, G.P_CENTERS.m_wild, G.P_CENTERS.m_lucky,
            G.P_CENTERS.m_glass, G.P_CENTERS.m_steel, G.P_CENTERS.m_stone, G.P_CENTERS.m_gold,
			G.P_CENTERS.m_ortalab_post, G.P_CENTERS.m_ortalab_bent, G.P_CENTERS.m_ortalab_sand,
			G.P_CENTERS.m_ortalab_rusty, G.P_CENTERS.m_ortalab_ore, G.P_CENTERS.m_ortalab_iou, G.P_CENTERS.m_ortalab_recycled,
			G.P_CENTERS.m_snow_platinum_card, G.P_CENTERS.m_cry_echo, G.P_CENTERS.m_fn_Crystal, G.P_CENTERS.m_fn_Wood,
			G.P_CENTERS.m_fn_Brick, G.P_CENTERS.m_fn_Metal,
        }

        if G and G.hand and G.hand.highlighted then
            for k, v in ipairs(G.hand.highlighted) do
                -- Randomly select an enhancement for each card
                local random_enhancement = enhancements[math.random(1, #enhancements)] or G.P_CENTERS.m_fn_Wood
                
                -- Apply the randomly selected enhancement to the current card
                v:set_ability(random_enhancement, nil, true)

                -- Trigger the event to juice up the card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()  -- Calling juice_up on the card
                        return true
                    end
                }))
            end
        end
    end,
}

----------------------------------------------
------------PERK UP CODE END----------------------

----------------------------------------------
------------SUPERCHARGER CODE BEGIN----------------------

SMODS.ConsumableType{
    key = 'LTMConsumableType', -- consumable type key

    collection_rows = {4, 5}, -- amount of cards in one page
    primary_colour = G.C.PURPLE, -- first color
    secondary_colour = G.C.DARK_EDITION, -- second color
    loc_txt = {
        collection = 'LTM Cards', -- name displayed in collection
        name = 'LTM Cards', -- name displayed in badge
        undiscovered = {
            name = 'Hidden LTM', -- undiscovered name
            text = {'you dont know the', 'playlist id'} -- undiscovered text
        }
    },
    shop_rate = 1, -- rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'LTMConsumableType', -- must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}

SMODS.Consumable{
    key = 'LTMSupercharge', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 3, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Card Supercharger', -- name of card
        text = { -- text of card
            'Used to promote cards',
			'Found in the Store or summoned by {C:mult}Crac',
            'add a random seal to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 2, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        for i, v in pairs(G.hand.highlighted) do
            -- Generate a pseudorandom number between 0 and 1
            local seal_type = pseudorandom(pseudoseed('supercharge')) 
            
            -- Assign a random seal based on the generated number
            if seal_type > 0.875 then 
                v:set_seal('Red', true)
            elseif seal_type > 0.75 then 
                v:set_seal('Blue', true)
            elseif seal_type > 0.625 then 
                v:set_seal('Gold', true)
            elseif seal_type > 0.5 then 
                v:set_seal('Purple', true)
            elseif seal_type > 0.375 then 
                v:set_seal('curs_curseddice_seal', true)
            elseif seal_type > 0.25 then 
                v:set_seal('dice_seal', true)
            elseif seal_type > 0.175 then 
                v:set_seal('cry_azure', true)
            elseif seal_type > 0.1 then 
                v:set_seal('cry_green', true)
            else 
                v:set_seal('cere_green_seal', true)
            end
            
            -- Add an event to "juice up" the card after sealing
            G.E_MANAGER:add_event(Event({
                func = function()
                    v:juice_up(0.3, 0.4)
                    return true
                end
            }))
        end
    end,
}
----------------------------------------------
------------SUPERCHARGER CODE END----------------------

----------------------------------------------
------------DOUBLE OR NOTHING CODE BEGIN----------------------
SMODS.Consumable{
    key = 'DoubleOrNothing', -- key
    set = 'Spectral', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 4, y = 1}, -- position in atlas
    loc_txt = {
        name = 'Double Or Nothing!', -- name of card
        text = { -- text of card
            'Has a {C:green,E:1,S:1.1}#1# in #2#{} chance to give 2 {C:spectral}Spectral{} packs else give {C:red}nothing{}.',
        },
    },
    config = {
        extra = { odds = 2 }, -- Configuration: odds of success (set to 2 for 50% chance)
        no_pool_flag = 'gamble',
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
        return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds}}
    end,
    use = function(self, card, area, copier)
        G.GAME.pool_flags.gamble = true -- Ensure 'gamble' flag is set

        -- Use the game's internal roll value (assuming it's already handled)
        if pseudorandom('mrbeast') < G.GAME.probabilities.normal/card.ability.extra.odds then
            -- Success: Grant 2 ethereal tags
            add_tag(Tag('tag_ethereal'))
            add_tag(Tag('tag_ethereal'))

            -- Display success message on the consumable
            SMODS.eval_this('card_eval_status_text', {
                card = card, -- Reference the consumable card
                message = "DOUBLE!", -- Display "DOUBLE!" message
                colour = G.C.GREEN,
            })
        else
            -- Failure: No tags granted
            -- Display failure message on the consumable
            SMODS.eval_this('card_eval_status_text', {
                card = card, -- Reference the consumable card
                message = "NOTHING!", -- Display "NOTHING!" message
                colour = G.C.RED,
            })
        end
    end,
    can_use = function(self, card)
        return true
    end,
}


----------------------------------------------
------------DOUBLE OR NOTHING CODE END----------------------

----------------------------------------------
------------CARD FLIP CODE BEGIN----------------------
SMODS.ConsumableType{
    key = 'LTMConsumableType', -- consumable type key

    collection_rows = {4, 5}, -- amount of cards in one page
    primary_colour = G.C.PURPLE, -- first color
    secondary_colour = G.C.DARK_EDITION, -- second color
    loc_txt = {
        collection = 'LTM Cards', -- name displayed in collection
        name = 'LTM Cards', -- name displayed in badge
        undiscovered = {
            name = 'Hidden LTM', -- undiscovered name
            text = {'you dont know the', 'playlist id'} -- undiscovered text
        }
    },
    shop_rate = 1, -- rate in shop out of 100
}

SMODS.UndiscoveredSprite{
    key = 'LTMConsumableType', -- must be the same key as the consumabletype
    atlas = 'Jokers',
    pos = {x = 0, y = 0}
}

SMODS.Consumable{
    key = 'LTMStormFlip', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 2, y = 3}, -- position in atlas
    loc_txt = {
        name = 'Card Flip', -- name of card
        text = { -- text of card
            'Flip up to {C:attention}#1#{} selected Cards, Jokers, or Consumables',
        }
    },
    config = {
        extra = {
            cards = 4, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards -1}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and card.ability and card.ability.extra and card.ability.extra.cards then
            local maxCards = card.ability.extra.cards
            local highlightedCardsCount = 0

            -- Count highlighted cards in hand, jokers, consumables, and pack cards
            highlightedCardsCount = highlightedCardsCount + #G.hand.highlighted
            highlightedCardsCount = highlightedCardsCount + #G.jokers.highlighted
            highlightedCardsCount = highlightedCardsCount + #G.consumeables.highlighted
            highlightedCardsCount = highlightedCardsCount + (G.pack_cards and #G.pack_cards.highlighted or 0)

            -- Check if the highlighted cards are within the allowed limit
            if highlightedCardsCount > 0 and highlightedCardsCount <= maxCards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        local highlightedCards = {}  -- Collect all the highlighted cards from each category

        -- Add selected cards from each category to the list
        for _, category in ipairs({G.hand.highlighted, G.jokers.highlighted, G.consumeables.highlighted, G.pack_cards and G.pack_cards.highlighted or {}}) do
            for i = 1, #category do
                table.insert(highlightedCards, category[i])
            end
        end

        -- Flip the selected cards, up to the maximum allowed
        for i = 1, math.min(#highlightedCards, card.ability.extra.cards) do
            local cardToFlip = highlightedCards[i]
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    cardToFlip:flip()  -- Flip the card
                    play_sound('tarot1', 1.1, 0.6)  -- Play sound effect
                    return true
                end
            }))
        end
    end,
}

----------------------------------------------
------------CARD FLIP CODE END----------------------

----------------------------------------------
------------KINETIC ORE CODE BEGIN----------------------

SMODS.Consumable{
    key = 'LTMKinetic', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 0, y = 4}, -- position in atlas
    loc_txt = {
        name = 'Kinetic Ore', -- name of card
        text = { -- text of card
            'A powerful and durable ore that can be found in many realities',
            'Apply {C:inactive}Stone{} and {C:dark_edition}Astral{} to up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 1, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        info_queue[#info_queue + 1] = G.P_CENTERS.e_cry_astral
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        if G and G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                -- Set the edition to Stone first
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_stone, nil, true)
                
                -- Then apply the enhancement to Astral
                local v = G.hand.highlighted[i]
                v:set_edition({cry_astral = true}, true)
                
                -- Add an event to juice up the card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
}

----------------------------------------------
------------KINETIC ORE CODE END----------------------

----------------------------------------------
------------LAUNCH PAD CODE BEGIN----------------------

SMODS.Consumable{ 
    key = 'LTMLaunchPad', -- key
    set = 'LTMConsumableType', -- the set of the card
    atlas = 'Jokers', -- atlas
    pos = {x = 1, y = 4}, -- position in atlas
    loc_txt = {
        name = 'Launch Pad', -- name of the consumable
        text = { 
            'Draw {C:attention}#1#{} additional cards'
        }
    },
    config = {
        extra = {
            cards = 2, -- configurable value (number of cards to draw)
        }
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        -- Use the card’s dynamically updated value instead of the fixed config value
        local cards_to_draw = card and card.ability and card.ability.extra and card.ability.extra.cards or self.config.extra.cards
        if G and G.hand and G.hand.highlighted then
            if #G.hand.highlighted >= 0 and #G.hand.highlighted <= cards_to_draw then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        -- Use the card’s dynamically updated value instead of the fixed config value
        local cards_to_draw = card and card.ability and card.ability.extra and card.ability.extra.cards or self.config.extra.cards
        if G and G.hand then
            -- Use the Launch Pad to draw extra cards
            G.FUNCS.draw_from_deck_to_hand(cards_to_draw)
        end
    end,
}

----------------------------------------------
------------LAUNCH PAD CODE END----------------------

----------------------------------------------
------------DECOY GRENADE CODE BEGIN---------------------

SMODS.Sound({
	key = "decoy",
	path = "decoy.ogg",
})

SMODS.Consumable{
    key = 'LTMDecoy',
    set = 'LTMConsumableType',
    atlas = 'Jokers',
    pos = {x = 1, y = 5},
    loc_txt = {
        name = 'Decoy Grenade',
        text = {
            'Create {C:attention}#2#{} temporary {C:dark_edition}Negative',
            'copies of selected up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = { cards = 1, copies = 3 },
        local_d6_sides = "cryptid compat to prevent it reset my config upon use ;( ;("
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
		if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards, center.ability.extra.copies}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
		play_sound("fn_decoy")
        -- Ensure the creation configuration is initialized
        G.deck.config.wonderMagnum_betmma = G.deck.config.wonderMagnum_betmma or {}

        -- Add an event to execute after a delay
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local highlighted_cards = G.hand.highlighted
                if not highlighted_cards or #highlighted_cards == 0 then
                    return false -- Exit if no cards are highlighted
                end

                for _, selected_card in ipairs(highlighted_cards) do
                    for i = 1, card.ability.extra.copies do
                        local new_card = copy_card(selected_card)
                        new_card:set_edition({negative = true}, true)
                        new_card:set_eternal(true)
                        new_card:add_to_deck()
                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        table.insert(G.playing_cards, new_card)
                        G.hand:emplace(new_card)
                        new_card:start_materialize(nil, _first_dissolve)
                        table.insert(G.deck.config.wonderMagnum_betmma, new_card.unique_val)
                        local new_cards = {}
                        new_cards[#new_cards+1] = new_card
                        playing_card_joker_effects(new_cards)
                    end
                end
                return true
            end
        }))
    end,
}

----------------------------------------------
------------DECOY GRENADE CODE END----------------------

----------------------------------------------
------------LEFT HANDED DEATH CODE BEGIN----------------------

SMODS.Consumable{
    key = 'LeftHandedDeath', -- key
    set = 'Tarot', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 2, y = 5}, -- position in atlas
    loc_txt = {
        name = 'Death', -- name of card
        text = { -- text of card
            'Select {C:attention:}#1#{} cards,',
            'Convert the {C:attention:}right{} card',
            'into the {C:attention} left{} card',
            '{C:inactive} [drag to rearrange]',
        },
    },
    config = {
        extra = { cards = 2 },
    },
    loc_vars = function(self, info_queue, center)
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self)
        -- Check if highlighted cards exist
        if not G.hand.highlighted or #G.hand.highlighted == 0 then
            return false
        end

        -- Find the leftmost card
        local leftmost = G.hand.highlighted[1]
        for i = 1, #G.hand.highlighted do
            if G.hand.highlighted[i].T.x < leftmost.T.x then
                leftmost = G.hand.highlighted[i]
            end
        end

        -- Convert all highlighted cards into the leftmost card
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    if G.hand.highlighted[i] ~= leftmost then
                        copy_card(leftmost, G.hand.highlighted[i])
                    end
                    return true
                end
            }))
        end
        return true
    end,
}

----------------------------------------------
------------LEFT HANDED DEATH CODE END----------------------

----------------------------------------------
------------POLYCHROME SPLASH CODE BEGIN----------------------

SMODS.Consumable{
    key = 'LTMPolychromeSplash',
    set = 'LTMConsumableType',
    atlas = 'Jokers',
    pos = {x = 4, y = 5},
    loc_txt = {
        name = 'Polychrome Splash',
        text = {
            'A dangerous organic living metal that consumes and replicates.',
            'Responsible for nearly destroying a whole reality.',
            'Converts {C:attention}#1#{} random thing into {C:dark_edition}polychrome.',
			'50% chance to destroy it instead',
            '{C:inactive}You wouldn\'t open this... right?'
        },
    },
    config = {
        extra = { cards = 1 },
    },
    loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        if center and center.ability and center.ability.extra then
            return { vars = { center.ability.extra.cards } }
        end
        return { vars = {} }
    end,
    can_use = function(self, card)
        return G and (#G.hand.cards > 0 or #G.jokers.cards > 0 or #G.consumeables.cards > 0)
    end,
    use = function(self, card, area, copier)
		play_sound("glass1")
        if not (G and card and card.ability and card.ability.extra) then
            print("Invalid game state or consumable configuration.")
            return
        end

        local maxCards = card.ability.extra.cards or 1
        local potentialTargets = {}

        -- Collect cards from hand
        if G.hand then
            for _, target in ipairs(G.hand.cards) do
                table.insert(potentialTargets, target)
            end
        end

        -- Collect Jokers
        if G.jokers then
            for _, target in ipairs(G.jokers.cards) do
                table.insert(potentialTargets, target)
            end
        end

        -- Collect Consumables
        if G.consumeables then
            for _, target in ipairs(G.consumeables.cards) do
                table.insert(potentialTargets, target)
            end
        end


        if #potentialTargets == 0 then
            print("No valid targets for Polychrome Splash.")
            return
        end

        -- Apply either Polychrome edition or dissolve with 50% chance
        local targetCount = math.min(#potentialTargets, maxCards)
        local selectedTargets = {}

        for i = 1, targetCount do
            local randomIndex = math.random(#potentialTargets)
            local target = potentialTargets[randomIndex]
            if math.random() > 0.5 then
                target:set_edition({polychrome = true}, true)
            else
				play_sound("slice1")
				play_sound("glass4")
                target:start_dissolve()  -- Initiates card dissolution
            end
            table.remove(potentialTargets, randomIndex)
        end
    end,
}

----------------------------------------------
------------POLYCHROME SPLASH CODE END----------------------

----------------------------------------------
------------FRACTURE CODE BEGIN----------------------

SMODS.Atlas({ key = "Blinds", atlas_table = "ANIMATION_ATLAS", path = "Blinds.png", px = 34, py = 34, frames = 21 })

SMODS.Blind {
    loc_txt = {
        name = 'Fracture',
        text = { 'All played cards are destroyed' }
    },
    key = 'Fracture',
    name = 'Fracture',
    config = {},
    boss = { min = 1, max = 10, hardcore = true },
    boss_colour = HEX("672A62"),
    atlas = "Blinds",
    pos = { x = 0, y = 0 },
    dollars = 5,

    press_play = function (self)
    G.E_MANAGER:add_event(Event({
        func = function()
            -- Loop through the played cards in reverse order
            for i = #G.play.cards, 1, -1 do
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.play.cards[i]:start_dissolve({ G.C.BLUE }, nil, 1.6, false)
                        return true
                    end,
                    delay = 0.5,
                }), 'base')
            end
            return true
        end
    }))
    return true
end
}

----------------------------------------------
------------FRACTURE CODE END----------------------

----------------------------------------------
------------CRYSTAL CODE BEGIN----------------------

SMODS.Enhancement({
    loc_txt = {
        name = 'Crystal',
        text = {
            '{X:mult,C:white}X#1#{} Mult {C:chips}#2#{} Chips',
            'no rank or suit',
			'{C:green}#4# in #3#{} chance this',
            'card is {C:red}destroyed',
            'when triggered',
        },
    },
    key = "Crystal",
    atlas = "Jokers",
    pos = {x = 0, y = 6},
    discovered = false,
    no_rank = true,
    no_suit = true,
    replace_base_card = true,
    always_scores = true,
    config = {extra = {base_x = 1.5, chips = 50, odds = 6}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then
            info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'}
        end
        local card_ability = card and card.ability or self.config
        return {
            vars = {
                card_ability.extra.base_x,
                card_ability.extra.chips,
                card.ability.extra.odds,
				G.GAME.probabilities.normal
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            -- Apply the enhancement effects
            effect.x_mult = self.config.extra.base_x
            effect.chips = self.config.extra.chips
            
            -- Chance to shatter the card
            if pseudorandom('CrystalShatter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Shatter the card
                card:shatter()
            end
        end
    end
})

----------------------------------------------
------------CRYSTAL CODE END----------------------

----------------------------------------------
------------RAINBOW CODE BEGIN----------------------
SMODS.Consumable{
    key = 'LTMRainbow', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 1, y = 6}, -- position in atlas
    loc_txt = {
        name = 'Rainbow Crystal', -- name of card
        text = { -- text of card
            'An ore never meant to exist',
			'yet somehow it does',
			'after {C:cry_epic}SOMEONE{} duped them endlessly',
            'Apply {C:inactive}Crystal{} and {C:dark_edition}Polychrome{} to up to {C:attention}#1#{} selected cards',
        }
    },
    config = {
        extra = {
            cards = 1, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fn_crystal
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        if G and G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                -- Set the edition to Crystal first
                G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_fn_Crystal, nil, true)
                
                -- Then apply the enhancement to Polychrome
                local v = G.hand.highlighted[i]
                v:set_edition({polychrome = true}, true)
                
                -- Add an event to juice up the card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        v:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
}
----------------------------------------------
------------RAINBOW CODE END----------------------

----------------------------------------------
------------WOOD CODE BEGIN----------------------
SMODS.Enhancement({
    loc_txt = {
        name = 'Wood',
        text = {
            '{X:mult,C:white}X#1#{} Mult {C:chips}#2#{} Chips',
        },
    },
    key = "Wood",
    atlas = "Jokers",
    pos = {x = 3, y = 6},
    discovered = false,
    no_rank = false,
    no_suit = false,
    replace_base_card = false,
    always_scores = false,
    config = {extra = {base_x = 1.2, chips = 15,}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then
            info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'}
        end
        local card_ability = card and card.ability or self.config
        return {
            vars = {
                card_ability.extra.base_x,
                card_ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            -- Apply the enhancement effects
            effect.x_mult = self.config.extra.base_x
            effect.chips = self.config.extra.chips
        end
    end
})
----------------------------------------------
------------WOOD CODE END----------------------

----------------------------------------------
------------BRICK CODE BEGIN----------------------

SMODS.Sound({
	key = "gnome",
	path = "gnome.ogg",
})

SMODS.Enhancement({
    loc_txt = {
        name = 'Brick',
        text = {
            '{X:mult,C:white}X#1#{} Mult {C:chips}#2#{} Chips',
            '{C:green}#4# in #3#{} chance to',
            'summon a {C:red}Gnome',
        },
    },
    key = "Brick",
    atlas = "Jokers",
    pos = {x = 4, y = 6},
    discovered = false,
    no_rank = false,
    no_suit = false,
    replace_base_card = false,
    always_scores = false,
    config = {
        extra = {
            base_x = 1.3, -- Multiplier effect
            chips = 40,   -- Chip bonus
            odds = 100    -- Odds for gnome 
        },
    },
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then
            info_queue[#info_queue + 1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'}
        end
        local card_ability = card and card.ability or self.config
        return {
            vars = {
                card_ability.extra.base_x,           -- Multiplier
                card_ability.extra.chips,           -- Chip bonus
                card_ability.extra.odds,            -- Odds for gnome 
                G.GAME.probabilities.normal         -- Base probability
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            -- Apply the enhancement effects
            effect.x_mult = self.config.extra.base_x
            effect.chips = self.config.extra.chips
            
            -- Chance to summon a gnome
            if pseudorandom('Gnome') < G.GAME.probabilities.normal / card.ability.extra.odds then
                -- Summon the gnome
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local c = create_card(
                            nil, G.consumeables, nil, nil, nil, nil, 'c_fn_Gnome', 'sup'
                        )
                        c:add_to_deck()
                        G.consumeables:emplace(c)
						play_sound("fn_gnome")
                        return true
                    end
                }))
            end
        end
    end,
})

----------------------------------------------
------------BRICK CODE END----------------------

----------------------------------------------
------------GNOME CODE BEGIN----------------------

SMODS.Consumable{
    key = 'Gnome', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 0, y = 7}, -- position in atlas
    loc_txt = {
        name = 'Gnome', -- name of card
        text = { -- text of card
            'Has a {C:green,E:1,S:1.1}#1# in #2#{} chance to',
			'give an eternal copy of {C:cry_epic}Eric{}, {C:mult}Crac{}, {C:cry_epic}Emily{}, or {C:green,E:1,S:1.1}Zorlodo{}',
			'else give {C:red}nothing{}.',
        },
    },
    config = {
        extra = { odds = 10 }, -- Configuration: odds of success (set to 2 for 50% chance)
        no_pool_flag = 'gamble',
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds}}
    end,
    use = function(self, card, area, copier)
        G.GAME.pool_flags.gamble = true -- Ensure 'gamble' flag is set
		play_sound("fn_gnome")

        -- Use the game's internal roll value (assuming it's already handled)
        if pseudorandom('FriendsGamble') < G.GAME.probabilities.normal / card.ability.extra.odds then
            -- List of possible jokers
            local jokers = {'j_fn_Crac', 'j_fn_Eric', 'j_fn_Emily', 'j_fn_Zorlodo'}

            -- Randomly select one joker to add
            local selected_joker = jokers[math.random(#jokers)]
            joker_add(selected_joker)

            -- Display success message on the consumable
            SMODS.eval_this('card_eval_status_text', {
                card = card, -- Reference the consumable card
                message = "Friends!", -- Display "Friends!" message
                colour = G.C.PURPLE,
            })
        else
            -- Failure: No joker granted
            -- Display failure message on the consumable
            SMODS.eval_this('card_eval_status_text', {
                card = card, -- Reference the consumable card
                message = "NOTHING!", -- Display "NOTHING!" message
                colour = G.C.RED,
            })
        end
    end,
    can_use = function(self, card)
        return true
    end,
}
----------------------------------------------
------------GNOME CODE END----------------------

----------------------------------------------
------------METAL CODE BEGIN----------------------
SMODS.Enhancement({
    loc_txt = {
        name = 'Metal',
        text = {
            '{X:mult,C:white}X#1#{} Mult {C:chips}#2#{} Chips',
        },
    },
    key = "Metal",
    atlas = "Jokers",
    pos = {x = 1, y = 7},
    discovered = false,
    no_rank = false,
    no_suit = false,
    replace_base_card = false,
    always_scores = false,
    config = {extra = {base_x = 1.5, chips = 60,}},
    loc_vars = function(self, info_queue, card)
        if card and Ortalab.config.artist_credits then
            info_queue[#info_queue+1] = {generate_ui = ortalab_artist_tooltip, key = 'gappie'}
        end
        local card_ability = card and card.ability or self.config
        return {
            vars = {
                card_ability.extra.base_x,
                card_ability.extra.chips,
            }
        }
    end,
    calculate = function(self, card, context, effect)
        if context.cardarea == G.play and not context.repetition then
            -- Apply the enhancement effects
            effect.x_mult = self.config.extra.base_x
            effect.chips = self.config.extra.chips
        end
    end
})

----------------------------------------------
------------METAL CODE END----------------------
SMODS.Sound({
	key = "wood",
	path = "wood.ogg",
})
SMODS.Sound({
	key = "brick",
	path = "brick.ogg",
})
SMODS.Sound({
	key = "metal",
	path = "metal.ogg",
})

SMODS.Consumable{
    key = 'LTMBlueprint', -- key
    set = 'LTMConsumableType', -- the set of the card: corresponds to a consumable type
    atlas = 'Jokers', -- atlas
    pos = {x = 2, y = 7}, -- position in atlas
    loc_txt = {
        name = 'Blueprint', -- name of card
        text = { -- text of card
            'Enhances {C:attention}#1#{} selected cards',
            'into {C:money}Wood{}, {C:mult}Brick{}, or {C:inactive}Metal{}.',
        }
    },
    config = {
        extra = {
            cards = 1, -- configurable value
        }
    },
    loc_vars = function(self, info_queue, center)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fn_Wood
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fn_Brick
        info_queue[#info_queue + 1] = G.P_CENTERS.m_fn_Metal
        if center and center.ability and center.ability.extra then
            return {vars = {center.ability.extra.cards}} 
        end
        return {vars = {}}
    end,
    can_use = function(self, card)
        if G and G.hand and G.hand.highlighted and card.ability and card.ability.extra and card.ability.extra.cards then
            if #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.extra.cards then
                return true
            end
        end
        return false
    end,
    use = function(self, card, area, copier)
        if G and G.hand and G.hand.highlighted then
            for i = 1, #G.hand.highlighted do
                -- Randomly select an enhancement type
                local enhancement_type = math.random(3) -- 1 for Wood, 2 for Brick, 3 for Metal
                
                -- Assign the enhancement based on the random type
                if enhancement_type == 1 then
					play_sound("fn_wood")
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_fn_Wood, nil, true)
                elseif enhancement_type == 2 then
					play_sound("fn_brick")
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_fn_Brick, nil, true)
                elseif enhancement_type == 3 then
					play_sound("fn_metal")
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS.m_fn_Metal, nil, true)
                end
                
                -- Add an event to juice up the card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand.highlighted[i]:juice_up()
                        return true
                    end
                }))
            end
        end
    end,
}

----------------------------------------------
------------CRAC DECK CODE BEGIN----------------------
-- Add Joker
function joker_add(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)


        SMODS.Stickers["eternal"]:apply(j, true)

    end
end

SMODS.Back{
    name = 'Crac Deck',
    key = 'CracDeck',
    atlas = 'Jokers',
    pos = {x = 1, y = 2},
    loc_txt = {
        name = 'Crac Deck',
        text = {
            '{C:attention} 13 hand size',
            'Start with 4 {C:red}Crac\'s{} and {C:buf_spc}Infinity{}',
            '{C:attention}The Arcana is the means by which all is revealed{}.',
        },
    },

    config = {
        hand_size = 5
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add Crac's
                joker_add('j_fn_Crac')
				joker_add('j_fn_Crac')
				joker_add('j_fn_Crac')
				joker_add('j_fn_Crac')
				joker_add('j_snow_infinityDice')

                return true
            end
        }))
    end,

}
----------------------------------------------
------------CRAC DECK CODE END----------------------

----------------------------------------------
------------ERIC DECK CODE BEGIN----------------------
function joker_add(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)


        SMODS.Stickers["eternal"]:apply(j, true)

    end
end

SMODS.Back{
    name = 'Eric Deck',
    key = 'EricDeck',
    atlas = 'Jokers',
    pos = {x = 0, y = 2},
    loc_txt = {
        name = 'Eric Deck',
        text = {
            'Start with {C:cry_epic}Eric',
        },
    },

    config = {
        hand_size = 0
    },

    apply = function ()
        G.E_MANAGER:add_event(Event({

            func = function ()

                -- Add Eric
                joker_add('j_fn_Eric')

                return true
            end
        }))
    end,

}
----------------------------------------------
------------ERIC DECK CODE END----------------------

----------------------------------------------
------------MOD CODE END----------------------
