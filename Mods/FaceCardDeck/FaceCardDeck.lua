--- STEAMODDED HEADER
--- MOD_NAME: Face Card Deck 3
--- MOD_ID: FaceCardDeck3
--- MOD_AUTHOR: [YourName]
--- MOD_DESCRIPTION: Adds 1 deck (Face Card Deck 3): All face cards (Jacks, Queens, Kings) are now Lucky cards.

----------------------------------------
--------------- MOD CODE ---------------
----------------------------------------

function add_card_to_deck(arg_card)
    arg_card:add_to_deck()
    table.insert(G.playing_cards, arg_card)
    G.deck.config.card_limit = G.deck.config.card_limit + 1
    G.deck:emplace(arg_card)
end

function add_joker_to_game(arg_key, arg_loc, arg_joker)
    arg_joker.key = arg_key
    arg_joker.order = #G.P_CENTER_POOLS["Joker"] + 1

    G.P_CENTERS[arg_key] = arg_joker
    table.insert(G.P_CENTER_POOLS["Joker"], arg_joker)
    table.insert(G.P_JOKER_RARITY_POOLS[arg_joker.rarity], arg_joker)

    G.localization.descriptions.Joker[arg_key] = arg_loc
end

function SMODS.INIT.FaceCardDeck3()
    local jokers = {}

    local texts = {}

    for key, val in pairs(jokers) do
        add_joker_to_game(key, texts[key], val)
    end
end

local card_calculate_joker_ref = Card.calculate_joker
function Card.calculate_joker(self, context)
    local calculate_joker_ref = card_calculate_joker_ref(self, context)

    return calculate_joker_ref
end

local back_apply_to_run_ref = Back.apply_to_run
function Back.apply_to_run(arg_facecard3)
    back_apply_to_run_ref(arg_facecard3)

    if arg_facecard3.effect.config.royalty then
        G.E_MANAGER:add_event(Event({
            func = function()
                -- Code for cards
                local cards_by_suit = {
                    ["S"] = {},
                    ["H"] = {},
                    ["C"] = {},
                    ["D"] = {}
                }

                for idx = #G.playing_cards, 1, -1 do
                    sendDebugMessage(G.playing_cards[idx].base.suit .. G.playing_cards[idx].base.id)

                    local suit = string.sub(G.playing_cards[idx].base.suit, 1, 1)
                    local rank = tostring(G.playing_cards[idx].base.id)

                    if     rank == "11" then rank = "J"
                    elseif rank == "12" then rank = "Q"
                    elseif rank == "13" then rank = "K"
                    else
                        -- Remove non-face cards
                        G.playing_cards[idx]:start_dissolve(nil, true)
                    end

                    if rank == "J" or rank == "Q" or rank == "K" then
                        table.insert(cards_by_suit[suit], G.playing_cards[idx])

                        -- Set ALL face cards to "Lucky"
                        G.playing_cards[idx]:set_ability(G.P_CENTERS.m_lucky)
                    end
                end

                -- Duplicate each card to create two copies
                local final_deck = {}
                for suit, cards in pairs(cards_by_suit) do
                    for _, card in ipairs(cards) do
                        table.insert(final_deck, card)

                        -- Create a second copy of each card
                        local copied_card = copy_card(card, nil, 1)
                        add_card_to_deck(copied_card) -- Ensure the duplicate is properly registered
                        table.insert(final_deck, copied_card)
                    end
                end

                G.playing_cards = final_deck
                G.starting_deck_size = #G.playing_cards

                -- Jokers (unchanged)
                local joker_list = {}
                for idx = 1, #joker_list, 1 do
                    local card = create_card('Joker', G.jokers, false, nil, nil, nil, joker_list[idx], nil)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                end
                return true
            end
        }))
    end
end

local loc_def_facecard3 = {
    ["name"]="Face Card Deck 3",
    ["text"]={
        [1]="This deck contains only",
        [2]="Jacks, Queens, and Kings.",
        [3]="All face cards are {C:attention}Lucky{}",
        [4]="Each suit has 2 copies, for 24 total."
    }
}

local d_facecard3 = SMODS.Deck:new("FaceCard_Deck3", "facecard3", {royalty = true, hands = 0, discards = 0}, {x = 6, y = 0}, loc_def_facecard3)
d_facecard3:register()

----------------------------------------
------------- MOD CODE END -------------
----------------------------------------
