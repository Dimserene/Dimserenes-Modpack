--- STEAMODDED HEADER
--- MOD_NAME: Antonos Stakes
--- MOD_ID: AntonosStake
--- PREFIX: AntonosStake
--- MOD_AUTHOR: [Antonos]
--- MOD_DESCRIPTION: (REQUIRES Talisman) Adds simple stakes that increase ante scaling. Recommended for crazy modpacks. You can change each stake's ante scaling in the AntonosStake.lua
--- BADGE_COLOUR: 00FF00
--- VERSION: 1.0-beta
--- PRIORITY: -1
--- DEPENDENCIES: [Talisman>=2.0.0-beta5]



SMODS.Atlas({
    key = 'A_stakes',
    path = 'A_chips.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'A_morestakes',
    path = 'A_morechips.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'A_crazystakes',
    path = 'A_crazychips.png',
    px = '29',
    py = '29'
})

SMODS.Atlas({
    key = 'stickers',
    path = 'A_stickers.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'morestickers',
    path = 'A_morestickers.png',
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = 'crazystickers',
    path = 'A_crazystickers.png',
    px = 71,
    py = 95
})


SMODS.Stake({
    key = "A_white",
    applied_stakes = {},
    above_stake = 'gold',
    unlocked_stake = "AntonosStake_A_red",
    atlas = 'A_stakes',
    pos = {x = 0, y = 0},
    sticker_pos = {x = 1, y = 0},
    sticker_atlas = 'stickers',
    loc_txt = {
        name = "Increased Ante White Stake",
        text = {
            "Required score scales",
            "faster for each {C:attention}Ante by 12.5%",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    },    

    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
}
)

SMODS.Stake {
    name = "Increased Ante Red Stake",
    key = "A_red",
    above_stake = 'AntonosStake_A_white',
    unlocked_stake = "AntonosStake_A_green",
    applied_stakes = { "AntonosStake_A_white" },
    atlas = 'A_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.RED,
    loc_txt = {
        name = "Increased Ante Red Stake",
        text = {
            "Required score scales",
            "faster for each {C:attention}Ante by 25%",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "Increased Ante Green Stake",
    key = "A_green",
    above_stake = 'AntonosStake_A_red',
    unlocked_stake = "AntonosStake_A_black",
    applied_stakes = { "AntonosStake_A_red" },
    atlas = 'A_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.GREEN,
    loc_txt = {
        name = "Increased Ante Green Stake",
        text = {
            "Required score scales",
            "faster for each {C:attention}Ante by 12.5%",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "Increased Ante Black Stake",
    key = "A_black",
    above_stake = 'AntonosStake_A_green',
    unlocked_stake = "AntonosStake_A_blue",
    applied_stakes = { "AntonosStake_A_green" },
    atlas = 'A_stakes',
    sticker_atlas = 'stickers',
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.BLACK,
    loc_txt = {
        name = "Increased Ante Black Stake",
        text = {
            "Required score scales",
            "faster for each {C:attention}Ante by 25%",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "Increased Ante Gold Stake",
    key = "A_gold",
    above_stake = 'AntonosStake_A_black',
    unlocked_stake = "AntonosStake_A_death",
    applied_stakes = { "AntonosStake_A_black" },
    atlas = 'A_stakes',
    sticker_atlas = 'stickers',
    shiny = true,
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "Increased Ante Gold Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante by 25%",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "Increased Ante Death Stake",
    key = "A_death",
    above_stake = 'AntonosStake_A_gold',
    applied_stakes = { "AntonosStake_A_gold" },
    atlas = 'A_stakes',
    sticker_atlas = 'stickers',
    shiny = false,
    pos = { x = 4, y = 1 },
    sticker_pos = { x = 4, y = 1 },
    modifiers = function()
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 4
    end,
    colour = G.C.WHITE,
    loc_txt = {
    name = "Increased Ante Death Stake",
    text = {
        "Required score scales",
        "faster for each {C:attention}Ante by 50%",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

---------------------------------------------------------------------------------------------------------------------------------------------------------------

SMODS.Stake({
    key = "A_morewhite",
    applied_stakes = {},
    above_stake = 'gold',
    unlocked_stake = "AntonosStake_A_morered",
    atlas = 'A_morestakes',
    pos = {x = 0, y = 0},
    sticker_pos = {x = 1, y = 0},
    sticker_atlas = 'morestickers',
    loc_txt = {
        name = "More Ante White Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    },    

    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
    end,
}
)

SMODS.Stake {
    name = "More Ante Red Stake",
    key = "A_morered",
    above_stake = 'AntonosStake_A_morewhite',
    unlocked_stake = "AntonosStake_A_moregreen",
    applied_stakes = { "AntonosStake_A_morewhite" },
    atlas = 'A_morestakes',
    sticker_atlas = 'morestickers',
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
    end,
    colour = G.C.RED,
    loc_txt = {
        name = "More Ante Red Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "More Ante Green Stake",
    key = "A_moregreen",
    above_stake = 'AntonosStake_A_morered',
    unlocked_stake = "AntonosStake_A_moreblack",
    applied_stakes = { "AntonosStake_A_morered" },
    atlas = 'A_morestakes',
    sticker_atlas = 'morestickers',
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
    end,
    colour = G.C.GREEN,
    loc_txt = {
        name = "More Ante Green Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "More Ante Black Stake",
    key = "A_moreblack",
    above_stake = 'AntonosStake_A_moregreen',
    unlocked_stake = "AntonosStake_A_moreblue",
    applied_stakes = { "AntonosStake_A_moregreen" },
    atlas = 'A_morestakes',
    sticker_atlas = 'morestickers',
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
    end,
    colour = G.C.BLACK,
    loc_txt = {
        name = "More Ante Black Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "{s:0.8,C:inactive}(Vanilla Disabled){}",
        }
    }
}

SMODS.Stake {
    name = "More Ante Gold Stake",
    key = "A_moregold",
    above_stake = 'AntonosStake_A_moreblack',
    unlocked_stake = "AntonosStake_A_moredeath",
    applied_stakes = { "AntonosStake_A_moreblack" },
    atlas = 'A_morestakes',
    sticker_atlas = 'morestickers',
    shiny = true,
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "More Ante Gold Stake",
    text = {
        "Increases the ante",
        "required to win the game by 2",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

SMODS.Stake {
    name = "More Ante Death Stake",
    key = "A_moredeath",
    above_stake = 'AntonosStake_A_moregold',
    applied_stakes = { "AntonosStake_A_moregold" },
    atlas = 'A_morestakes',
    sticker_atlas = 'morestickers',
    shiny = false,
    pos = { x = 4, y = 1 },
    sticker_pos = { x = 4, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 3
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "More Ante Death Stake",
    text = {
        "Increases the ante",
        "required to win the game by 3",
        "{s:0.8,C:inactive}(Vanilla Disabled){}",
    }
}
}

---------------------------------------------------------------------------------------------------------------------

SMODS.Stake({
    key = "A_crazywhite",
    applied_stakes = {},
    above_stake = 'gold',
    unlocked_stake = "AntonosStake_A_crazyred",
    atlas = 'A_crazystakes',
    pos = {x = 0, y = 0},
    sticker_pos = {x = 1, y = 0},
    sticker_atlas = 'crazystickers',
    loc_txt = {
        name = "Crazy White Stake",
        text = {
            "Increases the ante",
            "required to win the game by 1",
            "Required score scales",
            "faster for each {C:attention}Ante by 12.5%",
        }
    },    

    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 1
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
}
)

SMODS.Stake {
    name = "Crazy Red Stake",
    key = "A_crazyred",
    above_stake = 'AntonosStake_A_crazywhite',
    unlocked_stake = "AntonosStake_A_crazygreen",
    applied_stakes = { "AntonosStake_A_crazywhite" },
    atlas = 'A_crazystakes',
    sticker_atlas = 'crazystickers',
    pos = { x = 1, y = 0 },
    sticker_pos = { x = 2, y = 0 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 1
    end,
    colour = G.C.RED,
    loc_txt = {
        name = "Crazy Red Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "Required score scales",
            "faster for each {C:attention}Ante by 12.5%",
        }
    }
}

SMODS.Stake {
    name = "Crazy Green Stake",
    key = "A_crazygreen",
    above_stake = 'AntonosStake_A_crazyred',
    unlocked_stake = "AntonosStake_A_crazyblack",
    applied_stakes = { "AntonosStake_A_crazyred" },
    atlas = 'A_crazystakes',
    sticker_atlas = 'crazystickers',
    pos = { x = 2, y = 0 },
    sticker_pos = { x = 3, y = 0 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.GREEN,
    loc_txt = {
        name = "Crazy Green Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "Required score scales",
            "faster for each {C:attention}Ante by 25%",
        }
    }
}

SMODS.Stake {
    name = "Crazy Black Stake",
    key = "A_crazyblack",
    above_stake = 'AntonosStake_A_crazygreen',
    unlocked_stake = "AntonosStake_A_crazyblue",
    applied_stakes = { "AntonosStake_A_crazygreen" },
    atlas = 'A_crazystakes',
    sticker_atlas = 'crazystickers',
    pos = { x = 4, y = 0 },
    sticker_pos = { x = 0, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.BLACK,
    loc_txt = {
        name = "Crazy Black Stake",
        text = {
            "Increases the ante",
            "required to win the game by 2",
            "Required score scales",
            "faster for each {C:attention}Ante by 25%",
        }
    }
}

SMODS.Stake {
    name = "Crazy Gold Stake",
    key = "A_crazygold",
    above_stake = 'AntonosStake_A_crazyblack',
    unlocked_stake = "AntonosStake_A_crazydeath",
    applied_stakes = { "AntonosStake_A_crazyblack" },
    atlas = 'A_crazystakes',
    sticker_atlas = 'crazystickers',
    shiny = true,
    pos = { x = 2, y = 1 },
    sticker_pos = { x = 3, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 2
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 2
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "Crazy Gold Stake",
    text = {
        "Increases the ante",
        "required to win the game by 2",
        "Required score scales",
        "faster for each {C:attention}Ante by 25%",
    }
}
}

SMODS.Stake {
    name = "Crazy Death Stake",
    key = "A_crazydeath",
    above_stake = 'AntonosStake_A_crazygold',
    applied_stakes = { "AntonosStake_A_crazygold" },
    atlas = 'A_crazystakes',
    sticker_atlas = 'crazystickers',
    shiny = false,
    pos = { x = 4, y = 1 },
    sticker_pos = { x = 4, y = 1 },
    modifiers = function()
        G.GAME.win_ante = (G.GAME.win_ante or 1) + 3
        G.GAME.modifiers.scaling = (G.GAME.modifiers.scaling or 1) + 4
    end,
    colour = G.C.GOLD,
    loc_txt = {
    name = "Crazy Death Stake",
    text = {
        "Increases the ante",
        "required to win the game by 3",
        "Required score scales",
        "faster for each {C:attention}Ante by 50%",
    }
}
}
