--- STEAMODDED HEADER
--- MOD_NAME: Baba Decks
--- MOD_ID: BabaDecks
--- MOD_AUTHOR: [Blackbando]
--- MOD_DESCRIPTION: A texture mod, using art by Auburn Arcana on Tumblr. Makes the basic + Abandoned decks look like Baba!
--- PREFIX: baba_is
--- VERSION: 1.2
--- DEPENDENCIES: [malverk]

AltTexture({
    key = 'new_decks',
    set = 'Back',
    path = 'baba.png',
    loc_txt = {
        name = 'Baba Deck Backs'
    },
	keys = {
		'b_red',
		'b_blue',
		'b_yellow',
		'b_green',
		'b_black'
	},
	original_sheet = true
})
TexturePack{
    key = 'baba',
    textures = {
        'baba_is_new_decks'
    },
    loc_txt = {
        name = 'BABA IS DECK',
        text = {
            'Deck backs with',
			'baba on them'
        }
    }
}