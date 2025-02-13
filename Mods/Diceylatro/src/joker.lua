return function(joker_dir, jokers)
  SMODS.Atlas {
    key = "jokers",
    px = 71,
    py = 95,
    path = "jokers.png",
  }

  for k, j in pairs(jokers) do
    if type(j) == "string" then
      if type(k) == "number" then
        k = j
      end
      j = DiceyLatro.load(joker_dir .. "/" .. j) or j
    end
    if type(j) == "table" then
      if type(j.atlas) == "number" then
        local n = j.atlas
        j.atlas = "jokers"
        local x = n % 5
        if x == 0 then
          x = 5
        end
        j.pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      if type(j.soul_pos) == "number" then
        local n = j.soul_pos
        local x = n % 5
        if x == 0 then
          x = 5
        end
        j.soul_pos = { x = x - 1, y = math.ceil(n / 5) - 1 }
      end

      j.key = k
      if type(j.unlocked) ~= "boolean" then
        j.unlocked = true
      end
      j.discovered = false
      SMODS.Joker(j)
    end
  end
end
