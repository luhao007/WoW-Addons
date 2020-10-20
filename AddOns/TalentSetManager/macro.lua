-- Talent Set Manager
-- by Vildiesel
-- EU-Well of Eternity

local format, lower = string.format, string.lower

local addonName, addonTable = ...
local L = addonTable.L

local macro_t = {talents = "pve", talents_pvp = "pvp"}
local macro_prefix = "TSM - "
local body_prefix = "#tsm "
local slashcmd = "/talentset "
local comment_header = "#Talent Set Manager#"

function addonTable:GetMacroID(v)
 local _, numMacros = GetNumMacros()

 for i = MAX_ACCOUNT_MACROS, MAX_ACCOUNT_MACROS + numMacros do
  local macroName, icon, body = GetMacroInfo(i)
  if body and body:find(comment_header) then
   local _, tt, _, name = body:match("\/talentset(%s+)(%w+)(%s+)(%C+)")
   if tt == macro_t[v.tt] and name == v.name then
    return i
   end
  end
 end
end

-- output strings
local function getMacroName(name)
 return (macro_prefix..name):sub(1, 16)
end

local function getMacroTexture(texture)
 if type(texture) ~= "number" then
  local s = string.lower(texture)
  if s:find("interface\\icons\\") then
   return s:gsub("interface\\icons\\", "")
  else
   return texture or "inv_misc_questionmark"
  end
 else
  return texture
 end
end

local function getMacroBody(v, overrideName)
 return comment_header.." "..L["macro_comment"].."\n"..slashcmd..macro_t[v.tt].." "..(overrideName or v.name)
end
--

function addonTable:UpdateMacro(v, newname, newtexture)
 local i = addonTable:GetMacroID(v)

 if not i or UnitAffectingCombat("player") then return end

 EditMacro(i, getMacroName(newname), getMacroTexture(newtexture or v.texture), getMacroBody(v, newname))
end

function addonTable:CreateMacro(v)
 if UnitAffectingCombat("player") or addonTable:GetMacroID(v) then return end

 local _, numMacros = GetNumMacros()

 if numMacros >= MAX_CHARACTER_MACROS then
  print("|cff00ffffTalent Set Manager|r -", L["macro_limit_reached"])
  return
 end

 local new_id = CreateMacro(getMacroName(v.name), getMacroTexture(v.texture), getMacroBody(v), 1)

 -- check if we can reach it, otherwise a new macro will be created with every drag, and we don't want it
 if not addonTable:GetMacroID(v) then 
  DeleteMacro(new_id)
  return
 end
 
 return true
end

function addonTable:DeleteMacro(v)
 local i = addonTable:GetMacroID(v)
 if i and not UnitAffectingCombat("player") then
  DeleteMacro(i)
  return true
 end
end






