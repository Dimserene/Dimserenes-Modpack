SMODS.Joker { -- Fire and Ice
  key = 'ADOFAI',
  rarity = 2,
  cost = 6,
  atlas = "adofai-jokers-1",
  pos = { x = 1 , y = 0},
  config = { extra = { Xmult = 2 , Xchips = 2 , isFire= false , status_a = "X:chips,C:white" , status_b = "Chips"} },
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.Xmult,
        card.ability.extra.Xchips,
        card.ability.extra.isFire,
        card.ability.extra.status_a,
        card.ability.extra.status_b
    } }
  end,
  calculate = function (self,card,context) 
    if context.joker_main then
      if not context.blueprint then
        if card.ability.extra.isFire then -- Fire means mult
          card.ability.extra.isFire = false
          card.ability.extra.status_a = "X:mult,C:white"
          card.ability.extra.status_b = "Chips"
          return {
            Xmult_mod = card.ability.extra.Xmult,
            message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.Xmult } }),
          }
        else -- Ice means chips
          card.ability.extra.isFire = true 
          card.ability.extra.status_a = "X:chips,C:white"
          card.ability.extra.status_b = "Mult"
          return {
            message = localize({ type = "variable", key = "a_xchips", vars = { card.ability.extra.Xchips } }),
            Xchip_mod = card.ability.extra.Xchips,
            colour = G.C.CHIPS
        }
        end
      end
    end
  end
}

SMODS.Joker { -- Speed trial
  key = 'Speed_trial',
  config = { extra = { Xmult = 1.0 , Xmult_gain = 0.2 , Xmult_lose = 0.1} },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain , card.ability.extra.Xmult_lose} }
  end,
  rarity = 3,
  cost = 6,
  atlas = "adofai-jokers-1",
  pos = { x = 0 , y = 0},
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
    end
    if context.setting_blind then
      card.ability.extra.Xmult = ( card.ability.extra.Xmult + card.ability.extra.Xmult_gain )
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
    end
    if context.pre_discard then
      if card.ability.extra.Xmult > 1.0 then
        card.ability.extra.Xmult = ( card.ability.extra.Xmult - card.ability.extra.Xmult_lose )
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Downgrade!"})
      end
    end
  end
}

SMODS.Joker { --Practice mode
  key = 'practice_mode',
  atlas = "adofai-jokers-1",
  pos = { x = 8 , y = 0},
  config = { extra = { chips = -20 , chips_gain = 5, prefix = ""} },
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.chips ,
        card.ability.extra.chips_gain,
        card.ability.extra.prefix
      } }
    end,
    calculate = function(self, card, context)
      if G.GAME.blind.boss and context.end_of_round and not context.repetition and not context.individual then
        card.ability.extra.chips = -20
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Reset!"})
        card.ability.extra.prefix = ""
      end
      if context.joker_main and card.ability.extra.chips >= 0 then
        return {
          chip_mod = card.ability.extra.chips,
          message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
        }
      end
      if context.discard then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
        if card.ability.extra.chips >= 0 then
          card.ability.extra.prefix = "+"
        end
      end
    end
}

SMODS.Joker { -- Spin 2 win
  key = 'spin2win',
  rarity = 3,
  cost = 6,
  atlas = "adofai-jokers-1",
  pos = { x = 3 , y = 0},
  config = { extra = { Xmult = 1.0 , Xmult_gain = 0.2} },
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.Xmult,
        card.ability.extra.Xmult_gain
        -- text = {"Whatever the fuck"}
    } }
  end,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.name == "The Wheel of Fortune" then
      card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
    end
    if context.joker_main and ( card.ability.extra.Xmult > 1.00) then
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
    end
  end
}

SMODS.Joker { -- NHH
  key = 'NHH',
  rarity = 2,
  cost = 6,
  atlas = "adofai-jokers-1",
  pos = { x = 7 , y = 0},
  config = {  extra = { 
    Xmult = 1.0,
    Xmult_min = 110,
    Xmult_max = 200,
  } }, -- xmult is times 100 because of the random function not liking decimals.
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.idea,
        card.ability.extra.sprite,
        card.ability.extra.Xmult,
        card.ability.extra.Xmult_min,
        card.ability.extra.Xmult_max,
    } }
  end,
  calculate = function (self, card, context)
    if context.joker_main then
      card.ability.extra.Xmult = (pseudorandom("Charla", card.ability.extra.Xmult_min, card.ability.extra.Xmult_max)/100)
      return {
        mult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
    end
  end
}
