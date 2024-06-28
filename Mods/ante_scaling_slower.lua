--- STEAMODDED HEADER
--- MOD_NAME: Ante scaling linear
--- MOD_ID: Infarctus_Ante_scaling_linear
--- MOD_AUTHOR: [infarctus]
--- MOD_DESCRIPTION: Slows the ante scaling to 2x each ante.
----------------------------------------------
------------MOD CODE -------------------------
local scaling_factor = 2
function get_blind_amount(ante)
    local k = 0.75
    if not G.GAME.modifiers.scaling or G.GAME.modifiers.scaling == 1 then 
      local amounts = {
        300,  800, 2000,  5000,  11000,  20000,   35000,  50000
      }
      if ante < 1 then return 100 end
      if ante <= 8 then return amounts[ante] end
      local amount = math.floor(amounts[8]*scaling_factor^(ante-8))
      amount = amount - amount%(10^math.floor(math.log10(amount)-1))
      return amount
    elseif G.GAME.modifiers.scaling == 2 then 
      local amounts = {
        300,  900, 2600,  8000,  20000,  36000,  60000,  100000
        --300,  900, 2400,  7000,  18000,  32000,  56000,  90000
      }
      if ante < 1 then return 100 end
      if ante <= 8 then return amounts[ante] end
      local amount = math.floor(amounts[8]*scaling_factor^(ante-8))
      amount = amount - amount%(10^math.floor(math.log10(amount)-1))
      return amount
    elseif G.GAME.modifiers.scaling == 3 then 
      local amounts = {
        300,  1000, 3200,  9000,  25000,  60000,  110000,  200000
        --300,  1000, 3000,  8000,  22000,  50000,  90000,  180000
      }
      if ante < 1 then return 100 end
      if ante <= 8 then return amounts[ante] end
      local amount = math.floor(amounts[8]*scaling_factor^(ante-8))
      amount = amount - amount%(10^math.floor(math.log10(amount)-1))
      return amount
    end
end
----------------------------------------------
------------MOD CODE END----------------------
