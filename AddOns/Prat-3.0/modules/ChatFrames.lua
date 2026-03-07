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
	local module = Prat:NewModule("Frames", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Frames"] = true,
		["Chat window frame parameter options"] = true,
		["removeclamp_name"] = "Zero Clamp Size",
		["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen",
		["minchatwidth_name"] = "Set Minimum Width",
		["minchatwidth_desc"] = "Sets the minimum width for all chat windows.",
		["maxchatwidth_name"] = "Set Maximum Width",
		["maxchatwidth_desc"] = "Sets the maximum width for all chat windows.",
		["minchatheight_name"] = "Set Minimum Height",
		["minchatheight_desc"] = "Sets the minimum height for all chat windows.",
		["maxchatheight_name"] = "Set Maximum Height",
		["maxchatheight_desc"] = "Sets the maximum height for all chat windows.",
		["mainchatonload_name"] = "Force Main Chat Frame On Load",
		["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load.",
		["framealphastatic_name"] = "Static Chatframe Alpha",
		["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency",
		["defaultframealpha_name"] = "Default alpha on mouseover",
		["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window.",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/

	--@non-debug@
  do
	  local L


  L = {}
  -- Frames
L["Chat window frame parameter options"] = true
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
L["defaultframealpha_name"] = "Default alpha on mouseover"
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
L["framealpha_name"] = "Set Chatframe Alpha"
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = true
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
L["maxchatheight_desc"] = "Sets the maximum height for all chat windows."
L["maxchatheight_name"] = "Set Maximum Height"
L["maxchatwidth_desc"] = "Sets the maximum width for all chat windows."
L["maxchatwidth_name"] = "Set Maximum Width"
L["minchatheight_desc"] = "Sets the minimum height for all chat windows."
L["minchatheight_name"] = "Set Minimum Height"
L["minchatwidth_desc"] = "Sets the minimum width for all chat windows."
L["minchatwidth_name"] = "Set Minimum Width"
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
L["rememberframepositions_name"] = "Remember Positions"
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("enUS", L)

  L = {}
  -- Frames
--[[Translation missing --]]
L["Chat window frame parameter options"] = "Chat window frame parameter options"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
--[[Translation missing --]]
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
--[[Translation missing --]]
L["framealpha_name"] = "Set Chatframe Alpha"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
--[[Translation missing --]]
L["Frames"] = "Frames"
--[[Translation missing --]]
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
--[[Translation missing --]]
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
--[[Translation missing --]]
L["maxchatheight_desc"] = "Sets the maximum height for all chat windows."
--[[Translation missing --]]
L["maxchatheight_name"] = "Set Maximum Height"
--[[Translation missing --]]
L["maxchatwidth_desc"] = "Sets the maximum width for all chat windows."
--[[Translation missing --]]
L["maxchatwidth_name"] = "Set Maximum Width"
--[[Translation missing --]]
L["minchatheight_desc"] = "Sets the minimum height for all chat windows."
--[[Translation missing --]]
L["minchatheight_name"] = "Set Minimum Height"
--[[Translation missing --]]
L["minchatwidth_desc"] = "Sets the minimum width for all chat windows."
--[[Translation missing --]]
L["minchatwidth_name"] = "Set Minimum Width"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("itIT", L)

  L = {}
  -- Frames
--[[Translation missing --]]
L["Chat window frame parameter options"] = "Chat window frame parameter options"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
--[[Translation missing --]]
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
--[[Translation missing --]]
L["framealpha_name"] = "Set Chatframe Alpha"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
--[[Translation missing --]]
L["Frames"] = "Frames"
--[[Translation missing --]]
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
--[[Translation missing --]]
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
--[[Translation missing --]]
L["maxchatheight_desc"] = "Sets the maximum height for all chat windows."
--[[Translation missing --]]
L["maxchatheight_name"] = "Set Maximum Height"
--[[Translation missing --]]
L["maxchatwidth_desc"] = "Sets the maximum width for all chat windows."
--[[Translation missing --]]
L["maxchatwidth_name"] = "Set Maximum Width"
--[[Translation missing --]]
L["minchatheight_desc"] = "Sets the minimum height for all chat windows."
--[[Translation missing --]]
L["minchatheight_name"] = "Set Minimum Height"
--[[Translation missing --]]
L["minchatwidth_desc"] = "Sets the minimum width for all chat windows."
--[[Translation missing --]]
L["minchatwidth_name"] = "Set Minimum Width"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("ptBR", L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "Options de la fenêtre de discussion"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
L["framealpha_desc"] = "Définit la transparence de la fenêtre de discussion quand la souris passe par dessus."
L["framealpha_name"] = "Transparence"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = "Fenêtre"
L["mainchatonload_desc"] = "Sélectionne automatiquement la première fenêtre de discussion et la rend active lors du chargement."
--[[Translation missing --]]
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
L["maxchatheight_desc"] = "Définit la hauteur maximale pour toutes les fenêtres de discussion."
L["maxchatheight_name"] = "Hauteur maximale"
L["maxchatwidth_desc"] = "Définit la largeur maximale pour toutes les fenêtres de discussion."
L["maxchatwidth_name"] = "Largeur maximale"
L["minchatheight_desc"] = "Définit la hauteur minimum pour toutes les fenêtres de discussion."
L["minchatheight_name"] = "Hauteur minimum"
L["minchatwidth_desc"] = "Définit la largeur minimum pour toutes les fenêtres de discussion."
L["minchatwidth_name"] = "Largeur minimum"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("frFR", L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "Optionen für Parameter des Chatfenster-Rahmens"
L["defaultframealpha_desc"] = "Legt die minimale Transparenz für den Chat fest, wenn du mit der Maus darüber fährst und die statische Chatfrahmen-Transparenzeinstellung deaktiviert ist UND die Standard Transparenz größer ist als die benutzerdefinierte Transparenz, die für das Chatfenster festgelegt ist."
L["defaultframealpha_name"] = "Standard Transparenz beim darüber fahren mit der Maus"
L["framealpha_desc"] = "Steuert die Transparenz des Chatfensters, wenn du die Maus darüberlegst."
L["framealpha_name"] = "Transparenz für Chatfenster einstellen"
L["framealphastatic_desc"] = "Stelle die Transparenz des Chatrahmens so ein, dass sie immer der konfigurierten Transparenz entspricht"
L["framealphastatic_name"] = "Statische Chatrahmen Transparenz"
L["Frames"] = "Fenster"
L["mainchatonload_desc"] = "Automatisch das erste Chatfenster auswählen und beim Laden aktivieren."
L["mainchatonload_name"] = "Haupt-Chatfenster beim Laden erzwingen"
L["maxchatheight_desc"] = "Die maximale Höhe für alle Chatfenster einstellen."
L["maxchatheight_name"] = "Maximale Höhe einstellen"
L["maxchatwidth_desc"] = "Die maximale Breite für alle Chatfenster einstellen."
L["maxchatwidth_name"] = "Maximale Breite einstellen"
L["minchatheight_desc"] = "Die minimale Höhe für alle Chatfenster einstellen."
L["minchatheight_name"] = "Minimale Höhe einstellen"
L["minchatwidth_desc"] = "Die minimale Breite für alle Chatfenster einstellen."
L["minchatwidth_name"] = "Minimale Breite einstellen"
L["rememberframepositions_desc"] = "Merkt sich die Chatrahmen Positionen und stellt sie beim Laden wieder her"
L["rememberframepositions_name"] = "Positionen merken"
L["removeclamp_desc"] = "Das Verschieben des Chatfensters bündig zur Bildschirmkante zulassen"
L["removeclamp_name"] = "Klammergröße Null"

  PL:AddLocale("deDE", L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "대화창 프레임 한도 옵션"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
L["framealpha_desc"] = "마우스를 올렸을 때 대화창의 투명도를 조절합니다."
L["framealpha_name"] = "대화창 투명도 설정"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = "대화창 [Frames]"
L["mainchatonload_desc"] = "첫번째 대화창을 자동으로 선택하고 로드 시에 활성화 시킵니다."
L["mainchatonload_name"] = "로드 시 주 대화창 강제 설정"
L["maxchatheight_desc"] = "모든 대화창의 최대 높이를 설정합니다."
L["maxchatheight_name"] = "최대 높이 설정"
L["maxchatwidth_desc"] = "모든 대화창의 최대 너비를 설정합니다."
L["maxchatwidth_name"] = "최대 너비 설정"
L["minchatheight_desc"] = "모든 대화창의 최소 높이를 설정합니다."
L["minchatheight_name"] = "최소 높이 설정"
L["minchatwidth_desc"] = "모든 대화창의 최소 너비를 설정합니다."
L["minchatwidth_name"] = "최소 너비 설정"
L["rememberframepositions_desc"] = "대화창 위치를 기억하고 로드 시마다 불러옵니다"
L["rememberframepositions_name"] = "위치 기억"
L["removeclamp_desc"] = "대화창이 화면 밖으로 나가지 않도록 방지합니다."
L["removeclamp_name"] = "Zero 고정 크기"

  PL:AddLocale("koKR", L)

  L = {}
  -- Frames
--[[Translation missing --]]
L["Chat window frame parameter options"] = "Chat window frame parameter options"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
--[[Translation missing --]]
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
--[[Translation missing --]]
L["framealpha_name"] = "Set Chatframe Alpha"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
--[[Translation missing --]]
L["Frames"] = "Frames"
--[[Translation missing --]]
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
--[[Translation missing --]]
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
--[[Translation missing --]]
L["maxchatheight_desc"] = "Sets the maximum height for all chat windows."
--[[Translation missing --]]
L["maxchatheight_name"] = "Set Maximum Height"
--[[Translation missing --]]
L["maxchatwidth_desc"] = "Sets the maximum width for all chat windows."
--[[Translation missing --]]
L["maxchatwidth_name"] = "Set Maximum Width"
--[[Translation missing --]]
L["minchatheight_desc"] = "Sets the minimum height for all chat windows."
--[[Translation missing --]]
L["minchatheight_name"] = "Set Minimum Height"
--[[Translation missing --]]
L["minchatwidth_desc"] = "Sets the minimum width for all chat windows."
--[[Translation missing --]]
L["minchatwidth_name"] = "Set Minimum Width"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("esMX", L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "Параметры окна чата"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
L["framealpha_desc"] = "Настройка прозрачности окна чата при наведении на него курсора мыши."
L["framealpha_name"] = "Прозрачность окна чата"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = "Фреймы"
L["mainchatonload_desc"] = "Автоматически выбирает первое окно чата, и делает его активным при загрузке."
L["mainchatonload_name"] = "Задействовать главное окно чата при загрузке"
L["maxchatheight_desc"] = "Устанавливает максимальную высоту для всех окон чата."
L["maxchatheight_name"] = "Максимальная высоты"
L["maxchatwidth_desc"] = "Устанавливает максимальную ширину для всех окон чата."
L["maxchatwidth_name"] = "Максимальная ширина"
L["minchatheight_desc"] = "Устанавливает минимальную высоту для всех окон чата."
L["minchatheight_name"] = "Минимальная высоты"
L["minchatwidth_desc"] = "Устанавливает минимальную ширину для всех окон чата."
L["minchatwidth_name"] = "Минимальная ширина"
L["rememberframepositions_desc"] = "Запомнить положение окна чата и восстановить при загрузке"
L["rememberframepositions_name"] = "Запомнить положение"
L["removeclamp_desc"] = "Позволить окну чата прижиматься вплотную к краю экрана"
L["removeclamp_name"] = "Вплотную к краю экрана"

  PL:AddLocale("ruRU", L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "聊天窗口参数选项"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
L["framealpha_desc"] = "控制鼠标移过时聊天框架的透明度."
L["framealpha_name"] = "设定聊天框架透明度"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = "框架"
L["mainchatonload_desc"] = "加载时自动选择并激活第1个聊天框架."
L["mainchatonload_name"] = "加载时焦点于主聊天框架."
L["maxchatheight_desc"] = "设定所有聊天窗口的最大高度."
L["maxchatheight_name"] = "设定最大高度"
L["maxchatwidth_desc"] = "设定所有聊天窗口的最大宽度."
L["maxchatwidth_name"] = "设定最大宽度"
L["minchatheight_desc"] = "设定所有聊天窗口的最小高度."
L["minchatheight_name"] = "设定最小高度."
L["minchatwidth_desc"] = "设定所有聊天窗口的最小宽度."
L["minchatwidth_name"] = "设定最小宽度."
L["rememberframepositions_desc"] = "记住聊天框的位置,在加载时恢复."
L["rememberframepositions_name"] = "记住位置"
L["removeclamp_desc"] = "允许聊天框架移动至屏幕边缘齐平"
L["removeclamp_name"] = "零距离边缘固定"

  PL:AddLocale("zhCN", L)

  L = {}
  -- Frames
--[[Translation missing --]]
L["Chat window frame parameter options"] = "Chat window frame parameter options"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
--[[Translation missing --]]
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
--[[Translation missing --]]
L["framealpha_name"] = "Set Chatframe Alpha"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
--[[Translation missing --]]
L["Frames"] = "Frames"
--[[Translation missing --]]
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
--[[Translation missing --]]
L["mainchatonload_name"] = "Force Main Chat Frame On Load"
--[[Translation missing --]]
L["maxchatheight_desc"] = "Sets the maximum height for all chat windows."
--[[Translation missing --]]
L["maxchatheight_name"] = "Set Maximum Height"
--[[Translation missing --]]
L["maxchatwidth_desc"] = "Sets the maximum width for all chat windows."
--[[Translation missing --]]
L["maxchatwidth_name"] = "Set Maximum Width"
--[[Translation missing --]]
L["minchatheight_desc"] = "Sets the minimum height for all chat windows."
--[[Translation missing --]]
L["minchatheight_name"] = "Set Minimum Height"
--[[Translation missing --]]
L["minchatwidth_desc"] = "Sets the minimum width for all chat windows."
L["minchatwidth_name"] = "Establecer ancho mínimo"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("esES",  L)

  L = {}
  -- Frames
L["Chat window frame parameter options"] = "聊天視窗框架參數選項"
--[[Translation missing --]]
L["defaultframealpha_desc"] = "Sets minimum alpha for the chat on mouseover when the static chatframe alpha setting is disabled AND the default alpha is greater than the custom alpha set to the chat window."
--[[Translation missing --]]
L["defaultframealpha_name"] = "Default alpha on mouseover"
--[[Translation missing --]]
L["framealpha_desc"] = "Conrols the transparency of the chatframe when you hover over it with your mouse."
L["framealpha_name"] = "設定聊天欄透明度"
--[[Translation missing --]]
L["framealphastatic_desc"] = "Set the transparency of the chatframe to always match the configured transparency"
--[[Translation missing --]]
L["framealphastatic_name"] = "Static Chatframe Alpha"
L["Frames"] = "框架"
--[[Translation missing --]]
L["mainchatonload_desc"] = "Automatically select the first chat frame and make it active on load."
L["mainchatonload_name"] = "強制主聊天框在載入"
L["maxchatheight_desc"] = "設定最大高度全部聊天視窗。"
L["maxchatheight_name"] = "設定最大高度"
L["maxchatwidth_desc"] = "設定最大寬度全部聊天視窗。"
L["maxchatwidth_name"] = "設定最大寬度"
L["minchatheight_desc"] = "設定對話視窗最小高度"
L["minchatheight_name"] = "設定最小高度"
L["minchatwidth_desc"] = "設定對話視窗最小寬度"
L["minchatwidth_name"] = "設定最小寬度"
--[[Translation missing --]]
L["rememberframepositions_desc"] = "Remember the chatframe positions, and restore them on load"
--[[Translation missing --]]
L["rememberframepositions_name"] = "Remember Positions"
--[[Translation missing --]]
L["removeclamp_desc"] = "Allow the chatframe to be moved flush with the edge of the screen"
--[[Translation missing --]]
L["removeclamp_name"] = "Zero Clamp Size"

  PL:AddLocale("zhTW", L)
  end
  --@end-non-debug@

	-- We have to set the insets here before blizzard has a chance to move them
	for i = 1, NUM_CHAT_WINDOWS do
		local f = _G["ChatFrame" .. i]
		f:SetClampRectInsets(0, 0, 0, 0)
	end

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			minchatwidth = 160,
			minchatwidthdefault = 160,
			maxchatwidth = 800,
			maxchatwidthdefault = 800,
			minchatheight = 120,
			minchatheightdefault = 120,
			maxchatheight = 600,
			maxchatheightdefault = 600,
			mainchatonload = true,
			removeclamp = true,
			framealphastatic = false,
			defaultframealpha = 0.25,
			framemetrics = {
				['*'] = {
					width = 430,
					height = 120,
				}
			}
		}
	})

	do
		local frameoption = {
			name = function(info)
				return PL[info[#info] .. "_name"]
			end,
			desc = function(info)
				return PL[info[#info] .. "_desc"]
			end,
			type = "range",
			min = 25,
			max = 1024,
			step = 1
		}

		Prat:SetModuleOptions(module.name, {
			name = PL["Frames"],
			desc = PL["Chat window frame parameter options"],
			type = "group",
			args = {
				minchatwidth = frameoption,
				maxchatwidth = frameoption,
				minchatheight = frameoption,
				maxchatheight = frameoption,
				removeclamp = {
					type = "toggle",
					order = 110,
					name = PL["removeclamp_name"],
					desc = PL["removeclamp_desc"],
				},
				framealphastatic = {
					type = "toggle",
					order = 130,
					name = PL.framealphastatic_name,
					desc = PL.framealphastatic_desc,
				},
				defaultframealpha = {
					name = PL["defaultframealpha_name"],
					desc = PL["defaultframealpha_desc"],
					type = "range",
					order = 140,
					min = 0.0,
					max = 1,
					step = 0.01,
				},
			}
		})
	end


	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	Prat:SetModuleInit(module, function()
		module:GetDefaults()
	end)

	function module:OnModuleEnable()
		CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0
		self:ConfigureAllChatFrames(true)

		self:SecureHook("FCF_DockFrame")
		self:SecureHook("FCF_UnDockFrame")
		self:SecureHook("FloatingChatFrame_UpdateBackgroundAnchors")

		self:SecureHook("FCF_SetWindowAlpha")
		self:SecureHook("FCF_SetWindowColor")

		if not Prat.IsClassic then
			local prevClamp = ChatFrame1.SetClampRectInsets
			self:SecureHook(ChatFrame1, "SetClampRectInsets", function(frame)
				-- If in combat, SetClampRectInsets is protected... This should likely never happen, but to be safe.
				if _G.InCombatLockdown() then
					return
				end
				if self.db.profile.on and self.db.profile.removeclamp then
					prevClamp(frame, 0, 0, 0, 0)
				end
			end)
		end
	end

	function module:OnModuleDisable()
		CHAT_FRAME_BUTTON_FRAME_MIN_ALPHA = 0.2
		self:ConfigureAllChatFrames(false)
	end

	function module:GetDescription()
		return PL["Chat window frame parameter options"]
	end

	function module:FloatingChatFrame_UpdateBackgroundAnchors(frame)
		if self.db.profile.removeclamp then
			frame:SetClampRectInsets(0, 0, 0, 0)
		end
		Prat.Frames[frame:GetName()] = frame
		local m = Prat:GetModule("Font")
		if m then
			m:ConfigureAllChatFrames()
		end
	end
	function module:FCF_DockFrame(frame)
		if self.db.profile.removeclamp then
			frame:SetClampRectInsets(0, 0, 0, 0)
		end
		Prat.Frames[frame:GetName()] = frame
		local m = Prat:GetModule("Font")
		if m then
			m:ConfigureAllChatFrames()
		end
	end

	function module:FCF_UnDockFrame(frame)
		if self.db.profile.removeclamp then
			frame:SetClampRectInsets(0, 0, 0, 0)
		end
		Prat.Frames[frame:GetName()] = frame
		local m = Prat:GetModule("Font")
		if m then
			m:ConfigureAllChatFrames()
		end
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	-- set parameters for each chatframe
	function module:ConfigureAllChatFrames(enabled)
		for _, v in pairs(Prat.Frames) do
			self:SetParameters(v, enabled)
		end
	end

	function module:RecreateBackgroundTextures(frame)
		if frame.PratTextures then
			return
		end
		frame.PratTextures = {}
		for _, name in ipairs(CHAT_FRAME_TEXTURES) do
			local texture = _G[frame:GetName() .. name]
			local layer, sublevel = texture:GetDrawLayer()

			local newTexture = texture:GetParent():CreateTexture(nil, layer, nil, sublevel)
			for i = 1, texture:GetNumPoints() do
				newTexture:SetPoint(texture:GetPoint(i))
			end

			newTexture:SetTexture(texture:GetTexture())
			newTexture:SetTexCoord(texture:GetTexCoord())

			newTexture:SetSize(texture:GetSize())

			table.insert(frame.PratTextures, newTexture)
			texture:Hide()
		end
	end

	function module:HidePratTextures(frame)
		if frame.PratTextures then
			for _, name in ipairs(CHAT_FRAME_TEXTURES) do
				local texture = _G[frame:GetName() .. name]
				texture:Show()
			end
			for _, texture in ipairs(frame.PratTextures) do
				texture:Hide()
			end
		end
	end

	function module:RestorePratTextures(frame)
		if not frame.PratTextures then
			self:RecreateBackgroundTextures(frame)
		end

		for _, name in ipairs(CHAT_FRAME_TEXTURES) do
			local texture = _G[frame:GetName() .. name]
			texture:Hide()
		end
		local _, _, r, g, b, a = FCF_GetChatWindowInfo(frame:GetID())
		for _, texture in ipairs(frame.PratTextures) do
			texture:Show()
			texture:SetVertexColor(r, g, b)
			texture:SetAlpha(a)
		end
	end

	-- get the defaults for chat frame1 max/min width/height for use when disabling the module
	function module:GetDefaults()
		local cf = _G["ChatFrame1"]
		local prof = self.db.profile

		local minwidthdefault, minheightdefault, maxwidthdefault, maxheightdefault
		if cf.GetResizeBounds then
			minwidthdefault, minheightdefault, maxwidthdefault, maxheightdefault = cf:GetResizeBounds()
		else
			minwidthdefault, minheightdefault = cf:GetMinResize()
			maxwidthdefault, maxheightdefault = cf:GetMaxResize()
		end

		prof.minchatwidthdefault = minwidthdefault
		prof.maxchatwidthdefault = maxwidthdefault
		prof.minchatheightdefault = minheightdefault
		prof.maxchatheightdefault = maxheightdefault

		prof.initialized = true
	end

	function module:FCF_SetWindowColor(frame, r, g, b)
		if frame.PratTextures then
			for _, texture in ipairs(frame.PratTextures) do
				texture:SetVertexColor(r, g, b)
			end
		end
	end

	function module:FCF_SetWindowAlpha(frame)
		local _, _, _, _, _, a = FCF_GetChatWindowInfo(frame:GetID())
		if frame.PratTextures then
			for _, texture in ipairs(frame.PratTextures) do
				texture:SetAlpha(a)
			end
		end
	end
	-- set the max/min width/height for a chatframe
	function module:SetParameters(cf, enabled)
		local prof = self.db.profile

		local minWidth, minHeight, maxWidth, maxHeight
		if enabled then
			if prof.framealphastatic then
				self:RestorePratTextures(cf)
			else
				self:HidePratTextures(cf)
			end

			DEFAULT_CHATFRAME_ALPHA = prof.defaultframealpha

			minWidth, minHeight = prof.minchatwidth, prof.minchatheight
			maxWidth, maxHeight = prof.maxchatwidth, prof.maxchatheight

			if prof.removeclamp then
				if not Prat.IsClassic then
					cf:SetClampedToScreen(false)
				end
				cf:SetClampRectInsets(0, 0, 0, 0)
				if not Prat.IsClassic then
					EventRegistry:RegisterCallback("EditMode.Enter", function()
						cf:SetClampedToScreen(true)
						EventRegistry:UnregisterCallback("EditMode.Enter", cf)
					end, cf)
				end
			end

			if cf.ScrollBar then
				cf.ScrollBar:SetAlpha(0)
			end
		else
			self:HidePratTextures(cf)
			DEFAULT_CHATFRAME_ALPHA = 0.25

			minWidth, minHeight = prof.minchatwidthdefault, prof.minchatheightdefault
			maxWidth, maxHeight = prof.maxchatwidthdefault, prof.maxchatheightdefault
		end

		if cf.SetResizeBounds then
			cf:SetResizeBounds(minWidth, minHeight, maxWidth, maxHeight)
		else
			cf:SetMinResize(minWidth, minHeight)
			cf:SetMaxResize(maxWidth, maxHeight)
		end
	end

	function module:OnValueChanged()
		self:ConfigureAllChatFrames(true)
	end

	return
end) -- Prat:AddModuleToLoad
