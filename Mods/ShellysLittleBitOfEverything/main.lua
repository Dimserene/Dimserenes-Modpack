--- the actual code starts here ---

sendInfoMessage("Launched", "Shellular's Little Bit Of Everything")

ShellularDecks = {}
ShellularDecks.path = SMODS.current_mod.path
ShellularDecks.config = SMODS.current_mod.config

--atlas and sound definitions
SMODS.Atlas({
    key = "joker_atlas",
    path = "jokers.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "deck_atlas",
    path = "decks.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "enhancement_atlas",
    path = "enhancements.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "consumable_atlas",
    path = "consumables.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "modicon",
    path = "icon.png",
    px = 34,
    py = 34
})

SMODS.Sound({
	vol = 1,
	pitch = 1,
	key = 'reflect',
	path = 'reflect.ogg'
})

SMODS.Sound({
	vol = 1,
	pitch = 1,
	key = 'reflect2',
	path = 'reflect2.ogg'
})


SMODS.Sound({
	vol = 1,
	pitch = 1,
	key = 'blip',
	path = 'blip.ogg'
})

SMODS.Sound({
	vol = 1,
	pitch = 1,
	key = 'blip2',
	path = 'blip2.ogg'
})

SMODS.Sound({
	vol = 1,
	pitch = 1,
	key = 'hexed',
	path = 'hexed.ogg'
})

--load the files and append
local decks_to_load = {
    "populous",
    "ancient",
    "gilded",
    "arithmetic",
    "discounted",
    "reflective",
    "cluttered",
    "blocky",
    "romantic",
    "somber",
    "harlequin",
    "stellar",
    "cursed",
    "liquid",
    "hexed"
}

local enhancements_to_load = {
}

local consumables_to_load = {
}

local jokers_to_load = {
    "minimalist",
    "love",
    "labor",
    "spirit",
    "wealth",
    "night_out"
}

SMODS.Atlas({
    key = "blind_atlas",
    path = "blinds_21f.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 21
})

SMODS.Atlas({
    key = "blind_atlas_24f",
    path = "blinds_24f.png",
	px = 34,
	py = 34,
	atlas_table = 'ANIMATION_ATLAS',
	frames = 24
})

--load the files and append
local blinds_to_load = {
    "drop",
    "love",
    "flow",
    "duality",
    "symmetry",
    "destitute",
    "feast",
    "famine",
    "purity",
    "positive",
    "negative",
    "question",
    "fracture",
    "fuschia",
    "yin",
    "yang"
}

for _, v in ipairs(blinds_to_load) do

    --load file and call it blind_loaded for this purpose so we can modify the blind and take from it instead of just its name like with blind_name
    local blind_loaded = SMODS.load_file("source/blinds/" .. v .. ".lua")()
    
    --throw an error and instead of crashing the game like an angry toddler if the blind isn't found
    if not blind_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shelly's Little Bit of Everything")

    else
        blind_loaded.key = v
        blind_loaded.discovered = true

        if not blind_loaded.atlas then
            blind_loaded.atlas = "blind_atlas"
        end

        if not blind_loaded.pos then
            blind_loaded.pos = { x = 0, y = 0 }
        end
        
        if not blind_loaded.dollars then
            blind_loaded.dollars = 5
        end

        if not blind_loaded.mult then
            blind_loaded.mult = 2
        end

        if not blind_loaded.boss then
            blind_loaded.boss = { min = 1, max = 10 }
        end

        local blind_obj = SMODS.Blind(blind_loaded)

        --i'm a little stupid & don't totally know what this means but it's basically going "for each function in the file, pull function and add it to blind_obj"
        for k_, v_ in pairs(blind_loaded) do
            if type(v_) == 'function' then
                blind_obj[k_] = blind_loaded[k_]
            end
        end

        --you did it *party.wav*
        sendInfoMessage("Loaded " .. v .. " blind successfully", "Shelly's Little Bit of Everything")
    end
end

for _, v in ipairs(decks_to_load) do

    --load file and call it deck_loaded for this purpose so we can modify the deck and take from it instead of just its name like with deck_name
    local deck_loaded = SMODS.load_file("source/decks/" .. v .. ".lua")()
    
    --throw an error and instead of crashing the game like an angry toddler if the deck isn't found
    if not deck_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Little Bit Of Everything")

    else
        --set "universal" info for every deck here so i don't have to write "atlas = 'deck_atlas'" 1 quadrillion times
        deck_loaded.key = v
        deck_loaded.atlas = "deck_atlas"
        deck_loaded.unlocked = true
        deck_loaded.discovered = true

        if not deck_loaded.pos then
            deck_loaded.pos = { x = 0, y = 0 }
        end
        
        local deck_obj = SMODS.Back(deck_loaded)

        --i'm a little stupid  & don't totally know what this means but it's basically going "for each function in the file, pull function and add it to deck_obj"
        for k_, v_ in pairs(deck_loaded) do
            if type(v_) == 'function' then
                deck_obj[k_] = deck_loaded[k_]
            end
        end

        --you did it *party.wav*
        sendInfoMessage("Loaded " .. v .. " deck successfully", "Shellular's Little Bit Of Everything")
    end
end

--Again!
for _, v in ipairs(enhancements_to_load) do

    local enhancement_loaded = SMODS.load_file("source/enhancements/" .. v .. ".lua")()
    
    if not enhancement_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Little Bit Of Everything")

    else
        enhancement_loaded.key = v
        enhancement_loaded.atlas = "enhancement_atlas"

        if not enhancement_loaded.pos then
            enhancement_loaded.pos = { x = 0, y = 0 }
        end
        
        local enhancement_obj = SMODS.Enhancement(enhancement_loaded)

        for k_, v_ in pairs(enhancement_loaded) do
            if type(v_) == 'function' then
                enhancement_obj[k_] = enhancement_loaded[k_]
            end
        end

        sendInfoMessage("Loaded " .. v .. " enhancement successfully", "Shellular's Little Bit Of Everything")
    end
end

--Again!
for _, v in ipairs(consumables_to_load) do

    local consumable_loaded = SMODS.load_file("source/consumables/" .. v .. ".lua")()
    if not consumable_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Little Bit Of Everything")

    else
        consumable_loaded.key = v
        consumable_loaded.atlas = "consumable_atlas"
        consumable_loaded.unlocked = true
        consumable_loaded.discovered = true

        if not consumable_loaded.pos then
            consumable_loaded.pos = { x = 0, y = 0 }
        end
        
        local consumable_obj = SMODS.Consumable(consumable_loaded)

        for k_, v_ in pairs(consumable_loaded) do
            if type(v_) == 'function' then
                consumable_obj[k_] = consumable_loaded[k_]
            end
        end

        sendInfoMessage("Loaded " .. v .. " consumable successfully", "Shellular's Little Bit Of Everything")
    end
end

for _, v in ipairs(jokers_to_load) do

    local joker_loaded = SMODS.load_file("source/jokers/" .. v .. ".lua")()
    if not joker_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Little Bit Of Everything")

    else
        joker_loaded.key = v
        joker_loaded.atlas = "joker_atlas"
        joker_loaded.unlocked = true
        joker_loaded.discovered = true

        if not joker_loaded.pos then
            joker_loaded.pos = { x = 0, y = 0 }
        end

        if not joker_loaded.cost then
            joker_loaded.cost = 3
        end

        if not joker_loaded.rarity then
            joker_loaded.rarity = 1
        end

        if not joker_loaded.eternal_compat then
            joker_loaded.eternal_compat = true
        end

        if not joker_loaded.perishable_compat then
            joker_loaded.perishable_compat = true
        end

        if not joker_loaded.blueprint_compat then
            joker_loaded.blueprint_compat = true
        end
        
        local joker_obj = SMODS.Joker(joker_loaded)

        for k_, v_ in pairs(joker_loaded) do
            if type(v_) == 'function' then
                joker_obj[k_] = joker_loaded[k_]
            end
        end

        sendInfoMessage("Loaded " .. v .. " joker successfully", "Shellular's Little Bit Of Everything")
    end
end
--this is so talisman doesn't get mad
to_big = to_big or function(x)
    return num
end