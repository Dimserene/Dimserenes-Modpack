return {
    descriptions = {
        Joker={
            j_bmjo_heart={
                name = '腐化之心<骷髅模式>',
                text = {
                    '拥有至少{C:money}$#1#{}时',
                    '若最终得到的筹码',
                    '{C:red}未达到{}所需筹码',
                    '不会死亡并失去{C:money}$#2#{}',
                    '{C:inactive}(#3#)',
                },
            },
            j_bmjo_supermeteor={
                name = '巨型流星',
                text = {
                    '使用{C:planet}星球牌{}时',
                    '{C:attention}额外提升{}一次牌型等级',
                },
            },
            j_bmjo_smartcowboy={
                name = '精装牛仔',
                text = {
                    '每拥有{C:money}$#2#{}',
                    '{X:mult,C:white}X#1#{}倍率',
                    '{C:inactive}(当前为{X:mult,C:white}X#3#{C:inactive})',
                },
            },
            j_bmjo_clover={
                name = '四叶草',
                text = {
                    '每{C:attention}售出{}一张小丑有{C:green}#1#/#2#{}几率',
                    '生成{C:attention}#3#{}张随机的{C:planet}星球牌{}或{C:tarot}塔罗牌{}',
                    '选择{C:attention}盲注{}时摧毁右侧的小丑牌',
                    '若该小丑牌的价值低于{C:money}$3{}',
                    '则生成{C:attention}#4#{}张随机的{C:planet}星球牌{}或{C:tarot}塔罗牌{}',
                    '反之则生成{C:attention}#4#{}张随机的{C:dark_edition}优质{}{C:spectral}幻灵牌{}',
                    '{C:inactive}(必须有空位){}',
                },
            },
            j_bmjo_duke={
                name = '公爵',
                text = {
                    '留在手中的每一张{C:attention}人头牌{}',
                    '会给予{X:mult,C:white}X#1#{}倍率',
                    '如果同时还是{C:attention}钢铁牌{}',
                    '{C:attention}重复触发{}额外{C:attention}#2#{}次所有效果',
                },
            },
            j_bmjo_supergodcard={
                name = '大神卡',
                text = {
                    '击败{C:attention}Boss盲注{}时',
                    '为{C:attention}消耗牌{}槽位中所有牌添加{C:dark_edition}负片{}',
                    '每回合结束时',
                    '获得等同所有{C:attention}消耗牌{}售价的资金',
                    '{C:inactive}(当前{C:money}$#3#{C:inactive})',
                },
            },
            j_bmjo_chef={
                name = '粗心大厨',
                text = {
                    "选择{C:attention}盲注{}时",
                    "随机生成一张",
                    "{C:dark_edition}奇怪{}的{C:attention}食物小丑{}",
                    "{C:inactive}(必须有空位){}",
                },
            },
            j_bmjo_microchip={
                name = '芯片',
                text = {
                    '复制左右两侧',
                    '{C:attention}小丑牌{}的能力',
                },
            },
            j_bmjo_shifu={
                name = '师父',
                text = {
                    '在选择{C:attention}Boss盲注{}时',
                    '随机提高{C:attention}#1#{}张小丑牌',
                    '修为{C:attention}#2#{}重境界',
                },
            },
        },
        Other={
            cultivation={
                name = '修为',
                text = {
                    '路漫漫而求索',
                    '{C:attention}#1#{}重境界',
                },
            },
        },
    },
    misc={
        dictionary = {
            l_compatible = " 左侧兼容 ",
            l_incompatible = " 左侧不兼容 ",
            r_compatible = " 右侧兼容 ",
            r_incompatible = " 右侧不兼容 ",
            n_active = "未激活",
            y_active = "已激活",
            f_leaves = "落叶",
            c_perishable = "保质期有点短...",
            c_perishabled = "烤糊了...",
            c_rental = "还想吃霸王餐?",
            c_eternal = "这是道硬菜",
            c_pinned = "靠左排队有序用餐",
            s_preach = "修为精进！",
            s_sifu = "道最玄...",
            s_energy = "冲天！",
        },
    },
}