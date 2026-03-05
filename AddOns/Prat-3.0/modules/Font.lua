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

local GetCVar = _G.GetCVar or _G.C_CVar.GetCVar

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("Font", "AceHook-3.0", "AceEvent-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Font"] = true,
		["Chat window font options."] = true,
		["Set Separately"] = true,
		["Toggle setting options separately for each chat window."] = true,
		["Set Font Face"] = true,
		["Set the text font face for all chat windows."] = true,
		["rememberfont_name"] = "Remember Font",
		["rememberfont_desc"] = "Remember your font choice and restore it at startup.",
		["Set Font Size"] = true,
		["Set text font size for each chat window."] = true,
		["Set ChatFrame%d Font Size"] = true,
		["Set text font size."] = true,
		["Auto Restore Font Size"] = true,
		["Workaround a Blizzard bug which changes the font size when you open a system menu."] = true,
		["outlinemode_name"] = "Set Outline Mode",
		["outlinemode_desc"] = "Sets mode for the outline around the font.",
		["None"] = true,
		["Outline"] = true,
		["Thick Outline"] = true,
		["monochrome_name"] = "Toggle Monochrome",
		["monochrome_desc"] = "Toggles monochrome coloring of the font.",
		["shadowcolor_name"] = "Set Shadow Color",
		["shadowcolor_desc"] = "Set the color of the shadow effect.",
		["whisper_tabs"] = "Whisper Tabs",
		["pet_battle_tab"] = "Pet Battle Tab",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L

		L = {}
-- Font
L["Auto Restore Font Size"] = true
L["Chat window font options."] = true
L["Font"] = true
L["monochrome_desc"] = "Toggles monochrome coloring of the font."
L["monochrome_name"] = "Toggle Monochrome"
L["None"] = true
L["Outline"] = true
L["outlinemode_desc"] = "Sets mode for the outline around the font."
L["outlinemode_name"] = "Set Outline Mode"
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "Remember your font choice and restore it at startup."
L["rememberfont_name"] = "Remember Font"
L["Set ChatFrame%d Font Size"] = true
L["Set Font Face"] = true
L["Set Font Size"] = true
L["Set Separately"] = true
L["Set text font size for each chat window."] = true
L["Set text font size."] = true
L["Set the text font face for all chat windows."] = true
L["shadowcolor_desc"] = "Set the color of the shadow effect."
L["shadowcolor_name"] = "Set Shadow Color"
L["Thick Outline"] = true
L["Toggle setting options separately for each chat window."] = true
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = true

		PL:AddLocale("enUS", L)

		L = {}
-- Font
--[[Translation missing --]]
L["Auto Restore Font Size"] = "Auto Restore Font Size"
--[[Translation missing --]]
L["Chat window font options."] = "Chat window font options."
--[[Translation missing --]]
L["Font"] = "Font"
--[[Translation missing --]]
L["monochrome_desc"] = "Toggles monochrome coloring of the font."
--[[Translation missing --]]
L["monochrome_name"] = "Toggle Monochrome"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Outline"] = "Outline"
--[[Translation missing --]]
L["outlinemode_desc"] = "Sets mode for the outline around the font."
--[[Translation missing --]]
L["outlinemode_name"] = "Set Outline Mode"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
--[[Translation missing --]]
L["rememberfont_desc"] = "Remember your font choice and restore it at startup."
--[[Translation missing --]]
L["rememberfont_name"] = "Remember Font"
--[[Translation missing --]]
L["Set ChatFrame%d Font Size"] = "Set ChatFrame%d Font Size"
--[[Translation missing --]]
L["Set Font Face"] = "Set Font Face"
--[[Translation missing --]]
L["Set Font Size"] = "Set Font Size"
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Set text font size for each chat window."] = "Set text font size for each chat window."
--[[Translation missing --]]
L["Set text font size."] = "Set text font size."
--[[Translation missing --]]
L["Set the text font face for all chat windows."] = "Set the text font face for all chat windows."
--[[Translation missing --]]
L["shadowcolor_desc"] = "Set the color of the shadow effect."
--[[Translation missing --]]
L["shadowcolor_name"] = "Set Shadow Color"
--[[Translation missing --]]
L["Thick Outline"] = "Thick Outline"
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
--[[Translation missing --]]
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Workaround a Blizzard bug which changes the font size when you open a system menu."

		PL:AddLocale("itIT", L)

		L = {}
-- Font
--[[Translation missing --]]
L["Auto Restore Font Size"] = "Auto Restore Font Size"
--[[Translation missing --]]
L["Chat window font options."] = "Chat window font options."
--[[Translation missing --]]
L["Font"] = "Font"
--[[Translation missing --]]
L["monochrome_desc"] = "Toggles monochrome coloring of the font."
--[[Translation missing --]]
L["monochrome_name"] = "Toggle Monochrome"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Outline"] = "Outline"
--[[Translation missing --]]
L["outlinemode_desc"] = "Sets mode for the outline around the font."
--[[Translation missing --]]
L["outlinemode_name"] = "Set Outline Mode"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
--[[Translation missing --]]
L["rememberfont_desc"] = "Remember your font choice and restore it at startup."
--[[Translation missing --]]
L["rememberfont_name"] = "Remember Font"
--[[Translation missing --]]
L["Set ChatFrame%d Font Size"] = "Set ChatFrame%d Font Size"
--[[Translation missing --]]
L["Set Font Face"] = "Set Font Face"
--[[Translation missing --]]
L["Set Font Size"] = "Set Font Size"
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Set text font size for each chat window."] = "Set text font size for each chat window."
--[[Translation missing --]]
L["Set text font size."] = "Set text font size."
--[[Translation missing --]]
L["Set the text font face for all chat windows."] = "Set the text font face for all chat windows."
--[[Translation missing --]]
L["shadowcolor_desc"] = "Set the color of the shadow effect."
--[[Translation missing --]]
L["shadowcolor_name"] = "Set Shadow Color"
--[[Translation missing --]]
L["Thick Outline"] = "Thick Outline"
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
--[[Translation missing --]]
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Workaround a Blizzard bug which changes the font size when you open a system menu."

		PL:AddLocale("ptBR", L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "Restauration automatique de la taille du texte"
L["Chat window font options."] = "Options de formatage du texte."
L["Font"] = "Police"
L["monochrome_desc"] = "Activer/Désactiver la monochromie de la police."
L["monochrome_name"] = "Monochromie"
L["None"] = "Aucun"
L["Outline"] = "Contour"
L["outlinemode_desc"] = "Définit le contour autour de la police."
L["outlinemode_name"] = "Contour de la police"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "Se souvenir de la police du texte et la restaurer au chargement."
L["rememberfont_name"] = "Mémoriser la police"
L["Set ChatFrame%d Font Size"] = "Définit la taille de la police de la fenêtre de discussion %d"
L["Set Font Face"] = "Police d'écriture"
L["Set Font Size"] = "Taille de la police"
L["Set Separately"] = "Configurer séparément"
L["Set text font size for each chat window."] = "Définir la taille du texte de chaque fenêtre."
L["Set text font size."] = "Définit la taille du texte."
L["Set the text font face for all chat windows."] = "Définit la police du texte pour toutes les fenêtres de discussions."
L["shadowcolor_desc"] = "Définit la couleur de l'ombre."
L["shadowcolor_name"] = "Couleur de l'ombre"
L["Thick Outline"] = "Contour épais"
L["Toggle setting options separately for each chat window."] = "Activer/Désactiver les options séparées pour chaque fenêtre."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Contourner un bug de Blizzard qui change la taille de la police quand on ouvre un menu système."

		PL:AddLocale("frFR",L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "Schriftgröße automatisch wiederherstellen"
L["Chat window font options."] = "Optionen für die Schriftart des Chatfensters."
L["Font"] = "Schrifttyp"
L["monochrome_desc"] = "Einfarbige Einfärbung der Schrift umschalten."
L["monochrome_name"] = "Einfarbigkeit ein- und ausschalten"
L["None"] = "Keiner"
L["Outline"] = "Umrandung"
L["outlinemode_desc"] = "Stellt Modus für die Umrandung des Schrifttyps ein."
L["outlinemode_name"] = "Umrandungsmodus einstellen"
L["pet_battle_tab"] = "Registerkarte „Haustierkampf“"
L["rememberfont_desc"] = "Deine Wahl des Schrifttyps merken und beim Starten wiederherstellen."
L["rememberfont_name"] = "Schrifttyp merken"
L["Set ChatFrame%d Font Size"] = "Schriftgröße im Chatfenster %d einstellen"
L["Set Font Face"] = "Schrifttyp einstellen"
L["Set Font Size"] = "Schriftgröße einstellen"
L["Set Separately"] = "Einzeln einstellen"
L["Set text font size for each chat window."] = "Schriftgröße von Text für jedes Chatfenster einstellen."
L["Set text font size."] = "Schriftgröße von Text einstellen."
L["Set the text font face for all chat windows."] = "Schriftart von Text für alle Chatfenster einstellen."
L["shadowcolor_desc"] = "Farbe des Schatteneffekts einstellen."
L["shadowcolor_name"] = "Schattenfarbe einstellen"
L["Thick Outline"] = "Dicke Umrandung"
L["Toggle setting options separately for each chat window."] = "Optionen einzeln für jedes Chatfenster einstellen umschalten."
L["whisper_tabs"] = "Flüster-Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Einen Bug von Blizzard umgehen, welcher die Schriftgröße ändert sobald du ein Systemmenü öffnest."

		PL:AddLocale("deDE", L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "글꼴 크기 자동 복원"
L["Chat window font options."] = "대화창 글꼴 옵션입니다."
L["Font"] = "글꼴"
L["monochrome_desc"] = "글꼴 그림자 색을 끄고 켭니다."
L["monochrome_name"] = "그림자 끄고 켜기"
L["None"] = "없음"
L["Outline"] = "외곽선"
L["outlinemode_desc"] = "글꼴의 외곽선을 설정합니다."
L["outlinemode_name"] = "외곽선 설정"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "선택한 글꼴을 기억하고 시작할 때 적용합니다."
L["rememberfont_name"] = "글꼴 기억"
L["Set ChatFrame%d Font Size"] = "대화창%d의 글꼴 크기를 설정합니다."
L["Set Font Face"] = "글꼴 설정"
L["Set Font Size"] = "글꼴 크기 설정"
L["Set Separately"] = "개별 설정"
L["Set text font size for each chat window."] = "각 대화창 별로 글꼴 크기를 설정합니다."
L["Set text font size."] = "글꼴 크기를 설정합니다."
L["Set the text font face for all chat windows."] = "모든 대화창의 글꼴을 설정합니다."
L["shadowcolor_desc"] = "그림자 색상을 설정합니다."
L["shadowcolor_name"] = "그림자 색상 설정"
L["Thick Outline"] = "굵은 외곽선"
L["Toggle setting options separately for each chat window."] = "각 대화창 별로 옵션 설정을 끄고 켭니다."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "시스템 메뉴를 열 때 글꼴 크기를 변경하는 블리자드 버그를 회피합니다."

		PL:AddLocale("koKR",L)

		L = {}
-- Font
--[[Translation missing --]]
L["Auto Restore Font Size"] = "Auto Restore Font Size"
--[[Translation missing --]]
L["Chat window font options."] = "Chat window font options."
--[[Translation missing --]]
L["Font"] = "Font"
--[[Translation missing --]]
L["monochrome_desc"] = "Toggles monochrome coloring of the font."
--[[Translation missing --]]
L["monochrome_name"] = "Toggle Monochrome"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Outline"] = "Outline"
--[[Translation missing --]]
L["outlinemode_desc"] = "Sets mode for the outline around the font."
--[[Translation missing --]]
L["outlinemode_name"] = "Set Outline Mode"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
--[[Translation missing --]]
L["rememberfont_desc"] = "Remember your font choice and restore it at startup."
--[[Translation missing --]]
L["rememberfont_name"] = "Remember Font"
--[[Translation missing --]]
L["Set ChatFrame%d Font Size"] = "Set ChatFrame%d Font Size"
--[[Translation missing --]]
L["Set Font Face"] = "Set Font Face"
--[[Translation missing --]]
L["Set Font Size"] = "Set Font Size"
--[[Translation missing --]]
L["Set Separately"] = "Set Separately"
--[[Translation missing --]]
L["Set text font size for each chat window."] = "Set text font size for each chat window."
--[[Translation missing --]]
L["Set text font size."] = "Set text font size."
--[[Translation missing --]]
L["Set the text font face for all chat windows."] = "Set the text font face for all chat windows."
--[[Translation missing --]]
L["shadowcolor_desc"] = "Set the color of the shadow effect."
--[[Translation missing --]]
L["shadowcolor_name"] = "Set Shadow Color"
--[[Translation missing --]]
L["Thick Outline"] = "Thick Outline"
--[[Translation missing --]]
L["Toggle setting options separately for each chat window."] = "Toggle setting options separately for each chat window."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
--[[Translation missing --]]
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Workaround a Blizzard bug which changes the font size when you open a system menu."

		PL:AddLocale("esMX",L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "Авто-восстановление размера"
L["Chat window font options."] = "Настройки шрифта окна чата."
L["Font"] = "Шрифт"
L["monochrome_desc"] = "Вкл/Выкл чёрно-белое окрашивание шрифта."
L["monochrome_name"] = "Чёрно-белое"
L["None"] = "Нет"
L["Outline"] = "Обычная обводка"
L["outlinemode_desc"] = "Выбор типа обводки вокруг символов."
L["outlinemode_name"] = "Обводка"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "Запомнить выбранный шрифт и использовать его при следующей загрузке."
L["rememberfont_name"] = "Запомнить шрифт"
L["Set ChatFrame%d Font Size"] = "Размер шрифта окна %d"
L["Set Font Face"] = "Основной шрифт"
L["Set Font Size"] = "Размер шрифта"
L["Set Separately"] = "Разделение"
L["Set text font size for each chat window."] = "Установка размера шрифта во всех окнах чата."
L["Set text font size."] = "Размер шрифта."
L["Set the text font face for all chat windows."] = "Установка главного шрифта для всех окон чата."
L["shadowcolor_desc"] = "Установка цвета эффекта тени."
L["shadowcolor_name"] = "Цвет тени"
L["Thick Outline"] = "Жирная обводка"
L["Toggle setting options separately for each chat window."] = "Вкл/Выкл настройки разделения для всех окон чата."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Метод обхода ошибки Blizzard, изменяющей размер шрифта при открытии системного меню."

		PL:AddLocale("ruRU",L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "自动还原字体尺寸"
L["Chat window font options."] = "聊天窗口字体选项"
L["Font"] = "字体"
L["monochrome_desc"] = "单色字体"
L["monochrome_name"] = "单色"
L["None"] = "无"
L["Outline"] = "轮廓"
L["outlinemode_desc"] = "字体轮廓样式设置"
L["outlinemode_name"] = "轮廓样式"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "记住您的字体选择并在启动时恢复"
L["rememberfont_name"] = "记住字体"
L["Set ChatFrame%d Font Size"] = "聊天框%d字体尺寸"
L["Set Font Face"] = "字体设置"
L["Set Font Size"] = "设置字体大小"
L["Set Separately"] = "个别设置"
L["Set text font size for each chat window."] = "每个聊天窗口的文本字体尺寸"
L["Set text font size."] = "文本字体尺寸"
L["Set the text font face for all chat windows."] = "所有聊天窗口的文本字体"
L["shadowcolor_desc"] = "阴影效果的颜色"
L["shadowcolor_name"] = "阴影色彩"
L["Thick Outline"] = "厚轮廓"
L["Toggle setting options separately for each chat window."] = "每个聊天窗口的个别选项设置"
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "当你打开系统菜单时改变暴雪错误提示字体尺寸"

		PL:AddLocale("zhCN",L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "Restaurar Tamaño Fuentes Automáticamente"
L["Chat window font options."] = "Opciones de la fuente de la ventana del chat."
L["Font"] = "Fuente"
L["monochrome_desc"] = "Alterna el color monocromo de la fuente."
L["monochrome_name"] = "Alternar Monocromo"
L["None"] = "Ninguna"
L["Outline"] = "Contorno"
L["outlinemode_desc"] = "Estable el modo para el contorno alrededor de la fuente."
L["outlinemode_name"] = "Establecer Modo de Cotorno"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "Recordar la elección de la fuente y restaurarla al reiniciar."
L["rememberfont_name"] = "Recordar Fuente"
L["Set ChatFrame%d Font Size"] = "Establecer Tamaño Fuente de Chat %d"
L["Set Font Face"] = "Establecer Tipo de Fuente"
L["Set Font Size"] = "Establecer Tamaño de Fuente"
L["Set Separately"] = "Establecer por separado"
L["Set text font size for each chat window."] = "Establece el tamaño de la fuente del texto de cada ventana de chat."
L["Set text font size."] = "Establece el tamaño de la fuente del texto."
L["Set the text font face for all chat windows."] = "Establece el tipo de fuente de texto para todas las ventanas de chat."
L["shadowcolor_desc"] = "Establece el color del efecto de sombra."
L["shadowcolor_name"] = "Establecer Color de la Sombra"
L["Thick Outline"] = "Contorno Grueso"
L["Toggle setting options separately for each chat window."] = "Cambiar opciones de configuración por separado para cada ventana de chat."
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "Solución a un error de Blizzard que cambia el tamaño de la fuente cuando se abre un menú de sistema."

		PL:AddLocale("esES",L)

		L = {}
-- Font
L["Auto Restore Font Size"] = "自動還原字型大小"
L["Chat window font options."] = "聊天視窗字型選項。"
L["Font"] = "字型"
L["monochrome_desc"] = "切換字型的灰階色彩。"
L["monochrome_name"] = "切換灰階"
L["None"] = "無"
L["Outline"] = "輪廓"
L["outlinemode_desc"] = "設定字體是否加粗輪廓"
L["outlinemode_name"] = "設定輪廓模式"
--[[Translation missing --]]
L["pet_battle_tab"] = "Pet Battle Tab"
L["rememberfont_desc"] = "記住字型設定"
L["rememberfont_name"] = "記憶字型"
L["Set ChatFrame%d Font Size"] = "設定聊天視窗 %d 之字型大小"
L["Set Font Face"] = "設定字體"
L["Set Font Size"] = "設定字型大小"
L["Set Separately"] = "個別設定"
L["Set text font size for each chat window."] = "設定個別聊天視窗字型大小"
L["Set text font size."] = "設定文字字型大小"
L["Set the text font face for all chat windows."] = "設定所有聊天視窗字體"
L["shadowcolor_desc"] = "設定陰影效果色彩"
L["shadowcolor_name"] = "設定陰影色彩"
L["Thick Outline"] = "粗邊"
L["Toggle setting options separately for each chat window."] = "切換設定選項分開地每個聊天視窗。"
--[[Translation missing --]]
L["whisper_tabs"] = "Whisper Tabs"
L["Workaround a Blizzard bug which changes the font size when you open a system menu."] = "開啟系統選單時變更Blizzard錯誤訊息的字型大小。"

		PL:AddLocale("zhTW",L)
	end
	--@end-non-debug@

	Prat:SetModuleDefaults(module, {
		profile = {
			on = true,
			fontface = "",
			rememberfont = false,
			size = { ["*"] = 12 },
			autorestore = false,
			outlinemode = "",
			monochrome = false,
			shadowcolor = {
				r = 0,
				g = 0,
				b = 0,
				a = 1,
			},
		}
	})

	local frameOption = {
		name = function(info)
			return Prat.FrameList[info[#info]] or ""
		end,
		desc = PL["Set text font size."],
		type = "range",
		get = "GetSubValue",
		set = "SetSubValue",
		min = 4,
		max = 100,
		step = 1,
		hidden = function(info)
			return Prat.FrameList[info[#info]] == nil
		end,
	}
	local whisperTabsOption = {
		name = PL["whisper_tabs"],
		desc = PL["Set text font size."],
		type = "range",
		get = "GetSubValue",
		set = "SetSubValue",
		min = 4,
		max = 100,
		step = 1,
		hidden = function()
			return GetCVar("whisperTabs") == "inline"
		end,
	}
	local petBattleTabOption = {
		name = PL["pet_battle_tab"],
		desc = PL["Set text font size."],
		type = "range",
		get = "GetSubValue",
		set = "SetSubValue",
		min = 4,
		max = 100,
		step = 1,
		hidden = not Prat.IsRetail and not Prat.IsMop,
		order = 900,
	}

	Prat:SetModuleOptions(module, {
		name = PL["Font"],
		desc = PL["Chat window font options."],
		type = "group",
		args = {
			fontface = {
				name = PL["Set Font Face"],
				desc = PL["Set the text font face for all chat windows."],
				type = "select",
				dialogControl = 'LSM30_Font',
				values = AceGUIWidgetLSMlists.font,
				order = 110,
			},
			size = {
				name = PL["Set Font Size"],
				desc = PL["Set text font size for each chat window."],
				type = "group",
				inline = true,
				order = 130,
				args = {
					ChatFrame1 = frameOption,
					ChatFrame2 = frameOption,
					ChatFrame3 = frameOption,
					ChatFrame4 = frameOption,
					ChatFrame5 = frameOption,
					ChatFrame6 = frameOption,
					ChatFrame7 = frameOption,
					ChatFrame8 = frameOption,
					ChatFrame9 = frameOption,
					ChatFrame10 = frameOption,
					WhisperTabs = whisperTabsOption,
					PetBattleTab = petBattleTabOption,
				}
			},
			outlinemode = {
				name = PL["outlinemode_name"],
				desc = PL["outlinemode_desc"],
				type = "select",
				order = 150,
				values = { [""] = PL["None"], ["OUTLINE"] = PL["Outline"], ["THICKOUTLINE"] = PL["Thick Outline"] },
			},
			monochrome = {
				type = "toggle",
				name = PL["monochrome_name"],
				desc = PL["monochrome_desc"],
				order = 160,
			},
			shadowcolor = {
				name = PL["shadowcolor_name"],
				desc = PL["shadowcolor_desc"],
				type = "color",
				order = 170,
				get = "GetColorValue",
				set = "SetColorValue",
			},
			rememberfont = {
				type = "toggle",
				order = 120,
				name = PL["rememberfont_name"],
				desc = PL["rememberfont_desc"],
			},
		}
	})

	function module:OnModuleEnable()
		self:RegisterEvent("PLAYER_ENTERING_WORLD")

		self.oldsize = {}
		for k, cf in pairs(Prat.Frames) do
			local _, s, _ = cf:GetFont()
			self.oldsize[k] = s
		end

		if not self.db.profile.rememberfont then
			self.db.profile.fontface = nil
		end

		self:ConfigureAllChatFrames()

		self:SecureHook("FCF_SetChatWindowFontSize")

		Prat.Media.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
		Prat.Media.RegisterCallback(self, "LibSharedMedia_SetGlobal", "SharedMedia_Registered")

		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
	end

	function module:GetDescription()
		return PL["Chat window font options."]
	end

	function module:SharedMedia_Registered(mediatype, name)
		if mediatype == "font" then
			if name == self.db.profile.fontface then
				self:ConfigureAllChatFrames()
			end
		end
	end

	function module:Prat_FramesUpdated()
		self:ConfigureAllChatFrames()
	end

	function module:PLAYER_ENTERING_WORLD()
		self:ConfigureAllChatFrames()
		self:UnregisterAllEvents()
	end

	function module:OnModuleDisable()
		self:UnhookAll()
		Prat.Media.UnregisterAllCallbacks(self)

		for k, cf in pairs(Prat.Frames) do
			self:SetFontSize(cf, self.oldsize[k] or 12)
		end
		self:SetFontMode("")
	end

	function module:GetSubValue(info)
		return self.db.profile[info[#info - 1]][info[#info]]
	end

	function module:SetSubValue(info, b)
		self.db.profile[info[#info - 1]][info[#info]] = b
		self:OnValueChanged(info, b)
	end

	local function IsWhisperFrame(frame)
		return frame.chatType == "WHISPER" or frame.chatType == "BN_WHISPER"
	end

	local function IsPetBattleFrame(frame)
		return frame.chatType == "PET_BATTLE_COMBAT_LOG"
	end

	--[[------------------------------------------------
	  Core Functions
	------------------------------------------------]] --
	function module:ConfigureAllChatFrames()
		local db = self.db.profile

		if db.fontface then
			self:SetFont(db.fontface)
		end

		for k, v in pairs(Prat.Frames) do
			if IsWhisperFrame(v) then
				self:SetFontSize(v, db.size.WhisperTabs)
			elseif IsPetBattleFrame(v) then
				self:SetFontSize(v, db.size.PetBattleTab)
			else
				self:SetFontSize(v, db.size[k])
			end
		end

		if not db.monochrome then
			self:SetFontMode(db.outlinemode)
		else
			self:SetFontMode(db.outlinemode .. ", MONOCHROME")
		end
	end

	function module:SetFontSize(cf, size)
		if not size then
			return
		end

		FCF_SetChatWindowFontSize(module, cf, size)
	end

	function module:SetFont(font)
		local fontfile = Prat.Media:Fetch(Prat.Media.MediaType.FONT, font)
		for _, cf in pairs(Prat.Frames) do
			local _, s, m = cf:GetFont()
			cf:SetFont(fontfile, s, m)
		end
	end

	function module:SetFontMode(mode, monochrome)
		for _, cf in pairs(Prat.Frames) do
			local f, s, _ = cf:GetFont()
			cf:SetFont(f, s, mode)

			if monochrome then
				local c = self.db.profile.shadowcolor
				cf:SetShadowColor(c.r, c.g, c.b, c.a)
			end
		end
	end

	function module:GetShadowClr()
		local h = self.db.profile.shadowcolor or {}
		return h.r or 1.0, h.g or 1.0, h.b or 1.0
	end

	function module:SetShadowClr(r, g, b)
		local db = self.db.profile
		db.shadowcolor = db.shadowcolor or {}
		local h = db.shadowcolor
		h.r, h.g, h.b = r, g, b
		self:ConfigureAllChatFrames()
	end

	function module:FCF_SetChatWindowFontSize(fcfself, chatFrame, fontSize)
		if not fontSize then
			-- fontSize should never be nil
			return
		end
		if fcfself == module then
			return
		end

		if not chatFrame then
			chatFrame = FCF_GetCurrentChatFrame();
		end
		if self.db and self.db.profile.on then
			if IsWhisperFrame(chatFrame) then
				self.db.profile.size.WhisperTabs = fontSize
			elseif IsPetBattleFrame(chatFrame) then
				self.db.profile.size.PetBattleTab = fontSize
			else
				self.db.profile.size[chatFrame:GetName()] = fontSize
			end
		end
	end

	module.OnValueChanged = module.ConfigureAllChatFrames
	module.OnSubValueChanged = module.ConfigureAllChatFrames
	module.OnColorValueChanged = module.ConfigureAllChatFrames
	return
end)
