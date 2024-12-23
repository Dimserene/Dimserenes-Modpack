local lovely = require("lovely")
local nativefs = require("nativefs")

G.FUNCS.viewReplay = function(e)
    DejaVu.replays = {}
    local files = nativefs.getDirectoryItems(lovely.mod_dir.."/MathIsFun0-Ankh/Runs")
    for _, file in ipairs(files) do
        local contents = DejaVu.decode(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Runs/"..file))
        if contents then
            local filename = file:sub(1,file:match("^.*()%.")-1)
            local runInfo = contents[1]
            if not G.SAVED_GAME then
                G.SAVED_GAME = get_compressed(G.SETTINGS.profile..'/'..'save.jkr')
                if G.SAVED_GAME ~= nil then G.SAVED_GAME = STR_UNPACK(G.SAVED_GAME) end
            end
            local seed = "(hidden)"
            local hidden = false
            if G.SAVED_GAME and G.SAVED_GAME.GAME and G.SAVED_GAME.GAME.log then
                local saved_log = DejaVu.decode(G.SAVED_GAME.GAME.log)
                if saved_log[1][5] == runInfo[5] and saved_log[1][8] == runInfo[8] then
                    hidden = true
                else
                    seed = runInfo[5]
                end
            else
                seed = runInfo[5]
            end
            local deck = runInfo[4]
            local deck_name = G.P_CENTERS[deck] and G.P_CENTERS[deck].key
            local stake = runInfo[3]       
            local stake_name = G.P_STAKES[stake] and stake
            local time = Speedrun.formatTime(tonumber(contents[#contents][1]))
            local function formatUnixTime(unixTime)
                local utcDiff = os.difftime(os.time(), os.time(os.date("!*t")))
                local localTime = unixTime + utcDiff
                return os.date("%b %d @ %I:%M %p", localTime)
            end    
            DejaVu.replays[#DejaVu.replays+1] = ankh_UIBox_button {
                label = { " " .. filename .. " ", time.." - "..seed..", "..(deck_name and localize{type = 'name_text', set = 'Back', key = deck_name} or deck and deck.."?" or "???")..", "   ..(stake_name and localize{type = 'name_text', set = 'Stake', key = stake_name} or stake and stake.."?" or "???")},
                shadow = false,
                scales = {0.75,0.5},
                colour = deck_name and stake_name and not hidden and G.C.GREEN or G.C.UI.BACKGROUND_INACTIVE,
                text_colours = {G.C.TEXT_DARK,G.C.TEXT_LIGHT},
                button = deck_name and stake_name and not hidden and "viewSelectedReplay" or "nil",
                minh = 0.8,
                minw = 12,
                file = file
            }
        end
    end
    DejaVu.replay_pages = {}
    for i = 1, math.ceil(#DejaVu.replays / 4) do
		table.insert(DejaVu.replay_pages,
			localize('k_page') .. ' ' .. tostring(i) .. '/' .. tostring(math.ceil(#DejaVu.replays / 4)))
	end
    G.SETTINGS.paused = true
    create_UIBox_replays(e)
end

function create_UIBox_replays(args)
	if not args or not args.cycle_config then 
        args = {cycle_config = {current_option = 1}}
    end
    local thisPageReplays = {}
    for i = 4*args.cycle_config.current_option-3, 4*args.cycle_config.current_option do
        if DejaVu.replays[i] then
            thisPageReplays[#thisPageReplays+1] = DejaVu.replays[i]
        end
    end
    local object = {
		n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 6,
            align = "tm",
            padding = 0.2,
            colour = G.C.BLACK,
            id = "replays"
        },
		nodes = {
			{
				n = G.UIT.R,
				config = { align = "cm", padding = 0.04 },
				nodes = thisPageReplays
			},
			#DejaVu.replays > 4 and {
				n = G.UIT.R,
				config = { align = "cm", padding = 0 },
				nodes = {
					create_option_cycle({
						options = DejaVu.replay_pages,
						w = 4.5,
						cycle_shoulders = true,
						opt_callback =
						'viewReplay',
						focus_args = { snap_to = true, nav = 'wide' },
						current_option = args.cycle_config.current_option,
						colour = G
							.C.RED,
						no_pips = true
					})
				}
			} or nil
		}
	}
    local tabs = create_tabs({
        snap_to_nav = true,
        colour = G.C.BOOSTER,
        tabs = {
            {
                label = "Replays",
                chosen = true,
                tab_definition_function = function()
                    return object
                end
            },
        }})
    local replayUI = G.OVERLAY_MENU:get_UIE_by_ID('replays')
    if not replayUI then
        G.FUNCS.overlay_menu{
            definition = create_UIBox_generic_options({
                back_func = "ankhMenu",
                contents = {tabs}
            }),
        config = {offset = {x=0,y=10}}
        }
    else
        G.FUNCS.overlay_menu{
            definition = create_UIBox_generic_options({
                back_func = "ankhMenu",
                contents = {tabs}
            }),
        config = {offset = {x=0,y=0}}
        }
    end
end

function ankh_UIBox_button(args)
    args = args or {}
    args.button = args.button or "exit_overlay_menu"
    args.func = args.func or nil
    args.colour = args.colour or G.C.RED
    args.choice = args.choice or nil
    args.chosen = args.chosen or nil
    args.label = args.label or {'LABEL'}
    args.minw = args.minw or 2.7
    args.maxw = args.maxw or (args.minw - 0.2)
    if args.minw < args.maxw then args.maxw = args.minw - 0.2 end
    args.minh = args.minh or 0.9
    args.scale = args.scales[1] or 0.5
    args.focus_args = args.focus_args or nil
    args.text_colour = args.text_colour or G.C.UI.TEXT_LIGHT
    local but_UIT = args.col == true and G.UIT.C or G.UIT.R
  
    local but_UI_label = {}
  
    local button_pip = nil
    for i = 1, #args.label do 
      if i == #args.label and args.focus_args and args.focus_args.set_button_pip then 
        button_pip ='set_button_pip'
      end
      table.insert(but_UI_label, {n=G.UIT.R, config={align = "cm", padding = 0, minw = args.minw, maxw = args.maxw}, nodes={
        {n=G.UIT.T, config={text = args.label[i], scale = args.scales[i], colour = args.text_colours[i], shadow = args.shadow, focus_args = button_pip and args.focus_args or nil, func = button_pip, ref_table = args.ref_table}}
      }})
    end
  
    if args.count then 
      table.insert(but_UI_label, 
      {n=G.UIT.R, config={align = "cm", minh = 0.4}, nodes={
        {n=G.UIT.T, config={scale = 0.35,text = args.count.tally..' / '..args.count.of, colour = {1,1,1,0.9}}}
      }}
      )
    end
  
    return 
    {n= but_UIT, config = {align = 'cm'}, nodes={
    {n= G.UIT.C, config={
        align = "cm",
        padding = args.padding or 0,
        r = 0.1,
        hover = true,
        colour = args.colour,
        one_press = args.one_press,
        button = (args.button ~= 'nil') and args.button or nil,
        choice = args.choice,
        chosen = args.chosen,
        focus_args = args.focus_args,
        minh = args.minh - 0.3*(args.count and 1 or 0),
        shadow = true,
        func = args.func,
        id = args.id,
        back_func = args.back_func,
        ref_table = args.ref_table,
        mid = args.mid,
        file = args.file
      }, nodes=
      but_UI_label
      }}}
end

local gd = Game.draw
function Game:draw()
    gd(self)
    if DejaVu.replayMode then
        love.graphics.push()
        love.graphics.setColor(G.C.DARK_EDITION[1],G.C.DARK_EDITION[2],G.C.DARK_EDITION[3],1)
        love.graphics.print("Replay Mode", 10, 10+(_RELEASE_MODE and 0 or 20))
        local replayAction = "None"
        local action = "???"
        if DejaVu.replay and DejaVu.replay[1] and DejaVu.replay[1][2] then
            for k, v in pairs(DejaVu.Actions) do
                if DejaVu.Actions[k] == DejaVu.replay[1][2] then
                    action = k
                end
            end
            replayAction = Speedrun.formatTime(tonumber(DejaVu.replay[1][1])).." - "..action
        end
        love.graphics.print("Current Action: "..replayAction, 10, 30+(_RELEASE_MODE and 0 or 20))
        love.graphics.pop()
    end
end

local gupd = Game.update
function click(btn)
    if G.FUNCS[btn.config.button] then
        G.FUNCS[btn.config.button](btn)
    end
end
function Game:update(dt)
    local ret = gupd(self,dt)
    if DejaVu.replayMode_pre and G.STAGE == G.STAGES.RUN then
        DejaVu.replayMode = true
        DejaVu.replayMode_pre = false
        DejaVu.drawn_to_hand = false
        DejaVu.handled = nil
        DejaVu.action = nil
        DejaVu.DELAY_TIME = Speedrun.REPLAY_SPEED_LIST[Speedrun.SETTINGS.replaySpeedID]
    end
    if DejaVu.replayMode then
        if G.STAGE ~= G.STAGES.RUN then
            DejaVu.replayMode = false
            DejaVu.replay = nil
        end
        if DejaVu.delay then
            if not DejaVu.delay_progress then DejaVu.delay_progress = 0 end
            DejaVu.delay_progress = DejaVu.delay_progress + dt
            if DejaVu.delay_progress >= DejaVu.delay then
                DejaVu.delay = nil
                DejaVu.delay_progress = nil
            end
        end
        DejaVu.action = DejaVu.replay and DejaVu.replay[1]
        if DejaVu.action and DejaVu.handled ~= DejaVu.action[1] and not DejaVu.delay and G.STATE_COMPLETE and not (G.CONTROLLER.locked) and not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then
            if DejaVu.action[2] == DejaVu.Actions.START_RUN or DejaVu.action[2] == DejaVu.Actions.CONTINUE_RUN or DejaVu.action[2] == DejaVu.Actions.SHOW_SEED or DejaVu.action[2] == DejaVu.Actions.LOG or DejaVu.action[2] == DejaVu.Actions.WIN_RUN or DejaVu.action[2] == DejaVu.Actions.LOSE_RUN or DejaVu.action[2] == DejaVu.Actions.USE_THIS_CARD then
                table.remove(DejaVu.replay, 1)
            end
            if DejaVu.action[2] == DejaVu.Actions.SORT_RANK and G.STATE == G.STATES.SELECTING_HAND and DejaVu.drawn_to_hand then
                G.hand:sort('desc')
                table.remove(DejaVu.replay, 1)
            end
            if DejaVu.action[2] == DejaVu.Actions.SORT_SUIT and G.STATE == G.STATES.SELECTING_HAND and DejaVu.drawn_to_hand then
                G.hand:sort('suit desc')
                table.remove(DejaVu.replay, 1)
            end
            if DejaVu.action[2] == DejaVu.Actions.SELECT_BLIND and G.STATE == G.STATES.BLIND_SELECT and G.GAME.blind_on_deck and G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID('select_blind_button') then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local blind_select = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID('select_blind_button')
                        click(blind_select)
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                })) 
            end
            if DejaVu.action[2] == DejaVu.Actions.SKIP_BLIND and G.STATE == G.STATES.BLIND_SELECT and G.GAME.blind_on_deck and G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID('select_blind_button') then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local blind_skip = G.blind_select_opts[string.lower(G.GAME.blind_on_deck)]:get_UIE_by_ID('tag_'..G.GAME.blind_on_deck).children[2]
                        click(blind_skip)
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                })) 
            end
            if DejaVu.action[2] == DejaVu.Actions.PLAY_HAND and G.STATE == G.STATES.SELECTING_HAND and DejaVu.drawn_to_hand then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for i = 3, #DejaVu.action do
                            if tonumber(DejaVu.action[i]) then
                                G.hand.cards[tonumber(DejaVu.action[i])]:click()
                            end
                        end
                        G.FUNCS.play_cards_from_highlighted()
                        table.remove(DejaVu.replay, 1)
                        DejaVu.drawn_to_hand = false
                        return true
                    end
                })) 
            end
            if DejaVu.action[2] == DejaVu.Actions.DISCARD_HAND and G.STATE == G.STATES.SELECTING_HAND and DejaVu.drawn_to_hand then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for i = 3, #DejaVu.action do
                            if tonumber(DejaVu.action[i]) then
                                G.hand.cards[tonumber(DejaVu.action[i])]:click()
                            end
                        end
                        G.FUNCS.discard_cards_from_highlighted()
                        table.remove(DejaVu.replay, 1)
                        DejaVu.drawn_to_hand = false
                        return true
                    end
                })) 
            end
            if DejaVu.action[2] == DejaVu.Actions.REARRANGE_HAND and (G.STATE == G.STATES.SELECTING_HAND and DejaVu.drawn_to_hand or G.pack_cards) then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for k, v in ipairs(DejaVu.action) do
                            if k >= 3 and tonumber(v) then
                                k = k - 2
                                v = tonumber(v)
                                for i = 1, #G.hand.cards do
                                    if G.hand.cards[i].ankh_id == v then
                                        G.hand.cards[k],G.hand.cards[i]=G.hand.cards[i],G.hand.cards[k]
                                    end
                                end
                            end
                        end
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.REARRANGE_JOKERS then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for k, v in ipairs(DejaVu.action) do
                            if k >= 3 and tonumber(v) then
                                k = k - 2
                                v = tonumber(v)
                                for i = 1, #G.jokers.cards do
                                    if G.jokers.cards[i].ankh_id == v then
                                        G.jokers.cards[k],G.jokers.cards[i]=G.jokers.cards[i],G.jokers.cards[k]
                                    end
                                end
                            end
                        end
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.REARRANGE_CONSUMABLES then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for k, v in ipairs(DejaVu.action) do
                            if k >= 3 and tonumber(v) then
                                k = k - 2
                                v = tonumber(v)
                                for i = 1, #G.consumeables.cards do
                                    if G.consumeables.cards[i].ankh_id == v then
                                        G.consumeables.cards[k],G.consumeables.cards[i]=G.consumeables.cards[i],G.consumeables.cards[k]
                                    end
                                end
                            end
                        end
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.USE_CONSUMABLE and (not DejaVu.action[4] or G.hand) then
                DejaVu.handled = DejaVu.action[1]
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for i = 4, #DejaVu.action do
                            if tonumber(DejaVu.action[i]) then
                                G.hand.cards[tonumber(DejaVu.action[i])]:click()
                            end
                        end
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.5,
                            blocking = false,
                            func = function()
                            G.FUNCS.use_card({config = {ref_table = G.consumeables.cards[tonumber(DejaVu.action[3])]}})
                            return true
                            end
                        }))
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 4.0,
                            blocking = false,
                            func = function()
                                if G.STATE_COMPLETE and not (G.CONTROLLER.locked) and not (G.GAME.STOP_USE and G.GAME.STOP_USE > 0) then G.hand:unhighlight_all()
                                    table.remove(DejaVu.replay, 1)
                                    DejaVu.delay = 0
                        return true end end}))
                        return true
                    end
                }))
                DejaVu.delay = 1e100
            end
            if DejaVu.action[2] == DejaVu.Actions.BUY_CARD and G.STATE == G.STATES.SHOP then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local e = {config = {ref_table = G.shop_jokers.cards[tonumber(DejaVu.action[3])], id = 'buy'}}
                        if DejaVu.replay[2] and DejaVu.replay[2][2] == DejaVu.Actions.USE_THIS_CARD then 
                            e.config.id = 'buy_and_use'
                            DejaVu.delay = 1.5
                        end 
                        G.FUNCS.buy_from_shop(e)
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.BUY_VOUCHER and G.STATE == G.STATES.SHOP then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local e = {config = {ref_table = G.shop_vouchers.cards[tonumber(DejaVu.action[3])], id = 'buy_and_use'}}
                        G.FUNCS.buy_from_shop(e)
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.BUY_BOOSTER and G.STATE == G.STATES.SHOP then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        local e = {config = {ref_table = G.shop_booster.cards[tonumber(DejaVu.action[3])], id = 'buy_and_use'}}
                        G.FUNCS.use_card(e, true)
                        table.remove(DejaVu.replay, 1)
                        DejaVu.delay = 1
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.SELL_JOKER then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.jokers.cards[tonumber(DejaVu.action[3])]:sell_card()
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.SELL_CONSUMABLE then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.consumeables.cards[tonumber(DejaVu.action[3])]:sell_card()
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.END_SHOP and G.STATE == G.STATES.SHOP then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.FUNCS.toggle_shop()
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.REROLL_SHOP and G.STATE == G.STATES.SHOP then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.FUNCS.reroll_shop()
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 1,
                            func = function()
                                table.remove(DejaVu.replay, 1)
                                return true
                            end
                        }))
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.SELECT_BOOSTER_CARD and G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        for i = 4, #DejaVu.action do
                            if tonumber(DejaVu.action[i]) then
                                G.hand.cards[tonumber(DejaVu.action[i])]:click()
                            end
                        end
                        G.FUNCS.use_card({config = {ref_table = G.pack_cards.cards[tonumber(DejaVu.action[3])]}})
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
            if DejaVu.action[2] == DejaVu.Actions.SKIP_BOOSTER_PACK and G.pack_cards and G.pack_cards.cards and G.pack_cards.cards[1] then
                DejaVu.handled = DejaVu.action[1]
                delay(DejaVu.DELAY_TIME*G.SETTINGS.GAMESPEED)
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    func = function()
                        G.FUNCS.skip_booster()
                        table.remove(DejaVu.replay, 1)
                        return true
                    end
                }))
            end
        end
    end
    return ret
end

local d2h = Blind.drawn_to_hand
function Blind:drawn_to_hand()
    d2h(self)
    if DejaVu.replay then DejaVu.drawn_to_hand = true end
end

G.FUNCS.viewSelectedReplay = function(e)
    G.security = {}
    G.security_page = 1
    DejaVu.replay_file = e.config.file
    DejaVu.replay = DejaVu.decode(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Runs/"..e.config.file))
    local contents = DejaVu.replay
    for i = 1, #contents do
        if contents[i].security then
            G.security[#G.security+1] = contents[i]
        end
    end
    DejaVu.replay = nil
    create_UIBox_replay()
end
function create_UIBox_replay()
    local tabs = create_tabs({
        snap_to_nav = true,
        colour = G.C.BOOSTER,
        tabs = {
            {
                label = "Replays",
                chosen = true,
                tab_definition_function = function()
                    return {
                        n = G.UIT.ROOT,
                        config = {
                            emboss = 0.05,
                            minh = 6,
                            r = 0.1,
                            minw = 6,
                            align = "tm",
                            padding = 0.2,
                            colour = G.C.BLACK,
                            id = "replay"
                        },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cm", padding = 0.04 },
                                nodes = {UIBox_button{ label = {"View Replay"}, button = "watchSelectedReplay", minw = 5, minh = 0.7, scale = 1},
                                        {
                                            n = G.UIT.R,
                                            config = {align = "cm", padding = 0.1},
                                            nodes = {{
                                                n = G.UIT.T,
                                                config = {text = "This tab is under construction!", scale = 0.4, shadow = true, colour = G.C.WHITE}
                                            }}
                                        }}
                            }
                        }
                    }
                end
            },
            {
                label = "Security",
                tab_definition_function = function()
                    return {
                        n = G.UIT.ROOT,
                        config = {
                            emboss = 0.05,
                            minh = 6,
                            r = 0.1,
                            minw = 6,
                            align = "tm",
                            padding = 0.2,
                            colour = G.C.BLACK,
                            id = "replay"
                        },
                        nodes = {DejaVu.securityUI(G.security[G.security_page])}
                    }
                end
            },
        }})
    local replayUI = G.OVERLAY_MENU:get_UIE_by_ID('replay')
    if not replayUI then
        G.FUNCS.overlay_menu{
            definition = create_UIBox_generic_options({
                back_func = "viewReplay",
                contents = {tabs}
            }),
        config = {offset = {x=0,y=10}}
        }
    else
        G.FUNCS.overlay_menu{
            definition = create_UIBox_generic_options({
                back_func = "viewReplay",
                contents = {tabs}
            }),
        config = {offset = {x=0,y=0}}
        }
    end
end

G.FUNCS.watchSelectedReplay = function(e)
    G.FUNCS.exit_overlay_menu()
    local function find_challenge(c)
        for k, v in pairs(G.CHALLENGES) do
            if v.id == c then return v end
        end
    end
    DejaVu.replay = DejaVu.decode(nativefs.read(lovely.mod_dir.."/MathIsFun0-Ankh/Runs/"..DejaVu.replay_file))
    local contents = DejaVu.replay
    for i = #contents, 1, -1 do
        if contents[i].security then
            table.remove(contents, i)
        end
    end
    G.GAME.viewed_back = G.P_CENTERS[DejaVu.replay[1][4]]
    G.FUNCS.start_run(nil, {stake = G.P_STAKES[DejaVu.replay[1][3]].stake_level, seed = DejaVu.replay[1][5], challenge = DejaVu.replay[1][6] and find_challenge(DejaVu.replay[1][6])})
    DejaVu.replayMode_pre = true
end

local sr = save_run
function save_run()
    if not DejaVu.replayMode then
        sr()
    end
end