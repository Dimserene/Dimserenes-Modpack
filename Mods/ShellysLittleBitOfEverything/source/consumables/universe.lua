local consumable = {
    set = "Tarot",
    pos = {x = 0, y = 0},
    loc_txt = {
        name = "The Universe",
        text = {"Enhances {C:attention}#1#{}",
                "selected cards",
                "into {C:planet}Spatial Cards{}"}
    },
    config = { extra = {cards = 3}}
}

consumable.loc_vars = function(self, info_queue, card)
    return { vars = { self.config.extra.cards } }
end

consumable.can_use = function(self, card)
    if G and G.hand then
        if #G.hand.highlighted ~= 0 and #G.hand.highlighted <= self.config.extra.cards then
            return true
        end
    end
    return false
end

consumable.use = function(self, card, area, copier)

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
    return true end }))
    
    for i = 1, #G.hand.highlighted do
        local card_selected = G.hand.highlighted[i]
        local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()

            

            card_selected:flip()
            play_sound('card1', percent)
            card_selected:juice_up(0.3, 0.3);

            return true end }))

            card_selected:set_ability(G.P_CENTERS.m_slbe_spatial, nil, true)
    end

    for i = 1, #G.hand.highlighted do
        local card_selected = G.hand.highlighted[i]
        local percent = 0.8 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3

        G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()


            card_selected:flip()
            play_sound('tarot2', percent)
            card_selected:juice_up(0.3, 0.3)

            G.hand:remove_from_highlighted(card_selected)
            return true end }))

    end
end

return consumable