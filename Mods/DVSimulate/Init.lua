--- Divvy's Simulation for Balatro - Init.lua
--
-- Global values that must be present for the rest of this mod to work.
local json = require "json"

if not DV then DV = {} end

DV.SIM = {
   running = false,
   waiting = false,

   TYPES = {
      EXACT = -1,
      MIN   = 1, -- by default large values are "worst case"
      MAX   = 0, -- by default small values are "best case"
   },
   running_type = 0,
   total_simulations = 0,

   -- Tables to create shadow copies for:
   MAIN_TABLES = { METRICS = true, GAME = true, play = true, hand = true, jokers = true, consumeables = true, deck = true, discard = true, playing_cards = true },
   -- Table keys that should not be shadowed (to preserve memory):
   IGNORED_KEYS = { role = true, children = true, parent = true, alignment = true, ability_UIBox_table = true, h_popup = true, example = true, dissolve_colours = true, FRAME = true },

   real = {
      global = nil, -- Real global `G` table
      main = {},    -- Real game tables (from MAIN_TABLES)
   },

   shadow = {
      global = nil, -- Shadow global `G` table
      main = {},    -- Top-level shadow tables (from MAIN_TABLES)
      links = {},   -- Links to real_tables (links[real] = shadow)
   },

   seeds = {
      known = {},
      unknown = {},
      save_loc = "",
   },

   --DEBUG = {immediate = true},
   debug_data = {
      -- Time data for rough benchmarking:
      t0 = 0,
      t1 = 0,
      t = {},
      label = {},
   },

   -- deprecated
   JOKERS = {},
}


DV.SIM._start_up = Game.start_up
function Game:start_up()
   local temp = { DV.SIM._start_up(self) }
   local filesystem = NFS or love.filesystem

   for _, mod in pairs(SMODS.Mods) do
      if mod.display_name == "DVSimulate" then
         DV.SIM.seeds.save_loc = mod.path .. "/seeds.json"
         local file_content, err = filesystem.read(DV.SIM.seeds.save_loc)
         if file_content == nil then
            print("CAN'T READ: " .. tostring(err))
         else
            local new_seeds = json.decode(file_content)
            for seed, tbl in pairs(new_seeds) do
               DV.SIM.seeds.known[seed] = tbl
            end
         end
      end
   end
   return unpack(temp)
end

function DV.SIM.save_seed_json()
   local filesystem = NFS or love.filesystem
   local success, message = filesystem.write(DV.SIM.seeds.save_loc, json.encode(DV.SIM.seeds.known))
   if not success then
      print("CAN'T WRITE: " .. tostring(message))
   end
end

function DV.SIM.create_seed_json()
   return json.encode(DV.SIM.seeds.known)
end

function DV.SIM.create_json(tbl)
   return json.encode(tbl)
end
