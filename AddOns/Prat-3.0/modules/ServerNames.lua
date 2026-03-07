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
	local module = Prat:NewModule("ServerNames")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["ServerNames"] = true,
		["Server name abbreviation options."] = true,
		["randomclr_name"] = "Random Colors",
		["randomclr_desc"] = "Use a random color for each server.",
		["colon_name"] = "Show Colon",
		["colon_desc"] = "Toggle adding colon after server replacement.",
		["hide_name"] = "Hide Server",
		["hide_desc"] = "Never display the server name",
		["autoabbreviate_name"] = "Auto-abbreviate",
		["autoabbreviate_desc"] = "Shorten the server name to 3 letters",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
   do
	   local L


  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "Shorten the server name to 3 letters"
L["autoabbreviate_name"] = "Auto-abbreviate"
L["colon_desc"] = "Toggle adding colon after server replacement."
L["colon_name"] = "Show Colon"
L["hide_desc"] = "Never display the server name"
L["hide_name"] = "Hide Server"
L["randomclr_desc"] = "Use a random color for each server."
L["randomclr_name"] = "Random Colors"
L["Server name abbreviation options."] = true
L["ServerNames"] = true


	 PL:AddLocale("enUS",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "Raccourcir le nom des serveurs à 3 lettres."
L["autoabbreviate_name"] = "Abréviation"
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after server replacement."
--[[Translation missing --]]
L["colon_name"] = "Show Colon"
--[[Translation missing --]]
L["hide_desc"] = "Never display the server name"
--[[Translation missing --]]
L["hide_name"] = "Hide Server"
L["randomclr_desc"] = "Utiliser une couleur aléatoire pour chaque serveur."
L["randomclr_name"] = "Couleurs aléatoires"
L["Server name abbreviation options."] = "Options d'abréviation des noms de serveur."
L["ServerNames"] = "Noms de serveur"


	 PL:AddLocale("frFR",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "Kürze den Servernamen auf 3 Buchstaben"
L["autoabbreviate_name"] = "Automatisch abkürzen"
L["colon_desc"] = "Hinzufügen eines Doppelpunkts nach dem Ersetzen des Servers ein-/ausschalten."
L["colon_name"] = "Doppelpunkt anzeigen"
L["hide_desc"] = "Zeigt niemals den Servernamen an"
L["hide_name"] = "Server ausblenden"
L["randomclr_desc"] = "Eine zufällige Farbe für jeden Server verwenden."
L["randomclr_name"] = "Zufällige Farben"
L["Server name abbreviation options."] = "Abkürzungsoptionen für Servernamen."
L["ServerNames"] = "Servernamen"


	 PL:AddLocale("deDE",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "서버 이름을 3글자로 줄입니다"
L["autoabbreviate_name"] = "자동-줄임"
L["colon_desc"] = "서버 대체 이름 뒤에 콜론 추가 기능을 끄거나 켭니다."
L["colon_name"] = "콜론 표시"
L["hide_desc"] = "서버명 표시하지 않음"
L["hide_name"] = "서버 숨김"
L["randomclr_desc"] = "서버 이름에 무작위 색상을 사용합니다."
L["randomclr_name"] = "무작위 색상"
L["Server name abbreviation options."] = "서버 이름 줄이기 옵션입니다."
L["ServerNames"] = "서버 이름 [ServerNames]"


	 PL:AddLocale("koKR",L)



  L = {}
  -- ServerNames
--[[Translation missing --]]
L["autoabbreviate_desc"] = "Shorten the server name to 3 letters"
--[[Translation missing --]]
L["autoabbreviate_name"] = "Auto-abbreviate"
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after server replacement."
--[[Translation missing --]]
L["colon_name"] = "Show Colon"
--[[Translation missing --]]
L["hide_desc"] = "Never display the server name"
--[[Translation missing --]]
L["hide_name"] = "Hide Server"
--[[Translation missing --]]
L["randomclr_desc"] = "Use a random color for each server."
--[[Translation missing --]]
L["randomclr_name"] = "Random Colors"
--[[Translation missing --]]
L["Server name abbreviation options."] = "Server name abbreviation options."
--[[Translation missing --]]
L["ServerNames"] = "ServerNames"


	 PL:AddLocale("esMX",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "Сокращает название сервера до трех букв"
L["autoabbreviate_name"] = "Авто-сокращение"
L["colon_desc"] = "Вкл/Выкл добавление двоеточия после замещения сервера."
L["colon_name"] = "Показывать двоеточие"
L["hide_desc"] = "Никогда не отображать имя сервера"
L["hide_name"] = "Скрыть сервер"
L["randomclr_desc"] = "Использовать случайные цвета для всех серверов."
L["randomclr_name"] = "Случайные цвета"
L["Server name abbreviation options."] = "Настройки сокращений имен серверов."
L["ServerNames"] = "Названия серверов"


	 PL:AddLocale("ruRU",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "把服务器名缩到3个字符"
L["autoabbreviate_name"] = "自动缩写"
L["colon_desc"] = "在服务器后添加冒号"
L["colon_name"] = "显示冒号"
--[[Translation missing --]]
L["hide_desc"] = "Never display the server name"
--[[Translation missing --]]
L["hide_name"] = "Hide Server"
L["randomclr_desc"] = "为每个服务器使用随机颜色"
L["randomclr_name"] = "随机颜色"
L["Server name abbreviation options."] = "服务器名称缩写选项"
L["ServerNames"] = "服务器名称"


	 PL:AddLocale("zhCN",L)



  L = {}
  -- ServerNames
L["autoabbreviate_desc"] = "Acorta el nombre del servidor a 3 letras"
L["autoabbreviate_name"] = "Auto-abreviar"
L["colon_desc"] = "Alterna añadir dos puntos despues del servidor reemplazado."
L["colon_name"] = "Mostrar dos puntos"
--[[Translation missing --]]
L["hide_desc"] = "Never display the server name"
--[[Translation missing --]]
L["hide_name"] = "Hide Server"
L["randomclr_desc"] = "Utiliza un color aleatorio para cada servidor."
L["randomclr_name"] = "Colores Aleatorios"
L["Server name abbreviation options."] = "Opciones de la abreviatura del nombre del servidor."
L["ServerNames"] = "NombreServidor"


	 PL:AddLocale("esES",L)



  L = {}
  -- ServerNames
--[[Translation missing --]]
L["autoabbreviate_desc"] = "Shorten the server name to 3 letters"
L["autoabbreviate_name"] = "自動縮短"
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after server replacement."
L["colon_name"] = "顯示冒號"
--[[Translation missing --]]
L["hide_desc"] = "Never display the server name"
--[[Translation missing --]]
L["hide_name"] = "Hide Server"
L["randomclr_desc"] = "伺服器名稱使用隨機色彩"
L["randomclr_name"] = "隨機色彩"
L["Server name abbreviation options."] = "伺服器名稱縮寫選項"
L["ServerNames"] = "伺服器名稱"


	 PL:AddLocale("zhTW",L)


   end
   --@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			space = true,
			colon = true,
			autoabbreviate = true,
			hide = false,
			chanSave = {},
			serveropts = {
				["*"] = {
					replace = false,
					customcolor = false,
					shortname = "",
					color = {
						r = 0.65,
						g = 0.65,
						b = 0.65,
						a = 1,
					},
				},
			},
			randomclr = true,
		}
	})

	local serverPlugins = { servers = {} }

	Prat:SetModuleOptions(module.name, {
		name = PL["ServerNames"],
		desc = PL["Server name abbreviation options."],
		type = "group",
		plugins = serverPlugins,
		args = {
			hide = {
				type = "toggle",
				name = PL["hide_name"],
				desc = PL["hide_desc"],
			},
			autoabbreviate = {
				type = "toggle",
				name = PL["autoabbreviate_name"],
				desc = PL["autoabbreviate_desc"],
				order = 250,
				disabled = function(info)
					return info.handler.db.profile.hide
				end,
			},
			randomclr = {
				type = "toggle",
				name = PL["randomclr_name"],
				desc = PL["randomclr_desc"],
				order = 250,
				disabled = function(info)
					return info.handler.db.profile.hide
				end,
			}
		}
	})

	-- build the options menu using prat templates
	--module.toggleOptions = { optsep_sep = 240, randomclr = 250}
	--module.toggleOptions = { optsep_sep = 229, space = 230, colon = 240 }

	--local server_tags = {
	--    ["Normal"] = "(E)",
	--    ["PvP"] = "(P)",
	--    ["RP"] = "(R)",
	--    ["RP-PvP"] = "(PR)",
	--}
	--
	--local server_desctags = {
	--    ["Normal"] = "PvE",
	--    ["PvP"] = "PvP",
	--    ["RP"] = "RP",
	--    ["RP-PvP"] = "RPPvP",
	--}

	local CLR = Prat.CLR
	local function Server(server, text)
		return CLR:Colorize(module:GetServerCLR(server), text or server)
	end

	local KeyToFullNameMap = {}
	local FullNameToKeyMap = {}

	-- Get the key for the server specified, safe to pass this nil and "", if no key then it returns nil
	function module:GetServerKey(server)
		local key = FullNameToKeyMap[server]

		if key == nil then
			self:AddServer(server)

			key = FullNameToKeyMap[server]
		end

		return key
	end

	function module:AddServer(server)
		if server and strlen(server) > 0 then
			local key = server:gsub(" ", ""):lower()
			FullNameToKeyMap[server] = key
			KeyToFullNameMap[key] = KeyToFullNameMap[key] or server
		end
	end

	function module:GetServerSettings(serverKey)
		local opts = self.db.profile.serveropts[serverKey]
		if not opts then
			self.db.profile.serveropts[serverKey] = {}
			opts = self.db.profile.serveropts[serverKey]
		end

		return opts
	end

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --
	function module:OnModuleEnable()
		Prat.RegisterChatEvent(self, "Prat_PreAddMessage")
	end

	function module:OnModuleDisable()
		Prat.UnregisterAllChatEvents(self)
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:GetDescription()
		return PL["Server name abbreviation options."]
	end

	-- replace text using prat event implementation
	function module:Prat_PreAddMessage(_, m)
		local serverKey = self:GetServerKey(m.SERVER)
		local opts = serverKey and self:GetServerSettings(serverKey)

		if opts and opts.replace then
			m.SERVER = opts.shortname
		end

		if self.db.profile.hide then
			m.SERVER = ""
		end

		if m.SERVER and strlen(m.SERVER) > 0 then
			m.SERVER = self:FormatServer(m.SERVER, serverKey)
		end

		if not (m.SERVER and strlen(m.SERVER) > 0) then
			local s = Prat.SplitMessage
			s.SERVER, s.sS, s.Ss = "", "", ""
		end
	end

	function module:FormatServer(server, serverKey)
		if server == nil then
			server = KeyToFullNameMap[serverKey]
		elseif serverKey == nil then
			serverKey = self:GetServerKey(server)
		end

		if server == nil or serverKey == nil then
			return
		end

		if self.db.profile.autoabbreviate then
			server = server:match("^([%a\192-\255]?[\128-\191]*[%a\192-\255]?[\128-\191]*[%a\192-\255]?[\128-\191]*)")
		end

		return Server(serverKey, server)
	end

	local serverHashes = setmetatable({}, {
		__mode = "kv",
		__index = function(t, k)
			t[k] = CLR:GetHashColor(k)
			return
			t[k]
		end
	})
	local serverColors = setmetatable({}, {
		__mode = "kv",
		__index = function(t, k)
			t[k] = CLR:GetHexColor(k)
			return
			t[k]
		end
	})

	function module:GetServerCLR(server)
		local serverKey = self:GetServerKey(server)

		if serverKey then
			local opts = self:GetServerSettings(serverKey)

			if opts and opts.customcolor then
				return serverColors[opts.color]
			elseif self.db.profile.randomclr then
				return serverHashes[serverKey]
			end
		end

		return CLR.COLOR_NONE
	end
	return
end) -- Prat:AddModuleToLoad
