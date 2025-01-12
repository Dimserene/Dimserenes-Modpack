--- STEAMODDED HEADER
--- MOD_NAME: Art of the Deal
--- MOD_ID: ATRAXIA
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
		
		if context.buying_card then
			card.ability.extra.Xmult=1
			return
			{
				message = 'Reset!',
				colour = G.C.MULT
			}
		end
		
		if context.end_of_round and not context.repetition and not context.individual then
			card.ability.extra.Xmult=card.ability.extra.Xmult+0.5 
			return
			{
				
				message = 'X' .. card.ability.extra.Xmult,
				colour = G.C.MULT
			}
		end
	end
}