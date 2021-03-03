-- AtlasLoot_Classes

-- atlasloot_hooks.lua:
-- Modifies AtlasLoot's base code in some way to either
-- fix something or add a feature

local addonName, addonTable = ...

local AtlasLoot = _G.AtlasLoot

local strsplit = strsplit

--if we are running with AtlasLoot before v8, cancel
if AtlasLoot and ATLASLOOT_VERSION_NUM then
  return
end

--taken unmodified from Template_Select.lua (called by our hook function)
local function GetStartAndEndPos(self)
  if not self.enableScroll then 
    return 1, self.numContent
  end
  local numEntrys = self.numContent
  local selected = self.curPos
  local startPos, endPos = 1,1
  if selected then
    if selected+self.numEntrys-1 >= numEntrys then
      startPos = numEntrys - self.numEntrys + 1
      endPos = numEntrys 
    else
      startPos = selected
      endPos = selected + self.numEntrys - 1
    end
  else
    startPos = 1
    endPos = self.numEntrys
  end
  
  return startPos, endPos
end

--originally from Template_Select.lua, modified to add dynamic cointextures ("texture:file:left:right:top:bottom")
local function SetupCoin(coinTexture, button, selected)
  if coinTexture and coinTexture:sub(1,8) == "texture:" then
    local _, texture, left, right, top, bottom = strsplit(":", coinTexture)

    if texture then    
      button.coin:SetTexCoord(left or 0, right or 1, top or 0, bottom or 1)
      button.coin:SetTexture(texture)

      if selected then
        button.coin:SetDesaturated(false)
      else
        button.coin:SetDesaturated(true)
      end
    else
      button.coin:SetTexCoord(0, 1, 0, 1)
      if selected then
        button.coin:SetTexture(_G.AtlasLoot.IMAGE_PATH.."gold")
      else
        button.coin:SetTexture(_G.AtlasLoot.IMAGE_PATH.."silver")
      end
    end
  end
end

--taken from Template_Select.lua
local function UpdateScroll(self)
  if not self or not self.data or self.numContent < 1 then return end
  local startPos, endPos = GetStartAndEndPos(self)
  local info
  for i = 1, #self.buttons do
    local button = self.buttons[i]
    info = self.data[startPos + i - 1]
    
    if info then
      assert(info.id, "No 'id' found for button")
      button.info = info
      button.ttTitle = info.tt_title
      button.ttText = info.tt_text
      button.label:SetText(info.name or UNKNOWN)
      if self.selected and self.selected[2] == info.id then
        button:SetChecked(true)
        if self.showSelectedCoin then
          SetupCoin(info.coinTexture, button, true)
          button.coin:Show()
        else
          button.coin:Hide()
        end
      else
        button:SetChecked(false)
        if self.showSelectedCoin then
          SetupCoin(info.coinTexture, button, false)
          button.coin:Show()
        else
          button.coin:Hide()
        end
      end
    else
      button:Hide()
    end
  end
end
--install hook
local ALGUI = _G["AtlasLoot_GUI-Frame"]
local bossSelect = ALGUI.boss
hooksecurefunc(bossSelect, "UpdateContent", UpdateScroll)
hooksecurefunc(bossSelect, "SetSelected", UpdateScroll)
