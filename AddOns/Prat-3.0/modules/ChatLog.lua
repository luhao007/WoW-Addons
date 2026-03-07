---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2018  Prat Development Team
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

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("ChatLog")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["ChatLog"] = true,
		["A module to automaticaly enable chat and combat logging."] = true,
		["Toggle Chat Log"] = true,
		["Toggle chat log on and off."] = true,
		["Toggle Combat Log"] = true,
		["Toggle combat log on and off."] = true,
		["Combat Log: Enabled"] = true,
		["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = true,
		["Combat Log: Disabled"] = true,
		["Chat Log: Enabled"] = true,
		["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = true,
		["Chat Log: Disabled"] = true,
		["quiet_name"] = "Suppress Feedback Messages",
		["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings.",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = true
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = true
L["Chat Log: Disabled"] = true
L["Chat Log: Enabled"] = true
L["ChatLog"] = true
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = true
L["Combat Log: Disabled"] = true
L["Combat Log: Enabled"] = true
L["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings."
L["quiet_name"] = "Suppress Feedback Messages"
L["Toggle Chat Log"] = true
L["Toggle chat log on and off."] = true
L["Toggle Combat Log"] = true
L["Toggle combat log on and off."] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- ChatLog
--[[Translation missing --]]
L["A module to automaticaly enable chat and combat logging."] = "A module to automaticaly enable chat and combat logging."
--[[Translation missing --]]
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."
--[[Translation missing --]]
L["Chat Log: Disabled"] = "Chat Log: Disabled"
--[[Translation missing --]]
L["Chat Log: Enabled"] = "Chat Log: Enabled"
--[[Translation missing --]]
L["ChatLog"] = "ChatLog"
--[[Translation missing --]]
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."
--[[Translation missing --]]
L["Combat Log: Disabled"] = "Combat Log: Disabled"
--[[Translation missing --]]
L["Combat Log: Enabled"] = "Combat Log: Enabled"
--[[Translation missing --]]
L["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings."
--[[Translation missing --]]
L["quiet_name"] = "Suppress Feedback Messages"
--[[Translation missing --]]
L["Toggle Chat Log"] = "Toggle Chat Log"
--[[Translation missing --]]
L["Toggle chat log on and off."] = "Toggle chat log on and off."
--[[Translation missing --]]
L["Toggle Combat Log"] = "Toggle Combat Log"
--[[Translation missing --]]
L["Toggle combat log on and off."] = "Toggle combat log on and off."

  PL:AddLocale("itIT", L)



  L = {}
  -- ChatLog
--[[Translation missing --]]
L["A module to automaticaly enable chat and combat logging."] = "A module to automaticaly enable chat and combat logging."
--[[Translation missing --]]
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."
--[[Translation missing --]]
L["Chat Log: Disabled"] = "Chat Log: Disabled"
--[[Translation missing --]]
L["Chat Log: Enabled"] = "Chat Log: Enabled"
--[[Translation missing --]]
L["ChatLog"] = "ChatLog"
--[[Translation missing --]]
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."
--[[Translation missing --]]
L["Combat Log: Disabled"] = "Combat Log: Disabled"
--[[Translation missing --]]
L["Combat Log: Enabled"] = "Combat Log: Enabled"
--[[Translation missing --]]
L["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings."
--[[Translation missing --]]
L["quiet_name"] = "Suppress Feedback Messages"
--[[Translation missing --]]
L["Toggle Chat Log"] = "Toggle Chat Log"
--[[Translation missing --]]
L["Toggle chat log on and off."] = "Toggle chat log on and off."
--[[Translation missing --]]
L["Toggle Combat Log"] = "Toggle Combat Log"
--[[Translation missing --]]
L["Toggle combat log on and off."] = "Toggle combat log on and off."

  PL:AddLocale("ptBR", L)


  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "Un module pour activer automatiquement la journalisation du chat et des combats"
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Journalisation du chat enregistré dans <WoW Installation>\\Logs\\WoWChatLog.txt jusqu'à la prochaine déconnexion"
L["Chat Log: Disabled"] = "Journalisation Chat : Désactivé"
L["Chat Log: Enabled"] = "Journalisation Chat : Activé"
L["ChatLog"] = true
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Journalisation des combats enregistré dans <WoW Installation>\\Logs\\WoWChatLog.txt jusqu'à la prochaine déconnexion"
L["Combat Log: Disabled"] = "Journalisation des combats : Désactivé"
L["Combat Log: Enabled"] = "Journalisation des combats : Activé"
L["quiet_desc"] = "N'afficher aucun messages quand ce mod est activé ou quand il change les paramètres de journalisation"
L["quiet_name"] = "Supprimer les messages de feedback"
L["Toggle Chat Log"] = "Activer la journalisation du chat"
L["Toggle chat log on and off."] = "Activer/Désactiver la journalisation du chat"
L["Toggle Combat Log"] = "Activer la journalisation des combat"
L["Toggle combat log on and off."] = "Activer/Désactiver la journalisation des combats"

  PL:AddLocale("frFR",L)




  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "Ein Modul zum automatischen Aktivieren der Chat- und Kampfprotokollierung."
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Speicherung des Chat-Logs in <WoW Installation>\\Logs\\WoWChatLog.txt nur während des Ausloggens."
L["Chat Log: Disabled"] = "Chat-Protokoll: Deaktiviert"
L["Chat Log: Enabled"] = "Chat-Protokoll: Aktiviert"
L["ChatLog"] = "Chat-Protokoll"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Das aufgezeichnete Kampfprotokoll in <WoW Installation>\\Logs\\WoWCombatLog.txt wird erst beim Abmelden aufgezeichnet."
L["Combat Log: Disabled"] = "Kampfprotokoll: Deaktiviert"
L["Combat Log: Enabled"] = "Kampfprotokoll: Aktiviert"
L["quiet_desc"] = "Zeigt keinerlei Mitteilungen an, wenn dieser Modus aktiv ist, oder wenn es die Log-Einstellungen verändert."
L["quiet_name"] = "Feedback-Mitteilungen unterdrücken"
L["Toggle Chat Log"] = "Chat-Log umschalten"
L["Toggle chat log on and off."] = "Chat-Log ein- und ausschalten."
L["Toggle Combat Log"] = "Kampflog umschalten"
L["Toggle combat log on and off."] = "Kampflog ein- und ausschalten."

  PL:AddLocale("deDE", L)


  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "대화 기록과 전투 기록을 자동으로 켜는 모듈입니다."
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "대화 기록은 접속종료 후, <와우폴더>\\Logs\\WoWChatLog.txt 에 저장됩니다."
L["Chat Log: Disabled"] = "대화 기록: 꺼짐"
L["Chat Log: Enabled"] = "대화 기록: 켜짐"
L["ChatLog"] = "대화 기록 [ChatLog]"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "전투 기록은 접속종료 후, <와우폴더>\\Logs\\WoWCombatLog.txt 에 저장됩니다."
L["Combat Log: Disabled"] = "전투 기록: 꺼짐"
L["Combat Log: Enabled"] = "전투 기록: 켜짐"
L["quiet_desc"] = "이 모듈이 켜지거나 설정이 변경될 때 알림 메시지를 표시하지 않습니다."
L["quiet_name"] = "알림 메시지 끄기"
L["Toggle Chat Log"] = "대화 기록 끄고 켜기"
L["Toggle chat log on and off."] = "대화 기록을 끄거나 켭니다."
L["Toggle Combat Log"] = "전투 기록 끄고 켜기"
L["Toggle combat log on and off."] = "전투 기록을 끄거나 켭니다."

  PL:AddLocale("koKR",L)

  L = {}
  -- ChatLog
--[[Translation missing --]]
L["A module to automaticaly enable chat and combat logging."] = "A module to automaticaly enable chat and combat logging."
--[[Translation missing --]]
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."
--[[Translation missing --]]
L["Chat Log: Disabled"] = "Chat Log: Disabled"
--[[Translation missing --]]
L["Chat Log: Enabled"] = "Chat Log: Enabled"
--[[Translation missing --]]
L["ChatLog"] = "ChatLog"
--[[Translation missing --]]
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."
--[[Translation missing --]]
L["Combat Log: Disabled"] = "Combat Log: Disabled"
--[[Translation missing --]]
L["Combat Log: Enabled"] = "Combat Log: Enabled"
--[[Translation missing --]]
L["quiet_desc"] = "Dont display any messages when this mod is enabled, or when it changes the log settings."
--[[Translation missing --]]
L["quiet_name"] = "Suppress Feedback Messages"
--[[Translation missing --]]
L["Toggle Chat Log"] = "Toggle Chat Log"
--[[Translation missing --]]
L["Toggle chat log on and off."] = "Toggle chat log on and off."
--[[Translation missing --]]
L["Toggle Combat Log"] = "Toggle Combat Log"
--[[Translation missing --]]
L["Toggle combat log on and off."] = "Toggle combat log on and off."

  PL:AddLocale("esMX",L)

  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "Модуль автоматического включения записи чата и журнала боя."
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Запись чата, записано в <директория инсталляции WoW>\\Logs\\WoWChatLog.txt  (только после выхода из игры)."
L["Chat Log: Disabled"] = "Запись чатa: выключена"
L["Chat Log: Enabled"] = "Запись чатa: включена"
L["ChatLog"] = "Логи чата"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Журнал боя записывается в <директория инсталляции WoW>\\Logs\\WoWCombatLog.txt только до выхода из игры."
L["Combat Log: Disabled"] = "Запись журнала боя: выключена"
L["Combat Log: Enabled"] = "Запись журнала боя: включена"
L["quiet_desc"] = "Не отображать никаких сообщений, если данный модуль включен, или при изменении им настроек записи."
L["quiet_name"] = "Подавлять инфо сообщения"
L["Toggle Chat Log"] = "Запись чата"
L["Toggle chat log on and off."] = "Вкл/Выкл запись чата."
L["Toggle Combat Log"] = "Запись журнала боя"
L["Toggle combat log on and off."] = "Вкл/Выкл запись журнала боя."

  PL:AddLocale("ruRU",L)

  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "自动启用聊天和战斗记录的模块"
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "退出游戏时保存聊天记录在<魔兽世界安装目录>\\Logs\\WoWChatLog.txt"
L["Chat Log: Disabled"] = "聊天记录：禁用"
L["Chat Log: Enabled"] = "聊天记录：启用"
L["ChatLog"] = "聊天记录"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "退出游戏后保存战斗记录在<魔兽世界安装目录>\\Logs\\WoWCombatLog.txt"
L["Combat Log: Disabled"] = "战斗记录：禁用"
L["Combat Log: Enabled"] = "战斗记录：启用"
L["quiet_desc"] = "模块启用或改变记录设置时不显示任何信息"
L["quiet_name"] = "禁止反馈信息"
L["Toggle Chat Log"] = "聊天记录"
L["Toggle chat log on and off."] = "切换聊天记录开关"
L["Toggle Combat Log"] = "战斗记录"
L["Toggle combat log on and off."] = "切换战斗记录开关"

  PL:AddLocale("zhCN",L)

  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "Un módulo que automáticamente activa el chat y el registro de combate."
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "Registro del chat guardado en <Instalación WoW>\\Logs\\WoWChatLog.txt sólo al cierre de la sesión."
L["Chat Log: Disabled"] = "Registro del Chat: Desactivado"
L["Chat Log: Enabled"] = "Registro del Chat: Activado"
L["ChatLog"] = "Registro del Chat"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "Registro del combate guardado en <Instalación WoW>\\Logs\\WoWCombatLog.txt sólo al cierre de la sesión."
L["Combat Log: Disabled"] = "Registro de Combate: Desactivado"
L["Combat Log: Enabled"] = "Registro de Combate: Activado"
L["quiet_desc"] = "No mostrar algún mensaje cuando este mod esté activdo, o cuando cambie la configuración del registro."
L["quiet_name"] = "Suprimir Mensaje de Respuesta"
L["Toggle Chat Log"] = "Alternar Registro del Chat"
L["Toggle chat log on and off."] = "Alterna la activación del registro del chat."
L["Toggle Combat Log"] = "Alternar Registro de Combate"
L["Toggle combat log on and off."] = "Alterna la activación del registro de combate."

  PL:AddLocale("esES",L)

  L = {}
  -- ChatLog
L["A module to automaticaly enable chat and combat logging."] = "模組：自動啟用聊天以及戰鬥紀錄。"
L["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."] = "聊天紀錄至 <WoW Installation>\\Logs\\WoWChatLog.txt 僅於遊戲登出時。"
L["Chat Log: Disabled"] = "聊天記錄：已停用"
L["Chat Log: Enabled"] = "聊天記錄：已啟用"
L["ChatLog"] = "聊天記錄"
L["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."] = "戰鬥紀錄至 <WoW Installation>\\Logs\\WoWChatLog.txt 僅於遊戲登出時。"
L["Combat Log: Disabled"] = "戰鬥記錄：已停用"
L["Combat Log: Enabled"] = "戰鬥記錄：已啟用"
L["quiet_desc"] = "禁止顯示任何訊息當插件啟用時的訊息或者插件改變紀錄設定時。"
L["quiet_name"] = "禁止回饋訊息"
L["Toggle Chat Log"] = "切換聊天記錄"
L["Toggle chat log on and off."] = "切換聊天記錄啟用"
L["Toggle Combat Log"] = "切換戰鬥記錄"
L["Toggle combat log on and off."] = "切換戰鬥記錄啟用"

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@


	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			chat = false,
			combat = false,
			quiet = true,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["ChatLog"],
		desc = PL["A module to automaticaly enable chat and combat logging."],
		type = "group",
		args = {
			chat = {
				name = PL["Toggle Chat Log"],
				desc = PL["Toggle chat log on and off."],
				type = "toggle",
				set = "SetChatLog",
			},
			combat = {
				name = PL["Toggle Combat Log"],
				desc = PL["Toggle combat log on and off."],
				type = "toggle",
				set = "SetCombatLog",
			},
			quiet = {
				name = PL["quiet_name"],
				desc = PL["quiet_desc"],
				type = "toggle",
			}
		}
	})


	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		self:SetChatLog(nil, self.db.profile.chat)
		self:SetCombatLog(nil, self.db.profile.combat)
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --

	function module:GetDescription()
		return PL["A module to automaticaly enable chat and combat logging."]
	end

	-- enable or disable the chat log
	function module:SetChatLog(_, val)
		self.db.profile.chat = val
		if self.db.profile.chat then
			self:Print(PL["Chat Log: Enabled"])
			self:Print(PL["Chat log recorded to <WoW Installation>\\Logs\\WoWChatLog.txt only upon logout."])
			LoggingChat(true)
		else
			LoggingChat(false)
			self:Print(PL["Chat Log: Disabled"])
		end
	end

	-- enable or disable the combat log
	function module:SetCombatLog(_, val)
		self.db.profile.combat = val
		if self.db.profile.combat then
			self:Print(PL["Combat Log: Enabled"])
			self:Print(PL["Combat log recorded to <WoW Installation>\\Logs\\WoWCombatLog.txt only upon logout."])
			LoggingCombat(true)
		end
	end

	function module:Print(str)
		if self.db.profile.quiet then
			return
		end

		Prat:Print(str)
	end

	return
end) -- Prat:AddModuleToLoad
