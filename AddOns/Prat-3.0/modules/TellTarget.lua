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

local ChatFrame_SendTell = _G.ChatFrame_SendTell or _G.ChatFrameUtil.SendTell
local ChatEdit_UpdateHeader = _G.ChatEdit_UpdateHeader or _G.ChatFrameEditBoxMixin.UpdateHeader

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("TellTarget", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["TellTarget"] = true,
		["Adds telltarget slash command (/tt)."] = true,
		["Target does not exist."] = true,
		["Target is not a player."] = true,
		["No target selected."] = true,
		["NoTarget"] = true,
		["/tt"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = true
L["No target selected."] = true
L["NoTarget"] = true
L["Target does not exist."] = true
L["Target is not a player."] = true
L["TellTarget"] = true

		PL:AddLocale("enUS",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "Ajoute la commande telltarget (/tt) pour envoyer un message privé au joueur ciblé."
L["No target selected."] = "Pas de cible sélectionnée."
L["NoTarget"] = "PasDeCible"
L["Target does not exist."] = "La cible n'existe pas."
L["Target is not a player."] = "La cible n'est pas un joueur."
L["TellTarget"] = true

		PL:AddLocale("frFR",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "Fügt den Slash-Befehl Ziel Sagen (/tt) hinzu."
L["No target selected."] = "Kein Ziel ausgewählt."
L["NoTarget"] = "KeinZiel"
L["Target does not exist."] = "Ziel existiert nicht."
L["Target is not a player."] = "Ziel ist kein Spieler."
L["TellTarget"] = "Ziel Sagen"

		PL:AddLocale("deDE",L)

		L = {}
-- TellTarget
L["/tt"] = "/ㅅㅅ"
L["Adds telltarget slash command (/tt)."] = "대상에게 말하기 슬래쉬 명령어를 추가합니다 (/tt)."
L["No target selected."] = "대상이 선택되지 않았습니다."
L["NoTarget"] = "대상 없음"
L["Target does not exist."] = "대상이 존재하지 않습니다."
L["Target is not a player."] = "대상이 플레이어가 아닙니다."
L["TellTarget"] = "대상에게 말하기"

		PL:AddLocale("koKR",L)

		L = {}
-- TellTarget
--[[Translation missing --]]
L["/tt"] = "/tt"
--[[Translation missing --]]
L["Adds telltarget slash command (/tt)."] = "Adds telltarget slash command (/tt)."
--[[Translation missing --]]
L["No target selected."] = "No target selected."
--[[Translation missing --]]
L["NoTarget"] = "NoTarget"
--[[Translation missing --]]
L["Target does not exist."] = "Target does not exist."
--[[Translation missing --]]
L["Target is not a player."] = "Target is not a player."
--[[Translation missing --]]
L["TellTarget"] = "TellTarget"

		PL:AddLocale("esMX",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "Добавляет слеш-команду 'сказать о цели' (/tt)."
L["No target selected."] = "Нет выбранной цели."
L["NoTarget"] = "Нет цели"
L["Target does not exist."] = "Цель не существует."
L["Target is not a player."] = "Выбранная цель не является игроком."
L["TellTarget"] = "Сказать цели"

		PL:AddLocale("ruRU",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "添加目标告知斜杠命令(/tt)."
L["No target selected."] = "无目标被选取"
L["NoTarget"] = "无目标"
L["Target does not exist."] = "目标不存在"
L["Target is not a player."] = "目标不是一个玩家"
L["TellTarget"] = "告知目标"

		PL:AddLocale("zhCN",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "Añade comando decir a objetivo (/tt)."
L["No target selected."] = "Sin objetivo seleccionado."
L["NoTarget"] = "SinObjetivo"
L["Target does not exist."] = "El Objetivo no existe."
L["Target is not a player."] = "El Objetivo no es un jugador."
L["TellTarget"] = "DecirObjetivo"

		PL:AddLocale("esES",L)

		L = {}
-- TellTarget
L["/tt"] = true
L["Adds telltarget slash command (/tt)."] = "新增 telltarget 快捷命令（/tt）"
L["No target selected."] = "未選取目標"
L["NoTarget"] = "沒有目標"
L["Target does not exist."] = "目標並不存在"
L["Target is not a player."] = "目標並不是玩家"
L["TellTarget"] = true

		PL:AddLocale("zhTW",L)
	end
	--@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["TellTarget"],
		desc = PL["Adds telltarget slash command (/tt)."],
		type = "group",
		args = {
			info = {
				name = PL["Adds telltarget slash command (/tt)."],
				type = "description",
			}
		}
	})

	function module:OnModuleEnable()
		self:SecureHookScript(_G.ChatFrame1EditBox, "OnTextChanged")
	end

	function module:OnModuleDisable()
		self:UnhookAll()
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:GetDescription()
		return PL["Adds telltarget slash command (/tt)."]
	end

	function module:OnTextChanged(editBox)
		local command, msg = editBox:GetText():match("^(/%S+)%s(.*)$")
		if command == "/tt" or command == PL["/tt"] then
			self:SendTellToTarget(editBox.chatFrame, msg, editBox)
		end
	end

	function module:SendTellToTarget(frame, text, editBox)
		if frame == nil then
			frame = DEFAULT_CHAT_FRAME
		end

		local unitname, realm, fullname
		if UnitIsPlayer("target") then
			unitname, realm = UnitName("target")
			if unitname then
				if realm and UnitRealmRelationship("target") ~= LE_REALM_RELATION_SAME then
					fullname = unitname .. "-" .. realm
				else
					fullname = unitname
				end
			end
		end

		local target = fullname and fullname:gsub(" ", "") or PL["NoTarget"]

		if editBox then
			editBox:SetAttribute("chatType", "WHISPER")
			editBox:SetAttribute("tellTarget", target)
			editBox:SetText(text)
			ChatEdit_UpdateHeader(editBox)
		else
			ChatFrame_SendTell(target, frame)
		end
	end

	return
end)
