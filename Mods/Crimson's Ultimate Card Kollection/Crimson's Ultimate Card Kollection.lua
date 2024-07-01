--- STEAMODDED HEADER
--- MOD_NAME: Crimson's Ultimate Card Kollection
--- MOD_ID: CUCK
--- MOD_AUTHOR: [Crimson Heart]
--- MOD_DESCRIPTION: A collection of all of the mods by Crimson Heart. 

----------------------------------------------
------------MOD CODE -------------------------

---------- Sprites ---------------------------------------------------------------------------------------------------------------
function SMODS.INIT.CUCK()
    local CUCK = SMODS.findModByID("CUCK")
    local CUCKDecks = SMODS.Sprite:new("CUCKDecks", CUCK.path, "CUCKDecks.png", 71, 95, "asset_atli")
    CUCKDecks:register()

---------- Codes ---------------------------------------------------------------------------------------------------------------
    local Backapply_to_run_Ref = Back.apply_to_run
    function Back.apply_to_run(self)
        Backapply_to_run_Ref(self)
        if self.effect.config.all_eternal then
            G.GAME.modifiers.all_eternal = true
        else
            G.GAME.modifiers.all_eternal = false
        end

        if self.effect.config.flipped_cards then
            G.GAME.modifiers.flipped_cards = 4
        else
            G.GAME.modifiers.flipped_cards = nil
        end

        if self.effect.config.debuff_played_cards then
            G.GAME.modifiers.debuff_played_cards = true
        else
            G.GAME.modifiers.debuff_played_cards = false
        end
        if self.effect.config.shop_eternals then
            G.GAME.modifiers.enable_eternals_in_shop = true
        else
            G.GAME.modifiers.enable_eternals_in_shop = false
        end

        if self.effect.config.rentals then
            G.GAME.modifiers.enable_rentals_in_shop = true
        else
            G.GAME.modifiers.enable_rentals_in_shop = false
        end

        if self.effect.config.perishables then
            G.GAME.modifiers.enable_perishables_in_shop = true
        else
            G.GAME.modifiers.enable_perishables_in_shop = false
        end

        if self.effect.config.no_blind_reward then
            G.GAME.modifiers.no_blind_reward = G.GAME.modifiers.no_blind_reward or {}
            G.GAME.modifiers.no_blind_reward.Small = true
            G.GAME.modifiers.no_blind_reward.Big = true
        end
        
        if self.effect.config.jokers then
            delay(0.4)
            G.E_MANAGER:add_event(Event({
                func = function()
                    for k, v in ipairs(self.effect.config.jokers) do
                        local card = create_card('Joker', G.jokers, nil, nil, nil, nil, v, 'deck')
                        card:add_to_deck()
                        G.jokers:emplace(card)
                    end
                return true
                end
            }))
        end

        if self.effect.config.AllSixes then
            G.E_MANAGER:add_event(Event({
                func = function()
                    for iter_57_0 = #G.playing_cards, 1, -1 do
                        sendDebugMessage(G.playing_cards[iter_57_0].base.id)
                        if G.playing_cards[iter_57_0].base.id ~= 6 then
                            local suit = string.sub(G.playing_cards[iter_57_0].base.suit, 1, 1) .. "_"
                            local rank = "6"
    
                            G.playing_cards[iter_57_0]:set_base(G.P_CARDS[suit .. rank])
                        end
                    end
                    return true
                end
            }))
        end
    end

---------- Decks ---------------------------------------------------------------------------------------------------------------

    local CrimDecks_def = {

        Plain = {
            ["name"] = "Plain Deck",
            ["text"] = {
                [1] = "Base Deck",    
            },
        },

        Extreme = {
            ["name"] = "Extreme Deck",
            ["text"] = {
                [1] = "{C:blue}1{} hand",
               [2] = "{C:red}1{} discard",
            },
        },
        
        Insane = {
            ["name"] = "Insane Deck",
            ["text"] = {
                [1] = "{C:attention}Played{} cards become {C:attention}debuffed{} after scoring",
                [2] = "Jokers will spawn as Eternal regardless of stake",
                [3] = "{C:green}1 in 4{} cards are drawn face down",
            },
        },

        Impossible = {
            ["name"] = "Impossible Deck",
            ["text"] = {
                [1] = "{C:attention}Played{} cards become {C:attention}debuffed{} after scoring",
                [2] = "Jokers will spawn as Eternal, perishable,",
                [3] = "and/or rental regardless of stake",
                [4] = "{C:green}1 in 4{} cards are drawn face down",
                [5] = "Start with {C:money}$-10{}",
                [6] = "Small and Big Blind give no money"
            },
        },

        SixDeck = {
            ["name"] = "Six Deck",
            ["text"] = {
                [1] = "All cards are {C:green}Sixes{}",
            },
        },
        Subathon = {
            ["name"] = "Murphy Subathon Deck",
            ["text"] = {
                [1] = "Start with {C:money}Gros Michel{}",
                [2] = "and {C:money}Cavendish{}"
            },
    },

}

    local PlainDeck = SMODS.Deck:new("Plain Deck", "ch_plain", {atlas = "CUCKDecks"}, {x = 0, y = 0}, CrimDecks_def.Plain)
    local ExtremeDeck = SMODS.Deck:new("Extreme Deck", "ch_Extreme", {ExtremeEffect = true, hands = -3, discards = -2, atlas = "CUCKDecks"}, {x = 1, y = 0}, CrimDecks_def.Extreme)
    local InsaneDeck = SMODS.Deck:new("Insane Deck", "InsaneDeck", {shop_eternals = true, flipped_cards = true, debuff_played_cards = true, atlas = "CUCKDecks"}, {x=2, y=0}, CrimDecks_def.Insane)

    local ImpossibleDeck = SMODS.Deck:new("Impossible Deck", "ImpossibleDeck", {no_blind_reward = true, dollars = -14, shop_eternals = true, rentals = true, perishables = true, flipped_cards = true, debuff_played_cards = true, atlas = "CUCKDecks"}, {x=5, y=0}, CrimDecks_def.Impossible)
    


    local SixDeck = SMODS.Deck:new("Six Deck", "SixDeck", {AllSixes = 6, atlas = "CUCKDecks"}, {x=3,y=0}, CrimDecks_def.SixDeck)
    local Subathon = SMODS.Deck:new("Murphy Subathon Deck", "Subathon", {jokers = {'j_gros_michel', 'j_cavendish'},atlas = "CUCKDecks"}, {x=4,y=0}, CrimDecks_def.Subathon)
    PlainDeck:register()
    SixDeck:register()
    ExtremeDeck:register()
    InsaneDeck:register()
    ImpossibleDeck:register()
    Subathon:register()

---------- Challenges ---------------------------------------------------------------------------------------------------------------


    local challenges = G.CHALLENGES

	G.localization.misc.challenge_names["c_mod_JIMBO_Jimbonly"] = "Jimbo Only"
	G.localization.misc.challenge_names["c_mod_JIMBO_Jimboless"] = "Jimboless"

    table.insert(G.CHALLENGES,#G.CHALLENGES+1,{
        name = 'Jimbo Only',
        id = 'c_mod_JIMBO_Jimbonly',
        rules = {
            custom = {
            },
            modifiers = {
                {id = 'dollars', value = 4},
                {id = 'discards', value = 3},
                {id = 'hands', value = 4},
                {id = 'reroll_cost', value = 5},
                {id = 'joker_slots', value = 5},
                {id = 'consumable_slots', value = 2},
                {id = 'hand_size', value = 8},
            }
        },
        jokers = {
            
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            type = 'Plain Deck'
        },
        restrictions = {
            banned_cards = {
                {id = 'j_four_fingers'},
                {id = 'j_mime'},
                {id = 'j_credit_card'},
                {id = 'j_ceremonial'},
                {id = 'j_banner'},
                {id = 'j_mystic_summit'},
                {id = 'j_loyalty_card'},
                {id = 'j_8_ball'},
                {id = 'j_dusk'},
                {id = 'j_raised_fist'},
                {id = 'j_fibonacci'},
                {id = 'j_scary_face'},
                {id = 'j_delayed_grat'},
                {id = 'j_hack'},
                {id = 'j_pareidolia'},
                {id = 'j_gros_michel'},
                {id = 'j_business'},
                {id = 'j_supernova'},
                {id = 'j_ride_the_bus'},
                {id = 'j_egg'},
                {id = 'j_ice_cream'},
                {id = 'j_dna'},
                {id = 'j_splash'},
                {id = 'j_superposition'},
                {id = 'j_todo_list'},
                {id = 'j_cavendish'},
                {id = 'j_red_card'},
                {id = 'j_seance'},
                {id = 'j_shortcut'},
                {id = 'j_cloud_9'},
                {id = 'j_rocket'},
                {id = 'j_obelisk'},
                {id = 'j_midas_mask'},
                {id = 'j_gift'},
                {id = 'j_turtle_bean'},
                {id = 'j_erosion'},
                {id = 'j_reserved_parking'},
                {id = 'j_mail'},
                {id = 'j_to_the_moon'},
                {id = 'j_juggler'},
                {id = 'j_drunkard'},
                {id = 'j_lucky_cat'},
                {id = 'j_baseball'},
                {id = 'j_bull'},
                {id = 'j_diet_cola'},
                {id = 'j_popcorn'},
                {id = 'j_trousers'},
                {id = 'j_ancient'},
                {id = 'j_ramen'},
                {id = 'j_walkie_talkie'},
                {id = 'j_selzer'},
                {id = 'j_castle'},
                {id = 'j_smiley'},
                {id = 'j_campfire'},
                {id = 'j_ticket'},
                {id = 'j_acrobat'},
                {id = 'j_sock_and_buskin'},
                {id = 'j_troubadour'},
                {id = 'j_certificate'},
                {id = 'j_hanging_chad'},
                {id = 'j_rough_gem'},
                {id = 'j_bloodstone'},
                {id = 'j_arrowhead'},
                {id = 'j_onyx_agate'},
                {id = 'j_flower_pot'},
                {id = 'j_oops'},
                {id = 'j_idol'},
                {id = 'j_seeing_double'},
                {id = 'j_hit_the_road'},
                {id = 'j_duo'},
                {id = 'j_trio'},
                {id = 'j_family'},
                {id = 'j_order'},
                {id = 'j_tribe'},
                {id = 'j_satellite'},
                {id = 'j_shoot_the_moon'},
                {id = 'j_drivers_license'},
                {id = 'j_bootstraps'},
            },
            banned_tags = {
            },
            banned_other = {
            }
        }
    })
    
    table.insert(G.CHALLENGES,#G.CHALLENGES+1,{
        name = 'Jimboless',
        id = 'c_mod_JIMBO_Jimboless',
        rules = {
            custom = {
            },
            modifiers = {
                {id = 'dollars', value = 4},
                {id = 'discards', value = 3},
                {id = 'hands', value = 4},
                {id = 'reroll_cost', value = 5},
                {id = 'joker_slots', value = 5},
                {id = 'consumable_slots', value = 2},
                {id = 'hand_size', value = 8},
            }
        },
        jokers = {
            
        },
        consumeables = {
        },
        vouchers = {
        },
        deck = {
            type = 'Plain Deck'
        },
        restrictions = {
            banned_cards = {
                {id = 'j_joker'},
                {id = 'j_greedy_joker'},
                {id = 'j_lusty_joker'},
                {id = 'j_wrathful_joker'},
                {id = 'j_gluttenous_joker'},
                {id = 'j_jolly'},
                {id = 'j_zany'},
                {id = 'j_mad'},
                {id = 'j_droll'},
                {id = 'j_crazy'},
                {id = 'j_sly'},
                {id = 'j_wily'},
                {id = 'j_clever'},
                {id = 'j_devious'},
                {id = 'j_crafty'},
                {id = 'j_half'},
                {id = 'j_stencil'},
                {id = 'j_marble'},
                {id = 'j_misprint'},
                {id = 'j_chaos'},
                {id = 'j_steel_joker'},
                {id = 'j_abstract'},
                {id = 'j_even_steven'},
                {id = 'j_odd_todd'},
                {id = 'j_scholar'},
                {id = 'j_space'},
                {id = 'j_burglar'},
                {id = 'j_blackboard'},
                {id = 'j_runner'},
                {id = 'j_blue_joker'},
                {id = 'j_sixth_sense'},
                {id = 'j_constellation'},
                {id = 'j_hiker'},
                {id = 'j_faceless'},
                {id = 'j_green_joker'},
                {id = 'j_card_sharp'},
                {id = 'j_madness'},
                {id = 'j_square'},
                {id = 'j_riff_raff'},
                {id = 'j_vampire'},
                {id = 'j_hologram'},
                {id = 'j_vagabond'},
                {id = 'j_luchador'},
                {id = 'j_photograph'},
                {id = 'j_hallucination'},
                {id = 'j_fortune_teller'},
                {id = 'j_stone'},
                {id = 'j_golden'},
                {id = 'j_trading'},
                {id = 'j_flash'},
                {id = 'j_mr_bones'},
                {id = 'j_swashbuckler'},
                {id = 'j_smeared'},
                {id = 'j_throwback'},
                {id = 'j_glass'},
                {id = 'j_ring_master'},
                {id = 'j_blueprint'},
                {id = 'j_wee'},
                {id = 'j_merry_andy'},
                {id = 'j_matador'},
                {id = 'j_stuntman'},
                {id = 'j_invisible'},
                {id = 'j_brainstorm'},
                {id = 'j_cartomancer'},
                {id = 'j_astronomer'},
                {id = 'j_burnt'},
                {id = 'j_caino'},
                {id = 'j_triboulet'},
                {id = 'j_yorick'},
                {id = 'j_chicot'},
                {id = 'j_perkeo'},
                {id = 'c_soul'}
            },
            banned_tags = {
            },
            banned_other = {
            }
        }
    })



end

----------------------------------------------  
------------MOD CODE END----------------------
