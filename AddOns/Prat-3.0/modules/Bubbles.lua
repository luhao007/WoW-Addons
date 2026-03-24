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
	local module = Prat:NewModule("Bubbles")
	local PL = module.PL
	module._classic_era = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC

	--[==[@debug@
	PL:AddLocale("enUS", {
		module_name = "Bubbles",
		module_desc = "Chat bubble related customizations",
		shorten_name = "Shorten Bubbles",
		shorten_desc = "Shorten the chat bubbles down to a single line each. Mouse over the bubble to expand the text.",
		color_name = "Color Bubbles",
		color_desc = "Color the chat bubble border the same as the chat type.",
		format_name = "Format Text",
		format_desc = "Apply Prat's formatting to the chat bubble text.",
		icons_name = "Show Raid Icons",
		icons_desc = "Show raid icons in the chat bubbles.",
		font_name = "Use Chat Font",
		font_desc = "Use the same font you are using on the chatframe",
		fontsize_name = "Font Size",
		fontsize_desc = "Set the chat bubble font size",
		transparent_name = "Transparent Bubbles",
		transparent_desc = "Hide background and border textures from chat bubbles. (/reload required to undo this option)",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/

	--@non-debug@
  do
	  local L


  L = {}
  -- Bubbles
L["color_desc"] = "Color the chat bubble border the same as the chat type."
L["color_name"] = "Color Bubbles"
L["font_desc"] = "Use the same font you are using on the chatframe"
L["font_name"] = "Use Chat Font"
L["fontsize_desc"] = "Set the chat bubble font size"
L["fontsize_name"] = "Font Size"
L["format_desc"] = "Apply Prat's formatting to the chat bubble text."
L["format_name"] = "Format Text"
L["icons_desc"] = "Show raid icons in the chat bubbles."
L["icons_name"] = "Show Raid Icons"
L["module_desc"] = "Chat bubble related customizations"
L["module_name"] = "Bubbles"
L["shorten_desc"] = "Shorten the chat bubbles down to a single line each. Mouse over the bubble to expand the text."
L["shorten_name"] = "Shorten Bubbles"
L["transparent_desc"] = "Hide background and border textures from chat bubbles. (/reload required to undo this option)"
L["transparent_name"] = "Transparent Bubbles"


	PL:AddLocale("enUS",L)



  L = {}
  -- Bubbles
L["color_desc"] = "Colorie la bordure de la bulle en fonction du type de discussion."
L["color_name"] = "Colorier les bulles"
L["font_desc"] = "Utiliser la même police que celle de la fenêtre de discussion."
L["font_name"] = "Police du chat"
L["fontsize_desc"] = "Définit la taille du texte dans les bulles."
L["fontsize_name"] = "Taille du texte"
L["format_desc"] = "Appliquer le formatage de Prat aux textes dans les bulles."
L["format_name"] = "Formater le texte"
L["icons_desc"] = "Montrer les icônes de raid dans les bulles."
L["icons_name"] = "Montrer les icônes de raid"
L["module_desc"] = "Options des bulles de chat ."
L["module_name"] = "Bulles"
L["shorten_desc"] = "Raccourci le texte des bulles à une seule ligne. Mettre la souris sur la bulle pour étendre la bulle et voir le texte en entier."
L["shorten_name"] = "Raccourcir les bulles"
--[[Translation missing --]]
L["transparent_desc"] = "Hide background and border textures from chat bubbles. (/reload required to undo this option)"
--[[Translation missing --]]
L["transparent_name"] = "Transparent Bubbles"


	PL:AddLocale("frFR",L)



  L = {}
  -- Bubbles
L["color_desc"] = "Färbt den Rand der Sprechblase genauso wie den Chat-Typ."
L["color_name"] = "Sprechblasen färben"
L["font_desc"] = "Die selbe Schriftart wie auch für das Chatfenster verwenden"
L["font_name"] = "Chatschriftart verwenden"
L["fontsize_desc"] = "Stellt die Schriftgröße der Sprechblase ein"
L["fontsize_name"] = "Schriftgröße"
L["format_desc"] = "Wendet die Formatierung von Prat auf den Sprechblasentext an."
L["format_name"] = "Text formatieren"
L["icons_desc"] = "Zielmarkierungssymbole in den Sprechblasen anzeigen."
L["icons_name"] = "Zielmarkierungssymbole anzeigen"
L["module_desc"] = "Sprechblasenbezogene Anpassungen"
L["module_name"] = "Blasen"
L["shorten_desc"] = "Verkürze die Sprechblasen zu einem Einzeiler. Fahre mit der Maus über die Sprachblase , um den Text zu erweitern"
L["shorten_name"] = "Sprechblasen verkürzen"
L["transparent_desc"] = "Ausblenden des Hintergrunds und den Randstrukturen von Sprechblasen. (/reload ist erforderlich, um diese Option rückgängig zu machen)"
L["transparent_name"] = "Transparente Blasen"


	PL:AddLocale("deDE",L)



  L = {}
  -- Bubbles
L["color_desc"] = "말풍선 테두리 색상을 대화 유형에 맞춥니다."
L["color_name"] = "말풍선 색상"
L["font_desc"] = "대화창에서 사용중인 글꼴과 같은 글꼴 사용"
L["font_name"] = "대화 글꼴 사용"
L["fontsize_desc"] = "말풍선 글꼴 크기를 설정합니다"
L["fontsize_name"] = "글꼴 크기"
L["format_desc"] = "대화 말풍선 내용에 Prat 서식을 적용합니다."
L["format_name"] = "문자열 서식"
L["icons_desc"] = "말풍선에 전술 아이콘을 표시합니다."
L["icons_name"] = "전술 아이콘 표시"
L["module_desc"] = "대화 말풍선과 관련된 사용자 설정"
L["module_name"] = "말풍선 [Bubbles]"
L["shorten_desc"] = "말풍선을 한 줄로 줄입니다. 말풍선에 마우스를 올리면 내용을 확장합니다."
L["shorten_name"] = "말풍선 축소"
L["transparent_desc"] = "대화 말풍선의 배경과 테두리 무늬를 숨깁니다. (이 옵션을 취소하려면 /reload 필요)"
L["transparent_name"] = "투명한 말풍선"


	PL:AddLocale("koKR",L)



  L = {}
  -- Bubbles
--[[Translation missing --]]
L["color_desc"] = "Color the chat bubble border the same as the chat type."
--[[Translation missing --]]
L["color_name"] = "Color Bubbles"
--[[Translation missing --]]
L["font_desc"] = "Use the same font you are using on the chatframe"
--[[Translation missing --]]
L["font_name"] = "Use Chat Font"
--[[Translation missing --]]
L["fontsize_desc"] = "Set the chat bubble font size"
--[[Translation missing --]]
L["fontsize_name"] = "Font Size"
--[[Translation missing --]]
L["format_desc"] = "Apply Prat's formatting to the chat bubble text."
--[[Translation missing --]]
L["format_name"] = "Format Text"
--[[Translation missing --]]
L["icons_desc"] = "Show raid icons in the chat bubbles."
--[[Translation missing --]]
L["icons_name"] = "Show Raid Icons"
--[[Translation missing --]]
L["module_desc"] = "Chat bubble related customizations"
--[[Translation missing --]]
L["module_name"] = "Bubbles"
--[[Translation missing --]]
L["shorten_desc"] = "Shorten the chat bubbles down to a single line each. Mouse over the bubble to expand the text."
--[[Translation missing --]]
L["shorten_name"] = "Shorten Bubbles"
--[[Translation missing --]]
L["transparent_desc"] = "Hide background and border textures from chat bubbles. (/reload required to undo this option)"
--[[Translation missing --]]
L["transparent_name"] = "Transparent Bubbles"


	PL:AddLocale("esMX",L)



  L = {}
  -- Bubbles
L["color_desc"] = "Окрашивать границу облачка чата в цвет канала чата."
L["color_name"] = "Окрашивать облачка"
L["font_desc"] = "Использовать тот же шрифт, что и в окне чата"
L["font_name"] = "Шрифт чата"
L["fontsize_desc"] = "Размер шрифта чата"
L["fontsize_name"] = "Размер шрифта"
L["format_desc"] = "Применить форматирование чата к тексту в облачках чата."
L["format_name"] = "Формат Текста"
L["icons_desc"] = "Показать иконки рейда в облачках чата."
L["icons_name"] = "Показать метки цели рейда"
L["module_desc"] = "Настройки, относящиеся к облачкам чата"
L["module_name"] = "Облачка"
L["shorten_desc"] = "Уменьшать облачка чата до одной строки. Наведите курсор на облачко, чтобы открыть текст полностью."
L["shorten_name"] = "Уменьшать облачка"
L["transparent_desc"] = "Скрыть фон и границы у всплывающих сообщений (требуется /reload для отмены опции)"
L["transparent_name"] = "Прозрачные всплывающие сообщения"


	PL:AddLocale("ruRU",L)



  L = {}
  -- Bubbles
L["color_desc"] = "把聊天泡泡颜色设为与聊天类型一致"
L["color_name"] = "泡泡颜色"
L["font_desc"] = "使用与聊天框相同的字体"
L["font_name"] = "使用聊天字体"
L["fontsize_desc"] = "设置聊天泡泡字体大小"
L["fontsize_name"] = "字体大小"
L["format_desc"] = "聊天泡泡文字应用 Prat's 格式"
L["format_name"] = "格式化文字"
L["icons_desc"] = "在聊天泡泡里显示团队图标。"
L["icons_name"] = "显示团队图标"
L["module_desc"] = "聊天泡泡相关自定义"
L["module_name"] = "泡泡"
L["shorten_desc"] = [=[缩短每个聊天气泡至一行. 鼠标移过气泡时展开文本.
]=]
L["shorten_name"] = "缩短气泡"
L["transparent_desc"] = "隐藏聊天泡泡中的背景和边框材质.(撤销此选项需要/reload)"
L["transparent_name"] = "透明泡泡"


	PL:AddLocale("zhCN",L)



  L = {}
  -- Bubbles
--[[Translation missing --]]
L["color_desc"] = "Color the chat bubble border the same as the chat type."
--[[Translation missing --]]
L["color_name"] = "Color Bubbles"
--[[Translation missing --]]
L["font_desc"] = "Use the same font you are using on the chatframe"
--[[Translation missing --]]
L["font_name"] = "Use Chat Font"
--[[Translation missing --]]
L["fontsize_desc"] = "Set the chat bubble font size"
L["fontsize_name"] = "Tamaño de fuente"
--[[Translation missing --]]
L["format_desc"] = "Apply Prat's formatting to the chat bubble text."
--[[Translation missing --]]
L["format_name"] = "Format Text"
--[[Translation missing --]]
L["icons_desc"] = "Show raid icons in the chat bubbles."
--[[Translation missing --]]
L["icons_name"] = "Show Raid Icons"
--[[Translation missing --]]
L["module_desc"] = "Chat bubble related customizations"
--[[Translation missing --]]
L["module_name"] = "Bubbles"
--[[Translation missing --]]
L["shorten_desc"] = "Shorten the chat bubbles down to a single line each. Mouse over the bubble to expand the text."
--[[Translation missing --]]
L["shorten_name"] = "Shorten Bubbles"
--[[Translation missing --]]
L["transparent_desc"] = "Hide background and border textures from chat bubbles. (/reload required to undo this option)"
--[[Translation missing --]]
L["transparent_name"] = "Transparent Bubbles"


	PL:AddLocale("esES",L)



  L = {}
  -- Bubbles
--[[Translation missing --]]
L["color_desc"] = "Color the chat bubble border the same as the chat type."
L["color_name"] = "顏色氣泡"
--[[Translation missing --]]
L["font_desc"] = "Use the same font you are using on the chatframe"
L["font_name"] = "使用聊天字型"
L["fontsize_desc"] = "設定聊天氣泡字型尺寸"
L["fontsize_name"] = "字型尺寸"
--[[Translation missing --]]
L["format_desc"] = "Apply Prat's formatting to the chat bubble text."
L["format_name"] = "格式文字"
L["icons_desc"] = "顯示在聊天氣泡團隊圖示。"
L["icons_name"] = "顯示團隊圖示"
L["module_desc"] = "自訂對話泡泡"
L["module_name"] = "對話泡泡"
--[[Translation missing --]]
L["shorten_desc"] = "Shorten the chat bubbles down to a single line each. Mouse over the bubble to expand the text."
L["shorten_name"] = "縮短氣泡"
--[[Translation missing --]]
L["transparent_desc"] = "Hide background and border textures from chat bubbles. (/reload required to undo this option)"
--[[Translation missing --]]
L["transparent_name"] = "Transparent Bubbles"


	PL:AddLocale("zhTW",L)


  end
  --@end-non-debug@


	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			shorten = false,
			color = true,
			format = true,
			icons = true,
			font = true,
			transparent = false,
			fontsize = 14,
		}
	})

	local toggleOption = {
		name = function(info)
			return PL[info[#info] .. "_name"]
		end,
		desc = function(info)
			return PL[info[#info] .. "_desc"]
		end,
		type = "toggle",
	}

	Prat:SetModuleOptions(module.name, {
		name = PL["module_name"],
		desc = PL["module_desc"],
		type = "group",
		args = {
			shorten = toggleOption,
			color = toggleOption,
			format = toggleOption,
			icons = toggleOption,
			font = toggleOption,
			transparent = toggleOption,
			fontsize = {
				name = function(info)
					return PL[info[#info] .. "_name"]
				end,
				desc = function(info)
					return PL[info[#info] .. "_desc"]
				end,
				type = "range",
				min = 8,
				max = 32,
				step = 1,
				order = 101
			}
		}
	})

	--[[------------------------------------------------
	  Module Event Functions
	------------------------------------------------]] --

	local BUBBLE_SCAN_THROTTLE = 0.1

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		self.update = self.update or CreateFrame('Frame');
		self.throttle = BUBBLE_SCAN_THROTTLE

		self.update:SetScript("OnUpdate", function(frame, elapsed)
			self.throttle = self.throttle - elapsed
			if frame:IsShown() and self.throttle < 0 then
				self.throttle = BUBBLE_SCAN_THROTTLE
				self:FormatBubbles()
			end
		end)

		self:RestoreDefaults()
		self:APLyOptions()
	end

	function module:APLyOptions()
		self.shorten = self.db.profile.shorten
		self.color = self.db.profile.color
		self.format = self.db.profile.format
		self.icons = self.db.profile.icons
		self.font = self.db.profile.font
		self.fontsize = self.db.profile.fontsize
		self.transparent = self.db.profile.transparent

		if self.shorten or self.color or self.format or self.icons or self.font or self.transparent then
			self.update:Show()
		else
			self.update:Hide()
		end
	end

	function module:OnValueChanged()
		self:RestoreDefaults()

		self:APLyOptions()
	end

	function module:OnModuleDisable()
		self:RestoreDefaults()
	end

	function module:FormatBubbles()
		self:IterateChatBubbles("FormatCallback")
	end

	function module:RestoreDefaults()
		self.update:Hide()

		self:IterateChatBubbles("RestoreDefaultsCallback")
	end

	local textureUVs = {
		"TopLeftCorner", "TopRightCorner",
		"BottomLeftCorner", "BottomRightCorner",
		"TopEdge", "BottomEdge",
		"LeftEdge", "RightEdge"
	}
	-- Called for each chatbubble, passed the bubble's frame and its fontstring
	function module:FormatCallback(frame, fontstring)
		if not frame:IsShown() then
			fontstring.lastText = nil
			return
		end

		if self.color then
			-- Color the bubble border the same as the chat
			local r, g, b, a = fontstring:GetTextColor()
			for _, edge in pairs(textureUVs) do
				frame[edge]:SetVertexColor(r, g, b, a)
			end
			frame.Tail:SetVertexColor(r, g, b, a)
		end

		if self.shorten then
			local wrap = fontstring:CanWordWrap() or false
			-- If the mouse is over, then expand the bubble
			if frame:IsMouseOver() then
				fontstring:SetWordWrap(true)
			elseif wrap == true then
				fontstring:SetWordWrap(false)
			end
		end

		if self.font then
			local _, _, c = fontstring:GetFont()

			fontstring:SetFont(ChatFrame1:GetFont(), self.fontsize, c)
		end

		if self.transparent then
			for _, edge in pairs(textureUVs) do
				frame[edge]:SetTexture(nil)
			end
			frame.Center:SetTexture(nil)
			frame.Tail:SetTexture(nil)
		end

		local text = fontstring:GetText() or ""

		if self.icons then
			if (not fontstring.lastText) or (text ~= fontstring.lastText) then
				local term;
				for tag in string.gmatch(text, "%b{}") do
					term = strlower(string.gsub(tag, "[{}]", ""));
					if (ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]]) then
						text = string.gsub(text, tag, ICON_LIST[ICON_TAG_LIST[term]] .. "0|t");
					end
				end
			end
		end

		if self.format then
			if (not fontstring.lastText) or (text ~= fontstring.lastText) then
				text = Prat:MatchPatterns(text)
				text = Prat:ReplaceMatches(text)
			end
		end

		fontstring:SetText(text)
		fontstring.lastText = text
		fontstring:SetWidth(fontstring:GetWrappedWidth())
	end

	-- Called for each chatbubble, passed the bubble's frame and its fontstring
	function module:RestoreDefaultsCallback(frame, fontstring)
		for _, edge in pairs(textureUVs) do
			frame[edge]:SetVertexColor(1, 1, 1, 1)
		end
		frame.Tail:SetVertexColor(1, 1, 1, 1)
		fontstring:SetWordWrap(true)
		fontstring:SetWidth(fontstring:GetWidth())
	end

	function module:IterateChatBubbles(funcToCall)
		-- includeForbidden is false by default but in case default changes at some point
		for _, chatBubbleObj in pairs(C_ChatBubbles.GetAllChatBubbles(false)) do
			local chatBubble
			if self._classic_era then
				-- yeye, hardcoded's bad, but whole client is hardco-dead
				chatBubble = chatBubbleObj
				chatBubble.Center, chatBubble.TopLeftCorner, chatBubble.TopRightCorner, chatBubble.BottomLeftCorner, chatBubble.BottomRightCorner,
				chatBubble.TopEdge, chatBubble.BottomEdge, chatBubble.LeftEdge, chatBubble.RightEdge,
				chatBubble.Tail, chatBubble.String = chatBubble:GetRegions()
			else
				chatBubble = chatBubbleObj:GetChildren()
			end
			if chatBubble and chatBubble.String and chatBubble.String:GetObjectType() == "FontString" then
				if type(funcToCall) == "function" then
					funcToCall(chatBubble, chatBubble.String)
				else
					self[funcToCall](self, chatBubble, chatBubble.String)
				end
			end
		end
	end

	return
end) -- Prat:AddModuleToLoad
