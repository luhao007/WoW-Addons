
-- App locals
local _, app = ...;

if app.GameBuildVersion < 100000 then
	app.CreateMountMod = app.CreateUnimplementedClass("MountMod", "mountmodID");
	app.CreateFirstCraft = app.CreateUnimplementedClass("FirstCraft", "firstcraftID");
	return
end

local pairs
	= pairs

-- Mount Mod Lib
do
	local CACHE = "MountMods"
	local CLASSNAME = "MountMod"
	app.CreateMountMod = app.ExtendClass("Item", CLASSNAME, "mountmodID", {
		RefreshCollectionOnly = true,
		collectible = function(t) return app.Settings.Collectibles[CACHE]; end,
		collected = function(t) return app.IsAccountCached("Quests", t.questID) and 1 end,
		itemID = function(t) return t.mountmodID; end,
	});
	app.AddSimpleCollectibleSwap(CLASSNAME, CACHE)

	app.AddEventHandler("OnLoad", function()
		app.AddDynamicCategoryHeader({ id = "mountmodID", name = "Mount Mods", icon = 975744 });
	end);
end

-- First Craft Lib
do
	local C_TradeSkillUI_IsRecipeFirstCraft, C_TradeSkillUI_GetRecipeInfo
		= C_TradeSkillUI.IsRecipeFirstCraft, C_TradeSkillUI.GetRecipeInfo

	local CACHE = "FirstCrafts"
	local CLASSNAME = "FirstCraft"
	local KEY = "firstcraftID"
	local FirstCraftInfoMeta = setmetatable({}, {
		__index = function(t, id)
			if not id then return app.EmptyTable end

			local info = C_TradeSkillUI_GetRecipeInfo(id) or app.EmptyTable
			t[id] = info
			return info
		end
	})
	app.CreateFirstCraft = app.CreateClassWithInfo(CLASSNAME, KEY, FirstCraftInfoMeta, {
		CACHE = function() return CACHE end,
		icon = function(t)
			return app.asset("Category_Professions")
		end,
		collectible = function(t)
			return app.Settings.Collectibles[CACHE]
		end,
		collected = function(t)
			local id = t[KEY];
			-- character collected
			if app.IsCached(CACHE, id) then return 1; end
			-- account-wide collected
			if app.IsAccountTracked(CACHE, id) then return 2; end
		end,
	})
	app.AddSimpleCollectibleSwap(CLASSNAME, CACHE)
	app.AddEventHandler("OnSavedVariablesAvailable", function(currentCharacter, accountWideData)
		if not currentCharacter[CACHE] then currentCharacter[CACHE] = {} end
		if not accountWideData[CACHE] then accountWideData[CACHE] = {} end
	end)
	app.AddGenericFieldConverter(KEY);
	app.AddEventHandler("OnRefreshCollections", function()
		local saved, none = {}, {}
		for id,_ in pairs(app.GetRawFieldContainer(KEY)) do
			-- If NOT first craft anymore, then it's been completed
			if not C_TradeSkillUI_IsRecipeFirstCraft(id) then
				saved[id] = true
			else
				none[id] = true
			end
		end

		-- Character Cache
		app.SetBatchCached(CACHE, saved, 1)
		app.SetBatchCached(CACHE, none)

		-- Account Cache (removals handled by Sync)
		app.SetBatchAccountCached(CACHE, saved, 1)
	end)
end
