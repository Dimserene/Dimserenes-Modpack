-- region gondola

local v_gondola = SMODS.Voucher({
	name = "ccc_Fast Track",
	key = "gondola",  -- ACTUAL KEY IS "v_ccc_gondola"
    config = {extra = 1},
	pos = {x = 0, y = 0},
	loc_txt = {
        name = 'Fast Track',
        text = {
	"{C:attention}+1{} Ante",
	"Blinds require {C:red}30%{} less chips"
        }
    },
	cost = 10,
	discovered = true,
	unlocked = true,
	available = true,
	requires = {},
	atlas = "v_ccc_vouchers",
	no_pool_flag = "winning_ante",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})

function v_gondola.redeem(center_table)
    -- if G.GAME.round_resets.blind_ante == G.GAME.win_ante then
    --     G.GAME.win_ante = G.GAME.win_ante + 1
    -- end
    -- center_table has 2 fields: name (the center's name) and extra (the extra field of the voucher config)
    -- apparently the above comment is no longer applicable so i just replaced both instances of center_table.extra with 1... surely that won't cause any problems
    ease_ante(1)
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
    G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante + 1
    G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 0.7
end

function v_gondola.loc_vars(self, info_queue, card)
	return {vars = {card.ability.extra}}	-- desc is hardcoded anyway lol... it still crashes when indexing center_table.extra
end


local ease_anteRef = ease_ante
function ease_ante(mod)
	if G.GAME then
		G.GAME.pool_flags["winning_ante"] = G.GAME.win_ante + (-1*mod) == G.GAME.round_resets.blind_ante
	end
	return ease_anteRef(mod)
end

local v_feather = SMODS.Voucher({
	name = "ccc_Mindfulness",
	key = "feather", -- ACTUAL KEY IS "v_ccc_feather"
    config = {},
	pos = {x = 0, y = 1},
	loc_txt = {
        name = 'Mindfulness',
        text = {
	"Blinds require {C:red}30%{} less chips"
        }
    },
	cost = 10,
	discovered = true,
	unlocked = true,
	available = true,
	requires = {'v_ccc_gondola'},
	atlas = "v_ccc_vouchers",
	credit = {
		art = "Aurora Aquir",
		code = "Aurora Aquir",
		concept = "Aurora Aquir"
	}
})



function v_feather.redeem(center_table)
    G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * 0.7
end



-- endregion gondola

sendDebugMessage("[CCC] Vouchers loaded")