
local balancing_act = SMODS.Joker {
    key = 'balancing_act',
    loc_txt = {
      name = 'Balancing Act',
      text = {
        "Rounds chips up to the next",
        "highest multiple of 100"
      }
    },
    config = {},
    rarity = 1,
    atlas = 'a_circus',
    pos = { x = 4, y = 0 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      return {}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        local rounded_chips = math.ceil(hand_chips / 100) * 100
        local chip_difference = rounded_chips - hand_chips
        return {
          chip_mod = chip_difference,
          message = "Rounded to " .. rounded_chips .. " chips!"
        }
      end
    end
  }

local candy_butcher = SMODS.Joker {
    key = 'candy_butcher',
    loc_txt = {
        name = 'Candy Butcher',
        text = {
        "Gain {C:mult}#1#{} Mult on",
        "the {C:attention}first hand{} of each round",
        "and during {C:attention}boss blinds{}"
        }
    },
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'a_circus',
    blueprint_compat = true,
    pos = { x = 3, y = 1 },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and (G.GAME.current_round.hands_played == 0
        or (G.GAME.blind and G.GAME.blind:get_type() == 'Boss')) then
        return { mult_mod = card.ability.extra.mult,
        message = localize {
            type = 'variable',
            key = 'a_mult',
            vars = { card.ability.extra.mult}
            }
        }
        end
    end
}

local curtain_puller = SMODS.Joker {
    key = 'curtain_puller',
    loc_txt = {
      name = 'Curtain Puller',
      text = {
        "Gains {C:money}$#1#{} sell value",
        "whenever you discard"
      }
    },
    config = { extra = { dollar_bonus = 1, discard_use = -1 } },
    rarity = 1,
    blueprint_compat = false,
    atlas = 'a_circus_2',
    pos = { x = 1, y = 0 },
    cost = 2,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.dollar_bonus, card.ability.extra.discard_use } }
    end,
    calculate = function(self, card, context)
      if context.discard and not context.blueprint then 
        if G.GAME.current_round.discards_used ~= card.ability.extra.discard_use then
          card.ability.extra.discard_use = G.GAME.current_round.discards_used
          card.ability.extra_value = (card.ability.extra_value or 0) + card.ability.extra.dollar_bonus
          card:set_cost()
          return {
            message = "+$1",
          }
        end
      end
      if context.end_of_round and not context.game_over and not context.blueprint then
        card.ability.extra.discard_use = -1
      end
    end
}


local entrance_of_the_gladiators = SMODS.Joker {
    key = 'entrance_of_the_gladiators',
    loc_txt = {
      name = 'Entrance of the Gladiators',
      text = {
          "This Joker gains {X:mult,C:white} X#2# {} Mult",
          "every time you buy a {C:attention}Circus joker{}",
          "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"
      } 
    },
    config = { extra = { xmult = 1.5, xmult_gain = 0.25 } },
    rarity = 1,
    atlas = 'a_circus',
    pos = { x = 0, y = 1 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_gain } }
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.buying_card and not context.blueprint and not (context.card == card) then
        if string.find(context.card.config.center.key, "j_circus_") then
          card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
          G.E_MANAGER:add_event(Event({delay=0.15, 
          func = function() 
            card:juice_up()
            play_sound('circus_entrance')
            return true 
          end }))
        end
      end
      if context.joker_main then
        return { Xmult_mod = card.ability.extra.xmult,
        message = localize {
            type = 'variable',
            key = 'a_xmult',
            vars = { card.ability.extra.xmult}
        }}
      end
    end
  }


local joker_pyramid = SMODS.Joker {
  key = 'joker_pyramid',
  loc_txt = {
    name = 'Joker Pyramid',
    text = {
      "Once per round, gain an additional hand",
      "when you score {C:attention}Three of a kind{}"
    }
  },
  config = { extra = { count_3oaks = 0 } },
  rarity = 1,
  atlas = 'a_circus_2',
  pos = { x = 0, y = 2 },
  cost = 6,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.count_3oaks } }
  end,
  calculate = function(self, card, context)
    if context.scoring_name == "Three of a Kind" and context.joker_main then
      card.ability.extra.count_3oaks = card.ability.extra.count_3oaks + 1
      if card.ability.extra.count_3oaks == 1 then
        ease_hands_played(1)
        card:juice_up()
        return {
          message = "Gained a hand!",
          colour = G.C.MULT,
          card=card
        }
      end
    end
    if context.end_of_round and not context.game_over and not context.blueprint then
      card.ability.extra.count_3oaks = 0
    end
  end
}


local knife_thrower = SMODS.Joker {
    key = 'knife_thrower',
    loc_txt = {
      name = 'Knife Thrower',
      text = {
        "{C:mult}#1#{} Chips",
        "Reroll chips on buy and when you sell a joker"
      }
    },
    config = { extra = { chips = 50 } },
    rarity = 1,
    atlas = 'a_circus_2',
    pos = { x = 4, y = 2 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips } }
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.joker_main then
        return { chip_mod = card.ability.extra.chips,
        message = localize {
            type = 'variable',
            key = 'a_chips',
            vars = { card.ability.extra.chips}
        }}
      end
      if context.selling_card and not context.blueprint and context.card.config.center.set == 'Joker' then
        card.ability.extra.chips = math.random(1, 100)
      end
    end,
    add_to_deck = function(self, card, from_debuff)
      card.ability.extra.chips = math.random(1, 100)
    end
  }


local mucker = SMODS.Joker {
    key = 'mucker',
    loc_txt = {
      name = 'Mucker',
      text = {
        "{X:mult,C:white}X#1#{} Mult",
        "if this is the leftmost joker"
      }
    },
    config = { extra = { xmult = 2 } },
    rarity = 1,
    atlas = 'a_circus',
    pos = { x = 2, y = 2 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.xmult } }
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.joker_main then
        if G.jokers.cards and card == G.jokers.cards[1] then
          return { Xmult_mod = card.ability.extra.xmult,
          message = localize {
              type = 'variable',
              key = 'a_xmult',
              vars = { card.ability.extra.xmult}
          }}
      end
      end
    end
  }


local musical_clown = SMODS.Joker {
  key = 'musical_clown',
  loc_txt = {
    name = 'Musical Clown',
    text = {
      "Gain {C:mult}#1#{} Mult",
      "and {C:chips}#2#{} Chips",
      "when a scored hand contains 2 or more {C:hearts}Hearts{}"
    }
  },
  config = { extra = { mult = 4, chips = 25 } },
  rarity = 1,
  atlas = 'a_circus_2',
  pos = { x = 2, y = 0 },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n_hearts = 0
      for _, card in ipairs(context.scoring_hand) do
        if (card.ability.name ~= 'Stone Card' and not card.config.center.no_suit and not card.debuffed_by_blind)
            and card.base.suit == 'Hearts' then
          n_hearts = n_hearts + 1
        end
      end
      if n_hearts >= 2 then
        return {
          message = "25 chips, 4 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
      end
    end
  end
}


local sad_clown = SMODS.Joker {
  key = 'sad_clown',
  loc_txt = {
    name = 'Sad Clown',
    text = {
      "Gain {C:mult}#1#{} Mult",
      "and {C:chips}#2#{} Chips",
      "when a scored hand contains 2 or more {C:diamonds}Diamonds{}"
    }
  },
  config = { extra = { mult = 4, chips = 25 } },
  rarity = 1,
  atlas = 'a_circus_2',
  pos = { x = 3, y = 0 },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n_diamonds = 0
      for _, card in ipairs(context.scoring_hand) do
        if (card.ability.name ~= 'Stone Card' and not card.config.center.no_suit and not card.debuffed_by_blind)
            and card.base.suit == 'Diamonds' then
          n_diamonds = n_diamonds + 1
        end
      end
      if n_diamonds >= 2 then
        return {
          message = "25 chips, 4 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
      end
    end
  end
}


local silly_clown = SMODS.Joker {
  key = 'silly_clown',
  loc_txt = {
    name = 'Silly Clown',
    text = {
      "Gain {C:mult}#1#{} Mult",
      "and {C:chips}#2#{} Chips",
      "when a scored hand contains 2 or more {C:spades}Spades{}"
    }
  },
  config = { extra = { mult = 4, chips = 25 } },
  rarity = 1,
  atlas = 'a_circus_2',
  pos = { x = 0, y = 1 },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n_spades = 0
      for _, card in ipairs(context.scoring_hand) do
        if (card.ability.name ~= 'Stone Card' and not card.config.center.no_suit and not card.debuffed_by_blind) 
            and card.base.suit == 'Spades' then
          n_spades = n_spades + 1
        end
      end
      if n_spades >= 2 then
        return {
          message = "25 chips, 4 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
      end
    end
  end
}


local stilt_walker = SMODS.Joker {
    key = 'stilt_walker',
    loc_txt = {
      name = 'Stilt Walker',
      text = {
        "Rounds mult up to the next",
        "highest multiple of 10"
      }
    },
    config = {},
    rarity = 1,
    atlas = 'a_circus',
    pos = { x = 2, y = 1 },
    cost = 5,
    loc_vars = function(self, info_queue, card)
      return {}
    end,
    calculate = function(self, card, context)
      if context.joker_main then
        local rounded_mult = math.ceil(mult / 10) * 10
        local mult_difference = rounded_mult - mult
        return {
          mult_mod = mult_difference,
          message = "Rounded to " .. rounded_mult .. " mult!"
        }
      end
    end
  }


local sword_swallower = SMODS.Joker { 
    key = 'sword',
    loc_txt = {
      name = 'Sword Swallower',
      text = {
        "{C:mult}+25{} Mult if bought",
        "{C:mult}+10{} otherwise",
        "{C:inactive}(Currently {C:mult}+#1#{} Mult){C:inactive}"
      }
    },
    config = { extra = { mult = 10 } },
    rarity = 1,
    atlas = 'a_circus',
    pos = { x = 2, y = 0 },
    cost = 10,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult } }
    end,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.buying_card and not context.blueprint and (context.card == card) then
        card.ability.extra.mult = 25
      end
      if context.joker_main then
        return { mult_mod = card.ability.extra.mult,
        message = localize {
            type = 'variable',
            key = 'a_mult',
            vars = {card.ability.extra.mult}
        }}
      end
    end
  }


local talent_show = SMODS.Joker {
    key = "talent_show",
    loc_txt = {
      name = 'Talent Show',
      text = {
        "Retrigger all played cards ",
        "with an edition and/or seal"
      }
    },
    config = { extra = { repetitions = 1 } },
    rarity = 1,
    atlas = 'a_circus_2',
    pos = { x = 3, y = 2 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
      if context.cardarea == G.play and context.repetition and not context.repetition_only then
        if context.other_card.seal or context.other_card.edition then
          return {
            message = 'Again!',
            repetitions = card.ability.extra.repetitions,
            card = context.other_card
          }
        end
      end
    end
  }


local trickster = SMODS.Joker {
    key = 'trickster',
    loc_txt = {
      name = 'Trickster',
      text = {
        "{C:chips}+#1#{} Chips {C:mult}+#2#{} Mult",
        "Sell to add a random joker that ",
        "costs {C:money}1{} to sell."
      }
    },
    config = { extra = { chips = 25, mult = 2 } },
    rarity = 1,
    atlas = 'a_circus',
    eternal_compat = false,
    pos = { x = 1, y = 0 },
    cost = 3,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.chips, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
      if context.selling_self and not context.blueprint then
        local ccard = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'trik')
  
        ccard.sell_cost = -1
        ccard:start_materialize()
        ccard:add_to_deck()
        G.jokers:emplace(ccard)
      end
      if context.joker_main then
        return {
          message = "25 chips, 2 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
        end
      end,
    add_to_deck = function(self, card, from_debuff)
      card.sell_cost = -1
    end
  }


local violent_clown = SMODS.Joker {
  key = 'violent_clown',
  loc_txt = {
    name = 'Violent Clown',
    text = {
      "Gain {C:mult}#1#{} Mult",
      "and {C:chips}#2#{} Chips",
      "when a scored hand contains 2 or more {C:clubs}Clubs{}"
    }
  },
  config = { extra = { mult = 4, chips = 25 } },
  rarity = 1,
  atlas = 'a_circus_2',
  pos = { x = 4, y = 0 },
  cost = 1,
  blueprint_compat = true,
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      local n_clubs = 0
      for _, card in ipairs(context.scoring_hand) do
        if (card.ability.name ~= 'Stone Card' and not card.config.center.no_suit  and not card.debuffed_by_blind)
            and card.base.suit == 'Clubs' then
          n_clubs = n_clubs + 1
        end
      end
      if n_clubs >= 2 then
        return {
          message = "25 chips, 4 mult",
          chip_mod = card.ability.extra.chips,
          mult_mod = card.ability.extra.mult
          }
      end
    end
  end
}