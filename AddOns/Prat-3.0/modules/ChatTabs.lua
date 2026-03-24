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
	local module = Prat:NewModule("ChatTabs", "AceHook-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Tabs"] = true,
		["Chat window tab options."] = true,
		["Set Display Mode"] = true,
		["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)",
		["Set ChatFrame%d Display Mode"] = true,
		["Set tab display to always, hidden or the Blizzard default."] = true,
		["Active Alpha"] = true,
		["Sets alpha of chat tab for active chat frame."] = true,
		["Not Active Alpha"] = true,
		["Sets alpha of chat tab for not active chat frame."] = true,
		["Show Tab Textures"] = true,
		["All"] = true,
		["Individual"] = true,
		["Always"] = true,
		["Hidden"] = true,
		["Default"] = true,
		["disablewhisperflash_name"] = "Disable Flash for Whispers",
		["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers.",
		["preventdrag_name"] = "Prevent Dragging",
		["preventdrag_desc"] = "Prevent dragging chat tabs with mouse",
		["Set Flash On Message"] = true,
		["Change Font Color On Message"] = true,
		["Flash Color"] = true,
		["Font Color"] = true,
		["Visibility"] = true,
		["Highlighting/Flashing"] = true,
		["foreveralert_name"] = "Keep highlighting until tab button clicked",
		["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses",
		["Chat Alert Timeout"] = true,
		["How long any highlights/flashes should last"] = true,
		["Tab Font Size"] = true,
		["Set the font size for chat tab names."] = true,
		["keephighlightinactive_name"] = "Only keep highlighting if tab is not active",
		["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L

  L = {}
  -- ChatTabs
L["Active Alpha"] = true
L["All"] = true
L["Always"] = true
L["Change Font Color On Message"] = true
L["Chat Alert Timeout"] = true
L["Chat window tab options."] = true
L["Default"] = true
L["disableflash_desc"] = "Disable flashing of the chat tabs."
L["disableflash_name"] = "Disable Flashing"
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
L["Flash Color"] = true
L["Font Color"] = true
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = true
L["Highlighting/Flashing"] = true
L["How long any highlights/flashes should last"] = true
L["Individual"] = true
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = true
L["preventdrag_desc"] = "Prevent dragging chat tabs with mouse"
L["preventdrag_name"] = "Prevent Dragging"
L["Set ChatFrame%d Display Mode"] = true
L["Set Display Mode"] = true
L["Set Flash Color"] = true
L["Set Flash On Message"] = true
L["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)"
L["Set tab display to always, hidden or the Blizzard default."] = true
L["Set the font size for chat tab names."] = true
L["Sets alpha of chat tab for active chat frame."] = true
L["Sets alpha of chat tab for not active chat frame."] = true
L["Show Tab Textures"] = true
L["Tab Font Size"] = true
L["Tabs"] = true
L["Visibility"] = true

  PL:AddLocale("enUS", L)



  L = {}
  -- ChatTabs
--[[Translation missing --]]
L["Active Alpha"] = "Active Alpha"
--[[Translation missing --]]
L["All"] = "All"
--[[Translation missing --]]
L["Always"] = "Always"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
--[[Translation missing --]]
L["Chat window tab options."] = "Chat window tab options."
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["disableflash_desc"] = "Disable flashing of the chat tabs."
--[[Translation missing --]]
L["disableflash_name"] = "Disable Flashing"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
--[[Translation missing --]]
L["Hidden"] = "Hidden"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
--[[Translation missing --]]
L["Individual"] = "Individual"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
--[[Translation missing --]]
L["Not Active Alpha"] = "Not Active Alpha"
--[[Translation missing --]]
L["preventdrag_desc"] = "Prevent dragging chat tabs with mouse"
--[[Translation missing --]]
L["preventdrag_name"] = "Prevent Dragging"
--[[Translation missing --]]
L["Set ChatFrame%d Display Mode"] = "Set ChatFrame%d Display Mode"
--[[Translation missing --]]
L["Set Display Mode"] = "Set Display Mode"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
--[[Translation missing --]]
L["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)"
--[[Translation missing --]]
L["Set tab display to always, hidden or the Blizzard default."] = "Set tab display to always, hidden or the Blizzard default."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
--[[Translation missing --]]
L["Sets alpha of chat tab for active chat frame."] = "Sets alpha of chat tab for active chat frame."
--[[Translation missing --]]
L["Sets alpha of chat tab for not active chat frame."] = "Sets alpha of chat tab for not active chat frame."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
--[[Translation missing --]]
L["Tabs"] = "Tabs"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("itIT", L)



  L = {}
  -- ChatTabs
--[[Translation missing --]]
L["Active Alpha"] = "Active Alpha"
--[[Translation missing --]]
L["All"] = "All"
--[[Translation missing --]]
L["Always"] = "Always"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
--[[Translation missing --]]
L["Chat window tab options."] = "Chat window tab options."
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["disableflash_desc"] = "Disable flashing of the chat tabs."
--[[Translation missing --]]
L["disableflash_name"] = "Disable Flashing"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
--[[Translation missing --]]
L["Hidden"] = "Hidden"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
--[[Translation missing --]]
L["Individual"] = "Individual"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
--[[Translation missing --]]
L["Not Active Alpha"] = "Not Active Alpha"
--[[Translation missing --]]
L["preventdrag_desc"] = "Prevent dragging chat tabs with mouse"
--[[Translation missing --]]
L["preventdrag_name"] = "Prevent Dragging"
--[[Translation missing --]]
L["Set ChatFrame%d Display Mode"] = "Set ChatFrame%d Display Mode"
--[[Translation missing --]]
L["Set Display Mode"] = "Set Display Mode"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
--[[Translation missing --]]
L["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)"
--[[Translation missing --]]
L["Set tab display to always, hidden or the Blizzard default."] = "Set tab display to always, hidden or the Blizzard default."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
--[[Translation missing --]]
L["Sets alpha of chat tab for active chat frame."] = "Sets alpha of chat tab for active chat frame."
--[[Translation missing --]]
L["Sets alpha of chat tab for not active chat frame."] = "Sets alpha of chat tab for not active chat frame."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
--[[Translation missing --]]
L["Tabs"] = "Tabs"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("ptBR", L)


  L = {}
  -- ChatTabs
L["Active Alpha"] = "Transparence"
L["All"] = "Tout"
L["Always"] = "Toujours"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "Options des onglets des fenêtres de discussion."
L["Default"] = "Défaut"
L["disableflash_desc"] = "Désactiver le clignotement des onglets."
L["disableflash_name"] = "Pas de clignotement"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "Caché"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = "Individuel"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "Transparence inactive"
L["preventdrag_desc"] = "Empêcher le déplacement des onglets avec la souris"
L["preventdrag_name"] = "Verrouiller"
L["Set ChatFrame%d Display Mode"] = "Définir le mode d'affichage de la fenêtre de discussion %d"
L["Set Display Mode"] = "Mode d'affichage"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "Définir le mode d'affichage des onglets pour chaque fenêtre de chat. Coché (On), Décoché (Off) Coché en gris (Défaut)"
L["Set tab display to always, hidden or the Blizzard default."] = "Définir l'affichage des onglets sur toujours, caché ou par défaut Blizzard"
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "Définit la transparence de l'onglet pour les fenêtres de discussion actives."
L["Sets alpha of chat tab for not active chat frame."] = "Définit la transparence de l'onglet pour les fenêtres de discussion inactives."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "Onglets"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("frFR",L)




  L = {}
  -- ChatTabs
L["Active Alpha"] = "Aktive Transparenz"
L["All"] = "Alle"
L["Always"] = "Immer"
L["Change Font Color On Message"] = "Ändert die Schriftfarbe der Nachricht"
L["Chat Alert Timeout"] = "Zeitüberschreitung bei Chat-Benachrichtigung"
L["Chat window tab options."] = "Optionen für Chatfensterreiter"
L["Default"] = "Standard"
L["disableflash_desc"] = "Deaktiviert das Blinken der Chat-Tabs."
L["disableflash_name"] = "Blinken ausschalten"
L["disablewhisperflash_desc"] = "Deaktiviert das Blitzen beim Chat-Fenster für Flüsternachrichten."
L["disablewhisperflash_name"] = "Deaktiviert das Blitzen für Flüsternachrichten"
L["Flash Color"] = "Blitzfarbe"
L["Font Color"] = "Schriftfarbe"
L["foreveralert_desc"] = "Wenn diese Option ausgeschaltet ist, bleibt die Beleuchtung/das Blitzen solange bestehen, bis der Timer abläuft"
L["foreveralert_name"] = "Haltet die Beleuchtung, bis du die Tab-Taste klickst"
L["Hidden"] = "Verborgen"
L["Highlighting/Flashing"] = "Beleuchtung/das Blitzen"
L["How long any highlights/flashes should last"] = "Wie lange sollte die Beleuchtung/das Blitzen dauern"
L["Individual"] = "Individuell"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "Inaktive Transparenz"
L["preventdrag_desc"] = "Verhindert das Verschieben der Chattabs mit der Maus."
L["preventdrag_name"] = "Ziehen verhindern"
L["Set ChatFrame%d Display Mode"] = "Darstellungsmodus von Chatfenster%d einstellen"
L["Set Display Mode"] = "Darstellungsmodus einstellen"
L["Set Flash Color"] = "Lege die Blitzfarbe fest"
L["Set Flash On Message"] = "Lege das Blitzen bei Nachricht fest"
L["Set tab display mode for each chat window."] = "Reiterdarstellungsmodus für jedes Chatfenster einstellen: markiert (an), nicht markiert (aus), grau markiert (standard)"
L["Set tab display to always, hidden or the Blizzard default."] = "Reiterdarstellung einstellen: immer, verbergen oder Blizzards Standard"
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "Transparenz der Chatreiter von aktiven Chatfenstern einstellen."
L["Sets alpha of chat tab for not active chat frame."] = "Transparenz der Chatreiter von inaktiven Chatfenstern einstellen."
L["Show Tab Textures"] = "Tab-Texturen anzeigen"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "Reiter (Reiter der Chatfenster)"
L["Visibility"] = "Sichtbarkeit"

  PL:AddLocale("deDE", L)


  L = {}
  -- ChatTabs
L["Active Alpha"] = "활성 탭 투명도"
L["All"] = "모두"
L["Always"] = "항상"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "대화창 탭 옵션입니다."
L["Default"] = "기본값"
L["disableflash_desc"] = "대화창 탭의 반짝임을 끕니다."
L["disableflash_name"] = "반짝임 끄기"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "숨김"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = "개별"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "비활성 탭 투명도"
L["preventdrag_desc"] = "마우스로 대화창 탭을 이동하지 못하게 합니다"
L["preventdrag_name"] = "탭 이동방지"
L["Set ChatFrame%d Display Mode"] = "대화창%d 표시 모드 설정"
L["Set Display Mode"] = "표시 모드 설정"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "각 대화창 별로 탭 표시 모드를 설정합니다. 체크함 (표시), 체크 안함 (표시 안함), 회색 체크 (기본값)"
L["Set tab display to always, hidden or the Blizzard default."] = "탭 표시를 항상 표시, 숨김 또는 블리자드 기본값으로 설정합니다."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "활성화 된 대화창 탭의 투명도를 설정합니다."
L["Sets alpha of chat tab for not active chat frame."] = "비활성화 된 대화창 탭의 투명도를 설정합니다."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "대화창 탭 [ChatTabs]"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("koKR",L)

  L = {}
  -- ChatTabs
--[[Translation missing --]]
L["Active Alpha"] = "Active Alpha"
--[[Translation missing --]]
L["All"] = "All"
--[[Translation missing --]]
L["Always"] = "Always"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
--[[Translation missing --]]
L["Chat window tab options."] = "Chat window tab options."
--[[Translation missing --]]
L["Default"] = "Default"
--[[Translation missing --]]
L["disableflash_desc"] = "Disable flashing of the chat tabs."
--[[Translation missing --]]
L["disableflash_name"] = "Disable Flashing"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
--[[Translation missing --]]
L["Hidden"] = "Hidden"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
--[[Translation missing --]]
L["Individual"] = "Individual"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
--[[Translation missing --]]
L["Not Active Alpha"] = "Not Active Alpha"
--[[Translation missing --]]
L["preventdrag_desc"] = "Prevent dragging chat tabs with mouse"
--[[Translation missing --]]
L["preventdrag_name"] = "Prevent Dragging"
--[[Translation missing --]]
L["Set ChatFrame%d Display Mode"] = "Set ChatFrame%d Display Mode"
--[[Translation missing --]]
L["Set Display Mode"] = "Set Display Mode"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
--[[Translation missing --]]
L["Set tab display mode for each chat window."] = "Set tab display mode for each chat window. Checked (on), Unchecked (off), Greyed Check (default)"
--[[Translation missing --]]
L["Set tab display to always, hidden or the Blizzard default."] = "Set tab display to always, hidden or the Blizzard default."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
--[[Translation missing --]]
L["Sets alpha of chat tab for active chat frame."] = "Sets alpha of chat tab for active chat frame."
--[[Translation missing --]]
L["Sets alpha of chat tab for not active chat frame."] = "Sets alpha of chat tab for not active chat frame."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
--[[Translation missing --]]
L["Tabs"] = "Tabs"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("esMX",L)

  L = {}
  -- ChatTabs
L["Active Alpha"] = "Прозрачность активной"
L["All"] = "Все"
L["Always"] = "Всегда"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "Настройки вкладок чата."
L["Default"] = "По умолчанию"
L["disableflash_desc"] = "Отключить мигание вкладок чата."
L["disableflash_name"] = "Отключить мигание"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "Скрывать"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = "Индивидуально"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "Прозрачность неактивных"
L["preventdrag_desc"] = "Запретить перетаскивание вкладок чата с помощью мыши"
L["preventdrag_name"] = "Запретить перетаскивание"
L["Set ChatFrame%d Display Mode"] = "Установить режим отображения %d вкладки"
L["Set Display Mode"] = "Режим отображения"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "Установить режим отображения каждой вкладки окна чата. Отмечено (вкл), Не отмечено (выкл), Отмечено серым (по умолчанию)"
L["Set tab display to always, hidden or the Blizzard default."] = "Установить режим отображения вкладки на 'всегда показывать', 'скрывать' или 'поведение по умолчанию, как у Blizzard'."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "Прозрачность активной вкладки чата."
L["Sets alpha of chat tab for not active chat frame."] = "Прозрачность неактивных вкладок чата."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "Вкладки чата"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("ruRU",L)

  L = {}
  -- ChatTabs
L["Active Alpha"] = "活跃的透明度"
L["All"] = "全部"
L["Always"] = "总是"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "聊天窗口页签选项"
L["Default"] = "预设"
L["disableflash_desc"] = "禁用聊天页签闪动"
L["disableflash_name"] = "禁用闪动"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "隐藏"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = "个别"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "非活跃的透明度"
L["preventdrag_desc"] = "阻止聊天页签随鼠标拖动"
L["preventdrag_name"] = "拖动阻止"
L["Set ChatFrame%d Display Mode"] = "设置聊天框%d显示模式"
L["Set Display Mode"] = "设置显示模式"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "设置每个聊天窗口的页签显示模式.检查(开),不检查(关),暂停检查(预设)"
L["Set tab display to always, hidden or the Blizzard default."] = "设置页签永久显示,隐藏或暴雪预设"
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "设置活跃聊天框页签透明度"
L["Sets alpha of chat tab for not active chat frame."] = "设置非活跃聊天框页签透明度"
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "页签"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("zhCN",L)

  L = {}
  -- ChatTabs
L["Active Alpha"] = "Activar Transparencia"
L["All"] = "Todo/s"
L["Always"] = "Siempre"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "Opciones de la pestaña de la ventana de chat."
L["Default"] = "Predeterminado"
L["disableflash_desc"] = "Deshabilitar destello de las pestañas del chat."
L["disableflash_name"] = "Desactivar Destello"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "Oculto"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = true
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "No Activar Transparencia"
L["preventdrag_desc"] = "Evitar arrastrar pestañas de chat con el ratón"
L["preventdrag_name"] = "Evitar arrastrar"
L["Set ChatFrame%d Display Mode"] = "Establecer Modo de Visualización del Marco de Chat %d"
L["Set Display Mode"] = "Establecer Modo Visualización"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "Establecer modo de pantalla de la pestaña para cada ventana de chat. Marcado (encendido), Desmarcado (apagado), Deshabilitado (predeterminado)"
L["Set tab display to always, hidden or the Blizzard default."] = "Establecer mostrar pestaña a siempre, oculta o por defecto (Blizzard)."
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "Establece la transparencia de la pestaña de chat para el marco activo."
L["Sets alpha of chat tab for not active chat frame."] = "Establece la transparencia de la pestaña de chat para el marco no activo."
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "Pestañas"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("esES",L)

  L = {}
  -- ChatTabs
L["Active Alpha"] = "使用中透明度"
L["All"] = "所有"
L["Always"] = "總是"
--[[Translation missing --]]
L["Change Font Color On Message"] = "Change Font Color On Message"
--[[Translation missing --]]
L["Chat Alert Timeout"] = "Chat Alert Timeout"
L["Chat window tab options."] = "聊天視窗標籤選單"
L["Default"] = "預設值"
L["disableflash_desc"] = "停用聊天標籤閃爍"
L["disableflash_name"] = "停用閃爍"
--[[Translation missing --]]
L["disablewhisperflash_desc"] = "Disable flashing of the chat tabs for whispers."
--[[Translation missing --]]
L["disablewhisperflash_name"] = "Disable Flash for Whispers"
--[[Translation missing --]]
L["Flash Color"] = "Flash Color"
--[[Translation missing --]]
L["Font Color"] = "Font Color"
--[[Translation missing --]]
L["foreveralert_desc"] = "With this turned off the highlight/flash will persist until the timer elapses"
--[[Translation missing --]]
L["foreveralert_name"] = "Keep highlighting until tab button clicked"
L["Hidden"] = "隱藏"
--[[Translation missing --]]
L["Highlighting/Flashing"] = "Highlighting/Flashing"
--[[Translation missing --]]
L["How long any highlights/flashes should last"] = "How long any highlights/flashes should last"
L["Individual"] = "個人"
--[[Translation missing --]]
L["keephighlightinactive_desc"] = "If this is turned on, the highlight will only persist if the tab is not the active tab. Otherwise the timer will be used"
--[[Translation missing --]]
L["keephighlightinactive_name"] = "Only keep highlighting if tab is not active"
L["Not Active Alpha"] = "非使用中透明度"
L["preventdrag_desc"] = "預防以滑鼠拖曳聊天標籤"
L["preventdrag_name"] = "防止拖曳"
L["Set ChatFrame%d Display Mode"] = "設定聊天框架 %d 的顯示模式"
L["Set Display Mode"] = "設定顯示模式"
--[[Translation missing --]]
L["Set Flash Color"] = "Set Flash Color"
--[[Translation missing --]]
L["Set Flash On Message"] = "Set Flash On Message"
L["Set tab display mode for each chat window."] = "為個別聊天標籤顯示模式設定. 核選（啟用），取消（停用），灰階（預設值）"
L["Set tab display to always, hidden or the Blizzard default."] = "設定是否顯示聊天標籤或者是 Blizzard預設值"
--[[Translation missing --]]
L["Set the font size for chat tab names."] = "Set the font size for chat tab names."
L["Sets alpha of chat tab for active chat frame."] = "設定使用中聊天視窗標籤透明度"
L["Sets alpha of chat tab for not active chat frame."] = "設定非使用中聊天視窗標籤透明度"
--[[Translation missing --]]
L["Show Tab Textures"] = "Show Tab Textures"
--[[Translation missing --]]
L["Tab Font Size"] = "Tab Font Size"
L["Tabs"] = "標籤"
--[[Translation missing --]]
L["Visibility"] = "Visibility"

  PL:AddLocale("zhTW",L)
  end
  --@end-non-debug@

	module.HighlightTabsPlugin = {}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			displaymode = {},
			highlighttabs = {
				["*"] = {
					flash = false,
					flashcolor = {
						r = 124 / 255,
						g = 239 / 255,
						b = 232 / 255,
						a = 0.7,
					},
					changefont = false,
					fontcolor = {
						r = 221 / 255,
						g = 27 / 255,
						b = 24 / 255,
						a = 1,
					}
				},
			},
			disableflash = false,
			notactivealpha = 0,
			activealpha = 0,
			preventdrag = false,
			showtabtextures = true,

			foreveralert = false,
			alerttimeout = 3.2,
			tabfontsize = 12,
		}
	})

	--module.toggleOptions = { sep115_sep = 115, disableflash = 120, preventdrag = 125 }

	Prat:SetModuleOptions(module.name, {
		name = PL["Tabs"],
		desc = PL["Chat window tab options."],
		type = "group",
		childGroups = "tab",
		args = {
			displaygroup = {
				type = "group",
				name = PL["Visibility"],
				order = 10,
				args = {
					displaymode = {
						name = PL["Set Display Mode"],
						desc = PL["Set tab display mode for each chat window."],
						type = "multiselect",
						tristate = true,
						order = 110,
						values = Prat.FrameList,
						get = "GetSubValue",
						set = "SetSubValue",
					},
					--			preventdrag = {
					--				name = PL["preventdrag_name"],
					--				desc = PL["preventdrag_desc"],
					--				type = "toggle",
					--				order = 120
					--			},
					activealpha = {
						name = PL["Active Alpha"],
						desc = PL["Sets alpha of chat tab for active chat frame."],
						type = "range",
						order = 130,
						min = 0.0,
						max = 1,
						step = 0.1,
					},
					notactivealpha = {
						name = PL["Not Active Alpha"],
						desc = PL["Sets alpha of chat tab for not active chat frame."],
						type = "range",
						order = 140,
						min = 0.0,
						max = 1,
						step = 0.1,
					},
					showtabtextures = {
						name = PL["Show Tab Textures"],
						type = "toggle",
						order = 150,
					},
					tabfontsize = {
						name = PL["Tab Font Size"],
						desc = PL["Set the font size for chat tab names."],
						type = "range",
						order = 160,
						min = 8,
						max = 24,
						step = 1,
					},
				},
			},
			highlightgroup = {
				name = PL["Highlighting/Flashing"],
				type = "group",
				order = 20,
				plugins = module.HighlightTabsPlugin,
				args = {
					disableflash = {
						name = PL["disablewhisperflash_name"],
						desc = PL["disablewhisperflash_desc"],
						type = "toggle",
						order = 4
					},
					foreveralert = {
						name = PL["foreveralert_name"],
						desc = PL["foreveralert_desc"],
						type = "toggle",
						order = 5
					},
					alerttimeout = {
						name = PL["Chat Alert Timeout"],
						desc = PL["How long any highlights/flashes should last"],
						type = "range",
						order = 6,
						min = 0.1,
						max = 15,
					},
					keephighlightinactive = {
						name = PL["keephighlightinactive_name"],
						desc = PL["keephighlightinactive_desc"],
						type = "toggle",
						order = 7
					},
				},
			},
		}
	})

	--local tabmode = { ["true"] = "ALWAYS", ["false"] = "HIDDEN", ["nil"] = "DEFAULT" }

	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		self:SecureHook("FCF_StartAlertFlash")
		self:SecureHook("FCFTab_UpdateAlpha")
		self:SecureHook("FCF_StopAlertFlash")

		self:HookedMode(true)
		self.chatTabTexture = {}
		self.chatAlertTimers = {}
		self.chatAlertCleanupActions = {}

		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_REMOVED)
		self:UpdateAllTabs()
		self:UpdateHighlightTabsConfig()
	end

	-- things to do when the module is enabled
	function module:OnModuleDisable()
		self:RemoveHooks()
	end

	function module:Prat_FramesUpdated()
		self:UpdateHighlightTabsConfig()
		for _, v in pairs(Prat.Frames) do
			self:ShowHideTabTextures(v)
		end
	end

	function module:Prat_FramesRemoved()
		self:UpdateHighlightTabsConfig()
	end
	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --

	function module:UpdateHighlightTabsConfig()
		local getToggle = function(info)
			return self.db.profile.highlighttabs[info[#info - 1]][info[#info]]
		end
		local setToggle = function(info, value)
			self.db.profile.highlighttabs[info[#info - 1]][info[#info]] = value
		end
		local getColor = function(info)
			local color = self.db.profile.highlighttabs[info[#info - 1]][info[#info]]
			return color.r, color.g, color.b, color.a
		end
		local setColor = function(info, r, g, b, a)
			self.db.profile.highlighttabs[info[#info - 1]][info[#info]] = {
				r = r,
				g = g,
				b = b,
				a = a,
			}
		end
		local orderedFrames = {}
		for _, frame in pairs(Prat.Frames) do
			if (frame.isDocked == 1) or frame:IsShown() then
				table.insert(orderedFrames, frame)
			end
		end
		table.sort(orderedFrames, function(a, b)
			return a:GetID() < b:GetID()
		end)
		for index, frame in pairs(orderedFrames) do
			local raw = frame:GetName()
			local name = frame.name
			self.HighlightTabsPlugin[raw] = {
				[raw] = {
					name = name,
					type = "group",
					inline = true,
					order = index * 10,
					args = {
						flash = {
							name = PL["Set Flash On Message"],
							order = 150,
							type = "toggle",
							get = getToggle,
							set = setToggle,
						},
						flashcolor = {
							name = PL["Flash Color"],
							type = "color",
							order = 170,
							get = getColor,
							set = setColor,
						},
						changefont = {
							name = PL["Change Font Color On Message"],
							order = 160,
							type = "toggle",
							get = getToggle,
							set = setToggle,
						},
						fontcolor = {
							name = PL["Font Color"],
							type = "color",
							order = 170,
							get = getColor,
							set = setColor,
						},
					},
				}
			}
		end
	end

	function module:GetDescription()
		return PL["Chat window tab options."]
	end

	function module:HookedMode(hooked)
		if hooked then
			self:RawHook("FCF_Close", true)
			self:InstallHooks()
		else
			self:RemoveHooks()
		end
	end

	local needToHook = {}

	function module:InstallHooks()
		for frameName, chatFrame in pairs(Prat.Frames) do
			local tabButton = _G[frameName .. "Tab"]
			self:HookScript(tabButton, "OnShow", "OnTabShow")
			self:SecureHook(chatFrame, "AddMessage")
			if tabButton:IsShown() then
				self:HookScript(tabButton, "OnHide", "OnTabHide")
				needToHook[tabButton] = nil
			else
				needToHook[tabButton] = true
			end
			--		self:HookScript(cftab,"OnDragStart", "OnTabDragStart")
		end
	end

	function module:RemoveHooks()
		for k, _ in pairs(Prat.Frames) do
			local cftab = _G[k .. "Tab"]
			cftab:SetScript("OnShow", function()
				return
			end)
			cftab:SetScript("OnHide", function()
				return
			end)
		end
		-- unhook functions
		self:UnhookAll()
	end

	function module:OnValueChanged()
		self:UpdateAllTabs()
	end

	function module:OnSubValueChanged()
		self:UpdateAllTabs()
	end

	local ChatTabTexturesRetail = {
		"Left", "Right", "Middle",
		"HighlightLeft", "HighlightRight", "HighlightMiddle",
		"ActiveLeft", "ActiveRight", "ActiveMiddle",
	}
	local ChatTabTexturesSelectedRetail = {
		"ActiveLeft", "ActiveRight", "ActiveMiddle",
	}
	local ChatTabTexturesClassic = {
		"Left", "Right", "Middle",
		"HighlightLeft", "HighlightRight", "HighlightMiddle",
		"SelectedLeft", "SelectedRight", "SelectedMiddle",
	}
	local ChatTabTexturesSelectedClassic = {
		"SelectedLeft", "SelectedRight", "SelectedMiddle",
	}

	function module:ShowHideTabTextures(tab)
		local tabButton = _G[tab:GetName() .. "Tab"]
		local alpha = self.db.profile.showtabtextures and 1 or 0
		if Prat.IsRetail then
			for _, field in ipairs(ChatTabTexturesRetail) do
				tabButton[field]:SetShown(self.db.profile.showtabtextures)
			end
			for _, field in ipairs(ChatTabTexturesSelectedRetail) do
				tabButton[field]:SetAlpha(alpha)
			end
		else
			for _, field in ipairs(ChatTabTexturesClassic) do
				_G[tabButton:GetName() .. field]:SetShown(self.db.profile.showtabtextures)
			end
			for _, field in ipairs(ChatTabTexturesSelectedClassic) do
				_G[tabButton:GetName() .. field]:SetAlpha(alpha)
			end
		end
	end

	function module:UpdateAllTabs()
		CHAT_FRAME_TAB_SELECTED_NOMOUSE_ALPHA = self.db.profile.activealpha;
		CHAT_FRAME_TAB_NORMAL_NOMOUSE_ALPHA = self.db.profile.notactivealpha;
		for k, v in pairs(Prat.Frames) do
			local tabButton = _G[k .. "Tab"]
			if FCF_IsValidChatFrame(v) then
				tabButton:Show()
				tabButton:Hide()
				FCFTab_UpdateAlpha(v)
			end
			self:ShowHideTabTextures(v)
		end
		self:UpdateTabFontSizes()
	end

	function module:OnTabShow(tab)
		if needToHook[tab] then
			self:HookScript(tab, "OnHide", "OnTabHide")
			needToHook[tab] = nil
		end

		if self.db.profile.displaymode["ChatFrame" .. tab:GetID()] == false then
			tab:Hide()
		end
	end

	function module:OnTabHide(tab)
		if self.db.profile.displaymode["ChatFrame" .. tab:GetID()] == true then
			tab:Show()
		end
	end

	function module:OnTabDragStart(this, ...)
		local p = self.db.profile

		if p.preventdrag and p.on then
			return
		end

		self.hooks[this].OnDragStart(this, ...)
	end

	function module:FCF_StartAlertFlash(this)
		if self.db.profile.disableflash then
			FCF_StopAlertFlash(this)
		end
	end

	function module:FCFTab_UpdateAlpha(chatFrame)
		local chatTab = _G[chatFrame:GetName() .. "Tab"]

		if chatTab.alerting then
			return
		elseif self.chatAlertCleanupActions[chatFrame:GetName()] then
			chatTab.noMouseAlpha = 1
			chatTab.mouseAlpha = 1
			chatTab:SetAlpha(1)
			return
		end

		if FCF_IsValidChatFrame(chatFrame) then
			if SELECTED_CHAT_FRAME:GetID() == chatFrame:GetID() then
				chatTab:SetAlpha(self.db.profile.activealpha)
				chatTab.noMouseAlpha = self.db.profile.activealpha
				chatTab.mouseAlpha = self.db.profile.activealpha
			else
				chatTab:SetAlpha(self.db.profile.notactivealpha)
				chatTab.noMouseAlpha = self.db.profile.notactivealpha
				chatTab.mouseAlpha = self.db.profile.notactivealpha
			end
		end
	end

	function module:FCF_Close(frame, fallback)
		local tab = _G[frame:GetName() .. "Tab"]

		-- print(frame, fallback, tab)
		if tab then
			self:Unhook(tab, "OnHide")
			needToHook[tab] = true
		end

		self.hooks.FCF_Close(frame, fallback)
	end

	function module:FCF_StopAlertFlash(frame)
		if FCF_IsValidChatFrame(frame) then
			FCFTab_UpdateAlpha(frame)
		end
	end

	function module:AddMessage(chatFrame)
		local oldActions = self.chatAlertCleanupActions[chatFrame:GetName()]
		self.chatAlertCleanupActions[chatFrame:GetName()] = nil
		if oldActions then
			for _, a in ipairs(oldActions) do
				a()
			end
		end
		if self.chatAlertTimers[chatFrame:GetName()] then
			self.chatAlertTimers[chatFrame:GetName()]:Cancel()
		end

		local actions = {}
		if self.db.profile.highlighttabs[chatFrame:GetName()].flash then
			table.insert(actions, self:DoFlash(chatFrame))
		end
		if self.db.profile.highlighttabs[chatFrame:GetName()].changefont then
			table.insert(actions, self:DoFontColorChange(chatFrame))
		end
		if #actions > 0 then
			table.insert(actions, self:KeepTabButtonVisible(chatFrame))
		end

		if #actions > 0 then
			self.chatAlertCleanupActions[chatFrame:GetName()] = actions
			local activeChatFrame = SELECTED_CHAT_FRAME
			if not self.db.profile.foreveralert or (self.db.profile.keephighlightinactive and activeChatFrame:GetID() == chatFrame:GetID()) then
				self.chatAlertTimers[chatFrame:GetName()] = C_Timer.NewTimer(self.db.profile.alerttimeout, function()
					self.chatAlertTimers[chatFrame:GetName()] = nil
					for _, a in ipairs(actions) do
						a()
					end
					self.chatAlertCleanupActions[chatFrame:GetName()] = nil
				end)
			else
				local tabButton = _G[chatFrame:GetName() .. "Tab"]
				if not self:IsHooked(tabButton, "OnClick") then
					self:HookScript(tabButton, "OnClick", function(tabButtonSelf)
						local frameName = "ChatFrame" .. tabButtonSelf:GetID()
						if self.chatAlertCleanupActions[frameName] then
							for _, a in ipairs(self.chatAlertCleanupActions[frameName]) do
								a()
							end
							self.chatAlertCleanupActions[frameName] = nil
						end
					end)
				end
			end
		end
	end

	function module:KeepTabButtonVisible(chatFrame)
		local tabButton = _G[chatFrame:GetName() .. "Tab"]
		tabButton:SetAlpha(1)
		tabButton.noMouseAlpha = 1
		tabButton.mouseAlpha = 1
		UIFrameFadeRemoveFrame(tabButton)
		return function()
			if chatFrame.hasBeenFaded then
				tabButton.noMouseAlpha = self.db.profile.activealpha
				tabButton.mouseAlpha = self.db.profile.activealpha
			else
				tabButton.noMouseAlpha = self.db.profile.notactivealpha
				tabButton.mouseAlpha = self.db.profile.notactivealpha
				UIFrameFadeOut(tabButton, 0.2, tabButton:GetAlpha(), tabButton.mouseAlpha)
			end
		end
	end

	function module:DoFlash(chatFrame)
		local tabButton = _G[chatFrame:GetName() .. "Tab"]

		if not self.chatTabTexture[chatFrame:GetName()] then
			self.chatTabTexture[chatFrame:GetName()] = tabButton:CreateTexture()
			local texture = self.chatTabTexture[chatFrame:GetName()]
			texture:SetTexture([[Interface\AddOns\Prat-3.0\textures\button-flash]])
			texture:SetPoint("BOTTOM", 0, -8)
			texture:SetHeight(32)
			texture:SetWidth(tabButton:GetWidth())
			texture.animation = texture:CreateAnimationGroup()
			local alpha = texture.animation:CreateAnimation("Alpha")
			alpha:SetFromAlpha(0)
			alpha:SetToAlpha(1)
			alpha:SetTargetParent()
			alpha:SetDuration(0.4)
			alpha:SetOrder(1)
			local alpha2 = texture.animation:CreateAnimation("Alpha")
			alpha2:SetFromAlpha(1)
			alpha2:SetToAlpha(0)
			alpha2:SetTargetParent()
			alpha2:SetDuration(0.4)
			alpha2:SetOrder(2)
			texture.animation:SetLooping("REPEAT")
		end

		local color = self.db.profile.highlighttabs[chatFrame:GetName()].flashcolor
		local highlight = self.chatTabTexture[chatFrame:GetName()]
		highlight:SetVertexColor(color.r, color.g, color.b, color.a)
		highlight:Show()
		highlight.animation:Restart()

		return function()
			if chatFrame.hasBeenFaded then
				tabButton.noMouseAlpha = self.db.profile.activealpha
				tabButton.mouseAlpha = self.db.profile.activealpha
			else
				tabButton.noMouseAlpha = self.db.profile.notactivealpha
				tabButton.mouseAlpha = self.db.profile.notactivealpha
				UIFrameFadeOut(tabButton, 0.2, tabButton:GetAlpha(), tabButton.mouseAlpha)
			end
			highlight:Hide()
		end
	end

	function module:DoFontColorChange(chatFrame)
		local tabButton = _G[chatFrame:GetName() .. "Tab"]
		local oldR, oldG, oldB, oldA = tabButton:GetFontString():GetTextColor()
		local color = self.db.profile.highlighttabs[chatFrame:GetName()].fontcolor
		tabButton:GetFontString():SetTextColor(color.r, color.g, color.b, color.a)

		return function()
			tabButton:GetFontString():SetTextColor(oldR, oldG, oldB, oldA)
		end
	end

	function module:UpdateTabFontSizes()
		for k, _ in pairs(Prat.Frames) do
			local tabButton = _G[k .. "Tab"]
			if tabButton and tabButton:GetFontString() then
				local fontString = tabButton:GetFontString()
				local currentFont, _, currentFlags = fontString:GetFont()
				fontString:SetFont(currentFont, self.db.profile.tabfontsize, currentFlags)
			end
		end
	end

	return
end) -- Prat:AddModuleToLoad
