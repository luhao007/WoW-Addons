--------------------------------------------------------------------------
-- GTFO.lua 
--------------------------------------------------------------------------
--[[
GTFO
Author: Zensunim of Dragonblight [Retail], Myzrael [Classic]

Usage: /GTFO or go to Interface->Add-ons->GTFO
]]--
GTFO = {
	DefaultSettings = {
		Active = true;
		Sounds = { true, true, true, true };
		ScanMode = nil;
		AlertMode = nil;
		DebugMode = nil; -- Turn on debug alerts
		TestMode = nil; -- Activate alerts for events marked as "test only"
		UnmuteMode = nil;
		TrivialMode = nil;
		NoVersionReminder = nil;
		EnableVibration = nil;
		Volume = 3; -- Volume setting, 3 = default
		SoundChannel = "Master"; -- Sound channel to play on
		IgnoreOptions = { };
		TrivialDamagePercent = 2; -- Minimum % of HP lost required for an alert to be trivial
		SoundOverrides = { "", "", "", "" }; -- Override table for GTFO sounds
		IgnoreSpellList = { };
		BrannMode = 0;
		IgnoreTimeAmount = .2;
	};
	Version = "5.18"; -- Version number (text format)
	VersionNumber = 0; -- Numeric version number for checking out-of-date clients (placeholder until client is detected)
	RetailVersionNumber = 51800; -- Numeric version number for checking out-of-date clients (retail)
	ClassicVersionNumber = 51701; -- Numeric version number for checking out-of-date clients (Vanilla classic)
	BurningCrusadeVersionNumber = 50000; -- Numeric version number for checking out-of-date clients (TBC classic)
	WrathVersionNumber = 50503; -- Numeric version number for checking out-of-date clients (Wrath classic)
	CataclysmVersionNumber = 51704; -- Numeric version number for checking out-of-date clients (Cata classic)
	MistsVersionNumber = 51800; -- Numeric version number for checking out-of-date clients (MoP classic)
	DataLogging = nil; -- Indicate whether or not the addon needs to run the datalogging function (for hooking)
	DataCode = "4"; -- Saved Variable versioning, change this value to force a reset to default
	CanTank = nil; -- The active character is capable of tanking
	CanCast = nil; -- The active character is capable of casting
	TankMode = nil; -- The active character is a tank
	CasterMode = nil; -- The active character is a caster
	PlayerClass = select(2, UnitClass("player")); -- The active character's class
	SpellName = { }; -- List of spells (for Classic only since Spell IDs are not available in the combat log)
	SpellID = { }; -- List of spell IDs
	FFSpellID = { }; -- List of friendly fire spell IDs
	IgnoreSpellCategory = { }; -- List of spell groups to ignore
	IgnoreScan = { }; -- List of spell groups to ignore during scans
	MobID = { }; -- List of mob IDs for melee attack detection
	GroupGUID = { }; -- List of GUIDs of members in your group
	UpdateFound = nil; -- Upgrade available?
	IgnoreTime = nil;
	IgnoreUpdateTimeAmount = 5; -- Number of seconds between sending out version updates
	IgnoreUpdateTime = nil;
	IgnoreUpdateRequestTimeAmount = 90; -- Number of seconds between sending out version update requests
	IgnoreUpdateRequestTime = nil;
	Events = { }; -- Event queue
	Users = { }; -- User version database
	Sounds = { }; -- Sound Files
	SoundSettings = { }; -- CVARs for temporary muting
	SoundTimes = { .5, .3, .4, .5 }; -- Length of sound files in seconds (for auto-unmute)
	VibrationTypes = { "High", "Low", "Low", "High" };
	VibrationIntensity = { 1.0, .1, .25, 1.0 };
	PartyMembers = 0;
	RaidMembers = 0;
	PowerAuras = nil; -- PowerAuras Integration enabled
	WeakAuras = nil; -- WeakAuras Integration enabled
	Recount = nil; -- Recount Integration enabled
	Skada = nil; -- Skada Integration enabled
	Settings = { };
	UIRendered = nil;
	VariableStore = { -- Variable storage for special circumstances
		StackCounter = 0;
		DisableGTFO = nil;
	};
	BetaMode = nil; -- WoW Beta/PTR client detection
	DragonflightMode = nil; -- WoW Dragonflight UI client detection
	RetailMode = nil; -- WoW Retail client detection
	ClassicMode = nil; -- WoW Classic client detection
	BurningCrusadeMode = nil; -- WoW TBC client detection
	WrathMode = nil; -- WoW Wrath client detection
	CataclysmMode = nil; -- WoW Cataclysm client detection
	MistsMode = nil; -- WoW Mists client detection
	SoundChannels = { 
		{ Code = "Master", Name = _G.MASTER_VOLUME },
		{ Code = "SFX", Name = _G.SOUND_VOLUME, CVar = "Sound_EnableSFX" },
		{ Code = "Ambience", Name = _G.AMBIENCE_VOLUME, CVar = "Sound_EnableAmbience" },
		{ Code = "Music", Name = _G.MUSIC_VOLUME, CVar = "Sound_EnableMusic" },
		{ Code = "Dialog", Name = _G.DIALOG_VOLUME, CVar = "Sound_EnableDialog" },
	};
	Scans = { };
};

GTFOData = {};

local buildNumber = select(4, GetBuildInfo());

if (buildNumber >= 110100) then
	GTFO.BetaMode = true;
end
if (buildNumber >= 100000) then
	GTFO.DragonflightMode = true;
	GTFO.SoundChannels[2].Name = _G.FX_VOLUME;
end
if (buildNumber <= 20000) then
	GTFO.ClassicMode = true;
	GTFO.VersionNumber = GTFO.ClassicVersionNumber;
elseif (buildNumber <= 30000) then
	GTFO.BurningCrusadeMode = true;
	GTFO.VersionNumber = GTFO.BurningCrusadeVersionNumber;
elseif (buildNumber <= 40000) then
	GTFO.WrathMode = true;
	GTFO.VersionNumber = GTFO.WrathVersionNumber;
elseif (buildNumber <= 50000) then
	GTFO.CataclysmMode = true;
	GTFO.VersionNumber = GTFO.CataclysmVersionNumber;
elseif (buildNumber <= 60000) then
	GTFO.MistsMode = true;
	GTFO.VersionNumber = GTFO.MistsVersionNumber;
else
	GTFO.RetailMode = true;
	GTFO.VersionNumber = GTFO.RetailVersionNumber;
	local currentDate = date("*t");
	GTFO.AprilFoolsDay = (currentDate.month == 4 and currentDate.day == 1);
end

StaticPopupDialogs["GTFO_POPUP_MESSAGE"] = {
	preferredIndex = 3,
	text = GTFOLocal.LoadingPopup_Message,
	button1 = YES,
	button2 = NO,
	OnAccept = function()
		GTFO_Command_Options()
	end,
	OnCancel = function()
		GTFO_ChatPrint(string.format(GTFOLocal.ClosePopup_Message," |cFFFFFFFF/gtfo options|r"))
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
};	

function GTFO_ChatPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.25, 1.0, 0.25);
end

function GTFO_ErrorPrint(str)
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 1.0, 0.5, 0.5);
end

function GTFO_DebugPrint(str)
	if (GTFO.Settings.DebugMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.75, 1.0, 0.25);
	end
end

function GTFO_ScanPrint(str, bNew)
	if (GTFO.Settings.ScanMode) then
		if (bNew) then
			DEFAULT_CHAT_FRAME:AddMessage("[GTFO:New] "..tostring(str), 0.5, 0.5, 0.85);
		else
			DEFAULT_CHAT_FRAME:AddMessage("[GTFO:Scan] "..tostring(str), 0.5, 0.65, 0.65);
		end

	end
end

function GTFO_AlertPrint(str)
	if (GTFO.Settings.AlertMode) then
		DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..tostring(str), 0.5, 0.5, 0.85);
	end
end

function GTFO_GetMobId(sGUID)
	local mobType, _, _, _, _, mobId = strsplit("-", sGUID or "")
	if mobType and (mobType == "Creature" or mobType == "Vehicle" or mobType == "Pet") then
		return tonumber(mobId)
	end
	return 0;
end

function GTFO_OnEvent(self, event, ...)
	if (event == "VARIABLES_LOADED") then
		C_ChatInfo.RegisterAddonMessagePrefix("GTFO");
		if (GTFOData.DataCode ~= GTFO.DataCode) then
			GTFO_SetDefaults();
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_NewDatabase, GTFO.Version));
			GTFO_DisplayConfigPopupMessage();
		end
		GTFO.Settings = {
			Active = GTFOData.Active;
			Sounds = { GTFOData.Sounds[1], GTFOData.Sounds[2], GTFOData.Sounds[3], GTFOData.Sounds[4] };
			ScanMode = GTFOData.ScanMode;
			AlertMode = GTFOData.AlertMode;
			DebugMode = GTFOData.DebugMode;
			TestMode = GTFOData.TestMode;
			UnmuteMode = GTFOData.UnmuteMode;
			TrivialMode = GTFOData.TrivialMode;
			NoVersionReminder = GTFOData.NoVersionReminder;
			EnableVibration = GTFOData.EnableVibration;
			Volume = GTFOData.Volume or 3;
			TrivialDamagePercent = GTFOData.TrivialDamagePercent or GTFO.DefaultSettings.TrivialDamagePercent;
			SoundChannel = GTFOData.SoundChannel or GTFO.DefaultSettings.SoundChannel;
			BrannMode = GTFOData.BrannMode;
			IgnoreTimeAmount = GTFOData.IgnoreTimeAmount;
			IgnoreOptions = { };
			SoundOverrides = { "", "", "", "" };
			IgnoreSpellList = { };
		};
		
		-- Load spell ignore options (player set)
		if (GTFOData.IgnoreOptions) then
			for key, option in pairs(GTFOData.IgnoreOptions) do
				GTFO.Settings.IgnoreOptions[key] = GTFOData.IgnoreOptions[key];
			end
		end
		
		-- Load default spell ignore options
		if (GTFO.IgnoreSpellCategory) then
			for key, option in pairs(GTFO.IgnoreSpellCategory) do
				if (GTFO.IgnoreSpellCategory[key].isDefault) then
					GTFO.DefaultSettings.IgnoreOptions[key] = true;
					if (GTFO.Settings.IgnoreOptions[key] == nil) then
						GTFO.Settings.IgnoreOptions[key] = true;
					end
				end
			end
		end
		
		if (GTFOData.SoundOverrides) then
			for key, option in pairs(GTFOData.SoundOverrides) do
				GTFO.Settings.SoundOverrides[key] = GTFOData.SoundOverrides[key] or "";
			end
		end
		
		if (GTFOData.IgnoreSpellList) then
			for i, spellId in pairs(GTFOData.IgnoreSpellList) do
				tinsert(GTFO.Settings.IgnoreSpellList, spellId);
			end
		end

		GTFO_RenderOptions();
		GTFO_SaveSettings();
		GTFO_AddEvent("RefreshOptions", .1, function() GTFO_RefreshOptions(); end);

		-- Power Auras Integration
		if (C_AddOns.IsAddOnLoaded("PowerAuras")) then
			local PowaAurasEnabled
			if (PowaAuras_GlobalTrigger) then
				PowaAurasEnabled = PowaAuras_GlobalTrigger()
			end
			-- Power Auras 5.x
			if (PowaAuras and PowaAuras.MarkAuras) then
				GTFO.PowerAuras = true;
			-- Power Auras 4.24.2+
			elseif (PowaAurasEnabled) then
				GTFO.PowerAuras = true;
			-- Power Auras 4.x
			elseif (PowaAuras and PowaAuras.AurasByType) then
				if (PowaAuras.AurasByType.GTFOHigh) then
					GTFO.PowerAuras = true;
				else
					GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
				end
			else
				GTFO_ChatPrint(GTFOLocal.Loading_PowerAurasOutOfDate);
			end
		end
		if (C_AddOns.IsAddOnLoaded("WeakAuras")) then
			GTFO.WeakAuras = true;
		else
			GTFO_DisplayAura_WeakAuras = nil;
		end
		if not (GTFO.PowerAuras) then
			GTFO_DisplayAura_PowerAuras = nil
		end
		if (GTFO.Settings.Active) then
			--GTFO_ChatPrint(string.format(GTFOLocal.Loading_Loaded, GTFO.Version));
		else
			GTFO_ChatPrint(string.format(GTFOLocal.Loading_LoadedSuspended, GTFO.Version));
		end
		
		-- Recount Integration
		if (C_AddOns.IsAddOnLoaded("Recount")) then
			GTFO.Recount = GTFO_Recount();
			GTFO.DataLogging = true;
		else
			GTFO_Recount = nil;
			GTFO_RecordRecount = nil;
		end
		if (C_AddOns.IsAddOnLoaded("Skada")) then
			GTFO.Skada = GTFO_Skada();
			GTFO.DataLogging = true;
		else
			GTFO_Skada = nil;
		end
		
		GTFO.Users[UnitName("player")] = GTFO.VersionNumber;
		GTFO_GetSounds();
		GTFO.CanTank = GTFO_CanTankCheck();
		GTFO.CanCast = GTFO_CanCastCheck();
		if (GTFO.CanCast) then
			GTFO_RegisterCasterEvents();
		end
		if (GTFO.CanTank) then
			GTFO_RegisterTankEvents();
		end
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO.CasterMode = GTFO_CheckCasterMode();
		GTFO_SendUpdateRequest();
		
		if (GTFO.ClassicMode) then
			GTFO_ScanSpells();
		end
		
		-- Display state errors meant for debuggers:
		if (GTFO.Settings.ScanMode) then
			GTFO_ErrorPrint("Scan (debugging) mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo scan|r");
		end
		if (GTFO.Settings.AlertMode) then
			GTFO_ErrorPrint("Alert (debugging) mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo alert|r");
		end
		if (GTFO.Settings.DebugMode) then
			GTFO_ErrorPrint("Debug mode is currently on.");
			GTFO_ErrorPrint(" To turn this off, type: |cFFEEEE00/gtfo debug|r");
		end
		
		return;
	end
	if (event == "PLAYER_ENTERING_WORLD") then
		-- Refresh mode status just in case
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO.CasterMode = GTFO_CheckCasterMode();
		return;
	end
	if (event == "COMBAT_LOG_EVENT_UNFILTERED") then
		if (GTFO.IgnoreTime and not (GTFO.DataLogging)) then
			if (GetTime() < GTFO.IgnoreTime) then
				-- Alerts are currently being ignored and data logging is off, don't bother with processing anything
				return;
			end
		end

		local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, misc1, misc2, misc3, misc4, misc5, misc6, misc7 = CombatLogGetCurrentEventInfo(); 
		
		local SpellType = tostring(eventType);
		local vehicle = nil;

		if (GTFO.VariableStore.DisableGTFO) then
			if GTFO_FindEvent("ReshapeLife") then
				if (GTFO_HasDebuff("player", 122784)) then
					GTFO_AddEvent("ReshapeLife", 5);
				end
				return;
			end
			GTFO.VariableStore.DisableGTFO = nil;
		end
		
		if (UnitIsCharmed("player")) then
			--GTFO_DebugPrint("Won't alert - Player is mind-controlled");
			return;		
		end
	
		if (destGUID ~= UnitGUID("player")) then
			-- Damage happened to someone/something other than the player
			if (destGUID == UnitGUID("vehicle")) then
				-- Player's vehicle is targetted, not the player
				vehicle = true;
			else
				if (sourceGUID == UnitGUID("player")) then
					-- Player was the source of event, but not the target
					if (SpellType=="SPELL_DAMAGE") then
						local SpellID = tonumber(misc1);
						local SpellName = tostring(misc2);
						local SpellSourceGUID = tostring(sourceGUID);
						
						if (GTFO.ClassicMode) then
							SpellID = tostring(GTFO.SpellName[SpellName] or SpellID or 0)
						else
							SpellID = tostring(SpellID);
						end
						
						--GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..SpellName.." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName));
						if (GTFO.FFSpellID[SpellID]) then
							-- Friendly fire alerts
							if not (tContains(GTFO.GroupGUID, destGUID)) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Damage wasn't a raid member");
								return;
							end
							if (GTFO.FFSpellID[SpellID].test and not GTFO.Settings.TestMode) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Test mode off");
								-- Test mode is off, ignore
								return;
							end
							if (GTFO.FFSpellID[SpellID].trivialLevel and not GTFO.Settings.TrivialMode and GTFO.FFSpellID[SpellID].trivialLevel <= UnitLevel("player")) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Trivial spell - Level");
								-- Trivial mode is off, ignore trivial spell
								return;
							end
							if (GTFO.FFSpellID[SpellID].ignoreSelfInflicted and destGUID == UnitGUID("player")) then
								--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore self inflicted");
								-- Self-inflicted wound and "Ignore Self Inflicated" is set
								return;
							end
							local damage = tonumber(misc4) or 0
							if ((GTFO.FFSpellID[SpellID].trivialPercent or 0) >= 0 and not GTFO.FFSpellID[SpellID].alwaysAlert and not GTFO.Settings.TrivialMode) then
								local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"));
							 	if (((GTFO.FFSpellID[SpellID].trivialPercent or 0) == 0 and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) or (GTFO.FFSpellID[SpellID].trivialPercent and GTFO.FFSpellID[SpellID].trivialPercent > 0 and damagePercent < GTFO.FFSpellID[SpellID].trivialPercent)) then
									--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") on "..tostring(destName).." - Trivial spell - Damage %");
									-- Trivial mode is off, ignore trivial spell based on damage %
									return;
								end
							end

							if (GTFO.FFSpellID[SpellID].test) then
								GTFO_ScanPrint("TEST FF ALERT: Spell ID #"..SpellID, true);
							end
							alertID = GTFO_GetAlertID(GTFO.FFSpellID[SpellID]);
							GTFO_PlaySound(alertID);
							GTFO_RecordStats(alertID, SpellID, SpellName, tonumber(damage), nil, SpellType);
						end
					end
				end
				return;
			end
		end
		if (SpellType == "ENVIRONMENTAL_DAMAGE") then
			local environment = string.upper(tostring(misc1))
			local damage = tonumber(misc2) or 0
			local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"))
			-- Environmental detection
			local alertID = 0;
			if (environment == "DROWNING") then
				alertID = 1;
			elseif (environment == "FATIGUE") then
				if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Fatigue"]) then
					-- Fatigue being ignored
					--GTFO_DebugPrint("Won't alert FATIGUE - Manually ignored");
					return;
				end
				alertID = 1;
			elseif (environment == "LAVA") then
				if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Lava"]) then
					-- Lava being ignored
					--GTFO_DebugPrint("Won't alert LAVA - Manually ignored");
					return;
				end
				alertID = 2;
				if (GTFO_HasDebuff("player", 81118) or GTFO_HasDebuff("player", 94073) or GTFO_HasDebuff("player", 94074) or GTFO_HasDebuff("player", 94075) or GTFO_HasDebuff("player", 97151)) then
					-- Magma debuff exception
					--GTFO_DebugPrint("Won't alert LAVA - Magma debuff found");
					alertID = 0;
				elseif (not GTFO.Settings.TrivialMode and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) then
					-- Trivial
					--GTFO_DebugPrint("Won't alert LAVA - Trivial");
					alertID = 0;
				end
			elseif (environment ~= "FALLING") then
				if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Lava"]) then
					-- Lava being ignored
					--GTFO_DebugPrint("Won't alert LAVA - Manually ignored");
					return;
				end
				alertID = 2;
				if (not GTFO.Settings.TrivialMode and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) then
					-- Trivial
					--GTFO_DebugPrint("Won't alert "..tostring(environment).." - Trivial");
					alertID = 0;
				end
			else
				return;
			end
			GTFO_ScanPrint(SpellType.." - "..environment, (alertID == 0));
			if (alertID == 0) then
				return;
			end
			GTFO_PlaySound(alertID);
			GTFO_RecordStats(alertID, 0, GTFOLocal.Recount_Environmental, tonumber(damage), nil, SpellType);
		elseif (SpellType=="SPELL_PERIODIC_DAMAGE" or SpellType=="SPELL_DAMAGE" or SpellType=="SPELL_MISSED" or SpellType=="SPELL_PERIODIC_MISSED" or SpellType=="SPELL_ENERGIZE" or SpellType=="SPELL_INSTAKILL" or ((SpellType=="SPELL_AURA_APPLIED" or SpellType=="SPELL_AURA_APPLIED_DOSE" or SpellType=="SPELL_AURA_REFRESH") and misc4=="DEBUFF")) then
			-- Spell detection
			local SpellID = tonumber(misc1);
			local SpellName = tostring(misc2);
			local SpellSourceGUID = tostring(sourceGUID);
			local SpellSourceName = tostring(sourceName);
			local damage = tonumber(misc4) or 0

			-- Special exception for Onyxia Breath's and her stupid 92 different spell IDs
			if ((SpellID > 17086 and SpellID <= 17097) or (SpellID >= 18351 and SpellID <= 18361) or (SpellID >= 18564 and SpellID <= 18607) or SpellID == 18609 or (SpellID >= 18611 and SpellID <= 18628)) then
				SpellID = 17086;
			end
			
			if (GTFO.ClassicMode) then
				SpellID = tostring(GTFO.SpellName[SpellName] or SpellID or 0)
			else
				SpellID = tostring(SpellID);
			end
						
			if (GTFO.Settings.ScanMode and not GTFO.IgnoreScan[SpellID]) then
				if (vehicle) then
					GTFO_ScanPrint("V: "..SpellType.." - "..SpellID.." - "..GTFO_GetSpellLink(SpellID).." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName), GTFO_SpellScan(SpellID, SpellSourceName));
				elseif (SpellType~="SPELL_ENERGIZE" or (SpellType=="SPELL_ENERGIZE" and sourceGUID ~= UnitGUID("player"))) then
					if (GTFO.ClassicMode) then
						GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..SpellName.." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName).." for "..tostring(misc4), GTFO_SpellScanName(SpellName, SpellSourceName, tostring(misc4)));
					else
						GTFO_ScanPrint(SpellType.." - "..SpellID.." - "..GTFO_GetSpellLink(SpellID).." - "..SpellSourceName.." ("..GTFO_GetMobId(sourceGUID)..") >"..tostring(destName).." for "..tostring(misc4), GTFO_SpellScan(SpellID, SpellSourceName, tostring(misc4)));
					end
				end
			end
			if (GTFO.SpellID[SpellID]) then
				if (tContains(GTFO.Settings.IgnoreSpellList, tonumber(SpellID))) then
					-- Spell is on the custom ignore list
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Player custom ignore option: "..GTFO.SpellID[SpellID].category);
					return;						
				end
			
				if (GTFO.SpellID[SpellID].category) then
					if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions[GTFO.SpellID[SpellID].category]) then
						-- Spell is being ignored completely
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Player activated ignore option: "..GTFO.SpellID[SpellID].category);
						return;						
					end
				end

				if (GTFO.SpellID[SpellID].spellType and not (GTFO.SpellID[SpellID].spellType == SpellType)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Wrong Spell Type");
					-- Wrong spell type
					return;
				end

				if (vehicle and not GTFO.SpellID[SpellID].vehicle) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Vehicle not enabled");
					-- Vehicle damage and vehicle mode is not set
					return;
				end
				if (GTFO.SpellID[SpellID].test and not GTFO.Settings.TestMode) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Test mode off");
					-- Experiemental/Beta option is off, ignore
					return;
				end

				if (GTFO.SpellID[SpellID].casterOnly and not GTFO.CasterMode) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Caster alert only");
					-- Alert is for casters only
					return;
				end

				if (GTFO.SpellID[SpellID].ignoreEvent and GTFO_FindEvent(GTFO.SpellID[SpellID].ignoreEvent)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore Event ("..GTFO.SpellID[SpellID].ignoreEvent..") is active");
					-- Ignore event code found
					return;
				end

				if (GTFO.SpellID[SpellID].ignorePeriodic and (SpellType == "SPELL_PERIODIC_DAMAGE" or SpellType == "SPELL_PERIODIC_MISSED")) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore periodic event");
					-- Lingering damage and "Ignore Periodic" is set
					return;					
				end

				if (GTFO.SpellID[SpellID].ignoreRefresh and SpellType == "SPELL_AURA_REFRESH") then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore refresh event");
					-- Lingering damage and "Ignore Periodic" is set
					return;					
				end

				if (GTFO.SpellID[SpellID].negatingDebuffSpellID and GTFO_HasDebuff("player", GTFO.SpellID[SpellID].negatingDebuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Negating debuff ("..GTFO.SpellID[SpellID].negatingDebuffSpellID..") is active");
					-- Player has a spell negating debuff
					if (GTFO.SpellID[SpellID].negatingIgnoreTime) then
						GTFO_AddEvent("Negate"..SpellID, GTFO.SpellID[SpellID].negatingIgnoreTime);
					end
					return;
				end
				if (GTFO.SpellID[SpellID].negatingBuffSpellID and GTFO_HasBuff("player", GTFO.SpellID[SpellID].negatingBuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Negating buff ("..GTFO.SpellID[SpellID].negatingBuffSpellID..") is active");
					-- Player has a spell negating buff
					if (GTFO.SpellID[SpellID].negatingIgnoreTime) then
						GTFO_AddEvent("Negate"..SpellID, GTFO.SpellID[SpellID].negatingIgnoreTime);
					end
					return;
				end
				if (GTFO.SpellID[SpellID].negatingIgnoreTime and GTFO_FindEvent("Negate"..SpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore Event (Negate"..SpellID..") is active");
					-- Ignore event code found (keep this code after AddEvent triggers so the triggers can continue to refresh)
					return;
				end
				if (GTFO.SpellID[SpellID].affirmingDebuffSpellID and not GTFO_HasDebuff("player", GTFO.SpellID[SpellID].affirmingDebuffSpellID)) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Affirming debuff ("..GTFO.SpellID[SpellID].affirmingDebuffSpellID..") is not active");
					-- Player doesn't have spell affirming debuff
					return;
				end
				if (not GTFO.Settings.TrivialMode) then
					if (GTFO.SpellID[SpellID].trivialLevel and GTFO.SpellID[SpellID].trivialLevel <= UnitLevel("player")) then
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Trivial spell - Low level");
						-- Trivial mode is off, ignore trivial spell based on level
						return;
					end
					if ((GTFO.SpellID[SpellID].trivialPercent or 0) >= 0 and not GTFO.SpellID[SpellID].alwaysAlert and (SpellType=="SPELL_PERIODIC_DAMAGE" or SpellType=="SPELL_DAMAGE")) then
						local damagePercent = tonumber((damage * 100) / UnitHealthMax("player"));
					 	if (((GTFO.SpellID[SpellID].trivialPercent or 0) == 0 and damagePercent < tonumber(GTFO.Settings.TrivialDamagePercent)) or (GTFO.SpellID[SpellID].trivialPercent and GTFO.SpellID[SpellID].trivialPercent > 0 and damagePercent < GTFO.SpellID[SpellID].trivialPercent)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Trivial spell - Damage %");
							-- Trivial mode is off, ignore trivial spell based on damage %
							return;
						end
					end
				end
				if (GTFO.SpellID[SpellID].specificMobs and not tContains(GTFO.SpellID[SpellID].specificMobs, GTFO_GetMobId(sourceGUID))) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Mob isn't on the list");
					-- Mob isn't on the list, ignore spell
					return;
				end
				if ((SpellType == "SPELL_MISSED" or SpellType == "SPELL_PERIODIC_MISSED") and not GTFO.SpellID[SpellID].alwaysAlert) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Spell missed & always alert off");
					-- Always Alert is off, ignore missed spell
					return;
				end
				if (GTFO.SpellID[SpellID].applicationOnly) then
					if (GTFO.SpellID[SpellID].minimumStacks or GTFO.SpellID[SpellID].maximumStacks) then
						if (SpellType ~= "SPELL_AURA_APPLIED_DOSE" or not misc5) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ minimum stacks & not a dosage event");
							-- Not a dose application event
							return;
						end
						local stacks = tonumber(misc5);
						if (GTFO.SpellID[SpellID].minimumStacks and stacks <= tonumber(GTFO.SpellID[SpellID].minimumStacks)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ minimum stacks & not enough stacks");
							-- Not enough stacks
							return;
						elseif (GTFO.SpellID[SpellID].maximumStacks and stacks >= tonumber(GTFO.SpellID[SpellID].maximumStacks)) then
							--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only w/ maximum stacks & too many stacks");
							-- Too many stacks
							return;
						end
					elseif (not (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE" or SpellType == "SPELL_AURA_REFRESH")) then
						--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Application only & non-application event");
						-- Application Only is set and this was a non-application event
						return;
					end
				end
				if (GTFO.SpellID[SpellID].ignoreApplication and (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE" or SpellType == "SPELL_AURA_REFRESH")) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore application event");
					-- Debuff application and "Ignore Application" is set
					return;					
				end
				if (GTFO.SpellID[SpellID].trivialLevelApplication and GTFO.SpellID[SpellID].trivialLevelApplication <= UnitLevel("player") and (SpellType == "SPELL_AURA_APPLIED" or SpellType == "SPELL_AURA_APPLIED_DOSE" or SpellType == "SPELL_AURA_REFRESH")) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore trivial level application event");
					-- Debuff application and "Ignore Application when above trivial level" is set
					return;					
				end
				if (GTFO.SpellID[SpellID].ignoreSelfInflicted and SpellSourceGUID == UnitGUID("player")) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Ignore self inflicted");
					-- Self-inflicted wound and "Ignore Self Inflicated" is set
					return;
				end
				if (GTFO.SpellID[SpellID].damageMinimum and GTFO.SpellID[SpellID].damageMinimum > damage) then
					--GTFO_DebugPrint("Won't alert "..SpellName.." ("..SpellID..") - Minimum damage amount not exceeded");
					-- Not enough damage was caused
					return;
				end
				alertID = GTFO_GetAlertID(GTFO.SpellID[SpellID]);
				if (GTFO.SpellID[SpellID].test) then
					GTFO_ErrorPrint("TEST ALERT: Spell ID #"..SpellID.." "..GTFO_GetSpellLink(SpellID));
				end
				GTFO_PlaySound(alertID);
				if (SpellType == "SPELL_PERIODIC_DAMAGE" or SpellType == "SPELL_DAMAGE" or SpellType == "SPELL_ENERGIZE") then
					GTFO_RecordStats(alertID, SpellID, SpellName, damage, SpellSourceName, SpellType);
				else
					GTFO_RecordStats(alertID, SpellID, "+"..SpellName, 0, SpellSourceName, SpellType);
				end
				return;
			end
		elseif (SpellType=="SWING_DAMAGE" or SpellType=="SWING_MISSED") then
			-- Melee hit detection
			local SourceMobID = tostring(GTFO_GetMobId(sourceGUID));
			if (GTFO.MobID[SourceMobID]) then
				if (GTFO.MobID[SourceMobID].test and not GTFO.Settings.TestMode) then
					return;
				end
				if (GTFO.MobID[SourceMobID].trivialLevel and not GTFO.Settings.TrivialMode and GTFO.MobID[SourceMobID].trivialLevel <= UnitLevel("player")) then
					-- Trivial mode is off, ignore trivial mob
					return;
				end
				if (SpellType=="SWING_DAMAGE") then
					local damage = tonumber(misc1) or 0
					if (damage > 0 or not GTFO.MobID[SourceMobID].damageOnly) then
						alertID = GTFO_GetAlertID(GTFO.MobID[SourceMobID]);
						GTFO_PlaySound(alertID);
						GTFO_RecordStats(alertID, 6603, sourceName, tonumber(damage), nil, SpellType);
						return;						
					end
				elseif (not GTFO.MobID[SourceMobID].damageOnly and SpellType=="SWING_MISSED") then
					alertID = GTFO_GetAlertID(GTFO.MobID[SourceMobID]);
					GTFO_PlaySound(alertID);
					GTFO_RecordStats(alertID, 6603, sourceName, 0, nil, SpellType);
					return;						
				end
			end
		end
		return;
	end
	if (event == "MIRROR_TIMER_START") then
		-- Fatigue bar warning
		local sType, iValue, iMaxValue, iScale, bPaused, sLabel = ...;
		if (sType == "EXHAUSTION" and iScale < 0) then
			if (GTFO.Settings.IgnoreOptions and GTFO.Settings.IgnoreOptions["Fatigue"]) then
				-- Fatigue being ignored
				--GTFO_DebugPrint("Won't alert FATIGUE - Manually ignored");
				return;
			end
			GTFO_PlaySound(1);
		end
		return;
	end
	if (event == "CHAT_MSG_ADDON") then
		local msgPrefix, msgMessage, msgType, msgSender = ...;
		if (msgPrefix == "GTFO" and msgMessage and msgMessage ~= "") then
			local iSlash = string.find(msgMessage,":",1);
			if (iSlash) then
				local sCommand = string.sub(msgMessage,1,iSlash - 1);
				local sValue = string.sub(msgMessage,iSlash + 1);
				if (sCommand == "V" and sValue) then
					-- Version update received
					--GTFO_DebugPrint(msgSender.." sent version info '"..sValue.."' to "..msgType);
					if (not GTFO.Users[msgSender]) then
						GTFO_SendUpdate(msgType);
					end
					GTFO.Users[msgSender] = sValue;
					if ((tonumber(sValue) > GTFO.VersionNumber) and not GTFO.UpdateFound) then
						GTFO.UpdateFound = GTFO_ParseVersionNumber(sValue);
						if (not GTFO.Settings.NoVersionReminder) then
							GTFO_ChatPrint(string.format(GTFOLocal.Loading_OutOfDate, GTFO.UpdateFound));
						end
					end
					return;
				elseif (sCommand == "U" and sValue) then
					-- Version Request
					--GTFO_DebugPrint(msgSender.." requested update to "..sValue);
					GTFO_SendUpdate(sValue);
					return;
				end
			end
		end
		return;
	end
	if (event == "GROUP_ROSTER_UPDATE") then
		--GTFO_DebugPrint("Group roster was updated");
		local sentUpdate = nil;
		GTFO_ScanGroupGUID();
		local PartyMembers = GetNumSubgroupMembers();
		if (PartyMembers > GTFO.PartyMembers and GTFO.RaidMembers == 0) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				GTFO_SendUpdate("INSTANCE_CHAT");
			else
				GTFO_SendUpdate("PARTY");
			end
			sentUpdate = true;
		end
		GTFO.PartyMembers = PartyMembers;

		local RaidMembers = GetNumGroupMembers();		
		if (not IsInRaid()) then
			RaidMembers = 0
		end

		if (RaidMembers > GTFO.RaidMembers) then
			if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
				if (not sentUpdate) then
					GTFO_SendUpdate("INSTANCE_CHAT");
				end
			else
				GTFO_SendUpdate("RAID");
			end
		end
		GTFO.RaidMembers = RaidMembers;		
		return;
	end
	if (event == "UNIT_INVENTORY_CHANGED") then
		local msgUnit = ...;
		if (UnitIsUnit(msgUnit, "PLAYER")) then
			--GTFO_DebugPrint("Inventory changed, check tank mode");
			GTFO.TankMode = GTFO_CheckTankMode();
		end
		return;
	end
	if (event == "UPDATE_SHAPESHIFT_FORM") then
		--GTFO_DebugPrint("Form changed, check tank mode");
		GTFO.TankMode = GTFO_CheckTankMode();
		return;
	end
	if (event == "CHAT_MSG_MONSTER_YELL") then
		local msgBoss = ...;
		if (msgBoss == GTFOLocal.Boss_Nefarian_Phase2) then
			GTFO_AddEvent("NefarianIgnoreMagma", 17); -- 17 seconds from Nefarian's warning to getting on the pillar
		end
		return;
	end
	if (event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_TALENT_UPDATE") then
		--GTFO_DebugPrint("Spec changed, check tank/caster mode -- "..event);
		GTFO.TankMode = GTFO_CheckTankMode();
		GTFO.CasterMode = GTFO_CheckCasterMode();
		return;
	end
end

function GTFO_ScanGroupGUID()
	GTFO.GroupGUID = { };
	local partyMembers, raidMembers;
	raidMembers = GetNumGroupMembers();
	partyMembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidMembers = 0
	end
	if (raidMembers > 0) then
		for i = 1, raidMembers, 1 do
			if not (UnitIsUnit("raid"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("raid"..i));
			end;
		end
	end
	if (partyMembers > 0) then
		for i = 1, partyMembers, 1 do
			if not (UnitIsUnit("party"..i, "player")) then
				tinsert(GTFO.GroupGUID, UnitGUID("party"..i));
			end;
		end
	end
end

function GTFO_Command(arg1)
	local Command = string.upper(arg1);
	local DescriptionOffset = string.find(arg1,"%s",1);
	local Description = nil;
	
	if (DescriptionOffset) then
		Command = string.upper(string.sub(arg1, 1, DescriptionOffset - 1));
		Description = tostring(string.sub(arg1, DescriptionOffset + 1));
	end
	
	--GTFO_DebugPrint("Command executed: "..Command);
	
	if (Command == "OPTION" or Command == "OPTIONS") then
		GTFO_Command_Options();
	elseif (Command == "STANDBY") then
		GTFO_Command_Standby();
	elseif (Command == "DEBUG") then
		GTFO_Command_Debug();
	elseif (Command == "SCAN" or Command == "SCANNER") then
		GTFO_Command_ScanMode();
	elseif (Command == "ALERT") then
		GTFO_Command_AlertMode();
	elseif (Command == "TESTMODE") then
		GTFO_Command_TestMode();
	elseif (Command == "VERSION") then
		GTFO_Command_Version();
	elseif (Command == "TEST") then
		if (DescriptionOffset) then
			GTFO_Command_Test(tonumber(Description));
		else
			GTFO_Command_Test(1);
		end
	elseif (Command == "TEST1") then
		GTFO_Command_Test(1);
	elseif (Command == "TEST2") then
		GTFO_Command_Test(2);
	elseif (Command == "TEST3") then
		GTFO_Command_Test(3);
	elseif (Command == "TEST4") then
		GTFO_Command_Test(4);
	elseif (Command == "CUSTOM") then
		GTFO_Command_SetCustomSound(1, Description);
	elseif (Command == "CUSTOM1") then
		GTFO_Command_SetCustomSound(1, Description);
	elseif (Command == "CUSTOM2") then
		GTFO_Command_SetCustomSound(2, Description);
	elseif (Command == "CUSTOM3") then
		GTFO_Command_SetCustomSound(3, Description);
	elseif (Command == "CUSTOM4") then
		GTFO_Command_SetCustomSound(4, Description);
	elseif (Command == "NOVERSION") then
		GTFO_Command_VersionReminder();
	elseif (Command == "DATA") then
		GTFO_Command_Data();
	elseif (Command == "CLEAR") then
		GTFO_Command_ClearData();
	elseif (Command == "VIBRATE" or Command == "VIB") then
		GTFO_Command_Vibrate();
	elseif (Command == "HELP" or Command == "") then
		GTFO_Command_Help();
	elseif (Command == "BRANN") then
		GTFO_Command_BrannMode();
	elseif (Command == "IGNORE") then
		GTFO_Command_IgnoreSpell(Description);
	else
		GTFO_Command_Help();
	end
end

function GTFO_Command_Test(iSound)
	if (iSound == 1) then
		GTFO_PlaySound(1);
		if (GTFO.Settings.Sounds[1]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_High);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_HighMuted);		
		end
	elseif (iSound == 2) then
		GTFO_PlaySound(2);
		if (GTFO.Settings.Sounds[2]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Low);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_LowMuted);		
		end
	elseif (iSound == 3) then			
		GTFO_PlaySound(3);
		if (GTFO.Settings.Sounds[3]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_Fail);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FailMuted);		
		end
	elseif (iSound == 4) then			
		GTFO_PlaySound(4);
		if (GTFO.Settings.Sounds[4]) then
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFire);
		else
			GTFO_ChatPrint(GTFOLocal.TestSound_FriendlyFireMuted);		
		end
	end
end

function GTFO_Command_IgnoreSpell(iSpellId)
	if (GTFO.ClassicMode) then
		-- Classic doesn't use Spell IDs, so it's not supported
		GTFO_ErrorPrint(GTFOLocal.UI_NotSupported_Classic);		
		return;
	end
	
	local sCommand = tostring(iSpellId):lower();
	local spellId = tonumber(iSpellId) or 0;
	if (sCommand == "" or sCommand == "nil") then
		if (#GTFO.Settings.IgnoreSpellList > 0) then
			GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_List);
			for i, IgnoredSpellId in pairs(GTFO.Settings.IgnoreSpellList) do
				GTFO_ChatPrint("  "..IgnoredSpellId..": "..GTFO_GetSpellLink(IgnoredSpellId));
			end
		else
			GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_None);
		end
		GTFO_ChatPrint(GTFOLocal.UI_IgnoreSpell_Help);
	elseif (spellId > 0) then
		local spellLink = GTFO_GetSpellLink(spellId);
		if (tContains(GTFO.Settings.IgnoreSpellList, spellId)) then
			-- Remove spell ID
			for i, IgnoredSpellId in pairs(GTFO.Settings.IgnoreSpellList) do
				if (IgnoredSpellId == spellId) then
					tremove(GTFO.Settings.IgnoreSpellList, i);
					GTFO_ChatPrint(string.format(GTFOLocal.UI_IgnoreSpell_Remove,spellId,(spellLink or "")));
					GTFO_SaveSettings();
					return;
				end
			end
		else
			-- Add spell ID
			if (not spellLink) then
				GTFO_ErrorPrint(string.format(GTFOLocal.UI_IgnoreSpell_InvalidSpellId, spellId));	
				return;
			end
			tinsert(GTFO.Settings.IgnoreSpellList, spellId);
			GTFO_ChatPrint(string.format(GTFOLocal.UI_IgnoreSpell_Add,spellId,spellLink));
			GTFO_SaveSettings();
		end
	else
		GTFO_ErrorPrint("Invalid command.")
	end
end


function GTFO_Command_SetCustomSound(iSound, sSound)
	GTFO.Settings.SoundOverrides[iSound] = tostring(sSound or "");
	if (iSound == 1) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_HighReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_High));
			GTFO_SaveSettings();
			GTFO_Option_HighTest();
		end
	elseif (iSound == 2) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_LowReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_Low));
			GTFO_SaveSettings();
			GTFO_Option_LowTest();
		end
	elseif (iSound == 3) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_FailReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_Fail));
			GTFO_SaveSettings();
			GTFO_Option_FailTest();
		end
	elseif (iSound == 4) then
		if (GTFO.Settings.SoundOverrides[iSound] == "") then
			GTFO_Option_FriendlyFireReset();
		else
			GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Set, GTFOLocal.AlertType_FriendlyFire));
			GTFO_SaveSettings();
			GTFO_Option_FriendlyFireTest();
		end
	end
end

function GTFO_Command_Debug()
	if (GTFO.Settings.DebugMode) then
		GTFO.Settings.DebugMode = nil;
		GTFO_ChatPrint("Debug mode off.");
	else
		GTFO.Settings.DebugMode = true;
		GTFO_ChatPrint("Debug mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_ScanMode()
	if (GTFO.Settings.ScanMode) then
		GTFO.Settings.ScanMode = nil;
		GTFO_ChatPrint("Scan mode off.");
	else
		GTFO.Settings.ScanMode = true;
		GTFO_ChatPrint("Scan mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_AlertMode()
	if (GTFO.Settings.AlertMode) then
		GTFO.Settings.AlertMode = nil;
		GTFO_ChatPrint("Alert display mode off.");
	else
		GTFO.Settings.AlertMode = true;
		GTFO_ChatPrint("Alert display mode mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_TestMode()
	if (GTFO.Settings.TestMode) then
		GTFO.Settings.TestMode = nil;
		GTFO_ChatPrint("Test mode off.");
	else
		GTFO.Settings.TestMode = true;
		GTFO_ChatPrint("Test mode on.");
	end
	GTFO_SaveSettings();
end

function GTFO_Command_Standby()
	if (GTFO.Settings.Active) then
		GTFO.Settings.Active = nil;
		GTFO_ChatPrint(GTFOLocal.Active_Off);
	else
		GTFO.Settings.Active = true;
		GTFO_ChatPrint(GTFOLocal.Active_On);
	end
	GTFO_SaveSettings();
	GTFO_ActivateMod();
end

function GTFO_Command_Vibrate()
	if (GTFO.Settings.EnableVibration) then
		GTFO.Settings.EnableVibration = nil;
		GTFO_ChatPrint(GTFOLocal.Vibration_Off);
	else
		GTFO.Settings.EnableVibration = true;
		GTFO_ChatPrint(GTFOLocal.Vibration_On);
	end
	GTFO_SaveSettings();
end

function GTFO_Command_BrannMode()
	if (GTFO.Settings.BrannMode == 2 or not GTFO.Settings.BrannMode) then
		GTFO.Settings.BrannMode = 0;
		GTFO_ChatPrint(GTFOLocal.BrannMode_Off);
	elseif (GTFO.Settings.BrannMode == 1) then
		GTFO.Settings.BrannMode = 2;
		GTFO_ChatPrint(GTFOLocal.BrannMode_On);
	else
		GTFO.Settings.BrannMode = 1;
		GTFO_ChatPrint(GTFOLocal.BrannMode_OnWithDefault);
	end
	GTFO_SaveSettings();
end

function GTFO_Command_VersionReminder()
	if (GTFO.Settings.NoVersionReminder) then
		GTFO.Settings.NoVersionReminder = nil;
		GTFO_ChatPrint(GTFOLocal.Version_On);
	else
		GTFO.Settings.NoVersionReminder = true;
		GTFO_ChatPrint(GTFOLocal.Version_Off);
	end
	GTFO_SaveSettings();
end

function GTFO_OnLoad()
	GTFOFrame:RegisterEvent("VARIABLES_LOADED");
	GTFOFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
	GTFOFrame:RegisterEvent("CHAT_MSG_ADDON");
	GTFOFrame:RegisterEvent("MIRROR_TIMER_START");
	GTFOFrame:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	GTFOFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	SlashCmdList["GTFO"] = GTFO_Command;
	SLASH_GTFO1 = "/GTFO";
end

function GTFO_PlaySound(iSound, bOverride, bForceVibrate)
	if ((iSound or 0) == 0) then
		return;
	end
	
	local currentTime = GetTime();
	if (GTFO.IgnoreTime) then
		if (currentTime < GTFO.IgnoreTime) then
			return;
		end
	end
	GTFO.IgnoreTime = currentTime + (GTFO.Settings.IgnoreTimeAmount or GTFO.DefaultSettings.IgnoreTimeAmount);

	if (bOverride or GTFO.Settings.Sounds[iSound]) then
		local soundChannel = GTFO.Settings.SoundChannel;
		
		if (bOverride) then
			local channel = math.floor(getglobal("GTFO_ChannelIdSlider"):GetValue());
			soundChannel = GTFO.SoundChannels[channel].Code;
		end
		if (bOverride and getglobal("GTFO_UnmuteButton"):GetChecked()) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound], soundChannel);
		elseif (GTFO.Settings.UnmuteMode and GTFO.SoundTimes[iSound] and not bOverride) then
			GTFO_UnmuteSound(GTFO.SoundTimes[iSound], soundChannel);
		end
		
		local soundFile = tostring(GTFO.Settings.SoundOverrides[iSound] or "");
		local soundFile2 = "";
		local brannSound = (GTFO.Settings.BrannMode or 0) > 0;
		if (soundFile == "") then
			-- Sad, this only works if the dialog channel is unmuted, will need to investigate further
			if (brannSound and iSound == 1) then
				soundFile = GTFO.BrannModeSounds[1][math.random(#GTFO.BrannModeSounds[1])];
			elseif (brannSound and iSound == 3) then
				soundFile = GTFO.BrannModeSounds[2][math.random(#GTFO.BrannModeSounds[2])];
			else
				soundFile = GTFO.Sounds[iSound];
			end
			if (GTFO.Settings.BrannMode == 1) then
				soundFile2 = GTFO.Sounds[iSound];
			end
		end

		if (tonumber(soundFile) or 0 > 0) then
			GTFO_PlaySoundId(soundFile, soundChannel);
		else
			GTFO_PlaySoundFile(soundFile, soundChannel);
		end
		
		-- Play 2 times if the volume is at louder
		if (GTFO.Settings.Volume >= 4) then
			if (tonumber(soundFile) or 0 > 0) then
				GTFO_PlaySoundId(soundFile, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile, soundChannel);
			end
		end
		
		-- Play 3 times if the volume is at max
		if (GTFO.Settings.Volume >= 5) then
			if (tonumber(soundFile) or 0 > 0) then
				GTFO_PlaySoundId(soundFile, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile, soundChannel);
			end
		end
		
		-- Play secondary soundfile 
		if (soundFile2 ~= "") then
			if (tonumber(soundFile2) or 0 > 0) then
				GTFO_PlaySoundId(soundFile2, soundChannel);
			else
				GTFO_PlaySoundFile(soundFile2, soundChannel);
			end
			
			-- Play 2 times if the volume is at louder
			if (GTFO.Settings.Volume >= 4) then
				if (tonumber(soundFile2) or 0 > 0) then
					GTFO_PlaySoundId(soundFile2, soundChannel);
				else
					GTFO_PlaySoundFile(soundFile2, soundChannel);
				end
			end
			
			-- Play 3 times if the volume is at max
			if (GTFO.Settings.Volume >= 5) then
				if (tonumber(soundFile2) or 0 > 0) then
					GTFO_PlaySoundId(soundFile2, soundChannel);
				else
					GTFO_PlaySoundFile(soundFile2, soundChannel);
				end
			end
		end
	end
	GTFO_DisplayAura(iSound);
	if (bForceVibrate == true or (bForceVibrate == nil and GTFO.Settings.EnableVibration)) then
		GTFO_Vibrate(iSound);
	end
end

function GTFO_PlaySoundFile(sFile, sChannel)
	local willPlay, handle = PlaySoundFile(sFile, sChannel);
	if (willPlay) then
		-- Stop the sound automatically after 3 seconds in case someone trolls you with a 10 minute song
		GTFO_AddEvent("Sound"..handle, 3, function() StopSound(handle, 250); end);
	end
end

function GTFO_PlaySoundId(iSound, sChannel)
	local willPlay, handle = PlaySound(iSound, sChannel, false);
	if (willPlay) then
		-- Stop the sound automatically after 3 seconds in case someone trolls you with a 10 minute song
		GTFO_AddEvent("Sound"..handle, 3, function() StopSound(handle, 250); end);
	end
end

-- Play vibration
function GTFO_Vibrate(iSound)
	if (GTFO.VibrationTypes[iSound] and GTFO.VibrationIntensity[iSound] > 0) then
		C_GamePad.SetVibration(GTFO.VibrationTypes[iSound], GTFO.VibrationIntensity[iSound]);
	end
end

-- Create Addon Menu options and interface
function GTFO_RenderOptions()
	if (Settings and Settings.RegisterAddOnCategory) then
		-- TWW version (TWW)
		local ConfigurationPanel = CreateFrame("FRAME","GTFO_MainFrame");
		ConfigurationPanel.name = "GTFO";
		local category, layout = Settings.RegisterCanvasLayoutCategory(ConfigurationPanel, ConfigurationPanel.name);
		Settings.RegisterAddOnCategory(category);
		GTFO.SettingsCategoryId = category:GetID();

		local IntroMessageHeader = ConfigurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
		IntroMessageHeader:SetPoint("TOPLEFT", 10, -10);
		IntroMessageHeader:SetText("GTFO "..GTFO.Version);

		local EnabledButton = CreateFrame("CheckButton", "GTFO_EnabledButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		EnabledButton:SetPoint("TOPLEFT", 10, -35)
		EnabledButton.tooltip = GTFOLocal.UI_EnabledDescription;
		getglobal(EnabledButton:GetName().."Text"):SetText(GTFOLocal.UI_Enabled);
		EnabledButton.optionKey = "Enabled";
		EnabledButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local HighSoundButton = CreateFrame("CheckButton", "GTFO_HighSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		HighSoundButton:SetPoint("TOPLEFT", 10, -65)
		HighSoundButton.tooltip = GTFOLocal.UI_HighDamageDescription;
		getglobal(HighSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_HighDamage);
		HighSoundButton.optionKey = "HighSound";
		HighSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local LowSoundButton = CreateFrame("CheckButton", "GTFO_LowSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		LowSoundButton:SetPoint("TOPLEFT", 10, -95)
		LowSoundButton.tooltip = GTFOLocal.UI_LowDamageDescription;
		getglobal(LowSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_LowDamage);
		LowSoundButton.optionKey = "LowSound";
		LowSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local FailSoundButton = CreateFrame("CheckButton", "GTFO_FailSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		FailSoundButton:SetPoint("TOPLEFT", 10, -125)
		FailSoundButton.tooltip = GTFOLocal.UI_FailDescription;
		getglobal(FailSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_Fail);
		FailSoundButton.optionKey = "FailSound";
		FailSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local FriendlyFireSoundButton = CreateFrame("CheckButton", "GTFO_FriendlyFireSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		FriendlyFireSoundButton:SetPoint("TOPLEFT", 10, -155)
		FriendlyFireSoundButton.tooltip = GTFOLocal.UI_FriendlyFireDescription;
		getglobal(FriendlyFireSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_FriendlyFire);
		FriendlyFireSoundButton.optionKey = "FriendlyFireSound";
		FriendlyFireSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local HighTestButton = CreateFrame("Button", "GTFO_HighTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		HighTestButton:SetPoint("TOPLEFT", 300, -65);
		HighTestButton.tooltip = GTFOLocal.UI_TestDescription;
		HighTestButton:SetScript("OnClick",GTFO_Option_HighTest);
		getglobal(HighTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local LowTestButton = CreateFrame("Button", "GTFO_LowTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		LowTestButton:SetPoint("TOPLEFT", 300, -95);
		LowTestButton.tooltip = GTFOLocal.UI_TestDescription;
		LowTestButton:SetScript("OnClick",GTFO_Option_LowTest);
		getglobal(LowTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local FailTestButton = CreateFrame("Button", "GTFO_FailTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FailTestButton:SetPoint("TOPLEFT", 300, -125);
		FailTestButton.tooltip = GTFOLocal.UI_TestDescription;
		FailTestButton:SetScript("OnClick",GTFO_Option_FailTest);
		getglobal(FailTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local FriendlyFireTestButton = CreateFrame("Button", "GTFO_FriendlyFireTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FriendlyFireTestButton:SetPoint("TOPLEFT", 300, -155);
		FriendlyFireTestButton.tooltip = GTFOLocal.UI_TestDescription;
		FriendlyFireTestButton:SetScript("OnClick",GTFO_Option_FriendlyFireTest);
		getglobal(FriendlyFireTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local HighResetButton = CreateFrame("Button", "GTFO_HighResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		HighResetButton:SetPoint("TOPLEFT", 360, -65);
		HighResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		HighResetButton:SetScript("OnClick",GTFO_Option_HighReset);
		getglobal(HighResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local LowResetButton = CreateFrame("Button", "GTFO_LowResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		LowResetButton:SetPoint("TOPLEFT", 360, -95);
		LowResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		LowResetButton:SetScript("OnClick",GTFO_Option_LowReset);
		getglobal(LowResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local FailResetButton = CreateFrame("Button", "GTFO_FailResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FailResetButton:SetPoint("TOPLEFT", 360, -125);
		FailResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		FailResetButton:SetScript("OnClick",GTFO_Option_FailReset);
		getglobal(FailResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local FriendlyFireResetButton = CreateFrame("Button", "GTFO_FriendlyFireResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FriendlyFireResetButton:SetPoint("TOPLEFT", 360, -155);
		FriendlyFireResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		FriendlyFireResetButton:SetScript("OnClick",GTFO_Option_FriendlyFireReset);
		getglobal(FriendlyFireResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local VolumeText = ConfigurationPanel:CreateFontString("GTFO_VolumeText","ARTWORK","GameFontNormal");
		VolumeText:SetPoint("TOPLEFT", 170, -195);
		VolumeText:SetText("");

		local VolumeSlider = CreateFrame("Slider", "GTFO_VolumeSlider", ConfigurationPanel, "OptionsSliderTemplate");
		VolumeSlider:SetPoint("TOPLEFT", 12, -195);
		VolumeSlider.tooltip = GTFOLocal.UI_VolumeDescription;
		VolumeSlider:SetScript("OnValueChanged",GTFO_Option_SetVolume);
		if (getglobal(GTFO_VolumeSlider:GetName().."Text")) then
			getglobal(GTFO_VolumeSlider:GetName().."Text"):SetText(GTFOLocal.UI_Volume);
			getglobal(GTFO_VolumeSlider:GetName().."High"):SetText(GTFOLocal.UI_VolumeMax);
			getglobal(GTFO_VolumeSlider:GetName().."Low"):SetText(GTFOLocal.UI_VolumeMin);
		end
		VolumeSlider:SetMinMaxValues(1,5);
		VolumeSlider:SetValueStep(1);
		VolumeSlider:SetValue(GTFO.Settings.Volume);
		GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
		
		local UnmuteButton = CreateFrame("CheckButton", "GTFO_UnmuteButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		UnmuteButton:SetPoint("TOPLEFT", 10, -240)
		UnmuteButton.tooltip = GTFOLocal.UI_UnmuteDescription.."\n\n("..GTFOLocal.UI_UnmuteDescription2..")";
		getglobal(UnmuteButton:GetName().."Text"):SetText(GTFOLocal.UI_Unmute);
		UnmuteButton.optionKey = "Unmute";
		UnmuteButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local TrivialButton = CreateFrame("CheckButton", "GTFO_TrivialButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		TrivialButton:SetPoint("TOPLEFT", 10, -270)
		TrivialButton.tooltip = GTFOLocal.UI_TrivialDescription.."\n\n"..GTFOLocal.UI_TrivialDescription2;
		getglobal(TrivialButton:GetName().."Text"):SetText(GTFOLocal.UI_Trivial);
		TrivialButton.optionKey = "Trivial";
		TrivialButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local TrivialDamageText = ConfigurationPanel:CreateFontString("GTFO_TrivialDamageText","ARTWORK","GameFontNormal");
		TrivialDamageText:SetPoint("TOPLEFT", 450, -270);
		TrivialDamageText:SetText("");

		local TrivialDamageSlider = CreateFrame("Slider", "GTFO_TrivialDamageSlider", ConfigurationPanel, "OptionsSliderTemplate");
		TrivialDamageSlider:SetPoint("TOPLEFT", 300, -270);
		TrivialDamageSlider.tooltip = GTFOLocal.UI_TrivialSlider;
		TrivialDamageSlider:SetScript("OnValueChanged",GTFO_Option_SetTrivialDamage);
		if (getglobal(GTFO_TrivialDamageSlider:GetName().."Text")) then
			getglobal(GTFO_TrivialDamageSlider:GetName().."Text"):SetText(GTFOLocal.UI_TrivialSlider);
			getglobal(GTFO_TrivialDamageSlider:GetName().."High"):SetText(" ");
			getglobal(GTFO_TrivialDamageSlider:GetName().."Low"):SetText(" ");
		end
		TrivialDamageSlider:SetMinMaxValues(.5,10);
		TrivialDamageSlider:SetValueStep(.5);
		TrivialDamageSlider:SetValue(GTFO.Settings.TrivialDamagePercent);
		GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);

		local TestModeButton = CreateFrame("CheckButton", "GTFO_TestModeButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		TestModeButton:SetPoint("TOPLEFT", 10, -300)
		TestModeButton.tooltip = GTFOLocal.UI_TestModeDescription.."\n\n"..string.format(GTFOLocal.UI_TestModeDescription2,"zensunim","gmail","com");
		getglobal(TestModeButton:GetName().."Text"):SetText(GTFOLocal.UI_TestMode);
		TestModeButton.optionKey = "TestMode";
		TestModeButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local ChannelText = ConfigurationPanel:CreateFontString("GTFO_ChannelText","ARTWORK","GameFontNormal");
		ChannelText:SetPoint("TOPLEFT", 170, -350);
		ChannelText:SetText("");

		local ChannelIdSlider = CreateFrame("Slider", "GTFO_ChannelIdSlider", ConfigurationPanel, "OptionsSliderTemplate");
		ChannelIdSlider:SetPoint("TOPLEFT", 12, -350);
		ChannelIdSlider:SetScript("OnValueChanged",GTFO_Option_SetChannel);
		ChannelIdSlider:SetMinMaxValues(1,5);
		ChannelIdSlider:SetValueStep(1);
		ChannelIdSlider:SetValue(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
		if (getglobal(GTFO_ChannelIdSlider:GetName().."Text")) then
			getglobal(GTFO_ChannelIdSlider:GetName().."Text"):SetText(GTFOLocal.UI_SoundChannel);
			getglobal(GTFO_ChannelIdSlider:GetName().."High"):SetText(" ");
			getglobal(GTFO_ChannelIdSlider:GetName().."Low"):SetText(" ");
		end
		GTFO_Option_SetChannelIdText(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
		
		local VibrationButton = CreateFrame("CheckButton", "GTFO_VibrationButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		VibrationButton:SetPoint("TOPLEFT", 10, -380)
		VibrationButton.tooltip = GTFOLocal.UI_VibrationDescription;
		getglobal(VibrationButton:GetName().."Text"):SetText(GTFOLocal.UI_Vibration);
		VibrationButton.optionKey = "Vibration";
		VibrationButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local BrannModeText = ConfigurationPanel:CreateFontString("GTFO_BrannModeText","ARTWORK","GameFontNormal");
		BrannModeText:SetPoint("TOPLEFT", 170, -420);
		BrannModeText:SetText("");

		local BrannModeSlider = CreateFrame("Slider", "GTFO_BrannModeSlider", ConfigurationPanel, "OptionsSliderTemplate");
		BrannModeSlider:SetPoint("TOPLEFT", 12, -420);
		BrannModeSlider:SetScript("OnValueChanged",GTFO_Option_SetBrannMode);
		BrannModeSlider:SetMinMaxValues(0,2);
		BrannModeSlider:SetValueStep(1);
		BrannModeSlider:SetValue(GTFO.Settings.BrannMode or GTFO.DefaultSettings.BrannMode);
		BrannModeSlider.tooltip = GTFOLocal.UI_BrannModeDescription;
		BrannModeSlider:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
		end);
		BrannModeSlider:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);

		if (getglobal(GTFO_BrannModeSlider:GetName().."Text")) then
			getglobal(GTFO_BrannModeSlider:GetName().."Text"):SetText(GTFOLocal.UI_BrannMode);
			getglobal(GTFO_BrannModeSlider:GetName().."High"):SetText(" ");
			getglobal(GTFO_BrannModeSlider:GetName().."Low"):SetText(" ");
		end
		BrannModeText:SetText(GTFO_GetCurrentBrannMode(GTFO.Settings.BrannMode));

		local IgnoreTimeText = ConfigurationPanel:CreateFontString("GTFO_IgnoreTimeText","ARTWORK","GameFontNormal");
		IgnoreTimeText:SetPoint("TOPLEFT", 170, -460);
		IgnoreTimeText:SetText("");

		local IgnoreTimeSlider = CreateFrame("Slider", "GTFO_IgnoreTimeSlider", ConfigurationPanel, "OptionsSliderTemplate");
		IgnoreTimeSlider:SetPoint("TOPLEFT", 12, -460);
		IgnoreTimeSlider:SetScript("OnValueChanged",GTFO_Option_SetIgnoreTime);
		IgnoreTimeSlider:SetMinMaxValues(0,5);
		IgnoreTimeSlider:SetValueStep(0.1);
		IgnoreTimeSlider:SetValue(GTFO.Settings.IgnoreTimeAmount or GTFO.DefaultSettings.IgnoreTimeAmount);
		IgnoreTimeSlider.tooltip = GTFOLocal.UI_IgnoreTimeDescription;
		IgnoreTimeSlider:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetText(self.tooltip, nil, nil, nil, nil, true);
		end);
		IgnoreTimeSlider:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);
		
		if (getglobal(GTFO_IgnoreTimeSlider:GetName().."Text")) then
			getglobal(GTFO_IgnoreTimeSlider:GetName().."Text"):SetText(GTFOLocal.UI_IgnoreTime);
			getglobal(GTFO_IgnoreTimeSlider:GetName().."High"):SetText(" ");
			getglobal(GTFO_IgnoreTimeSlider:GetName().."Low"):SetText(" ");
		end
		IgnoreTimeText:SetText((GTFO.Settings.IgnoreTimeAmount or GTFO.DefaultSettings.IgnoreTimeAmount).." "..(GTFOLocal.UI_IgnoreTime_Seconds or ""));

		-- Special Alerts frame
		local IgnoreOptionsPanel = CreateFrame("FRAME","GTFO_IgnoreOptionsFrame");
		IgnoreOptionsPanel.name = GTFOLocal.UI_SpecialAlerts;
		IgnoreOptionsPanel.parent = ConfigurationPanel.name;
		local subcategory, layout = Settings.RegisterCanvasLayoutSubcategory(category, IgnoreOptionsPanel, IgnoreOptionsPanel.name);
		Settings.RegisterAddOnCategory(subcategory);
		GTFO.SettingsSpecialAlertsCategoryId = subcategory:GetID();

		local IntroMessageHeader2 = IgnoreOptionsPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
		IntroMessageHeader2:SetPoint("TOPLEFT", 10, -10);
		IntroMessageHeader2:SetText("GTFO "..GTFO.Version.." - "..GTFOLocal.UI_SpecialAlertsHeader);

		local yCount = -20;
		for key, option in pairs(GTFO.IgnoreSpellCategory) do
			if (GTFO.IgnoreSpellCategory[key].spellID) then
				yCount = yCount - 30;

				local IgnoreAlertButton = CreateFrame("CheckButton", "GTFO_IgnoreAlertButton_"..key, IgnoreOptionsPanel, "ChatConfigCheckButtonTemplate");
				IgnoreAlertButton:SetPoint("TOPLEFT", 10, yCount)
				getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
				if (GTFO.IgnoreSpellCategory[key].tooltip) then
					_G["GTFO_IgnoreAlertButton_"..key].tooltip = GTFO.IgnoreSpellCategory[key].tooltip;
				end
				IgnoreAlertButton.optionKey = "Ignore"..key;
				IgnoreAlertButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);
			end
		end

		GTFOSpellTooltip:ClearLines();
	else
		-- Dragonflight version
		local ConfigurationPanel = CreateFrame("FRAME","GTFO_MainFrame");
		ConfigurationPanel.name = "GTFO";
		InterfaceOptions_AddCategory(ConfigurationPanel);

		local IntroMessageHeader = ConfigurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
		IntroMessageHeader:SetPoint("TOPLEFT", 10, -10);
		IntroMessageHeader:SetText("GTFO "..GTFO.Version);

		local EnabledButton = CreateFrame("CheckButton", "GTFO_EnabledButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		EnabledButton:SetPoint("TOPLEFT", 10, -35)
		EnabledButton.tooltip = GTFOLocal.UI_EnabledDescription;
		getglobal(EnabledButton:GetName().."Text"):SetText(GTFOLocal.UI_Enabled);
		EnabledButton.optionKey = "Enabled";
		EnabledButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local HighSoundButton = CreateFrame("CheckButton", "GTFO_HighSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		HighSoundButton:SetPoint("TOPLEFT", 10, -65)
		HighSoundButton.tooltip = GTFOLocal.UI_HighDamageDescription;
		getglobal(HighSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_HighDamage);
		HighSoundButton.optionKey = "HighSound";
		HighSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local LowSoundButton = CreateFrame("CheckButton", "GTFO_LowSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		LowSoundButton:SetPoint("TOPLEFT", 10, -95)
		LowSoundButton.tooltip = GTFOLocal.UI_LowDamageDescription;
		getglobal(LowSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_LowDamage);
		LowSoundButton.optionKey = "LowSound";
		LowSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local FailSoundButton = CreateFrame("CheckButton", "GTFO_FailSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		FailSoundButton:SetPoint("TOPLEFT", 10, -125)
		FailSoundButton.tooltip = GTFOLocal.UI_FailDescription;
		getglobal(FailSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_Fail);
		FailSoundButton.optionKey = "FailSound";
		FailSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local FriendlyFireSoundButton = CreateFrame("CheckButton", "GTFO_FriendlyFireSoundButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		FriendlyFireSoundButton:SetPoint("TOPLEFT", 10, -155)
		FriendlyFireSoundButton.tooltip = GTFOLocal.UI_FriendlyFireDescription;
		getglobal(FriendlyFireSoundButton:GetName().."Text"):SetText(GTFOLocal.UI_FriendlyFire);
		FriendlyFireSoundButton.optionKey = "FriendlyFireSound";
		FriendlyFireSoundButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local HighTestButton = CreateFrame("Button", "GTFO_HighTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		HighTestButton:SetPoint("TOPLEFT", 300, -65);
		HighTestButton.tooltip = GTFOLocal.UI_TestDescription;
		HighTestButton:SetScript("OnClick",GTFO_Option_HighTest);
		getglobal(HighTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local LowTestButton = CreateFrame("Button", "GTFO_LowTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		LowTestButton:SetPoint("TOPLEFT", 300, -95);
		LowTestButton.tooltip = GTFOLocal.UI_TestDescription;
		LowTestButton:SetScript("OnClick",GTFO_Option_LowTest);
		getglobal(LowTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local FailTestButton = CreateFrame("Button", "GTFO_FailTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FailTestButton:SetPoint("TOPLEFT", 300, -125);
		FailTestButton.tooltip = GTFOLocal.UI_TestDescription;
		FailTestButton:SetScript("OnClick",GTFO_Option_FailTest);
		getglobal(FailTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local FriendlyFireTestButton = CreateFrame("Button", "GTFO_FriendlyFireTestButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FriendlyFireTestButton:SetPoint("TOPLEFT", 300, -155);
		FriendlyFireTestButton.tooltip = GTFOLocal.UI_TestDescription;
		FriendlyFireTestButton:SetScript("OnClick",GTFO_Option_FriendlyFireTest);
		getglobal(FriendlyFireTestButton:GetName().."Text"):SetText(GTFOLocal.UI_Test);

		local HighResetButton = CreateFrame("Button", "GTFO_HighResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		HighResetButton:SetPoint("TOPLEFT", 360, -65);
		HighResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		HighResetButton:SetScript("OnClick",GTFO_Option_HighReset);
		getglobal(HighResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local LowResetButton = CreateFrame("Button", "GTFO_LowResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		LowResetButton:SetPoint("TOPLEFT", 360, -95);
		LowResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		LowResetButton:SetScript("OnClick",GTFO_Option_LowReset);
		getglobal(LowResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local FailResetButton = CreateFrame("Button", "GTFO_FailResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FailResetButton:SetPoint("TOPLEFT", 360, -125);
		FailResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		FailResetButton:SetScript("OnClick",GTFO_Option_FailReset);
		getglobal(FailResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local FriendlyFireResetButton = CreateFrame("Button", "GTFO_FriendlyFireResetButton", ConfigurationPanel, "UIPanelButtonTemplate");
		FriendlyFireResetButton:SetPoint("TOPLEFT", 360, -155);
		FriendlyFireResetButton.tooltip = GTFOLocal.UI_ResetCustomSounds;
		FriendlyFireResetButton:SetScript("OnClick",GTFO_Option_FriendlyFireReset);
		getglobal(FriendlyFireResetButton:GetName().."Text"):SetText(GTFOLocal.UI_Reset);

		local VolumeText = ConfigurationPanel:CreateFontString("GTFO_VolumeText","ARTWORK","GameFontNormal");
		VolumeText:SetPoint("TOPLEFT", 170, -195);
		VolumeText:SetText("");

		local VolumeSlider = CreateFrame("Slider", "GTFO_VolumeSlider", ConfigurationPanel, "OptionsSliderTemplate");
		VolumeSlider:SetPoint("TOPLEFT", 12, -195);
		VolumeSlider.tooltip = GTFOLocal.UI_VolumeDescription;
		VolumeSlider:SetScript("OnValueChanged",GTFO_Option_SetVolume);
		getglobal(GTFO_VolumeSlider:GetName().."Text"):SetText(GTFOLocal.UI_Volume);
		getglobal(GTFO_VolumeSlider:GetName().."High"):SetText(GTFOLocal.UI_VolumeMax);
		getglobal(GTFO_VolumeSlider:GetName().."Low"):SetText(GTFOLocal.UI_VolumeMin);
		VolumeSlider:SetMinMaxValues(1,5);
		VolumeSlider:SetValueStep(1);
		VolumeSlider:SetValue(GTFO.Settings.Volume);
		GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
		
		local UnmuteButton = CreateFrame("CheckButton", "GTFO_UnmuteButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		UnmuteButton:SetPoint("TOPLEFT", 10, -240)
		UnmuteButton.tooltip = GTFOLocal.UI_UnmuteDescription.."\n\n("..GTFOLocal.UI_UnmuteDescription2..")";
		getglobal(UnmuteButton:GetName().."Text"):SetText(GTFOLocal.UI_Unmute);
		UnmuteButton.optionKey = "Unmute";
		UnmuteButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local TrivialButton = CreateFrame("CheckButton", "GTFO_TrivialButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		TrivialButton:SetPoint("TOPLEFT", 10, -270)
		TrivialButton.tooltip = GTFOLocal.UI_TrivialDescription.."\n\n"..GTFOLocal.UI_TrivialDescription2;
		getglobal(TrivialButton:GetName().."Text"):SetText(GTFOLocal.UI_Trivial);
		TrivialButton.optionKey = "Trivial";
		TrivialButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local TrivialDamageText = ConfigurationPanel:CreateFontString("GTFO_TrivialDamageText","ARTWORK","GameFontNormal");
		TrivialDamageText:SetPoint("TOPLEFT", 450, -270);
		TrivialDamageText:SetText("");

		local TrivialDamageSlider = CreateFrame("Slider", "GTFO_TrivialDamageSlider", ConfigurationPanel, "OptionsSliderTemplate");
		TrivialDamageSlider:SetPoint("TOPLEFT", 300, -270);
		TrivialDamageSlider.tooltip = GTFOLocal.UI_TrivialSlider;
		TrivialDamageSlider:SetScript("OnValueChanged",GTFO_Option_SetTrivialDamage);
		getglobal(GTFO_TrivialDamageSlider:GetName().."Text"):SetText(GTFOLocal.UI_TrivialSlider);
		getglobal(GTFO_TrivialDamageSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_TrivialDamageSlider:GetName().."Low"):SetText(" ");
		TrivialDamageSlider:SetMinMaxValues(.5,10);
		TrivialDamageSlider:SetValueStep(.5);
		TrivialDamageSlider:SetValue(GTFO.Settings.TrivialDamagePercent);
		GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);

		local TestModeButton = CreateFrame("CheckButton", "GTFO_TestModeButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		TestModeButton:SetPoint("TOPLEFT", 10, -300)
		TestModeButton.tooltip = GTFOLocal.UI_TestModeDescription.."\n\n"..string.format(GTFOLocal.UI_TestModeDescription2,"zensunim","gmail","com");
		getglobal(TestModeButton:GetName().."Text"):SetText(GTFOLocal.UI_TestMode);
		TestModeButton.optionKey = "TestMode";
		TestModeButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		local ChannelText = ConfigurationPanel:CreateFontString("GTFO_ChannelText","ARTWORK","GameFontNormal");
		ChannelText:SetPoint("TOPLEFT", 170, -350);
		ChannelText:SetText("");

		local ChannelIdSlider = CreateFrame("Slider", "GTFO_ChannelIdSlider", ConfigurationPanel, "OptionsSliderTemplate");
		ChannelIdSlider:SetPoint("TOPLEFT", 12, -350);
		ChannelIdSlider:SetScript("OnValueChanged",GTFO_Option_SetChannel);
		ChannelIdSlider:SetMinMaxValues(1,5);
		ChannelIdSlider:SetValueStep(1);
		ChannelIdSlider:SetValue(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
		getglobal(GTFO_ChannelIdSlider:GetName().."Text"):SetText(GTFOLocal.UI_SoundChannel);
		getglobal(GTFO_ChannelIdSlider:GetName().."High"):SetText(" ");
		getglobal(GTFO_ChannelIdSlider:GetName().."Low"):SetText(" ");
		GTFO_Option_SetChannelIdText(GTFO_GetCurrentSoundChannelId(GTFO.Settings.SoundChannel));
		
		local VibrationButton = CreateFrame("CheckButton", "GTFO_VibrationButton", ConfigurationPanel, "ChatConfigCheckButtonTemplate");
		VibrationButton:SetPoint("TOPLEFT", 10, -380)
		VibrationButton.tooltip = GTFOLocal.UI_VibrationDescription;
		getglobal(VibrationButton:GetName().."Text"):SetText(GTFOLocal.UI_Vibration);
		VibrationButton.optionKey = "Vibration";
		VibrationButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);

		-- Special Alerts frame
		local IgnoreOptionsPanel = CreateFrame("FRAME","GTFO_IgnoreOptionsFrame");
		IgnoreOptionsPanel.name = GTFOLocal.UI_SpecialAlerts;
		IgnoreOptionsPanel.parent = ConfigurationPanel.name;
		InterfaceOptions_AddCategory(IgnoreOptionsPanel);

		local IntroMessageHeader2 = IgnoreOptionsPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge");
		IntroMessageHeader2:SetPoint("TOPLEFT", 10, -10);
		IntroMessageHeader2:SetText("GTFO "..GTFO.Version.." - "..GTFOLocal.UI_SpecialAlertsHeader);

		local yCount = -20;
		for key, option in pairs(GTFO.IgnoreSpellCategory) do
			if (GTFO.IgnoreSpellCategory[key].spellID) then
				yCount = yCount - 30;

				local IgnoreAlertButton = CreateFrame("CheckButton", "GTFO_IgnoreAlertButton_"..key, IgnoreOptionsPanel, "ChatConfigCheckButtonTemplate");
				IgnoreAlertButton:SetPoint("TOPLEFT", 10, yCount)
				getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
				if (GTFO.IgnoreSpellCategory[key].tooltip) then
					_G["GTFO_IgnoreAlertButton_"..key].tooltip = GTFO.IgnoreSpellCategory[key].tooltip;
				end
				IgnoreAlertButton.optionKey = "Ignore"..key;
				IgnoreAlertButton:SetScript("OnClick", GTFO.ToggleCheckboxOption);
			end
		end

		GTFOSpellTooltip:ClearLines();
	end

	if (AddonCompartmentFrame) then
		AddonCompartmentFrame:RegisterAddon({
			text = "GTFO",
			icon = "Interface\\Icons\\spell_fire_fire.blp",
			notCheckable = true,
			func = function(button, menuInputData, menu)
				Settings.OpenToCategory(GTFO.SettingsCategoryId);
			end,
			funcOnEnter = function(button)
				MenuUtil.ShowTooltip(button, function(tooltip)
					tooltip:SetText("GTFO "..GTFO.Version);
					tooltip:AddLine("|cFFFFFFFF"..GTFOLocal.Help_Options.."|r");
				end)
			end,
			funcOnLeave = function(button)
				MenuUtil.HideTooltip(button)
			end,
		});
	end

	GTFO.UIRendered = true;
end

function GTFO.ToggleCheckboxOption(self)
	local checked = self:GetChecked();
	local optionKey = self.optionKey;

	if (optionKey == "Enabled") then
		GTFO.Settings.Active = checked;
	elseif (optionKey == "HighSound") then
		GTFO.Settings.Sounds[1] = checked;
	elseif (optionKey == "LowSound") then
		GTFO.Settings.Sounds[2] = checked;
	elseif (optionKey == "FailSound") then
		GTFO.Settings.Sounds[3] = checked;
	elseif (optionKey == "FriendlyFireSound") then
		GTFO.Settings.Sounds[4] = checked;
	elseif (optionKey == "TestMode") then
		GTFO.Settings.TestMode = checked;
	elseif (optionKey == "Unmute") then
		GTFO.Settings.UnmuteMode = checked;
	elseif (optionKey == "Trivial") then
		GTFO.Settings.TrivialMode = checked;
	elseif (optionKey == "Vibration") then
		GTFO.Settings.EnableVibration = checked;
	end
	
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (optionKey == "Ignore"..key) then
			GTFO.Settings.IgnoreOptions[key] = not checked;
		end
	end
	
	GTFO_SaveSettings();
end

function GTFO_RefreshOptions()
	-- Spell info isn't available right away, so do this after loading
	for key, option in pairs(GTFO.IgnoreSpellCategory) do
		if (GTFO.IgnoreSpellCategory[key].spellID and not (GetLocale() == "enUS" and GTFO.IgnoreSpellCategory[key].override)) then
			local IgnoreAlertButton = _G["GTFO_IgnoreAlertButton_"..key];
			if (IgnoreAlertButton) then
				local spellID = GTFO.IgnoreSpellCategory[key].spellID;
				local spellName = GTFO_GetSpellName(spellID);
				if (spellName) then
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(spellName);
				
					GTFOSpellTooltip:SetOwner(_G["GTFOFrame"],"ANCHOR_NONE");
					GTFOSpellTooltip:ClearLines();
					if (not GTFO.ClassicMode) then
						GTFOSpellTooltip:SetHyperlink(GTFO_GetSpellLink(spellID));
					end
					local tooltipText = tostring(getglobal("GTFOSpellTooltipTextLeft1"):GetText());
					if (GTFOSpellTooltip:NumLines()) then
						if (getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines()))) then
							tooltipText = tooltipText.."\n"..tostring(getglobal("GTFOSpellTooltipTextLeft"..tostring(GTFOSpellTooltip:NumLines())):GetText());
						end
					end
					IgnoreAlertButton.tooltip = tooltipText;
				else
					getglobal(IgnoreAlertButton:GetName().."Text"):SetText(GTFO.IgnoreSpellCategory[key].desc);
				end
			end
		end
	end
end

function GTFO_ActivateMod()
	if (GTFO.Settings.Active) then
		GTFOFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		GTFOFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end	
end

-- Event handling
function GTFO_OnUpdate()
	local currentTime = GetTime();
	
	if (#GTFO.Events > 0) then
		for index, event in pairs(GTFO.Events) do
			if (currentTime > event.ExecuteTime) then
				if (event.Code) then
					event:Code();
				end
				if (event.Repeat > 0) then
					event.ExecuteTime = currentTime + event.Repeat;
					--GTFO_DebugPrint("Repeating event #"..index.." for "..event.Repeat.." seconds.");
				else
					--GTFO_DebugPrint("Removing event #"..index.." - "..event.Name);
					tremove(GTFO.Events, index);
				end				
			end
		end
	end
	
	-- Check for GTFO events
	if (#GTFO.Events <= 0) then
		GTFOFrame:SetScript("OnUpdate", nil);
		--GTFO_DebugPrint("Event update checking disabled.");
	end	
end

function GTFO_UnmuteSound(delayTime, soundChannel)
	if (not GTFO_FindEvent("Mute")) then
		GTFO.SoundSettings.EnableAllSound = GetCVar("Sound_EnableAllSound");
		GTFO.SoundSettings.SecondaryCVar = GTFO_GetSoundChannelCVar(soundChannel);
		if (GTFO.SoundSettings.SecondaryCVar) then
			GTFO.SoundSettings.EnableSecondary = GetCVar(GTFO.SoundSettings.SecondaryCVar);
			SetCVar(GTFO.SoundSettings.SecondaryCVar, 1);
		end
		SetCVar("Sound_EnableAllSound", 1);
		--GTFO_DebugPrint("Temporarily unmuting volume for "..delayTime.. " seconds.");
	end
	GTFO_AddEvent("Mute", delayTime, function() GTFO_MuteSound(); end);
end

function GTFO_MuteSound()
	SetCVar("Sound_EnableAllSound", GTFO.SoundSettings.EnableAllSound);
	if (GTFO.SoundSettings.SecondaryCVar) then
		SetCVar(GTFO.SoundSettings.SecondaryCVar, GTFO.SoundSettings.EnableSecondary);
	end
	--GTFO_DebugPrint("Muting sound again.");
end

function GTFO_Command_Help()
	DEFAULT_CHAT_FRAME:AddMessage("[GTFO] "..string.format(GTFOLocal.Help_Intro, GTFO.Version), 0.25, 1.0, 0.25);
	if not (GTFO.Settings.Active) then
		DEFAULT_CHAT_FRAME:AddMessage(GTFOLocal.Help_Suspended, 1.0, 0.1, 0.1);		
	end
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo options|r -- "..GTFOLocal.Help_Options, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo standby|r -- "..GTFOLocal.Help_Suspend, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo version|r -- "..GTFOLocal.Help_Version, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test|r -- "..GTFOLocal.Help_TestHigh, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test2|r -- "..GTFOLocal.Help_TestLow, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test3|r -- "..GTFOLocal.Help_TestFail, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo test4|r -- "..GTFOLocal.Help_TestFriendlyFire, 0.25, 1.0, 0.75);
	DEFAULT_CHAT_FRAME:AddMessage("|cFFEEEE00/gtfo ignore|r -- "..GTFOLocal.Help_IgnoreSpell, 0.25, 1.0, 0.75);
end

function GTFO_Option_HighTest()
	GTFO_PlaySound(1, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_LowTest()
	GTFO_PlaySound(2, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_FailTest()
	GTFO_PlaySound(3, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_FriendlyFireTest()
	GTFO_PlaySound(4, true, getglobal("GTFO_VibrationButton"):GetChecked());
end

function GTFO_Option_HighReset()
	GTFO.Settings.SoundOverrides[1] = "";
	GTFO_SaveSettings();
	GTFO_Option_HighTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_High));
end

function GTFO_Option_LowReset()
	GTFO.Settings.SoundOverrides[2] = "";
	GTFO_SaveSettings();
	GTFO_Option_LowTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_Low));
end

function GTFO_Option_FailReset()
	GTFO.Settings.SoundOverrides[3] = "";
	GTFO_SaveSettings();
	GTFO_Option_FailTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_Fail));
end

function GTFO_Option_FriendlyFireReset()
	GTFO.Settings.SoundOverrides[4] = "";
	GTFO_SaveSettings();
	GTFO_Option_FriendlyFireTest();
	GTFO_ChatPrint(string.format(GTFOLocal.UI_CustomSounds_Removed, GTFOLocal.AlertType_FriendlyFire));
end

-- Get a list of all the people in your group/raid using GTFO and their version numbers
function GTFO_Command_Version()
	GTFO_SendUpdateRequest();
	local partymembers, raidmembers;

	partymembers = GetNumSubgroupMembers();
	raidmembers = GetNumGroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end

	local users = 0;

	if (raidmembers > 0 or partymembers > 0) then
		if (raidmembers > 0) then
			for i = 1, raidmembers, 1 do
				local displayName;
				local name, server = UnitName("raid"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server;
					displayName = fullname;
				else
					fullname = name.."-"..GTFO_GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_RaidMembers, users, raidmembers));
		elseif (partymembers > 0) then
			GTFO_ChatPrint(UnitName("player")..": "..GTFO_ParseVersionColor(GTFO.VersionNumber));
			users = 1;
			for i = 1, partymembers, 1 do
				local displayName;
				local name, server = UnitName("party"..i);
				local fullname = name;
				if (server and server ~= "") then
					fullname = name.."-"..server
					displayName = fullname;
				else
					fullname = name.."-"..GTFO_GetRealmName()
					displayName = name;
				end
				if (GTFO.Users[fullname]) then
					GTFO_ChatPrint(displayName..": "..GTFO_ParseVersionColor(GTFO.Users[fullname]));
					users = users + 1;
				else
					GTFO_ChatPrint(displayName..": |cFF999999"..GTFOLocal.Group_None.."|r");
				end
			end
			GTFO_ChatPrint(string.format(GTFOLocal.Group_PartyMembers, users, (partymembers + 1)));
		end
	else
		GTFO_ErrorPrint(GTFOLocal.Group_NotInGroup);
	end		
end

function GTFO_ParseVersionColor(iVersionNumber)
	local Color = "";
	if (GTFO.VersionNumber < iVersionNumber * 1) then
		Color = "|cFFFFFF00"
	elseif (GTFO.VersionNumber == iVersionNumber * 1) then
		Color = "|cFFFFFFFF"
	else
		Color = "|cFFAAAAAA"
	end
	return Color..GTFO_ParseVersionNumber(iVersionNumber).."|r"
end

function GTFO_ParseVersionNumber(iVersionNumber)
	local sVersion = "";
	local iMajor = math.floor(iVersionNumber * 0.0001);
	local iMinor = math.floor((iVersionNumber - (iMajor * 10000)) * 0.01)
	local iMinor2 = iVersionNumber - (iMajor * 10000) - (iMinor * 100)
	if (iMinor2 > 0) then
		sVersion = iMajor.."."..iMinor.."."..iMinor2
	else
		sVersion = iMajor.."."..iMinor
	end
	return sVersion;
end

function GTFO_SendUpdate(sMethod)
	if not (sMethod == "PARTY" or sMethod == "RAID" or sMethod == "INSTANCE_CHAT") then
		return;
	end
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateTime) then
		if (currentTime < GTFO.IgnoreUpdateTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateTime = currentTime + GTFO.IgnoreUpdateTimeAmount;

	--GTFO_DebugPrint("Sending version info to "..sMethod);
	C_ChatInfo.SendAddonMessage("GTFO","V:"..GTFO.VersionNumber,sMethod)
end

function GTFO_SendUpdateRequest()
	local currentTime = GetTime();
	if (GTFO.IgnoreUpdateRequestTime) then
		if (currentTime < GTFO.IgnoreUpdateRequestTime) then
			return;
		end
	end
	GTFO.IgnoreUpdateRequestTime = currentTime + GTFO.IgnoreUpdateRequestTimeAmount;

	raidmembers = GetNumGroupMembers();
	partymembers = GetNumSubgroupMembers();
	if (not IsInRaid()) then
		raidmembers = 0
	end
	
	if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
		C_ChatInfo.SendAddonMessage("GTFO","U:INSTANCE_CHAT","INSTANCE_CHAT");
	elseif (raidmembers > 0) then
		C_ChatInfo.SendAddonMessage("GTFO","U:RAID","RAID");
	elseif (partymembers > 0) then
		C_ChatInfo.SendAddonMessage("GTFO","U:PARTY","PARTY");
	end
end

function GTFO_Command_Options()
	if (Settings and Settings.OpenToCategory) then
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
		Settings.OpenToCategory(GTFO.SettingsCategoryId);
	else
		InterfaceOptionsFrame_OpenToCategory("GTFO");
		InterfaceOptionsFrame_OpenToCategory("GTFO");
		InterfaceOptionsFrame_OpenToCategory("GTFO");	
	end
end

function GTFO_Option_SetVolume()
	if (not GTFO.UIRendered) then
		return;
	end
	GTFO.Settings.Volume = math.floor(getglobal("GTFO_VolumeSlider"):GetValue());
	getglobal("GTFO_VolumeSlider"):SetValue(GTFO.Settings.Volume);
	GTFO_GetSounds();
	GTFO_Option_SetVolumeText(GTFO.Settings.Volume);
	GTFO_SaveSettings();
end

function GTFO_Option_SetVolumeText(iVolume)
	if (iVolume == 1) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeQuiet);
	elseif (iVolume == 2) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeSoft);
	elseif (iVolume == 4) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLoud);
	elseif (iVolume == 5) then
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeLouder);
	elseif (iVolume > 5) then
		getglobal("GTFO_VolumeText"):SetText(iVolume);
	else
		getglobal("GTFO_VolumeText"):SetText(GTFOLocal.UI_VolumeNormal);
	end
end

function GTFO_Option_SetChannelIdText(iChannelId)
	getglobal("GTFO_ChannelText"):SetText(GTFO.SoundChannels[iChannelId].Name);
end

function GTFO_Option_SetTrivialDamage()
	if (not GTFO.UIRendered) then
		return;
	end
	GTFO.Settings.TrivialDamagePercent = math.floor(getglobal("GTFO_TrivialDamageSlider"):GetValue() * 10)/10;
	getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.Settings.TrivialDamagePercent);
	GTFO_GetSounds();
	GTFO_Option_SetTrivialDamageText(GTFO.Settings.TrivialDamagePercent);
	GTFO_SaveSettings();
end

function GTFO_Option_SetChannel()
	if (not GTFO.UIRendered) then
		return;
	end
	local channelId = math.floor(getglobal("GTFO_ChannelIdSlider"):GetValue());
	GTFO.Settings.SoundChannel = GTFO.SoundChannels[channelId].Code;
	getglobal("GTFO_ChannelIdSlider"):SetValue(channelId);
	GTFO_Option_SetChannelIdText(channelId);
	GTFO_SaveSettings();
end

function GTFO_Option_SetBrannMode()
	if (not GTFO.UIRendered) then
		return;
	end
	local brannMode = math.floor(getglobal("GTFO_BrannModeSlider"):GetValue());
	GTFO.Settings.BrannMode = brannMode;
	getglobal("GTFO_BrannModeSlider"):SetValue(brannMode);
	getglobal("GTFO_BrannModeText"):SetText(GTFO_GetCurrentBrannMode(GTFO.Settings.BrannMode));
	GTFO_SaveSettings();
end

function GTFO_Option_SetIgnoreTime()
	if (not GTFO.UIRendered) then
		return;
	end
	local ignoreTime = math.floor(getglobal("GTFO_IgnoreTimeSlider"):GetValue() * 10)/10;
	GTFO.Settings.IgnoreTimeAmount = ignoreTime;
	getglobal("GTFO_IgnoreTimeSlider"):SetValue(ignoreTime);
	getglobal("GTFO_IgnoreTimeText"):SetText(GTFO.Settings.IgnoreTimeAmount.." "..(GTFOLocal.UI_IgnoreTime_Seconds or ""));
	GTFO_SaveSettings();
end

function GTFO_Option_SetTrivialDamageText(iTrivialDamagePercent)
	if (not GTFO.UIRendered) then
		return;
	end
	getglobal("GTFO_TrivialDamageText"):SetText(iTrivialDamagePercent.."%");
end

-- Detect if the player is tanking or not
function GTFO_CheckTankMode()
	if (GTFO.CanTank) then
		if (GTFO.PlayerClass == "DRUID") then
			local stance = GetShapeshiftForm();
			if (stance == 1) then
				--GTFO_DebugPrint("Bear Form found - tank mode activated");
				return true;
			end
		elseif ((not (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode)) and (GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER" or GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "DEATHKNIGHT" or GTFO.PlayerClass == "PALADIN")) then
			-- Get the exact specialization role as defined by the class
			local spec = GTFO_GetSpecIndex();
			if (spec and GTFO_GetSpecRole(spec) == "TANK") then
				--GTFO_DebugPrint("Tank spec found - tank mode activated");
				return true;
			end
		elseif ((GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) and (GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "PALADIN" or GTFO.PlayerClass == "DEATHKNIGHT")) then
			GTFO.CanTank = true;
		else
			--GTFO_DebugPrint("Failed Tank Mode - This code shouldn't have ran");
			GTFO.CanTank = nil;
		end
	end
	--GTFO_DebugPrint("Tank mode off");
	return nil;
end

function GTFO_CheckCasterMode()
	if (GTFO.CanCast) then
		if (GTFO.PlayerClass == "PRIEST" or GTFO.PlayerClass == "MAGE" or GTFO.PlayerClass == "WARLOCK" or GTFO.PlayerClass == "EVOKER") then
			return true;
		end

		if not (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) then
			-- Get the exact specialization role as defined by the class
			local spec = GTFO_GetSpecIndex();
			if (spec) then
				local role = GTFO_GetSpecRole(spec);
				if (role == "TANK") then
					return nil;
				end
				if (role == "HEALER") then
					return true;
				end
			
				local id, _ = GTFO_GetSpecRole(spec);
				if (id == 102) then
					-- Balance Druid
					return true;
				end
				if (id == 262) then
					-- Elemental Shaman
					return true;
				end
			end
		else
			if (GTFO.PlayerClass == "DRUID" or GTFO.PlayerClass == "PALADIN" or GTFO.PlayerClass == "SHAMAN") then
				-- Classic Detection (check for caster mode)
				return true;
			end
		end
	end
	--GTFO_DebugPrint("Caster mode off");
	return nil;
end

function GTFO_IsTank()
	if (GTFO_CanTankCheck()) then
		if (GTFO.PlayerClass == "PALADIN") then
			-- Check for Righteous Fury (Classic)
			if (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) then
				return GTFO_HasBuff("player", 25780);
			end
			
			-- Backup check (removed in retail)
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		elseif (GTFO.PlayerClass == "DRUID") then
			-- Check for Bear Form
			return GTFO_HasBuff("player", 5487);
		elseif (GTFO.PlayerClass == "DEATHKNIGHT") then
			-- Check for Frost Presence (Wrath Classic)
			if (GTFO.WrathMode or GTFO.CataclysmMode) then
				return GTFO_HasBuff("player", 48263);
			end
			
			-- Backup check (removed in retail)
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		elseif (GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER" or GTFO.PlayerClass == "DEATHKNIGHT") then
			-- No definitive way to determine...take a guess.
			if (UnitGroupRolesAssigned("player") == "TANK" or GetPartyAssignment("MAINTANK", "player")) then
				return true;
			end
		end	
	end
	return;
end

function GTFO_CanTankCheck()
	if (GTFO.PlayerClass == "PALADIN" or GTFO.PlayerClass == "DRUID" or GTFO.PlayerClass == "DEATHKNIGHT" or GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "MONK" or GTFO.PlayerClass == "DEMONHUNTER") then
		----GTFO_DebugPrint("Possible tank detected for "..target);
		return true;
	else
		----GTFO_DebugPrint("This class isn't a tank");
	end
	return;
end

function GTFO_CanCastCheck()
	if (GTFO.PlayerClass == "WARRIOR" or GTFO.PlayerClass == "HUNTER" or GTFO.PlayerClass == "ROGUE" or GTFO.PlayerClass == "DEATHKNIGHT" or GTFO.PlayerClass == "DEMONHUNTER") then
		----GTFO_DebugPrint("This class isn't a caster");
		return;
	else
		----GTFO_DebugPrint("Possible caster detected for "..target);
		return true;
	end
end

function GTFO_RegisterTankEvents()
	if (GTFO.PlayerClass == "PALADIN") then
		GTFOFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
	else
		GTFOFrame:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	end
end

function GTFO_RegisterCasterEvents()
	if not (GTFO.ClassicMode or GTFO.BurningCrusadeMode or GTFO.WrathMode or GTFO.CataclysmMode) then
		GTFOFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
		GTFOFrame:RegisterEvent("PLAYER_TALENT_UPDATE");	
	end
end

-- Cache sound file locations 
function GTFO_GetSounds()
	if (GTFO.Settings.Volume == 2) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_soft.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz_soft.ogg",
		};
	elseif (GTFO.Settings.Volume == 1) then
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble_quiet.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz_quiet.ogg",
		};
	else	
		GTFO.Sounds = {
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzzer.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbeep.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmdouble.ogg",
			"Interface\\AddOns\\GTFO\\Sounds\\alarmbuzz.ogg",
		};
	end
	
	if not (GTFO.BrannModeSounds) then
		GTFO.BrannModeSounds = {
			{
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_33_M.ogg", -- Get out of the way!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_34_M.ogg", -- Don't stand there!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_35_M.ogg", -- You got to dodge
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_43_M.ogg", -- Keepers preserve ye!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_47_M.ogg", -- Hey, be careful!
			},
			{
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_33_M.ogg", -- Get out of the way!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_34_M.ogg", -- Don't stand there!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_35_M.ogg", -- You got to dodge
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_42_M.ogg", -- Don't go dying on me
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_43_M.ogg", -- Keepers preserve ye!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_44_M.ogg", -- It can't end like this!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_47_M.ogg", -- Hey, be careful!
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_57_M.ogg", -- I know you can do better than that
				"Interface\\AddOns\\GTFO\\Sounds\\Brann\\VO_110_Brann_Bronzebeard_89_M.ogg", -- Little too close for my taste
			},
		};
	end
end

-- Save settings to persistant storage, refresh UI options
function GTFO_SaveSettings()
	--GTFO_DebugPrint("Saving settings");
	GTFOData.DataCode = GTFO.DataCode;
	GTFOData.Active = GTFO.Settings.Active;
	GTFOData.Sounds = { };
	GTFOData.Sounds[1] = GTFO.Settings.Sounds[1];
	GTFOData.Sounds[2] = GTFO.Settings.Sounds[2];
	GTFOData.Sounds[3] = GTFO.Settings.Sounds[3];
	GTFOData.Sounds[4] = GTFO.Settings.Sounds[4];
	GTFOData.Volume = GTFO.Settings.Volume;
	GTFOData.ScanMode = GTFO.Settings.ScanMode;
	GTFOData.AlertMode = GTFO.Settings.AlertMode;
	GTFOData.DebugMode = GTFO.Settings.DebugMode;
	GTFOData.TestMode = GTFO.Settings.TestMode;
	GTFOData.UnmuteMode = GTFO.Settings.UnmuteMode;
	GTFOData.TrivialMode = GTFO.Settings.TrivialMode;
	GTFOData.TrivialDamagePercent = GTFO.Settings.TrivialDamagePercent;
	GTFOData.NoVersionReminder = GTFO.Settings.NoVersionReminder;
	GTFOData.EnableVibration = GTFO.Settings.EnableVibration;
	GTFOData.SoundChannel = GTFO.Settings.SoundChannel;
	GTFOData.BrannMode = GTFO.Settings.BrannMode;
	GTFOData.IgnoreTimeAmount = GTFO.Settings.IgnoreTimeAmount;
	GTFOData.IgnoreOptions = { };
	if (GTFO.Settings.IgnoreOptions) then
		for key, option in pairs(GTFO.Settings.IgnoreOptions) do
			GTFOData.IgnoreOptions[key] = GTFO.Settings.IgnoreOptions[key];
		end
	end
	GTFOData.SoundOverrides = { "", "", "", "" };
	GTFOData.IgnoreSpellList = { };
	if (GTFO.UIRendered) then
		getglobal("GTFO_HighResetButton"):Hide();
		getglobal("GTFO_LowResetButton"):Hide();
		getglobal("GTFO_FailResetButton"):Hide();
		getglobal("GTFO_FriendlyFireResetButton"):Hide();
	end

	if (GTFO.Settings.SoundOverrides) then
		for key, option in pairs(GTFO.Settings.SoundOverrides) do
			GTFOData.SoundOverrides[key] = GTFO.Settings.SoundOverrides[key] or "";
			if (GTFOData.SoundOverrides[key] ~= "") then
				if (key == 1) then
					getglobal("GTFO_HighResetButton"):Show();
				end
				if (key == 2) then
					getglobal("GTFO_LowResetButton"):Show();
				end
				if (key == 3) then
					getglobal("GTFO_FailResetButton"):Show();
				end
				if (key == 4) then
					getglobal("GTFO_FriendlyFireResetButton"):Show();
				end
			end			
		end
	end
	
	if (not GTFO.ClassicMode and #GTFO.Settings.IgnoreSpellList > 0) then
		for i, spellId in pairs(GTFO.Settings.IgnoreSpellList) do
			tinsert(GTFOData.IgnoreSpellList, spellId);
		end
	end
	
	if (GTFO.UIRendered) then
		getglobal("GTFO_EnabledButton"):SetChecked(GTFO.Settings.Active);
		getglobal("GTFO_HighSoundButton"):SetChecked(GTFO.Settings.Sounds[1]);
		getglobal("GTFO_LowSoundButton"):SetChecked(GTFO.Settings.Sounds[2]);
		getglobal("GTFO_FailSoundButton"):SetChecked(GTFO.Settings.Sounds[3]);
		getglobal("GTFO_FriendlyFireSoundButton"):SetChecked(GTFO.Settings.Sounds[4]);
		getglobal("GTFO_TestModeButton"):SetChecked(GTFO.Settings.TestMode);
		getglobal("GTFO_UnmuteButton"):SetChecked(GTFO.Settings.UnmuteMode);
		getglobal("GTFO_TrivialButton"):SetChecked(GTFO.Settings.TrivialMode);
		getglobal("GTFO_VibrationButton"):SetChecked(GTFO.Settings.EnableVibration);

		for key, option in pairs(GTFO.IgnoreSpellCategory) do
			getglobal("GTFO_IgnoreAlertButton_"..key):SetChecked(not GTFO.Settings.IgnoreOptions[key]);
		end
	end
	
	GTFO_ActivateMod();
end

-- Reset all settings to default
function GTFO_SetDefaults()
	GTFO.Settings.Active = GTFO.DefaultSettings.Active;
	GTFO.Settings.Sounds = { };
	GTFO.Settings.Sounds[1] = GTFO.DefaultSettings.Sounds[1];
	GTFO.Settings.Sounds[2] = GTFO.DefaultSettings.Sounds[2];
	GTFO.Settings.Sounds[3] = GTFO.DefaultSettings.Sounds[3];
	GTFO.Settings.Sounds[4] = GTFO.DefaultSettings.Sounds[4];
	GTFO.Settings.Volume = GTFO.DefaultSettings.Volume;
	GTFO.Settings.ScanMode = GTFO.DefaultSettings.ScanMode;
	GTFO.Settings.AlertMode = GTFO.DefaultSettings.AlertMode;
	GTFO.Settings.DebugMode = GTFO.DefaultSettings.DebugMode;
	GTFO.Settings.TestMode = GTFO.DefaultSettings.TestMode;
	GTFO.Settings.UnmuteMode = GTFO.DefaultSettings.UnmuteMode;
	GTFO.Settings.TrivialMode = GTFO.DefaultSettings.TrivialMode;
	GTFO.Settings.NoVersionReminder = GTFO.DefaultSettings.NoVersionReminder;
	GTFO.Settings.EnableVibration = GTFO.DefaultSettings.EnableVibration;
	GTFO.Settings.TrivialDamagePercent = GTFO.DefaultSettings.TrivialDamagePercent;
	GTFO.Settings.SoundChannel = GTFO.DefaultSettings.SoundChannel;
	if (GTFO.UIRendered) then
		getglobal("GTFO_VolumeSlider"):SetValue(GTFO.DefaultSettings.Volume);
		getglobal("GTFO_TrivialDamageSlider"):SetValue(GTFO.DefaultSettings.TrivialDamagePercent);
		getglobal("GTFO_ChannelIdSlider"):SetValue(GTFO_GetCurrentSoundChannelId(GTFO.DefaultSettings.SoundChannel));
		getglobal("GTFO_BrannModeSlider"):SetValue(GTFO_GetCurrentBrannMode(GTFO.DefaultSettings.BrannMode));
		getglobal("GTFO_IgnoreTimeSlider"):SetValue(GTFO.DefaultSettings.IgnoreTimeAmount);
	end
	GTFO.Settings.IgnoreOptions = GTFO.DefaultSettings.IgnoreOptions;
	GTFO.Settings.SoundOverrides = GTFO.DefaultSettings.SoundOverrides;
	GTFO.Settings.IgnoreSpellList = GTFO.DefaultSettings.IgnoreSpellList;
	GTFO.Settings.BrannMode = GTFO.DefaultSettings.BrannMode;
	GTFO.Settings.IgnoreTimeAmount = GTFO.DefaultSettings.IgnoreTimeAmount;
	GTFO_SaveSettings();
end

-- Show pop-up alert
function GTFO_DisplayConfigPopupMessage()
	StaticPopup_Show("GTFO_POPUP_MESSAGE");
end

function GTFO_HasBuff(target, iSpellID)
	if (GTFO_GetBuffSpellIndex(target, iSpellID)) then
		return true;
	else
		return nil;
	end
end

function GTFO_HasDebuff(target, iSpellID)
	if (GTFO_GetDebuffSpellIndex(target, iSpellID)) then
		return true;
	else
		return nil;
	end
end

function GTFO_DebuffStackCount(target, iSpellID)
	local spellName = GTFO_GetSpellName(tonumber(iSpellID));
	if (spellName) then
		local debuffIndex, debuff = GTFO_GetDebuffSpellIndex(target, iSpellID);
		if (debuffIndex) then
			return tonumber(debuff.applications);
		end
	end
	return 0;
end

function GTFO_GetBuffSpellIndex(target, iSpellID)
	if (iSpellID) then
		for i = 1, 40, 1 do
			local buff = C_UnitAuras.GetAuraDataByIndex(target, i, "HELPFUL");
			if (buff) then
				if (tonumber(buff.spellId) == tonumber(iSpellID)) then
					return i, buff;
				end
			else
				return nil;
			end
		end
	end
	return nil;
end

function GTFO_GetDebuffSpellIndex(target, iSpellID)
	if (iSpellID) then
		for i = 1, 40, 1 do
			local debuff = C_UnitAuras.GetAuraDataByIndex(target, i, "HARMFUL");
			if (debuff) then
				if (tonumber(debuff.spellId) == tonumber(iSpellID)) then
					return i, debuff;
				end
			else
				return nil;
			end
		end
	end
	return nil;
end

function GTFO_BuffTime(target, iSpellID)
	local index, buff = GTFO_GetBuffSpellIndex(target, iSpellID);
	if (index and buff.expirationTime > 0) then
		return (tonumber(buff.expirationTime) - GetTime()) or 0;
	else
		return 0;
	end
end

function GTFO_DebuffTime(target, iSpellID)
	local index, debuff = GTFO_GetDebuffSpellIndex(target, iSpellID);
	if (index and debuff.expirationTime > 0) then
		return (tonumber(debuff.expirationTime) - GetTime()) or 0;
	else
		return 0;
	end
end

function GTFO_GetAlertID(alert)
	if (alert.soundFunction) then
		return alert:soundFunction();
	end	

	local alertLevel;
	local tankAlert = nil;

	if (alert.tankSound or alert.tankSoundLFR or alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic) then
		-- TankSound alert present, check for tanking mode
		if (GTFO.TankMode or (GTFO.RaidMembers == 0 and GTFO.PartyMembers == 0)) then
			-- Tank or soloing
			tankAlert = true;
		elseif (not GTFO.RetailMode and GTFO_IsTank()) then
			tankAlert = true;
		end
	end
	
	if (tankAlert and alert.tankSound) then
		alertLevel = alert.tankSound;
	else
		alertLevel = alert.sound or 0;
	end
	
	if ((alert.soundLFR or (tankAlert and alert.tankSoundLFR)) and GTFO_IsInLFR()) then
		if (tankAlert and alert.tankSoundLFR) then
			alertLevel = alert.tankSoundLFR;
		elseif (alert.soundLFR) then
			alertLevel = alert.soundLFR;
		end
	elseif (alert.soundHeroic or alert.soundMythic or alert.soundChallenge or (tankAlert and (alert.tankSoundHeroic or alert.tankSoundMythic or alert.tankSoundChallenge))) then
		local isHeroic, isChallenge, isHeroicRaid, isMythic = select(3, GetDifficultyInfo(select(3, GetInstanceInfo())));
		if (isChallenge == true) then
			-- Mythic+/Challenge Mode
			local useAlert = true;
			if (alert.soundChallengeMinimumLevel) then
				local currentKey, _ = C_ChallengeMode.GetActiveKeystoneInfo()
				useAlert = alert.soundChallengeMinimumLevel >= tonumber(currentKey);
			end
			if (useAlert) then
				if (tankAlert and (alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic)) then
					alertLevel = alert.tankSoundChallenge or alert.tankSoundMythic or alert.tankSoundHeroic;
				elseif (alert.soundChallenge or alert.soundMythic or alert.soundHeroic) then
					alertLevel = alert.soundChallenge or alert.soundMythic or alert.soundHeroic;
				end
			end
		elseif (isMythic == true) then
			-- Mythic Mode
			if (tankAlert and (alert.tankSoundMythic or alert.tankSoundHeroic)) then
				alertLevel = alert.tankSoundMythic or alert.tankSoundHeroic;
			elseif (alert.soundMythic or alert.soundHeroic) then
				alertLevel = alert.soundMythic or alert.soundHeroic;
			end
		elseif (isHeroic == true or isHeroicRaid == true) then
			-- Heroic Mode
			if (tankAlert and alert.tankSoundHeroic) then
				alertLevel = alert.tankSoundHeroic;
			elseif (alert.soundHeroic) then
				alertLevel = alert.soundHeroic;
			end
		end
	end
	
	return alertLevel;
end

function GTFO_GetAlertType(alertID)
	if (alertID == 1) then
		return GTFOLocal.AlertType_High;
	elseif (alertID == 2) then
		return GTFOLocal.AlertType_Low;
	elseif (alertID == 3) then
		return GTFOLocal.AlertType_Fail;
	elseif (alertID == 4) then
		return GTFOLocal.AlertType_FriendlyFire;
	end
	return nil;
end

function GTFO_GetAlertByID(alertName)
	if (alertName == GTFOLocal.AlertType_High) then
		return 1;
	elseif (alertName == GTFOLocal.AlertType_Low) then
		return 2;
	elseif (alertName == GTFOLocal.AlertType_Fail) then
		return 3;
	elseif (alertName == GTFOLocal.AlertType_FriendlyFire) then
		return 4;
	end
	return nil;
end

function GTFO_GetAlertIcon(alertID)
	if (alertID == 1) then
		return "Interface\\Icons\\Spell_Fire_Fire";
	elseif (alertID == 2) then
		return "Interface\\Icons\\Spell_Fire_BlueFire";
	elseif (alertID == 3) then
		return "Interface\\Icons\\Ability_Suffocate";
	elseif (alertID == 4) then
		return "Interface\\Icons\\Spell_Fire_FelFlameRing";
	end
	return nil;
end

function GTFO_AlertIncoming(soundAlert, vehicle, ...)
	local timestamp, eventType, hideCaster, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags, misc1, misc2, misc3, misc4, misc5, misc6, misc7 = ...; 
end

function GTFO_AddEvent(eventName, eventTime, eventCode, eventRepeat)
		local event = {
			Name = tostring(eventName);
			ExecuteTime = GetTime() + eventTime;
			Code = eventCode;
			Repeat = 0;
		};
		local eventIndex = nil;
		
		if (eventRepeat) then
			event.Repeat = eventRepeat;
		end

		-- Check for existing event
		eventIndex = GTFO_FindEvent(event.Name);
		
		if (eventIndex) then
			GTFO.Events[eventIndex].ExecuteTime = event.ExecuteTime;
			--GTFO_DebugPrint("Extending event '"..event.Name.."' to be executed in "..eventTime.." seconds.");
		else
			tinsert(GTFO.Events, event);
			--GTFO_DebugPrint("Adding event '"..event.Name.."' to be executed in "..eventTime.." seconds.");			
			GTFOFrame:SetScript("OnUpdate", GTFO_OnUpdate);
			--GTFO_DebugPrint("Event update checking enabled.");
		end
end

function GTFO_RemoveEvent(eventName)
	if (#GTFO.Events > 0) then
		for index, event in pairs(GTFO.Events) do
			if (event.Name == eventName) then
				--GTFO_DebugPrint("Removed event: "..tostring(eventName));
				tremove(GTFO.Events, index);
				return;
			end
		end
	end
end

function GTFO_FindEvent(eventName)
	if (#GTFO.Events > 0) then
		for index, currentEvent in pairs(GTFO.Events) do
			if (currentEvent.Name == eventName) then
				return index;
			end
		end
	end	
	return nil;
end

function GTFO_RecordStats(alertID, spellID, SpellName, damage, sourceName, spellType)
	if (alertID and alertID > 0 and (GTFO.Recount or GTFO.Skada)) then
		local spellName = SpellName;
		-- Append the name of the person that did damage for Friendly Fire alerts
		if (alertID == 4) then
			if (sourceName and tostring(sourceName) ~= "nil") then
				spellName = spellName.." ("..sourceName..")";
			end
		end

		if (GTFO.Settings.AlertMode) then	
			if (GTFO.ClassicMode or (tonumber(spellID) or 0) <= 0) then
				GTFO_AlertPrint(GTFO_GetAlertType(alertID).." Alert: "..tostring(spellType).." - "..tostring(spellID).." - "..tostring(spellName).." ("..tostring(sourceName or "")..") for "..tostring(damage));
			else
				GTFO_AlertPrint(GTFO_GetAlertType(alertID).." Alert: "..tostring(spellType).." - "..tostring(spellID).." - "..GTFO_GetSpellLink(spellID).." ("..tostring(sourceName or "")..") for "..tostring(damage));
			end
		end
		
		-- Integration
		if (GTFO.Recount) then
			GTFO_RecordRecount(UnitName("player"), alertID, spellName, damage);
		end
		if (GTFO.Skada) then
			GTFO_RecordSkada(UnitName("player"), UnitGUID("player"), alertID, tonumber(spellID), spellName, tonumber(damage));
		end
	end
end

function GTFO_DisplayAura(alertTypeID)
	-- Integration
	if (GTFO.PowerAuras) then
		GTFO_DisplayAura_PowerAuras(alertTypeID);
	end
	if (GTFO.WeakAuras) then
		GTFO_DisplayAura_WeakAuras(alertTypeID);
	end
end

function GTFO_IsInLFR()
	return IsInGroup(LE_PARTY_CATEGORY_INSTANCE);
end

function GTFO_GetSoundChannelCVar(soundChannel)
	for _, item in pairs(GTFO.SoundChannels) do
	  if (item.Code and item.Code == soundChannel) then
	    return item.CVar;
	  end
	end
	return;	
end

function GTFO_GetRealmName()
	return gsub(GetRealmName(), "%s", "");
end

function GTFO_SpellScan(spellId, spellOrigin, spellDamage)
	local test = false;
	if (GTFO.Settings.ScanMode) then
		local damage = tonumber(spellDamage) or 0;
		if (GTFO.Scans[spellId]) then
			GTFO.Scans[spellId].Times = GTFO.Scans[spellId].Times + 1;
			GTFO.Scans[spellId].Damage = GTFO.Scans[spellId].Damage + damage;
			return true;
		elseif (GTFO.IgnoreScan[spellId]) then
			-- Ignored spell
			return false;
		else
			if (GTFO.SpellID[spellId]) then 
				test = GTFO.SpellID[spellId].test or false;
				if not (test) then
					return false;
				end
			elseif (GTFO.FFSpellID[spellId]) then
				test = GTFO.FFSpellID[spellId].test or false;
				if not (test) then
					return false;
				end
			end

			GTFO.Scans[spellId] = {
				TimeAdded = GetTime();
				Times = 1;
				SpellID = spellId;
				SpellName = tostring(select(1, GTFO_GetSpellName(spellId)));
				SpellDescription = GTFO_GetSpellDescription(spellId) or "";
				SpellOrigin = tostring(spellOrigin);
				IsDebuff = (spellDamage == "DEBUFF");
				Damage = damage;
				IsTest = test;
			};
			return true;
		end
	end
	return false;
end

-- For Vanilla Classic because SpellIDs are not available
function GTFO_SpellScanName(spellName, spellOrigin, spellDamage)
	if (GTFO.Settings.ScanMode) then
		local damage = tonumber(spellDamage) or 0;
		if not (GTFO.Scans[spellName] or GTFO.SpellName[spellName] or GTFO.IgnoreScan[spellName]) then
			GTFO.Scans[spellName] = {
				TimeAdded = GetTime();
				Times = 1;
				SpellID = 0;
				SpellName = spellName;
				SpellOrigin = tostring(spellOrigin);
				IsDebuff = (spellDamage == "DEBUFF");
				Damage = damage;
			};
		elseif (GTFO.Scans[spellName]) then
			GTFO.Scans[spellName].Times = GTFO.Scans[spellName].Times + 1;
			GTFO.Scans[spellName].Damage = GTFO.Scans[spellName].Damage + damage;
		end
	end
end

function GTFO_Command_Data()
	if (next(GTFO.Scans) == nil) then
		GTFO_ErrorPrint("No scan data available.");
		return;
	end
	if (not PratCCFrame) then
		GTFO_ErrorPrint("Prat Addon is required to use this feature.");
		return;
	end

	local dataOutput = "";
	local scans = { };
	for key, data in pairs(GTFO.Scans) do
    table.insert(scans, data);
  end
  table.sort(scans, (function(a, b) return tonumber(a.TimeAdded) < tonumber(b.TimeAdded) end));
  
	for _, data in pairs(scans) do
		dataOutput = dataOutput.."-- |cff00ff00"..tostring(data.SpellName).." (x"..data.Times;

		if (data.SpellDescription == nil or data.SpellDescription == "") then
			data.SpellDescription = GTFO_GetSpellDescription(data.SpellID) or "";
		end
		
		if (data.Damage > 0) then
			dataOutput = dataOutput..", "..data.Damage
		end
		dataOutput = dataOutput..")|r\n";
		dataOutput = dataOutput.."-- |cff00aa00"..tostring(data.SpellDescription or "").."|r\n";
		dataOutput = dataOutput.."GTFO.SpellID[\""..data.SpellID.."\"] = {\n";
		dataOutput = dataOutput.."  --desc = \""..tostring(data.SpellName).." ("..tostring(data.SpellOrigin)..")\";\n";
		if (data.IsDebuff) then
			dataOutput = dataOutput.."  applicationOnly = true;\n";
		end
		if (data.IsTest) then
			dataOutput = dataOutput.."  test = true;\n";
		end
		dataOutput = dataOutput.."  sound = 1;\n";
		dataOutput = dataOutput.."};\n";
		dataOutput = dataOutput.."\n";
	end

	local display = "|cffffffff"..dataOutput.."|r"
	PratCCText:SetText("GTFO Spells");
	PratCCFrameScrollText:SetText(display);
	PratCCFrame:Show()
end

function GTFO_Command_ClearData()
	GTFO.Scans = { };
	return;
end

function GTFO_ScanSpells()
	GTFO.SpellName = { };
	for spellId, record in pairs(GTFO.SpellID) do
		local spellName = GTFO_GetSpellName(spellId);
		if (spellName or "" ~= "") then
			if (GTFO.SpellName[spellName] ~= nil) then
			GTFO_ErrorPrint("Duplicate spell "..spellName.." from ID #"..tostring(spellId));
			else
				GTFO.SpellName[spellName] = spellId;
			end
		else
			GTFO_ErrorPrint("Unknown or invalid spell ID #"..tostring(spellId));
		end
	end		
end

function GTFO_GetCurrentSoundChannelId(sSoundChannel)
	for key, option in pairs(GTFO.SoundChannels) do
		if ((sSoundChannel) == option.Code) then
			return key;
		end
	end
	return 1; -- Default
end

function GTFO_GetCurrentBrannMode(iCode)
	local code = tonumber(iCode) or 0;
	if (code == 1) then
		return GTFOLocal.BrannMode_OnWithDefault;
	elseif (code == 2) then
		return GTFOLocal.BrannMode_On;
	end
	return GTFOLocal.BrannMode_Off;
end

function GTFO_GetSpellName(spellId)
	if (C_Spell and C_Spell.GetSpellInfo) then
		local spell = C_Spell.GetSpellInfo(spellId);
		if (spell) then
			return spell.name;
		end
	else
		return GetSpellInfo(spellId);
	end
end

function GTFO_GetSpellLink(spellId)
	if (C_Spell and C_Spell.GetSpellLink) then
		return C_Spell.GetSpellLink(spellId);
	else
		return GetSpellLink(spellId);
	end
end

function GTFO_GetSpellDescription(spellId)
	if (C_Spell and C_Spell.GetSpellDescription) then
		return C_Spell.GetSpellDescription(spellId);
	else
		return GetSpellDescription(spellId);
	end
end

function GTFO_GetSpecIndex()
	if C_SpecializationInfo and C_SpecializationInfo.GetSpecialization then
		return C_SpecializationInfo.GetSpecialization();
	elseif GetSpecialization then
		return GetSpecialization();
	end
	return nil;
end

function GTFO_GetSpecRole(spec)
	if C_SpecializationInfo and C_SpecializationInfo.GetSpecializationRole then
		return C_SpecializationInfo.GetSpecializationRole(spec);
	elseif GetSpecializationRole then
		return GetSpecializationRole(spec);
	end
	return nil;
end
