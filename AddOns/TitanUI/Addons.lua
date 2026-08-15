--[[ Addons.lua

Add a list of addons with info to an edit box.

By: The Titan Panel Development Team

--]]

-- ******************************** Constants *******************************

local add_on_id, NS = ... -- folder and Lua table
local _G = _G             --getfenv(0);

-- ******************************** Variables *******************************
local trace = false -- true / false    Make true when debug output is needed.


--=========================== Addons =============================
local function GetAddons()
   local t = {}
   for i = 1, GetNumGroupMembers() do
      tinsert(t, (UnitName("raid" .. i)))
   end
   sort(t)

   -- Clear any old list
   local alist = {}
   -- Create a new list of indexes
   local numAddons = C_AddOns.GetNumAddOns()
   for i = 1, numAddons do
      table.insert(alist, i)
   end

   -- Sort the addon list by title.
   table.sort(alist, function(a, b)
      local folderA = C_AddOns.GetAddOnInfo(a)
      local folderB = C_AddOns.GetAddOnInfo(b)
      return folderA < folderB
   end)

   -- create the list to display
   local sep = " : "
   local str = "Folder" .. sep
       .. "Name" .. sep
       .. "Loaded" .. sep
       .. "Status" .. sep
       .. "\n"

   for i = 1, numAddons do
      local name, title, notes, loadable, reason, security = C_AddOns.GetAddOnInfo(i)
      if reason then
         reason = _G["ADDON_" .. reason] -- localize
      else
         reason = ""
      end
      local loaded = ""
      if loadable then
         loaded = ""
      else
         loaded = "Not Loaded"
             .. " [" .. tostring(reason) .. "]"
      end
      str = str
          .. tostring(name) .. sep
          .. tostring(title) .. sep
          .. tostring(loaded)
          .. "\n"
   end

   return str
end


function NS.GetAddons()
   NS.ListBox:Show(GetAddons())
end
