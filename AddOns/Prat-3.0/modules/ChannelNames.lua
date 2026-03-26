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
	local module = Prat:NewModule("ChannelNames", "AceEvent-3.0", "AceTimer-3.0", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["ChannelNames"] = true,
		["Channel name abbreviation options."] = true,
		["Replace"] = true,
		["Toggle replacing this channel."] = true,
		["Blank"] = true,
		["Dont display the channel/chat type name"] = true,
		["Set"] = true,
		["Channel %d"] = true,
		["%s settings."] = true,
		["Use a custom replacement for the chat %s text."] = true,
		["channelnick_name"] = "Channel Abbreviations",
		["channelnick_desc"] = "Channel Abbreviations",
		["Add Channel Abbreviation"] = true,
		["addnick_desc"] = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade').",
		["Remove Channel Abbreviation"] = true,
		["Removes an an abbreviated channel name."] = true,
		["Clear Channel Abbreviation"] = true,
		["Clears an abbreviated channel name."] = true,
		["otheropts_name"] = "Other Options",
		["otheropts_desc"] = "Additional channel formating options, and channel link controls.",
		["space_name"] = "Show Space",
		["space_desc"] = "Toggle adding space after channel replacement.",
		["colon_name"] = "Show Colon",
		["colon_desc"] = "Toggle adding colon after channel replacement.",
		["chanlink_name"] = "Create Channel Link",
		["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel.",
		["<string>"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- ChannelNames
L["%s settings."] = true
L["<string>"] = true
L["Add Channel Abbreviation"] = true
L["addnick_desc"] = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade')."
L["Blank"] = true
L["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel."
L["chanlink_name"] = "Create Channel Link"
L["Channel %d"] = true
L["Channel name abbreviation options."] = true
L["ChannelNames"] = true
L["channelnick_desc"] = "Channel Abbreviations"
L["channelnick_name"] = "Channel Abbreviations"
L["Clear Channel Abbreviation"] = true
L["Clears an abbreviated channel name."] = true
L["colon_desc"] = "Toggle adding colon after channel replacement."
L["colon_name"] = "Show Colon"
L["Dont display the channel/chat type name"] = true
L["otheropts_desc"] = "Additional channel formating options, and channel link controls."
L["otheropts_name"] = "Other Options"
L["Remove Channel Abbreviation"] = true
L["Removes an an abbreviated channel name."] = true
L["Replace"] = true
L["Set"] = true
L["space_desc"] = "Toggle adding space after channel replacement."
L["space_name"] = "Show Space"
L["Toggle replacing this channel."] = true
L["Use a custom replacement for the chat %s text."] = true


  PL:AddLocale("enUS",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "Options pour %s ."
L["<string>"] = "<chaîne>"
L["Add Channel Abbreviation"] = "Ajouter une abréviation"
L["addnick_desc"] = "Ajoute une abréviation pour le nom de ce canal. Préfixer le nom avec '#' permet d'inclure le numéro du canal. (Exemple : '#Commerce')"
--[[Translation missing --]]
L["Blank"] = "Blank"
--[[Translation missing --]]
L["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel."
--[[Translation missing --]]
L["chanlink_name"] = "Create Channel Link"
L["Channel %d"] = "Canal %d"
L["Channel name abbreviation options."] = "Options d'abréviations des noms de canaux."
L["ChannelNames"] = "Noms des canaux"
L["channelnick_desc"] = "Abréviations des noms des canaux."
L["channelnick_name"] = "Abréviations"
--[[Translation missing --]]
L["Clear Channel Abbreviation"] = "Clear Channel Abbreviation"
--[[Translation missing --]]
L["Clears an abbreviated channel name."] = "Clears an abbreviated channel name."
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after channel replacement."
--[[Translation missing --]]
L["colon_name"] = "Show Colon"
--[[Translation missing --]]
L["Dont display the channel/chat type name"] = "Dont display the channel/chat type name"
L["otheropts_desc"] = "Options supplémentaires du formatage des noms de canaux."
L["otheropts_name"] = "Autres options"
--[[Translation missing --]]
L["Remove Channel Abbreviation"] = "Remove Channel Abbreviation"
--[[Translation missing --]]
L["Removes an an abbreviated channel name."] = "Removes an an abbreviated channel name."
L["Replace"] = "Remplacer"
--[[Translation missing --]]
L["Set"] = "Set"
--[[Translation missing --]]
L["space_desc"] = "Toggle adding space after channel replacement."
--[[Translation missing --]]
L["space_name"] = "Show Space"
L["Toggle replacing this channel."] = "Active/Désactive le texte de remplacement pour ce canal."
L["Use a custom replacement for the chat %s text."] = "Utiliser un texte de remplacement pour le canal %s."


  PL:AddLocale("frFR",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "%s - Einstellungen"
L["<string>"] = "<Zeichenfolge>"
L["Add Channel Abbreviation"] = "Kanalabkürzung hinzufügen"
L["addnick_desc"] = "Fügt einen abgekürzten Kanalnamen hinzu. Füge den Vorsatz '#' dem Namen hinzu, um die Kanalnummer einzuschließen. (z.B. '#Handel')"
L["Blank"] = "Leer"
L["chanlink_desc"] = "Den Kanal zu einem anklickbaren Link machen, der den Chat zu diesem Kanal öffnet."
L["chanlink_name"] = "Kanal Link erstellen"
L["Channel %d"] = "Kanal %d"
L["Channel name abbreviation options."] = "Abkürzungsoptionen für Kanalnamen."
L["ChannelNames"] = "Kanalnamen"
L["channelnick_desc"] = "Kanalabkürzungen"
L["channelnick_name"] = "Kanalabkürzungen"
L["Clear Channel Abbreviation"] = "Kanalabkürzung löschen"
L["Clears an abbreviated channel name."] = "Löscht einen abgekürzten Kanalnamen."
L["colon_desc"] = "Hinzufügen eines Doppelpunkts nach dem Ersetzen des Kanals ein-/ausschalten."
L["colon_name"] = "Doppelpunkt anzeigen"
L["Dont display the channel/chat type name"] = "Zeigt nicht den Namen des Kanal-/Chat-Typs an"
L["otheropts_desc"] = "Weitere Formatierungsoptionen für die Kanäle, sowie Steuerung der Kanal-Links."
L["otheropts_name"] = "Weitere Optionen"
L["Remove Channel Abbreviation"] = "Kanalabkürzung entfernen"
L["Removes an an abbreviated channel name."] = "Entfernt einen abgekürzten Kanalnamen."
L["Replace"] = "Ersetzen"
L["Set"] = "Setzen"
L["space_desc"] = [=[Hinzufügen eines Leerzeichens nach dem Ersetzen des Kanals ein-/ausschalten.
]=]
L["space_name"] = "Leerzeichen anzeigen"
L["Toggle replacing this channel."] = "Schaltet das Ersetzen dieses Kanals um."
L["Use a custom replacement for the chat %s text."] = "Benutze einen allgemein üblichen Ersatz für den Text des Chats %s."


  PL:AddLocale("deDE",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "%s 설정."
L["<string>"] = "<내용>"
L["Add Channel Abbreviation"] = "채널 이름 줄임 추가"
L["addnick_desc"] = "축약된 채널 이름을 추가합니다. 채널 이름에 #을 붙이면 채널 번호를 포함합니다. (예. '#거래')."
L["Blank"] = "공백"
L["chanlink_desc"] = "채널을 해당 채널에 대화를 여는 클릭가능 한 링크로 만듭니다."
L["chanlink_name"] = "채널 링크 만들기"
L["Channel %d"] = "채널 %d"
L["Channel name abbreviation options."] = "채널 이름 줄이기 옵션입니다."
L["ChannelNames"] = "채널 이름"
L["channelnick_desc"] = "채널 이름 줄여쓰기"
L["channelnick_name"] = "채널 이름 줄여쓰기"
L["Clear Channel Abbreviation"] = "채널 줄임 초기화"
L["Clears an abbreviated channel name."] = "축약된 채널 이름을 지웁니다."
L["colon_desc"] = "대체 채널 이름 뒤에 콜론을 추가합니다."
L["colon_name"] = "콜론 표시"
L["Dont display the channel/chat type name"] = "채널/대화 유형 이름 표시하지 않기"
L["otheropts_desc"] = "추가적으로 채널 링크를 제어하고 채널을 형식화하는 옵션입니다."
L["otheropts_name"] = "기타 옵션"
L["Remove Channel Abbreviation"] = "채널 줄임 제거"
L["Removes an an abbreviated channel name."] = "축약된 채널 이름을 제거합니다."
L["Replace"] = "교체"
L["Set"] = "설정"
L["space_desc"] = "채널 대체 이름 뒤에 공간 추가 기능을 켜거나 끕니다."
L["space_name"] = "공간 표시"
L["Toggle replacing this channel."] = "이 채널 이름 대체하기"
L["Use a custom replacement for the chat %s text."] = "대화 %s 문자에 사용자 설정 교체를 사용합니다."


  PL:AddLocale("koKR",L)



  L = {}
  -- ChannelNames
--[[Translation missing --]]
L["%s settings."] = "%s settings."
--[[Translation missing --]]
L["<string>"] = "<string>"
--[[Translation missing --]]
L["Add Channel Abbreviation"] = "Add Channel Abbreviation"
--[[Translation missing --]]
L["addnick_desc"] = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade')."
--[[Translation missing --]]
L["Blank"] = "Blank"
--[[Translation missing --]]
L["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel."
--[[Translation missing --]]
L["chanlink_name"] = "Create Channel Link"
--[[Translation missing --]]
L["Channel %d"] = "Channel %d"
--[[Translation missing --]]
L["Channel name abbreviation options."] = "Channel name abbreviation options."
--[[Translation missing --]]
L["ChannelNames"] = "ChannelNames"
--[[Translation missing --]]
L["channelnick_desc"] = "Channel Abbreviations"
--[[Translation missing --]]
L["channelnick_name"] = "Channel Abbreviations"
--[[Translation missing --]]
L["Clear Channel Abbreviation"] = "Clear Channel Abbreviation"
--[[Translation missing --]]
L["Clears an abbreviated channel name."] = "Clears an abbreviated channel name."
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after channel replacement."
--[[Translation missing --]]
L["colon_name"] = "Show Colon"
--[[Translation missing --]]
L["Dont display the channel/chat type name"] = "Dont display the channel/chat type name"
--[[Translation missing --]]
L["otheropts_desc"] = "Additional channel formating options, and channel link controls."
--[[Translation missing --]]
L["otheropts_name"] = "Other Options"
--[[Translation missing --]]
L["Remove Channel Abbreviation"] = "Remove Channel Abbreviation"
--[[Translation missing --]]
L["Removes an an abbreviated channel name."] = "Removes an an abbreviated channel name."
--[[Translation missing --]]
L["Replace"] = "Replace"
--[[Translation missing --]]
L["Set"] = "Set"
--[[Translation missing --]]
L["space_desc"] = "Toggle adding space after channel replacement."
--[[Translation missing --]]
L["space_name"] = "Show Space"
--[[Translation missing --]]
L["Toggle replacing this channel."] = "Toggle replacing this channel."
--[[Translation missing --]]
L["Use a custom replacement for the chat %s text."] = "Use a custom replacement for the chat %s text."


  PL:AddLocale("esMX",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "Настройки канала \"%s\"."
L["<string>"] = true
L["Add Channel Abbreviation"] = "Добавить сокращение канала"
L["addnick_desc"] = "Добавляет сокращение названий каналов. Префикс названия с '#' включает номер канала. (например '#Торговля')."
L["Blank"] = "Пустой"
L["chanlink_desc"] = "Сделать название канала ссылкой, щелчок по которой открывает окно чата этого канала."
L["chanlink_name"] = "Создать ссылку на канал"
L["Channel %d"] = "Канал %d"
L["Channel name abbreviation options."] = "Настройки сокращения названий каналов."
L["ChannelNames"] = "Названия каналов"
L["channelnick_desc"] = "Сокращение канала"
L["channelnick_name"] = "Сокращение канала"
L["Clear Channel Abbreviation"] = "Очистить сокращение канала"
L["Clears an abbreviated channel name."] = "Очищает сокращение названия канала."
L["colon_desc"] = "Вкл/Выкл добавление двоеточия после замены канала."
L["colon_name"] = "Показывать двоеточие"
L["Dont display the channel/chat type name"] = "Не показывать название канала/тип чата"
L["otheropts_desc"] = "Дополнительные настройки форматирования канала, и управление ссылками канала."
L["otheropts_name"] = "Другие настройки"
L["Remove Channel Abbreviation"] = "Удалить сокращение канала"
L["Removes an an abbreviated channel name."] = "Удаляет сокращение названий каналов."
L["Replace"] = "Заменить"
L["Set"] = "Задать"
L["space_desc"] = "Вкл/Выкл добавление пробела после замены канала."
L["space_name"] = "Показывать пробел"
L["Toggle replacing this channel."] = "Включить замену данного канала."
L["Use a custom replacement for the chat %s text."] = "Использовать заданную замену текста %s канала."


  PL:AddLocale("ruRU",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "%s 设置."
L["<string>"] = "<字符串>"
L["Add Channel Abbreviation"] = "添加频道缩写"
L["addnick_desc"] = "添加一个缩写的频道名称.名称前缀为 '#' 来包含频道数字(例如'#贸易')"
L["Blank"] = "空白"
L["chanlink_desc"] = "使频道可以点击链接打开频道聊天"
L["chanlink_name"] = "创建频道链接"
L["Channel %d"] = "频道 %d"
L["Channel name abbreviation options."] = "频道名称缩写选项"
L["ChannelNames"] = "频道名称"
L["channelnick_desc"] = "频道缩写"
L["channelnick_name"] = "频道缩写"
L["Clear Channel Abbreviation"] = "清除频道缩写"
L["Clears an abbreviated channel name."] = "清除一个频道名称缩写"
L["colon_desc"] = "频道后添加冒号"
L["colon_name"] = "显示冒号"
L["Dont display the channel/chat type name"] = "不要显示频道/聊天分类名称"
L["otheropts_desc"] = "额外的频道格式选项，以及频道链接控制"
L["otheropts_name"] = "其他选项"
L["Remove Channel Abbreviation"] = "移除频道缩写"
L["Removes an an abbreviated channel name."] = "移除一个频道名称缩写"
L["Replace"] = "替换"
L["Set"] = "设置"
L["space_desc"] = "频道后添加空格"
L["space_name"] = "显示空格"
L["Toggle replacing this channel."] = "替换频道"
L["Use a custom replacement for the chat %s text."] = "使用自定义替换此聊天 %s 文本"


  PL:AddLocale("zhCN",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "opciones %s."
L["<string>"] = "<cadena>"
L["Add Channel Abbreviation"] = "Añadir Abreviatura del Canal"
L["addnick_desc"] = "Agrega un nombre abreviado del canal. El nombre con '#' para incluir el número de canal. (por ejemplo, '#Comercio')."
L["Blank"] = "Blanco"
L["chanlink_desc"] = "Hacer del canal un vínculo clickable que abre el chat para ese canal."
L["chanlink_name"] = "Crear Enlace del Canal"
L["Channel %d"] = "Canal %d"
L["Channel name abbreviation options."] = "Opciones de abreviatura del nombre del canal."
L["ChannelNames"] = "NombresCanales"
L["channelnick_desc"] = "Abreviaturas de Canal"
L["channelnick_name"] = "Abreviaturas de Canal"
L["Clear Channel Abbreviation"] = "Limpiar Abreviatura de Canal"
L["Clears an abbreviated channel name."] = "Limpia un nombre de canal abreviado."
L["colon_desc"] = "Añade dos puntos después del canal reemplazado."
L["colon_name"] = "Mostrar dos puntos"
L["Dont display the channel/chat type name"] = "No mostrar el nombre del tipo de canal/chat"
L["otheropts_desc"] = "Opciones de formato de canal adicionales y controles de enlace del canal."
L["otheropts_name"] = "Otras Opciones"
L["Remove Channel Abbreviation"] = "Eliminar Abreviatura de Canal"
L["Removes an an abbreviated channel name."] = "Elimina un nombre de canal abreviado."
L["Replace"] = "Sustituir"
L["Set"] = "Establecer"
L["space_desc"] = "Alternar añadir un espacio después del canal reemplazado."
L["space_name"] = "Mostrar Espacio"
L["Toggle replacing this channel."] = "Alterna reemplazar este canal."
L["Use a custom replacement for the chat %s text."] = "Utilizarr un reemplazo personalizado para el texto del chat %s."


  PL:AddLocale("esES",L)



  L = {}
  -- ChannelNames
L["%s settings."] = "%s 設定。"
L["<string>"] = true
L["Add Channel Abbreviation"] = "新增頻道縮寫"
--[[Translation missing --]]
L["addnick_desc"] = "Adds an abbreviated channel name. Prefix the name with '#' to include the channel number. (e.g. '#Trade')."
L["Blank"] = "空白"
--[[Translation missing --]]
L["chanlink_desc"] = "Make the channel a clickable link which opens chat to that channel."
L["chanlink_name"] = "新建聊天連結"
L["Channel %d"] = "頻道 %d"
L["Channel name abbreviation options."] = "頻道名稱縮寫選項"
L["ChannelNames"] = "頻道名稱"
L["channelnick_desc"] = "頻道簡稱"
L["channelnick_name"] = "頻道簡稱"
L["Clear Channel Abbreviation"] = "清除頻道名稱縮寫"
L["Clears an abbreviated channel name."] = "清除縮短頻道名稱。"
--[[Translation missing --]]
L["colon_desc"] = "Toggle adding colon after channel replacement."
L["colon_name"] = "顯示冒號"
L["Dont display the channel/chat type name"] = "不要顯示頻道/聊天類型名稱"
--[[Translation missing --]]
L["otheropts_desc"] = "Additional channel formating options, and channel link controls."
L["otheropts_name"] = "其他選項"
L["Remove Channel Abbreviation"] = "移除頻道縮寫"
L["Removes an an abbreviated channel name."] = "移除縮短頻道名稱。"
L["Replace"] = "替換"
L["Set"] = "設定"
--[[Translation missing --]]
L["space_desc"] = "Toggle adding space after channel replacement."
L["space_name"] = "顯示空格"
L["Toggle replacing this channel."] = "切換替代此頻道。"
L["Use a custom replacement for the chat %s text."] = "用自訂更換聊天 %s 文字。"


  PL:AddLocale("zhTW",L)


  end
  --@end-non-debug@

	-- order to show channels
	local orderMap = {
		"say",
		"whisper",
		"whisperincome",
		"yell",
		"party",
		"partyleader",
		"guild",
		"officer",
		"raid",
		"raidleader",
		"raidwarning",
		"instance",
		"instanceleader",
		"bnwhisper",
		"bnwhisperincome",
		"bnconversation",
	}

	if not CHAT_MSG_BN_WHISPER_INFORM then
		CHAT_MSG_BN_WHISPER_INFORM = "Outgoing Real ID Whisper";
	end

	if not CHAT_MSG_INSTANCE_CHAT then
		CHAT_MSG_INSTANCE_CHAT = INSTANCE_CHAT_MESSAGE;
	end

	if not CHAT_MSG_INSTANCE_CHAT_LEADER then
		CHAT_MSG_INSTANCE_CHAT_LEADER = INSTANCE_CHAT_LEADER;
	end

	-- Look Up Our Settings Key event..message.CHANNUM
	local eventMap = {
		CHAT_MSG_CHANNEL1 = "channel1",
		CHAT_MSG_CHANNEL2 = "channel2",
		CHAT_MSG_CHANNEL3 = "channel3",
		CHAT_MSG_CHANNEL4 = "channel4",
		CHAT_MSG_CHANNEL5 = "channel5",
		CHAT_MSG_CHANNEL6 = "channel6",
		CHAT_MSG_CHANNEL7 = "channel7",
		CHAT_MSG_CHANNEL8 = "channel8",
		CHAT_MSG_CHANNEL9 = "channel9",
		CHAT_MSG_SAY = "say",
		CHAT_MSG_GUILD = "guild",
		CHAT_MSG_WHISPER = "whisperincome",
		CHAT_MSG_WHISPER_INFORM = "whisper",
		CHAT_MSG_BN_WHISPER = "bnwhisperincome",
		CHAT_MSG_BN_WHISPER_INFORM = "bnwhisper",
		CHAT_MSG_YELL = "yell",
		CHAT_MSG_PARTY = "party",
		CHAT_MSG_PARTY_LEADER = "partyleader",
		CHAT_MSG_OFFICER = "officer",
		CHAT_MSG_RAID = "raid",
		CHAT_MSG_RAID_LEADER = "raidleader",
		CHAT_MSG_RAID_WARNING = "raidwarning",
		CHAT_MSG_INSTANCE_CHAT = "instance",
		CHAT_MSG_INSTANCE_CHAT_LEADER = "instanceleader",
		CHAT_MSG_BN_CONVERSATION = "bnconversation"
	}

	local CLR = Prat.CLR

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			space = true,
			colon = true,
			chanlink = true,
			replace = {
				say = true,
				whisper = true,
				whisperincome = true,
				bnwhisper = true,
				bnwhisperincome = true,
				yell = true,
				party = true,
				partyleader = true,
				guild = true,
				officer = true,
				raid = true,
				raidleader = true,
				raidwarning = true,
				instance = true,
				instanceleader = true,
				channel1 = true,
				channel2 = true,
				channel3 = true,
				channel4 = true,
				channel5 = true,
				channel6 = true,
				channel7 = true,
				channel8 = true,
				channel9 = true,
				channel10 = true,
			},
			chanSave = {},
			shortnames = GetLocale() == "zhCN" and {
				say = "[说]",
				whisper = "[密]",
				whisperincome = "[收]",
				yell = "[喊]",
				party = "[队]",
				guild = "[会]",
				officer = "[管]",
				raid = "[团]",
				raidleader = "[酱]",
				raidwarning = "[警]",
				instance = "[战]",
				instanceleader = "[蟀]",
				channel1 = "[1]",
				channel2 = "[2]",
				channel3 = "[3]",
				channel4 = "[4]",
				channel5 = "[5]",
				channel6 = "[6]",
				channel7 = "[7]",
				channel8 = "[8]",
				channel9 = "[9]",
				channel10 = "[10]",
			} or GetLocale() == "zhTW" and {
				say = "[說]",
				whisper = "[密]",
				whisperincome = "[聽]",
				yell = "[喊]",
				party = "[隊]",
				guild = "[會]",
				officer = "[官]",
				raid = "[團]",
				raidleader = "[團長]",
				raidwarning = "[警]",
				instance = "[戰]",
				instanceleader = "[戰領]",
				channel1 = "[1]",
				channel2 = "[2]",
				channel3 = "[3]",
				channel4 = "[4]",
				channel5 = "[5]",
				channel6 = "[6]",
				channel7 = "[7]",
				channel8 = "[8]",
				channel9 = "[9]",
				channel10 = "[10]",
			} or GetLocale() == "koKR" and {
				say = "[대화]",
				whisper = "[귓말]",
				whisperincome = "[받은귓말]",
				yell = "[외침]",
				party = "[파티]",
				guild = "[길드]",
				officer = "[오피서]",
				raid = "[공대]",
				raidleader = "[공대장]",
				raidwarning = "[공대경보]",
				instance = "[전장]",
				instanceleader = "[전투대장]",
				channel1 = "[1]",
				channel2 = "[2]",
				channel3 = "[3]",
				channel4 = "[4]",
				channel5 = "[5]",
				channel6 = "[6]",
				channel7 = "[7]",
				channel8 = "[8]",
				channel9 = "[9]",
				channel10 = "[10]",
			} or {
				say = "[S]",
				whisper = "[W To]",
				whisperincome = "[W From]",
				bnwhisper = "[W To]",
				bnwhisperincome = "[W From]",
				yell = "[Y]",
				party = "[P]",
				partyleader = "[PL]",
				guild = "[G]",
				officer = "[O]",
				raid = "[R]",
				raidleader = "[RL]",
				raidwarning = "[RW]",
				instance = "[I]",
				instanceleader = "[IL]",
				channel1 = "[1]",
				channel2 = "[2]",
				channel3 = "[3]",
				channel4 = "[4]",
				channel5 = "[5]",
				channel6 = "[6]",
				channel7 = "[7]",
				channel8 = "[8]",
				channel9 = "[9]",
				channel10 = "[10]",
			},
			nickname = {}
		}
	})

	local eventPlugins = { types = {}, channels = {} }
	local nickPlugins = { nicks = {} }

	--- module.toggleOptions = { optsep227_sep = 227, optsep_sep = 229, space = 230, colon = 240, sep241_sep = 241, chanlink = 242 }
	Prat:SetModuleOptions(module.name, {
		name = PL["ChannelNames"],
		desc = PL["Channel name abbreviation options."],
		type = "group",
		childGroups = "tab",
		args = {
			etypes = {
				name = PL["ChannelNames"],
				desc = PL["Channel name abbreviation options."],
				type = "group",
				order = 1,
				plugins = eventPlugins,
				args = {}
			},
			ntypes = {
				name = PL["channelnick_name"],
				desc = PL["channelnick_desc"],
				order = 2,
				type = "group",
				plugins = nickPlugins,
				args = {}
			},
			ctypes = {
				name = PL["otheropts_name"],
				desc = PL["otheropts_desc"],
				order = 3,
				type = "group",
				args = {
					space = {
						name = PL["space_name"],
						desc = PL["space_desc"],
						type = "toggle",
					},
					colon = {
						name = PL["colon_name"],
						desc = PL["colon_desc"],
						type = "toggle",
					},
				}
			},
		}
	})

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --
	function module:OnModuleEnable()
		self:BuildChannelOptions()
		self:RegisterEvent("UPDATE_CHAT_COLOR", "RefreshOptions")
		self:RegisterEvent("CHAT_MSG_CHANNEL_NOTICE")

		Prat.RegisterChatEvent(self, "Prat_FrameMessage")

		Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_NOTICE")
		Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_NOTICE_USER")
		Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_LEAVE")
		Prat.EnableProcessingForEvent("CHAT_MSG_CHANNEL_JOIN")
	end

	function module:OnModuleDisable()
		self:UnregisterAllEvents()
		Prat.UnregisterAllChatEvents(self)
	end

	function module:GetDescription()
		return PL["Channel name abbreviation options."]
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	function module:CHAT_MSG_CHANNEL_NOTICE()
		self:BuildChannelOptions()
		self:RefreshOptions()
	end

	function module:RefreshOptions()
		LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
	end

	function module:AddNickname(info, name)
		self.db.profile.nickname[info[#info - 1]] = name
	end

	function module:RemoveNickname(info)
		if self.db.profile.nickname[info[#info - 1]] then
			self.db.profile.nickname[info[#info - 1]] = nil
		end
	end

	function module:GetNickname(info)
		return self.db.profile.nickname[info[#info - 1]]
	end

	function module:NotGetNickname(info)
		return (self:GetNickname(info) == nil) and true or false
	end

	-- replace text using prat event implementation
	function module:Prat_FrameMessage(_, message, _, event)
		if event == "CHAT_MSG_CHANNEL_JOIN" or event == "CHAT_MSG_CHANNEL_LEAVE" then
			message.MESSAGE = message.ORG.TYPEPOSTFIX:trim()
			message.ORG.TYPEPOSTFIX = " "
		end

		if event == "CHAT_MSG_CHANNEL_NOTICE" or event == "CHAT_MSG_CHANNEL_NOTICE_USER" or event == "CHAT_MSG_CHANNEL_JOIN" or event == "CHAT_MSG_CHANNEL_LEAVE" then
			event = "CHAT_MSG_CHANNEL"
		end

		local cfg

		if event == "CHAT_MSG_BN_CONVERSATION" then
			cfg = eventMap[event]
		else
			cfg = eventMap[event .. (message.CHANNELNUM or "")]
		end

		if (not issecretvalue or not issecretvalue(message.CHANNEL)) and self.db.profile.nickname[message.CHANNEL] then
			message.CHANNEL = self.db.profile.nickname[message.CHANNEL]
			if message.CHANNEL:sub(1, 1) == "#" then
				message.CHANNEL = message.CHANNEL:sub(2)
			else
				message.CHANNELNUM, message.CC = "", ""
			end
		elseif self.db.profile.replace[cfg] then
			message.cC, message.CHANNELNUM, message.CC, message.CHANNEL, message.Cc = "", "", "", "", ""
			local space = self.db.profile.space and self.db.profile.shortnames[cfg] and self.db.profile.shortnames[cfg] ~= "" and " " or ""
			local colon = ''
			if self.db.profile.colon then
				if message.PLAYER then
					colon = ":"
				elseif message.PLAYERLINK:len() > 0 and message.MESSAGE:len() > 0 then
					colon = ":"
				end
			end
			message.TYPEPREFIX = self.db.profile.shortnames[cfg] or ""

			if message.TYPEPREFIX:len() == 0 then
				message.nN, message.NN, message.Nn, message.CHANLINK = "", "", "", ""
			end

			message.TYPEPREFIX = message.TYPEPREFIX .. space

			if message.PLAYER or message.PLAYERLINK:len() > 0 then
				message.TYPEPOSTFIX = colon .. "\32"
			else
				message.TYPEPOSTFIX = ""
			end
		end
	end

	--[[------------------------------------------------
		Menu Builder Functions
	------------------------------------------------]] --
	function module:BuildChannelOptions()
		for _, v in ipairs(orderMap) do
			self:CreateTypeOption(eventPlugins["types"], v)
		end
		for i = 1, 9 do
			self:CreateChannelOption(eventPlugins["channels"], "channel" .. i, i)
		end

		local t = Prat.GetChannelTable()
		for _, v in pairs(t) do
			if type(v) == "string" then
				self:CreateChanNickOption(nickPlugins["nicks"], v)
			end
		end
	end

	function module:CreateChanNickOption(args, keyname)
		local text = keyname
		local name = keyname
		args[name] = args[name] or {
			name = text,
			desc = string.format(PL["%s settings."], text),
			type = "group",
			order = 228,
			args = {
				addnick = {
					name = PL["Add Channel Abbreviation"],
					desc = PL["addnick_desc"],
					type = "input",
					order = 140,
					usage = "<string>",
					get = "GetNickname",
					set = "AddNickname",
				},
				removenick = {
					name = PL["Remove Channel Abbreviation"],
					desc = PL["Removes an an abbreviated channel name."],
					type = "execute",
					order = 150,
					func = "RemoveNickname",
					disabled = "NotGetNickname";
				},
			}
		}
	end

	function module:GetChanOptValue(info)
		return self.db.profile[info[#info]][info[#info - 1]]
	end

	function module:SetChanOptValue(info, val)
		self.db.profile[info[#info]][info[#info - 1]] = val
	end

	do
		local function revLookup(keyname)
			for k, v in pairs(eventMap) do
				if keyname == v then
					return k
				end
			end
		end

		local function GetChatCLR(name)
			if name == nil then
				return CLR.COLOR_NONE
			end

			local type = strsub(name, 10);
			local info = ChatTypeInfo[type];
			if not info then
				return CLR.COLOR_NONE
			end
			return CLR:GetHexColor(info)
		end

		local function ChatType(text, type)
			return CLR:Colorize(GetChatCLR(type), text)
		end

		local optionGroup = {
			type = "group",
			name = function(info)
				return ChatType(_G[revLookup(info[#info])], revLookup(info[#info]))
			end,
			desc = function(info)
				return (PL["%s settings."]):format(_G[revLookup(info[#info])])
			end,
			get = "GetChanOptValue",
			set = "SetChanOptValue",
			args = {
				shortnames = {
					name = function(info)
						return ChatType(_G[revLookup(info[#info - 1])], revLookup(info[#info - 1]))
					end,
					desc = function(info)
						return (PL["Use a custom replacement for the chat %s text."]):format(ChatType(_G[revLookup(info[#info - 1])], revLookup(info[#info - 1])))
					end,
					order = 1,
					type = "input",
					usage = PL["<string>"],
				},
				replace = {
					name = PL["Replace"],
					desc = PL["Toggle replacing this channel."],
					type = "toggle",
					order = 3,
				},
			}
		}

		local optionGroupChan = {
			type = "group",
			name = function(info)
				return ChatType((PL["Channel %d"]):format(info[#info]:sub(-1)), revLookup(info[#info]))
			end,
			desc = function(info)
				return (PL["%s settings."]):format(ChatType((PL["Channel %d"]):format(info[#info]:sub(-1)), revLookup(info[#info])))
			end,
			get = "GetChanOptValue",
			set = "SetChanOptValue",
			order = function(info)
				return 200 + tonumber(info[#info]:sub(-1))
			end,
			args = {
				shortnames = {
					name = function(info)
						return ChatType((PL["Channel %d"]):format(info[#info - 1]:sub(-1)), revLookup(info[#info - 1]))
					end,
					desc = function(info)
						return (PL["Use a custom replacement for the chat %s text."]):format(ChatType((PL["Channel %d"]):format(info[#info - 1]:sub(-1)), revLookup(info[#info - 1])))
					end,
					order = 1,
					type = "input",
					usage = PL["<string>"],
				},
				replace = {
					name = PL["Replace"],
					desc = PL["Toggle replacing this channel."],
					type = "toggle",
					order = 3,
				},
			}
		}

		function module:CreateTypeOption(args, keyname)
			if not args[keyname] then
				args[keyname] = optionGroup
			end
		end

		function module:CreateChannelOption(args, keyname)
			if not args[keyname] then
				args[keyname] = optionGroupChan
			end
		end
	end

	return
end)
