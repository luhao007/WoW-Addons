
------------------------------------------
--  This addon was heavily inspired by  --
--    HandyNotes_Lorewalkers            --
--    HandyNotes_LostAndFound           --
--  by Kemayo                           --
------------------------------------------


-- declaration
local _, AzerothsTopTunes = ...
AzerothsTopTunes.points = {}


-- our db and defaults
local db
local defaults = { profile = { completed = false, icon_scale = 1.4, icon_alpha = 0.8 } }

local continents = {
	[12]   = true, -- Kalimdor
	[13]   = true, -- Eastern Kingdoms
	[101]  = true, -- Outland
	[113]  = true, -- Northrend
	[203]  = true, -- Vashj'ir
	[224]  = true, -- Stranglethorn Vale
	[424]  = true, -- Pandaria
	[572]  = true, -- Draenor
	[619]  = true, -- Broken Isles
	[875]  = true, -- Zandalar
	[876]  = true, -- Kul Tiras
	[947]  = true, -- Azeroth
	[1550] = true, -- The Shadowlands
}


-- upvalues
local GameTooltip = _G.GameTooltip
local IsControlKeyDown = _G.IsControlKeyDown
local gsub = _G.string.gsub
local LibStub = _G.LibStub
local next = _G.next
local UIParent = _G.UIParent

local HandyNotes = _G.HandyNotes
local TomTom = _G.TomTom

local completedQuests = {}
local points = AzerothsTopTunes.points


-- plugin handler for HandyNotes
local function infoFromCoord(mapFile, coord)
	local point = points[mapFile] and points[mapFile][coord]
	return point[2], point[3]
end

function AzerothsTopTunes:OnEnter(mapFile, coord)
	if self:GetCenter() > UIParent:GetCenter() then -- compare X coordinate
		GameTooltip:SetOwner(self, "ANCHOR_LEFT")
	else
		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	end

	local name, note = infoFromCoord(mapFile, coord)

	GameTooltip:SetText(name)

	if note then
		GameTooltip:AddLine(note)
		GameTooltip:AddLine(" ")
	end

	if TomTom then
		GameTooltip:AddLine("Right-click to set a waypoint.", 1, 1, 1)
		GameTooltip:AddLine("Control-Right-click to set waypoints to every music roll.", 1, 1, 1)
	end

	GameTooltip:Show()
end

function AzerothsTopTunes:OnLeave()
		GameTooltip:Hide()
end


local function createWaypoint(mapID, coord)
	local x, y = HandyNotes:getXY(coord)
	TomTom:AddWaypoint(mapID, x, y, { title = "Candy Bucket", persistent = nil, minimap = true, world = true })
end

local function createAllWaypoints()
	for mapFile, coords in next, points do
		if not continents[mapFile] then
		for coord, questID in next, coords do
			if coord and (db.completed or not completedQuests[questID]) then
				createWaypoint(mapFile, coord)
			end
		end
		end
	end
	TomTom:SetClosestWaypoint()
end

function AzerothsTopTunes:OnClick(button, down, mapFile, coord)
	if TomTom and button == "RightButton" and not down then
		if IsControlKeyDown() then
			createAllWaypoints()
		else
			createWaypoint(mapFile, coord)
		end
	end
end


do
	-- custom iterator we use to iterate over every node in a given zone
	local function iterator(t, prev)
		if not completedQuests[38356] or not completedQuests[37961] then return end
		if not t then return end

		local coord, v = next(t, prev)
		while coord do
			if v and (db.completed or not completedQuests[v[1]]) then
				return coord, nil, "interface\\icons\\inv_misc_punchcards_yellow", db.icon_scale, db.icon_alpha
			end

			coord, v = next(t, coord)
		end
	end

	function AzerothsTopTunes:GetNodes2(mapID)
		return iterator, points[mapID]
	end
end


-- config
local options = {
	type = "group",
	name = "Azeroth's Top Tunes",
	desc = "Music Scrolls for your Garrison Jukebox.",
	get = function(info) return db[info[#info]] end,
	set = function(info, v)
		db[info[#info]] = v
		AzerothsTopTunes:Refresh()
	end,
	args = {
		desc = {
			name = "These settings control the look and feel of the icon.",
			type = "description",
			order = 1,
		},
		completed = {
			name = "Show completed",
			desc = "Show icons for music scrolls you have already collected.",
			type = "toggle",
			width = "full",
			arg = "completed",
			order = 2,
		},
		icon_scale = {
			type = "range",
			name = "Icon Scale",
			desc = "Change the size of the icons.",
			min = 0.25, max = 2, step = 0.01,
			arg = "icon_scale",
			order = 3,
		},
		icon_alpha = {
			type = "range",
			name = "Icon Alpha",
			desc = "Change the transparency of the icons.",
			min = 0, max = 1, step = 0.01,
			arg = "icon_alpha",
			order = 4,
		},
	},
}


-- initialise
function AzerothsTopTunes:OnEnable()
	local HereBeDragons = LibStub("HereBeDragons-2.0", true)
	if not HereBeDragons then
		HandyNotes:Print("Your installed copy of HandyNotes is out of date and the Azeroth's Top Tunes plug-in will not work correctly.  Please update HandyNotes to version 1.5.0 or newer.")
		return
	end

	for continentMapID in next, continents do
		local children = C_Map.GetMapChildrenInfo(continentMapID, nil, true)
		for _, map in next, children do
			local coords = points[map.mapID]
			if coords then
				for coord, criteria in next, coords do
					local mx, my = HandyNotes:getXY(coord)
					local cx, cy = HereBeDragons:TranslateZoneCoordinates(mx, my, map.mapID, continentMapID)
					if cx and cy then
						points[continentMapID] = points[continentMapID] or {}
						points[continentMapID][HandyNotes:getCoord(cx, cy)] = criteria
					end
				end
			end
		end
	end

	HandyNotes:RegisterPluginDB("AzerothsTopTunes", self, options)

	local tmpPairs = C_QuestLog.GetAllCompletedQuestIDs()
	for _, id in ipairs(tmpPairs) do 
		completedQuests[id] = true
	end

	db = LibStub("AceDB-3.0"):New("HandyNotes_AzerothsTopTunesDB", defaults, "Default").profile

	AzerothsTopTunes:Refresh()
	AzerothsTopTunes:RegisterEvent("CRITERIA_UPDATE", "Refresh")
end

function AzerothsTopTunes:Refresh(_, questID)
	if questID then completedQuests[questID] = true end
	self:SendMessage("HandyNotes_NotifyUpdate", "AzerothsTopTunes")
end


-- activate
LibStub("AceAddon-3.0"):NewAddon(AzerothsTopTunes, "HandyNotes_AzerothsTopTunes", "AceEvent-3.0")
