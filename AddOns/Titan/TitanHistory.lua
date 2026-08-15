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
      version = "9.3.1",
      when = "2026/08/08",
      topics = {
         {
            topic = "TitanXP",
            lines = {
               "Restore XP kills to level.",
            },
         },
         {
            topic = "TitanUI",
            lines = {
               "Add lists for key binds and addons.",
            },
         },
      },
   },
   {
      version = "9.3.0",
      when = "2026/07/22",
      topics = {
         {
            topic = "Titan",
            lines = {
               "Remove frame adjust code.",
               "Remove old drop down lib code.",
               "Unused var cleanup.",
               "Ace3: Checkbox - r1399-alpha.",
            },
         },
      },
   },
   {
      version = "9.2.7",
      when = "2026/07/21",
      topics = {
         {
            topic = "Titan",
            lines = {
               "Update for API changes in 12.1.0.",
            },
         },
         {
            topic = "Location",
            lines = {
               "Fix for top/bottom coords option not working.",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Consolidated merged / grouped routines.",
               "Cleanup of unused switches.",
            },
         },
      },
   },
   {
      version = "9.2.6",
      when = "2026/06/10",
      topics = {
         {
            topic = "TOC",
            lines = {
               "Update BC:Anniversary to 2.5.6.",
               "Update TWW to 12.0.7.",
            },
         },
      },
   },
   {
      version = "9.2.5",
      when = "2026/06/10",
      topics = {
         {
            topic = "TOC",
            lines = {
               "Update MoP to 5.5.4.",
            },
         },
         {
            topic = "Gold",
            lines = {
               "Fix for missing toons on servers with a space in the name.",
            },
         },
         {
            topic = "Titan",
            lines = {
               "Tooltips : Fix for tooltip covering TitanUI menu.",
            },
         },
      },
   },
   {
      version = "9.2.4",
      when = "2026/05/07",
      topics = {
         {
            topic = "Titan",
            lines = {
               "Utils : Revert change on frame timer out - it hides control frames (Vol / Clock).",
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
