local blind = {
	name = 'The Famine',
	boss = { min = 1, max = 10 },
	loc_txt = {
		name = 'The Famine',
		text = { '-1 Mult per',
			    '$4 you have',}
	},
	discovered = true,
	boss_colour = HEX('515151'),
	pos = { x = 0, y = 4 },
}

blind.modify_hand = function (self, cards, poker_hands, text, mult, hand_chips)
    if G.GAME.dollars > 0 then
        if mult - to_big(math.floor(G.GAME.dollars / 4)) < to_big(1) then
            return 1, hand_chips, true
        else
            return mult - math.floor(G.GAME.dollars / 4), hand_chips, true
        end 
        G.GAME.blind:wiggle()
    end
end

return blind