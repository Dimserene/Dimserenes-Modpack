--- Divvy's Settings for Balatro - Settings.lua
--
-- A few helper functions that create a new tab in the game's settings,
-- which has pagination. The pagination can be leveraged by 'registering'
-- a mod's settings in the global `G.DV.options` table alongside the function
-- to provide the mod's settings UI.

if not DV then DV = {} end

DV.settings = false

if not DV.settings then
   DV._start_up = Game.start_up
   function Game:start_up()
      DV._start_up(self)

      -- Initialise my mods' sub-table in settings:
      if not G.SETTINGS.DV then G.SETTINGS.DV = {} end

      -- Initialise a global variable that will hold setting tab functions:
      -- This must be re-initialised on every launch, so that only loaded mods
      -- are present as options; it cannot be in `G.SETTINGS.DV` for instance.
      if not G.DV then G.DV = {} end
      if not G.DV.options then G.DV.options = {} end
      -- Usage example:
      --   G.DV.options["Score Preview"] = "get_preview_settings_page"
      -- NOTE: the function name must be in the `DV` global table

      -- Needs to be defined after G is initialised, which is easiest here:
      function G.FUNCS.dv_settings_change(args)
         if not args or not args.cycle_config then return end
         local callback_args = args.cycle_config.opt_args

         local page_object = callback_args.ui
         local page_wrap = page_object.parent

         local new_option_idx = args.to_key
         local new_option_def = callback_args.indexed_options[new_option_idx]

         page_wrap.config.object:remove()
         page_wrap.config.object = UIBox({
            definition = DV[G.DV.options[new_option_def]](),
            config = { parent = page_wrap, type = "cm" }
         })
         page_wrap.UIBox:recalculate()
      end
   end

   function DV.create_settings_tab(num_tabs)
      -- Ensure that no duplicate tabs are created:
      -- (the game (usually) has 4 settings tabs)
      if num_tabs > 4 then return nil end

      return {
         label = "Other",
         tab_definition_function = DV.get_settings_tab,
      }
   end

   function DV.get_settings_tab()
      local options = {}
      local first_option_def = nil
      for option_name, option_def in pairs(G.DV.options) do
         if #options == 0 then first_option_def = option_def end
         table.insert(options, option_name)
      end

      local first_page = UIBox({
            definition = DV[first_option_def](),
            config = {type = "cm"}
      })

      if #options == 1 then
         return
            {n=G.UIT.ROOT, config={align="cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
                {n=G.UIT.O, config={object = first_page}}
            }}
      end

      return
         {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
             {n=G.UIT.C, config={align = "cm"}, nodes={
                 {n=G.UIT.R, config={align = "tm", minh = 5.5}, nodes={
                     {n=G.UIT.O, config={object = first_page}}
                 }},
                 {n=G.UIT.R, config={align = "bm"}, nodes={
                     create_option_cycle({
                           options = options,
                           current_option = 1,
                           opt_callback = "dv_settings_change",
                           opt_args = {ui = first_page, indexed_options = options},
                           w = 5, colour = G.C.RED, cycle_shoulders = false})
                 }}
             }}
         }}
   end

   DV.settings = true
end
