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
	local module = Prat:NewModule("Timestamps", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Timestamps"] = true,
		["Chat window timestamp options."] = true,
		["Show Timestamp"] = true,
		["Toggle showing timestamp for each window."] = true,
		["show_name"] = "Show Timestamp",
		["show_desc"] = "Toggle showing timestamp on and off for each window.",
		["Set the timestamp format"] = true,
		["Format All Timestamps"] = true,
		["colortimestamp_name"] = "Color Timestamp",
		["colortimestamp_desc"] = "Toggle coloring the timestamp on and off.",
		["Set Timestamp Color"] = true,
		["Sets the color of the timestamp."] = true,
		["localtime_name"] = "Use Local Time",
		["localtime_desc"] = "Toggle using local time on and off.",
		["space_name"] = "Show Space",
		["space_desc"] = "Toggle adding space after timestamp on and off.",
		["twocolumn_name"] = "2 Column Chat",
		["twocolumn_desc"] = "Place the timestamps in a separate column so the text does not wrap underneath them",
		["HH:MM:SS AM (12-hour)"] = true,
		["HH:MM:SS (12-hour)"] = true,
		["HH:MM:SS (24-hour)"] = true,
		["HH:MM AM (12-hour)"] = true,
		["HH:MM (12-hour)"] = true,
		["HH:MM (24-hour)"] = true,
		["MM:SS"] = true,
		["Post-Timestamp"] = true,
		["Pre-Timestamp"] = true,
		["Timestamp Text Format"] = true,
		["Other Formatting Options"] = true,
		["Date Format"] = true,
		["Set the format for the day/month/year"] = true,
		["dd/mm/yy"] = true,
		["mm/dd/yy"] = true,
		["mm/dd"] = true,
		["dd/mm"] = true,
		["None"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L


  L = {}
  -- Timestamps
L["Chat window timestamp options."] = true
L["colortimestamp_desc"] = "Toggle coloring the timestamp on and off."
L["colortimestamp_name"] = "Color Timestamp"
L["Date Format"] = true
L["dd/mm"] = true
L["dd/mm/yy"] = true
L["Format All Timestamps"] = true
L["HH:MM (12-hour)"] = true
L["HH:MM (24-hour)"] = true
L["HH:MM AM (12-hour)"] = true
L["HH:MM:SS (12-hour)"] = true
L["HH:MM:SS (24-hour)"] = true
L["HH:MM:SS AM (12-hour)"] = true
L["localtime_desc"] = "Toggle using local time on and off."
L["localtime_name"] = "Use Local Time"
L["mm/dd"] = true
L["mm/dd/yy"] = true
L["MM:SS"] = true
L["None"] = true
L["Other Formatting Options"] = true
L["Post-Timestamp"] = true
L["Pre-Timestamp"] = true
L["Set the format for the day/month/year"] = true
L["Set the timestamp format"] = true
L["Set Timestamp Color"] = true
L["Sets the color of the timestamp."] = true
L["Show Timestamp"] = true
L["show_desc"] = "Toggle showing timestamp on and off for each window."
L["show_name"] = "Show Timestamp"
L["space_desc"] = "Toggle adding space after timestamp on and off."
L["space_name"] = "Show Space"
L["Timestamp Text Format"] = true
L["Timestamps"] = true
L["Toggle showing timestamp for each window."] = true
L["twocolumn_desc"] = "Place the timestamps in a separate column so the text does not wrap underneath them"
L["twocolumn_name"] = "2 Column Chat"


	  PL:AddLocale("enUS",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "Options de l'heure des messages."
L["colortimestamp_desc"] = "Active/Désactive la couleur de l'heure des messages."
L["colortimestamp_name"] = "Couleur de l'heure"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "Formatage de l'heure"
L["HH:MM (12-hour)"] = "HH:MM (12 heures)"
L["HH:MM (24-hour)"] = "HH:MM (24 heures)"
--[[Translation missing --]]
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-hour)"
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12 heures)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24 heures)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12 heures)"
L["localtime_desc"] = "Active/Désactive l'utilisation de l'heure locale."
L["localtime_name"] = "Utiliser l'heure locale"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = true
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Other Formatting Options"] = "Other Formatting Options"
L["Post-Timestamp"] = "Après l'heure"
L["Pre-Timestamp"] = "Avant l'heure"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "Définit le format de l'heure."
L["Set Timestamp Color"] = "Configurer la couleur"
L["Sets the color of the timestamp."] = "Définit la couleur de l'heure des messages."
L["Show Timestamp"] = "Montrer l'heure des messages"
L["show_desc"] = "Active/Désactive l'affiche de l'heure pour chaque fenêtre."
L["show_name"] = "Montrer l'heure des messages"
L["space_desc"] = "Active/Désactive l'ajout d'un espace après l'heure."
L["space_name"] = "Montrer l'espace"
--[[Translation missing --]]
L["Timestamp Text Format"] = "Timestamp Text Format"
L["Timestamps"] = "Heure des messages"
L["Toggle showing timestamp for each window."] = "Active/Désactive l'affiche de l'heure des messages pour chaque fenêtre."
L["twocolumn_desc"] = "Place l'heure dans une colonne séparée de manière à ce qu'aucun texte ne s'écrive en dessous de l'heure."
L["twocolumn_name"] = "Discussion à 2 colonnes"


	  PL:AddLocale("frFR",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "Optionen für Zeitstempel in Chatfenstern."
L["colortimestamp_desc"] = "Färbung des Zeitstempels ein- und ausschalten."
L["colortimestamp_name"] = "Zeitstempel färben"
L["Date Format"] = "Datumsformat"
L["dd/mm"] = "tt/mm"
L["dd/mm/yy"] = "tt/mm/jj"
L["Format All Timestamps"] = "Formatiert alle Zeitstempel"
L["HH:MM (12-hour)"] = "HH:MM (12-Stunden)"
L["HH:MM (24-hour)"] = "HH:MM (24-Stunden)"
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-Stunden)"
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12-Stunden)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-Stunden)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-Stunden)"
L["localtime_desc"] = "Verwendung der Ortszeit ein- und ausschalten."
L["localtime_name"] = "Ortszeit verwenden"
L["mm/dd"] = "mm/tt"
L["mm/dd/yy"] = "mm/tt/jj"
L["MM:SS"] = true
L["None"] = "Keines"
L["Other Formatting Options"] = "Andere Formatierungsoptionen"
L["Post-Timestamp"] = "Nach-Zeitstempel"
L["Pre-Timestamp"] = "Vor-Zeitstempel"
L["Set the format for the day/month/year"] = "Lege das Format für Tag/Monat/Jahr fest"
L["Set the timestamp format"] = "Format für Zeitstempel einstellen"
L["Set Timestamp Color"] = "Farbe für Zeitstempel einstellen"
L["Sets the color of the timestamp."] = "Stellt die Farbe des Zeitstempels ein."
L["Show Timestamp"] = "Zeitstempel anzeigen"
L["show_desc"] = "Anzeige des Zeitstempels für jedes Fenster ein- und ausschalten."
L["show_name"] = "Zeitstempel anzeigen"
L["space_desc"] = "Das Einfügen eines Leerzeichens nach dem Zeitstempel ein- und ausschalten."
L["space_name"] = "Leerzeichen anzeigen"
L["Timestamp Text Format"] = "Zeitstempel-Textformat"
L["Timestamps"] = "Zeitstempel"
L["Toggle showing timestamp for each window."] = "Anzeige des Zeitstempels für jedes Fenster umschalten."
L["twocolumn_desc"] = "Platziere die Zeitstempel in einer getrennten Spalte, so dass der Text nicht unterhalb der Zeitstempel dargestellt wird."
L["twocolumn_name"] = "2-Spalten-Chat"


	  PL:AddLocale("deDE",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "대화창 대화 시각 옵션입니다."
L["colortimestamp_desc"] = "대화 시각에 색상을 입히거나 입히지 않습니다."
L["colortimestamp_name"] = "대화 시각 색상 지정"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "모든 대화 시각 형식"
L["HH:MM (12-hour)"] = "시:분 (12시간)"
L["HH:MM (24-hour)"] = "시:분 (24시간)"
L["HH:MM AM (12-hour)"] = "시:분 오전 (12시간)"
L["HH:MM:SS (12-hour)"] = "시:분:초 (12시간)"
L["HH:MM:SS (24-hour)"] = "시:분:초 (24시간)"
L["HH:MM:SS AM (12-hour)"] = "시:분:초 오전 (12시간)"
L["localtime_desc"] = "시스템 시간 사용을 켜고 끕니다."
L["localtime_name"] = "시스템 시간 사용"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = "분:초"
--[[Translation missing --]]
L["None"] = "None"
L["Other Formatting Options"] = "다른 형식 옵션"
L["Post-Timestamp"] = "뒤-대화 시각"
L["Pre-Timestamp"] = "앞-대화 시각"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "대화 시각 형식을 설정합니다."
L["Set Timestamp Color"] = "대화 시각 색상 설정"
L["Sets the color of the timestamp."] = "대화 시각의 색상을 설정합니다."
L["Show Timestamp"] = "대화 시각 표시"
L["show_desc"] = "각 창에 대해 대화 시각 표시를 켜고 끕니다."
L["show_name"] = "대화 시각 표시"
L["space_desc"] = "시간 표시 뒤에 공간을 넣을 지 선택합니다."
L["space_name"] = "공간 삽입"
L["Timestamp Text Format"] = "대화 시각 문자 형식"
L["Timestamps"] = "대화 시각 [Timestamps]"
L["Toggle showing timestamp for each window."] = "각 창 별로 대화 시각 표시 기능을 켜거나 끕니다."
L["twocolumn_desc"] = "대화 시각을 분리된 열에 배치시켜 글자가 줄바꿈되지 않도록 합니다."
L["twocolumn_name"] = "열 분리"


	  PL:AddLocale("koKR",L)



  L = {}
  -- Timestamps
--[[Translation missing --]]
L["Chat window timestamp options."] = "Chat window timestamp options."
--[[Translation missing --]]
L["colortimestamp_desc"] = "Toggle coloring the timestamp on and off."
--[[Translation missing --]]
L["colortimestamp_name"] = "Color Timestamp"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
--[[Translation missing --]]
L["Format All Timestamps"] = "Format All Timestamps"
--[[Translation missing --]]
L["HH:MM (12-hour)"] = "HH:MM (12-hour)"
--[[Translation missing --]]
L["HH:MM (24-hour)"] = "HH:MM (24-hour)"
--[[Translation missing --]]
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-hour)"
--[[Translation missing --]]
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12-hour)"
--[[Translation missing --]]
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-hour)"
--[[Translation missing --]]
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-hour)"
--[[Translation missing --]]
L["localtime_desc"] = "Toggle using local time on and off."
--[[Translation missing --]]
L["localtime_name"] = "Use Local Time"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
--[[Translation missing --]]
L["MM:SS"] = "MM:SS"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Other Formatting Options"] = "Other Formatting Options"
--[[Translation missing --]]
L["Post-Timestamp"] = "Post-Timestamp"
--[[Translation missing --]]
L["Pre-Timestamp"] = "Pre-Timestamp"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
--[[Translation missing --]]
L["Set the timestamp format"] = "Set the timestamp format"
--[[Translation missing --]]
L["Set Timestamp Color"] = "Set Timestamp Color"
--[[Translation missing --]]
L["Sets the color of the timestamp."] = "Sets the color of the timestamp."
--[[Translation missing --]]
L["Show Timestamp"] = "Show Timestamp"
--[[Translation missing --]]
L["show_desc"] = "Toggle showing timestamp on and off for each window."
--[[Translation missing --]]
L["show_name"] = "Show Timestamp"
--[[Translation missing --]]
L["space_desc"] = "Toggle adding space after timestamp on and off."
--[[Translation missing --]]
L["space_name"] = "Show Space"
--[[Translation missing --]]
L["Timestamp Text Format"] = "Timestamp Text Format"
--[[Translation missing --]]
L["Timestamps"] = "Timestamps"
--[[Translation missing --]]
L["Toggle showing timestamp for each window."] = "Toggle showing timestamp for each window."
--[[Translation missing --]]
L["twocolumn_desc"] = "Place the timestamps in a separate column so the text does not wrap underneath them"
--[[Translation missing --]]
L["twocolumn_name"] = "2 Column Chat"


	  PL:AddLocale("esMX",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "Настройки времени в окне чата."
L["colortimestamp_desc"] = "Вкл/Выкл окрасу времени."
L["colortimestamp_name"] = "Окраска времени"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "Формат всего времени"
L["HH:MM (12-hour)"] = "HH:MM (12-ч)"
L["HH:MM (24-hour)"] = "HH:MM (24-ч)"
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-ч)"
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12-ч)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-ч)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-ч)"
L["localtime_desc"] = "Вкл/Выкл использование местного времени."
L["localtime_name"] = "Местное время"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = true
--[[Translation missing --]]
L["None"] = "None"
L["Other Formatting Options"] = "Другие параметры форматирования"
L["Post-Timestamp"] = "Перед-временем"
L["Pre-Timestamp"] = "После-времени"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "Установите формат времени "
L["Set Timestamp Color"] = "Цвет времени"
L["Sets the color of the timestamp."] = "Установка цвета времени."
L["Show Timestamp"] = "Показывать время"
L["show_desc"] = "Вкл/Выкл отображение времени во всех окнах."
L["show_name"] = "Показывать время"
L["space_desc"] = "Вкл/Выкл добавление пробела после времени."
L["space_name"] = "Пробел"
L["Timestamp Text Format"] = "Текстовый формат метки времени"
L["Timestamps"] = "Отображение времени"
L["Toggle showing timestamp for each window."] = "Вкл/Выкл отображение времени во всех окнах."
L["twocolumn_desc"] = "Помещает время в отдельную колонку, чтобы текст не переносился на строку под ним."
L["twocolumn_name"] = "Чат в 2 колонки"


	  PL:AddLocale("ruRU",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "聊天窗口时间戳选项"
L["colortimestamp_desc"] = "时间戳着色开关"
L["colortimestamp_name"] = "彩色时间戳"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "所有时间戳格式"
L["HH:MM (12-hour)"] = "时:分 (12-小时)"
L["HH:MM (24-hour)"] = "时:分 (24-小时)"
--[[Translation missing --]]
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-hour)"
L["HH:MM:SS (12-hour)"] = "时:分:秒 (12-小时)"
L["HH:MM:SS (24-hour)"] = "时:分:秒 (24-小时)"
L["HH:MM:SS AM (12-hour)"] = "时:分:秒 上午(12-小时)"
L["localtime_desc"] = "本地时间使用开关"
L["localtime_name"] = "使用本地时间"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = "分:秒"
--[[Translation missing --]]
L["None"] = "None"
L["Other Formatting Options"] = "其他设置"
L["Post-Timestamp"] = "后缀-时间戳"
L["Pre-Timestamp"] = "前缀-时间戳"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "设置时间戳格式"
L["Set Timestamp Color"] = "设置时间戳颜色"
L["Sets the color of the timestamp."] = "设置时间戳颜色"
L["Show Timestamp"] = "显示时间戳"
L["show_desc"] = "为各个窗口选取显示时间戳开关"
L["show_name"] = "显示时间戳"
L["space_desc"] = "在时间戳后添加空格"
L["space_name"] = "显示空格"
L["Timestamp Text Format"] = "时间戳格式"
L["Timestamps"] = "时间戳"
L["Toggle showing timestamp for each window."] = "为各个窗口切换显示时间戳"
L["twocolumn_desc"] = "放置时间戳在一个单独的栏，文本不包括其中"
L["twocolumn_name"] = "2栏聊天"


	  PL:AddLocale("zhCN",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "Opciones de MáscaraTiempo de la ventana de chat."
L["colortimestamp_desc"] = "Alterna activación de colorear máscara de tiempo."
L["colortimestamp_name"] = "Color Máscara de Tiempo"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "Formatear Todas las Mascaras de Tiempo"
L["HH:MM (12-hour)"] = "HH:MM (12-horas)"
L["HH:MM (24-hour)"] = "HH:MM (24-horas)"
--[[Translation missing --]]
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-hour)"
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12-horas)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24-horas)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12-horas)"
L["localtime_desc"] = "Activa o desactiva el uso de la hora local."
L["localtime_name"] = "Utilizar Hora Local"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = true
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Other Formatting Options"] = "Other Formatting Options"
L["Post-Timestamp"] = "Post-MáscaraTiempo"
L["Pre-Timestamp"] = "Pre-MáscaraTiempo"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "Establecer el formato de la Máscara de Tiempo"
L["Set Timestamp Color"] = "Establecer Color MáscaraTiempo"
L["Sets the color of the timestamp."] = "Establece el Color de la Máscara de Tiempo."
L["Show Timestamp"] = "Mostrar MáscaraTiempo"
L["show_desc"] = "Alterna activación de mostrar máscara de tiempo para cada ventana."
L["show_name"] = "Mostrar Máscara de Tiempo"
L["space_desc"] = "Alterna activación de añadir un espacio tras la máscara de tiempo."
L["space_name"] = "Mostrar Espacio"
--[[Translation missing --]]
L["Timestamp Text Format"] = "Timestamp Text Format"
L["Timestamps"] = "Máscara de Tiempo"
L["Toggle showing timestamp for each window."] = "Alterna mostrar máscara de tiempo para cada ventana."
L["twocolumn_desc"] = "Colocar las máscaras de hora en una columna separada por lo que el texto no se ajustará debajo de ellas"
L["twocolumn_name"] = "2 Columnas Chat"


	  PL:AddLocale("esES",L)



  L = {}
  -- Timestamps
L["Chat window timestamp options."] = "聊天視窗時間戳選項"
L["colortimestamp_desc"] = "切換是否為時間戳著色。"
L["colortimestamp_name"] = "時間戳色彩"
--[[Translation missing --]]
L["Date Format"] = "Date Format"
--[[Translation missing --]]
L["dd/mm"] = "dd/mm"
--[[Translation missing --]]
L["dd/mm/yy"] = "dd/mm/yy"
L["Format All Timestamps"] = "所有時間戳格式"
L["HH:MM (12-hour)"] = "HH:MM (12時制)"
L["HH:MM (24-hour)"] = "HH:MM (24時制)"
--[[Translation missing --]]
L["HH:MM AM (12-hour)"] = "HH:MM AM (12-hour)"
L["HH:MM:SS (12-hour)"] = "HH:MM:SS (12時制)"
L["HH:MM:SS (24-hour)"] = "HH:MM:SS (24時制)"
L["HH:MM:SS AM (12-hour)"] = "HH:MM:SS AM (12時制)"
L["localtime_desc"] = "切換是否使用本地時間"
L["localtime_name"] = "使用本地時間"
--[[Translation missing --]]
L["mm/dd"] = "mm/dd"
--[[Translation missing --]]
L["mm/dd/yy"] = "mm/dd/yy"
L["MM:SS"] = true
--[[Translation missing --]]
L["None"] = "None"
L["Other Formatting Options"] = "其他设置"
L["Post-Timestamp"] = "貼出時間戳"
L["Pre-Timestamp"] = "時間標籤"
--[[Translation missing --]]
L["Set the format for the day/month/year"] = "Set the format for the day/month/year"
L["Set the timestamp format"] = "設定時間戳格式"
L["Set Timestamp Color"] = "設定時間戳色彩"
L["Sets the color of the timestamp."] = "設定時間戳色彩。"
L["Show Timestamp"] = "顯示時間戳"
L["show_desc"] = "切換顯示時間標籤"
L["show_name"] = "顯示時間戳"
--[[Translation missing --]]
L["space_desc"] = "Toggle adding space after timestamp on and off."
L["space_name"] = "顯示空白"
L["Timestamp Text Format"] = "时间戳格式"
L["Timestamps"] = "時間戳"
L["Toggle showing timestamp for each window."] = "切換是否在個別視窗顯示時間戳。"
--[[Translation missing --]]
L["twocolumn_desc"] = "Place the timestamps in a separate column so the text does not wrap underneath them"
L["twocolumn_name"] = "兩欄式聊天"


	  PL:AddLocale("zhTW",L)


	end
	--@end-non-debug@

	module.pluginopts = {}

	-- Chatter (Antiarc)
	local TIME_FORMATS = {
		["%I:%M:%S %p"] = PL["HH:MM:SS AM (12-hour)"],
		["%I:%M:%S"] = PL["HH:MM:SS (12-hour)"],
		["%X"] = PL["HH:MM:SS (24-hour)"],
		["%I:%M %p"] = PL["HH:MM AM (12-hour)"],
		["%I:%M"] = PL["HH:MM (12-hour)"],
		["%H:%M"] = PL["HH:MM (24-hour)"],
		["%M:%S"] = PL["MM:SS"],
	}
	local DATE_FORMATS = {
		[""] = PL["None"],
		["%d/%m/%y"] = PL["dd/mm/yy"],
		["%m/%d/%y"] = PL["mm/dd/yy"],
		["%d/%m"] = PL["dd/mm"],
		["%m/%d"] = PL["mm/dd"],
	}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			show = { ["*"] = true },
			formatcode = "%X",
			formatdate = "",
			formatpre = "[",
			formatpost = "]",
			["timestampcolor"] = {
				["b"] = 0.592156862745098,
				["g"] = 0.592156862745098,
				["r"] = 0.592156862745098,
				a = 1
			},
			colortimestamp = true,
			space = true,
			localtime = true,
			twocolumn = false,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["Timestamps"],
		desc = PL["Chat window timestamp options."],
		type = "group",
		plugins = module.pluginopts,
		args = {
			show = {
				name = PL["Show Timestamp"],
				desc = PL["Toggle showing timestamp for each window."],
				type = "multiselect",
				order = 120,
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			helpheader = {
				name = PL["Timestamp Text Format"],
				type = "header",
				order = 129,
			},
			formatpre = {
				name = PL["Pre-Timestamp"],
				desc = PL["Pre-Timestamp"],
				type = "input",
				order = 130,
				usage = "<string>",
			},
			formatcode = {
				name = PL["Format All Timestamps"],
				desc = PL["Set the timestamp format"],
				type = "select",
				order = 131,
				values = TIME_FORMATS,
			},
			formatpost = {
				name = PL["Post-Timestamp"],
				desc = PL["Post-Timestamp"],
				type = "input",
				order = 145,
				usage = "<string>",
			},
			formatdate = {
				name = PL["Date Format"],
				desc = PL["Set the format for the day/month/year"],
				type = "select",
				order = 150,
				values = DATE_FORMATS,
			},
			colortimestamp = {
				name = PL["colortimestamp_name"],
				desc = PL["colortimestamp_desc"],
				type = "toggle",
				get = function(info)
					return info.handler:GetValue(info)
				end,
				order = 171,
			},
			localtime = {
				name = PL["localtime_name"],
				desc = PL["localtime_desc"],
				type = "toggle",
				order = 171,
			},
			space = {
				name = PL["space_name"],
				desc = PL["space_desc"],
				type = "toggle",
				order = 171,
			},
			otherheader = {
				name = PL["Other Formatting Options"],
				type = "header",
				order = 170,
			},
			timestampcolor = {
				name = PL["Set Timestamp Color"],
				desc = PL["Sets the color of the timestamp."],
				type = "color",
				order = 181,
				get = "GetColorValue",
				set = "SetColorValue",
				disabled = "IsTimestampPlain",
			},
		},
	})

	Prat:SetModuleInit(module, function(self)
		-- Disable blizz timestamps if possible
		local proxy = {}
		if Prat.IsClassic then
			proxy.CHAT_TIMESTAMP_FORMAT = false -- nil would defer to __index
		else
			proxy.GetChatTimestampFormat = function()
			end
		end
		local CF_MEH_env = setmetatable(proxy, { __index = _G, __newindex = _G })
		if _G.ChatFrameMixin and _G.ChatFrameMixin.MessageEventHandler then
			setfenv(_G.ChatFrameMixin.MessageEventHandler, CF_MEH_env)
		elseif _G["ChatFrame_MessageEventHandler"] and issecurevariable("ChatFrame_MessageEventHandler") then
			setfenv(_G.ChatFrame_MessageEventHandler, CF_MEH_env)
		else
			self:Output("Could not install hook")
		end

		for _, v in pairs(Prat.HookedFrames) do
			self:SecureHook(v, "AddMessage")
		end
	end)

	function module:OnModuleEnable()
		for _, v in pairs(Prat.HookedFrames) do
			if not self:IsHooked(v, "AddMessage") then
				self:SecureHook(v, "AddMessage")
			end
		end
		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_REMOVED)
	end

	function module:OnModuleDisable()
		for _, v in pairs(Prat.HookedFrames) do
			if self:IsHooked(v, "AddMessage") then
				self:Unhook(v, "AddMessage")
			end
		end
	end

	function module:GetDescription()
		return PL["Chat window timestamp options."]
	end

	function module:Prat_FramesUpdated(_, _, chatFrame)
		if not self:IsHooked(chatFrame, "AddMessage") then
			self:SecureHook(chatFrame, "AddMessage")
		end
	end

	function module:Prat_FramesRemoved(_, _, chatFrame)
		if self:IsHooked(chatFrame, "AddMessage") then
			self:Unhook(chatFrame, "AddMessage")
		end
	end

	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --
	local lastParsed
	function module:AddMessage(frame)
		if self.db.profile.on and self.db.profile.show and self.db.profile.show[frame:GetName()] and not Prat.loading then
			local entry = frame.historyBuffer:GetEntryAtIndex(1)
			if lastParsed == entry then
				return
			end
			entry.message = self:InsertTimestamp(entry.message, frame)
			lastParsed = entry
		end
	end

	function module:IsTimestampPlain()
		return not self.db.profile.colortimestamp
	end

	local function Timestamp(text)
		if not module:IsTimestampPlain() then
			return Prat.CLR:Colorize(module.db.profile.timestampcolor, text)
		end
		return text
	end

	function module:PlainTimestampNotAllowed()
		return false
	end

	function module:InsertTimestamp(text, cf)
		if type(text) == "string" then
			local db = self.db.profile
			local space = db.space
			local code = db.formatcode
			if db.formatdate ~= "" then
				code = db.formatdate .. " " .. code
			end
			local fmt = db.formatpre .. code .. db.formatpost

			if cf and cf:GetJustifyH() == "RIGHT" then
				return text .. (space and " " or "") .. Timestamp(self:GetTime(fmt))
			end
			return Timestamp(self:GetTime(fmt)) .. (space and " " or "") .. text
		end

		return text
	end

	function module:GetTime(format)
		if self.db.profile.localtime then
			return date(format)
		end
		return date(format, GetServerTime())
	end

	return
end) -- Prat:AddModuleToLoad
