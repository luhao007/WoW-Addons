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
   {
      version = "9.1.5",
      when = "2026/03/25",
      topics = {
         {
            topic = "Titan Repair",
            lines = {
               "Fix for Auto repair not working.",
               "Durability and cost should update after merchant repair.",
            },
         },
         {
            topic = "Titan",
            lines = {
               "LDB : Fix for LDB tooltips (OnTooltipShow)",
               "Config Bars : plugins can be adjusted vertically",
               "Locale : Several strings added.",
            },
         },
      },
   },
   {
      version = "9.1.4",
      when = "2026/03/15",
      topics = {
         {
            topic = "Titan Gold",
            lines = {
               "On Show / Hide update button to reflect new total.",
               "Show / Hide Menu cleanup: sort alpha and add server to names.",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Config : Open config from menu should work (again)",
               "Config : Titan in Addon Compartment should work (again)",
               "Config : Refactor code, partly in response to above.",
            },
         },
      },
   },
   {
      version = "9.1.3",
      when = "2026/03/08",
      topics = {
         {
            topic = "Titan Gold",
            lines = {
               "Added sort descending option.",
            },
         },
         {
            topic = "Titan XP",
            lines = {
               "Removed Kill to Level if secret values [Retail-only for now].",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Menu : Added open Edit Mode OR Config Bars All to hopefully be clearer as Blizzard migrates Edit Mode",
               "LDB : Fix for when LDB uses Blizzard_Menu scheme. [#1453].",
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
