--i think steamodded needs a patch for retriggers to work so this is unused for now

local enhancement = {
    name = "Sewn Card",
    pos = { x = 2, y = 0 },
    loc_txt = {
        name = "Sewn Card",
		text = {
            "{C:green}Retrigger{} once per",
            "other {C:enhanced}Sewn Card{}",
            "in {C:blue}played{} hand",
            "{C:inactive,s:0.8}(Art by {}{C:dark_edition,s:0.9}@ricottakitten{}{C:inactive,s:0.8}){}"
            
		},
    },

    config = {retriggers = 0}
}

enhancement.calculate = function(self, card, context, effect)

    local other_cards_sewn = -1
    for _, card in ipairs(G.play.cards) do
        if card.ability.name == 'Sewn Card' then
            other_cards_sewn = other_cards_sewn + 1
        end
    end

    if other_cards_sewn > 0 then
        enhancement.config.retriggers = other_cards_sewn
    end
end

return enhancement