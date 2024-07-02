--- STEAMODDED HEADER
--- MOD_NAME: gamblecore
--- MOD_ID: arachnei_gamblecore
--- MOD_AUTHOR: [arachnei]
--- MOD_DESCRIPTION: Adds "aw dangit" when Wheel of Fortune fails
--- LOADER_VERSION_GEQ: 1.0.0
local ui_attention_text = attention_text
function attention_text(args)
    args = args or {}
    if args.text == localize('k_nope_ex') and args.major.config.center_key == "c_wheel_of_fortune" then
        SOURCES.gamblecore.sound:setVolume((G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/100.0))
        SOURCES.gamblecore.sound:play()
    end
    ui_attention_text(args)
end
local game_poll_edition = poll_edition
function poll_edition(_key, _mod, _no_neg, _guaranteed)
    if _key == 'wheel_of_fortune' and _no_neg and _guaranteed then
        SOURCES.gamblecore2.sound:setVolume((G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/100.0))
        SOURCES.gamblecore2.sound:play()
    end
    return game_poll_edition(_key, _mod, _no_neg, _guaranteed)
end
local function on_enable()
    for _, filename in ipairs(love.filesystem.getDirectoryItems("/mods/gamblecore/assets/sounds/")) do
        local ext = string.sub(filename, -4)
        if ext == '.ogg' then
            local sound_code = string.sub(filename, 1, -5)
            local s = {
                sound = love.audio.newSource("/mods/gamblecore/assets/sounds/" .. filename, 'static'),
                sound_code = sound_code
            }
            SOURCES[sound_code] = s
            love.audio.play(s.sound)
            s.sound:stop()
            s.sound:setVolume((G.SETTINGS.SOUND.volume/100.0) * (G.SETTINGS.SOUND.game_sounds_volume/100.0))
        end
    end
end
local balamod_exists, a = pcall(function()
    if logger then 
        return true 
    else
        return false
    end
end)
local smods_exists, b = pcall(function()
    if SMODS then
        return true
    else
        return false
    end
end)
print("balamod: ".. tostring(balamod_exists))
print("smods: ".. tostring(smods_exists))
if balamod_exists and a then
    logger:info("balamod loading gamblecore sound")
    return {
        on_enable = on_enable
    }
elseif smods_exists and b then
    print("smods loading gamblecore sound")
    on_enable()
end