local preview_jokers = DV.SIM.JOKERS

preview_jokers.simulate_fibonacci_golden_ratio = function(joker, context)
    if context.cardarea == G.jokers and context.global then
        preview_jokers.x_mult_if_global(joker, context)
    end
end

preview_jokers.simulate_fibonacci_recurring = function(joker, context)
    if context.cardarea == G.jokers and context.global then
        preview_jokers.add_type_chips(joker, context)
    end
end

preview_jokers.simulate_fibonacci_cynical = function(joker, context)
    if context.cardarea == G.jokers and context.global then
        preview_jokers.add_type_mult(joker, context)
    end
end
