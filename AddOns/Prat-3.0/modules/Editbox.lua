-- This is the editbox module from Chatter by Antiarc

local GetCVar = _G.GetCVar or _G.C_CVar.GetCVar

local ChatEdit_ChooseBoxForSend = _G.ChatEdit_ChooseBoxForSend or _G.ChatFrameUtil.ChooseBoxForSend
local ChatEdit_DeactivateChat = _G.ChatEdit_DeactivateChat or _G.ChatFrameUtil.DeactivateChat

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("Editbox", "AceHook-3.0")
	local PL = module.PL


	--[==[@debug@
	PL:AddLocale("enUS", {
		["Editbox"] = true,
		["Editbox options."] = true,
		["Top"] = true,
		["Bottom"] = true,
		["Free-floating"] = true,
		["Free-floating, Locked"] = true,
		["Background texture"] = true,
		["Border texture"] = true,
		["Background color"] = true,
		["Border color"] = true,
		["Background Inset"] = true,
		["Tile Size"] = true,
		["Edge Size"] = true,
		["Attach to..."] = true,
		["Attach edit box to..."] = true,
		["Color border by channel"] = true,
		["Sets the frame's border color to the color of your currently active channel"] = true,
		["Use Alt key for cursor movement"] = true,
		["Requires the Alt key to be held down to move the cursor in chat"] = true,
		["Font"] = true,
		currently_broken_alt_behavior = "Arrow key behaviour broken in current WoW client,\n\nUse ALT-UP and ALT-DOWN instead of just UP DOWN to access history",
		["Select the font to use for the edit box"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/

	--@non-debug@
  do
	local L


  L = {}
  -- Editbox
L["Attach edit box to..."] = true
L["Attach to..."] = true
L["Background color"] = true
L["Background Inset"] = true
L["Background texture"] = true
L["Border color"] = true
L["Border texture"] = true
L["Bottom"] = true
L["Color border by channel"] = true
L["currently_broken_alt_behavior"] = [=[Arrow key behaviour broken in current WoW client,

Use ALT-UP and ALT-DOWN instead of just UP DOWN to access history]=]
L["Edge Size"] = true
L["Editbox"] = true
L["Editbox options."] = true
L["Font"] = true
L["Free-floating"] = true
L["Free-floating, Locked"] = true
L["Requires the Alt key to be held down to move the cursor in chat"] = true
L["Select the font to use for the edit box"] = true
L["Sets the frame's border color to the color of your currently active channel"] = true
L["Tile Size"] = true
L["Top"] = true
L["Use Alt key for cursor movement"] = true


  PL:AddLocale("enUS",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "Définit la position de la boîte d'édition."
L["Attach to..."] = "Position"
L["Background color"] = "Couleur du fond"
L["Background Inset"] = "Marge du fond"
L["Background texture"] = "Texture du fond"
L["Border color"] = "Couleur de la bordure"
L["Border texture"] = "Texture de la bordure"
L["Bottom"] = "Bas"
L["Color border by channel"] = "Colorier avec le canal"
--[[Translation missing --]]
L["currently_broken_alt_behavior"] = [=[Arrow key behaviour broken in current WoW client,

Use ALT-UP and ALT-DOWN instead of just UP DOWN to access history]=]
L["Edge Size"] = "Taille de la bordure"
L["Editbox"] = "Boite d'édition"
L["Editbox options."] = "Options de la boite d'édition."
L["Font"] = "Police d'écriture"
L["Free-floating"] = "Flottante"
L["Free-floating, Locked"] = "Flottante, verrouillée"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Requiert de maintenir la touche Alt enfoncée pour déplacer le curseur lorsque vous écrivez un message."
L["Select the font to use for the edit box"] = "Définit la police du texte dans la boîte d'édition."
L["Sets the frame's border color to the color of your currently active channel"] = "Définit la couleur de la bordure avec la couleur du canal actif."
L["Tile Size"] = "Taille du fond"
L["Top"] = "Haut"
L["Use Alt key for cursor movement"] = "Curseur avec Alt"


  PL:AddLocale("frFR",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "Hefte Eingabefeld an..."
L["Attach to..."] = "Befestige an ..."
L["Background color"] = "Hintergrundfarbe"
L["Background Inset"] = "Hintergrundeinfügung"
L["Background texture"] = "Hintergrundbeschaffenheit"
L["Border color"] = "Randfarbe"
L["Border texture"] = "Randtextur"
L["Bottom"] = "Unten"
L["Color border by channel"] = "Farbrand nach Kanal"
L["currently_broken_alt_behavior"] = "Das Verhalten der Pfeiltasten im aktuellen WoW-Client ist unterbrochen. Verwende ALT-HOCH und ALT-RUNTER anstelle von nur HOCH RUNTER, um auf den Verlauf zuzugreifen"
L["Edge Size"] = "Kantengröße"
L["Editbox"] = "Eingabefeld"
L["Editbox options."] = "Optionen für das Eingabefeld."
L["Font"] = "Schriftart"
L["Free-floating"] = "Freischwebend"
L["Free-floating, Locked"] = "Freischwebend, fixiert"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Das Drücken der Alt-Taste wird benötigt, um den Cursor (Zeiger) im Chat zu bewegen."
L["Select the font to use for the edit box"] = "Schriftart auswählen, die im Eingabefeld verwendet wird."
L["Sets the frame's border color to the color of your currently active channel"] = "Legt die Randfarbe des Rahmens auf die Farbe des aktuell aktiven Kanals fest"
L["Tile Size"] = "Kachelgröße"
L["Top"] = "Oben"
L["Use Alt key for cursor movement"] = "Benutze Alt-Taste für Cursor-Bewegung"


  PL:AddLocale("deDE",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "입력창 붙이기..."
L["Attach to..."] = "붙이기..."
L["Background color"] = "배경 색상"
L["Background Inset"] = "배경 삽입"
L["Background texture"] = "배경 무늬"
L["Border color"] = "테두리 색상"
L["Border texture"] = "테두리 무늬"
L["Bottom"] = "아래"
L["Color border by channel"] = "채널에 의한 테두리 색상"
L["currently_broken_alt_behavior"] = [=[화살표 키 동작은 현재 WoW 클라이언트에서 작동하지 않습니다.

기록 접근에 위쪽 아래쪽 키 대신 ALT-위와 ALT-아래 키를 사용하세요]=]
L["Edge Size"] = "모서리 크기"
L["Editbox"] = "대화 입력창 [Editbox]"
L["Editbox options."] = "대화 입력창을 설정합니다."
L["Font"] = "글꼴"
L["Free-floating"] = "자유로운 이동"
L["Free-floating, Locked"] = "자유로운 이동, 잠금"
L["Requires the Alt key to be held down to move the cursor in chat"] = "대화 입력창 커서 이동에 Alt 키를 사용합니다"
L["Select the font to use for the edit box"] = "대화 입력창에 사용할 글꼴 선택"
L["Sets the frame's border color to the color of your currently active channel"] = "대화 입력창 테두리 색상을 현재 채널 색상으로 설정"
L["Tile Size"] = "타일 크기"
L["Top"] = "위"
L["Use Alt key for cursor movement"] = "커서 이동에 Alt 키 사용"


  PL:AddLocale("koKR",L)



  L = {}
  -- Editbox
--[[Translation missing --]]
L["Attach edit box to..."] = "Attach edit box to..."
--[[Translation missing --]]
L["Attach to..."] = "Attach to..."
--[[Translation missing --]]
L["Background color"] = "Background color"
--[[Translation missing --]]
L["Background Inset"] = "Background Inset"
--[[Translation missing --]]
L["Background texture"] = "Background texture"
--[[Translation missing --]]
L["Border color"] = "Border color"
--[[Translation missing --]]
L["Border texture"] = "Border texture"
--[[Translation missing --]]
L["Bottom"] = "Bottom"
--[[Translation missing --]]
L["Color border by channel"] = "Color border by channel"
--[[Translation missing --]]
L["currently_broken_alt_behavior"] = [=[Arrow key behaviour broken in current WoW client,

Use ALT-UP and ALT-DOWN instead of just UP DOWN to access history]=]
--[[Translation missing --]]
L["Edge Size"] = "Edge Size"
--[[Translation missing --]]
L["Editbox"] = "Editbox"
--[[Translation missing --]]
L["Editbox options."] = "Editbox options."
--[[Translation missing --]]
L["Font"] = "Font"
--[[Translation missing --]]
L["Free-floating"] = "Free-floating"
--[[Translation missing --]]
L["Free-floating, Locked"] = "Free-floating, Locked"
--[[Translation missing --]]
L["Requires the Alt key to be held down to move the cursor in chat"] = "Requires the Alt key to be held down to move the cursor in chat"
--[[Translation missing --]]
L["Select the font to use for the edit box"] = "Select the font to use for the edit box"
--[[Translation missing --]]
L["Sets the frame's border color to the color of your currently active channel"] = "Sets the frame's border color to the color of your currently active channel"
--[[Translation missing --]]
L["Tile Size"] = "Tile Size"
--[[Translation missing --]]
L["Top"] = "Top"
--[[Translation missing --]]
L["Use Alt key for cursor movement"] = "Use Alt key for cursor movement"


  PL:AddLocale("esMX",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "Закрепить поле ввода..."
L["Attach to..."] = "Закрепить..."
L["Background color"] = "Цвет фона"
L["Background Inset"] = "Фоновая врезка"
L["Background texture"] = "Текстура фона"
L["Border color"] = "Цвет границ"
L["Border texture"] = "Текстура границы"
L["Bottom"] = "Внизу"
L["Color border by channel"] = "Окраска границы по цвету канала"
L["currently_broken_alt_behavior"] = [=[Поведение стрелок сломано в текущей версии WoW

Используйте ALT-СтрелкаВверх и ALT-СтрелкаВниз вместо просто стрелок вверх и вниз чтобы открыть историю]=]
L["Edge Size"] = "Размер контура"
L["Editbox"] = "Поле ввода"
L["Editbox options."] = "Настройки поля ввода."
L["Font"] = "Шрифт"
L["Free-floating"] = "Свободно"
L["Free-floating, Locked"] = "Свободно, заблокировано"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Для перемещения курсора в чате требуется нажатая клавиша Alt"
L["Select the font to use for the edit box"] = "Выбор шрифта для области редактирования"
L["Sets the frame's border color to the color of your currently active channel"] = "Установить окраску границы в цвет вашего активного канала"
L["Tile Size"] = "Размер мозаики"
L["Top"] = "Вверху"
L["Use Alt key for cursor movement"] = "Исп. кливишу Alt для перемещения курсора"


  PL:AddLocale("ruRU",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "把输入框附加到……"
L["Attach to..."] = "附加到……"
L["Background color"] = "背景颜色"
L["Background Inset"] = "背景嵌入"
L["Background texture"] = "背景纹理"
L["Border color"] = "边框颜色"
L["Border texture"] = "边框纹理"
L["Bottom"] = "底部"
L["Color border by channel"] = "频道颜色边框"
L["currently_broken_alt_behavior"] = [=[在现在WoW客户端里，方向键的行为已损坏，

使用Alt+上和Alt+下来替代上下键浏览历史]=]
L["Edge Size"] = "边缘尺寸"
L["Editbox"] = "输入框"
L["Editbox options."] = "输入框选项"
L["Font"] = "字体"
L["Free-floating"] = "自由浮动"
L["Free-floating, Locked"] = "自由浮动，锁定"
L["Requires the Alt key to be held down to move the cursor in chat"] = "需要在聊天中按住Alt键移动光标"
L["Select the font to use for the edit box"] = "选择输入框的字体"
L["Sets the frame's border color to the color of your currently active channel"] = "设置边框颜色到你当前激活的频道颜色"
L["Tile Size"] = "平铺尺寸"
L["Top"] = "顶部"
L["Use Alt key for cursor movement"] = "使用Alt键令光标移动"


  PL:AddLocale("zhCN",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "Anclar la caja de edición a..."
L["Attach to..."] = "Anclar a..."
L["Background color"] = "Color de fondo"
--[[Translation missing --]]
L["Background Inset"] = "Background Inset"
L["Background texture"] = "Textura de fondo"
L["Border color"] = "Color del borde"
L["Border texture"] = "Textura del borde"
L["Bottom"] = "Abajo"
L["Color border by channel"] = "Color del borde por canal"
--[[Translation missing --]]
L["currently_broken_alt_behavior"] = [=[Arrow key behaviour broken in current WoW client,

Use ALT-UP and ALT-DOWN instead of just UP DOWN to access history]=]
L["Edge Size"] = "Tamaño del borde"
L["Editbox"] = "Caja de edición"
L["Editbox options."] = "Opciones de la caja de edición."
L["Font"] = "Fuente"
L["Free-floating"] = "Flotar-libre"
L["Free-floating, Locked"] = "Flotar-libre, Bloqueado"
L["Requires the Alt key to be held down to move the cursor in chat"] = "Requiere la tecla Alt presionada para mover el cursor en el chat"
L["Select the font to use for the edit box"] = "Seleccione la fuente a usar para la caja de edición"
L["Sets the frame's border color to the color of your currently active channel"] = "Establece el color del borde del marco con el color de su canal actualmente activo"
L["Tile Size"] = "Tamaño de mosaico"
L["Top"] = "Arriba"
L["Use Alt key for cursor movement"] = "Usar la tecla Alt para el desplazamiento del cursor"


  PL:AddLocale("esES",L)



  L = {}
  -- Editbox
L["Attach edit box to..."] = "附上編輯框..."
L["Attach to..."] = "附上..."
L["Background color"] = "背景色彩"
L["Background Inset"] = "背景插入"
L["Background texture"] = "背景材質"
L["Border color"] = "邊緣色彩"
L["Border texture"] = "邊緣材質"
L["Bottom"] = "底部"
L["Color border by channel"] = "顏色邊框由道頻"
--[[Translation missing --]]
L["currently_broken_alt_behavior"] = [=[Arrow key behaviour broken in current WoW client,

Use ALT-UP and ALT-DOWN instead of just UP DOWN to access history]=]
L["Edge Size"] = "邊框尺寸"
L["Editbox"] = "輸入框"
L["Editbox options."] = "輸入框選單"
L["Font"] = "字型"
L["Free-floating"] = "自由浮動"
L["Free-floating, Locked"] = "自由浮動, 已鎖定"
--[[Translation missing --]]
L["Requires the Alt key to be held down to move the cursor in chat"] = "Requires the Alt key to be held down to move the cursor in chat"
L["Select the font to use for the edit box"] = "選擇字型使用編輯框"
--[[Translation missing --]]
L["Sets the frame's border color to the color of your currently active channel"] = "Sets the frame's border color to the color of your currently active channel"
L["Tile Size"] = "並排尺寸"
L["Top"] = "頂部"
L["Use Alt key for cursor movement"] = "使用 Alt 鍵游標移動"


  PL:AddLocale("zhTW",L)


  end
  --@end-non-debug@

	local Media = Prat.Media
	local backgrounds, borders, fonts = {}, {}, {}
	local CreateFrame = _G.CreateFrame
	local max = _G.max
	local pairs = _G.pairs

	local VALID_ATTACH_POINTS = {
		TOP = PL["Top"],
		BOTTOM = PL["Bottom"],
		FREE = PL["Free-floating"],
		LOCK = PL["Free-floating, Locked"]
	}

	local function updateEditBox(method, ...)
		for i = 1, #CHAT_FRAMES do
			local f = _G["ChatFrame" .. i .. "EditBox"]
			f[method](f, ...)
		end
	end

	Prat:SetModuleOptions(module, {
		name = PL["Editbox"],
		desc = PL["Editbox options."],
		type = "group",
		args = {
			background = {
				type = "select",
				name = PL["Background texture"],
				desc = PL["Background texture"],
				values = backgrounds,
				get = function()
					return module.db.profile.background
				end,
				set = function(_, v)
					module.db.profile.background = v
					module:SetBackdrop()
				end
			},
			border = {
				type = "select",
				name = PL["Border texture"],
				desc = PL["Border texture"],
				values = borders,
				get = function()
					return module.db.profile.border
				end,
				set = function(_, v)
					module.db.profile.border = v
					module:SetBackdrop()
				end
			},
			backgroundColor = {
				type = "color",
				name = PL["Background color"],
				desc = PL["Background color"],
				hasAlpha = true,
				get = function()
					local c = module.db.profile.backgroundColor
					return c.r, c.g, c.b, c.a
				end,
				set = function(_, r, g, b, a)
					local c = module.db.profile.backgroundColor
					c.r, c.g, c.b, c.a = r, g, b, a
					module:SetBackdrop()
				end
			},
			borderColor = {
				type = "color",
				name = PL["Border color"],
				desc = PL["Border color"],
				hasAlpha = true,
				get = function()
					local c = module.db.profile.borderColor
					return c.r, c.g, c.b, c.a
				end,
				set = function(_, r, g, b, a)
					local c = module.db.profile.borderColor
					c.r, c.g, c.b, c.a = r, g, b, a
					module:SetBackdrop()
				end
			},
			inset = {
				type = "range",
				name = PL["Background Inset"],
				desc = PL["Background Inset"],
				min = 1,
				max = 64,
				step = 1,
				bigStep = 1,
				get = function()
					return module.db.profile.inset
				end,
				set = function(_, v)
					module.db.profile.inset = v
					module:SetBackdrop()
				end
			},
			tileSize = {
				type = "range",
				name = PL["Tile Size"],
				desc = PL["Tile Size"],
				min = 1,
				max = 64,
				step = 1,
				bigStep = 1,
				get = function()
					return module.db.profile.tileSize
				end,
				set = function(_, v)
					module.db.profile.tileSize = v
					module:SetBackdrop()
				end
			},
			edgeSize = {
				type = "range",
				name = PL["Edge Size"],
				desc = PL["Edge Size"],
				min = 1,
				max = 64,
				step = 1,
				bigStep = 1,
				get = function()
					return module.db.profile.edgeSize
				end,
				set = function(_, v)
					module.db.profile.edgeSize = v
					module:SetBackdrop()
				end
			},
			attach = {
				type = "select",
				name = PL["Attach to..."],
				desc = PL["Attach edit box to..."],
				get = function()
					return module.db.profile.attach
				end,
				values = VALID_ATTACH_POINTS,
				set = function(_, v)
					module.db.profile.attach = v
					module:SetAttach()
				end
			},
			colorByChannel = {
				type = "toggle",
				name = PL["Color border by channel"],
				desc = PL["Sets the frame's border color to the color of your currently active channel"],
				get = function()
					return module.db.profile.colorByChannel
				end,
				set = function(_, v)
					module.db.profile.colorByChannel = v
					if v then
						module:SecureHook("ChatEdit_UpdateHeader", "SetBorderByChannel", true)
					else
						if module:IsHooked("ChatEdit_UpdateHeader") then
							module:Unhook("ChatEdit_UpdateHeader")
							local c = module.db.profile.borderColor
							for _, frame in ipairs(module.frames) do
								frame:SetBackdropBorderColor(c.r, c.g, c.b, c.a)
							end
						end
					end
				end
			},
			useAltKey = {
				type = "toggle",
				name = PL["Use Alt key for cursor movement"],
				desc = PL["Requires the Alt key to be held down to move the cursor in chat"],
				get = function()
					return module.db.profile.useAltKey
				end,
				set = function(_, v)
					module.db.profile.useAltKey = v
					updateEditBox("SetAltArrowKeyMode", v)
				end,
			},
			font = {
				type = "select",
				name = PL["Font"],
				desc = PL["Select the font to use for the edit box"],
				values = fonts,
				get = function()
					return module.db.profile.font
				end,
				set = function(_, v)
					module.db.profile.font = v
					for i = 1, #CHAT_FRAMES do
						local ff = _G["ChatFrame" .. i .. "EditBox"]
						local header = _G[ff:GetName() .. "Header"]
						local _, s, m = ff:GetFont()
						local font = Media:Fetch("font", v)
						ff:SetFont(font, s, m)
						header:SetFont(font, s, m)
					end
				end
			},
		},
	})

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			background = "Blizzard Tooltip",
			border = "Blizzard Tooltip",
			backgroundColor = { r = 0, g = 0, b = 0, a = 1 },
			borderColor = { r = 1, g = 1, b = 1, a = 1 },
			inset = 3,
			edgeSize = 12,
			tileSize = 16,
			height = 22,
			attach = "BOTTOM",
			colorByChannel = true,
			useAltKey = false,
			font = (function()
				for i = 1, #CHAT_FRAMES do
					local ff = _G["ChatFrame" .. i .. "EditBox"]
					local f = ff:GetFont()
					for k, v in pairs(Media:HashTable("font")) do
						if v == f then
							return k
						end
					end
				end
			end)()
		}
	})

	function module:LibSharedMedia_Registered()
		for _, v in pairs(Media:List("background")) do
			backgrounds[v] = v
		end
		for _, v in pairs(Media:List("border")) do
			borders[v] = v
		end
		for _, v in pairs(Media:List("font")) do
			fonts[v] = v
		end
	end

	local function MakePratEditbox(self, i)
		if not self.frames[i] then
			local parent = _G["ChatFrame" .. i .. "EditBox"]

			local frame = CreateFrame("Frame", nil, parent, BackdropTemplateMixin and "BackdropTemplate")
			frame:SetFrameStrata("DIALOG")
			frame:SetFrameLevel(parent:GetFrameLevel() - 1)
			frame:SetAllPoints(parent)
			frame:Hide()
			parent.pratFrame = frame
			self.frames[i] = frame

			parent.lDrag = CreateFrame("Frame", nil, parent)
			parent.lDrag:SetWidth(15)
			parent.lDrag:SetPoint("TOPLEFT", parent, "TOPLEFT")
			parent.lDrag:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT")
			parent.lDrag.left = true

			parent.rDrag = CreateFrame("Frame", nil, parent)
			parent.rDrag:SetWidth(15)
			parent.rDrag:SetPoint("TOPRIGHT", parent, "TOPRIGHT")
			parent.rDrag:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT")
		end
	end

	Prat:SetModuleInit(module,
		function(self)

			Media.RegisterCallback(module, "LibSharedMedia_Registered")
			self.frames = {}

			self:LibSharedMedia_Registered()

			for i = 1, #CHAT_FRAMES do
				MakePratEditbox(self, i)
			end
		end)

	local function OnArrowPressed(self, key)
		-- We cannot call SetText while in lockdown
		if C_ChatInfo and C_ChatInfo.InChatMessagingLockdown and C_ChatInfo.InChatMessagingLockdown() then
			return
		end
		if #self.history_lines == 0 then
			return
		end

		if key == "DOWN" then
			self.history_index = self.history_index - 1

			if self.history_index < 1 then
				self.history_index = #self.history_lines
			end
		elseif key == "UP" then
			self.history_index = self.history_index + 1

			if self.history_index > #self.history_lines then
				self.history_index = 1
			end
		else
			return -- We don't want to interfere with LEFT/RIGHT because the tab-complete stuff might use it; we're already killing the other two.
		end

		self:SetText(self.history_lines[self.history_index])
	end

	local function enableArrowKeys(e)
		e.history_lines = e.history_lines or {}
		e.history_index = e.history_index or 0
		e:HookScript("OnArrowPressed", OnArrowPressed)
	end

	function module:Prat_FramesUpdated(_, _, chatFrame)
		local i = chatFrame:GetID()
		local f = _G["ChatFrame" .. i .. "EditBox"]
		_G["ChatFrame" .. i .. "EditBoxLeft"]:Hide()
		_G["ChatFrame" .. i .. "EditBoxRight"]:Hide()
		_G["ChatFrame" .. i .. "EditBoxMid"]:Hide()
		if f.focusLeft then
			f.focusLeft:SetAlpha(0)
		end
		if f.focusRight then
			f.focusRight:SetAlpha(0)
		end
		if f.focusMid then
			f.focusMid:SetAlpha(0)
		end
		f:Hide()

		MakePratEditbox(self, i)
		self.frames[i]:Show()

		local _, s, m = f:GetFont()
		f:SetFont(Media:Fetch("font", self.db.profile.font), s, m)

		local header = _G[f:GetName() .. "Header"]
		local _, s2, m2 = header:GetFont()
		header:SetFont(Media:Fetch("font", self.db.profile.font), s2, m2)

		f:SetAltArrowKeyMode(module.db.profile.useAltKey and 1 or nil)
		if (not module.db.profile.useAltKey) then
			enableArrowKeys(f)
		end
		self:SetBackdrop()
		self:UpdateHeight()
		self:SetAttach(nil, self.db.profile.editX, self.db.profile.editY, self.db.profile.editW)
	end

	function module:OnModuleEnable()
		self:LibSharedMedia_Registered()

		for i = 1, #CHAT_FRAMES do
			local f = _G["ChatFrame" .. i .. "EditBox"]
			_G["ChatFrame" .. i .. "EditBoxLeft"]:Hide()
			_G["ChatFrame" .. i .. "EditBoxRight"]:Hide()
			_G["ChatFrame" .. i .. "EditBoxMid"]:Hide()
			if f.focusLeft then
				f.focusLeft:SetAlpha(0)
			end
			if f.focusRight then
				f.focusRight:SetAlpha(0)
			end
			if f.focusMid then
				f.focusMid:SetAlpha(0)
			end
			f:Hide()

			-- Prevent an error in FloatingChatFrame FCF_FadeOutChatFrame() (blizz bug)
			f:SetAlpha(f:GetAlpha() or 0)

			MakePratEditbox(self, i) -- For new temporary chat frames created between init and now
			self.frames[i]:Show()
			local _, s, m = f:GetFont()
			f:SetFont(Media:Fetch("font", self.db.profile.font), s, m)

			local header = _G[f:GetName() .. "Header"]
			local _, s2, m2 = header:GetFont()
			header:SetFont(Media:Fetch("font", self.db.profile.font), s2, m2)

			f:SetAltArrowKeyMode(module.db.profile.useAltKey and 1 or nil)
			if (not module.db.profile.useAltKey) then
				enableArrowKeys(f)
			end
		end

		self:SetBackdrop()

		self:SetAttach(nil, self.db.profile.editX, self.db.profile.editY, self.db.profile.editW)

		if _G.ChatFrameUtil then
			if _G.ChatFrameUtil.DeactivateChat then
				self:SecureHook(_G.ChatFrameUtil, "DeactivateChat", "ChatEdit_DeactivateChat")
			end
			if _G.ChatFrameUtil.SetLastActiveWindow then
				self:SecureHook(_G.ChatFrameUtil, "SetLastActiveWindow", "ChatEdit_SetLastActiveWindow")
			end
			if _G.ChatFrameUtil.OpenChat then
				self:SecureHook(_G.ChatFrameUtil, "OpenChat", "ChatFrame_OpenChat")
			end
		else
			self:SecureHook("ChatEdit_DeactivateChat")
			self:SecureHook("ChatEdit_SetLastActiveWindow")
			self:SecureHook("ChatFrame_OpenChat")
		end

		self:SetBackdrop()
		self:UpdateHeight()
		if self.db.profile.colorByChannel then
			if _G.ChatFrameEditBoxBaseMixin and _G.ChatFrameEditBoxBaseMixin.UpdateHeader then
				self:SecureHook(_G.ChatFrameEditBoxBaseMixin, "UpdateHeader", "SetBorderByChannel")
			else
				self:SecureHook("ChatEdit_UpdateHeader", "SetBorderByChannel", true)
			end
		end
		self:SecureHook("FCF_Tab_OnClick")

		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
	end

	function module:ChatFrame_OpenChat(_, chatFrame)
		if not self.db.profile.useAltKey then
			local frame = ChatEdit_ChooseBoxForSend(chatFrame)

			frame.history_index = 0
		end
	end

	function module:FCF_Tab_OnClick(frame)
		if self.db.profile.attach == "TOP" and GetCVar("chatStyle") ~= "classic" then
			local chatFrame = _G["ChatFrame" .. frame:GetID()];
			ChatEdit_DeactivateChat(chatFrame.editBox)
			chatFrame.editBox:Hide()
		end
	end

	function module:OnModuleDisable()
		self:SetAttach("BOTTOM") -- clear move/resize handlers
		for i = 1, #CHAT_FRAMES do
			local f = _G["ChatFrame" .. i .. "EditBox"]
			_G["ChatFrame" .. i .. "EditBoxLeft"]:Show()
			_G["ChatFrame" .. i .. "EditBoxRight"]:Show()
			_G["ChatFrame" .. i .. "EditBoxMid"]:Show()
			if f.focusLeft then
				f.focusLeft:SetAlpha(1)
			end
			if f.focusRight then
				f.focusRight:SetAlpha(1)
			end
			if f.focusMid then
				f.focusMid:SetAlpha(1)
			end
			f:SetAltArrowKeyMode(true)
			f:EnableMouse(true)
			f.pratFrame:Hide()
			-- restore Blizz size/position
			f:ClearAllPoints()
			f:SetHeight(32)
			f:SetPoint("TOPLEFT", f.chatFrame, "BOTTOMLEFT", -5, -2)
			if Prat.IsClassic then
				f:SetPoint("TOPRIGHT", f.chatFrame, "BOTTOMRIGHT", 5, -2)
			else
				f:SetPoint("RIGHT", f.chatFrame.ScrollBar, "RIGHT", 5, 0)
			end
		end
	end

	function module:GetDescription()
		return PL["Editbox options."]
	end

	-- changed the Hide to SetAlpha(0), the new ChatSystem OnHide handlers go though some looping
	-- when in IM style and Classic style, cause heavy delays on the chat edit box.
	function module:ChatEdit_SetLastActiveWindow(frame)
		if frame:IsShown() then
			frame:SetAlpha(0)
		else
			frame:SetAlpha(1)
		end
		frame:EnableMouse(true)
	end

	function module:ChatEdit_DeactivateChat(frame)
		if frame:IsShown() then
			frame:SetAlpha(0)
			frame:EnableMouse(false)
		end
	end

	function module:SetBackdrop()
		for _, frame in ipairs(self.frames) do
			frame:SetBackdrop({
				bgFile = Media:Fetch("background", self.db.profile.background),
				edgeFile = Media:Fetch("border", self.db.profile.border),
				tile = true,
				tileSize = self.db.profile.tileSize,
				edgeSize = self.db.profile.edgeSize,
				insets = {
					left = self.db.profile.inset,
					right = self.db.profile.inset,
					top = self.db.profile.inset,
					bottom = self.db.profile.inset
				}
			})
			local c = self.db.profile.backgroundColor
			frame:SetBackdropColor(c.r, c.g, c.b, c.a)

			local c2 = self.db.profile.borderColor
			frame:SetBackdropBorderColor(c2.r, c2.g, c2.b, c2.a)
		end
	end

	function module:SetBorderByChannel()
		for index, frame in ipairs(self.frames) do
			local f = _G["ChatFrame" .. index .. "EditBox"]
			local attr = f:GetAttribute("chatType")
			if attr == "CHANNEL" then
				local chan = f:GetAttribute("channelTarget")
				if chan == 0 then
					local c = self.db.profile.borderColor
					frame:SetBackdropBorderColor(c.r, c.g, c.b, c.a)
				elseif chan and ChatTypeInfo["CHANNEL" .. chan] then
					local r, g, b = GetMessageTypeColor("CHANNEL" .. chan)
					frame:SetBackdropBorderColor(r, g, b, 1)
				end
			else
				local r, g, b = GetMessageTypeColor(attr)
				frame:SetBackdropBorderColor(r, g, b, 1)
			end
		end
	end

	do
		local function startMoving(self)
			self:StartMoving()
		end

		local function stopMoving(self)
			self:StopMovingOrSizing()
			module.db.profile.editX = self:GetLeft()
			module.db.profile.editY = self:GetTop()
			module.db.profile.editW = self:GetRight() - self:GetLeft()
		end

		local cfHeight
		local function constrainHeight(self)
			self:GetParent():SetHeight(cfHeight)
		end

		local function startDragging(self)
			cfHeight = self:GetParent():GetHeight()
			self:GetParent():StartSizing(not self.left and "TOPRIGHT" or "TOPLEFT")
			self:SetScript("OnUpdate", constrainHeight)
		end

		local function stopDragging(self)
			local parent = self:GetParent()
			parent:StopMovingOrSizing()
			self:SetScript("OnUpdate", nil)
			module.db.profile.editX = parent:GetLeft()
			module.db.profile.editY = parent:GetTop()
			module.db.profile.editW = parent:GetWidth()
		end

		function module:SetAttach(val, x, y, w)
			for i = 1, #CHAT_FRAMES do
				local frame = _G["ChatFrame" .. i .. "EditBox"]
				val = val or self.db.profile.attach
				if not x and val == "FREE" then
					if self.db.profile.editX and self.db.profile.editY then
						x, y, w = self.db.profile.editX, self.db.profile.editY, self.db.profile.editW
					else
						x, y, w = frame:GetLeft(), frame:GetTop(), max(frame:GetWidth(), (frame:GetRight() or 0) - (frame:GetLeft() or 0))
					end
				end
				if not w or w < 10 then
					w = 100
				end
				frame:ClearAllPoints()
				if val ~= "FREE" then
					frame:SetMovable(false)
					frame.lDrag:EnableMouse(false)
					frame.rDrag:EnableMouse(false)
					frame:SetScript("OnMouseDown", nil)
					frame:SetScript("OnMouseUp", nil)
					frame.lDrag:EnableMouse(false)
					frame.rDrag:EnableMouse(false)
					frame.lDrag:SetScript("OnMouseDown", nil)
					frame.rDrag:SetScript("OnMouseDown", nil)
					frame.lDrag:SetScript("OnMouseUp", nil)
					frame.rDrag:SetScript("OnMouseUp", nil)
				end

				local scrollbarWidth = frame.chatFrame.ScrollBar and frame.chatFrame.ScrollBar:GetWidth() or 0
				if val == "TOP" then
					frame:SetPoint("BOTTOMLEFT", frame.chatFrame, "TOPLEFT", 0, 3)
					frame:SetPoint("BOTTOMRIGHT", frame.chatFrame, "TOPRIGHT", scrollbarWidth, 3)
				elseif val == "BOTTOM" then
					frame:SetPoint("TOPLEFT", frame.chatFrame, "BOTTOMLEFT", 0, -8)
					frame:SetPoint("TOPRIGHT", frame.chatFrame, "BOTTOMRIGHT", scrollbarWidth, -8)
				elseif val == "FREE" then
					frame:EnableMouse(true)
					frame:SetMovable(true)
					frame:SetResizable(true)
					frame:SetScript("OnMouseDown", startMoving)
					frame:SetScript("OnMouseUp", stopMoving)
					frame:SetWidth(w)
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
					local minWidth, minHeight = 40, 1
					if frame.SetResizeBounds then
						frame:SetResizeBounds(minWidth, minHeight)
					else
						frame:SetMinResize(minWidth, minHeight)
					end

					frame.lDrag:EnableMouse(true)
					frame.rDrag:EnableMouse(true)

					frame.lDrag:SetScript("OnMouseDown", startDragging)
					frame.rDrag:SetScript("OnMouseDown", startDragging)

					frame.lDrag:SetScript("OnMouseUp", stopDragging)
					frame.rDrag:SetScript("OnMouseUp", stopDragging)
				elseif val == "LOCK" then
					frame:SetWidth(self.db.profile.editW or w)
					frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", self.db.profile.editX or x, self.db.profile.editY or y)
				end
			end
		end
	end

	function module:UpdateHeight()
		for i, _ in ipairs(self.frames) do
			local ff = _G["ChatFrame" .. i .. "EditBox"]
			ff:SetHeight(module.db.profile.height)
		end
	end

	return
end) -- Prat:AddModuleToLoad
