Speedrun = {}
function initSpeedrunTimer()
  local lovely = require("lovely")
  local nativefs = require("nativefs")
  assert(load(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Ankh_ops.lua")))()
  if nativefs.getInfo(lovely.mod_dir.."/MathIsFun0-Ankh/settings.lua") then
    local settings_file = STR_UNPACK(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/settings.lua"))
    if settings_file ~= nil then Speedrun.SETTINGS = settings_file end
  end
  assert(load(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/logging.lua")))()
  assert(load(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/replay.lua")))()
end