------------------------------
-- JokerDisplay Integration --
------------------------------

local jd_def = JokerDisplay.Definitions

jd_def['j_beast'] = { -- Beastly Joker
    text = {
        { text = '+' },
        { ref_table = "card.ability.extra", ref_value = "current_chips" },
    },
    text_config = { colour = G.C.CHIPS },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active", colour = G.C.UI.TEXT_INACTIVE },
        { text = ")" }
    },
    calc_function = function(card)
        local is_trading_card_discard = G.GAME and G.GAME.current_round.discards_used == 0 and
            G.GAME.current_round.discards_left > 0 and #G.hand.highlighted == 1
        card.joker_display_values.active = is_trading_card_discard and localize("k_active_ex") or "Inactive"
    end,
}

jd_def['j_deathly'] = { -- Deathly Joker
    text = {
        { text = '+' },
        { ref_table = "card.ability.extra", ref_value = "current_chips" },
    },
    text_config = { colour = G.C.CHIPS },
}

jd_def['j_techno'] = { -- Techno Joker
    text = {
        { text = '+' },
        { ref_table = "card.ability", ref_value = "mult" },
    },
    text_config = { colour = G.C.MULT },
}

jd_def['j_magickal'] = { -- Magickal Joker
    text = {
        { text = '+' },
        { ref_table = "card.ability", ref_value = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { text = "All Suits", colour = G.C.ORANGE },
        { text = ")" }
    },
}

jd_def['j_mycologist'] = { -- Mycologists
    text = {
        { text = '+' },
        { ref_table = "card.joker_display_values", ref_value = "mult" },
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = '(' },
        { ref_table = "card.joker_display_values", ref_value = "localized_text_pair", colour = G.C.ORANGE },
        { text = '/' },
        { ref_table = "card.joker_display_values", ref_value = "localized_text_two_pair", colour = G.C.ORANGE },
        { text = ')' },
    },
    calc_function = function(card)
        local mult = 0
        local mycologist_hand = false
        local hand = next(G.play.cards) and G.play.cards or G.hand.highlighted
        local text, poker_hands, scoring_hand = JokerDisplay.evaluate_hand(hand)
        if poker_hands["Pair"] and next(poker_hands["Pair"]) or
            poker_hands["Two Pair"] and next(poker_hands["Two Pair"]) then
            mycologist_hand = true
        end
        if mycologist_hand then
            for k, v in pairs(scoring_hand) do
                mult = mult +
                    (v.base and v.base.nominal or 0) *
                    JokerDisplay.calculate_card_triggers(v, not (text == 'Unknown') and scoring_hand or nil)
            end
        end
        card.joker_display_values.mult = mult
        card.joker_display_values.localized_text_pair = localize("Pair", 'poker_hands')
        card.joker_display_values.localized_text_two_pair = localize("Two Pair", 'poker_hands')
    end
}
