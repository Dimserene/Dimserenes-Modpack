--- STEAMODDED HEADER
--- MOD_NAME: Nether's Jokers
--- MOD_ID: NethersJokers
--- MOD_AUTHOR: [Nether]
--- MOD_DESCRIPTION: Add new Jokers to the game
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.2.0

----------------------------------------------
------------MOD CODE -------------------------

_RELEASE_MODE = false

nether_util = require(SMODS.current_mod.path.."/nethers-util")

-- Config: Enable or disable additional jokers here
local CONFIG = {
    joker_masterplan = true,
    joker_blank = true,
}

for key, enabled in pairs(CONFIG) do
    if enabled then
        local path = key:gsub("_", "/")
        require(SMODS.current_mod.path.."/assets/"..path)
        sendDebugMessage("Loaded joker: "..key)
    end
end