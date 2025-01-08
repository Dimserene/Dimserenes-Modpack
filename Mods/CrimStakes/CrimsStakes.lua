--- STEAMODDED HEADER
--- MOD_NAME: CrimStake
--- MOD_ID: CrimStake
--- PREFIX: CrimStake
--- MOD_AUTHOR: [Crimson Heart]
--- MOD_DESCRIPTION: Want to try the base stakes with just mods? Here you go! [DO NOT USE BY ITSELF] 
--- BADGE_COLOUR: 990000
--- VERSION: 1.0_beta
--- PRIORITY: -1

SMODS.Atlas({
    key = 'MO_stakes',
    path = 'mo_chips.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'stickers',
    path = 'mo_stickers.png',
    px = 71,
    py = 95
})


-- Mod Only --

SMODS.Stake({
    key = "MO_white",
    applied_stakes = {},
    above_stake = 'gold',
    unlocked_stake = "CrimStake_MO_red",
    atlas = 'MO_stakes',
    pos = {x = 0, y = 0},
    sticker_pos = {x = 1, y = 0},
    sticker_atlas = 'stickers',
    loc_txt = {
        name = "Modded White Stake",
        text = {
            "Base Difficulty",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    },
    modifiers = function()
        G.GAME.banned_keys.j_joker = true
        G.GAME.banned_keys.j_greedy_joker = true
        G.GAME.banned_keys.j_lusty_joker = true
        G.GAME.banned_keys.j_wrathful_joker = true
        G.GAME.banned_keys.j_gluttenous_joker = true
        G.GAME.banned_keys.j_jolly = true
        G.GAME.banned_keys.j_zany = true
        G.GAME.banned_keys.j_mad = true
        G.GAME.banned_keys.j_crazy = true
        G.GAME.banned_keys.j_droll = true
        G.GAME.banned_keys.j_sly = true
        G.GAME.banned_keys.j_wily = true
        G.GAME.banned_keys.j_clever = true
        G.GAME.banned_keys.j_devious = true
        G.GAME.banned_keys.j_crafty = true
        G.GAME.banned_keys.j_half = true
        G.GAME.banned_keys.j_stencil = true
        G.GAME.banned_keys.j_four_fingers = true
        G.GAME.banned_keys.j_mime = true
        G.GAME.banned_keys.j_credit_card = true
        G.GAME.banned_keys.j_ceremonial = true
        G.GAME.banned_keys.j_banner = true
        G.GAME.banned_keys.j_mystic_summit = true
        G.GAME.banned_keys.j_marble = true
        G.GAME.banned_keys.j_loyalty_card = true
        G.GAME.banned_keys.j_8_ball = true
        G.GAME.banned_keys.j_misprint = true
        G.GAME.banned_keys.j_dusk = true
        G.GAME.banned_keys.j_raised_fist = true
        G.GAME.banned_keys.j_chaos = true
        G.GAME.banned_keys.j_fibonacci = true
        G.GAME.banned_keys.j_steel_joker = true
        G.GAME.banned_keys.j_scary_face = true
        G.GAME.banned_keys.j_abstract = true
        G.GAME.banned_keys.j_delayed_grat = true
        G.GAME.banned_keys.j_hack = true
        G.GAME.banned_keys.j_pareidolia = true
        G.GAME.banned_keys.j_gros_michel = true
        G.GAME.banned_keys.j_even_steven = true
        G.GAME.banned_keys.j_odd_todd = true
        G.GAME.banned_keys.j_scholar = true
        G.GAME.banned_keys.j_business = true
        G.GAME.banned_keys.j_supernova = true
        G.GAME.banned_keys.j_ride_the_bus = true
        G.GAME.banned_keys.j_space = true
        G.GAME.banned_keys.j_egg = true
        G.GAME.banned_keys.j_burglar = true
        G.GAME.banned_keys.j_blackboard = true
        G.GAME.banned_keys.j_runner = true
        G.GAME.banned_keys.j_ice_cream = true
        G.GAME.banned_keys.j_dna = true
        G.GAME.banned_keys.j_splash = true
        G.GAME.banned_keys.j_blue_joker = true
        G.GAME.banned_keys.j_sixth_sense = true
        G.GAME.banned_keys.j_constellation = true
        G.GAME.banned_keys.j_hiker = true
        G.GAME.banned_keys.j_faceless = true
        G.GAME.banned_keys.j_green_joker = true
        G.GAME.banned_keys.j_superposition = true
        G.GAME.banned_keys.j_todo_list = true
        G.GAME.banned_keys.j_cavendish = true
        G.GAME.banned_keys.j_card_sharp = true
        G.GAME.banned_keys.j_red_card = true
        G.GAME.banned_keys.j_madness = true
        G.GAME.banned_keys.j_square = true
        G.GAME.banned_keys.j_seance = true
        G.GAME.banned_keys.j_riff_raff = true
        G.GAME.banned_keys.j_vampire = true
        G.GAME.banned_keys.j_shortcut = true
        G.GAME.banned_keys.j_hologram = true
        G.GAME.banned_keys.j_vagabond = true
        G.GAME.banned_keys.j_baron = true
        G.GAME.banned_keys.j_cloud_9 = true
        G.GAME.banned_keys.j_rocket = true
        G.GAME.banned_keys.j_obelisk = true
        G.GAME.banned_keys.j_midas_mask = true
        G.GAME.banned_keys.j_luchador = true
        G.GAME.banned_keys.j_photograph = true
        G.GAME.banned_keys.j_gift = true
        G.GAME.banned_keys.j_turtle_bean = true
        G.GAME.banned_keys.j_erosion = true
        G.GAME.banned_keys.j_reserved_parking = true
        G.GAME.banned_keys.j_mail = true
        G.GAME.banned_keys.j_to_the_moon = true
        G.GAME.banned_keys.j_hallucination = true
        G.GAME.banned_keys.j_fortune_teller = true
        G.GAME.banned_keys.j_juggler = true
        G.GAME.banned_keys.j_drunkard = true
        G.GAME.banned_keys.j_stone = true
        G.GAME.banned_keys.j_golden = true
        G.GAME.banned_keys.j_lucky_cat = true
        G.GAME.banned_keys.j_baseball = true
        G.GAME.banned_keys.j_bull = true
        G.GAME.banned_keys.j_diet_cola = true
        G.GAME.banned_keys.j_trading = true
        G.GAME.banned_keys.j_flash = true
        G.GAME.banned_keys.j_popcorn = true
        G.GAME.banned_keys.j_trousers = true
        G.GAME.banned_keys.j_ancient = true
        G.GAME.banned_keys.j_ramen = true
        G.GAME.banned_keys.j_walkie_talkie = true
        G.GAME.banned_keys.j_selzer = true
        G.GAME.banned_keys.j_castle = true
        G.GAME.banned_keys.j_smiley = true
        G.GAME.banned_keys.j_campfire = true
        G.GAME.banned_keys.j_ticket = true
        G.GAME.banned_keys.j_mr_bones = true
        G.GAME.banned_keys.j_acrobat = true
        G.GAME.banned_keys.j_sock_and_buskin = true
        G.GAME.banned_keys.j_swashbuckler = true
        G.GAME.banned_keys.j_troubadour = true
        G.GAME.banned_keys.j_certificate = true
        G.GAME.banned_keys.j_smeared = true
        G.GAME.banned_keys.j_throwback = true
        G.GAME.banned_keys.j_hanging_chad = true
        G.GAME.banned_keys.j_rough_gem = true
        G.GAME.banned_keys.j_bloodstone = true
        G.GAME.banned_keys.j_arrowhead = true
        G.GAME.banned_keys.j_onyx_agate = true
        G.GAME.banned_keys.j_glass = true
        G.GAME.banned_keys.j_ring_master = true
        G.GAME.banned_keys.j_flower_pot = true
        G.GAME.banned_keys.j_blueprint = true
        G.GAME.banned_keys.j_wee = true
        G.GAME.banned_keys.j_merry_andy = true
        G.GAME.banned_keys.j_oops = true
        G.GAME.banned_keys.j_idol = true
        G.GAME.banned_keys.j_seeing_double = true
        G.GAME.banned_keys.j_matador = true
        G.GAME.banned_keys.j_hit_the_road = true
        G.GAME.banned_keys.j_duo = true
        G.GAME.banned_keys.j_trio = true
        G.GAME.banned_keys.j_family = true
        G.GAME.banned_keys.j_order = true
        G.GAME.banned_keys.j_tribe = true
        G.GAME.banned_keys.j_stuntman = true
        G.GAME.banned_keys.j_invisible = true
        G.GAME.banned_keys.j_brainstorm = true
        G.GAME.banned_keys.j_satellite = true
        G.GAME.banned_keys.j_shoot_the_moon = true
        G.GAME.banned_keys.j_drivers_license = true
        G.GAME.banned_keys.j_cartomancer = true
        G.GAME.banned_keys.j_astronomer = true
        G.GAME.banned_keys.j_burnt = true
        G.GAME.banned_keys.j_bootstraps = true
        G.GAME.banned_keys.j_caino = true
        G.GAME.banned_keys.j_triboulet = true
        G.GAME.banned_keys.j_yorick = true
        G.GAME.banned_keys.j_chicot = true
        G.GAME.banned_keys.j_perkeo = true
        G.GAME.banned_keys.c_fool = true
        G.GAME.banned_keys.c_magician = true
        G.GAME.banned_keys.c_high_priestess = true
        G.GAME.banned_keys.c_empress = true
        G.GAME.banned_keys.c_emperor = true
        G.GAME.banned_keys.c_heirophant = true
        G.GAME.banned_keys.c_lovers = true
        G.GAME.banned_keys.c_chariot = true
        G.GAME.banned_keys.c_justice = true
        G.GAME.banned_keys.c_hermit = true
        G.GAME.banned_keys.c_wheel_of_fortune = true
        G.GAME.banned_keys.c_strength = true
        G.GAME.banned_keys.c_hanged_man = true
        G.GAME.banned_keys.c_death = true
        G.GAME.banned_keys.c_temperance = true
        G.GAME.banned_keys.c_devil = true
        G.GAME.banned_keys.c_tower = true
        G.GAME.banned_keys.c_star = true
        G.GAME.banned_keys.c_moon = true
        G.GAME.banned_keys.c_sun = true
        G.GAME.banned_keys.c_judgement = true
        G.GAME.banned_keys.c_world = true
        G.GAME.banned_keys.c_mercury = true
        G.GAME.banned_keys.c_venus = true
        G.GAME.banned_keys.c_earth = true
        G.GAME.banned_keys.c_mars = true
        G.GAME.banned_keys.c_jupiter = true
        G.GAME.banned_keys.c_saturn = true
        G.GAME.banned_keys.c_uranus = true
        G.GAME.banned_keys.c_neptune = true
        G.GAME.banned_keys.c_pluto = true
        G.GAME.banned_keys.c_planet_x = true
        G.GAME.banned_keys.c_ceres = true
        G.GAME.banned_keys.c_eris = true
        G.GAME.banned_keys.c_familiar = true
        G.GAME.banned_keys.c_grim = true
        G.GAME.banned_keys.c_incantation = true
        G.GAME.banned_keys.c_talisman = true
        G.GAME.banned_keys.c_aura = true
        G.GAME.banned_keys.c_wraith = true
        G.GAME.banned_keys.c_sigil = true
        G.GAME.banned_keys.c_ouija = true
        G.GAME.banned_keys.c_ectoplasm = true
        G.GAME.banned_keys.c_immolate = true
        G.GAME.banned_keys.c_ankh = true
        G.GAME.banned_keys.c_deja_vu = true
        G.GAME.banned_keys.c_hex = true
        G.GAME.banned_keys.c_trance = true
        G.GAME.banned_keys.c_medium = true
        G.GAME.banned_keys.c_cryptid = true
        G.GAME.banned_keys.c_soul = true
        G.GAME.banned_keys.c_black_hole = true
        G.GAME.banned_keys.v_overstock_norm = true
        G.GAME.banned_keys.v_clearance_sale = true
        G.GAME.banned_keys.v_hone = true
        G.GAME.banned_keys.v_reroll_surplus = true
        G.GAME.banned_keys.v_crystal_ball = true
        G.GAME.banned_keys.v_telescope = true
        G.GAME.banned_keys.v_grabber = true
        G.GAME.banned_keys.v_wasteful = true
        G.GAME.banned_keys.v_tarot_merchant = true
        G.GAME.banned_keys.v_planet_merchant = true
        G.GAME.banned_keys.v_seed_money = true
        G.GAME.banned_keys.v_blank = true
        G.GAME.banned_keys.v_magic_trick = true
        G.GAME.banned_keys.v_hieroglyph = true
        G.GAME.banned_keys.v_directors_cut = true
        G.GAME.banned_keys.v_paint_brush = true
        G.GAME.banned_keys.v_overstock_plus = true
        G.GAME.banned_keys.v_liquidation = true
        G.GAME.banned_keys.v_glow_up = true
        G.GAME.banned_keys.v_reroll_glut = true
        G.GAME.banned_keys.v_omen_globe = true
        G.GAME.banned_keys.v_observatory = true
        G.GAME.banned_keys.v_nacho_tong = true
        G.GAME.banned_keys.v_recyclomancy = true
        G.GAME.banned_keys.v_tarot_tycoon = true
        G.GAME.banned_keys.v_planet_tycoon = true
        G.GAME.banned_keys.v_money_tree = true
        G.GAME.banned_keys.v_antimatter = true
        G.GAME.banned_keys.v_illusion = true
        G.GAME.banned_keys.v_petroglyph = true
        G.GAME.banned_keys.v_retcon = true
        G.GAME.banned_keys.v_palette = true

        
    end,
})

SMODS.Stake {
    name = "Modded Red Stake",
    key = "MO_red",
    above_stake = 'CrimStake_MO_white',
    unlocked_stake = "CrimStake_MO_green",
    applied_stakes = { "CrimStake_MO_white" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
    end,
    colour = G.C.RED,
    loc_txt = {
    name = "Modded Red Stake",
    text = {
        "{C:attention}Small Blind{} gives",
        "no reward money",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Green Stake",
    key = "MO_green",
    above_stake = 'CrimStake_MO_red',
    unlocked_stake = "CrimStake_MO_black",
    applied_stakes = { "CrimStake_MO_red" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.GREEN,
    loc_txt = {
    name = "Modded Green Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Black Stake",
    key = "MO_black",
    above_stake = 'CrimStake_MO_green',
    unlocked_stake = "CrimStake_MO_blue",
    applied_stakes = { "CrimStake_MO_green" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_eternals_in_shop = true
    end,
    colour = G.C.BLACK,
    loc_txt = {
    name = "Modded Black Stake",
    text = {
        "Shop can have {C:attention}Eternal{} Jokers",
        "{C:inactive,s:0.8}(Can't be sold or destroyed)",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Blue Stake",
    key = "MO_blue",
    above_stake = 'CrimStake_MO_black',
    unlocked_stake = "CrimStake_MO_purple",
    applied_stakes = { "CrimStake_MO_black" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 3, y = 0 },
    sticker_pos = { x = 4, y = 0 },
    modifiers = function()
        G.GAME.starting_params.discards = G.GAME.starting_params.discards - 1
    end,
    colour = G.C.BLUE,
    loc_txt = {
    name = "Modded Blue Stake",
    text = {
        "Shop can have {C:attention}Eternal{} Jokers",
        "{C:inactive,s:0.8}(Can't be sold or destroyed)",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Purple Stake",
    key = "MO_purple",
    above_stake = 'CrimStake_MO_blue',
    unlocked_stake = "CrimStake_MO_orange",
    applied_stakes = { "CrimStake_MO_blue" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 0, y = 1 },
    sticker_pos = { x = 1, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.PURPLE,
    loc_txt = {
    name = "Modded Purple Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Orange Stake",
    key = "MO_orange",
    above_stake = 'CrimStake_MO_purple',
    unlocked_stake = "CrimStake_MO_Gold",
    applied_stakes = { "CrimStake_MO_purple" },
        atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 1 },
    sticker_pos = { x = 2, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
    colour = G.C.ORANGE,
    loc_txt = {
    name = "Modded Orange Stake",
    text = {
        "Shop can have {C:attention}Perishable{} Jokers",
        "{C:inactive,s:0.8}(Debuffed after 5 Rounds)",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Modded Gold Stake",
    key = "MO_gold",
    above_stake = 'CrimStake_MO_orange',
    applied_stakes = { "CrimStake_MO_orange" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    shiny = true,
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "Modded Gold Stake",
    text = {
        "Shop can have {C:attention}Rental{} Jokers",
        "{C:inactive,s:0.8}(Costs {C:money,s:0.8}$3{C:inactive,s:0.8} per round)",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}



--Vanilla Only--



SMODS.Stake({
    key = "VO_White",
    applied_stakes = {},
    above_stake = 'CrimStake_MO_gold',
    unlocked_stake = "CrimStake_VO_Red",
    atlas = 'MO_stakes',
    pos = {x = 0, y = 2},
    sticker_pos = {x = 1, y = 2},
    sticker_atlas = 'stickers',
    loc_txt = {
        name = "Vanilla White Stake",
        text = {
            "Base Difficulty",
            "{s:0.8,C:inactive}(Vanilla Only){}",
        }
    },
    modifiers = function()
        G.GAME.modifiers.vanilla_only = true
        if Ortalab then
            G.GAME.banned_keys.ortalab_lot_rooster = true
            G.GAME.banned_keys.ortalab_lot_melon = true
            G.GAME.banned_keys.ortalab_lot_scorpion = true
            G.GAME.banned_keys.ortalab_lot_umbrella = true
            G.GAME.banned_keys.ortalab_lot_barrel = true
            G.GAME.banned_keys.ortalab_lot_mandolin = true
            G.GAME.banned_keys.ortalab_lot_ladder = true
            G.GAME.banned_keys.ortalab_lot_siren = true
            G.GAME.banned_keys.ortalab_lot_bird = true
            G.GAME.banned_keys.ortalab_lot_bonnet = true
            G.GAME.banned_keys.ortalab_lot_pear = true
            G.GAME.banned_keys.ortalab_lot_flag = true
            G.GAME.banned_keys.ortalab_lot_bottle = true
            G.GAME.banned_keys.ortalab_lot_harp = true
            G.GAME.banned_keys.ortalab_lot_heron = true
            G.GAME.banned_keys.ortalab_lot_rose = true
            G.GAME.banned_keys.ortalab_lot_dandy = true
            G.GAME.banned_keys.ortalab_lot_boot = true
            G.GAME.banned_keys.ortalab_lot_parrot = true
            G.GAME.banned_keys.ortalab_lot_heart = true
            G.GAME.banned_keys.ortalab_lot_hand = true
            G.GAME.banned_keys.ortalab_lot_tree = true
            G.GAME.banned_keys.ortalab_small_loteria_1 = true
            G.GAME.banned_keys.ortalab_small_loteria_2 = true
            G.GAME.banned_keys.ortalab_small_loteria_3 = true
            G.GAME.banned_keys.ortalab_small_loteria_4 = true
        end
    end,
})

SMODS.Stake {
    name = "Vanilla Red Stake",
    key = "VO_Red",
    above_stake = 'CrimStake_VO_White',
    unlocked_stake = "CrimStake_VO_Green",
    applied_stakes = { "CrimStake_VO_White" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 2 },
    sticker_pos = { x = 2, y = 2 },
    modifiers = function()
        G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
        G.GAME.modifiers.no_blind_reward.Small = true
    end,
    colour = G.C.RED,
    loc_txt = {
    name = "Vanilla Red Stake",
    text = {
        "{C:attention}Small Blind{} gives",
        "no reward money",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Green Stake",
    key = "VO_Green",
    above_stake = 'CrimStake_VO_Red',
    unlocked_stake = "CrimStake_VO_Black",
    applied_stakes = { "CrimStake_VO_Red" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 2, y = 2 },
    sticker_pos = { x = 3, y = 2 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.GREEN,
    loc_txt = {
    name = "Vanilla Green Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Black Stake",
    key = "VO_Black",
    above_stake = 'CrimStake_VO_Green',
    unlocked_stake = "CrimStake_VO_Blue",
    applied_stakes = { "CrimStake_VO_Green" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 4, y = 2 },
    sticker_pos = { x = 0, y = 3 },
    modifiers = function()
        G.GAME.modifiers.enable_eternals_in_shop = true
    end,
    colour = G.C.BLACK,
    loc_txt = {
    name = "Vanilla Black Stake",
    text = {
        "Shop can have {C:attention}Eternal{} Jokers",
        "{C:inactive,s:0.8}(Can't be sold or destroyed)",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Blue Stake",
    key = "VO_Blue",
    above_stake = 'CrimStake_VO_Black',
    unlocked_stake = "CrimStake_VO_Purple",
    applied_stakes = { "CrimStake_VO_Black" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 3, y = 2 },
    sticker_pos = { x = 4, y = 2 },
    modifiers = function()
        G.GAME.starting_params.discards = G.GAME.starting_params.discards - 1
    end,
    colour = G.C.BLUE,
    loc_txt = {
    name = "Vanilla Blue Stake",
    text = {
        "Shop can have {C:attention}Eternal{} Jokers",
        "{C:inactive,s:0.8}(Can't be sold or destroyed)",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Purple Stake",
    key = "VO_Purple",
    above_stake = 'CrimStake_VO_Blue',
    unlocked_stake = "CrimStake_VO_Orange",
    applied_stakes = { "CrimStake_VO_Blue" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 0, y = 3 },
    sticker_pos = { x = 1, y = 3 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.PURPLE,
    loc_txt = {
    name = "Vanilla Purple Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Orange Stake",
    key = "VO_Orange",
    above_stake = 'CrimStake_VO_Purple',
    unlocked_stake = "CrimStake_VO_Gold",
    applied_stakes = { "CrimStake_VO_Purple" },
        atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 3 },
    sticker_pos = { x = 2, y = 3 },
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
    colour = G.C.ORANGE,
    loc_txt = {
    name = "Vanilla Orange Stake",
    text = {
        "Shop can have {C:attention}Perishable{} Jokers",
        "{C:inactive,s:0.8}(Debuffed after 5 Rounds)",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Vanilla Gold Stake",
    key = "VO_Gold",
    above_stake = 'CrimStake_VO_Orange',
    applied_stakes = { "CrimStake_VO_Orange" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    shiny = true,
    pos = { x = 2, y = 3 },
    sticker_pos = { x = 3, y = 3 },
    modifiers = function()
        G.GAME.modifiers.enable_perishables_in_shop = true
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "Vanilla Gold Stake",
    text = {
        "Shop can have {C:attention}Rental{} Jokers",
        "{C:inactive,s:0.8}(Costs {C:money,s:0.8}$3{C:inactive,s:0.8} per round)",
        "{s:0.8,C:inactive}(Vanilla Only){}",
    }
}
}

SMODS.Stake {
    name = "Jimbo Only Stake",
    key = "JimboStake",
    above_stake = 'CrimStake_VO_Gold',
    applied_stakes = { "white" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 0, y = 4 },
    sticker_pos = { x = 0, y = 0 },
    modifiers = function()
        G.GAME.banned_keys.j_four_fingers = true
        G.GAME.banned_keys.j_mime = true
        G.GAME.banned_keys.j_credit_card = true
        G.GAME.banned_keys.j_ceremonial = true
        G.GAME.banned_keys.j_banner = true
        G.GAME.banned_keys.j_mystic_summit = true
        G.GAME.banned_keys.j_loyalty_card = true
        G.GAME.banned_keys.j_8_ball = true
        G.GAME.banned_keys.j_dusk = true
        G.GAME.banned_keys.j_raised_fist = true
        G.GAME.banned_keys.j_fibonacci = true
        G.GAME.banned_keys.j_scary_face = true
        G.GAME.banned_keys.j_delayed_grat = true
        G.GAME.banned_keys.j_hack = true
        G.GAME.banned_keys.j_pareidolia = true
        G.GAME.banned_keys.j_gros_michel = true
        G.GAME.banned_keys.j_business = true
        G.GAME.banned_keys.j_supernova = true
        G.GAME.banned_keys.j_ride_the_bus = true
        G.GAME.banned_keys.j_egg = true
        G.GAME.banned_keys.j_ice_cream = true
        G.GAME.banned_keys.j_dna = true
        G.GAME.banned_keys.j_splash = true
        G.GAME.banned_keys.j_superposition = true
        G.GAME.banned_keys.j_todo_list = true
        G.GAME.banned_keys.j_cavendish = true
        G.GAME.banned_keys.j_red_card = true
        G.GAME.banned_keys.j_seance = true
        G.GAME.banned_keys.j_shortcut = true
        G.GAME.banned_keys.j_cloud_9 = true
        G.GAME.banned_keys.j_rocket = true
        G.GAME.banned_keys.j_obelisk = true
        G.GAME.banned_keys.j_midas_mask = true
        G.GAME.banned_keys.j_gift = true
        G.GAME.banned_keys.j_turtle_bean = true
        G.GAME.banned_keys.j_erosion = true
        G.GAME.banned_keys.j_reserved_parking = true
        G.GAME.banned_keys.j_mail = true
        G.GAME.banned_keys.j_to_the_moon = true
        G.GAME.banned_keys.j_juggler = true
        G.GAME.banned_keys.j_drunkard = true
        G.GAME.banned_keys.j_lucky_cat = true
        G.GAME.banned_keys.j_baseball = true
        G.GAME.banned_keys.j_bull = true
        G.GAME.banned_keys.j_diet_cola = true
        G.GAME.banned_keys.j_popcorn = true
        G.GAME.banned_keys.j_trousers = true
        G.GAME.banned_keys.j_ancient = true
        G.GAME.banned_keys.j_ramen = true
        G.GAME.banned_keys.j_walkie_talkie = true
        G.GAME.banned_keys.j_selzer = true
        G.GAME.banned_keys.j_castle = true
        G.GAME.banned_keys.j_smiley = true
        G.GAME.banned_keys.j_campfire = true
        G.GAME.banned_keys.j_ticket = true
        G.GAME.banned_keys.j_acrobat = true
        G.GAME.banned_keys.j_sock_and_buskin = true
        G.GAME.banned_keys.j_troubadour = true
        G.GAME.banned_keys.j_certificate = true
        G.GAME.banned_keys.j_hanging_chad = true
        G.GAME.banned_keys.j_rough_gem = true
        G.GAME.banned_keys.j_bloodstone = true
        G.GAME.banned_keys.j_arrowhead = true
        G.GAME.banned_keys.j_onyx_agate = true
        G.GAME.banned_keys.j_flower_pot = true
        G.GAME.banned_keys.j_oops = true
        G.GAME.banned_keys.j_idol = true
        G.GAME.banned_keys.j_seeing_double = true
        G.GAME.banned_keys.j_hit_the_road = true
        G.GAME.banned_keys.j_duo = true
        G.GAME.banned_keys.j_trio = true
        G.GAME.banned_keys.j_family = true
        G.GAME.banned_keys.j_order = true
        G.GAME.banned_keys.j_tribe = true
        G.GAME.banned_keys.j_satellite = true
        G.GAME.banned_keys.j_shoot_the_moon = true
        G.GAME.banned_keys.j_drivers_license = true
        G.GAME.banned_keys.j_bootstraps = true
    end,
    colour = G.C.JIMBO,
    loc_txt = {
    name = "Jimbo Stake",
    text = {
        "{C:attention}Non-Jimbo{} Jokers",
        "are Removed",
        "{s:0.8,C:inactive}(Vanilla Jokers Only){}"
    }
}
}

SMODS.Stake {
    name = "Jimbo Only Vanilla Stake",
    key = "Jimbo_VOStake",
    above_stake = 'CrimStake_JimboStake',
    applied_stakes = { "CrimStake_VO_White" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 4 },
    sticker_pos = { x = 0, y = 2 },
    modifiers = function()
        G.GAME.banned_keys.j_four_fingers = true
        G.GAME.banned_keys.j_mime = true
        G.GAME.banned_keys.j_credit_card = true
        G.GAME.banned_keys.j_ceremonial = true
        G.GAME.banned_keys.j_banner = true
        G.GAME.banned_keys.j_mystic_summit = true
        G.GAME.banned_keys.j_loyalty_card = true
        G.GAME.banned_keys.j_8_ball = true
        G.GAME.banned_keys.j_dusk = true
        G.GAME.banned_keys.j_raised_fist = true
        G.GAME.banned_keys.j_fibonacci = true
        G.GAME.banned_keys.j_scary_face = true
        G.GAME.banned_keys.j_delayed_grat = true
        G.GAME.banned_keys.j_hack = true
        G.GAME.banned_keys.j_pareidolia = true
        G.GAME.banned_keys.j_gros_michel = true
        G.GAME.banned_keys.j_business = true
        G.GAME.banned_keys.j_supernova = true
        G.GAME.banned_keys.j_ride_the_bus = true
        G.GAME.banned_keys.j_egg = true
        G.GAME.banned_keys.j_ice_cream = true
        G.GAME.banned_keys.j_dna = true
        G.GAME.banned_keys.j_splash = true
        G.GAME.banned_keys.j_superposition = true
        G.GAME.banned_keys.j_todo_list = true
        G.GAME.banned_keys.j_cavendish = true
        G.GAME.banned_keys.j_red_card = true
        G.GAME.banned_keys.j_seance = true
        G.GAME.banned_keys.j_shortcut = true
        G.GAME.banned_keys.j_cloud_9 = true
        G.GAME.banned_keys.j_rocket = true
        G.GAME.banned_keys.j_obelisk = true
        G.GAME.banned_keys.j_midas_mask = true
        G.GAME.banned_keys.j_gift = true
        G.GAME.banned_keys.j_turtle_bean = true
        G.GAME.banned_keys.j_erosion = true
        G.GAME.banned_keys.j_reserved_parking = true
        G.GAME.banned_keys.j_mail = true
        G.GAME.banned_keys.j_to_the_moon = true
        G.GAME.banned_keys.j_juggler = true
        G.GAME.banned_keys.j_drunkard = true
        G.GAME.banned_keys.j_lucky_cat = true
        G.GAME.banned_keys.j_baseball = true
        G.GAME.banned_keys.j_bull = true
        G.GAME.banned_keys.j_diet_cola = true
        G.GAME.banned_keys.j_popcorn = true
        G.GAME.banned_keys.j_trousers = true
        G.GAME.banned_keys.j_ancient = true
        G.GAME.banned_keys.j_ramen = true
        G.GAME.banned_keys.j_walkie_talkie = true
        G.GAME.banned_keys.j_selzer = true
        G.GAME.banned_keys.j_castle = true
        G.GAME.banned_keys.j_smiley = true
        G.GAME.banned_keys.j_campfire = true
        G.GAME.banned_keys.j_ticket = true
        G.GAME.banned_keys.j_acrobat = true
        G.GAME.banned_keys.j_sock_and_buskin = true
        G.GAME.banned_keys.j_troubadour = true
        G.GAME.banned_keys.j_certificate = true
        G.GAME.banned_keys.j_hanging_chad = true
        G.GAME.banned_keys.j_rough_gem = true
        G.GAME.banned_keys.j_bloodstone = true
        G.GAME.banned_keys.j_arrowhead = true
        G.GAME.banned_keys.j_onyx_agate = true
        G.GAME.banned_keys.j_flower_pot = true
        G.GAME.banned_keys.j_oops = true
        G.GAME.banned_keys.j_idol = true
        G.GAME.banned_keys.j_seeing_double = true
        G.GAME.banned_keys.j_hit_the_road = true
        G.GAME.banned_keys.j_duo = true
        G.GAME.banned_keys.j_trio = true
        G.GAME.banned_keys.j_family = true
        G.GAME.banned_keys.j_order = true
        G.GAME.banned_keys.j_tribe = true
        G.GAME.banned_keys.j_satellite = true
        G.GAME.banned_keys.j_shoot_the_moon = true
        G.GAME.banned_keys.j_drivers_license = true
        G.GAME.banned_keys.j_bootstraps = true
        if Ortalab then
            G.GAME.banned_keys.ortalab_lot_rooster = true
            G.GAME.banned_keys.ortalab_lot_melon = true
            G.GAME.banned_keys.ortalab_lot_scorpion = true
            G.GAME.banned_keys.ortalab_lot_umbrella = true
            G.GAME.banned_keys.ortalab_lot_barrel = true
            G.GAME.banned_keys.ortalab_lot_mandolin = true
            G.GAME.banned_keys.ortalab_lot_ladder = true
            G.GAME.banned_keys.ortalab_lot_siren = true
            G.GAME.banned_keys.ortalab_lot_bird = true
            G.GAME.banned_keys.ortalab_lot_bonnet = true
            G.GAME.banned_keys.ortalab_lot_pear = true
            G.GAME.banned_keys.ortalab_lot_flag = true
            G.GAME.banned_keys.ortalab_lot_bottle = true
            G.GAME.banned_keys.ortalab_lot_harp = true
            G.GAME.banned_keys.ortalab_lot_heron = true
            G.GAME.banned_keys.ortalab_lot_rose = true
            G.GAME.banned_keys.ortalab_lot_dandy = true
            G.GAME.banned_keys.ortalab_lot_boot = true
            G.GAME.banned_keys.ortalab_lot_parrot = true
            G.GAME.banned_keys.ortalab_lot_heart = true
            G.GAME.banned_keys.ortalab_lot_hand = true
            G.GAME.banned_keys.ortalab_lot_tree = true
            G.GAME.banned_keys.ortalab_small_loteria_1 = true
            G.GAME.banned_keys.ortalab_small_loteria_2 = true
            G.GAME.banned_keys.ortalab_small_loteria_3 = true
            G.GAME.banned_keys.ortalab_small_loteria_4 = true
        end
    end,
    colour = G.C.JIMBO,
    loc_txt = {
    name = "Vanilla Jimbo Stake",
    text = {
        "{C:attention}Non-Jimbo{} cards",
        "are Removed",
        "{s:0.8,C:inactive}(Vanilla Only Stake){}",
    }
}
}


SMODS.Stake {
    name = "Jimboless Stake",
    key = "JimbolessStake",
    above_stake = 'CrimStake_Jimbo_VOStake',
    applied_stakes = { "white" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 4, y = 1 },
    sticker_pos = { x = 4, y = 1 },
    modifiers = function()
        G.GAME.banned_keys.j_joker = true
        G.GAME.banned_keys.j_greedy_joker = true
        G.GAME.banned_keys.j_lusty_joker = true
        G.GAME.banned_keys.j_wrathful_joker = true
        G.GAME.banned_keys.j_gluttenous_joker = true
        G.GAME.banned_keys.j_jolly = true
        G.GAME.banned_keys.j_zany = true
        G.GAME.banned_keys.j_mad = true
        G.GAME.banned_keys.j_droll = true
        G.GAME.banned_keys.j_crazy = true
        G.GAME.banned_keys.j_sly = true
        G.GAME.banned_keys.j_wily = true
        G.GAME.banned_keys.j_clever = true
        G.GAME.banned_keys.j_devious = true
        G.GAME.banned_keys.j_crafty = true
        G.GAME.banned_keys.j_half = true
        G.GAME.banned_keys.j_stencil = true
        G.GAME.banned_keys.j_marble = true
        G.GAME.banned_keys.j_misprint = true
        G.GAME.banned_keys.j_chaos = true
        G.GAME.banned_keys.j_steel_joker = true
        G.GAME.banned_keys.j_abstract = true
        G.GAME.banned_keys.j_even_steven = true
        G.GAME.banned_keys.j_odd_todd = true
        G.GAME.banned_keys.j_scholar = true
        G.GAME.banned_keys.j_space = true
        G.GAME.banned_keys.j_burglar = true
        G.GAME.banned_keys.j_blackboard = true
        G.GAME.banned_keys.j_runner = true
        G.GAME.banned_keys.j_blue_joker = true
        G.GAME.banned_keys.j_sixth_sense = true
        G.GAME.banned_keys.j_constellation = true
        G.GAME.banned_keys.j_hiker = true
        G.GAME.banned_keys.j_faceless = true
        G.GAME.banned_keys.j_green_joker = true
        G.GAME.banned_keys.j_card_sharp = true
        G.GAME.banned_keys.j_madness = true
        G.GAME.banned_keys.j_square = true
        G.GAME.banned_keys.j_riff_raff = true
        G.GAME.banned_keys.j_vampire = true
        G.GAME.banned_keys.j_hologram = true
        G.GAME.banned_keys.j_vagabond = true
        G.GAME.banned_keys.j_luchador = true
        G.GAME.banned_keys.j_photograph = true
        G.GAME.banned_keys.j_hallucination = true
        G.GAME.banned_keys.j_fortune_teller = true
        G.GAME.banned_keys.j_stone = true
        G.GAME.banned_keys.j_golden = true
        G.GAME.banned_keys.j_trading = true
        G.GAME.banned_keys.j_flash = true
        G.GAME.banned_keys.j_mr_bones = true
        G.GAME.banned_keys.j_swashbuckler = true
        G.GAME.banned_keys.j_smeared = true
        G.GAME.banned_keys.j_throwback = true
        G.GAME.banned_keys.j_glass = true
        G.GAME.banned_keys.j_ring_master = true
        G.GAME.banned_keys.j_blueprint = true
        G.GAME.banned_keys.j_wee = true
        G.GAME.banned_keys.j_merry_andy = true
        G.GAME.banned_keys.j_matador = true
        G.GAME.banned_keys.j_stuntman = true
        G.GAME.banned_keys.j_invisible = true
        G.GAME.banned_keys.j_brainstorm = true
        G.GAME.banned_keys.j_cartomancer = true
        G.GAME.banned_keys.j_astronomer = true
        G.GAME.banned_keys.j_burnt = true
        G.GAME.banned_keys.j_caino = true
        G.GAME.banned_keys.j_triboulet = true
        G.GAME.banned_keys.j_yorick = true
        G.GAME.banned_keys.j_chicot = true
        G.GAME.banned_keys.j_perkeo = true
        G.GAME.banned_keys.c_soul = true
    end,
    colour = G.C.JIMBO,
    loc_txt = {
    name = "Jimboless Stake",
    text = {
        "{C:attention}Jimbo{} Jokers",
        "are Removed",
        "{s:0.8,C:inactive}(Vanilla Jokers Only){}"
    }
}
}



SMODS.Stake {
    name = "Jimboless Vanilla Stake",
    key = "Jimboless_VOStake",
    above_stake = 'CrimStake_JimbolessStake',
    applied_stakes = { "CrimStake_VO_White" },
    atlas = 'MO_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 4, y = 3 },
    sticker_pos = { x = 4, y = 3 },
        modifiers = function()
        G.GAME.banned_keys.j_joker = true
        G.GAME.banned_keys.j_greedy_joker = true
        G.GAME.banned_keys.j_lusty_joker = true
        G.GAME.banned_keys.j_wrathful_joker = true
        G.GAME.banned_keys.j_gluttenous_joker = true
        G.GAME.banned_keys.j_jolly = true
        G.GAME.banned_keys.j_zany = true
        G.GAME.banned_keys.j_mad = true
        G.GAME.banned_keys.j_droll = true
        G.GAME.banned_keys.j_crazy = true
        G.GAME.banned_keys.j_sly = true
        G.GAME.banned_keys.j_wily = true
        G.GAME.banned_keys.j_clever = true
        G.GAME.banned_keys.j_devious = true
        G.GAME.banned_keys.j_crafty = true
        G.GAME.banned_keys.j_half = true
        G.GAME.banned_keys.j_stencil = true
        G.GAME.banned_keys.j_marble = true
        G.GAME.banned_keys.j_misprint = true
        G.GAME.banned_keys.j_chaos = true
        G.GAME.banned_keys.j_steel_joker = true
        G.GAME.banned_keys.j_abstract = true
        G.GAME.banned_keys.j_even_steven = true
        G.GAME.banned_keys.j_odd_todd = true
        G.GAME.banned_keys.j_scholar = true
        G.GAME.banned_keys.j_space = true
        G.GAME.banned_keys.j_burglar = true
        G.GAME.banned_keys.j_blackboard = true
        G.GAME.banned_keys.j_runner = true
        G.GAME.banned_keys.j_blue_joker = true
        G.GAME.banned_keys.j_sixth_sense = true
        G.GAME.banned_keys.j_constellation = true
        G.GAME.banned_keys.j_hiker = true
        G.GAME.banned_keys.j_faceless = true
        G.GAME.banned_keys.j_green_joker = true
        G.GAME.banned_keys.j_card_sharp = true
        G.GAME.banned_keys.j_madness = true
        G.GAME.banned_keys.j_square = true
        G.GAME.banned_keys.j_riff_raff = true
        G.GAME.banned_keys.j_vampire = true
        G.GAME.banned_keys.j_hologram = true
        G.GAME.banned_keys.j_vagabond = true
        G.GAME.banned_keys.j_luchador = true
        G.GAME.banned_keys.j_photograph = true
        G.GAME.banned_keys.j_hallucination = true
        G.GAME.banned_keys.j_fortune_teller = true
        G.GAME.banned_keys.j_stone = true
        G.GAME.banned_keys.j_golden = true
        G.GAME.banned_keys.j_trading = true
        G.GAME.banned_keys.j_flash = true
        G.GAME.banned_keys.j_mr_bones = true
        G.GAME.banned_keys.j_swashbuckler = true
        G.GAME.banned_keys.j_smeared = true
        G.GAME.banned_keys.j_throwback = true
        G.GAME.banned_keys.j_glass = true
        G.GAME.banned_keys.j_ring_master = true
        G.GAME.banned_keys.j_blueprint = true
        G.GAME.banned_keys.j_wee = true
        G.GAME.banned_keys.j_merry_andy = true
        G.GAME.banned_keys.j_matador = true
        G.GAME.banned_keys.j_stuntman = true
        G.GAME.banned_keys.j_invisible = true
        G.GAME.banned_keys.j_brainstorm = true
        G.GAME.banned_keys.j_cartomancer = true
        G.GAME.banned_keys.j_astronomer = true
        G.GAME.banned_keys.j_burnt = true
        G.GAME.banned_keys.j_caino = true
        G.GAME.banned_keys.j_triboulet = true
        G.GAME.banned_keys.j_yorick = true
        G.GAME.banned_keys.j_chicot = true
        G.GAME.banned_keys.j_perkeo = true
        G.GAME.banned_keys.c_soul = true
        if Ortalab then
            G.GAME.banned_keys.ortalab_lot_rooster = true
            G.GAME.banned_keys.ortalab_lot_melon = true
            G.GAME.banned_keys.ortalab_lot_scorpion = true
            G.GAME.banned_keys.ortalab_lot_umbrella = true
            G.GAME.banned_keys.ortalab_lot_barrel = true
            G.GAME.banned_keys.ortalab_lot_mandolin = true
            G.GAME.banned_keys.ortalab_lot_ladder = true
            G.GAME.banned_keys.ortalab_lot_siren = true
            G.GAME.banned_keys.ortalab_lot_bird = true
            G.GAME.banned_keys.ortalab_lot_bonnet = true
            G.GAME.banned_keys.ortalab_lot_pear = true
            G.GAME.banned_keys.ortalab_lot_flag = true
            G.GAME.banned_keys.ortalab_lot_bottle = true
            G.GAME.banned_keys.ortalab_lot_harp = true
            G.GAME.banned_keys.ortalab_lot_heron = true
            G.GAME.banned_keys.ortalab_lot_rose = true
            G.GAME.banned_keys.ortalab_lot_dandy = true
            G.GAME.banned_keys.ortalab_lot_boot = true
            G.GAME.banned_keys.ortalab_lot_parrot = true
            G.GAME.banned_keys.ortalab_lot_heart = true
            G.GAME.banned_keys.ortalab_lot_hand = true
            G.GAME.banned_keys.ortalab_lot_tree = true
            G.GAME.banned_keys.ortalab_small_loteria_1 = true
            G.GAME.banned_keys.ortalab_small_loteria_2 = true
            G.GAME.banned_keys.ortalab_small_loteria_3 = true
            G.GAME.banned_keys.ortalab_small_loteria_4 = true
        end
    end,
    colour = G.C.JIMBO,
    loc_txt = {
    name = "Vanilla Jimboless Stake",
    text = {
        "{C:attention}Jimbo{} cards",
        "are Removed",
        "{s:0.8,C:inactive}(Vanilla Only Stake){}",
    }
}
}


-- Code --

VO_Packs = {
    p_arcana_normal_1 = true,
    p_arcana_normal_2 = true,
    p_arcana_normal_3 = true,
    p_arcana_normal_4 = true,
    p_arcana_jumbo_1 = true,
    p_arcana_jumbo_2 = true,
    p_arcana_mega_1 = true,
    p_arcana_mega_2 = true,
    p_celestial_normal_1 = true,
    p_celestial_normal_2 = true,
    p_celestial_normal_3 = true,
    p_celestial_normal_4 = true,
    p_celestial_jumbo_1 = true,
    p_celestial_jumbo_2 = true,
    p_celestial_mega_1 = true,
    p_celestial_mega_2 = true,
    p_spectral_normal_1 = true,
    p_spectral_normal_2 = true,
    p_spectral_jumbo_1 = true,
    p_spectral_mega_1 = true,
    p_standard_normal_1 = true,
    p_standard_normal_2 = true,
    p_standard_normal_3 = true,
    p_standard_normal_4 = true,
    p_standard_jumbo_1 = true,
    p_standard_jumbo_2 = true,
    p_standard_mega_1 = true,
    p_standard_mega_2 = true,
    p_buffoon_normal_1 = true,
    p_buffoon_normal_2 = true,
    p_buffoon_jumbo_1 = true,
    p_buffoon_mega_1 = true,
    }  

    function get_pack(_key, _type)
        if not G.GAME.first_shop_buffoon and not G.GAME.banned_keys['p_buffoon_normal_1'] then
            G.GAME.first_shop_buffoon = true
            return G.P_CENTERS['p_buffoon_normal_'..(math.random(1, 2))]
        end
        local cume, it, center = 0, 0, nil
        local temp_in_pool = {}
        for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
            local add
            v.current_weight = v.get_weight and v:get_weight() or v.weight or 1
            if (not _type or _type == v.kind) then add = true end
            if v.in_pool and type(v.in_pool) == 'function' then 
                local res, pool_opts = v:in_pool()
                pool_opts = pool_opts or {}
                add = res and (add or pool_opts.override_base_checks)
            end
            if v.kind ~= 'Buffoon' and v.kind ~= 'Standard' and G.GAME.modifiers.vanilla_only then
                if not VO_Packs[v.key] then add = false end
            end
            if add and not G.GAME.banned_keys[v.key] then cume = cume + (v.current_weight or 1); temp_in_pool[v.key] = true end
        end
        local poll = pseudorandom(pseudoseed((_key or 'pack_generic')..G.GAME.round_resets.ante))*cume
        for k, v in ipairs(G.P_CENTER_POOLS['Booster']) do
            if temp_in_pool[v.key] then 
                it = it + (v.current_weight or 1)
                if it >= poll and it - (v.current_weight or 1) <= poll then center = v; break end
            end
        end
       if not center then center = G.P_CENTERS['p_buffoon_normal_1'] end  return center
    end
    
    local card_open = Card.open
    function Card:open()
        if self.ability.set == 'Booster' and G.GAME.modifiers.vanilla_only and self.ability.name:find('Standard') then
            stop_use()
            G.STATE_COMPLETE = false 
            self.opening = true
    
            if not self.config.center.discovered then
                discover_card(self.config.center)
            end
            self.states.hover.can = false
        
            G.STATE = G.STATES.STANDARD_PACK
            G.GAME.pack_size = self.ability.extra
    
            G.GAME.pack_choices = self.config.center.config.choose or 1
    
            if self.cost > 0 then 
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                    inc_career_stat('c_shop_dollars_spent', self.cost)
                    self:juice_up()
                return true end }))
                ease_dollars(-self.cost) 
           else
               delay(0.2)
           end
    
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                self:explode()
                local pack_cards = {}
    
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3*math.sqrt(G.SETTINGS.GAMESPEED), blockable = false, blocking = false, func = function()
                    local _size = self.ability.extra
                    
                    for i = 1, _size do
                        local card = create_card((pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", G.pack_cards, nil, nil, nil, true, nil, 'sta')
                            local edition_rate = 2
                            local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true, nil, {'e_foil','e_holo','e_polychrome'})
                            card:set_edition(edition)
                            local seal_rate = 10
                            local seal_poll = pseudorandom(pseudoseed('stdseal'..G.GAME.round_resets.ante))
                            if seal_poll > 1 - 0.02*seal_rate then
                                local seal_type = pseudorandom(pseudoseed('stdsealtype'..G.GAME.round_resets.ante))
                                if seal_type > 0.75 then card:set_seal('Red')
                                elseif seal_type > 0.5 then card:set_seal('Blue')
                                elseif seal_type > 0.25 then card:set_seal('Gold')
                                else card:set_seal('Purple')
                                end
                            end
                       
                        card.T.x = self.T.x
                        card.T.y = self.T.y
                        card:start_materialize({G.C.WHITE, G.C.WHITE}, nil, 1.5*G.SETTINGS.GAMESPEED)
                        pack_cards[i] = card
                    end
                    return true
                end}))
    
                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 1.3*math.sqrt(G.SETTINGS.GAMESPEED), blockable = false, blocking = false, func = function()
                    if G.pack_cards then 
                        if G.pack_cards and G.pack_cards.VT.y < G.ROOM.T.h then 
                        for k, v in ipairs(pack_cards) do
                            G.pack_cards:emplace(v)
                        end
                        return true
                        end
                    end
                end}))
    
                for i = 1, #G.jokers.cards do
                    G.jokers.cards[i]:calculate_joker({open_booster = true, card = self})
                end
    
                if G.GAME.modifiers.inflation then 
                    G.GAME.inflation = G.GAME.inflation + 1
                    G.E_MANAGER:add_event(Event({func = function()
                      for k, v in pairs(G.I.CARD) do
                          if v.set_cost then v:set_cost() end
                      end
                      return true end }))
                end
    
            return true end }))
        else
            card_open(self)
        end
    end