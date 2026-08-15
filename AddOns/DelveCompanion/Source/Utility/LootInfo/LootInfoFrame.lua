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

---@type number
local BASE_WIDTH_FRAME = 450
---@type number
local BASE_WIDTH_TRACK_MIDDLE = 385
---@type number
local BASE_WIDTH_THUMB_MIDDLE = 280

--#endregion

---@class (exact) LootInfoFrame : LootInfoFrameXml
---@field frameOverlap number Whether Loot Info frame overlaps with the frame it's opened from. Used to shrink the width of the frame and fit into the screen.
DelveCompanion_LootInfoFrameMixin = {}

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnLoad()
    -- Logger:Log("[LootInfo] OnLoad start")

    self.frameOverlap = 0

    ---@see DefaultPanelBaseTemplate Blizzard's template
    ---@diagnostic disable-next-line undefined-field
    self.TitleContainer.TitleText:SetText(_G["LOOT"])

    do
        local scrollFrame = self.RowsScroll
        local scrollBar = self.RowsScroll.ScrollBar
        ScrollUtil.InitHorizontalScrollFrameWithScrollBar(scrollFrame, scrollBar)

        scrollBar:ClearAllPoints()
        scrollBar:SetPoint("TOPLEFT", scrollFrame, "BOTTOMLEFT", 0, -3)
        scrollBar:SetPoint("TOPRIGHT", scrollFrame, "BOTTOMRIGHT", 0, -3)
    end

    local gildedStashSpell = Config.GILDED_STASH_SPELL_CODE
    local nemesisSpell = Config.AFFIXES.Nemesis[LE_EXPANSION_MIDNIGHT]
    do
        local headers = self.RowsScroll.Content.ColumnHeaders
        headers.Tier:SetText(strtrim(format(_G["GARRISON_TIER"], "")))

        local container = headers.Container

        local bountiful = Item:CreateFromItemID(Config.BOUNTIFUL_COFFER_ITEM_CODE)
        bountiful:ContinueOnItemLoad(function()
            container.Bountiful.Text:SetText(bountiful:GetItemName())
            container.Bountiful.Icon:SetAtlas("delves-bountiful")
        end)

        container.GildedStash.Text:SetText(C_Spell.GetSpellName(gildedStashSpell))
        container.GildedStash.Icon:SetTexture(C_Spell.GetSpellTexture(gildedStashSpell))

        local map = Item:CreateFromItemID(Config.BOUNTY_MAPS[LE_EXPANSION_MIDNIGHT])
        map:ContinueOnItemLoad(function()
            container.Map.Text:SetText(map:GetItemName())
            container.Map.Icon:SetTexture("interface/icons/icon_treasuremap")
        end)

        container.Nemesis.Text:SetText(C_Spell.GetSpellName(nemesisSpell))
        container.Nemesis.Icon:SetAtlas("delves-treasure-upgrade")

        container.Vault.Text:SetText(_G["DELVES_GREAT_VAULT_LABEL"])
        container.Vault.Icon:SetAtlas("GreatVault-32x32")

        container:Layout()
    end

    do
        local rows = self.RowsScroll.Content.Rows
        for tier = 1, #Config.DELVES_LOOT_INFO_DATA, 1 do
            ---@type LootInfoRowXml
            local rowFrame = CreateFrame("Frame", nil, rows,
                "DelveCompanionLootInfoRowTemplate")
            rowFrame.layoutIndex = tier

            rowFrame.Tier:SetText(tostring(tier))
        end

        rows:Layout()
    end

    do
        self.Tips.Text:SetText(string.format(Lockit.UI_LOOT_INFO_TIPS, C_Spell.GetSpellName(nemesisSpell),
            C_Spell.GetSpellTexture(gildedStashSpell), C_Spell.GetSpellName(gildedStashSpell)))
    end
end

local function GetLootRarity(ilvl)
    for _, rarityInfo in ipairs(Config.LOOT_RARITY) do
        if ilvl >= rarityInfo.from and ilvl < rarityInfo.to then
            ---@type ItemQualityColorData
            local data = ColorManager.GetColorDataForItemQuality(rarityInfo.quality)
            return data.color:WrapTextInColorCode(ilvl)
        end
    end

    return tostring(ilvl)
end

---@param frame LootInfoElementXml
---@param lootData DelveLootData?
local function SetTierLoot(frame, lootData)
    if not lootData then
        frame.Text:SetText("-")
        frame.Text:Show()
        frame.Text:SetPoint("CENTER")

        return
    end

    if lootData.itemLevel and lootData.crests then
        frame.Text:SetText(GetLootRarity(lootData.itemLevel) .. " + " .. lootData.crests[1].count)

        local currency = Config.UPGRADE_CRESTS[lootData.crests[1].track]
        frame.CrestWidget:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, currency)
        local color = ColorManager.GetColorDataForItemQuality(C_CurrencyInfo.GetCurrencyInfo(currency).quality)
        frame.CrestWidget:DisplayBorderForQuality(color)

        frame.Text:SetPoint("CENTER", -5, -1)
        frame.CrestWidget:SetPoint("LEFT", frame.Text, "RIGHT", 3, 0)

        frame.Text:Show()
        frame.CrestWidget:Show()
    elseif lootData.itemLevel then
        frame.Text:SetText(GetLootRarity(lootData.itemLevel))
        frame.Text:SetPoint("CENTER", 0, -1)
        frame.Text:Show()
    else
        do
            local crestData = lootData.crests[1]
            local widget = frame.CrestWidget
            local currency = Config.UPGRADE_CRESTS[crestData.track]
            widget:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, currency)
            local color = ColorManager.GetColorDataForItemQuality(C_CurrencyInfo.GetCurrencyInfo(currency).quality)
            widget:DisplayBorderForQuality(color)

            widget.displayLabel = true
            widget:SetLabelText(crestData.count)

            widget:SetPoint("CENTER", 7, -1)
            widget:Show()
        end

        do
            local crestData = lootData.crests[2]
            if crestData then
                local widget = frame.CrestWidget2
                local currency = Config.UPGRADE_CRESTS[crestData.track]
                widget:SetFrameInfo(DelveCompanion.Definitions.CodeType.Currency, currency)
                local color = ColorManager.GetColorDataForItemQuality(C_CurrencyInfo.GetCurrencyInfo(currency).quality)
                widget:DisplayBorderForQuality(color)

                widget.displayLabel = true
                widget:SetLabelText(crestData.count)

                widget:SetPoint("CENTER", -12, -1)
                widget:Show()

                frame.CrestWidget:SetPoint("CENTER", 37, -1)
            end
        end
    end
end

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnShow()
    --Logger:Log("[LootInfo] OnShow start")

    self.RowsScroll:SetHorizontalScroll(0)

    self:SetWidth(BASE_WIDTH_FRAME - self.frameOverlap)
    self.RowsScroll.ScrollBar.Track.Middle:SetHeight(BASE_WIDTH_TRACK_MIDDLE - self.frameOverlap)
    self.RowsScroll.ScrollBar.Track.Thumb.Middle:SetHeight(BASE_WIDTH_THUMB_MIDDLE - self.frameOverlap)

    ---@type LootInfoRowXml[]
    local rows = self.RowsScroll.Content.Rows:GetLayoutChildren()

    if not rows or #rows < 1 then
        self:Hide()
        return
    end

    for i, rowFrame in ipairs(rows) do
        local lootInfo = Config.DELVES_LOOT_INFO_DATA[i]

        local container = rowFrame.Container
        SetTierLoot(container.Bountiful, lootInfo.bountiful)
        SetTierLoot(container.Nemesis, lootInfo.nemesis or nil)
        SetTierLoot(container.GildedStash, lootInfo.gildedStash or nil)
        SetTierLoot(container.Map, lootInfo.map or nil)
        SetTierLoot(container.Vault, lootInfo.vault)
    end
end

---@param self LootInfoFrame
function DelveCompanion_LootInfoFrameMixin:OnHide()
    --Logger:Log("[LootInfo] OnHide start")

    self.frameOverlap = 0
end

--#region XML Annotations

--- `DelveCompanionLootInfoHeaderTemplate`
---@class (exact) LootInfoHeaderXml : Frame, LayoutChild
---@field Icon Texture
---@field Text FontString

---@class (exact) LootInfoHeaderContainer : HorizontalLayoutFrame
---@field Bountiful LootInfoHeaderXml
---@field Nemesis LootInfoHeaderXml
---@field GildedStash LootInfoHeaderXml
---@field Map LootInfoHeaderXml
---@field Vault LootInfoHeaderXml

--- `DelveCompanionLootInfoColumnHeadersTemplate`
---@class (exact) LootInfoColumnHeadersXml : Frame
---@field Tier FontString
---@field Container LootInfoHeaderContainer

--- `DelveCompanionLootInfoElementTemplate`
---@class (exact) LootInfoElementXml : Frame, LayoutChild
---@field Text FontString
---@field CrestWidget CustomActionWidget
---@field CrestWidget2 CustomActionWidget

---@class (exact) LootInfoRowContainer : HorizontalLayoutFrame
---@field Bountiful LootInfoElementXml
---@field Nemesis LootInfoElementXml
---@field GildedStash LootInfoElementXml
---@field Map LootInfoElementXml
---@field Vault LootInfoElementXml

--- `DelveCompanionLootInfoRowTemplate`
---@class (exact) LootInfoRowXml : Frame, LayoutChild
---@field Tier FontString
---@field Container LootInfoRowContainer

---@class (exact) LootInfoScrollContent : Frame
---@field ColumnHeaders LootInfoColumnHeadersXml
---@field Rows VerticalLayoutFrame

---@class (exact) LootInfoScroll : ScrollFrame
---@field ScrollBar EventFrame
---@field Content LootInfoScrollContent

---@class (exact) LootInfoTips : ScrollFrame
---@field Text FontString

--- `DelveCompanionLootInfoFrameTemplate`
---@class (exact) LootInfoFrameXml : Frame
---@field CloseButton Button
---@field RowsScroll LootInfoScroll
---@field Tips LootInfoTips
--#endregion
