--- STEAMODDED HEADER
--- MOD_NAME: Chip's Stuff
--- MOD_ID: ChipsStuff
--- MOD_AUTHOR: [Chipfoxxo]
--- MOD_DESCRIPTION: Contains 12 new jokers mainly based around suits and generating consumables. And there's furries in this one too! :3
--- BADGE_COLOR: ffcc00

----------------------------------------------
------------MOD CODE -------------------------
SMODS.Atlas {
  key = "ChipsStuff",
  path = "FurryJokers.png",
  -- Width of each sprite in 1x size
  px = 71,
  -- Height of each sprite in 1x size
  py = 95
}

SMODS.Joker {
  key = 'tail',
  loc_txt = {
    name = 'Tail',
    text = {
      "{C:green}#1# in #2#{} chance for",
      "each played {C:diamonds}Diamond{}",
      "to create a copy of",
      "{C:tarot}The Star{} when scored",
      "{C:inactive}(Must have room)",
    }
  },
  config = { extra = { odds = 8 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 5, y = 0 },
  cost = 5,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and not context.repetition then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if context.other_card:is_suit('Diamonds') and pseudorandom('tail') < G.GAME.probabilities.normal / card.ability.extra.odds then
         G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           return {
               G.E_MANAGER:add_event(Event({
                 trigger = 'after',
                 delay = 0.0,
                 func = (function()
                   local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_star', 'tail')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end)})),
                 card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_tarot"), colour = G.C.SECONDARY_SET.Tarot})
           }
      end
    end
  end
end
}

SMODS.Joker {
  key = 'maw',
  loc_txt = {
    name = 'Maw',
    text = {
      "{C:green}#1# in #2#{} chance to create",
      "a copy of {C:tarot}The Sun{} if",
      "played hand contains a",
      "{C:hearts}Hearts{} {C:attention}Flush{}",
      "{C:inactive}(Must have room)",
    }
  },
  config = { extra = { odds = 3 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 3, y = 0 },
  cost = 5,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and next(context.poker_hands['Flush']) then
      local suits = {
        ["Hearts"] = 0
      }
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.name ~= 'Wild Card' then
          if context.scoring_hand[i]:is_suit('Hearts') then suits["Hearts"] = suits["Hearts"] + 1 end
        end
      end
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.name == 'Wild Card' then
          if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0  then suits["Hearts"] = suits["Hearts"] + 1 end
        end
      end
      if suits["Hearts"] > 3 then
       if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
         if pseudorandom('maw') < G.GAME.probabilities.normal / card.ability.extra.odds then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
             return {
                  G.E_MANAGER:add_event(Event({
                     trigger = 'before',
                     delay = 0.0,
                     func = function()
                       local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_sun', 'maw')
                         card:add_to_deck()
                         G.consumeables:emplace(card)
                         G.GAME.consumeable_buffer = 0
                       return true
                     end})),
                     card = card,
                     message = localize('k_plus_tarot'),
                     colour = G.C.SECONDARY_SET.Tarot
              }
        end
      end
    end
  end
end
}

SMODS.Joker {
  key = 'snoot',
  loc_txt = {
    name = 'Snoot',
    text = {
      "{C:green}#1# in #2#{} chance to create",
      "a copy of {C:tarot}The World{} if",
      "played hand contains at",
      "least one {C:spades}Spade{} and does",
      "not contain a {C:attention}Flush{}",
      "{C:inactive}(Must have room)",
    }
  },
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 2, y = 0 },
  cost = 5,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and not next(context.poker_hands['Flush']) then
      local suits = {
        ["Spades"] = 0
      }
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.name ~= 'Wild Card' then
          if context.scoring_hand[i]:is_suit('Spades') then suits["Spades"] = suits["Spades"] + 1 end
        end
      end
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i].ability.name == 'Wild Card' then
          if context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1 end
        end
      end
      if suits["Spades"] > 0 then
       if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
         if pseudorandom('snoot') < G.GAME.probabilities.normal / card.ability.extra.odds then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
             return {
                  G.E_MANAGER:add_event(Event({
                     trigger = 'before',
                     delay = 0.0,
                     func = function()
                       local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_world', 'snoot')
                         card:add_to_deck()
                         G.consumeables:emplace(card)
                         G.GAME.consumeable_buffer = 0
                       return true
                     end})),
                     card = card,
                     message = localize('k_plus_tarot'),
                     colour = G.C.SECONDARY_SET.Tarot
              }
        end
      end
    end
  end
end
}

SMODS.Joker {
  key = 'paw',
  loc_txt = {
    name = 'Paw',
    text = {
      "{C:green}#1# in #2#{} chance for",
      "each discarded",
      "non-{C:clubs}Club{} to create",
      "a copy of {C:tarot}The Moon{}",
      "{C:inactive}(Must have room)",
    }
  },
  config = { extra = { odds = 6 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 4, y = 0 },
  cost = 5,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.discard then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        if not context.other_card:is_suit('Clubs') and pseudorandom('paw') < G.GAME.probabilities.normal / card.ability.extra.odds then
         G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           return {
               G.E_MANAGER:add_event(Event({
                 trigger = 'before',
                 delay = 0.0,
                 func = (function()
                   local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, 'c_moon', 'paw')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end)})),
                 card = card,
                 message = localize('k_plus_tarot'),
                 colour = G.C.SECONDARY_SET.Tarot
           }
      end
    end
  end
end
}

SMODS.Joker {
  key = 'fursuit_head',
  loc_txt = {
    name = 'Fursuit Head',
    text = {
      "Gains {C:money}$#1#{} of {C:attention}sell value{} at ",
      "end of round, sell this card",
      "to create a copy of {C:spectral}Sigil{}",
      "{C:inactive}(Must have room)",
    }
  },
  config = { extra = 1 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 6, y = 0 },
  cost = 6,
  eternal_compat = false,
  blueprint_compat = false,
  brainstorm_compat = false,
  calculate = function(self, card, context)
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
      card.ability.extra_value = card.ability.extra_value + card.ability.extra
      card:set_cost()
    card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_val_up"), colour = G.C.MONEY })
    end
    if context.selling_self then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           return {
              G.E_MANAGER:add_event(Event({
                 trigger = 'before',
                 delay = 0.0,
                 func = function()
                   local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, 'c_sigil', 'fursuit_head')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end})),
                 card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral})
           }
     end
  end
end
}

SMODS.Joker {
  key = 'fortuitous_joker',
  loc_txt = {
    name = 'Fortuitous Joker',
    text = {
      "{C:green}#1# in #2#{} chance for each",
      "played {C:attention}7{} to become a",
      "{C:attention}Lucky{} card when scored",
    }
  },
  config = { extra = { odds = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  rarity = 1,
  atlas = 'ChipsStuff',
  pos = { x = 2, y = 1 },
  cost = 7,
  eternal_compat = true,
  blueprint_compat = false,
  brainstorm_compat = false,
  calculate = function(self, card, context)
    if context.cardarea == G.play and not context.repetition then
      if (context.other_card:get_id() == 7) and pseudorandom('fortuitous_joker') < G.GAME.probabilities.normal / card.ability.extra.odds then
       G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
         return {
           card = context.other_card,
           context.other_card:set_ability(G.P_CENTERS.m_lucky, nil, true),
           G.E_MANAGER:add_event(Event({
             func = function()
               context.other_card:juice_up()
               return true
             end})),
           card_eval_status_text(context.other_card, "extra", nil, nil, nil, { message = "Lucky", colour = G.C.MONEY })
         }
    end
  end
end
}

SMODS.Joker {
  key = 'frying_pan',
  loc_txt = {
    name = 'Frying Pan',
    text = {
      "{C:attention}+#1#{} hand size,",
      "{C:green}1 in 6{} cards get",
      "drawn face down",
    }
  },
  config = { extra = { hand_size = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hand_size } }
  end,
  rarity = 2,
  atlas = 'ChipsStuff',
  pos = { x = 0, y = 1 },
  cost = 6,
  eternal_compat = true,
  blueprint_compat = false,
  brainstorm_compat = false,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.modifiers.flipped_cards = 6
      G.hand:change_size(card.ability.extra.hand_size)
      return true
    end
    if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
      G.GAME.modifiers.flipped_cards = nil
      G.hand:change_size(card.ability.extra.hand_size * -1)
      return true
    end
    if context.selling_self then
      G.GAME.modifiers.flipped_cards = nil
      G.hand:change_size(card.ability.extra.hand_size * -1)
      return true
    end
  end
}

SMODS.Joker {
  key = 'club_sandwich',
  loc_txt = {
    name = 'Club Sandwich',
    text = {
      "{C:mult}+#1#{} Mult, {C:mult}-#2#{} Mult per ",
      "each played non-{C:clubs}Club{}",
      "card that is scored",
    }
  },
  config = { mult = 50, extra = 2 },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.mult, card.ability.extra } }
  end,
  rarity = 2,
  atlas = 'ChipsStuff',
  pos = { x = 1, y = 1 },
  cost = 6,
  eternal_compat = false,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and not context.repetition and not context.other_card:is_suit('Clubs') then
      if card.ability.mult - card.ability.extra == 0 then 
       G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
              func = function()
                G.jokers:remove_card(self)
                card:remove()
                card = nil
              return true; end})) 
            return true
          end
        })) 
        return {
          card_eval_status_text(card, "extra", nil, nil, nil, { message = localize('k_eaten_ex'), colour = G.C.RED } )
        }
        else
          trigger = 'after'
          card.ability.mult = card.ability.mult - card.ability.extra
          return {
            card_eval_status_text(card, "extra", nil, nil, nil, { message = localize { type = 'variable', key = 'a_mult_minus', vars = { card.ability.mult } }, colour = G.C.MULT } )
          }
        end
      end
    if context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.mult } },
        colour = G.C.MULT,
        mult_mod = card.ability.mult,
      }
    end
  end
}

SMODS.Joker {
  key = 'just_the_two_of_us',
  loc_txt = {
    name = 'Just the Two of Us',
    text = {
      "Sell this card to create two",
      "{C:spectral}Spectral{} cards if your most",
      "played {C:attention}poker hand{} is {C:attention}Pair{}",
      "{C:inactive}(Must have room)",
    }
  },
  rarity = 2,
  atlas = 'ChipsStuff',
  pos = { x = 3, y = 1 },
  cost = 7,
  eternal_compat = false,
  blueprint_compat = false,
  brainstorm_compat = false,
  calculate = function(self, card, context)
    if context.selling_self then
        if G.GAME.hands['Pair'].played >= G.GAME.hands['High Card'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Two Pair'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Three of a Kind'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Straight'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Flush'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Full House'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Four of a Kind'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Straight Flush'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Five of a Kind'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Flush House'].played and G.GAME.hands['Pair'].played >= G.GAME.hands['Flush Five'].played and G.GAME.hands['Pair'].played > 0 then
        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit - 1 then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           return {
              G.E_MANAGER:add_event(Event({
                 trigger = 'before',
                 delay = 0.0,
                 func = function()
                   local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'just_the_two_of_us')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end})),
                 card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral}),
              G.E_MANAGER:add_event(Event({
                 trigger = 'before',
                 delay = 0.0,
                 func = function()
                   local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'just_the_two_of_us')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end})),
                 card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral})
           }
        elseif #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
           G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
           return {
              G.E_MANAGER:add_event(Event({
                 trigger = 'before',
                 delay = 0.0,
                 func = function()
                   local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'just_the_two_of_us')
                     card:add_to_deck()
                     G.consumeables:emplace(card)
                     G.GAME.consumeable_buffer = 0
                   return true
                 end})),
                 card_eval_status_text(card, "extra", nil, nil, nil, { message = localize("k_plus_spectral"), colour = G.C.SECONDARY_SET.Spectral})
           }
        end
     end
  end
end
}

SMODS.Joker {
  key = 'vendor',
  loc_txt = {
    name = 'Vendor',
    text = {
      "{C:blue}Common{} Jokers",
      "each give {C:chips}+#1#{} Chips",
    }
  },
  config = { extra = { chips = 500 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips } }
  end,
  rarity = 3,
  atlas = 'ChipsStuff',
  pos = { x = 4, y = 1 },
  cost = 8,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.other_joker then
      if context.other_joker.config.center.rarity == 1 and self ~= context.other_joker then
        return {
          G.E_MANAGER:add_event(Event({
            trigger = 'before',
            delay = 0.0,
            func = function()
              context.other_joker:juice_up(0.5, 0.5)
            return true
          end})),
          card_eval_status_text(card, "extra", nil, nil, nil, { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }, colour = G.C.CHIPS } ),
          chip_mod = card.ability.extra.chips
        }
       end
    end
  end
}

SMODS.Joker {
  key = 'anthonv',
  loc_txt = {
    name = 'Anthonv',
    text = {
      "{X:mult,C:white}X#1#{} Mult...",
      "{C:inactive}...?",
    }
  },
  config = { extra = { Xmult = 0.5 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult } }
  end,
  rarity = 3,
  atlas = 'ChipsStuff',
  pos = { x = 5, y = 1 },
  soul_pos = { x = 6, y = 1 },
  cost = 9,
  eternal_compat = false,
  blueprint_compat = false,
  brainstorm_compat = false,
  calculate = function(self, card, context)
    if card.config.center.soul_pos and (card.config.center.discovered or self.bypass_discovery_center) then
      card = card
      local scale_mod = 0.07 + 0.02*math.sin(1.8*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL))*math.pi*14)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^3
      local rotate_mod = 0.05*math.sin(1.219*G.TIMERS.REAL) + 0.00*math.sin((G.TIMERS.REAL)*math.pi*5)*(1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL)))^2
      card.hover_tilt = card.hover_tilt*1.5
      card.children.floating_sprite:draw_shader('hologram', nil, card.ARGS.send_to_shader, nil, card.children.center, 2*scale_mod, 2*rotate_mod)
      card.hover_tilt = card.hover_tilt/1.5
    end
    if context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
        colour = G.C.MULT,
        Xmult_mod = card.ability.extra.Xmult,
      }
    end
    if context.end_of_round and not context.repetition and not context.individual then
      if G.GAME.blind.boss and not (context.blueprint_card or self).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
        G.GAME.joker_buffer = G.GAME.joker_buffer + math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
        G.E_MANAGER:add_event(Event({
          func = function() 
            local card = create_card('Joker', G.jokers, true, 4, nil, nil, nil, 'anthonv')
            card:add_to_deck()
            G.jokers:emplace(card)
            card:start_materialize()
            G.GAME.joker_buffer = 0
            return true
          end}))   
          card_eval_status_text(card, "extra", nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.SECONDARY_SET.Spectral})
      end
    end
  end
}

SMODS.Joker {
  key = 'chip',
  loc_txt = {
    name = 'Chip',
    text = {
      "{C:chips}+#1#{} Chips",
    }
  },
  config = { extra = { chips = 3000 } },
  loc_vars = function(self, info_queue, center)
    return { vars = { center.ability.extra.chips } }
  end,
  rarity = 4,
  atlas = 'ChipsStuff',
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },
  cost = 20,
  eternal_compat = true,
  blueprint_compat = true,
  brainstorm_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
        colour = G.C.CHIPS,
        chip_mod = card.ability.extra.chips,
      }
    end
  end
}
----------------------------------------------
------------MOD CODE END----------------------