DiceyLatro = {
  mod = SMODS.current_mod,
  path = SMODS.current_mod.path:gsub("/$", ""),
  load_chace = {},
  G = {},
  round_vars = {},
  game_objects = {},
  config = SMODS.current_mod.config,
  config_ui = {},
}

SMODS.Atlas {
  key = "modicon",
  path = "modicon.png",
  px = 100,
  py = 100,
}

function DiceyLatro.load(path)
  local module = DiceyLatro.load_chace[path]
  if not module then
    module = assert(SMODS.load_file("src/" .. path .. ".lua"))()
    DiceyLatro.load_chace[path] = module
  end
  return module
end


DiceyLatro.load("joker")("jokers", {
  "big_stick",
  "dust_cloud",
  "flying_skull",
  "hammer",
  "lament",
  "precious_egg",
  "scrap_metal",
  "screwdriver",
  "shovel",
  "snapdragon",
  "spanner",
  "toxic_ooze",
  "venus_fly_trap",
  "whip",
  "sword",
  "dagger",
  "juggling_ball"
  
})

function SMODS.current_mod.reset_game_globals()
  for key, value in pairs(DiceyLatro.round_vars) do
    G.GAME.current_round["dd_" .. key] = value(G.GAME.current_round["dd_" .. key])
  end
end
