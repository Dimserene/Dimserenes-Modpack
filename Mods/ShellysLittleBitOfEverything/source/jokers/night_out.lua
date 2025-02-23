joker = {
    pos = { x = 1, y = 0 },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Night Out",
        text = {"Played cards with {C:clubs}Club{}",
                "suit randomly give {C:mult}+#1#{} Mult,",
                "{C:chips}+#2#{} Chips, or {C:money}$#3#{}"}
    },
    config = {extra = {mult = 3, chips = 30, dollars = 1}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.dollars } }
end

joker.calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
        -- :get_id tests for the rank of the card. Other than 2-10, Jack is 11, Queen is 12, King is 13, and Ace is 14.
        if context.other_card.base.suit == 'Clubs' then
            -- Specifically returning to context.other_card is fine with multiple values in a single return value, chips/mult are different from chip_mod and mult_mod, and automatically come with a message which plays in order of return.
            local rnd_select = pseudorandom_element({1, 2, 3}, pseudoseed(self.key))
            local multgiven = card.ability.extra.mult
            local chipsgiven = card.ability.extra.chips

            if rnd_select == 1 then
                chipsgiven = 0
            end
            if rnd_select == 2 then
                multgiven = 0
            end
            if rnd_select == 3 then
                multgiven = 0
                chipsgiven = 0
                ease_dollars(card.ability.extra.dollars)
            end

            return {
                chips = chipsgiven,
                mult = multgiven,
                card = context.other_card,
            }
                
        end
    end
end
return joker