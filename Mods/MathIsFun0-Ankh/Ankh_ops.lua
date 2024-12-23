local lovely = require("lovely")
local nativefs = require("nativefs")
G.F_NO_ACHIEVEMENTS = true
Speedrun.INITIALIZED = true
Speedrun.TIMERS = {
  SPEEDRUN = 0,
  CURRENT_RUN = 0,
  FINISHED_RUN = 999,
  ENDSCREEN_COLORS = 0,
  SPEEDRUN_DISP = "0:00.000",
  CURRENT_RUN_DISP = "0:00.000",
  UNLOCK_DISP = "0 / 0",
  SPEEDRUN_ACTIVE = false
}
G.PROFILES["Official Mode*"] = {}
G.PROFILES["Official Mode*"].name = "Official Mode"
Speedrun.VER = "Ankh v2.0.0-beta2"
Speedrun.C_SATURATION = 0.42
Speedrun.C_VALUE = 0.89
Speedrun.SETTINGS = {
  timerDuringRun = "Right",
  timerDuringRunID = 3,
  timerEndScreen = true,
  selectedCategory = "Single Run",
  selectedCategoryID = 1,
  replaySpeedID = 2,
  timerColor = "White",
  selectedColorID = 1,
  includeMenuing = true
}
Speedrun.RUN_INFO = {
  trailingConditionValue = 0,
  trailingPaused = true,
  
  unlocksFound = 0,
  unlocksTotal = 0,
  condition_value = 0,
  deckWins = {},
  challengeWins = {}
}
Speedrun.LIVESPLIT = io.open("//./pipe/LiveSplit", 'a')
local profile_temp = G.SETTINGS.profile
G.SETTINGS.profile = "//"
function copy(obj, seen)
  if type(obj) ~= 'table' then return obj end
  if seen and seen[obj] then return seen[obj] end
  local s = seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do res[copy(k, s)] = copy(v, s) end
  return res
end
local iip = Game.init_item_prototypes
function Game:init_item_prototypes()
  local ret = iip(self)
  Speedrun.P_CENTERS = copy(self.P_CENTERS);
  Speedrun.P_TAGS = copy(self.P_TAGS);
  Speedrun.P_BLINDS = copy(self.P_BLINDS);
  return ret;
end
for _, v in pairs(G.P_CENTERS) do
  if not v.omit then 
    if v.set and v.set == 'Back' then
      Speedrun.RUN_INFO.deckWins[v.name] = false
    end
  end
end
G.SETTINGS.profile = profile_temp
for _, v in pairs(G.CHALLENGES) do
  Speedrun.RUN_INFO.challengeWins[v.id] = false
end
Speedrun.TIMER_POS_LIST = {"Disabled", "Top Left", "Right"}
Speedrun.CATEGORY_LIST = {"Single Run", "3 Decks", "7 Decks", "All Decks", "All Challenges", "All Unlocks", "Collect All", "All Gold Stickers"};
Speedrun.REPLAY_SPEED_LIST = {0, 0.25, 0.5, 1, 2, 4}
Speedrun.COLORS_LIST = {"White", "Green", "Red", "Blue", "Orange", "Gold", "Purple", "Animated"}
Speedrun.COLORS = {
  ["White"] = G.C.WHITE,
  ["Green"] = G.C.GREEN,
  ["Red"] = G.C.RED,
  ["Blue"] = G.C.BLUE,
  ["Orange"] = G.C.ORANGE,
  ["Gold"] = G.C.GOLD,
  ["Purple"] = G.C.PURPLE,
  ["Animated"] = G.C.EDITION,
}
Speedrun.CATEGORIES = {
  ["Single Run"] = {
    unlocked = true,
    condition = "ante",
    condition_value = 9,
    condition_start_value = 1,
    hide_condition = true
  },
  ["3 Decks"] = {
    unlocked = true,
    condition = "deck_wins",
    condition_value = 3
  },
  ["7 Decks"] = {
    unlocked = true,
    condition = "deck_wins",
    condition_value = 7
  },
  ["All Decks"] = {
    unlocked = true,
    condition = "deck_wins",
    condition_value = 0
  },
  ["All Challenges"] = {
    unlocked = true,
    condition = "challenge_wins",
    condition_value = 0
  },
  ["All Unlocks"] = {
    unlocked = false,
    condition = "unlocks",
    condition_value = 0
  },
  ["Collect All"] = {
    unlocked = false,
    condition = "discoveries",
    condition_value = 0,
    condition_start_value = 2
  },
  ["All Gold Stickers"] = {
    unlocked = true,
    condition = "joker_gold_stickers",
    condition_value = 0
  }
}
for _ in pairs(G.P_CENTER_POOLS.Back) do Speedrun.CATEGORIES["All Decks"].condition_value = Speedrun.CATEGORIES["All Decks"].condition_value + 1 end
for _ in pairs(G.CHALLENGES) do Speedrun.CATEGORIES["All Challenges"].condition_value = Speedrun.CATEGORIES["All Challenges"].condition_value + 1 end
for _, v in pairs(G.P_CENTERS) do
  if not v.omit then 
    if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Booster') or (v.set == 'Back')) then
      if v.unlock_condition and v.unlock_condition.type ~= '' and v.name ~= 'Dusk' and v.name ~= 'Ride the Bus' then 
        Speedrun.CATEGORIES["All Unlocks"].condition_value = Speedrun.CATEGORIES["All Unlocks"].condition_value + 1
      end
    end
  end
end
for _, v in pairs(G.P_CENTERS) do
  if not v.omit then 
    if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Back') or (v.set == 'Booster')) then
      if not (v.set == 'Joker' and v.rarity == 4) then 
        Speedrun.CATEGORIES["Collect All"].condition_value = Speedrun.CATEGORIES["Collect All"].condition_value + 1
      end
    end
  end
end
for _, v in pairs(G.P_BLINDS) do
  Speedrun.CATEGORIES["Collect All"].condition_value = Speedrun.CATEGORIES["Collect All"].condition_value + 1
end
for _, v in pairs(G.P_TAGS) do
  Speedrun.CATEGORIES["Collect All"].condition_value = Speedrun.CATEGORIES["Collect All"].condition_value + 1
end
for _, v in pairs(G.P_CENTER_POOLS.Joker) do
  Speedrun.CATEGORIES["All Gold Stickers"].condition_value = Speedrun.CATEGORIES["All Gold Stickers"].condition_value + 1
end
Speedrun.G_FUNCS_options_ref = G.FUNCS.options
G.FUNCS.options = function(e)
  Speedrun.G_FUNCS_options_ref(e)
  nativefs.write(lovely.mod_dir.."/MathIsFun0-Ankh/settings.lua", STR_PACK(Speedrun.SETTINGS))
  if (G.STAGE ~= G.STAGES.RUN) then Speedrun.initRunInfo() end
end
Ankh_tab = {}
  if G.SETTINGS.profile == "Official Mode*" then
    if (G.STAGE == G.STAGES.RUN) then
      Ankh_tab = {
        label = "Ankh",
        tab_definition_function = function()return {
          n = G.UIT.ROOT,
          config = {
              emboss = 0.05,
              minh = 6,
              r = 0.1,
              minw = 10,
              align = "cm",
              padding = 0.2,
              colour = G.C.BLACK
          },
          nodes = {
              create_option_cycle({
                label = "Timer Position",
                scale = 0.8,
                w = 4,
                options = Speedrun.TIMER_POS_LIST,
                opt_callback = 'change_timer_pos',
                current_option = Speedrun.SETTINGS.timerDuringRunID,
              }),
              create_toggle({label = "Show Timer in End Screen", ref_table = Speedrun.SETTINGS, ref_value = 'timerEndScreen'}),
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = "Time between runs is included in Official Mode.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
              }},
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = "Category cannot be changed during a run.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
              }},
              UIBox_button{ label = {"Connect to LiveSplit Server"}, button = "startLiveSplitServer", minw = 5, minh = 0.7, scale = 1},
          }
      }end
    }
  else
    Ankh_tab = {
      label = "Ankh",
      tab_definition_function = function()return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = {
            create_option_cycle({
              label = "Timer Position",
              scale = 0.8,
              w = 4,
              options = Speedrun.TIMER_POS_LIST,
              opt_callback = 'change_timer_pos',
              current_option = Speedrun.SETTINGS.timerDuringRunID,
            }),
            create_toggle({label = "Show Timer in End Screen", ref_table = Speedrun.SETTINGS, ref_value = 'timerEndScreen'}),
            {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = "Time between runs is included in Official Mode.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
            }},
            create_option_cycle({
              label = "Category",
              scale = 0.8,
              w = 4,
              options = Speedrun.CATEGORY_LIST,
              opt_callback = 'change_category',
              current_option = Speedrun.SETTINGS.selectedCategoryID,
            }),
            UIBox_button{ label = {"Connect to LiveSplit Server"}, button = "startLiveSplitServer", minw = 5, minh = 0.7, scale = 1},
        }
    }end
  }
    end
  else
    if (G.STAGE == G.STAGES.RUN) then
      Ankh_tab = {
        label = "Ankh",
        tab_definition_function = function()return {
          n = G.UIT.ROOT,
          config = {
              emboss = 0.05,
              minh = 6,
              r = 0.1,
              minw = 10,
              align = "cm",
              padding = 0.2,
              colour = G.C.BLACK
          },
          nodes = {
              create_option_cycle({
                label = "Timer Position",
                scale = 0.8,
                w = 4,
                options = Speedrun.TIMER_POS_LIST,
                opt_callback = 'change_timer_pos',
                current_option = Speedrun.SETTINGS.timerDuringRunID,
              }),
              create_toggle({label = "Show Timer in End Screen", ref_table = Speedrun.SETTINGS, ref_value = 'timerEndScreen'}),
              create_toggle({label = "Include Time Between Runs", ref_table = Speedrun.SETTINGS, ref_value = 'includeMenuing'}),
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = "Category cannot be changed during a run.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
              }},
              UIBox_button{ label = {"Connect to LiveSplit Server"}, button = "startLiveSplitServer", minw = 5, minh = 0.7, scale = 1}
          }
      }end
    }
  else
    Ankh_tab = {
      label = "Ankh",
      tab_definition_function = function()return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = {
            create_option_cycle({
              label = "Timer Position",
              scale = 0.8,
              w = 4,
              options = Speedrun.TIMER_POS_LIST,
              opt_callback = 'change_timer_pos',
              current_option = Speedrun.SETTINGS.timerDuringRunID,
            }),
            create_toggle({label = "Show Timer in End Screen", ref_table = Speedrun.SETTINGS, ref_value = 'timerEndScreen'}),
            create_toggle({label = "Include Time Between Runs", ref_table = Speedrun.SETTINGS, ref_value = 'includeMenuing'}),
            create_option_cycle({
              label = "Category",
              scale = 0.8,
              w = 4,
              options = Speedrun.CATEGORY_LIST,
              opt_callback = 'change_category',
              current_option = Speedrun.SETTINGS.selectedCategoryID,
            }),
            UIBox_button{ label = {"Connect to LiveSplit Server"}, button = "startLiveSplitServer", minw = 5, minh = 0.7, scale = 1},
        }
    }end
  }
  end
  end
if not SpectralPack then
  SpectralPack = {}
  local ct = create_tabs
  function create_tabs(args)
      if args and args.tab_h == 7.05 then
          args.tabs[#args.tabs+1] = {
              label = "Spectral Pack",
              tab_definition_function = function() return {
                  n = G.UIT.ROOT,
                  config = {
                      emboss = 0.05,
                      minh = 6,
                      r = 0.1,
                      minw = 10,
                      align = "cm",
                      padding = 0.2,
                      colour = G.C.BLACK
                  },
                  nodes = SpectralPack
              } end
          }
      end
      return ct(args)
  end
end
SpectralPack[#SpectralPack+1] = UIBox_button{ label = {"Ankh"}, button = "ankhMenu", colour = G.C.GREEN, minw = 5, minh = 0.7, scale = 0.6}
G.FUNCS.ankhMenu = function(e)
  local tabs = create_tabs({
      snap_to_nav = true,
      tabs = {
          {
              label = "Speedrun",
              tab_definition_function = function()
                local tab = {
                  n = G.UIT.ROOT,
                  config = {
                      emboss = 0.05,
                      minh = 6,
                      r = 0.1,
                      minw = 10,
                      align = "cm",
                      padding = 0.2,
                      colour = G.C.BLACK
                  },
                  nodes = {
                      create_option_cycle({
                        label = "Timer Position",
                        scale = 0.8,
                        w = 4,
                        options = Speedrun.TIMER_POS_LIST,
                        opt_callback = 'change_timer_pos',
                        current_option = Speedrun.SETTINGS.timerDuringRunID,
                      }),
                      create_toggle({label = "Show Timer in End Screen", ref_table = Speedrun.SETTINGS, ref_value = 'timerEndScreen'}),
                      create_toggle({label = "Include Time Between Runs", ref_table = Speedrun.SETTINGS, ref_value = 'includeMenuing'}),
                      create_option_cycle({
                        label = "Category",
                        scale = 0.8,
                        w = 4,
                        options = Speedrun.CATEGORY_LIST,
                        opt_callback = 'change_category',
                        current_option = Speedrun.SETTINGS.selectedCategoryID,
                      }),
                      create_option_cycle({
                        label = "Timer Color",
                        scale = 0.8,
                        w = 4,
                        options = Speedrun.COLORS_LIST,
                        opt_callback = 'change_timer_color',
                        current_option = Speedrun.SETTINGS.selectedColorID,
                      }),
                      UIBox_button{ label = {"Connect to LiveSplit Server"}, button = "startLiveSplitServer", minw = 5, minh = 0.7, scale = 1},
                  }
                }
              if G.STAGE == G.STAGES.RUN then
                tab.nodes[4] = {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = "Category cannot be changed during a run.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
                }}
              end
              if G.SETTINGS.profile == "Official Mode*" then
                tab.nodes[3] = {n=G.UIT.R, config={align = "cm"}, nodes={
                  {n=G.UIT.O, config={object = DynaText({string = "Time between runs is included in Official Mode.", colours = {G.C.WHITE}, shadow = true, scale = 0.4})}},
                }}
              end
              return tab
            end
          },
          {
              label = "Replays",
              chosen = true,
              tab_definition_function = function()
                local tab = {
                  n = G.UIT.ROOT,
                  config = {
                      emboss = 0.05,
                      minh = 6,
                      r = 0.1,
                      minw = 10,
                      align = "cm",
                      padding = 0.2,
                      colour = G.C.BLACK
                  },
                  nodes = {
                    create_option_cycle({
                      label = "Input Delay (seconds)",
                      scale = 0.8,
                      w = 4,
                      options = Speedrun.REPLAY_SPEED_LIST,
                      opt_callback = 'change_replay_speed',
                      current_option = Speedrun.SETTINGS.replaySpeedID,
                    }),  
                    UIBox_button{ label = {"View a Replay"}, button = "viewReplay", minw = 5, minh = 0.7, scale = 0.6},
                  }
                }
              return tab
            end
          },
          {
              label = "Security",
              chosen = false,
              tab_definition_function = function()
                local tab = {
                  n = G.UIT.ROOT,
                  config = {
                      emboss = 0.05,
                      minh = 6,
                      r = 0.1,
                      minw = 10,
                      align = "cm",
                      padding = 0.2,
                      colour = G.C.BLACK
                  },
                  nodes = {DejaVu.securityUI()}
                }
              return tab
            end
          },
      }})
  G.FUNCS.overlay_menu{
          definition = create_UIBox_generic_options({
              back_func = "settings",
              contents = {tabs}
          }),
      config = {offset = {x=0,y=10}}
  }
end
G.FUNCS.startLiveSplitServer = function()
  Speedrun.LIVESPLIT = io.open("//./pipe/LiveSplit", 'a')
  local _infotip_object = G.OVERLAY_MENU:get_UIE_by_ID('overlay_menu_infotip')
  _infotip_object.config.object:remove() 
  _infotip_object.config.object = UIBox{
    definition = overlay_infotip({Speedrun.LIVESPLIT and "Connection successful!" or "Connection failed!"}),
    config = {offset = {x=0,y=0}, align = 'bm', parent = _infotip_object}
  }
  _infotip_object.config.object.UIRoot:juice_up()
  _infotip_object.config.set = true
end
G.FUNCS.change_category = function(x)
  Speedrun.SETTINGS.selectedCategoryID = x.to_key
  Speedrun.SETTINGS.selectedCategory = x.to_val
end
G.FUNCS.change_timer_pos = function(x)
  Speedrun.SETTINGS.timerDuringRunID = x.to_key
  Speedrun.SETTINGS.timerDuringRun = x.to_val
end
G.FUNCS.change_replay_speed = function(x)
  Speedrun.SETTINGS.replaySpeedID = x.to_key
  DejaVu.DELAY_TIME = x.to_val
end
G.FUNCS.change_timer_color = function(x)
  Speedrun.SETTINGS.selectedColorID = x.to_key
  Speedrun.SETTINGS.timerColor = x.to_val
end
function Speedrun.formatTime(seconds)
  if seconds < 3600 then
    local minutes = math.floor(seconds / 60)
    local remainingSeconds = math.floor(seconds - minutes * 60)
    local milliseconds = math.floor((seconds * 1000) % 1000)
    
    return string.format("%d:%02d.%03d", minutes, remainingSeconds, milliseconds)
  else
    local hours = math.floor(seconds / 3600)
    local minutes = math.floor((seconds-hours*3600) / 60)
    local remainingSeconds = math.floor(seconds - hours*3600 - minutes * 60)
    local milliseconds = math.floor((seconds * 1000) % 1000)
    
    return string.format("%d:%02d:%02d.%03d", hours, minutes, remainingSeconds, milliseconds)
  end
end
function Speedrun.initRunInfo()
  if Speedrun.LIVESPLIT then
    Speedrun.LIVESPLIT:write("reset\r\n")
    Speedrun.LIVESPLIT:flush()
  end
  if G.SETTINGS.profile == "Official Mode*" then
    if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].unlocked then
      G.PROFILES[G.SETTINGS.profile].all_unlocked = true
      for k, v in pairs(G.P_CENTERS) do
        if not v.demo and not v.wip then 
          v.alerted = true
          v.discovered = true
          v.unlocked = true
        end
      end
      for k, v in pairs(G.P_BLINDS) do
        if not v.demo and not v.wip then 
          v.alerted = true
          v.discovered = true
          v.unlocked = true
        end
      end
      for k, v in pairs(G.P_TAGS) do
        if not v.demo and not v.wip then 
          v.alerted = true
          v.discovered = true
          v.unlocked = true
        end
      end
      if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "joker_gold_stickers" then
        for _, jkr in pairs(G.PROFILES[G.SETTINGS.profile].joker_usage) do 
          jkr.wins = {}
        end
      end
      set_discover_tallies()
    else
      for _, deck in pairs(G.PROFILES[G.SETTINGS.profile].deck_usage) do 
        deck.wins = {}
      end
      for _, jkr in pairs(G.PROFILES[G.SETTINGS.profile].joker_usage) do 
        jkr.wins = {}
      end
      for k, v in pairs(G.P_CENTERS) do
        if not v.demo and not v.wip then 
          v.alerted = Speedrun.P_CENTERS[k].alerted
          v.discovered = Speedrun.P_CENTERS[k].discovered
          v.unlocked = Speedrun.P_CENTERS[k].unlocked
        end
      end
      for k, v in pairs(G.P_BLINDS) do
        if not v.demo and not v.wip then 
          v.alerted = Speedrun.P_BLINDS[k].alerted
          v.discovered = Speedrun.P_BLINDS[k].discovered
          v.unlocked = Speedrun.P_BLINDS[k].unlocked
        end
      end
      for k, v in pairs(G.P_TAGS) do
        if not v.demo and not v.wip then 
          v.alerted = Speedrun.P_TAGS[k].alerted
          v.discovered = Speedrun.P_TAGS[k].discovered
          v.unlocked = Speedrun.P_TAGS[k].unlocked
        end
      end
      set_discover_tallies()
    end
  end
  for _, v in pairs(G.P_CENTERS) do
    if not v.omit then 
      if v.set and v.set == 'Back' then
        Speedrun.RUN_INFO.deckWins[v.name] = false
      end
    end
  end
  for _, v in pairs(G.CHALLENGES) do
    Speedrun.RUN_INFO.challengeWins[v.id] = false
  end
  Speedrun.RUN_INFO.unlocksFound = 0
  Speedrun.RUN_INFO.trailingConditionValue = Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_start_value or 0
  Speedrun.RUN_INFO.unlocksTotal = 0
  for _, v in pairs(G.P_CENTERS) do
    if not v.omit then 
      if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Booster')) then
        Speedrun.RUN_INFO.unlocksTotal=Speedrun.RUN_INFO.unlocksTotal+1
        if v.unlocked == true or v.unlocked == nil or v.unlock_condition and v.unlock_condition.type == '' then Speedrun.RUN_INFO.unlocksFound=Speedrun.RUN_INFO.unlocksFound+1 end
      end
    end
  end
  for _, v in pairs(G.P_CENTERS) do
    if not v.omit then 
      if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Booster')) then
        if not v.unlock_condition or v.unlock_condition.type == '' or v.name == 'Dusk' or v.name == 'Ride the Bus' then 
          Speedrun.RUN_INFO.unlocksFound=Speedrun.RUN_INFO.unlocksFound-1
          Speedrun.RUN_INFO.unlocksTotal=Speedrun.RUN_INFO.unlocksTotal-1
        end
      end
    end
  end
  Speedrun.RUN_INFO.condition_value = 0
end
Speedrun.create_UIBox_HUD_ref = create_UIBox_HUD
function create_UIBox_HUD()
  local hud = Speedrun.create_UIBox_HUD_ref()
  if Speedrun.SETTINGS.timerDuringRun == "Top Left" then
    if not Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].hide_condition then
      hud.nodes[1].nodes[1].nodes[1].nodes[#hud.nodes[1].nodes[1].nodes[1].nodes+1] = 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'UNLOCK_DISP'}}, colours = {Speedrun.COLORS[Speedrun.SETTINGS.timerColor]}, shadow = true, bump = true, scale = 0.4, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
        }} end
  hud.nodes[1].nodes[1].nodes[1].nodes[#hud.nodes[1].nodes[1].nodes[1].nodes+1] = 
  {n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'SPEEDRUN_DISP'}}, colours = {Speedrun.COLORS[Speedrun.SETTINGS.timerColor]}, shadow = true, bump = true, scale = 0.7, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
  }} end
  return hud
end
Speedrun.Game_update_ref = Game.update
function Game:update(dt)
  Speedrun.Game_update_ref(self, dt)
  Speedrun.update(dt)
end
function Speedrun.update(dt)
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "joker_gold_stickers" then
    Speedrun.RUN_INFO.condition_value = 0
    for _, v in pairs(G.P_CENTERS) do
      if v.set == 'Joker' then 
        if get_joker_win_sticker(v, true) == 8 then
          Speedrun.RUN_INFO.condition_value=Speedrun.RUN_INFO.condition_value+1
        end
      end
    end
  end
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "ante" then
    Speedrun.RUN_INFO.condition_value = math.min(8,G.GAME.round_resets.ante)
  end
  if Speedrun.RUN_INFO.trailingConditionValue < Speedrun.RUN_INFO.condition_value then
    while Speedrun.RUN_INFO.trailingConditionValue < Speedrun.RUN_INFO.condition_value do
        Speedrun.RUN_INFO.trailingConditionValue = Speedrun.RUN_INFO.trailingConditionValue + 1
        if Speedrun.LIVESPLIT then
          Speedrun.LIVESPLIT:write("split\r\n");
          Speedrun.LIVESPLIT:flush()
        end
    end
  end
  if Speedrun.TIMERS.SPEEDRUN_ACTIVE and (G.STAGE == G.STAGES.RUN or Speedrun.SETTINGS.includeMenuing or G.SETTINGS.profile == "Official Mode*") then
    if Speedrun.trailingPaused then
      Speedrun.trailingPaused = false
      if Speedrun.LIVESPLIT then
        Speedrun.LIVESPLIT:write("resume\r\n")
        Speedrun.LIVESPLIT:flush()
      end
    end
    if Speedrun.RUN_INFO.condition_value < Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_value then 
      if Speedrun.LIVESPLIT then
        Speedrun.LIVESPLIT:write("setgametime "..string.format("%.3f",Speedrun.TIMERS.SPEEDRUN).."\r\n")
        Speedrun.LIVESPLIT:flush()
      end
      Speedrun.TIMERS.SPEEDRUN = Speedrun.TIMERS.SPEEDRUN + dt
    end
    if Speedrun.TIMERS.FINISHED_RUN == 999 then
      Speedrun.TIMERS.CURRENT_RUN = Speedrun.TIMERS.CURRENT_RUN + dt
    end
    Speedrun.TIMERS.SPEEDRUN_DISP = Speedrun.formatTime(Speedrun.TIMERS.SPEEDRUN) 
    Speedrun.TIMERS.CURRENT_RUN_DISP = Speedrun.formatTime(Speedrun.TIMERS.CURRENT_RUN)
  else
    if not Speedrun.trailingPaused and Speedrun.RUN_INFO.condition_value > (Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_start_value or 0) then
      Speedrun.trailingPaused = true
      if Speedrun.LIVESPLIT then
        Speedrun.LIVESPLIT:write("pause\r\n");
        Speedrun.LIVESPLIT:flush()
      end
    end
  end
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "unlocks" then
    Speedrun.RUN_INFO.condition_value = 0
    for _, v in pairs(G.P_CENTERS) do
      if not v.omit then 
        if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Booster') or (v.set == 'Back')) then
          if v.unlocked == true or v.unlocked == nil or v.unlock_condition and v.unlock_condition.type == '' then Speedrun.RUN_INFO.condition_value=Speedrun.RUN_INFO.condition_value+1 end
        end
      end
    end
    for _, v in pairs(G.P_CENTERS) do
      if not v.omit then 
        if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Booster') or (v.set == 'Back')) then
          if not v.unlock_condition or v.unlock_condition.type == '' or v.name == 'Dusk' or v.name == 'Ride the Bus' then 
            Speedrun.RUN_INFO.condition_value=Speedrun.RUN_INFO.condition_value-1
          end
        end
      end
    end
  end
  Speedrun.TIMERS.UNLOCK_DISP = Speedrun.RUN_INFO.condition_value.." / "..Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_value
  Speedrun.TIMERS.ENDSCREEN_COLORS = Speedrun.TIMERS.ENDSCREEN_COLORS + dt
  if Speedrun.TIMERS.ENDSCREEN_COLORS > 1 then
    Speedrun.TIMERS.ENDSCREEN_COLORS = 0
    math.randomseed(Speedrun.RNG)
    Speedrun.RNG = math.random()
    local hue = math.floor(math.random()*255)
    local C1 = hsvColor(hue,Speedrun.C_SATURATION,Speedrun.C_VALUE)
    Speedrun.C1[1] = C1[1]
    Speedrun.C1[2] = C1[2]
    Speedrun.C1[3] = C1[3]
    local C2 = hsvColor((hue+50)%256,Speedrun.C_SATURATION,Speedrun.C_VALUE)
    Speedrun.C2[1] = C2[1]
    Speedrun.C2[2] = C2[2]
    Speedrun.C2[3] = C2[3]
  end
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "discoveries" then
    Speedrun.RUN_INFO.condition_value = 0
    for _, v in pairs(G.P_CENTERS) do
      if not v.omit then 
        if v.set and ((v.set == 'Joker') or v.consumeable or (v.set == 'Edition') or (v.set == 'Voucher') or (v.set == 'Back') or (v.set == 'Booster')) then
          if not (v.set == 'Joker' and v.rarity == 4) and v.discovered then 
            Speedrun.RUN_INFO.condition_value = Speedrun.RUN_INFO.condition_value + 1
          end
        end
      end
    end
    for _, v in pairs(G.P_BLINDS) do
      if v.discovered then Speedrun.RUN_INFO.condition_value = Speedrun.RUN_INFO.condition_value + 1 end
    end
    for _, v in pairs(G.P_TAGS) do
      if v.discovered then Speedrun.RUN_INFO.condition_value = Speedrun.RUN_INFO.condition_value + 1 end
    end
  end
end
Speedrun.Game_start_run_ref = Game.start_run
function Game:start_run(args)
  Speedrun.TIMERS.FINISHED_RUN = 999
  Speedrun.Game_start_run_ref(self,args)
  local saveTable = args.savetext or nil
  if G.CONTROLLER.held_keys["lctrl"] or G.CONTROLLER.held_keys["rctrl"] then
    if (saveTable and saveTable.TIMERS) then Speedrun.TIMERS.SPEEDRUN = saveTable.TIMERS.SPEEDRUN
    else Speedrun.TIMERS.SPEEDRUN = 0 end
  else
    if (saveTable and saveTable.TIMERS) then Speedrun.TIMERS.SPEEDRUN = saveTable.TIMERS.SPEEDRUN
    elseif Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].hide_condition == true then Speedrun.TIMERS.SPEEDRUN = 0
    elseif Speedrun.RUN_INFO.condition_value > (Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_start_value or 0) then
      if Speedrun.RUN_INFO.condition_value < Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_value then
          Speedrun.TIMERS.SPEEDRUN = Speedrun.TIMERS.SPEEDRUN
      end
    else Speedrun.TIMERS.SPEEDRUN = 0 end
  end
  Speedrun.TIMERS.CURRENT_RUN = saveTable and saveTable.TIMERS and saveTable.TIMERS.CURRENT_RUN or 0
  if saveTable and saveTable.RUN_INFO then Speedrun.RUN_INFO = saveTable.RUN_INFO elseif Speedrun.TIMERS.SPEEDRUN == 0 then Speedrun.initRunInfo() end
  Speedrun.TIMERS.SPEEDRUN_DISP = Speedrun.formatTime(Speedrun.TIMERS.SPEEDRUN)
  Speedrun.TIMERS.SPEEDRUN_ACTIVE = Speedrun.TIMERS.SPEEDRUN ~= 0 and (Speedrun.SETTINGS.includeMenuing or G.SETTINGS.profile == "Official Mode*")
  if not saveTable then Speedrun.SAVED_GAME = nil end
  if Speedrun.SETTINGS.timerDuringRun == "Right" then
    Game.speedrunHUD = UIBox{
      definition = create_UIBox_SpeedrunTimer(),
      config = {align=('cri'), offset = {x=-0.3,y=2.1},major = G.ROOM_ATTACH}
    }
  end
end
Speedrun.G_FUNCS_wipe_off_ref = G.FUNCS.wipe_off
G.FUNCS.wipe_off = function()
  Speedrun.G_FUNCS_wipe_off_ref()
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 0,
    no_delete = true,
    blocking = false,
    timer = 'REAL',
    func = function()
      Speedrun.TIMERS.SPEEDRUN_ACTIVE = true
      if Speedrun.TIMERS.SPEEDRUN == 0 and G.STAGE == G.STAGES.RUN then
        if Speedrun.LIVESPLIT then
          Speedrun.LIVESPLIT:write("starttimer\r\n")
          Speedrun.LIVESPLIT:flush()
        end
      end
      return true
    end
  }))
end
local eom = G.FUNCS.exit_overlay_menu
G.FUNCS.exit_overlay_menu = function()
  eom()
  if G.GAME.won then Speedrun.TIMERS.FINISHED_RUN = 999 end
end
Speedrun.create_UIBox_round_scores_row_ref = create_UIBox_round_scores_row
function create_UIBox_round_scores_row(score, text_colour)
  Speedrun.TIMERS.FINISHED_RUN = 1
  if score == "ankh_speedrun_time" then
    local check_high_score = false
    local score_tab = {}
    local label_w, score_w, h = 3.5, 3.5, 0.5
    score_tab = {
      {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'CURRENT_RUN_DISP'}}, colours = {text_colour or G.C.WHITE},shadow = true, float = true, scale = 0.5})}},
    }
    return {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, func = check_high_score and 'high_score_alert' or nil, id = score}, nodes={
      {n=score=='defeated_by' and G.UIT.R or G.UIT.C, config={align = "cm", padding = 0.02, minw = label_w, maxw = label_w}, nodes={
          {n=G.UIT.T, config={text = "Elapsed Time", scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
      }},
      {n=score=='defeated_by' and G.UIT.R or G.UIT.C, config={align = "cr"}, nodes={
        {n=G.UIT.C, config={align = "cm", minh = h, r = 0.1, minw = score=='defeated_by' and label_w or score_w, colour = (score == 'seed' and G.GAME.seeded) and G.C.RED or (G.SETTINGS.profile == "Official Mode*" and (Speedrun.GROS_MICHEL == 2 and G.C.RED or Speedrun.GROS_MICHEL == 1 and G.C.ORANGE or HEX("786907"))) or G.C.BLACK, emboss = 0.05}, nodes={
          {n=G.UIT.C, config={align = "cm", padding = 0.05, r = 0.1, minw = score_w}, nodes=score_tab},
        }}
      }},
    }}
  end
  return Speedrun.create_UIBox_round_scores_row_ref(score, text_colour)
end
Speedrun.create_UIBox_win_ref = create_UIBox_win
function create_UIBox_win()
  Speedrun.TIMERS.ENDSCREEN_COLORS = 1000
  Speedrun.RNG = Speedrun.HASH
  local ui = Speedrun.create_UIBox_win_ref()
  local verNode = 
  {n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = Speedrun.VER, colours = {Speedrun.C1,Speedrun.C2},shadow = true, float = true, rotate = true, scale = 0.75, pop_in = 0.4})}},
  }}
  local unlockNode = 
  {n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = Speedrun.RUN_INFO.unlocksFound.." / "..Speedrun.RUN_INFO.unlocksTotal, colours = {Speedrun.RUN_INFO.unlocksFound==Speedrun.RUN_INFO.unlocksTotal and G.C.GOLD or G.C.WHITE},shadow = true, scale = 0.4})}},
  }}
  if Speedrun.SETTINGS.timerEndScreen then ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes+1] = create_UIBox_round_scores_row('ankh_speedrun_time', G.C.WHITE) end
  ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes+1] = verNode
  ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes+1] = unlockNode

  Speedrun.RUN_INFO.deckWins[G.GAME.selected_back.name] = true
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "deck_wins" then
    Speedrun.RUN_INFO.condition_value = 0
    for _, v in pairs(Speedrun.RUN_INFO.deckWins) do
      if v then Speedrun.RUN_INFO.condition_value = Speedrun.RUN_INFO.condition_value + 1 end
    end
  end
  
  if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "ante" then
    Speedrun.RUN_INFO.condition_value = 9
  end

  if G.GAME.challenge then
    Speedrun.RUN_INFO.challengeWins[G.GAME.challenge] = true
    if Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition == "challenge_wins" then
      Speedrun.RUN_INFO.condition_value = 0
      for _, v in pairs(Speedrun.RUN_INFO.challengeWins) do
        if v then Speedrun.RUN_INFO.condition_value = Speedrun.RUN_INFO.condition_value + 1 end
      end
    end
  end

  if Speedrun.RUN_INFO.trailingConditionValue < Speedrun.RUN_INFO.condition_value then
    while Speedrun.RUN_INFO.trailingConditionValue < Speedrun.RUN_INFO.condition_value do
        Speedrun.RUN_INFO.trailingConditionValue = Speedrun.RUN_INFO.trailingConditionValue + 1
        if Speedrun.LIVESPLIT then
          Speedrun.LIVESPLIT:write("split\r\n");
          Speedrun.LIVESPLIT:flush()
        end
    end
  end

  
  Speedrun.TIMERS.SPEEDRUN_ACTIVE = (Speedrun.RUN_INFO.condition_value < Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_value) and (Speedrun.SETTINGS.includeMenuing or G.SETTINGS.profile == "Official Mode*")

  return ui
end
Speedrun.create_UIBox_game_over_ref = create_UIBox_game_over
function create_UIBox_game_over()
  Speedrun.TIMERS.ENDSCREEN_COLORS = 1000
  Speedrun.TIMERS.SPEEDRUN_ACTIVE = (Speedrun.RUN_INFO.condition_value < Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].condition_value) and (Speedrun.SETTINGS.includeMenuing or G.SETTINGS.profile == "Official Mode*")
  Speedrun.RNG = Speedrun.HASH
  local ui = Speedrun.create_UIBox_game_over_ref()
  if Speedrun.SETTINGS.timerEndScreen then ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes+1] = create_UIBox_round_scores_row('ankh_speedrun_time', G.C.WHITE) end
  local verNode = 
  {n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = Speedrun.VER, colours = {Speedrun.C1,Speedrun.C2},shadow = true, float = true, rotate = true, scale = 0.75, pop_in = 0.4})}},
  }}
  local unlockNode = 
  {n=G.UIT.R, config={align = "cm"}, nodes={
    {n=G.UIT.O, config={object = DynaText({string = Speedrun.RUN_INFO.unlocksFound.." / "..Speedrun.RUN_INFO.unlocksTotal, colours = {Speedrun.RUN_INFO.unlocksFound==Speedrun.RUN_INFO.unlocksTotal and G.C.GOLD or G.C.WHITE},shadow = true, scale = 0.4})}},
  }}
  ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes+1] = verNode
  ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes[#ui.nodes[1].nodes[2].nodes[1].nodes[1].nodes[1].nodes[2].nodes[1].nodes+1] = unlockNode
  return ui
end
function save_run()
  if G.F_NO_SAVING == true then return end
  local cardAreas = {}
  for k, v in pairs(G) do
    if (type(v) == "table") and v.is and v:is(CardArea) then 
      local cardAreaSer = v:save()
      if cardAreaSer then cardAreas[k] = cardAreaSer end
    end
  end

  local tags = {}
  for k, v in ipairs(G.GAME.tags) do
    if (type(v) == "table") and v.is and v:is(Tag) then 
      local tagSer = v:save()
      if tagSer then tags[k] = tagSer end
    end
  end

  G.culled_table =  recursive_table_cull{
    cardAreas = cardAreas,
    tags = tags,
    GAME = G.GAME,
    STATE = G.STATE,
    ACTION = G.action or nil,
    BLIND = G.GAME.blind:save(),
    BACK = G.GAME.selected_back:save(),
    VERSION = G.VERSION,
    TIMERS = Speedrun.TIMERS,
    RUN_INFO = Speedrun.RUN_INFO
  }
  G.ARGS.save_run = G.culled_table
  Speedrun.SAVED_GAME = G.culled_table

  if G.SETTINGS.profile ~= "Official Mode*" then
    G.FILE_HANDLER = G.FILE_HANDLER or {}
    G.FILE_HANDLER.run = true
    G.FILE_HANDLER.update_queued = true
  end
end
function G.UIDEF.profile_select()
  G.focused_profile = G.focused_profile or G.SETTINGS.profile or 1

  local t =   create_UIBox_generic_options({padding = 0,contents ={
      {n=G.UIT.R, config={align = "cm", padding = 0, draw_layer = 1, minw = 4}, nodes={
        create_tabs(
        {tabs = {
            {
                label = 1,
                chosen = G.focused_profile == 1,
                tab_definition_function = G.UIDEF.profile_option,
                tab_definition_function_args = 1
            },
            {
                label = 2,
                chosen = G.focused_profile == 2,
                tab_definition_function = G.UIDEF.profile_option,
                tab_definition_function_args = 2
            },
            {
                label = 3,
                chosen = G.focused_profile == 3,
                tab_definition_function = G.UIDEF.profile_option,
                tab_definition_function_args = 3
            },
            --[[{
                label = "Official Mode",
                chosen = G.focused_profile == "Official Mode*",
                tab_definition_function = Speedrun.official_mode_option,
                tab_definition_function_args = "Official Mode*"
            }--]] --disabled this because the checks haven't been updated
        },
        snap_to_nav = true}),
      }},
  }})
  return t
end
function Speedrun.official_mode_option(_profile)
  set_discover_tallies()
  G.focused_profile = _profile

  local lwidth, rwidth, scale = 1, 1, 1
  G.CHECK_PROFILE_DATA = nil
  local t = {n=G.UIT.ROOT, config={align = 'cm', colour = G.C.CLEAR}, nodes={
    {n=G.UIT.R, config={align = 'cm',padding = 0.1, minh = 0.8}, nodes={
        ((_profile == G.SETTINGS.profile) or not profile_data) and {n=G.UIT.R, config={align = "cm"}, nodes={
        create_text_input({
          w = 4, max_length = 16, prompt_text = localize('k_enter_name'),
          ref_table = G.PROFILES[_profile], ref_value = 'name',extended_corpus = true, keyboard_offset = 1,
          callback = function() 
            G:save_settings()
            G.FILE_HANDLER.force = true
          end
        }),
      }} or {n=G.UIT.R, config={align = 'cm',padding = 0.1, minw = 4, r = 0.1, colour = G.C.BLACK, minh = 0.6}, nodes={
        {n=G.UIT.T, config={text = G.PROFILES[_profile].name, scale = 0.45, colour = G.C.WHITE}},
      }},
    }},
    {n=G.UIT.R, config={align = "cm", padding = 0.1}, nodes={
      {n=G.UIT.C, config={align = "cm", minw = 6}, nodes={
        (G.PROFILES[_profile].progress and G.PROFILES[_profile].progress.discovered) and create_progress_box(G.PROFILES[_profile].progress, 0.5) or
        {n=G.UIT.C, config={align = "cm", minh = 4, minw = 5.2, colour = G.C.BLACK, r = 0.1}, nodes=
          lovely.version == "0.1.0" and
          {
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'Official Mode requires', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'Lovely version 0.5.0', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'or higher.', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          }
          or SMODS and
          {
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'Official Mode', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'cannot be used', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'with Steamodded.', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          }
          or
          {
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'Creates a profile that', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'uses extra protections', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'to prevent cheating.', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'Progress will not be', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.T, config={text = 'saved to any files.', scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}},
          }},
          }
      },
      }},
      {n=G.UIT.C, config={align = "cm", minh = 4}, nodes={
        {n=G.UIT.R, config={align = "cm", minh = 1}, nodes={
          profile_data and {n=G.UIT.R, config={align = "cm"}, nodes={
            {n=G.UIT.C, config={align = "cm", minw = lwidth}, nodes={{n=G.UIT.T, config={text = localize('k_wins'),colour = G.C.UI.TEXT_LIGHT, scale = scale*0.7}}}},
            {n=G.UIT.C, config={align = "cm"}, nodes={{n=G.UIT.T, config={text = ': ',colour = G.C.UI.TEXT_LIGHT, scale = scale*0.7}}}},
            {n=G.UIT.C, config={align = "cl", minw = rwidth}, nodes={{n=G.UIT.T, config={text = tostring(profile_data.career_stats.c_wins),colour = G.C.RED, shadow = true, scale = 1*scale}}}}
          }} or nil,
        }},
        {n=G.UIT.R, config={align = "cm", padding = 0.2}, nodes={
          {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
            {n=G.UIT.R, config={align = "cm", minw = 4, maxw = 4, minh = 0.8, padding = 0.2, r = 0.1, hover = true, colour = G.C.BLUE,func = 'can_load_profile', button = "load_profile", shadow = true, focus_args = {nav = 'wide'}}, nodes={
              {n=G.UIT.T, config={text = _profile == G.SETTINGS.profile and localize('b_current_profile') or profile_data and localize('b_load_profile') or localize('b_create_profile'), ref_value = 'load_button_text', scale = 0.5, colour = G.C.UI.TEXT_LIGHT}}
            }}
          }},
          {n=G.UIT.R, config={align = "cm", padding = 0, minh = 0.7}, nodes={
            {n=G.UIT.R, config={align = "cm", minw = 3, maxw = 4, minh = 0.6, padding = 0.2, r = 0.1, hover = true, colour = G.C.RED,func = 'can_delete_profile', button = "delete_profile", shadow = true, focus_args = {nav = 'wide'}}, nodes={
              {n=G.UIT.T, config={text = _profile == G.SETTINGS.profile and localize('b_reset_profile') or localize('b_delete_profile'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT}}
            }}
          }},
          (_profile == G.SETTINGS.profile and not G.PROFILES[G.SETTINGS.profile].all_unlocked) and {n=G.UIT.R, config={align = "cm", padding = 0, minh = 0.7}, nodes={
            {n=G.UIT.R, config={align = "cm", minw = 3, maxw = 4, minh = 0.6, padding = 0.2, r = 0.1, hover = true, colour = G.C.ORANGE,func = 'can_unlock_all', button = "unlock_all", shadow = true, focus_args = {nav = 'wide'}}, nodes={
              {n=G.UIT.T, config={text = localize('b_unlock_all'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT}}
            }}
          }} or {n=G.UIT.R, config={align = "cm", minw = 3, maxw = 4, minh = 0.7}, nodes={
            G.PROFILES[_profile].all_unlocked and ((not G.F_NO_ACHIEVEMENTS) and {n=G.UIT.T, config={text = localize(G.F_TROPHIES and 'k_trophies_disabled' or 'k_achievements_disabled'), scale = 0.3, colour = G.C.UI.TEXT_LIGHT}} or 
              nil) or nil
          }},
        }},
    }},
    }},
    {n=G.UIT.R, config={align = "cm", padding = 0}, nodes={
      {n=G.UIT.T, config={id = 'warning_text', text = localize('ph_click_confirm'), scale = 0.4, colour = G.C.CLEAR}}
    }}
  }} 
  return t
end
local clp_ref = G.FUNCS.can_load_profile
G.FUNCS.can_load_profile = function(e)
  clp_ref(e)
  if G.focused_profile == "Official Mode*" then
    if SMODS or lovely.version == "0.1.0" then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
  end
end

function Game:load_profile(_profile)
  if not G.PROFILES[_profile] then _profile = 1 end
  G.SETTINGS.profile = _profile
  
  if _profile ~= "Official Mode*" then
    local info = get_compressed(_profile..'/profile.jkr')
    if info ~= nil then
        for k, v in pairs(STR_UNPACK(info)) do
            G.PROFILES[G.SETTINGS.profile][k] = v
        end
    end
  end

  local temp_profile = {
      MEMORY = {
          deck = 'Red Deck',
          stake = 1,
      },
      stake = 1,
      
      high_scores = {
          hand = {label = 'Best Hand', amt = 0},
          furthest_round = {label = 'Highest Round', amt = 0},
          furthest_ante = {label = 'Highest Ante', amt = 0},
          most_money = {label = 'Most Money', amt = 0},
          boss_streak = {label = 'Most Bosses in a Row', amt = 0},
          collection = {label = 'Collection', amt = 0, tot = 1},
          win_streak = {label = 'Best Win Streak', amt = 0},
          current_streak = {label = '', amt = 0},
          poker_hand = {label = 'Most Played Hand', amt = 0}
      },
  
      career_stats = {
          c_round_interest_cap_streak = 0,
          c_dollars_earned = 0,
          c_shop_dollars_spent = 0,
          c_tarots_bought = 0,
          c_planets_bought = 0,
          c_playing_cards_bought = 0,
          c_vouchers_bought = 0,
          c_tarot_reading_used = 0,
          c_planetarium_used = 0,
          c_shop_rerolls = 0,
          c_cards_played = 0,
          c_cards_discarded = 0,
          c_losses = 0,
          c_wins = 0,
          c_rounds = 0,
          c_hands_played = 0,
          c_face_cards_played = 0,
          c_jokers_sold = 0,
          c_cards_sold = 0,
          c_single_hand_round_streak = 0,
      },
      progress = {

      },
      joker_usage = {},
      consumeable_usage = {},
      voucher_usage = {},
      hand_usage = {},
      deck_usage = {},
      deck_stakes = {},
      challenges_unlocked = nil,
      challenge_progress = {
          completed = {},
          unlocked = {}
      }
  }
  local recursive_init 
  recursive_init = function(t1, t2) 
      for k, v in pairs(t1) do
          if not t2[k] then 
              t2[k] = v
          elseif type(t2[k]) == 'table' and type(v) == 'table' then
              recursive_init(v, t2[k])
          end
      end
  end

  recursive_init(temp_profile, G.PROFILES[G.SETTINGS.profile])
  
  if G.SETTINGS.profile == "Official Mode*" then
    local exePath = love.filesystem.getSourceBaseDirectory().."\\Balatro.exe"
    local hash = nil
    if love.system.getOS() == "Windows" then
      local handle = io.popen("certutil -hashfile \""..exePath.."\" SHA256")
      local currentLine = 1
      for line in handle:lines() do
          if currentLine == 2 then
              hash = line
              break
          end
          currentLine = currentLine + 1
      end
      handle:close()
    elseif love.system.getOS() == "OS X" then
      local handle = io.popen("shasum -a 256 \""..exePath.."\"")
      local output = handle:read("*a")
      hash = output:match("(%x+)%s")
      handle:close()
    elseif love.system.getOS() == "Linux" then
      local handle = io.popen("sh256sum \""..exePath.."\"")
      local output = handle:read("*a")
      hash = output:match("(%x+)%s")
      handle:close()
    end
    local http = require("https")
    local url = "https://gist.githubusercontent.com/MathIsFun0/cacc041088dd6a16610633ddcc50c615/raw"
    local code, body = http.request(url)
    if not body then 
        error(code) 
    end
    function split(inputstr, sep)
      if sep == nil then
              sep = "%s"
      end
      local t={}
      for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
              table.insert(t, str)
      end
      return t
    end
    local data = split(body,"\n")
    for i=1,#data do
      data[i] = split(data[i],";")
    end
    Speedrun.GROS_MICHEL = 1
    for i=1,#data do
      if (VERSION == data[i][2] and love.system.getOS() == data[i][1]) then
        if (hash == data[i][3]) then
          Speedrun.GROS_MICHEL = 0
        elseif Speedrun.GROS_MICHEL == 1 then 
          Speedrun.GROS_MICHEL = 2
        end
      end
    end
    if Speedrun.GROS_MICHEL ~= 0 then
      Speedrun.sendDebugMessage("Bala Hash: "..hash)
    end
    if Speedrun.pseudohash(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Ankh.lua")) ~= 0.52647060898004838236 then 
      Speedrun.sendDebugMessage("Lua Hash: "..string.format("%.20f",Speedrun.pseudohash(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Ankh.lua"))))
      Speedrun.CAVENDISH = true 
    end
    if Speedrun.pseudohash(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/lovely.toml")) ~= 0.2876176958334326627664268 then 
      Speedrun.sendDebugMessage("Love Hash: "..string.format("%.20f",Speedrun.pseudohash(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/lovely.toml"))))
      Speedrun.CAVENDISH = true 
    end
    G.SETTINGS.GAMESPEED = 4
    local files = nativefs.getDirectoryItems(lovely.mod_dir.."/MathIsFun0-Ankh")
    for _, file in ipairs(files) do
      if (file ~= "Ankh.lua" and file ~= "Ankh_ops.lua" and file ~= "README.md" and file ~= "settings.lua" and file ~= "lovely.toml" and file ~= "icon.png" and file ~= "manifest.json" and file ~= "mm_v2_manifest.json") then Speedrun.CAVENDISH = true end
    end
    local files = nativefs.getDirectoryItems(lovely.mod_dir.."/lovely/dump")
    for _, file in ipairs(files) do
      if (file ~= "game.lua" and file ~= "main.lua") then Speedrun.CAVENDISH = true end
    end
    local game_lua = nativefs.read(lovely.mod_dir.."/lovely/dump/game.lua")
    local game_lua = game_lua and game_lua:match("'(.-)'")
    local main_lua = nativefs.read(lovely.mod_dir.."/lovely/dump/main.lua")
    local main_lua = main_lua and main_lua:match("'(.-)'")
    Speedrun.sendDebugMessage("Game Hash: "..game_lua)
    Speedrun.sendDebugMessage("Main Hash: "..main_lua)
    for i=1,#data do
      if (VERSION == data[i][2] and love.system.getOS() == data[i][1]) then
        if game_lua ~= data[i][4] then
          Speedrun.CAVENDISH = true
        end
        if main_lua ~= data[i][5] then
          Speedrun.CAVENDISH = true
        end
      end
    end
  end
  G.E_MANAGER:add_event(Event({
    trigger = 'after',
    delay = 1,
    no_delete = true,
    blocking = false,
    timer = 'REAL',
    func = function()
      Speedrun.initRunInfo()
      return true
    end
  }))
end
function Speedrun.sendDebugMessage(str)
  print("[ANKH] "..str)
end
function Speedrun.pseudohash(str)
  local num = 1
  if str == nil then return -1 end
  for i=#str, 1, -1 do
      num = ((1.1239285023/(num+0.1))*(1+string.byte(str, i))*math.pi + math.pi*i)%1
  end
  return num
end
function hsvColor(h, s, v)
  h = h / 255

  local r, g, b

  local i = math.floor(h * 6)
  local f = h * 6 - i
  local p = v * (1 - s)
  local q = v * (1 - f * s)
  local t = v * (1 - (1 - f) * s)

  i = i % 6

  if i == 0 then
      r, g, b = v, t, p
  elseif i == 1 then
      r, g, b = q, v, p
  elseif i == 2 then
      r, g, b = p, v, t
  elseif i == 3 then
      r, g, b = p, q, v
  elseif i == 4 then
      r, g, b = t, p, v
  elseif i == 5 then
      r, g, b = v, p, q
  end

  return {r, g, b, 1}
end
Speedrun.HASH = Speedrun.pseudohash(debug.getinfo(1, "S").source:sub(2))
Speedrun.RNG = Speedrun.HASH
Speedrun.C1 = hsvColor(0,Speedrun.C_SATURATION,Speedrun.C_VALUE)
Speedrun.C2 = hsvColor(50,Speedrun.C_SATURATION,Speedrun.C_VALUE)
function Game:save_notify(card)
  if G.SETTINGS.profile ~= "Official Mode*" then
    G.SAVE_MANAGER.channel:push({
      type = 'save_notify',
      save_notify = card.key,
      profile_num = G.SETTINGS.profile
    })
  end
end
function Game:save_progress()
    G.ARGS.save_progress = G.ARGS.save_progress or {}
    G.ARGS.save_progress.UDA = EMPTY(G.ARGS.save_progress.UDA)
    G.ARGS.save_progress.SETTINGS = G.SETTINGS
    G.ARGS.save_progress.PROFILE = G.PROFILES[G.SETTINGS.profile]

    for k, v in pairs(self.P_CENTERS) do
        G.ARGS.save_progress.UDA[k] = (v.unlocked and 'u' or '')..(v.discovered and 'd' or '')..(v.alerted and 'a' or '')
    end
    for k, v in pairs(self.P_BLINDS) do
        G.ARGS.save_progress.UDA[k] = (v.unlocked and 'u' or '')..(v.discovered and 'd' or '')..(v.alerted and 'a' or '')
    end
    for k, v in pairs(self.P_TAGS) do
        G.ARGS.save_progress.UDA[k] = (v.unlocked and 'u' or '')..(v.discovered and 'd' or '')..(v.alerted and 'a' or '')
    end
    for k, v in pairs(self.P_SEALS) do
        G.ARGS.save_progress.UDA[k] = (v.unlocked and 'u' or '')..(v.discovered and 'd' or '')..(v.alerted and 'a' or '')
    end

  if G.SETTINGS.profile ~= "Official Mode*" then
    G.FILE_HANDLER = G.FILE_HANDLER or {}
    G.FILE_HANDLER.progress = true
    G.FILE_HANDLER.update_queued = true
  end
end
function Game:save_settings()
    G.ARGS.save_settings = G.SETTINGS
  if G.SETTINGS.profile ~= "Official Mode*" then
    G.FILE_HANDLER = G.FILE_HANDLER or {}
    G.FILE_HANDLER.settings = true
    G.FILE_HANDLER.update_queued = true
  end
end
function Game:save_metrics()
    G.ARGS.save_metrics = G.METRICS
  if G.SETTINGS.profile ~= "Official Mode*" then
    G.FILE_HANDLER = G.FILE_HANDLER or {}
    G.FILE_HANDLER.settings = true
    G.FILE_HANDLER.update_queued = true
  end
end
Speedrun.GROS_MICHEL = 0
Speedrun.CAVENDISH = false
function Card_Character:init(args)
  Moveable.init(self,args.x or 1, args.y or 1, args.w or G.CARD_W*1.1, args.h or G.CARD_H*1.1)

  self.states.collide.can = false

  self.children = {}
  self.config = {args = args}
  self.children.card = Card(self.T.x, self.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, args.center or G.P_CENTERS.j_joker, {bypass_discovery_center = true})
  self.children.card.states.visible = false
  self.children.card:start_materialize({G.C.BLUE, G.C.WHITE, G.C.RED})
  self.children.card:set_alignment{
      major = self, type = 'cm', offset = {x=0, y=0}
  }
  self.children.card.jimbo = self
  self.children.card.states.collide.can = true
  self.children.card.states.focus.can = false
  self.children.card.states.hover.can = true
  self.children.card.states.drag.can = false
  self.children.card.hover = Node.hover

  self.children.particles = Particles(0, 0, 0,0, {
      timer = 0.03,
      scale = 0.3,
      speed = 1.2,
      lifespan = 2,
      attach = self,
      colours = Speedrun.CAVENDISH and {G.C.RED, G.C.BLUE, G.C.ORANGE, G.C.GREEN} or {G.C.RED, G.C.BLUE, G.C.ORANGE},
      fill = true
  })
  self.children.particles.static_rotation = true
  self.children.particles:set_role{
      role_type = 'Minor',
      xy_bond = 'Weak',
      r_bond = 'Strong',
      major = self,
  }

  if getmetatable(self) == Card_Character then 
      table.insert(G.I.CARD, self)
  end
end
G.FUNCS.can_continue = function(e)
  if e.config.func then
    local _can_continue = nil
    local savefile = love.filesystem.getInfo(G.SETTINGS.profile..'/'..'save.jkr')
    if G.SETTINGS.profile == "Official Mode*" then
      G.SAVED_GAME = Speedrun.SAVED_GAME
    end
    if savefile == nil and (G.SETTINGS.profile ~= "Official Mode*" and Speedrun.SAVED_GAME) then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    else
      if not G.SAVED_GAME then 
        G.SAVED_GAME = get_compressed(G.SETTINGS.profile..'/'..'save.jkr')
        if G.SAVED_GAME ~= nil then G.SAVED_GAME = STR_UNPACK(G.SAVED_GAME) end
      end
      if not G.SAVED_GAME then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
        return false
      end
      if not G.SAVED_GAME.VERSION or G.SAVED_GAME.VERSION < '0.9.2' then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
      else
        _can_continue = true
      end
    end
    e.config.func = nil
    return _can_continue
  end
end

function STR_UNPACK(str)
	local chunk, err = loadstring(str)
	if chunk then
	  setfenv(chunk, {})
	  local success, result = pcall(chunk)
	  if success then
		return result
	  else
		print("Error unpacking string: " .. result)
		return nil
	  end
	else
	  print("Error loading string: " .. err)
	  return nil
	end
end

function create_UIBox_SpeedrunTimer()
	return {n=G.UIT.ROOT, config = {align = "cm", padding = 0.03, colour = G.C.UI.TRANSPARENT_DARK, r=0.1}, nodes={
		{n=G.UIT.R, config = {align = "cm", padding= 0.05, colour = G.C.DYN_UI.MAIN, r=0.1}, nodes={
			{n=G.UIT.R, config={align = "cm", colour = G.C.DYN_UI.BOSS_DARK, r=0.1, minw = 1.5, padding = 0.08}, nodes={
				{n=G.UIT.R, config={align = "cm", minh = 0.0}, nodes={}},
				{n=G.UIT.R, config={id = 'speedrun_timer_right', align = "cm", padding = 0.05, minw = 1.45, emboss = 0.05, r = 0.1}, nodes=not Speedrun.CATEGORIES[Speedrun.SETTINGS.selectedCategory].hide_condition and {{n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'UNLOCK_DISP'}}, colours = {Speedrun.COLORS[Speedrun.SETTINGS.timerColor]}, shadow = true, bump = true, scale = 0.4, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
              }},
              {n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'SPEEDRUN_DISP'}}, colours = {Speedrun.COLORS[Speedrun.SETTINGS.timerColor]}, shadow = true, bump = true, scale = 0.6, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
              }}} or {{n=G.UIT.R, config={align = "cm"}, nodes={
                {n=G.UIT.O, config={object = DynaText({string = {{ref_table = Speedrun.TIMERS, ref_value = 'SPEEDRUN_DISP'}}, colours = {Speedrun.COLORS[Speedrun.SETTINGS.timerColor]}, shadow = true, bump = true, scale = 0.6, pop_in = 0.5, maxw = 5, silent = true}), id = 'timer'}}
              }}}
				}
			}}
		}}
	}}
end