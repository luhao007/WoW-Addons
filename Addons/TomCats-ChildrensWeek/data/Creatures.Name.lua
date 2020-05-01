local addon = select(2, ...)
local D = addon.TomCatsLibs.Data

local dataMineTooltipName = ("%sDatamineTooltip"):format(addon.name)
local dataMineTooltip = _G.CreateFrame("GameTooltip", dataMineTooltipName, UIParent, "GameTooltipTemplate")
local dataMineTitleText = _G[("%sDatamineTooltipTextLeft1"):format(addon.name)]

function addon.getCreatureNameByCreatureID(creatureID)
    local creature = D["Quest Givers"][creatureID] or D["Orphans"][creatureID]
    if (not creature) then return end
    if (not creature["Name"]) then
        dataMineTooltip:SetOwner(UIParent, "ANCHOR_NONE")
        dataMineTooltip:SetHyperlink(("unit:Creature-0-0-0-0-%d"):format(creatureID))
        local name = dataMineTitleText:GetText()
        if (name) then
            creature["Name"] = name
            return name
        end
        return
    end
    return creature["Name"]
end

function addon.isCreatureNamesLoaded()
    if(addon.creatureNamesLoaded) then return true end
    for _, creature in pairs(D["Quest Givers"].records) do
        if (not creature["Name"]) then
            return false
        end
    end
    for _, creature in pairs(D["Orphans"].records) do
        if (not creature["Name"]) then
            return false
        end
    end
    addon.creatureNamesLoaded = true
    return true
end

function addon.loadCreatureNames()
    for k in pairs(D["Quest Givers"].records) do
        addon.getCreatureNameByCreatureID(k)
    end
    for k in pairs(D["Orphans"].records) do
        addon.getCreatureNameByCreatureID(k)
    end
    return addon.isCreatureNamesLoaded()
end

addon.loadCreatureNames()

-- TODO: Handle condition where names are unavailable due to recently cleared WoW cache

--local function CreaturesName_AfterUpdate(record)
--    if (record["Vignette Info"]) then
--        record["Vignette Info"].name = record["Name"]
--        for mapcanvas in pairs(D["Map Canvases"]) do
--            if (mapcanvas:GetMapID() == P["Vignette MapID"]) then
--                mapcanvas:OnEvent("VIGNETTES_UPDATED")
--            end
--        end
--    end
--end
--
--D["Creatures"]:SetAfterUpdate("Name", CreaturesName_AfterUpdate)
