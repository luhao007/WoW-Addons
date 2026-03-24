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

local NUM_CHAT_WINDOWS = NUM_CHAT_WINDOWS or Constants.ChatFrameConstants.MaxChatWindows

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("OriginalButtons", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["ChannelNames"] = true,
		["Original Buttons"] = true,
		["Chat window button options."] = true,
		["chatmenu_name"] = "Show Chat Menu",
		["chatmenu_desc"] = "Toggles chat menu on and off.",
		["Show Arrows"] = true,
		["Toggle showing chat arrows for each chat window."] = true,
		["Show Chat%d Arrows"] = true,
		["Toggles navigation arrows on and off."] = true,
		["reminder_name"] = "Show ScrollDown Reminder",
		["reminder_desc"] = "Show reminder button when not at the bottom of a chat window.",
		["Set Position"] = true,
		["Sets position of chat menu and arrows for all chat windows."] = true,
		["Default"] = true,
		["Right, Inside Frame"] = true,
		["Right, Outside Frame"] = true,
		["alpha_name"] = "Set Alpha",
		["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows.",
		buttonframe_desc = "Toggles the button frame menu on and off.",
		buttonframe_name = "Show Button Frame",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- OriginalButtons
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
L["alpha_name"] = "Set Alpha"
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
L["buttonframe_name"] = "Show Button Frame"
L["ChannelNames"] = true
L["Chat window button options."] = true
L["chatmenu_desc"] = "Toggles chat menu on and off."
L["chatmenu_name"] = "Show Chat Menu"
L["Default"] = true
L["Original Buttons"] = true
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
L["reflow_name"] = "Text Flows Around"
L["reminder_desc"] = "Show reminder button when not at the bottom of a chat window."
L["reminder_name"] = "Show ScrollDown Reminder"
L["Right, Inside Frame"] = true
L["Right, Outside Frame"] = true
L["Set Position"] = true
L["Sets position of chat menu and arrows for all chat windows."] = true
L["Show Arrows"] = true
L["Show Chat%d Arrows"] = true
L["Toggle showing chat arrows for each chat window."] = true
L["Toggles navigation arrows on and off."] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- OriginalButtons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
--[[Translation missing --]]
L["buttonframe_name"] = "Show Button Frame"
--[[Translation missing --]]
L["ChannelNames"] = "ChannelNames"
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["Original Buttons"] = "Original Buttons"
--[[Translation missing --]]
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
--[[Translation missing --]]
L["reflow_name"] = "Text Flows Around"
--[[Translation missing --]]
L["reminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["reminder_name"] = "Show ScrollDown Reminder"
--[[Translation missing --]]
L["Right, Inside Frame"] = "Right, Inside Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
--[[Translation missing --]]
L["Set Position"] = "Set Position"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["Show Arrows"] = "Show Arrows"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("itIT", L)



  L = {}
  -- OriginalButtons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
--[[Translation missing --]]
L["buttonframe_name"] = "Show Button Frame"
L["ChannelNames"] = true
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
L["Default"] = "Padrão"
L["Original Buttons"] = "Botões Originais"
--[[Translation missing --]]
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
--[[Translation missing --]]
L["reflow_name"] = "Text Flows Around"
--[[Translation missing --]]
L["reminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["reminder_name"] = "Show ScrollDown Reminder"
L["Right, Inside Frame"] = "Direito, Dentro do Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
L["Set Position"] = "Definir Posição"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
L["Show Arrows"] = "Mostrar Setas"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("ptBR", L)


  L = {}
  -- OriginalButtons
L["alpha_desc"] = "Définir l'alpha du menu du chat et des flèches pour toutes les fenêtres."
L["alpha_name"] = "Définir l'alpha"
--[[Translation missing --]]
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
--[[Translation missing --]]
L["buttonframe_name"] = "Show Button Frame"
L["ChannelNames"] = "Noms-des-Canaux"
L["Chat window button options."] = "Bouton d'options de la fenêtre de chat."
L["chatmenu_desc"] = "Activer et désactiver le menu du chat"
L["chatmenu_name"] = "Afficher le menu de chat"
L["Default"] = "Défaut"
L["Original Buttons"] = "Boutons d'origine"
--[[Translation missing --]]
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
--[[Translation missing --]]
L["reflow_name"] = "Text Flows Around"
L["reminder_desc"] = "Montrer une icône de rappel lorsque vous n'êtes pas en bas de la fenêtre de chat"
L["reminder_name"] = "Montrer un rappel pour le défilement vers le bas"
L["Right, Inside Frame"] = "Droite, Dans le cadre"
L["Right, Outside Frame"] = "Droite, En dehors du cadre"
L["Set Position"] = "Définir la position"
L["Sets position of chat menu and arrows for all chat windows."] = "Définir la position du menu de chat et des flèches pour toute les fenêtres."
L["Show Arrows"] = "Afficher les flèches"
L["Show Chat%d Arrows"] = "Montrer les flèches du Chat%d"
L["Toggle showing chat arrows for each chat window."] = "Activer les flèches de chat pour chaque fenêtre de chat"
L["Toggles navigation arrows on and off."] = "Activer et désactiver les flèches de navigation"

  PL:AddLocale("frFR",L)




  L = {}
  -- OriginalButtons
L["alpha_desc"] = "Transparenz des Chatmenüs sowie der Navigationspfeile für alle Chatfenster einstellen."
L["alpha_name"] = "Transparenz einstellen"
L["buttonframe_desc"] = "Schaltfächenrahmen-Menü anzeigen/verbergen"
L["buttonframe_name"] = "Schaltfächenrahmen anzeigen"
L["ChannelNames"] = "Kanalnamen"
L["Chat window button options."] = "Optionen für Schaltflächen im Chatfenster."
L["chatmenu_desc"] = "Ein-/Ausschalten des Chatmenüs"
L["chatmenu_name"] = "Chatmenü anzeigen"
L["Default"] = "Standard"
L["Original Buttons"] = "Standardschaltflächen"
L["reflow_desc"] = "Chatfenster-Text soll um die Schaltflächen herum fließen, nicht unter sie."
L["reflow_name"] = "Umfließungstext"
L["reminder_desc"] = "Erinnerungsschaltfläche anzeigen, wenn du dich nicht am unteren Rand eines Chatfensters befindest."
L["reminder_name"] = "Runterscrollen-Erinnerung anzeigen"
L["Right, Inside Frame"] = "Rechts, innerhalb des Rahmens"
L["Right, Outside Frame"] = "Rechts, außerhalb des Rahmens"
L["Set Position"] = "Position festlegen"
L["Sets position of chat menu and arrows for all chat windows."] = "Position von Chatmenü und -pfeilen für alle Fenster festlegen."
L["Show Arrows"] = "Scrollsymbole anzeigen"
L["Show Chat%d Arrows"] = "%d -Chat-Pfeile anzeigen"
L["Toggle showing chat arrows for each chat window."] = "Ein-/Ausschalten der Chatpfeile für jedes Chatfenster."
L["Toggles navigation arrows on and off."] = "Ein-/Ausschalten der Navigationspfeile"

  PL:AddLocale("deDE", L)


  L = {}
  -- OriginalButtons
L["alpha_desc"] = "모든 대화창의 대화 메뉴와 화살표의 투명도를 설정합니다."
L["alpha_name"] = "투명도 설정"
L["buttonframe_desc"] = "버튼 프레임 메뉴를 켜거나 끕니다."
L["buttonframe_name"] = "버튼 프레임 표시"
L["ChannelNames"] = "채널 이름"
L["Chat window button options."] = "대화창 버튼 옵션입니다."
L["chatmenu_desc"] = "대화 메뉴를 표시하거나 숨깁니다."
L["chatmenu_name"] = "대화 메뉴 표시"
L["Default"] = "기본값"
L["Original Buttons"] = "오리지날 버튼"
L["reflow_desc"] = "대화창 문자를 버튼과 겹치지 않게 합니다."
L["reflow_name"] = "문자 겹침 방지"
L["reminder_desc"] = "대화창이 최하단이 아닐 때 맨 아래로 버튼을 표시합니다."
L["reminder_name"] = "맨 아래로 버튼 표시"
L["Right, Inside Frame"] = "오른쪽, 프레임 내부"
L["Right, Outside Frame"] = "오른쪽, 프레임 외부"
L["Set Position"] = "위치 설정"
L["Sets position of chat menu and arrows for all chat windows."] = "모든 대화창에서 대화 메뉴와 화살표의 위치를 설정합니다."
L["Show Arrows"] = "화살표 표시"
L["Show Chat%d Arrows"] = "대화창%d 화살표 표시"
L["Toggle showing chat arrows for each chat window."] = "각 대화창 별로 화살표 표시 기능을 켜거나 끕니다."
L["Toggles navigation arrows on and off."] = "탐색 화살표를 켜거나 끕니다."

  PL:AddLocale("koKR",L)

  L = {}
  -- OriginalButtons
--[[Translation missing --]]
L["alpha_desc"] = "Sets alpha of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["alpha_name"] = "Set Alpha"
--[[Translation missing --]]
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
--[[Translation missing --]]
L["buttonframe_name"] = "Show Button Frame"
--[[Translation missing --]]
L["ChannelNames"] = "ChannelNames"
--[[Translation missing --]]
L["Chat window button options."] = "Chat window button options."
--[[Translation missing --]]
L["chatmenu_desc"] = "Toggles chat menu on and off."
--[[Translation missing --]]
L["chatmenu_name"] = "Show Chat Menu"
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["Original Buttons"] = "Original Buttons"
--[[Translation missing --]]
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
--[[Translation missing --]]
L["reflow_name"] = "Text Flows Around"
--[[Translation missing --]]
L["reminder_desc"] = "Show reminder button when not at the bottom of a chat window."
--[[Translation missing --]]
L["reminder_name"] = "Show ScrollDown Reminder"
--[[Translation missing --]]
L["Right, Inside Frame"] = "Right, Inside Frame"
--[[Translation missing --]]
L["Right, Outside Frame"] = "Right, Outside Frame"
--[[Translation missing --]]
L["Set Position"] = "Set Position"
--[[Translation missing --]]
L["Sets position of chat menu and arrows for all chat windows."] = "Sets position of chat menu and arrows for all chat windows."
--[[Translation missing --]]
L["Show Arrows"] = "Show Arrows"
--[[Translation missing --]]
L["Show Chat%d Arrows"] = "Show Chat%d Arrows"
--[[Translation missing --]]
L["Toggle showing chat arrows for each chat window."] = "Toggle showing chat arrows for each chat window."
--[[Translation missing --]]
L["Toggles navigation arrows on and off."] = "Toggles navigation arrows on and off."

  PL:AddLocale("esMX",L)

  L = {}
  -- OriginalButtons
L["alpha_desc"] = "Установить прозрачность меню чата, а также стрелок для всех окон чата."
L["alpha_name"] = "Прозрачность"
L["buttonframe_desc"] = "Включить или выключить меню Окна кнопок."
L["buttonframe_name"] = "Показать Окно кнопок"
L["ChannelNames"] = "Названия каналов"
L["Chat window button options."] = "Опции кнопок чата."
L["chatmenu_desc"] = "Вкл/выкл меню чата."
L["chatmenu_name"] = "Показать меню чата"
L["Default"] = "По умолчанию"
L["Original Buttons"] = "Обычные кнопки"
L["reflow_desc"] = "Текст в окне чата должен обтекать кнопки, а не уходить под них."
L["reflow_name"] = "Текст обтекает кнопки"
L["reminder_desc"] = "Показать кнопку прокрутки чата вниз, когда последнее сообщение не в нижней части окна чата."
L["reminder_name"] = "Показать прокрутку вниз"
L["Right, Inside Frame"] = "Справа, внутри рамки"
L["Right, Outside Frame"] = "Справа, вне рамки"
L["Set Position"] = "Установить позицию"
L["Sets position of chat menu and arrows for all chat windows."] = "Устанавливает позицию меню чата и стрелок для всех окон чата"
L["Show Arrows"] = "Отображать стрелки"
L["Show Chat%d Arrows"] = "Отображает стрелки чата %d"
L["Toggle showing chat arrows for each chat window."] = "Вкл/Откл отображение стрелок для всех окон чата."
L["Toggles navigation arrows on and off."] = "Вкл/Откл отображение стрелок прокрутки чата"

  PL:AddLocale("ruRU",L)

  L = {}
  -- OriginalButtons
L["alpha_desc"] = "设置所有聊天窗口里聊天菜单和聊天箭头的透明度。"
L["alpha_name"] = "设置透明度"
L["buttonframe_desc"] = "切换框架菜单按钮开关."
L["buttonframe_name"] = "显示框架按钮"
L["ChannelNames"] = "频道名字"
L["Chat window button options."] = "聊天窗口按钮选项."
L["chatmenu_desc"] = "开启或关闭聊天菜单。"
L["chatmenu_name"] = "显示聊天菜单"
L["Default"] = "默认"
L["Original Buttons"] = "初始按钮"
L["reflow_desc"] = "聊天框文字应该此按钮而非位于其下方"
L["reflow_name"] = "文字环绕"
L["reminder_desc"] = "当不在聊天窗口底部时显示提醒按钮。"
L["reminder_name"] = "显示鼠标滚动提醒器"
L["Right, Inside Frame"] = "右边,框体内"
L["Right, Outside Frame"] = "右边,框体外"
L["Set Position"] = "设置位置"
L["Sets position of chat menu and arrows for all chat windows."] = "设置所有聊天窗口的聊天菜单和箭头的位置."
L["Show Arrows"] = "显示箭头"
L["Show Chat%d Arrows"] = "显示 聊天框%d 箭头"
L["Toggle showing chat arrows for each chat window."] = "在每个聊天窗口显示聊天箭头。"
L["Toggles navigation arrows on and off."] = "开启或关闭导航箭头。"

  PL:AddLocale("zhCN",L)

  L = {}
  -- OriginalButtons
L["alpha_desc"] = "Establece la transparencia del menú y de las flechas en todas las ventanas de chat."
L["alpha_name"] = "Establecer Transparencia"
--[[Translation missing --]]
L["buttonframe_desc"] = "Toggles the button frame menu on and off."
--[[Translation missing --]]
L["buttonframe_name"] = "Show Button Frame"
L["ChannelNames"] = "NombreCanales"
L["Chat window button options."] = "Opciones de los botones de la ventana de chat."
L["chatmenu_desc"] = "Alterna activación del menú de chat."
L["chatmenu_name"] = "Mostrar Ménu de Chat"
L["Default"] = "Predeterminado"
L["Original Buttons"] = "Botones Originales"
L["reflow_desc"] = "Flujo del texto del marco de chat alrededor de los botones no por debajo de ellos."
L["reflow_name"] = "Flujo Texto Alrededor"
L["reminder_desc"] = "Muestra el botón de recordatorio cuando no se está en la parte inferior de la ventana de chat."
L["reminder_name"] = "Mostrar Recordatorio de Desplazamiento Abajo"
L["Right, Inside Frame"] = "Derecha, Interior del Marco"
L["Right, Outside Frame"] = "Derecha, Exterior del Marco"
L["Set Position"] = "Establecer Posición"
L["Sets position of chat menu and arrows for all chat windows."] = "Establece la posición del menú y de las flechas para todas las ventanas de chat."
L["Show Arrows"] = "Mostrar Flechas"
L["Show Chat%d Arrows"] = "Mostrar Flechas del Chat %d"
L["Toggle showing chat arrows for each chat window."] = "Alterna mostrar las flechas en cada ventana de chat."
L["Toggles navigation arrows on and off."] = "Alterna activación de flechas de navegación."

  PL:AddLocale("esES",L)

  L = {}
  -- OriginalButtons
L["alpha_desc"] = "為所有聊天視窗選單以及箭頭設定透明度"
L["alpha_name"] = "設定透明度"
L["buttonframe_desc"] = "切換按鍵框架選項"
L["buttonframe_name"] = "顯示按鍵框架"
L["ChannelNames"] = "頻道名稱"
L["Chat window button options."] = "聊天視窗按鈕選項。"
L["chatmenu_desc"] = "切換聊天選單開啟/關閉"
L["chatmenu_name"] = "顯示聊天選單"
L["Default"] = "預設值"
L["Original Buttons"] = "預設按鈕"
--[[Translation missing --]]
L["reflow_desc"] = "Chatframe text should flow around the buttons not under them."
L["reflow_name"] = "文字流動環繞"
L["reminder_desc"] = "顯示按鈕提醒當聊天視窗未在最底層時"
L["reminder_name"] = "顯示下方箭頭提示"
L["Right, Inside Frame"] = "右側，視窗內部"
L["Right, Outside Frame"] = "左側，視窗外部"
L["Set Position"] = "設置位置"
L["Sets position of chat menu and arrows for all chat windows."] = "為所有聊天視窗設定聊天選單以及箭頭位置"
L["Show Arrows"] = "顯示箭頭"
L["Show Chat%d Arrows"] = "顯示聊天 %d 箭頭"
L["Toggle showing chat arrows for each chat window."] = "為所有聊天視窗啟用聊天箭頭。"
L["Toggles navigation arrows on and off."] = "切換是否啟用導覽箭頭"

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@
	--module.moduleName = PL["Buttons"]
	--module.moduleDesc = PL["Chat window button options."]
	--module.consoleName = "buttons"
	--module.guiName = PL["Buttons"]
	--module.Categories = { cat.BUTTON, cat.FRAME }

	-- define the default db values
	--module.defaultDB = {
	--    on = true,
	--    chatmenu = false,
	--    chatbutton = {false, false, false, false, false, false, false},
	--    position = "DEFAULT",
	--    reminder = false,
	--    alpha = 1.0,
	--}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			chatmenu = false,
			chatarrows = { ["*"] = true },
			position = "RIGHTINSIDE",
			reminder = true,
			alpha = 1.0,
			buttonframe = false,
			friendsbutton = false,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["Original Buttons"],
		desc = PL["Chat window button options."],
		type = "group",
		args = {
			chatarrows = {
				name = PL["Show Arrows"],
				desc = PL["Toggle showing chat arrows for each chat window."],
				order = 120,
				get = "GetSubValue",
				set = "SetSubValue",
				type = "multiselect",
				values = Prat.FrameList,
			},
			chatmenu = {
				type = "toggle",
				order = 110,
				name = PL["chatmenu_name"],
				desc = PL["chatmenu_desc"],
				get = function()
					return module.db.profile.chatmenu
				end,
				set = function(_, v)
					module.db.profile.chatmenu = v
					module:ChatMenu(v)
				end,
			},
			buttonframe = {
				type = "toggle",
				order = 110,
				name = PL["buttonframe_name"],
				desc = PL["buttonframe_desc"],
				get = function()
					return module.db.profile.buttonframe
				end,
				set = function(_, v)
					module.db.profile.buttonframe = v
					module:ConfigureAllFrames()
				end,
			},
			reminder = {
				type = "toggle",
				name = PL["reminder_name"],
				desc = PL["reminder_desc"],
				get = function()
					return module.db.profile.reminder
				end,
				set = function(_, v)
					module.db.profile.reminder = v
				end,
			},
			alpha = {
				name = PL["alpha_name"],
				desc = PL["alpha_desc"],
				type = "range",
				set = function(_, v)
					module.db.profile.alpha = v;
					module:ConfigureAllFrames()
				end,
				min = 0.1,
				max = 1,
				step = 0.1,
				order = 150,
				get = function()
					return module.db.profile.alpha
				end,
			},
			position = {
				name = PL["Set Position"],
				desc = PL["Sets position of chat menu and arrows for all chat windows."],
				type = "select",
				order = 140,
				get = function()
					return module.db.profile.position
				end,
				set = function(_, v)
					module.db.profile.position = v;
					module:ConfigureAllFrames()
				end,
				values = { ["DEFAULT"] = PL["Default"], ["RIGHTINSIDE"] = PL["Right, Inside Frame"], ["RIGHTOUTSIDE"] = PL["Right, Outside Frame"] }
			}
		}
	})

	local function hide(self)
		self:Hide()
	end

	function module:OnSubValueChanged(_, val, b)
		self:chatbutton(_G[val]:GetID(), b)
	end


	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		local buttons3 = Prat:GetModule("Buttons")
		if buttons3 then
			self.disabledB3 = true
			buttons3.db.profile.on = false
			buttons3:Disable()
			LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
		end
		-- stub variables for frame handling
		self.frames = {}
		self.reminders = {}
		for name, frame in pairs(Prat.Frames) do
			local i = frame:GetID()
			table.insert(self.reminders, self:MakeReminder(i))
			self:chatbutton(i, self.db.profile.chatarrows[name])
			self:ButtonFrame(i, self.db.profile.buttonframe)
		end
		self:ChatMenu(self.db.profile.chatmenu)
		if QuickJoinToastButton then
			QuickJoinToastButton:Hide()
		end

		self.OnUpdateInterval = 0.05
		self.lastupdate = 0
		-- hook functions
		if _G.ChatFrame_OnUpdate then
			self:SecureHook("ChatFrame_OnUpdate", "ChatFrame_OnUpdateHook")
		else
			for _, v in pairs(Prat.Frames) do
				if v and v.OnUpdate then
					self:SecureHook(v, "OnUpdate", "ChatFrame_OnUpdateHook")
				end
			end
		end
		self:SecureHook("FCF_SetTemporaryWindowType")
	end

	-- things to do when the module is disabled
	function module:OnModuleDisable()
		-- show chatmenu
		self:ChatMenu(true)
		-- show all the chatbuttons
		for i = 1, NUM_CHAT_WINDOWS do
			self:chatbutton(i, true)
		end
		-- unhook functions
		self:UnhookAll()
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --

	function module:GetDescription()
		return PL["Original Buttons"]
	end

	function module:FCF_SetTemporaryWindowType(chatFrame)
		local i = chatFrame:GetID()

		self:chatbutton(i, self.db.profile.chatarrows[chatFrame:GetName()])
		self:ButtonFrame(i, self.db.profile.buttonframe)
	end

	function module:ConfigureAllFrames()
		for name, frame in pairs(Prat.Frames) do
			local i = frame:GetID()
			self:chatbutton(i, self.db.profile.chatarrows[name])
			self:ButtonFrame(i, self.db.profile.buttonframe)
		end
		self:ChatMenu(self.db.profile.chatmenu)

		if QuickJoinToastButton then
			QuickJoinToastButton:Hide()
		end
	end

	function module:ChatFrame_OnUpdateHook(this, elapsed)
		if not this:IsVisible() and not this:IsShown() then
			return
		end
		self.lastupdate = self.lastupdate + elapsed

		while (self.lastupdate > self.OnUpdateInterval) do
			self:ChatFrame_OnUpdate(this, elapsed)
			self.lastupdate = self.lastupdate - self.OnUpdateInterval;
		end
	end

	do
		local anims
		function module:ChatFrame_OnUpdate(this)
			if (not this:IsShown()) then
				return ;
			end

			local id = this:GetID()
			local prof = self.db.profile
			local show = prof.chatarrows[this:GetName()]

			self:chatbutton(id, show)
			--self:ChatFrame_OnUpdateTextFlow(this, elapsed)

			-- This is all code for the 'reminder' from here on
			if show then
				return
			end
			if not prof.reminder then
				return
			end
			local remind = _G[this:GetName() .. "ScrollDownReminder"];
			local flash = _G[this:GetName() .. "ScrollDownReminderFlash"];
			if (not flash) then
				return
			end
			if not anims then
				anims = {}
			end
			if not anims[flash] then
				anims[flash] = flash:CreateAnimationGroup()

				local fade1 = anims[flash]:CreateAnimation("Alpha")
				fade1:SetDuration(0.1)
				fade1:SetToAlpha(1)
				fade1:SetEndDelay(0.5)
				fade1:SetOrder(1)

				local fade2 = anims[flash]:CreateAnimation("Alpha")
				fade2:SetDuration(0.1)
				fade2:SetToAlpha(-1)
				fade2:SetEndDelay(0.5)
				fade2:SetOrder(2)
			end
			if (this:AtBottom()) then
				if (remind:IsShown()) then
					remind:Hide();
					anims[flash]:Stop()
				end
				return ;
			else
				if (remind:IsShown()) then
					return
				end
				remind:Show()
				flash:Show()
				flash:SetAlpha(0)
				anims[flash]:SetLooping("REPEAT")
				anims[flash]:Play()
			end
		end
	end

	function module:ButtonFrame(id, visible)
		local f = _G["ChatFrame" .. id .. "ButtonFrame"]

		if visible then
			f:SetScript("OnShow", nil)
			f:Show()
			f:SetWidth(29)
		else
			f:SetScript("OnShow", hide)
			f:Hide()

			f:SetWidth(0.1)
		end
	end

	-- manipulate chatframe menu button
	function module:ChatMenu(visible)
		local ChatFrameMenuButton = ChatFrameMenuButton
		-- define variables used
		local f = self.frames[1]
		if not f then
			self.frames[1] = {}
			f = self.frames[1]
		end
		f.cfScrl = f.cfScrl or {}
		f.cfScrl.up = _G["ChatFrame1ButtonFrameUpButton"]
		-- chatmenu position:
		-- position chatmenu under the UpButton for chatframe1 if button position is set to "RIGHTINSIDE"
		-- otherwise position chatmenu above the UpButton for chatframe1
		ChatFrameMenuButton:ClearAllPoints()
		if self.db.profile.position == "RIGHTINSIDE" then
			ChatFrameMenuButton:SetPoint("TOP", f.cfScrl.up, "BOTTOM")
		else
			ChatFrameMenuButton:SetPoint("BOTTOM", f.cfScrl.up, "TOP")
		end
		-- chatmenu alpha:
		-- set alpha of the chatmenu based on the alpha setting
		ChatFrameMenuButton:SetAlpha(self.db.profile.alpha)
		-- chatmenu visibility
		-- show buttons based on show settings
		if visible then
			ChatFrameMenuButton:SetScript("OnShow", nil)
			ChatFrameMenuButton:Show()
		else
			ChatFrameMenuButton:Hide()
			ChatFrameMenuButton:SetScript("OnShow", hide)
		end
	end



	-- manipulate chatframe scrolling and reminder buttons
	function module:chatbutton(id, visible)
		-- define variables used
		local f = self.frames[id]
		--local id = this:GetID()
		if not f then
			self.frames[id] = {}
			f = self.frames[id]
		end

		f.cfScrl = f.cfScrl or {}
		f.cf = f.cf or _G["ChatFrame" .. id]
		f.cfScrl.up = f.cfScrl.up or _G["ChatFrame" .. id .. "ButtonFrameUpButton"]
		f.cfScrl.down = f.cfScrl.down or _G["ChatFrame" .. id .. "ButtonFrameDownButton"]
		f.cfScrl.bottom = f.cfScrl.bottom or _G["ChatFrame" .. id .. "ButtonFrameBottomButton"]
		f.cfScrl.min = f.cfScrl.min or _G["ChatFrame" .. id .. "ButtonFrameMinimizeButton"] or _G["ChatFrame" .. id .. "MinimizeButton"]

		if f.cfScrl.up then
			f.cfScrl.up:SetParent(f.cf)
			f.cfScrl.down:SetParent(f.cf)
			f.cfScrl.bottom:SetParent(f.cf)
			f.cfScrl.min:SetParent(_G[f.cf:GetName() .. "Tab"])

			f.cfScrl.min:SetScript("OnShow",
				function(minSelf)
					if f.cf.isDocked then
						minSelf:Hide()
					end
				end)

			f.cfScrl.min:SetScript("OnClick",
				function()
					FCF_MinimizeFrame(f.cf, strupper(f.cf.buttonSide))
				end)

			f.cfScrl.up:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_CHAT_SCROLL_UP);
				f.cf:ScrollUp()
			end)
			f.cfScrl.down:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_CHAT_SCROLL_DOWN);
				f.cf:ScrollDown()
			end)
			f.cfScrl.bottom:SetScript("OnClick", function()
				PlaySound(SOUNDKIT.IG_CHAT_BOTTOM);
				f.cf:ScrollToBottom()
			end)
		end

		f.cfScrlheight = (f.cfScrlheight and f.cfScrlheight > 0) and f.cfScrlheight or ((f.cfScrl.up and f.cfScrl.down and f.cfScrl.bottom) and
			(f.cfScrl.up:GetHeight() + f.cfScrl.down:GetHeight() + f.cfScrl.bottom:GetHeight()) or 0)
		f.cfreminder = f.cfreminder or self:MakeReminder(id)
		f.cfreminderflash = f.cfreminderflash or _G["ChatFrame" .. id .. "ScrollDownReminderFlash"]

		-- chatbuttons position:
		-- position of the chatbuttons based on position setting
		if f.cfScrl.bottom and f.cfScrl.up then
			f.cfScrl.bottom:ClearAllPoints()
			f.cfScrl.up:ClearAllPoints()
			if self.db.profile.position == "RIGHTINSIDE" then
				f.cfScrl.bottom:SetPoint("BOTTOMRIGHT", f.cf, "BOTTOMRIGHT", 0, -4)
				f.cfScrl.up:SetPoint("TOPRIGHT", f.cf, "TOPRIGHT", 0, -4)
			elseif self.db.profile.position == "RIGHTOUTSIDE" then
				f.cfScrl.bottom:SetPoint("BOTTOMLEFT", f.cf, "BOTTOMRIGHT", 0, -4)
				f.cfScrl.up:SetPoint("BOTTOM", f.cfScrl.down, "TOP", 0, -2)
			else
				f.cfScrl.bottom:SetPoint("BOTTOMLEFT", f.cf, "BOTTOMLEFT", -32, -4)
				f.cfScrl.up:SetPoint("BOTTOM", f.cfScrl.down, "TOP", 0, -2)
			end
		end

		-- chatbuttons alpha:
		-- set alpha of the chatbuttons based on the alpha setting
		for _, v in pairs(f.cfScrl) do
			v:SetAlpha(self.db.profile.alpha)
		end
		-- chatbuttons visibility:
		-- show buttons based on visible value passed to function
		if f.cf then
			if visible and (f.cf:GetHeight() > f.cfScrlheight) then
				for k, _ in pairs(f.cfScrl) do
					f.cfScrl[k]:Show()
				end
			else
				for k, _ in pairs(f.cfScrl) do
					f.cfScrl[k]:Hide()
				end
				-- reminder visibility:
				-- show the reminder button (if enabled) when not at the bottom of the chatframe
				if (not f.cf:AtBottom()) and self.db.profile.reminder and (f.cf:GetHeight() > f.cfreminder:GetHeight()) then
					local b = f.cfreminder
					b:ClearAllPoints()
					if f.cf:GetJustifyH() == "RIGHT" then
						b:SetPoint("LEFT", f.cf, "LEFT", 0, 0)
						b:SetPoint("RIGHT", f.cf, "LEFT", 32, 0)
						b:SetPoint("TOP", f.cf, "BOTTOM", 0, 28)
						b:SetPoint("BOTTOM", f.cf, "BOTTOM", 0, 0)
					elseif f.cf:GetJustifyH() == "LEFT" then
						b:SetPoint("RIGHT", f.cf, "RIGHT", 0, 0)
						b:SetPoint("LEFT", f.cf, "RIGHT", -32, 0)
						b:SetPoint("TOP", f.cf, "BOTTOM", 0, 28)
						b:SetPoint("BOTTOM", f.cf, "BOTTOM", 0, 0)
					end

					f.cfreminder:Show()
					f.cfreminderflash:Show()
				else
					f.cfreminder:Hide()
					f.cfreminderflash:Hide()
				end
			end
		end
	end

	-- create a "reminder" button
	function module:MakeReminder(id)
		-- define variables used
		local cf = _G["ChatFrame" .. id]
		local b = _G["ChatFrame" .. id .. "ScrollDownReminder"]
		if b then
			return b
		end
		b = CreateFrame("Button", "ChatFrame" .. id .. "ScrollDownReminder", cf)
		-- define the parameters for the button
		b:SetFrameStrata("BACKGROUND")
		b:SetWidth(24)
		b:SetHeight(24)
		b:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Up")
		b:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollEnd-Down")
		b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
		b:SetPoint("RIGHT", cf, "RIGHT", 0, 0)
		b:SetPoint("LEFT", cf, "RIGHT", -32, 0)
		b:SetPoint("TOP", cf, "BOTTOM", 0, 28)
		b:SetPoint("BOTTOM", cf, "BOTTOM", 0, 0)
		b:SetScript("OnClick", function()
			PlaySound(SOUNDKIT.IG_CHAT_BOTTOM);
			cf:ScrollToBottom()
		end)
		-- hide the button by default
		b:Hide()
		-- add a flash texture for the reminder button
		self:AddFlashTexture(b)

		return b
	end

	-- create a "flash" texture
	function module:AddFlashTexture(frame)
		-- define variables used
		local t = frame:CreateTexture(frame:GetName() .. "Flash", "OVERLAY")
		-- define the parameters for the texture
		t:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-BlinkHilight")
		t:SetPoint("CENTER", frame, "CENTER", 0, 1)
		t:SetBlendMode("ADD")
		t:SetAlpha(0.5)
		-- hide the texture by default
		t:Hide()
	end

	return
end) -- Prat:AddModuleToLoad
