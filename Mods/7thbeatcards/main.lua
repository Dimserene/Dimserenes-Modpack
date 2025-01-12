local config = SMODS.current_mod.config
local debug_mode = false


--[[

Load everything

]]

local contents = {
  "rd-jokers",
  "adofai-jokers",
  "consumables",
  "misc"
}


for k, v in pairs(contents) do
  assert(SMODS.load_file('/content/'..v..'.lua'))()
end




local old_back_apply_to_run = Back.apply_to_run
function Back.apply_to_run(self)
  old_back_apply_to_run(self)
  if self.effect.config.sbc_speed_trial then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sbc_Speed_trial', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
  if self.effect.config.sbc_battleworn_insomniac then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sbc_battleworn_insomniac', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
  if self.effect.config.sbc_oneshot then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sbc_oneshot', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
  if self.effect.config.sbc_practice_mode then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sbc_practice_mode', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
  if self.effect.config.sbc_astro then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_sbc_astro', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
  if self.effect.config.blueprint then
    G.E_MANAGER:add_event(Event({
      func = function()
        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, 'j_blueprint', nil)
        card:add_to_deck()
        G.jokers:emplace(card)
        return true
      end
    }))
  end
end

if debug_mode then _RELEASE_MODE = false end -- DEBUG MODE

if debug_mode then
SMODS.Back{
	name = "7 Beat Games Deck",
	key = "sbg",
  atlas = "back",
	pos = {x = 0, y = 0},
	config = {
    ante_scaling = 0.7, 
  },
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
          for k, v in ipairs(G.playing_cards) do
            if v:get_id() == 7 then
              if v:is_suit("Spades") or v:is_suit("Hearts") then
                  v:set_ability(G.P_CENTERS["m_sbc_fire"])
              end
              if v:is_suit("Clubs") or v:is_suit("Diamonds") then
                v:set_ability(G.P_CENTERS["m_sbc_ice"])
              end
            end
				  end
				return true
			end
		}))
	end
}
end

--[[

  Config tab, prob

]]

--[[
 SMODS.current_mod.config_tab = function()
 	return {n = G.UIT.ROOT, config = {
 		-- config values here, see 'Building a UI' page
 	}, nodes = {
 		-- work your UI wizardry here, see 'Building a UI' page
 	}}
 end
]]

--[[

  Atlases

]]

SMODS.Atlas { -- RD jokers
  key = "rd-jokers-1",
  path = "rd-jokers-1.png",
  px = 71,
  py = 95
}

SMODS.Atlas { -- ADOFAI jokers
  key = "adofai-jokers-1",
  path = "adofai-jokers-1.png",
  px = 71,
  py = 95
}

SMODS.Atlas { -- Spectal cards
  key = "spectral",
  path = "spectral.png",
  px = 128,
  py = 188
}

SMODS.Atlas { -- Spectal cards
  key = "deck",
  path = "cards.png",
  px = 71,
  py = 95
}

SMODS.Atlas { -- Tarot
  key = "tarot",
  path = "tarot.png",
  px = 71,
  py = 95
}

SMODS.Atlas { -- Deck backs
  key = "back",
  path = "back.png",
  px = 275,
  py = 371
}




--[[

Fire and Ice

]]

SMODS.Enhancement({
  key = 'fire',
  atlas = "deck",
  pos = { x = 0 , y = 0},
  config = {
    mult = 0, --mult it gives
    extra = {
      mult_gain = 5, --mult it adds
      other_card = 1, -- Count of other cards
    }
  },
  loc_vars = function (self, info_queue, card)
    card.ability.mult = 0
    card.ability.extra.mult_gain = 5
    card.ability.extra.other_card = 0
    if G.jokers then
        for k, v in pairs(G.playing_cards) do
          if v.config.center == G.P_CENTERS.m_sbc_ice or v.config.center == G.P_CENTERS.m_sbc_wind then 
            card.ability.extra.other_card = card.ability.extra.other_card + 1
            card.ability.mult = card.ability.extra.mult_gain * card.ability.extra.other_card
          end
      end
    end
      return {
      vars = {
        card.ability.mult,
        card.ability.extra.mult_gain,
        card.ability.extra.other_card
      }
      }
  end
})

SMODS.Enhancement({
  key = 'ice',
  atlas = "deck",
  pos = { x = 1 , y = 0},
  config = {
    bonus = 0,
    extra = {
      bonus_gain = 10,
      other_card = 1,
  }
  },
  loc_vars = function (self, info_queue, card)
    card.ability.bonus = 0
    card.ability.extra.bonus_gain = 10
    card.ability.extra.other_card = 0
    if G.jokers then
      for k, v in pairs(G.playing_cards) do
        if v.config.center == G.P_CENTERS.m_sbc_fire or v.config.center == G.P_CENTERS.m_sbc_wind then 
          card.ability.extra.other_card = card.ability.extra.other_card + 1
          card.ability.bonus = card.ability.extra.bonus_gain * card.ability.extra.other_card
        end
      end
    end
    return {
      vars = {
        card.ability.bonus,
        card.ability.extra.bonus_gain,
        card.ability.extra.other_card
      }
    }
  end
})

--[[

Jonklers / Debug

]] 

if debug_mode then

  SMODS.Joker { -- Test Joker
    key = 'test_joker',
    config = { extra = { value_1 = 0} },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.value_1 } }
    end,
    rarity = 4,
    cost = 6,
    calculate = function(self, card, context)
      if context.joker_main then
        C =  C + 2
        print(C)
      end
    end
  }



  SMODS.Joker { -- CC joker 1
    key = 'Chrysanthemum',
    config = { extra = { value_1 = 0} },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.value_1 } }
    end,
    rarity = 4,
    cost = 6,
    atlas = "rd-jokers-1",
    pos = { x = 2 , y = 0},
    calculate = function(self, card, context)
      if context.setting_blind or context.before or context.pre_discard then
        card.ability.extra.value_1 = #G.deck.cards
      end
    end
  }
end

if debug_mode then
  SMODS.Joker { -- Midspin
    key = 'midspin',
    rarity = 2,
    cost = 6,
    atlas = "adofai-jokers-1",
    pos = { x = 4 , y = 0},
    config = { extra = { mult = 7 , mult_gain = 7 } },
    loc_vars = function(self, info_queue, card)
      return { vars = {
          card.ability.extra.mult,
          card.ability.extra.mult_gain,
      } }
    end,
    calculate = function(self, card, context)
      if ( context.repetition and context.other_card.seal == "Red" and context.cardarea == G.play) then
        card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
        card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Upgrade!"})
      end
      if context.joker_main then
        return {
          mult_mod = card.ability.extra.mult,
          message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
        }
      end
    end
  }
end


