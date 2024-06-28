-- fix for LOVE acting up in some cases (thanks @MathIsFun)
local shader = NFS.read(SMODS.current_mod.path.."/assets/shaders/".."hologramv2.fs")
love.filesystem.write("temp-hologramv2.fs", shader)
G.SHADERS['hologramv2'] = love.graphics.newShader("temp-hologramv2.fs")
love.filesystem.remove("temp-hologramv2.fs")
sendDebugMessage("Shaders injected!")

NETHER_UTIL = {}

function NETHER_UTIL.is_in_your_collection(card)
    if not G.your_collection then return false end
    for i = 1, 3 do
        if (G.your_collection[i] and card.area == G.your_collection[i]) then return true end
    end
    return false
end

return NETHER_UTIL