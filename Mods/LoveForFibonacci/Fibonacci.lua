--- STEAMODDED HEADER
--- MOD_NAME: Fibonacci
--- MOD_ID: fibonacci
--- MOD_AUTHOR: [Surrealreal_]
--- MOD_DESCRIPTION: Adds Fibonacci hands
--- VERSION: 1.1.0
--- PREFIX: fibonacci

--- HELPER FUNCS ---
local get_smallfib = function(hand)
    if (#hand < 3) then
        return {}
    end

    local ret = {}
    local t = {}
    local count = 0
    local fib = {false, false, false, false, false}

    for i=1, #hand do
        if (hand[i].base.value == 'Ace') and (fib[1] == false) then
            table.insert(t, hand[i])
            count = count + 1
            fib[1] = true
        elseif (hand[i].base.value == '8') and (fib[2] == false) then
            table.insert(t, hand[i])
            count = count + 1
            fib[2] = true
        elseif (hand[i].base.value == '5') and (fib[3] == false) then
            table.insert(t, hand[i])
            count = count + 1
            fib[3] = true
        elseif (hand[i].base.value == '3') and (fib[4] == false) then
            table.insert(t, hand[i])
            count = count + 1
            fib[4] = true
        elseif (hand[i].base.value == '2') and (fib[5] == false) then
            table.insert(t, hand[i])
            count = count + 1
            fib[5] = true
        end
    end

    if (count < 3) then
        return {}
    end

    table.insert(ret, t)
    return ret
end

--- HANDS ---
local fibonacci_mult = function(n)
    local memo_mult = {3, 5}
    local solve_mult = function(n)
        if n <= #memo_mult then
            return memo_mult[n]
        end
        local result = solve_mult(n-2) + solve_mult(n-1)
        memo_mult[n] = result
        return result
    end
    return solve_mult(n)
end

local fibonacci_chips = function(n)
    local memo_chips = {34, 55}
    local solve_chips = function(n)
        if n <= #memo_chips then
            return memo_chips[n]
        end
        local result = solve_chips(n-2) + solve_chips(n-1)
        memo_chips[n] = result
        return result
    end
    return solve_chips(n)
end

local flushonacci_mult = function(n)
    local memo_mult = {5, 8}
    local solve_mult = function(n)
        if n <= #memo_mult then
            return memo_mult[n]
        end
        local result = solve_mult(n-2) + solve_mult(n-1)
        memo_mult[n] = result
        return result
    end
    return solve_mult(n)
end

local flushonacci_chips = function(n)
    local memo_chips = {55, 89}
    local solve_chips = function(n)
        if n <= #memo_chips then
            return memo_chips[n]
        end
        local result = solve_chips(n-2) + solve_chips(n-1)
        memo_chips[n] = result
        return result
    end
    return solve_chips(n)
end

SMODS.PokerHandPart {
    key = 'hand',
    func = function(hand)
        local spiral_clock = next(SMODS.find_card('j_fibonacci_spiral_clock'))

        if spiral_clock then
            local smallhand = get_smallfib(hand)
            if #smallhand > 0 then
                return smallhand
            end
            return {}
        end

        if (#hand < 5) then
            return {}
        end

        local fib = {false, false, false, false, false}

        for i=1, #hand do
            if (hand[i].base.value == 'Ace') then
                if (fib[1] == true) then
                    return {}
                end
                fib[1] = true
            elseif (hand[i].base.value == '8') then
                if (fib[2] == true) then
                    return {}
                end
                fib[2] = true
            elseif (hand[i].base.value == '5') then
                if (fib[3] == true) then
                    return {}
                end
                fib[3] = true
            elseif (hand[i].base.value == '3') then
                if (fib[4] == true) then
                    return {}
                end
                fib[4] = true
            elseif (hand[i].base.value == '2') then
                if (fib[5] == true) then
                    return {}
                end
                fib[5] = true
            end
        end

        for i=1, #fib do
            if (fib[i] == false) then
                return {}
            end
        end

        return { hand }
    end
}

local fibonacci_hand = SMODS.PokerHand {
    key = 'Fibonacci',
    mult = 5,
    chips = 55,
    l_mult = fibonacci_mult(1),
    l_chips = fibonacci_chips(1),
    example = {
        {'H_A', true},
        {'S_8', true},
        {'D_5', true},
        {'C_3', true},
        {'S_2', true}
    },
    evaluate = function(parts)
        return parts.fibonacci_hand
    end
}

local flushonacci_hand = SMODS.PokerHand {
    key = 'Flushonacci',
    mult = 8,
    chips = 89,
    l_mult = flushonacci_mult(1),
    l_chips = flushonacci_chips(1),
    example = {
        {'H_A', true},
        {'H_8', true},
        {'H_5', true},
        {'H_3', true},
        {'H_2', true}
    },
    evaluate = function(parts)
        if not next(parts.fibonacci_hand) or not next(parts._flush) then return {} end
        return { SMODS.merge_lists(parts.fibonacci_hand, parts._flush) }
    end
}

--- PLANETS ---
SMODS.Atlas {
    key = 'planets',
    path = 'Planets.png',
    px = 71,
    py = 95
}

local moon = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_moon'), get_type_colour(self or card.config, card), nil, 1.2)
end

SMODS.Consumable {
    set = 'Planet',
    key = 'phobos',
    config = { hand_type = fibonacci_hand.key },
    pos = { x = 0, y = 0 },
    atlas = 'fibonacci_planets',
    set_card_type_badge = moon,
    generate_ui = 0
    --- use = function(self, card, area, copier)
    ---     self.level_mult = fibonacci_mult(self.level)
    ---     self.level_chips = fibonacci_chips(self.level)
    --- end
}

SMODS.Consumable {
    set = 'Planet',
    key = 'deimos',
    config = { hand_type = flushonacci_hand.key },
    pos = { x = 1, y = 0 },
    atlas = 'fibonacci_planets',
    set_card_type_badge = moon,
    generate_ui = 0
    --- use = function(self, card, area, copier)
    ---     self.level_mult = flushonacci_mult(self.level)
    ---     self.level_chips = flushonacci_chips(self.level)
    --- end
}

--- JOKERS ---

SMODS.Atlas {
    key = 'jokers',
    path = 'fibjokers.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'golden_ratio',
    effect = 'X3 Mult',
    config = {
        Xmult = 3,
        type = fibonacci_hand.key
    },
    atlas = 'fibonacci_jokers',
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 8,
    unlocked = false,
    blueprint_compat = true,
    unlock_condition = {
        type = 'win_no_hand',
        extra = fibonacci_hand.key
    },
}

SMODS.Joker {
    key = 'spiral_clock',
    config = {
        extra = {
            odds = 7,
            times = 1
        }
    },
    atlas = 'fibonacci_jokers',
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 6
}

SMODS.Joker {
    key = 'recurring',
    config = {
        t_chips = 144,
        type = fibonacci_hand.key
    },
    atlas = 'fibonacci_jokers',
    pos = { x = 2, y = 0 },
    cost = 4,
    blueprint_compat = true
}

--- JokerDisplay mod support
if JokerDisplay then
    SMODS.load_file('JokerDisplay_integration.lua')()
end

--- Score Preview mod support
if DV and DV.SIM then
    SMODS.load_file('ScorePreview_integration.lua')()
end

SMODS.Joker {
    key = 'cynical',
    config = {
        t_mult = 13,
        type = fibonacci_hand.key
    },
    atlas = 'fibonacci_jokers',
    pos = { x = 3, y = 0 },
    cost = 4,
    blueprint_compat = true
}

SMODS.Challenge {
    key = 'inner_spiral',
    jokers = {
        {id = 'j_fibonacci_golden_ratio'},
        {id = 'j_fibonacci_spiral_clock'},
        {id = 'j_fibonacci_recurring'},
        {id = 'j_fibonacci_cynical'}
    },
    deck = {
        cards = {
            {s = 'C', r = 'A'},
            {s = 'C', r = 'A'},
            {s = 'C', r = '8'},
            {s = 'C', r = '8'},
            {s = 'C', r = '5'},
            {s = 'C', r = '5'},
            {s = 'C', r = '3'},
            {s = 'C', r = '3'},
            {s = 'C', r = '2'},
            {s = 'C', r = '2'},
            {s = 'S', r = 'A'},
            {s = 'S', r = 'A'},
            {s = 'S', r = '8'},
            {s = 'S', r = '8'},
            {s = 'S', r = '5'},
            {s = 'S', r = '5'},
            {s = 'S', r = '3'},
            {s = 'S', r = '3'},
            {s = 'S', r = '2'},
            {s = 'S', r = '2'},
            {s = 'D', r = 'A'},
            {s = 'D', r = 'A'},
            {s = 'D', r = '8'},
            {s = 'D', r = '8'},
            {s = 'D', r = '5'},
            {s = 'D', r = '5'},
            {s = 'D', r = '3'},
            {s = 'D', r = '3'},
            {s = 'D', r = '2'},
            {s = 'D', r = '2'},
            {s = 'H', r = 'A'},
            {s = 'H', r = 'A'},
            {s = 'H', r = '8'},
            {s = 'H', r = '8'},
            {s = 'H', r = '5'},
            {s = 'H', r = '5'},
            {s = 'H', r = '3'},
            {s = 'H', r = '3'},
            {s = 'H', r = '2'},
            {s = 'H', r = '2'}
        }
    },
    restrictions = {
        banned_cards = {
            {id = 'j_jolly'},
            {id = 'j_zany'},
            {id = 'j_mad'},
            {id = 'j_crazy'},
            {id = 'j_sly'},
            {id = 'j_wily'},
            {id = 'j_clever'},
            {id = 'j_devious'},
            {id = 'j_hack'},
            {id = 'j_runner'},
            {id = 'j_splash'},
            {id = 'j_sixth_sense'},
            {id = 'j_superposition'},
            {id = 'j_seance'},
            {id = 'j_shortcut'},
            {id = 'j_obelisk'},
            {id = 'j_cloud_9'},
            {id = 'j_trousers'},
            {id = 'j_flower_pot'},
            {id = 'j_wee'},
            {id = 'j_duo'},
            {id = 'j_trio'},
            {id = 'j_family'},
            {id = 'j_order'},
            {id = 'j_8_ball'},
            {id = 'c_pluto'},
            {id = 'c_mercury'},
            {id = 'c_venus'},
            {id = 'c_earth'},
            {id = 'c_mars'},
            {id = 'c_jupiter'},
            {id = 'c_saturn'},
            {id = 'c_uranus'},
            {id = 'c_neptune'},
            {id = 'c_pluto'},
            {id = 'c_planet_x'},
            {id = 'c_ceres'},
            {id = 'c_eris'},
            {id = 'c_high_priestess'},
            {id = 'v_telescope'},
            {
                id = 'p_celestial_normal_2',
                ids = {
                    'p_celestial_normal_1',
                    'p_celestial_normal_2',
                    'p_celestial_normal_3',
                    'p_celestial_normal_4',
                    'p_celestial_jumbo_1',
                    'p_celestial_jumbo_2',
                    'p_celestial_mega_1',
                    'p_celestial_mega_2'
                }
            }
        },
        banned_tags = {
            {id = 'tag_meteor'}
        },
        banned_other = {
            {id = 'bl_psychic', type = 'blind'},
            {id = 'bl_eye', type = 'blind'},
            {id = 'bl_ox', type = 'blind'}
        }
    }
}
