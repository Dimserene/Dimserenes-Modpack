--- the actual code starts here ---

sendInfoMessage("Launched", "Shellular's Deck of Cards")

ShellularDecks = {}
ShellularDecks.path = SMODS.current_mod.path
ShellularDecks.config = SMODS.current_mod.config

--atlas and sound definitions
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

--load the files and append
local decks_to_load = {
    "populous",
    "ancient",
    "arithmetic",
    "discounted",
    "reflective",
    "cluttered",
    "blocky",
    "romantic",
    "somber",
    "harlequin",
}

local enhancements_to_load = {
    "cosmic",
}

local consumables_to_load = {
    "universe"
}

for _, v in ipairs(decks_to_load) do

    --load file and call it deck_loaded for this purpose so we can modify the deck and take from it instead of just its name like with deck_name
    local deck_loaded = SMODS.load_file("source/decks/" .. v .. ".lua")()
    
    --throw an error and instead of crashing the game like an angry toddler if the deck isn't found
    if not deck_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Deck of Cards")

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
        sendInfoMessage("Loaded " .. v .. " deck successfully", "Shellular's Deck of Cards")
    end
end

--Again!
for _, v in ipairs(enhancements_to_load) do

    local enhancement_loaded = SMODS.load_file("source/enhancements/" .. v .. ".lua")()
    
    if not enhancement_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Deck of Cards")

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

        sendInfoMessage("Loaded " .. v .. " enhancement successfully", "Shellular's Deck of Cards")
    end
end

--Again!
for _, v in ipairs(consumables_to_load) do

    local consumable_loaded = SMODS.load_file("source/consumables/" .. v .. ".lua")()
    if not consumable_loaded then
        sendErrorMessage("Error loading file " .. v .. ".lua", "Shellular's Deck of Cards")

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

        sendInfoMessage("Loaded " .. v .. " consumable successfully", "Shellular's Deck of Cards")
    end
end

--this is so talisman doesn't get mad
to_big = to_big or function(x)
    return num
end