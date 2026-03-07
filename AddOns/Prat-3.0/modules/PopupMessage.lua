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
	local module = Prat:NewModule("PopupMessage", "LibSink-2.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["PopupMessage"] = true,
		["Shows messages with your name in a popup."] = true,
		["Set Separately"] = true,
		["Toggle setting options separately for each chat window."] = true,
		["show_name"] = "Show Popups",
		["show_desc"] = "Show Popups for each window.",
		["Show Popups"] = true,
		["Show Popups for each window."] = true,
		["show_perframename"] = "Show ChatFrame%d Popups",
		["show_perframedesc"] = "Toggles showing popups on and off.",
		["showall_name"] = "Show All Popups",
		["showall_desc"] = "Show Popups for all chat windows.",
		["Show All Popups"] = true,
		["Show Popups for all chat windows."] = true,
		["Add Nickname"] = true,
		["Adds an alternate name to show in popups."] = true,
		["Remove Nickname"] = true,
		["Removes an alternate name to show in popups."] = true,
		["Clear Nickname"] = true,
		["Clears alternate name to show in popups."] = true,
		["framealpha_name"] = "Popup Frame Alpha",
		["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in.",
		["Popup"] = true,
		["Shows messages in a popup window."] = true,
		-- 	["Use SCT Message"] = true,
		--	["Show the text as an SCT message instead of in its own frame"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- PopupMessage
L["Add Nickname"] = true
L["Adds an alternate name to show in popups."] = true
L["Clear Nickname"] = true
L["Clears alternate name to show in popups."] = true
L["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in."
L["framealpha_name"] = "Popup Frame Alpha"
L["Popup"] = true
L["PopupMessage"] = true
L["Remove Nickname"] = true
L["Removes an alternate name to show in popups."] = true
L["Set Separately"] = true
L["Show All Popups"] = true
L["Show Popups"] = true
L["Show Popups for all chat windows."] = true
L["Show Popups for each window."] = true
L["show_desc"] = "Show Popups for each window."
L["show_name"] = "Show Popups"
L["show_perframedesc"] = "Toggles showing popups on and off."
L["show_perframename"] = "Show ChatFrame%d Popups"
L["showall_desc"] = "Show Popups for all chat windows."
L["showall_name"] = "Show All Popups"
L["Shows messages in a popup window."] = true
L["Shows messages with your name in a popup."] = true
L["Toggle setting options separately for each chat window."] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- PopupMessage
--[[Translation missing --]]
L["Add Nickname"] = "Add Nickname"
--[[Translation missing --]]
L["Adds an alternate name to show in popups."] = "Adds an alternate name to show in popups."
--[[Translation missing --]]
L["Clear Nickname"] = "Clear Nickname"
--[[Translation missing --]]
L["Clears alternate name to show in popups."] = "Clears alternate name to show in popups."
--[[Translation missing --]]
L["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in."
--[[Translation missing --]]
L["framealpha_name"] = "Popup Frame Alpha"
--[[Translation missing --]]
L["Popup"] = "Popup"
--[[Translation missing --]]
L["PopupMessage"] = "PopupMessage"
--[[Translation missing --]]
L["Remove Nickname"] = "Remove Nickname"
--[[Translation missing --]]
L["Removes an alternate name to show in popups."] = "Removes an alternate name to show in popups."
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Show All Popups"] = "Show All Popups"
--[[Translation missing --]]
L["Show Popups"] = "Show Popups"
--[[Translation missing --]]
L["Show Popups for all chat windows."] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["Show Popups for each window."] = "Show Popups for each window."
--[[Translation missing --]]
L["show_desc"] = "Show Popups for each window."
--[[Translation missing --]]
L["show_name"] = "Show Popups"
--[[Translation missing --]]
L["show_perframedesc"] = "Toggles showing popups on and off."
--[[Translation missing --]]
L["show_perframename"] = "Show ChatFrame%d Popups"
--[[Translation missing --]]
L["showall_desc"] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["showall_name"] = "Show All Popups"
--[[Translation missing --]]
L["Shows messages in a popup window."] = "Shows messages in a popup window."
--[[Translation missing --]]
L["Shows messages with your name in a popup."] = "Shows messages with your name in a popup."
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."

  PL:AddLocale("itIT", L)



  L = {}
  -- PopupMessage
--[[Translation missing --]]
L["Add Nickname"] = "Add Nickname"
--[[Translation missing --]]
L["Adds an alternate name to show in popups."] = "Adds an alternate name to show in popups."
--[[Translation missing --]]
L["Clear Nickname"] = "Clear Nickname"
--[[Translation missing --]]
L["Clears alternate name to show in popups."] = "Clears alternate name to show in popups."
--[[Translation missing --]]
L["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in."
--[[Translation missing --]]
L["framealpha_name"] = "Popup Frame Alpha"
--[[Translation missing --]]
L["Popup"] = "Popup"
--[[Translation missing --]]
L["PopupMessage"] = "PopupMessage"
--[[Translation missing --]]
L["Remove Nickname"] = "Remove Nickname"
--[[Translation missing --]]
L["Removes an alternate name to show in popups."] = "Removes an alternate name to show in popups."
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Show All Popups"] = "Show All Popups"
--[[Translation missing --]]
L["Show Popups"] = "Show Popups"
--[[Translation missing --]]
L["Show Popups for all chat windows."] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["Show Popups for each window."] = "Show Popups for each window."
--[[Translation missing --]]
L["show_desc"] = "Show Popups for each window."
--[[Translation missing --]]
L["show_name"] = "Show Popups"
--[[Translation missing --]]
L["show_perframedesc"] = "Toggles showing popups on and off."
--[[Translation missing --]]
L["show_perframename"] = "Show ChatFrame%d Popups"
--[[Translation missing --]]
L["showall_desc"] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["showall_name"] = "Show All Popups"
--[[Translation missing --]]
L["Shows messages in a popup window."] = "Shows messages in a popup window."
--[[Translation missing --]]
L["Shows messages with your name in a popup."] = "Shows messages with your name in a popup."
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."

  PL:AddLocale("ptBR", L)


  L = {}
  -- PopupMessage
L["Add Nickname"] = "Ajouter un surnom"
--[[Translation missing --]]
L["Adds an alternate name to show in popups."] = "Adds an alternate name to show in popups."
L["Clear Nickname"] = "Efface le surnom"
--[[Translation missing --]]
L["Clears alternate name to show in popups."] = "Clears alternate name to show in popups."
L["framealpha_desc"] = "Régler la transparence de la popup lorsqu'elle disparait."
L["framealpha_name"] = "Transparence des popups"
L["Popup"] = true
L["PopupMessage"] = "Message popup"
L["Remove Nickname"] = "Retirer un surnom"
--[[Translation missing --]]
L["Removes an alternate name to show in popups."] = "Removes an alternate name to show in popups."
L["Set Separately"] = "Afficher séparément"
L["Show All Popups"] = "Afficher toutes les popups"
L["Show Popups"] = "Afficher les popups"
L["Show Popups for all chat windows."] = "Afficher les popups pour toutes les fenêtres de discussion."
L["Show Popups for each window."] = "Afficher les popups pour chaque fenêtre."
L["show_desc"] = "Afficher les popups pour chaque fenêtre."
L["show_name"] = "Afficher les popups"
L["show_perframedesc"] = "Active ou désactive l'affichage des popups."
L["show_perframename"] = "Afficher les popups de la fenêtre de discussion %d"
L["showall_desc"] = "Afficher les popups pour toutes les fenêtres de discussion."
L["showall_name"] = "Afficher toutes les popups"
L["Shows messages in a popup window."] = "Afficher les messages dans une fenêtre popup."
L["Shows messages with your name in a popup."] = "Afficher les messages avec votre nom dans une popup."
L["Toggle setting options separately for each chat window."] = "Activer des préférences différentes pour chaque fenêtre de discussion."

  PL:AddLocale("frFR",L)




  L = {}
  -- PopupMessage
L["Add Nickname"] = "Spitzname hinzufügen"
L["Adds an alternate name to show in popups."] = "Fügt einen alternativen Namen hinzu, der in Popups angezeigt werden soll."
L["Clear Nickname"] = "Spitznamen löschen"
L["Clears alternate name to show in popups."] = "Löscht den alternativen Namen, der in Popups angezeigt werden soll."
L["framealpha_desc"] = "Den Transparenzwert des Popup-Rahmens bei voller Darstellung einstellen."
L["framealpha_name"] = "Transparenz der Popup-Rahmens"
L["Popup"] = true
L["PopupMessage"] = "Popup Nachricht"
L["Remove Nickname"] = "Spitznamen entfernen"
L["Removes an alternate name to show in popups."] = "Entfernt einen alternativen Namen, der in Popups angezeigt werden soll."
L["Set Separately"] = "Einzeln einstellen"
L["Show All Popups"] = "Alle Popups anzeigen"
L["Show Popups"] = "Popups anzeigen"
L["Show Popups for all chat windows."] = "Popups für alle Chatfenster anzeigen."
L["Show Popups for each window."] = "Popups für jedes Fenster anzeigen."
L["show_desc"] = "Popups für jedes Fenster anzeigen."
L["show_name"] = "Popups anzeigen"
L["show_perframedesc"] = "Anzeige der Popups ein- und ausschalten."
L["show_perframename"] = "Popups vom Chatfenster%d anzeigen"
L["showall_desc"] = "Popups für alle Chatfenster anzeigen."
L["showall_name"] = "Alle Popups anzeigen"
L["Shows messages in a popup window."] = "Zeigt Nachrichten in einem Popup-Fenster an."
L["Shows messages with your name in a popup."] = "Zeigt Nachrichten mit deinem Namen in einem Popup an."
L["Toggle setting options separately for each chat window."] = "Optionseinstellungen einzeln für jedes Chatfenster umschalten."

  PL:AddLocale("deDE", L)


  L = {}
  -- PopupMessage
L["Add Nickname"] = "별명 추가"
L["Adds an alternate name to show in popups."] = "팝업에 표시할 별명을 추가합니다."
L["Clear Nickname"] = "별명 전체 삭제"
L["Clears alternate name to show in popups."] = "팝업에 표시할 별명을 전체 삭제합니다."
L["framealpha_desc"] = "가장 밝아졌을 때 팝업 창의 투명도를 설정합니다."
L["framealpha_name"] = "팝업 창 투명도"
L["Popup"] = "팝업"
L["PopupMessage"] = "팝업 메시지"
L["Remove Nickname"] = "별명 제거"
L["Removes an alternate name to show in popups."] = "팝업에 표시할 별명을 제거합니다."
L["Set Separately"] = "개별 설정"
L["Show All Popups"] = "모든 팝업 표시"
L["Show Popups"] = "팝업 표시"
L["Show Popups for all chat windows."] = "모든 대화창에 팝업을 표시합니다."
L["Show Popups for each window."] = "각 대화창 별로 팝업을 표시합니다."
L["show_desc"] = "각 창 별로 팝업을 표시합니다."
L["show_name"] = "팝업 표시"
L["show_perframedesc"] = "팝업 표시 여부를 토글합니다."
L["show_perframename"] = "%d번 대화창 팝업 표시"
L["showall_desc"] = "모든 대화창에 팝업을 표시합니다."
L["showall_name"] = "모든 팝업 표시"
L["Shows messages in a popup window."] = "팝업창 안에 메시지를 표시합니다."
L["Shows messages with your name in a popup."] = "팝업 창에 당신의 이름과 메시지를 같이 표시합니다."
L["Toggle setting options separately for each chat window."] = "각 대화창 별로 설정 옵션을 끄거나 켭니다."

  PL:AddLocale("koKR",L)

  L = {}
  -- PopupMessage
--[[Translation missing --]]
L["Add Nickname"] = "Add Nickname"
--[[Translation missing --]]
L["Adds an alternate name to show in popups."] = "Adds an alternate name to show in popups."
--[[Translation missing --]]
L["Clear Nickname"] = "Clear Nickname"
--[[Translation missing --]]
L["Clears alternate name to show in popups."] = "Clears alternate name to show in popups."
--[[Translation missing --]]
L["framealpha_desc"] = "Set the alpha value of the popup frame when fully faded in."
--[[Translation missing --]]
L["framealpha_name"] = "Popup Frame Alpha"
--[[Translation missing --]]
L["Popup"] = "Popup"
--[[Translation missing --]]
L["PopupMessage"] = "PopupMessage"
--[[Translation missing --]]
L["Remove Nickname"] = "Remove Nickname"
--[[Translation missing --]]
L["Removes an alternate name to show in popups."] = "Removes an alternate name to show in popups."
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Show All Popups"] = "Show All Popups"
--[[Translation missing --]]
L["Show Popups"] = "Show Popups"
--[[Translation missing --]]
L["Show Popups for all chat windows."] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["Show Popups for each window."] = "Show Popups for each window."
--[[Translation missing --]]
L["show_desc"] = "Show Popups for each window."
--[[Translation missing --]]
L["show_name"] = "Show Popups"
--[[Translation missing --]]
L["show_perframedesc"] = "Toggles showing popups on and off."
--[[Translation missing --]]
L["show_perframename"] = "Show ChatFrame%d Popups"
--[[Translation missing --]]
L["showall_desc"] = "Show Popups for all chat windows."
--[[Translation missing --]]
L["showall_name"] = "Show All Popups"
--[[Translation missing --]]
L["Shows messages in a popup window."] = "Shows messages in a popup window."
--[[Translation missing --]]
L["Shows messages with your name in a popup."] = "Shows messages with your name in a popup."
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."

  PL:AddLocale("esMX",L)

  L = {}
  -- PopupMessage
L["Add Nickname"] = "Добавить ник"
L["Adds an alternate name to show in popups."] = "Добавить альтернативное имя для отображения при всплывании."
L["Clear Nickname"] = "Очистить ники"
L["Clears alternate name to show in popups."] = "Очистить альтернативные имена для отображения при всплывании."
L["framealpha_desc"] = "Установка прозрачности всплывающего окна при полном затухании."
L["framealpha_name"] = "Прозрачность окна всплывания"
L["Popup"] = "Всплывающий"
L["PopupMessage"] = "Всплывающее окно "
L["Remove Nickname"] = "Удалить ник"
L["Removes an alternate name to show in popups."] = "Удалить альтернативное имя для отображения при всплывании."
L["Set Separately"] = "Разделение"
L["Show All Popups"] = "Все всплывающие"
L["Show Popups"] = "Показывать всплывания"
L["Show Popups for all chat windows."] = "Показывать всплывающие окна для всего чата."
L["Show Popups for each window."] = "Показывать всплывания для всех окон."
L["show_desc"] = "Отображать всплывние для всех окон чата."
L["show_name"] = "Показывать всплывание"
L["show_perframedesc"] = "Вкл/Выкл отображение всплывания."
L["show_perframename"] = "Показать всплывание окна %d"
L["showall_desc"] = "Показывать всплывающие окна для всего чата."
L["showall_name"] = "Все всплывающие"
L["Shows messages in a popup window."] = "Показывать сообщение во всплывающем окне."
L["Shows messages with your name in a popup."] = "Показывать сообщение с вашим именем во всплывающем окне."
L["Toggle setting options separately for each chat window."] = "Вкл/Выкл настройки разделения для всех окон чата."

  PL:AddLocale("ruRU",L)

  L = {}
  -- PopupMessage
L["Add Nickname"] = "添加昵称"
L["Adds an alternate name to show in popups."] = "添加一个显示在弹出中的替换名"
L["Clear Nickname"] = "清除昵称"
L["Clears alternate name to show in popups."] = "弹出显示清除候补名称"
L["framealpha_desc"] = "设置完全消失时弹出框体透明度值"
L["framealpha_name"] = "弹出框体透明度"
L["Popup"] = "弹出"
L["PopupMessage"] = "弹出信息"
L["Remove Nickname"] = "移除昵称"
L["Removes an alternate name to show in popups."] = "移除在弹出里显示的候补名称"
L["Set Separately"] = "个别设置"
L["Show All Popups"] = "显示所有弹出"
L["Show Popups"] = "显示弹出"
L["Show Popups for all chat windows."] = "为所有聊天窗后显示弹出"
L["Show Popups for each window."] = "为每个窗口显示弹出"
L["show_desc"] = "在每个窗口显示弹出"
L["show_name"] = "显示弹出"
L["show_perframedesc"] = "弹出开关"
L["show_perframename"] = "显示聊天框体%d弹出"
L["showall_desc"] = "在所有聊天窗口显示弹出"
L["showall_name"] = "显示所有弹出"
L["Shows messages in a popup window."] = "在弹出窗口显示信息"
L["Shows messages with your name in a popup."] = "在弹出中显示含有你名字的信息"
L["Toggle setting options separately for each chat window."] = "分别为每个聊天窗口设置选项"

  PL:AddLocale("zhCN",L)

  L = {}
  -- PopupMessage
L["Add Nickname"] = "Añadir un Apodo"
L["Adds an alternate name to show in popups."] = "Añade un nombre alternativo para mostrar en las ventanas emergentes."
L["Clear Nickname"] = "Limpiar Apodo"
L["Clears alternate name to show in popups."] = "Limpia el nombre alternativo a mostrar en las ventanas emergentes."
L["framealpha_desc"] = "Establece el valor de transparencia del marco emergente al desaparecer completamente."
L["framealpha_name"] = "Transparencia Marco Emergente"
L["Popup"] = "Emergente"
L["PopupMessage"] = "Mensaje Emergente"
L["Remove Nickname"] = "Eliminar Apodo"
L["Removes an alternate name to show in popups."] = "Quita un nombre alternativo para mostrar en las ventanas emergentes."
L["Set Separately"] = "Establecer por Separado"
L["Show All Popups"] = "Mostrar Todas las Emergentes"
L["Show Popups"] = "Mostrar Emergentes"
L["Show Popups for all chat windows."] = "Mostrar Emergentes para todas las ventanas de chat."
L["Show Popups for each window."] = "Mostrar Emergentes para cada ventana."
L["show_desc"] = "Muestra Emergentes para cada ventana."
L["show_name"] = "Mostar Emergentes"
L["show_perframedesc"] = "Alterna activación de mostrar ventanas emergentes."
L["show_perframename"] = "Mostrar Marcos Emergentes de Chat %d"
L["showall_desc"] = "Mostrar Ventanas Emergentes para todas las ventanas de chat."
L["showall_name"] = "Mostrar Todas las Emergentes"
L["Shows messages in a popup window."] = "Muestra mensajes en una ventana emergente."
L["Shows messages with your name in a popup."] = "Muestra mensajes con tu nombre en una ventana emergente."
L["Toggle setting options separately for each chat window."] = "Cambiar opciones de configuración por separado para cada ventana de chat."

  PL:AddLocale("esES",L)

  L = {}
  -- PopupMessage
L["Add Nickname"] = "新增暱稱"
--[[Translation missing --]]
L["Adds an alternate name to show in popups."] = "Adds an alternate name to show in popups."
L["Clear Nickname"] = "清除暱稱"
--[[Translation missing --]]
L["Clears alternate name to show in popups."] = "Clears alternate name to show in popups."
L["framealpha_desc"] = "設定彈出視窗完全淡入時的透明度值"
L["framealpha_name"] = "彈出視窗透明度"
L["Popup"] = "彈出"
L["PopupMessage"] = "彈出訊息"
L["Remove Nickname"] = "移除暱稱"
--[[Translation missing --]]
L["Removes an alternate name to show in popups."] = "Removes an alternate name to show in popups."
L["Set Separately"] = "單獨設定"
L["Show All Popups"] = "顯示所有彈出視窗"
L["Show Popups"] = "顯示彈出視窗"
L["Show Popups for all chat windows."] = "顯示彈出全部聊天視窗。"
L["Show Popups for each window."] = "顯示彈出每個視窗。"
L["show_desc"] = "顯示彈出每個視窗。"
L["show_name"] = "顯示彈出"
L["show_perframedesc"] = "換顯示彈出開動和關閉。"
L["show_perframename"] = "顯示 ChatFrame%d 彈出"
L["showall_desc"] = "顯示彈出全部聊天視窗。"
L["showall_name"] = "顯示全部彈出"
L["Shows messages in a popup window."] = "顯示在彈出視窗訊息。"
--[[Translation missing --]]
L["Shows messages with your name in a popup."] = "Shows messages with your name in a popup."
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@

	local EVENTS_EMOTES = {
		["CHAT_MSG_BG_SYSTEM_ALLIANCE"] = true,
		["CHAT_MSG_BG_SYSTEM_HORDE"] = true,
		["CHAT_MSG_BG_SYSTEM_NEUTRAL"] = true,
		["CHAT_MSG_EMOTE"] = true,
		["CHAT_MSG_TEXT_EMOTE"] = true,
		["CHAT_MSG_MONSTER_EMOTE"] = true,
		["CHAT_MSG_MONSTER_SAY"] = true,
		["CHAT_MSG_MONSTER_WHISPER"] = true,
		["CHAT_MSG_MONSTER_YELL"] = true,
		["CHAT_MSG_RAID_BOSS_EMOTE"] = true
	};

	local EVENTS_IGNORE = {
		["CHAT_MSG_CHANNEL_NOTICE_USER"] = true,
		["CHAT_MSG_SYSTEM"] = true,
		["CHAT_MSG_PING"] = true,
	}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			separate = true,
			show = { ChatFrame1 = true },
			framealpha = 1.0,
			nickname = {},
			sinkoptions = { ["sink20OutputSink"] = "Popup" },
		}
	})

	local pluginOptions = { sink = {} }

	Prat:SetModuleOptions(module, {
		name = PL["PopupMessage"],
		desc = PL["Shows messages with your name in a popup."],
		type = "group",
		plugins = pluginOptions,
		args = {
			helpheader = {
				name = "Settings",
				type = "header",
				order = 105,
			},
			show = {
				name = PL["Show Popups"],
				desc = PL["Show Popups for each window."],
				type = "multiselect",
				order = 110,
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			addnick = {
				name = PL["Add Nickname"],
				desc = PL["Adds an alternate name to show in popups."],
				type = "input",
				order = 140,
				usage = "<string>",
				get = false,
				set = function(info, name)
					info.handler:AddNickname(name)
				end
			},
			removenick = {
				name = PL["Remove Nickname"],
				desc = PL["Removes an alternate name to show in popups."],
				type = "select",
				order = 150,
				get = function()
					return ""
				end,
				values = function(info)
					return info.handler.db.profile.nickname
				end,
				disabled = function(info)
					return #info.handler.db.profile.nickname == 0
				end,
				set = function(info, value)
					info.handler:RemoveNickname(value)
				end
			},
			clearnick = {
				name = PL["Clear Nickname"],
				desc = PL["Clears alternate name to show in popups."],
				type = "execute",
				order = 160,
				disabled = function(info)
					return (#info.handler.db.profile.nickname == 0)
				end,
				func = "ClearNickname",
			},
		},
	})

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --
	Prat:SetModuleInit(module,
		function(self)
			self:RegisterSink(PL["Popup"],
				PL["PopupMessage"],
				PL["Shows messages in a popup window."],
				"Popup")
			self:SetSinkStorage(self.db.profile.sinkoptions)

			pluginOptions.sink["output"] = self:GetSinkAce3OptionsDataTable()
			pluginOptions.sink["output"].inline = true

			self.db.profile.show = self.db.profile.show or {}
		end)

	function module:OnModuleEnable()
		Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

		self.nickpat = {}
		for _, v in ipairs(self.db.profile.nickname) do
			self.nickpat[v] = Prat.GetNamePattern(v)
		end

		self.playerName = Prat.GetNamePattern(UnitName("player"))
	end

	--[[------------------------------------------------
	  Core Functions
	------------------------------------------------]] --
	function module:GetDescription()
		return PL["Shows messages with your name in a popup."]
	end

	-- /dump module.moduleOptions.args.output.get():find("Default")
	-- /script module.moduleOptions.args.output.set("PopupMessage")
	-- /dump module.db.profile
	-- /script module.db.profile.sink10OutputSink = nil
	function module:Popup(_, text, r, g, b)
		if Prat_PopupFrame.anim then
			Prat_PopupFrame.anim:Stop()
		else
			Prat_PopupFrame.anim = Prat_PopupFrame:CreateAnimationGroup()
			Prat_PopupFrame.anim:SetScript("OnFinished", function()
				Prat_PopupFrameText:Hide()
			end)

			local fade1 = Prat_PopupFrame.anim:CreateAnimation("Alpha")
			fade1:SetDuration(1)
			fade1:SetToAlpha(module.db.profile.framealpha or 1)
			fade1:SetEndDelay(4)
			fade1:SetOrder(1)

			local fade2 = Prat_PopupFrame.anim:CreateAnimation("Alpha")
			fade2:SetDuration(5)
			fade2:SetToAlpha(0)
			fade2:SetOrder(2)
		end

		Prat_PopupFrameText:SetTextColor(r, g, b)
		Prat_PopupFrameText:SetText(text)

		local font, _, style = ChatFrame1:GetFont()
		local _, fontsize = GameFontNormal:GetFont()
		Prat_PopupFrameText:SetFont(font, fontsize, style)
		Prat_PopupFrameText:SetNonSpaceWrap(false)
		Prat_PopupFrame:SetWidth(math.min(math.max(64, Prat_PopupFrameText:GetStringWidth() + 20), 520))
		Prat_PopupFrame:SetHeight(64)
		Prat_PopupFrame:SetBackdropBorderColor(r, g, b)

		Prat_PopupFrameText:ClearAllPoints()
		Prat_PopupFrameText:SetPoint("TOPLEFT", Prat_PopupFrame, "TOPLEFT", 10, 10)
		Prat_PopupFrameText:SetPoint("BOTTOMRIGHT", Prat_PopupFrame, "BOTTOMRIGHT", -10, -10)
		Prat_PopupFrameText:Show()

		Prat_PopupFrame:SetAlpha(0)
		Prat_PopupFrame:Show()
		Prat_PopupFrame.anim:Play()
	end

	local DEBUG
	--[==[@debug@
	DEBUG = true
	--@end-debug@]==]

	function module:Prat_PostAddMessage(_, message, frame, event, _, r, g, b)
		if self.pouring then
			return
		end
		if message.LINE_ID and
			message.LINE_ID == self.lastevent and
			self.lasteventtype == event then
			return
		end

		if not (EVENTS_EMOTES[event] or EVENTS_IGNORE[event]) then
			if self.db.profile.showall or self.db.profile.show[frame:GetName()] then
				if DEBUG or not (message.ORG.PLAYER and self.playerName and message.ORG.PLAYER:match(self.playerName)) then
					self:CheckText(message.ORG.MESSAGE, message.OUTPUT, event, r, g, b, message.LINE_ID)
				end
			end
		end
	end

	function module:AddNickname(name)
		for _, v in ipairs(self.db.profile.nickname) do
			if v:lower() == name:lower() then
				return
			end
		end
		tinsert(self.db.profile.nickname, name)

		self.nickpat[name] = Prat.GetNamePattern(name)
	end

	function module:RemoveNickname(idx)
		self.nickpat[self.db.profile.nickname[idx]] = nil
		tremove(self.db.profile.nickname, idx)
	end

	function module:ClearNickname()
		local n = self.db.profile.nickname
		while #n > 0 do
			self.nickpat[n[#n]] = nil
			n[#n] = nil
			--		tremove(self.db.profile.nickname)
		end
	end

	function module:CheckText(text, display_text, event, r, g, b, eventId)
		local show = false

		if text:match(self.playerName) then
			show = true;
		else
			for _, v in pairs(self.nickpat) do
				if v:len() > 0 and text:match(v) then
					show = true
				end
			end
		end

		if show then
			self.lasteventtype = event
			self.lastevent = eventId
			self.pouring = true
			self:Pour(display_text or text, r, g, b)
			Prat:PlaySound("popup");
			self.pouring = nil
		end
	end

	return
end) -- Prat:AddModuleToLoad
