--[[
-- Credit to ckknight for originally writing Cartographer_ZoneInfo
--]]
Cromulent = LibStub("AceAddon-3.0"):NewAddon("Cromulent", "AceHook-3.0")
local Cromulent, self = Cromulent, Cromulent
local CromulentDataProviderMixin = CreateFromMixins(MapCanvasDataProviderMixin)

local L = LibStub("AceLocale-3.0"):GetLocale("Cromulent")
local T = LibStub("LibTourist-3.0")
local table_concat = table.concat
local table_wipe = table.wipe
local GetMapInfo = C_Map.GetMapInfo
local GetMapInfoAtPosition = C_Map.GetMapInfoAtPosition
local GetProfessionInfo = GetProfessionInfo
local GetProfessions = GetProfessions
local COLOUR_RED = "ff0000"
local COLOUR_GREEN = "00ff00"
local COLOUR_YELLOW = "ffff00"
local FISHING_SKILL_FMT = "|cff%s%s|r |cff%s[%d]|r"

-- Temporary until LibTourist knows what's up with fishing levels.
local FISHING_ENABLED = false

local WORLDMAP_CONTINENT = Enum.UIMapType.Continent

-- World map IDs. Taken from WorldMapFrame:GetMapID()
local WORLDMAP_AZEROTH_ID = 947

function CromulentDataProviderMixin:OnAdded(mapCanvas)
    MapCanvasDataProviderMixin.OnAdded(self, mapCanvas)

    if not self.Frame then
        -- Create the frame and attach it to the WorldMap canvas container
        self.Frame = CreateFrame(
            "Frame",
            nil,
            self:GetMap():GetCanvasContainer()
        )

        -- Set the frame size
        self.Frame:SetSize(400, 128)

        -- Create a font string for the info text, using the WorldMap font
        self.InfoText = self.Frame:CreateFontString(
            nil,
            "OVERLAY",
            "WorldMapTextFont"
        )

        local font, size = WorldMapTextFont:GetFont()
        self.InfoText:SetFont(font, size, "OUTLINE")

        -- Attach the infotext to the topleft of the frame and scale to 0.5.
        self.InfoText:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 0, 0)
        self.InfoText:SetScale(0.4)
        self.InfoText:SetJustifyH("LEFT")
    else
        self.Frame:SetParent(self:GetMap():GetCanvasContainer())
    end

    -- Put the frame in the topleft of the world map
    self.Frame:SetPoint(
        "BOTTOMLEFT",
        self:GetMap():GetCanvasContainer(),
        10,
        10
    )

    self.Frame:SetFrameStrata("HIGH")
    self.Frame.dataProvider = self

    -- Ensure everything is shown
    self.Frame:Show()
    self.InfoText:Show()
end

function CromulentDataProviderMixin:RefreshAllData(fromOnShow)
    local info = Cromulent:GetZoneInfo()

    if info then
        self.InfoText:SetText(info)
    else
        self.InfoText:SetText("")
    end
end

function CromulentDataProviderMixin:RemoveAllData()
    self.Frame:Hide()
end

function Cromulent:OnEnable()
    WorldMapFrame:AddDataProvider(CromulentDataProviderMixin)
end

function Cromulent:OnDisable()
    WorldMapFrame:RemoveDataProvider(CromulentDataProviderMixin)
end

-- Text to display stored here.
local t = {}

-- Get the fishing info for a given mapId
-- LibTourist is returning no fishing levels for now, so just return nil right
-- away.
local function getFishingInfo(mapId)
    -- Fishing info in LibTourist always returns 0 for now, so disable this
    -- by returning right away.
    -- Hidden behind an if statement because otherwise Lua freaks out.
    if not FISHING_ENABLED then
        return nil
    end

    local fishingSkillText
    local minFish = T:GetFishingLevel(zone)

    if minFish then
        -- Get fishing index
        -- prof1, prof2, archaeology, fishing, cooking, firstaid
        local _, _, _, fishingIdx, _ = GetProfessions()

        -- Find our current fishing rank
        if fishingIdx then
            local skillName, _, skillRank = GetProfessionInfo(fishingIdx)
            local numColour = COLOUR_RED
            if minFish < skillRank then
                numColour = COLOUR_GREEN
            end

            fishingSkillText = FISHING_SKILL_FMT:format(
                COLOUR_YELLOW,
                skillName,
                numColour,
                minFish
            )
        end
    end

    return fishingSkillText
end

function Cromulent:GetZoneInfo()
    local finalText

    -- Set the text to white and hide the zone info if we're on the Azeroth
    -- continent map.
    local mapID = WorldMapFrame:GetMapID()
    local mapInfo = GetMapInfo(mapID)
    local mapName = mapInfo.name
    local zone = mapID

    if mapInfo.mapID == WORLDMAP_AZEROTH_ID then
        if mapInfo.mapType == WORLDMAP_CONTINENT then
            return
        end
    end

    -- Now we can do some real work if the zone is a real zone and/or has
    -- instances
    if zone and (T:IsZoneOrInstance(zone) or T:DoesZoneHaveInstances(zone)) then
        local fishingSkillText = getFishingInfo(zone)

        -- List the instances in the zone if it has any.
        if T:DoesZoneHaveInstances(zone) then
            t[#t + 1] = ("|cffffff00%s:|r"):format(L["Instances"])

            -- Iterate over the instance list and insert them into t[]
            for instance in T:IterateZoneInstances(zone) do
                local complex = T:GetComplex(instance)
                local low, high = T:GetLevel(instance)
                local r1, g1, b1 = T:GetFactionColor(instance)
                local r2, g2, b2 = T:GetLevelColor(instance)
                local groupSize = T:GetInstanceGroupSize(instance)
                local name = instance

                if complex then
                    name = complex .. " - " .. instance
                end

                if low == high then
                    if groupSize > 0 then
                        t[#t + 1] = ("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r " .. L["%d-man"]):format(
                            r1 * 255,
                            g1 * 255,
                            b1 * 255,
                            name,
                            r2 * 255,
                            g2 * 255,
                            b2 * 255,
                            high,
                            groupSize
                        )
                    else
                        t[#t + 1] = ("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d]|r"):format(
                            r1 * 255,
                            g1 * 255,
                            b1 * 255,
                            name,
                            r2 * 255,
                            g2 * 255,
                            b2 * 255,
                            high
                        )
                    end
                else
                    if groupSize > 0 then
                        t[#t + 1] = ("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r " .. L["%d-man"]):format(
                            r1 * 255,
                            g1 * 255,
                            b1 * 255,
                            name,
                            r2 * 255,
                            g2 * 255,
                            b2 * 255,
                            low,
                            high,
                            groupSize
                        )
                    else
                        t[#t + 1] = ("|cff%02x%02x%02x%s|r |cff%02x%02x%02x[%d-%d]|r"):format(
                            r1 * 255,
                            g1 * 255,
                            b1 * 255,
                            name,
                            r2 * 255,
                            g2 * 255,
                            b2 * 255,
                            low,
                            high
                        )
                    end
                end
            end

            -- Add the fishing info to t[] if it exists.
            if fishingSkillText then
                t[#t + 1] = fishingSkillText
            end

            -- OK, add all of the info from t[] into the zone info!
            finalText = table_concat(t, "\n")

            -- Reset t[], ready for the next run.
            table_wipe(t)
        else
            -- If the zone has no instances
            -- Just set the fishing level text and be on our way.
            if fishingSkillText then
                finalText = fishingSkillText
            end
        end
    end

    return finalText
end
