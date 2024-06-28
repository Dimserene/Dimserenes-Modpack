--- STEAMODDED HEADER

--- MOD_NAME: Loop
--- MOD_ID: loop
--- MOD_AUTHOR: [jenwalter666]
--- MOD_DESCRIPTION: Adds a new voucher called Loop, allowing certain vouchers to be re-redeemed in the same run.
--- PRIORITY: 0
--- BADGE_COLOR: 9f008c
--- PREFIX: loop
--- VERSION: 0.0.2a
--- LOADER_VERSION_GEQ: 1.0.0

SMODS.Atlas {
	key = "modicon",
	path = "loop_avatar.png",
	px = 34,
	py = 34
}

SMODS.Atlas {
	key = "loopvoucher",
	path = "v_loop.png",
	px = 71,
	py = 95
}

local loopable = {
	'v_grabber',
	'v_nacho_tong',
	'v_wasteful',
	'v_recyclomancy',
	'v_reroll_glut',
	'v_reroll_surplus',
	'v_blank',
	'v_antimatter',
	'v_crystal_ball',
	'v_paint_brush',
	'v_palette'
}

--Allow external mods to add onto/remove from this list
function AddLoopableVoucher(key)
	local already_exists = false
	for k, v in pairs(loopable) do
		if v == key then
			already_exists = true
			break
		end
	end
	if not already_exists then
		table.insert(loopable, key)
	end
end

function RemoveLoopableVoucher(key)
	for k, v in pairs(loopable) do
		if v == key then
			table.remove(loopable, k)
			break
		end
	end
end

if SMODS.Mods['Cryptid'] then
	AddLoopableVoucher('v_overstock_norm')
	AddLoopableVoucher('v_overstock_plus')
end

SMODS.Voucher {
	key = 'loop',
	loc_txt = {
		name = 'Loop',
		text = {
			'{C:attention}Unredeems{} certain vouchers,',
			'allowing them to be',
			'{C:attention}redeemed again{} for',
			'{C:green}stacking{} effects'
		}
	},
	atlas = 'loopvoucher',
	cost = 30,
	unlocked = true,
	discovered = true,
	requires = loopable
}

local redeemref = Card.redeem

function Card:redeem()
	redeemref(self)
	if self.config.center_key == 'v_loop_loop' then
		G.GAME.used_vouchers[self.config.center_key] = false
		for k, v in pairs(loopable) do
			G.GAME.used_vouchers[v] = false
		end
	end
end