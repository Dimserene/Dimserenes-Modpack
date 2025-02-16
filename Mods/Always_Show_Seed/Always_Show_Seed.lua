--- STEAMODDED HEADER
--- MOD_NAME: Always Show Seed
--- MOD_ID: Infarctus_Always_Show_Seed
--- MOD_AUTHOR: [infarctus]
--- MOD_DESCRIPTION: Shows the seed and makes you able to copy it at all time on the options
----------------------------------------------
------------MOD CODE -------------------------
local Orginal_create_UIBox_generic_options = create_UIBox_generic_options
function create_UIBox_generic_options(args)
  if  #args==0 and args.contents and #args.contents>=2 and args.contents[2]==nil and G.STAGE == G.STAGES.RUN then
    args.contents[2] = {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0}, nodes={
        {n=G.UIT.T, config={text = localize('b_seed')..": ", scale = 0.4, colour = G.C.WHITE}}
      }},
      {n=G.UIT.C, config={align = "cm", padding = 0, minh = 0.8}, nodes={
        {n=G.UIT.C, config={align = "cm", padding = 0, minh = 0.8}, nodes={
          {n=G.UIT.R, config={align = "cm", r = 0.1, colour = G.GAME.seeded and G.C.RED or G.C.BLACK, minw = 1.8, minh = 0.5, padding = 0.1, emboss = 0.05}, nodes={
            {n=G.UIT.C, config={align = "cm"}, nodes={
              {n=G.UIT.T, config={ text = tostring(G.GAME.pseudorandom.seed), scale = 0.43, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
            }}
          }}
        }}
      }},
      UIBox_button({col = true, button = 'copy_seed', label = {localize('b_copy')}, colour = G.C.BLUE, scale = 0.3, minw = 1.3, minh = 0.5,}),
    }}
  end
  return Orginal_create_UIBox_generic_options(args)
end
----------------------------------------------
------------MOD CODE END----------------------
