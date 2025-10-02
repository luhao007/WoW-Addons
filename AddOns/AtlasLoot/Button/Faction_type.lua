local _G = getfenv(0)

-- lua
local str_match, str_format = string.match, string.format

local AtlasLoot = _G.AtlasLoot
local Faction = AtlasLoot.Button:AddType("Faction", "f")
local BF = AtlasLoot.LibBabble:Get("LibBabble-Faction-3.0")
local ClickHandler = AtlasLoot.ClickHandler

--[[
	-- /script for i = 1, MAX_REPUTATION_REACTION do print(i, _G["FACTION_STANDING_LABEL"..i]) end
	-- rep info ("f1435rep3" = Unfriendly rep @ Shado-Pan Assault)
	1. Hated
	2. Hostile
	3. Unfriendly
	4. Neutral
	5. Friendly
	6. Honored
	7. Revered
	8. Exalted
]]

local FactionClickHandler
local PlayerSex

local FACTION_IMAGES = {
	[0] = "Interface\\Icons\\Achievement_Reputation_08", -- dummy

	-- Classic
	[47] = "Interface\\Icons\\inv_misc_tournaments_symbol_dwarf", --Ironforge
	[54] = "Interface\\Icons\\inv_misc_tournaments_symbol_gnome", --Gnomeregan
	[59] = "Interface\\Icons\\INV_Ingot_Mithril",                 --Thorium Brotherhood
	[68] = "Interface\\Icons\\inv_misc_tournaments_symbol_scourge", --Undercity
	[69] = "Interface\\Icons\\inv_misc_tournaments_banner_nightelf", --Darnassus
	[72] = "Interface\\Icons\\inv_misc_tournaments_symbol_human", --Stormwind
	[76] = "Interface\\Icons\\inv_misc_tournaments_symbol_orc",   --Orgrimmar
	[81] = "Interface\\Icons\\inv_misc_tournaments_symbol_tauren", --Thunder Bluff
	[87] = "Interface\\Icons\\INV_Helmet_66",                     --Bloodsail Buccaneers
	[529] = "Interface\\Icons\\inv_jewelry_talisman_07",          --Argent Dawn
	[530] = "Interface\\Icons\\inv_misc_tournaments_symbol_troll", --Darkspear Trolls
	[576] = "Interface\\Icons\\achievement_reputation_timbermaw", --Timbermaw Hold
	[589] = "Interface\\Icons\\Achievement_Zone_Winterspring",    --Wintersaber Trainers
	[609] = "Interface\\Icons\\ability_racial_ultravision",       --Cenarion Circle
	[910] = "Interface\\Icons\\inv_misc_head_dragon_bronze",      --Brood of Nozdormu

	-- BC
	[911] = "Interface\\Icons\\inv_misc_tournaments_symbol_bloodelf",     --Silvermoon City
	[922] = "Interface\\Icons\\INV_Misc_Bandana_03",                      --Tranquillien
	[930] = "Interface\\Icons\\inv_misc_tournaments_symbol_draenei",      --Exodar
	[932] = "Interface\\Icons\\spell_arcane_portalshattrath",             --The Aldor
	[933] = "Interface\\Icons\\inv_enchant_shardprismaticlarge",          --The Consortium
	[934] = "Interface\\Icons\\spell_arcane_portalshattrath",             --The Scryers
	[935] = "Interface\\Icons\\Spell_Nature_LightningOverload",           --The Sha'tar
	[941] = "Interface\\Icons\\inv_misc_foot_centaur",                    --The Mag'har
	[942] = "Interface\\Icons\\ability_racial_ultravision",               --Cenarion Expedition
	[946] = "Interface\\Icons\\INV_BannerPVP_02",                         --Honor Hold
	[947] = "Interface\\Icons\\INV_BannerPVP_01",                         --Thrallmar
	[967] = "Interface\\Icons\\spell_holy_mindsooth",                     --The Violet Eye
	[970] = "Interface\\Icons\\inv_mushroom_11",                          --Sporeggar
	[978] = "Interface\\Icons\\inv_misc_foot_centaur",                    --Kurenai
	[989] = "Interface\\Icons\\Ability_Warrior_VictoryRush",              --Keepers of Time
	[990] = "Interface\\Icons\\inv_enchant_dustillusion",                 --The Scale of the Sands
	[1011] = "Interface\\Icons\\Ability_Rogue_MasterOfSubtlety",          --Lower City
	[1012] = "Interface\\Icons\\achievement_reputation_ashtonguedeathsworn", --Ashtongue Deathsworn
	[1015] = "Interface\\Icons\\ability_mount_netherdrakepurple",         --Netherwing
	[1031] = "Interface\\Icons\\ability_hunter_pet_netherray",            --Sha'tari Skyguard
	[1038] = "Interface\\Icons\\inv_misc_apexis_crystal",                 --Ogri'la
	[1077] = "Interface\\Icons\\inv_shield_48",                           --Shattered Sun Offensive

	-- WotLK
	[1037] = "Interface\\Icons\\spell_misc_hellifrepvphonorholdfavor",      --Alliance Vanguard
	[1052] = "Interface\\Icons\\spell_misc_hellifrepvpthrallmarfavor",      --Horde Expedition
	[1073] = "Interface\\Icons\\achievement_reputation_tuskarr",            --The Kalu'ak
	[1090] = "Interface\\Icons\\achievement_reputation_kirintor",           --Kirin Tor
	[1091] = "Interface\\Icons\\achievement_reputation_wyrmresttemple",     --The Wyrmrest Accord
	[1094] = "Interface\\Icons\\inv_elemental_primal_mana",                 --The Silver Covenant
	[1098] = "Interface\\Icons\\achievement_reputation_knightsoftheebonblade", --Knights of the Ebon Blade
	[1104] = "Interface\\Icons\\ability_mount_whitedirewolf",               --Frenzyheart Tribe
	[1105] = "Interface\\Icons\\inv_misc_head_murloc_01",                   --The Oracles
	[1106] = "Interface\\Icons\\inv_jewelry_talisman_08",                   --Argent Crusade
	[1119] = "Interface\\Icons\\spell_frost_wizardmark",                    --The Sons of Hodir
	[1124] = "Interface\\Icons\\inv_elemental_primal_nether",               --The Sunreavers
	[1156] = "Interface\\Icons\\inv_jewelry_talisman_08",                   --The Ashen Verdict

	-- Cata
	[1133] = "Interface\\Icons\\inv_misc_tabard_kezan",         --Bilgewater Cartel
	[1134] = "Interface\\Icons\\inv_misc_tabard_gilneas",       --Gilneas
	[1135] = "Interface\\Icons\\inv_misc_tabard_earthenring",   --The Earthen Ring
	[1158] = "Interface\\Icons\\inv_misc_tabard_guardiansofhyjal", --Guardians of Hyjal
	[1171] = "Interface\\Icons\\inv_misc_tabard_therazane",     --Therazane
	[1172] = "Interface\\Icons\\inv_misc_tabard_dragonmawclan", --Dragonmaw Clan
	[1173] = "Interface\\Icons\\inv_misc_tabard_tolvir",        --Ramkahen
	[1174] = "Interface\\Icons\\inv_misc_tabard_wildhammerclan", --Wildhammer Clan
	[1177] = "Interface\\Icons\\inv_misc_tabard_baradinwardens", --Baradin's Wardens
	[1178] = "Interface\\Icons\\inv_misc_tabard_hellscream",    --Hellscream's Reach
	[1204] = "Interface\\Icons\\inv_neck_hyjaldaily_04",        --Avengers of Hyjal

	-- MoP
	[1269] = "Interface\\Icons\\achievement_faction_goldenlotus",        --Golden Lotus
	[1270] = "Interface\\Icons\\achievement_faction_shadopan",           --Shado Pan
	[1271] = "Interface\\Icons\\achievement_faction_serpentriders",      --Order of the Cloud Serpent
	[1272] = "Interface\\Icons\\achievement_faction_tillers",            --The Tillers
	[1302] = "Interface\\Icons\\achievement_faction_anglers",            --The Anglers
	[1337] = "Interface\\Icons\\achievement_faction_klaxxi",             --The Klaxxi
	[1341] = "Interface\\Icons\\achievement_faction_celestials",         --The August Celestials
	[1345] = "Interface\\Icons\\achievement_faction_lorewalkers",        --The Lorewalkers
	[1352] = "Interface\\Icons\\inv_misc_tournaments_symbol_orc",        --Huojin Pandaren
	[1353] = "Interface\\Icons\\inv_misc_tournaments_symbol_human",      --Tushui Pandaren
	[1358] = "Interface\\Icons\\INV_Misc_Fishing_Raft",                  --Nat Pagle
	[1375] = "Interface\\Icons\\achievement_general_hordeslayer",        --Dominance Offensive
	[1376] = "Interface\\Icons\\achievement_general_allianceslayer",     --Operation: Shieldwall
	[1387] = "Interface\\Icons\\achievement_reputation_kirintor_offensive", --Kirin Tor Offensive
	[1388] = "Interface\\Icons\\achievement_faction_sunreaveronslaught", --Sunreaver Onslaught
	[1435] = "Interface\\Icons\\achievement_faction_shadopan",           --Shado-Pan Assault
	[1492] = "Interface\\Icons\\ability_monk_quipunch",                  --Emperor Shaohao

	-- WoD
	[1445] = "Interface\\Icons\\inv_tabard_a_01frostwolfclan",  --Frostwolf Orcs
	[1515] = "Interface\\Icons\\inv_tabard_a_76arakkoaoutcast", --Arakkoa Outcasts
	[1681] = "Interface\\Icons\\inv_tabard_a_77voljinsspear",   --Vol'jin's Spear
	[1682] = "Interface\\Icons\\inv_tabard_a_78wrynnvanguard",  --Wrynn's Vanguard
	[1708] = "Interface\\Icons\\inv_tabard_a_80laughingskull",  --Laughing Skull Orcs
	[1710] = "Interface\\Icons\\inv_tabard_a_shataridefense",   --Sha'tari Defense
	[1711] = "Interface\\Icons\\achievement_goblinhead",        --Steamwheedle Perservation Society
	[1731] = "Interface\\Icons\\inv_tabard_a_81exarchs",        --Council of Exarchs
	[1847] = "Interface\\Icons\\Achievement_Leader_Prophet_Velen", -- Hand of the Prophet
	[1848] = "Interface\\Icons\\INV_Misc_VoljinsShatteredTusk", -- Vol'jin's Headhunters
	[1849] = "Interface\\Icons\\INV_Tabard_A_82AwakenedOrder",  -- Order of the Awakened
	[1850] = "Interface\\Icons\\INV_Tabard_A_83SaberStalkers",  -- The Saberstalkers

	-- Legion
	[1828] = "Interface\\Icons\\INV_Legion_Faction_HightmountainTribes", -- Highmountain Tribe
	[1859] = "Interface\\Icons\\INV_Legion_Faction_NightFallen",      -- The Nightfallen
	[1883] = "Interface\\Icons\\INV_Legion_Faction_DreamWeavers",     -- Dreamweavers
	[1894] = "Interface\\Icons\\INV_Legion_Faction_Warden",           -- The Wardens
	[1900] = "Interface\\Icons\\INV_Legion_Faction_CourtofFarnodis",  -- Court Of Farondis
	[1948] = "Interface\\Icons\\INV_Legion_Faction_Valarjar",         -- Valarjar
	[2045] = "Interface\\Icons\\INV_Legion_Faction_LegionFall",       -- Armies of Legionfall
	[2165] = "Interface\\Icons\\INV_Legion_Faction_ArmyoftheLight",   -- Army of the Light
	[2170] = "Interface\\Icons\\INV_legion_Faction_ArgussianReach",   -- Argussian Reach

	-- BfA
	[2164] = "Interface\\Icons\\inv_faction_championsofazeroth",      -- Champions of Azeroth
	[2163] = "Interface\\Icons\\inv_faction_tortollanseekers",        -- Tortollan Seekers
	[2159] = "Interface\\Icons\\inv_tabard_alliancewareffort",        -- 7th Legion
	[2161] = "Interface\\Icons\\inv_faction_orderofembers",           -- Order of Embers
	[2160] = "Interface\\Icons\\inv_faction_proudmooreadmiralty",     -- Proudmoore Admiralty
	[2162] = "Interface\\Icons\\inv_faction_stormswake",              -- Storm's Wake
	[2156] = "Interface\\Icons\\inv_faction_talanjisexpedition",      -- Talanji's Expedition
	[2157] = "Interface\\Icons\\inv_tabard_hordewareffort",           -- The Honorbound
	[2158] = "Interface\\Icons\\inv_faction_voldunai",                -- Voldunai
	[2103] = "Interface\\Icons\\inv_faction_zandalariempire",         -- Zandalari Empire
	[2391] = "Interface\\Icons\\inv_mechagon_junkyardtinkeringcrafting", -- Rustbolt Resistance
	[2415] = "Interface\\Icons\\inv_faction_83_rajani",               -- Rajani
	[2417] = "Interface\\Icons\\inv_faction_83_uldumaccord",          -- Uldum Accord
	[2373] = "Interface\\Icons\\inv_faction_unshackled",              -- The Unshackled
	[2400] = "Interface\\Icons\\inv_faction_akoan",                   -- Waveblade Ankoan

	-- Shadowlands
	[2407] = "Interface\\Icons\\inv_tabard_bastion_d_01",         -- The Ascended
	[2410] = "Interface\\Icons\\inv_tabard_maldraxxus_d_01",      -- The Undying Army
	[2413] = "Interface\\Icons\\inv_tabard_revendreth_d_01",      -- Court of Harvesters
	[2432] = "Interface\\Icons\\70_inscription_vantus_rune_suramar", -- Ve'nari
	[2465] = "Interface\\Icons\\inv_tabard_ardenweald_d_01",      -- The Wild Hunt
	[2470] = "Interface\\Icons\\inv_tabard_deathsadvance_b_01",   -- Death's Advance
	[2472] = "Interface\\Icons\\inv_mawexpansionfliermountyellow", -- The Archivists' Codex
	[2478] = "Interface\\Icons\\inv_tabard_enlightenedbrokers_c_01", -- The Enlightened

	-- Dragonflight
	[2503] = 4687627,                                                 -- Maruuk Centaur
	[2507] = 4687628,                                                 -- Dragonscale Expedition
	[2510] = 4687630,                                                 -- Valdrakken Accord
	[2511] = 4687629,                                                 -- Iskaara Tuskarr
	[2564] = "interface\\icons\\ui_majorfaction_niffen",              -- Loamm Niffen
	[2574] = "interface\\icons\\ui_majorfaction_denizens",            -- Dream Wardens
	[2517] = 1394891,                                                 -- Wrathion
	[2518] = 4559236,                                                 -- Sabellian
	[2550] = 1394893,                                                 -- Cobalt Assembly
	[2544] = "interface\\icons\\inv_10_gearcraft_artisansmettle_color4", -- Artisan's Consortium
	[2526] = "interface\\icons\\inv_10_misc_winterpeltfurbolg_totem", -- Winterpelt Furbolg

	-- TWW
	[2590] = "interface\\icons\\ui_majorfactions_storm",               -- Council of Dornogal
	[2594] = "interface\\icons\\ui_majorfactions_candle",              -- The Assembly of the Deeps
	[2570] = "interface\\icons\\ui_majorfactions_flame",               -- Hallowfall Arathi
	[2600] = "interface\\icons\\ui_majorfactions_web",                 -- The Severed Threads
	[2653] = "interface\\icons\\ui_majorfactions_rocket",              -- The Cartels of Undermine
	[2673] = "interface\\icons\\inv_tabard_bilgewater_b_01",           -- Bilgewater Cartel
	[2675] = "interface\\icons\\inv_tabard_blackwater_b_01",           -- Blackwater Cartel
	[2677] = "interface\\icons\\inv_tabard_steamwheedle_b_01",         -- Steamwheedle Cartel
	[2671] = "interface\\icons\\inv_tabard_ventureco_b_01",            -- Venture Company
	[2669] = "interface\\icons\\inv_111_tabard_darkfusefaction",       -- Darkfuse Solutions
	[2685] = "interface\\icons\\ui_majorfactions_stars",               -- Gallagio Loyalty Rewards Club
	[2688] = "interface\\icons\\ui_majorfactions_ nightfall",          -- Flame's Radiance
	[2658] = "interface\\icons\\ui_majorfactions_ karesh",             -- The K'aresh Trust
	[2736] = "interface\\icons\\inv_112_achievement_raid_manaforgeomega", -- Manaforge Vandals
}

local function GetLocRepStanding(id)
	if (id > 30) then -- if it's renown
		local i = id - 30
		return format(COVENANT_RENOWN_LEVEL_TOAST, i)
	else
		return PlayerSex == 3 and _G["FACTION_STANDING_LABEL"..(id or 4).."_FEMALE"] or _G["FACTION_STANDING_LABEL"..(id or 4)]
	end
end


function Faction.OnSet(button, second)
	if not FactionClickHandler then
		FactionClickHandler = ClickHandler:Add(
			"Faction",
			{
				types = {},
			},
			AtlasLoot.db.Button.Faction.ClickHandler,
			{}
		)
		PlayerSex = UnitSex("player")
	end
	if not button then return end

	if second and button.__atlaslootinfo.secType then
		if type(button.__atlaslootinfo.secType[2]) == "table" then
			button.secButton.FactionID = button.__atlaslootinfo.secType[2][1]
			button.secButton.RepID = button.__atlaslootinfo.secType[2][2]
		else
			button.secButton.FactionID = button.__atlaslootinfo.secType[2]
		end
		Faction.Refresh(button.secButton)
	else
		if type(button.__atlaslootinfo.type[2]) == "table" then
			button.FactionID = button.__atlaslootinfo.type[2][1]
			button.RepID = button.__atlaslootinfo.type[2][2]
		else
			button.FactionID = button.__atlaslootinfo.type[2]
		end
		Faction.Refresh(button)
	end
end

function Faction.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = FactionClickHandler:Get(mouseButton)
end

function Faction.OnEnter(button, owner)
	if not button.FactionID then return end
	Faction.ShowToolTipFrame(button)
end

function Faction.OnLeave(button)
	if Faction.tooltipFrame then
		Faction.tooltipFrame:Hide()
	end
end

function Faction.OnClear(button)
	button.FactionID = nil
	button.secButton.FactionID = nil
	button.RepID = nil
	button.secButton.RepID = nil

	button.icon:SetDesaturated(false)
	button.secButton.icon:SetDesaturated(false)
end

function Faction.GetStringContent(str)
	if tonumber(str) then
		return tonumber(str)
	else
		return {
			tonumber(str_match(str, "(%d+)")),
			tonumber(str_match(str, "rep(%d+)")), -- required rep (1-8)
		}
	end
end

function Faction.Refresh(button)
	if not button.FactionID then return end
	local factionID = button.FactionID
	local RepID = button.RepID
	local reputationInfo = C_GossipInfo.GetFriendshipReputation(factionID)
	local friendshipFactionID = reputationInfo.friendshipFactionID

	local temp = C_Reputation.GetFactionDataByID(factionID)
	local name = nil
	if (temp == nil) then
		name = BF[AtlasLoot.Data.Faction.FACTION_KEY[factionID]] or FACTION.." "..factionID
	else
		name = temp.name
	end
	local standingID = nil
	if (temp ~= nil) then
		standingID = temp.reaction
	end
	local isMajorFaction = C_Reputation.IsMajorFaction(factionID);
	local majorFactionData, renownLevel
	if isMajorFaction then
		majorFactionData = C_MajorFactions.GetMajorFactionData(factionID);
		renownLevel = majorFactionData.renownLevel;
	end

	if button.type == "secButton" then
		button:SetNormalTexture(FACTION_IMAGES[factionID] or FACTION_IMAGES[0])
	else
		button.name:SetText("|cFFe6b300"..name)
		button.icon:SetTexture(FACTION_IMAGES[factionID] or FACTION_IMAGES[0])

		local reqRepText
		if friendshipFactionID and friendshipFactionID > 0 then
			reqRepText = AtlasLoot.Data.Faction.FriendshipRanks[factionID][RepID] or ""
		else
			reqRepText = GetLocRepStanding(RepID or standingID) or ""
		end

		if RepID and isMajorFaction then
			local i = RepID - 30
			if renownLevel < i then
				button.icon:SetDesaturated(true)
				button.extra:SetText("|cffff0000"..reqRepText)
			else
				button.extra:SetText("|cFF00991a"..reqRepText)
			end
		elseif RepID and friendshipFactionID and friendshipFactionID > 0 then
			local rank = C_GossipInfo.GetFriendshipReputationRanks(friendshipFactionID)
			if rank.currentLevel < RepID then
				button.icon:SetDesaturated(true)
				button.extra:SetText("|cffff0000"..reqRepText)
			else
				button.extra:SetText("|cFF00991a"..reqRepText)
			end
		elseif RepID and standingID and RepID > standingID then
			button.icon:SetDesaturated(true)
			button.extra:SetText("|cffff0000"..reqRepText)
		elseif not standingID then
			button.extra:SetText("|cffff0000"..reqRepText)
		else
			button.extra:SetText("|cFF00991a"..reqRepText)
		end
	end

	return true
end

function Faction.ShowToolTipFrame(button)
	if not Faction.tooltipFrame then
		local WIDTH = 210
		local name = "AtlasLoot-FactionToolTip"
		local frame = CreateFrame("Frame", name, nil, BackdropTemplateMixin and "BackdropTemplate" or nil)
		frame:SetClampedToScreen(true)
		frame:SetWidth(WIDTH)
		frame:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 16,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		})
		frame:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR:GetRGBA())

		frame.icon = frame:CreateTexture(name.."-icon", "ARTWORK")
		frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 10, -10)
		frame.icon:SetHeight(15)
		frame.icon:SetWidth(15)
		frame.icon:SetTexture(FACTION_IMAGES[0])

		frame.name = frame:CreateFontString(name.."-name", "ARTWORK", "GameFontNormal")
		frame.name:SetPoint("TOPLEFT", frame.icon, "TOPRIGHT", 3, 0)
		frame.name:SetJustifyH("LEFT")
		frame.name:SetWidth(WIDTH - 35)
		frame.name:SetHeight(15)

		frame.standing = CreateFrame("FRAME", name.."-standing", frame, BackdropTemplateMixin and "BackdropTemplate" or nil)
		frame.standing:SetWidth(WIDTH - 20)
		frame.standing:SetHeight(20)
		frame.standing:SetPoint("TOPLEFT", frame.icon, "BOTTOMLEFT", 0, -5)
		frame.standing:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = true,
			tileSize = 16,
			edgeSize = 12,
			insets = { left = 3, right = 3, top = 3, bottom = 3 }
		})
		frame.standing:SetBackdropColor(0, 0, 0, 1)

		frame.standing.bar = CreateFrame("StatusBar", name.."-standingBar", frame.standing)
		frame.standing.bar:SetStatusBarTexture("Interface\\TARGETINGFRAME\\UI-StatusBar")
		frame.standing.bar:SetPoint("TOPLEFT", 3, -3)
		frame.standing.bar:SetPoint("BOTTOMRIGHT", -3, 3)
		frame.standing.bar:GetStatusBarTexture():SetHorizTile(false)
		frame.standing.bar:GetStatusBarTexture():SetVertTile(false)

		frame.standing.text = frame.standing.bar:CreateFontString(name.."-standingText", "ARTWORK", "GameFontNormalSmall")
		frame.standing.text:SetPoint("TOPLEFT", 3, -3)
		frame.standing.text:SetPoint("BOTTOMRIGHT", -3, 3)
		frame.standing.text:SetJustifyH("CENTER")
		frame.standing.text:SetJustifyV("MIDDLE")
		frame.standing.text:SetTextColor(1, 1, 1, 1)

		frame.desc = frame:CreateFontString(name.."-desc", "ARTWORK", "GameFontNormalSmall")
		frame.desc:SetPoint("TOPLEFT", frame.standing, "BOTTOMLEFT", 0, -5)
		frame.desc:SetJustifyH("LEFT")
		frame.desc:SetJustifyV("TOP")
		frame.desc:SetWidth(WIDTH - 20)
		frame.desc:SetTextColor(1, 1, 1, 1)

		Faction.tooltipFrame = frame
	end
	local frame = Faction.tooltipFrame
	local factionID = button.FactionID
	local name, description, standingID, barMin, barMax, barValue = nil, nil, nil, nil, nil, nil
	local temp = C_Reputation.GetFactionDataByID(factionID)
	if (temp == nil) then
		name = BF[AtlasLoot.Data.Faction.FACTION_KEY[factionID]] or FACTION.." "..factionID
	else
		name, description, standingID, barMin, barMax, barValue = temp.name, temp.description, temp.reaction, temp.currentReactionThreshold, temp.nextReactionThreshold, temp.currentStanding
	end
	standingID = standingID or 1
	local colorIndex = standingID;
	local barColor = FACTION_BAR_COLORS[colorIndex];
	local factionStandingtext;

	local isCapped;
	if (standingID == MAX_REPUTATION_REACTION) then
		isCapped = true;
	end

	-- check if this is a friendship faction or a Major Faction
	local isMajorFaction = factionID and C_Reputation.IsMajorFaction(factionID);
	local repInfo = factionID and C_GossipInfo.GetFriendshipReputation(factionID);
	if (repInfo and repInfo.friendshipFactionID > 0) then
		factionStandingtext = repInfo.reaction;
		if (repInfo.nextThreshold) then
			barMin, barMax, barValue = repInfo.reactionThreshold, repInfo.nextThreshold, repInfo.standing;
		else
			-- max rank, make it look like a full bar
			barMin, barMax, barValue = 0, 1, 1;
		end
		colorIndex = 5
		barColor = FACTION_BAR_COLORS[colorIndex]; -- always color friendships green
	elseif (isMajorFaction) then
		local majorFactionData = C_MajorFactions.GetMajorFactionData(factionID);

		barMin, barMax = 0, majorFactionData.renownLevelThreshold;
		isCapped = C_MajorFactions.HasMaximumRenown(factionID);
		barValue = isCapped and majorFactionData.renownLevelThreshold or majorFactionData.renownReputationEarned or 0;
		barColor = BLUE_FONT_COLOR;
		factionStandingtext = str_format(RENOWN_LEVEL_LABEL, majorFactionData.renownLevel);
	else
		barMin, barMax, barValue = barMin or 0, barMax or 1, barValue or 0
		if (isCapped) then
			-- max rank, make it look like a full bar
			barMin, barMax, barValue = 0, 1, 1;
		end
		factionStandingtext = GetLocRepStanding(standingID)
	end

	--Normalize Values
	barMax = barMax - barMin;
	barValue = barValue - barMin;
	barMin = 0;

	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT")

	frame.icon:SetTexture(FACTION_IMAGES[button.FactionID] or FACTION_IMAGES[0])
	frame.name:SetText(name)
	frame.desc:SetText(description)

	frame.standing.bar:SetMinMaxValues(barMin, barMax)
	frame.standing.bar:SetValue(barValue)
	frame.standing.bar:SetStatusBarColor(barColor.r, barColor.g, barColor.b)
	if (isCapped) then
		frame.standing.text:SetText(str_format("%s", factionStandingtext))
	else
		frame.standing.text:SetText(str_format("%s ( %d / %d )", factionStandingtext, barValue - barMin, barMax - barMin))
	end

	frame:SetHeight(20 + 21 + frame.desc:GetHeight() + 23)
	frame:Show()
end
