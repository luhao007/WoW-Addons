local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

---@type Logger
local Logger = DelveCompanion.Logger
---@type Lockit
local Lockit = DelveCompanion.Lockit

--#region Constants

---@type string
local STATIC_POPUP_ADDON_LINK_ID = "StaticPopup_DelveCompanionAddonLink"

---@type string
local ADDON_METADATA_VERSION = "Version"
--#endregion

---@class (exact) AddonSettingsFrame : AddonSettingsFrameXml
DelveCompanionSettingsFrameMixin = {}

---@param self MagicButton
---@param data Link
---@param tooltipText string
local function SetupLinkButton(self, data, tooltipText)
    self:SetTextToFit(data.name)

    self:SetScript("OnClick", function()
        StaticPopup_Show(STATIC_POPUP_ADDON_LINK_ID, data.name, _, data.url)
    end)
    self:SetScript("OnEnter", function()
        local tooltip = GameTooltip
        tooltip:SetOwner(self, "ANCHOR_TOP")
        GameTooltip_SetTitle(tooltip, tooltipText, HIGHLIGHT_FONT_COLOR)

        tooltip:Show()
    end)
    self:SetScript("OnLeave", function()
        securecall(GameTooltip.Hide, GameTooltip)
    end)
end

---@param self AddonSettingsFrame
function DelveCompanionSettingsFrameMixin:OnLoad()
    -- Logger:Log("SettingsFrame OnLoad start...")

    -- Title panel
    self.TitlePanel.Text:SetText(Lockit.UI_ADDON_NAME)
    self.TitlePanel.Version:SetText(C_AddOns.GetAddOnMetadata(addonName, ADDON_METADATA_VERSION))

    -- Slash Commands section
    local slashCmdText = string.join("\n", Lockit.UI_SETTINGS_SLASH_CMD_TEXT
    , Lockit.UI_SETTINGS_SLASH_CMD_SHOWDELVES
    )
    self.SlashCmdInfo.Text:SetText(slashCmdText)

    -- Localization section
    self.LocalizationSection.Title:SetText(Lockit.UI_SETTINGS_TRANSLATION_TITLE)
    self.LocalizationSection:Layout()

    -- Footer with links
    local defs = DelveCompanion.Definitions
    local links = self.Footer.Links
    links.Text:SetText(Lockit.UI_SETTINGS_LINKS_TITLE)
    SetupLinkButton(links.CurseForge, defs.Links.CurseForge, Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_CURSEFORGE)
    SetupLinkButton(links.Wago, defs.Links.Wago, Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WAGO)
    SetupLinkButton(links.WoWInt, defs.Links.WoWInt, Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_WOWINT)
    SetupLinkButton(links.GitHub, defs.Links.GitHub, Lockit.UI_SETTINGS_ADDON_LINK_TOOLTIP_GITHUB)
    links:Layout()
end

---@param self AddonSettingsFrame
function DelveCompanionSettingsFrameMixin:OnShow()
    -- Logger:Log("SettingsFrame OnShow start...")
end

StaticPopupDialogs[STATIC_POPUP_ADDON_LINK_ID] = {
    text = Lockit.UI_SETTINGS_ADDON_LINK_POPUP_TEXT,
    button1 = _G["CLOSE"],
    OnShow = function(self, data)
        local function HidePopup()
            StaticPopup_Hide(STATIC_POPUP_ADDON_LINK_ID)
        end

        local editBox = self:GetEditBox()
        editBox:SetScript("OnEscapePressed", HidePopup)
        editBox:SetScript("OnKeyUp", function(_, key)
            if IsControlKeyDown() and key == "C" then
                HidePopup()
            end
        end)
        editBox:SetMaxLetters(0)
        editBox:SetText(data)
        editBox:HighlightText()
    end,
    hasEditBox = true,
    editBoxWidth = 350,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

--#region Xml annotations

---@class (exact) AddonSettingsFrameTitlePanelXml : Frame
---@field Text FontString
---@field Version FontString

---@class (exact) AddonSettingsFrameSlashCmdInfoXml : Frame
---@field Text FontString

---@class (exact) AddonSettingsFrameLocalizationElementXml : Frame
---@field FlagIcon Texture
---@field Name FontString

---@class (exact) AddonSettingsFrameLocalizationSectionXml : VerticalLayoutFrame
---@field Title FontString
---@field ruRU AddonSettingsFrameLocalizationElementXml
---@field zhCN AddonSettingsFrameLocalizationElementXml
---@field zhTW AddonSettingsFrameLocalizationElementXml

---@class (exact) AddonSettingsFrameFooterLinksXml : HorizontalLayoutFrame
---@field Text FontString
---@field CurseForge MagicButton
---@field Wago MagicButton
---@field WoWInt MagicButton
---@field GitHub MagicButton

---@class (exact) AddonSettingsFrameFooterXml : Frame
---@field Links AddonSettingsFrameFooterLinksXml

--- `DelveCompanionSettingsFrameTemplate`
---@class (exact) AddonSettingsFrameXml : Frame
---@field TitlePanel AddonSettingsFrameTitlePanelXml
---@field SlashCmdInfo AddonSettingsFrameSlashCmdInfoXml
---@field LocalizationSection AddonSettingsFrameLocalizationSectionXml
---@field Footer AddonSettingsFrameFooterXml
--#endregion
