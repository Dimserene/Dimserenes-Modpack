-- region Mirrored

SMODS.Shader({key = 'mirrored', path = "mirrored.fs"})

local mirrored = SMODS.Edition({
    key = "mirrored",
    loc_txt = {
        name = "Mirrored",
        label = "Mirrored",
        text = {
		"{C:attention}Retrigger{} this card",
		"If a {C:attention}Mirror{} is not",
		"present, {C:red}self-destructs{}",
		"at end of round"
        }
    },
    discovered = true,
    unlocked = true,
    disable_base_shader = true,
    disable_shadow = true,
    shader = 'mirrored',
    config = {},
    in_shop = false,
    calculate = function(self, card, context)
	-- yeah ngl i took this directly from ortalab... i hope this works?
	if context.repetition_only or (context.retrigger_joker_check and context.other_card == card) then
		return {
			repetitions = 1,
			card = card,
			colour = G.C.FILTER,
			message = localize('k_again_ex')
		}     
	end
    end,
})
-- endregion Mirrored