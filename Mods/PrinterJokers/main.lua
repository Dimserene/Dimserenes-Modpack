
-------------MOD CODE-------------





--thanks to elial1(discord) for the example mod and youtube tutorials. Really helped me out

--HOLY BANANA AND PEDRO!!--

SMODS.Atlas{
    key = 'holybanana', 
    path = 'holybanana.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'pedro', 
    path = 'pedro.png', 
    px = 71, 
    py = 95 
}

SMODS.Rarity{
    key = "holy",
    badge_colour = G.C.RARITY[2],
    loc_txt = {
        name = 'Holy Banana', 
    },
    pools = {}, 
}

SMODS.Rarity{
    key = "pedro",
    badge_colour = G.C.RARITY[3],
    loc_txt = {
        name = 'Pedro', 
    },
    pools = {}, 
}

SMODS.Joker {
    key = 'holybanana',
    loc_txt = {
      name = '{C:uncommon}Holy Banana',
      text = {
        'Gives{X:mult,C:white} X#1# {} Mult',
        'and {C:chips}+#2#{} Chips',
        '{C:green}#3# in #4#{} chance to get',
        'Sacrificed to the Divine',

      }
    },
    config = { extra = {  xmult = 4011, chips = 4011, odds = 4011 } },
    rarity = 'crv_holy',
    atlas = 'holybanana',
    blueprint_compat = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult,card.ability.extra.chips,(G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
          return {
            x_mult = card.ability.extra.xmult,
            chips = card.ability.extra.chips,
          }
        end
        if context.end_of_round and not context.repetition and not context.individual then
            if pseudorandom('holybanana') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                      play_sound('tarot1')
                      card.T.r = -0.2
                      card:juice_up(0.3, 0.4)
                      card.states.drag.is = true
                      card.children.center.pinch.x = true
                      G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                          G.jokers:remove_card(card)
                          card:remove()
                          card = nil
                          return true;
                        end,
                        
                  }))
                  return true
                end
              }))
              G.GAME.pool_flags.holybanana_extinct = true
              return {
                message = 'Sacrificed to the Divine!', 
                delay(0.6)
              }
            else
                return {
                    message = 'Shielded by Grace!', 
                    delay(0.6)
                }
    end
end
end
}       
SMODS.Joker {
    key = 'pedro',
    loc_txt = {
      name = '{C:rare}Pedro',
      text = {
        '{C:dark_edition}Rise and shine, sleepyhead',
        "{C:inactive} (won't go extinct)"

      }
    },
    config = { extra = {  xmult = 42831398, chips = 42831398, } },
    rarity = 'crv_pedro',
    atlas = 'pedro',
    blueprint_compat = true,
    discovered = true,
    pos = { x = 0, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult,card.ability.extra.chips, } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
          return {
            x_mult = card.ability.extra.xmult,
            chips = card.ability.extra.chips,
          }
        end
end
}       


--atlas--



SMODS.Atlas{
    key = 'wip', 
    path = 'wip.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'v', 
    path = 'v.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'megaprinter', 
    path = 'mega.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'megaenh', 
    path = 'megaenh.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'ghost', 
    path = 'Ghost.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Decks', 
    path = 'Decks.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Decks2', 
    path = 'Decks2.png', 
    px = 71, 
    py = 95 
}


SMODS.Atlas{
    key = 'Jokers', 
    path = 'Jokers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'Jokers2', 
    path = 'Jokers2.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'tarots', 
    path = 'tarots.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents', 
    path = 'documents.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'documents_u', 
    path = 'documents2.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'enh', 
    path = 'enh.png',
    px = 71,
    py = 95 
}

SMODS.Atlas{
    key = 'scrapss', 
    path = 'Scraps.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 't', 
    path = 'tiers.png', 
    px = 71, 
    py = 95 
}

SMODS.Atlas{
    key = 'td', 
    path = 'td.png', 
    px = 71, 
    py = 95 
}

---------------RARITIES-----------------

SMODS.Rarity{
    key = "p",
   badge_colour = G.C.RARITY[3],
   loc_txt = {
        name = 'Printer', -- used on rarity badge
    },
    pools = {}, 
}






---------------ENHANCEMENTS-----------------
SMODS.Enhancement{
    key = "bulletproofglass",
    atlas = 'enh',
    pos = {x = 0, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Bulletproof Glass',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            '{C:green}#2# in #3# {}chance to',
            'turn into {C:attention}Glass',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {x_mult = 4, odds = 6}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult,(G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play then
        return {
            x_mult = card.ability.extra.x_mult 
            }
        end
        if context.destroying_card and pseudorandom('bulletproofglass') < G.GAME.probabilities.normal / card.ability.extra.odds then
            G.E_MANAGER:add_event(Event({
            
                func = function()
                    card:juice_up(0.3, 0.4)
                    card:set_ability(G.P_CENTERS["m_glass"])
                  card = nil
                  return true
                end
              }))
      end
    end


            

}

SMODS.Enhancement{
    key = "diamondcard",
    atlas = 'enh',
    pos = {x = 2, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Diamond Card',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'while this card', 
            'stays in hand',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {x_mult = 2.5,}
    },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_mult} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.hand then
        return {
            x_mult = card.ability.extra.x_mult 
            }
        end
    end
}

SMODS.Enhancement{
    key = "soulcard",
    atlas = 'ghost',
    pos = {x = 0, y = 0},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Soul Card',
        text = {
            "{X:mult,C:white}Don't Deal With The Devil",
        }},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    overrides_base_rank = true,
    any_suit = false,
    always_scores = false,
    weight = 0,
}

SMODS.Enhancement{
    key = "mugged",
    atlas = 'enh',
    pos = {x = 1, y = 1},
    discovered = true,
    unlocked = true,
    loc_txt = { 
        name = 'Mugged',
        text = {
            '{X:mult,C:white}X#1#{} Mult',
            'if played hand contains a {C:attention}Flush',
        }},
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    overrides_base_rank = false,
    any_suit = false,
    always_scores = false,
    weight = 0,
    config = {extra = {xmult = 2,
    },},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult} }
      end,
      calculate = function(self, card, context, effect)
        if context.main_scoring and context.cardarea == G.play and next(context.poker_hands['Flush']) then
            return {
                x_mult = card.ability.extra.xmult,
              }
    end
end
    }   

    SMODS.Enhancement{
        key = "aflame",
        atlas = 'enh',
        pos = {x = 1, y = 0},
        discovered = true,
        unlocked = true,
        loc_txt = { 
            name = 'Aflame',
            text = {
                '{X:mult,C:white}X#1#{} Mult',
                'if played hand contains a {C:attention}Full House',
            }},
        replace_base_card = false,
        no_rank = false,
        no_suit = false,
        overrides_base_rank = false,
        any_suit = false,
        always_scores = false,
        weight = 0,
        config = {extra = {xmult = 2,
        },},
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.xmult} }
          end,
          calculate = function(self, card, context, effect)
            if context.main_scoring and context.cardarea == G.play and next(context.poker_hands['Full House']) then
                return {
                    x_mult = card.ability.extra.xmult,
                  }
        end
    end
        }   

        SMODS.Enhancement{
            key = 'mega',
            atlas = 'megaenh',
            pos = {x = 0, y = 0},
            discovered = true,
            unlocked = true,
            loc_txt = { 
                name = 'Mega',
                text = {
                    '{X:mult,C:white}X#1#{} Mult when scored'
                }},
            replace_base_card = false,
            no_rank = false,
            no_suit = false,
            overrides_base_rank = false,
            any_suit = false,
            always_scores = false,
            weight = 0,
            config = {extra = {xmult = 4,
            },},
            loc_vars = function(self, info_queue, card)
                return { vars = {card.ability.extra.xmult} }
              end,
              calculate = function(self, card, context, effect)
                if context.main_scoring and context.cardarea == G.play then
                    return {
                        x_mult = card.ability.extra.xmult,
                      }
            end
        end
            }   

            SMODS.Enhancement{
                key = "tier1card",
                atlas = 't',
                pos = {x = 0, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 1 Card',
                    text = {
                        '{C:chips}+#1#{} Chips',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 50,}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips
                        }
                    end
                end
            }
        
            SMODS.Enhancement{
                key = "tier2card",
                atlas = 't',
                pos = {x = 1, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 2 Card',
                    text = {
                        '{C:chips}+#1#{} Chips and',
                        '{C:mult}+#2#{} Mult',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 100, mult = 10}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips,card.ability.extra.mult} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult
                        }
                    end
                end
            }
        
            SMODS.Enhancement{
                key = "tier3card",
                atlas = 't',
                pos = {x = 2, y = 0},
                discovered = true,
                unlocked = true,
                loc_txt = { 
                    name = 'Tier 3 Card',
                    text = {
                        '{C:chips}+#1#{} Chips and',
                        '{X:mult,C:white}X#2#{} Mult',
                        'when scored'
                    }},
                replace_base_card = false,
                no_rank = false,
                no_suit = false,
                overrides_base_rank = false,
                any_suit = false,
                always_scores = false,
                weight = 0,
                config = {extra = {chips = 200, x_mult = 3}
                },
                loc_vars = function(self, info_queue, card)
                    return { vars = {card.ability.extra.chips,card.ability.extra.x_mult} }
                  end,
                  calculate = function(self, card, context, effect)
                    if context.main_scoring and context.cardarea == G.play then
                    return {
                        chips = card.ability.extra.chips,
                        x_mult = card.ability.extra.x_mult
                        }
                    end
                end
            }
            



---------------CONSUMEABLES-----------------

SMODS.ConsumableType{
    key = 'scrap', --consumable type key
    collection_rows = {4,5}, --amount of cards in one page
    primary_colour = G.C.DARK_EDITION, --first color
    secondary_colour = G.C.DARK_EDITION , --second color
    loc_txt = {
        collection = 'Scraps', --name displayed in collection
        name = 'Scraps', --name displayed in badge
        undiscovered = {
            name = '???', --undiscovered name
            text = {'???'} --undiscovered text
        },
    },
    shop_rate = 1,
}

SMODS.UndiscoveredSprite{
    key = 'scrap', --must be the same key as the consumabletype
    atlas = 'documents2.png',
    pos = {x = 0, y = 0}
}


SMODS.Consumable{
    in_pool = function(self,wawa,wawa2)
        if (#SMODS.find_card('j_crv_lpm') > 0) then
        return true
        elseif (#SMODS.find_card('j_crv_lpm') == 0) then
            return false
        end
    end,
    key = 'horn', --key
    set = 'scrap', --the set of the card: corresponds to a consumable type
    atlas = 'scrapss', --atlas
    cost = 0,
    pos = {x = 2, y = 0}, --position in atlas
    loc_txt = {
        name = 'Horn', --name of card
        text = { --text of card
            'Gives{C:money} 30$'
        },
        in_pool = function(self,wawa,wawa2)
            return false
        end,
    },
    can_use = function(self,card)
                return true
            end,
    use = function()
        return {
            ease_dollars(30),
        }
    end

}

    SMODS.Consumable{
        in_pool = function(self,wawa,wawa2)
            if (#SMODS.find_card('j_crv_lpm') > 0) then
            return true
            elseif (#SMODS.find_card('j_crv_lpm') == 0) then
                return false
            end
        end,
        key = 'pickles', --key
        set = 'scrap', --the set of the card: corresponds to a consumable type
        atlas = 'scrapss', --atlas
        cost = 0,
        pos = {x = 0, y = 0}, --position in atlas
        loc_txt = {
            name = 'Pickles', --name of card
            text = { --text of card
                'Gives{C:money} 25$'
            },
            in_pool = function(self,wawa,wawa2)
                return false
            end,
        },
        can_use = function(self,card)
                    return true
                end,
        use = function()
            return {
                ease_dollars(25),
            }
        end
    }
        SMODS.Consumable{
            in_pool = function(self,wawa,wawa2)
                if (#SMODS.find_card('j_crv_lpm') > 0) then
                return true
                elseif (#SMODS.find_card('j_crv_lpm') == 0) then
                    return false
                end
            end,
            key = 'mp', --key
            set = 'scrap', --the set of the card: corresponds to a consumable type
            atlas = 'scrapss', --atlas
            cost = 0,
            pos = {x = 1, y = 0}, --position in atlas
            loc_txt = {
                name = 'Metal Piece', --name of card
                text = { --text of card
                    'Gives{C:money} 20$'
                },
                in_pool = function(self,wawa,wawa2)
                    return false
                end,
            },
            can_use = function(self,card)
                        return true
                    end,
            use = function()
                return {
                    ease_dollars(20),
                }
            end
    

}


local printer_keys = {'j_crv_printer','j_crv_rustyprinter','j_crv_jimboprinter','j_crv_grossprinter','j_crv_obeliskprinter','j_crv_moneyprinter','j_crv_brokenprinter','j_crv_faxprinter','j_crv_spectralprinter',
'j_crv_glassprinter','j_crv_lpm','j_crv_devilishprinter','j_crv_steelprinter','j_crv_tierp'}

SMODS.Consumable{
    key = 'ink&intuition', 
    set = 'Tarot',
    loc_txt = { 
        name = 'Ink & Intuition',
        text = {
            '{C:green}#1# in #2#{} chance to',
            'create a {C:attention}Printer',
            '{C:inactive}(Must have room)',
        },
    },
    config = { extra = { odds = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
      end, 
    pos = { x = 0, y = 0 },
    atlas = 'tarots',
    cost = 3,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
        return true
        end
    end,
    use = function(self,card)
        if pseudorandom('ink&intuition') < G.GAME.probabilities.normal / card.ability.extra.odds then   
            local random_key = printer_keys[math.random(#printer_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
        else
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.06*G.SETTINGS.GAMESPEED, blockable = false, blocking = false, func = function()
                        play_sound('tarot2', 0.76, 0.4);return true end}))
                        play_sound('tarot2', 1, 0.4)
            return true end }))
        end
        delay(1.5)
    end
        }

        local machine_keys = {'j_crv_head','j_crv_body','j_crv_back' }

        SMODS.Consumable{
            key = 'dreams&desires', 
            set = 'Tarot',
            loc_txt = { 
                name = 'Dreams & Desires',
                text = {
                    'Creates 1 of the 3 {C:attention}Machine Parts,',
                    "{C:inactive}(Must have room)",
                },
            },
            config = { extra = {}},
            loc_vars = function(self, info_queue, card)
                return { vars = {} }
              end, 
            pos = { x = 1, y = 0 },
            atlas = 'tarots',
            cost = 3,
            unlocked = true,
            discovered = true,
            can_use = function(self,card)
                if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                return true
                end
            end,
            use = function(self,card) 
                    local random_key = machine_keys[math.random(#machine_keys)]
                        local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                        new_card:add_to_deck()
                        G.jokers:emplace(new_card)
                delay(1.5)
            end
                }
 

        SMODS.ConsumableType{
            key = 'EnchancedDocuments', --consumable type key
        
            collection_rows = {4,5}, --amount of cards in one page
            primary_colour = G.C.PURPLE, --first color
            secondary_colour = G.C.DARK_EDITION, --second color
            loc_txt = {
                collection = 'Documents', --name displayed in collection
                name = 'Documents', --name displayed in badge
                undiscovered = {
                    name = '???', --undiscovered name
                    text = {'???'} --undiscovered text
                }
            },
            shop_rate = 0, --rate in shop out of 100
        }
    
        SMODS.UndiscoveredSprite{
            key = 'EnchancedDocuments', --must be the same key as the consumabletype
            atlas = 'documents_u',
            pos = {x = 0, y = 0}
        }
        
    
    
        SMODS.Consumable{
            key = 'glassdocument', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 0, y = 0}, --position in atlas
            loc_txt = {
                name = 'Glass Document', --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Glass',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Bulletproof Glass{}'
                }
            },
            config = {
                extra = {
                    cards = 1, odds = 4}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('glassdocument') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_bulletproofglass"])
                    end
            else 
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_glass"])
            end
             end
            end,
        }

        SMODS.Consumable{
            key = 'steeldocument', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 3, y = 0}, --position in atlas
            loc_txt = {
                name = 'Steel Document', --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Steel',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Diamond{}'
                }
            },
            config = {
                extra = {
                    cards = 1, odds = 4}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('steeldocument') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_diamondcard"])
                    end
            else 
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_steel"])
            end
             end
            end,
        }

        local imsofckntired = {'m_crv_aflame','m_crv_mugged'}

        SMODS.Consumable{
            key = 'devilscontract', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'documents', --atlas
            pos = {x = 1, y = 0}, --position in atlas
            loc_txt = {
                name = "Devil's Contract", --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Aflame or Mugged{}',
                    '{C:green} #2# in #3#{} chance for it to be a',
                    '{C:dark_edition} Soul Card{}'
                }
            },
            config = {
                extra = { cards = 1, odds = 4 }},
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                if pseudorandom('devilscontract') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_soulcard"])
                    end
            else 
                local random_key = imsofckntired[math.random(#imsofckntired)]
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS[random_key])
            end
             end
            end,
        }
        
        SMODS.Consumable{
            key = 'megadoc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'megaenh', --atlas
            pos = {x = 1, y = 0}, --position in atlas
            loc_txt = {
                name = 'Mega Document', --name of card
                text = { --text of card
                    'Turns #1# card into {C:attention}Mega'
                }
            },
            config = {
                extra = {
                    cards = 1,}
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards, } }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_mega"])
                    end
            end
        }

        SMODS.Consumable{
            key = 't1doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'td', --atlas
            pos = {x = 0, y = 0}, --position in atlas
            config = {extra ={ cards = 1}},
            loc_txt = {
                name = 'Tier 1 Document', --name of card
                text = { 
                    'Turns #1# card into a',
                    '{C:attention}Tier 1 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier1card"])
                    end
            end
        }
        SMODS.Consumable{
            key = 't2doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'td', --atlas
            pos = {x = 1, y = 0},
            config = {extra ={ cards = 2}}, --position in atlas
            loc_txt = {
                name = 'Tier 2 Document', --name of card
                text = { --text of card
                    'Turns up to #1# cards into a',
                    '{C:attention}Tier 2 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier2card"])
                    end
            end
        }
        SMODS.Consumable{
            key = 't3doc', --key
            set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
            discovered = true,
            atlas = 'td', --atlas
            pos = {x = 2, y = 0},
            config = {extra = { cards = 3}}, --position in atlas
            loc_txt = {
                name = 'Tier 3 Document', --name of card
                text = { --text of card
                    'Turns up to #1# card into a',
                    '{C:attention}Tier 2 Card',
                }
            },
            loc_vars = function(self, info_queue, card)
                return { vars = { card.ability.extra.cards,} }
              end,
            can_use = function(self,card)
                if G and G.hand then
                    if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                        return true
                    end
                end
                return false
            end,
            use = function(self,card,area,copier)
                    for i, card in pairs(G.hand.highlighted) do
                        card:set_ability(G.P_CENTERS["m_crv_tier3card"])
                    end
            end
        }
    
        
    



---------------JOKER FUNCTIONS-----------------

function joker_add(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        -- (Credit to @AstroLighz for the deck codes)
        SMODS.Stickers["eternal"]:apply(j, true)


    end
end

function joker_add_etx(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)

    end
end

function joker_add_per(jKey)

    if type(jKey) == 'string' then
        
        local j = SMODS.create_card({
            key = jKey,
        })

        j:add_to_deck()
        G.jokers:emplace(j)
        SMODS.Stickers["perishable"]:apply(j, true)

    end
end



-------JOKERS------


SMODS.Joker{
    key = 'printer', 
    loc_txt = { 
        name = 'Blueprinter',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Blueprint{} Joker',
        },
        
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
    cost = 30, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = false,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 0, y = 0},
    config = { 
      extra = {

      }
    },

    calculate = function(self,card,context)
        
        if context.setting_blind and not context.blueprint then
            local new_card = create_card('Blueprint', G.jokers, nil,nil,nil,nil,'j_blueprint')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
    in_pool = function(self,wawa,wawa2)
        return false
    end,
   }

   SMODS.Joker{
    key = 'rustyprinter', 
    loc_txt = { 
        name = 'Rusty Printer',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Brainstorm{} Joker',
        },

    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
    cost = 30, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = false, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 0}, 
    config = { 
      extra = {

      }
    },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint then
            local new_card = create_card('Brainstorm', G.jokers, nil,nil,nil,nil,'j_brainstorm')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)

            end
        end,

    in_pool = function(self,wawa,wawa2)
        
        return false
    end,
   }

   SMODS.Joker{
    key = 'jimboprinter', 
    loc_txt = { 
        name = 'Jimbo Printer',
        text = {
          'When Blind is selected,',
          'print a {C:dark_edition}Negative {}{C:attention}Joker {}',
        },
   
    },
        atlas = 'Jokers', 
        rarity = 'crv_p',
        cost = 30, 
        unlocked = true,
        discovered = true,
        blueprint_compat = false,
        eternal_compat = true,
        perishable_compat = false,
        pos = {x = 2, y = 0},
        config = { 
          extra = {

      }
    },
    loc_vars = function(self,info_queue,center)
    end,
    calculate = function(self,card,context)
        if context.setting_blind then
            local new_card = create_card('Joker', G.jokers, nil,nil,nil,nil,'j_joker')
            new_card:set_edition({negative = true}, true)
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,

    in_pool = function(self,wawa,wawa2)
      
        return false
    end,
   }

   SMODS.Joker{
    key = 'grossprinter', 
    loc_txt = { 
        name = 'Gross Printer',
        text = {
          'When Blind is selected,',
          'print a {C:attention}Gros Michel{}',
          '{C:green}#1# in #2#{} chance to',
          'print {C:attention}Cavendish{} and',
          '{C:green}#1# in #3#{} chance to',
          'print a{C:attention} Holy Banana',
          'if somehow the {C:uncommon}Holy Banana{} gets',
          'Sacrified to the Divine, spawns {C:rare}Pedro{}',
          'when blind is selected',

        
        },

    },
    atlas = 'Jokers', 
    rarity = 'crv_p',
    
    cost = 30, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true, 
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 0, y = 1},
    config = { 
      extra = { odds = 100, odds2 = 1011

      }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds,card.ability.extra.odds2 },  } 
      end,

    calculate = function(self,card,context)

        if context.setting_blind and pseudorandom('grossprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local new_card = create_card('Cavendish', G.jokers, nil,nil,nil,nil,'j_cavendish')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        elseif context.setting_blind then
            local new_card = create_card('Gros Michel', G.jokers, nil,nil,nil,nil,'j_gros_michel')
        new_card:add_to_deck()
        G.jokers:emplace(new_card)
        end
        if context.setting_blind and pseudorandom('grossprinter') < G.GAME.probabilities.normal / card.ability.extra.odds2 then
            local new_card = create_card('Holy Banana', G.jokers, nil,nil,nil,nil,'j_crv_holybanana')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
    end
    if G.GAME.pool_flags.holybanana_extinct == true and context.setting_blind and not (#SMODS.find_card('j_crv_pedro') >= 1) then
            local new_card = create_card('Pedro', G.jokers, nil,nil,nil,nil,'j_crv_pedro')
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
    end
end,
    
    in_pool = function(self,wawa,wawa2)
        
        return false
    end,
   }

   SMODS.Joker{
    key = 'obeliskprinter', 
    loc_txt = { 
        name = 'Obelisk Printer',
        text = {
          'When Blind is selected,',
          'print a {C:dark_edition}Negative{} {C:attention}Obelisk{} Joker',
        },
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
 
    cost = 20, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 1, y = 1}, 
    config = { 
      extra = {

      }
    },
    calculate = function(self, card, context)
        if context.setting_blind then
            local new_card = create_card('Obelisk', G.jokers, nil,nil,nil,nil,'j_obelisk')
            new_card:set_edition({negative = true}, true)
            new_card:add_to_deck()
            G.jokers:emplace(new_card)
        end
    end,
    in_pool = function(self, wawa, wawa2)
        return false
    end,
   }

   SMODS.Joker{
    key = 'moneyprinter', 
    loc_txt = { 
        name = 'Money Printer',
        text = {
          'When round ends,',
          'Gain {C:money}+$25{}',
        },
    },
    atlas = 'Jokers', 
    rarity = 'crv_p', 
 
    cost = 40, 
    unlocked = true, 
    discovered = true, 
    blueprint_compat = true,
    eternal_compat = true, 
    perishable_compat = false, 
    pos = {x = 2, y = 1}, 
    config = { 
      extra = {
      }
    },
      
    in_pool = function(self,wawa,wawa2)
        return false
    end,

    calc_dollar_bonus = function(self,card)
        return 25
    end,
   }

    local card_keys = {
        'j_8_ball', 'j_abstract', 'j_acrobat', 'j_ancient', 'j_arrowhead', 'j_astronomer', 'j_banner', 'j_baron',
        'j_baseball', 'j_blackboard', 'j_bloodstone', 'j_blue_joker', 'j_blueprint', 'j_bootstraps', 'j_brainstorm',
        'j_bull', 'j_burglar', 'j_burnt', 'j_business', 'j_caino', 'j_campfire', 'j_card_sharp', 'j_cartomancer',
        'j_castle', 'j_cavendish', 'j_ceremonial', 'j_certificate', 'j_chaos', 'j_chicot', 'j_clever', 'j_cloud_9',
        'j_constellation', 'j_crafty', 'j_crazy', 'j_credit_card', 'j_delayed_grat', 'j_devious', 'j_diet_cola',
        'j_dna', 'j_drivers_license', 'j_droll', 'j_drunkard', 'j_duo', 'j_dusk', 'j_egg', 'j_erosion', 'j_even_steven',
        'j_faceless', 'j_family', 'j_fibonacci', 'j_flash', 'j_flower_pot', 'j_fortune_teller', 'j_four_fingers',
        'j_gift', 'j_glass', 'j_gluttenous_joker', 'j_golden', 'j_greedy_joker', 'j_green_joker', 'j_gros_michel',
        'j_hack', 'j_half', 'j_hallucination', 'j_hanging_chad', 'j_hiker', 'j_hit_the_road', 'j_hologram', 'j_ice_cream',
        'j_idol', 'j_invisible', 'j_joker', 'j_jolly', 'j_juggler', 'j_loyalty_card', 'j_luchador', 'j_lucky_cat',
        'j_lusty_joker', 'j_mad', 'j_madness', 'j_mail', 'j_marble', 'j_matador', 'j_merry_andy', 'j_midas_mask',
        'j_mime', 'j_misprint', 'j_mr_bones', 'j_mystic_summit', 'j_obelisk', 'j_odd_todd', 'j_onyx_agate', 'j_oops',
        'j_order', 'j_pareidolia', 'j_perkeo', 'j_photograph', 'j_popcorn', 'j_raised_fist', 'j_ramen', 'j_red_card',
        'j_reserved_parking', 'j_ride_the_bus', 'j_riff_raff', 'j_ring_master', 'j_rocket', 'j_rough_gem', 'j_runner',
        'j_satellite', 'j_scary_face', 'j_scholar', 'j_seance', 'j_seeing_double', 'j_selzer', 'j_shoot_the_moon',
        'j_shortcut', 'j_sixth_sense', 'j_sly', 'j_smeared', 'j_smiley', 'j_sock_and_buskin', 'j_space', 'j_splash',
        'j_square', 'j_steel_joker', 'j_stencil', 'j_stone', 'j_stuntman', 'j_supernova', 'j_superposition',
        'j_swashbuckler', 'j_throwback', 'j_ticket', 'j_to_the_moon', 'j_todo_list', 'j_trading', 'j_tribe', 'j_triboulet',
        'j_trio', 'j_troubadour', 'j_trousers', 'j_turtle_bean', 'j_vagabond', 'j_vampire', 'j_walkie_talkie', 'j_wee',
        'j_wily', 'j_wrathful_joker', 'j_yorick', 'j_zany'
    }
    
    SMODS.Joker{
        key = 'brokenprinter', 
        loc_txt = { 
            name = 'Broken Printer',
            text = {
              'When Blind is selected,',
              'print a {C:attention}Random Joker{}',

            },
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 2}, 
        config = { 
          extra = {
          }
        },
        calculate = function(self, card, context)
            if context.setting_blind then
                local random_key = card_keys[math.random(#card_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
             end
            end,

        in_pool = function(self, wawa, wawa2)
           
            return false
        end,
    }

    SMODS.Joker {
        key = 'faxprinter',
        loc_txt = {
          name = 'Fax Printer',
          text = {
            'When blind is selected,',
            "{C:green}#1# in #2#{} chance this",
            "card prints a",
            "{C:attention} Document",
          }
        },
        config = { extra = { odds = 4 } },
        rarity = 'crv_p',
        atlas = 'Jokers',
        blueprint_compat = true,
        pos = { x = 1, y = 2 },
        cost = 30,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
          return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end,
        calculate = function(self, card, context)
          if context.setting_blind then
            if pseudorandom('faxprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Paper Work', G.jokers, nil,nil,nil,nil,'j_crv_pprwork')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end
    end,


        in_pool = function(self, wawa, wawa2)
           
            return false
        end

    }
    
    SMODS.Joker {
        key = 'pprwork',
        loc_txt = {
          name = 'Paperwork',
          text = {
            "Anything between {C:attention}9{} and {C:attention}2",
            "gives {C:chips}+#1#{} Chips and",
            "{C:mult}+#2#{} Mult when scored",
            '{C:inactive}(9 and 2 included){}',
          }
        },
        config = { extra = { chips = 20.4, mult = 9.8 } },
        rarity = 2,
        atlas = 'Jokers',
        blueprint_compat = true,
        discovered = true,
        pos = { x = 2, y = 2 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
        end,
        calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 2 and context.other_card:get_id() <= 9 then
              return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card.other_card
              }
            end
        end
    end,

              in_pool = function(self, wawa, wawa2)
                return false
            end
      }

      local spectral_keys = {'c_ankh', 'c_aura', 'c_black_hole', 'c_cryptid', 'c_deja_vu', 'c_ectoplasm', 'c_familiar', 'c_grim', 'c_hex', 'c_immolate', 'c_incantation', 'c_medium', 'c_ouija', 'c_sigil', 'c_soul', 'c_talisman', 'c_trance', 'c_wraith'
}

      SMODS.Joker{
        key = 'spectralprinter', 
        loc_txt = { 
            name = 'Spectral Printer',
            text = {
              'When Blind is selected,',
              'print a Random',
              '{C:dark_edition} Negative {C:attention}Spectral{}',
              '{C:attention}Card{}',
            },
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 3}, 
        config = { 
          extra = {
          }
        },
        calculate = function(self, card, context)
            if context.setting_blind then
                local random_key = spectral_keys[math.random(#spectral_keys)]
                local new_card = create_card(random_key, G.consumeables, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
             end
        end,
        in_pool = function(self, wawa, wawa2)
           
            return false
        end,
      }

      local leg_keys = {'j_caino','j_triboulet','j_yorick','j_chicot','j_perkeo'}

      SMODS.Joker{
        key = 'legendaryprinter', 
        loc_txt = { 
            name = 'Legendary Printer',
            text = {
              "{C:green}#1# in #2#{} chance this",
              "card prints a random {C:dark_edition}Temporary",
              "{C:dark_edition}Negative{C:attention} Legendary Joker"
            },
            
        },
        atlas = 'Jokers', 
        rarity = 4, 
        cost = 35, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 3},
        config = { 
          extra = { odds = 3 }
          },
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self, card, context)
            if context.setting_blind then
              if pseudorandom('legendaryprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local random_key = leg_keys[math.random(#leg_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:set_edition({negative = true}, true)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                SMODS.Stickers['perishable']:apply(new_card, true)
              end
          end
          in_pool = function(self, wawa, wawa2)
           
            return false
        end
      end
       
    }

    SMODS.Joker{
        key = 'glassprinter', 
        loc_txt = { 
            name = 'Glass Printer',
            text = {
                'Prints {C:attention}Glass Document{}',
                'When blind is selected,',
                "{C:green}#1# in #2#{} chance this",
                "card gets destroyed",
              }
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 3},
        config = { extra = { odds = 6 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                if pseudorandom('glassprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local new_card = create_card('Glass Document', G.consumeables, nil,nil,nil,nil,'c_crv_glassdocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                          card.T.r = -0.2
                          card:juice_up(0.3, 0.4)
                          card.states.drag.is = true
                          card.children.center.pinch.x = true
                          G.E_MANAGER:add_event(Event({
                            func = function()
                              G.jokers:remove_card(card)
                              card:shatter()
                              card = nil
                              return true;
                            end
                          }))
                          return true
                        end
                      }))
                                else
                                    local new_card = create_card('Glass Document', G.consumeables, nil,nil,nil,nil,'c_crv_glassdocument')
                                    new_card:add_to_deck()
                                    G.consumeables:emplace(new_card)                   
                                end
                            end
                        end,
                
        in_pool = function(self,wawa,wawa2)
            return false
        end
    }

    SMODS.Joker{
        key = 'steelprinter', 
        loc_txt = { 
            name = 'Steel Printer',
            text = {
                'Prints {C:attention}Steel Document{}',
                'When blind is selected,',
                '{X:mult,C:white}X#1#{} Mult'
              }
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 0},
        config = { extra = { xmult = 1.5 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                    local new_card = create_card('Steel Document', G.consumeables, nil,nil,nil,nil,'c_crv_steeldocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            end
            if context.joker_main then
                return  {
                    x_mult = card.ability.extra.xmult
                }
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end
    }
    
    SMODS.Joker{
        key = 'smile!', 
        loc_txt = { 
            name = 'Camera',
            text = {
              'If you have a {C:attention}Joker{} in hand',
              '{C:green}#1# in #2#{} chance to create a',
              '{C:attention}Photograph{} when blind is',
              'selected',
            },
            
        },
        atlas = 'Jokers', 
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 3, y = 0},
        config = { extra = { odds = 4 }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds} }
          end,
        calculate = function(self,card,context)
            if (#SMODS.find_card('j_joker') > 0) and context.setting_blind and
              pseudorandom('smile!') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Photograph', G.jokers, nil,nil,nil,nil,'j_photograph')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end
       }

       SMODS.Joker{
        key = 'lpm', 
        loc_txt = { 
            name = 'Lethal Press Machine',
            text = {
                'When in inventory',
                'Has a chance to spawn {C:attention}Scrap',
                'in shop.',
                'Gains {C:mult}+#2# {}Mult for every {C:attention}Scrap used',
                '{C:inactive}(Currently{C:mult} +#1#{C:inactive} Mult)'
              },
            
        },
        atlas = 'Jokers',
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 3, y = 1},
        config = { 
          extra = { mult = 5, mult_gain = 15
          },},
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
          end,
          calculate = function(self, card, context)
            if context.joker_main then
              return {
                mult_mod = card.ability.extra.mult,
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
              }
            end
            if context.using_consumeable and context.consumeable.config.center.key == 'c_crv_mp' and not context.blueprint or  context.using_consumeable and context.consumeable.config.center.key == 'c_crv_pickles'  and not context.blueprint or
             context.using_consumeable and context.consumeable.config.center.key == 'c_crv_horn' and not context.blueprint then
            
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                  message = 'The Company Is Hiring!',
                  delay = 1.3
                }
              end  
            end,
        in_pool = function(self,wawa,wawa2)
            return false
        end

        
       }

       SMODS.Joker{
        key = 'devilishprinter', 
        loc_txt = { 
            name = 'Devilish Printer',
            text = {
              'When blind is selected,',
              '{C:green}#1# in #2# {}chance to',
              "Create a {C:attention}Devil's Contract"
            },
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { odds = 2 }},
        loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self,card,context)
                if context.setting_blind and pseudorandom('devilishprinter') < G.GAME.probabilities.normal / card.ability.extra.odds then
                    local new_card = create_card("Devil's Contract", G.consumeables, nil,nil,nil,nil,'c_crv_devilscontract')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card)
                end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }   

       SMODS.Joker{
        key = 'head', 
        loc_txt = { 
            name = 'Left Side of the Mega Printer',
            text = {
              'Gives {C:mult}+#1#{} Mult',
              'If all 3 parts of the mega printer',
              'are present, print an {C:attention}Mega Document'
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { mult = 25
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

       SMODS.Joker{
        key = 'body', 
        loc_txt = { 
            name = 'Middle of the Mega Printer',
            text = {
              'Gives {C:mult}+#1#{} Mult',
              'If all 3 parts of the mega printer',
              'are present, print an {C:attention}Mega Document'
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 1, y = 0},
        config = { 
          extra = { mult = 30
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

       SMODS.Joker{
        key = 'back', 
        loc_txt = { 
            name = 'Right Side of the Mega Printer',
            text = {
              'Gives {C:mult}+#1#{} Mult',
              'If all 3 parts of the mega printer',
              'is present, print an {C:attention}Mega Document'
            },
            
        },
        atlas = 'megaprinter', 
        rarity = 'crv_p', 
        cost = 25, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { 
          extra = { mult = 25
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.mult, } }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                  mult_mod = card.ability.extra.mult,
                  message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
            if (#SMODS.find_card('j_crv_head') > 0) and (#SMODS.find_card('j_crv_body') > 0) and context.setting_blind then
                local new_card = create_card("Mega", G.consumeables, nil, nil, nil, nil, "c_crv_megadoc")
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

       SMODS.Joker{
        key = 'tierp', 
        loc_txt = { 
            name = 'Advanced Printer',
            text = {
                'Prints a {C:green}T1 Document{}',
                'When blind is selected,',
                "Prints a{C:money} T2 Doc{} if {C:rare}Tier 1 Upgrade",
                'has been redeemed. Prints a{C:gold} T3 Doc{} if {C:rare}Tier 2 Upgrade',
                'has been redeemed',
              }
        },
        atlas = 'Jokers2', 
        rarity = 'crv_p', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { extra = {}, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = {  } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind and G.GAME.used_vouchers["v_crv_tup2"] == true then
                    local new_card = create_card('Tier 3 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t3doc')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            elseif context.setting_blind and G.GAME.used_vouchers["v_crv_tup"] == true and not G.GAME.used_vouchers["v_crv_tup2"] == true then
                    local new_card = create_card('Tier 2 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t2doc')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
    
            else if context.setting_blind and not G.GAME.used_vouchers["v_crv_tup2"] == true and not G.GAME.used_vouchers["v_crv_tup"] == true then
                local new_card = create_card('Tier 1 Document', G.consumeables, nil,nil,nil,nil,'c_crv_t1doc')
                new_card:add_to_deck()
                G.consumeables:emplace(new_card)
            end
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end
    }

    
    
            
    ----------------DECKS----------------
    SMODS.Back{
        name = 'Old Scroll',
        key = 'os',
        atlas = 'Decks',
        pos = {x = 1, y = 0},
        loc_txt = {
            name = 'Old Scroll',
            text = {
                'Start with an',
                'Eternal{C:attention} Rusty Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_rustyprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Machinery',
        key = 'mach',
        atlas = 'Decks',
        pos = {x = 0, y = 0},
        loc_txt = {
            name = 'Machinery',
            text = {
                'Start with an',
                'Eternal {C:attention}Blueprinter{}'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_printer')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Gold Mayhem',
        key = 'gm',
        atlas = 'Decks',
        pos = {x = 2, y = 1},
        loc_txt = {
            name = 'Gold Mayhem',
            text = {
                'Start with an',
                'Eternal {C:money}Money Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_moneyprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    
        SMODS.Back{
        name = 'Ripped Deck',
        key = 'rpd',
        atlas = 'Decks',
        pos = {x = 0, y = 2},
        loc_txt = {
            name = 'Ripped Deck',
            text = {
                'Start with an',
                'Eternal {C:attention}Broken Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_brokenprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Jimbo World',
        key = 'jw',
        atlas = 'Decks',
        pos = {x = 2, y = 0},
        loc_txt = {
            name = 'Jimbo World',
            text = {
                'Start with an',
                'Eternal {C:attention}Jimbo Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_jimboprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Gross Deck',
        key = 'gd',
        atlas = 'Decks',
        pos = {x = 0, y = 1},
        loc_txt = {
            name = 'Gross Deck',
            text = {
                'Start with an',
                'Eternal {C:attention}Gross Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_grossprinter')
    
    
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'The Suspicious Desert',
        key = 'tsd',
        atlas = 'Decks',
        pos = {x = 1, y = 1},
        loc_txt = {
            name = 'The Suspicious Desert',
            text = {
                'Start with an',
                'Eternal {C:attention}Obelisk Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_obeliskprinter')
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Speaking Fax',
        key = 'spx',
        atlas = 'Decks',
        pos = {x = 1, y = 2},
        loc_txt = {
            name = 'Speaking Fax',
            text = {
                'Start with an',
                'Eternal {C:attention}Fax Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_faxprinter')
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Phantom Forge',
        key = 'phf',
        atlas = 'Decks',
        pos = {x = 2, y = 2},
        loc_txt = {
            name = 'Phantom Forge',
            text = {
                'Start with an',
                'Eternal {C:attention}Spectral Printer{}',
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
                func = function ()
                    joker_add('j_crv_spectralprinter')
                    return true
                end
            }))
        end
    }
    
    SMODS.Back{
        name = 'Hollow Gems',
        key = 'hg',
        atlas = 'Decks',
        pos = {x = 0, y = 3},
        loc_txt = {
            name = 'Hollow Gems',
            text = {
                'Start with an',
                'Eternal{C:attention} Legendary Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_legendaryprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Glassbound',
        key = 'gb',
        atlas = 'Decks',
        pos = {x = 1, y = 3},
        loc_txt = {
            name = 'Glassbound',
            text = {
                'Start with an',
                'Eternal{C:attention} Glass Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_glassprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'Art Gallery',
        key = 'atg',
        atlas = 'Decks',
        pos = {x = 2, y = 3},
        loc_txt = {
            name = 'Art Gallery',
            text = {
                'Start with an',
                'Eternal{C:attention} Camera{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_smile!')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = 'The Company Is Hiring!',
        key = 'tcih',
        atlas = 'Decks',
        pos = {x = 0, y = 4},
        loc_txt = {
            name = 'The Company Is Hiring!',
            text = {
                'Start with an',
                'Eternal{C:attention} Lethal Press Machine{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_lpm')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Devil's Casino",
        key = 'dc',
        atlas = 'Decks2',
        pos = {x = 0, y = 0},
        loc_txt = {
            name = "Devil's Casino",
            text = {
                'Start with an',
                'Eternal{C:attention} Devilish Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_devilishprinter')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "MDeck HQ",
        key = 'rf',
        atlas = 'Decks2',
        pos = {x = 1, y = 0},
        loc_txt = {
            name = "MDeck HQ",
            text = {
                'Start with an',
                'Eternal{C:attention} Completed Mega Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_head')
                    joker_add('j_crv_body')
                    joker_add('j_crv_back')
    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Steelbound",
        key = 'sb',
        atlas = 'Decks2',
        pos = {x = 2, y = 0},
        loc_txt = {
            name = "Steelbound",
            text = {
                'Start with an',
                'Eternal{C:attention} Steel Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_steelprinter')

    
    
                    return true
                end
            }))
        end
    }

    SMODS.Back{
        name = "Upgrade!",
        key = 'up',
        atlas = 'Decks2',
        pos = {x = 3, y = 0},
        loc_txt = {
            name = "Upgrade!",
            text = {
                'Start with an',
                'Eternal{C:attention} Advanced Printer{}.'
            },
        },
        apply = function ()
    
            G.E_MANAGER:add_event(Event({
    
                func = function ()
    
    
                    joker_add('j_crv_tierp')

    
    
                    return true
                end
            }))
        end
    }

    --VOUCHERS--

    
    SMODS.Voucher {
        key = 'tup',
        atlas = 'v',
        pos = {x = 0, y = 0},
        loc_txt = {
            name = 'Tier Upgrade',
            text = {
                'Allows for tier 2 documents to be spawned by',
                'the {C:attention} Advanced Printer'
        },
        atlas = 'wip', 
        cost = 10,
        unlocked = true,
        discovered = true,
        requires = {'v_crv_tup2'}
        }
            
    
    }
    SMODS.Voucher {
        key = 'tup2',
        atlas = 'v', 
        pos = {x = 1, y = 0},
        loc_txt = {
            name = 'Tier Upgrade 2',
            text = {
                'Allows for tier 3 documents to be spawned by',
                'the {C:attention} Advanced Printer'
        },
        cost = 15,
        unlocked = true,
        discovered = true,
        }
            
    }    

    ---WIP---

    SMODS.Atlas{
        key = 'gb', 
        path = 'gb.png', 
        px = 71, 
        py = 95 
    }
  
    
    SMODS.Joker{
        key = 'ghostbanana', 
        loc_txt = { 
            name = 'Ghost Banana',
            text = {
              '{C:chips}+#1# Chips',
              'Creates {C:dark_edition}Ghost Slices{} when',
              'blind is selected',
              '{C:inactive}(Must have room)'
            },
            
        },
        atlas = 'gb', 
        rarity = 2, 
        cost = 4, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 0, y = 0},
        config = { 
          extra = { chips = 100
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.chips } }
          end, 
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
            if context.setting_blind and #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                local new_card = create_card('Ghost Slices', G.jokers, nil, nil, nil, nil, 'j_crv_ghostslices')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return true
        end,
       }

       SMODS.Joker{
        key = 'ghostslices', 
        loc_txt = { 
            name = 'Ghost Slices',
            text = {
              '{C:chips}+#1# Chips'
            },
            
        },
        atlas = 'gb', 
        rarity = 1, 
        cost = 1, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = true, 
        pos = {x = 1, y = 0},
        config = { 
          extra = { chips = 50
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.chips} }
          end,
        calculate = function(self,card,context)
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
            end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

  
    

      

       

    
    

    
    
        
        





















































































































    --- chaos releated ---

    SMODS.Atlas{
        key = 'chaosa', 
        path = 'chaos.png', 
        px = 71, 
        py = 95 
    }

    SMODS.Atlas{
        key = 'printersoul', 
        path = 'Printer_Soul.png', 
        px = 71, 
        py = 105 
    }

    SMODS.Rarity{
        key = "chaos",
       badge_colour = G.C.DARK_EDITION,
       loc_txt = {
            name = 'Chaos',
        },
        pools = {}, 
    }

    local chaos_keys = {'j_crv_chaoticprintermachine','j_crv_thefaxprinter','j_crv_dirtinator9999'}

SMODS.Consumable{
    key = "Printer's Soul", 
    set = 'Spectral',
    soul_set = 'Spectral',
        soul_rate = 0.003,
        can_repeat_soul = false,
    loc_txt = { 
        name = "Printer's Soul",
        text = {
            'Create a random',
            '{C:dark_edition}Chaos Printer',
        },
    },
    config = { extra = { odds = 3 }},
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
      end, 
    pos = { x = 0, y = 0 },
    atlas = 'printersoul',
    cost = 3,
    unlocked = true,
    discovered = true,
    can_use = function(self,card)
        return true
        end,
    use = function(self,card)
            local random_key = chaos_keys[math.random(#chaos_keys)]
                local new_card = create_card(random_key, G.jokers, nil, nil, nil, nil, random_key)
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                delay(1.5)
    end
        }
   
    
            
    SMODS.Joker{
        key = 'chaoticprintermachine', 
        loc_txt = { 
            name = '{C:dark_edition}Chaotic Printer',
            text = {
              'When Blind is selected,',
              '{C:green}#1# in #2# to',
              'create all of the {C:attention}Printers',
              '{C:inactive}(Trust me, limiting this by luck',
              '{C:inactive}is needed.)'
            },
            
        },
        atlas = 'chaosa', 
        rarity = 'crv_chaos', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = false,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 0, y = 1},
        config = { 
          extra = { odds = 3
    
          }
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
          end, 
        calculate = function(self,card,context)
            
            if context.setting_blind and not context.blueprint and pseudorandom('chaoticprintermachine') < G.GAME.probabilities.normal / card.ability.extra.odds then
                local new_card = create_card('Blueprinter', G.jokers, nil,nil,nil,nil,'j_crv_printer')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Rusty Printer', G.jokers, nil,nil,nil,nil,'j_crv_rustyprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Jimbo Printer', G.jokers, nil,nil,nil,nil,'j_crv_jimboprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Obelisk Printer', G.jokers, nil,nil,nil,nil,'j_crv_obeliskprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Money Printer', G.jokers, nil,nil,nil,nil,'j_crv_moneyprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Broken Printer', G.jokers, nil,nil,nil,nil,'j_crv_brokenprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Fax Printer', G.jokers, nil,nil,nil,nil,'j_crv_faxprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Spectral Printer', G.jokers, nil,nil,nil,nil,'j_crv_spectralprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Legendary Printer', G.jokers, nil,nil,nil,nil,'j_crv_legendaryprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Glass Printer', G.jokers, nil,nil,nil,nil,'j_crv_glassprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Camera', G.jokers, nil,nil,nil,nil,'j_crv_smile!')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Lethal Press Machine', G.jokers, nil,nil,nil,nil,'j_crv_lpm')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Devilish Printer', G.jokers, nil,nil,nil,nil,'j_crv_devilishprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Head', G.jokers, nil,nil,nil,nil,'j_crv_head')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Body', G.jokers, nil,nil,nil,nil,'j_crv_body')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Back', G.jokers, nil,nil,nil,nil,'j_crv_back')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Steel Printer', G.jokers, nil,nil,nil,nil,'j_crv_steelprinter')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
                local new_card = create_card('Advanced Printer', G.jokers, nil,nil,nil,nil,'j_crv_tierp')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end,
       }

       SMODS.Joker {
        key = 'thefaxprinter',
        loc_txt = {
          name = '{C:money}THE Fax Printer',
          text = {
            'When blind is selected,',
            "this card prints a",
            "{C:attention} Promotion",
          }
        },
        config = { extra = {  } },
        rarity = "crv_chaos",
        atlas = 'chaosa',
        blueprint_compat = true,
        pos = { x = 1, y = 0 },
        cost = 30,
        eternal_compat = true,
        loc_vars = function(self, info_queue, card)
          return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
        end,
        calculate = function(self, card, context)
          if context.setting_blind then
                local new_card = create_card('Promotion', G.jokers, nil,nil,nil,nil,'j_crv_promotion')
                new_card:add_to_deck()
                G.jokers:emplace(new_card)
            end
        end,
        in_pool = function(self, wawa, wawa2)
           
            return false
        end

    }
    
    SMODS.Joker {
        key = 'promotion',
        loc_txt = {
          name = '{C:money}Promotion',
          text = {
            "All {C:attention}Royal Cards {}and {C:attention}Aces",
            "give {C:chips}+#1#{} Chips and",
            "{X:mult,C:white}X#2#{} Mult when scored",
          }
        },
        config = { extra = { chips = 36286368, xmult = 4153211351420 } },
        rarity = 'crv_chaos',
        atlas = 'chaosa',
        blueprint_compat = true,
        discovered = true,
        pos = { x = 0, y = 0 },
        cost = 6,
        loc_vars = function(self, info_queue, card)
          return { vars = { card.ability.extra.chips, card.ability.extra.xmult } }
        end,
        calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() >= 11 and context.other_card:get_id() <= 14 then
              return {
                chips = card.ability.extra.chips,
                x_mult = card.ability.extra.xmult,
                card = card.other_card
              }
            end
        end
    end,

              in_pool = function(self, wawa, wawa2)
                return false
            end
      }

      SMODS.Joker{
        key = 'dirtinator9999', 
        loc_txt = { 
            name = '{C:green}Dirtinator9999',
            text = {
                '{C:dark_edition}DIRT'
              }
        },
        atlas = 'chaosa', 
        rarity = 'crv_chaos', 
        cost = 30, 
        unlocked = true, 
        discovered = true, 
        blueprint_compat = true,
        eternal_compat = true, 
        perishable_compat = false, 
        pos = {x = 2, y = 0},
        config = { extra = {  }, }, 
          loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.xmult } }
          end,
        calculate = function(self,card,context)
            if context.setting_blind then
                    local new_card = create_card('Dirt Document', G.consumeables, nil,nil,nil,nil,'c_crv_dirtdocument')
                    new_card:add_to_deck()
                    G.consumeables:emplace(new_card) 
            end
        end,
        in_pool = function(self,wawa,wawa2)
            return false
        end
    }

    SMODS.Consumable{
        key = 'dirtdocument', --key
        set = 'EnchancedDocuments', --the set of the card: corresponds to a consumable type
        atlas = 'chaosa', --atlas
        pos = {x = 2, y = 1}, --position in atlas
        discovered = true,
        loc_txt = {
            name = '{C:green}Dirt Document', --name of card
            text = { --text of card
                '{X:dark_edition,C:red}Dirt?'
            }
        },
        config = {
            extra = {
                cards = 9999,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.cards, }}
          end,
        can_use = function(self,card)
            if G and G.hand then
                if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= card.ability.extra.cards then --if cards in hand highlighted are above 0 but below the configurable value then
                    return true
                end
            end
            return false
        end,
        use = function(self,card,area,copier)
                for i, card in pairs(G.hand.highlighted) do
                    card:set_ability(G.P_CENTERS["m_crv_dirt"])
                end
         end
    }

    SMODS.Enhancement{
        key = "dirt",
        atlas = 'chaosa',
        pos = {x = 1, y = 1},
        discovered = true,
        unlocked = true,
        loc_txt = { 
            name = 'DIRT',
            text = {
                '{C:green}DIRT'
            }},
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        overrides_base_rank = true,
        any_suit = false,
        always_scores = true,
        weight = 0,
        config = {extra = {x_mult = 99999999,}
        },
        loc_vars = function(self, info_queue, card)
            return { vars = {card.ability.extra.x_mult} }
          end,
          calculate = function(self, card, context, effect)
            if context.main_scoring and context.cardarea == G.hand or context.main_scoring and context.cardarea == G.play then
            return {
                x_mult = card.ability.extra.x_mult 
                }
            end
          end
        }