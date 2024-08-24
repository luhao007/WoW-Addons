-- $Id: Core.lua 8 2022-11-20 07:29:37Z arithmandar $
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
		icon = "Interface\\ICONS\\achievement_mythicdungeons_shadowlands",
		name = EXPANSION_NAME8,
		tt_title = nil,		-- ToolTip title
		tt_text = nil,		-- ToolTip text
}

AtlasLoot:RegisterModules(addonname, moduleMeta)

local data = AtlasLoot.ItemDB:Add(addonname, 9)
private.data = data
