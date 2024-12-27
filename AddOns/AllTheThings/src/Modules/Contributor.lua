-- Contributor Module
-- Provides additional functionality which may be opted-into by the end user to help in crowd-sourcing
-- or further improvement to ATT data or logic
local _, app = ...;

-- Globals
local ipairs,pairs,tostring,setmetatable
	= ipairs,pairs,tostring,setmetatable
local GetQuestID,C_QuestLog_IsOnQuest
	= GetQuestID,C_QuestLog.IsOnQuest

-- Modules
local DelayedCallback = app.CallbackHandlers.DelayedCallback
local round = app.round

local api = {};
app.Modules.Contributor = api;
-- Events - a collection of Game Events which should trigger additional logic
api.Events = {}
local Reports = setmetatable({}, { __index = function(t,key)
	local reportType = setmetatable({}, { __index = function(t,key)
		local typeIDReport = {}
		t[key] = typeIDReport
		return typeIDReport
	end})
	reportType.__type = key
	t[key] = reportType
	return reportType
end})
app.AddEventHandler("OnReportReset", function() wipe(Reports) end)

-- Allows adding an Event handler function for in-game events when Contributor is enabled
local function AddEventFunc(event, func)
	api.Events[event] = func
end

local function GetReportPlayerLocation()
	local mapID, px, py, fake = app.GetPlayerPosition()
	if fake then
		return UNKNOWN..", "..UNKNOWN..", "..tostring(mapID or UNKNOWN).." ("..(app.GetMapName(mapID) or "??")..")"
	end
	-- floor coords to nearest tenth
	if px then px = round(px, 1) end
	if py then py = round(py, 1) end
	return tostring(px or UNKNOWN)..", "..tostring(py or UNKNOWN)..", "..tostring(mapID or UNKNOWN).." ("..(app.GetMapName(mapID) or "??")..")"
end

local function DoReport(reporttype, id)
	local dialogID = reporttype.."_"..id
	-- app.PrintDebug("Contributor.DoReport",reporttype,id)

	local reportData = Reports[reporttype][id]
	-- keyed report data
	local keyedData = {}
	for k,v in pairs(reportData) do
		keyedData[#keyedData + 1] = tostring(k)..": \""..tostring(v).."\""
	end
	-- common report data
	reportData[#reportData + 1] = "### "..reporttype..":"..id
	reportData[#reportData + 1] = "```elixir"	-- discord fancy box start
	for _,text in pairs(keyedData) do
		reportData[#reportData + 1] = text
	end
	-- common report data
	reportData[#reportData + 1] = "---- User Info ----"
	reportData[#reportData + 1] = "PlayerLocation: "..GetReportPlayerLocation()
	reportData[#reportData + 1] = "L:"..app.Level.." R:"..app.RaceID.." ("..app.Race..") C:"..app.ClassIndex.." ("..app.Class..")"
	reportData[#reportData + 1] = "ver: "..app.Version
	reportData[#reportData + 1] = "build: "..app.GameBuildVersion
	reportData[#reportData + 1] = "```";	-- discord fancy box end

	if app:SetupReportDialog(dialogID, "Contributor Report: " .. dialogID, reportData) then
		app.print(app:Linkify("Contributor Report: "..dialogID, app.Colors.ChatLinkError, "dialog:" .. dialogID));
		app.Audio:PlayReportSound();
	end
end

local function AddReportData(reporttype, id, data)
	-- app.PrintDebug("Contributor.AddReportData",reporttype,id)
	-- app.PrintTable(data)
	local reportData = Reports[reporttype][id]
	if type(data) == "table" then
		for k,v in pairs(data) do
			reportData[k] = v
		end
	else
		reportData[#reportData + 1] = tostring(data)
	end
	-- after adding data for a report, we will trigger that report shortly afterwards in case more data is added elsewhere within
	-- that timeframe
	DelayedCallback(DoReport, 0.25, reporttype, id)
end

api.DoReport = function(id, text)
	AddReportData("test", id, text)
end

-- Used to override the precision of coord accuracy based on irregularly sized maps
-- typically we don't want the report to trigger even when interacting from max range
-- so can adjust here
local MapPrecisionOverrides = {
	[1700] = 3,	-- Sinfall (not tested)
}

local function Check_coords(objRef, id, maxCoordDistance)
	-- check coord distance
	local mapID, px, py, fake = app.GetPlayerPosition()
	-- fake player coords (instances, etc.) cannot be checked
	if fake then return true end

	if not objRef or not objRef.coords then return end

	local dist, sameMap, check
	local closest = 9999
	maxCoordDistance = MapPrecisionOverrides[mapID] or maxCoordDistance or 1
	for _, coord in ipairs(objRef.coords) do
		if mapID == coord[3] then
			sameMap = mapID
			dist = app.distance(px, py, coord[1], coord[2])
			-- app.PrintDebug("coords @",dist)
			if dist < closest then closest = dist end
		end
	end
	if sameMap then
		-- quest has an accurate coord on accurate map
		if closest > maxCoordDistance then
			-- round to the tenth
			closest = round(closest, 1)
			AddReportData(objRef.__type,id,{
				[objRef.key or "ID"] = id,
				WrongCoords = "Closest Coordinates are off by: "..tostring(closest).." on mapID: "..mapID,
			})
			check = 1
		end
	else
		AddReportData(objRef.__type,id,{
			[objRef.key or "ID"] = id,
			MissingMap = "No Coordinates on current Map!",
		})
		check = 1
	end
	return check or true
end

-- Temporary implementation until better, global DB(s) provides similar data references
-- These should be NPCs which are mobile in that they can have completely variable coordinates in game
-- either by following the player or having player-based decisions that cause them to have any coordinates
local MobileDB = {}
MobileDB.Creature = {
	   [951] = true,	-- Brother Paxton
	 [19644] = true,	-- Image of Archmage Vargoth
	 [19935] = true,	-- Soridormi
	 [23870] = true,	-- Ember Clutch Ancient
	 [26206] = true,	-- Keristrasza
	 [29795] = true,	-- Kolitra Deathweaver (Orgrim's Hammer)
	 [30216] = true,	-- Vile
	 [34653] = true,	-- Bountiful Table Hostess
	 [43300] = true,	-- Messner
	 [43302] = true,	-- Danforth
	 [43303] = true,	-- Krakauer
	 [43305] = true,	-- Jorgensen
	 [43929] = true,	-- Blingtron 4000
	 [52234] = true,	-- Bwemba
	 [55497] = true,	-- Zin'Jun
	 [64337] = true,	-- Nomi
	 [67153] = true,	-- Zin'Jun
	 [77789] = true,	-- Blingtron 5000
	 [79815] = true,	-- Grun'lek
	 [83858] = true,	-- Khadgar's Servant
	 [87991] = true,	-- Cro Threadstrong
	 [87992] = true,	-- Olaf
	 [87994] = true,	-- Moroes <Tower Steward>
	 [87995] = true,	-- Fleet Master Seahorn
	 [87996] = true,	-- Lillian Voss
	 [87997] = true,	-- Leonid Barthalomew the Revered
	 [87998] = true,	-- Sunwalker Dezco
	 [87999] = true,	-- Skylord Omnuron
	 [88000] = true,	-- Pip Quickwit
	 [88001] = true,	-- Maximillian of Northshire
	 [88002] = true,	-- Highlord Darion Mograine
	 [88003] = true,	-- Cowled Ranger
	 [88004] = true,	-- Zen'kiki
	 [88005] = true,	-- Lorewalker Cho
	 [88006] = true,	-- Lonika Stillblade
	 [88007] = true,	-- Gamon
	 [88009] = true,	-- Millhouse Manastorm
	 [88013] = true,	-- Lunk
	 [88017] = true,	-- Budd
	 [88022] = true,	-- Johnny Awesome
	 [88023] = true,	-- Taoshi
	 [88024] = true,	-- Oralius
	 [88025] = true,	-- Mylune
	 [88026] = true,	-- John J. Keeshan
	 [88027] = true,	-- Impsy
	[101527] = true,	-- Blingtron 6000
	[105637] = true,	-- Scowling Rosa <Texts and Specialty Goods>
	[115785] = true,	-- Direbeak Hatchling
	[117475] = true,	-- Lord Darius Crowley
	[145005] = true,	-- Lor'themar Theron
	[145707] = true,	-- Advisor Belgrum
	[153897] = true,	-- Blingtron 7000
	[158544] = true,	-- Lord Herne
	[158635] = true,	-- Xolartios <Eternal Traveler>
	[172854] = true,	-- Dredger Butler
	[185749] = true,	-- Gnoll Mon-Ark
	[191494] = true,	-- Khanam Matra Sarest
	[193985] = true,	-- Initiate Zorig
	[209681] = true,	-- Squally
	[214890] = true,	-- Magni Bronzebeard
	[214892] = true,	-- Dagran Thaurissan II
	[220307] = true,	-- Holiday Enthusiast
	[220859] = true,	-- Amy Lychenstone
	[221492] = true,	-- Baron Sybaestan Braunpyke
	[221867] = true,	-- Mereldar Child
	[221980] = true,	-- Faerin Lothar
	[222239] = true,	-- Scrit
	[224618] = true,	-- Danagh's Cogwalker
	[211444] = true,	-- Flynn Fairwind
}
-- These should be GameObjects which are mobile in that they can have completely variable coordinates in game
-- either by following the player or having player-based decisions that cause them to have any coordinates
-- but also quests objects that are not sourced elsewhere..
MobileDB.GameObject = {
	[201615] = true,	-- Valve in ICC
	[209287] = true,	-- Bit of Glass, quest:29516
	[281326] = true,	-- Falcon Cage (Quest Object in Drustvar)
	[293351] = true,	-- Truffle
	[293445] = true,	-- Truffle
	[293446] = true,	-- Truffle
	[293449] = true,	-- Truffle
	[296855] = true,	-- Truffle
	[327230] = true,	-- Jelly Deposit
	[350978] = true,	-- Queen's Conservatory Cache
	[411930] = true,	-- Blackpowder Barrel
	[413246] = true,	-- Elemental Silt Mound
	[415296] = true,	-- Repair Kit
	[419696] = true,	-- Waxy Lump
	[421070] = true,	-- Remnent Satchel
	[433370] = true,	-- War Supply Chest
	[444798] = true,	-- Arathi Treasure Hoard
	[444799] = true,	-- Potent Concentrated Shadow
	[444800] = true,	-- Sureki Strongbox
	[444804] = true,	-- Concentrated Shadow
	[452696] = true,	-- Machine Speaker's Reliquary
	[452706] = true,	-- Deep-Lost Satchel
	[451579] = true,	-- Used Fuel Drum (Ringing Deeps)
	[478443] = true,	-- Mislaid Curiosity (delve object)
}

local ReturnEmptyFunctionMeta = { __index = function() return app.ReturnFalse end}
local EmptyFunctionTable = setmetatable({}, ReturnEmptyFunctionMeta)
local ReturnEmptyTableMeta = { __index = function() return EmptyFunctionTable end}
local IgnoredChecksByType = setmetatable({
	Item = setmetatable({
		coord = app.ReturnTrue,
		provider = app.ReturnTrue,
	}, ReturnEmptyFunctionMeta),
	Player = setmetatable({
		coord = app.ReturnTrue,
		provider = app.ReturnTrue
	}, ReturnEmptyFunctionMeta),
	Creature = setmetatable({
		coord = function(id) return MobileDB.Creature[id] end,
	}, ReturnEmptyFunctionMeta),
	GameObject = setmetatable({
		coord = function(id) return MobileDB.GameObject[id] end,
	}, ReturnEmptyFunctionMeta),
	Vehicle = setmetatable({
		coord = app.ReturnTrue,
	}, ReturnEmptyFunctionMeta),
}, ReturnEmptyTableMeta)

local GuidTypeProviders = {
	Item = "i",
	GameObject = "o",
	Creature = "n",
}

local ProviderTypeChecks = {
	n = function(objID, objRef, providers, providerID)
		-- app.PrintDebug("Check.n",objID,providerID,app:SearchLink(objRef))
		-- app.PrintTable(providers)
		-- app.PrintTable(objRef.qgs)
		local found
		-- n providers are turned into qgs on quest objects
		local qgs = objRef.qgs
		if qgs then
			for _,qg in ipairs(qgs) do
				if qg == providerID then found = 1 break end
			end
		end
		if not found and providers then
			for _,provider in ipairs(providers) do
				if provider[1] == "n" and provider[2] == providerID then found = 1 break end
			end
		end
		if not found then
			local questParent = objRef.parent
			-- this quest is listed directly under an NPC then compare that NPCID
			-- e.g. Garrison NPCs Bronzebeard/Saurfang
			if questParent and questParent.__type == "NPC" and questParent.npcID == providerID then
				found = 1
			end
		end
		if not found then
			AddReportData(objRef.__type,objID, {
				[objRef.key or "ID"] = objID,
				QuestGiver = "Missing Quest Giver: "..providerID..", -- "..(app.NPCNameFromID[providerID] or UNKNOWN),
			})
		end
	end,
	o = function(objID, objRef, providers, providerID)
		if not providers then
			AddReportData(objRef.__type,objID, {
				[objRef.key or "ID"] = objID,
				QuestGiver = "Missing Object Provider: "..providerID..", -- "..(app.ObjectNames[providerID] or UNKNOWN),
			})
			return
		end
		local found
		for _,provider in ipairs(providers) do
			if provider[1] == "o" and provider[2] == providerID then found = 1 break end
		end
		if not found then
			AddReportData(objRef.__type,objID, {
				[objRef.key or "ID"] = objID,
				QuestGiver = "Missing Object Provider: "..providerID..", -- "..(app.ObjectNames[providerID] or UNKNOWN),
			})
		end
	end,
	-- TODO: Items are weird, maybe handle eventually
	-- i = function(objID, objRef, providers, providerID)
	-- end,
}

local function Check_providers(objID, objRef, providerType, id)
	local providerTypeCheck = ProviderTypeChecks[providerType]
	if providerTypeCheck then
		providerTypeCheck(objID, objRef, objRef.providers, id)
	end
end

-- Add a check when interacting with a Quest Giver NPC to verify coordinates of the related Quest
local function OnQUEST_DETAIL(...)
	-- local questStartItemID = ...;
	local questID = GetQuestID();
	-- app.PrintDebug("Contributor.OnQUEST_DETAIL",questID,...)
	if questID == 0 then return end
	-- only check logic when the player is not actually on this quest
	if C_QuestLog_IsOnQuest(questID) then return end
	local objRef = app.SearchForObject("questID", questID, "field")
	-- app.PrintDebug("Contributor.OnQUEST_DETAIL.ref",objRef and objRef.hash)
	if not objRef then
		-- this is reported from Quest class
		return
	end

	local guid = UnitGUID("questnpc") or UnitGUID("npc")
	local providerid, guidtype, _
	if not guid then
		app.print("No Quest check performed for Quest #", questID,"[GUID]")
		return
	end
	-- TODO: would need to be fixed for Item type
	guidtype, _, _, _, _, providerid = ("-"):split(guid)
	providerid = tonumber(providerid)
	if not providerid or not guidtype then
		-- app.print("Unknown Quest Provider",guidtype,providerid,"during Contribute check!")
		if not IgnoredChecksByType[guidtype].provider() then
			app.print("No Quest check performed for Quest #", questID,"[ProviderID]")
		end
		return
	end
	app.PrintDebug(guidtype,providerid,app.NPCNameFromID[providerid] or app.ObjectNames[providerid]," => Quest #", questID)

	-- check coords
	if not IgnoredChecksByType[guidtype].coord(providerid) then
		if not Check_coords(objRef, objRef[objRef.key]) then
			-- is this quest listed directly under an NPC which has coords instead? check that NPC for coords
			-- e.g. Garrison NPCs Bronzebeard/Saurfang
			local questParent = objRef.parent
			if questParent and questParent.__type == "NPC" then
				if not Check_coords(questParent, questParent[questParent.key]) then
					AddReportData(objRef.__type,questID,{
						[objRef.key or "ID"] = questID,
						MissingCoords = "No Coordinates for this quest under NPC!",
					})
				end
			else
				AddReportData(objRef.__type,questID,{
					[objRef.key or "ID"] = questID,
					MissingCoords = "No Coordinates for this quest!",
				})
			end
		end
	end

	-- check provider
	if not IgnoredChecksByType[guidtype].provider(providerid) then
		Check_providers(questID, objRef, GuidTypeProviders[guidtype], providerid)
	end
	-- app.PrintDebug("Contributor.OnQUEST_DETAIL.Done")
end
AddEventFunc("QUEST_DETAIL", OnQUEST_DETAIL)
AddEventFunc("QUEST_PROGRESS", OnQUEST_DETAIL)
AddEventFunc("QUEST_COMPLETE", OnQUEST_DETAIL)

-- PLAYER_SOFT_INTERACT_CHANGED
local LastSoftInteract = {}
-- Allows automatically tracking nearby ObjectID's and running check functions on them for data verification
local function OnPLAYER_SOFT_INTERACT_CHANGED(previousGuid, newGuid)
	-- app.PrintDebug("PLAYER_SOFT_INTERACT_CHANGED",previousGuid,newGuid)

	-- previousGuid == newGuid when the player distance becomes close enough or far enough to change interaction cursor
	if not newGuid or previousGuid ~= newGuid then
		LastSoftInteract.GuidType = nil
		LastSoftInteract.ID = nil
		return
	end

	local id, guidtype, _
	guidtype, _, _, _, _, id = ("-"):split(newGuid)
	id = tonumber(id)
	LastSoftInteract.GuidType = guidtype
	LastSoftInteract.ID = id
	-- app.PrintDebug(guidtype,id)

	-- only check object soft-interact (for now)
	if guidtype ~= "GameObject" then return end

	local objRef = app.SearchForObject("objectID", id, "field")
	-- only check sourced objects
	if not objRef then return end
	-- app.PrintDebug("GameObject",app:SearchLink(objRef))

	-- check sourced object coords
	if not IgnoredChecksByType[guidtype].coord(id) then
		-- object auto-detect can happen from rather far, so using 2 distance
		if not Check_coords(objRef, objRef[objRef.key], 2) then
			AddReportData(objRef.__type,id,{
				[objRef.key or "ID"] = id,
				MissingCoords = ("No Coordinates for this %s!"):format(objRef.__type),
			})
		end
	end
end
AddEventFunc("PLAYER_SOFT_INTERACT_CHANGED", OnPLAYER_SOFT_INTERACT_CHANGED)

-- UNIT_SPELLCAST_START
-- Allows handling some special logic in special cases for special spell casts
local SpellIDHandlers = {
	-- Opening (on Objects)
	[6478] = function(source)
		if source ~= "player" then return end

		-- Verify 'Opening' cast, report ObjectID if not Sourced
		local id = LastSoftInteract.ID
		-- likely not possible
		if not id then return end

		local objRef = app.SearchForObject("objectID", id, "field")
		-- if it's Sourced, we've already checked it via PLAYER_SOFT_INTERACT_CHANGED
		if objRef then return end

		objRef = app.CreateObject(id)
		AddReportData(objRef.__type,id,{
			[objRef.key or "ID"] = id,
			NotSourced = "Openable Object not Sourced!",
		})
	end
}
-- Other 'Opening' spells
SpellIDHandlers[3365] = SpellIDHandlers[6478]

local RegisteredUNIT_SPELLCAST_START
local function OnUNIT_SPELLCAST_START(...)
	-- app.PrintDebug("UNIT_SPELLCAST_START",...)
	local source, _, id = ...
	local spellHandler = SpellIDHandlers[id]
	if not spellHandler then return end

	spellHandler(source)
end
local function UnregisterUNIT_SPELLCAST_START()
	-- app.PrintDebug("Unregister.UNIT_SPELLCAST_START")
	app:UnregisterEvent("UNIT_SPELLCAST_START")
	RegisteredUNIT_SPELLCAST_START = nil
end
local function RegisterUNIT_SPELLCAST_START()
	if RegisteredUNIT_SPELLCAST_START then return end
	RegisteredUNIT_SPELLCAST_START = true
	-- app.PrintDebug("Register.UNIT_SPELLCAST_START")
	app:RegisterFuncEvent("UNIT_SPELLCAST_START",OnUNIT_SPELLCAST_START)
	app.CallbackHandlers.DelayedCallback(UnregisterUNIT_SPELLCAST_START, 0.5)
end

-- PLAYER_SOFT_TARGET_INTERACTION
-- Allows handling when the player succeeds in interacting with a soft-interact
-- This happens when the player presses the keybind while a soft-interact is active, but not necessarily when it's within range
local function OnPLAYER_SOFT_TARGET_INTERACTION()
	-- app.PrintDebug("PLAYER_SOFT_TARGET_INTERACTION",LastSoftInteract.GuidType,LastSoftInteract.ID)

	-- currently only track interacts on objects
	if LastSoftInteract.GuidType ~= "GameObject" then return end
	-- if ignore check on coords, then also ignore for unsourced
	if IgnoredChecksByType.GameObject.coord(LastSoftInteract.ID) then return end

	-- If the player attempts to interact, hook for spell cast start event
	RegisterUNIT_SPELLCAST_START()
end
AddEventFunc("PLAYER_SOFT_TARGET_INTERACTION", OnPLAYER_SOFT_TARGET_INTERACTION)

-- Contribution setup
local function Contribute(contrib)
	app.Contributor = contrib == 1 and true or nil
	AllTheThingsSavedVariables.Contributor = app.Contributor and 1 or 0
	local contribModule = app.Modules.Contributor or app.EmptyTable
	if app.Contributor then
		app.print("Thanks for helping to contribute to ATT! There may be additional chat and report sounds to help with finding additional discrepancies in ATT data.")
		if contribModule.Events then
			for event,func in pairs(contribModule.Events) do
				-- app.PrintDebug("Contribute.RegisterFuncEvent",event)
				app:RegisterFuncEvent(event,func)
			end
		end
	elseif app.IsReady then
		app.print("Not showing ATT contribution information.")
		if contribModule.Events then
			for event,func in pairs(contribModule.Events) do
				-- app.PrintDebug("Contribute.UnregisterEventClean",event)
				app:UnregisterEventClean(event)
			end
		end
	end
end
-- Allows a user to use /att contribute
-- to opt-in/out of seeing additional reporting/chat/sound functionality to help with refining ATT data
app.ChatCommands.Add("contribute", function(args)
	Contribute(not app.Contributor and 1)
	return true
end, {
	"Usage : /att contribute"
})
app.AddEventHandler("OnReady", function()
	Contribute(AllTheThingsSavedVariables.Contributor)
end)
