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
	local module = Prat:NewModule("CustomFilters", "LibSink-2.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["module_name"] = "CustomFilters",
		["module_desc"] = "Module to support custom filters.",
		["Add Pattern"] = true,
		["Add a pattern to search for."] = true,
		["Remove Pattern"] = true,
		["Remove an existing pattern."] = true,
		["Pattern Options"] = true,
		["Inbound"] = true,
		["Outbound"] = true,
		["Search Pattern"] = true,
		["Search Format String"] = true,
		["Supplied pattern is a format string instead of a pattern"] = true,
		["<string>"] = true,
		["Replacement Text"] = true,
		["Block Message"] = true,
		["Prevent the message from being displayed"] = true,
		["Hilight Match Text"] = true,
		["Hilight Color"] = true,
		["Secondary Output"] = true,
		["Send to a secondary output"] = true,
		["Play Sound"] = true,
		["Play a sound when this message is output to the chatframe"] = true,
		["Forward"] = true,
		["ForwardMessage"] = true,
		["Forward the message to a chat channel."] = true,
		["Output Channel"] = true,
		["Channel to send output text to."] = true,
		["Channel Data"] = true,
		["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = true,
		["Output Message Only"] = true;
		["Only output the message portion of the chat text, leave out the channel, and playername etc."] = true,
		["Your name for this filter"] = true,
		["Filter Name"] = true,
		["Enabled"] = true,
		["Is this pattern enabled for use?"] = true,
		["Pattern Info"] = true,
		["Match Options"] = true,
		["inchannels_name"] = "Search Channels",
		["inchannels_desc"] = "Search in certain channels",
		["ForwardCustom"] = true,
		["ForwardMessageCustom"] = "Private Channel",
		["Forward the message to a custom chat channel."] = "Output to a private chat channel",
		chatframesink_name = "Chatframe",
		chatframesink_desc = "Output to a chat window"
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/

	--@non-debug@
  do
	  local L


  L = {}
  -- CustomFilters
L["<string>"] = true
L["Add a pattern to search for."] = true
L["Add Pattern"] = true
L["Block Message"] = true
L["Channel Data"] = true
L["Channel to send output text to."] = true
L["chatframesink_desc"] = "Output to a chat window"
L["chatframesink_name"] = "Chatframe"
L["Enabled"] = true
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = true
L["Filter Name"] = true
L["Forward"] = true
L["Forward the message to a chat channel."] = true
L["Forward the message to a custom chat channel."] = "Output to a private chat channel"
L["ForwardCustom"] = true
L["ForwardMessage"] = true
L["ForwardMessageCustom"] = "Private Channel"
L["Hilight Color"] = true
L["Hilight Match Text"] = true
L["Inbound"] = true
L["inchannels_desc"] = "Search in certain channels"
L["inchannels_name"] = "Search Channels"
L["Is this pattern enabled for use?"] = true
L["Match Options"] = true
L["module_desc"] = "Module to support custom filters."
L["module_name"] = "CustomFilters"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = true
L["Outbound"] = true
L["Output Channel"] = true
L["Output Message Only"] = true
L["Pattern Info"] = true
L["Pattern Options"] = true
L["Play a sound when this message is output to the chatframe"] = true
L["Play Sound"] = true
L["Prevent the message from being displayed"] = true
L["Remove an existing pattern."] = true
L["Remove Pattern"] = true
L["Replacement Text"] = true
L["Search Format String"] = true
L["Search Pattern"] = true
L["Secondary Output"] = true
L["Send to a secondary output"] = true
L["Supplied pattern is a format string instead of a pattern"] = true
L["Your name for this filter"] = true


	PL:AddLocale("enUS",L)



  L = {}
  -- CustomFilters
--[[Translation missing --]]
L["<string>"] = "<string>"
--[[Translation missing --]]
L["Add a pattern to search for."] = "Add a pattern to search for."
--[[Translation missing --]]
L["Add Pattern"] = "Add Pattern"
--[[Translation missing --]]
L["Block Message"] = "Block Message"
--[[Translation missing --]]
L["Channel Data"] = "Channel Data"
--[[Translation missing --]]
L["Channel to send output text to."] = "Channel to send output text to."
--[[Translation missing --]]
L["chatframesink_desc"] = "Output to a chat window"
--[[Translation missing --]]
L["chatframesink_name"] = "Chatframe"
L["Enabled"] = "Activé"
--[[Translation missing --]]
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "Extra data for WHISPER (target) and CHANNEL (channel name or num)"
L["Filter Name"] = "Nom du filtre"
L["Forward"] = "Transférer"
L["Forward the message to a chat channel."] = "Transférer le message sur un canal de discussion."
L["Forward the message to a custom chat channel."] = "Transférer vers un canal de discussion privé"
--[[Translation missing --]]
L["ForwardCustom"] = "ForwardCustom"
--[[Translation missing --]]
L["ForwardMessage"] = "ForwardMessage"
L["ForwardMessageCustom"] = "Canal privé"
--[[Translation missing --]]
L["Hilight Color"] = "Hilight Color"
--[[Translation missing --]]
L["Hilight Match Text"] = "Hilight Match Text"
--[[Translation missing --]]
L["Inbound"] = "Inbound"
--[[Translation missing --]]
L["inchannels_desc"] = "Search in certain channels"
--[[Translation missing --]]
L["inchannels_name"] = "Search Channels"
--[[Translation missing --]]
L["Is this pattern enabled for use?"] = "Is this pattern enabled for use?"
--[[Translation missing --]]
L["Match Options"] = "Match Options"
--[[Translation missing --]]
L["module_desc"] = "Module to support custom filters."
--[[Translation missing --]]
L["module_name"] = "CustomFilters"
--[[Translation missing --]]
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Only output the message portion of the chat text, leave out the channel, and playername etc."
--[[Translation missing --]]
L["Outbound"] = "Outbound"
--[[Translation missing --]]
L["Output Channel"] = "Output Channel"
--[[Translation missing --]]
L["Output Message Only"] = "Output Message Only"
--[[Translation missing --]]
L["Pattern Info"] = "Pattern Info"
--[[Translation missing --]]
L["Pattern Options"] = "Pattern Options"
--[[Translation missing --]]
L["Play a sound when this message is output to the chatframe"] = "Play a sound when this message is output to the chatframe"
--[[Translation missing --]]
L["Play Sound"] = "Play Sound"
--[[Translation missing --]]
L["Prevent the message from being displayed"] = "Prevent the message from being displayed"
--[[Translation missing --]]
L["Remove an existing pattern."] = "Remove an existing pattern."
--[[Translation missing --]]
L["Remove Pattern"] = "Remove Pattern"
--[[Translation missing --]]
L["Replacement Text"] = "Replacement Text"
--[[Translation missing --]]
L["Search Format String"] = "Search Format String"
--[[Translation missing --]]
L["Search Pattern"] = "Search Pattern"
--[[Translation missing --]]
L["Secondary Output"] = "Secondary Output"
--[[Translation missing --]]
L["Send to a secondary output"] = "Send to a secondary output"
--[[Translation missing --]]
L["Supplied pattern is a format string instead of a pattern"] = "Supplied pattern is a format string instead of a pattern"
--[[Translation missing --]]
L["Your name for this filter"] = "Your name for this filter"


	PL:AddLocale("frFR",L)



  L = {}
  -- CustomFilters
L["<string>"] = "<Zeichenfolge>"
L["Add a pattern to search for."] = "Fügt ein Muster hinzu, nach dem gesucht werden soll."
L["Add Pattern"] = "Muster hinzufügen"
L["Block Message"] = "Nachricht blockieren"
L["Channel Data"] = "Kanal-Daten"
L["Channel to send output text to."] = "Kanal, an den der Ausgabetext gesendet werden soll."
L["chatframesink_desc"] = "Ausgabe in ein Chatfenster"
L["chatframesink_name"] = "Chatrahmen"
L["Enabled"] = "Aktiviert"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "Zusätzliche Daten für FLÜSTERN (Ziel) und KANAL (Kanalname oder Nummer)"
L["Filter Name"] = "Name filtern"
L["Forward"] = "Weiterleiten"
L["Forward the message to a chat channel."] = "Leitet die Nachricht an einen Chat-Kanal weiter."
L["Forward the message to a custom chat channel."] = "Ausgabe an einen privaten Chat-Kanal"
L["ForwardCustom"] = true
L["ForwardMessage"] = "Nachricht weiterleiten"
L["ForwardMessageCustom"] = "Privater Kanal"
L["Hilight Color"] = "Farbe für Hervorhebungen"
L["Hilight Match Text"] = "Text hervorheben, der Suchbegriff entspricht"
L["Inbound"] = "Eingehend"
L["inchannels_desc"] = "Suche in bestimmten Kanälen"
L["inchannels_name"] = "Suche Kanäle"
L["Is this pattern enabled for use?"] = "Ist das Muster zur Anwendung aktiviert?"
L["Match Options"] = "Übereinstimmungsoptionen"
L["module_desc"] = "Modul zur Unterstützung eigener Filter."
L["module_name"] = "Benutzerdefinierte Filter"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Gibt nur den Nachrichtenteil des Chat-Textes aus, lässt den Kanal- und Spielernamen usw. weg."
L["Outbound"] = "Ausgehend"
L["Output Channel"] = "Ausgabekanal"
L["Output Message Only"] = "Nur Nachricht ausgeben"
L["Pattern Info"] = "Muster-Informationen"
L["Pattern Options"] = "Optionen für Muster"
L["Play a sound when this message is output to the chatframe"] = "Einen Ton abspielen, wenn diese Nachricht an das Chatfenster ausgegeben wurde."
L["Play Sound"] = "Ton abspielen"
L["Prevent the message from being displayed"] = "Verhindert, dass die Nachricht angezeigt wird"
L["Remove an existing pattern."] = "Ein vorhandenes Muster entfernen."
L["Remove Pattern"] = "Muster entfernen"
L["Replacement Text"] = "Ersatztext"
L["Search Format String"] = "Suche Formatierungs-String"
L["Search Pattern"] = "Suchmuster"
L["Secondary Output"] = "Sekundäre Ausgabe"
L["Send to a secondary output"] = "Versende eine sekundäre Ausgabe"
L["Supplied pattern is a format string instead of a pattern"] = "Geliefertes Muster ist eine Formatierungsvariable anstatt eines Musters."
L["Your name for this filter"] = "Dein Name für diesen Filter"


	PL:AddLocale("deDE",L)



  L = {}
  -- CustomFilters
L["<string>"] = "<내용>"
L["Add a pattern to search for."] = "검색할 패턴을 추가합니다."
L["Add Pattern"] = "패턴 추가"
L["Block Message"] = "메시지 차단"
L["Channel Data"] = "채널 데이터"
L["Channel to send output text to."] = "출력 내용을 보낼 채널."
L["chatframesink_desc"] = "대화창으로 출력"
L["chatframesink_name"] = "대화창"
L["Enabled"] = "사용"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "귓속말 (대상)과 채널 (채널 이름 또는 숫자)의 추가 데이터"
L["Filter Name"] = "필터 이름"
L["Forward"] = "보내기"
L["Forward the message to a chat channel."] = "메시지를 대화 채널로 보내기."
L["Forward the message to a custom chat channel."] = "사설 채널로 출력"
L["ForwardCustom"] = "사설 채널로 보내기"
L["ForwardMessage"] = "메시지 보내기"
L["ForwardMessageCustom"] = "사설 채널"
L["Hilight Color"] = "색상 강조"
L["Hilight Match Text"] = "일치하는 문자 강조"
L["Inbound"] = "받는 메시지"
L["inchannels_desc"] = "특정 채널에서 검색"
L["inchannels_name"] = "채널 검색"
L["Is this pattern enabled for use?"] = "이 패턴을 사용하기 위해 활성화 할까요?"
L["Match Options"] = "일치 옵션"
L["module_desc"] = "사용자 설정 필터를 지원하는 모듈입니다."
L["module_name"] = "사용자 설정 필터 [CustomFilters]"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "대화 문자열, 채널 나감, 플레이어 이름 등의 메시지 부분만 출력합니다."
L["Outbound"] = "보낸 메시지"
L["Output Channel"] = "출력 채널"
L["Output Message Only"] = "출력 메시지만"
L["Pattern Info"] = "패턴 정보"
L["Pattern Options"] = "패턴 옵션"
L["Play a sound when this message is output to the chatframe"] = "이 메시지가 대화창에 출력되면 소리를 재생합니다"
L["Play Sound"] = "소리 재생"
L["Prevent the message from being displayed"] = "표시 중인 메시지 차단하기"
L["Remove an existing pattern."] = "저장 중인 패턴을 제거합니다."
L["Remove Pattern"] = "패턴 삭제"
L["Replacement Text"] = "대체 텍스트"
L["Search Format String"] = "형식 구문 검색"
L["Search Pattern"] = "패턴 검색"
L["Secondary Output"] = "보조 출력"
L["Send to a secondary output"] = "보조 출력으로 전송하기"
L["Supplied pattern is a format string instead of a pattern"] = "제공된 패턴은 패턴이 아닌 형식 구문입니다"
L["Your name for this filter"] = "이 필터의 이름"


	PL:AddLocale("koKR",L)



  L = {}
  -- CustomFilters
--[[Translation missing --]]
L["<string>"] = "<string>"
--[[Translation missing --]]
L["Add a pattern to search for."] = "Add a pattern to search for."
--[[Translation missing --]]
L["Add Pattern"] = "Add Pattern"
--[[Translation missing --]]
L["Block Message"] = "Block Message"
--[[Translation missing --]]
L["Channel Data"] = "Channel Data"
--[[Translation missing --]]
L["Channel to send output text to."] = "Channel to send output text to."
--[[Translation missing --]]
L["chatframesink_desc"] = "Output to a chat window"
--[[Translation missing --]]
L["chatframesink_name"] = "Chatframe"
--[[Translation missing --]]
L["Enabled"] = "Enabled"
--[[Translation missing --]]
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "Extra data for WHISPER (target) and CHANNEL (channel name or num)"
--[[Translation missing --]]
L["Filter Name"] = "Filter Name"
--[[Translation missing --]]
L["Forward"] = "Forward"
--[[Translation missing --]]
L["Forward the message to a chat channel."] = "Forward the message to a chat channel."
--[[Translation missing --]]
L["Forward the message to a custom chat channel."] = "Output to a private chat channel"
--[[Translation missing --]]
L["ForwardCustom"] = "ForwardCustom"
--[[Translation missing --]]
L["ForwardMessage"] = "ForwardMessage"
--[[Translation missing --]]
L["ForwardMessageCustom"] = "Private Channel"
--[[Translation missing --]]
L["Hilight Color"] = "Hilight Color"
--[[Translation missing --]]
L["Hilight Match Text"] = "Hilight Match Text"
--[[Translation missing --]]
L["Inbound"] = "Inbound"
--[[Translation missing --]]
L["inchannels_desc"] = "Search in certain channels"
--[[Translation missing --]]
L["inchannels_name"] = "Search Channels"
--[[Translation missing --]]
L["Is this pattern enabled for use?"] = "Is this pattern enabled for use?"
--[[Translation missing --]]
L["Match Options"] = "Match Options"
--[[Translation missing --]]
L["module_desc"] = "Module to support custom filters."
--[[Translation missing --]]
L["module_name"] = "CustomFilters"
--[[Translation missing --]]
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Only output the message portion of the chat text, leave out the channel, and playername etc."
--[[Translation missing --]]
L["Outbound"] = "Outbound"
--[[Translation missing --]]
L["Output Channel"] = "Output Channel"
--[[Translation missing --]]
L["Output Message Only"] = "Output Message Only"
--[[Translation missing --]]
L["Pattern Info"] = "Pattern Info"
--[[Translation missing --]]
L["Pattern Options"] = "Pattern Options"
--[[Translation missing --]]
L["Play a sound when this message is output to the chatframe"] = "Play a sound when this message is output to the chatframe"
--[[Translation missing --]]
L["Play Sound"] = "Play Sound"
--[[Translation missing --]]
L["Prevent the message from being displayed"] = "Prevent the message from being displayed"
--[[Translation missing --]]
L["Remove an existing pattern."] = "Remove an existing pattern."
--[[Translation missing --]]
L["Remove Pattern"] = "Remove Pattern"
--[[Translation missing --]]
L["Replacement Text"] = "Replacement Text"
--[[Translation missing --]]
L["Search Format String"] = "Search Format String"
--[[Translation missing --]]
L["Search Pattern"] = "Search Pattern"
--[[Translation missing --]]
L["Secondary Output"] = "Secondary Output"
--[[Translation missing --]]
L["Send to a secondary output"] = "Send to a secondary output"
--[[Translation missing --]]
L["Supplied pattern is a format string instead of a pattern"] = "Supplied pattern is a format string instead of a pattern"
--[[Translation missing --]]
L["Your name for this filter"] = "Your name for this filter"


	PL:AddLocale("esMX",L)



  L = {}
  -- CustomFilters
L["<string>"] = true
L["Add a pattern to search for."] = "Добавить образец для поиска."
L["Add Pattern"] = "Добавить образец"
L["Block Message"] = "Блокировка сообщения"
L["Channel Data"] = "Канал данных"
L["Channel to send output text to."] = "Канал для отсылки выходящего текста."
L["chatframesink_desc"] = "Вывод в окно чата"
L["chatframesink_name"] = "Чатфрейм "
L["Enabled"] = "Включено"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "Добавочные данные для ШЕПОТА (цель) и КАНАЛА (название канала или номер)"
L["Filter Name"] = "Название фильтра"
L["Forward"] = "Пересылать"
L["Forward the message to a chat channel."] = "Пересылать сообщение в канал чата."
L["Forward the message to a custom chat channel."] = "Вывод в частный канал"
L["ForwardCustom"] = true
L["ForwardMessage"] = true
L["ForwardMessageCustom"] = "Частный канал"
L["Hilight Color"] = "Цвет выделения"
L["Hilight Match Text"] = "Выделение текста"
L["Inbound"] = "Входящие"
L["inchannels_desc"] = "Поиск в определённых каналах"
L["inchannels_name"] = "Поиск канала"
L["Is this pattern enabled for use?"] = "Включить в использование данный шаблон?"
L["Match Options"] = "Опции совпадения"
L["module_desc"] = "Модуль поддерживающий пользовательские фильтры."
L["module_name"] = "CustomFilters"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Вывод только части сообщений, выход с канала, имя игрока и т.д."
L["Outbound"] = "Исходящие"
L["Output Channel"] = "Канал вывода"
L["Output Message Only"] = "Только вывод сообщения"
L["Pattern Info"] = "Шаблон"
L["Pattern Options"] = "Настройки образца"
L["Play a sound when this message is output to the chatframe"] = "Проиграть звук когда данное сообщение выводится в окно чата."
L["Play Sound"] = "Проиграть звук"
L["Prevent the message from being displayed"] = "Предотвращает отображение сообщения"
L["Remove an existing pattern."] = "Удалить существующий образец."
L["Remove Pattern"] = "Удалить образец"
L["Replacement Text"] = "Замена текста"
L["Search Format String"] = "Формат строки поиска"
L["Search Pattern"] = "Образец поиска"
L["Secondary Output"] = "Вторичный вывод"
L["Send to a secondary output"] = "Отослать на вторичный вывод"
L["Supplied pattern is a format string instead of a pattern"] = "Поставляется оброзец формата строки вместо шаблона"
L["Your name for this filter"] = "Ваше имя для данного фильтра"


	PL:AddLocale("ruRU",L)



  L = {}
  -- CustomFilters
L["<string>"] = true
L["Add a pattern to search for."] = "添加一个搜索模板"
L["Add Pattern"] = "添加模板"
L["Block Message"] = "消息阻止"
L["Channel Data"] = "频道数据"
L["Channel to send output text to."] = "频道发送输出文本"
--[[Translation missing --]]
L["chatframesink_desc"] = "Output to a chat window"
--[[Translation missing --]]
L["chatframesink_name"] = "Chatframe"
L["Enabled"] = "启用"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "密语(目标)和频道(频道名称或数字)的扩展数据"
L["Filter Name"] = "过滤器名字"
L["Forward"] = "转发"
L["Forward the message to a chat channel."] = "转发信息到聊天频道"
L["Forward the message to a custom chat channel."] = "输出到一个私人频道"
L["ForwardCustom"] = "自定义传送"
L["ForwardMessage"] = "信息转发"
L["ForwardMessageCustom"] = "私有频道"
L["Hilight Color"] = "颜色高亮"
L["Hilight Match Text"] = "高亮匹配文本"
L["Inbound"] = "输入范围"
L["inchannels_desc"] = "在当前频道搜索"
L["inchannels_name"] = "搜索频道"
L["Is this pattern enabled for use?"] = "这个样式启用了吗？"
L["Match Options"] = "适配选项"
L["module_desc"] = "支持自定义过滤的模块"
L["module_name"] = "自定义过滤"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "仅在聊天文本中输出部分信息，移除频道和玩家姓名等"
L["Outbound"] = "输出范围"
L["Output Channel"] = "输出频道"
L["Output Message Only"] = "只输出信息"
L["Pattern Info"] = "样式信息"
L["Pattern Options"] = "模块选项"
L["Play a sound when this message is output to the chatframe"] = "当信息在聊天框输出时播放声音"
L["Play Sound"] = "播放声音"
L["Prevent the message from being displayed"] = "阻止信息被现实"
L["Remove an existing pattern."] = "移除现有模板"
L["Remove Pattern"] = "移除模板"
L["Replacement Text"] = "替换文本"
L["Search Format String"] = "搜索格式字符串"
L["Search Pattern"] = "搜索模板"
L["Secondary Output"] = "二次输出"
L["Send to a secondary output"] = "发送二次输出"
L["Supplied pattern is a format string instead of a pattern"] = "支持模板是格式字符串而非模板"
L["Your name for this filter"] = "这个过滤器的名字"


	PL:AddLocale("zhCN",L)



  L = {}
  -- CustomFilters
L["<string>"] = "<cadena>"
L["Add a pattern to search for."] = "Añadir un patrón de búsqueda."
L["Add Pattern"] = "Añadir Patrón"
L["Block Message"] = "Bloque de Mensaje"
L["Channel Data"] = "Datos de Canal"
L["Channel to send output text to."] = "Canal a enviar el texto de salida"
--[[Translation missing --]]
L["chatframesink_desc"] = "Output to a chat window"
--[[Translation missing --]]
L["chatframesink_name"] = "Chatframe"
L["Enabled"] = "Activado"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "Datos extra para SUSURRAR (objetivo) y CANAL (nombre de canal o número)"
L["Filter Name"] = "Nombre del Filtro"
L["Forward"] = "Reenviar"
L["Forward the message to a chat channel."] = "Reenviar el mensaje a un canal de chat."
L["Forward the message to a custom chat channel."] = "Salida a un canal privado de chat"
L["ForwardCustom"] = "Reenviar Personalizado"
L["ForwardMessage"] = "ReenviarMensaje"
L["ForwardMessageCustom"] = "Canal Privado"
L["Hilight Color"] = "Color Resaltado"
L["Hilight Match Text"] = "Texto Coincidente Resaltado"
L["Inbound"] = "Entrante"
L["inchannels_desc"] = "Buscar en algunos canales"
L["inchannels_name"] = "Buscar canales"
L["Is this pattern enabled for use?"] = "¿Está habilitado este patrón para su uso?"
L["Match Options"] = "Opciones de Coincidencias"
L["module_desc"] = "Módulo para soportar filtros personalizados."
L["module_name"] = "Filtros Personalizados"
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Sólo mostrar la parte del mensaje del chat de texto, omitir el canal, nombre de jugador, etc."
L["Outbound"] = "Saliente"
L["Output Channel"] = "Canal de Salida"
L["Output Message Only"] = "Solo Mensajes Salientes"
L["Pattern Info"] = "Patrón de Información"
L["Pattern Options"] = "Opciones de Patrón"
L["Play a sound when this message is output to the chatframe"] = "Reproducir un sonido cuando este mensaje sale en el marco de chat"
L["Play Sound"] = "Reproducir Sonido"
L["Prevent the message from being displayed"] = "Impedir que el mensaje sea visualizado"
L["Remove an existing pattern."] = "Elimina un patrón existente."
L["Remove Pattern"] = "Eliminar Patrón"
L["Replacement Text"] = "Sustitución de texto"
L["Search Format String"] = "Cadena de Formato de Búsqueda"
L["Search Pattern"] = "Patrón de Búsqueda"
L["Secondary Output"] = "Salida Secundaria"
L["Send to a secondary output"] = "Enviar a un salida secundaria"
L["Supplied pattern is a format string instead of a pattern"] = "El patrón suministrado es una cadena de formato en lugar de un patrón"
L["Your name for this filter"] = "Su nombre para este filtro"


	PL:AddLocale("esES",L)



  L = {}
  -- CustomFilters
L["<string>"] = true
L["Add a pattern to search for."] = "新增模式搜索。"
L["Add Pattern"] = "新增樣式"
L["Block Message"] = "屏蔽訊息"
L["Channel Data"] = "頻道資料"
L["Channel to send output text to."] = "頻道發送輸出文字至。"
--[[Translation missing --]]
L["chatframesink_desc"] = "Output to a chat window"
--[[Translation missing --]]
L["chatframesink_name"] = "Chatframe"
L["Enabled"] = "已啟用"
L["Extra data for WHISPER (target) and CHANNEL (channel name or num)"] = "額外資料密話(目標)和頻道(頻道名稱或數字)"
L["Filter Name"] = "過濾名稱"
L["Forward"] = "轉送"
L["Forward the message to a chat channel."] = "轉送訊息至聊天頻道"
L["Forward the message to a custom chat channel."] = "轉送名稱至自訂聊天頻道"
L["ForwardCustom"] = "自訂轉送"
L["ForwardMessage"] = "轉送訊息"
L["ForwardMessageCustom"] = "私人頻道"
L["Hilight Color"] = "高亮提示色彩"
L["Hilight Match Text"] = "符合高亮提示文字"
L["Inbound"] = "傳入"
L["inchannels_desc"] = "搜尋某些頻道"
L["inchannels_name"] = "搜尋頻道"
--[[Translation missing --]]
L["Is this pattern enabled for use?"] = "Is this pattern enabled for use?"
L["Match Options"] = "匹配選項"
L["module_desc"] = "支援自訂過濾的模組"
L["module_name"] = "自定義過濾"
--[[Translation missing --]]
L["Only output the message portion of the chat text, leave out the channel, and playername etc."] = "Only output the message portion of the chat text, leave out the channel, and playername etc."
L["Outbound"] = "傳出"
L["Output Channel"] = "輸出頻道"
L["Output Message Only"] = "僅輸出訊息"
L["Pattern Info"] = "樣式資訊"
L["Pattern Options"] = "模式選項"
--[[Translation missing --]]
L["Play a sound when this message is output to the chatframe"] = "Play a sound when this message is output to the chatframe"
L["Play Sound"] = "播放音效"
--[[Translation missing --]]
L["Prevent the message from being displayed"] = "Prevent the message from being displayed"
L["Remove an existing pattern."] = "替換文本"
L["Remove Pattern"] = "移除模板"
L["Replacement Text"] = "替換文字"
L["Search Format String"] = "搜尋格式字串"
L["Search Pattern"] = "搜尋樣式"
L["Secondary Output"] = "次要輸出"
L["Send to a secondary output"] = "發送次要輸出"
--[[Translation missing --]]
L["Supplied pattern is a format string instead of a pattern"] = "Supplied pattern is a format string instead of a pattern"
L["Your name for this filter"] = "你的名字此過濾"


	PL:AddLocale("zhTW",L)


  end
  --@end-non-debug@

	local eventMap = {
		CHAT_MSG_CHANNEL_LIST = true,
		CHAT_MSG_SAY = true,
		CHAT_MSG_GUILD = true,
		CHAT_MSG_WHISPER_INFORM = true,
		CHAT_MSG_WHISPER = true,
		CHAT_MSG_YELL = true,
		CHAT_MSG_PARTY = true,
		CHAT_MSG_PARTY_LEADER = true,
		CHAT_MSG_OFFICER = true,
		CHAT_MSG_RAID = true,
		CHAT_MSG_RAID_LEADER = true,
		CHAT_MSG_INSTANCE_CHAT = true,
		CHAT_MSG_INSTANCE_CHAT_LEADER = true,
	}

	local eventTypes = {}
	local function getTypes()
		for k, _ in pairs(ChatTypeGroup) do
			eventTypes[k] = _G["CHAT_MSG_" .. k]
		end
		for _, v in ipairs(Prat.GetChannelTable()) do
			eventTypes[v] = "Channel: " .. v
		end
		eventTypes.WHISPER_INFORM = CHAT_MSG_WHISPER_INFORM
		eventTypes.CHANNEL = CHANNEL
		return eventTypes
	end

	local function getTypesConfig()
		local types = getTypes()

		local keys = {}
		for k in pairs(types) do
			table.insert(keys, k)
		end
		table.sort(keys, function(a, b)
			return strcmputf8i(types[a], types[b]) < 0
		end)

		local result = {}

		for index, k in ipairs(keys) do
			result[k] = {
				type = "toggle",
				name = types[k],
				desc = k,
				order = index,
			}
		end

		return result
	end

	local newmap = {}
	for _, v in ipairs(eventMap) do
		newmap[v] = v
	end
	eventMap = newmap

	local patterndefaults = {
		["*"] = {
			enabled = true,
			sink20OutputSink = "None",
			replacement_is_code = false,
			outputmessageonly = true,
			inchannels = {
				SYSTEM = true,
				SAY = true,
				EMOTE = true,
				YELL = true,
				WHISPER = true,
				WHISPER_INFORM = true,
				PARTY = true,
				RAID = true,
				RAID_LEADER = true,
				RAID_WARNING = true,
				INSTANCE_CHAT = true,
				INSTANCE_CHAT_LEADER = true,
				GUILD = true,
				GUILD_OFFICER = true,
				MONSTER_SAY = true,
				MONSTER_YELL = true,
				MONSTER_EMOTE = true,
				MONSTER_WHISPER = true,
				MONSTER_BOSS_EMOTE = true,
				MONSTER_BOSS_WHISPER = true,
				ERRORS = true,
				AFK = true,
				DND = true,
				IGNORED = true,
				BG_HORDE = true,
				BG_ALLIANCE = true,
				BG_NEUTRAL = true,
				COMBAT_XP_GAIN = true,
				COMBAT_HONOR_GAIN = true,
				COMBAT_FACTION_CHANGE = true,
				SKILL = true,
				MONEY = true,
				OPENING = true,
				TRADESKILLS = true,
				PET_INFO = true,
				COMBAT_MISC_INFO = true,
				ACHIEVEMENT = true,
				GUILD_ACHIEVEMENT = true,
				CHANNEL = true,
			}
		}
	}
	Prat:SetModuleDefaults(module, {
		profile = {
			on = false,
			inbound = patterndefaults,
			outbound = patterndefaults,
			outputchannel = CHAT_MSG_SAY,
			outputchanneldata = "",
			sinkoptions = {}
		}
	})

	local modeOptions = {
		mode = {
			inbound = {
				type = "group",
				name = PL["Inbound"],
				desc = PL["Inbound"],
				args = {}
			},
			outbound = {
				type = "group",
				name = PL["Outbound"],
				desc = PL["Outbound"],
				args = {}
			},
		}
	}

	Prat:SetModuleOptions(module, {
		name = PL["module_name"],
		desc = PL["module_desc"],
		type = "group",
		plugins = modeOptions,
		args = {
			outputchannel = {
				type = "select",
				name = PL["Output Channel"],
				desc = PL["Channel to send output text to."],
				order = 110,
				values = eventMap,
			},
			outputchanneldata = {
				type = "input",
				order = 115,
				name = PL["Channel Data"],
				desc = PL["Extra data for WHISPER (target) and CHANNEL (channel name or num)"],
				usage = "<string>",
				disabled = function(info)
					return not (info.handler.db.profile.outputchannel == CHAT_MSG_WHISPER_INFORM or
						info.handler.db.profile.outputchannel == CHAT_MSG_CHANNEL_LIST)
				end
			},
			outputmessageonly = {
				type = "toggle",
				name = PL["Output Message Only"],
				desc = PL["Only output the message portion of the chat text, leave out the channel, and playername etc."],
				order = 118,
			}
		}
	})

	function module:BuildModeOptions(mode, opts)
		local po = opts[mode].args

		self[mode] = {}
		self[mode].validate = {}

		--    po.pathdr = {
		--        type = "header",
		--        name = PL["Pattern Options"],
		--        order = 80,
		--    }

		for k, v in pairs(self.db.profile[mode]) do
			self:AddPatternOptions(po, v.name or k, mode, k)
			self[mode].validate[k] = v.name or k
		end

		--    po.opspc = {
		--        type = "header",
		--        order = 94,
		--    }

		po.addpattern = {
			name = PL["Add Pattern"],
			desc = PL["Add a pattern to search for."],
			type = "input",
			usage = PL["<string>"],
			get = false,
			set = "AddPattern"
		}

		po.removepattern = {
			name = PL["Remove Pattern"],
			desc = PL["Remove an existing pattern."],
			type = "select",
			get = function()
				return ""
			end,
			set = "RemovePattern",
			values = self[mode].validate,
			disabled = function(info)
				return next(info.handler.db.profile[info[#info - 1]]) == nil
			end,
		}
	end

	function module:DisableOutputOption(info)
		return not self.db.profile[info[#info - 3]][info[#info - 2]].tosink
	end

	function module:AddPatternOptions(o, pattern, mode, key)
		key = key or pattern
		o[key] = o[key] or {}
		local po = o[key]
		local settings = self.db.profile[mode][key]
		po.type = "group"
		po.name = pattern
		po.desc = pattern
		po.order = 90

		po.args = {
			name = {
				order = 1,
				type = "input",
				name = PL["Filter Name"],
				desc = PL["Your name for this filter"],
				get = "GetPatternValue",
				set = "UpdatePatternValue",
			},
			enabled = {
				order = 5,
				type = "toggle",
				name = PL["Enabled"],
				desc = PL["Is this pattern enabled for use?"],
				get = "GetPatternValue",
				set = "UpdatePatternValue",
			},
			opspc9 = {
				name = PL["Pattern Info"],
				type = "header",
				order = 9,
			},
			searchfor = {
				order = 10,
				type = "input",
				name = PL["Search Pattern"],
				desc = PL["Search Pattern"],
				usage = PL["<string>"],
				get = "GetPatternValue",
				set = "UpdatePatternValue"
			},
			inchannels = {
				name = PL["inchannels_name"],
				desc = PL["inchannels_desc"],
				type = "group",
				inline = true,
				order = 110,
				args = getTypesConfig(),
				get = "GetChannelPatternSubValue",
				set = "SetChannelPatternSubValue",
			},
			--        searchfordeformat = {
			--            type = "toggle",
			--            name = PL["Search Format String"],
			--            desc = PL["SuPLied pattern is a format string instead of a pattern"],
			--            get = "GetPatternValue",
			--            set = "UpdatePatternValue"
			--            },
			replacewith = {
				order = 20,
				type = "input",
				name = PL["Replacement Text"],
				desc = PL["Replacement Text"],
				usage = PL["<string>"],
				get = "GetPatternValue",
				set = "UpdatePatternValue",
				disabled = "GetDisableReplace",
			},
			opspc29 = {
				name = PL["Match Options"],
				type = "header",
				order = 29,
			},
			block = {
				type = "toggle",
				name = PL["Block Message"],
				desc = PL["Prevent the message from being displayed"],
				get = "GetPatternValue",
				set = "SetPatternValue"
			},
			tosink = {
				type = "toggle",
				name = PL["Secondary Output"],
				desc = PL["Send to a secondary output"],
				get = "GetPatternValue",
				set = "SetPatternValue"
			},
			sound = {
				type = "select",
				name = PL["Play Sound"],
				desc = PL["Play a sound when this message is output to the chatframe"],
				dialogControl = 'LSM30_Sound',
				get = "GetPatternValue",
				set = "SetPatternValue",
				values = AceGUIWidgetLSMlists.sound,
			},
			hilight = {
				type = "toggle",
				name = PL["Hilight Match Text"],
				desc = PL["Hilight Match Text"],
				get = "GetPatternValue",
				set = "UpdatePatternValue",
				disabled = "GetBlockMessage",
			},
			hilight_color = {
				type = "color",
				name = PL["Hilight Color"],
				desc = PL["Hilight Color"],
				get = "GetPatternColorValue",
				set = "SetPatternColorValue",
				disabled = "GetBlockMessage",
			},
			replacement_is_code = {
				type = "toggle",
				get = "GetPatternValue",
				set = "SetPatternValue",
				name = "Replacement is Lua code",
				desc = "Replacement is Lua code",
			}
		}

		self.SetSinkStorage(settings, settings)

		po.args.outputmessageonly = {
			type = "toggle",
			name = PL["Output Message Only"],
			desc = PL["Only output the message portion of the chat text, leave out the channel, and playername etc."],
			order = 190,
			get = "GetPatternValue",
			set = "UpdatePatternValue",
		}
		po.args.output = self.GetSinkAce3OptionsDataTable(settings)
		po.args.output.inline = true
		po.args.output.order = 200
		po.args.output.disabled = "DisableOutputOption"
	end

	local CLR = Prat.CLR

	local function match(text, matchopts, mode)
		if (not matchopts) or (not matchopts.enabled) then
			return
		end

		local matchtype
		if mode == "inbound" then
			matchtype = "FRAME"
		else
			matchtype = "OUTBOUND"
		end

		local textout = text

		if mode == "inbound" then
			local chatype = Prat.SplitMessage.CHATTYPE
			local typeopt = matchopts.inchannels[chatype]

			if Prat.SplitMessage.CHATTYPE == "CHANNEL" then
				local channelopt = matchopts.inchannels[Prat.SplitMessage.ORG.CHANNEL]

				if channelopt == false then
					return
				end
				if channelopt == nil and not typeopt then
					return
				end
			else
				if not typeopt then
					return
				end
			end
		end

		if matchopts.replacewith and matchopts.replacewith ~= matchopts.searchfor then
			if matchopts.replacement_is_code then
				textout = loadstring(matchopts.replacewith)(text)
			else
				textout = textout:gsub(matchopts.searchfor, matchopts.replacewith)
			end
		end

		if matchopts.hilight then
			local hexcolor = CLR:GetHexColor(matchopts.hilight_color)
			textout = CLR:Colorize(hexcolor, textout)
		end

		if matchopts.sink20OutputSink then
			if mode == "inbound" then
				Prat.SplitMessage.CF_SINK_OUT = matchopts
			else
				Prat.SplitMessageOut.CF_SINK_OUT = matchopts
			end
		end

		if matchopts.tosink then
			if mode == "inbound" then
				Prat.SplitMessage.CF_SINK = true
			else
				Prat.SplitMessageOut.CF_SINK = true
			end
		end

		if matchopts.sound then
			if mode == "inbound" then
				Prat.SplitMessage.CF_SOUND = matchopts.sound
			else
				Prat.SplitMessageOut.CF_SOUND = matchopts.sound
			end
		end

		if matchopts.block then
			if mode == "inbound" then
				Prat.SplitMessage.DONOTPROCESS = true
			else
				Prat.SplitMessageOut.DONOTPROCESS = true
			end
		end

		textout = Prat:RegisterMatch(textout, matchtype)
		--  end

		return textout
	end

	function module:RegisterPattern(matchopts, mode)
		local matchtype
		if mode == "inbound" then
			matchtype = "FRAME"
		else
			matchtype = "OUTBOUND"
		end
		local patterninfo = {
			pattern = matchopts.searchfor,
			matchopts = matchopts,
			matchfunc = function(text)
				return match(text, matchopts, mode)
			end,
			type = matchtype,
			deformat = matchopts.deformat,
			priority = 46
		}

		Prat:RegisterPattern(patterninfo, self.name)

		table.insert(self.modulePatterns, patterninfo)
	end

	function module:UnregisterPattern(matchopts)
		local patterninfo
		for _, v in pairs(self.modulePatterns) do
			if v.matchopts == matchopts then
				patterninfo = v
			end
		end

		if patterninfo == nil then
			return
		end

		if patterninfo.idx then
			Prat:UnregisterPattern(patterninfo.idx)
		end

		local idx
		for k, v in pairs(self.modulePatterns) do
			if v == patterninfo then
				idx = k
			end
		end

		table.remove(self.modulePatterns, idx)
	end

	function module:UpdatePattern(matchopts)
		local patterninfo
		for _, v in pairs(self.modulePatterns) do
			if v.matchopts == matchopts then
				patterninfo = v
			end
		end

		if patterninfo == nil then
			return
		end

		local mode
		if patterninfo.type == "FRAME" then
			mode = "inbound"
		else
			mode = "outbound"
		end

		patterninfo.pattern = matchopts.searchfor
		patterninfo.deformat = matchopts.deformat
		patterninfo.matchfunc = function(text)
			return match(text, matchopts, mode)
		end
	end

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	Prat:SetModuleInit(module,
		function(self)

			self:RegisterSink(PL.chatframesink_name,
				PL.chatframesink_name,
				PL.chatframesink_desc,
				"ChatframeSink",
				function()
					local keys = {}
					for k, v in pairs(Prat.HookedFrames) do
						if not v.isTemporary and (v:IsShown() or v.isDocked) then
							keys[#keys + 1] = v.name or k
						end
					end

					return keys
				end)

			local modeOpts = modeOptions.mode
			for k, _ in pairs(modeOpts) do
				self:BuildModeOptions(k, modeOpts)
			end

			self:SetSinkStorage(self.db.profile.sinkoptions)
			modeOpts.output = self:GetSinkAce3OptionsDataTable()
			modeOpts.output.inline = true
		end)

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		self.modulePatterns = {}
		local modeOpts = modeOptions.mode
		for mode, _ in pairs(modeOpts) do
			if type(self.db.profile[mode]) == "table" then
				for _, patopts in pairs(self.db.profile[mode]) do
					if patopts.enabled then
						self:RegisterPattern(patopts, mode)
					end
				end
			end
		end

		Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE)
		Prat.RegisterChatEvent(self, Prat.Events.POST_ADDMESSAGE_BLOCKED, "Prat_PostAddMessage")
	end

	function module:OnModuleDisable()
		self.modulePatterns = nil
		Prat.UnregisterAllChatEvents(self)
	end

	function module:Prat_PostAddMessage(_, message, _, event, text, r, g, b)
		local uid = message.LINE_ID
		if uid and
			uid == self.lastevent and
			self.lasteventtype == event then
			return
		end

		self.lasteventtype = event
		self.lastevent = uid

		if message.CF_SINK or message.CF_SINK_OUT then
			if message.CF_SINK_OUT.outputmessageonly then
				self.Pour(message.CF_SINK_OUT or self, message.MESSAGE, r, g, b)
			else
				self.Pour(message.CF_SINK_OUT or self, text, r, g, b)
			end
		end

		if message.CF_SOUND then
			Prat:PlaySound(message.CF_SOUND)
		end
	end


	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --

	function module:GetPatternValue(info)
		return self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]]
	end

	function module:UpdatePatternValue(info, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = v
		self:UpdatePattern(self.db.profile[info[#info - 2]][info[#info - 1]])
	end

	function module:SetPatternValue(info, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = v
	end

	function module:GetPatternSubValue(info, val)
		return self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]][val]
	end

	function module:SetPatternSubValue(info, val, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]][val] = v
	end

	function module:GetChannelPatternSubValue(info)
		local v = self.db.profile[info[#info - 3]][info[#info - 2]][info[#info - 1]][info[#info]]

		if ChatTypeGroup[info[#info]] or v ~= nil then
			return v
		end

		return self.db.profile[info[#info - 3]][info[#info - 2]][info[#info - 1]]["CHANNEL"]
	end

	function module:SetChannelPatternSubValue(info, v)
		self.db.profile[info[#info - 3]][info[#info - 2]][info[#info - 1]][info[#info]] = v
	end

	function module:SetPatternName(info, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = v
	end

	function module:GetPatternColorValue(info)
		local c = self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]]
		if c == nil then
			self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = { r = 1, g = 1, b = 1, a = 1 }
			c = self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]]
		end
		return c.r, c.g, c.b, c.a
	end

	function module:SetPatternColorValue(info, r, g, b, a)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = { r = r, g = g, b = b, a = a }
	end

	function module:GetPatternSearch(info)
		return self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]]
	end

	function module:SetPatternSearch(info, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = v
		self:UpdatePattern(self.db.profile[info[#info - 2]][info[#info - 1]])
	end

	function module:GetPatternReplace(info)
		return self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]]
	end

	function module:SetPatternReplace(info, v)
		self.db.profile[info[#info - 2]][info[#info - 1]][info[#info]] = v
		self:UpdatePattern(self.db.profile[info[#info - 2]][info[#info - 1]])
	end

	function module:GetPatternHilight(p)
		return p.hilight
	end

	function module:SetPatternHilight(p, v)
		p.hilight = v

		self:UpdatePattern(p)
	end

	function module:GetDisableReplace(p)
		return p.block or p.tosink
	end

	function module:GetBlockMessage(p)
		return p.block
	end

	function module:SetBlockMessage(p, v)
		p.block = v
	end

	function module:GetSinkMessage(p)
		return p.tosink
	end

	function module:SetSinkMessage(p, v)
		p.tosink = v
	end

	function module:GetSoundMessage(p)
		return p.sound
	end

	function module:SetSoundMessage(p, v)
		p.sound = v

		Prat:PlaySound(v)
	end

	local white_clr = { r = 1.0, b = 1.0, g = 1.0 }
	function module:GetPatternHilightClr(p)
		local h = p.hilight_color or white_clr
		return h.r or 1.0, h.g or 1.0, h.b or 1.0
	end

	function module:SetPatternHilightClr(p, r, g, b)
		p.hilight_color = p.hilight_color or {}
		local h = p.hilight_color
		h.r, h.g, h.b = r, g, b

		self:UpdatePattern(p)
	end

	function module:AddPattern(info, pattern)
		local mode = info[#info - 1]
		local p = self.db.profile[mode]

		for _, v in pairs(p) do
			if v.name == pattern then
				return
			end
		end

		self[mode].validate = self[mode].validate or {}
		local v = self[mode].validate

		local num = 0
		while rawget(p, "pat" .. num) ~= nil do
			num = num + 1
		end

		local key = "pat" .. num

		p[key] = p[key] or {}
		p[key].name = pattern
		p[key].searchfor = pattern
		p[key].replacewith = "%1"

		v[key] = pattern

		local o = modeOptions.mode[mode].args
		self:AddPatternOptions(o, pattern, mode, key)

		self:RegisterPattern(p[key], mode)

		self:RefreshOptions()
	end

	function module:RemovePattern(info, pattern)
		local mode = info[#info - 1]
		local p = self.db.profile[mode]
		local key, name

		if type(pattern) == "number" then
			name = self[mode].validate[pattern]
		else
			name = pattern
		end

		for k, v in pairs(p) do
			if k == name then
				key = k
				break
			end

			if v.name == name then
				key = k
				break
			end
		end

		if key == nil then
			return
		end

		self:UnregisterPattern(p[key])

		p[key] = nil

		modeOptions.mode[mode].args = {}

		self:BuildModeOptions(mode, modeOptions.mode)

		self:RefreshOptions()
	end

	function module:RefreshOptions()
		LibStub("AceConfigRegistry-3.0"):NotifyChange("Prat")
	end

	function module:ChatframeSink(source, text, r, g, b)
		local sink = LibStub("LibSink-2.0")
		local s = sink.storageForAddon[source]
		local name = s and s.sink20ScrollArea or ""

		for k, v in pairs(Prat.HookedFrames) do
			if k == name or v.name == name then
				v:AddMessage(text, r, g, b)
				return
			end
		end
	end

	return
end)
