local deck = {
	name = "Blocky Deck",
	pos = { x = 8, y = 0 },
	loc_txt = {
		name = "Blocky Deck",
		text = {
			"Start run with no",
            "cards below rank {C:attention}5{}",
            "{C:inactive,s:0.8}(Aces are removed){}"
		},
	},
	config = {},
}

deck.apply = function(self)
    G.E_MANAGER:add_event(Event({
        func = function()
            local i = 1
            while i <= #G.playing_cards do
                local v = G.playing_cards[i]

                if v:get_id() < 5 or v:get_id() == 14 then
                    v:remove()
                else
                    i = i + 1
                end
            end
            return true
        end
    }))
end

return deck