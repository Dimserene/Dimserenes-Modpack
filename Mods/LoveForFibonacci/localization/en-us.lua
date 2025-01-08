return {
    misc = {
        dictionary = {
            k_moon = "Moon"
        },
        poker_hands = {
            fibonacci_Fibonacci = "Fibonacci",
            fibonacci_Flushonacci = "Flushonacci"
        },
        poker_hand_descriptions = {
            fibonacci_Fibonacci = { "Fibonacci Sequence" },
            fibonacci_Flushonacci = {
                "Fibonacci Sequence of the",
                "same suit"
            }
        },
        challenge_names = {
            c_fibonacci_inner_spiral = "The Inner Spiral"
        }
    },
    descriptions = {
        Planet = {
            c_fibonacci_phobos = {
                name = "Phobos",
                text = {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                }
            },
            c_fibonacci_deimos = {
                name = "Deimos",
                text = {
                    "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                    "{C:attention}#2#",
                    "{C:mult}+#3#{} Mult and",
                    "{C:chips}+#4#{} chips",
                }
            }
        },
        Joker = {
            j_fibonacci_golden_ratio = {
                name = "The Golden Ratio",
                text = {
                    "{X:mult,C:white}X3# {} Mult if played hand",
                    "contains a {C:attention}Fibonnaci{}."
                },
                unlock = {
                    "Win a run",
                    "without playing",
                    "a {C:attention}Fibonacci{}."
                }
            },
            j_fibonacci_spiral_clock = {
                name = "Spiral Clock",
                text = {
                    "All {C:attention}Fibonaccis{} can be",
                    "made with 3 or 4 cards"
                }
            },
            j_fibonacci_recurring = {
                name = "Recurring Joker",
                text = {
                    "{C:chips}+144{} chips if played hand",
                    "contains a {C:attention}Fibonacci{}."
                }
            },
            j_fibonacci_cynical = {
                name = "Cynical Joker",
                text = {
                    "{C:mult}+13{} mult if played hand",
                    "contains a {C:attention}Fibonacci{}."
                }
            }
        }
    }
}
