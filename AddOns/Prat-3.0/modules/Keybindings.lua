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
	local module = Prat:NewModule("KeyBindings")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		module_desc = "Adds chat related keybindings",
		["Prat Keybindings"] = true,
		["Officer Channel"] = true,
		["Guild Channel"] = true,
		["Party Channel"] = true,
		["Raid Channel"] = true,
		["Raid Warning Channel"] = true,
		["Instance Channel"] = true,
		["Say"] = true,
		["Yell"] = true,
		["Whisper"] = true,
		["Channel %d"] = true,
		["Prat TellTarget"] = true,
		["TellTarget"] = true,
		["Prat CopyChat"] = true,
		["Copy Selected Chat Frame"] = true,
		["Smart Group Channel"] = true,
		["Next Chat Tab"] = true
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
   do
	   local L


  L = {}
  -- KeyBindings
L["Channel %d"] = true
L["Copy Selected Chat Frame"] = true
L["Guild Channel"] = true
L["Instance Channel"] = true
L["module_desc"] = "Adds chat related keybindings"
L["Next Chat Tab"] = true
L["Officer Channel"] = true
L["Party Channel"] = true
L["Prat CopyChat"] = true
L["Prat Keybindings"] = true
L["Prat TellTarget"] = true
L["Raid Channel"] = true
L["Raid Warning Channel"] = true
L["Say"] = true
L["Smart Group Channel"] = true
L["TellTarget"] = true
L["Whisper"] = true
L["Yell"] = true


	 PL:AddLocale("enUS",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "Canal %d"
L["Copy Selected Chat Frame"] = "Copier la fenêtre de chat sélectionné"
L["Guild Channel"] = "Canal de Guilde"
L["Instance Channel"] = "Canal d'Instance"
--[[Translation missing --]]
L["module_desc"] = "Adds chat related keybindings"
--[[Translation missing --]]
L["Next Chat Tab"] = "Next Chat Tab"
L["Officer Channel"] = "Canal Officier"
L["Party Channel"] = "Canal de Groupe"
L["Prat CopyChat"] = "Prat Copier-le-Chat"
L["Prat Keybindings"] = "Prat Association-de-touche"
L["Prat TellTarget"] = "Prat Dire-à-la-cible"
L["Raid Channel"] = "Canal Raid"
L["Raid Warning Channel"] = "Canal Avertissement"
L["Say"] = "Dire"
--[[Translation missing --]]
L["Smart Group Channel"] = "Smart Group Channel"
L["TellTarget"] = "Chuchoter à la cible"
L["Whisper"] = "Chuchoter"
L["Yell"] = "Crier"


	 PL:AddLocale("frFR",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "Kanal %d"
L["Copy Selected Chat Frame"] = "Ausgewähltes Chatfenster kopieren"
L["Guild Channel"] = "Gildenkanal"
L["Instance Channel"] = "Instanzkanal"
L["module_desc"] = "Fügt chatbezogene Tastenbelegungen hinzu"
L["Next Chat Tab"] = "Nächster Chatreiter"
L["Officer Channel"] = "Offizierskanal"
L["Party Channel"] = "Gruppenkanal"
L["Prat CopyChat"] = "Prat Chat kopieren"
L["Prat Keybindings"] = true
L["Prat TellTarget"] = true
L["Raid Channel"] = "Schlachtzugskanal"
L["Raid Warning Channel"] = "Schlachtzugswarnkanal"
L["Say"] = true
L["Smart Group Channel"] = "Intelligenter Gruppenkanal"
L["TellTarget"] = true
L["Whisper"] = true
L["Yell"] = true


	 PL:AddLocale("deDE",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "채널 %d"
L["Copy Selected Chat Frame"] = "선택한 대화창 복사"
L["Guild Channel"] = "길드 채널"
L["Instance Channel"] = "인스턴스 채널"
L["module_desc"] = "채팅 관련 단축키 추가"
L["Next Chat Tab"] = "다음 대화 탭"
L["Officer Channel"] = "관리자 채널"
L["Party Channel"] = "파티 채널"
L["Prat CopyChat"] = "Prat 대화 복사"
L["Prat Keybindings"] = "Prat 단축키"
L["Prat TellTarget"] = "Prat 대상 대화"
L["Raid Channel"] = "공격대 채널"
L["Raid Warning Channel"] = "공격대 경보 채널"
L["Say"] = "일반 대화"
L["Smart Group Channel"] = "스마트 그룹 채널"
L["TellTarget"] = "대상 대화"
L["Whisper"] = "귓속말"
L["Yell"] = "외침"


	 PL:AddLocale("koKR",L)



  L = {}
  -- KeyBindings
--[[Translation missing --]]
L["Channel %d"] = "Channel %d"
--[[Translation missing --]]
L["Copy Selected Chat Frame"] = "Copy Selected Chat Frame"
--[[Translation missing --]]
L["Guild Channel"] = "Guild Channel"
--[[Translation missing --]]
L["Instance Channel"] = "Instance Channel"
--[[Translation missing --]]
L["module_desc"] = "Adds chat related keybindings"
--[[Translation missing --]]
L["Next Chat Tab"] = "Next Chat Tab"
--[[Translation missing --]]
L["Officer Channel"] = "Officer Channel"
--[[Translation missing --]]
L["Party Channel"] = "Party Channel"
--[[Translation missing --]]
L["Prat CopyChat"] = "Prat CopyChat"
--[[Translation missing --]]
L["Prat Keybindings"] = "Prat Keybindings"
--[[Translation missing --]]
L["Prat TellTarget"] = "Prat TellTarget"
--[[Translation missing --]]
L["Raid Channel"] = "Raid Channel"
--[[Translation missing --]]
L["Raid Warning Channel"] = "Raid Warning Channel"
--[[Translation missing --]]
L["Say"] = "Say"
--[[Translation missing --]]
L["Smart Group Channel"] = "Smart Group Channel"
--[[Translation missing --]]
L["TellTarget"] = "TellTarget"
--[[Translation missing --]]
L["Whisper"] = "Whisper"
--[[Translation missing --]]
L["Yell"] = "Yell"


	 PL:AddLocale("esMX",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "Канал %d"
L["Copy Selected Chat Frame"] = "Копирование выбранного окна чата"
L["Guild Channel"] = "Канал Гильдии"
L["Instance Channel"] = "Канал Подземелий"
L["module_desc"] = "Добавляет привязки к чату "
L["Next Chat Tab"] = "Следующее окно чата"
L["Officer Channel"] = "Офицерский Канал"
L["Party Channel"] = "Канал Группы"
L["Prat CopyChat"] = "Копирование чата Prat"
L["Prat Keybindings"] = true
L["Prat TellTarget"] = "Prat Сказать обьекту"
L["Raid Channel"] = "Канал Рейда"
L["Raid Warning Channel"] = "Канал объявлений рейду"
L["Say"] = "Сказать"
L["Smart Group Channel"] = "Групирование каналов"
L["TellTarget"] = "Сказать обьекту"
L["Whisper"] = "Шепнуть"
L["Yell"] = "Крикнуть"


	 PL:AddLocale("ruRU",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "频道 %d"
L["Copy Selected Chat Frame"] = "复制选定的聊天框体"
L["Guild Channel"] = "公会频道"
L["Instance Channel"] = "战场频道"
L["module_desc"] = "添加聊天关联的按键绑定"
L["Next Chat Tab"] = "下一个聊天标签"
L["Officer Channel"] = "官员频道"
L["Party Channel"] = "小队频道"
L["Prat CopyChat"] = "Prat聊天复制"
L["Prat Keybindings"] = "Prat键位绑定"
L["Prat TellTarget"] = "Prat目标告知"
L["Raid Channel"] = "团队频道"
L["Raid Warning Channel"] = "团队警告频道"
L["Say"] = "说"
L["Smart Group Channel"] = "频道智能分组"
L["TellTarget"] = "目标告知"
L["Whisper"] = "密语"
L["Yell"] = "喊话"


	 PL:AddLocale("zhCN",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "Canal %d"
L["Copy Selected Chat Frame"] = "Copiar el Marco de Chat Seleccionado"
L["Guild Channel"] = "Canal de Hermandad"
L["Instance Channel"] = "Canal Campo de Batalla"
--[[Translation missing --]]
L["module_desc"] = "Adds chat related keybindings"
L["Next Chat Tab"] = "Siguiente Pestaña de Chat"
L["Officer Channel"] = "Canal Oficial"
L["Party Channel"] = "Canal del Grupo"
L["Prat CopyChat"] = "Prat ChatCopiar"
L["Prat Keybindings"] = "Combinaciones de teclas Prat"
L["Prat TellTarget"] = "Prat DecirObjetivo"
L["Raid Channel"] = "Canal de Banda"
L["Raid Warning Channel"] = "Canal Aviso de Banda"
L["Say"] = "Decir"
L["Smart Group Channel"] = "Canal de Grupo Inteligente"
L["TellTarget"] = "DecirObjetivo"
L["Whisper"] = "Susurrar"
L["Yell"] = "Gritar"


	 PL:AddLocale("esES",L)



  L = {}
  -- KeyBindings
L["Channel %d"] = "頻道 %d"
L["Copy Selected Chat Frame"] = "複製選取的聊天視窗"
L["Guild Channel"] = "公會頻道"
L["Instance Channel"] = "戰場頻道"
--[[Translation missing --]]
L["module_desc"] = "Adds chat related keybindings"
L["Next Chat Tab"] = "次個聊天標籤"
L["Officer Channel"] = "幹部頻道"
L["Party Channel"] = "小隊頻道"
L["Prat CopyChat"] = "Prat 聊天複製"
L["Prat Keybindings"] = "Prat按鍵綁定"
L["Prat TellTarget"] = true
L["Raid Channel"] = "團隊頻道"
L["Raid Warning Channel"] = "團隊警告頻道"
L["Say"] = "說"
L["Smart Group Channel"] = "按鍵綁定"
L["TellTarget"] = true
L["Whisper"] = "密語"
L["Yell"] = "大喊"


	 PL:AddLocale("zhTW",L)


   end
   --@end-non-debug@

	Prat:SetModuleInit(module,
		function()
			BINDING_HEADER_Prat = PL["Prat Keybindings"]
			BINDING_NAME_officer = PL["Officer Channel"]
			BINDING_NAME_guild = PL["Guild Channel"]
			BINDING_NAME_party = PL["Party Channel"]
			BINDING_NAME_raid = PL["Raid Channel"]
			BINDING_NAME_raidwarn = PL["Raid Warning Channel"]
			BINDING_NAME_instance = PL["Instance Channel"]
			BINDING_NAME_say = PL["Say"]
			BINDING_NAME_yell = PL["Yell"]
			BINDING_NAME_whisper = PL["Whisper"]
			BINDING_NAME_one = (PL["Channel %d"]):format(1)
			BINDING_NAME_two = (PL["Channel %d"]):format(2)
			BINDING_NAME_three = (PL["Channel %d"]):format(3)
			BINDING_NAME_four = (PL["Channel %d"]):format(4)
			BINDING_NAME_five = (PL["Channel %d"]):format(5)
			BINDING_NAME_six = (PL["Channel %d"]):format(6)
			BINDING_NAME_seven = (PL["Channel %d"]):format(7)
			BINDING_NAME_eight = (PL["Channel %d"]):format(8)
			BINDING_NAME_nine = (PL["Channel %d"]):format(9)
			BINDING_NAME_SmartGroup = PL["Smart Group Channel"]
			--	    BINDING_HEADER_Prat_TellTarget = PL["Prat TellTarget"]
			--	    BINDING_HEADER_Prat_CopyChat = PL["Prat CopyChat"]
			BINDING_NAME_NextTab = PL["Next Chat Tab"]
			BINDING_NAME_CopySelected = PL["Copy Selected Chat Frame"]
		end)

	-- /script keybindings:CycleChatTabs()
	function module:CycleChatTabs()
		local current = FCFDock_GetSelectedWindow(GENERAL_CHAT_DOCK)
		local idx
		local dockedFrames = FCFDock_GetChatFrames(GENERAL_CHAT_DOCK)

		for i, v in ipairs(dockedFrames) do
			if v == current then
				idx = i
			end
		end

		if idx == nil then
			return
		end

		idx = idx + 1
		if dockedFrames[idx] == nil then
			idx = 1
		end

		FCFDock_SelectWindow(GENERAL_CHAT_DOCK, dockedFrames[idx])
	end

	return
end) -- Prat:AddModuleToLoad
