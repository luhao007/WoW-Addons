--[===[ File
This file contains 'recent changes' and notes for Titan Config.
It should be updated for each Titan release!

These are in a seperate file to
1) Increase the chance these strings get updated
2) Decrease the chance of breaking the code :).
--]===]

--- Release notes. Keep structure; most recent on 'top'
local recent_changes = {
   {
      version = "9.1.0",
      when = "2026/02/02",
      topics =  {
         {
            topic = "Titan Menus",
            lines = {
               "!! Menus have been rewritten !! The new menus will look a little different.",
               "-- Some menus were reordered or changed to fit the new scheme.",
               "Devs : The older scheme and the new scheme work side by side.",
               "-- .menuTextFunction will fail when Blizz removes deprecated code in the future - no idea when.",
               "-- If you wish to update, please see Bags for old and new menu schemes explained.",
               "Devs : Titan now honors color coding in registry.menuText.",
            },
         },
         {
            topic = "Titan Tooltips",
            lines = {
               "Internals changed due to Midnight 'secret' value errors, mostly in instances.",
               "!! New option in Tooltips and Frames to adjust tooltip timer - 0.0 - 10 sec.",
               "Devs : The registry.tooltipTitle is now optional allowing the title to be custom set.",
               "Devs : If your tooltip is not right, please use Titan Discord to message us for assistance.",
               "-- Especially if you use registry.tooltipCustomFunction ",
            },
         },
         {
            topic = "Titan Config",
            lines = {
               "Opening Config from Titan menu remains unavailable. Use Esc > Options as before.",
               "Profile Config now shows some toon info, as well as Gold and Post info if they are enabled.",
            },
         },
         {
            topic = "Titan Gold",
            lines = {
               "!! On first login the tracked list will only show that toon !!",
               "!! Gold data moved into Titan profiles, causing the need to login to toons again.",
               "Menus are changed:",
               "- Show and Delete are not available; the data is now part of the profile.",
               "- Delete is now delete toon profile",
               "Fix : Added back 'show color' option for those that want white text.",
               "Fix : 'gsub' error in button text.",
            },
         },
         {
            topic = "TitanPost",
            lines = {
               "New built-in! ",
               "Button info: ",
               ": ?? read/total from last open; ?? = not opened this session.",
               ": !! number of toons with expiring mail.",
            },
         },
         {
            topic = "Titan Fixes",
            lines = {
               "- Loot : Should not error on mouse over of new gear.",
               "- Titan : Should not get IsBattleground error on any WoW version.",
               "- Performance : Should now honor selected number of addons.",
            },
         },
      },
   },
   {
      version = "9.0.2",
      when = "2026/01/12",
      topics =  {
         {
            topic = "Titan TOC",
            lines = {
               "Update MoP and TWW ",
            },
         },
         {
            topic = "TitanXP",
            lines = {
               "The 'time played' should no longer spam on every reload / instance change / etc.",
            },
         },
         {
            topic = "Titan Config",
            lines = {
               "NOTE: Opening Config from Titan menu disabled in Midnight Beta until we figure out what the bleep is wrong :).",
            },
         },
         {
            topic = "Titan Config > Profile",
            lines = {
               "Added Mail info - if enabled and running.",
               "Added Gold info - if enabled and running.",
               "Added basic toon info for reference - after logging into that toon.",
            },
         },
      },
   },
   {
      version = "9.0.1",
      when = "2025/12/01",
      topics =  {
         {
         topic = "Profiles",
         lines = {
            "Profiles - Sync All added.",
            "- Acts as the old Global; overrides Sync.",
            "- See Titan > Config > Help > Profiles for more details on how this works.",
            },
         },
         {
            topic = "Titan > Config > Plugins",
            lines = {
               "Show (Hide) fixed; all features should be working again.",
            },
         },
      },
   },
   {
      version = "9.0.0",
      when = "2025/11/06",
      topics = {
            {
            topic = "Profiles",
            lines = {
               "Profiles are greatly changed.",
               "- Global is gone; replaced by a Sync scheme.",
               "- See Titan > Config > Help > Profiles for more details on how this works.",
               },
            },
            {
               topic = "Export / Import of Profiles",
               lines = {
                  "Profiles can be exported to be safely saved and imported to same or another system.",
                  "- See Titan > Config > Help > Export / Import for more details on how this works.",
               },
            },
            {
               topic = "Reset",
               lines = {
                  "Due to the Profile changing to Sync :",
                  "- /titan reset will reset the Profile used (could be a Sync).",
                  "- /titan reset all ",
                  "--- NEW slash command will act as a delete of Titan saved vars",
                  "--- Also accessable in Titan > Config > Advanced",
               },
            },
            {
               topic = "TitanUI",
               lines = {
                  "NEW built-in!",
                  "Left click will reload UI.",
                  "Menu gives access to :",
                  "- Select Titan config pages.",
                  "- Titan reset of profile (could be a Sync).",
                  "- Select dev tools, if available.",
               },
            },
            {
               topic = "Titan",
               lines = {
                  "Ace : Updated libs to Oct 2025 release - Should be Midnight ready!!",
                  "Plugins : Should be less space after, esp. for those with multiple info displayed such as Perf and Repair.",
                  "Help : Titan > Config > Help - More detailed info; Redesigned for readability.",
               },
            },
      },
   },
}

---Format the release notes
local function BuildList()
   local max = 5
   local res = ""
   for idx = 1, #recent_changes do -- A release
      res = res .. "\n"            -- spacer
      local rc = recent_changes[idx]

      if idx <= max then
         res = res
             .. TitanUtils_GetGoldText(rc.version .. " : " .. rc.when .. "\n")

         for tops = 1, #rc.topics do -- Topic of change
            local rct = rc.topics[tops]
            res = res
                .. TitanUtils_GetGreenText(rct.topic .. " : \n")

            for line = 1, #rct.lines do -- Change details
               local rctl = rct.lines[line]
               res = res .. TitanUtils_GetHighlightText(rctl .. " \n")
            end
         end
      end
   end

   return res
end
Titan_Global.recent_changes = BuildList()
