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
	local module = Prat:NewModule("Filtering", "AceEvent-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Filtering"] = true,
		["A module to provide basic chat filtering."] = true,
		["leavejoin_name"] = "Filter Channel Leave/Join",
		["leavejoin_desc"] = "Filter out channel leave/join spam",
		["notices_name"] = "Filter Channel Notices",
		["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes.",
		["bgjoin_name"] = "Filter BG Leave/Join",
		["bgjoin_desc"] = "Filter out channel Battleground leave/join spam",
		["tradespam_name"] = "Throttle Spam",
		["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times",
		["afkdnd_name"] = "Throttle AFK and DND messages.",
		["afkdnd_desc"] = "Throttle AFK and DND messages.",
		["useai_desc"] = "Use a spam filter based on machine learning",
		["useai_name"] = "AI Spam Filter",
		["training_desc"] = "Show the AI training UI",
		["training_name"] = "AI Training",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = true
L["afkdnd_desc"] = "Throttle AFK and DND messages."
L["afkdnd_name"] = "Throttle AFK and DND messages."
L["bgjoin_desc"] = "Filter out channel Battleground leave/join spam"
L["bgjoin_name"] = "Filter BG Leave/Join"
L["Filtering"] = true
L["leavejoin_desc"] = "Filter out channel leave/join spam"
L["leavejoin_name"] = "Filter Channel Leave/Join"
L["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes."
L["notices_name"] = "Filter Channel Notices"
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
L["tradespam_name"] = "Throttle Spam"
L["training_desc"] = "Show the AI training UI"
L["training_name"] = "AI Training"
L["useai_desc"] = "Use a spam filter based on machine learning"
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("enUS", L)



  L = {}
  -- Filtering
--[[Translation missing --]]
L["A module to provide basic chat filtering."] = "A module to provide basic chat filtering."
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["bgjoin_desc"] = "Filter out channel Battleground leave/join spam"
--[[Translation missing --]]
L["bgjoin_name"] = "Filter BG Leave/Join"
--[[Translation missing --]]
L["Filtering"] = "Filtering"
--[[Translation missing --]]
L["leavejoin_desc"] = "Filter out channel leave/join spam"
--[[Translation missing --]]
L["leavejoin_name"] = "Filter Channel Leave/Join"
--[[Translation missing --]]
L["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes."
--[[Translation missing --]]
L["notices_name"] = "Filter Channel Notices"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("itIT", L)



  L = {}
  -- Filtering
--[[Translation missing --]]
L["A module to provide basic chat filtering."] = "A module to provide basic chat filtering."
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["bgjoin_desc"] = "Filter out channel Battleground leave/join spam"
--[[Translation missing --]]
L["bgjoin_name"] = "Filter BG Leave/Join"
--[[Translation missing --]]
L["Filtering"] = "Filtering"
--[[Translation missing --]]
L["leavejoin_desc"] = "Filter out channel leave/join spam"
--[[Translation missing --]]
L["leavejoin_name"] = "Filter Channel Leave/Join"
--[[Translation missing --]]
L["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes."
--[[Translation missing --]]
L["notices_name"] = "Filter Channel Notices"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("ptBR", L)


  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "Un module pour fournir un filtrage basique"
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
L["bgjoin_desc"] = "Filtrer les messages du canal Champ de bataille: \"quitte/rejoint\""
L["bgjoin_name"] = "Filtrer BG quitte/rejoint"
L["Filtering"] = "Filtrage"
L["leavejoin_desc"] = "Filtrer les messages: \"quitte/rejoint le canal\""
L["leavejoin_name"] = "Filtre Rejoindre/Quitte"
--[[Translation missing --]]
L["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes."
L["notices_name"] = "Notifications de filtrage"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("frFR",L)




  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "Ein Modul zur grundlegenden Chat-Filterung."
L["afkdnd_desc"] = "AFK- und DND-Meldungen unterdrücken."
L["afkdnd_name"] = "AFK- und DND-Meldungen unterdrücken."
L["bgjoin_desc"] = "Filtert Schlachtfeld Verlassen- und Beitrittmeldungen herraus"
L["bgjoin_name"] = "Filter Schlachtfeld Verlassen/Beitreten"
L["Filtering"] = "Filtert"
L["leavejoin_desc"] = "Filtert bzw. entfernt Kanalbeitritts- und -verlassensnachrichten."
L["leavejoin_name"] = "Filter Kanal Verlassen/Beitreten"
L["notices_desc"] = "Die allgemein üblichen Benachrichtigungen in Kanälen verhindern, z.B. Moderatorenwechsel."
L["notices_name"] = "Kanal-Meldungen filtern"
L["tradespam_desc"] = "Unterdrückt Nachrichten, um zu verhindern, dass dieselbe Nachricht mehrmals wiederholt wird"
L["tradespam_name"] = "Spam begrenzen"
L["training_desc"] = "Zeigt die Benutzeroberfläche des KI-Trainings"
L["training_name"] = "KI-Training"
L["useai_desc"] = "Verwende einen Spamfilter, der auf maschinellem Lernen basiert"
L["useai_name"] = "KI Spamfilter"

  PL:AddLocale("deDE", L)


  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "대화 내용을 필터링하는 모듈입니다."
L["afkdnd_desc"] = "자리비움과 다른 용무중 메시지를 조절합니다."
L["afkdnd_name"] = "자리비움과 다른 용무중 메시지를 조절합니다."
L["bgjoin_desc"] = "전장 채널 입장/퇴장 메시지를 숨깁니다."
L["bgjoin_name"] = "전장 입장/퇴장 필터링"
L["Filtering"] = "필터링"
L["leavejoin_desc"] = "채널 입장/퇴장 메시지를 숨깁니다."
L["leavejoin_name"] = "채널 입장/퇴장 필터링"
L["notices_desc"] = "사설 채널의 알림 메시지를 숨깁니다, ex. 관리자 변경."
L["notices_name"] = "채널 알림 메시지 필터링"
L["tradespam_desc"] = "같은 메시지가 여러번 반복되지 않게 방지합니다."
L["tradespam_name"] = "스팸 조절"
L["training_desc"] = "AI 훈련 UI 표시"
L["training_name"] = "AI 훈련"
L["useai_desc"] = "기계 학습 기반 스팸 필터를 사용합니다"
L["useai_name"] = "AI 스팸 필터"

  PL:AddLocale("koKR",L)

  L = {}
  -- Filtering
--[[Translation missing --]]
L["A module to provide basic chat filtering."] = "A module to provide basic chat filtering."
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["bgjoin_desc"] = "Filter out channel Battleground leave/join spam"
--[[Translation missing --]]
L["bgjoin_name"] = "Filter BG Leave/Join"
--[[Translation missing --]]
L["Filtering"] = "Filtering"
--[[Translation missing --]]
L["leavejoin_desc"] = "Filter out channel leave/join spam"
--[[Translation missing --]]
L["leavejoin_name"] = "Filter Channel Leave/Join"
--[[Translation missing --]]
L["notices_desc"] = "Filter out other custom channel notification messages, e.g. moderator changes."
--[[Translation missing --]]
L["notices_name"] = "Filter Channel Notices"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("esMX",L)

  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "Модуль для обеспечения базовый фильтрации чата."
L["afkdnd_desc"] = "Заглушать сообщения AFK и DND."
L["afkdnd_name"] = "Заглушать сообщения AFK и DND."
L["bgjoin_desc"] = "Отфильтровывать сообщения входа и выхода на/из Поля Сражения (БГ)"
L["bgjoin_name"] = "Отфильтровывать вход/выход на ПС"
L["Filtering"] = "Фильтрование"
L["leavejoin_desc"] = "Отфильтровывать сообщения входа и выхода из/в канал."
L["leavejoin_name"] = "Вход/выход в/из канала"
L["notices_desc"] = "Отфильтровывать извещения в каналах (такие как смета модератора и т.п.)."
L["notices_name"] = "Извещения в канале"
L["tradespam_desc"] = "Скрывать повторяющиеся сообщения"
L["tradespam_name"] = "Скрывать спам"
L["training_desc"] = "Показать интерфейс обучения AI"
L["training_name"] = "Обучение AI"
L["useai_desc"] = "Используйте спам-фильтр на основе машинного обучения"
L["useai_name"] = "Спам-фильтр AI"

  PL:AddLocale("ruRU",L)

  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "提供基础的聊天过滤的模块"
L["afkdnd_desc"] = "节流AFK和DND消息."
L["afkdnd_name"] = "节流AFK和DND消息."
L["bgjoin_desc"] = "过滤战场频道离开/加入信息"
L["bgjoin_name"] = "过滤战场出/入"
L["Filtering"] = "过滤"
L["leavejoin_desc"] = "滤掉频道离开/加入信息"
L["leavejoin_name"] = "过滤频道离开/加入"
L["notices_desc"] = "滤掉其他自定义频道通知信息,例如改变频道所有者"
L["notices_name"] = "频道通知过滤"
L["tradespam_desc"] = "节流消息以防止连续多次收到同样的消息"
L["tradespam_name"] = "屏蔽垃圾"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("zhCN",L)

  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "Un módulo que proporciona el filtrado básico del chat."
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
L["bgjoin_desc"] = "Filtrar en canal Campo de Batlla spam ha abandonado/se ha unido"
L["bgjoin_name"] = "Filtrar mensajes de unión/dejadas de Campos de Batalla"
L["Filtering"] = "Filtrado"
L["leavejoin_desc"] = "Filtrar en canal spam ha abandonado/se ha unido"
L["leavejoin_name"] = "Filtro de Canal  Ha abandonado / Se ha unido"
L["notices_desc"] = "Filtrar otros mensajes de notificación de canal personalizado, por ejemplo, los cambios de moderador."
L["notices_name"] = "Filtrar Noticias del Canal"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("esES",L)

  L = {}
  -- Filtering
L["A module to provide basic chat filtering."] = "模組：提供基本聊天過濾。"
--[[Translation missing --]]
L["afkdnd_desc"] = "Throttle AFK and DND messages."
--[[Translation missing --]]
L["afkdnd_name"] = "Throttle AFK and DND messages."
L["bgjoin_desc"] = "濾除戰場頻道離開/加入訊息"
L["bgjoin_name"] = "過濾戰場離開/參加"
L["Filtering"] = "過濾"
L["leavejoin_desc"] = "濾除頻道離開/加入訊息"
L["leavejoin_name"] = "過濾頻道離開/加入"
L["notices_desc"] = "濾除自訂頻道通知訊息，像是主持人變動"
L["notices_name"] = "過濾頻道通知"
--[[Translation missing --]]
L["tradespam_desc"] = "Throttle messages to prevent the same message from being repeated multiple times"
--[[Translation missing --]]
L["tradespam_name"] = "Throttle Spam"
--[[Translation missing --]]
L["training_desc"] = "Show the AI training UI"
--[[Translation missing --]]
L["training_name"] = "AI Training"
--[[Translation missing --]]
L["useai_desc"] = "Use a spam filter based on machine learning"
--[[Translation missing --]]
L["useai_name"] = "AI Spam Filter"

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@

	Prat:SetModuleDefaults(module, {
		profile = {
			on = false,
			leavejoin = true,
			notices = true,
			tradespam = false,
			afkdnd = false,
			training = false,
			useai = true,
		}
	})

	Prat:SetModuleOptions(module, {
		name = PL["Filtering"],
		desc = PL["A module to provide basic chat filtering."],
		type = "group",
		args = {
			--		    leavejoin = {
			--				name = PL["leavejoin_name"],
			--				desc = PL["leavejoin_desc"],
			--				type = "toggle",
			--				order = 100
			--			},
			notices = {
				name = PL["notices_name"],
				desc = PL["notices_desc"],
				type = "toggle",
				order = 110
			},
			tradespam = {
				name = PL["tradespam_name"],
				desc = PL["tradespam_desc"],
				type = "toggle",
				order = 115
			},
			afkdnd = {
				name = PL["afkdnd_name"],
				desc = PL["afkdnd_desc"],
				type = "toggle",
				order = 115
			},
			useai = {
				name = PL["useai_name"],
				desc = PL["useai_desc"],
				type = "toggle",
				order = 117
			},
			training = {
				name = PL["training_name"],
				desc = PL["training_desc"],
				type = "toggle",
				order = 118
			},

			--		    bgjoin = {
			--				name = PL["bgjoin_name"],
			--				desc = PL["bgjoin_desc"],
			--				type = "toggle",
			--				order = 111
			--			},
		}
	})

	local THROTTLE_TIME = 120

	local MessageTime = {}

	local function cleanText(msg, author)
		local cleanmsg = msg:gsub("...hic!", ""):gsub("%d", ""):gsub("%c", ""):gsub("%p", ""):gsub("%s", ""):upper():gsub("SH", "S");
		return (author and author:upper() or "") .. cleanmsg;
	end

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --
	function module:OnModuleEnable()
		Prat.RegisterMessageItem("SPAMPROB", "PRE", "after")
		self.classifier = Prat.GetClassifier(self.db.global)
		self.throttleFrame = self.throttleFrame or CreateFrame("FRAME");
		self.lineTable = {}
		self.trainTable = {}
		self.throttle = THROTTLE_TIME

		self.throttleFrame:SetScript("OnUpdate",
			function(frame, elapsed)
				self.throttle = self.throttle - elapsed
				if frame:IsShown() and self.throttle < 0 then
					self.throttle = THROTTLE_TIME
					self:PruneMessages()
				end
			end)

		--    ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", tradeSpamFilter)
		--    ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", tradeSpamFilter)

		Prat.RegisterChatEvent(self, "Prat_FrameMessage")
		Prat.RegisterLinkType({ linkid = "pratfilter", linkfunc = module.PratFilter, handler = module }, module.name)
	end

	-- things to do when the module is disabled
	function module:OnModuleDisable()
		self.lineTable = nil
		self.trainTable = nil
		--    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", tradeSpamFilter)
		--    ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", tradeSpamFilter)

		Prat.UnregisterAllChatEvents(self)
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --


	function module:PratFilter(data, frame)
		local _, id, found = strsplit(":", data)
		found = tonumber(found) == 1 and true or false
		self:ToggleLearn(id, found, frame)
		return false
	end

	function module:GetDescription()
		return PL["A module to provide basic chat filtering."]
	end

	function module:PruneMessages()
		for k, v in pairs(MessageTime) do
			if difftime(time(), v) > THROTTLE_TIME then
				MessageTime[k] = nil
			end
		end
	end

	local function string_split(text, sep, pattern)
		sep = sep or ""
		local fields = {}
		local patt = pattern or ("([^%s]+)"):format(sep)
		text:gsub(patt, function(c)
			fields[#fields + 1] = c:lower()
		end)
		return fields
	end

	local function tokenize(msg)
		return string_split(msg, nil, "([^%s%p%c]+)") -- obfuscations removal
	end

	local CLR = Prat.CLR

	function module:AdjustScore(id, frame)
		id = tonumber(id)
		local text = self.lineTable[id]
		local prob = self.classifier.getprob(tokenize(text))
		for _, v in ipairs(frame.visibleLines) do
			local mi = v.messageInfo
			local m = mi.message
			if m:match(("pratfilter:%d"):format(id)) then
				mi.message = m:gsub("|c%x-%d+%%%x-|r", CLR:Probability(FormatPercentage(prob), prob):gsub("%%", "%%%%"))
				break
			end
		end
	end

	function module:Learn(id, found, frame)
		id = tonumber(id)
		local text = self.lineTable[id]
		if not text then
			return
		end
		local learned = self.trainTable[id]
		if learned ~= nil then
			self.classifier.unlearn(tokenize(text), learned)
		end
		self:Output(frame, "learning " .. text .. " as " .. CLR:Probability(found and "SPAM" or "NOT SPAM", found and 1 or 0))
		self.trainTable[id] = found or false
		self.classifier.learn(tokenize(text), found)
		self:AdjustScore(id, frame)
	end

	function module:Unlearn(id, found, frame)
		id = tonumber(id)
		local text = self.lineTable[id]
		if not text then
			return
		end
		local learned = self.trainTable[id]
		self.trainTable[id] = nil
		if learned ~= nil then
			self.classifier.unlearn(tokenize(text), learned)
		end
		self:Output(frame, "Unlearning " .. text .. " as " .. CLR:Probability(found and "SPAM" or "NOT SPAM", found and 1 or 0))
		self.classifier.unlearn(tokenize(text), found)
		self:AdjustScore(id, frame)
	end

	function module:ToggleLearn(id, found, frame)
		id = tonumber(id)
		local learned = self.trainTable[id]
		if learned ~= nil then
			self:Unlearn(id, learned, frame)
			return
		end

		self:Learn(id, found, frame)
	end

	local SPAM_CUTOFF = 0.90
	local HAM_CUTOFF = 0.20

	function CLR:Bracket(text)
		return self:Colorize({
			r = 0.85,
			g = 0.85,
			b = 0.85,
			a = 1.0
		}, text)
	end

	function CLR:Probability(text, prob)
		local isHam = prob <= HAM_CUTOFF
		local isSpam = prob >= SPAM_CUTOFF

		local color = isHam and "40ff40" or isSpam and "ff4040" or "a0a0a0"
		return self:Colorize(color, text)
	end

	local eventsToHandle = {
		CHAT_MSG_CHANNEL = true
	}

	function module:Prat_FrameMessage(_, message, _, event)
		if self.db.profile.useai and eventsToHandle[event] and message.GUID ~= UnitGUID("player") then
			local msg = tokenize(message.ORG.MESSAGE)
			local prob = self.classifier.getprob(msg)
			local isSpam = prob >= SPAM_CUTOFF
			if self.db.profile.training then
				self.lineTable[message.LINE_ID] = message.ORG.MESSAGE
				message.SPAMPROB = ("|cff40ff40|Hpratfilter:%d:0|h[--]|h|r" .. CLR:Bracket("[") .. "%s" .. CLR:Bracket("]") .. "|cffff4040|Hpratfilter:%d:1|h[++]|h|r ")
					:format(message.LINE_ID, CLR:Probability(FormatPercentage(prob), prob), message.LINE_ID)
			else
				if isSpam then
					message.DONOTPROCESS = true
				end
			end
		end

		local newEvent = true
		if message.LINE_ID and
			message.LINE_ID == self.lastevent and
			self.lasteventtype == event then
			newEvent = false
		end

		if self.db.profile.tradespam then
			if event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_YELL" then
				local msg = cleanText(message.ORG.MESSAGE, message.ORG.PLAYER)

				if message.ORG.PLAYER ~= UnitName("player") then
					if newEvent and MessageTime[msg] then
						if difftime(time(), MessageTime[msg]) <= THROTTLE_TIME then
							message.DONOTPROCESS = true
						else
							MessageTime[msg] = nil
						end
					else
						self.lasteventtype = event
						self.lastevent = message.LINE_ID
						MessageTime[msg] = time();
					end
				end
			end
		end

		if self.db.profile.afkdnd then
			if event == "CHAT_MSG_AFK" or event == "CHAT_MSG_DND" then
				local msg = cleanText(message.ORG.MESSAGE, message.ORG.PLAYER)

				if newEvent and MessageTime[msg] then
					if difftime(time(), MessageTime[msg]) <= THROTTLE_TIME then
						message.DONOTPROCESS = true
					else
						MessageTime[msg] = nil
					end
				else
					self.lasteventtype = event
					self.lastevent = message.LINE_ID
					MessageTime[msg] = time();
				end
			end
		end

		if self.db.profile.notices then
			if event == "CHAT_MSG_CHANNEL_NOTICE_USER" or event == "CHAT_MSG_CHANNEL_NOTICE" then
				message.DONOTPROCESS = true
			end
		end
	end

	return
end) -- Prat:AddModuleToLoad
