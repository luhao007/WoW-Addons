---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2020  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------

local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS or Constants.ChatFrameConstants.MaxChatWindows

local Chat_GetChatFrame = _G.Chat_GetChatFrame or _G.ChatFrameUtil.GetChatFrame

local ChatEdit_DeactivateChat = _G.ChatEdit_DeactivateChat or _G.ChatFrameUtil.DeactivateChat

local ChatFrame_AddNewCommunitiesChannel = _G.ChatFrame_AddNewCommunitiesChannel or _G.ChatFrameUtil.AddNewCommunitiesChannel
local ChatFrame_RemoveAllMessageGroups = _G.ChatFrame_RemoveAllMessageGroups or _G.ChatFrameMixin.RemoveAllMessageGroups
local ChatFrame_AddMessageGroup = _G.ChatFrame_AddMessageGroup or _G.ChatFrameMixin.AddMessageGroup
local ChatFrame_RemoveAllChannels = _G.ChatFrame_RemoveAllChannels or _G.ChatFrameMixin.RemoveAllChannels
local ChatFrame_ReceiveAllPrivateMessages = _G.ChatFrame_ReceiveAllPrivateMessages or _G.ChatFrameMixin.ReceiveAllPrivateMessages

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("Memory", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
	-- define localized strings
	local PL = module.PL

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			frames = { ["*"] = {} },
			types = {},
			cvars = {},
			autoload = false
		}
	})

	--[==[@debug@
	PL:AddLocale("enUS", {
		["module_name"] = "Memory",
		["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters",
		module_info = "|cffff8888THIS MODULE IS EXPERIMENTAL|r \n\n This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters",
		autoload_name = "Load Settings Automatically",
		autoload_desc = "Automatically load the saved settings when you log in",
		load_name = "Load Settings",
		load_desc = "Load the chat frame/tabs from the last save",
		save_name = "Save Settings",
		save_desc = "Save the current chat frame/tab configuration",
		msg_nosettings = "No stored settings",
		msg_settingsloaded = "Settings Loaded",
		command_header_name = "Commands",
		options_header_name = "Options",
		msg_loadfailed = "Could not fully restore the chat settings"
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Memory
L["autoload_desc"] = "Automatically load the saved settings when you log in"
L["autoload_name"] = "Load Settings Automatically"
L["command_header_name"] = "Commands"
L["load_desc"] = "Load the chat frame/tabs from the last save"
L["load_name"] = "Load Settings"
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
L["module_name"] = "Memory"
L["msg_loadfailed"] = "Could not fully restore the chat settings"
L["msg_nosettings"] = "No stored settings"
L["msg_settingsloaded"] = "Settings Loaded"
L["options_header_name"] = "Options"
L["save_desc"] = "Save the current chat frame/tab configuration"
L["save_name"] = "Save Settings"

  PL:AddLocale("enUS", L)



  L = {}
  -- Memory
--[[Translation missing --]]
L["autoload_desc"] = "Automatically load the saved settings when you log in"
--[[Translation missing --]]
L["autoload_name"] = "Load Settings Automatically"
--[[Translation missing --]]
L["command_header_name"] = "Commands"
--[[Translation missing --]]
L["load_desc"] = "Load the chat frame/tabs from the last save"
--[[Translation missing --]]
L["load_name"] = "Load Settings"
--[[Translation missing --]]
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
--[[Translation missing --]]
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
--[[Translation missing --]]
L["module_name"] = "Memory"
--[[Translation missing --]]
L["msg_loadfailed"] = "Could not fully restore the chat settings"
--[[Translation missing --]]
L["msg_nosettings"] = "No stored settings"
--[[Translation missing --]]
L["msg_settingsloaded"] = "Settings Loaded"
--[[Translation missing --]]
L["options_header_name"] = "Options"
--[[Translation missing --]]
L["save_desc"] = "Save the current chat frame/tab configuration"
--[[Translation missing --]]
L["save_name"] = "Save Settings"

  PL:AddLocale("itIT", L)



  L = {}
  -- Memory
--[[Translation missing --]]
L["autoload_desc"] = "Automatically load the saved settings when you log in"
--[[Translation missing --]]
L["autoload_name"] = "Load Settings Automatically"
--[[Translation missing --]]
L["command_header_name"] = "Commands"
--[[Translation missing --]]
L["load_desc"] = "Load the chat frame/tabs from the last save"
--[[Translation missing --]]
L["load_name"] = "Load Settings"
--[[Translation missing --]]
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
--[[Translation missing --]]
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
--[[Translation missing --]]
L["module_name"] = "Memory"
--[[Translation missing --]]
L["msg_loadfailed"] = "Could not fully restore the chat settings"
--[[Translation missing --]]
L["msg_nosettings"] = "No stored settings"
--[[Translation missing --]]
L["msg_settingsloaded"] = "Settings Loaded"
--[[Translation missing --]]
L["options_header_name"] = "Options"
--[[Translation missing --]]
L["save_desc"] = "Save the current chat frame/tab configuration"
--[[Translation missing --]]
L["save_name"] = "Save Settings"

  PL:AddLocale("ptBR", L)



  L = {}
  -- Memory
--[[Translation missing --]]
L["autoload_desc"] = "Automatically load the saved settings when you log in"
--[[Translation missing --]]
L["autoload_name"] = "Load Settings Automatically"
--[[Translation missing --]]
L["command_header_name"] = "Commands"
--[[Translation missing --]]
L["load_desc"] = "Load the chat frame/tabs from the last save"
--[[Translation missing --]]
L["load_name"] = "Load Settings"
--[[Translation missing --]]
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
--[[Translation missing --]]
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
--[[Translation missing --]]
L["module_name"] = "Memory"
--[[Translation missing --]]
L["msg_loadfailed"] = "Could not fully restore the chat settings"
--[[Translation missing --]]
L["msg_nosettings"] = "No stored settings"
--[[Translation missing --]]
L["msg_settingsloaded"] = "Settings Loaded"
--[[Translation missing --]]
L["options_header_name"] = "Options"
--[[Translation missing --]]
L["save_desc"] = "Save the current chat frame/tab configuration"
--[[Translation missing --]]
L["save_name"] = "Save Settings"

  PL:AddLocale("frFR", L)



  L = {}
  -- Memory
L["autoload_desc"] = "Ladet die gespeicherten Einstellungen automatisch, wenn du dich anmeldest"
L["autoload_name"] = "Einstellungen automatisch laden"
L["command_header_name"] = "Befehle"
L["load_desc"] = "Ladet den Chat-Rahmen/Registerkarten aus der letzten Speicherung"
L["load_name"] = "Einstellungen laden"
L["module_desc"] = "Unterstützt das Speichern der Blizzard-Chat Einstellungen in deinem Profil, damit sie für alle deine Charaktere synchronisiert werden können"
L["module_info"] = "|cffff8888DIESES MODUL IST EXPERIMENTELL|r Mit diesem Modul kannst du alle deine Chat-Einstellungen und deine Rahmenanordnung laden/speichern. Diese Einstellungen können auf jeden deiner Charaktere geladen werden"
L["module_name"] = "Erinnerung"
L["msg_loadfailed"] = "Die Chat-Einstellungen konnten nicht vollständig wiederhergestellt werden"
L["msg_nosettings"] = "Keine gespeicherten Einstellungen"
L["msg_settingsloaded"] = "Einstellungen geladen"
L["options_header_name"] = "Optionen"
L["save_desc"] = "Speichert die aktuelle Konfiguration des Chat-Rahmens/Registerkarte"
L["save_name"] = "Einstellungen speichern"

  PL:AddLocale("deDE", L)



  L = {}
  -- Memory
L["autoload_desc"] = "로그인시 저장된 설정을 자동으로 불러옵니다."
L["autoload_name"] = "자동 설정 불러오기"
L["command_header_name"] = "명령어"
L["load_desc"] = "마지막 저장에서 대화창/탭을 불러옴"
L["load_name"] = "불러오기 설정"
L["module_desc"] = "블리자드 채팅 설정을 프로필에 저장하여 모든 캐릭터와 동기화 할 수 있도록 지원"
L["module_info"] = "|cffff8888이 모듈은 실험적입니다.|r 이 모듈을 사용하면 모든 채팅 설정 및 프레임 모양을 불러오기/저장할 수 있습니다. 이 설정은 모든 캐릭터에서 불러오기 할 수 있습니다."
L["module_name"] = "메모리 [Memory]"
L["msg_loadfailed"] = "대화 설정을 완전히 복구하지 못했습니다"
L["msg_nosettings"] = "저장된 설정 없음"
L["msg_settingsloaded"] = "설정 불러옴"
L["options_header_name"] = "옵션"
L["save_desc"] = "정확한 대화창/탭 구성을 저장"
L["save_name"] = "저장 설정"

  PL:AddLocale("koKR",  L)


  L = {}
  -- Memory
--[[Translation missing --]]
L["autoload_desc"] = "Automatically load the saved settings when you log in"
--[[Translation missing --]]
L["autoload_name"] = "Load Settings Automatically"
--[[Translation missing --]]
L["command_header_name"] = "Commands"
--[[Translation missing --]]
L["load_desc"] = "Load the chat frame/tabs from the last save"
--[[Translation missing --]]
L["load_name"] = "Load Settings"
--[[Translation missing --]]
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
--[[Translation missing --]]
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
--[[Translation missing --]]
L["module_name"] = "Memory"
--[[Translation missing --]]
L["msg_loadfailed"] = "Could not fully restore the chat settings"
--[[Translation missing --]]
L["msg_nosettings"] = "No stored settings"
--[[Translation missing --]]
L["msg_settingsloaded"] = "Settings Loaded"
--[[Translation missing --]]
L["options_header_name"] = "Options"
--[[Translation missing --]]
L["save_desc"] = "Save the current chat frame/tab configuration"
--[[Translation missing --]]
L["save_name"] = "Save Settings"

  PL:AddLocale("esMX",  L)


  L = {}
  -- Memory
L["autoload_desc"] = "Автоматически загружать сохраненные настройки при входе в систему"
L["autoload_name"] = "Загружать настройки автоматически"
L["command_header_name"] = "Команды "
L["load_desc"] = "Загрузить фрейм/вкладки чата из последнего сохранения"
L["load_name"] = "Загрузить настройки"
L["module_desc"] = "Поддержите сохранение настроек чата Blizzard в вашем профиле, чтобы их можно было синхронизировать со всеми вашими персонажами."
L["module_info"] = "|cffff8888 ЭТОТ МОДУЛЬ ЯВЛЯЕТСЯ ЭКСПЕРИМЕНТАЛЬНЫМ|r Этот модуль позволяет загружать/сохранять все настройки чата и разметки. Эти настройки можно загрузить на любого из ваших персонажей."
L["module_name"] = "Память"
L["msg_loadfailed"] = "Не удалось полностью восстановить настройки чата"
L["msg_nosettings"] = "Нет сохраненных настроек"
L["msg_settingsloaded"] = "Настройки загружены"
L["options_header_name"] = "Параметры "
L["save_desc"] = "Сохраните текущую конфигурацию фрейма/вкладки чата"
L["save_name"] = "Сохранить настройки"

  PL:AddLocale("ruRU",  L)


  L = {}
  -- Memory
L["autoload_desc"] = "登录时自动加载保存过的设置"
L["autoload_name"] = "自动加载设置"
L["command_header_name"] = "命令"
L["load_desc"] = "加载上次保存的聊天框/标签"
L["load_name"] = "加载设置"
L["module_desc"] = "支持将官方聊天设置保存到你的个人设置中，以便你可以在所有角色之间进行同步。"
L["module_info"] = [=[|cffff8888此模块是实验性的|r 
 该模块允许你加载/保存所有的聊天设置和框体布局。这些设置可以导入到你的其他账号内]=]
L["module_name"] = "内存"
L["msg_loadfailed"] = "无法完全恢复聊天设置"
L["msg_nosettings"] = "没有保存的设置"
L["msg_settingsloaded"] = "设置已加载"
L["options_header_name"] = "选项"
L["save_desc"] = "保存当前的聊天框/标签设置"
L["save_name"] = "保存设置"

  PL:AddLocale("zhCN",  L)


  L = {}
  -- Memory
--[[Translation missing --]]
L["autoload_desc"] = "Automatically load the saved settings when you log in"
--[[Translation missing --]]
L["autoload_name"] = "Load Settings Automatically"
--[[Translation missing --]]
L["command_header_name"] = "Commands"
--[[Translation missing --]]
L["load_desc"] = "Load the chat frame/tabs from the last save"
--[[Translation missing --]]
L["load_name"] = "Load Settings"
--[[Translation missing --]]
L["module_desc"] = "Support saving the Blizzard chat settings to your profile so they can be synced across all your characters"
--[[Translation missing --]]
L["module_info"] = [=[|cffff8888THIS MODULE IS EXPERIMENTAL|r 

 This module allows you to load/save all your chat settings and frame layout. These settings can be loaded on any of your characters]=]
--[[Translation missing --]]
L["module_name"] = "Memory"
--[[Translation missing --]]
L["msg_loadfailed"] = "Could not fully restore the chat settings"
--[[Translation missing --]]
L["msg_nosettings"] = "No stored settings"
--[[Translation missing --]]
L["msg_settingsloaded"] = "Settings Loaded"
--[[Translation missing --]]
L["options_header_name"] = "Options"
--[[Translation missing --]]
L["save_desc"] = "Save the current chat frame/tab configuration"
--[[Translation missing --]]
L["save_name"] = "Save Settings"

  PL:AddLocale("esES",  L)


  L = {}
  -- Memory
L["autoload_desc"] = "登录时自动加载保存过的设置"
L["autoload_name"] = "自动加载设置"
L["command_header_name"] = "命令"
L["load_desc"] = "加载上次保存的聊天框/标签"
L["load_name"] = "加载设置"
L["module_desc"] = "支持将官方聊天设置保存到你的个人设置中，以便你可以在所有角色之间进行同步。"
L["module_info"] = [=[|cffff8888此模块是实验性的|r 
 该模块允许你加载/保存所有的聊天设置和框体布局。这些设置可以导入到你的其他账号内]=]
L["module_name"] = "内存"
L["msg_loadfailed"] = "无法完全恢复聊天设置"
L["msg_nosettings"] = "没有保存的设置"
L["msg_settingsloaded"] = "设置已加载"
L["options_header_name"] = "选项"
L["save_desc"] = "保存当前的聊天框/标签设置"
L["save_name"] = "保存设置"

  PL:AddLocale("zhTW",  L)
  end
  --@end-non-debug@

	Prat:SetModuleOptions(module.name, {
		name = PL.module_name,
		desc = PL.module_desc,
		type = "group",
		args = {
			info = {
				name = PL.module_info,
				type = "description",
			},
			command_header = {
				name = PL.command_header_name,
				type = "header",
				order = 190,
			},
			save = {
				name = PL.save_name,
				desc = PL.save_desc,
				type = "execute",
				order = 191,
				func = "SaveSettings"
			},
			load = {
				name = PL.load_name,
				desc = PL.load_desc,
				type = "execute",
				order = 190,
				func = "LoadSettings"
			},
			options_header = {
				name = PL.options_header_name,
				type = "header",
				order = 195,
			},
			autoload = {
				name = PL.autoload_name,
				desc = PL.autoload_desc,
				type = "toggle",
				order = 200,
			}
		}
	})

	local cvars = {
		whisperMode = "CVar",
		chatStyle = "CVar",
		wholeChatWindowClickable = "CVarBool",
		blockChannelInvites = "CVarBool"
	}

	Prat:SetModuleInit(module.name,
		function(self)
			self:RegisterEvent("PLAYER_ENTERING_WORLD")
		end)

	function module:PLAYER_ENTERING_WORLD()
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
		self.ready = true
		if self.needsLoading then
			self:ScheduleTimer("LoadSettings", 0)
		end
	end

	function module:OnModuleEnable()
		if not self.working and self.db.profile.autoload and next(self.db.profile.frames) then
			if not self.ready then
				self.needsLoading = true
			else
				self:ScheduleTimer("LoadSettings", 0)
			end
		end

		Prat.RegisterChatEvent(self, Prat.Events.PRE_ADDMESSAGE)
	end

	function module:SaveSettings()
		local db = self.db.profile

		wipe(db.frames)

		for i = 1, NUM_CHAT_WINDOWS do
			self:SaveSettingsForFrame(i)
		end

		db.types = CopyTable(getmetatable(ChatTypeInfo).__index)
		db.channels = { GetChannelList() }

		for k, v in pairs(cvars) do
			db.cvars[k] = _G["Get" .. v](k)
		end

		self:Output("Settings Saved")
	end

	function module:SaveSettingsForFrame(frameId)
		local db = self.db.profile.frames[frameId]

		local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(frameId)
		db.name, db.fontSize, db.r, db.g, db.b, db.alpha, db.shown, db.locked, db.docked, db.uninteractable = name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable

		local f = Chat_GetChatFrame(frameId)
		db.minimized = f.minimized
		if f.minFrame then
			db.minframe = {}
			for i = 1, f.minFrame:GetNumPoints() do
				local point, relativeTo, relativePoint, xoff, yoff = f.minFrame:GetPoint(i)
				db.minframe[#db.minframe + 1] = { point, (type(relativeTo) == "table") and relativeTo:GetName() or relativeTo, relativePoint, xoff, yoff }
			end
		end
		db.messages = { GetChatWindowMessages(frameId) }
		db.channels = { GetChatWindowChannels(frameId) }

		local width, height = GetChatWindowSavedDimensions(frameId);
		local point, xOffset, yOffset = GetChatWindowSavedPosition(frameId)

		db.point, db.xOffset, db.yOffset, db.width, db.height = point, xOffset, yOffset, width, height
	end

	-- Warning: This function causes taint with DF edit mode
	function module:LoadFrameSettingsForFrame(frameId)
		local db = self.db.profile.frames[frameId]
		local success = true
		local f = Chat_GetChatFrame(frameId)

		if not db.shown and not db.docked then
			FCF_Close(f)
			return success
		end

		if f.minimized then
			FCF_MaximizeFrame(f)
		end

		-- Restore FloatingChatFrame
		SetChatWindowName(frameId, db.name)
		SetChatWindowSize(frameId, db.fontSize)
		SetChatWindowColor(frameId, db.r, db.g, db.b)
		SetChatWindowAlpha(frameId, db.alpha)
		SetChatWindowDocked(frameId, db.docked)
		SetChatWindowLocked(frameId, db.locked)
		SetChatWindowUninteractable(frameId, db.uninteractable)
		SetChatWindowSavedDimensions(frameId, db.width, db.height)
		if db.point then
			SetChatWindowSavedPosition(frameId, db.point, db.xOffset, db.yOffset)
		end
		SetChatWindowShown(frameId, db.shown)
		FloatingChatFrame_Update(frameId, 1)
		FCF_DockUpdate()
		ChatEdit_DeactivateChat(f.editBox)
		FCF_FadeInChatFrame(f)

		if db.minimized then
			FCF_MinimizeFrame(f, "LEFT")
			f.minFrame:ClearAllPoints()
			for _, v in ipairs(db.minframe) do
				local point, relativeTo, relativePoint, xoff, yoff = unpack(v)
				f.minFrame:SetPoint(point, relativeTo and _G[relativeTo], relativePoint, xoff, yoff)
			end

			f.minFrame:SetUserPlaced(true)
		end
		return success
	end

	function module:LoadChatSettingsForFrame(frameId)
		local db = self.db.profile.frames[frameId]
		local success = true
		local f = Chat_GetChatFrame(frameId)

		-- Restore ChatFrame
		ChatFrame_RemoveAllMessageGroups(f)
		for _, v in ipairs(db.messages) do
			ChatFrame_AddMessageGroup(f, v);
		end

		ChatFrame_RemoveAllChannels(f)
		for i = 1, #db.channels, 2 do
			local chan
			if _G.ChatFrame_AddChannel then
				chan = _G.ChatFrame_AddChannel(f, db.channels[i])
			elseif _G.ChatFrameMixin.AddChannel then
				chan = f:AddChannel(db.channels[i])
			end
			if not chan then
				success = false
			end
		end

		ChatFrame_ReceiveAllPrivateMessages(f)
		return success
	end
	function module:LeaveChannels(...)
		local db = self.db.profile
		local map = self:GetChannelMap(unpack(db.channels))
		for i = 1, select("#", ...), 3 do
			local snum, sname = select(i, ...);
			local num, name = map[sname], map[snum];
			if snum ~= num or sname ~= name then
				LeaveChannelByName(snum)
			end
		end
	end

	local channelStepDelay = 0.5
	local function getDelay()
		return channelStepDelay + module.errorcount
	end

	function module:LeavePlaceholderChannels(...)
		for i = 1, select("#", ...), 3 do
			local num, name = select(i, ...);
			if name:match("^LeaveMe") then
				LeaveChannelByName(num)
			end
		end

		self:ScheduleTimer(function()
			module:CheckChannels(GetChannelList())
		end, getDelay())
	end

	function module:GetChannelMap(...)
		local map = {}
		for i = 1, select("#", ...), 3 do
			local num, name = select(i, ...);
			map[name] = num
			map[num] = name
		end

		return map
	end

	function module:CheckChannels(...)
		local db = self.db.profile
		local map = self:GetChannelMap(unpack(db.channels))

		local correct = true
		if select("#", ...) ~= #db.channels then
			correct = "wrong"
		else
			for i = 1, select("#", ...), 3 do
				local snum, sname = select(i, ...);
				local num, name = db.channels[i], db.channels[i + 1];
				if snum ~= num or sname ~= name then
					correct = map[sname] and "order" or "wrong"
				end
			end
		end

		if type(correct) == "boolean" or self.errorcount >= 3 then
			self:ScheduleTimer("LoadSettings", 0)
		else
			if correct == "wrong" then
				self:LeaveChannels(GetChannelList())
				self:ScheduleTimer("RestoreChannels", getDelay(), unpack(db.channels))
				self.errorcount = self.errorcount + 1
			elseif correct == "order" then
				for i = 1, select("#", ...), 3 do
					local snum, sname = select(i, GetChannelList());
					local curnum = map[sname]
					-- we check if the channel is joined and was joined in the past before
					-- doing anything (avoids nil reference error on some new characters)
					if curnum ~= nil and snum ~= nil and snum ~= curnum then
						if Prat.IsClassic then
							SwapChatChannelByLocalID(snum, curnum)
						else
							C_ChatInfo.SwapChatChannelsByChannelIndex(snum, curnum)
						end
					end
				end

				self:ScheduleTimer(function()
					module:CheckChannels(GetChannelList())
				end, getDelay())
			end
		end
	end

	if Prat.IsClassic then
		function module:RestoreChannels(...)
			local index = 1
			for i = 1, select("#", ...), 3 do
				local num, name = select(i, ...);
				while index < num do
					if GetChannelName(index) == 0 then
						JoinTemporaryChannel("LeaveMe" .. index)
					end
					index = index + 1
				end
				if GetChannelName(index) == 0 then
					JoinChannelByName(name)
				end
				index = index + 1
			end

			self:ScheduleTimer(function()
				module:LeavePlaceholderChannels(GetChannelList())
			end, getDelay())
		end
	else
		function module:RestoreChannels(...)
			local index = 1
			for i = 1, select("#", ...), 3 do
				local num, name = select(i, ...);
				while index < num do
					if GetChannelName(index) == 0 then
						JoinTemporaryChannel("LeaveMe" .. index)
					end
					index = index + 1
				end
				if GetChannelName(index) == 0 then
					local clubId, streamId = Prat.GetCommunityAndStreamFromChannel(name);
					if not clubId or not streamId then
						JoinChannelByName(name)
					else
						ChatFrame_AddNewCommunitiesChannel(1, clubId, streamId)
					end
				end
				index = index + 1
			end
			self:ScheduleTimer(function()
				module:LeavePlaceholderChannels(GetChannelList())
			end, getDelay())
		end
	end
	function module:LoadSettings()
		local db = self.db.profile
		local success = true

		if not next(db.frames) then
			self:Output(PL.msg_nosettings)
			self.needsLoading = nil
			return
		end

		if not self.working then
			self.working = {}
		end

		-- restore CVars
		if not self.working.cvars then
			for k, _ in pairs(cvars) do
				local val = db.cvars[k]
				if val ~= nil then
					SetCVar(k, val)
				end
			end
			self.working.cvars = true
		end

		-- Disabled for retail because it causes taint errors with edit mode
		if Prat.IsClassic then
			-- restore frame appearance and layout
			if not self.working.frames then
				for k, _ in pairs(db.frames) do
					if not self:LoadFrameSettingsForFrame(k) then
						success = false
					end
				end
				FCFDock_SelectWindow(GENERAL_CHAT_DOCK, ChatFrame1)
				self.working.frames = success
			end
		end

		-- restore chat channels
		if not self.working.channels and db.channels and #db.channels > 0 then
			self.errorcount = 0
			self:ScheduleTimer("CheckChannels", getDelay(), GetChannelList())
			self.working.channels = true
			return
		end

		-- restore channels and messages to chatframes
		if not self.working.chatframes then
			for k, _ in pairs(db.frames) do
				if not self:LoadChatSettingsForFrame(k) then
					success = false
				end
			end
			self.working.chatframes = success
		end

		-- restore chat colors
		if not self.working.colorsa then
			for k, v in pairs(db.types) do
				ChangeChatColor(k, v.r, v.g, v.b)
			end
			self.working.colorsa = true
		end

		if success then
			self.needsLoading = nil
			self.working = nil
			self.errorcount = 0
			self:Output(PL.msg_settingsloaded)
		else
			self.errorcount = self.errorcount + 1

			if self.errorcount > 10 then
				self.working = nil
				self.errorcount = 0
				self:Output(PL.msg_loadfailed)
				return
			end
			self:ScheduleTimer("LoadSettings", getDelay())
		end
	end

	function module:Prat_PreAddMessage(_, message)
		if self.working and ("YOU_CHANGED" == message.NOTICE or "YOU_LEFT" == message.NOTICE) then
			message.DONOTPROCESS = true
		end
	end
end)

