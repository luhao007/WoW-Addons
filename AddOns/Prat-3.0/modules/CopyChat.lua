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

local ChatEdit_GetActiveWindow = _G.ChatEdit_GetActiveWindow or _G.ChatFrameUtil.GetActiveWindow
local ChatEdit_ChooseBoxForSend = _G.ChatEdit_ChooseBoxForSend or _G.ChatFrameUtil.ChooseBoxForSend

local ChatFrame_OpenChat = _G.ChatFrame_OpenChat or _G.ChatFrameUtil.OpenChat
local StripHyperlinks = _G.StripHyperlinks or _G.C_StringUtil.StripHyperlinks

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("CopyChat", "AceHook-3.0", "AceTimer-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["CopyChat"] = true,
		["Copy text from the active chat window."] = true,
		["Copy Text"] = true,
		["Copy To Editbox"] = true,
		["Copy all of the text in the selected chat frame into an edit box"] = true,
		["showbutton_name"] = "Copy Button",
		["showbutton_desc"] = "Show a button on the chatframe",
		buttonpos_name = "Button Location",
		buttonpos_desc = "Where on the chatframe to show the copy button",
		["ChatFrame"] = true,
		[" Text"] = true,
		["Message From : %s"] = true,
		["Copy Text Format"] = true,
		["Should the copied text be plain, or formatted so you can see the colors."] = true,
		["Plain"] = true,
		["HTML"] = true,
		["BBCode"] = true,
		["Wowace.com Forums"] = true,
		copytimestamps_name = "Timestamps Copy",
		copytimestamps_desc = "Copy the chat line when you click on the timestamp",
		TOPLEFT = "Top, Left",
		TOPRIGHT = "Top, Right",
		BOTTOMRIGHT = "Bottom, Right",
		BOTTOMLEFT = "Bottom, Left",
		activealpha = "Alpha when mouseover",
		inactivealpha = "Alpha when mouseout",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L

		L = {}
-- CopyChat
L[" Text"] = true
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
L["BOTTOMLEFT"] = "Bottom, Left"
L["BOTTOMRIGHT"] = "Bottom, Right"
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
L["buttonpos_name"] = "Button Location"
L["ChatFrame"] = true
L["Copy all of the text in the selected chat frame into an edit box"] = true
L["Copy Text"] = true
L["Copy Text Format"] = true
L["Copy text from the active chat window."] = true
L["Copy To Editbox"] = true
L["CopyChat"] = true
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
L["copytimestamps_name"] = "Timestamps Copy"
L["HTML"] = true
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = true
L["Plain"] = true
L["Should the copied text be plain, or formatted so you can see the colors."] = true
L["showbutton_desc"] = "Show a button on the chatframe"
L["showbutton_name"] = "Copy Button"
L["TOPLEFT"] = "Top, Left"
L["TOPRIGHT"] = "Top, Right"
L["Wowace.com Forums"] = true

		PL:AddLocale("enUS", L)

		L = {}
-- CopyChat
L[" Text"] = "Testo"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
--[[Translation missing --]]
L["BBCode"] = "BBCode"
--[[Translation missing --]]
L["BOTTOMLEFT"] = "Bottom, Left"
--[[Translation missing --]]
L["BOTTOMRIGHT"] = "Bottom, Right"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
--[[Translation missing --]]
L["buttonpos_name"] = "Button Location"
--[[Translation missing --]]
L["ChatFrame"] = "ChatFrame"
--[[Translation missing --]]
L["Copy all of the text in the selected chat frame into an edit box"] = "Copy all of the text in the selected chat frame into an edit box"
--[[Translation missing --]]
L["Copy Text"] = "Copy Text"
--[[Translation missing --]]
L["Copy Text Format"] = "Copy Text Format"
--[[Translation missing --]]
L["Copy text from the active chat window."] = "Copy text from the active chat window."
--[[Translation missing --]]
L["Copy To Editbox"] = "Copy To Editbox"
--[[Translation missing --]]
L["CopyChat"] = "CopyChat"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
--[[Translation missing --]]
L["HTML"] = "HTML"
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
--[[Translation missing --]]
L["Message From : %s"] = "Message From : %s"
--[[Translation missing --]]
L["Plain"] = "Plain"
--[[Translation missing --]]
L["Should the copied text be plain, or formatted so you can see the colors."] = "Should the copied text be plain, or formatted so you can see the colors."
--[[Translation missing --]]
L["showbutton_desc"] = "Show a button on the chatframe"
--[[Translation missing --]]
L["showbutton_name"] = "Copy Button"
--[[Translation missing --]]
L["TOPLEFT"] = "Top, Left"
--[[Translation missing --]]
L["TOPRIGHT"] = "Top, Right"
--[[Translation missing --]]
L["Wowace.com Forums"] = "Wowace.com Forums"

		PL:AddLocale("itIT", L)

		L = {}
-- CopyChat
L[" Text"] = "Texto"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
--[[Translation missing --]]
L["BBCode"] = "BBCode"
--[[Translation missing --]]
L["BOTTOMLEFT"] = "Bottom, Left"
--[[Translation missing --]]
L["BOTTOMRIGHT"] = "Bottom, Right"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
--[[Translation missing --]]
L["buttonpos_name"] = "Button Location"
--[[Translation missing --]]
L["ChatFrame"] = "ChatFrame"
--[[Translation missing --]]
L["Copy all of the text in the selected chat frame into an edit box"] = "Copy all of the text in the selected chat frame into an edit box"
--[[Translation missing --]]
L["Copy Text"] = "Copy Text"
--[[Translation missing --]]
L["Copy Text Format"] = "Copy Text Format"
--[[Translation missing --]]
L["Copy text from the active chat window."] = "Copy text from the active chat window."
--[[Translation missing --]]
L["Copy To Editbox"] = "Copy To Editbox"
--[[Translation missing --]]
L["CopyChat"] = "CopyChat"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
--[[Translation missing --]]
L["HTML"] = "HTML"
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
--[[Translation missing --]]
L["Message From : %s"] = "Message From : %s"
--[[Translation missing --]]
L["Plain"] = "Plain"
--[[Translation missing --]]
L["Should the copied text be plain, or formatted so you can see the colors."] = "Should the copied text be plain, or formatted so you can see the colors."
--[[Translation missing --]]
L["showbutton_desc"] = "Show a button on the chatframe"
--[[Translation missing --]]
L["showbutton_name"] = "Copy Button"
--[[Translation missing --]]
L["TOPLEFT"] = "Top, Left"
--[[Translation missing --]]
L["TOPRIGHT"] = "Top, Right"
L["Wowace.com Forums"] = "Wowace.com Fóruns"

		PL:AddLocale("ptBR", L)

		L = {}
-- CopyChat
L[" Text"] = "Texte"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
--[[Translation missing --]]
L["BOTTOMLEFT"] = "Bottom, Left"
--[[Translation missing --]]
L["BOTTOMRIGHT"] = "Bottom, Right"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
--[[Translation missing --]]
L["buttonpos_name"] = "Button Location"
--[[Translation missing --]]
L["ChatFrame"] = "ChatFrame"
L["Copy all of the text in the selected chat frame into an edit box"] = "Copier tout le texte de la fenêtre de discussion sélectionnée dans une boîte d'édition."
L["Copy Text"] = "Copier le texte"
L["Copy Text Format"] = "Format du texte copié"
L["Copy text from the active chat window."] = "Copier le texte à partir de la fenêtre de discussion active."
L["Copy To Editbox"] = "Copier vers la fenêtre d'édition"
L["CopyChat"] = "Copier"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
L["HTML"] = true
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "Message de : %s"
L["Plain"] = "Texte seul"
L["Should the copied text be plain, or formatted so you can see the colors."] = "Le texte copié doit-il être seul, ou formaté de tel manière à voir les couleurs."
L["showbutton_desc"] = "Montrer un bouton sur la fenêtre de discussion."
L["showbutton_name"] = "Bouton de copie"
--[[Translation missing --]]
L["TOPLEFT"] = "Top, Left"
--[[Translation missing --]]
L["TOPRIGHT"] = "Top, Right"
L["Wowace.com Forums"] = "Forums wowace.com"

		PL:AddLocale("frFR",L)

		L = {}
-- CopyChat
L[" Text"] = "Text"
L["activealpha"] = "Transparenz, wenn mit der Maus darüber gefahren wird"
L["BBCode"] = true
L["BOTTOMLEFT"] = "Unten, links"
L["BOTTOMRIGHT"] = "Unten, rechts"
L["buttonpos_desc"] = "Wo im Chatfenster die Kopier-Schaltfläche angezeigt werden soll."
L["buttonpos_name"] = "Schaltflächenposition"
L["ChatFrame"] = "Chatfenster"
L["Copy all of the text in the selected chat frame into an edit box"] = "Den gesamten Text des ausgewählten Chatfensters in ein Eingabefeld kopieren"
L["Copy Text"] = "Text kopieren"
L["Copy Text Format"] = "Textformat kopieren"
L["Copy text from the active chat window."] = "Text im aktiven Chatfenster kopieren."
L["Copy To Editbox"] = "In das Eingabefeld kopieren"
L["CopyChat"] = "Chat kopieren"
L["copytimestamps_desc"] = "Kopiert die Chat-Zeile, wenn du auf den Zeitstempel klickst"
L["copytimestamps_name"] = "Zeitstempel kopieren"
L["HTML"] = true
L["inactivealpha"] = "Transparenz, wenn mit der Maus nicht darüber gefahren wird"
L["Message From : %s"] = "Nachricht von : %s"
L["Plain"] = "Einfach"
L["Should the copied text be plain, or formatted so you can see the colors."] = "Soll der kopierte Text einfach oder formattiert mit farbiger Darstellung kopiert werden?"
L["showbutton_desc"] = "Schaltfläche im Chat-Rahmen anzeigen"
L["showbutton_name"] = "Schaltfläche Kopieren"
L["TOPLEFT"] = "Oben, links"
L["TOPRIGHT"] = "Oben, rechts"
L["Wowace.com Forums"] = "Wowace.com Foren"

		PL:AddLocale("deDE", L)

		L = {}
-- CopyChat
L[" Text"] = " 텍스트"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
L["BOTTOMLEFT"] = "하단, 좌측"
L["BOTTOMRIGHT"] = "하단, 우측"
L["buttonpos_desc"] = "복사 버튼을 표시할 대화창의 위치"
L["buttonpos_name"] = "버튼 위치"
L["ChatFrame"] = "대화창 [Frames]"
L["Copy all of the text in the selected chat frame into an edit box"] = "선택된 대화창의 모든 내용을 대화 입력창으로 복사합니다"
L["Copy Text"] = "텍스트 복사"
L["Copy Text Format"] = "복사 내용 서식"
L["Copy text from the active chat window."] = "활성 대화창에서 내용을 복사합니다."
L["Copy To Editbox"] = "대화 입력창에 복사"
L["CopyChat"] = "대화 복사 [CopyChat]"
L["copytimestamps_desc"] = "대화 시각을 클릭하면 그 대화줄을 복사합니다."
L["copytimestamps_name"] = "대화 시각 복사"
L["HTML"] = true
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "%s|1으로;로;부터 메시지"
L["Plain"] = "보통"
L["Should the copied text be plain, or formatted so you can see the colors."] = "복사된 내용을 보통으로 표시하거나, 또는 색상을 보기 위해 형식화 합니다."
L["showbutton_desc"] = "대화창에 버튼 표시"
L["showbutton_name"] = "복사 버튼"
L["TOPLEFT"] = "상단, 좌측"
L["TOPRIGHT"] = "상단, 우측"
L["Wowace.com Forums"] = "Wowace.com 포럼"

		PL:AddLocale("koKR",L)

		L = {}
-- CopyChat
--[[Translation missing --]]
L[" Text"] = " Text"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
--[[Translation missing --]]
L["BBCode"] = "BBCode"
--[[Translation missing --]]
L["BOTTOMLEFT"] = "Bottom, Left"
--[[Translation missing --]]
L["BOTTOMRIGHT"] = "Bottom, Right"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
--[[Translation missing --]]
L["buttonpos_name"] = "Button Location"
--[[Translation missing --]]
L["ChatFrame"] = "ChatFrame"
--[[Translation missing --]]
L["Copy all of the text in the selected chat frame into an edit box"] = "Copy all of the text in the selected chat frame into an edit box"
--[[Translation missing --]]
L["Copy Text"] = "Copy Text"
--[[Translation missing --]]
L["Copy Text Format"] = "Copy Text Format"
--[[Translation missing --]]
L["Copy text from the active chat window."] = "Copy text from the active chat window."
--[[Translation missing --]]
L["Copy To Editbox"] = "Copy To Editbox"
--[[Translation missing --]]
L["CopyChat"] = "CopyChat"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
--[[Translation missing --]]
L["HTML"] = "HTML"
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
--[[Translation missing --]]
L["Message From : %s"] = "Message From : %s"
--[[Translation missing --]]
L["Plain"] = "Plain"
--[[Translation missing --]]
L["Should the copied text be plain, or formatted so you can see the colors."] = "Should the copied text be plain, or formatted so you can see the colors."
--[[Translation missing --]]
L["showbutton_desc"] = "Show a button on the chatframe"
--[[Translation missing --]]
L["showbutton_name"] = "Copy Button"
--[[Translation missing --]]
L["TOPLEFT"] = "Top, Left"
--[[Translation missing --]]
L["TOPRIGHT"] = "Top, Right"
--[[Translation missing --]]
L["Wowace.com Forums"] = "Wowace.com Forums"

		PL:AddLocale("esMX",L)

		L = {}
-- CopyChat
L[" Text"] = " Текст"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
L["BOTTOMLEFT"] = "Снизу, Слева"
L["BOTTOMRIGHT"] = "Снизу, Справа"
L["buttonpos_desc"] = "Где в окне чата показывать кнопку копирования"
L["buttonpos_name"] = "Положение кнопки"
L["ChatFrame"] = "Окно чата"
L["Copy all of the text in the selected chat frame into an edit box"] = "Копировать весь текст из выбранного окна чата в поле ввода."
L["Copy Text"] = "Копировать текст"
L["Copy Text Format"] = "Формат копирования текста"
L["Copy text from the active chat window."] = "Копировать текст из активного окна чата."
L["Copy To Editbox"] = "Копировать чат"
L["CopyChat"] = "Копия Чата "
L["copytimestamps_desc"] = "Скопируйте строку чата при нажатии на метку времени"
L["copytimestamps_name"] = "Копирование временны́х меток"
L["HTML"] = true
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "Сообщение от : %s"
L["Plain"] = "Обычный текст"
L["Should the copied text be plain, or formatted so you can see the colors."] = "Копировать информацию как обычный текст или же форматированный, с сохранением цветов и т.п."
L["showbutton_desc"] = "Показывать кнопку копирования в окне чата"
L["showbutton_name"] = "Кнопка копирования"
L["TOPLEFT"] = "Сверху, Слева"
L["TOPRIGHT"] = "Сверху, Справа"
L["Wowace.com Forums"] = "Форумы Wowace.com"

		PL:AddLocale("ruRU",L)

		L = {}
-- CopyChat
L[" Text"] = "文本"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = "BB代码"
L["BOTTOMLEFT"] = "左下"
L["BOTTOMRIGHT"] = "右下"
L["buttonpos_desc"] = "复制按钮在聊天框的位置"
L["buttonpos_name"] = "按钮位置"
L["ChatFrame"] = "聊天框"
L["Copy all of the text in the selected chat frame into an edit box"] = "在选定的聊天框复制全部文本到输入框"
L["Copy Text"] = "复制文本"
L["Copy Text Format"] = "复制文本格式"
L["Copy text from the active chat window."] = "从活跃的聊天窗口复制文本"
L["Copy To Editbox"] = "复制到编辑框"
L["CopyChat"] = "聊天复制"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
L["HTML"] = "超文本标记语言"
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "信息来自: %s"
L["Plain"] = "简洁"
L["Should the copied text be plain, or formatted so you can see the colors."] = "如果用简洁或排版复制的文本,你可以看到颜色"
L["showbutton_desc"] = "在聊天框显示按钮"
L["showbutton_name"] = "复制按钮"
L["TOPLEFT"] = "左上"
L["TOPRIGHT"] = "右上"
L["Wowace.com Forums"] = "Wowace.com论坛"

		PL:AddLocale("zhCN",L)

		L = {}
-- CopyChat
L[" Text"] = "Texto"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
--[[Translation missing --]]
L["BOTTOMLEFT"] = "Bottom, Left"
--[[Translation missing --]]
L["BOTTOMRIGHT"] = "Bottom, Right"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
--[[Translation missing --]]
L["buttonpos_name"] = "Button Location"
L["ChatFrame"] = "MarcoChat"
L["Copy all of the text in the selected chat frame into an edit box"] = "Copiar todo el texto seleccionado en el marco del chat a una caja de edición"
L["Copy Text"] = "Copiar Texto"
L["Copy Text Format"] = "Copiar Texto con fomato"
L["Copy text from the active chat window."] = "Copiar texto desde la ventana de chat activa."
--[[Translation missing --]]
L["Copy To Editbox"] = "Copy To Editbox"
L["CopyChat"] = "ChatCopiar"
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
L["HTML"] = true
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "Mensaje de : %s"
L["Plain"] = "Liso"
L["Should the copied text be plain, or formatted so you can see the colors."] = "El texto copiado debería ser llano, o con formato para que pueda ver los colores. "
L["showbutton_desc"] = "Muestra un botón en el marco del chat"
L["showbutton_name"] = "Botón Copiar"
--[[Translation missing --]]
L["TOPLEFT"] = "Top, Left"
--[[Translation missing --]]
L["TOPRIGHT"] = "Top, Right"
L["Wowace.com Forums"] = "Foros Wowace.com"

		PL:AddLocale("esES",L)

		L = {}
-- CopyChat
L[" Text"] = "文字"
--[[Translation missing --]]
L["activealpha"] = "Alpha when mouseover"
L["BBCode"] = true
L["BOTTOMLEFT"] = "下, 左"
L["BOTTOMRIGHT"] = "下, 右"
--[[Translation missing --]]
L["buttonpos_desc"] = "Where on the chatframe to show the copy button"
L["buttonpos_name"] = "按鈕位置"
L["ChatFrame"] = "聊天視窗"
--[[Translation missing --]]
L["Copy all of the text in the selected chat frame into an edit box"] = "Copy all of the text in the selected chat frame into an edit box"
L["Copy Text"] = "複製文字"
L["Copy Text Format"] = "複製文字格式"
L["Copy text from the active chat window."] = "複製使用中聊天視窗文字"
L["Copy To Editbox"] = "複製至編輯盒"
L["CopyChat"] = true
--[[Translation missing --]]
L["copytimestamps_desc"] = "Copy the chat line when you click on the timestamp"
--[[Translation missing --]]
L["copytimestamps_name"] = "Timestamps Copy"
L["HTML"] = true
--[[Translation missing --]]
L["inactivealpha"] = "Alpha when mouseout"
L["Message From : %s"] = "來自 %s 的訊息"
--[[Translation missing --]]
L["Plain"] = "Plain"
--[[Translation missing --]]
L["Should the copied text be plain, or formatted so you can see the colors."] = "Should the copied text be plain, or formatted so you can see the colors."
L["showbutton_desc"] = "於聊天視窗中顯示按鈕"
L["showbutton_name"] = "複製按鈕"
L["TOPLEFT"] = "上, 左"
L["TOPRIGHT"] = "上, 右"
L["Wowace.com Forums"] = "Wowace.com 論壇"

		PL:AddLocale("zhTW",L)
	end
	--@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			showbutton = { ["*"] = true },
			buttonpos = "TOPLEFT",
			copyformat = "plain",
			copytimestamps = true,
			activealpha = 0.9,
			inactivealpha = 0.2,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["CopyChat"],
		desc = PL["Copy text from the active chat window."],
		type = "group",
		args = {
			showbutton = {
				name = PL["showbutton_name"],
				desc = PL["showbutton_desc"],
				type = "multiselect",
				values = Prat.FrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			buttonpos = {
				name = PL.buttonpos_name,
				desc = PL.buttonpos_desc,
				type = "select",
				order = 195,
				get = "GetValue",
				set = "SetValue",
				values = {
					["TOPLEFT"] = PL.TOPLEFT,
					["TOPRIGHT"] = PL.TOPRIGHT,
					["BOTTOMLEFT"] = PL.BOTTOMLEFT,
					["BOTTOMRIGHT"] = PL.BOTTOMRIGHT
				},
			},
			copy = {
				name = PL["Copy Text"],
				desc = PL["Copy all of the text in the selected chat frame into an edit box"],
				type = "execute",
				order = 190,
				func = "MenuScrape"
			},
			copyformat = {
				name = PL["Copy Text Format"],
				desc = PL["Should the copied text be plain, or formatted so you can see the colors."],
				type = "select",
				order = 195,
				get = "GetValue",
				set = "SetValue",
				values = { ["plain"] = PL["Plain"], ["bbcode"] = PL["BBCode"], ["html"] = PL["HTML"], ["wowace"] = PL["Wowace.com Forums"] },
			},
			copytimestamps = {
				name = PL.copytimestamps_name,
				desc = PL.copytimestamps_desc,
				type = "toggle",
				order = 200,
			},
			activealpha = {
				name = PL["activealpha"],
				type = "range",
				order = 210,
				min = 0,
				max = 1.0,
				step = 0.1,
			},
			inactivealpha = {
				name = PL["inactivealpha"],
				type = "range",
				order = 220,
				min = 0,
				max = 1.0,
				step = 0.1,
			},
		}
	})

	Prat:SetModuleInit(module.name, function(self)
		PratCCFrameScrollText:SetScript("OnTextChanged", function(this)
			self:OnTextChanged(this)
		end)
		PratCCFrameScrollText:SetScript("OnEscapePressed", function()
			PratCCFrame:Hide()
			self.str = nil
		end)

		Prat.RegisterChatCommand("copychat", function()
			local frame = SELECTED_CHAT_FRAME
			if frame then
				self:ScrapeChatFrame(frame)
			end
		end)

		Prat.RegisterChatCommand("copychatfull", function()
			local frame = SELECTED_CHAT_FRAME
			if frame then
				self:ScrapeFullChatFrame(frame)
			end
		end)

		Prat.RegisterLinkType({ linkid = "pratcopy", linkfunc = self.CopyLink, handler = module }, self.name)

		module.timestamps = Prat:GetModule("Timestamps")

		if self.timestamps then
			self:RawHook(self.timestamps, "GetTime")
		end
	end)

	function module:OnModuleEnable()
		self.buttons = {}
		for k, v in pairs(Prat.Frames) do
			self.buttons[k] = self:MakeReminder(v:GetID())
			self:showbutton(k, self.db.profile.showbutton[k])
		end

		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
	end

	function module:GetDescription()
		return PL["Copy text from the active chat window."]
	end

	function module:Prat_FramesUpdated(_, _, chatFrame)
		local id = chatFrame:GetID()
		self.buttons[id] = self:MakeReminder(id)
		self:showbutton(id, self.db.profile.showbutton[1])
	end

	function module:OnModuleDisable()
		Prat.UnregisterAllChatEvents(self)
		self:hidebuttons()
		PratCCFrame:Hide()
	end

	function module:EnterSelectMode(frame)
		frame = frame or SELECTED_CHAT_FRAME

		frame:SetTextCopyable(true)
		frame:EnableMouse(true)
		frame:SetOnTextCopiedCallback(function(this)
			this:SetTextCopyable(false)
			this:EnableMouse(false)
			this:SetOnTextCopiedCallback(nil)
		end)
	end

	local function CleanText(text)
		text = text:gsub("|K.-|k", "???")
		return StripHyperlinks(text, false, true)
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:CopyLink(_, frame)
		if frame and self.db.profile.on and self.db.profile.copytimestamps then
			for _, visibleLine in ipairs(frame.visibleLines) do
				local isMouseOver = visibleLine:IsMouseOver()
				if (not issecretvalue or not issecretvalue(isMouseOver)) and isMouseOver then
					local info = visibleLine.messageInfo
					if info and info.message then
						local text = issecretvalue and issecretvalue(info.message) and "<SECRET>" or CleanText(info.message)
						local editBox = ChatEdit_ChooseBoxForSend(frame);

						if (editBox ~= ChatEdit_GetActiveWindow()) then
							ChatFrame_OpenChat(text, frame);
						else
							editBox:SetText(text);
						end
					end
					return false
				end
			end
		end

		return false
	end

	function module:GetTime(...)
		local stamp = self.hooks[self.timestamps].GetTime(...)
		if module.db.profile.on and module.db.profile.copytimestamps then
			return "|Hpratcopy|h" .. stamp .. "|h"
		end

		return stamp
	end

	module.lines = {}
	module.str = nil

	function module:GetFormattedLine(line, r, g, b)
		local fmt = self.copyformat or self.db.profile.copyformat
		local CLR = Prat.CLR

		line = line:gsub("|c00000000|r", "")

		if fmt == "plain" then
			return line
		end

		if fmt == "bbcode" or fmt == "wowace" then
			local fline = line:gsub("|c[fF][fF](%w%w%w%w%w%w)", "[color=#%1]"):gsub("|r", "[/color]")
			return "[color=#" .. CLR:GetHexColor(r, g, b) .. "]" .. fline .. "[/color]"
		end

		if fmt == "html" then
			local fline = line:gsub("|c[fF][fF](%w%w%w%w%w%w)", "<font color='#%1'>"):gsub("|r", "</font>")
			return "<p><font color='#" .. CLR:GetHexColor(r, g, b) .. "' face='monospace'>" .. fline .. "</font></p>"
		end
	end

	function module:ScrapeChatFrame(frame, noshow)
		self:DoCopyChat(frame, noshow)
	end

	function module:ScrapeFullChatFrame(frame)
		self:DoCopyChatScroll(frame)
	end

	function module:MenuScrape()
		self:ScrapeChatFrame(SELECTED_CHAT_FRAME)
	end

	function module:DoCopyChatScroll(frame)
		local scrapelines = {}
		local str

		if frame:GetNumMessages() == 0 then
			return
		end

		for i = frame:GetNumMessages(), 1, -1 do
			local msg = frame.historyBuffer:GetEntryAtIndex(i)
			msg = msg and msg.message

			if msg then
				scrapelines[#scrapelines + 1] = issecretvalue and issecretvalue(msg) and "<SECRET>" or CleanText(msg)
			end
		end

		str = table.concat(scrapelines, "\n")

		PratCCFrameScrollText:SetText(str or "")
		PratCCText:SetText(PL["ChatFrame"] .. frame:GetName():gsub("ChatFrame", "") .. PL[" Text"])
		PratCCFrame:Show()
	end

	function module:DoCopyChatArg(arg)
		self:DoCopyChat(unpack(arg))
	end

	function module:DoCopyChat(frame, noshow)
		local lines = {}

		for i = 1, frame:GetNumMessages() do
			local msg = frame:GetMessageInfo(i)

			if msg then
				if issecretvalue and issecretvalue(msg) then
					lines[#lines + 1] = "<SECRET>"
				else
					lines[#lines + 1] = CleanText(msg)
				end
			end
		end

		local str = table.concat(lines, "\n")

		if not noshow then
			if (self.copyformat and self.copyformat == "wowace") or self.db.profile.copyformat == "wowace" then
				str = "[bgcolor=black]" .. str .. "[/bgcolor]"
			end

			PratCCFrameScrollText:SetText(str or "")
			PratCCText:SetText(PL["ChatFrame"] .. frame:GetName():gsub("ChatFrame", "") .. PL[" Text"])
			PratCCFrame:Show()
		end
	end

	function module:CopyChat()
		module:ScrapeChatFrame(SELECTED_CHAT_FRAME)
	end

	function module:OnTextChanged(this)
		if self.str and this:GetText() ~= self.str then
			this:SetText(self.str)
			self.str = nil
		end
		local s = PratCCFrameScrollScrollBar
		this:GetParent():UpdateScrollChildRect()
		local _, m = s:GetMinMaxValues()
		if m > 0 and this.max ~= m then
			this.max = m
			s:SetValue(m)
		end
	end

	function module:hidebuttons()
		for _, v in pairs(self.buttons) do
			v:Hide()
		end
	end

	function module:showbutton(id, show)
		local b = self.buttons[id]
		if show then
			b:Show()
		else
			b:Hide()
		end
	end

	do
		local function reminderOnClick(self, button)
			PlaySound(SOUNDKIT.IG_CHAT_BOTTOM);
			if button == "RightButton" then
				module:EnterSelectMode(self:GetParent())
			else
				if (IsShiftKeyDown()) then
					module:EnterSelectMode(self:GetParent())
				elseif (IsControlKeyDown()) then
					module:ScrapeFullChatFrame(self:GetParent())
				else
					module:ScrapeChatFrame(self:GetParent())
				end
			end

			module.copyformat = nil
		end

		local function reminderOnEnter(self)
			self:SetAlpha(module.db.profile.activealpha)
		end

		local function reminderOnLeave(self)
			self:SetAlpha(module.db.profile.inactivealpha)
		end

		function module:MakeReminder(id)
			local cf = _G["ChatFrame" .. id]
			local name = "ChatFrame" .. id .. "PratCCReminder"
			local b = _G[name]
			if not b then
				b = CreateFrame("Button", name, cf)
				b:SetFrameStrata("MEDIUM")
				b:SetWidth(24)
				b:SetHeight(24)
				b:SetNormalTexture("Interface\\Addons\\Prat-3.0\\textures\\prat-chatcopy2")
				b:SetPushedTexture("Interface\\Addons\\Prat-3.0\\textures\\prat-chatcopy")
				b:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")
				b:SetPoint(self.db.profile.buttonpos, cf, self.db.profile.buttonpos, 0, 0)
				b:SetScript("OnClick", reminderOnClick)
				b:SetScript("OnEnter", reminderOnEnter)
				b:SetScript("OnLeave", reminderOnLeave)
				b:SetAlpha(module.db.profile.inactivealpha)
				b:RegisterForClicks("AnyUp")
				b:Hide()
			end

			return b
		end
	end

	function module:OnValueChanged()
		for k, v in pairs(Prat.Frames) do
			local cf = _G["ChatFrame" .. v:GetID()]
			local btn = self.buttons[k]
			btn:ClearAllPoints()
			btn:SetPoint(self.db.profile.buttonpos, cf, self.db.profile.buttonpos, 0, 0)
			btn:SetAlpha(module.db.profile.inactivealpha)
		end
	end

	return
end)
