SMODS.Joker {
    key = 'gammaray',
    loc_txt = {
        name = 'Gamma Ray',
        text = {
            'The Boss Blind for the',
            'next ante is {C:attention}#1#{}',
            'Upgrades the winning',
            '{C:attention}poker hand{} for boss blinds'
            }
    },

    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    pos = {x = 0, y = 1 },
    config = {
        extra = { boss = "None" }
    },
	loc_vars = function(self, info_queue, card)
		return { vars = { } }
	end,
    calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval then
            return {level_up = 1}
        end

        if context.setting_blind then
            local eligible_bosses = {}
            for k, v in pairs(G.P_BLINDS) do
                if not v.boss then
                elseif not v.boss.showdown and (v.boss.min <= (G.GAME.round_resets.ante) and ((G.GAME.round_resets.ante)%G.GAME.win_ante ~= 0 or G.GAME.round_resets.ante < 2)) then
                    eligible_bosses[k] = true
                elseif v.boss.showdown and (G.GAME.round_resets.ante)%G.GAME.win_ante == 0 and G.GAME.round_resets.ante >= 2 then
                    eligible_bosses[k] = true
                end
            end

            for k, v in pairs(G.GAME.banned_keys) do
                if eligible_bosses[k] then eligible_bosses[k] = nil end
            end

            local min_use = 100
            for k, v in pairs(G.GAME.bosses_used) do
                if eligible_bosses[k] then
                    eligible_bosses[k] = v
                    if eligible_bosses[k] <= min_use then
                        min_use = eligible_bosses[k]
                    end
                end
            end

            for k, v in pairs(eligible_bosses) do
                if eligible_bosses[k] then
                    if eligible_bosses[k] > min_use then
                        eligible_bosses[k] = nil
                    end
                end
            end

            local boss_seed = ((math.abs(tonumber(string.format("%.13f", (2.134453429141+G.GAME.pseudorandom.boss*1.72431234)%1)))) + G.GAME.pseudorandom.hashed_seed)/2
            math.randomseed(boss_seed)

            local keys = {}
            for k, v in pairs(eligible_bosses) do
                keys[#keys+1] = {k = k,v = v}
            end

            if keys[1] and keys[1].v and type(keys[1].v) == 'table' and keys[1].v.sort_id then
                table.sort(keys, function (a, b) return a.v.sort_id < b.v.sort_id end)
            else
                table.sort(keys, function (a, b) return a.k < b.k end)
            end

            local boss = keys[math.random(#keys)].k

            if     boss == "bl_hook"            then boss = "The Hook"
            elseif boss == "bl_ox"              then boss = "The Ox"
            elseif boss == "bl_house"           then boss = "The House"
            elseif boss == "bl_wall"            then boss = "The Wall"
            elseif boss == "bl_wheel"           then boss = "The Wheel"
            elseif boss == "bl_arm"             then boss = "The Arm"
            elseif boss == "bl_club"            then boss = "The Club"
            elseif boss == "bl_fish"            then boss = "The Fish"
            elseif boss == "bl_psychic"         then boss = "The Psychic"
            elseif boss == "bl_goad"            then boss = "The Goad"
            elseif boss == "bl_water"           then boss = "The Water"
            elseif boss == "bl_window"          then boss = "The Window"
            elseif boss == "bl_manacle"         then boss = "The Manacle"
            elseif boss == "bl_eye"             then boss = "The Eye"
            elseif boss == "bl_mouth"           then boss = "The Mouth"
            elseif boss == "bl_plant"           then boss = "The Plant"
            elseif boss == "bl_serpent"         then boss = "The Serpent"
            elseif boss == "bl_pillar"          then boss = "The Pillar"
            elseif boss == "bl_needle"          then boss = "The Needle"
            elseif boss == "bl_head"            then boss = "The Head"
            elseif boss == "bl_tooth"           then boss = "The Tooth"
            elseif boss == "bl_flint"           then boss = "The Flint"
            elseif boss == "bl_mark"            then boss = "The Mark"
            elseif boss == "bl_final_acorn"     then boss = "Amber Acorn"
            elseif boss == "bl_final_leaf"      then boss = "Verdant Leaf"
            elseif boss == "bl_final_vessel"    then boss = "Violet Vessel"
            elseif boss == "bl_final_heart"     then boss = "Crimson Heart"
            elseif boss == "bl_final_bell"      then boss = "Cerulean Bell"
            end

            return { 
                message = boss,
                card = card
            }
        end
    end,
}
