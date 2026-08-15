local _, ns = ...
local L = ns.L

local WhatsNew = {}
ns.WhatsNew = WhatsNew

local VERSIONS = {
    --[[
    {
        version = "4.4.0",
        features = {
            {
                title = L["Assign sound to ability ready"],
                description = L["You can now assign a custom sound to a tracked ability and play it when that ability becomes ready."],
                preview = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Preview\\sound_alert.png",
                previewWidth = 760,
                previewHeight = 345,
            }, 
            {
                title = L["Track custom Auras on cooldown icons"],
                description = L["A cooldown can now display an Aura even when it is not provided by Blizzard's Cooldown Manager. Open Cooldown Settings, right-click an Essential or Utility ability, then choose CMC > Cooldown > Set Aura and enter the Aura's Spell ID. You can also reverse the Aura swipe or make the icon glow while the Aura is active."],
            },
        },
    },   
    ]]
    {
        version = "5.0.0",
        features = {
            {
                title = L["Make Tracked Buff Bars your own"],
                description = L["Tracked Buff Bars now come with a full set of customization options. Choose a bar texture, move the icon to either side, match the bar height to the icon, create a clean square style with separate icon and bar borders, and customize the name and duration font. Open Edit Mode, select Tracked Buff Bars, and find everything under Bar Styling."],
                preview = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Preview\\cooldownManager_squareIcons_BuffBar.png",
                previewWidth = 569,
                previewHeight = 263,
            },
            {
                title = L["Styling has moved to Edit Mode"],
                description = L["Viewer styling now lives where you use it: directly in Edit Mode. Select a Cooldown Manager viewer to change its icon style, fonts, glows, colors, visibility, layout, and other viewer-specific options. The regular CMC settings remain the home for global behavior, profiles, and advanced configuration."],
                preview = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Preview\\cmc_settings_in_preview.png",
                previewWidth = 569,
                previewHeight = 263,
            },
        },
    },
    {
        version = "4.4.0",
        features = {
            {
                title = L["Assign sound to ability ready"],
                description = L["You can now assign a custom sound to a tracked ability and play it when that ability becomes ready."],
                preview = "Interface\\AddOns\\CooldownManagerCentered\\Media\\Preview\\sound_alert.png",
                previewWidth = 760,
                previewHeight = 345,
            },
        },
    },
}

function WhatsNew:Show()
    local lib = LibStub("LibWhatsNew-1.0")
    local version = C_AddOns.GetAddOnMetadata("CooldownManagerCentered", "Version") or VERSIONS[#VERSIONS].version

    -- debug show always
    -- ns.db.global.lastSeenWhatsNewVersion = nil
    return lib:Show({
        addonName = "Cooldown Manager Centered",
        frameName = "CooldownManagerCenteredWhatsNewFrame",
        title = L["What's new in Cooldown Manager Centered"],
        currentVersion = version,
        versions = VERSIONS,
        savedVariables = ns.db.global,
        lastSeenKey = "lastSeenWhatsNewVersion",
        configRoot = ns.db,
    })
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("PLAYER_LOGIN")
eventFrame:SetScript("OnEvent", function(self)
    self:UnregisterEvent("PLAYER_LOGIN")
    C_Timer.After(1.1, function()
        if ns.db then
            WhatsNew:Show()
        end
    end)
end)
