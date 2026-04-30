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
      version = "9.2.2",
      when = "2026/04/28",
      topics = {
         {
            topic = "Alts",
            lines = {
               "Fix Gold value disappearing from tooltip on logout",
            },
         },
         {
            topic = "Gold",
            lines = {
               "Fix tooltip for All Servers - special thanks to Liefwing for the code!",
               "Gold Only option is back",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Time Played : Move override to Utils so both Titan and XP can use.",
               "Tooltip : Fix 'flash' on cursor leaving plugin, especially if using scale less than 1.",
            },
         },
      },
   },
   {
      version = "9.2.1",
      when = "2026/04/23",
      topics = {
         {
            topic = "Titan",
            lines = {
               "Update : Due to a git hitch, tooltip, an Alts fix, and History were not included in 9.2.0.",
            },
         },
      },
   },
   {
      version = "9.2.0",
      when = "2026/04/20",
      topics = {
         {
            topic = "Alts",
            lines = {
               "New built-in plugin to display profile info on Alts in tooltip format.",
            },
         },
         {
            topic = "TitanUI",
            lines = {
               "Tools : Added /eventtrace and /api",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Tooltip : Change to revert behavior to be same as GameTooltip - cursor over plugin controls tooltip show / hide.",
               "Core : TOC retail to 12.0.5; Foundational for Alts profile info",
               "Config : Fixed string in Import / Export text",
            },
         },
      },
   },
   {
      version = "9.1.7",
      when = "2026/04/05",
      topics = {
         {
            topic = "Gold",
            lines = {
               "Delete Database is back.",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Profile : deletes allowed when using Sync (All) - as long it is not a sync 'source' for any other profile",
            },
         },
      },
   },
   {
      version = "9.1.6",
      when = "2026/03/25",
      topics = {
         {
            topic = "Titan",
            lines = {
               "Scaling : Plugins should properly scale.",
               "Tooltip : New registry .tooltipTemplateFunction; prevent 'secret' errors.",
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
