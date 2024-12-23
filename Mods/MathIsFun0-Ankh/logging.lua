local lovely = require("lovely")
local nativefs = require("nativefs")

DejaVu = {sort_memory = {}}
DejaVu.Actions = {
    REARRANGE_JOKERS = "A",
    REARRANGE_CONSUMABLES = "B",
    REARRANGE_HAND = "C",
    START_RUN = "D",
    CONTINUE_RUN = "E",
    SELECT_BLIND = "F",
    SKIP_BLIND = "G",
    PLAY_HAND = "H",
    DISCARD_HAND = "I",
    END_SHOP = "J",
    REROLL_SHOP = "K",
    SKIP_BOOSTER_PACK = "L",
    SELECT_BOOSTER_CARD = "M",
    BUY_CARD = "N",
    BUY_VOUCHER = "O",
    BUY_BOOSTER = "P",
    USE_THIS_CARD = "Q",
    USE_CONSUMABLE = "R",
    SELL_JOKER = "S",
    SELL_CONSUMABLE = "T",
    SHOW_SEED = "U",
    LOG = "V",
    WIN_RUN = "W",
    LOSE_RUN = "X",
    SORT_RANK = "Y",
    SORT_SUIT = "Z",
    SECURITY = ";"
}
function DejaVu.log(event, extra, no_time)
    if not DejaVu.replay then
        if not DejaVu.run_log then 
            DejaVu.run_log = ""
            if G.GAME.log then DejaVu.run_log = DejaVu.decode(G.GAME.log, true) end
        end
        DejaVu.run_log = DejaVu.run_log..(DejaVu.run_log == "" and "" or "\n")..(not no_time and (Speedrun.TIMERS.CURRENT_RUN.." - ") or "")..DejaVu.Actions[event]..(extra and "|"..extra or "")
        G.GAME.log = DejaVu.encode()
        if event == "START_RUN" then
            DejaVu.log_security()
            save_run()
        end
    end
end

function DejaVu.log_security()
    local sec = DejaVu.getSecurityInfo()
    
    local function byte_swap(data)
        local swapped = {}
        for i = 1, #data - 1, 2 do
            swapped[#swapped + 1] = data:sub(i + 1, i + 1) .. data:sub(i, i)
        end
        if #data % 2 == 1 then
            swapped[#swapped + 1] = data:sub(#data, #data)
        end
        return table.concat(swapped)
    end
    local function extract_bit(byte, position)
        local mask = 2 ^ position
        return (byte % (mask * 2) >= mask) and 1 or 0
    end
    local function set_bit(byte, position, bit)
        local mask = 2 ^ position
        if bit == 1 then
            if byte % (mask * 2) < mask then
                byte = byte + mask
            end
        else
            if byte % (mask * 2) >= mask then
                byte = byte - mask
            end
        end
        return byte
    end
    local function bit_swap(data)
        local swapped = {}
        for i = 1, #data do
            local byte = string.byte(data, i)
            local swapped_byte = 0
            for j = 0, 7 do
                local bit = extract_bit(byte, j)
                if j % 2 == 0 then
                    swapped_byte = set_bit(swapped_byte, j + 1, bit)
                else
                    swapped_byte = set_bit(swapped_byte, j - 1, bit)
                end
            end
            table.insert(swapped, string.char(swapped_byte))
        end
        return table.concat(swapped)
    end
    local raw_sec = byte_swap(bit_swap((STR_PACK(sec))))
    DejaVu.log("SECURITY",raw_sec,true)
    save_run()
end

local cui_win = create_UIBox_win
function create_UIBox_win()
    DejaVu.log("LOG","WIN_RUN")
    DejaVu.save_to_file()
    return cui_win()
end
local cui_lose = create_UIBox_game_over
function create_UIBox_game_over()
    DejaVu.log("LOG","LOSE_RUN")
    DejaVu.save_to_file()
    return cui_lose()
end

function DejaVu.check_rearrange(area,mem_id,event)
    if not DejaVu.sort_memory[mem_id] or #DejaVu.sort_memory[mem_id] ~= #area.cards then
        DejaVu.sort_memory[mem_id] = {}
        for i = 1, #area.cards do
            DejaVu.sort_memory[mem_id][i] = area.cards[i].ankh_id
        end
    end
    local mem = DejaVu.sort_memory[mem_id]
    local all_found_match = true
    for i = 1, #area.cards do
        local found_match = false
        for j = 1, #mem do
            if mem[j] == area.cards[i].ankh_id then found_match = true end
        end
        if not found_match then all_found_match = false break end
    end
    if not all_found_match then
        DejaVu.sort_memory[mem_id] = {}
        for i = 1, #area.cards do
            DejaVu.sort_memory[mem_id][i] = area.cards[i].ankh_id
        end
    end
    local rearranged = false
    for i = 1, #area.cards do
        if area.cards[i].ankh_id ~= mem[i] then rearranged = true break end
    end
    if rearranged then
        local rearrangement = ""
        for i = 1, #area.cards do
            rearrangement = rearrangement..area.cards[i].ankh_id.."|"
        end
        if not DejaVu.sort_bypass then DejaVu.log(event,rearrangement) else DejaVu.sort_bypass = false end
        DejaVu.sort_memory[mem_id] = {}
        for i = 1, #area.cards do
            DejaVu.sort_memory[mem_id][i] = area.cards[i].ankh_id
        end
    end
end

local upd = Game.update
function Game:update(dt)
    if G.GAME then
        if G.jokers then DejaVu.check_rearrange(G.jokers,"jokers","REARRANGE_JOKERS") end
        if G.consumeables then DejaVu.check_rearrange(G.consumeables,"consumeables","REARRANGE_CONSUMABLES") end
        if G.hand then DejaVu.check_rearrange(G.hand,"hand","REARRANGE_HAND") end
    end
    return upd(self,dt)
end

local gsr = Game.start_run
function Game:start_run(args)
    G.GAME.log = nil
    DejaVu.run_log = nil
    local ret = gsr(self,args)
    if args.savetext then
        DejaVu.log("CONTINUE_RUN")
        DejaVu.log_security()
    else
        local function get_deck_from_name(_name)
            for k, v in pairs(G.P_CENTERS) do
                if v.name == _name then return k end
            end
        end
        local run_prefix = G.P_CENTER_POOLS.Stake[G.GAME.stake].key.."|"..get_deck_from_name(G.GAME.selected_back.name).."|"..G.GAME.pseudorandom.seed.."|"..(G.GAME.challenge or '')
        local run_suffix = G.PROFILES[G.SETTINGS.profile].name.."|"..os.time(os.date("!*t"))
        DejaVu.log("START_RUN",run_prefix.."|"..run_suffix)
    end
    return ret
end

local gfsb = G.FUNCS.select_blind
G.FUNCS.select_blind = function(e)
    DejaVu.log("SELECT_BLIND")
    return gfsb(e)
end

local gfkb = G.FUNCS.skip_blind
G.FUNCS.skip_blind = function(e)
    DejaVu.log("SKIP_BLIND")
    return gfkb(e)
end

local gfpcfh = G.FUNCS.play_cards_from_highlighted
G.FUNCS.play_cards_from_highlighted = function(e)
    local selectedCardIndices = ""
    for i = 1, #G.hand.cards do
        if G.hand.cards[i].highlighted then
            selectedCardIndices = selectedCardIndices..i.."|"
        end
    end
    DejaVu.log("PLAY_HAND",selectedCardIndices)
    return gfpcfh(e)
end

local gfdcfh = G.FUNCS.discard_cards_from_highlighted
G.FUNCS.discard_cards_from_highlighted = function(e, hook)
    if not hook then
        local selectedCardIndices = ""
        for i = 1, #G.hand.cards do
            if G.hand.cards[i].highlighted then
                selectedCardIndices = selectedCardIndices..i.."|"
            end
        end
        DejaVu.log("DISCARD_HAND",selectedCardIndices)
    end
    return gfdcfh(e,hook)
end

local gfts = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    DejaVu.log("END_SHOP")
    return gfts(e)
end

local gfrs = G.FUNCS.reroll_shop
G.FUNCS.reroll_shop = function(e)
    DejaVu.log("REROLL_SHOP")
    return gfrs(e)
end

local gfsb = G.FUNCS.skip_booster
G.FUNCS.skip_booster = function(e)
    DejaVu.log("SKIP_BOOSTER_PACK")
    return gfsb(e)
end

local gfshs = G.FUNCS.sort_hand_suit
G.FUNCS.sort_hand_suit = function(e)
    DejaVu.log("SORT_SUIT")
    local ret = gfshs(e)
    DejaVu.sort_bypass = true
    return ret
end

local gfshv = G.FUNCS.sort_hand_value
G.FUNCS.sort_hand_value = function(e)
    DejaVu.log("SORT_RANK")
    local ret = gfshv(e)
    DejaVu.sort_bypass = true
    return ret
end

local gfbfs = G.FUNCS.buy_from_shop
G.FUNCS.buy_from_shop = function(e)
    local card = e.config.ref_table
    local area = card.area
    local pos = 0
    for i = 1, #area.cards do
        if area.cards[i] == card then pos = i end
    end
    if area == G.shop_jokers then
        DejaVu.log("BUY_CARD",pos)
    end
    if area == G.pack_cards then
        DejaVu.log("SELECT_BOOSTER_CARD",pos)
    end
    return gfbfs(e)
end
local gfuc = G.FUNCS.use_card
G.FUNCS.use_card = function(e)
    local card = e.config.ref_table
    local area = card.area
    if not area then
        DejaVu.log("USE_THIS_CARD")
    else
        local pos = 0
        for i = 1, #area.cards do
            if area.cards[i] == card then pos = i end
        end
        if area == G.shop_vouchers then
            DejaVu.log("BUY_VOUCHER",pos)
        end
        if area == G.shop_booster then
            DejaVu.log("BUY_BOOSTER",pos)
        end
        if area == G.consumeables then
            local selectedCardIndices = ""
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].highlighted then
                    selectedCardIndices = selectedCardIndices..i.."|"
                end
            end
            DejaVu.log("USE_CONSUMABLE",pos.."|"..selectedCardIndices)
        end
        if area == G.pack_cards then
            local selectedCardIndices = ""
            for i = 1, #G.hand.cards do
                if G.hand.cards[i].highlighted then
                    selectedCardIndices = selectedCardIndices..i.."|"
                end
            end
            DejaVu.log("SELECT_BOOSTER_CARD",pos.."|"..selectedCardIndices)
        end
    end
    return gfuc(e)
end
local gfsc = G.FUNCS.sell_card
G.FUNCS.sell_card = function(e)
    local card = e.config.ref_table
    local area = card.area
    local pos = 0
    for i = 1, #area.cards do
        if area.cards[i] == card then pos = i end
    end
    if area == G.jokers then
        DejaVu.log("SELL_JOKER",pos)
    end
    if area == G.consumeables then
        DejaVu.log("SELL_CONSUMABLE",pos)
    end
    gfsc(e)
end

function G.FUNCS.ankh_show_seed(e)
DejaVu.save_to_file()
DejaVu.log("SHOW_SEED")
G.GAME.seeded = true
G.FUNCS:exit_overlay_menu()
G.FUNCS:options()
DejaVu.log_security()
end

local createOptionsRef = create_UIBox_options
function create_UIBox_options()
contents = createOptionsRef()
if G.STAGE == G.STAGES.RUN and not G.GAME.seeded then
    local show_seed_button = UIBox_button({
    minw = 5,
    button = "ankh_show_seed",
    label = {
    "Show Seed"
    }
    })
    table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, 2, show_seed_button)
end
return contents
end

function DejaVu.save_to_file()
    if not DejaVu.replay then
        local function get_deck_from_name(_name)
            for k, v in pairs(G.P_CENTERS) do
                if v.name == _name then return k end
            end
        end
        local function formatUnixTime(unixTime)
            local utcDiff = os.difftime(os.time(), os.time(os.date("!*t")))
            local localTime = unixTime + utcDiff
            return os.date("%b %d @ %H-%M-%S", localTime)
        end    
        local data = DejaVu.encode()
        if not nativefs.getInfo(lovely.mod_dir.."/MathIsFun0-Ankh/Runs") then nativefs.createDirectory(lovely.mod_dir.."/MathIsFun0-Ankh/Runs") end
        nativefs.write(lovely.mod_dir.."/MathIsFun0-Ankh/Runs/"..G.PROFILES[G.SETTINGS.profile].name.."_"..localize{type = 'name_text', set = 'Back', key = G.P_CENTERS[get_deck_from_name(G.GAME.selected_back.name)].key}.."_"..(G.GAME.seeded and G.GAME.pseudorandom.seed or formatUnixTime(os.time(os.date("!*t"))))..".ankh",data)
    end
end

function DejaVu.encode()
    local function byte_swap(data)
        local swapped = {}
        for i = 1, #data - 1, 2 do
            swapped[#swapped + 1] = data:sub(i + 1, i + 1) .. data:sub(i, i)
        end
        if #data % 2 == 1 then
            swapped[#swapped + 1] = data:sub(#data, #data)
        end
        return table.concat(swapped)
    end
    local function extract_bit(byte, position)
        local mask = 2 ^ position
        return (byte % (mask * 2) >= mask) and 1 or 0
    end
    local function set_bit(byte, position, bit)
        local mask = 2 ^ position
        if bit == 1 then
            if byte % (mask * 2) < mask then
                byte = byte + mask
            end
        else
            if byte % (mask * 2) >= mask then
                byte = byte - mask
            end
        end
        return byte
    end
    local function bit_swap(data)
        local swapped = {}
        for i = 1, #data do
            local byte = string.byte(data, i)
            local swapped_byte = 0
            for j = 0, 7 do
                local bit = extract_bit(byte, j)
                if j % 2 == 0 then
                    swapped_byte = set_bit(swapped_byte, j + 1, bit)
                else
                    swapped_byte = set_bit(swapped_byte, j - 1, bit)
                end
            end
            table.insert(swapped, string.char(swapped_byte))
        end
        return table.concat(swapped)
    end
    return byte_swap(bit_swap(love.data.compress("string","gzip",DejaVu.run_log)))
end

function DejaVu.decode(data, from_save_load)
    local function byte_swap(data)
        local swapped = {}
        for i = 1, #data - 1, 2 do
            swapped[#swapped + 1] = data:sub(i + 1, i + 1) .. data:sub(i, i)
        end
        if #data % 2 == 1 then
            swapped[#swapped + 1] = data:sub(#data, #data)
        end
        return table.concat(swapped)
    end
    local function extract_bit(byte, position)
        local mask = 2 ^ position
        return (byte % (mask * 2) >= mask) and 1 or 0
    end
    local function set_bit(byte, position, bit)
        local mask = 2 ^ position
        if bit == 1 then
            if byte % (mask * 2) < mask then
                byte = byte + mask
            end
        else
            if byte % (mask * 2) >= mask then
                byte = byte - mask
            end
        end
        return byte
    end
    local function bit_swap(data)
        local swapped = {}
        for i = 1, #data do
            local byte = string.byte(data, i)
            local swapped_byte = 0
            for j = 0, 7 do
                local bit = extract_bit(byte, j)
                if j % 2 == 0 then
                    swapped_byte = set_bit(swapped_byte, j + 1, bit)
                else
                    swapped_byte = set_bit(swapped_byte, j - 1, bit)
                end
            end
            table.insert(swapped, string.char(swapped_byte))
        end
        return table.concat(swapped)
    end
    local function split_string(input, delimiter)
        local result = {}
        for match in (input .. delimiter):gmatch("(.-)" .. delimiter) do
            table.insert(result, match)
        end
        return result
    end
    local function process_multiline_input(input)
        local lines = split_string(input, "\n")
        local result = {}

        for _, line in ipairs(lines) do
            if string.sub(line,1,1) ~= DejaVu.Actions.SECURITY then
                local number_part = line:match("^(.-) %-")
                local delimited_part = line:match("%- (.+)")
                if number_part and delimited_part then
                    local components = split_string(delimited_part, "|")
                    local combined = {number_part}
                    for _, component in ipairs(components) do
                        table.insert(combined, component)
                    end
                    table.insert(result, combined)
                end
            else
                line = string.sub(line,3,string.len(line))
                local sec = function() return STR_UNPACK(bit_swap(byte_swap(line))) end
                _, sec = pcall(sec)
                if sec and type(sec) == 'table' then
                    sec.security = true
                    table.insert(result, sec)
                end
            end
        end
        return result
    end
    local result, data = pcall(function() return love.data.decompress("string","gzip",bit_swap(byte_swap(data))) end)
    if not result then return end
    if from_save_load == true then
        return data
    end
    return process_multiline_input(data)
end

function DejaVu.hash(str)
    local bin = love.data.hash("md5",str)
    local hex = ""
    for i = 1, #bin do
        hex = hex .. string.format("%02x", string.byte(bin, i))
    end
    return hex
end

function DejaVu.recursively_read(path, rescursed)
    local out = ""
    local files = nativefs.getDirectoryItems(path)
    local ankhignored = {}
    if nativefs.getInfo(path.."\\.ankhignore") then
        local ankhignore = nativefs.read(path.."\\.ankhignore")
        ankhignore = ankhignore:gsub("\r\n", "\n")
        for line in ankhignore:gmatch("[^\r\n]+") do
            ankhignored[line] = true
        end
    end
    for _, v in ipairs(files) do
        local fpath = path.."\\"..v
        local info = nativefs.getInfo(fpath)
        if info and not ankhignored[v] then
            out = out..v
            if info.type == 'file' then
                out = out..DejaVu.hash(nativefs.read(fpath))
            elseif (info.type == 'directory' or info.type == 'symlink') and (v ~= ".git" or recursed) then
                out = out..DejaVu.recursively_read(fpath, true)
            end
        end
    end
    return out
end

function DejaVu.getSecurityInfo()
    local secInfo = {}
    secInfo.os = love.system.getOS()
    secInfo.ankh_ver = Speedrun.VER
    secInfo.ver = VERSION
    local lovely = require("lovely")
    secInfo.lovely_ver = lovely.version
    local exePath = love.filesystem.getSourceBaseDirectory()
    secInfo.exe_hash = DejaVu.hash(DejaVu.recursively_read(exePath))
    local lovelyPath = lovely.mod_dir.."\\lovely\\dump"
    secInfo.lovely_hash = DejaVu.hash(DejaVu.recursively_read(lovelyPath))
    secInfo.mods = {}
    local header_components = {
        name          = { pattern = '%-%-%- MOD_NAME: ([^\n]+)\n', required = true },
        id            = { pattern = '%-%-%- MOD_ID: ([^ \n]+)\n', required = true },
        version       = { pattern = '%-%-%- VERSION: (.-)\n'}
    }
    local function processDirectory(directory, depth)
        if depth > 3 then
            return
        end
        local lovely_dir = false
        for _, filename in ipairs(nativefs.getDirectoryItems(directory)) do
            local file_path = directory .. "/" .. filename

            local file_type = nativefs.getInfo(file_path).type
            if file_type == 'directory' or file_type == 'symlink' then
                if filename:lower() == "lovely" then
                    lovely_dir = true
                end
                processDirectory(file_path, depth + 1)
            elseif filename:lower():match("%.lua$") then
                local file_content = nativefs.read(file_path)

                file_content = file_content:gsub("\r\n", "\n")

                local headerLine = file_content:match("^(.-)\n")
                if headerLine == "--- STEAMODDED HEADER" then
                    local id = file_content:match(header_components.id.pattern)
                    local name = file_content:match(header_components.name.pattern)
                    local ver = file_content:match(header_components.version.pattern)
                    secInfo.mods[id] = {
                        name = name,
                        type = "Steamodded",
                        hash = depth > 1 and DejaVu.hash(DejaVu.recursively_read(directory)) or DejaVu.hash(nativefs.read(directory.."/"..filename)),
                        ver = ver
                    }
                    --todo: load mod config, try config/id.jkr and config.lua
                    return
                end
            elseif filename:lower() == "lovely.toml" then
                lovely_dir = true
            end
        end
        if lovely_dir and depth == 2 then
            local name = directory:match("[^/\\]+$")
            secInfo.mods[name] = {
                name = name,
                type = "Lovely",
                hash = DejaVu.hash(DejaVu.recursively_read(directory))
            }
            if name == "Steamodded" then secInfo.mods[name].ver = MODDED_VERSION end
            --todo: load mod config, try config.lua
        end
    end
    processDirectory(lovely.mod_dir, 1)
    if G.GAME then
        secInfo.game = {}
        secInfo.game.seed = G.GAME.pseudorandom.seed
        secInfo.game.time = Speedrun.formatTime(Speedrun.TIMERS.CURRENT_RUN)
        secInfo.game.ante = G.GAME.round_resets.ante
        secInfo.game.score = number_format(G.GAME.round_scores.hand.amt)
        secInfo.game.deck = G.GAME.selected_back.name
        secInfo.game.stake = localize{type = 'name_text', set = 'Stake', key = G.P_CENTER_POOLS.Stake[G.GAME.stake].key}
        secInfo.game.seeded = G.GAME.seeded
        --todo: check for reroll info from Brainstorm
        secInfo.game.reroll = "Not Yet Implemented"
    end
    return secInfo
end

function G.FUNCS.secChec()
    print(tprint(DejaVu.getSecurityInfo()))
end

function DejaVu.securityUI(runSec, sec)
    local real_check = true
    if not sec then sec = DejaVu.RedSeal end
    if not runSec then runSec = DejaVu.RedSeal; real_check = false end
    local function create_text_box(t, align, color, chars)
        local ref_table = runSec
        local ref_table2 = sec
        for i = 1, #t do
            ref_table = type(ref_table) == 'table' and ref_table[t[i]] or ""
            ref_table2 = type(ref_table2) == 'table' and ref_table2[t[i]] or ""
        end
        local reftdisp = ref_table
        if chars then
            reftdisp = string.sub(ref_table,1,chars)
        end
        if not color then
            if not real_check then color = G.C.WHITE 
            elseif ref_table == ref_table2 then color = G.C.GREEN
            else color = G.C.RED end
        end
        return {
            n = G.UIT.R,
            config = {align = align or "cm", padding = 0.1},
            nodes = {{
                n = G.UIT.T,
                config = {text = reftdisp, scale = 0.4, shadow = true, colour = color}
            }}
        }
    end
    local function create_text_box_simple(t, align, color)
        if not color then color = G.C.WHITE end
        return {
            n = G.UIT.R,
            config = {align = align or "cm", padding = 0.1},
            nodes = {{
                n = G.UIT.T,
                config = {text = t, scale = 0.4, shadow = true, colour = color}
            }}
        }
    end
    local function create_dynatext_box(config)
        if not color then color = G.C.WHITE end
        return {
            n = G.UIT.R,
            config = {align = "cm", padding = 0.1},
            nodes = {{
                n = G.UIT.O,
                config = {object = DynaText(config)}
            }}
        }
    end
    local base_node = {
        create_dynatext_box{string = "Base Checks", colours = {G.C.WHITE}, bump = true, float = true, scale = 0.7},
        {
            n = G.UIT.R,
            config = {align = "cm", padding = 0},
            nodes = {
                {
                    n = G.UIT.C,
                    config = {align = "cm", padding = 0},
                    nodes = {
                        create_text_box_simple("Balatro Version","cl"),
                        create_text_box_simple("Ankh Version","cl"),
                        create_text_box_simple("Lovely Version","cl"),
                        create_text_box_simple("Operating System","cl"),
                        create_text_box_simple("Balatro Hash","cl"),
                        create_text_box_simple("Lovely Hash","cl")
                    },
                },
                {
                    n = G.UIT.C,
                    config = {align = "cm", padding = 0},
                    nodes = {
                        create_text_box({"ver"},"cr"),
                        create_text_box({"ankh_ver"},"cr"),
                        create_text_box({"lovely_ver"},"cr"),
                        create_text_box({"os"},"cr"),
                        create_text_box({"exe_hash"},"cr",nil,8),
                        create_text_box({"lovely_hash"},"cr",nil,8),
                    },
                },
            },
        }
    }
    local mod_names = {}
    local mod_vers = {}
    local mod_hashes = {}
    local mod_keys = {}
    for k, v in pairs(DejaVu.RedSeal.mods) do
        mod_keys[#mod_keys+1] = k
    end
    table.sort(mod_keys)
    for _, k in ipairs(mod_keys) do
        v = DejaVu.RedSeal.mods[k]
        mod_names[#mod_names+1] = create_text_box({"mods",k,"name"},"cl")
        mod_vers[#mod_vers+1] = create_text_box({"mods",k,"ver"},"cl")
        mod_hashes[#mod_hashes+1] = create_text_box({"mods",k,"hash"},"cr",nil,8)
    end
    mod_page_names = {}
    for i = 1, (#mod_names+4)/5 do
        mod_page_names[i] = localize('k_page')..' '..tostring(i)..' / '..tostring(math.ceil(#mod_names/5))
    end
    if G.security then
        sec_page_names = {}
        for i = 1, #G.security do
            sec_page_names[i] = 'Snapshot '..tostring(i)..' / '..tostring(#G.security)
        end
    end
    DejaVu.mod_page_num = (DejaVu.mod_page_num or 1)
    local mod_node = {
        create_dynatext_box{string = "Installed Mods", colours = {G.C.WHITE}, bump = true, float = true, scale = 0.7},
        {
            n = G.UIT.R,
            config = {align = "cm", padding = 0},
            nodes = {
                {
                    n = G.UIT.C,
                    config = {align = "cm", padding = 0},
                    nodes = {mod_names[5*DejaVu.mod_page_num-4],mod_names[5*DejaVu.mod_page_num-3],mod_names[5*DejaVu.mod_page_num-2],mod_names[5*DejaVu.mod_page_num-1],mod_names[5*DejaVu.mod_page_num]},
                },
                {
                    n = G.UIT.C,
                    config = {align = "cm", padding = 0},
                    nodes = {mod_vers[5*DejaVu.mod_page_num-4],mod_vers[5*DejaVu.mod_page_num-3],mod_vers[5*DejaVu.mod_page_num-2],mod_vers[5*DejaVu.mod_page_num-1],mod_vers[5*DejaVu.mod_page_num]},
                },
                {
                    n = G.UIT.C,
                    config = {align = "cm", padding = 0},
                    nodes = {mod_hashes[5*DejaVu.mod_page_num-4],mod_hashes[5*DejaVu.mod_page_num-3],mod_hashes[5*DejaVu.mod_page_num-2],mod_hashes[5*DejaVu.mod_page_num-1],mod_hashes[5*DejaVu.mod_page_num]},
                },
            },
        },
        create_option_cycle({options = mod_page_names, w = 1.3, h = 0, cycle_shoulders = true, opt_callback = 'change_mod_list_page', current_option = DejaVu.mod_page_num, text_scale = 0.4, colour = {0,0,0,0}, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
    }
    local col2 = {{
        n = G.UIT.C,
        config = {align = "cm", padding = 0.1, r = 0.1, outline_colour = G.C.GREY, outline = 1},
        nodes = base_node
    },{
        n = G.UIT.C,
        config = {align = "cm", padding = 0.1, r = 0.1, outline_colour = G.C.GREY, outline = 1},
        nodes = mod_node
    },}
    local game_node
    if runSec.game then
        game_node = {
            create_dynatext_box{string = "Run Info", colours = {G.C.WHITE}, bump = true, float = true, scale = 0.7},
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0},
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("Seed","cl"),
                            create_text_box_simple("Ante","cl"),
                            create_text_box_simple("Deck","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("-","cl"),
                            create_text_box_simple("-","cl"),
                            create_text_box_simple("-","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple(runSec.game.seed,"cr",runSec.game.seeded and G.C.RED or G.C.WHITE),
                            create_text_box_simple(runSec.game.ante,"cr",G.C.BLUE),
                            create_text_box_simple(runSec.game.deck,"cr",G.C.FILTER),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("   ","cl"),
                            create_text_box_simple("   ","cl"),
                            create_text_box_simple("   ","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("Time","cl"),
                            create_text_box_simple("Score","cl"),
                            create_text_box_simple("Stake","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("-","cl"),
                            create_text_box_simple("-","cl"),
                            create_text_box_simple("-","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple(runSec.game.time,"cr",G.C.BLUE),
                            create_text_box_simple(runSec.game.score,"cr",G.C.RED),
                            create_text_box_simple(runSec.game.stake,"cr",G.C.FILTER),
                        },
                    },
                },
            },
            {
                n = G.UIT.R,
                config = {align = "cm", padding = 0},
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple("Reroll Type -","cl"),
                        },
                    },
                    {
                        n = G.UIT.C,
                        config = {align = "cm", padding = 0},
                        nodes = {
                            create_text_box_simple(runSec.game.reroll,"cr"),
                        },
                    },
                },
            }
        }
    end
    DejaVu.SecurityUI = {
        n = G.UIT.C,
        config = {align = "cm", padding = 0.1},
        nodes = {{
            n = G.UIT.R,
            config = {align = "cm", padding = 0.1, r = 0.1, outline_colour = game_node and G.C.GREY, outline = game_node and 1},
            nodes = game_node
        },{
            n = G.UIT.R,
            config = {align = "cm", padding = 0.1, r = 0.1},
            nodes = col2
        },
        G.security and create_option_cycle({options = sec_page_names, w = 1.3, h = 0, cycle_shoulders = true, opt_callback = 'change_security_page', current_option = G.security_page, text_scale = 0.4, colour = {0,0,0,0}, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}}) or nil
        }
    }
    return DejaVu.SecurityUI
end

G.FUNCS.change_mod_list_page = function(args)
    DejaVu.mod_page_num = args.to_key
    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID('tab_but_Security')
    G.FUNCS.change_tab(tab_but)
end
G.FUNCS.change_security_page = function(args)
    G.security_page = args.to_key
    local tab_but = G.OVERLAY_MENU:get_UIE_by_ID('tab_but_Security')
    G.FUNCS.change_tab(tab_but)
end
DejaVu.RedSeal = DejaVu.getSecurityInfo()