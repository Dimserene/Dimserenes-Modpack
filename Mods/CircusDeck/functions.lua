local skpac_utils = {}

--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]
--[[ Joker Calc Helper Functions --]]
--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]
joker_counter = 0

function skpac_utils.create_joker(def)
	joker_counter = joker_counter + 1
	def.id = joker_counter
	return def
end

function skpac_utils.getCardKey(card)
	if type(card.key) == "string" then
		return card.key
	elseif card.config and type(card.config) == "table" then
		local center = card.config.center
		if center and type(center) == "table" and type(center.key) == "string" then
			return center.key
		end
	end
	if type(card.label) == "string" then
		return card.label
	end
	return "unknown"
end

--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]
--[[ Deck Helper Functions       --]]
--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]

--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]
--[[ Other Stuff                 --]]
--[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[--]]

function skpac_utils.serialize(tbl, indent, visited)
	indent = indent or ""
	visited = visited or {}
	if visited[tbl] then
		return '"*RECURSION*"'
	end
	visited[tbl] = true
	local parts = {"{"}
	local nextIndent = indent .. "\t"
	for k, v in pairs(tbl) do
		local key = (type(k) == "string") and string.format("%q", k) or ("[" .. tostring(k) .. "]")
		local value
		if type(v) == "table" then
			value = skpac_utils.serialize(v, nextIndent, visited)
		elseif type(v) == "string" then
			value = string.format("%q", v)
		else
			value = tostring(v)
		end
		table.insert(parts, nextIndent .. key .. " : " .. value .. ",")
	end
	table.insert(parts, indent .. "}")
	return table.concat(parts, "\n")
end

function skpac_utils.spawn_voucher(voucher_key)
    -- If no specific voucher is provided, pick the next available voucher
    if not voucher_key then
        if not get_next_voucher_key then
            print("[ERROR] Missing function: get_next_voucher_key()")
            return
        end
        voucher_key = get_next_voucher_key(true)
    end

    -- Ensure the voucher key exists in G.P_CENTERS
    if not G.P_CENTERS[voucher_key] then
        print("[ERROR] Invalid voucher key: " .. tostring(voucher_key))
        return
    end

    -- Increment shop voucher card limit
    G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1

    -- Create and place the voucher in the shop
    local card = Card(
        G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
        G.shop_vouchers.T.y,
        G.CARD_W,
        G.CARD_H,
        G.P_CARDS.empty,
        G.P_CENTERS[voucher_key],
        { bypass_discovery_center = true, bypass_discovery_ui = true }
    )

    -- Assign shop voucher property and update UI
    create_shop_card_ui(card, "Voucher", G.shop_vouchers)
    card.shop_voucher = true
    card:start_materialize()
    G.shop_vouchers:emplace(card)

    print("[INFO] Spawned Voucher: " .. voucher_key)
end

return skpac_utils