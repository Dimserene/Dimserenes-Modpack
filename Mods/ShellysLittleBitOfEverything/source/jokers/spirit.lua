joker = {
    pos = { x = 5, y = 0 },
    rarity = 3,
    cost = 7,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    loc_txt = {
        name = "Spirit",
        text = {"When a {C:clubs}Clubs{} Flush is played,",
                "{C:green}#2#{} in {C:green}#1#{} chance to create",
                "a random {C:spectral}Spectral{} card, otherwise",
                "create a random {C:tarot}Tarot{} card"}
    },
    config = {extra = {rand_spirit = 3}}
}

joker.loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.rand_spirit, G.GAME.probabilities.normal} }
end

joker.calculate = function(self, card, context)
    if context.before and next(context.poker_hands['Flush']) then

        local all_clubs = true
        for _, i in ipairs(G.play.cards) do
            if i.base.suit ~= 'Clubs' then
                all_clubs = false
            end
        end

        if all_clubs then 
            if pseudorandom(self.key) < G.GAME.probabilities.normal/self.config.extra.rand_spirit then
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Spectral',G.consumeables, nil, nil, nil, nil, nil, 'sixth')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_spectral'), colour = G.C.SECONDARY_SET.Spectral})
                end
            else
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = (function()
                                local card = create_card('Tarot',G.consumeables, nil, nil, nil, nil, nil, 'vag')
                                card:add_to_deck()
                                G.consumeables:emplace(card)
                                G.GAME.consumeable_buffer = 0
                            return true
                        end)}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_tarot'), colour = G.C.SECONDARY_SET.Tarot})
                end
            end
        end
	end
end

return joker