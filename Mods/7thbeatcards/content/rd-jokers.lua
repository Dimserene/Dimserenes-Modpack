SMODS.Joker { -- Samurai
  key = 'samurai',
  rarity = 1,
  cost = 6,
  atlas = "rd-jokers-1",
  pos = { x = 6 , y = 0},
  config = {  extra = { mult = 7 } },
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.mult
    } }
  end,
  calculate = function (self, card, context)
    if context.scoring_hand and context.cardarea == G.play and context.other_card:get_id() == 7 then
      return {
        mult = card.ability.extra.mult,
        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
      }
    end
  end
}

SMODS.Joker { --Oneshot
  key = 'oneshot',
  config = { extra = { idea = "deathmodereal", sprite = "k_lemun" ,  Xmult = 1.0 , Xmult_gain = 0.05 } },
  loc_vars = function(self, info_queue, card)
    return { vars = {
      card.ability.extra.idea,
      card.ability.extra.sprite,
      card.ability.extra.Xmult,
      card.ability.extra.Xmult_gain
      } }
    end,
    rarity = 2,
    cost = 6,
    atlas = "rd-jokers-1",
    pos = { x = 1 , y = 0},

    calculate = function(self, card, context)
      if context.before and context.cardarea == G.jokers and #context.full_hand == 1 and not context.blueprint then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
      end
      if context.joker_main then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
        }
      end
    end
}

SMODS.Joker { -- Battleworn insomniac
  key = 'battleworn_insomniac',
  atlas = "rd-jokers-1",
  pos = { x = 5 , y = 0},
  config = { extra = { Xmult = 2.0, rank = 7 , count = 0 , active = 7 , status = false} },
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.Xmult , 
      card.ability.extra.rank , 
      ( card.ability.extra.active - card.ability.extra.count ) ,
      card.ability.extra.active,
      card.ability.extra.status
    } }
  end,
  rarity = 3,
  cost = 6,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and context.other_card:get_id() == 7 then
      if card.ability.extra.count == (card.ability.extra.active - 1) then
        card.ability.extra.count = 0
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Active!"})
        card.ability.extra.status = true
      elseif not context.blueprint then
        -- Increase the counter
        card.ability.extra.count = card.ability.extra.count + 1
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = (( card.ability.extra.active - card.ability.extra.count ).." more!")})
      end
    end
    if context.joker_main and card.ability.extra.status then
      card.ability.extra.status = false
      return {
        Xmult_mod = card.ability.extra.Xmult,
        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
      }
  end
end
}

SMODS.Joker { -- Skipshot
  key = 'skipshot',
  config = { extra = { 
    dollars = 1, 
    skipped = 0,
    x_dollars = 3
  } },
  loc_vars = function(self, info_queue, card)
    return { vars = { 
      card.ability.extra.dollars, 
      card.ability.extra.skipped,
      card.ability.extra.x_dollars
  } }
  end,
  rarity = 2,
  cost = 6,
  atlas = "rd-jokers-1",
  pos = { x = 3 , y = 0},
  calc_dollar_bonus = function(self, card)
    return card.ability.extra.dollars
  end,
  calculate = function(self, card, context)
    if context.skip_blind then
      card.ability.extra.skipped = card.ability.extra.skipped + 1
      card.ability.extra.dollars = (card.ability.extra.skipped * card.ability.extra.x_dollars) + 1
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
    end
  end
}

SMODS.Joker { -- Logun
  key = 'reduce',
  atlas = "rd-jokers-1",
  pos = { x = 4 , y = 0},
  rarity = 4,
  cost = 8,
  config = {  extra = { 
    blind_mult = 0.5,
  } }, -- xmult is times 100 because of the random function not liking decimals.
  loc_vars = function(self, info_queue, card)
    return { vars = {
        card.ability.extra.blind_mult
    } }
  end,
  calculate = function (self, card, context)
    if context.setting_blind then
      card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Active!"})
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_mult
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
      G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
      G.HUD_blind:recalculate() 
    end
  end
}