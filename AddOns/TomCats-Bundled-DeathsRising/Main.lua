local addon = select(2, ...)

local D, L, P = addon.getLocalVars()
local TCL = addon.TomCatsLibs
local QUEST_STATUS, windowSettings
local GetVignettes_Orig = C_VignetteInfo.GetVignettes

local zoneMapID = 118

local spawnTimer = 600

local eventStarts = {
    [1] = 1605054000 + 120, -- NA
    [2] = 1605054000 + 120 - spawnTimer * 12, -- KR
    [3] = 1605097200 + 120, -- EU
    [4] = 1605054000 + 120 - spawnTimer * 12, -- TW
    [5] = 1605054000 + 120 - spawnTimer * 12, -- CN
}

local eventStartsTime

local function EventStartTime()
    if (not eventStartsTime) then
        eventStartsTime = eventStarts[GetCurrentRegion()] or eventStarts[1]
    end
    return eventStartsTime
end

local function NextSpawnInfo()
    local servertime = GetServerTime()
    local elapsed = servertime - EventStartTime() + spawnTimer
    local quotient = elapsed % (20 * spawnTimer)
    local index = math.floor(quotient / spawnTimer)
    local remaining = spawnTimer - quotient % spawnTimer
    return index + 1, remaining
end

local function SpawnTimerByIndex(index)
    local nextIndex, nextRemaining = NextSpawnInfo()
    if (nextIndex == index) then
        return nextRemaining
    end
    if (index > nextIndex) then
        return nextRemaining + (index - nextIndex) * spawnTimer
    end
    return nextRemaining + (20 - nextIndex + index) * spawnTimer
end

local function suppressVignettes()
    if (HandyNotes and TomCats_Account.DeathsRisingEnableHandyNotesPlugin) then
        return true
    end
    local stack = debugstack()
    if (string.find(stack, "SilverDragon")) then return true end
    if (string.find(stack, "RareScanner")) then return true end
    if (string.find(stack, "NPCScan")) then return true end
    if (string.find(stack, "Blizzard_FlightMap")) then return true end
    local mapID = C_Map.GetBestMapForUnit("player")
    if (mapID and mapID == addon.params["Vignette MapID"]) then return false end
    if (WorldMapFrame and WorldMapFrame:GetMapID() == addon.params["Vignette MapID"]) then return false end
    return true
end

function C_VignetteInfo.GetVignettes()
    local vignettes = GetVignettes_Orig()
    if (suppressVignettes()) then return vignettes end
    for _, creature in pairs(D["Creatures"].records) do
        local vignetteInfo = creature["Vignette Info"]
        if (vignetteInfo and vignetteInfo.name) then
            table.insert(vignettes, vignetteInfo.vignetteGUID)
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
    if (C_VignetteInfo.GetVignettePosition(vignetteGUID, P["Vignette MapID"]) and D["Creatures by Vignette ID"][vignetteInfo.vignetteID]) then
        vignetteInfo.atlasName = "nazjatar-nagaevent"
        vignetteInfo.onWorldMap = true
        vignetteInfo.hasTooltip = true
        vignetteInfo.isUnique = true
    end
    return vignetteInfo
end

local GetVignettePosition_Orig = C_VignetteInfo.GetVignettePosition

function C_VignetteInfo.GetVignettePosition(vignetteGUID, uiMapID)
    if (suppressVignettes()) then return GetVignettePosition_Orig(vignetteGUID, uiMapID) end
    if (uiMapID == P["Vignette MapID"]) then
        local creature = D["Creatures by Vignette GUID"][vignetteGUID]
        if (creature) then
            local location = D["Creatures"][creature["Creature ID"]]["Location"]
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
    for k, _ in pairs(dataproviders) do
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

local function ADDON_LOADED(_, _, addonName)
    if (addonName == "TomCats-Bundled-DeathsRising") then
        TCL.Events.UnregisterEvent("ADDON_LOADED", ADDON_LOADED)
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
        TomCats.DeathsRising.charm:SetHandler("OnClick", addon.OpenWorldMapToZone)
        TCL.Events.RegisterEvent("QUEST_LOG_UPDATE", addon)
        C_Timer.After(5,addon.checkForQuestUpdates)
        if (TomCats.DeathsRising.openOnStart) then
            addon.OpenWorldMapToZone()
            TomCats.UpdateAll()
        end
    end
end
TCL.Events.RegisterEvent("ADDON_LOADED", ADDON_LOADED)

function addon.checkForQuestUpdates()
    addon.QUEST_LOG_UPDATE()
    C_Timer.After(5, addon.checkForQuestUpdates)
end

function addon:QUEST_LOG_UPDATE()
    addon.refreshStatusForAllCreatures()
    if (HandyNotes) then
        HandyNotes.UpdateWorldMapPlugin("TomCat's Tours: Death's Rising")
        HandyNotes:UpdateMinimapPlugin("TomCat's Tours: Death's Rising")
    end
end

local lastWaypoint

function addon:OpenWorldMapToZone()
    if TomCatsRareMapFrame then
        if TomCatsRareMapFrame:IsShown() and WorldMapFrame:GetMapID() == zoneMapID then
            HideUIPanel(WorldMapFrame)
        else
            WorldMapFrame:SetDisplayState(3)
            WorldMapFrame:SetMapID(zoneMapID)
            if not TomCatsRareMapFrame:IsShown() then
                TomCatsRarePanelToggle:OnClick()
            end
        end
    else
        -- todo: cleanup
        DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Warning: TomCat's Tours must be installed and enabled for Death's Rising to function properly|r")
    end
end

local LOOT_NOUN_COLOR = CreateColor(1.0, 0.82, 0.0, 1.0)
local COLOR_WHITE = CreateColor(1.0, 1.0, 1.0, 1.0)
local COLOR_RED = CreateColor(1.0, 0.0, 0.0, 1.0)
local PIN_SHARING = string.gsub(MAP_PIN_SHARING_TOOLTIP,".*|c","|c")

function addon.showItemTooltip(self, creature, showCreatureName, _, _)
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
--            GameTooltip_AddBlankLinesToTooltip(tooltip, 1);
            local atlasName
            if (self.Texture) then
                atlasName = self.Texture:GetAtlas()
            end
            --todo: localize
            if ("VignetteKill" == atlasName) then
                local secondsToSpawn = SpawnTimerByIndex(creature["Spawn Index"])
                GameTooltip_AddColoredLine(EmbeddedItemTooltip, ("Respawn in: %s"):format(SecondsToTime(secondsToSpawn, true)), COLOR_WHITE, true);
            else
                GameTooltip_AddColoredLine(EmbeddedItemTooltip, ("Active"), COLOR_RED, true);
            end
            GameTooltip_AddColoredLine(EmbeddedItemTooltip, LOOT_NOUN, LOOT_NOUN_COLOR, true);
            EmbeddedItemTooltip_SetItemByID(EmbeddedItemTooltip.ItemTooltip, itemID)
            C_Timer.NewTimer(0, function()
                local ilevelText = EmbeddedItemTooltipTooltipTextLeft2:GetText()
                if (ilevelText) then
                    EmbeddedItemTooltipTooltipTextLeft2:SetText(string.gsub(ilevelText, "100","110"))
                end
            end)
        end
        footerText = footerText or ""
        if (TomTom) then
            footerText = footerText .. ("\n\n|cff00ff00<%s>|r"):format(L["Click to view creature details"]) .. "\n\n" ..
                    ("|cff00ff00<%s>|r"):format(L["Control-Click TomTom"]) .. "\n\n" .. PIN_SHARING
        else
            footerText = footerText .. ("\n\n|cff00ff00<%s>|r"):format(L["Click to view creature details"]) .. "\n\n" ..
                    ("|cff999999<%s>|r"):format(L["Control-Click TomTom"]) .. "\n\n" .. PIN_SHARING
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
local rareCreaturesLogTimeFormatter = "%dh %02dm"
local function ClickRarePin(self, isCreature)
    local creature
    if (isCreature) then
        creature = self
    else
        creature = D["Creatures by Vignette ID"][self.vignetteID]
    end
    if (creature) then
        if (IsShiftKeyDown()) then
            local linktemplate = "|cffffff00|Hworldmap:%s:%s:%s|h[|A:Waypoint-MapPin-ChatIcon:13:13:0:0|a Map Pin Location]|h|r %s %s"
            local location = creature["Location"]
            if (location) then
                local timerText
                local seconds = SpawnTimerByIndex(creature["Spawn Index"])
                if (seconds > (20 * spawnTimer - spawnTimer)) then
                    timerText = "up now"
                else
                    local foundPin
                    for pin in WorldMapFrame:EnumeratePinsByTemplate("VignettePinTemplate") do
                        if (pin.vignetteID and pin.vignetteID == creature["Vignette ID"]) then
                            if (pin:IsShown() and pin.Texture:GetAtlas() == "nazjatar-nagaevent") then
                                foundPin = pin
                            end
                        end
                    end
                    if (foundPin) then
                        timerText = "up now"
                    else
                        local hours = math.floor(seconds / 3600);
                        local minutes = math.floor((seconds % 3600) / 60);
                        seconds = seconds % 60
                        timerText = " in " .. rareCreaturesLogTimeFormatter:format(hours, minutes)
                    end
                end
                local link = string.format(linktemplate,WorldMapFrame:GetMapID(),math.floor(location[1] * 10000),math.floor(location[2] * 10000),creature["Name"], timerText)
                if (IsControlKeyDown()) then
                    ChatEdit_InsertLink(link)
                else
                    SendChatMessage(link, "CHANNEL", nil, 1)
                end
            end
        elseif (IsControlKeyDown() and TomTom) then
            local playerMapID = C_Map.GetBestMapForUnit("player")
            local pinMapID = WorldMapFrame:GetMapID()
            if (pinMapID == playerMapID) then
                if (lastWaypoint) then
                    TomTom:RemoveWaypoint(lastWaypoint)
                end
                local location = creature["Location"] or creature["Locations"][raresLog.locationIndex]
                if location then
                    lastWaypoint = TomTom:AddWaypoint(WorldMapFrame:GetMapID(), location[1], location[2], {
                        title      = creature["Name"],
                        persistent = false,
                        minimap    = true,
                        world      = true
                    })
                end
            end
        elseif (IsControlKeyDown()) then
            ChatFrame1:AddMessage(("|cffff0000%s|r"):format(L["Must have TomTom"]))
        else
            if WorldMapFrame:IsMaximized() then
                WorldMapFrame.BorderFrame.MaximizeMinimizeFrame:Minimize()
            end
            if not TomCatsRareMapFrame:IsShown() then
                TomCatsRarePanelToggle:OnClick()
            end
            PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
            TomCatsRareMapFrame.RaresFrame:Hide()
            TomCatsRaresLogFrame_ShowRareDetails(creature)
        end
    end
end

local VignettePinMixin_OnMouseEnter_Orig = VignettePinMixin.OnMouseEnter

function VignettePinMixin:OnMouseEnter()
    local creature = D["Creatures by Vignette ID"][self.vignetteID]
    if (creature) then
        self:SetScript("OnMouseUp", function(self)
            ClickRarePin(self)
        end)
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

if (HandyNotes) then
    local incompleteIcon = {icon = 1121272, tCoordLeft = 728/1024, tCoordRight = 760/1024, tCoordTop = 409/512, tCoordBottom = 441/512 }
    local completeIcon = {icon = 973338, tCoordLeft = 124/256, tCoordRight = 160/256, tCoordTop = 94/128, tCoordBottom = 126/128 }
    local nilFunc = function() return nil end
    local coordLookup = {}
    local HandyNotesPlugin = {
        GetNodes2 = function(_, uiMapID, minimap)
            if (uiMapID ~= addon.params["Vignette MapID"]) then return nilFunc end
            if (not TomCats_Account.DeathsRisingEnableHandyNotesPlugin) then return nilFunc end
            local vignettes = {}
            for creatureID, creature in pairs(D["Creatures"].records) do
                local vignetteInfo = creature["Vignette Info"]
                if (vignetteInfo and vignetteInfo.name) then
                    local location = creature["Location"]
                    if (location and (((creature["Status"] == addon.STATUS.COMPLETE) or (creature["Status"] == addon.STATUS.LOOT_ELIGIBLE)))) then
                        table.insert(vignettes, D["Creatures"][creatureID])
                    end
                end
            end
            local i = 0
            return function()
                i = i + 1
                local creature = vignettes[i]
                if (creature) then
                    local coords = creature["Location"]
                    local coord = math.floor(coords[1] * 10000) * 10000 + math.floor(coords[2] * 10000)
                    coordLookup[coord] = creature
                    local icon = incompleteIcon
                    if (creature["Status"] == addon.STATUS.COMPLETE) then
                        icon = completeIcon
                    end
                    local alpha = 1.0
                    if (minimap) then
                        alpha = 0.50
                    end
                    return coord, uiMapID,
                    icon,
                    2.0, alpha
                else
                    return nil
                end
            end
        end,
        OnEnter = function(pinHandler, _, coord)
            addon.showItemTooltip(pinHandler, coordLookup[coord], true, 10, 5)
        end,
        OnLeave = function()
            addon.hideItemTooltip()
        end,
        OnClick = function(_, button, down, _, coord)
            if button == "LeftButton" and not down then
                ClickRarePin(coordLookup[coord], true)
            end
        end
    }

    local HandyNotesOptions = {
        type="group",
        name="TomCat's Tours: Death's Rising",
        get = function() return TomCats_Account.DeathsRisingEnableHandyNotesPlugin or false end,
        set = function(_, v)
            TomCats_Account.DeathsRisingEnableHandyNotesPlugin = v
        end,
        args = {
            enablePlugin = {
                type = "toggle",
                arg = "enable_plugin",
                name = "Enable Plugin",
                order = 1,
                width = "normal",
            }
        }
    }

    HandyNotes:RegisterPluginDB("TomCat's Tours: Death's Rising", HandyNotesPlugin, HandyNotesOptions)
end

addon.raresLog = {
    creatures = D["Creatures"].records,
    updated = true,
    zone = 118
}

local function GetRaresLog()
    local raresLog = addon.raresLog
    if not raresLog.isSorted then
        raresLog.isSorted = true
        raresLog.creatures_sorted = { }
        local rareNames = { }
        local lookupByName = { }
        for _, v in pairs(raresLog.creatures) do
            local name = v["Creature ID"]
            if not name then
                raresLog.isSorted = false
            else
                table.insert(rareNames, name)
                lookupByName[name] = v
            end
        end
        table.sort(rareNames)
        for _, v in ipairs(rareNames) do
            table.insert(raresLog.creatures_sorted, 1, lookupByName[v])
        end
    end
    return addon.raresLog
end





if (TomCats and TomCats.Register) then
    TomCats:Register(
            {
                slashCommands = {
                    {
                        command = "DEATHSRISING",
                        desc = "Toggle Rares of Death's Rising Window",
                        func = addon.OpenWorldMapToZone
                    }
                },
                name = "Rares of Death's Rising",
                version = "2.0.25",
                raresLogHandlers = {
                    [zoneMapID] = {
                        raresLog = GetRaresLog
                    }
                }
            }
    )
end
