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
	local module = Prat:NewModule("Buttons", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Buttons"] = true,
		["Chat window button options."] = true,
		["chatmenu_name"] = "Show Chat Menu",
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		["Show Arrows"] = true,
		["Toggle showing chat arrows for each chat window."] = true,
		["Show Chat%d Arrows"] = true,
		["Toggles navigation arrows on and off."] = true,
		["scrollReminder_name"] = "Show ScrollDown Reminder",
		["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		["Set Position"] = true,
		["Sets position of chat menu and arrows for all chat windows."] = true,
		["Default"] = true,
		["Right, Inside Frame"] = true,
		["Right, Outside Frame"] = true,
		["alpha_name"] = "Set Alpha",
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		["showmenu_name"] = "Show Menu",
		["showmenu_desc"] = "Show Chat Menu",
		["showbnet_name"] = "Show Social Menu",
		["showbnet_desc"] = "Show Social Menu",
		["showminimize_name"] = "Show Minimize Button",
		["showminimize_desc"] = "Show Minimize Button",
		["showvoice_name"] = "Show Voice Buttons",
		["showvoice_desc"] = "Show Voice Buttons",
		["showchannel_name"] = "Show Channel Button",
		["showchannel_desc"] = "Show Channel Button",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Buttons
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
L["alpha_name"] = "Set Alpha"
L["Buttons"] = true
L["Chat window button options."] = true
L["chatmenu_desc"] = "Toggles chat menu on and off."
L["chatmenu_name"] = "Show Chat Menu"
L["Default"] = true
L["Right, Inside Frame"] = true
L["Right, Outside Frame"] = true
L["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window."
L["scrollReminder_name"] = "Show ScrollDown Reminder"
L["Set Position"] = true
L["Sets position of chat menu and arrows for all chat windows."] = true
L["Show Arrows"] = true
L["Show Chat%d Arrows"] = true
L["showbnet_desc"] = "Show Social Menu"
L["showbnet_name"] = "Show Social Menu"
L["showchannel_desc"] = "Show Channel Button"
L["showchannel_name"] = "Show Channel Button"
L["showmenu_desc"] = "Show Chat Menu"
L["showmenu_name"] = "Show Menu"
L["showminimize_desc"] = "Show Minimize Button"
L["showminimize_name"] = "Show Minimize Button"
L["showvoice_desc"] = "Show Voice Buttons"
L["showvoice_name"] = "Show Voice Buttons"
L["Toggle showing chat arrows for each chat window."] = true
L["Toggles navigation arrows on and off."] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- Buttons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["Buttons"] = "Buttons"
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["Right, Inside Frame"] = "Right, Inside Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
--[[Translation missing --]]
L["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["scrollReminder_name"] = "Show ScrollDown Reminder"
--[[Translation missing --]]
L["Set Position"] = "Set Position"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["Show Arrows"] = "Show Arrows"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["showbnet_desc"] = "Show Social Menu"
--[[Translation missing --]]
L["showbnet_name"] = "Show Social Menu"
--[[Translation missing --]]
L["showchannel_desc"] = "Show Channel Button"
--[[Translation missing --]]
L["showchannel_name"] = "Show Channel Button"
--[[Translation missing --]]
L["showmenu_desc"] = "Show Chat Menu"
--[[Translation missing --]]
L["showmenu_name"] = "Show Menu"
--[[Translation missing --]]
L["showminimize_desc"] = "Show Minimize Button"
--[[Translation missing --]]
L["showminimize_name"] = "Show Minimize Button"
--[[Translation missing --]]
L["showvoice_desc"] = "Show Voice Buttons"
--[[Translation missing --]]
L["showvoice_name"] = "Show Voice Buttons"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("itIT", L)



  L = {}
  -- Buttons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["Buttons"] = "Buttons"
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["Right, Inside Frame"] = "Right, Inside Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
--[[Translation missing --]]
L["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["scrollReminder_name"] = "Show ScrollDown Reminder"
--[[Translation missing --]]
L["Set Position"] = "Set Position"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["Show Arrows"] = "Show Arrows"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["showbnet_desc"] = "Show Social Menu"
--[[Translation missing --]]
L["showbnet_name"] = "Show Social Menu"
--[[Translation missing --]]
L["showchannel_desc"] = "Show Channel Button"
--[[Translation missing --]]
L["showchannel_name"] = "Show Channel Button"
--[[Translation missing --]]
L["showmenu_desc"] = "Show Chat Menu"
--[[Translation missing --]]
L["showmenu_name"] = "Show Menu"
--[[Translation missing --]]
L["showminimize_desc"] = "Show Minimize Button"
--[[Translation missing --]]
L["showminimize_name"] = "Show Minimize Button"
--[[Translation missing --]]
L["showvoice_desc"] = "Show Voice Buttons"
--[[Translation missing --]]
L["showvoice_name"] = "Show Voice Buttons"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("ptBR", L)



  L = {}
  -- Buttons
L["alpha_desc"] = "Définit la transparence du menu du chat et des flèches pour toutes les fenêtres de discussion."
L["alpha_name"] = "Définir la transparence"
L["Buttons"] = "Boutons"
L["Chat window button options."] = "Options des boutons de la fenêtre de discussion."
L["chatmenu_desc"] = "Activer et désactiver le menu du tchat"
L["chatmenu_name"] = "Montrer le menu du chat"
L["Default"] = "Défaut"
L["Right, Inside Frame"] = "Droite, dans le cadre"
L["Right, Outside Frame"] = "Droite, en dehors du cadre"
L["scrollReminder_desc"] = "Montrer le bouton de rappel lorsque vous n'êtes pas à la fin de la fenêtre de discussion."
L["scrollReminder_name"] = "Montrer le rappel"
L["Set Position"] = "Définir la position"
L["Sets position of chat menu and arrows for all chat windows."] = "Définir la position du menu et des flèches de toutes les fenêtres de discussion."
L["Show Arrows"] = "Montrer les flèches"
L["Show Chat%d Arrows"] = "Afficher les boutons fléchés du chat"
L["showbnet_desc"] = "Montrer le menu Social."
L["showbnet_name"] = "Montrer le menu Social"
--[[Translation missing --]]
L["showchannel_desc"] = "Show Channel Button"
--[[Translation missing --]]
L["showchannel_name"] = "Show Channel Button"
L["showmenu_desc"] = "Montrer le menu de la fenêtre de discussion."
L["showmenu_name"] = "Montrer le menu"
L["showminimize_desc"] = "Montrer le bouton pour minimiser la discussion."
L["showminimize_name"] = "Montrer Minimiser"
--[[Translation missing --]]
L["showvoice_desc"] = "Show Voice Buttons"
--[[Translation missing --]]
L["showvoice_name"] = "Show Voice Buttons"
L["Toggle showing chat arrows for each chat window."] = "Activer l'affichage des flèches pour chaque fenêtre de discussion."
L["Toggles navigation arrows on and off."] = "Activer et désactiver les flèches de navigations"

  PL:AddLocale("frFR", L)



  L = {}
  -- Buttons
L["alpha_desc"] = "Stellt die Transparenz der Chatmenüs und Navigationspfeile aller Chatfenster ein."
L["alpha_name"] = "Transparenz einstellen"
L["Buttons"] = "Schaltflächen"
L["Chat window button options."] = "Optionen für Schaltflächen im Chatfenster."
L["chatmenu_desc"] = "Schaltet das Chatmenü ein/aus."
L["chatmenu_name"] = "Chatmenü anzeigen"
L["Default"] = "Standard"
L["Right, Inside Frame"] = "Rechts, innerhalb des Rahmens"
L["Right, Outside Frame"] = "Rechts, außerhalb des Rahmens"
L["scrollReminder_desc"] = "Erinnerungsschaltfläche anzeigen, wenn du nicht am unteren Rand eines Chat-Fensters bist."
L["scrollReminder_name"] = "Runterscrollen-Erinnerung anzeigen"
L["Set Position"] = "Position einstellen"
L["Sets position of chat menu and arrows for all chat windows."] = "Stellt die Position des Chatmenüs und der Navigationspfeile für alle Chatfenster ein."
L["Show Arrows"] = "Zeige die Navigationspfeile"
L["Show Chat%d Arrows"] = "Navigationspfeile im Chat%d anzeigen"
L["showbnet_desc"] = "Geselligkeitsmenü anzeigen"
L["showbnet_name"] = "Geselligkeitsmenü anzeigen"
L["showchannel_desc"] = "Kanalschaltfläche anzeigen"
L["showchannel_name"] = "Kanalschaltfläche anzeigen"
L["showmenu_desc"] = "Chatmenü anzeigen"
L["showmenu_name"] = "Zeige das Menü"
L["showminimize_desc"] = "Minimiertaste anzeigen"
L["showminimize_name"] = "Minimiertaste anzeigen"
L["showvoice_desc"] = "Sprachschaltflächen anzeigen"
L["showvoice_name"] = "Sprachschaltflächen anzeigen"
L["Toggle showing chat arrows for each chat window."] = "Anzeige der Navigationspfeile für jedes Chatfenster ein- und ausschalten."
L["Toggles navigation arrows on and off."] = "Schaltet die Anzeige der Navigationspfeile an und aus"

  PL:AddLocale("deDE", L)



  L = {}
  -- Buttons
L["alpha_desc"] = "모든 대화창의 대화 메뉴와 화살표의 투명도를 설정합니다."
L["alpha_name"] = "투명도 설정"
L["Buttons"] = "버튼 [Buttons]"
L["Chat window button options."] = "대화창 버튼 옵션"
L["chatmenu_desc"] = "대화 메뉴를 끄고 켭니다."
L["chatmenu_name"] = "대화 메뉴 표시"
L["Default"] = "기본값"
L["Right, Inside Frame"] = "우측, 프레임 안쪽"
L["Right, Outside Frame"] = "우측, 프레임 바깥쪽"
L["scrollReminder_desc"] = "대화창을 위로 올렸을 때 맨 아래로 버튼을 표시합니다."
L["scrollReminder_name"] = "맨 아래로 버튼 표시"
L["Set Position"] = "위치 설정"
L["Sets position of chat menu and arrows for all chat windows."] = "대화창의 메뉴와 화살표의 위치를 설정합니다."
L["Show Arrows"] = "화살표 표시"
L["Show Chat%d Arrows"] = "대화창%d의 화살표 보이기"
L["showbnet_desc"] = "커뮤니티 메뉴 표시"
L["showbnet_name"] = "커뮤니티 메뉴 표시"
L["showchannel_desc"] = "채널 버튼 보이기"
L["showchannel_name"] = "채널 버튼 보이기"
L["showmenu_desc"] = "대화 메뉴 표시"
L["showmenu_name"] = "메뉴 표시"
L["showminimize_desc"] = "최소화 버튼 표시"
L["showminimize_name"] = "최소화 버튼 표시"
L["showvoice_desc"] = "음성 버튼 표시"
L["showvoice_name"] = "음성 버튼 표시"
L["Toggle showing chat arrows for each chat window."] = "각 채팅창 별로 화살표 표시를 끄고 켭니다."
L["Toggles navigation arrows on and off."] = "상하 화살표를 끄고 켭니다."

  PL:AddLocale("koKR",  L)


  L = {}
  -- Buttons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["Buttons"] = "Buttons"
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["Right, Inside Frame"] = "Right, Inside Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
--[[Translation missing --]]
L["scrollReminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["scrollReminder_name"] = "Show ScrollDown Reminder"
--[[Translation missing --]]
L["Set Position"] = "Set Position"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["Show Arrows"] = "Show Arrows"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["showbnet_desc"] = "Show Social Menu"
--[[Translation missing --]]
L["showbnet_name"] = "Show Social Menu"
--[[Translation missing --]]
L["showchannel_desc"] = "Show Channel Button"
--[[Translation missing --]]
L["showchannel_name"] = "Show Channel Button"
--[[Translation missing --]]
L["showmenu_desc"] = "Show Chat Menu"
--[[Translation missing --]]
L["showmenu_name"] = "Show Menu"
--[[Translation missing --]]
L["showminimize_desc"] = "Show Minimize Button"
--[[Translation missing --]]
L["showminimize_name"] = "Show Minimize Button"
--[[Translation missing --]]
L["showvoice_desc"] = "Show Voice Buttons"
--[[Translation missing --]]
L["showvoice_name"] = "Show Voice Buttons"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("esMX",  L)


  L = {}
  -- Buttons
L["alpha_desc"] = "Настройка прозрачности кнопки чата и всех цтрелок."
L["alpha_name"] = "Прозрачность"
L["Buttons"] = "Кнопки"
L["Chat window button options."] = "Настройки кнопок окна чата."
L["chatmenu_desc"] = "Вкл/выкл кнопки чата."
L["chatmenu_name"] = "Показать кнопку чата"
L["Default"] = "По умолчанию"
L["Right, Inside Frame"] = "Справа, внутри окна"
L["Right, Outside Frame"] = "Справа, вне окна"
L["scrollReminder_desc"] = "Вкл/выкл указателя, сигнализирующего о том, что окно чата можно прокручивать вниз."
L["scrollReminder_name"] = "Указатель прокрутки вниз"
L["Set Position"] = "Положение"
L["Sets position of chat menu and arrows for all chat windows."] = "Установить положение стрелок и кнопок чата для всех окон."
L["Show Arrows"] = "Показывать стрелки"
L["Show Chat%d Arrows"] = "Показывать стрелки %d чата"
L["showbnet_desc"] = "Показать меню Общение"
L["showbnet_name"] = "Показать меню Общение"
L["showchannel_desc"] = "Показать кнопку канала "
L["showchannel_name"] = "Показать кнопку канала "
L["showmenu_desc"] = "Отображать меню команд"
L["showmenu_name"] = "Отображать меню"
L["showminimize_desc"] = "Показать Кнопку минимизации"
L["showminimize_name"] = "Показать Кнопку минимизации"
L["showvoice_desc"] = "Показать голосовую кнопку  "
L["showvoice_name"] = "Показать голосовую кнопку  "
L["Toggle showing chat arrows for each chat window."] = "Показывать стрелки для каждого окна чата."
L["Toggles navigation arrows on and off."] = "Вкл/выкл навигационных стрелок."

  PL:AddLocale("ruRU",  L)


  L = {}
  -- Buttons
L["alpha_desc"] = "设置所有聊天窗口的聊天目录及箭头透明度"
L["alpha_name"] = "设置透明度"
L["Buttons"] = "按钮"
L["Chat window button options."] = "聊天窗口按钮选项"
L["chatmenu_desc"] = "聊天菜单开与关"
L["chatmenu_name"] = "聊天菜单_名称"
L["Default"] = "默认"
L["Right, Inside Frame"] = "框体内右侧"
L["Right, Outside Frame"] = "框体外右侧"
L["scrollReminder_desc"] = "当聊天信息不在底部时显示提醒按钮"
L["scrollReminder_name"] = "显示向下滚动提醒"
L["Set Position"] = "设置位置"
L["Sets position of chat menu and arrows for all chat windows."] = "设置所有聊天窗口的聊天目录及箭头位置"
L["Show Arrows"] = "显示箭头"
L["Show Chat%d Arrows"] = "显示聊天%d箭头"
L["showbnet_desc"] = "显示社交菜单"
L["showbnet_name"] = "显示社交菜单"
L["showchannel_desc"] = "显示频道按钮 "
L["showchannel_name"] = "显示频道按钮 "
L["showmenu_desc"] = "显示聊天菜单"
L["showmenu_name"] = "显示菜单"
L["showminimize_desc"] = "显示最小化按钮"
L["showminimize_name"] = "显示最小化按钮"
L["showvoice_desc"] = "显示语音按钮 "
L["showvoice_name"] = "显示语音按钮"
L["Toggle showing chat arrows for each chat window."] = "为各个聊天窗口显示上下翻页箭头"
L["Toggles navigation arrows on and off."] = "切换导航箭头开与关"

  PL:AddLocale("zhCN",  L)


  L = {}
  -- Buttons
L["alpha_desc"] = "Establece la transparencia del menu del chat y de las flechas para todas las ventanas."
L["alpha_name"] = "Establecer Transparencia"
L["Buttons"] = "Botones"
L["Chat window button options."] = "Opciones de los botones de la ventana del chat"
L["chatmenu_desc"] = "Alterna la activación del menú del chat."
L["chatmenu_name"] = "Mostrar Menú del Chat"
L["Default"] = "Predeterminado"
L["Right, Inside Frame"] = "Derecha, Dentro del Marco"
L["Right, Outside Frame"] = "Derecha, Fuera del Marco"
L["scrollReminder_desc"] = "Muestra el botón recordatorio cuando no se está en la parte inferior de la ventana de chat."
L["scrollReminder_name"] = "Mostrar Recordatorio de Desplazamiento Abajo"
L["Set Position"] = "Establecer Posición"
L["Sets position of chat menu and arrows for all chat windows."] = "Establece la posición del menú y de las flechas de todas las ventanas de chat."
L["Show Arrows"] = "Mostar Flechas"
L["Show Chat%d Arrows"] = "Mostar Flechas del Chat %d"
L["showbnet_desc"] = "Muestra Botón Social"
L["showbnet_name"] = "Mostrar Botón Social"
L["showchannel_desc"] = "Muestra el botón de canales de chat"
L["showchannel_name"] = "Mostrar Botón de Canales"
L["showmenu_desc"] = "Muestra el botón de menú del chat"
L["showmenu_name"] = "Mostrar Menú"
L["showminimize_desc"] = "Muestra el botón de minimizar"
L["showminimize_name"] = "Mostrar botón de minimizar"
L["showvoice_desc"] = "Muestra los botones de voz"
L["showvoice_name"] = "Mostrar botones de voz"
L["Toggle showing chat arrows for each chat window."] = "Alterna el mostrar las flechas para cada ventana de chat."
L["Toggles navigation arrows on and off."] = "Alterna la activación de las flechas de navegación."

  PL:AddLocale("esES",  L)


  L = {}
  -- Buttons
L["alpha_desc"] = "設定所有聊天視窗的聊天選單以及箭頭。"
L["alpha_name"] = "設定透明度"
L["Buttons"] = "按鈕"
L["Chat window button options."] = "聊天視窗按鈕選單。"
L["chatmenu_desc"] = "切換聊天選單的開和關。"
L["chatmenu_name"] = "顯示聊天選單"
L["Default"] = "預設值"
L["Right, Inside Frame"] = "右側，內部框架"
L["Right, Outside Frame"] = "右側，外部框架"
L["scrollReminder_desc"] = "當不在聊天視窗底部時顯示剩餘按鈕"
L["scrollReminder_name"] = "顯示視窗可下卷的提示信號"
L["Set Position"] = "設定位置"
L["Sets position of chat menu and arrows for all chat windows."] = "設定聊天選單的位置與所有聊天視窗的箭頭。"
L["Show Arrows"] = "顯示箭頭"
L["Show Chat%d Arrows"] = "顯示聊天 %d 的箭頭"
L["showbnet_desc"] = "顯示社交選單"
L["showbnet_name"] = "顯示社交選單"
--[[Translation missing --]]
L["showchannel_desc"] = "Show Channel Button"
--[[Translation missing --]]
L["showchannel_name"] = "Show Channel Button"
L["showmenu_desc"] = "顯示聊天選單"
L["showmenu_name"] = "顯示選單"
L["showminimize_desc"] = "顯示最小化按鈕"
L["showminimize_name"] = "顯示最小化按鈕"
--[[Translation missing --]]
L["showvoice_desc"] = "Show Voice Buttons"
--[[Translation missing --]]
L["showvoice_name"] = "Show Voice Buttons"
L["Toggle showing chat arrows for each chat window."] = "點擊顯示每個聊天視窗的聊天箭頭"
L["Toggles navigation arrows on and off."] = "開啟/關閉輸入箭頭"

  PL:AddLocale("zhTW",  L)
  end
  --@end-non-debug@


	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			scrollReminder = true,
			showButtons = true,
			showBnet = true,
			showMenu = true,
			showminimize = true,
			showvoice = true,
			showchannel = true,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["Buttons"],
		desc = PL["Chat window button options."],
		type = "group",
		args = {
			showButtons = {
				name = PL["Show Arrows"],
				desc = PL["Toggle showing chat arrows for each chat window."],
				type = "toggle",
				order = 100
			},
			scrollReminder = {
				name = PL["scrollReminder_name"],
				desc = PL["scrollReminder_desc"],
				type = "toggle",
				order = 110
			},
			showBnet = {
				name = PL["showbnet_name"],
				desc = PL["showbnet_desc"],
				type = "toggle",
				order = 120
			},
			showMenu = {
				name = PL["showmenu_name"],
				desc = PL["showmenu_desc"],
				type = "toggle",
				order = 130
			},
			showminimize = {
				name = PL["showminimize_name"],
				desc = PL["showminimize_desc"],
				type = "toggle",
				order = 140
			},
			showvoice = {
				name = PL["showvoice_name"],
				desc = PL["showvoice_desc"],
				type = "toggle",
				order = 150,
				hidden = not Prat.IsRetail,
			},
			showchannel = {
				name = PL["showchannel_name"],
				desc = PL["showchannel_desc"],
				type = "toggle",
				order = 160,
			}
		}
	})

	--[[------------------------------------------------
	  Module Event Functions
	------------------------------------------------]] --

	function module:GetDescription()
		return PL["Chat window button options."]
	end

	local function hide(self)
		if not self.override then
			self:Hide()
		end
		self.override = nil
	end

	function module:OnModuleEnable()
		local buttons3 = Prat:GetModule("OriginalButtons")
		if buttons3 then
			self.disabledB3 = true
			buttons3.db.profile.on = false
			buttons3:Disable()
			LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
		end

		self:APLyAllSettings()

		Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

		self:SecureHook("FCF_SetButtonSide")
	end

	function module:APLyAllSettings()
		if not self.db.profile.showButtons then
			self:HideButtons()
		else
			self:ShowButtons()
		end

		self:UpdateMenuButtons()

		self:AdjustMinimizeButtons()

		self:UpdateVoiceButtons()

		self:UpdateChannelButton()

		self:UpdateReminder()

		self:AdjustButtonFrames()
		self:MarkButtonFramesDirty()
	end

	function module:MarkButtonFramesDirty()
		for _, frame in pairs(Prat.Frames) do
			if frame.buttonFrame and frame.buttonFrame.IsLayoutFrame and frame.buttonFrame:IsLayoutFrame() then
				frame.buttonFrame:MarkDirty()
			end
		end
	end

	function module:OnModuleDisable()
		self:DisableBottomButton()
		self:ShowButtons()

		Prat.UnregisterAllChatEvents(self)
	end

	function module:UpdateReminder()
		local v = self.db.profile.scrollReminder
		if v then
			module:EnableBottomButton()
		elseif self.buttonsEnabled then
			module:DisableBottomButton()
		end
	end

	function module:OnValueChanged()
		self:APLyAllSettings()
	end

	function module:UpdateMenuButtons()
		local socialBtn = _G.QuickJoinToastButton or _G.FriendsMicroButton
		if socialBtn then
			if self.db.profile.showBnet then
				socialBtn:Show()
			else
				socialBtn:Hide()
			end
		end

		if self.db.profile.showMenu then
			ChatFrameMenuButton:SetScript("OnShow", nil)
			ChatFrameMenuButton:Show()
		else
			ChatFrameMenuButton:SetScript("OnShow", hide)
			ChatFrameMenuButton:Hide()
		end
	end

	function module:UpdateVoiceButtons()
		if ChatFrameToggleVoiceDeafenButton and ChatFrameToggleVoiceMuteButton then
			if self.db.profile.showvoice then
				ChatFrameToggleVoiceDeafenButton:SetScript("OnShow", nil)
				ChatFrameToggleVoiceMuteButton:SetScript("OnShow", nil)

				if C_VoiceChat.IsLoggedIn() then
					ChatFrameToggleVoiceDeafenButton:Show()
					ChatFrameToggleVoiceMuteButton:Show()
				end
			else
				ChatFrameToggleVoiceDeafenButton:SetScript("OnShow", hide)
				ChatFrameToggleVoiceDeafenButton:Hide()

				ChatFrameToggleVoiceMuteButton:SetScript("OnShow", hide)
				ChatFrameToggleVoiceMuteButton:Hide()
			end
		end
	end

	function module:UpdateChannelButton()
		if self.db.profile.showchannel then
			ChatFrameChannelButton:SetScript("OnShow", nil)
			ChatFrameChannelButton:Show()
		else
			ChatFrameChannelButton:SetScript("OnShow", hide)
			ChatFrameChannelButton:Hide()
		end
	end

	function module:HideButtons()
		self:UpdateMenuButtons()

		local upButton, downButton, bottomButton

		for name, frame in pairs(Prat.Frames) do
			if not Prat.IsRetail then
				upButton = _G[name .. "ButtonFrameUpButton"]
				upButton:SetScript("OnShow", hide)
				upButton:Hide()
				downButton = _G[name .. "ButtonFrameDownButton"]
				downButton:SetScript("OnShow", hide)
				downButton:Hide()
				bottomButton = _G[name .. "ButtonFrameBottomButton"]
				bottomButton:SetScript("OnShow", hide)
				bottomButton:Hide()
				--bottomButton:SetParent(frame)

				bottomButton:SetScript("OnClick", function()
					frame:ScrollToBottom()
				end)
			end
			self:FCF_SetButtonSide(frame)
		end

		self:AdjustMinimizeButtons()
	end

	function module:AdjustButtonFrames()
		for name, _ in pairs(Prat.Frames) do
			local f = _G[name .. "ButtonFrame"]

			local hasChildren = false
			for _, child in ipairs({ f:GetChildren() }) do
				if child:IsShown() then
					hasChildren = true
					break
				end
			end

			if hasChildren then
				f:SetScript("OnShow", nil)
				f:Show()
				f:SetWidth(29)
			else
				f:SetScript("OnShow", hide)
				f:Hide()
				f:SetWidth(0.1)
			end
		end
	end

	function module:AdjustMinimizeButtons()
		for name, frame in pairs(Prat.Frames) do
			local min = _G[name .. "ButtonFrameMinimizeButton"] or _G[name .. "MinimizeButton"]

			if min then

				if self.db.profile.showminimize then
					min:ClearAllPoints()

					min:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 2, 2)
					--min:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", -32, -4);

					min:SetParent(_G[frame:GetName() .. "Tab"])

					min:SetScript("OnShow",
						function(mself)
							if frame.isDocked then
								mself:Hide()
							end
						end)

					min:SetScript("OnClick",
						function()
							FCF_MinimizeFrame(frame, strupper(frame.buttonSide))
						end)

					min:Show()
				else
					min:SetScript("OnShow", hide)
					min:Hide()
				end
			end
		end
	end

	function module:ShowButtons()
		self:Unhook("FCF_SetButtonSide")
		self:UpdateMenuButtons()
		local upButton, downButton, bottomButton

		for name, frame in pairs(Prat.Frames) do
			if not Prat.IsRetail then
				upButton = _G[name .. "ButtonFrameUpButton"]
				upButton:SetScript("OnShow", nil)
				upButton:Show()
				downButton = _G[name .. "ButtonFrameDownButton"]
				downButton:SetScript("OnShow", nil)
				downButton:Show()
				bottomButton = _G[name .. "ButtonFrameBottomButton"]
				bottomButton:SetScript("OnShow", nil)
				bottomButton:SetShown(self.showButtons)
				bottomButton:SetParent(_G[name .. "ButtonFrame"])
			end

			self:FCF_SetButtonSide(frame)
		end

		self:AdjustMinimizeButtons()
	end

	--[[ - - ------------------------------------------------
	  Core Functions
	--------------------------------------------- - ]] --
	function module:FCF_SetButtonSide(chatFrame)
		local f = _G[chatFrame:GetName() .. "ButtonFrameBottomButton"]
		local bf = _G[chatFrame:GetName() .. "ButtonFrame"]

		if not Prat.IsRetail then
			if self.db.profile.showButtons then
				f:ClearAllPoints()
				f:SetPoint("BOTTOM", bf, "BOTTOM", 0, 0)
			else
				f:ClearAllPoints()
				f:SetPoint("BOTTOMRIGHT", chatFrame, "BOTTOMRIGHT", 2, 2)
			end
		end
	end

	function module:EnableBottomButton()
		if self.buttonsEnabled then
			return
		end
		self.buttonsEnabled = true
		for name, f in pairs(Prat.Frames) do
			self:SecureHook(f, "ScrollUp")
			self:SecureHook(f, "ScrollToTop", "ScrollUp")
			self:SecureHook(f, "PageUp", "ScrollUp")

			self:SecureHook(f, "ScrollDown")
			self:SecureHook(f, "ScrollToBottom", "ScrollDownForce")
			self:SecureHook(f, "PageDown", "ScrollDown")

			local button = _G[name .. "ButtonFrameBottomButton"]

			if button then
				if f:GetScrollOffset() ~= 0 then
					button.override = true
					button:Show()
				else
					button:Hide()
				end
			end
		end
	end

	function module:DisableBottomButton()
		if not self.buttonsEnabled then
			return
		end
		self.buttonsEnabled = false
		for name, f in pairs(Prat.Frames) do
			if f then
				self:Unhook(f, "ScrollUp")
				self:Unhook(f, "ScrollToTop")
				self:Unhook(f, "PageUp")
				self:Unhook(f, "ScrollDown")
				self:Unhook(f, "ScrollToBottom")
				self:Unhook(f, "PageDown")
				local button = _G[name .. "ButtonFrameBottomButton"]
				if button then
					button:Hide()
				end
			end
		end
	end

	function module:ScrollUp(frame)
		local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
		if button then
			button.override = true
			button:Show()
		end
		self:MarkButtonFramesDirty()
	end

	function module:ScrollDown(frame)
		if frame:GetScrollOffset() == 0 then
			local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
			if button then
				button:Hide()
			end
		end
		self:MarkButtonFramesDirty()
	end

	function module:ScrollDownForce(frame)
		local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]
		if button then
			button:Hide()
		end
		self:MarkButtonFramesDirty()
	end

	--function module:AddMessage(frame, text, ...)
	function module:Prat_PostAddMessage(_, _, frame)
		local button = _G[frame:GetName() .. "ButtonFrameBottomButton"]

		if not button then
			return
		end
		if frame:GetScrollOffset() > 0 then
			button.override = true
			button:Show()
		else
			button:Hide()
		end
		self:MarkButtonFramesDirty()
	end

	return
end) -- Prat:AddModuleToLoad
