--- STEAMODDED HEADER
--- MOD_NAME: House Rules
--- MOD_ID: HouseRules
--- MOD_AUTHOR: [Mysthaps]
--- MOD_DESCRIPTION: Adds difficulty modifiers for your runs, stackable with stakes. Thanks Eremel for Galdur support!
--- VERSION: 1.4.3

--[[

TODO:
Properly implement mod support
Rewrite pages so that it automatically adds a new page whenever more than 12 modifiers are added

]]--

local localization = {
    b_modifiers_cap = "Modifiers",
    ph_six_card_hands = "Must play 6 card hand types",
    m_minus_discard = "-1 hand",
    m_minus_hand = "-1 discard",
    m_minus_hand_size = "-1 hand size",
    m_minus_consumable_slot = "-1 consumable slot",
    m_minus_joker_slot = "-1 Joker slot",
    m_minus_starting_dollars = "-$4 starting dollars",
    m_increased_blind_size = "X2 base Blind size",
    m_increased_reroll_cost = "+$1 reroll cost",
    m_minus_shop_card = "-1 card slot available in shop",
    m_minus_shop_booster = "-1 Booster Pack available in shop",
    m_flipped_cards = "1 in 4 cards are drawn face down",
    m_all_eternal_mod = "All Jokers are Eternal",
    m_no_interest = "Earn no Interest at end of round",
    m_no_extra_hand_money = "Extra Hands no longer earn money",
    m_debuff_played_cards = "All Played cards become debuffed after scoring",
    m_inflation = "Permanently raise prices by $1 on every purchase",
    m_no_shop_jokers = "Jokers no longer appear in the shop",
    m_discard_cost = "Discards each cost $1",
    m_all_perishable = "All Jokers are Perishable",
    m_all_rental = "All Jokers are Rental",
    m_perishable_early = "Perishable debuffs Jokers 2 rounds earlier",
    m_rental_increase = "Rental Jokers take $1 more each round",
    m_booster_ante_scaling = "Booster Packs cost $1 more per Ante",
    m_booster_less_choices = "Booster Packs offer 1 less choice",
    m_minus_hand_size_per_X_dollar = "-1 hand size for every $5 you have",
    m_debuff_common = "All Common Jokers are debuffed",
    m_debuff_uncommon = "All Uncommon Jokers are debuffed",
    m_debuff_rare = "All Rare Jokers are debuffed",
    m_set_eternal_ante = "When Ante 4 boss is defeated, all Jokers become Eternal",
    m_set_joker_slots_ante = "When Ante 4 boss is defeated, set Joker slots to 0",
    m_chips_dollar_cap = "Chips cannot exceed the current $",
    m_all_pinned = "All Jokers are Pinned",
    --m_no_back_effects = "Disable all Deck effects",
    m_all_jokers_flipped = "All Jokers in shop and Booster Packs are flipped",
    m_all_consumables_flipped = "All consumables in shop and Booster Packs are flipped",
    gald_house_rules = "House Rules"
}

local all_modifiers = {
    -- Basic
    "minus_discard",
    "minus_hand",
    "minus_hand_size",
    "minus_consumable_slot",
    "minus_joker_slot",
    "minus_starting_dollars",
    "increased_blind_size",
    "increased_reroll_cost",
    "minus_shop_card",
    "minus_shop_booster",
    "booster_less_choices", 
    "",

    -- Challenges
    "flipped_cards",
    "no_shop_jokers",
    "no_interest",
    "no_extra_hand_money",
    "debuff_played_cards",
    "inflation",
    "discard_cost",
    "minus_hand_size_per_X_dollar",
    "set_eternal_ante",
    "set_joker_slots_ante",
    "chips_dollar_cap",
    "",

    -- Jokers
    "all_eternal_mod",
    "all_perishable",
    "all_rental",
    "all_pinned",
    "perishable_early",
    "rental_increase",
    "debuff_common",
    "debuff_uncommon",
    "debuff_rare",
    "all_jokers_flipped",
    "all_consumables_flipped",
    "",

    -- Legacy
    "booster_ante_scaling",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "", 
    "", 
    "", 
    "", 
}

-- localization
function SMODS.current_mod.process_loc_text()
    for k, v in pairs(localization) do
        SMODS.process_loc_text(G.localization.misc.dictionary, k, v)
    end
end

-- default values
G.HouseRules_modifiers = {}
for _, v in ipairs(all_modifiers) do 
    if v ~= "" then G.HouseRules_modifiers[v] = false end 
end

sendDebugMessage("Loaded HouseRules~")

---- HouseRules UI

-- Add "Modifiers" button
local run_setup_optionref = G.UIDEF.run_setup_option
function G.UIDEF.run_setup_option(type)
    local t = run_setup_optionref(type)
    if Galdur then return t end
    local button = 
    { n = G.UIT.R, config = { align = "cm", padding = 0 }, nodes = {
        { n = G.UIT.C, config = { align = "cm", minw = 2.4 }, nodes = {} },
        { n = G.UIT.C,
            config = { align = "cm", minw = 2.6, minh = 0.6, padding = 0.2, r = 0.1, hover = true, colour = G.C.RED, button = "modifiers", shadow = true },
            nodes = {{
                n = G.UIT.R, config = { align = "cm", padding = 0 },
                nodes = {
                    { n = G.UIT.T, config = { text = localize('b_modifiers_cap'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true, func = 'set_button_pip', focus_args = { button = 'x', set_button_pip = true } } }
                }
            }}
        },
        { n = G.UIT.C, config = { align = "cm", minw = 2.5 }, nodes = {} }
    }}
    table.insert(t.nodes, 3, button)
    return t
end

-- Create a modifier row
function add_modifier_node(modifier_name, run_info)
    if not modifier_name or modifier_name == "" then
        if Galdur then return end
        return
        { n = G.UIT.R, config = {align = "c", minw = 8, padding = 0, colour = G.C.CLEAR}, nodes = {
            {n = G.UIT.C, config = { align = "cr", padding = 0.1 }, nodes = {}},
            {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
                { n = G.UIT.T, config = { text = "", scale = 0.9175, colour = G.C.UI.TEXT_LIGHT, shadow = true }},
            }},
        }}
    end
    return 
    { n = G.UIT.R, config = {align = "c", minw = 8, padding = 0, colour = G.C.CLEAR}, nodes = {
        {n = G.UIT.C, config = { align = Galdur and "cl" or "cr", padding = not Galdur and 0.1 }, nodes = {
            run_info and nil or create_toggle{ col = true, label = "", w = 0, scale = Galdur and 0.5 or 0.6, shadow = true, ref_table = G.HouseRules_modifiers, ref_value = modifier_name },
        }},
        {n = G.UIT.C, config = { align = "c", padding = 0 }, nodes = {
            { n = G.UIT.T, config = { text = localize('m_'..modifier_name), scale = Galdur and 0.27 or 0.3, colour = G.C.UI.TEXT_LIGHT, shadow = true }},
        }},
    }}
end

-- UIBox for modifiers
function create_UIBox_modifiers()
    local page_options = {
        "Basic",
        "Challenges",
        "Jokers",
        "Legacy",
    }

    G.E_MANAGER:add_event(Event({func = (function()
        G.FUNCS.modifiers_change_page{cycle_config = {current_option = 1}}
    return true end)}))

    local t = create_UIBox_generic_options({ back_id = G.STATE == G.STATES.GAME_OVER and 'from_game_over', back_func = 'setup_run', contents = {
        { n = G.UIT.R, config = { align = "cm", padding = 0.1, minh = Galdur and 6 or 9, minw = 4.2 }, nodes = {
            { n = G.UIT.O, config = { id = 'modifiers_list', object = Moveable() }},
        }},
        { n = G.UIT.R, config = { align = "cm" }, nodes = {
            create_option_cycle({options = page_options, w = 4.5, cycle_shoulders = true, opt_callback = 'modifiers_change_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }},
    }})
    return t
end

G.FUNCS.modifiers = function(e)
    G.SETTINGS.paused = true
    G.FUNCS.overlay_menu{
        definition = create_UIBox_modifiers(),
    }
end

-- Page buttons
G.FUNCS.modifiers_change_page = function(args)
    if not args or not args.cycle_config then return end
    if G.OVERLAY_MENU then
        local m_list = G.OVERLAY_MENU:get_UIE_by_ID('modifiers_list')
        if m_list then
            if m_list.config.object then
                m_list.config.object:remove()
            end
            m_list.config.object = UIBox {
                definition = modifiers_page(args.cycle_config.current_option - 1),
                config = { offset = { x = 0, y = 0 }, align = 'cm', parent = m_list }
            }
        end
    end
end

function modifiers_page(_page)
    local modifiers_list = {}
    for k, v in ipairs(all_modifiers) do
        if k > 12 * (_page or 0) and k <= 12 * ((_page or 0) + 1) then
            modifiers_list[#modifiers_list + 1] = add_modifier_node(v)
        end
    end

    for _ = #modifiers_list+1, 12 do
        modifiers_list[#modifiers_list + 1] = add_modifier_node(nil)
    end
  
    return {n=G.UIT.ROOT, config={align = Galdur and "tl" or "c", padding = 0, colour = G.C.CLEAR}, nodes = modifiers_list}
end

---- Apply Modifiers to run
local start_runref = Game.start_run
function Game.start_run(self, args)
    if args.savetext then
        start_runref(self, args)
        return
    end

    args.challenge = args.challenge or {
        rules = {
            custom = {},
            modifiers = {},
        }
    }

    for k, v in pairs(args.challenge.rules.custom) do
        sendDebugMessage(v.id)
    end

    start_runref(self, args)

    -- hmst
    for k, v in pairs(G.HouseRules_modifiers) do
        if v then
            if k == "flipped_cards" then G.GAME.modifiers.flipped_cards = 4
            elseif k == "discard_cost" then G.GAME.modifiers.discard_cost = 1
            elseif k == "minus_hand_size_per_X_dollar" then G.GAME.modifiers.minus_hand_size_per_X_dollar = 5
            elseif k == "set_eternal_ante" then G.GAME.modifiers.set_eternal_ante = 4
            elseif k == "no_shop_jokers" then G.GAME.joker_rate = 0
            else G.GAME.modifiers[k] = true end
        end
    end

    if G.GAME.modifiers.minus_discard then 
        self.GAME.starting_params.discards = self.GAME.starting_params.discards - 1 
        self.GAME.round_resets.discards = self.GAME.starting_params.discards
        self.GAME.current_round.discards_left = self.GAME.starting_params.discards
    end
    if G.GAME.modifiers.minus_hand then 
        self.GAME.starting_params.hands = self.GAME.starting_params.hands - 1 
        self.GAME.round_resets.hands = self.GAME.starting_params.hands
        self.GAME.current_round.hands_left = self.GAME.starting_params.hands
    end
    if G.GAME.modifiers.minus_consumable_slot then 
        self.GAME.starting_params.consumable_slots = self.GAME.starting_params.consumable_slots - 1
        G.consumeables.config.card_limit = self.GAME.starting_params.consumable_slots
    end
    if G.GAME.modifiers.minus_hand_size then 
        self.GAME.starting_params.hand_size = self.GAME.starting_params.hand_size - 1 
        G.hand.config.card_limit = self.GAME.starting_params.hand_size
    end
    if G.GAME.modifiers.minus_joker_slot then 
        self.GAME.starting_params.joker_slots = self.GAME.starting_params.joker_slots - 1
        G.jokers.config.card_limit = self.GAME.starting_params.joker_slots
    end
    if G.GAME.modifiers.minus_starting_dollars then 
        self.GAME.starting_params.dollars = self.GAME.starting_params.dollars - 4
        self.GAME.dollars = self.GAME.starting_params.dollars
    end
    if G.GAME.modifiers.increased_reroll_cost then 
        self.GAME.starting_params.reroll_cost = self.GAME.starting_params.reroll_cost + 1 
        self.GAME.round_resets.reroll_cost = self.GAME.starting_params.reroll_cost
        self.GAME.base_reroll_cost = self.GAME.starting_params.reroll_cost
        self.GAME.round_resets.reroll_cost = self.GAME.base_reroll_cost
        self.GAME.current_round.reroll_cost = self.GAME.base_reroll_cost
    end
    if G.GAME.modifiers.increased_blind_size then
        self.GAME.starting_params.ante_scaling = self.GAME.starting_params.ante_scaling * 2
    end
    if G.GAME.modifiers.minus_shop_card then G.GAME.shop.joker_max = G.GAME.shop.joker_max - 1 end
    if G.GAME.modifiers.perishable_early then G.GAME.perishable_rounds = G.GAME.perishable_rounds - 2 end
    if G.GAME.modifiers.rental_increase then G.GAME.rental_rate = G.GAME.rental_rate + 1 end
end


-- booster_less_choices
local shopref = G.UIDEF.shop
function G.UIDEF.shop()
    local t = shopref()
    if G.GAME.modifiers["minus_shop_booster"] then
        if G.GAME.modifiers.minus_shop_booster then 
            G.shop_booster.config.card_limit = G.shop_booster.config.card_limit - 1
            t.nodes[1].nodes[1].nodes[1].nodes[1].nodes[3].nodes[2].nodes[1].config = { object = G.shop_booster }
        end
    end
    return t
end

-- this will destroy every booster generated over the limit every frame. will not fix
local update_shopref = Game.update_shop
function Game.update_shop(self, dt)
    update_shopref(self, dt)
    if G.GAME.modifiers["minus_shop_booster"] then
        if #G.shop_booster.cards > G.shop_booster.config.card_limit then
            G.shop_booster.cards[#G.shop_booster.cards]:remove()
        end
    end
end

-- joker mods
local create_cardref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    local card = create_cardref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if _type == "Joker" or _type == "Abnormality" then
        if G.GAME.modifiers.all_eternal_mod then
            card:set_eternal(true)
        end
        if G.GAME.modifiers.all_perishable then
            card:set_perishable(true)
        end
        if G.GAME.modifiers.all_rental then
            card:set_rental(true)
        end
        if G.GAME.modifiers.all_pinned then
            card.pinned = true
        end
        if G.GAME.modifiers.all_flipped then
            card.facing = 'back'
            card.sprite_facing = 'back'
            card.pinch.x = false
        end
    end
    return card
end

local set_perishableref = Card.set_perishable
function Card.set_perishable(self, _perishable)
    set_perishableref(self, _perishable)
    if G.GAME.modifiers.all_perishable then
        self.ability.perishable = true
        self.ability.perish_tally = G.GAME.perishable_rounds
    end
end

local set_eternalref = Card.set_eternal
function Card.set_eternal(self, _eternal)
    set_eternalref(self, _eternal)
    if G.GAME.modifiers.all_eternal_mod or
       (G.GAME.modifiers.set_eternal_ante and (G.GAME.round_resets.ante == G.GAME.modifiers.set_eternal_ante)) then
        self.ability.eternal = true
    end
end

-- booster_less_choices
-- debuff rarity
local set_abilityref = Card.set_ability
function Card.set_ability(self, center, initial, delay_sprites)
    set_abilityref(self, center, initial, delay_sprites)
    if G.GAME.modifiers.booster_less_choices then
        if self.ability.set == "Booster" then
            self.ability.extra = self.ability.extra - 1
        end
    end
    if self.ability.set == "Joker" then
        if G.GAME.modifiers.debuff_common and self.config.center.rarity == 1 or
        G.GAME.modifiers.debuff_uncommon and self.config.center.rarity == 2 or
        G.GAME.modifiers.debuff_rare and self.config.center.rarity == 3 then
            self.ability.perma_debuff = true
        end
    end
end

local generate_card_uiref = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if G.GAME.modifiers.booster_less_choices then
        if _c.set == "Booster" then
            _c.config.extra = _c.config.extra - 1
        end
    end
    local obj = generate_card_uiref(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if G.GAME.modifiers.booster_less_choices then
        if _c.set == "Booster" then
            _c.config.extra = _c.config.extra + 1
        end
    end
    return obj
end

-- all_flipped
local cardarea_emplaceref = CardArea.emplace
function CardArea.emplace(self, card, location, stay_flipped)
    cardarea_emplaceref(self, card, location, stay_flipped)
    if (self == G.shop_jokers or self == G.pack_cards) and 
       ((card.ability.set == "Joker" and G.GAME.modifiers.all_jokers_flipped) or
       (card.ability.consumeable and G.GAME.modifiers.all_consumables_flipped)) then
        card.facing = 'back' 
        card.sprite_facing = 'back'
        card.pinch.x = false
    end
end

local function galdur_page()
    Galdur.include_deck_preview()
    Galdur.include_chip_tower()


    local page_options = {
        "Basic",
        "Challenges",
        "Jokers",
        "Legacy",
    }
    G.E_MANAGER:add_event(Event({func = (function()
        G.FUNCS.modifiers_change_page{cycle_config = {current_option = 1}}
    return true end)}))

    return 
    {n=G.UIT.ROOT, config={align = "tm", minh = 3.8, colour = G.C.CLEAR, padding=0.1}, nodes={
        {n=G.UIT.C, config = {padding = 0.15}, nodes ={   
            {n=G.UIT.R, config={align = "cm", minh = 0.45+G.CARD_H+G.CARD_H, minw = 10.7, colour = G.C.BLACK, padding = 0.15, r = 0.1, emboss = 0.05}, nodes = {
                    { n = G.UIT.O, config = { id = 'modifiers_list', object = Moveable() }},
            }},
            create_option_cycle({options = page_options, w = 4.5, cycle_shoulders = true, opt_callback = 'modifiers_change_page', current_option = 1, colour = G.C.RED, no_pips = true, focus_args = {snap_to = true, nav = 'wide'}})
        }},
        Galdur.display_chip_tower(),
        Galdur.display_deck_preview()
    }}
end

if Galdur then
    Galdur.add_new_page({
        definition = galdur_page,
        name = 'gald_house_rules',
        -- pre_start = pre_game_start,
        -- post_start = post_game_start
    })
end