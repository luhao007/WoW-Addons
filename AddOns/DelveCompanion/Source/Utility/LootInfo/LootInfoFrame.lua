local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region

---@type number Item ID of [Bountiful Coffer](https://www.wowhead.com/item=254250/bountiful-coffer).
local BOUNTIFUL_COFFER_ITEM_CODE = 254250
--#endregion

---@class (exact) LootInfoFrame : LootInfoFrameXml
DelveCompanion_LootInfoFrameMixin = {}

local function GetLootRarity(ilvl)
    for _, rarityInfo in ipairs(Config.LOOT_RARITY) do
        if ilvl >= rarityInfo.from and ilvl <= rarityInfo.to then
            return rarityInfo.color:WrapTextInColorCode(ilvl)
        end
    end

    return tostring(ilvl)
end

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnLoad()
    -- Logger:Log("LootInfo OnLoad start")

    ---@see DefaultPanelBaseTemplate Blizzard's template
    ---@diagnostic disable-next-line undefined-field
    self.TitleContainer.TitleText:SetText(_G["LOOT"])

    do
        self.ColumnHeaders.Tier:SetText(strtrim(format(_G["GARRISON_TIER"], "")))

        local container = self.ColumnHeaders.Container

        local bountiful = Item:CreateFromItemID(BOUNTIFUL_COFFER_ITEM_CODE)
        bountiful:ContinueOnItemLoad(function()
            container.Bountiful.Text:SetText(bountiful:GetItemName())
            container.Bountiful.Icon:SetAtlas("delves-bountiful")
        end)

        container.Vault.Text:SetText(_G["DELVES_GREAT_VAULT_LABEL"])
        container.Vault.Icon:SetAtlas("GreatVault-32x32")

        local map = Item:CreateFromItemID(Config.BOUNTY_MAPS[LE_EXPANSION_MIDNIGHT])
        map:ContinueOnItemLoad(function()
            container.Map.Text:SetText(map:GetItemName())
            container.Map.Icon:SetTexture("interface/icons/icon_treasuremap")
        end)

        container:Layout()
    end

    for tier, lootInfo in ipairs(Config.DELVES_LOOT_INFO_DATA) do
        ---@type LootInfoRowXml
        local rowFrame = CreateFrame("Frame", nil, self.Rows,
            "DelveCompanionLootInfoRowTemplate")
        rowFrame.layoutIndex = tier

        rowFrame.Tier:SetText(tostring(tier))

        local container = rowFrame.Container
        container.Bountiful.Text:SetText(GetLootRarity(lootInfo.bountifulLvl))
        container.Vault.Text:SetText(GetLootRarity(lootInfo.vaultLvl))
        container.Map.Text:SetText(lootInfo.mapLvl and GetLootRarity(lootInfo.mapLvl) or "-")
    end

    self.Rows:Layout()
end

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnShow()
    --Logger:Log("LootInfo OnShow start")
end

--#region XML Annotations

--- `DelveCompanionLootInfoHeaderTemplate`
---@class (exact) LootInfoHeaderXml : Frame, LayoutChild
---@field Icon Texture
---@field Text FontString

---@class (exact) LootInfoHeaderContainer : HorizontalLayoutFrame
---@field Bountiful LootInfoHeaderXml
---@field Map LootInfoHeaderXml
---@field Vault LootInfoHeaderXml

--- `DelveCompanionLootInfoColumnHeadersTemplate`
---@class (exact) LootInfoColumnHeadersXml : Frame
---@field Tier FontString
---@field Container LootInfoHeaderContainer

--- `DelveCompanionLootInfoElementTemplate`
---@class (exact) LootInfoElementXml : Frame, LayoutChild
---@field Text FontString

---@class (exact) LootInfoRowContainer : HorizontalLayoutFrame
---@field Bountiful LootInfoElementXml
---@field Map LootInfoElementXml
---@field Vault LootInfoElementXml

--- `DelveCompanionLootInfoRowTemplate`
---@class (exact) LootInfoRowXml : Frame, LayoutChild
---@field Tier FontString
---@field Container LootInfoRowContainer

--- `DelveCompanionLootInfoFrameTemplate`
---@class (exact) LootInfoFrameXml : Frame
---@field CloseButton Button
---@field ColumnHeaders LootInfoColumnHeadersXml
---@field Rows VerticalLayoutFrame
--#endregion
