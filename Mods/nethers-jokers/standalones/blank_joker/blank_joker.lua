--- STEAMODDED HEADER
--- MOD_NAME: Nether's Blank Joker Standalone
--- MOD_ID: BlankJoker
--- MOD_AUTHOR: [Nether]
--- MOD_DESCRIPTION: Add the Blank Joker to the game!
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0.0

----------------------------------------------
------------MOD CODE -------------------------

-- fix for LOVE acting up in some cases (thanks @MathIsFun)
local shader = NFS.read(SMODS.current_mod.path.."/assets/shaders/".."hologramv2.fs")
love.filesystem.write("temp-hologramv2.fs", shader)
G.SHADERS['hologramv2'] = love.graphics.newShader("temp-hologramv2.fs")
love.filesystem.remove("temp-hologramv2.fs")

function is_in_your_collection(card)
    if not G.your_collection then return false end
    for i = 1, 3 do
        if (G.your_collection[i] and card.area == G.your_collection[i]) then return true end
    end
    return false
end

function check_if_copied_joker_is_still_there(card)
    local other_joker = nil
    if not is_in_your_collection(card) and card.ability.extra.copied_joker then
        -- iterate over G.jokers.cards and find the joker with the same sort_id
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].sort_id == card.ability.extra.copied_joker.sort_id then
                other_joker = G.jokers.cards[i]
                set_new_joker_sprite(card, other_joker)
                break
            end
        end
        if not other_joker then
            set_new_joker_sprite(card, nil)
        end
    end
    return other_joker
end

function set_new_joker_sprite(card, other_joker)
    if not other_joker then -- if no joker is selected, display no soul sprite at all
        card.ability.extra.copied_joker = nil
        card.children.floating_sprite.scale.x = 0
        card.children.floating_sprite.scale.y = 0
        card.children.floating_sprite:reset()
        return
    end
    card.ability.extra.copied_joker = {name = other_joker.ability.name, sort_id = other_joker.sort_id}
    card.children.floating_sprite.atlas = G.ASSET_ATLAS["Joker"]
    card.children.floating_sprite.scale.x = other_joker.children.center.scale.x
    card.children.floating_sprite.scale.y = other_joker.children.center.scale.y
    card.children.floating_sprite:set_sprite_pos(other_joker.config.center.pos)
    card.children.floating_sprite:reset()
end

SMODS.Atlas{
    key = "blankjoker",
    path = "joker_blankjoker.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "blankjoker",
    name = "Blank Joker", -- don't change this, it is hardcoded into the lovely injection to insert the code for the hologram effect for the soul sprite
    rarity = 3, -- Rare
    discovered = true,
    unlocked = true,
    cost = 8, -- tbd
    blueprint_compat = true, -- can also be copied
    loc_txt = {
        name = "Blank Joker",
        text = {
            "Copies the scoring",
            "of a {C:attention}random Joker{}",
            "{C:red}Changes every blind{}",
            "{C:inactive}(Currently: {X:inactive,C:white}#1#{}{C:inactive}){}"
        }
    },
    atlas = "blankjoker",
    soul_pos = {x = 0, y = 0},
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra = card.ability.extra or {}
        set_new_joker_sprite(card, nil)
    end,
    set_sprites = function(self, card, front)
        if not card.ability then return end
        set_new_joker_sprite(card, check_if_copied_joker_is_still_there(card))
    end,
    loc_vars = function(self, info_queue, card)
        check_if_copied_joker_is_still_there(card)
        return is_in_your_collection(card) and nil or {vars={
                (card.ability.extra.copied_joker and card.ability.extra.copied_joker.name or "None"),
            }}
        end,
    calculate = function(self, card, context)
        -- check if copied joker is being sold
        if context.selling_card then
            other_joker = check_if_copied_joker_is_still_there(card)
            if other_joker then
                if context.card.sort_id == card.ability.extra.copied_joker.sort_id then
                    set_new_joker_sprite(card, nil)
                end
            end
        end

        -- select new random joker
        if context.setting_blind then
            local jokers = G.jokers.cards
            -- collect all jokers with blueprint_compat (that are not self) into a table
            local jokers_with_blueprint_compat = {}
            for i = 1, #jokers do
                if jokers[i] ~= card and jokers[i].config.center.blueprint_compat then
                    table.insert(jokers_with_blueprint_compat, jokers[i])
                end
            end
            -- pick random joker out of table
            local other_joker = jokers_with_blueprint_compat[math.random(1, #jokers_with_blueprint_compat)]
            
            if not other_joker then return end -- failsafe
            
            -- save picked joker for later use
            set_new_joker_sprite(card, other_joker)
        end

        -- calculate scoring
        if not is_in_your_collection(card) and card.ability.extra.copied_joker then
            local other_joker = nil
            -- iterate over G.jokers.cards and find the joker with the same sort_id
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].sort_id == card.ability.extra.copied_joker.sort_id then
                    other_joker = G.jokers.cards[i]
                    set_new_joker_sprite(card, other_joker)
                    break
                end
            end
            if not other_joker then
                set_new_joker_sprite(card, nil)
                return
            end

            context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
            context.blueprint_card = context.blueprint_card or card
            if context.blueprint > #G.jokers.cards + 1 then return end
            local other_joker_ret = other_joker:calculate_joker(context)
            if other_joker_ret then 
                other_joker_ret.card = context.blueprint_card or card
                other_joker_ret.colour = G.C.RED
                return other_joker_ret
            end
        end
    end
}