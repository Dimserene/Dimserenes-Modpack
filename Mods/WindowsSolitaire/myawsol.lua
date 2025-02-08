--- STEAMODDED HEADER
--- MOD_NAME: Windows Solitaire
--- MOD_ID: myawsol
--- PREFIX: myawsol
--- MOD_AUTHOR: [myAphelion]
--- MOD_DESCRIPTION: Classic Windows Solitaire themed textures!
--- VERSION: 1.0
--- DEPENDENCIES: [malverk]

AltTexture({ -- WinSol Tags
	key = 'winsol_tag',
	set = 'Tag',
	path = 'winsol_tags.png',
	loc_txt = {
		name = 'Windows Solitaire Tags'
	}
})
AltTexture({ -- WinSol Blinds
	key = 'winsol_blind',
	set = 'Blind',
	path = 'winsol_blinds.png',
	frames = 21,
	loc_txt = {
		name = 'Windows Solitaire Blinds'
	}
})
AltTexture({ -- WinSol Decks
	key = 'winsol_decks',
	set = 'Back',
	path = 'winsol_back_enhance_seal.png',
	loc_txt = {
		name = 'Windows Solitaire Decks'
	}
})
AltTexture({ -- WinSol Seals
	key = 'winsol_seals',
	set = 'Seal',
	path = 'winsol_back_enhance_seal.png',
	loc_txt = {
		name = 'Windows Solitaire Seals'
	}
})
AltTexture({ -- WinSol Enhancements
	key = 'winsol_enhance',
	set = 'Enhanced',
	path = 'winsol_back_enhance_seal.png',
	loc_txt = {
		name = 'Windows Solitaire Enhancements'
	}
})
AltTexture({ -- WinSol Stakes
	key = 'winsol_stakes',
	set = 'Stake',
	path = 'winsol_chips.png',
	stickers = true,
	loc_txt = {
		name = 'Windows Solitaire Stakes'
	}
})
AltTexture({ -- WinSol Stickers
	key = 'winsol_stickers',
	set = 'Sticker',
	path = 'winsol_stickers.png',
	loc_txt = {
		name = 'Windows Solitaire Stickers'
	}
})
AltTexture({ -- WinSol Tarots
	key = 'winsol_tarot',
	set = 'Tarot',
	path = 'winsol_tarot_spectral.png',
	loc_txt = {
		name = 'Windows Solitaire Tarots'
	}
})
AltTexture({ -- WinSol Planets
	key = 'winsol_planet',
	set = 'Planet',
	path = 'winsol_tarot_spectral.png',
	loc_txt = {
		name = 'Windows Solitaire Planets'
	}
})
AltTexture({ -- WinSol Spectrals
	key = 'winsol_spectral',
	set = 'Spectral',
	path = 'winsol_tarot_spectral.png',
	soul = 'winsol_back_enhance_seal.png',
	loc_txt = {
		name = 'Windows Solitaire Spectrals'
	}
})
AltTexture({ -- WinSol Vouchers
	key = 'winsol_voucher',
	set = 'Voucher',
	path = 'winsol_vouchers.png',
	loc_txt = {
		name = 'Windows Solitaire Vouchers'
	}
})
AltTexture({ -- WinSol Jokers
	key = 'winsol_joker',
	set = 'Joker',
	path = 'winsol_jokers.png',
	loc_txt = {
		name = 'Windows Solitaire Jokers'
	}
})
AltTexture({ -- WinSol Boosters
	key = 'winsol_booster',
	set = 'Booster',
	path = 'winsol_booster.png',
	loc_txt = {
		name = 'Windows Solitaire Boosters'
	}
})
TexturePack{ -- WinSol Textures
	key = 'winsol',
	textures = {
		'myawsol_winsol_tag',
		'myawsol_winsol_blind',
		'myawsol_winsol_decks',
		'myawsol_winsol_seals',
		'myawsol_winsol_enhance',
		'myawsol_winsol_stakes',
		'myawsol_winsol_stickers',
		'myawsol_winsol_tarot',
		'myawsol_winsol_planet',
		'myawsol_winsol_spectral',
		'myawsol_winsol_voucher',
		'myawsol_winsol_joker',
		'myawsol_winsol_booster'
	},
	loc_txt = {
		name = 'Windows Solitaire',
		text = {
			'Windows Solitaire',
			'themed pack'
		}
	}
}