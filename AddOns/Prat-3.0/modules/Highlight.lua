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
	local module = Prat:NewModule("Highlight")
	local PL = module.PL

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			player = true,
			guild = true
		}
	})

	--[==[@debug@
	PL:AddLocale("enUS", {
		["module_name"] = "Highlight",
		["module_desc"] = "Highlight your own name, and various other text",
		["player_name"] = "Highlight Self",
		["player_desc"] = "Highlight you own name in a special color",
		["guild_name"] = "Highlight Guilds",
		["guild_desc"] = "Highlight things which looks like guild names"
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Highlight
L["guild_desc"] = "Highlight things which looks like guild names"
L["guild_name"] = "Highlight Guilds"
L["module_desc"] = "Highlight your own name, and various other text"
L["module_name"] = "Highlight"
L["player_desc"] = "Highlight you own name in a special color"
L["player_name"] = "Highlight Self"

  PL:AddLocale("enUS", L)



  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("itIT", L)



  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("ptBR", L)



  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("frFR", L)



  L = {}
  -- Highlight
L["guild_desc"] = "Markiert Dinge, die wie Gildennamen aussehen"
L["guild_name"] = "Markiert Gilden"
L["module_desc"] = "Markiert dein eigener Name und verschiedene andere Texte"
L["module_name"] = "Markierung"
L["player_desc"] = "Markiert deinen eigenen Namen in einer speziellen Farbe"
L["player_name"] = "Markiert dich selbst"

  PL:AddLocale("deDE", L)



  L = {}
  -- Highlight
L["guild_desc"] = "길드명처럼 보일 수 있게 강조"
L["guild_name"] = "길드 강조"
L["module_desc"] = "사용자 이름 및  기타 텍스트 강조하기"
L["module_name"] = "강조 [Highlight]"
L["player_desc"] = "자신의 이름을 특별한 색으로 강조"
L["player_name"] = "자신 강조"

  PL:AddLocale("koKR",  L)


  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("esMX",  L)


  L = {}
  -- Highlight
L["guild_desc"] = "Выделите вещи, похожие на названия гильдий"
L["guild_name"] = "Выделить гильдии"
L["module_desc"] = "Выделите свое имя и другой текст"
L["module_name"] = [=[Основной момент
]=]
L["player_desc"] = "Выделите свое имя специальным цветом"
L["player_name"] = "Выделить себя"

  PL:AddLocale("ruRU",  L)


  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
L["module_desc"] = "突出显示你自己的名字，以及各种其他文字"
L["module_name"] = "高亮度突显"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("zhCN",  L)


  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("esES",  L)


  L = {}
  -- Highlight
--[[Translation missing --]]
L["guild_desc"] = "Highlight things which looks like guild names"
--[[Translation missing --]]
L["guild_name"] = "Highlight Guilds"
--[[Translation missing --]]
L["module_desc"] = "Highlight your own name, and various other text"
--[[Translation missing --]]
L["module_name"] = "Highlight"
--[[Translation missing --]]
L["player_desc"] = "Highlight you own name in a special color"
--[[Translation missing --]]
L["player_name"] = "Highlight Self"

  PL:AddLocale("zhTW",  L)
  end
  --@end-non-debug@

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
		name = PL.module_name,
		desc = PL.module_desc,
		type = "group",
		args = {
			player = toggleOption,
			guild = toggleOption
		}
	})

	local CLR = Prat.CLR
	local function guildBracket(text)
		return CLR:Colorize("ffffff", text)
	end

	local function guildText(text)
		return CLR:Colorize("00ff00", text)
	end

	local function highlightPlayer(text)
		if module.db.profile.player then
			return Prat:RegisterMatch(CLR:Colorize("00ff00", text))
		end
	end

	local function highlightGuild(text)
		if module.db.profile.guild then
			return Prat:RegisterMatch(guildBracket("<") .. guildText(text) .. guildBracket(">"))
		end
	end

	Prat:SetModulePatterns(module, {
		{ pattern = Prat.GetNamePattern(UnitName("player")), matchfunc = highlightPlayer, priority = 47 },
		{ pattern = "<(..-)>", matchfunc = highlightGuild, priority = 49 },
	})
end)
