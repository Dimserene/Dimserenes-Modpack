--- STEAMODDED HEADER
--- MOD_NAME: Art of the Deal
--- MOD_ID: AotD
--- MOD_AUTHOR: [The Dealer]
--- MOD_DESCRIPTION: A variety of jokers and such made by the Dealer's hyperfixation
--- PREFIX: deal

------------
---JOKERS---
------------

---Notes:
---All jokers will use the first five letters of their name as their key

SMODS.Atlas
{
	key = 'Jokers',
	path = 'Jokers.png',
	px = 71,
	py = 95
}

--Atraxia--

--For every consecutive round without buying something gain .5x mult--
SMODS.Joker
{
	key = 'atrax',
	loc_txt = 
	{
		name = 'Atraxia',
		text = 
		{
			'For every consecutive round without',
			'buying something at the {C:attention}Shop{},',
			'gain {X:mult,C:white}X0.5{} Mult.',
			'{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}'
		}
	},
	atlas = 'Jokers',
	pos = {x = 0, y = 0},
	rarity = 3,
	cost = 7,
	config = 
	{ 
		extra = 
		{
			Xmult = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return {vars = {center.ability.extra.Xmult}}
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return
			{
				card = card,
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
		
		if context.buying_card and not context.blueprint then
			card.ability.extra.Xmult=1
			return
			{
				message = 'Reset!',
				colour = G.C.MULT
			}
		end
		
		if context.end_of_round and not context.repetition and not context.individual and not context.blueprint then
			card.ability.extra.Xmult=card.ability.extra.Xmult+0.5 
			return
			{
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
	end
}

---Bootleg Legendaries---

--Bootleg Perkeo--
SMODS.Joker
{
	key = 'perky',
	loc_txt = 
	{
		name = 'Perky Joker',
		text = 
		{
			'{C:green}#1# in #2#{} chance to create a {C:purple}Fool{} card',
			'at the end of the {C:attention}Shop{}',
			'{C:inactive,s:0.8}Art and original concept by{}',
			'{X:chips,C:white,s:0.8}Kitty{}{C:inactive,s:0.8} on the discord!{}'
		}
	},
	config =
	{
		extra =
		{
			odds = 2
		}
	},
	loc_vars = function(self,info_queue,center)
		table.insert(info_queue, G.P_CENTERS.c_fool)
		return {vars = {G.GAME.probabilities.normal, center.ability.extra.odds}}
	end,
	atlas = 'Jokers',
	pos = {x = 4, y = 1},
	cost = 4,
	calculate = function(self,card,context)
		if context.ending_shop and pseudorandom('insertanysubseedhere') < G.GAME.probabilities.normal / 2 and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			local _card = create_card(nil, G.consumeables, nil, nil, nil, nil, 'c_fool', 'randomassseed')
			G.consumeables:emplace(_card)
		end
	end
}

--Bootleg Trib--
SMODS.Joker
{
	key = 'trick',
	loc_txt = 
	{
		name = 'Tricky Joker',
		text = 
		{
			'{C:attention}Kings{} and {C:attention}Queens{} played this hand',
			'adds {X:mult,C:white}X0.2{} to {C:attention}Joker{}',
			'{C:inactive}(Currently {}{X:mult,C:white}X#1#{}{C:inactive} Mult){}',
			'{C:inactive,s:0.8}Art and original concept by{}',
			'{X:chips,C:white,s:0.8}Kitty{}{C:inactive,s:0.8} on the discord!{}'
		}
	},
	atlas = 'Jokers',
	pos = {x = 1, y = 1},
	cost = 6,
	config =
	{
		extra =
		{
			Xmult = 1
		}
	},
	loc_vars = function(self,info_queue,center)
		return {vars = {center.ability.extra.Xmult}}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) and not context.blueprint then
			card.ability.extra.Xmult=card.ability.extra.Xmult+0.2
			return
			{
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
		
		if context.joker_main then
			return
			{
				card = card,
				Xmult_mod = card.ability.extra.Xmult,
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
		
		if context.after and not context.blueprint then
			card.ability.extra.Xmult = 1
		end
	end
}

--Bootleg Canio--
SMODS.Joker
{
	key = 'canny',
	loc_txt = 
	{
		name = 'Canny Joker',
		text = 
		{
			'Each discarded {C:attention}face{} card',
			'gives {C:attention}$1{}',
			'{C:inactive,s:0.8}Art and original concept by{}',
			'{X:chips,C:white,s:0.8}Kitty{}{C:inactive,s:0.8} on the discord!{}'
		}
	},
	config =
	{
		extra =
		{
			dollars = 1
		}
	},
	cost = 6,
	atlas = 'Jokers',
	pos = {x = 0, y = 1},
	calculate = function(self,card,context)
		if context.discard and context.other_card:is_face(true) and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			if context.other_card.debuff then
                return {
                    message = 'Fuck you',
                    colour = G.C.RED,
                    card = card,
                }
			else
				ease_dollars(card.ability.extra.dollars)
				card_eval_status_text(card, 'extra', nil, nil, nil, {message = '$'..card.ability.extra.dollars, colour = G.C.GOLD})
				return
				{
					delay = .2
				}
			end
		end
	end
}

--Bootleg Yorick--
SMODS.Joker
{
	key = 'yello',
	loc_txt = 
	{
		name = 'Yellow Joker',
		text = 
		{
			'{C:mult}+1{} Mult per {C:attention}card{} discarded this round',
			'{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} Mult){}',
			'{C:inactive,s:0.8}Art and original concept by{}',
			'{X:chips,C:white,s:0.8}Kitty{}{C:inactive,s:0.8} on the discord!{}'
		}
	},
	atlas = 'Jokers',
	pos = {x = 2, y = 1},
	config = 
	{ 
		extra = 
		{
			mult = 0
		}
	},
	cost = 5,
	loc_vars = function(self,info_queue,center)
		return {vars = {center.ability.extra.mult}}
	end,
	calculate = function(self,card,context)
		if context.discard and not context.blueprint then
			card.ability.extra.mult=card.ability.extra.mult+1 
			return
			{
				message = '+1',
				colour = G.C.MULT,
				delay = 0.15
			}
		end
		
		if context.joker_main then
			return
			{
				card = card,
				mult_mod = card.ability.extra.mult,
				message = '+' .. card.ability.extra.mult,
				colour = G.C.MULT
			}
		end
		
		if context.end_of_round and not context.repetition and not context.individual then
			card.ability.extra.mult = 0
		end
	end
}

--Bootleg Chicot
SMODS.Joker
{
	key = 'chicj',
	loc_txt = 
	{
		name = 'Chic Joker',
		text = 
		{
			'{C:attention}Boss effect{} is disabled',
			'during the {C:attention}last hand{} of a blind',
			'{C:inactive,s:0.8}Art and original concept by{}',
			'{X:chips,C:white,s:0.8}Kitty{}{C:inactive,s:0.8} on the discord!{}'
		}
	},
	atlas = 'Jokers',
	cost = 5,
	blueprint_compat = false,
	pos = {x = 3, y = 1},
	calculate = function(self,card,context)
		if ((G.GAME.current_round.hands_left == 1 and context.after) or G.GAME.current_round.hands_left == 0) and G.GAME.blind.boss and not context.blueprint and not G.GAME.blind.disabled then
			G.GAME.blind:disable(self)
			return
			{
                message = 'Boss disabled!',
                colour = G.C.RED,
                card = card,
            }
		end
	end
}