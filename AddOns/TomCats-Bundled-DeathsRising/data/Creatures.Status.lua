local addon = select(2, ...)
local D = addon.getLocalVars()

local STATUS = {
    COMPLETE = 0,
    HIDDEN = 1,
    UNAVAILABLE = 2,
    LOOT_ELIGIBLE = 3,
    BONUS_ROLL_ELIGIBLE = 4,
    WORLD_QUEST_AVAILABLE = 5
}

addon.STATUS = STATUS

local function refreshStatusForCreature(creature)
    if (not IsQuestFlaggedCompleted(creature["Tracking ID"])) then
        creature["Status"] = STATUS.LOOT_ELIGIBLE
    else
        creature["Status"] = STATUS.COMPLETE
    end
end

function addon.refreshStatusForAllCreatures()
    for _, creature in pairs(D.Creatures.records) do
        refreshStatusForCreature(creature)
    end
end

addon.refreshStatusForAllCreatures()

function addon.CreaturesStatus_AfterUpdate(record)
    addon.addOrUpdateVignetteInfo(record)
    if addon.raresLog then
        addon.raresLog.updated = true
    end
end

D["Creatures"]:SetAfterUpdate("Status", addon.CreaturesStatus_AfterUpdate)
