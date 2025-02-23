local blind = {
	name = 'The Feast',
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Feast',
		text = { '-4 Chips per',
			    '$1 you have',}
	},
    discovered = true,
	boss_colour = HEX('56845B'),
    pos = {x = 0, y = 3}
}

blind.modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
    if G.GAME.dollars > 0 then
        if hand_chips - to_big(G.GAME.dollars * 4) < to_big(1) then
            return mult, 1, true
        else
            return mult, hand_chips - G.GAME.dollars * 4, true
        end 
        G.GAME.blind:wiggle()
    end
end

return blind