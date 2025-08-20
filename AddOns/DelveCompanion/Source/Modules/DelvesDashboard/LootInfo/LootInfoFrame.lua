local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Config
local Config = DelveCompanion.Config
---@type Lockit
local Lockit = DelveCompanion.Lockit

---@class (exact) LootInfoFrame : LootInfoFrameXml
DelveCompanion_LootInfoFrameMixin = {}

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnLoad()
    -- Logger.Log("LootInfo OnLoad start")

    ---@see DefaultPanelBaseTemplate Blizzard's template
    ---@diagnostic disable-next-line undefined-field
    self.TitleContainer.TitleText:SetText(_G["LOOT"])
    self.Header:SetText(Lockit.UI_LOOT_INFO_DESCRIPTION)

    self.DelveTiers.Title:SetText(strtrim(format(_G["GARRISON_TIER"], "")))

    local bountiful = Item:CreateFromItemID(Config.BOUNTIFUL_COFFER_ITEM_CODE)
    bountiful:ContinueOnItemLoad(function()
        self.BountifulGear.Title:SetText(bountiful:GetItemName() .. CreateAtlasMarkup("delves-bountiful", 16, 16))
    end)

    self.VaultGear.Title:SetText(_G["DELVES_GREAT_VAULT_LABEL"] .. CreateAtlasMarkup("GreatVault-32x32", 16, 16))

    local tiersText, bountifulText, vaultText = "", "", ""
    for tier, lootInfo in ipairs(Config.DELVES_LOOT_INFO_DATA) do
        tiersText = tiersText .. tier .. "\n"
        bountifulText = bountifulText .. lootInfo.bountifulLvl .. "\n"
        vaultText = vaultText .. lootInfo.vaultLvl .. "\n"
    end

    self.DelveTiers.Text:SetText(tiersText)
    self.BountifulGear.Text:SetText(bountifulText)
    self.VaultGear.Text:SetText(vaultText)

    if C_AddOns.IsAddOnLoaded(DelveCompanion.Definitions.DependencyAddonName.rio) then
        -- Display LootInfoFrame above the RIO Profile's Tooltip
        self:SetFrameStrata("HIGH")
    end
end

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnShow()
    --Logger.Log("LootInfo OnShow start")
end

--#region XML Annotations

--- `DelveCompanionColumnWithTitleTemplate`
---@class (exact) ColumnWithTitleXml : Frame
---@field Title FontString
---@field Text FontString

--- `DelveCompanionLootInfoFrameTemplate`
---@class (exact) LootInfoFrameXml : Frame
---@field Header FontString
---@field CloseButton Button
---@field DelveTiers ColumnWithTitleXml
---@field BountifulGear ColumnWithTitleXml
---@field VaultGear ColumnWithTitleXml
--#endregion
