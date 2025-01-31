--- STEAMODDED HEADER
--- MOD_NAME: Spectralsbian
--- MOD_ID: LeSpectrals
--- MOD_AUTHOR: [RadicaAprils, AutumnMood (it/she/they)]
--- MOD_DESCRIPTION: Spectral cards but lesbian
--- PREFIX: lspa
--- VERSION: 1.0a
--- DEPENDENCIES: [malverk]

AltTexture({
    key = 'lesb_spectrals',
    set = 'Spectral',
    path = 'Tarots-LeSpectrals.png',
    soul = "Enhancers-LeSpectrals.png",
    loc_txt = {
        name = 'Lesbian Spectrals'
    },
	original_sheet = true
})
AltTexture({
    key = 'lesb_tarots',
    set = 'Tarot',
    path = 'Tarots-LeSpectrals.png',
    loc_txt = {
        name = 'Lesbian Tarots'
    },
	keys = {
		'c_lovers'
	},
	original_sheet = true
})
AltTexture({
    key = 'lesb_jokers',
    set = 'Joker',
    path = 'Jokers-LeSpectrals.png',
    loc_txt = {
        name = 'Lesbian Jokers'
    },
	keys = {
		'j_banner',
		'j_seance'
	},
	original_sheet = true
})
AltTexture({
    key = 'lesb_decks',
    set = 'Back',
    path = 'Enhancers-LeSpectrals.png',
    loc_txt = {
        name = 'Lesbian Decks'
    },
	keys = {
		'b_ghost'
	},
	original_sheet = true
})
AltTexture({
    key = 'lesb_tags',
    set = 'Tag',
    path = 'Tags-LeSpectrals.png',
    loc_txt = {
        name = 'Lesbian Tags'
    },
	keys = {
		'tag_ethereal'
	},
	original_sheet = true
})
AltTexture({
    key = 'lesb_boosters',
    set = 'Booster',
    path = 'Boosters-LeSpectrals.png',
    loc_txt = {
        name = 'Lesbian Boosters'
    },
	keys = {
		'p_spectral_normal_1',
		'p_spectral_normal_2',
		'p_spectral_jumbo_1',
		'p_spectral_mega_1'
	},
	original_sheet = true
})
TexturePack{
    key = 'LeSpectrals',
    textures = {
        'lspa_lesb_spectrals',
		'lspa_lesb_jokers',
		'lspa_lesb_tags',
		'lspa_lesb_boosters',
		'lspa_lesb_decks',
		'lspa_lesb_tarots'
    },
    loc_txt = {
        name = 'Lesbian Spectrals',
        text = {
            'Spectral cards',
			'but Lesbian'
        }
    }
}