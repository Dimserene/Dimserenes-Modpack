return {
    descriptions = {
        Joker={
            j_bmjo_heart={
                name = 'Heart<Skeleton Mode>',
                text = {
                    "Prevents Death",
                    "if at least {C:money}$#1#{} you have,",
                    "lose {C:money}$#1#{} every time triggers",
                    "{C:inactive}(#3#)",
                },
            },
            j_bmjo_supermeteor={
                name = 'Supermeteor',
                text = {
                    'Retrigger the effect of',
                    '{C:planet}Planet{} card is used',
                },
            },
            j_bmjo_smartcowboy={
                name = 'Smart cowboy',
                text = {
                    "This Joker gains {X:mult,C:white} X#1# {} Mult",
                    "for every {C:money}$#2#{} you have",
                    "{C:inactive}(Currently {X:mult,C:white} X#3# {C:inactive} Mult)",
                },
            },
            j_bmjo_clover={
                name = 'Clover',
                text = {
                    "{C:green}#1# in #2#{} chance to",
                    "create {C:attention}#3#{} {C:purple}Tarot{} card or {C:planet}Planet{} card",
                    "for each Joker {C:attention}sold{}, when {C:attention}Blind{}",
                    "is selected, destroy Joker to the right",
                    "and create {C:attention}#4#{} {C:purple}Tarot{} card or {C:planet}Planet{} card",
                    "if its sell value is less than {C:money}$3{}, {C:attention}otherwise",
                    "create {C:attention}#4# {C:dark_edition}High-Quality {C:spectral}Spectral{} card",
                    "{C:inactive}(Must have room)",
                },
            },
            j_bmjo_duke={
                name = 'Duke',
                text = {
                    'Each {C:attention}face{} card',
                    "held in hand",
                    "gives {X:mult,C:white} X#1# {} Mult,",
                    "retrigger all",
                    "{C:attention}Steel face{} cards",
                    "held in hand",
                    "{C:attention}#2#{} additional times",
                },
            },
            j_bmjo_supergodcard={
                name = 'Super God Card',
                text = {
                    "After defeating each {C:attention}Boss Blind{},",
                    "add {C:dark_edition}Negative{} to all {C:attention}consumable{} cards",
                    "in your possession, earn",
                    "the sell value of all {C:attention}consumable{} cards",
                    "in your possession at end of round",
                    '{C:inactive}(Currently {C:money}$#3#{C:inactive})',
                },
            },
            j_bmjo_chef={
                name = 'Chef',
                text = {
                    'When {C:attention}Blind {}is selected,',
                    'create a {C:dark_edition}Strange {C:attention}Food Joker',
                    "{C:inactive}(Must have room){}",
                },
            },
            j_bmjo_microchip={
                name = 'Microchip',
                text = {
                    "Copies ability of",
                    "{C:attention}Joker{} to the left and the right",
                },
            },
            j_bmjo_shifu={
                name = 'Sifu',
                text = {
                    'When {C:attention}Boss Blind{} is selected,',
                    'randomly increase {C:attention}#1#{} Joker card',
                    'cultivation {C:attention}#2#{} level',
                },
            },
            j_bmjo_rna={
                name = 'RNA',
                text = {
                    "If {C:attention}first two discard{} of round",
                    "has only {C:attention}1{} card",
                    "then create a {C:purple}Death{}",
                },
            },
        },
        Other={
            Cultivation={
                name = 'Cultivation',
                text = {
                    'The road is long and searching',
                    '{C:attention}#1#{}.lvl',
                },
            },
            High_Quality_Spectral_Card={
                name = 'High-Quality Spectral Card',
                text = {
                    'Talisman, Dejavu',
                    'Immolate, Cryptid',
                    'Trance, Medium',
                },
            },
        },
    },
    misc={
        dictionary = {
            l_compatible = " left compatible ",
            l_incompatible = " left incompatible ",
            r_compatible = " right compatible ",
            r_incompatible = " right incompatible ",
            n_active = "not active",
            y_active = "active!",
            f_leaves = "defoliation",
            c_perishable = "the shelf life is a bit short...",
            c_perishabled = "burnt up...",
            c_rental = "want to eat the King's meal?",
            c_eternal = "this is a hard dish",
            c_pinned = "line up on the left for orderly dining",
            s_preach = "cultivate diligently!",
            s_sifu = "the most mysterious path...",
            s_energy = "Cultivation",
        },
    },
}
