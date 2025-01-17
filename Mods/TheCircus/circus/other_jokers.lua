local aerialist_prodigy = SMODS.Joker {
  key = 'aerialist_prodigy',
  loc_txt = {
    name = 'Aerialist Prodigy',
    text = {
      "Whenever a Planet is used",
      "gains +Mult equal to the number",
      "of cards in upgraded hand minus 1",
      "{C:inactive}(Currently +#1# Mult){C:inactive}"
    }
  },
  config = { extra = { mult = 0 } },
  rarity = 3,
  atlas = 'a_circus_2',
  pos = { x = 3, y = 1 },
  cost = 3,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult } }
  end,
  calculate = function(self, card, context)
    if context.consumeable and context.consumeable.config.center and context.consumeable.config.center.set then
      if context.consumeable.config.center.set == "Planet" then
        local hands_size_lk = { ["Straight Flush"] = 5, ["Five of a Kind"] = 5, ["Four of a Kind"] = 4, ["Full House"] = 5, 
        ["Flush"] = 5, ["Flush House"] = 5, ["Flush Five"] = 5, ["Straight"] = 5, ["Three of a Kind"] = 3, 
        ["Two Pair"] = 4, ["Pair"] = 2, ["High Card"] = 1 }
        local hand = context.consumeable.ability.hand_type
        card.ability.extra.mult = card.ability.extra.mult + hands_size_lk[hand] - 1
        if hand ~= "High Card" then
          G.E_MANAGER:add_event(Event({delay=0, func = function() card:juice_up(0.7, 0.5); return true end }))
        end
      end
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
        mult_mod = card.ability.extra.mult}
    end
  end
}


local equestrianarchy = SMODS.Joker {
  key = "equestrianarchy",
  loc_txt = {
    name = "Equestrianarchy",
    text = {
      "Gain {C:money}$#1#{} at end of round",
      "Has a {C:green}#2# in #3#{} chance of",
      "shuffling jokers before scoring"
    }
  },
  config = { extra = { money = 6, odds = 3 } },
  rarity = 2,
  atlas = "a_circus_2",
  pos = { x = 1, y = 1 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money, (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.money
  end,
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.jokers and #G.jokers.cards > 1 then
      if pseudorandom("equestrianarchy" .. os.date("%Y%m%d%H%M%S")) < (G.GAME.probabilities.normal / card.ability.extra.odds) then
        play_sound("circus_horse")
        card:juice_up(1.3, 0.5)
        G.jokers:shuffle()
        G.jokers:shuffle()
        G.jokers:shuffle()
        card:juice_up(1.3, 0.5)
      end
    end
  end
}


local fire_eater = SMODS.Joker {
  key = "fire_eater",
  loc_txt = {
    name = "Fire Eater",
    text = {
      "{C:chips}#1#{} Chips",
      "Goes up by {C:chips}#2#{} Chips",
      "when winning a blind with less",
      "than {C:attention}110%{} chips required"
    }
  },
  config = { extra = { chips = 35, chip_gain = 35} },
  rarity = 2,
  atlas = "a_circus",
  pos = { x = 1, y = 2 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {chip_mod = card.ability.extra.chips,
      message = localize {
          type = "variable",
          key = "a_chips",
          vars = { card.ability.extra.chips}
      }}
    elseif not context.individual and not context.repetition and 
      context.end_of_round and not context.blueprint then
      
        if G.GAME.chips >= G.GAME.blind.chips and G.GAME.chips <= 1.1 * G.GAME.blind.chips then
          card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
          return {
            message = "Upgraded!",
            colour = G.C.MULT,
            card=card
          }
      end
    end
  end
}


local grand_finale = SMODS.Joker {
  key = "grand_finale",
  loc_txt = {
    name = "Grand Finale",
    text = {
      "Seals retrigger",
    }
  },
  config = { },
  rarity = 3,
  atlas = "a_circus_2",
  pos = { x = 2, y = 2 },
  cost = 5,
  add_to_deck = function(self, card, from_debuff)
    if not G.GAME.n_seal_repeat then
      G.GAME.n_seal_repeat = 0
    end
    G.GAME.n_seal_repeat = G.GAME.n_seal_repeat + 1
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.n_seal_repeat = G.GAME.n_seal_repeat - 1
  end
  -- The rest is in the patch
}


local hooded_visitor = SMODS.Joker{
  key = "hooded_visitor",
  loc_txt = {
    name = "Hooded Visitor",
    text = {
      "You have {C:attention}#1#{} additional",
      "consumeable slots"
    }
  },
  config = {extra = {slots = 2}},
  rarity = 3,
  atlas = "a_circus_2",
  pos = { x = 4, y = 1 },
  cost = 4,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.slots } }
  end,
  add_to_deck = function(self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
  end
}


local joker_cannonball = SMODS.Joker{
  key = "joker_cannonball",
  loc_txt = {
    name = "Joker Cannonball",
    text = {
      "Create a random five-card hand {C:planet}Planet{} card",
      "the first time a {C:attention}five card hand{}",
      "is scored each round"
    }
  },
  config = { extra = { has_triggered = false} },
  rarity = 2,
  atlas = "a_circus",
  pos = { x = 1, y = 1 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.has_triggered } }
  end,
  calculate = function(self, card, context)
    if context.after and #context.scoring_hand == 5 then
      if card.ability.extra and not card.ability.extra.has_triggered then
        card.ability.extra.has_triggered = true
        local five_hands = {"c_earth", "c_saturn", "c_jupiter", "c_neptune"}
        if G.GAME.hands["Five of a Kind"].played > 0 then
          table.insert(five_hands, "c_planet_x")
        end
        if G.GAME.hands["Flush Five"].played > 0 then
          table.insert(five_hands, "c_eris")
        end
        local pchoice = pseudorandom_element(five_hands, pseudoseed("joker_cannonball"))
        play_sound("circus_cannonball")
        local pcard = create_card("Planet", G.consumeables, nil, nil, nil, nil, pchoice)
        pcard:add_to_deck()
        G.consumeables:emplace(pcard)
        card:juice_up(0.3, 0.5)
      end
    end
    if context.end_of_round and not context.game_over and not context.blueprint then
      card.ability.extra.has_triggered = false
    end
  end
}


local lion_tamer = SMODS.Joker {
  key = "lion_tamer",
  loc_txt = {
    name = "Lion Tamer",
    text = {
      "Whenever you use a consumeable during a blind",
      "draw {C:attention}3{} cards",
      "At end of a hand, randomly discard",
      "to maximum hand size"
    }
  },
  rarity = 3,
  atlas = "a_circus_2",
  pos = { x = 0, y = 0 },
  cost = 6,
  calculate = function(self, card, context)
    if context.consumeable and #G.hand.cards > 0 and not context.open_booster then -- during a round
      G.FUNCS.draw_from_deck_to_hand(3)
    end
    if context.after then
      local n_discards = #G.hand.cards - G.hand.config.card_limit
      if n_discards > 0 then
        for i = 1, n_discards do
          local discard = pseudorandom_element(G.hand.cards, pseudoseed("a_lion_tamer"))
          draw_card(G.hand, G.discard, nil, nil, nil, discard)
        end
      end
    end
  end
}


local loophole = SMODS.Joker {
  key = "loophole",
  loc_txt = {
    name = "Attorney Loophole",
    text = {
      "Four of a kinds trigger two pair jokers",
      "Is always negative when in your jokers"
    }
  },
  config = { type = "Four of a Kind"},
  rarity = 3,
  atlas = "a_circus",
  pos = { x = 3, y = 0 },
  cost = 4,
  calculate = function(self, card, context)
    if context.joker_main and context.scoring_name == "Four of a Kind" then
      local other_joker_ret = {}
      for _, other_joker in ipairs(G.jokers.cards) do
        if other_joker.label == "Mad Joker" then
          if other_joker_ret.mult_mod then
            other_joker_ret.mult_mod = other_joker_ret.mult_mod + 10
          else
            other_joker_ret.mult_mod = 10
          end
          other_joker_ret.message = "Lawyered!"
          G.E_MANAGER:add_event(Event({delay=0.15, func = function() other_joker:juice_up(); return true end }))
        end
        if other_joker.label == "Clever Joker" then
          if other_joker_ret.chip_mod then
            other_joker_ret.chip_mod = other_joker_ret.chip_mod + 80
          else
            other_joker_ret.chip_mod = 80
          end
          other_joker_ret.message = "Lawyered!"
          G.E_MANAGER:add_event(Event({delay=0.15, func = function() other_joker:juice_up(); return true end }))
        end
      end
      return other_joker_ret
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    card:set_edition({negative = true}, true)
    G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    for k, v in pairs(G.GAME.probabilities) do 
      G.GAME.probabilities[k] = v*1.1
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    for k, v in pairs(G.GAME.probabilities) do 
      G.GAME.probabilities[k] = v/1.1
    end
  end
}


local palm_reader = SMODS.Joker{
  key = "palm_reader",
  loc_txt = {
    name = "Palm Reader",
    text = {
      "After you use your last discard,",
      "Creates a {C:tarot}Tarot{} card you need"
    }
  },
  config = { extra = {has_triggered = false} },
  rarity = 3,
  atlas = "a_circus",
  pos = { x = 4, y = 1 },
  cost = 5,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.has_triggered } }
  end,
  calculate = function(self, card, context)
    if context.discard  and G.GAME.current_round.discards_left == 1 then  
      if not card.ability.extra.has_triggered then
        card.ability.extra.has_triggered = true
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          local hand_on = G.GAME.current_round.hands_played
          local hands_left = G.GAME.current_round.hands_left
          local best_hand_level = 0
          for _, val in pairs(G.GAME.hands) do
            if val.level and val.level > best_hand_level then
              best_hand_level = val.level
            end
          end
          -- Choose good, medium or bad tree
          local r = pseudorandom("palm_reader" .. os.date("%Y%m%d%H%M%S"), 1, 3)
          local tcard
          if r == 1 then -- good tree give something actually helpful
            if hands_left >= 2 then
              if G.GAME.dollars <= 3 then
                if G.GAME.round_resets.ante <= 3 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_devil") -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_magician") -- Tested
                end
              else
                if best_hand_level < 3 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_high_priestess") -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_emperor") -- Tested
                end
              end
            else -- only 1 hand left
              if G.GAME.chips / G.GAME.blind.chips < 0.5 then
                if G.jokers and #G.jokers.cards <= 1 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_judgement") -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_justice") -- Tested
                end
              else
                if best_hand_level < 3 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_empress")  -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_heirophant") -- Tested
                end
              end
            end
          elseif r == 2 then -- might be helpful, somewhat targeted
            if G.GAME.round_resets.ante > #G.jokers.cards then
              if G.GAME.dollars > 8 then
                if G.GAME.starting_deck_size > 51 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_hanged_man")  -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_temperance")  -- Tested
                end
              else  
                if #G.jokers.cards > 2 then
                  tcard = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_immolate")
                else
                  tcard = create_card("Spectral", G.consumeables, nil, nil, nil, nil, "c_ouija")
                end
              end
            else
              local n_enhanced = 0
              for _, val in ipairs(G.hand.cards) do
                  if val.ability.set == "Enhanced" then n_enhanced = n_enhanced + 1 end
              end
              if n_enhanced > 1 then
                if #G.consumeables.cards > 0 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_fool")  -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_death")  -- Tested
                end
              else
                if hands_left < 3 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_chariot")  -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_hermit")  -- Tested
                end
              end
            end
          else -- bad tree, give something mostly unhelpful
            if hands_left >= 2 then
              if G.GAME.chips / G.GAME.blind.chips < 0.5 then
                local nglass = 0
                for _, val in ipairs(G.hand.cards) do
                    if val.ability.name == "Glass Card" then nglass = nglass + 1 end
                end
                if nglass >= 1 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_star")  -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_tower")  -- Tested
                end
              else
                local n_aces = 0
                for _, val in ipairs(G.hand.cards) do
                  if val.base and val.base.value == "Ace" then
                    n_aces = n_aces + 1
                  end
                end
                if n_aces == 0 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_strength") -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_world")  -- Tested
                end
              end
            else
              local nwild = 0
              for _, val in ipairs(G.hand.cards) do
                  if val.ability.name == "Wild Card" then nwild = nwild + 1 end
              end
              if nwild == 0 then
                if #G.jokers.cards > 2 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_wheel_of_fortune") -- Tested
                else
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_sun")  -- Tested
                end
              else
                if #G.consumeables.cards == 0 then
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_lovers") -- Tested
                else 
                  tcard = create_card("Tarot", G.consumeables, nil, nil, nil, nil, "c_moon")  -- Tested
                end
              end
            end 
          end
          tcard:add_to_deck()
          G.consumeables:emplace(tcard)
        end
      end
    end
    if context.end_of_round and not context.game_over and not context.blueprint then
      card.ability.extra.has_triggered = false
    end
  end 
}


local ringmaster = SMODS.Joker {
  key = "ringmaster",
  loc_txt = {
    name = "Ringmaster",
    text = {
      "Earn {C:money}$1{} at",
      "end of round for each joker, ",
      "or {C:money}$2{} if it is a Circus joker"
    }
  },
  config = { extra = { money = 1, money_circus = 2 } },
  rarity = 3,
  atlas = "a_circus",
  cost = 6,
  pos = { x = 3, y = 2 },  
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.money } }
  end,
  calc_dollar_bonus = function(self, card)
    local bonus = 0
    for _, joker in ipairs(G.jokers.cards) do
      if string.find(joker.config.center.key, "j_circus_") then
        bonus = bonus + card.ability.extra.money_circus
      else
        bonus = bonus + card.ability.extra.money
      end
    end
    if bonus > 0 then return bonus end
  end
}


local safety_net = SMODS.Joker {
  key = "safety_net",
  loc_txt = {
    name = "Safety Net",
    text = {
      "During boss blinds,",
      "all probabilities are {C:green}tripled{}"
    }
  },
  rarity = 2,
  atlas = "a_circus_2",
  pos = { x = 1, y = 2 },
  cost = 5,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if G.GAME.blind and G.GAME.blind:get_type() == 'Boss' then
      if context.setting_blind then
        for k, v in pairs(G.GAME.probabilities) do 
          G.GAME.probabilities[k] = v*3
        end
      end
      if context.end_of_round and not context.repetition and not context.individual then
        for k, v in pairs(G.GAME.probabilities) do 
          G.GAME.probabilities[k] = v/3
        end
      end
    end
  end
}


local stoic_clown = SMODS.Joker {
  key = "stoic_clown",
  loc_txt = {
    name = "Stoic Clown",
    text = {
      "Gain {C:mult}#1#{} Mult",
      "and {C:chips}#2#{} Chips",
      "when a scored hand contains",
      "{C:attention}2 or more{} Stone cards"
    }
  },
  config = { extra = { mult = 20, chips = 100 } },
  rarity = 2,
  atlas = "a_circus_2",
  pos = { x = 2, y = 1 },
  cost = 1,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n_stones = 0
      for _, card in ipairs(context.scoring_hand) do
        if (card.ability.name == "Stone Card" and not card.config.center.no_suit) then
          n_stones = n_stones + 1
        end
      end
      if n_stones >= 2 then
        return {
          message = "100 chips, 20 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
      end
    end
  end
}


local strongman = SMODS.Joker {
  key = "strongman",
  loc_txt = {
    name = "Strongman",
    text = {
      "On the last hand of the round,",
      "destroys a consumeable to add",
      "Steel to a random un-enhanced card"
    }
  },
  config = { },
  rarity = 2,
  atlas = "a_circus",
  pos = { x = 0, y = 2 },
  cost = 4,
  calculate = function(self, card, context)
    if context.before and #G.consumeables.cards > 0 and G.GAME.current_round.hands_left == 0 then
      local ccard = pseudorandom_element(G.consumeables.cards, pseudoseed("strongman"))
      
      if #G.hand.cards > 0 then 
        local plain_cards = {}
        for _, val in ipairs(G.hand.cards) do
            if not val.ability or val.ability.set ~= "Enhanced" then
              table.insert(plain_cards, val)
            end
        end
        if #plain_cards > 0 then
          play_sound("circus_strongman")
          local pcard = pseudorandom_element(plain_cards, pseudoseed("strongman_steel"))
          pcard:set_ability(G.P_CENTERS.m_steel, true)
          pcard:juice_up(0.3, 0.5)
          G.E_MANAGER:add_event(Event({
            func = function() 
              (context.blueprint_card or card):juice_up(0.3, 0.5)
              ccard:start_dissolve()
              return true
            end}))
        end
      end
    end
  end
}


local trapezist = SMODS.Joker {
  key = "trapezist",
  loc_txt = {
    name = "Trapezist",
    text = {
      "{C:mult}#1#{} Mult",
      "Goes up by {C:mult}#2#{} Mult",
      "when winning a blind with less",
      "than {C:attention}110%{} chips required"
    }
  },
  config = { extra = { mult = 7, mult_gain = 7} },
  rarity = 2,
  atlas = "a_circus",
  pos = { x = 0, y = 0 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_gain } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {mult_mod = card.ability.extra.mult,
      message = localize {
          type = "variable",
          key = "a_mult",
          vars = { card.ability.extra.mult}
      }}
    elseif not context.individual and not context.repetition and 
      context.end_of_round and not context.blueprint then
      
        if G.GAME.chips >= G.GAME.blind.chips and G.GAME.chips <= 1.1 * G.GAME.blind.chips then
          card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
          return {
            message = "Upgraded!",
            colour = G.C.MULT,
            card=card
          }
      end
    end
  end
}


-- LEGENDARY
local oleg_popov = SMODS.Joker {
  key = "oleg_popov",
  loc_txt = {
    name = "Oleg Popov",
    text = {
      "Double your hand size"
    }
  },
  config = { extra = { size_before_double = 0 } },
  rarity = 4,
  atlas = "a_circus",
  pos = { x = 0, y = 3 },
  soul_pos = { x = 4, y = 3 },
  cost = 20,
  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.size_before_double = G.hand.config.card_limit
    G.hand:change_size(card.ability.extra.size_before_double)
  end,
  -- Inverse of above function.
  remove_from_deck = function(self, card, from_debuff)
    -- Adds - instead of +, so they get subtracted when this card is removed.
    G.hand:change_size(-card.ability.extra.size_before_double)
  end
}