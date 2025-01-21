--- STEAMODDED HEADER
--- MOD_NAME: Dimserene's Modpack Utility
--- MOD_ID: Modpack_Util
--- MOD_AUTHOR: [Dimserene]
--- MOD_DESCRIPTION: Dimserene's Modpack Utility
--- PRIORITY: 1e10000
----------------------------------------------
------------MOD CODE -------------------------

local lovely = require("lovely")
local nativefs = require("nativefs")
local splash_screenRef = Game.splash_screen
local modCount = 0

for _, mod in pairs(SMODS.Mods) do
    if mod.can_load and (not mod.meta_mod or mod.lovely_only) then
        modCount = modCount + 1
    end
end


if SMODS.Atlas then
  SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 32,
    py = 32
  })
end


local ModpackName = nativefs.read(lovely.mod_dir .. "/ModpackUtil/ModpackName.txt")
local ModpackVersion = nativefs.read(lovely.mod_dir .. "/ModpackUtil/CurrentVersion.txt")
local ModpackUpdate = nativefs.read(lovely.mod_dir .. "/ModpackUtil/VersionTime.txt")

local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
	gameMainMenuRef(self, change_context)
	UIBox({
		definition = {n = G.UIT.ROOT, config = {align = "cm", colour = G.C.CLEAR}, nodes = {
						{n= G.UIT.R, config = {align = "cr"}, nodes = {
							{n = G.UIT.T, config = {scale = 0.3, text = "Dimserene's Modpack - " .. ModpackName, align = "cr", colour = G.C.UI.TEXT_LIGHT}}}},
						{n= G.UIT.R, config = {align = "cr", padding = 0.05}, nodes = {
							{n = G.UIT.T, config = {scale = 0.3, text = "Current Version: " .. ModpackVersion, align = "cr", colour = G.C.UI.TEXT_LIGHT}}}},
						{n= G.UIT.R, config = {align = "cr", padding = 0.05}, nodes = {
							{n = G.UIT.T, config = {scale = 0.3, text = "(UTC) " .. ModpackUpdate, align = "cr", colour = G.C.UI.TEXT_LIGHT}}}},
						{n= G.UIT.R, config = {align = "cr", padding = 0.05}, nodes = {
							{n = G.UIT.T, config = {scale = 0.3, text = modCount .. " mods installed", align = "cr", colour = G.C.UI.TEXT_LIGHT}}}},

					}},
		config = {
			align = "tri",
			bond = "Weak",
			offset = {
				x = 0,
				y = 0.6
			},
			major = G.ROOM_ATTACH
		}
	})
end

----------------------------------------------
------------MOD CODE END----------------------
