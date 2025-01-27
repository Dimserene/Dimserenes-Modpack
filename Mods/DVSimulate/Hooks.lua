--- Divvy's Simulation for Balatro - Engine.lua
--
-- Hook into functions to either disable or modify them during simulation,
--     or to use them to track events

-- Runtime hooks to limit performance hits
function DV.SIM.hook_functions()
   -- LHS: Balatro's default functions
   -- RHS: this mod's modified versions
   pseudoseed = DV.SIM.new_pseudoseed
   pseudorandom = DV.SIM.new_pseudorandom
   pseudorandom_element = DV.SIM.new_pseudorandom_element
   ease_dollars = DV.SIM.new_ease_dollars
   check_for_unlock = DV.SIM.new_check_for_unlock
   play_sound = DV.SIM.new_play_sound
   update_hand_text = DV.SIM.new_update_hand_text
   EventManager.add_event = DV.SIM.new_add_event
   --attention_text = DV.SIM.new_attention_text
   --card_eval_status_text = DV.SIM.new_card_eval_status_text
   --update_hand_text = DV.SIM.new_update_hand_text
   if SMODS then
      if DV.SIM._calculate_effect == nil then
         DV.SIM._calculate_effect = SMODS.calculate_effect
      end
      SMODS.calculate_effect = DV.SIM.new_calculate_effect
   end
end

function DV.SIM.unhook_functions()
   -- LHS: Balatro's (presumably hooked) functions
   -- RHS: this mod's saved default Balatro functions
   pseudoseed = DV.SIM._pseudoseed
   pseudorandom = DV.SIM._pseudorandom
   pseudorandom_element = DV.SIM._pseudorandom_element
   ease_dollars = DV.SIM._ease_dollars
   check_for_unlock = DV.SIM._check_for_unlock
   play_sound = DV.SIM._play_sound
   update_hand_text = DV.SIM._update_hand_text
   EventManager.add_event = DV.SIM._add_event
   --attention_text = DV.SIM._attention_text
   --card_eval_status_text = DV.SIM._card_eval_status_text
   --update_hand_text = DV.SIM._update_hand_text
   if SMODS then
      SMODS.calculate_effect = DV.SIM._calculate_effect
   end
end

DV.SIM._add_event = EventManager.add_event
DV.SIM.new_add_event = function(self, event, queue, front)
   if not DV.SIM.running then
      return DV.SIM._add_event(self, event, queue, front)
   end
end

DV.SIM._ease_dollars = ease_dollars
DV.SIM.new_ease_dollars = function(mod, instant)
   if DV.SIM.running then
      instant = true
   end
   return DV.SIM._ease_dollars(mod, instant)
end

DV.SIM._update_hand_text = update_hand_text
DV.SIM.new_update_hand_text = function(config, vals)
   if not DV.SIM.running then
      return DV.SIM._update_hand_text(config, vals)
   end
end

DV.SIM._play_sound = play_sound
DV.SIM.new_play_sound = function(sound_code, per, vol)
   if not DV.SIM.running then
      return DV.SIM._play_sound(sound_code, per, vol)
   end
end

DV.SIM._check_for_unlock = check_for_unlock
DV.SIM.new_check_for_unlock = function(args)
   if not DV.SIM.running then
      return DV.SIM._check_for_unlock(args)
   end
end

DV.SIM._attention_text = attention_text
DV.SIM.new_attention_text = function(args)
   if not DV.SIM.running then
      return DV.SIM._attention_text(args)
   end
end

DV.SIM._update_hand_text = update_hand_text
DV.SIM.new_update_hand_text = function(config, vals)
   if not DV.SIM.running then
      return DV.SIM._update_hand_text(config, vals)
   end
end

DV.SIM._card_eval_status_text = card_eval_status_text
DV.SIM.new_card_eval_status_text = function(card, eval_type, amt, percent, dir, extra)
   if not DV.SIM.running then
      return DV.SIM._card_eval_status_text(args)
   end
   --print("STOP THE new_card_eval_status_text")
end

DV.SIM.new_calculate_effect = function(effect, scored_card, from_edition, pre_jokers)
   local calculated = false
   for k, amount in pairs(effect) do
      local lowercase = string.lower(k)
      if DV.SIM.calculation_keys[lowercase] then
         DV.SIM.calculation_keys[lowercase](amount)
         calculated = true
      elseif lowercase == 'swap' then
         local old_mult = mult
         mult = mod_mult(hand_chips)
         hand_chips = mod_chips(old_mult)
         calculated = true
      elseif lowercase == 'message' then
         calculated = true
      elseif lowercase == 'level_up' then
         level_up_hand(scored_card, G.GAME.last_hand_played, effect.instant, type(amount) == 'number' and amount or 1)
         calculated = true
      elseif lowercase == 'func' and type(amount) == "function" then
         amount()
         calculated = true
      elseif lowercase == 'extra' then
         return DV.SIM.new_calculate_effect(effect)
      elseif lowercase == 'saved' then
         SMODS.saved = amount
         calculated = true
      --else
      --   print("CAN'T FIND KEY - " .. k .. " / " .. type(amount))
      end
   end
   if effect.effect then calculated = true end
   if effect.remove then calculated = true end
   return calculated
end

function DV.SIM.new_mod_chips(amount)
   hand_chips = mod_chips(hand_chips + amount)
end

function DV.SIM.new_mod_mult(amount)
   mult = mod_mult(mult + amount)
end

function DV.SIM.new_xmod_mult(amount)
   mult = mod_mult(mult * amount)
end

function DV.SIM.new_dollars(amount)
   G.GAME.dollars = G.GAME.dollars + amount
end

DV.SIM.calculation_keys = {
   chips = DV.SIM.new_mod_chips,
   h_chips = DV.SIM.new_mod_chips,
   chip_mod = DV.SIM.new_mod_chips,
   mult = DV.SIM.new_mod_mult,
   h_mult = DV.SIM.new_mod_mult,
   mult_mod = DV.SIM.new_mod_mult,
   x_mult = DV.SIM.new_xmod_mult,
   xmult = DV.SIM.new_xmod_mult,
   x_mult_mod = DV.SIM.new_xmod_mult,
   xmult_mod = DV.SIM.new_xmod_mult,
   p_dollars = DV.SIM.new_dollars,
   dollars = DV.SIM.new_dollars,
   h_dollars = DV.SIM.new_dollars,
}
