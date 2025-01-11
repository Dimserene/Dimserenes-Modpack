--- STEAMODDED HEADER
--- MOD_NAME: Celeste Card Collection
--- MOD_ID: CelesteCardCollection
--- PREFIX: ccc
--- MOD_AUTHOR: [AuroraAquir, toneblock, Gappie, bein, sunsetquasar, goose!]
--- MOD_DESCRIPTION: Featuring 2 new decks, 25 new jokers, and 2 new vouchers! Special thanks to Bred, Fytos, sunsetquasar and goose for concepts!
--- PRIORITY: 0
--- DISPLAY_NAME: CCC
--- BADGE_COLOUR: ffc0ff

----------------------------------------------
------------MOD CODE -------------------------

assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/_helper_functions.lua")))()

SMODS.Atlas({key = "j_ccc_jokers", path = "j_ccc_jokers.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/jokers.lua")))()

SMODS.Atlas({key = "b_ccc_decks", path = "b_ccc_decks.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/decks.lua")))()

SMODS.Atlas({key = "v_ccc_vouchers", path = "v_ccc_vouchers.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/vouchers.lua")))()

SMODS.Atlas({key = "bl_ccc_blinds", path = "bl_ccc_blinds.png", px = 34, py = 34, frames = 21, atlas_table = "ANIMATION_ATLAS"})
assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/blinds.lua")))()

-- SMODS.Atlas({key = "i_ccc_instapix", path = "i_ccc_instapix.png", px = 71, py = 95, atlas = "asset_atlas"})
-- assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/instapix.lua")))()

assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/editions.lua")))()

assert(load(NFS.read(SMODS.current_mod.path .. "lua_files/localization/en-us.lua")))()

SMODS.Atlas({
    key = "modicon",
    path = "ccc_icon.png",
    px = 34,
    py = 34
}):register()


----------------------------------------------
------------MOD CODE END----------------------
