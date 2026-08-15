
local Plater = Plater
local addonId, platerInternal = ...
---@type detailsframework
local DF = DetailsFramework
local _

--> cvars just to make them easier to read
local CVAR_ENABLED = "1"
local CVAR_DISABLED = "0"

--> cache some common used member strings for better reading
local MEMBER_UNITID = "namePlateUnitToken"
local MEMBER_GUID = "namePlateUnitGUID"
local MEMBER_NPCID = "namePlateNpcId"
local MEMBER_QUEST = "namePlateIsQuestObjective"
local MEMBER_REACTION = "namePlateUnitReaction"
local MEMBER_RANGE = "namePlateInRange"
local MEMBER_NOCOMBAT = "namePlateNoCombat"
local MEMBER_NAME = "namePlateUnitName"
local MEMBER_NAMELOWER = "namePlateUnitNameLower"
local MEMBER_TARGET = "namePlateIsTarget"

local LDB = LibStub ("LibDataBroker-1.1", true)
local LDBIcon = LDB and LibStub ("LibDBIcon-1.0", true)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--> slash commands ~slash

SLASH_PLATER1 = "/plater"
SLASH_PLATER2 = "/nameplate"
SLASH_PLATER3 = "/nameplates"

-- ~cvar
local cvarDiagList = {
	"nameplateMaxDistance",
	"nameplateOtherTopInset",
	"nameplateOtherAtBase",
	"nameplateMinAlpha",
	"nameplateMinAlphaDistance",
	"nameplateShowAll",
	"nameplateShowEnemies",
	"nameplateShowEnemyMinions",
	"nameplateShowEnemyMinus",
	"nameplateShowFriends",
	"nameplateShowFriendlyGuardians",
	"nameplateShowFriendlyPets",
	"nameplateShowFriendlyTotems",
	"nameplateShowFriendlyMinions",
	"NamePlateHorizontalScale",
	"NamePlateVerticalScale",
}

function SlashCmdList.PLATER (msg, editbox)

	local optionsTabNumber = tonumber(msg)
	if (optionsTabNumber) then
		Plater.OpenOptionsPanel(optionsTabNumber)
		return
	end

	if (msg == "version") then
		Plater.GetVersionInfo(true)
		return

	elseif (msg == "showlogs") then
		---@type {_general_logs: string[], _error_logs: string[]}
		local logTable = platerInternal.Logs.GetLogs()
		local generalLogs = logTable._general_logs
		local errorLogs = logTable._error_logs

		---@type string[]
		local outputTable = {}

		if (#generalLogs > 0) then
			outputTable[#outputTable+1] = "General Logs:"
			for i = 1, #generalLogs do
				outputTable[#outputTable+1] = (generalLogs[i])
			end
		end

		outputTable[#outputTable+1] = " "

		if (#errorLogs > 0) then
			outputTable[#outputTable+1] = "Error Logs:"
			for i = 1, #errorLogs do
				outputTable[#outputTable+1] = (errorLogs[i])
			end
		end

		dumpt(outputTable) --this is a function from details! too buzy right now to thing on another function
		return

	elseif (msg == "dignostico" or msg == "diag" or msg == "debug") then

		print ("Plater Diagnostic:")
		for i = 1, #cvarDiagList do
			local cvar = cvarDiagList [i]
			print ("|cFFC0C0C0" .. cvar, "|r->", GetCVar(cvar))
		end

		local alphaPlateFrame = "there's no nameplate in the screen"
		local alphaUnitFrame = ""
		local alphaHealthFrame = ""
		local testPlate

		for _, plateFrame in ipairs (Plater.GetAllShownPlates()) do
			if (plateFrame [MEMBER_REACTION] < 4) then
				testPlate = plateFrame
				alphaPlateFrame = plateFrame:GetAlpha()
				alphaUnitFrame = plateFrame.unitFrame:GetAlpha()
				alphaHealthFrame = plateFrame.unitFrame.healthBar:GetAlpha()
				break
			end
		end

		print ("|cFFC0C0C0Alpha|r", "->", alphaPlateFrame, "-", alphaUnitFrame, "-", alphaHealthFrame)

		if (testPlate) then
			local w, h = testPlate:GetSize()
			print ("|cFFC0C0C0Size|r", "->", w, h, "-", testPlate.unitFrame.healthBar:GetSize())

			local point1, anchorFrame, point2, x, y = testPlate:GetPoint (1)
			print ("|cFFC0C0C0Point|r", "->", point1, anchorFrame:GetName(), point2, x, y)

			local plateIsShown = testPlate:IsShown() and "yes" or "no"
			local unitFrameIsShown = testPlate.unitFrame:IsShown() and "yes" or "no"
			local healthBarIsShown = testPlate.unitFrame.healthBar:IsShown() and "yes" or "no"
			print ("|cFFC0C0C0ShownStatus|r", "->", plateIsShown, "-", unitFrameIsShown, "-", healthBarIsShown)
		else
			print ("|cFFC0C0C0Size|r", "-> there's no nameplate in the screen")
			print ("|cFFC0C0C0Point|r", "-> there's no nameplate in the screen")
			print ("|cFFC0C0C0ShownStatus|r", "-> there's no nameplate in the screen")
		end

		return

	elseif (msg == "color" or msg == "colors") then
		Plater.OpenColorFrame()
		return

	elseif (msg == "npcs" or msg == "ids") then

	elseif (msg == "editmode") then
		Plater.ToggleDesignerWindow() --not yet
		return

	--elseif (msg == "add" or msg == "addnpc") then
	elseif (msg and (msg:find("^add") or msg:find("^addnpc"))) then
		local idStr = msg:gsub("^addnpc ?", ""):gsub("^add ?", "")
		local id = tonumber(idStr)
		if id then
			if Plater.db.profile.npc_cache[id] then
				print("ID", id, "已添加.")
				return
			end
			-- get npc info and add, zone unknown
			local function GetCreatureNameFromID(npcID)
				if C_TooltipInfo then
					local info = C_TooltipInfo.GetHyperlink(("unit:Creature-0-0-0-0-%d"):format(npcID))
					local leftText = info and info.lines and info.lines[1] and info.lines[1].leftText
					if leftText and leftText ~= _G.UNKNOWN then
						return leftText
					end
				else
					local tooltipFrame = GetCreatureNameFromIDFinderTooltip or CreateFrame ("GameTooltip", "GetCreatureNameFromIDFinderTooltip", nil, "GameTooltipTemplate")
					tooltipFrame:SetOwner (WorldFrame, "ANCHOR_NONE")
					tooltipFrame:SetHyperlink (("unit:Creature-0-0-0-0-%d"):format(npcID))
					local npcNameLine = _G ["GetCreatureNameFromIDFinderTooltipTextLeft1"]
					return npcNameLine and npcNameLine:GetText()
				end
			end
			
			local translator = {}
			translator.retries = 0
			local translate = function()
				translator.retries = translator.retries + 1
				if translator.retries > 10 then return end
				local npcName = GetCreatureNameFromID(id)
				if npcName then
					print("添加", id, "为", npcName)
					Plater.db.profile.npc_cache[id] = {npcName, "UNKNOWN", Plater.Locale or "enUS"}
				else
					print("添加:,", id, "尝试重新获取名称...")
					C_Timer.After(0.25, translator.translate)
				end
			end
			translator.translate = function()
				translate()
			end
			
			translator.translate()
			
			return
		end
		
		local plateFrame = C_NamePlate.GetNamePlateForUnit ("target")

		if (plateFrame) then
			local npcId = plateFrame [MEMBER_NPCID]
			if (npcId) then
				local colorDB = Plater.db.profile.npc_cache
				if (not colorDB [npcId]) then
					Plater.db.profile.npc_cache [npcId] = {plateFrame [MEMBER_NAME] or "UNKNOWN", Plater.ZoneName or "UNKNOWN", Plater.Locale or "enUS"}
					Plater:Msg ("添加单位.")

					if (PlaterOptionsPanelFrame and PlaterOptionsPanelFrame:IsShown()) then
						PlaterOptionsPanelContainerColorManagementColorsScroll:Hide()
						C_Timer.After (.2, function()
							PlaterOptionsPanelContainerColorManagementColorsScroll:Show()
						end)
					end

				else
					Plater:Msg ("已添加单位.")
				end
			else
				Plater:Msg ("无效的 npc 姓名版.")
			end
		else
			Plater:Msg ("需要锁定一个角色否则无法找到角色姓名版.")
		end

		return

	elseif (msg == "rare") then
		local waitTick = function(tickerObject)
			for _, plateFrame in ipairs (Plater.GetAllShownPlates()) do
				local unitClassification = UnitClassification(plateFrame.unitFrame[MEMBER_UNITID])
				if (unitClassification == "rareelite") then
					FlashClientIcon()
					Plater:Msg("(debug) rare spawned!")
				end
			end
		end

		if (not Plater.rare_ticker) then
			Plater:Msg("当稀有生物出现时 Plater 会闪烁任务栏上的 wow 图标.")
			Plater.rare_ticker = _G.C_Timer.NewTicker(3, waitTick)
		else
			Plater.rare_ticker:Cancel()
			Plater.rare_ticker = nil
			Plater:Msg("Plater 不再寻找稀有物品.")
		end

		return

	elseif (msg == "profstart" or msg == "profstartcore" or msg == "profstartadvance") then
		Plater.EnableProfiling(true)

		return

	elseif (msg == "profstartmods") then
		Plater.EnableProfiling(false)

		return

	elseif (msg == "profstop") then
		Plater.DisableProfiling()

		return

	elseif (msg == "profprint") then
		Plater.ShowPerfData()

		return

	elseif (msg == "minimap") then
		PlaterDBChr.minimap.hide = not PlaterDBChr.minimap.hide

		if (PlaterDBChr.minimap.hide) then
			LDBIcon:Hide ("Plater")
		else
			LDBIcon:Show ("Plater")
		end
		LDBIcon:Refresh ("Plater", PlaterDBChr.minimap)

		return

	elseif (msg == "compartment") then

		if LDBIcon:IsButtonInCompartment("Plater") then
			LDBIcon:RemoveButtonFromCompartment("Plater")
		else
			LDBIcon:AddButtonToCompartment("Plater")
		end

		return

	elseif (msg and msg:find("^cvar[s]?")) then
		Plater.DebugCVars(msg:gsub("^cvar[s]? ?", ""))
		return
	
	elseif (msg and msg:find("^resetcvar[s]?")) then
		Plater.ResetCVars(msg:gsub("^cvar[s]? ?", ""))
		return
	
	elseif (msg == "uninstall") then
		Plater.ResetCVars()
		C_AddOns.DisableAddOn("Plater", UnitName("player"))
		ReloadUI()

	elseif msg ~= "" then
		local usage = "使用说明:"
		usage = usage .. "\n|cffffaeae/plater|r : 打开 Plater 选项窗口"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33version|r: 打印 Plater 版本信息"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33profstart|r: 启动 Plater 剖析"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33profstop|r: 停止 Plater 剖析"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33profprint|r: 打印收集到的剖析信息"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33add|r: 将目标单位添加到 NPC 缓存中"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33colors|r: 打开 Plater 调色板"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33minimap|r: 切换 Plater 小地图图标"
		usage = usage .. "\n|cffffaeae/plater|r |compartment|r: 切换 Plater 插件隔间图标"
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33cvar <cvar name>|r: 打印配置文件中存储的 cvar 值的相关信息."
		usage = usage .. "\n|cffffaeae/plater|r |cffffff33resetcvar(s) <cvar name>|r: 给定或所有相关 cvars 重置为本次会话的默认值"
		usage = usage .. "\n|cffffaeae版本:|r |cffffff33" .. Plater.GetVersionInfo() .. "|r"
		Plater:Msg(usage)
		return

	end

	Plater.OpenOptionsPanel()
end