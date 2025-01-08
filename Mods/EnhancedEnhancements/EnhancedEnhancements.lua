--- STEAMODDED HEADER
--- MOD_NAME: Luna's Enhancedments
--- MOD_ID: EnhancedEnhancements
--- MOD_AUTHOR: [LunaAstraCassiopeia]
--- MOD_DESCRIPTION: Modified enhancement textures to fit the pattern of changing the material of the cards. Also, changes the high contrast card textures.

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas {
	key = "centers",
	path = "Enhancedments.png",
	px = 71,
	py = 95,
	raw_key = true,
}

SMODS.Atlas{
    key = "centers",
    path = "Enhancedments.png",
    px = 71,
    py = 95,
    inject = function(self)
        SMODS.Atlas.inject(self)
        G.shared_seals = {
            Gold = Sprite(0, 0, G.CARD_W, G.CARD_H, self, {x = 2,y = 0}),
            Purple = Sprite(0, 0, G.CARD_W, G.CARD_H, self, {x = 4,y = 4}),
            Red = Sprite(0, 0, G.CARD_W, G.CARD_H, self, {x = 5,y = 4}),
            Blue = Sprite(0, 0, G.CARD_W, G.CARD_H, self, {x = 6,y = 4}),
        }
    end
}

----------------------------------------------
------------MOD CODE END----------------------
