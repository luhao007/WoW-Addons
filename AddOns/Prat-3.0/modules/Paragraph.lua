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
	local module = Prat:NewModule("Paragraph")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Paragraph"] = true,
		["Chat window paragraph options."] = true,
		["justification_name"] = "Set Alignment",
		["justification_desc"] = "Set horizontal alignment for each chat window",
		["Line Spacing"] = true,
		["Set the line spacing for all chat windows."] = true,
		["adjustlinks_name"] = "Fix placement of player/item links",
		["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text.",
		["Center"] = true,
		["Right"] = true,
		["Left"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text."
L["adjustlinks_name"] = "Fix placement of player/item links"
L["Center"] = true
L["Chat window paragraph options."] = true
L["justification_desc"] = "Set horizontal alignment for each chat window"
L["justification_name"] = "Set Alignment"
L["Left"] = true
L["Line Spacing"] = true
L["Paragraph"] = true
L["Right"] = true
L["Set the line spacing for all chat windows."] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- Paragraph
--[[Translation missing --]]
L["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text."
--[[Translation missing --]]
L["adjustlinks_name"] = "Fix placement of player/item links"
--[[Translation missing --]]
L["Center"] = "Center"
--[[Translation missing --]]
L["Chat window paragraph options."] = "Chat window paragraph options."
--[[Translation missing --]]
L["justification_desc"] = "Set horizontal alignment for each chat window"
--[[Translation missing --]]
L["justification_name"] = "Set Alignment"
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["Line Spacing"] = "Line Spacing"
--[[Translation missing --]]
L["Paragraph"] = "Paragraph"
--[[Translation missing --]]
L["Right"] = "Right"
--[[Translation missing --]]
L["Set the line spacing for all chat windows."] = "Set the line spacing for all chat windows."

  PL:AddLocale("itIT", L)



  L = {}
  -- Paragraph
--[[Translation missing --]]
L["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text."
--[[Translation missing --]]
L["adjustlinks_name"] = "Fix placement of player/item links"
--[[Translation missing --]]
L["Center"] = "Center"
--[[Translation missing --]]
L["Chat window paragraph options."] = "Chat window paragraph options."
--[[Translation missing --]]
L["justification_desc"] = "Set horizontal alignment for each chat window"
--[[Translation missing --]]
L["justification_name"] = "Set Alignment"
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["Line Spacing"] = "Line Spacing"
--[[Translation missing --]]
L["Paragraph"] = "Paragraph"
--[[Translation missing --]]
L["Right"] = "Right"
--[[Translation missing --]]
L["Set the line spacing for all chat windows."] = "Set the line spacing for all chat windows."

  PL:AddLocale("ptBR", L)


  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "Ajuster les liens pour pouvoir cliquer dessus si ils sont centrés ou alignés à droite."
L["adjustlinks_name"] = "Répare la position des liens des joueurs/objets"
L["Center"] = "Centrer"
L["Chat window paragraph options."] = "Options de paragraphe."
L["justification_desc"] = "Défiinr l'alignement horizontale pour chaque fenêtre de chat"
L["justification_name"] = "Définir l'alignement"
L["Left"] = "Gauche"
L["Line Spacing"] = "Espacement des lignes"
L["Paragraph"] = "Paragraphe"
L["Right"] = "Droite"
L["Set the line spacing for all chat windows."] = "Définit l'espacement des lignes pour toutes les fenêtres de discussions."

  PL:AddLocale("frFR",L)




  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "Passt die Links an, um die Klickbarkeit von zentriertem oder rechtsbündigem Text wiederherzustellen."
L["adjustlinks_name"] = "Platzierung von Spieler-/Gegenstandslinks korrigieren"
L["Center"] = "Mitte"
L["Chat window paragraph options."] = "Paragraphoptionen in Chatfenstern."
L["justification_desc"] = "Horizontale Ausrichtung für jedes Chat-Fenster einstellen."
L["justification_name"] = "Ausrichtung einstellen"
L["Left"] = "Links"
L["Line Spacing"] = "Zeilenabstand"
L["Paragraph"] = true
L["Right"] = "Rechts"
L["Set the line spacing for all chat windows."] = "Den Zeilenabstand für alle Chatfenster einstellen."

  PL:AddLocale("deDE", L)


  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "중앙이나 우측 정렬일 때 클릭 기능을 위해 링크 위치를 조절합니다."
L["adjustlinks_name"] = "플레이어/아이템 링크 위치 수정"
L["Center"] = "가운데"
L["Chat window paragraph options."] = "대화창 단락 옵션입니다."
L["justification_desc"] = "각 대화창 별로 가로 정렬을 설정합니다."
L["justification_name"] = "정렬 설정"
L["Left"] = "왼쪽"
L["Line Spacing"] = "줄 간격"
L["Paragraph"] = "단락 [Paragraph]"
L["Right"] = "오른쪽"
L["Set the line spacing for all chat windows."] = "모든 대화창의 줄 간격을 설정합니다."

  PL:AddLocale("koKR",L)

  L = {}
  -- Paragraph
--[[Translation missing --]]
L["adjustlinks_desc"] = "Adjust links to restore clickability on centered or right-aligned text."
--[[Translation missing --]]
L["adjustlinks_name"] = "Fix placement of player/item links"
--[[Translation missing --]]
L["Center"] = "Center"
--[[Translation missing --]]
L["Chat window paragraph options."] = "Chat window paragraph options."
--[[Translation missing --]]
L["justification_desc"] = "Set horizontal alignment for each chat window"
--[[Translation missing --]]
L["justification_name"] = "Set Alignment"
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["Line Spacing"] = "Line Spacing"
--[[Translation missing --]]
L["Paragraph"] = "Paragraph"
--[[Translation missing --]]
L["Right"] = "Right"
--[[Translation missing --]]
L["Set the line spacing for all chat windows."] = "Set the line spacing for all chat windows."

  PL:AddLocale("esMX",L)

  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "Регулировка текста кликабельных сссылок способностей по центру или в право/лево."
L["adjustlinks_name"] = "Размещение ссылок игроков/предметов"
L["Center"] = "Центр"
L["Chat window paragraph options."] = "Настройки абзаца окна чата."
L["justification_desc"] = "Горизонтальное выравнивание всех окон чата."
L["justification_name"] = "Выравнивание"
L["Left"] = "Влево"
L["Line Spacing"] = "Промежуток строк"
L["Paragraph"] = "Абзац"
L["Right"] = "Вправо"
L["Set the line spacing for all chat windows."] = "Установка промежутка строк во всех окнах чата."

  PL:AddLocale("ruRU",L)

  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "调整链接以恢复在中心或右对齐文本上的可点击性"
L["adjustlinks_name"] = "修复玩家/物品位置链接"
L["Center"] = "中心"
L["Chat window paragraph options."] = "聊天窗口段落选项"
L["justification_desc"] = "为每个聊天窗口设置水平对齐"
L["justification_name"] = "设置对齐"
L["Left"] = "左"
L["Line Spacing"] = "行距"
L["Paragraph"] = "段落"
L["Right"] = "右"
L["Set the line spacing for all chat windows."] = "为所有聊天窗口设置行间距"

  PL:AddLocale("zhCN",L)

  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "Ajustar los vínculos para restaurar la capacidad de hacer click en texto centrado o alineado a la derecha."
L["adjustlinks_name"] = "Corregir la colocación de enlaces de jugador/objeto"
L["Center"] = "Centro"
L["Chat window paragraph options."] = "Opciones de párrafo en ventanas de chat."
L["justification_desc"] = "Establecer alineación horizontal para cada ventana de chat"
L["justification_name"] = "Establecer Alineación"
L["Left"] = "Izquierda"
L["Line Spacing"] = "Espaciado de Linea"
L["Paragraph"] = "Párrafo"
L["Right"] = "Derecha"
L["Set the line spacing for all chat windows."] = "Establece el espaciado de línea para todas las ventanas de chat."

  PL:AddLocale("esES",L)

  L = {}
  -- Paragraph
L["adjustlinks_desc"] = "在置中或靠右排列文字時，調整連結並復原點擊開啟能力"
L["adjustlinks_name"] = "修正玩家或物品連結"
L["Center"] = "中央"
L["Chat window paragraph options."] = "聊天視窗段落設定"
L["justification_desc"] = "設定所有聊天視窗水平對齊"
L["justification_name"] = "設定對齊"
L["Left"] = "左方"
L["Line Spacing"] = "行間距"
L["Paragraph"] = "段落"
L["Right"] = "右"
L["Set the line spacing for all chat windows."] = "設定聊天視窗段落間隔"

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@

	Prat:SetModuleDefaults(module, {
		profile = {
			on = false,
			justification = { ["*"] = "LEFT" },
			spacing = 0
		}
	})

	do
		local justifyoption = {
			name = function(info)
				return Prat.FrameList[info[#info]] or ""
			end,
			desc = PL["justification_name"],
			type = "select",
			get = function(info)
				return info.handler.db.profile.justification[info[#info]]
			end,
			set = function(info, v)
				info.handler.db.profile.justification[info[#info]] = v
				info.handler:OnValueChanged(info, v)
			end,
			values = { ["RIGHT"] = PL["Right"], ["CENTER"] = PL["Center"], ["LEFT"] = PL["Left"] },
			hidden = function(info)
				return Prat.FrameList[info[#info]] == nil
			end,
		}

		Prat:SetModuleOptions(module, {
			name = PL["Paragraph"],
			desc = PL["Chat window paragraph options."],
			type = "group",
			args = {
				justification = {
					name = PL["justification_name"],
					desc = PL["justification_desc"],
					type = "group",
					inline = true,
					args = {
						ChatFrame1 = justifyoption,
						ChatFrame2 = justifyoption,
						ChatFrame3 = justifyoption,
						ChatFrame4 = justifyoption,
						ChatFrame5 = justifyoption,
						ChatFrame6 = justifyoption,
						ChatFrame7 = justifyoption,
					},
				},
				spacing = {
					name = PL["Line Spacing"],
					desc = PL["Set the line spacing for all chat windows."],
					type = "range",
					min = 0,
					max = 20,
					step = 1,
					order = 109
				},
				info = {
					name = "Note: Playerlinks, itemlinks, and any other link type will not work when justification is set to anything other than 'Left'",
					type = "description",
					order = 110
				}
			}
		})
	end

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	function module:OnModuleEnable()
		self:ConfigureAllChatFrames(true)
		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
	end

	function module:OnModuleDisable()
		self:ConfigureAllChatFrames(false)
	end

	function module:OnValueChanged()
		self:ConfigureAllChatFrames(true)
	end

	function module:Prat_FramesUpdated()
		self:ConfigureAllChatFrames(true)
	end

	--[[------------------------------------------------
	  Core Functions
	------------------------------------------------]] --
	function module:GetDescription()
		return PL["Chat window paragraph options."]
	end

	function module:ConfigureAllChatFrames(enable)
		local prof = self.db.profile
		for k, v in pairs(Prat.Frames) do
			v:SetJustifyH(enable and prof.justification[k] or "LEFT")
			v:SetSpacing(prof.spacing)
		end
	end

	return
end) -- Prat:AddModuleToLoad
