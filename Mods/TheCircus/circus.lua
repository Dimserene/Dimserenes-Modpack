--- STEAMODDED HEADER
--- MOD_NAME: The Circus
--- MOD_ID: VSMODS
--- MOD_AUTHOR: [jrings]
--- MOD_DESCRIPTION: A first mod
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]
--- BADGE_COLOR: fb8b73
--- PREFIX: circus
----------------------------------------------
------------MOD CODE -------------------------

-- Using sounds from
-- Strong Man Noises.mp3 by Volvion -- https://freesound.org/s/609795/ -- License: Creative Commons 0
-- Cannon boom by Quassorr -- https://freesound.org/s/758072/ -- License: Creative Commons 0
-- Entry of the Gladiators, Op.68 - Julius Fučík - Arranged for Strings by GregorQuendel -- https://freesound.org/s/735154/ -- License: Attribution NonCommercial 4.0
-- "Horse Whinny, Close, A.wav" by InspectorJ (www.jshaw.co.uk) of Freesound.org
-- Graphics misappropriated: Bear blind graphic from BelenosBear


math.randomseed(os.time())

local unc_rare_circus_jokers = {
  "j_circus_aerialist_prodigy", "j_circus_equestrianarchy", "j_circus_grand_finale", "j_circus_hooded_visitor",
  "j_circus_joker_cannonball", "j_circus_lion_tamer", "j_circus_palm_reader", "j_circus_ringmaster", 
  "j_circus_safety_net", "j_circus_stoic_clown", "j_circus_strongman", "j_circus_trapezist", 
  "j_circus_fire_eater"
    }

--Creates an atlas for cards to use
SMODS.Atlas {
  key = "a_circus",
  path = "jokers1.png",
  px = 71,
  py = 95
}
SMODS.Atlas {
  key = "a_circus_2",
  path = "jokers2.png",
  px = 71,
  py = 95
}

SMODS.Atlas {
  key = "a_circus_blinds",
  path = "blinds.png",
	px = 34,
	py = 34,
  atlas_table = "ANIMATION_ATLAS",
  frames = 1
}

SMODS.Sound {
  key = 'cannonball',
  path = 'cannonball.ogg'
}
SMODS.Sound {
  key = 'entrance',
  path = 'entrance.ogg'
}
SMODS.Sound {
  key = 'strongman',
  path = 'strongman.ogg'
}
SMODS.Sound {
  key = 'horse',
  path = 'horse.ogg'
}

SMODS.load_file('circus/common_jokers.lua')()
SMODS.load_file('circus/other_jokers.lua')()


--- New Deck
--- 
--- 
SMODS.Back {
  name = "Sideshow Deck",
  key = "sideshow",
  pos = { x = 1, y = 3 },
  atlas = 'a_circus',
  loc_txt = {
    name = "Sideshow",
    text = {
      "Start with a random", 
      "uncommon or rare",
      "Circus joker"
    }
  },
  apply = function(self)
    
    local joker_name = pseudorandom_element(unc_rare_circus_jokers, pseudoseed('sideshow' .. os.date('%Y%m%d%H%M%S')))
    G.E_MANAGER:add_event(Event({
      func = function()
        if G.jokers then
          local njoker = create_card("Joker", G.jokers, nil, 2, nil, nil, joker_name)
          njoker:add_to_deck()
          G.jokers:emplace(njoker)
          return true
        end
    end
    }))
  end
}


--- 
--- New Boss
--- 
local bear = SMODS.Blind{
  key = "bear",
  loc_txt = {
   name = 'The Bear',
   text = { 'Set money to {C:money}$8{}' },
 },
  boss_colour = HEX('21b04e'),
  dollars = 0,
  mult = 2,
  boss = {
      min = 1,
      max = 10
  },
  pos = { x = 0, y = 0 },
  atlas = 'a_circus_blinds',
  set_blind = function(self)
      G.GAME.dollars = 8
  end,
  in_pool = function(self, wawa, wawa2)
      return 2
  end
}


