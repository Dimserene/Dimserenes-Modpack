local blind = {
	name = 'Light Yang',

	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10, showdown = true },

	loc_txt = {
		name = 'Light Yang',
		text = {'All Hearts and',
				'Diamonds are debuffed'}
	},
	discovered = true,
	boss_colour = HEX('C2C2C6'),
    pos = { x = 0, y = 16 },
}

blind.recalc_debuff = function (self, card, from_blind)
    local card_debuffed = false
    for _, targeted_suit in ipairs({'Hearts', 'Diamonds'}) do
        if card.base.suit == targeted_suit then
            card_debuffed = true
        end
    end
    return card_debuffed
end

return blind