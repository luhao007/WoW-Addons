-- $Id: Core.lua 8 2022-11-20 08:02:32Z arithmandar $
-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)
-- WoW

-- ----------------------------------------------------------------------------
-- AddOn namespace.
-- ----------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local addonname = FOLDER_NAME
local AtlasLoot = _G.AtlasLoot

local moduleMeta = {
		addonName = addonname,
		icon = "Interface\\ICONS\\ability_dragonriding_athomealoft01",
		name = EXPANSION_NAME10,
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
}

AtlasLoot:RegisterModules(addonname, moduleMeta)

local data = AtlasLoot.ItemDB:Add(addonname, 10)
private.data = data
