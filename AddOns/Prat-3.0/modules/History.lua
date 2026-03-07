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
	local module = Prat:NewModule("History", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["History"] = true,
		["Chat history options."] = true,
		["Set Chat Lines"] = true,
		["Set the number of lines of chat history for each window."] = true,
		["Set Command History"] = true,
		["Maximum number of lines of command history to save."] = true,
		["Save Command History"] = true,
		["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true,
		["Scrollback"] = true,
		["Store the chat lines between sessions"] = true,
		["Scrollback Options"] = true,
		["Command History Options"] = true,
		divider = "========== End of Scrollback ==========",
		scrollbackduration_name = "Scrollback Duration",
		scrollbackduration_desc = "How many hours to keep the saved messages.",
		["Colors the GMOTD label"] = true,
		["Color GMOTD"] = true,
		delaygmotd_name = "Delay GMOTD",
		delaygmotd_desc = "Delay GMOTD until after all the startup spam",
		bnet_removed = "<BNET REMOVED>",
		removespam_name = "Remove Spam",
		removespam_desc = "Remove addon spam messages when restoring the chat history"
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
   do
	   local L


  L = {}
  -- History
L["bnet_removed"] = "<BNET REMOVED>"
L["Chat history options."] = true
L["Color GMOTD"] = true
L["Colors the GMOTD label"] = true
L["Command History Options"] = true
L["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam"
L["delaygmotd_name"] = "Delay GMOTD"
L["divider"] = "========== End of Scrollback =========="
L["History"] = true
L["Maximum number of lines of command history to save."] = true
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
L["removespam_name"] = "Remove Spam"
L["Save Command History"] = true
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = true
L["Scrollback"] = true
L["Scrollback Options"] = true
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
L["scrollbackduration_name"] = "Scrollback Duration"
L["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer."
L["scrollbacklen_name"] = "Scrollback Length"
L["Set Chat Lines"] = true
L["Set Command History"] = true
L["Set the number of lines of chat history for each window."] = true
L["storage_char"] = "Character"
L["storage_desc"] = "Which location should the history be saved to."
L["storage_name"] = "Save To"
L["storage_server"] = "Server"
L["Store the chat lines between sessions"] = true


	 PL:AddLocale("enUS",L)


  L = {}
  -- History
--[[Translation missing --]]
L["bnet_removed"] = "<BNET REMOVED>"
L["Chat history options."] = "Option de l'historique."
--[[Translation missing --]]
L["Color GMOTD"] = "Color GMOTD"
--[[Translation missing --]]
L["Colors the GMOTD label"] = "Colors the GMOTD label"
--[[Translation missing --]]
L["Command History Options"] = "Command History Options"
L["delaygmotd_desc"] = "Afficher le message du jour de la guilde après tous les autres messages lors de la connexion."
--[[Translation missing --]]
L["delaygmotd_name"] = "Delay GMOTD"
L["divider"] = "========== Fin de l'historique =========="
L["History"] = "Historique"
L["Maximum number of lines of command history to save."] = "Nombre maximum de lignes de commande à sauvegarder dans l'historique."
--[[Translation missing --]]
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
--[[Translation missing --]]
L["removespam_name"] = "Remove Spam"
L["Save Command History"] = "Historique de commandes"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Sauvegarde l'historique des commandes entre les sessions (à utiliser avec alt+haut ou juste haut)"
--[[Translation missing --]]
L["Scrollback"] = "Scrollback"
--[[Translation missing --]]
L["Scrollback Options"] = "Scrollback Options"
--[[Translation missing --]]
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
--[[Translation missing --]]
L["scrollbackduration_name"] = "Scrollback Duration"
L["scrollbacklen_desc"] = "Nombre de lignes de discussions à sauvegarder dans l'historique."
L["scrollbacklen_name"] = "Taille de l'historique"
L["Set Chat Lines"] = "Historique de discussions"
L["Set Command History"] = "Historique de commandes"
L["Set the number of lines of chat history for each window."] = "Définit le nombre de lignes dans l'historique pour chaque fenêtre."
--[[Translation missing --]]
L["storage_char"] = "Character"
--[[Translation missing --]]
L["storage_desc"] = "Which location should the history be saved to."
--[[Translation missing --]]
L["storage_name"] = "Save To"
--[[Translation missing --]]
L["storage_server"] = "Server"
L["Store the chat lines between sessions"] = "Sauvegarder l'historique des discussions entre les sessions."


	 PL:AddLocale("frFR",L)


  L = {}
  -- History
L["bnet_removed"] = "<BNET ENTFERNT>"
L["Chat history options."] = "Optionen zum Chatverlauf."
L["Color GMOTD"] = "Farbe der Gildennachricht des Tages"
L["Colors the GMOTD label"] = "Färbt die Gildennachricht des Tages-Beschriftung"
L["Command History Options"] = "Befehlsverlaufsoptionen"
L["delaygmotd_desc"] = "GMOTD verzögern, bis die Ausgabe aller Mitteilungen nach dem Einloggen vollendet ist."
L["delaygmotd_name"] = "GMOTD verzögern"
L["divider"] = "========== Ende des Zurückblättern =========="
L["History"] = "Verlauf"
L["Maximum number of lines of command history to save."] = "Maximal zu speichernde Zeilenanzahl des Befehlsverlaufs."
L["removespam_desc"] = "Entfernt Addon Spam-Nachrichten, wenn du den Chat-Verlauf wiederherstellst"
L["removespam_name"] = "Spam entfernen"
L["Save Command History"] = "Befehlsverlauf speichern"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Speichert Befehlsverlauf zwischen Sitzungen (um mit Alt + \"Pfeil nach oben\" oder nur \"Pfeil nach oben\" verwendet zu werden)."
L["Scrollback"] = "Zurückblättern"
L["Scrollback Options"] = "Optionen für das Zurückblättern"
L["scrollbackduration_desc"] = "Wie viele Stunden, um die gespeicherten Nachrichten zu speichern."
L["scrollbackduration_name"] = "Dauer vom Zurückblättern"
L["scrollbacklen_desc"] = "Anzahl der Chat-Zeilen, die im Zurückblättern Puffer gespeichert werden sollen."
L["scrollbacklen_name"] = "Länge vom Zurückblättern"
L["Set Chat Lines"] = "Chatzeilen einstellen"
L["Set Command History"] = "Befehlsverlauf einstellen"
L["Set the number of lines of chat history for each window."] = "Die Zeilenanzahl des Chatverlaufs für jedes Fenster einstellen."
L["storage_char"] = "Charakter"
L["storage_desc"] = "An welchem Ort soll der Verlauf gespeichert werden?"
L["storage_name"] = "Speichern unter"
L["storage_server"] = "Server"
L["Store the chat lines between sessions"] = "Speichert die Chat-Zeilen zwischen den Sitzungen"


	 PL:AddLocale("deDE",L)


  L = {}
  -- History
L["bnet_removed"] = "<베틀넷 제거됨>"
L["Chat history options."] = "대화 내역 옵션입니다."
L["Color GMOTD"] = "오늘의 길드 메시지에 색상입히기"
L["Colors the GMOTD label"] = "오늘의 길드 메시지 제목에 색상입히기"
L["Command History Options"] = "명령어 내역 옵션"
L["delaygmotd_desc"] = "모든 시작 스팸이 표시 될때까지 오늘의 길드 메시지 지연시키기"
L["delaygmotd_name"] = "오늘의 길드 메시지 지연"
L["divider"] = "========== 이전 대화 목록의 끝 =========="
L["History"] = "내역 [History]"
L["Maximum number of lines of command history to save."] = "저장할 명령어 내역의 최대 갯수입니다."
L["removespam_desc"] = "채팅 기록을 복원 할 때 애드온 스팸 메시지 제거"
L["removespam_name"] = "스팸 제거"
L["Save Command History"] = "명령어 내역 저장"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "세션 간 명령어 내역을 저장합니다 (Alt+위 화살표나 위 화살표로 사용하는)"
L["Scrollback"] = "스크롤백"
L["Scrollback Options"] = "스크롤백 옵션"
L["scrollbackduration_desc"] = "저장된 메시지를 보관할 시간."
L["scrollbackduration_name"] = "스크롤백 구간"
L["scrollbacklen_desc"] = "스크롤백 저장소에 저장할 대화 줄의 숫자입니다."
L["scrollbacklen_name"] = "스크롤백 길이"
L["Set Chat Lines"] = "대화 내역 설정"
L["Set Command History"] = "명령어 내역 설정"
L["Set the number of lines of chat history for each window."] = "각 대화창 별로 대화 내역의 줄의 갯수를 설정합니다."
L["storage_char"] = "캐릭터"
L["storage_desc"] = "기록을 저장할 위치"
L["storage_name"] = "저장"
L["storage_server"] = "서버"
L["Store the chat lines between sessions"] = "세션 간 대화 내용 저장하기"


	 PL:AddLocale("koKR",L)


  L = {}
  -- History
--[[Translation missing --]]
L["bnet_removed"] = "<BNET REMOVED>"
--[[Translation missing --]]
L["Chat history options."] = "Chat history options."
--[[Translation missing --]]
L["Color GMOTD"] = "Color GMOTD"
--[[Translation missing --]]
L["Colors the GMOTD label"] = "Colors the GMOTD label"
--[[Translation missing --]]
L["Command History Options"] = "Command History Options"
--[[Translation missing --]]
L["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam"
--[[Translation missing --]]
L["delaygmotd_name"] = "Delay GMOTD"
--[[Translation missing --]]
L["divider"] = "========== End of Scrollback =========="
--[[Translation missing --]]
L["History"] = "History"
--[[Translation missing --]]
L["Maximum number of lines of command history to save."] = "Maximum number of lines of command history to save."
--[[Translation missing --]]
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
--[[Translation missing --]]
L["removespam_name"] = "Remove Spam"
--[[Translation missing --]]
L["Save Command History"] = "Save Command History"
--[[Translation missing --]]
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Saves command history between sessions (for use with alt+up arrow or just the up arrow)"
--[[Translation missing --]]
L["Scrollback"] = "Scrollback"
--[[Translation missing --]]
L["Scrollback Options"] = "Scrollback Options"
--[[Translation missing --]]
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
--[[Translation missing --]]
L["scrollbackduration_name"] = "Scrollback Duration"
--[[Translation missing --]]
L["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer."
--[[Translation missing --]]
L["scrollbacklen_name"] = "Scrollback Length"
--[[Translation missing --]]
L["Set Chat Lines"] = "Set Chat Lines"
--[[Translation missing --]]
L["Set Command History"] = "Set Command History"
--[[Translation missing --]]
L["Set the number of lines of chat history for each window."] = "Set the number of lines of chat history for each window."
--[[Translation missing --]]
L["storage_char"] = "Character"
--[[Translation missing --]]
L["storage_desc"] = "Which location should the history be saved to."
--[[Translation missing --]]
L["storage_name"] = "Save To"
--[[Translation missing --]]
L["storage_server"] = "Server"
--[[Translation missing --]]
L["Store the chat lines between sessions"] = "Store the chat lines between sessions"


	 PL:AddLocale("esMX",L)


  L = {}
  -- History
L["bnet_removed"] = "<BNET УДАЛЕН>"
L["Chat history options."] = "Настройки истории чата."
L["Color GMOTD"] = "Цвет  GMOTD"
L["Colors the GMOTD label"] = "Цвета названия СДГ"
L["Command History Options"] = "Параметры истории команд"
L["delaygmotd_desc"] = "Задерживать отображение СДГ вплоть до окончания спама при входе в игру"
L["delaygmotd_name"] = "задержка GMOTD"
L["divider"] = "========== Конец истории сообщений =========="
L["History"] = "История"
L["Maximum number of lines of command history to save."] = "Максимальное число строк сохранённых в истории команд."
L["removespam_desc"] = "Удалять спам-сообщения аддона при восстановлении истории чата"
L["removespam_name"] = "Удалить спам"
L["Save Command History"] = "Сохранять историю команд"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Сохранять историю команд между сеансами (для использования используйте alt+ стрелка вверх или просто стрелку вверх)"
L["Scrollback"] = "История сообщений"
L["Scrollback Options"] = "Вернуть опции"
L["scrollbackduration_desc"] = "Сколько часов хранить сохраненные сообщения."
L["scrollbackduration_name"] = "Длительность прокрутки"
L["scrollbacklen_desc"] = "Количество строк чата, которое надо сохранять в буфере истории сообщений."
L["scrollbacklen_name"] = "Длина истории сообщений"
L["Set Chat Lines"] = "Задать число строк чата"
L["Set Command History"] = "История команд"
L["Set the number of lines of chat history for each window."] = "Установите число строк истории чата для всех окон чата."
L["storage_char"] = "Персонаж"
L["storage_desc"] = "В какое место следует сохранять историю."
L["storage_name"] = "Сохранить В"
L["storage_server"] = "Сервер "
L["Store the chat lines between sessions"] = "Сохранять строки чата между сессиями"


	 PL:AddLocale("ruRU",L)


  L = {}
  -- History
--[[Translation missing --]]
L["bnet_removed"] = "<BNET REMOVED>"
L["Chat history options."] = "历史聊天记录选项"
L["Color GMOTD"] = "每日公会信息颜色"
L["Colors the GMOTD label"] = "为每日公会信息标签着色"
--[[Translation missing --]]
L["Command History Options"] = "Command History Options"
L["delaygmotd_desc"] = "延迟每日公会信息直到起始垃圾信息显示完毕为止"
L["delaygmotd_name"] = "延迟 GMOTD"
L["divider"] = "========== 回卷结束 =========="
L["History"] = "历史记录"
L["Maximum number of lines of command history to save."] = "存储命令记录最大行数"
--[[Translation missing --]]
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
--[[Translation missing --]]
L["removespam_name"] = "Remove Spam"
L["Save Command History"] = "命令记录存储"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "存储会话之间命令的历史记录(使用alt+上箭头键或仅上箭头键)"
L["Scrollback"] = "回卷"
L["Scrollback Options"] = "回滚选项"
--[[Translation missing --]]
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
--[[Translation missing --]]
L["scrollbackduration_name"] = "Scrollback Duration"
L["scrollbacklen_desc"] = "聊天内容回滚缓冲数量"
L["scrollbacklen_name"] = "回卷长度"
L["Set Chat Lines"] = "聊天行设置"
L["Set Command History"] = "命令历史记录"
L["Set the number of lines of chat history for each window."] = "为每个聊天窗口设置聊天历史记录行数"
--[[Translation missing --]]
L["storage_char"] = "Character"
--[[Translation missing --]]
L["storage_desc"] = "Which location should the history be saved to."
--[[Translation missing --]]
L["storage_name"] = "Save To"
--[[Translation missing --]]
L["storage_server"] = "Server"
L["Store the chat lines between sessions"] = "在会话之间存储聊天内容"


	 PL:AddLocale("zhCN",L)


  L = {}
  -- History
--[[Translation missing --]]
L["bnet_removed"] = "<BNET REMOVED>"
L["Chat history options."] = "Opciones del historial del chat."
--[[Translation missing --]]
L["Color GMOTD"] = "Color GMOTD"
--[[Translation missing --]]
L["Colors the GMOTD label"] = "Colors the GMOTD label"
--[[Translation missing --]]
L["Command History Options"] = "Command History Options"
--[[Translation missing --]]
L["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam"
--[[Translation missing --]]
L["delaygmotd_name"] = "Delay GMOTD"
L["divider"] = "========== Fin del Registro =========="
L["History"] = "Historial"
L["Maximum number of lines of command history to save."] = "Máximo número de líneas a guardar por el comando historial."
--[[Translation missing --]]
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
--[[Translation missing --]]
L["removespam_name"] = "Remove Spam"
L["Save Command History"] = "Comando Guardar Historial"
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Guarda el historial de comandos entre sesiones (para utilizar con alt+flecha arriba o sólo la flecha arriba)"
--[[Translation missing --]]
L["Scrollback"] = "Scrollback"
--[[Translation missing --]]
L["Scrollback Options"] = "Scrollback Options"
--[[Translation missing --]]
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
--[[Translation missing --]]
L["scrollbackduration_name"] = "Scrollback Duration"
--[[Translation missing --]]
L["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer."
--[[Translation missing --]]
L["scrollbacklen_name"] = "Scrollback Length"
L["Set Chat Lines"] = "Establecer Líneas de Chat"
L["Set Command History"] = "Establecer Historial de Comandos"
L["Set the number of lines of chat history for each window."] = "Establece el número de líneas del historial de chat para cada ventana."
--[[Translation missing --]]
L["storage_char"] = "Character"
--[[Translation missing --]]
L["storage_desc"] = "Which location should the history be saved to."
--[[Translation missing --]]
L["storage_name"] = "Save To"
--[[Translation missing --]]
L["storage_server"] = "Server"
--[[Translation missing --]]
L["Store the chat lines between sessions"] = "Store the chat lines between sessions"


	 PL:AddLocale("esES",L)


  L = {}
  -- History
--[[Translation missing --]]
L["bnet_removed"] = "<BNET REMOVED>"
L["Chat history options."] = "歷史訊息選項。"
L["Color GMOTD"] = "顏色 GMOTD"
L["Colors the GMOTD label"] = "顏色 GMOTD 標籤"
--[[Translation missing --]]
L["Command History Options"] = "Command History Options"
--[[Translation missing --]]
L["delaygmotd_desc"] = "Delay GMOTD until after all the startup spam"
L["delaygmotd_name"] = "延遲 GMOTD"
L["divider"] = "========== 捲動結束 =========="
L["History"] = "歷史訊息"
L["Maximum number of lines of command history to save."] = "最大行數的指令記錄儲存。"
--[[Translation missing --]]
L["removespam_desc"] = "Remove addon spam messages when restoring the chat history"
--[[Translation missing --]]
L["removespam_name"] = "Remove Spam"
L["Save Command History"] = "儲存指令歷史"
--[[Translation missing --]]
L["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"] = "Saves command history between sessions (for use with alt+up arrow or just the up arrow)"
L["Scrollback"] = "捲動"
L["Scrollback Options"] = "捲動選項"
--[[Translation missing --]]
L["scrollbackduration_desc"] = "How many hours to keep the saved messages."
--[[Translation missing --]]
L["scrollbackduration_name"] = "Scrollback Duration"
--[[Translation missing --]]
L["scrollbacklen_desc"] = "Number of chatlines to save in the scrollback buffer."
L["scrollbacklen_name"] = "捲動長度"
L["Set Chat Lines"] = "設定聊天行數"
L["Set Command History"] = "設定指令歷史"
L["Set the number of lines of chat history for each window."] = "設定行數的聊天記錄每個視窗。"
--[[Translation missing --]]
L["storage_char"] = "Character"
--[[Translation missing --]]
L["storage_desc"] = "Which location should the history be saved to."
--[[Translation missing --]]
L["storage_name"] = "Save To"
--[[Translation missing --]]
L["storage_server"] = "Server"
--[[Translation missing --]]
L["Store the chat lines between sessions"] = "Store the chat lines between sessions"


	 PL:AddLocale("zhTW",L)
   end
   --@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			chatlinesframes = {},
			chatlines = 384,
			maxlines = 50,
			scrollbackduration = 24,
			savehistory = false,
			scrollback = true,
			removespam = true,
			colorgmotd = true,
			delaygmotd = true,
		}
	})

	module.pluginopts = {}

	Prat:SetModuleOptions(module.name, {
		name = PL["History"],
		desc = PL["Chat history options."],
		type = "group",
		plugins = module.pluginopts,
		args = {
			chatlinesframes = {
				name = PL["Set Chat Lines"],
				desc = PL["Set the number of lines of chat history for each window."],
				type = "multiselect",
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			chatlines = {
				name = PL["Set Chat Lines"],
				desc = PL["Set the number of lines of chat history for each window."],
				type = "range",
				order = 120,
				min = 300,
				max = 5000,
				step = 10,
				bigStep = 50,
			},
			cmdhistheader = {
				name = PL["Command History Options"],
				type = "header",
				order = 130,
			},
			maxlines = {
				name = PL["Set Command History"],
				desc = PL["Maximum number of lines of command history to save."],
				type = "range",
				order = 132,
				min = 0,
				max = 500,
				step = 10,
				bigStep = 50,
				disabled = function()
					return not module.db.profile.savehistory
				end
			},
			savehistory = {
				name = PL["Save Command History"],
				desc = PL["Saves command history between sessions (for use with alt+up arrow or just the up arrow)"],
				type = "toggle",
				order = 131,
			},
			--      colorgmotd = {
			--        name = PL["Color GMOTD"],
			--        desc = PL["Colors the GMOTD label"],
			--        type = "toggle",
			--        order = 150,
			--      },
			--      delaygmotd = {
			--        name = PL.delaygmotd_name,
			--        desc = PL.delaygmotd_desc,
			--        type = "toggle",
			--        order = 151
			--      }
		}
	})

	local function applyEditBox(func)
		for i = 1, NUM_CHAT_WINDOWS do
			local f = _G["ChatFrame" .. i .. "EditBox"]
			func(f)
		end
	end

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	-- things to do when the module is enabled
	function module:OnModuleEnable()


		Prat3CharDB = Prat3CharDB or {}
		Prat3CharDB.history = Prat3CharDB.history or {}
		Prat3CharDB.history.cmdhistory = Prat3CharDB.history.cmdhistory or {}

		for i, v in ipairs(Prat3CharDB.history.cmdhistory) do
			if (type(v) == "string" and v:sub(1, 9) ~= "ChatFrame") then
				Prat3CharDB.history.cmdhistory[i] = nil
			end
		end

		applyEditBox(function(edit)
			local name = edit:GetName()
			Prat3CharDB.history.cmdhistory[name] = Prat3CharDB.history.cmdhistory[name] or {}
		end)

		self:ConfigureAllChatFrames()

		for k in pairs(Prat3CharDB.history.cmdhistory) do
			local edit = _G[k]
			if (edit) then
				self:SecureHook(edit, "AddHistoryLine")
				if self.db.profile.savehistory then
					self:addSavedHistory(edit)
				end
				self:SecureHook(edit, "ClearHistory")
			end
		end


		-- Clean out any old data
		if self.db.profile.cmdhistory then
			self.db.profile.cmdhistory = nil
		end
	end

	function module:GetDescription()
		return PL["Chat history options."]
	end

	-- things to do when the module is enabled
	function module:OnModuleDisable()
		self:ConfigureAllChatFrames(384)
	end

	function module:ConfigureAllChatFrames(lines)
		lines = lines or self.db.profile.chatlines

		for k, _ in pairs(self.db.profile.chatlinesframes) do
			self:SetHistory(_G[k], lines)
		end

		for k in pairs(Prat3CharDB.history.cmdhistory) do
			local edit = _G[k]
			if (edit) then
				if self.db.profile.savehistory then
					edit:SetHistoryLines(self.db.profile.maxlines)
					edit.history_lines = Prat3CharDB.history.cmdhistory[k]
				else
					edit.history_lines = {}
				end
				edit.history_index = 0
			end
		end
	end

	function module:OnSubvalueChanged()
		self:ConfigureAllChatFrames()
	end

	function module:OnValueChanged()
		self:ConfigureAllChatFrames()
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:SetHistory(f, lines)
		if f == nil then
			return
		end

		f:SetMaxLines(lines)
	end

	function module:addSavedHistory(editBox)
		editBox = editBox or ChatFrame1EditBox
		local cmdhistory = Prat3CharDB.history.cmdhistory[editBox:GetName()] or {}
		local cmdindex = #cmdhistory

		-- where there"s a while, there"s a way
		while cmdindex > 0 do
			editBox:AddHistoryLine(cmdhistory[cmdindex])
			cmdindex = cmdindex - 1
			-- way
		end
	end

	function module:saveLine(text, editBox)
		if not text or (text == "") then
			return false
		end

		local maxlines = self.db.profile.maxlines
		local cmdhistory = editBox.history_lines or {}

		if cmdhistory[1] == text then
			return
		end

		table.insert(cmdhistory, 1, text)

		local cmdcount = #cmdhistory - maxlines
		while cmdcount > 0 do
			table.remove(cmdhistory)
			cmdcount = cmdcount - 1
		end
	end

	function module:ClearHistory(editBox)
		editBox = editBox or ChatFrame1EditBox

		local cmdhistory = editBox.history_lines or {}
		local cmdcount = #cmdhistory
		while cmdcount > 0 do
			table.remove(cmdhistory)
			cmdcount = cmdcount - 1
		end
	end

	function module:AddHistoryLine(editBox)
		editBox = editBox or ChatFrame1EditBox

		-- following code mostly ripped off from Blizzard, but at least I understand it now
		local text = ""
		local type = editBox:GetAttribute("chatType")
		local header = _G["SLASH_" .. type .. "1"]

		if (header) then
			text = header
		end

		if (type == "WHISPER") and editBox:GetAttribute("tellTarget") ~= nil then
			text = text .. " " .. editBox:GetAttribute("tellTarget")
		elseif (type == "CHANNEL") and editBox:GetAttribute("channelTarget") ~= nil then
			text = "/" .. editBox:GetAttribute("channelTarget")
		end

		local editBoxText = editBox:GetText();
		if (strlen(editBoxText) > 0 and not IsSecureCmd(editBoxText:match("^/[%a%d_]+") or "")) then
			text = (header and (text .. " ") or "") .. editBoxText;
			self:saveLine(text, editBox)
		end
	end

	return
end) -- Prat:AddModuleToLoad
