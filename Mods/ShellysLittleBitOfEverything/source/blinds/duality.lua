local blind = {
	name = 'The Duality',
	dollars = 5,
	mult = 2,
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Duality',
		text = { 'All cards of odd',
			    'ranks are debuffed',}
	},
    pos = {x = 0, y = 2},
    boss_colour = HEX('56B089'),
}

blind.recalc_debuff = function (self, card, from_blind)
    local card_debuffed = false
    for _, rank in ipairs({'Ace', '3', '5', '7', '9'}) do
        if card.base.value == rank then
            card_debuffed = true
        end
    end
    return card_debuffed
end

return blind