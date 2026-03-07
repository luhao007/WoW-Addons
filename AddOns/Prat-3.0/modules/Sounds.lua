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
	local module = Prat:NewModule("Sounds", "AceEvent-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Sounds"] = true,
		["A module to play sounds on certain chat messages."] = true,
		["Add a custom channel"] = true,
		["Play a sound for a certain channel name (can be a substring)"] = true,
		["Remove a custom channel"] = true,
		["Reset settings"] = true,
		["Restore default settings and resets custom channel list"] = true,
		["Incoming Sounds"] = true,
		["Sound selection for incoming chat messages"] = true,
		["party_name"] = "Party",
		["party_desc"] = "Sound for %s party messages",
		["raid_name"] = "Raid",
		["raid_desc"] = "Sound for %s raid or instance group/leader messages",
		["guild_name"] = "Guild",
		["guild_desc"] = "Sound for %s guild messages",
		["officer_name"] = "Officer",
		["officer_desc"] = "Sound for %s officer channel messages",
		["whisper_name"] = "Whisper",
		["whisper_desc"] = "Sound for %s whisper messages",
		["bn_whisper_name"] = "Battle.Net Whisper",
		["bn_whisper_desc"] = "Sound for %s Battle.Net whisper messages",
		["group_lead_name"] = "Group Leader",
		["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages",
		["incoming"] = true,
		["outgoing"] = true,
		["Outgoing Sounds"] = true,
		["Sound selection for outgoing (from you) chat messages"] = true,
		["Custom Channels"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L


  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = true
L["Add a custom channel"] = true
L["bn_whisper_desc"] = "Sound for %s Battle.Net whisper messages"
L["bn_whisper_name"] = "Battle.Net Whisper"
L["Custom Channels"] = true
L["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages"
L["group_lead_name"] = "Group Leader"
L["guild_desc"] = "Sound for %s guild messages"
L["guild_name"] = "Guild"
L["incoming"] = true
L["Incoming Sounds"] = true
L["officer_desc"] = "Sound for %s officer channel messages"
L["officer_name"] = "Officer"
L["outgoing"] = true
L["Outgoing Sounds"] = true
L["party_desc"] = "Sound for %s party messages"
L["party_name"] = "Party"
L["Play a sound for a certain channel name (can be a substring)"] = true
L["raid_desc"] = "Sound for %s raid or battleground group/leader messages"
L["raid_name"] = "Raid"
L["Remove a custom channel"] = true
L["Reset settings"] = true
L["Restore default settings and resets custom channel list"] = true
L["Sound selection for incoming chat messages"] = true
L["Sound selection for outgoing (from you) chat messages"] = true
L["Sounds"] = true
L["whisper_desc"] = "Sound for %s whisper messages"
L["whisper_name"] = "Whisper"


	  PL:AddLocale("enUS",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "Un module pour jouer un son sur certains évènements de messages."
L["Add a custom channel"] = "Ajouter un canal"
L["bn_whisper_desc"] = "Son pour les messages Battle.Net %s"
L["bn_whisper_name"] = "Chuchotement Battle.Net"
L["Custom Channels"] = "Canaux personnalisés"
L["group_lead_desc"] = "Son pour les messages des leaders de raid, de groupe, ou des maîtres de donjon %s"
L["group_lead_name"] = "Chef de groupe"
L["guild_desc"] = "Son pour les messages de guilde %s"
L["guild_name"] = "Guilde"
L["incoming"] = "entrants"
L["Incoming Sounds"] = "Sons entrants"
L["officer_desc"] = "Son pour les messages d'officier %s"
L["officer_name"] = "Officier"
L["outgoing"] = "sortants"
L["Outgoing Sounds"] = "Sons sortants"
L["party_desc"] = "Son pour les messages de groupe %s"
L["party_name"] = "Groupe"
L["Play a sound for a certain channel name (can be a substring)"] = "Jouer un son pour un certain nom de canal (peut être une sous chaîne)"
L["raid_desc"] = "Son pour les messages de raid/CdB %s"
L["raid_name"] = "Raid"
L["Remove a custom channel"] = "Supprimer un canal personnalisé"
L["Reset settings"] = "Réinitialiser les options"
L["Restore default settings and resets custom channel list"] = "Restaurer les options par défaut et réinitialise la liste des canaux personnalisés"
L["Sound selection for incoming chat messages"] = "Sélection du son pour les messages entrants"
L["Sound selection for outgoing (from you) chat messages"] = "Sélection du son pour les messages sortants (de vous)"
L["Sounds"] = "Sons"
L["whisper_desc"] = "Son pour les messages privés %s"
L["whisper_name"] = "Chuchoter"


	  PL:AddLocale("frFR",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "Ein Modul zum Abspielen von Tönen in bestimmten Chat-Nachrichten."
L["Add a custom channel"] = "Einen benutzerdefinierten Kanal hinzufügen."
L["bn_whisper_desc"] = "Sound für %s Battle.Net-Flüsternachrichten"
L["bn_whisper_name"] = "Battle.Net-Flüsternachricht"
L["Custom Channels"] = "Benutzerdefinierte Kanäle"
L["group_lead_desc"] = "Klang für %s Schlachtzugsleiter, Gruppenführer oder Anleitungsmitteilungen für Instanzen."
L["group_lead_name"] = "Gruppenanführer"
L["guild_desc"] = "Klang für %s Gildenmitteilungen"
L["guild_name"] = "Gilde"
L["incoming"] = "eingehend"
L["Incoming Sounds"] = "Eingehende Klänge"
L["officer_desc"] = "Klang für %s Mitteilungen im Offizierskanal"
L["officer_name"] = "Offizier"
L["outgoing"] = "ausgehend"
L["Outgoing Sounds"] = "Ausgehende Töne"
L["party_desc"] = "Klang für %s Gruppenmitteilungen"
L["party_name"] = "Gruppe"
L["Play a sound for a certain channel name (can be a substring)"] = "Einen Ton für einen bestimmten Kanalnamen abspielen (kann eine Unterzeichenfolge sein)"
L["raid_desc"] = "Klang für %s Gruppen- und Führermitteilungen in Schlachtzügen oder Schlachtfeldern"
L["raid_name"] = "Schlachtzug"
L["Remove a custom channel"] = "Entfernt einen benutzerdefinierten Kanal"
L["Reset settings"] = "Einstellungen zurücksetzen"
L["Restore default settings and resets custom channel list"] = "Stellt die Standardeinstellungen wieder her und setzt die benutzerdefinierte Kanalliste zurück"
L["Sound selection for incoming chat messages"] = "Tonauswahl für eingehende Chat-Nachrichten"
L["Sound selection for outgoing (from you) chat messages"] = "Tonauswahl für ausgehende (von dir) Chat-Nachrichten"
L["Sounds"] = "Töne"
L["whisper_desc"] = "Klang für %s Flüstermitteilungen"
L["whisper_name"] = "Flüstern"


	  PL:AddLocale("deDE",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "특정 대화 메시지에 소리를 재생하는 모듈입니다."
L["Add a custom channel"] = "사설 채널 추가"
L["bn_whisper_desc"] = "%s Battle.Net 귓속말 메시지 소리"
L["bn_whisper_name"] = "Battle.Net 귓속말"
L["Custom Channels"] = "사설 채널"
L["group_lead_desc"] = "%s 공격대장, 파티장 또는 던전 길잡이 메시지의 소리"
L["group_lead_name"] = "그룹장"
L["guild_desc"] = "%s 길드 메시지 소리"
L["guild_name"] = "길드"
L["incoming"] = "받을 때"
L["Incoming Sounds"] = "받을 때 소리"
L["officer_desc"] = "%s 관리자 채널 메시지 소리"
L["officer_name"] = "관리자"
L["outgoing"] = "보낼 때"
L["Outgoing Sounds"] = "보낼 때 소리"
L["party_desc"] = "%s 파티 메시지 소리"
L["party_name"] = "파티"
L["Play a sound for a certain channel name (can be a substring)"] = "특정 채널 이름에 소리 재생하기 (일치하는 단어 포함)"
L["raid_desc"] = "%s 공격대 또는 전장 파티/장 메시지 소리"
L["raid_name"] = "공격대"
L["Remove a custom channel"] = "사설 채널 제거"
L["Reset settings"] = "설정 초기화"
L["Restore default settings and resets custom channel list"] = "사설 채널 목록을 초기화하고 기본 설정으로 복원"
L["Sound selection for incoming chat messages"] = "대화 메시지를 받을 때 소리 선택"
L["Sound selection for outgoing (from you) chat messages"] = "대화 메시지를 보낼 때(자신이) 소리 선택"
L["Sounds"] = "소리 [Sounds]"
L["whisper_desc"] = "%s 귓속말 메시지 소리"
L["whisper_name"] = "귓속말"


	  PL:AddLocale("koKR",L)



  L = {}
  -- Sounds
--[[Translation missing --]]
L["A module to play sounds on certain chat messages."] = "A module to play sounds on certain chat messages."
--[[Translation missing --]]
L["Add a custom channel"] = "Add a custom channel"
--[[Translation missing --]]
L["bn_whisper_desc"] = "Sound for %s Battle.Net whisper messages"
--[[Translation missing --]]
L["bn_whisper_name"] = "Battle.Net Whisper"
--[[Translation missing --]]
L["Custom Channels"] = "Custom Channels"
--[[Translation missing --]]
L["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages"
--[[Translation missing --]]
L["group_lead_name"] = "Group Leader"
--[[Translation missing --]]
L["guild_desc"] = "Sound for %s guild messages"
--[[Translation missing --]]
L["guild_name"] = "Guild"
--[[Translation missing --]]
L["incoming"] = "incoming"
--[[Translation missing --]]
L["Incoming Sounds"] = "Incoming Sounds"
--[[Translation missing --]]
L["officer_desc"] = "Sound for %s officer channel messages"
--[[Translation missing --]]
L["officer_name"] = "Officer"
--[[Translation missing --]]
L["outgoing"] = "outgoing"
--[[Translation missing --]]
L["Outgoing Sounds"] = "Outgoing Sounds"
--[[Translation missing --]]
L["party_desc"] = "Sound for %s party messages"
--[[Translation missing --]]
L["party_name"] = "Party"
--[[Translation missing --]]
L["Play a sound for a certain channel name (can be a substring)"] = "Play a sound for a certain channel name (can be a substring)"
--[[Translation missing --]]
L["raid_desc"] = "Sound for %s raid or battleground group/leader messages"
--[[Translation missing --]]
L["raid_name"] = "Raid"
--[[Translation missing --]]
L["Remove a custom channel"] = "Remove a custom channel"
--[[Translation missing --]]
L["Reset settings"] = "Reset settings"
--[[Translation missing --]]
L["Restore default settings and resets custom channel list"] = "Restore default settings and resets custom channel list"
--[[Translation missing --]]
L["Sound selection for incoming chat messages"] = "Sound selection for incoming chat messages"
--[[Translation missing --]]
L["Sound selection for outgoing (from you) chat messages"] = "Sound selection for outgoing (from you) chat messages"
--[[Translation missing --]]
L["Sounds"] = "Sounds"
--[[Translation missing --]]
L["whisper_desc"] = "Sound for %s whisper messages"
--[[Translation missing --]]
L["whisper_name"] = "Whisper"


	  PL:AddLocale("esMX",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "Модуль проигрывает зуки для определённых сообщений в чате."
L["Add a custom channel"] = "Добавить свой канал"
L["bn_whisper_desc"] = "Звук для %s Battle.Net при шепоте"
L["bn_whisper_name"] = "Battle.Net Шепот"
L["Custom Channels"] = "Личные каналы"
L["group_lead_desc"] = "Звук для сообщений %s лидера рейда, лидера группы или проводника подземелья"
L["group_lead_name"] = "Лидер группы"
L["guild_desc"] = "Звук %s для сообщений гильдии"
L["guild_name"] = "Гильдия"
L["incoming"] = "Входящие"
L["Incoming Sounds"] = "Звук входящих"
L["officer_desc"] = "Звук %s для сообщений офицеров или личного канала"
L["officer_name"] = "Офицеры"
L["outgoing"] = "Исходящие"
L["Outgoing Sounds"] = "Звуки исходящего"
L["party_desc"] = "Звук %s для сообщений группы"
L["party_name"] = "Группа"
L["Play a sound for a certain channel name (can be a substring)"] = "Проигрывает зук для определённого канала чата (can be a substring)"
L["raid_desc"] = "Звук %s для сообщений группы/лидера рейда или поля сражений"
L["raid_name"] = "Рейд"
L["Remove a custom channel"] = "Удалить свой канал"
L["Reset settings"] = "Сброс настроек"
L["Restore default settings and resets custom channel list"] = "Восстановление стандартных настроек и сброс списка своих каналов чата."
L["Sound selection for incoming chat messages"] = "Выбор звука для входящих сообщений в чате"
L["Sound selection for outgoing (from you) chat messages"] = "Выбор звука для исходящих (от вас) сообщений в чате"
L["Sounds"] = "Звуки"
L["whisper_desc"] = "Звук  %s для личных сообщений"
L["whisper_name"] = "Шепот"


	  PL:AddLocale("ruRU",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "在某些聊天信息播放声音的模块"
L["Add a custom channel"] = "添加自定义频道"
L["bn_whisper_desc"] = "为 %s 战网密语提示音乐"
L["bn_whisper_name"] = "战网密语"
L["Custom Channels"] = "自定义频道"
L["group_lead_desc"] = "为团队领袖, 队伍领袖或地下城领袖 %s 发出声音提示"
L["group_lead_name"] = "队伍领袖"
L["guild_desc"] = "公会信息声音"
L["guild_name"] = "公会"
L["incoming"] = "收到"
L["Incoming Sounds"] = "收入声音"
L["officer_desc"] = "官员或自定义频道信息声音"
L["officer_name"] = "官员"
L["outgoing"] = "送出"
L["Outgoing Sounds"] = "送出声音"
L["party_desc"] = " %s 小队信息声音"
L["party_name"] = "小队"
L["Play a sound for a certain channel name (can be a substring)"] = "为特定频道名(可以是子字符串)播放声音"
L["raid_desc"] = " %s 团队或战场分组/领袖信息声音"
L["raid_name"] = "团队"
L["Remove a custom channel"] = "移除自定义频道"
L["Reset settings"] = "重制设置"
L["Restore default settings and resets custom channel list"] = "恢复默认设置并且重制自定义频道列表"
L["Sound selection for incoming chat messages"] = "收到聊天信息声音设置"
L["Sound selection for outgoing (from you) chat messages"] = "送出(由你)聊天信息音乐设置"
L["Sounds"] = "声音"
L["whisper_desc"] = "密语信息 %s 声音"
L["whisper_name"] = "密语"


	  PL:AddLocale("zhCN",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "Un módulo que reproduce sonidos con ciertos mensajes del chat."
L["Add a custom channel"] = "Añadir un canal personalizado"
--[[Translation missing --]]
L["bn_whisper_desc"] = "Sound for %s Battle.Net whisper messages"
--[[Translation missing --]]
L["bn_whisper_name"] = "Battle.Net Whisper"
L["Custom Channels"] = "Canales Personalizados"
--[[Translation missing --]]
L["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages"
--[[Translation missing --]]
L["group_lead_name"] = "Group Leader"
L["guild_desc"] = "Sonido para mensajes de hermandad %s"
L["guild_name"] = "Hermandad"
L["incoming"] = "Recibido"
L["Incoming Sounds"] = "Sonidos Entrantes"
L["officer_desc"] = "Sonido para mensajes del canal oficial o personalizado %s"
L["officer_name"] = "Oficial"
L["outgoing"] = "Saliente"
L["Outgoing Sounds"] = "Sonidos Salientes"
L["party_desc"] = "Sonido para mensajes del grupo %s"
L["party_name"] = "Grupo"
L["Play a sound for a certain channel name (can be a substring)"] = "Reproduce un sonido para un cierto nombre de canal (puede ser una subcadena)"
L["raid_desc"] = "Sonido para mensajes de banda %s o líder/grupo de campo de batalla"
L["raid_name"] = "Banda"
L["Remove a custom channel"] = "Eliminar un canal personalizado."
L["Reset settings"] = "Restablecer ajustes"
L["Restore default settings and resets custom channel list"] = "Reestable ajustes por defecto y reestablece la lista de canales personalizados"
L["Sound selection for incoming chat messages"] = "Selección de sonido para mensajes de chat entrantes"
L["Sound selection for outgoing (from you) chat messages"] = "Selección de sonido para mensajes de chat salientes (de ti)"
L["Sounds"] = "Sonidos"
L["whisper_desc"] = "Sonido para susurros %s"
L["whisper_name"] = "Susurrar"


	  PL:AddLocale("esES",L)



  L = {}
  -- Sounds
L["A module to play sounds on certain chat messages."] = "模組：於特定聊天訊息播放音效。"
L["Add a custom channel"] = "加入自訂頻道"
L["bn_whisper_desc"] = "聲音於 %s Battle.Net 密話訊息"
L["bn_whisper_name"] = "Battle.Net 密話"
L["Custom Channels"] = "自訂頻道"
--[[Translation missing --]]
L["group_lead_desc"] = "Sound for %s raid leader, party leader or dungeon guide messages"
L["group_lead_name"] = "隊長"
L["guild_desc"] = "公會訊息音效：%s"
L["guild_name"] = "公會"
L["incoming"] = "收入"
L["Incoming Sounds"] = "收入聲音"
L["officer_desc"] = "幹部頻道音效：%s"
L["officer_name"] = "幹部"
L["outgoing"] = "外出"
L["Outgoing Sounds"] = "外出聲音"
L["party_desc"] = "小隊訊息音效：%s"
L["party_name"] = "小隊"
L["Play a sound for a certain channel name (can be a substring)"] = "於此頻道播放音效（可為字串）"
L["raid_desc"] = "戰場以及戰場領導訊息音效：%s"
L["raid_name"] = "團隊"
L["Remove a custom channel"] = "移除自訂頻道"
L["Reset settings"] = "重置設定"
L["Restore default settings and resets custom channel list"] = "恢復預設設定以及重置自訂聊天列表"
L["Sound selection for incoming chat messages"] = "發送選擇收入聊天訊息"
L["Sound selection for outgoing (from you) chat messages"] = "發送選擇外出(從你)聊天訊息"
L["Sounds"] = "音效"
L["whisper_desc"] = "密語訊息音效：%s"
L["whisper_name"] = "密語"


	  PL:AddLocale("zhTW",L)


	end
	--@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			["incoming"] = {
				["GUILD"] = "Kachink",
				["OFFICER"] = "popup",
				["PARTY"] = "Text1",
				["RAID"] = "Text1",
				["WHISPER"] = "Heart",
				["BN_WHISPER"] = "Heart",
				["GROUP_LEAD"] = "Text2",
			},
			["outgoing"] = {
				["GUILD"] = "None",
				["OFFICER"] = "None",
				["PARTY"] = "None",
				["RAID"] = "None",
				["WHISPER"] = "None",
				["BN_WHISPER"] = "None",
				["GROUP_LEAD"] = "None",
			},
			["customlist"] = GetLocale() == "zhTW" and {}
				or { ["*"] = "None" },
		}
	})

	local media, SOUND

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --
	-- things to do when the module is enabled
	function module:OnModuleEnable()
		media = Prat.Media
		SOUND = media.MediaType.SOUND
		self:BuildSoundList()
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE", "RefreshOptions")
		self:RefreshOptions()

		-- Remove older options
		for cname, _ in pairs(self.db.profile.customlist) do
			if type(cname) == "number" then
				-- bad data
				self.db.profile.customlist[cname] = nil
			end
		end

		Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)

		media.RegisterCallback(self, "LibSharedMedia_Registered", "SharedMedia_Registered")
		media.RegisterCallback(self, "LibSharedMedia_SetGlobal", "SharedMedia_Registered")

		_G.MuteSoundFile(567421)
	end



	-- things to do when the module is disabled
	function module:OnModuleDisable()
		self:UnregisterAllEvents()
		Prat.UnregisterAllChatEvents(self)
		media.UnregisterAllCallbacks(self)
		_G.UnmuteSoundFile(567421)
	end

	local soundslist = {}

	function module:GetDescription()
		return PL["A module to play sounds on certain chat messages."]
	end

	function module:BuildSoundList()
		if not media then
			return
		end

		for i, _ in ipairs(soundslist) do
			soundslist[i] = nil
		end

		for k, _ in pairs(media.MediaTable[SOUND]) do
			soundslist[k] = k
		end
	end

	function module:SharedMedia_Registered(mediatype)
		if mediatype == SOUND then
			self:BuildSoundList()
		end
	end

	do
		local optionGroup_mt = {
			__index = {
				type = "select",
				get = "GetChanOptValue",
				set = "SetChanOptValue",
				dialogControl = 'LSM30_Sound',
				values = AceGUIWidgetLSMlists.sound,
			}
		}

		local function newOptionGroup(text, incoming)
			local t = setmetatable({}, optionGroup_mt)
			t.name = PL[text .. "_name"]
			t.desc = (PL[text .. "_desc"]):format(incoming and PL["incoming"] or PL["outgoing"])
			return t
		end

		local customchans = {}

		function module:RefreshOptions()
			local o = customchans
			local t = Prat.GetChannelTable()
			for _, n in pairs(t) do
				if type(n) == "string" then
					if not o[n] then
						o[n] = setmetatable({ name = n, desc = n }, optionGroup_mt)
					end
				end
			end
		end

		Prat:SetModuleOptions(module.name, {
			name = PL["Sounds"],
			desc = PL["A module to play sounds on certain chat messages."],
			type = "group",
			childGroups = "tab",
			args = {
				customlist = {
					type = "group",
					order = 40,
					name = PL["Custom Channels"],
					desc = PL["Custom Channels"],
					args = customchans
				},
				incoming = {
					type = "group",
					name = PL["Incoming Sounds"],
					desc = PL["Sound selection for incoming chat messages"],
					order = 20,
					args = {
						party = newOptionGroup("party", true),
						raid = newOptionGroup("raid", true),
						guild = newOptionGroup("guild", true),
						officer = newOptionGroup("officer", true),
						whisper = newOptionGroup("whisper", true),
						bn_whisper = newOptionGroup("bn_whisper", true),
						group_lead = newOptionGroup("group_lead", true),
					},
				},
				outgoing = {
					type = "group",
					name = PL["Outgoing Sounds"],
					desc = PL["Sound selection for outgoing (from you) chat messages"],
					order = 30,
					args = {
						party = newOptionGroup("party"),
						raid = newOptionGroup("raid"),
						guild = newOptionGroup("guild"),
						officer = newOptionGroup("officer"),
						whisper = newOptionGroup("whisper"),
						bn_whisper = newOptionGroup("bn_whisper"),
						group_lead = newOptionGroup("group_lead", true),
					},
				},
			},
		})
	end

	function module:GetChanOptValue(info)
		return self.db.profile[info[#info - 1]][info[#info]:upper()]
	end

	function module:SetChanOptValue(info, val)
		Prat:PlaySound(val)
		self.db.profile[info[#info - 1]][info[#info]:upper()] = val
	end

	function module:GetCChanOptValue(info)
		return self.db.profile.customlist[info[#info]]
	end

	function module:SetCChanOptValue(info, val)
		self.db.profile.customlist[info[#info]] = val
	end




	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:Prat_PostAddMessage(_, message, _, event)
		if message.LINE_ID and message.LINE_ID == self.lastevent and self.lasteventtype == event then
			return
		end

		local msgtype = string.sub(event, 10)
		local plr = message.PLAYERLINK:match("([^%-]+)%-?.*")
		local outgoing = (plr == UnitName("player")) and true or false
		local sndprof = outgoing and self.db.profile.outgoing or self.db.profile.incoming

		if msgtype == "CHANNEL" or msgtype == "COMMUNITIES_CHANNEL" then
			local chan = string.lower(message.ORG.CHANNEL)
			for cname, value in pairs(self.db.profile.customlist) do
				if strlen(cname) > 0 and chan == cname:lower() then
					self:PlaySound(value)
				end
			end
		else
			if msgtype == "WHISPER_INFORM" then
				msgtype = "WHISPER"
				sndprof = self.db.profile.outgoing
			elseif msgtype == "WHISPER" then
				sndprof = self.db.profile.incoming
			end
			if msgtype == "BN_WHISPER_INFORM" then
				msgtype = "BN_WHISPER"
				sndprof = self.db.profile.outgoing
			elseif msgtype == "BN_WHISPER" then
				sndprof = self.db.profile.incoming
			end

			if msgtype == "PARTY_LEADER" or msgtype == "RAID_LEADER" or
				msgtype == "PARTY_GUIDE" or msgtype == "INSTANCE_CHAT_LEADER" then
				msgtype = "GROUP_LEAD"
			end

			if msgtype == "INSTANCE_CHAT" then
				msgtype = IsInRaid() and "RAID" or "PARTY"
			end

			if msgtype == "RAID_WARNING" then
				msgtype = "GROUP_LEAD"
			end

			if msgtype == "GUILD_ACHIEVEMENT" or msgtype == "GUILD_ITEM_LOOTED" then
				msgtype = "GUILD"
			end

			self:PlaySound(sndprof[msgtype], event, message.LINE_ID)
		end
	end

	function module:PlaySound(sound, event, eventId)
		self.lasteventtype = event
		self.lastevent = eventId
		Prat:PlaySound(sound)
	end

	return
end) -- Prat:AddModuleToLoad
