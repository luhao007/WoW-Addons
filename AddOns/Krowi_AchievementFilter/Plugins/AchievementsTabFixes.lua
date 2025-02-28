local _, addon = ...;
local atf = {};
KrowiAF.PluginsApi:RegisterPlugin("AchievementsTabFixes", atf);

local function FindCategory(categories, name)
    for _, category in next, categories do
        if category.Name == name then
            return category;
        end
    end
end

local function RenameExplorationDragonIslesCategory()
    local tabCategories = addon.Tabs["Achievements"].Categories;
    local explorationCategory = FindCategory(tabCategories, addon.GetCategoryInfoTitle(97));
    if not explorationCategory then
        return;
    end

    local dragonIslesCategory = FindCategory(explorationCategory.Children, addon.GetCategoryInfoTitle(15465));
    if not dragonIslesCategory then
        return;
    end

    dragonIslesCategory.Name = addon.GetCategoryInfoTitle(15455);
end

function atf:InjectOptions()
    KrowiAF.UtilApi.InjectOptions:AddDefaults("Plugins", "AchievementsTabFixes", {
        RenameExplorationDragonIslesCategory = true;
    });

    local pluginTable = KrowiAF.UtilApi.InjectOptions:AddPluginTable(
        "AchievementsTabFixes",
        addon.L["AchievementsTabFixes"],
        addon.L["AchievementsTabFixes Desc"],
        function()
            return true;
        end
    );
    KrowiAF.UtilApi.InjectOptions:AddTable(pluginTable, "RenameExplorationDragonIslesCategory", {
        order = KrowiAF.UtilApi.InjectOptions.AutoOrderPlusPlus(), type = "toggle", width = "full",
        name = addon.L["RenameExplorationDragonIslesCategory"],
        desc = addon.L["RenameExplorationDragonIslesCategory Desc"]:KAF_AddDefaultValueText("Plugins.AchievementsTabFixes.RenameExplorationDragonIslesCategory"):K_AddReloadRequired(),
        get = function() return addon.Options.db.profile.Plugins.AchievementsTabFixes.RenameExplorationDragonIslesCategory; end,
        set = function(_, value)
            addon.Options.db.profile.Plugins.AchievementsTabFixes.RenameExplorationDragonIslesCategory = value;
            RenameExplorationDragonIslesCategory();
        end,
        hidden = not addon.Util.IsMainline
    });
end

function atf:Load()
    if not addon.Util.IsMainline then
        return;
    end

    local preHookFunction = addon.Data.LoadBlizzardTabAchievements;
    function addon.Data.LoadBlizzardTabAchievements()
        preHookFunction();
        RenameExplorationDragonIslesCategory();
    end
end