local blind = {
	name = 'Dark Yin',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10, showdown = true },

	loc_txt = {
		name = 'Dark Yin',
		text = {'All Spades and',
				'Clubs are debuffed'}
	},
	discovered = true,
	boss_colour = HEX('2F3036'),
    pos = { x = 0, y = 15 },
}

blind.recalc_debuff = function (self, card, from_blind)
    local card_debuffed = false
    for _, targeted_suit in ipairs({'Spades', 'Clubs'}) do
        if card.base.suit == targeted_suit then
            card_debuffed = true
        end
    end
    return card_debuffed
end

return blind