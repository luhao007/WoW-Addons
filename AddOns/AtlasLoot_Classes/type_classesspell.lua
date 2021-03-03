-- AtlasLoot_Classes

-- type_classesspell.lua:
-- Adds an AtlasLoot button type to handle spells

local addonName, addonTable = ...

local AtlasLoot = _G.AtlasLoot

--if we are running with AtlasLoot before v8, cancel
if AtlasLoot and ATLASLOOT_VERSION_NUM then
  return
end

local AL = AtlasLoot.Locales
local Spell = AtlasLoot.Button:AddType("ClassesSpell", "cspell")

-- LUA
local type = type

-- WoW
local GetSpellInfo = GetSpellInfo

-- AL
local GetAlTooltip = AtlasLoot.Tooltip.GetTooltip

local SpellClickHandler = nil

function Spell.OnSet(button, second)
  if not SpellClickHandler then
    SpellClickHandler = AtlasLoot.ClickHandler:Add(
    "Spell",
    {
      ChatLink = { "LeftButton", "Shift" },
      types = {
        ChatLink = true,
      },
    },
    AtlasLoot.db.Button.Spell.ClickHandler, 
    {
      { "ChatLink",   AL["Chat Link"],  "Add spell link into chat" },
    })
  end
  if not button then return end

  if second and button.__atlaslootinfo.secType then
    button.secButton.spell = button.__atlaslootinfo.secType[2]
    if type(button.secButton.spell) == "number" then
      button.secButton.spell = { id = button.secButton.spell }
    end
    if not button.secButton.spell.id then return end
    Spell.Refresh(button.secButton)
  else
    --__atlaslootinfo.type = { "ClassesSpell" , { id = 1, level = 1 } }
    
    button.spell = button.__atlaslootinfo.type[2]
    if type(button.spell) == "number" then
      button.spell = { id = button.spell }
    end
    if not button.spell.id then return end
    Spell.Refresh(button)
  end
end

function Spell.OnClear(button)
  button.spell = nil  
  button.secButton.spell = nil
  
end

function Spell.OnEnter(button)
  local tooltip = GetAlTooltip() 
  tooltip:ClearLines()
  tooltip:SetOwner(button, "ANCHOR_RIGHT", -(button:GetWidth() * 0.5), 24)
  tooltip:SetHyperlink(button.spellLink)
  tooltip:Show()
end

function Spell.OnLeave(button)
  GetAlTooltip():Hide()
end

function Spell.OnMouseAction(button, mouseButton)
  if not mouseButton then return end
  mouseButton = SpellClickHandler:Get(mouseButton)
  if mouseButton == "ChatLink" then
    AtlasLoot.Button:AddChatLink(button.spellLink)
  end
end


function Spell.Refresh(button)
  local spell = button.spell

  local spellName, spellRank, spellIcon = GetSpellInfo(spell.id)
  if not spellName then
    spellName = "?"
  end
  
  button.spellLink = GetSpellLink(spell.id)
  --invalid link, make a fake one (game will automatically recolor/rename if it has to)
  if not button.spellLink then
    button.spellLink = "|cff71d5ff|Hspell:"..spell.id.."|h["..spellName.."]|h|r"
  end

  if button.type == "secButton" then
  else
    button.name:SetText(spellName)

    local extraText = ""

    if spellRank and spellRank ~= "" then extraText = "|cFF9D9D9D"..spellRank.." " end
    if spell.rank and spell.rank ~= "" then extraText = extraText.."|cFF9D9D9D"..spell.rank.." " end
    if spell.level then extraText = extraText.."|cFFFFFFFFLevel: "..spell.level.." " end
    button.extra:SetText(extraText)
  end
  
  button.icon:SetTexture(spellIcon)
  
end
