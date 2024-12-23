--- STEAMODDED HEADER
--- MOD_NAME: Contracts
--- MOD_ID: NH
--- PREFIX: nh
--- MOD_AUTHOR: [mathguy]
--- MOD_DESCRIPTION: Contracts
--- VERSION: 0.0.0
----------------------------------------------
------------MOD CODE -------------------------

function SMODS.current_mod.process_loc_text()
    G.localization.misc.dictionary["b_sign"] = "SIGN"
    G.localization.misc.dictionary["b_contracts"] = "Contracts"
    G.localization.misc.dictionary["k_contract"] = "Contract"
    G.localization.misc.dictionary["ph_contracts_signed"] = "Contracts signed this run"
    G.localization.misc.dictionary["ph_no_contracts"] = "No contracts signed this run"
    G.localization.descriptions["Contract"] = {}
    G.localization.descriptions["Contract"]["cn_nh_contract"] = {
        name = "Contract",
        text = {
            "Sign Here",
        }
    }
end

G.FUNCS.can_sign = function(e)
    e.config.colour = G.C.GREEN
    e.config.button = 'sign_contract'
end

SMODS.Contract = SMODS.Center:extend {
    set = 'Contract',
    cost = 0,
    atlas = 'Contract',
    discovered = true,
    unlocked = true,
    available = true,
    pos = { x = 0, y = 0 },
    config = {},
    class_prefix = 'cn',
    required_params = {
        'key',
    },
    weight = 1
}

SMODS.Atlas({ key = "Contract", atlas_table = "ASSET_ATLAS", path = "Contracts.png", px = 71, py = 95})


SMODS.Contract {
    key = 'loan',
    loc_txt = {
        name = "Loan",
        text = {
            "{C:money}+$20{}. {C:red}-$4{} when",
            "blind is selected",
        }
    },
    config = {},
    atlas = 'Contract',
    pos = {x = 1, y = 0},
    apply = function(self)
        ease_dollars(20)
    end
}

SMODS.Contract {
    key = 'brand',
    loc_txt = {
        name = "Brand Deal",
        text = {
            "{C:attention}+1{} Joker Slot. You may not",
            "buy non-{C:green}Uncommon{} {C:attention}Jokers{}",
        }
    },
    config = {},
    atlas = 'Contract',
    pos = {x = 3, y = 0},
    apply = function(self)
        G.E_MANAGER:add_event(Event({func = function()
            if G.jokers then 
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
            end
        return true end }))
    end
}

SMODS.Contract {
    key = 'space',
    loc_txt = {
        name = "Space Agreement",
        text = {
            "Level up {C:attention}most played poker hand{}",
            "{C:attention}5{} times. You may only play",
            "your {C:attention}most played poker hand{}"
        }
    },
    config = {},
    atlas = 'Contract',
    pos = {x = 2, y = 0},
    apply = function(self)
        level_up_hand(nil, G.GAME.contract_data.most_played, true, 5)
    end
}

SMODS.Contract {
    key = 'purchase',
    loc_txt = {
        name = "Purchase Agreement",
        text = {
            "All {C:attention}Jokers{} and {C:attention}Buffoon Packs{}",
            "are {C:attention}80%{} off. You can only",
            "buy/open {C:attention}Jokers{} and {C:attention}Buffoon Packs{}."
        }
    },
    config = {},
    atlas = 'Contract',
    pos = {x = 4, y = 0},
    apply = function(self)
      G.E_MANAGER:add_event(Event({func = function()
          for k, v in pairs(G.I.CARD) do
              if v.set_cost then v:set_cost() end
          end
          return true end }))
    end
}

SMODS.Contract {
  key = 'green',
  loc_txt = {
      name = "Enviromental Act",
      text = {
          "No {C:blue}Common{} {C:attention}Jokers{} or normal {C:attention}Packs{}",
          "in shop. You may never {C:red}discard{}."
      }
  },
  config = {},
  atlas = 'Contract',
  pos = {x = 0, y = 1},
  apply = function(self)
    G.E_MANAGER:add_event(Event({func = function()
        if G.shop_jokers then
            local remove = {}
            for k, v in pairs(G.shop_jokers.cards) do
                if (v.ability) and (v.ability.set == 'Joker') and (v.config.center.rarity == 1) then
                    table.insert(remove, v)
                end
            end
            for k, v in ipairs(remove) do
                G.shop_jokers:remove_card(v)
                v:start_dissolve()
            end
        end
        if G.shop_booster then
            local remove = {}
            for k, v in pairs(G.shop_booster.cards) do
                if not v.ability.name:find('Jumbo') and not v.ability.name:find('Mega') then
                    table.insert(remove, v)
                end
            end
            for k, v in ipairs(remove) do
                G.shop_booster:remove_card(v)
                v:start_dissolve()
            end
        end
    return true end }))
  end
}

SMODS.UndiscoveredSprite { key = 'Contract', atlas = 'Contract', pos = {x = 0, y = 0} }

function create_UIBox_your_collection_contracts()
    local deck_tables = {}
  
    G.your_collection = {}
    for j = 1, 2 do
      G.your_collection[j] = CardArea(
        G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
        5*G.CARD_W,
        0.95*G.CARD_H, 
        {card_limit = 5, type = 'title', highlight_limit = 0, collection = true})
      table.insert(deck_tables, 
      {n=G.UIT.R, config={align = "cm", padding = 0.07, no_fill = true}, nodes={
        {n=G.UIT.O, config={object = G.your_collection[j]}}
      }}
      )
    end
  
    local contract_options = {}
    for i = 1, math.ceil(#G.P_CENTER_POOLS.Contract/(5*#G.your_collection)) do
      table.insert(contract_options, localize('k_page')..' '..tostring(i)..'/'..tostring(math.ceil(#G.P_CENTER_POOLS.Contract/(5*#G.your_collection))))
    end
  
    for i = 1, 5 do
      for j = 1, #G.your_collection do
        local center = G.P_CENTER_POOLS["Contract"][i+(j-1)*5]
        if not center then break end
        local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, nil, center)
        G.your_collection[j]:emplace(card)
      end
    end
  
    INIT_COLLECTION_CARD_ALERTS()
    
    local t =  create_UIBox_generic_options({ back_func = 'your_collection', contents = {
        {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.C.BLACK, emboss = 0.05}, nodes=deck_tables}, 
        {n=G.UIT.R, config={align = "cm"}, nodes={
          create_option_cycle({options = contract_options, w = 4.5, cycle_shoulders = true, opt_callback = 'your_collection_contact_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }}
    }})
  return t
end

G.FUNCS.your_collection_contract_page = function(args)
    if not args or not args.cycle_config then return end
    for j = 1, #G.your_collection do
        for i = #G.your_collection[j].cards,1, -1 do
            local c = G.your_collection[j]:remove_card(G.your_collection[j].cards[i])
            c:remove()
            c = nil
        end
    end
    for i = 1, 5 do
        for j = 1, #G.your_collection do
            local center = G.P_CENTER_POOLS["Contract"][i+(j-1)*5 + (5*#G.your_collection*(args.cycle_config.current_option - 1))]
            if not center then break end
            local card = Card(G.your_collection[j].T.x + G.your_collection[j].T.w/2, G.your_collection[j].T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, center)
            G.your_collection[j]:emplace(card)
        end
    end
    INIT_COLLECTION_CARD_ALERTS()
end

G.FUNCS.your_collection_contracts = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_your_collection_contracts(),
    }
end

G.FUNCS.sign_contract = function(e)
    local c1 = e.config.ref_table
    if c1 and c1:is(Card) then
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                local obj = c1.config.center
                if obj and obj.apply and type(obj.apply) == "function" then
                    obj:apply()
                end
                G.GAME.contracts[obj.key] = true
                c1.area:remove_card(c1)
                c1:remove()
                if c1.children.price then c1.children.price:remove() end
                c1.children.price = nil
                if c1.children.buy_button then c1.children.buy_button:remove() end
                c1.children.buy_button = nil
                remove_nils(c1.children)

                if G.GAME.modifiers.inflation then 
                    G.GAME.inflation = G.GAME.inflation + 1
                    G.E_MANAGER:add_event(Event({func = function()
                    for k, v in pairs(G.I.CARD) do
                        if v.set_cost then v:set_cost() end
                    end
                    return true end }))
                end

                play_sound('card1')
                G.CONTROLLER:save_cardarea_focus('jokers')
                G.CONTROLLER:recall_cardarea_focus('jokers')
                return true
            end
        }))
    end
end

function G.UIDEF.signed_contracts()
    local silent = false
    local keys_used = {}
    local area_count = 0
    local contract_rows = {}
    local contract_areas = {}
    local contract_tables = {}
    local contract_tables_final = {}
    local i = 0
    for k, v in pairs(G.GAME.contracts) do
        local key = 1 + math.floor(i / 6)
        contract_rows[key] = contract_rows[key] or {}
        contract_rows[key][#contract_rows[key]+1] = k
        i = i + 1
    end
    -- for k, v in ipairs(keys_used) do 
    --   if next(v) then
    --     area_count = area_count + 1
    --   end
    -- end
    for k, v in pairs(contract_rows) do
        if next(v) then
          -- if #voucher_areas == 5 or #voucher_areas == 10 then 
          --   table.insert(voucher_table_rows, 
          --   {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=voucher_tables}
          --   )
          --   voucher_tables = {}
          -- end
          contract_areas[#contract_areas + 1] = CardArea(
          G.ROOM.T.x + 0.2*G.ROOM.T.w/2,G.ROOM.T.h,
          (#v == 1 and 1 or 1.02)*G.CARD_W*#v,
          1.07*G.CARD_H, 
          {card_limit = #v, type = 'voucher', highlight_limit = 0})
          for kk, vv in ipairs(v) do 
            local center = G.P_CENTERS[vv]
            local card = Card(contract_areas[#contract_areas].T.x + contract_areas[#contract_areas].T.w/2, contract_areas[#contract_areas].T.y, G.CARD_W, G.CARD_H, nil, center, {bypass_discovery_center=true,bypass_discovery_ui=true,bypass_lock=true})
            card.ability.order = kk
            card:start_materialize(nil, silent)
            silent = true
            contract_areas[#contract_areas]:emplace(card)
          end
          table.insert(contract_tables, 
          {n=G.UIT.C, config={align = "cm", padding = 0, no_fill = true}, nodes={
            {n=G.UIT.O, config={object = contract_areas[#contract_areas]}}
          }}
          )
        end
    end
    table.insert(contract_tables_final,
            {n=G.UIT.R, config={align = "cm", padding = 0, no_fill = true}, nodes=contract_tables}
          )
    local t = silent and {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
          {n=G.UIT.R, config={align = "cm"}, nodes={
              {n=G.UIT.O, config={object = DynaText({string = {localize('ph_contracts_signed')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
          }},
          {n=G.UIT.R, config={align = "cm", minh = 0.5}, nodes={
          }},
          {n=G.UIT.R, config={align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05}, nodes={
              {n=G.UIT.R, config={align = "cm"}, nodes=contract_tables_final},
          }}
      }} or 
      {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes={
          {n=G.UIT.O, config={object = DynaText({string = {localize('ph_no_contracts')}, colours = {G.C.UI.TEXT_LIGHT}, bump = true, scale = 0.6})}}
      }}
    return t
end

function contract_can_buy(card)
    if G.GAME.contracts.cn_nh_brand and (card.ability.set == 'Joker') and (card.config.center.rarity ~= 2) then
        return false
    end
    if G.GAME.contracts.cn_nh_purchase and (card.ability.set ~= 'Joker') then
        return false
    end
    return true
end

function contract_can_open(card)
    if G.GAME.contracts.cn_nh_purchase and (card.ability.set == 'Booster') and not card.ability.name:find('Buffoon') then
        return false
    end
    return true
end

function contract_can_play()
    if G.GAME.contracts.cn_nh_space and (G.GAME.contract_data.most_played ~= G.GAME.contract_data.current_hand) then
        return false
    end
    return true
end

function contract_can_discard()
    if G.GAME.contracts.cn_nh_green then
        return false
    end
    return true
end

function get_contract()
    local pool = {}
    local total = 0
    for i, j in pairs(self.P_CENTER_POOLS["Contract"]) do
        total = total + (j.weight or 1)
    end
end

local old_set = Card.set_cost
function Card:set_cost()
    old_set(self)
    if G.GAME.contracts.cn_nh_purchase and ((self.ability.set == 'Joker') or (self.ability.set == 'Booster' and self.ability.name:find('Buffoon'))) then
        self.cost = math.ceil(self.cost * 0.2)
    end
end

local old_pack = get_pack
function get_pack(_key, _type)
    local old = old_pack(_key, _type)
    if G.GAME.contracts.cn_nh_green then
        if not G.GAME.first_shop_buffoon and not G.GAME.banned_keys['p_buffoon_jumbo_1'] then
            G.GAME.first_shop_buffoon = true
            return G.P_CENTERS['p_buffoon_jumbo_1']
        end
        local new_pool = {}
        for k, v in pairs(G.P_CENTERS) do
            if v.set == "Booster" and not string.find(k, "normal") then
                table.insert(new_pool, v)
            end
        end
        local old_pool = G.P_CENTER_POOLS['Booster']
        G.P_CENTER_POOLS['Booster'] = new_pool
        local new = old_pack(_key, _type)
        G.P_CENTER_POOLS['Booster'] = old_pool
        return new
    end
    return old
end

local old_can_play = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
    old_can_play(e)
    if e.config.button ~= nil then
        if not contract_can_play() then
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end
end

function contract_allowed()
    if G.P_CENTER_POOLS.Contract then
        for i, j in pairs(G.P_CENTER_POOLS.Contract) do
            if G.GAME.contracts and not G.GAME.contracts[j.key] then
                return true
            end
        end
    end
    return false
end

function get_contract()
    if G.P_CENTER_POOLS.Contract then
        local pool = {}
        for i, j in pairs(G.P_CENTER_POOLS.Contract) do
            if G.GAME.contracts and not G.GAME.contracts[j.key] then
                table.insert(pool, j.key)
            end
        end
        if #pool > 0 then
            local key = pseudorandom_element(pool, pseudoseed('contract' .. G.GAME.round))
            return key
        end
    end
    return 'cn_nh_loan'
end

----------------------------------------------
------------MOD CODE END----------------------