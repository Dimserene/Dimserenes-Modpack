--- STEAMODDED HEADER
--- MOD_NAME: Gensokyo Consumables
--- MOD_ID: gensokyo_consumables
--- PREFIX: gensokyo
--- MOD_AUTHOR: [funtm]
--- MOD_DESCRIPTION: Touhou-themed consumable cards
--- VERSION: 0.9.0
--- DEPENDENCIES: [malverk]


AltTexture({
    key = 'touhou_tarot',
    set = 'Tarot',
    path = 'touhou_consumables.png',
    loc_txt = {
        name = 'Touhou Tarot'
    }
})
TexturePack{
    key = 'touhou',
    textures = {
        'gensokyo_touhou_tarot'
    },
    loc_txt = {
        name = 'Gensokyo Consumables',
        text = {
            'Touhou-themed textures for',
            'consumables [WIP]'
        }
    }
}