local enhancement = {
    loc_txt = {
        name = "Cosmic Card",
		text = {
            "{C:green}#2# in #1#{} chance to",
            "{C:planet}upgrade{} random hand",
            "and gain {C:chips}+#3#{} chips"
		},
    },
    config = {rand_planet_odds = 3, chip_gain = 12}
}

enhancement.loc_vars = function(self, info_queue, card)
    return { vars = { self.config.rand_planet_odds, G.GAME.probabilities.normal, self.config.chip_gain, card.ability.perma_bonus} }
end

enhancement.calculate = function(self, card, context, effect)
    if context.cardarea == G.play and not context.repetition then

        --from JenLib
        local hand_chosen = jl.rndhand(false, seed, false)

        if pseudorandom(self.key) < G.GAME.probabilities.normal/self.config.rand_planet_odds then
            local init_chips = G.GAME.last_hand_played.game_chips

            --this is a load of stuff i don't entirely get
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                card.ability.perma_bonus = card.ability.perma_bonus or 0
                card.ability.perma_bonus = card.ability.perma_bonus + self.config.chip_gain
                card:juice_up(0.8, 0.5)

                attention_text({
					scale = 1,
					text = 'Upgraded!',
					hold = 2,
					align = 'cm',
					offset = { x = 0, y = -2.7 },
                    major = G
                    .play
				})

                if math.random(1,2) == 1 then
				    play_sound('sdoc_blip', 1, 0.75)
                else
                    play_sound('sdoc_blip2', 1, 0.75)
                end
                return true end }))

            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=hand_chosen,chips = G.GAME.hands[hand_chosen].chips, mult = G.GAME.hands[hand_chosen].mult, level='+1'})

            level_up_hand(self, hand_chosen, true)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                G.TAROT_INTERRUPT_PULSE = true
                card:juice_up(0.8, 0.5)
                return true end }))

            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {chips = G.GAME.hands[hand_chosen].chips, StatusText = true})

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end }))

            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {mult = G.GAME.hands[hand_chosen].mult, StatusText = true})

            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                G.TAROT_INTERRUPT_PULSE = nil
                card:juice_up(0.8, 0.5)
                return true end }))
                
            update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=G.GAME.last_hand_played,chips = init_chips, mult =  G.GAME.hands[G.GAME.last_hand_played].mult, level=G.GAME.hands[G.GAME.last_hand_played].level})
            
            --sendInfoMessage("Cosmic roll succeeded", "Shellular's Deck of Cards")
        --else
            --sendInfoMessage("Cosmic roll failed", "Shellular's Deck of Cards")
        end
    end
end

return enhancement