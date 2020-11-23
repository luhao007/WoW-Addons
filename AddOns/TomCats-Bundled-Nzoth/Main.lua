local addon = select(2, ...)

local D, L, P = addon.getLocalVars()
local TCL = addon.TomCatsLibs
local gameVersion = GetBuildInfo()
local _, QUEST_STATUS, setQuestLabelStyle, updateQuests, labels, buttons, quests, windowSettings
local tourWindow, newTourWindow, warfrontFont, warningFont, updateTimer
local questTrackingColumnName, enemyReactColumnName
local GetVignettes_Orig = C_VignetteInfo.GetVignettes
local playerFaction, enemyFaction = addon.playerFaction, addon.enemyFaction
local initializeQuests

local function suppressVignettes()
    local stack = debugstack()
    if (string.find(stack, "SilverDragon")) then return true end
    if (string.find(stack, "RareScanner")) then return true end
    if (string.find(stack, "NPCScan")) then return true end
    if (string.find(stack, "Blizzard_FlightMap")) then return true end
    local mapID = C_Map.GetBestMapForUnit("player")
    if (mapID and (mapID == addon.params["Vignette MapID 1"] or mapID == addon.params["Vignette MapID 2"])) then return false end
    if (WorldMapFrame and (WorldMapFrame:GetMapID() == addon.params["Vignette MapID 1"] or WorldMapFrame:GetMapID() == addon.params["Vignette MapID 2"])) then return false end
    return true
end

function C_VignetteInfo.GetVignettes()
    local vignettes = GetVignettes_Orig()
    if (suppressVignettes()) then return vignettes end
    for creatureID, creature in pairs(D["Creatures_1"].records) do
        local vignetteInfo = creature["Vignette Info"]
        if (vignetteInfo and vignetteInfo.name) then
            local location = D["Creatures_1"][creatureID]["Locations"][addon.getLocationIndex1()]
            if (location) then
                table.insert(vignettes, vignetteInfo.vignetteGUID)
            end
        end
    end
    for creatureID, creature in pairs(D["Creatures_2"].records) do
        local vignetteInfo = creature["Vignette Info"]
        if (vignetteInfo and vignetteInfo.name) then
            local location = D["Creatures_2"][creatureID]["Locations"][addon.getLocationIndex2()]
            if (location) then
                table.insert(vignettes, vignetteInfo.vignetteGUID)
            end
        end
    end
    return vignettes
end

local GetVignetteInfo_Orig = C_VignetteInfo.GetVignetteInfo

function C_VignetteInfo.GetVignetteInfo(vignetteGUID)
    if (suppressVignettes()) then return GetVignetteInfo_Orig(vignetteGUID) end
    local creature = D["Creatures by Vignette GUID"][vignetteGUID]
    if (creature) then
        return creature["Vignette Info"]
    end
    local vignetteInfo = GetVignetteInfo_Orig(vignetteGUID)
    if not vignetteInfo then return nil end
    if (C_VignetteInfo.GetVignettePosition(vignetteGUID, P["Vignette MapID 1"]) and D["Creatures by Vignette ID"][vignetteInfo.vignetteID]) then
        vignetteInfo.atlasName = "VignetteEventElite"
        vignetteInfo.onWorldMap = true
        vignetteInfo.hasTooltip = true
        vignetteInfo.isUnique = true
    end
    if (C_VignetteInfo.GetVignettePosition(vignetteGUID, P["Vignette MapID 2"]) and D["Creatures by Vignette ID"][vignetteInfo.vignetteID]) then
        vignetteInfo.atlasName = "VignetteEventElite"
        vignetteInfo.onWorldMap = true
        vignetteInfo.hasTooltip = true
        vignetteInfo.isUnique = true
    end
    return vignetteInfo
end

local GetVignettePosition_Orig = C_VignetteInfo.GetVignettePosition

function C_VignetteInfo.GetVignettePosition(vignetteGUID, uiMapID)
    if (suppressVignettes()) then return GetVignettePosition_Orig(vignetteGUID, uiMapID) end
    if (uiMapID == P["Vignette MapID 1"]) then
        local creature = D["Creatures by Vignette GUID"][vignetteGUID]
        if (creature and D["Creatures_1"][creature["Creature ID"]]) then
            local location = D["Creatures_1"][creature["Creature ID"]]["Locations"][addon.getLocationIndex1()]
            if (location) then
                local vector2D = CreateFromMixins(Vector2DMixin)
                vector2D.x = location[1]
                vector2D.y = location[2]
                return vector2D
            end
        end
    end
    if (uiMapID == P["Vignette MapID 2"]) then
        local creature = D["Creatures by Vignette GUID"][vignetteGUID]
        if (creature and D["Creatures_2"][creature["Creature ID"]]) then
            local location = D["Creatures_2"][creature["Creature ID"]]["Locations"][addon.getLocationIndex2()]
            if (location) then
                local vector2D = CreateFromMixins(Vector2DMixin)
                vector2D.x = location[1]
                vector2D.y = location[2]
                return vector2D
            end
        end
    end
    return GetVignettePosition_Orig(vignetteGUID, uiMapID)
end

local FindBestUniqueVignette_Orig = C_VignetteInfo.FindBestUniqueVignette

function C_VignetteInfo.FindBestUniqueVignette(vignetteGUIDs)
    local index = FindBestUniqueVignette_Orig(vignetteGUIDs)
    if (suppressVignettes()) then return index end
    if (not index) then
        local primaryMatch, secondaryMatch
        for i = 1, #vignetteGUIDs, 1 do
            if (not secondaryMatch) then
                local creature = D["Creatures by Vignette GUID"][vignetteGUIDs[i]]
                if (creature) then
                    secondaryMatch = i
                end
            end
            if ((not primaryMatch) and (#vignetteGUIDs > 1) and (i ~= secondaryMatch)) then
                local vignetteInfo = GetVignetteInfo_Orig(vignetteGUIDs[i])
                if (vignetteInfo and (not vignetteInfo.isDead)) then
                    primaryMatch = i
                end
            end
        end
        if (primaryMatch) then return primaryMatch end
        if (secondaryMatch) then return secondaryMatch end
    end
    return index
end

local function replaceMapOnShow(mapFrame)
    local dataproviders = mapFrame["dataProviders"]
    local provider
    for k, v in pairs(dataproviders) do
        if (k.uniqueVignettesGUIDs) then
            provider = k
        end
    end
    function provider:OnShow()
        self:RegisterEvent("VIGNETTES_UPDATED");
        self.ticker = C_Timer.NewTicker(0.1, function() self:UpdatePinPositions() end);
    end
    if (provider.ticker) then
        provider.ticker:Cancel()
        provider:OnShow()
    end
end

local function ADDON_LOADED(self)
    replaceMapOnShow(WorldMapFrame)
    if not BattlefieldMapFrame then
        hooksecurefunc("BattlefieldMap_LoadUI", function() replaceMapOnShow(BattlefieldMapFrame) end)
    else
        replaceMapOnShow(BattlefieldMapFrame)
    end
    windowSettings = addon.savedVariables.character.windowSettings or { width = 360, height = 330 }
    local completeFont = CreateFont("Complete")
    completeFont:SetFontObject(SystemFont_Small)
    completeFont:SetTextColor(0, 1, 0)
    local incompleteFont = CreateFont("Incomplete")
    incompleteFont:SetFontObject(SystemFont_Small)
    incompleteFont:SetTextColor(0.75, 0.75, 0.75)
    local unavailableFont = CreateFont("Unavailable")
    unavailableFont:SetFontObject(SystemFont_Small)
    unavailableFont:SetTextColor(1, 0, 0)
    warfrontFont = CreateFont("Warfront Timer")
    warfrontFont:SetFontObject(SystemFont_Small)
    warfrontFont:SetJustifyH("CENTER")
    warfrontFont:SetTextColor(1, 1, 0)
    warningFont = CreateFont("Warning Font")
    warningFont:SetFontObject(SystemFont_Small)
    warningFont:SetJustifyH("CENTER")
    warningFont:SetTextColor(1, 0, 0)
    QUEST_STATUS = {
        COMPLETE = {
            getImage = function() return 973338, 124/256, 160/256, 94/128, 126/128 end,
            font = completeFont,
            texture = "complete",
            color = { r = 0, g = 1, b = 0 }
        },
        INCOMPLETE = {
            getImage = function() return 1121272, 576/1024, 608/1024, 373/512, 405/512 end,
            font = incompleteFont,
            texture = "incomplete",
            color = { r = 0.75, g = 0.75, b = 0.75 }
        },
        UNAVAILABLE = {
            getImage = function() return "Interface\\Buttons\\UI-GroupLoot-Pass-Up" end,
            font = unavailableFont,
            texture = "unavailable",
            color = { r = 1, g = 0, b = 0 }
        }
    }
    questTrackingColumnName = ("%s Tracking ID"):format(playerFaction)
    enemyReactColumnName = ("%s React"):format(enemyFaction)
    TCL.Events.RegisterEvent("PLAYER_LOGOUT", addon)
    TCL.Events.RegisterEvent("QUEST_LOG_UPDATE", addon)
    C_Timer.After(5,addon.checkForQuestUpdates)
    TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
end

TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)

function addon.checkForQuestUpdates()
    addon.QUEST_LOG_UPDATE()
    C_Timer.After(5, addon.checkForQuestUpdates)
end

function addon:PLAYER_LOGOUT()
    if (tourWindow) then
        windowSettings.width = tourWindow.frame:GetWidth()
        windowSettings.height = tourWindow.frame:GetHeight()
        windowSettings.point, _, windowSettings.relativePoint, windowSettings.x, windowSettings.y = tourWindow:GetPoint(1)
        addon.savedVariables.character.windowSettings = windowSettings
    end
end

function addon:QUEST_LOG_UPDATE()
    addon.refreshStatusForAllCreatures()
end

local lastWaypoint

local function onClickWayPoint(pin, creature)
    if (TomTom) then
        local playerMapID = C_Map.GetBestMapForUnit("player")
        local pinMapID = pin:GetMap():GetMapID()
        if (pinMapID == playerMapID) then
            if (addon.params["Vignette MapID 1"] == playerMapID) then
                if (lastWaypoint) then
                    TomTom:RemoveWaypoint(lastWaypoint)
                end
                local location = creature["Locations"][addon.getLocationIndex1()]
                lastWaypoint = TomTom:AddWaypoint(pinMapID, location[1], location[2], {
                    title = creature["Name"],
                    persistent = false,
                    minimap = true,
                    world = true
                })
            elseif (addon.params["Vignette MapID 2"] == playerMapID) then
                if (lastWaypoint) then
                    TomTom:RemoveWaypoint(lastWaypoint)
                end
                local location = creature["Locations"][addon.getLocationIndex2()]
                lastWaypoint = TomTom:AddWaypoint(pinMapID, location[1], location[2], {
                    title = creature["Name"],
                    persistent = false,
                    minimap = true,
                    world = true
                })
            end
        end
    end
end

function addon:OpenWorldMapToZone()
    if TomCatsRareMapFrame then
        if TomCatsRareMapFrame:IsShown() and (WorldMapFrame:GetMapID() == tonumber("1527") or WorldMapFrame:GetMapID() == tonumber("1530")) then
            HideUIPanel(WorldMapFrame)
        else
            local currentLocation = C_Map.GetBestMapForUnit("player")
            local preferredLocation = tonumber("1527")
            if currentLocation and currentLocation == tonumber("1530") then
                preferredLocation = tonumber("1530")
            end
            WorldMapFrame:SetDisplayState(3)
            WorldMapFrame:SetMapID(preferredLocation)
            if not TomCatsRareMapFrame:IsShown() then
                TomCatsRarePanelToggle:OnClick()
            end
        end
    end
end

local LOOT_NOUN_COLOR = CreateColor(1.0, 0.82, 0.0, 1.0)

function addon.showItemTooltip(self, creature, showCreatureName, offX, offY)
    local tooltip = EmbeddedItemTooltip
    tooltip:SetOwner(self, "ANCHOR_RIGHT", -4, -8);
    if (showCreatureName) then
        local color = WORLD_QUEST_QUALITY_COLORS[1];
        EmbeddedItemTooltip:SetText(creature["Name"], color.r, color.g, color.b);
    end
    local footerText
    if (creature["Loot"]) then
        local itemID
        if type(creature["Loot"]) == "table" then
            if creature["Loot"].items then
                itemID = creature["Loot"].items[1]
                if #(creature["Loot"].items) > 1 then
                    footerText = ("+ %d more items"):format(#(creature["Loot"].items) - 1)
                end
            end
        else
            itemID = creature["Loot"]
        end
        if itemID then
            GameTooltip_AddBlankLinesToTooltip(tooltip, 1);
            GameTooltip_AddColoredLine(EmbeddedItemTooltip, LOOT_NOUN, LOOT_NOUN_COLOR, true);
            EmbeddedItemTooltip_SetItemByID(EmbeddedItemTooltip.ItemTooltip, itemID)
        end
    end
    if footerText then
        EmbeddedItemTooltip.BottomFontString:SetText(footerText)
        EmbeddedItemTooltip.BottomFontString:SetShown(true)
    end
    EmbeddedItemTooltip:Show()
end

function addon.hideItemTooltip()
    EmbeddedItemTooltip:Hide()
end

local function pinOnClick(pin)
    local creature = D["Creatures by Vignette ID"][pin.vignetteID]
    if (creature) then
        onClickWayPoint(pin, creature)
    end
end

local VignettePinMixin_OnMouseEnter_Orig = VignettePinMixin.OnMouseEnter

function VignettePinMixin:OnMouseEnter()
    local creature = D["Creatures by Vignette ID"][self.vignetteID]
    if (creature) then
        self:SetScript("OnMouseUp", pinOnClick)
        addon.showItemTooltip(self, creature, true, 10, 5)
    else
        return VignettePinMixin_OnMouseEnter_Orig(self)
    end
end

local VignettePinMixin_OnMouseLeave_Orig = VignettePinMixin.OnMouseLeave

function VignettePinMixin:OnMouseLeave()
    local creature = D["Creatures by Vignette ID"][self.vignetteID]
    if (creature) then
        addon.hideItemTooltip()
    else
        return VignettePinMixin_OnMouseLeave_Orig(self)
    end
end

addon.raresLog1 = {
    creatures = D["Creatures_1"].records,
    locationIndex = addon.getLocationIndex1(),
    updated = true
}

addon.raresLog2 = {
    creatures = D["Creatures_2"].records,
    locationIndex = addon.getLocationIndex2(),
    updated = true
}

local function GetRaresLog1()
    addon.raresLog1.locationIndex = addon.getLocationIndex1();
    return addon.raresLog1
end

local function GetRaresLog2()
    addon.raresLog2.locationIndex = addon.getLocationIndex2();
    return addon.raresLog2
end

if (TomCats and TomCats.Register) then
    TomCats:Register(
        {
            raresLogHandlers = {
                [tonumber("1527")] = {
                    raresLog = GetRaresLog1
                },
                [tonumber("1530")] = {
                    raresLog = GetRaresLog2
                }
            }
        }
    )
end
