local set_edition_ref = Card.set_edition
function Card.set_edition(self, edition, immediate, silent)

    set_edition_ref(self, edition, immediate, silent)
    if edition then
        if edition.mirrored then 
            if not self.edition then self.edition = {} end
	    self.edition.mirror_bound = true
            self.edition.mirrored = true
            self.edition.type = 'mirrored'
	end
    end

    if self.edition and not silent and edition.mirrored then
        G.CONTROLLER.locks.edition = true
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            blockable = not immediate,
            func = function()
                self:juice_up(1, 0.5)
                play_sound('tarot1', 1.2, 0.4)
               return true
            end
          }))
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            func = function()
                G.CONTROLLER.locks.edition = false
               return true
            end
          }))
    end
end

local card_draw_ref = Card.draw
function Card.draw(self, layer)
    card_draw_ref(self, layer)

    layer = layer or 'both'

    if (layer == 'shadow' or layer == 'both') then
        self.ARGS.send_to_shader = self.ARGS.send_to_shader or {}
        self.ARGS.send_to_shader[1] = math.min(self.VT.r*3, 1) + G.TIMERS.REAL/(28) + (self.juice and self.juice.r*20 or 0) + self.tilt_var.amt
        self.ARGS.send_to_shader[2] = G.TIMERS.REAL

        for k, v in pairs(self.children) do
            v.VT.scale = self.VT.scale
        end
    end

    if (layer == 'card' or layer == 'both') then
        if self.sprite_facing == 'front' then 
            if self.edition and self.edition.mirrored then
                self.children.center:draw_shader('mirrored', nil, self.ARGS.send_to_shader)
                if self.children.front and self.ability.effect ~= 'Stone Card' then
                    self.children.front:draw_shader('mirrored', nil, self.ARGS.send_to_shader)
                end
            end

            if self.seal then
                G.shared_seals[self.seal].role.draw_major = self
                G.shared_seals[self.seal]:draw_shader('dissolve', nil, nil, nil, self.children.center)
                if self.seal == 'Gold' then G.shared_seals[self.seal]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil, self.children.center) end
            end
		if self.debuff then
                    self.children.center:draw_shader('debuff', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then
                        self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)	-- draw front here because otherwise debuff looks bad
                    end
                end
		if self.greyed then
                    self.children.center:draw_shader('played', nil, self.ARGS.send_to_shader)
                    if self.children.front and self.ability.effect ~= 'Stone Card' then		-- don't draw front here
                    end
                end
        end
    end
end

    G.SHADERS['mirrored'] = love.graphics.newShader(SMODS.current_mod.path.."/assets/shaders/mirrored.fs")

    local e_mirrored = {order = 6, key = "e_mirrored", unlocked = true, discovered = true, name = "Mirrored", pos = {x=0,y=0}, atlas = 'Joker', set = "Edition", config = {mirror_bound = true}}

    G.P_CENTERS['e_mirrored'] = e_mirrored
    table.insert(G.P_CENTER_POOLS['Edition'], e_mirrored)