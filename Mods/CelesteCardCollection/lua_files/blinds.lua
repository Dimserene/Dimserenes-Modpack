-- region Snow

local snow = SMODS.Blind{
	name = "ccc_The Snow",
	slug = "snow", 
	key = 'snow',
	atlas = 'bl_ccc_blinds',
	pos = {x = 0, y = 0},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('d8d8d8'),
	loc_txt = {
        	['default'] = {
			name = "The Snow",
			text = {
				"All Clubs are",
				"drawn face down"
			}
		}
	}
}

-- Snow, Stone, Crystal and Berry use lovely to keep suits flipped

snow.disable = function(self)
	for i = 1, #G.hand.cards do
		if G.hand.cards[i].facing == 'back' then
			G.hand.cards[i]:flip()
		end
	end
	for k, v in pairs(G.playing_cards) do
		v.ability.wheel_flipped = nil
	end
end

-- endregion Snow

-- region Stone

local stone = SMODS.Blind{
	name = "ccc_The Stone",
	slug = "stone", 
	key = 'stone',
	atlas = 'bl_ccc_blinds',
	pos = {x = 0, y = 1},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('575f7d'),
	loc_txt = {
        	['default'] = {
			name = "The Stone",
			text = {
				"All Spades are",
				"drawn face down"
			}
		}
	}
}

stone.disable = function(self)
	for i = 1, #G.hand.cards do
		if G.hand.cards[i].facing == 'back' then
			G.hand.cards[i]:flip()
		end
	end
	for k, v in pairs(G.playing_cards) do
		v.ability.wheel_flipped = nil
	end
end

-- endregion Stone

-- region Crystal

local crystal = SMODS.Blind{
	name = "ccc_The Crystal",
	slug = "crystal", 
	key = 'crystal',
	atlas = 'bl_ccc_blinds',
	pos = {x = 0, y = 2},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('fd7a30'),
	loc_txt = {
        	['default'] = {
			name = "The Crystal",
			text = {
				"All Diamonds are",
				"drawn face down"
			}
		}
	}
}

crystal.disable = function(self)
	for i = 1, #G.hand.cards do
		if G.hand.cards[i].facing == 'back' then
			G.hand.cards[i]:flip()
		end
	end
	for k, v in pairs(G.playing_cards) do
		v.ability.wheel_flipped = nil
	end
end

-- endregion Crystal

-- region Berry

local berry = SMODS.Blind{
	name = "ccc_The Berry",
	slug = "berry", 
	key = 'berry',
	atlas = 'bl_ccc_blinds',
	pos = {x = 0, y = 3},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 2, max = 10},
	boss_colour = HEX('f3639b'),
	loc_txt = {
        	['default'] = {
			name = "The Berry",
			text = {
				"All Hearts are",
				"drawn face down"
			}
		}
	}
}

berry.disable = function(self)
	for i = 1, #G.hand.cards do
		if G.hand.cards[i].facing == 'back' then
			G.hand.cards[i]:flip()
		end
	end
	for k, v in pairs(G.playing_cards) do
		v.ability.wheel_flipped = nil
	end
end

-- endregion Berry

-- region Fallacy

local fallacy = SMODS.Blind{
	name = "ccc_The Fallacy",
	slug = "fallacy", 
	key = 'fallacy',
	atlas = 'bl_ccc_blinds',
	pos = {x = 0, y = 4},
	dollars = 5, 
	mult = 2, 
	vars = {}, 
	debuff = {},
	discovered = true,
	boss = {min = 3, max = 10},
	boss_colour = HEX('2f4063'),
	loc_txt = {
        	['default'] = {
			name = "The Fallacy",
			text = {
				"Playing cards lose",
				"a rank when played"
			}
		}
	}
}

fallacy.press_play = function(self)
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
        for i = 1, #G.play.cards do
		G.E_MANAGER:add_event(Event({func = function()
			local card = G.play.cards[i]
			local suit_prefix = string.sub(card.base.suit, 1, 1)..'_'
			local rank_suffix = card.base.id == 2 and 14 or math.min(card.base.id-1, 14)
			if rank_suffix < 10 then rank_suffix = tostring(rank_suffix)
			elseif rank_suffix == 10 then rank_suffix = 'T'
			elseif rank_suffix == 11 then rank_suffix = 'J'
			elseif rank_suffix == 12 then rank_suffix = 'Q'
			elseif rank_suffix == 13 then rank_suffix = 'K'
			elseif rank_suffix == 14 then rank_suffix = 'A'
			end
			card:set_base(G.P_CARDS[suit_prefix..rank_suffix])
			card:juice_up()
			play_sound('tarot1')
		return true end }))
		delay(0.23)
        end
        return true end }))
	G.GAME.blind.triggered = true
        return true
end


