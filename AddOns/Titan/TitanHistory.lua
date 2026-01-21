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
   {
      version = "8.4.2",
      when = "2025/11/01",
      topics = {
         {
            topic = "Titan",
            lines = {
               "TOC update only.",
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
