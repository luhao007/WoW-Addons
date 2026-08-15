--[[ Key_binds.lua

Add a dump pf key binds to an edit box.

By: The Titan Panel Development Team

--]]

-- ******************************** Constants *******************************

local add_on_id, NS = ... -- folder and Lua table
local _G = _G             --getfenv(0);

-- ******************************** Variables *******************************
local trace = false -- true / false    Make true when debug output is needed.

--=========================== Key Binds =============================

local keys = {}

local SHIFT = "SHIFT%-"
local CTRL = "CTRL%-"
local ALT = "ALT%-"

local function grabBinding(command, category, ...)
   local cmdName = _G["BINDING_NAME_" .. command]
   --   print("Cmd:'"..tostring(cmdName).."'")

   -- Addon may put something other than string in category...
   local catName = _G[category]
   if type(catName) == 'table' then
      catName = "<table?>"
   else
   end

   -- store the bind with attribs
   local num_args = select('#', ...)
   --   print(tostring(num_args))
   for idx, val in ipairs { ... } do
      -- strip modifiers to get to 'root' key
      local root = val
      root = string.gsub(root, ALT, "")
      root = string.gsub(root, CTRL, "")
      root = string.gsub(root, SHIFT, "")

      tinsert(keys, {
         key_bind = val,
         key_bind_localized = GetBindingText(val, "KEY_", false),
         key_root = root,
         category = category,
         category_localized = catName,
         command = command,
         command_localized = _G["BINDING_NAME_" .. command],
      }
      -- GetBindingText
      -- KEY_ third param does not seem to work...
      -- BINDING_NAME_ as param does not seem to work...
      )

      --      print(tostring(#keys).." : "..tostring(val)
      --         .." "..keys[#keys].key_bind)
   end
end

function NS.GetKeyBinds(sort_type)
   local str = ""
   local numBindings = GetNumBindings()
   local cmdBound = 0
   for i = 1, numBindings do
      local command, category, key1, key2 = GetBinding(i)
      if key1 then
         cmdBound = cmdBound + 1
         grabBinding(GetBinding(i))
         --      dumpBinding(GetBinding(i))
      else
      end
   end

   if sort_type == "keys" then
      table.sort(keys, function(a, b)
         if a.key_root ~= b.key_root then
            return a.key_root < b.key_root
         end

         if a.key_bind_localized ~= b.key_bind_localized then
            return a.key_bind_localized < b.key_bind_localized
         end

         return false -- do not kill the caller
      end)
   elseif sort_type == "category" then
      table.sort(keys, function(a, b)
         if a.category_localized ~= b.category_localized then
            return a.category_localized < b.category_localized
         end

         if a.command_localized ~= b.command_localized then
            return a.command_localized < b.command_localized
         end

         if a.key_bind_localized ~= b.key_bind_localized then
            return a.key_bind_localized < b.key_bind_localized
         end

         return false -- do not kill the caller
      end)
   else
      -- could be a mess but display something...
   end
   --]]

   for idx = 1, #keys do
      --[[
   print(tostring(idx)
      .." "..tostring(keys[idx].key_bind)..""
      .." "..tostring(keys[idx].command)..""
   )
   --]]
      if sort_type == "keys" then
         str = str
             --      .." "..tostring(keys[idx].key_root)..""
             --      .." "..tostring(keys[idx].key_bind)..""
             .. " " .. tostring(keys[idx].key_bind_localized) .. ""
             .. " : " .. tostring(keys[idx].command_localized) .. ""
             .. " [" .. tostring(keys[idx].category_localized) .. "]"
             .. "\n"
      elseif sort_type == "category" then
         str = str
             --      .." "..tostring(keys[idx].key_root)..""
             --      .." "..tostring(keys[idx].key_bind)..""
             .. " " .. tostring(keys[idx].key_bind_localized) .. ""
             .. " [" .. tostring(keys[idx].category_localized) .. "]"
             .. " : " .. tostring(keys[idx].command_localized) .. ""
             .. "\n"
      else -- display something...
         str = str
             --      .." "..tostring(keys[idx].key_root)..""
             --      .." "..tostring(keys[idx].key_bind)..""
             .. " " .. tostring(keys[idx].key_bind_localized) .. ""
             .. " : " .. tostring(keys[idx].command_localized) .. ""
             .. " [" .. tostring(keys[idx].category_localized) .. "]"
             .. "\n"
      end
   end

   local summary = #keys .. " keys bound to " .. cmdBound .. " actions. " .. numBindings .. " total possible actions."
   str = str .. summary
   --print(summary)

   --return str

   NS.ListBox:Show(str)
end
