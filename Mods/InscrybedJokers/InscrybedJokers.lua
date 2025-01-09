--- STEAMODDED HEADER
--- MOD_NAME: Inscrybed Jokers
--- MOD_ID: InscrybedJokers
--- MOD_AUTHOR: [LunaAstraCassiopeia]
--- MOD_DESCRIPTION: Some Jokers inspired by Inscryption

----------------------------------------------
------------MOD CODE -------------------------


function SMODS.INIT.InscrybedJokers()

    -- Modified Booster Pack Logic

    --[[ local card_openref = Card.open
    function Card:open()
        if self.ability.name:find('Buffoon') then
            if self.ability.set == "Joker" then
                if self.ability.name == 'Retro Joker' then
                    local isActive = true
                    for k, v in ipairs(G.handlist) do
                        if v.ability.set == 'Joker' and v.edition then
                            isActive = false
                        end
                    end
                    if isActive then
                        local edition_rate = 2
                        local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
                        card:set_edition(edition)
                    end
                end
            end
        end
        return card_openref(self)
    end ]]--

    -- Beastly Joker
    local beastly_def = {
        ["name"] = "Beastly Joker",
        ["text"] = {
            "If {C:attention}first discard{} of round",
            "has only {C:attention}1{} card, destroy",
            "it and gain {C:chips}+#2#{} Chips",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    }
    local beastly_ability = {
        extra = {
            current_chips = 10,
            chip_mod = 10
        }
    }

    -- SMODS.Joker:new(name, slug, config, spritePos, loc_txt, rarity, cost, unlocked, discovered, blueprint_compat, eternal_compat)
    local j_beast = SMODS.Joker:new("Beastly Joker", "beast", beastly_ability, {x = 0, y = 0}, beastly_def, 2, 5, true, true, true, true)

    SMODS.Sprite:new("j_beast", SMODS.findModByID("InscrybedJokers").path, "j_beast.png", 71, 95, "asset_atli"):register();
    j_beast:register()
    SMODS.Jokers.j_beast.loc_def = function(self)
        return {self.ability.extra.current_chips, self.ability.extra.chip_mod}
    end

    SMODS.Jokers.j_beast.calculate = function(self,context)
        if SMODS.end_calculate_context(context) then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_chips',
                    vars = {self.ability.extra.current_chips}
                },
                chip_mod = self.ability.extra.current_chips,
                card = self
            }
        elseif context.discard and not context.blueprint then
            if G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
                self.ability.extra.current_chips = self.ability.extra.current_chips + self.ability.extra.chip_mod
                return {
                    message = localize('k_upgrade_ex'),
                    card = self,
                    colour = G.C.CHIPS,
                    delay = 0.45,
                    remove = true
                }
            end
        elseif context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(self, eval, true)
        end
    end

    -- Deathly Joker
    local deathly_def = {
        ["name"] = "Deathly Joker",
        ["text"] = {
            "When a card is destroyed, gains",
            "Chips equal to the rank",
            "of the destroyed card.",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
        }
    }
    local deathly_ability = {
        extra = {
            current_chips = 0
        }
    }
    
    local j_deathly = SMODS.Joker:new("Deathly Joker", "deathly", deathly_ability, {x = 0, y = 0}, deathly_def, 1, 4, true, true, true, true)

    SMODS.Sprite:new("j_deathly", SMODS.findModByID("InscrybedJokers").path, "j_deathly.png", 71, 95, "asset_atli"):register();
    j_deathly:register()
    
    SMODS.Jokers.j_deathly.loc_def = function(self)
        return {self.ability.extra.current_chips}
    end

    SMODS.Jokers.j_deathly.calculate = function(self,context)
        if SMODS.end_calculate_context(context) and self.ability.extra.current_chips > 0 then
            return {
                message = localize {
                    type = 'variable',
                    key = 'a_chips',
                    vars = {self.ability.extra.current_chips}
                },
                chip_mod = self.ability.extra.current_chips,
                card = self
            }
        elseif context.cards_destroyed and not context.blueprint then
            local value = 0
                for k, v in ipairs(context.glass_shattered) do
                    value = value + v.base.nominal
                end
            self.ability.extra.current_chips = self.ability.extra.current_chips + value
            if value > 0 then 
                G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {self.ability.extra.current_chips}}}); return true
                end}))
            end
            return
        elseif context.remove_playing_cards and not context.blueprint then
            local value = 0
                for k, v in ipairs(context.removed) do
                    value = value + v.base.nominal
                end
            self.ability.extra.current_chips = self.ability.extra.current_chips + value
            if value > 0 then 
                G.E_MANAGER:add_event(Event({
                func = function() card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize{type = 'variable', key = 'a_chips', vars = {self.ability.extra.current_chips}}}); return true
                end}))
            end
            return
        end
    end

    -- Techno Joker
    local techno_def = {
        ["name"] = "Techno Joker",
        ["text"] = {
            "Gains {C:red}+#2#{} Mult for each ",
            "hand played this round.",
            "Resets at end of round.",
            "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
        }
    }
    local techno_ability = { 
        mult = 0;
        extra = {
            mult_mod = 8;
        }
    }
    
    local j_techno = SMODS.Joker:new("Techno Joker", "techno", techno_ability, {x = 0, y = 0}, techno_def, 2, 5, true, true, true, true)

    SMODS.Sprite:new("j_techno", SMODS.findModByID("InscrybedJokers").path, "j_techno.png", 71, 95, "asset_atli"):register();
    j_techno:register()
    
    SMODS.Jokers.j_techno.loc_def = function(self)
        return {self.ability.mult, self.ability.extra.mult_mod}
    end

    SMODS.Jokers.j_techno.calculate = function(self,context)
        if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
            self.ability.mult = 0
            return {
                message = localize('k_reset'),
                colour = G.C.RED
            }
        elseif SMODS.end_calculate_context(context) and self.ability.mult > 0 then
            return {
                message = localize{type='variable',key='a_mult',vars={self.ability.mult}},
                mult_mod = self.ability.mult
            }
        end
        if context.after and not context.blueprint then
            self.ability.mult = self.ability.mult + self.ability.extra.mult_mod
            return {
                message = localize{type='variable',key='a_mult',vars={self.ability.mult}},
            }
        end
    end
    
    -- Magickal Joker
    local magickal_def = {
        ["name"] = "Magickal Joker",
        ["text"] = {
            "Gains {C:mult}+#2#{} Mult if hand played",
            "contains {C:spades}Spade{}, {C:hearts}Heart{},",
            "{C:clubs}Club{} and {C:diamonds}Diamond{} cards",
            "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
        }
    }
    local magickal_ability = { 
        mult = 3;
        extra = {
            mult_mod = 3;
        }
    }
    
    local j_magickal = SMODS.Joker:new("Magickal Joker", "magickal", magickal_ability, {x = 0, y = 0}, magickal_def, 1, 5, true, true, true, true)

    SMODS.Sprite:new("j_magickal", SMODS.findModByID("InscrybedJokers").path, "j_magickal.png", 71, 95, "asset_atli"):register();
    j_magickal:register()
    
    SMODS.Jokers.j_magickal.loc_def = function(self)
        return {self.ability.mult, self.ability.extra.mult_mod}
    end

    SMODS.Jokers.j_magickal.calculate = function(self,context)
        if context.before and not context.blueprint then
            local suits = {
                ['Hearts'] = 0,
                ['Diamonds'] = 0,
                ['Spades'] = 0,
                ['Clubs'] = 0
            }
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name == 'Wild Card' then
                    if context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0 then suits["Hearts"] = suits["Hearts"] + 1
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Spades') and suits["Spades"] == 0  then suits["Spades"] = suits["Spades"] + 1
                    elseif context.scoring_hand[i]:is_suit('Clubs') and suits["Clubs"] == 0  then suits["Clubs"] = suits["Clubs"] + 1 end
                end
            end
            if suits["Hearts"] > 0 and
            suits["Diamonds"] > 0 and
            suits["Spades"] > 0 and
            suits["Clubs"] > 0 then
                self.ability.mult = self.ability.mult + self.ability.extra.mult_mod
                return {
                    message = localize{'k_upgrade_ex'},
                    colour = G.C.RED
                }
            end
        elseif SMODS.end_calculate_context(context) then
            return {
                message = localize{type='variable',key='a_mult',vars={self.ability.mult}},
                mult_mod = self.ability.mult
            }
        end
    end

    -- Mycologists
    local mycologist_def = {
        ["name"] = "Mycologists",
        ["text"] = {
            "If {C:attention}poker hand{} contains a",
            "{C:attention}Pair{} or {C:attention}Two Pair{}, cards",
            "give Mult equal to their rank",
            "when scored."
        }
    }
    
    local j_mycologist = SMODS.Joker:new("Mycologists", "mycologist", magickal_ability, {x = 0, y = 0}, mycologist_def, 2, 5, true, true, true, true)

    SMODS.Sprite:new("j_mycologist", SMODS.findModByID("InscrybedJokers").path, "j_mycologist.png", 71, 95, "asset_atli"):register();
    j_mycologist:register()

    SMODS.Jokers.j_mycologist.calculate = function(self,context)
        if context.individual and context.cardarea == G.play and context.poker_hands ~= nil and context.poker_hands and (next(context.poker_hands['Two Pair']) or next(context.poker_hands['Pair'])) then
            return {
                mult = context.other_card.base.nominal,
                card = self
            }
        end
    end

    --[[ Retro
    local retro_def = {
        ["name"] = "Retro Joker",
        ["text"] = {
            "{C:attention}Buffoon Packs{} will always",
            "contain an Editioned Joker"
        }
    }
    
    local j_retro = SMODS.Joker:new("Retro", "retro", magickal_ability, {x = 0, y = 0}, retro_def, 2, 6, true, true, true, false)

    SMODS.Sprite:new("j_retro", SMODS.findModByID("InscrybedJokers").path, "j_retro.png", 71, 95, "asset_atli"):register();
    j_retro:register()

    SMODS.Jokers.j_retro.calculate = function(self,context)
        if context.open_booster and G.STATE == G.STATES.BUFFOON then
            local isActive = true
            for k, v in ipairs(G.handlist) do
                if v.ability.set == 'Joker' and v.edition then
                    isActive = false
                end
            end
            if isActive then
                local edition_rate = 2
                local edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, edition_rate, true)
                card:set_edition(edition)
            end
        end
    end]]--

    -- JokerDisplay Integration
    if _G["JokerDisplay"] then
        NFS.load(SMODS.findModByID("InscrybedJokers").path .. "jokerdisplay_integration.lua")()
    end
end

----------------------------------------------
------------MOD CODE END----------------------
