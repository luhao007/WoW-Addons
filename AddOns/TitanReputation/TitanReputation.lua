-- globals
TITANREP_ID =  "Reputation"
TITANREP_VERSION = GetAddOnMetadata("TitanReputation", "Version") or "UnKnown Version"
TITANREP_TITLE = GetAddOnMetadata("TitanReputation", "Title") or "UnKnown Title"
TITANREP_BUTTON_ICON = "Interface\\AddOns\\TitanReputation\\TitanReputation"
TITANREP_EventTime = GetTime()
TITAMREP_InitTime = 0
TITANREP_RTS = {}
gFactionID = 1168
TITANREP_bonusRepsTable = { 
            [1375]=1, --Dominance Offensive 
			[1269]=1, --Golden Lotus
			[1271]=1, --Order of the Cloud Serpent 
			[1270]=1, --Shado-Pan 
			[1388]=1, --Sunreaver Onslaught 
			[1341]=1, --The August Celestials 
			[1337]=1, --The Klaxxi 
			[1345]=1, --The Lorewalkers 
			[1272]=1, --The Tillers
			[1302]=1, --The Anglers
			[1387]=1, --Kirin Tor Offensive
			[1376]=1 --Operation: Shield Wall
			}

--check Glamour version
--

if(IsAddOnLoaded("Glamour")) then
	local min_version = 1.2
	local major, minor, _ = strsplit(".", Glamour_VERSION)
	local glam_ver = tonumber(major.."."..minor)

	if (glam_ver < min_version) then
		StaticPopupDialogs["! ! ! Glamour Outdated ! ! !"] = {
			  text = "An outdated version of Glamour has been detected. Running an older version of Glamour can have undesired effects on Glamour enabled addons.\n\n"..
		  		"Reporting Addon:\n"..TITANREP_TITLE.." v"..TITANREP_VERSION.."\n\n"..
				"Glamour Version Detected: "..Glamour_VERSION.."\nGlamour Version Required: "..min_version.."\n\n",
			  button1 = "Ok",
			  timeout = 0,
			  whileDead = true,
			  hideOnEscape = true,
		}
		StaticPopup_Show ("! ! ! Glamour Outdated ! ! !")
	end
end

--new color coding
local TITANREP_COLORS_DEFAULT = {
		[1] = {r = 0.8, g = 0, b = 0},
		[2] = {r = 0.8, g = 0.3, b = 0.22},
		[3] = {r = 0.75, g = 0.27, b = 0},
		[4] = {r = 0.9, g = 0.7, b = 0},
		[5] = {r = 0, g = 1.0, b = 0.5},
		[6] = {r = 0, g = 0.5, b = 0.5},
		[7] = {r = 0, g = 0.5, b = 1.0},
		[8] = {r = 0.2, g = 0.7, b = 0.7},
		[9] = {r = 1, g = 0.5, b = 0.1}
}

local TITANREP_COLORS_ARMORY = {
		[1] = {r = 0.54, g = 0.11, b = 0.07},
 		[2] = {r = 0.65, g = 0.30, b = 0.10},
		[3] = {r = 0.70, g = 0.48, b = 0.11},
		[4] = {r = 0.67, g = 0.55, b = 0.11},
		[5] = {r = 0.49, g = 0.49, b = 0.00},
		[6] = {r = 0.34, g = 0.47, b = 0.00},
		[7] = {r = 0.14, g = 0.48, b = 0.00},
		[8] = {r = 0.01, g = 0.49, b = 0.42},
		[9] = {r = 1, g = 0.5, b = 0.1}
}

local MYBARCOLORS = TITANREP_COLORS_DEFAULT

local TITANREP_ICONS = { "03", "03", "07", "08", "06", "06", "06", "05" }



-- labels
local TITANREP_ALL_HIDDEN_LABEL = "Reputation: Off"
local TITANREP_NO_FACTION_LABEL = "Reputation: No Faction Selected"
local TITANREP_SHOW_FACTION_NAME_LABEL = "Show Faction Name"
local TITANREP_SHOW_STANDING = "Show Standing"
local TITANREP_SHOW_VALUE = "Show Reputation Value"
local TITANREP_SHOW_PERCENT = "Show Percent"
local TITANREP_AUTO_CHANGE = "Auto Show Changed"
local TITANREP_SHOW_FRIENDSHIPS = "Show Frienships"
local TITANREP_SHOW_BESTFRIEND = "Show Best Friend"
local TITANREP_SHOW_GOODFRIEND = "Show Good Friend"
local TITANREP_SHOW_FRIEND = "Show Friend"
local TITANREP_SHOW_BUDDY = "Show Buddy"
local TITANREP_SHOW_ACQUAINTANCE= "Show Acquaintance"
local TITANREP_SHOW_STRANGER = "Show Stranger"
local TITANREP_SHOW_EXALTED = "Show Exalted"
local TITANREP_SHOW_REVERED = "Show Revered"
local TITANREP_SHOW_HONORED = "Show Honored"
local TITANREP_SHOW_FRIENDLY = "Show Friendly"
local TITANREP_SHOW_NEUTRAL = "Show Neutral"
local TITANREP_SHOW_UNFRIENDLY = "Show Unfriendly"
local TITANREP_SHOW_HOSTILE = "Show Hostile"
local TITANREP_SHOW_HATED = "Show Hated"
local TITANREP_SHORT_STANDING = " - Abbreviate Standing"
local TITANREP_ARMORY_COLORS = "Armory Colors"
local TITANREP_DEFAULT_COLORS = "Default Colors"
local TITANREP_NO_COLORS = "Basic Colors"
local TITANREP_SHOW_STATS = "Show Exalted Total"
local TITANREP_SHOW_SUMMARY = "Show Session Summary"
local TITANREP_SHOW_ANNOUNCE = "Announce Standing Changes"
local TITANREP_SHOW_ANNOUNCE_FRAME = "Glamourize Standing Changes"
local TITANREP_SHOW_ANNOUNCE_MIK = " - Use MikSBT for Announcement"
local TITANREP_SHOW_MINIMAL = "Use Minimal Tooltip Display"
local TITANREP_SCALE_INCREASE = "+ Increase Tooltip Scale"
local TITANREP_SCALE_DECREASE = "- Decrease Tooltip Scale"
local TITANREP_DisplayOnRightSide = "Align Plugin to Right-Side"
local TITANREP_ShowFriendsOnBar = "Show Friendships"
local TITANREP_BonusRepWarnings = "Show Bonus Reputation Warnings"
local TITANREP_PARAGON = "Paragon"
local TITANREP_SESSION_SUMMARY = "Session Summary"
local TITANREP_SESSION_SUMMARY_DURATION = "Duration"
local TITANREP_SESSION_SUMMARY_TOTAL_EXALTED_FACTIONS = "Total Exalted Factions"
local TITANREP_SESSION_SUMMARY_FACTIONS = "Factions"
local TITANREP_SESSION_SUMMARY_FRIENDS = "Friends"
local TITANREP_SESSION_SUMMARY_TOTAL = "Total"

-- local
local TITANREP_BUTTON_TEXT = TITANREP_NO_FACTION_LABEL
local TITANREP_TOOLTIP_TEXT = ""
local TITANREP_HIGHCHANGED = 0
local TITANREP_TIME = GetTime()
local TITANREP_CHANGEDFACTION = "none"
local TITANREP_TABLE = {}
local TITANREP_TABLE_INIT = false

-- initializing
function TitanPanelReputationButton_OnLoad(self)
	self.registry = {
		id = TITANREP_ID,
		menuText = TITANREP_ID,
		version = TITANREP_VERSION,
		buttonTextFunction = "TitanPanelReputation_GetButtonText",
		tooltipCustomFunction = TitanPanelReputation_localGetToolTipText,
		category = "Information",
		icon = TITANREP_BUTTON_ICON,
		iconWidth = 16,
		savedVariables = {
			ShowIcon = 1,
			ShowFriendships = 1,
			ShowFactionName = 1,
			ShowStanding = 1,
			ShortStanding = false,
			ShowValue = 1,
			ShowPercent = 1,
			AutoChange = 1,
			TITANREP_WATCHED_FACTION = "none",
			ShowExalted = 1,
			ShowRevered= 1,
			ShowHonored= 1,
			ShowFriendly= 1,
			ShowNeutral= 1,
			ShowUnfriendly= 1,
			ShowHostile= 1,
			ShowHated= 1,
			ShowBESTFRIEND= 1,
			ShowGOODFRIEND= 1,
			ShowFRIEND= 1,
			ShowBUDDY= 1,
			ShowACQUAINTANCE= 1,
			ShowSTRANGER= 1,
			MyColor = 1,
			ShowSummary = 1,
			ShowStats = 1,
			FactionHeaders = { "" },
			ShowTipValue = 1,
			ShowTipPercent = 1,
			ShowTipStanding = 1,
			ShowAnnounce = 1,
			ShowAnnounceFrame = 1,
			ShowAnnounceMik = 1,
			ShortTipStanding = false,
			ToolTipScale = .8,
			Minimal = false,
			ShowFriendsOnBar = 1,
			BonusRepWarnings = 1,
			DisplayOnRightSide = false
		}
	}
    self:RegisterEvent("UPDATE_FACTION")
    self:RegisterEvent("ADDON_LOADED")

    --Temporary Patch for Titan Panel RightClick bug.
    TitanPanelBarButton_OnClick(Titan_Bar__Display_Bar,"RightButton")   
    L_CloseDropDownMenus() 
end

-- event handling
function TitanPanelReputationButton_OnClick(self, button)
     if (button == "LeftButton") then
	     ToggleCharacter("ReputationFrame")
     end
     if (button == "RightButton") then
	     TitanPanelRightClickMenu_PrepareReputationMenu(self)
     end
end

function TitanPanelReputationButton_OnEvent(event, ...)

	if event == "ADDON_LOADED" and ... == "TitanReputation" then
		if not TitanRep_Data then
			TitanRep_Data = { }
			TitanRep_Data["BonusRep"] = { }
		end
	
		--Fix for 3.8.1/2/3 Grand Commedation Bug in saved variables with Shadowpan-Assault will be removed in later versions
		if TitanRep_Data["BonusRep"][1435] then
			TitanRep_Data["BonusRep"][1435] = nil
		end
		TITANREP_InitTime = GetTime();
		print("TITANREP_InitTime Set:",TITANREP_InitTime);
	end


	local EventTime = GetTime()
	local EventTimeDiff = EventTime - TITANREP_EventTime
	TitanPanelReputation_GatherFactions(TitanPanelReputation_GetChangedName)
	if( EventTimeDiff > .15) then
		TITANREP_HIGHCHANGED = 0
		TITANREP_EventTime = GetTime()
		if(TitanGetVar(TITANREP_ID, "AutoChange")) then
			if(not (TITANREP_CHANGEDFACTION == "none")) then
				TitanSetVar(TITANREP_ID, "TITANREP_WATCHED_FACTION", TITANREP_CHANGEDFACTION)
			end
		end
	end
	TitanPanelReputation_GatherFactions(TitanPanelReputation_GatherValues)
	if not TITANREP_TABLE_INIT then TITANREP_TABLE_INIT = true print("INIT SET") end
	TitanPanelReputation_Refresh()
	TitanPanelButton_UpdateTooltip()
	TitanPanelButton_UpdateButton(TITANREP_ID)
end

-- for titan to get the displayed text
function TitanPanelReputation_GetButtonText(id)
	TitanPanelReputation_Refresh()
	return TITANREP_BUTTON_TEXT
end

function TitanReputation_AddTooltipText(text)
	if ( text ) then
		-- Append a "\n" to the end
		if ( string.sub(text, -1, -1) ~= "\n" ) then
	--		text = text.."\n"
		end

		-- See if the string is intended for a double column
		for text1, text2 in string.gmatch(text, "([^\t\n]*)\t?([^\t\n]*)\n") do
			if ( text2 ~= "" ) then
				-- Add as double wide
				GameTooltip:AddDoubleLine(text1, text2)
			elseif ( text1 ~= "" ) then
				-- Add single column line
				GameTooltip:AddLine(text1)
			else
				if not TitanGetVar(TITANREP_ID, "Minimal") then
					-- Assume a blank line
				 	GameTooltip:AddLine("\n")
				end
			end
		end
	end
end


-- Tooltip scaling hooked ownership check (Thanks to Pankkirosvo, this was educational.)
local TITANREP_OldScale
local TITANREP_isTooltipShowing = false
function TITANREP_TooltipHook()
	if GameTooltip:GetOwner() == TitanPanelReputationButton then 
		if not TITANREP_isTooltipShowing then
			TITANREP_isTooltipShowing = true
			TITANREP_OldScale = GameTooltip:GetScale()
			GameTooltip:SetScale(TitanGetVar(TITANREP_ID, "ToolTipScale"))
		end
	elseif TITANREP_isTooltipShowing  then
		TITANREP_isTooltipShowing = false
		if TITANREP_OldScale then
			GameTooltip:SetScale(TITANREP_OldScale)
			TITANREP_OldScale = nil
		end
	end
end
hooksecurefunc(GameTooltip,"Show",TITANREP_TooltipHook)


-- for titan tool tip text building
function TitanPanelReputation_localGetToolTipText(self)

	if not TitanGetVar(TITANREP_ID, "Minimal") then
		local tleft = "|T"..TITANREP_BUTTON_ICON..":32|t "..TITANREP_TITLE
		local tright = "v"..TITANREP_VERSION.."|T"..TITANREP_BUTTON_ICON..":32|t"
		GameTooltip:AddDoubleLine(tleft, tright, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b)
	end

	TitanReputation_AddTooltipText(TitanPanelReputation_GetToolTipText())
	GameTooltip:Show()

end

function TitanPanelReputation_GetToolTipText()
    RTS_HAS_ENTRIES = false
	TITANREP_TOOLTIP_TEXT = ""
	TOTAL_EXALTED = 0
	TOTAL_BESTFRIENDS = 0
	LAST_HEADER = {"HEADER", 1}
	TitanPanelReputation_GatherFactions(TitanPanelReputation_BuildToolTipText)
	if(TitanGetVar(TITANREP_ID, "ShowSummary") == 1) then
		local timeonline =  GetTime() -	TITANREP_TIME
		local humantime = ""

		if (timeonline < 60) then
			humantime = "< 1 Mn"
		else
			humantime = floor(timeonline / 60)
			if(humantime < 60) then
				humantime = humantime.." Mn"
			else
				local hours = floor(humantime / 60)
				local mins = floor((timeonline - (hours * 60 * 60)) / 60)
				humantime = hours.." Hr "..mins.." Mn"
			end
		end

        for f, v in pairs(TITANREP_RTS) do
            RTS_HAS_ENTRIES = true
        end

        if RTS_HAS_ENTRIES then
    		TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"..TitanUtils_GetHighlightText(TITANREP_SESSION_SUMMARY..":").."\t"..TitanUtils_GetNormalText(TITANREP_SESSION_SUMMARY_DURATION..": "..humantime)
    		for f, v in pairs(TITANREP_RTS) do
			    local RPH_STRING = ""
		    	local RPH = floor(v / (timeonline / 60 / 60))
	    		local RPM = floor(v / (timeonline / 60 ))
    			if(RPH > 0) then
				    RPH_STRING = TitanUtils_GetGoldText(f).." : "..TitanUtils_GetGreenText(RPH).."/h "..
			    				TitanUtils_GetGreenText(RPM).."/m "..
		    					"\t Total: "..TitanUtils_GetGreenText(v)
	    		else
    				RPH_STRING = TitanUtils_GetGoldText(f).." : "..TitanUtils_GetRedText(RPH).."/h "..
				    			TitanUtils_GetRedText(RPM).."/m "..
			    				"\t Total: "..TitanUtils_GetGreenText(v)
		    	end
	    		TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n  "..RPH_STRING
    		end
      		TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"
        end
	end

	if(TitanGetVar(TITANREP_ID, "ShowStats") == 1) then
		TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"..TitanUtils_GetHighlightText(TITANREP_SESSION_SUMMARY_TOTAL_EXALTED_FACTIONS..":")
		TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\t"..
				TitanUtils_GetGoldText(TITANREP_SESSION_SUMMARY_FACTIONS..": ")..TitanUtils_GetGreenText(TOTAL_EXALTED)..
				TitanUtils_GetGoldText(" "..TITANREP_SESSION_SUMMARY_FRIENDS..": ")..TitanUtils_GetGreenText(TOTAL_BESTFRIENDS)..
				TitanUtils_GetGoldText(" "..TITANREP_SESSION_SUMMARY_TOTAL..": ")..TitanUtils_GetGreenText((TOTAL_EXALTED+TOTAL_BESTFRIENDS)).."\n"
	end
	return TITANREP_TOOLTIP_TEXT
end

function TitanReputationSetColor()
	if(TitanGetVar(TITANREP_ID, "MyColor") == 1) then
		MYBARCOLORS = TITANREP_COLORS_DEFAULT
	end
	if(TitanGetVar(TITANREP_ID, "MyColor") == 2) then
		MYBARCOLORS = TITANREP_COLORS_ARMORY
	end
	if(TitanGetVar(TITANREP_ID, "MyColor") == 3) then
		MYBARCOLORS = nil
	end
end

-- this method adds a line to the tooltip text
function TitanPanelReputation_BuildToolTipText(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFriendship, factionID, hasBonusRepGain)
	local showrep = 0
	local friendID , friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold
	local adjustedId = standingID

	if isFriendship then
		friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(isFriendship)
        if not nextFriendThreshold then 
            adjustedId = 8
            TOTAL_BESTFRIENDS = TOTAL_BESTFRIENDS + 1
        end
	elseif standingID == 8  then TOTAL_EXALTED = TOTAL_EXALTED + 1 	end

    if hasBonusRepGain  then adjustedId = 9 end

	if (tContains(TitanGetVar(TITANREP_ID, "FactionHeaders"), parentName)) then
		return
	end

	TitanReputationSetColor()

	local preface = TitanUtils_GetHighlightText(" - ")
	local postface = ""
	local bonusRepWarning = nil
	if TitanGetVar(TITANREP_ID, "BonusRepWarnings") then
		if hasBonusRepGain then
			if not isHeader then preface = TitanUtils_GetGreenText(" + ") end
			if TitanRep_Data["BonusRep"][factionID] then TitanRep_Data["BonusRep"][factionID] = nil end
		elseif TITANREP_bonusRepsTable[factionID] and standingID >= 7 then
			if not isHeader then 
				preface = TitanUtils_GetRedText(" ! ") 
				postface = TitanUtils_GetRedText(" (Grand Commendation Available: Visit Quartermaster!)")
			end
		elseif TitanRep_Data["BonusRep"][factionID] then
			preface = TitanUtils_GetRedText(" ! ") 
			postface = TitanUtils_GetRedText("(Grand Commendation Available!)")
			local toons = ""
			local count = 0
			for key,value in pairs(TitanRep_Data["BonusRep"][factionID]) do
				if count > 1 then toons = toons..", " end
				toons = toons..key.."("..getglobal("FACTION_STANDING_LABEL"..TitanRep_Data["BonusRep"][factionID][key])..")"
				count = count + 1
			end
			local pluralize = "this toon: "
			if count > 1 then pluralize = " one of these toons: " end
			bonusRepWarning = "   "..TitanUtils_GetRedText("Visit Quartermaster on "..pluralize..toons.." (+100% Rep Bonus)")
		elseif TITANREP_bonusRepsTable[factionID] then
			preface = TitanUtils_GetHighlightText(" + ")
		end
	end

	if(isInactive) then
		showrep = 0
	else
		showrep = 1
	end

	if(isHeader) then
		LAST_HEADER = {name, 0}

		if(isHeader and hasRep) then
			showrep = 1
		else
			showrep = 0
		end
	end

	if(showrep == 1) then
		showrep = 0

		if isFriendship  then
			if TitanGetVar(TITANREP_ID, "ShowFriendships") then
                showrep = 1
			end

		else
			if(standingID == 8 and TitanGetVar(TITANREP_ID, "ShowExalted")) then showrep = 1 end
			if(standingID == 8 and hasBonusRepGain ) then showrep = 1 end
			if(standingID == 7 and TitanGetVar(TITANREP_ID, "ShowRevered")) then showrep = 1 end
			if(standingID == 6 and TitanGetVar(TITANREP_ID, "ShowHonored")) then showrep = 1 end
			if(standingID == 5 and TitanGetVar(TITANREP_ID, "ShowFriendly")) then showrep = 1 end
			if(standingID == 4 and TitanGetVar(TITANREP_ID, "ShowNeutral")) then showrep = 1 end
			if(standingID == 3 and TitanGetVar(TITANREP_ID, "ShowUnfriendly")) then showrep = 1 end
			if(standingID == 2 and TitanGetVar(TITANREP_ID, "ShowHostile")) then showrep = 1 end
			if(standingID == 1 and TitanGetVar(TITANREP_ID, "ShowHated")) then showrep = 1 end

		end


		if(showrep == 1) then 

			local LABEL = getglobal("FACTION_STANDING_LABEL"..standingID)
			if isFriendship then LABEL = friendTextLevel end
            if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then LABEL = TITANREP_PARAGON end

			if TitanGetVar(TITANREP_ID, "ShortTipStanding") then LABEL = strsub(LABEL,1,1) end

			if(LAST_HEADER[2] == 0) then
				--if(LAST_HEADER[1] == TITANREP_GUILDLOCAL) then
				if(factionID == gFactionID) then
					TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"..TitanUtils_GetHighlightText(LAST_HEADER[1])
				else
					TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"..TitanUtils_GetHighlightText(LAST_HEADER[1]).."\n"
				end
				LAST_HEADER[2] = 1
			end

			if(MYBARCOLORS) then
				TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..preface
				if((standingID == 8 and not hasBonusRepGain) or topValue == 1000 or topValue == 0) then
   					TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText(name, MYBARCOLORS[8])..postface.."\t"
	    			TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText(LABEL,MYBARCOLORS[8])
				else
					TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText(name, MYBARCOLORS[(adjustedId)])..postface.."\t"
					if(TitanGetVar(TITANREP_ID, "ShowTipValue")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText("["..earnedValue.."/"..topValue.."]", MYBARCOLORS[(adjustedId)]).." "
					end
					if(TitanGetVar(TITANREP_ID, "ShowTipPercent")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText(percent.."%",MYBARCOLORS[(adjustedId)]).." "
					end
					if(TitanGetVar(TITANREP_ID, "ShowTipStanding")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..TitanUtils_GetColoredText(LABEL,MYBARCOLORS[(adjustedId)])
					end
				end
			else
				TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..preface
				if(standingID == 8) then
                   	TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..name..postface.."\t"
    				TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..LABEL
				else
					TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..name..postface.."\t"
					if(TitanGetVar(TITANREP_ID, "ShowTipValue")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."["..earnedValue.."/"..topValue.."] "
					end
					if(TitanGetVar(TITANREP_ID, "ShowTipPercent")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..percent.."% "
					end
					if(TitanGetVar(TITANREP_ID, "ShowTipStanding")) then
						TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..strsub(LABEL,1,1)
					end
				end
			end
			TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT.."\n"
			if bonusRepWarning then
				TITANREP_TOOLTIP_TEXT = TITANREP_TOOLTIP_TEXT..bonusRepWarning.."\n"
			end
		end
	end
end

function TitanPanelRightClickMenu_AddTitle2(title, level)
	if (title) then
		local info = {}
		info.text = title
		info.notClickable = 1
		info.isTitle = 1
       		info.notCheckable = true
		L_UIDropDownMenu_AddButton(info, level)
	end
end


function TitanPanelRightClickMenu_AddToggleVar2(text, id, var, toggleTable, level, noclose)
	if not level then level = 2 end	
	local info = {}
	info.text = text
	info.value = {id, var, toggleTable}
	if noclose then
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar({id, var, toggleTable})
			end
	else
		info.func = function()
			TitanPanelRightClickMenu_ToggleVar({id, var, toggleTable})
			L_CloseDropDownMenus()
			end
	end
	info.checked = TitanGetVar(id, var)
	info.keepShownOnClick = 1
	L_UIDropDownMenu_AddButton(info, level)
end

function TitanPanelRightClickMenu_AddToggleIcon2(id)
	TitanPanelRightClickMenu_AddToggleVar2("Show Icon", id, "ShowIcon")
end

function TitanPanelRightClickMenu_AddSpacer2(level)
	local info = {}
	info.disabled = 1
       	info.notCheckable = true
	L_UIDropDownMenu_AddButton(info, level)
end


-- this method builds the right-click menus
function TitanPanelRightClickMenu_PrepareReputationMenu()
	local info = {}
       	info.hasArrow = nil
       	info.notCheckable = nil
       	info.text = nil
       	info.value = nil
	info.func = nil
	info.disabled = nil
	info.checked = nil

	-- level 2 menus
	if ( L_UIDROPDOWNMENU_MENU_LEVEL == 3 ) then
		if L_UIDROPDOWNMENU_MENU_VALUE == "Friendship Rank Settings" then
			TitanPanelRightClickMenu_AddTitle2(L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_FRIENDSHIPS, TITANREP_ID, "ShowFriendships","",3,true)
			TitanPanelRightClickMenu_AddSpacer2(3)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_BESTFRIEND, TITANREP_ID, "ShowBESTFRIEND","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_GOODFRIEND, TITANREP_ID, "ShowGOODFRIEND","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_FRIEND, TITANREP_ID, "ShowFRIEND","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_BUDDY, TITANREP_ID, "ShowBUDDY","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_ACQUAINTANCE, TITANREP_ID, "ShowACQUAINTANCE","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_STRANGER, TITANREP_ID, "ShowSTRANGER","",3,true)
		end
		if L_UIDROPDOWNMENU_MENU_VALUE == "Reputation Standing Settings" then
			TitanPanelRightClickMenu_AddTitle2(L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_EXALTED, TITANREP_ID, "ShowExalted","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_REVERED, TITANREP_ID, "ShowRevered","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_HONORED, TITANREP_ID, "ShowHonored","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_FRIENDLY, TITANREP_ID, "ShowFriendly","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_NEUTRAL, TITANREP_ID, "ShowNeutral","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_UNFRIENDLY, TITANREP_ID, "ShowUnfriendly","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_HOSTILE, TITANREP_ID, "ShowHostile","",3,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_HATED, TITANREP_ID, "ShowHated","",3,true)
		end
		if L_UIDROPDOWNMENU_MENU_VALUE == "Tooltip Scale" then
			TitanPanelRightClickMenu_AddTitle2("CAUTION: This effects ALL tooltips", L_UIDROPDOWNMENU_MENU_LEVEL)
			info.text = TITANREP_SCALE_INCREASE
       			info.notCheckable = true
			if TitanGetVar(TITANREP_ID, "ToolTipScale") >= 1.2 then
				info.disabled = true
				info.func = nil
			else
				info.disabled = nil
				info.func = function()
					TitanSetVar(TITANREP_ID, "ToolTipScale", TitanGetVar(TITANREP_ID, "ToolTipScale") + .1)
					TitanPanelButton_UpdateButton(TITANREP_ID)
					L_CloseDropDownMenus()
					end
			end
	     		L_UIDropDownMenu_AddButton(info, 3)
			info.text = TITANREP_SCALE_DECREASE
			if TitanGetVar(TITANREP_ID, "ToolTipScale") <= .4 then
				info.disabled = true
				info.func = nil
			else
				info.disabled = nil
				info.func = function()
					TitanSetVar(TITANREP_ID, "ToolTipScale", TitanGetVar(TITANREP_ID, "ToolTipScale") - .1)
					TitanPanelButton_UpdateButton(TITANREP_ID)
					L_CloseDropDownMenus()
					end
			end
  			L_UIDropDownMenu_AddButton(info, 3)
		end
		return
	end
	if ( L_UIDROPDOWNMENU_MENU_LEVEL == 2 ) then
		TitanPanelRightClickMenu_AddTitle2(L_UIDROPDOWNMENU_MENU_VALUE, L_UIDROPDOWNMENU_MENU_LEVEL)
		TitanPanelReputation_GatherFactions(TitanPanelReputation_BuildFactionSubMenu)
		if L_UIDROPDOWNMENU_MENU_VALUE == "Button Options" then
			info.text = TITANREP_DisplayOnRightSide
			if TitanGetVar(TITANREP_ID, "DisplayOnRightSide") then
				info.checked = 1
			else
				info.checked = nil
			end
			info.func = function()
				if TitanGetVar(TITANREP_ID, "DisplayOnRightSide") then
					TitanSetVar(TITANREP_ID, "DisplayOnRightSide", nil)
				else
					TitanSetVar(TITANREP_ID, "DisplayOnRightSide", 1)
				end
				L_CloseDropDownMenus()
				TitanPanel_InitPanelButtons()
				end
  			L_UIDropDownMenu_AddButton(info, 2)
			TitanPanelRightClickMenu_AddToggleIcon2(TITANREP_ID, L_UIDROPDOWNMENU_MENU_LEVEL)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_ShowFriendsOnBar, TITANREP_ID, "ShowFriendsOnBar","",2,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_FACTION_NAME_LABEL, TITANREP_ID, "ShowFactionName","",2,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_STANDING, TITANREP_ID, "ShowStanding","",2,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHORT_STANDING, TITANREP_ID, "ShortStanding","",2,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_VALUE, TITANREP_ID, "ShowValue","",2,true)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_PERCENT, TITANREP_ID, "ShowPercent","",2,true)
		end
		if L_UIDROPDOWNMENU_MENU_VALUE == "Tooltip Options" then
			info.disabled = nil
			info.func = nil
		       	info.hasArrow = true
		       	info.notCheckable = true
		       	info.text = "Tooltip Scale ("..(TitanGetVar(TITANREP_ID, "ToolTipScale") * 100).."%)"
		       	info.value = "Tooltip Scale"
			L_UIDropDownMenu_AddButton(info, 2)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_MINIMAL, TITANREP_ID, "Minimal")
			TitanPanelRightClickMenu_AddSpacer2(2)
		       	info.text = "Friendship Rank Settings"
		       	info.value = "Friendship Rank Settings"
			L_UIDropDownMenu_AddButton(info, 2)
		       	info.text = "Reputation Standing Settings"
		       	info.value = "Reputation Standing Settings"
			L_UIDropDownMenu_AddButton(info, 2)
			TitanPanelRightClickMenu_AddSpacer2(2)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_VALUE, TITANREP_ID, "ShowTipValue")
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_PERCENT, TITANREP_ID, "ShowTipPercent")
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_STANDING, TITANREP_ID, "ShowTipStanding")
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHORT_STANDING, TITANREP_ID, "ShortTipStanding")
			TitanPanelRightClickMenu_AddSpacer2(2)
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_STATS, TITANREP_ID, "ShowStats")
			TitanPanelRightClickMenu_AddToggleVar2(TITANREP_SHOW_SUMMARY, TITANREP_ID, "ShowSummary")
		end
		if L_UIDROPDOWNMENU_MENU_VALUE == "Color Options" then
			info.disabled = nil
			info.hasArrow = nil
			info.notCheckable = nil
			info.value = nil

			info.text = TITANREP_DEFAULT_COLORS
			info.checked = function() if TitanGetVar(TITANREP_ID, "MyColor") == 1 then return true else return nil end end
			info.func = function()
				TitanSetVar(TITANREP_ID, "MyColor", 1)
				TitanPanelButton_UpdateButton(TITANREP_ID)
				L_CloseDropDownMenus()
				end
     			L_UIDropDownMenu_AddButton(info, 2)

			info.text = TITANREP_ARMORY_COLORS
			info.checked = function() if TitanGetVar(TITANREP_ID, "MyColor") == 2 then return true else return nil end end
			info.func = function()
				TitanSetVar(TITANREP_ID, "MyColor", 2)
				TitanPanelButton_UpdateButton(TITANREP_ID)
				L_CloseDropDownMenus()
				end
     			L_UIDropDownMenu_AddButton(info, 2)

			info.text = TITANREP_NO_COLORS
			info.checked = function() if TitanGetVar(TITANREP_ID, "MyColor") == 3 then return true else return nil end end
			info.func = function()
				TitanSetVar(TITANREP_ID, "MyColor", 3)
				TitanPanelButton_UpdateButton(TITANREP_ID)
				L_CloseDropDownMenus()
				end
     			L_UIDropDownMenu_AddButton(info, 2)
		end
		return
	end
	-- level 1 menu
	TitanPanelRightClickMenu_AddTitle2(TitanPlugins[TITANREP_ID].menuText.." v"..TITANREP_VERSION)
	TitanPanelRightClickMenu_AddToggleVar(TITANREP_AUTO_CHANGE, TITANREP_ID, "AutoChange")
	TitanPanelRightClickMenu_AddToggleVar(TITANREP_BonusRepWarnings, TITANREP_ID, "BonusRepWarnings")
	TitanPanelRightClickMenu_AddToggleVar(TITANREP_SHOW_ANNOUNCE, TITANREP_ID, "ShowAnnounce")
	if(IsAddOnLoaded("MikScrollingBattleText")) then
		TitanPanelRightClickMenu_AddToggleVar(TITANREP_SHOW_ANNOUNCE_MIK, TITANREP_ID, "ShowAnnounceMik")
	end
	if(IsAddOnLoaded("Glamour")) then
		TitanPanelRightClickMenu_AddToggleVar(TITANREP_SHOW_ANNOUNCE_FRAME, TITANREP_ID, "ShowAnnounceFrame")
	end
	TitanPanelRightClickMenu_AddSpacer2()
	TitanPanelReputation_GatherFactions(TitanPanelReputation_BuildRightClickMenu)
	TitanPanelRightClickMenu_AddSpacer2()

	info.checked = nil
       	info.hasArrow = true
       	info.notCheckable = true
       	info.text = "Button Options"
       	info.value = "Button Options"
	L_UIDropDownMenu_AddButton(info, 1)

       	info.text = "Tooltip Options"
       	info.value = "Tooltip Options"
	L_UIDropDownMenu_AddButton(info, 1)

       	info.text = "Color Options"
       	info.value = "Color Options"
	L_UIDropDownMenu_AddButton(info, 1)

	TitanPanelRightClickMenu_AddSpacer2()

	info.hasArrow = false
	info.text = "Reset Session Data"
	info.value = nil
	info.func = function()
		wipe(TITANREP_RTS)
		TITANREP_TIME = GetTime()
		print("TitanReputation Session Data Reset!")
		L_CloseDropDownMenus()
		end
	L_UIDropDownMenu_AddButton(info,1)

	info.text = "Close Menu"
	info.value = "Close Menu"
	L_UIDropDownMenu_AddButton(info, 1)
end

function TitanReputationHeaderFactionToggle(name)
	local value = ""
	local found = false
	local array = TitanGetVar(TITANREP_ID, "FactionHeaders")
	for index, value in ipairs(array) do
		if (value == name) then
			found = index
		end
	end
	if(found) then
		tremove(array,found)
	else
		tinsert(array,name)
	end
	TitanSetVar(TITANREP_ID, "FactionHeaders", array)
	return
end

-- this method adds a line to the right-click menu (to build up faction headers)
function TitanPanelReputation_BuildRightClickMenu(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFrienship, factionId, hasBonusRepGain)
	if(not isInactive) then
		if(isHeader and not isCollapsed) then
			command = {}
			command.text = name
			command.value = name
			command.hasArrow = 1
			command.keepShownOnClick = 1
			command.checked = function() if (tContains(TitanGetVar(TITANREP_ID, "FactionHeaders"), name)) then return nil else return true end end
			command.func = function()
				TitanReputationHeaderFactionToggle(name)
				TitanPanelButton_UpdateButton(TITANREP_ID)
			end
			L_UIDropDownMenu_AddButton(command)
		end
	end
end

-- this method adds a line to the level2 right-click menu (to build up factions for parent header)
function TitanPanelReputation_BuildFactionSubMenu(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFriendship, factionID, hasBonusRepGain)
	local friendID , friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold 
	local adjustedId = standingID
	if isFriendship then
		friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(isFriendship)
        if not nextFriendThreshold then adjustedId = 8 end
	end

    if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then adjustedId = 9 end

	local LABEL = getglobal("FACTION_STANDING_LABEL"..standingID)
	if isFriendship then LABEL = friendTextLevel end
	if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then LABEL = TITANREP_PARAGON end
	if TitanGetVar(TITANREP_ID, "ShortTipStanding") then LABEL = strsub(LABEL,1,1) end

	if(parentName == L_UIDROPDOWNMENU_MENU_VALUE and (not isHeader or (isHeader and hasRep))) then
		command = {}
		if(MYBARCOLORS) then
			command.text = TitanUtils_GetColoredText(name.." - "..LABEL,MYBARCOLORS[(adjustedId)])
		else
			command.text = name.." - "..LABEL
		end
		command.value = name
		command.func = TitanPanelReputation_SetFaction
       		command.notCheckable = true
		L_UIDropDownMenu_AddButton(command, L_UIDROPDOWNMENU_MENU_LEVEL)
	end
end

-- this method sets the selected faction shown at titan panel
function TitanPanelReputation_SetFaction(this)
		TitanSetVar(TITANREP_ID, "TITANREP_WATCHED_FACTION", this.value)
		TitanPanelReputation_Refresh()
		TitanPanelButton_UpdateButton(TITANREP_ID)
end

-- This method refreshes the reputation data
function TitanPanelReputation_Refresh()
	if not (TitanGetVar(TITANREP_ID, "TITANREP_WATCHED_FACTION") == "none") then
		TitanPanelReputation_GatherFactions(TitanPanelReputation_BuildButtonText)
	else
		TITANREP_BUTTON_TEXT = TITANREP_NO_FACTION_LABEL
	end
end

-- This method sets the text of the button according to selected faction's data
function TitanPanelReputation_BuildButtonText(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFriendship, factionID, hasBonusRepGain)
	local friendID , friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold
	local adjustedId = standingID

	if isFriendship then
   		if not TitanGetVar(TITANREP_ID, "ShowFriendsOnBar") then
			return
		end
		friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(isFriendship)
	end

    if hasBonusRepGain then adjustedId = 9 end
    if topValue == 0 then adjustedId = 8 end

	local preface = ""
	if TitanGetVar(TITANREP_ID, "BonusRepWarnings") then
		if hasBonusRepGain then
			preface = TitanUtils_GetGreenText("+")
		elseif TITANREP_bonusRepsTable[factionID] and standingID >= 7 then
			preface = TitanUtils_GetRedText("!")
		end
	end

	local LABEL = getglobal("FACTION_STANDING_LABEL"..standingID)
	if isFriendship then LABEL = friendTextLevel end
	if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then LABEL = TITANREP_PARAGON end
	if(TitanGetVar(TITANREP_ID, "ShortStanding")) then LABEL = strsub(LABEL,1,1) end

	TitanReputationSetColor()
	if((not isHeader or (isHeader and hasRep)) and (TitanGetVar(TITANREP_ID, "TITANREP_WATCHED_FACTION")==name)) then
		TITANREP_BUTTON_TEXT = ""
		local COLOR = nil
		if(MYBARCOLORS) then
			COLOR = MYBARCOLORS[(adjustedId)]
		end

		if(TitanGetVar(TITANREP_ID, "ShowFactionName")) then
			if TitanGetVar(TITANREP_ID, "BonusRepWarnings") then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..preface
			end
			if(COLOR) then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..TitanUtils_GetColoredText(name, COLOR)
			else
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..name
			end
			if(TitanGetVar(TITANREP_ID, "ShowStanding") or
				TitanGetVar(TITANREP_ID, "ShowStanding") or
				TitanGetVar(TITANREP_ID, "ShowValue") or
				TitanGetVar(TITANREP_ID, "ShowPercent")) then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT.." - "
			end
		end

		if(TitanGetVar(TITANREP_ID, "ShowStanding")) then
			if(COLOR) then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..TitanUtils_GetColoredText(LABEL,COLOR).." "
			else
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..LABEL.." "
			end
		end
		if(TitanGetVar(TITANREP_ID, "ShowValue") and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) ) then
			if(COLOR) then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT.."["..TitanUtils_GetColoredText(earnedValue.."/"..topValue, COLOR).."] "
			else
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT.."["..earnedValue.."/"..topValue.."] "
			end
		end

		if(TitanGetVar(TITANREP_ID, "ShowPercent")and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0)) then
			if(COLOR) then
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..TitanUtils_GetColoredText(percent.."%",COLOR)
			else
				TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..percent.."%"
			end
		end

		if(not (TitanGetVar(TITANREP_ID, "ShowFactionName") or
			TitanGetVar(TITANREP_ID, "ShowStanding") or
			TitanGetVar(TITANREP_ID, "ShowValue") or
			TitanGetVar(TITANREP_ID, "ShowPercent"))) then
			TITANREP_BUTTON_TEXT = TITANREP_BUTTON_TEXT..TITANREP_ALL_HIDDEN_LABEL
		end

	end
end

-- saves all reputation value, so we can monitor what is changed
function TitanPanelReputation_GatherValues(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFriendship, factionID, hasBonusRepGain)

	if TITANREP_TABLE_INIT then
		if hasBonusRepGain then
			if TitanRep_Data["BonusRep"][factionID] then TitanRep_Data["BonusRep"][factionID] = nil end
		else
			if TITANREP_bonusRepsTable[factionID] and standingID >= 7 then
				local cname, _ = UnitName("player")
				local crealm = GetRealmName()
				if TitanRep_Data["BonusRep"][factionID] then
					TitanRep_Data["BonusRep"][factionID][cname.."-"..crealm] = standingID
				else
					TitanRep_Data["BonusRep"][factionID] = { }
					TitanRep_Data["BonusRep"][factionID][cname.."-"..crealm] = standingID
				end
			end
		end


		if((not isHeader and name) or (isHeader and hasRep)) then
			if not TITANREP_TABLE[factionID] and GetTime() - TITANREP_InitTime > 30 then		
				local adjustedId = standingID
				local msg = ""
				local dsc = "You have obtained "
				local tag = " "
				local LABEL = getglobal("FACTION_STANDING_LABEL"..standingID)
				local factionType = "Faction"

				if isFriendship then
					if not TitanGetVar(TITANREP_ID, "ShowFriendsOnBar") then return end
					local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(isFriendship)
                    if not nextFriendThreshold then adjustedId = 8 end
					LABEL = friendTextLevel
					factionType = "Friendship"
				end

                if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then 
                    adjustedId = 9 
                    LABEL = TITANREP_PARAGON
                end

				if(MYBARCOLORS) then
					msg = TitanUtils_GetColoredText(name.." - "..LABEL,MYBARCOLORS[(adjustedId)])
					dsc = dsc..TitanUtils_GetColoredText(LABEL,MYBARCOLORS[(adjustedId)])
				else
					msg = TitanUtils_GetGoldText(name.." - "..LABEL)
					dsc = dsc..TitanUtils_GetGoldText(LABEL)
				end
				dsc = dsc.." standing with "..name.."."
				msg = tag..msg..tag
				if(TitanGetVar(TITANREP_ID, "ShowAnnounce")) then
					if(IsAddOnLoaded("MikScrollingBattleText") and TitanGetVar(TITANREP_ID, "ShowAnnounceMik")) then
						MikSBT.DisplayMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t","Notification",1)
					else
						UIErrorsFrame:AddMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t", 2.0, 2.0, 0.0, 53, 30)
					end
				end
				if(TitanGetVar(TITANREP_ID, "ShowAnnounceFrame")) then
					if(IsAddOnLoaded("Glamour")) then
						local MyData = { }
						MyData.Text = name.." - "..LABEL
 						MyData.Icon = "Interface\\ICONS\\Achievement_Reputation_"..TITANREP_ICONS[(adjustedId)]
						local color = { }
						color.r = TITANREP_COLORS_ARMORY[(adjustedId)].r
						color.g = TITANREP_COLORS_ARMORY[(adjustedId)].g
						color.b = TITANREP_COLORS_ARMORY[(adjustedId)].b
						MyData.bTitle = "New "..factionType.." Discovered"
						MyData.Title = "You have discovered"
						MyData.FrameStyle = "GuildAchievement"
						MyData.BannerColor = color
						local LastAlertFrame = GlamourShowAlert(400, MyData, color, color)
					end
				end
			end
		end
	end
	if((not isHeader and name) or (isHeader and hasRep)) then
		TITANREP_TABLE[factionID] = {}
		TITANREP_TABLE[factionID].standingID = standingID
		TITANREP_TABLE[factionID].earnedValue = earnedValue
		TITANREP_TABLE[factionID].topValue= topValue
	end
end

-- gets the faction name where reputation changed
function TitanPanelReputation_GetChangedName(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, isInactive, hasRep, isChild, isFriendship, factionID, hasBonusRepGain)
	local earnedAmount = 0
	local friendID , friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold
	local adjustedId = standingID
	local factionType = "Faction Standing"

	if isFriendship then
		friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(isFriendship)
        if not nextFriendThreshold then adjustedId = 8 end
		if not TitanGetVar(TITANREP_ID, "ShowFriendsOnBar") then return	end
		factionType = "Friendship Ranking"
	end

    if hasBonusRepGain  then adjustedId = 9 end

	local LABEL = getglobal("FACTION_STANDING_LABEL"..standingID)

	if isFriendship then LABEL = friendTextLevel end
    if hasBonusRepGain and not (isFriendship and not nextFriendThreshold) and not (adjustedId >= 8 and topValue == 0) then LABEL = TITANREP_PARAGON end

	if(not (factionID == gFactionID) and TITANREP_TABLE[factionID]) then
		if(GetTime() - TITANREP_InitTime > 30 and (TITANREP_TABLE[factionID].standingID < standingID) or (TITANREP_TABLE[factionID].earnedValue ~= earnedValue)) then
			local msg = ""
			local dsc = "You have obtained "
			local tag = " "
			if(TITANREP_TABLE[factionID].standingID < standingID) then
				if(MYBARCOLORS) then
					msg = TitanUtils_GetColoredText(name.." - "..LABEL,MYBARCOLORS[(adjustedId)])
					dsc = dsc..TitanUtils_GetColoredText(LABEL,MYBARCOLORS[(adjustedId)])
				else
					msg = TitanUtils_GetGoldText(name.." - "..LABEL)
					dsc = dsc..TitanUtils_GetGoldText(LABEL)
				end
				dsc = dsc.." standing with "..name.."."
				msg = tag..msg..tag
				if(TitanGetVar(TITANREP_ID, "ShowAnnounce")) then
					if(IsAddOnLoaded("MikScrollingBattleText") and TitanGetVar(TITANREP_ID, "ShowAnnounceMik")) then
						MikSBT.DisplayMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t","Notification",1)
					else
						UIErrorsFrame:AddMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t", 2.0, 2.0, 0.0, 53, 30)
					end
				end
				if(TitanGetVar(TITANREP_ID, "ShowAnnounceFrame")) then
					if(IsAddOnLoaded("Glamour")) then
							local MyData = { }
							MyData.Text = name.." - "..LABEL
	 						MyData.Icon = "Interface\\ICONS\\Achievement_Reputation_"..TITANREP_ICONS[(adjustedId)]
							local color = { }
							color.r = TITANREP_COLORS_ARMORY[(adjustedId)].r
							color.g = TITANREP_COLORS_ARMORY[(adjustedId)].g
							color.b = TITANREP_COLORS_ARMORY[(adjustedId)].b
							MyData.bTitle = factionType.." Upgrade"
							MyData.Title = ""
							MyData.FrameStyle = "GuildAchievement"
							MyData.BannerColor = color
							local LastAlertFrame = GlamourShowAlert(400, MyData, color, color)
					end
				end
				earnedAmount = TITANREP_TABLE[factionID].topValue - TITANREP_TABLE[factionID].earnedValue
				earnedAmount = earnedValue + earnedAmount
			elseif(TITANREP_TABLE[factionID].standingID > standingID) then
				if(MYBARCOLORS) then
					msg = TitanUtils_GetColoredText(name.." - "..LABEL,MYBARCOLORS[(adjustedId)])
					dsc = dsc..TitanUtils_GetColoredText(LABEL,MYBARCOLORS[(adjustedId)])
				else
					msg = TitanUtils_GetGoldText(name.." - "..LABEL)
					dsc = dsc..TitanUtils_GetGoldText(LABEL)
				end
				dsc = dsc.." standing with "..name.."."
				msg = tag..msg..tag
				if(TitanGetVar(TITANREP_ID, "ShowAnnounce")) then
					if(IsAddOnLoaded("MikScrollingBattleText") and TitanGetVar(TITANREP_ID, "ShowAnnounceMik")) then
						MikSBT.DisplayMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t","Notification",1)
					else
						UIErrorsFrame:AddMessage("|T"..TITANREP_BUTTON_ICON..":32|t"..msg.."|T"..TITANREP_BUTTON_ICON..":32|t", 2.0, 2.0, 0.0, 53, 30)
					end
				end
				if(TitanGetVar(TITANREP_ID, "ShowAnnounceFrame")) then
					if(IsAddOnLoaded("Glamour")) then
							local MyData = { }
							MyData.Text = name.." - "..LABEL
	 						MyData.Icon = "Interface\\ICONS\\Achievement_Reputation_"..TITANREP_ICONS[(adjustedId)]
							local color = { }
							color.r = TITANREP_COLORS_ARMORY[(adjustedId)].r
							color.g = TITANREP_COLORS_ARMORY[(adjustedId)].g
							color.b = TITANREP_COLORS_ARMORY[(adjustedId)].b
							MyData.bTitle = factionType.." Downgrade"
							MyData.Title = ""
							MyData.FrameStyle = "GuildAchievement"
							MyData.BannerColor = color
							local LastAlertFrame = GlamourShowAlert(400, MyData, color, color)
					end
				end
				earnedAmount = earnedValue - topValue
				earnedAmount = earnedAmount - TITANREP_TABLE[factionID].earnedValue
			elseif(TITANREP_TABLE[factionID].standingID == standingID) then
				if(TITANREP_TABLE[factionID].earnedValue < earnedValue) then
					earnedAmount = earnedValue - TITANREP_TABLE[factionID].earnedValue
				else
					earnedAmount = earnedValue - TITANREP_TABLE[factionID].earnedValue
				end
			end
			if TITANREP_RTS[name] then
				TITANREP_RTS[name] = TITANREP_RTS[name] + earnedAmount
			else
				TITANREP_RTS[name] = earnedAmount
			end
			if earnedAmount > 0 then
				if TITANREP_HIGHCHANGED < earnedAmount  then
					TITANREP_HIGHCHANGED = earnedAmount
					TITANREP_CHANGEDFACTION = name
				end
			elseif earnedAmount < 0 then
				if TITANREP_HIGHCHANGED > earnedAmount and TITANREP_HIGHCHANGED < 0 then
					TITANREP_HIGHCHANGED = earnedAmount
					TITANREP_CHANGEDFACTION = name
				end
			else
				TITANREP_CHANGEDFACTION = name
			end
		end
	end
end

-- This method looks up all factions, and calls 'method' with faction parameters
function TitanPanelReputation_GatherFactions(method)
		local count = GetNumFactions()
        if not count then return end
		local done = false
		local index = 1
		local parentName = ""
		local friendID
		while(not done)do
			local name, description, standingID, bottomValue, topValue, earnedValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep,
				isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(index)
			local friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
			local value

			-- Normalize values
			topValue = topValue - bottomValue
			earnedValue = earnedValue - bottomValue
			bottomValue = 0

            
            -- BonusRep Compatibility :: Issue #27 :: Code Provided by: SLOKnightfall
            if (factionID and C_Reputation.IsFactionParagon(factionID)) then
                 earnedValue, topValue, rewardQuestID, hasRewardPending = C_Reputation.GetFactionParagonInfo(factionID)
                 while(earnedValue > topValue) do
                     earnedValue = earnedValue - topValue
                 end
                 hasBonusRepGain  = true
            end

			percent = format("%.2f",(earnedValue/topValue)*100)
			if(percent:len()<5) then percent = "0"..percent; end

			if(isHeader) then parentName = name; end
			
            method(name, parentName, standingID, topValue, earnedValue, percent, isHeader, isCollapsed, IsFactionInactive(index), hasRep, isChild, friendID, factionID, hasBonusRepGain)
			
            index = index+1
			
            if(index>count) then done = true; end
		end
end
