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
	local module = Prat:NewModule("PlayerNames", "AceHook-3.0", "AceEvent-3.0", "AceTimer-3.0")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["PlayerNames"] = true,
		["Player name formating options."] = true,
		["Brackets"] = true,
		["Square"] = true,
		["Angled"] = true,
		["None"] = true,
		["Class"] = true,
		["Random"] = true,
		["Reset Settings"] = true,
		["No additional coloring"] = true,
		["Restore default settings, and delete stored character data."] = true,
		["Sets style of brackets to use around player names."] = true,
		["Unknown Use Common Color"] = true,
		["Toggle using a common color for unknown player names."] = true,
		["Unknown Common Color"] = true,
		["Set common color of unknown player names."] = true,
		["Enable TabComplete"] = true,
		["Toggle tab completion of player names."] = true,
		["Show Level"] = true,
		["Toggle level showing."] = true,
		["Level Color Mode"] = true,
		["Use Player Color"] = true,
		["Use Channel Color"] = true,
		["Color by Level Difference"] = true,
		["How to color other player's level."] = true,
		["Show Group"] = true,
		["Toggle raid group showing."] = true,
		["Show Raid Target Icon"] = true,
		["Toggle showing the raid target icon which is currently on the player."] = true,
		["Use toon name for RealID"] = true,

		-- In the high-cpu pullout
		["coloreverywhere_name"] = "Color Names Everywhere",
		["coloreverywhere_desc"] = "Color player names if they appear in the text of the chat message",
		["hoverhilight_name"] = "Hover Hilighting",
		["hoverhilight_desc"] = "Hilight chat lines from a specific player when hovering over thier playerlink",
		["realidcolor_name"] = "RealID Coloring",
		["realidcolor_desc"] = "RealID Name Coloring",
		["Keep Info"] = true,
		["Keep Lots Of Info"] = true,
		["Keep player information between session for all players except cross-server players"] = true,
		["Keep player information between session, but limit it to friends and guild members."] = true,
		["Player Color Mode"] = true,
		["How to color player's name."] = true,
		["Brackets Common Color"] = true,
		["Sets common color of brackets to use around player names."] = true,
		["Brackets Use Common Color"] = true,
		["Toggle using a common color for brackets around player names."] = true,
		["linkifycommon_name"] = "Linkify Common Messages",
		["linkifycommon_desc"] = "Linkify Common Messages",
		msg_stored_data_cleared = "Stored Player Data Cleared",
		["tabcomplete_name"] = "Possible Names",
		["Tab completion : "] = true,
		["Too many matches (%d possible)"] = true,
		["Actively Query Player Info"] = true,
		["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = true,
		bnetclienticon_name = "Show BNet Client Icon",
		bnetclienticon_desc = "Show an icon indicating which game or client the Battle.Net friend is using"
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L


  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = true
L["Angled"] = true
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
L["bnetclienticon_name"] = "Show BNet Client Icon"
L["Brackets"] = true
L["Brackets Common Color"] = true
L["Brackets Use Common Color"] = true
L["Class"] = true
L["Color by Level Difference"] = true
L["coloreverywhere_desc"] = "Color player names if they appear in the text of the chat message"
L["coloreverywhere_name"] = "Color Names Everywhere"
L["Enable Alt-Invite"] = true
L["Enable Invite Links"] = true
L["Enable TabComplete"] = true
L["hoverhilight_desc"] = "Hilight chat lines from a specific player when hovering over thier playerlink"
L["hoverhilight_name"] = "Hover Hilighting"
L["How to color other player's level."] = true
L["How to color player's name."] = true
L["Keep Info"] = true
L["Keep Lots Of Info"] = true
L["Keep player information between session for all players except cross-server players"] = true
L["Keep player information between session, but limit it to friends and guild members."] = true
L["Let TasteTheNaimbow set the common color for unknown player names."] = true
L["Level Color Mode"] = true
L["linkifycommon_desc"] = "Linkify Common Messages"
L["linkifycommon_name"] = "Linkify Common Messages"
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
L["No additional coloring"] = true
L["None"] = true
L["Player Color Mode"] = true
L["Player name formating options."] = true
L["PlayerNames"] = true
L["Prat_Playernames: Stored Player Data Cleared"] = true
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = true
L["Random"] = true
L["realidcolor_desc"] = "RealID Name Coloring"
L["realidcolor_name"] = "RealID Coloring"
L["Reset Settings"] = true
L["Restore default settings, and delete stored character data."] = true
L["Set common color of unknown player names."] = true
L["Sets common color of brackets to use around player names."] = true
L["Sets style of brackets to use around player names."] = true
L["Show Group"] = true
L["Show Level"] = true
L["Show Raid Target Icon"] = true
L["Square"] = true
L["Tab completion : "] = true
L["tabcomplete_name"] = "Possible Names"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = true
L["Toggle group invites by alt-clicking on player name."] = true
L["Toggle level showing."] = true
L["Toggle raid group showing."] = true
L["Toggle showing the raid target icon which is currently on the player."] = true
L["Toggle tab completion of player names."] = true
L["Toggle using a common color for brackets around player names."] = true
L["Toggle using a common color for unknown player names."] = true
L["Too many matches (%d possible)"] = true
L["Unknown Common Color"] = true
L["Unknown Common Color From TasteTheNaimbow"] = true
L["Unknown Use Common Color"] = true
L["Use Channel Color"] = true
L["Use Player Color"] = true
L["Use toon name for RealID"] = true


	  PL:AddLocale("enUS",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "Interroger activement les joueurs"
L["Angled"] = "Chevrons"
--[[Translation missing --]]
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
--[[Translation missing --]]
L["bnetclienticon_name"] = "Show BNet Client Icon"
L["Brackets"] = "Crochets"
L["Brackets Common Color"] = "Couleur des crochets"
L["Brackets Use Common Color"] = "Couleur des crochets"
L["Class"] = "Classe du joueur"
L["Color by Level Difference"] = "Différence de niveau"
L["coloreverywhere_desc"] = "Colorier le nom des joueurs si ils apparaissent dans le texte des messages."
L["coloreverywhere_name"] = "Couleur partout"
L["Enable Alt-Invite"] = "Invitation avec Alt"
L["Enable Invite Links"] = "Liens d'invitation"
L["Enable TabComplete"] = "Complétion avec Tab"
L["hoverhilight_desc"] = "Mettre en surbrillance les lignes de chat d'un joueur spécifique quand la souris survole un lien vers ce joueur"
L["hoverhilight_name"] = "Surbrillance de noms survolés"
L["How to color other player's level."] = "Définit la couleur du niveau des autres joueurs."
L["How to color player's name."] = "Définit la couleur du nom des joueurs."
L["Keep Info"] = "Garder les info."
L["Keep Lots Of Info"] = "Garder beaucoup d'info."
L["Keep player information between session for all players except cross-server players"] = "Garder les informations sur tous les joueurs entre les sessions sauf pour les joueurs inter-serveurs."
L["Keep player information between session, but limit it to friends and guild members."] = "Garder les informations sur les joueurs entre les sessions, mais seulement pour les amis et membres de la guilde."
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Laisser TasteTheNaimbow définir la couleur des joueurs inconnus."
L["Level Color Mode"] = "Couleur des niveaux"
--[[Translation missing --]]
L["linkifycommon_desc"] = "Linkify Common Messages"
--[[Translation missing --]]
L["linkifycommon_name"] = "Linkify Common Messages"
--[[Translation missing --]]
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
L["No additional coloring"] = "Pas de couleur"
L["None"] = "Aucun"
L["Player Color Mode"] = "Couleur des joueurs"
L["Player name formating options."] = "Options de formatage pour les noms des joueurs."
L["PlayerNames"] = "Nom des joueurs"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Informations des joueurs réinitialisées."
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Interroge le serveur pour tous les noms de joueurs que nous ne connaissons pas. Note : Cela peut être très lent, et les informations ne sont pas sauvegardées."
L["Random"] = "Aléatoire"
L["realidcolor_desc"] = "Couleur des noms RealID."
L["realidcolor_name"] = "Couleur RealID"
L["Reset Settings"] = "Réinitialiser"
L["Restore default settings, and delete stored character data."] = "Remets les options par défaut, et supprime toutes les informations enregistrées sur les joueurs."
L["Set common color of unknown player names."] = "Définit la couleur pour les noms de joueurs inconnus."
L["Sets common color of brackets to use around player names."] = "Définit la couleur des crochets autour du noms des joueurs."
L["Sets style of brackets to use around player names."] = "Définit le style des crochets autour du nom des joueurs."
L["Show Group"] = "Montrer le groupe"
L["Show Level"] = "Montrer le niveau"
L["Show Raid Target Icon"] = "Montrer l'icône de raid"
L["Square"] = "Crochets"
L["Tab completion : "] = "Auto-complétion :"
L["tabcomplete_name"] = "Noms possibles"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Active/Désactive l'invitation de groupe en faisant Alt+clic sur des mots-clé hyperliens comme 'inviter'."
L["Toggle group invites by alt-clicking on player name."] = "Active/Désactive l'invitation de groupe en faisant Alt+clic sur le nom d'un joueur."
L["Toggle level showing."] = "Active/Désactive l'affichage du niveau."
L["Toggle raid group showing."] = "Active/Désactive l'affichage du groupe de raid."
L["Toggle showing the raid target icon which is currently on the player."] = "Active/Désactive l'affichage de l'icône de raid qui est sur le joueur."
L["Toggle tab completion of player names."] = "Active/Désactive l'auto-complétion du nom des joueurs."
L["Toggle using a common color for brackets around player names."] = "Active/Désactive l'utilisation d'une couleur commune pour les crochets autour du nom des joueurs."
L["Toggle using a common color for unknown player names."] = "Active/Désactive l'utilisation d'une couleur commune pour les joueurs inconnus."
L["Too many matches (%d possible)"] = "Trop de résultats (%d possibles)"
L["Unknown Common Color"] = "Couleur pour inconnu"
--[[Translation missing --]]
L["Unknown Common Color From TasteTheNaimbow"] = "Unknown Common Color From TasteTheNaimbow"
L["Unknown Use Common Color"] = "Couleur pour inconnu"
L["Use Channel Color"] = "Couleur du canal"
L["Use Player Color"] = "Couleur du joueur"
--[[Translation missing --]]
L["Use toon name for RealID"] = "Use toon name for RealID"


	  PL:AddLocale("frFR",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "Spielerinformationen aktiv abfragen"
L["Angled"] = "Abgewinkelt"
L["bnetclienticon_desc"] = "Zeigt ein Symbol an, das angibt, welches Spiel oder welchen Client der Battle.Net-Freund verwendet"
L["bnetclienticon_name"] = "BNet-Client Symbol anzeigen"
L["Brackets"] = "Klammern"
L["Brackets Common Color"] = "Standardfarbe der Klammern"
L["Brackets Use Common Color"] = "Klammern verwenden die Standardfarbe"
L["Class"] = "Klasse"
L["Color by Level Difference"] = "Farbe nach Stufenunterschied"
L["coloreverywhere_desc"] = "Spielernamen einfärben, wenn diese im Text einer Chat-Mitteilung auftreten."
L["coloreverywhere_name"] = "Namen überall einfärben"
L["Enable Alt-Invite"] = "Alternative Einladung aktivieren"
L["Enable Invite Links"] = "Einladungs-Links aktivieren"
L["Enable TabComplete"] = "TabComplete aktivieren"
L["hoverhilight_desc"] = "Chat-Zeilen eines bestimmten Spielers hervorheben, wenn die Maus über den Spielerlink gelegt wird."
L["hoverhilight_name"] = "Schwebendes Hervorheben"
L["How to color other player's level."] = "Wie die Stufen anderer Spieler eingefärbt werden sollen."
L["How to color player's name."] = "Wie die Namen der Spieler eingefärbt werden sollen."
L["Keep Info"] = "Informationen merken"
L["Keep Lots Of Info"] = "Viele Informationen speichern"
L["Keep player information between session for all players except cross-server players"] = "Spielerinformationen aller Spieler außer Spielern anderer Server zwischen Sitzungen merken."
L["Keep player information between session, but limit it to friends and guild members."] = "Spielerinformationen zwischen Sitzungen speichern, aber schränke dies ein auf Freunde und Gildenmitglieder."
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Lasse TasteTheNaimbow die übliche Farbe für unbekannte Spielernamen einstellen."
L["Level Color Mode"] = "Stufenfarbe-Modus"
L["linkifycommon_desc"] = "Allgemeine Mitteilungen in Links umwandeln"
L["linkifycommon_name"] = "Allgemeine Mitteilungen in Links umwandeln"
L["msg_stored_data_cleared"] = "Gespeicherte Spielerdaten gelöscht"
L["No additional coloring"] = "Keine zusätzliche Einfärbung"
L["None"] = "Keine"
L["Player Color Mode"] = "Spieler Farbmodus"
L["Player name formating options."] = "Formatierungsoptionen für Spielernamen."
L["PlayerNames"] = "Spielernamen"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Gespeicherte Spielerdaten gelöscht"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Alle uns unbekannten Spielernamen beim Server abfragen. Merke: dies passiert ziemlich langsam und diese Daten sind nicht gespeichert."
L["Random"] = "Zufällig"
L["realidcolor_desc"] = "RealID-Namenseinfärbung"
L["realidcolor_name"] = "RealID-Einfärbung"
L["Reset Settings"] = "Einstellungen zurücksetzen"
L["Restore default settings, and delete stored character data."] = "Standardeinstellungen wiederherstellen und gespeicherte Charakterdaten löschen."
L["Set common color of unknown player names."] = "Allgemein übliche Farbe bei unbekannten Spielernamen einstellen."
L["Sets common color of brackets to use around player names."] = "Allgemein übliche Farbe der Klammern bei Spielernamen einstellen."
L["Sets style of brackets to use around player names."] = "Stil der Klammern bei Spielernamen einstellen."
L["Show Group"] = "Gruppe anzeigen"
L["Show Level"] = "Stufe anzeigen"
L["Show Raid Target Icon"] = "Zielmarkierungssymbol anzeigen"
L["Square"] = "Quadrat"
L["Tab completion : "] = "Tab-Ergänzung:"
L["tabcomplete_name"] = "Mögliche Namen"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Gruppeneinladungen umschalten, indem Hyperlinks von Stichworten wie \"invite\" bei gleichzeitigem Drücken der Alt-Taste angeklickt werden."
L["Toggle group invites by alt-clicking on player name."] = "Gruppeneinladungen umschalten, indem Spielernamen bei gleichzeitigem Drücken der Alt-Taste angeklickt werden."
L["Toggle level showing."] = "Stufenanzeige umschalten."
L["Toggle raid group showing."] = "Schlachtzugsgruppenanzeige umschalten."
L["Toggle showing the raid target icon which is currently on the player."] = "Anzeige von Schlachtzugsziel-Symbol, welches gegenwärtig dem Spieler zugewiesen ist, umschalten."
L["Toggle tab completion of player names."] = "Tag-Ergänzung von Spielernamen umschalten."
L["Toggle using a common color for brackets around player names."] = "Die Verwendung der allgemein üblichen Farbe für Klammern bei Spielernamen umschalten."
L["Toggle using a common color for unknown player names."] = "Die Verwendung der allgemein üblichen Farbe für unbekannte Spielernamen umschalten."
L["Too many matches (%d possible)"] = "Zu viele Entsprechungen (%d möglich)"
L["Unknown Common Color"] = "Unbekannte übliche Farbe"
L["Unknown Common Color From TasteTheNaimbow"] = "Unbekannte übliche Farbe von TasteTheNaimbow"
L["Unknown Use Common Color"] = "Unbekannt - übliche Farbe verwenden"
L["Use Channel Color"] = "Kanalfarbe verwenden"
L["Use Player Color"] = "Spielerfarbe verwenden"
L["Use toon name for RealID"] = "Charakternamen statt RealID verwenden"


	  PL:AddLocale("deDE",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "적극적인 플레이어 정보 요청"
L["Angled"] = "<플레이어>"
L["bnetclienticon_desc"] = "Battle.Net 친구가 사용중인 게임 또는 클라이언트를 나타내는 아이콘 표시"
L["bnetclienticon_name"] = "베틀넷 클라이언트 아이콘 표시"
L["Brackets"] = "괄호 선택"
L["Brackets Common Color"] = "괄호 색상"
L["Brackets Use Common Color"] = "괄호에 색상 사용"
L["Class"] = "직업"
L["Color by Level Difference"] = "레벨 차이에 의한 색상"
L["coloreverywhere_desc"] = "대화 메시지에 나타나는 플레이어 이름에 색상 적용"
L["coloreverywhere_name"] = "모든 곳의 이름에 색상 사용"
L["Enable Alt-Invite"] = "Alt-초대 켜기"
L["Enable Invite Links"] = "초대 링크 켜기"
L["Enable TabComplete"] = "탭 완성 켜기"
L["hoverhilight_desc"] = "플레이어 링크에 마우스를 올리면 특정 플레이어의 대화 내용을 강조합니다"
L["hoverhilight_name"] = "마우스 오버 강조"
L["How to color other player's level."] = "다른 플레이어의 레벨 색상화 방법을 설정합니다."
L["How to color player's name."] = "플레이어의 이름 색상화 방법을 설정합니다."
L["Keep Info"] = "친구/길드원 정보 저장"
L["Keep Lots Of Info"] = "모든 플레이어 정보 저장"
L["Keep player information between session for all players except cross-server players"] = "다른 서버를 제외한 모든 플레이어의 정보를 세션 간 유지합니다"
L["Keep player information between session, but limit it to friends and guild members."] = "친구와 길드원의 정보를 세션 간 유지합니다"
L["Let TasteTheNaimbow set the common color for unknown player names."] = "알 수 없는 플레이어 이름에 대한 색상으로 TasteTheNaimBow 애드온의 설정을 사용합니다."
L["Level Color Mode"] = "레벨 색상 설정"
L["linkifycommon_desc"] = "일반 메시지 링크"
L["linkifycommon_name"] = "일반 메시지 링크"
L["msg_stored_data_cleared"] = "저장된 플레이어 데이터가 지워짐"
L["No additional coloring"] = "사용 안함"
L["None"] = "안함"
L["Player Color Mode"] = "플레이어 색상 설정"
L["Player name formating options."] = "플레이어 이름 형식화 설정입니다."
L["PlayerNames"] = "플레이어 이름"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: 저장된 플레이어 정보 초기화"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "모르는 모든 플레이어 이름 정보를 서버에 요청합니다. 주의: 작동 시 느려질 수 있으며, 수집된 정보들은 저장되지 않습니다."
L["Random"] = "무작위"
L["realidcolor_desc"] = "실명ID 이름에 색을 입힙니다"
L["realidcolor_name"] = "실명ID 색 입히기"
L["Reset Settings"] = "설정 초기화"
L["Restore default settings, and delete stored character data."] = "기본 설정을 복구하고 저장된 캐릭터 설정을 지웁니다."
L["Set common color of unknown player names."] = "알 수 없는 플레이어 이름의 색상을 설정합니다."
L["Sets common color of brackets to use around player names."] = "플레이어 이름 주위에 사용할 괄호의 색상을 설정합니다."
L["Sets style of brackets to use around player names."] = "플레이어 이름 주위에 사용할 괄호의 모양을 설정합니다."
L["Show Group"] = "그룹 표시"
L["Show Level"] = "레벨 표시"
L["Show Raid Target Icon"] = "전술 아이콘 표시"
L["Square"] = "사각형"
L["Tab completion : "] = "탭 완성 :"
L["tabcomplete_name"] = "가능한 이름"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "'초대' 같은 링크된 단어를 Alt-클릭하여 초대합니다."
L["Toggle group invites by alt-clicking on player name."] = "플레이어 이름을 Alt-클릭하여 초대합니다."
L["Toggle level showing."] = "레벨을 표시합니다."
L["Toggle raid group showing."] = "공격대 파티를 표시합니다."
L["Toggle showing the raid target icon which is currently on the player."] = "플레이어에게 지정된 전술 아이콘을 표시합니다."
L["Toggle tab completion of player names."] = "플레이어 이름의 탭 완성을 켭니다."
L["Toggle using a common color for brackets around player names."] = "플레이어 이름 주위 괄호에 색상을 입힙니다."
L["Toggle using a common color for unknown player names."] = "알 수 없는 플레이어 이름에 색상을 입힙니다."
L["Too many matches (%d possible)"] = "너무 많은 일치 (%d 가능)"
L["Unknown Common Color"] = "알 수 없는 색상"
L["Unknown Common Color From TasteTheNaimbow"] = "알 수 없는 이름에 TasteTheNaimbow 색상 사용"
L["Unknown Use Common Color"] = "알 수 없는 이름에 색상 사용"
L["Use Channel Color"] = "채널 색상 사용"
L["Use Player Color"] = "플레이어 색상 사용"
L["Use toon name for RealID"] = "실명ID에 별명 사용"


	  PL:AddLocale("koKR",L)



  L = {}
  -- PlayerNames
--[[Translation missing --]]
L["Actively Query Player Info"] = "Actively Query Player Info"
--[[Translation missing --]]
L["Angled"] = "Angled"
--[[Translation missing --]]
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
--[[Translation missing --]]
L["bnetclienticon_name"] = "Show BNet Client Icon"
--[[Translation missing --]]
L["Brackets"] = "Brackets"
--[[Translation missing --]]
L["Brackets Common Color"] = "Brackets Common Color"
--[[Translation missing --]]
L["Brackets Use Common Color"] = "Brackets Use Common Color"
--[[Translation missing --]]
L["Class"] = "Class"
--[[Translation missing --]]
L["Color by Level Difference"] = "Color by Level Difference"
--[[Translation missing --]]
L["coloreverywhere_desc"] = "Color player names if they appear in the text of the chat message"
--[[Translation missing --]]
L["coloreverywhere_name"] = "Color Names Everywhere"
--[[Translation missing --]]
L["Enable Alt-Invite"] = "Enable Alt-Invite"
--[[Translation missing --]]
L["Enable Invite Links"] = "Enable Invite Links"
--[[Translation missing --]]
L["Enable TabComplete"] = "Enable TabComplete"
--[[Translation missing --]]
L["hoverhilight_desc"] = "Hilight chat lines from a specific player when hovering over thier playerlink"
--[[Translation missing --]]
L["hoverhilight_name"] = "Hover Hilighting"
--[[Translation missing --]]
L["How to color other player's level."] = "How to color other player's level."
--[[Translation missing --]]
L["How to color player's name."] = "How to color player's name."
--[[Translation missing --]]
L["Keep Info"] = "Keep Info"
--[[Translation missing --]]
L["Keep Lots Of Info"] = "Keep Lots Of Info"
--[[Translation missing --]]
L["Keep player information between session for all players except cross-server players"] = "Keep player information between session for all players except cross-server players"
--[[Translation missing --]]
L["Keep player information between session, but limit it to friends and guild members."] = "Keep player information between session, but limit it to friends and guild members."
--[[Translation missing --]]
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Let TasteTheNaimbow set the common color for unknown player names."
--[[Translation missing --]]
L["Level Color Mode"] = "Level Color Mode"
--[[Translation missing --]]
L["linkifycommon_desc"] = "Linkify Common Messages"
--[[Translation missing --]]
L["linkifycommon_name"] = "Linkify Common Messages"
--[[Translation missing --]]
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
--[[Translation missing --]]
L["No additional coloring"] = "No additional coloring"
--[[Translation missing --]]
L["None"] = "None"
--[[Translation missing --]]
L["Player Color Mode"] = "Player Color Mode"
--[[Translation missing --]]
L["Player name formating options."] = "Player name formating options."
--[[Translation missing --]]
L["PlayerNames"] = "PlayerNames"
--[[Translation missing --]]
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Stored Player Data Cleared"
--[[Translation missing --]]
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."
--[[Translation missing --]]
L["Random"] = "Random"
--[[Translation missing --]]
L["realidcolor_desc"] = "RealID Name Coloring"
--[[Translation missing --]]
L["realidcolor_name"] = "RealID Coloring"
--[[Translation missing --]]
L["Reset Settings"] = "Reset Settings"
--[[Translation missing --]]
L["Restore default settings, and delete stored character data."] = "Restore default settings, and delete stored character data."
--[[Translation missing --]]
L["Set common color of unknown player names."] = "Set common color of unknown player names."
--[[Translation missing --]]
L["Sets common color of brackets to use around player names."] = "Sets common color of brackets to use around player names."
--[[Translation missing --]]
L["Sets style of brackets to use around player names."] = "Sets style of brackets to use around player names."
--[[Translation missing --]]
L["Show Group"] = "Show Group"
--[[Translation missing --]]
L["Show Level"] = "Show Level"
--[[Translation missing --]]
L["Show Raid Target Icon"] = "Show Raid Target Icon"
--[[Translation missing --]]
L["Square"] = "Square"
--[[Translation missing --]]
L["Tab completion : "] = "Tab completion : "
--[[Translation missing --]]
L["tabcomplete_name"] = "Possible Names"
--[[Translation missing --]]
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."
--[[Translation missing --]]
L["Toggle group invites by alt-clicking on player name."] = "Toggle group invites by alt-clicking on player name."
--[[Translation missing --]]
L["Toggle level showing."] = "Toggle level showing."
--[[Translation missing --]]
L["Toggle raid group showing."] = "Toggle raid group showing."
--[[Translation missing --]]
L["Toggle showing the raid target icon which is currently on the player."] = "Toggle showing the raid target icon which is currently on the player."
--[[Translation missing --]]
L["Toggle tab completion of player names."] = "Toggle tab completion of player names."
--[[Translation missing --]]
L["Toggle using a common color for brackets around player names."] = "Toggle using a common color for brackets around player names."
--[[Translation missing --]]
L["Toggle using a common color for unknown player names."] = "Toggle using a common color for unknown player names."
--[[Translation missing --]]
L["Too many matches (%d possible)"] = "Too many matches (%d possible)"
--[[Translation missing --]]
L["Unknown Common Color"] = "Unknown Common Color"
--[[Translation missing --]]
L["Unknown Common Color From TasteTheNaimbow"] = "Unknown Common Color From TasteTheNaimbow"
--[[Translation missing --]]
L["Unknown Use Common Color"] = "Unknown Use Common Color"
--[[Translation missing --]]
L["Use Channel Color"] = "Use Channel Color"
--[[Translation missing --]]
L["Use Player Color"] = "Use Player Color"
--[[Translation missing --]]
L["Use toon name for RealID"] = "Use toon name for RealID"


	  PL:AddLocale("esMX",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "Активный запрос инфы о игроке"
L["Angled"] = "Треугольные"
L["bnetclienticon_desc"] = "Показывать значок, указывающий, какую игру или клиент использует ваш друг в Battle.Net"
L["bnetclienticon_name"] = "Показать иконку клиента BNet"
L["Brackets"] = "Скобки"
L["Brackets Common Color"] = "Основной цвет скобок"
L["Brackets Use Common Color"] = "Скобки общего цвета"
L["Class"] = "Класс"
L["Color by Level Difference"] = "Окрашивание по отличию в уровне"
L["coloreverywhere_desc"] = "Окраска текст сообщения в цвет имени игрока, если цвет задан"
L["coloreverywhere_name"] = "Цвет имени везде"
L["Enable Alt-Invite"] = "Включить приглашение с кнопкой Alt"
L["Enable Invite Links"] = "Включить приглашение по ссылкам"
L["Enable TabComplete"] = "Включить TabComplete"
L["hoverhilight_desc"] = "Подсвечивает строки чата от определенных игроков при наведении мышкой на их никнейм."
L["hoverhilight_name"] = "Подсветка при наведении мышкой"
L["How to color other player's level."] = "Как окрашивать уповень игрока."
L["How to color player's name."] = "Как окрашивать имя игрока."
L["Keep Info"] = "Хранить информацию"
L["Keep Lots Of Info"] = "Хранить большое количество информации"
L["Keep player information between session for all players except cross-server players"] = "Хранить информацию о всех собеседниках между сессиями за исключением игроков с других серверов"
L["Keep player information between session, but limit it to friends and guild members."] = "Хранить информацию о собеседниках между сессиями, но ограничить этот список только друзьями и членами гильдии."
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Позволить TasteTheNaimbow установить общий цветдля неизвестных играков."
L["Level Color Mode"] = "Режим окрашивания уровня"
L["linkifycommon_desc"] = "Общие сообщения с сылками"
L["linkifycommon_name"] = "Общие сообщения с сылками"
L["msg_stored_data_cleared"] = "Сохраненные данные игрока очищены"
L["No additional coloring"] = "Отключить дополнительное цвето-выделение"
L["None"] = "Нет"
L["Player Color Mode"] = "Режим цвета игрока"
L["Player name formating options."] = "Настройки форматирования имени собеседника."
L["PlayerNames"] = "Имя игрока"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Информация о собеседниках очищена"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Запрос сервера для всех неизвестных играков. Заметка: Это происходит дастаточно медленно, и их данные не сохраняются."
L["Random"] = "Случайно"
L["realidcolor_desc"] = "Окрашивание имен RealID"
L["realidcolor_name"] = "RealID Цвет"
L["Reset Settings"] = "Сброс настроек"
L["Restore default settings, and delete stored character data."] = "Восстановить настройки по умолчанию и удалить сохраненную информацию о собеседниках."
L["Set common color of unknown player names."] = "Выбор цвета, которым будут окрашены неизвестные игроки."
L["Sets common color of brackets to use around player names."] = "Установить цвет скобок, окружающих имя игрока."
L["Sets style of brackets to use around player names."] = "Установить стиль скобок вокруг имени собеседника."
L["Show Group"] = "Показывать группу"
L["Show Level"] = "Показывать уровень"
L["Show Raid Target Icon"] = "Показать иконку цели рейда"
L["Square"] = "Квадратные"
L["Tab completion : "] = "Завершение закладки : "
L["tabcomplete_name"] = "Возможные имена"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Вкл/выкл приглашение в группу с помощью alt+клик по ключевому слову типа: 'инвайт'."
L["Toggle group invites by alt-clicking on player name."] = "Включить режим, в котором можно пригласить игрока в группу щелкнув по его имени  с нажатой клавишей Alt."
L["Toggle level showing."] = "Вкл/выкл отображения уровня собеседника."
L["Toggle raid group showing."] = "Вкл/выкл отображения рейдовой группы."
L["Toggle showing the raid target icon which is currently on the player."] = "Вкл/Выкл отображение иконки цели рейда которой помечен игрок."
L["Toggle tab completion of player names."] = "Вкл/выкл завершение закладки именами играка."
L["Toggle using a common color for brackets around player names."] = "Включить окрашивание скобок вокруг имени игрока общим, выбранным цветом."
L["Toggle using a common color for unknown player names."] = "Включить окрашивание имен всех неизвестных собеседников в общий цвет."
L["Too many matches (%d possible)"] = "За много совпадение (%d возможных)"
L["Unknown Common Color"] = "Общий цвет неизвестных"
L["Unknown Common Color From TasteTheNaimbow"] = "Общая окраска неизвестных из TasteTheNaimbow"
L["Unknown Use Common Color"] = "Общий цвет для неизвестных"
L["Use Channel Color"] = "Использовать цвет канала"
L["Use Player Color"] = "Использовать цвет игрока"
L["Use toon name for RealID"] = "Использовать имя персонажа вместо RealID"


	  PL:AddLocale("ruRU",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "活跃的查询玩家信息"
L["Angled"] = "折角"
--[[Translation missing --]]
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
--[[Translation missing --]]
L["bnetclienticon_name"] = "Show BNet Client Icon"
L["Brackets"] = "括号"
L["Brackets Common Color"] = "同一颜色括号"
L["Brackets Use Common Color"] = "使用同一颜色括号"
L["Class"] = "职业"
L["Color by Level Difference"] = "彩色的等级差别"
L["coloreverywhere_desc"] = "彩色显示聊天信息中出现的玩家姓名"
L["coloreverywhere_name"] = "彩色显示姓名在所有地方"
L["Enable Alt-Invite"] = "启用Alt-邀请"
L["Enable Invite Links"] = "启用邀请链接"
L["Enable TabComplete"] = "启用Tab键补全"
L["hoverhilight_desc"] = "当悬停在玩家链接上时高亮该玩家的聊天语句"
L["hoverhilight_name"] = "悬停高亮"
L["How to color other player's level."] = "如何着色其他玩家的等级"
L["How to color player's name."] = "如何着色玩家的名称"
L["Keep Info"] = "保持信息"
L["Keep Lots Of Info"] = "保持大量的信息"
L["Keep player information between session for all players except cross-server players"] = "为除跨服玩家外的所有玩家在会话间保持玩家信息"
L["Keep player information between session, but limit it to friends and guild members."] = "在会话间保持玩家信息,但仅限于朋友和公会成员"
L["Let TasteTheNaimbow set the common color for unknown player names."] = "让TasteTheNaimbow(插件)为未知玩家名称设置公共颜色"
L["Level Color Mode"] = "等级着色模式"
L["linkifycommon_desc"] = "自助链接公共信息"
L["linkifycommon_name"] = "自助链接公共信息"
--[[Translation missing --]]
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
L["No additional coloring"] = "无额外着色"
L["None"] = "无"
L["Player Color Mode"] = "玩家着色模式"
L["Player name formating options."] = "玩家名称格式选项"
L["PlayerNames"] = "玩家名称"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_玩家名称: 玩家数据存储已清除"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "为所有未知玩家查询服务器,注意:这将非常缓慢,并且数据不会被存储"
L["Random"] = "随机"
L["realidcolor_desc"] = "实名名字颜色"
L["realidcolor_name"] = "实名颜色"
L["Reset Settings"] = "重置设置"
L["Restore default settings, and delete stored character data."] = "恢复默认设置并删除已存角色数据"
L["Set common color of unknown player names."] = "设置未知玩家名称共有颜色"
L["Sets common color of brackets to use around player names."] = "设置用来围绕玩家名称的括号颜色"
L["Sets style of brackets to use around player names."] = "设置用来围绕玩家名称的括号类型"
L["Show Group"] = "显示团队"
L["Show Level"] = "显示等级"
L["Show Raid Target Icon"] = "显示团队目标图标"
L["Square"] = "直角"
L["Tab completion : "] = "Tab键补全"
L["tabcomplete_name"] = "可能的名称"
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "组队邀请用alt-点击超链接的关键词如'邀请'"
L["Toggle group invites by alt-clicking on player name."] = "组队邀请用alt-点击玩家名称"
L["Toggle level showing."] = "等级显示"
L["Toggle raid group showing."] = "团队分组显示"
L["Toggle showing the raid target icon which is currently on the player."] = "显示当前玩家的团队目标图标"
L["Toggle tab completion of player names."] = "Tab键补全玩家姓名"
L["Toggle using a common color for brackets around player names."] = "为括号内玩家姓名使用公共颜色"
L["Toggle using a common color for unknown player names."] = "为位置未知玩家名称使用公共颜色"
L["Too many matches (%d possible)"] = "太多的匹配 (%d可能的)"
L["Unknown Common Color"] = "未知公共颜色"
L["Unknown Common Color From TasteTheNaimbow"] = "未知公共颜色自TasteTheNaimbow"
L["Unknown Use Common Color"] = "未知使用公共颜色"
L["Use Channel Color"] = "使用频道颜色"
L["Use Player Color"] = "使用玩家颜色"
L["Use toon name for RealID"] = "使用角色名代替战网ID"


	  PL:AddLocale("zhCN",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "Pedir Información de Jugador Activamente"
L["Angled"] = "Angulo"
--[[Translation missing --]]
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
--[[Translation missing --]]
L["bnetclienticon_name"] = "Show BNet Client Icon"
L["Brackets"] = "Corchetes"
L["Brackets Common Color"] = "Color Común Corchetes"
L["Brackets Use Common Color"] = "Utilizar Color Común Corchetes"
L["Class"] = "Clase"
L["Color by Level Difference"] = "Color por Diferencia de Nivel"
L["coloreverywhere_desc"] = "Colorear nombres de jugadores si ellos aparecen en el texto de los mensajes del chat."
L["coloreverywhere_name"] = "Colorear Nombres Siempre"
L["Enable Alt-Invite"] = "Habilitar Alt-Invitar"
L["Enable Invite Links"] = "Habilitar Enlaces Invitar"
L["Enable TabComplete"] = "Habilitar Ficha completa"
L["hoverhilight_desc"] = "Resaltar líneas de chat de un jugador al situarse sobre su enlace de jugador"
--[[Translation missing --]]
L["hoverhilight_name"] = "Hover Hilighting"
L["How to color other player's level."] = "Cómo el color de otro jugador de nivel."
L["How to color player's name."] = "Cómo el color de nombre del jugador."
L["Keep Info"] = "Mantener Información"
L["Keep Lots Of Info"] = "Mantener Mucha Información"
L["Keep player information between session for all players except cross-server players"] = "Mantiene información de jugadores entre sesiones para todos los jugadores excepto entre servidores"
L["Keep player information between session, but limit it to friends and guild members."] = "Mantiene información de jugadores entre sesiones, pero lo limita a amigos y miembros de la hermandad."
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Deje a TasteTheNaimbow establecer el color común para nombres de jugador desconocidos."
L["Level Color Mode"] = "Modo Color por Nivel"
L["linkifycommon_desc"] = "Linkify Common Messages"
L["linkifycommon_name"] = "Enlazar Mensajes Comunes"
--[[Translation missing --]]
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
L["No additional coloring"] = "Sin color adicional"
L["None"] = "Ninguno"
L["Player Color Mode"] = "Modo Color del Jugador"
L["Player name formating options."] = "Opciones de formato del nombre de jugador."
L["PlayerNames"] = "Nombre del Jugador"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames: Limpiados los Datos de Jugador Guardados"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "Consulta el servidor para todos los nombres de jugador que desconocemos. Nota: esto sucede muy lentamente, y estos datos no se guardan."
L["Random"] = "Aleatorio"
--[[Translation missing --]]
L["realidcolor_desc"] = "RealID Name Coloring"
--[[Translation missing --]]
L["realidcolor_name"] = "RealID Coloring"
L["Reset Settings"] = "Restablecer Ajustes"
L["Restore default settings, and delete stored character data."] = "Restablece ajustes por defecto, y eliminar información del jugador guardada."
L["Set common color of unknown player names."] = "Establece el color común para los nombres de jugadores desconocidos."
L["Sets common color of brackets to use around player names."] = "Establece el color común de los corchetes a utilizar en torno a los nombres de jugador."
L["Sets style of brackets to use around player names."] = "Establece el estilo de los corchetes a utilizar en torno a los nombres de jugador."
L["Show Group"] = "Mostrar Grupo"
L["Show Level"] = "Mostrar Nivel"
L["Show Raid Target Icon"] = "Mostrar Icono Objetivo Banda"
L["Square"] = "Cuadrado"
L["Tab completion : "] = "Finalización de Pestaña : "
L["tabcomplete_name"] = "Nombres Posibles"
--[[Translation missing --]]
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."
L["Toggle group invites by alt-clicking on player name."] = "Activa invitar a grupo al hacer alt-click en el nombre del jugador."
L["Toggle level showing."] = "Alterna mostrar nivel."
L["Toggle raid group showing."] = "Alterna mostrar grupo de raid."
L["Toggle showing the raid target icon which is currently on the player."] = "Altterna mostrar el icono de objetivo de banda que está en el jugador."
L["Toggle tab completion of player names."] = "Alterna la finalización de la pestaña de nombres de jugador."
L["Toggle using a common color for brackets around player names."] = "Alterna utilizar un color común de corchetes en torno a los nombres de jugador."
L["Toggle using a common color for unknown player names."] = "Alterna el utilizar un color común para los nombres de jugadores desconocidos."
L["Too many matches (%d possible)"] = "Demasiadas coincidencias (%d posibles)"
L["Unknown Common Color"] = "Color Común Desconocido"
L["Unknown Common Color From TasteTheNaimbow"] = "Color Común Desconocido de TasteTheNaimbow"
L["Unknown Use Common Color"] = "Desconocido Color de Uso Común"
L["Use Channel Color"] = "Utilizar Color Canal"
L["Use Player Color"] = "Utilizar Color Jugador"
--[[Translation missing --]]
L["Use toon name for RealID"] = "Use toon name for RealID"


	  PL:AddLocale("esES",L)



  L = {}
  -- PlayerNames
L["Actively Query Player Info"] = "主動查詢玩家資訊"
L["Angled"] = "角"
--[[Translation missing --]]
L["bnetclienticon_desc"] = "Show an icon indicating which game or client the Battle.Net friend is using"
--[[Translation missing --]]
L["bnetclienticon_name"] = "Show BNet Client Icon"
L["Brackets"] = "括號"
L["Brackets Common Color"] = "括號通用色彩"
L["Brackets Use Common Color"] = "括號使用的通用色彩"
L["Class"] = "職業"
L["Color by Level Difference"] = "等級差異色彩"
L["coloreverywhere_desc"] = "當玩家名稱出現在聊天訊息文字中時，為其上色。"
L["coloreverywhere_name"] = "顏色名字到處"
L["Enable Alt-Invite"] = "啟用 Alt 按鍵邀請"
L["Enable Invite Links"] = "啟用邀請連結"
L["Enable TabComplete"] = "啟用 TabComplete"
--[[Translation missing --]]
L["hoverhilight_desc"] = "Hilight chat lines from a specific player when hovering over thier playerlink"
L["hoverhilight_name"] = "滑鼠懸停高亮"
L["How to color other player's level."] = "如何為玩家等級著色"
L["How to color player's name."] = "如何為玩家名稱著色"
L["Keep Info"] = "保存資訊"
L["Keep Lots Of Info"] = "保存大量資訊"
L["Keep player information between session for all players except cross-server players"] = "保存此階段所有玩家資訊，除了跨伺服器人物。"
L["Keep player information between session, but limit it to friends and guild members."] = "保存此階段玩家資訊，但限制為好友以及公會成員。"
--[[Translation missing --]]
L["Let TasteTheNaimbow set the common color for unknown player names."] = "Let TasteTheNaimbow set the common color for unknown player names."
L["Level Color Mode"] = "等級色彩模式"
L["linkifycommon_desc"] = "製作連結共同的訊息"
L["linkifycommon_name"] = "製作連結共同的訊息"
--[[Translation missing --]]
L["msg_stored_data_cleared"] = "Stored Player Data Cleared"
L["No additional coloring"] = "無額外著色"
L["None"] = "無"
L["Player Color Mode"] = "玩家色彩模式"
L["Player name formating options."] = "玩家名稱格式化選項。"
L["PlayerNames"] = "玩家名稱"
L["Prat_Playernames: Stored Player Data Cleared"] = "Prat_Playernames：已清除儲存的玩家資料"
L["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."] = "查詢所有此伺服器我們不知道的角色名稱。備註：這個程序相當緩慢且並不會儲存此資料。"
L["Random"] = "隨機"
L["realidcolor_desc"] = "RealID 名稱著色"
L["realidcolor_name"] = "RealID 著色"
L["Reset Settings"] = "重置設定"
L["Restore default settings, and delete stored character data."] = "恢復至預設值且刪除儲存的角色資料。"
L["Set common color of unknown player names."] = "設定未知角色的顯示色彩"
L["Sets common color of brackets to use around player names."] = "設定用來圍繞玩家名稱的括號顏色。"
L["Sets style of brackets to use around player names."] = "設定用來圍繞玩家名稱的括號類型。"
L["Show Group"] = "顯示隊伍編號"
L["Show Level"] = "顯示等級"
L["Show Raid Target Icon"] = "顯示團隊標記"
L["Square"] = "方框"
L["Tab completion : "] = "標籤完成:"
L["tabcomplete_name"] = "可能的名稱 "
--[[Translation missing --]]
L["Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."] = "Toggle group invites by alt-clicking hyperlinked keywords like 'invite'."
L["Toggle group invites by alt-clicking on player name."] = "組隊邀請用alt-點擊玩家名稱。"
L["Toggle level showing."] = "切換等級顯示。"
L["Toggle raid group showing."] = "切換團隊組隊顯示。"
L["Toggle showing the raid target icon which is currently on the player."] = "顯示當前玩家的團隊目標圖標"
L["Toggle tab completion of player names."] = "切換玩家名稱的標籤完成。"
L["Toggle using a common color for brackets around player names."] = "選擇是否為玩家名稱外的括號使用一個通用顏色"
L["Toggle using a common color for unknown player names."] = "切換未知玩家以一般色彩顯示"
L["Too many matches (%d possible)"] = "太多符合 (可能 %d)"
L["Unknown Common Color"] = "未知的文字通用顏色"
L["Unknown Common Color From TasteTheNaimbow"] = "來自TasteTheNaimbow 的未知的文字通用顏色"
L["Unknown Use Common Color"] = "未知的文字使用通用顏色"
L["Use Channel Color"] = "使用頻道文字顏色"
L["Use Player Color"] = "使用腳色名稱文字色彩"
--[[Translation missing --]]
L["Use toon name for RealID"] = "Use toon name for RealID"


	  PL:AddLocale("zhTW",L)


	end
	--@end-non-debug@

	module.Classes = {}
	module.Levels = {}
	module.Subgroups = {}

	local NOP = function()
		return
	end

	module.OnPlayerDataChanged = NOP

	Prat:SetModuleDefaults(module.name, {
		realm = {
			classes = {},
			levels = {}
		},
		profile = {
			on = true,
			brackets = "Square",
			tabcomplete = true,
			tabcompletelimit = 20,
			level = true,
			levelcolor = "DIFFICULTY",
			subgroup = true,
			showtargeticon = false,
			keep = false,
			keeplots = false,
			colormode = "CLASS",
			realidcolor = "CLASS",
			realidname = false,
			coloreverywhere = true,
			usecommoncolor = true,
			bracketscommoncolor = true,
			linkifycommon = true,
			bnetclienticon = true,
			bracketscolor = {
				r = 0.85,
				g = 0.85,
				b = 0.85,
				a = 1.0
			},
			usewho = false,
			color = {
				r = 0.65,
				g = 0.65,
				b = 0.65,
				a = 1.0
			},
		}
	})

	module.pluginopts = {}

	Prat:SetModuleOptions(module, {
		name = PL["PlayerNames"],
		desc = PL["Player name formating options."],
		type = "group",
		plugins = module.pluginopts,
		args = {
			brackets = {
				name = PL["Brackets"],
				desc = PL["Sets style of brackets to use around player names."],
				type = "select",
				order = 110,
				values = { ["Square"] = PL["Square"], ["Angled"] = PL["Angled"], ["None"] = PL["None"] }
			},
			bracketscommoncolor = {
				name = PL["Brackets Use Common Color"],
				desc = PL["Toggle using a common color for brackets around player names."],
				type = "toggle",
				order = 111,
			},
			bracketscolor = {
				name = PL["Brackets Common Color"],
				desc = PL["Sets common color of brackets to use around player names."],
				type = "color",
				order = 112,
				get = "GetColorValue",
				set = "SetColorValue",
				disabled = function(info)
					return not info.handler.db.profile.bracketscommoncolor
				end,
			},
			usecommoncolor = {
				name = PL["Unknown Use Common Color"],
				desc = PL["Toggle using a common color for unknown player names."],
				type = "toggle",
				order = 120,
			},
			color = {
				name = PL["Unknown Common Color"],
				desc = PL["Set common color of unknown player names."],
				type = "color",
				order = 121,
				get = "GetColorValue",
				set = "SetColorValue",
				disabled = function(info)
					if not info.handler.db.profile.usecommoncolor then
						return true
					else
						return false
					end
				end,
			},
			colormode = {
				name = PL["Player Color Mode"],
				desc = PL["How to color player's name."],
				type = "select",
				order = 130,
				values = { ["RANDOM"] = PL["Random"], ["CLASS"] = PL["Class"], ["NONE"] = PL["None"] }
			},
			realidcolor = {
				name = PL["realidcolor_name"],
				desc = PL["realidcolor_desc"],
				type = "select",
				order = 135,
				values = { ["RANDOM"] = PL["Random"], ["CLASS"] = PL["Class"], ["NONE"] = PL["None"] }
			},
			realidname = {
				name = PL["Use toon name for RealID"],
				desc = PL["Use toon name for RealID"],
				type = "toggle",
				order = 136,
			},
			bnetclienticon = {
				name = PL.bnetclienticon_name,
				desc = PL.bnetclienticon_desc,
				type = "toggle",
				order = 137,
			},
			levelcolor = {
				name = PL["Level Color Mode"],
				desc = PL["How to color other player's level."],
				type = "select",
				order = 131,
				values = {
					["PLAYER"] = PL["Use Player Color"],
					["CHANNEL"] = PL["Use Channel Color"],
					["DIFFICULTY"] = PL["Color by Level Difference"],
					["NONE"] = PL["No additional coloring"]
				}
			},
			level = {
				name = PL["Show Level"],
				desc = PL["Toggle level showing."],
				type = "toggle",
				order = 140,
			},
			subgroup = {
				name = PL["Show Group"],
				desc = PL["Toggle raid group showing."],
				type = "toggle",
				order = 141,
			},
			showtargeticon = {
				name = PL["Show Raid Target Icon"],
				desc = PL["Toggle showing the raid target icon which is currently on the player."],
				type = "toggle",
				order = 142,
				hidden = Prat.IsRetail,
			},
			tabcomplete = {
				name = PL["Enable TabComplete"],
				desc = PL["Toggle tab completion of player names."],
				type = "toggle",
				order = 150,
				get = function(info)
					return info.handler.db.profile.tabcomplete
				end,
				set = function(info, v)
					info.handler.db.profile.tabcomplete = v;
					info.handler:TabComplete(v)
				end
			},
			keep = {
				name = PL["Keep Info"],
				desc = PL["Keep player information between session, but limit it to friends and guild members."],
				type = "toggle",
				order = 200,
			},
			keeplots = {
				name = PL["Keep Lots Of Info"],
				desc = PL["Keep player information between session for all players except cross-server players"],
				type = "toggle",
				order = 201,
				disabled = function(info)
					return not info.handler.db.profile.keep
				end,
			},
			usewho = {
				name = PL["Actively Query Player Info"],
				desc = PL["Query the server for all player names we do not know. Note: This happpens pretty slowly, and this data is not saved."],
				type = "toggle",
				order = 202,
				hidden = function()
					if LibStub:GetLibrary("LibWho-2.0", true) then
						return false
					end

					if C_AddOns.GetAddOnInfo("LibWho-2.0") then
						return false
					end

					return true
				end
			},
			reset = {
				name = PL["Reset Settings"],
				desc = PL["Restore default settings, and delete stored character data."],
				type = "execute",
				order = 250,
				func = "resetStoredData"
			},
		}
	})

	function module:OnValueChanged(info, b)
		local field = info[#info]
		if field == "altinvite" or field == "linkinvite" then
			self:SetAltInvite()
		elseif field == "usewho" then
			if b and not LibStub:GetLibrary("LibWho-2.0", true) then
				C_AddOns.LoadAddOn("LibWho-2.0")
			end
			self.wholib = b and LibStub:GetLibrary("LibWho-2.0", true)
			self:UpdateAll()
		elseif field == "coloreverywhere" then
			self:OnPlayerDataChanged(b and UnitName("player") or nil)
		end
	end

	function module:OnModuleEnable()
		Prat.RegisterChatEvent(self, "Prat_FrameMessage")
		Prat.RegisterChatEvent(self, "Prat_Ready")

		Prat.RegisterMessageItem("PREPLAYERDELIM", "PLAYER", "before")
		Prat.RegisterMessageItem("POSTPLAYERDELIM", "Ss", "after")
		Prat.RegisterMessageItem("PLAYERTARGETICON", "Ss", "after")
		Prat.RegisterMessageItem("PLAYERLEVEL", "PREPLAYERDELIM", "before")
		Prat.RegisterMessageItem("PLAYERGROUP", "POSTPLAYERDELIM", "after")
		Prat.RegisterMessageItem("PLAYERCLIENTICON", "PLAYERLEVEL", "before")

		Prat.EnableProcessingForEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
		Prat.EnableProcessingForEvent("CHAT_MSG_ACHIEVEMENT")

		self:RegisterEvent("FRIENDLIST_UPDATE", "UpdateFriends")
		self:RegisterEvent("GUILD_ROSTER_UPDATE")
		self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateGroup")
		self:RegisterEvent("PLAYER_LEVEL_UP")
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateTarget")
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateMouseOver")
		self:RegisterEvent("WHO_LIST_UPDATE", "UpdateWho")
		self:RegisterEvent("CHAT_MSG_SYSTEM", "UpdateWho")
		self:RegisterEvent("PLAYER_LEAVING_WORLD", "EmptyDataCache")

		if self.db.profile.usewho then
			if not LibStub:GetLibrary("LibWho-2.0", true) then
				C_AddOns.LoadAddOn("LibWho-2.0")
			end
			self.wholib = LibStub:GetLibrary("LibWho-2.0", true)
		end

		self:UpdatePlayer()
		self.NEEDS_INIT = true

		if IsInGuild() then
			C_GuildInfo.GuildRoster()
		end

		self:TabComplete(self.db.profile.tabcomplete)

		self:CacheAppIcons()
	end

	function module:OnModuleDisable()
		self:TabComplete(false)
		self:UnregisterAllEvents()
		Prat.UnregisterAllChatEvents(self)
	end

	function module:Prat_Ready()
		self:UpdateAll()
	end

	local cache = {
		module.Levels,
		module.Classes,
		module.Subgroups
	}

	function module:EmptyDataCache()
		for _, v in pairs(cache) do
			wipe(v)
		end

		self:UpdatePlayer()
		self.NEEDS_INIT = true
		self:OnPlayerDataChanged()
	end

	--[[------------------------------------------------
	  Fill Functions
	------------------------------------------------]] --
	local function GetToonInfoByBnetID(bnetAccountID)
		if not bnetAccountID then
			return
		end

		local accountInfo = C_BattleNet.GetAccountInfoByID(bnetAccountID)
		if not accountInfo then
			return
		end

		return accountInfo.gameAccountInfo.characterName,
			accountInfo.gameAccountInfo.characterLevel,
			accountInfo.gameAccountInfo.className
	end

	local function GetBnetClientByID(bnetAccountID)
		if not bnetAccountID then
			return
		end

		local accountInfo = C_BattleNet.GetAccountInfoByID(bnetAccountID)
		if not accountInfo then
			return
		end

		return accountInfo.gameAccountInfo.clientProgram
	end

	function module:CacheAppIcons()
		self.appIcons = {}

		-- List derived from old atlas containing client icons
		for _, client in ipairs({
			"App", -- B.net
			"WoW",
			"Hero", -- Heroes of the Storm
			"LAZR", -- Modern Warfare 2
			"OSI", -- Diablo Something
			"Pro", -- Overwatch
			"Overwatch-zhCN", -- Overwatch zhCN
			"RTRO",
			"ODIN", -- Modern Warfare
			"S1", -- Starcraft 1
			"WTCG", -- Hearthstone
			"ZEUS", -- Black Ops
			"FEN", -- Diablo 4
			"D3", -- Diablo 3
			"ANBS", -- Diablo Something
			"VIPR",
			"W3", -- Warcraft 3
			"WLBY",
			"GRY",
		}) do
			C_Texture.GetTitleIconTexture(client, 0, function(success, texture)
				if success then
					self.appIcons[client] = texture
				end
			end)
		end
	end

	--[[------------------------------------------------
	  Core Functions
	------------------------------------------------]] --
	function module:GetDescription()
		return PL["Player name formating options."]
	end

	function module:UpdateAll()
		self.NEEDS_INIT = nil
		self:UpdatePlayer()
		self:UpdateFriends()
		self:UpdateWho()
		if IsInGuild() then
			C_GuildInfo.GuildRoster()
		end
		if GetNumBattlefieldScores() > 0 then
			self:UpdateBG()
		else
			self:UpdateGroup()
		end
	end

	function module:UpdateGF()
		self:UpdateFriends()
		self:UpdateWho()
		if IsInGuild() then
			C_GuildInfo.GuildRoster()
		end
		if GetNumBattlefieldScores() > 0 then
			self:UpdateBG()
		else
			self:UpdateGroup()
		end
	end

	function module:UpdatePlayer()
		local PlayerClass = select(2, UnitClass("player"))
		local Name, Server = UnitName("player")
		self:addName(Name, Server, PlayerClass, UnitLevel("player"), nil, "PLAYER")
	end

	function module:PLAYER_LEVEL_UP(_, level)
		local PlayerClass = select(2, UnitClass("player"))
		local Name, Server = UnitName("player")
		self:addName(Name, Server, PlayerClass, level, nil, "PLAYER")
	end

	function module:UpdateFriends()
		for i = 1, C_FriendList.GetNumFriends() do
			local info = C_FriendList.GetFriendInfoByIndex(i)
			self:addName(info.name, nil, info.className, info.level, nil, "FRIEND")
		end
	end

	function module:GUILD_ROSTER_UPDATE()
		for i = 1, GetNumGuildMembers() do
			local Name, _, _, Level, _, _, _, _, _, _, Class = GetGuildRosterInfo(i)
			if Name then
				local plr, svr = Name:match("([^%-]+)%-?(.*)")
				self:addName(plr, nil, Class, Level, nil, "GUILD")
				self:addName(plr, svr, Class, Level, nil, "GUILD")
			end
		end
	end

	function module:UpdateRaid()
		for k, _ in pairs(self.Subgroups) do
			self.Subgroups[k] = nil
		end

		for i = 1, GetNumGroupMembers() do
			local _, _, SubGroup, Level, _, Class = GetRaidRosterInfo(i)
			local Name, Server = UnitName("raid" .. i)
			self:addName(Name, Server, Class, Level, SubGroup, "RAID")
		end
	end

	function module:UpdateParty()
		for i = 1, GetNumSubgroupMembers() do
			local Unit = "party" .. i
			local _, Class = UnitClass(Unit)
			local Name, Server = UnitName(Unit)
			self:addName(Name, Server, Class, UnitLevel(Unit), nil, "PARTY")
		end
	end

	function module:UpdateGroup()
		if IsInRaid() then
			self:UpdateRaid()
		elseif IsInGroup() then
			self:UpdateParty()
		end
	end

	function module:UpdateTarget()
		if not UnitIsPlayer("target") or not UnitIsFriend("player", "target") then
			return
		end
		local Class = select(2, UnitClass("target"))
		local Name, Server = UnitName("target")
		self:addName(Name, Server, Class, UnitLevel("target"), nil, "TARGET")
	end

	function module:UpdateMouseOver()
		if not UnitIsPlayer("mouseover") or not UnitIsFriend("player", "mouseover") then
			return
		end
		local Class = select(2, UnitClass("mouseover"))
		local Name, Server = UnitName("mouseover")
		self:addName(Name, Server, Class, UnitLevel("mouseover"), nil, "MOUSE")
	end

	function module:UpdateWho()
		if self.wholib then
			return
		end

		for i = 1, C_FriendList.GetNumWhoResults() do
			local info = C_FriendList.GetWhoInfo(i)
			self:addName(info.fullName, nil, info.classStr, info.level, nil, "WHO")
		end
	end

	function module:UpdateBG()
		for i = 1, GetNumBattlefieldScores() do
			local name, _, _, _, _, _, _, _, class = GetBattlefieldScore(i);

			if name and (not issecretvalue or not issecretvalue(name)) then
				local plr, svr = name:match("([^%-]+)%-?(.*)")
				self:addName(plr, nil, class, nil, nil, "BATTLEFIELD")
				self:addName(plr, svr, class, nil, nil, "BATTLEFIELD")
			end
		end
		self:UpdateGroup()
	end

	function module:resetStoredData()
		self.db.realm.classes = {}
		self.db.realm.levels = {}

		self:EmptyDataCache(true)

		self:Output(PL.msg_stored_data_cleared)
	end

	--
	-- Coloring Functions
	--
	local CLR = Prat.CLR
	function CLR:Bracket(text)
		return self:Colorize(module:GetBracketCLR(), text)
	end

	function CLR:Random(text, seed)
		return self:Colorize(module:GetRandomCLR(seed), text)
	end

	local colorFunc = GetQuestDifficultyColor or GetDifficultyColor
	function CLR:Level(text, level, name, class, mode)
		mode = mode or module.db.profile.levelcolor
		if mode and type(level) == "number" and level > 0 then
			if mode == "DIFFICULTY" then
				local diff = colorFunc(level)
				return self:Colorize(CLR:GetHexColor(CLR:Desaturate(diff)), text)
			elseif mode == "PLAYER" then
				return self:Player(text, name, class)
			end
		end

		return text
	end

	function CLR:Player(text, name, class)
		local mode = module.db.profile.colormode

		if name then
			if class and mode == "CLASS" then
				local classColor = Prat.GetClassColor(class, true)
				if classColor then
					return classColor:WrapTextInColorCode(text)
				end
				return text
			elseif mode == "RANDOM" then
				return self:Colorize(module:GetRandomCLR(name), text)
			else
				return self:Colorize(module:GetCommonCLR(), text)
			end
		end
	end

	local servernames
	function module:addName(Name, Server, Class, Level, SubGroup, Source)
		if not Name then
			return
		end

		if issecretvalue and (issecretvalue(Name) or issecretvalue(Server)) then
			return
		end

		local nosave
		Source = Source or "UNKNOWN"

		-- Messy negations, but this says dont save data from
		-- sources other than guild or friends unless you enable
		-- the keeplots option
		if Source ~= "GUILD" and Source ~= "FRIEND" and Source ~= "PLAYER" then
			nosave = not self.db.profile.keeplots
		end

		if Server and Server:len() > 0 then
			nosave = true
			servernames = servernames or Prat:GetModule("ServerNames")

			if servernames then
				servernames:GetServerKey(Server)
			end
		end

		Name = Name .. (Server and Server:len() > 0 and ("-" .. Server) or "")

		local changed
		if Level and Level > 0 then
			self.Levels[Name:lower()] = Level
			if ((not nosave) and self.db.profile.keep) then
				self.db.realm.levels[Name:lower()] = Level
			else
				-- Update it if it exists
				if self.db.realm.levels[Name:lower()] then
					self.db.realm.levels[Name:lower()] = Level
				end
			end

			changed = true
		end
		if Class and Class ~= UNKNOWN then
			self.Classes[Name:lower()] = Class
			if ((not nosave) and self.db.profile.keep) then
				self.db.realm.classes[Name:lower()] = Class
			end

			changed = true
		end
		if SubGroup then
			module.Subgroups[Name:lower()] = SubGroup

			changed = true
		end

		if changed then
			self:OnPlayerDataChanged(Name)
		end
	end

	function module:getClass(player)
		return self.Classes[player:lower()] or self.db.realm.classes[player:lower()] or self.db.realm.classes[player]
	end

	function module:getLevel(player)
		return self.Levels[player:lower()] or self.db.realm.levels[player:lower()] or self.db.realm.levels[player]
	end

	function module:getSubgroup(player)
		return self.Subgroups[player:lower()]
	end

	function module:GetData(player)
		local class = self:getClass(player)
		local level = self:getLevel(player)

		if level == 0 then
			level = nil
		end
		if class == UNKNOWN then
			class = nil
		end

		if self.wholib and not (class and level) then
			local user = self.wholib:UserInfo(player, { timeout = 20 })

			if user then
				level = user.Level or level
				class = user.NoLocaleClass or user.Class or class
			end
		end
		return class, level, self:getSubgroup(player)
	end

	function module:FormatPlayer(message, Name, frame, class)
		if not Name or Name:len() == 0 then
			return
		end

		local storedclass, level, subgroup = self:GetData(Name, frame)
		if class == nil then
			class = storedclass
		end

		-- Add level information if needed
		if level and self.db.profile.level then
			message.PLAYERLEVEL = CLR:Level(tostring(level), level, Name, class)
			message.PREPLAYERDELIM = ":"
		end

		-- Add raid subgroup information if needed
		if subgroup and self.db.profile.subgroup and (GetNumGroupMembers() > 0) then
			message.POSTPLAYERDELIM = ":"
			message.PLAYERGROUP = subgroup
		end

		-- Add raid target icon
		if not Prat.IsRetail and self.db.profile.showtargeticon then
			local icon = UnitExists(Name) and GetRaidTargetIndex(Name)
			if icon then
				icon = ICON_LIST[icon]

				if icon and icon:len() > 0 then
					-- since you cant have icons in links end the link before the icon
					message.PLAYERTARGETICON = "|h" .. icon .. "0|t"
					message.Ll = ""
				end
			end
		end

		if message.PLAYERLINKDATA and (message.PLAYERLINKDATA:find("BN_") and message.PLAYER ~= UnitName("player")) then
			if self.db.profile.realidcolor == "CLASS" then
				local toonName, toonLevel, toonClass = GetToonInfoByBnetID(message.PRESENCE_ID)
				if toonName and self.db.profile.realidname then
					message.PLAYER = toonName
					if level and self.db.profile.level then
						message.PLAYERLEVEL = CLR:Level(tostring(toonLevel), tonumber(toonLevel), nil, nil, "DIFFICULTY")
						message.PREPLAYERDELIM = ":"
					end
				end

				local classColor = Prat.GetClassColor(toonClass, true)
				if classColor then
					message.PLAYER = classColor:WrapTextInColorCode(message.PLAYER)
				end
			elseif self.db.profile.realidcolor == "RANDOM" then
				message.PLAYER = CLR:Random(message.PLAYER, message.PLAYER:lower())
			end

			if self.db.profile.bnetclienticon then
				local client = GetBnetClientByID(message.PRESENCE_ID)
				if client and self.appIcons[client] then
					message.PLAYERCLIENTICON = CreateTextureMarkup(self.appIcons[client], 12, 12, 12, 12, 0, 1, 0, 1) .. " "
				elseif client then
					C_Texture.GetTitleIconTexture(client, 0, function(success, texture)
						if success then
							self.appIcons[client] = texture
						end
					end)
				end
			end
		else
			-- Add the player name in the proper color
			message.PLAYER = CLR:Player(message.PLAYER, Name, class)
		end

		-- Add the correct bracket style and color
		if message.pP then
			local prof_brackets = self.db.profile.brackets
			if prof_brackets == "Angled" then
				message.pP = CLR:Bracket("<") .. message.pP
				message.Pp = message.Pp .. CLR:Bracket(">")
			elseif prof_brackets ~= "None" then
				message.pP = CLR:Bracket("[") .. message.pP
				message.Pp = message.Pp .. CLR:Bracket("]")
			end
		end
	end

	--
	-- Prat Event Implementation
	--
	local EVENTS_FOR_RECHECK = {
		["CHAT_MSG_GUILD"] = module.UpdateGF,
		["CHAT_MSG_INSTANCE_CHAT"] = module.UpdateBG,
		["CHAT_MSG_INSTANCE_CHAT_LEADER"] = module.UpdateBG,
		["CHAT_MSG_SYSTEM"] = module.UpdateGF,
	}

	local EVENTS_FOR_CACHE_GUID_DATA = {
		CHAT_MSG_PARTY = true,
		CHAT_MSG_PARTY_LEADER = true,
		CHAT_MSG_RAID = true,
		CHAT_MSG_RAID_WARNING = true,
		CHAT_MSG_RAID_LEADER = true,
		CHAT_MSG_INSTANCE_CHAT = true,
		CHAT_MSG_INSTANCE_CHAT_LEADER = true,
	}

	function module:Prat_FrameMessage(_, message, frame, event)
		if self.NEEDS_INIT then
			self:UpdateAll()
		end

		-- This name is used to lookup playerdata, not for display
		local Name = message.PLAYERLINK or ""
		message.Pp = ""
		message.pP = ""

		-- If there is no playerlink, then we have nothing to do
		if Name:len() == 0 then
			return
		end

		Name = Ambiguate(Name, "all")

		local _
		local class, level, subgroup = self:GetData(Name)

		if (class == nil) and message and message.ORG and message.ORG.GUID and message.ORG.GUID:len() > 0 and message.ORG.GUID ~= "0000000000000000" then
			_, class = GetPlayerInfoByGUID(message.ORG.GUID)

			if class ~= nil and EVENTS_FOR_CACHE_GUID_DATA[event] then
				self:addName(Name, message.SERVER, class, level, subgroup, "GUID")
			end
		end

		local fx = EVENTS_FOR_RECHECK[event]
		if fx ~= nil and (level == nil or level == 0) then
			fx(self)
		end

		self:FormatPlayer(message, Name, frame, class)
	end

	function module:GetBracketCLR()
		if not self.db.profile.bracketscommoncolor then
			return CLR.COLOR_NONE
		end

		return CLR:GetHexColor(self.db.profile.bracketscolor)
	end

	function module:GetCommonCLR()
		if not self.db.profile.usecommoncolor then
			return CLR.COLOR_NONE
		end

		return CLR:GetHexColor(self.db.profile.color)
	end

	function module:GetRandomCLR(Name)
		local hash = 17
		for i = 1, string.len(Name) do
			hash = hash * 37 * string.byte(Name, i);
		end

		local r = math.floor(math.fmod(hash / 97, 255));
		local g = math.floor(math.fmod(hash / 17, 255));
		local b = math.floor(math.fmod(hash / 227, 255));

		if ((r * 299 + g * 587 + b * 114) / 1000) < 105 then
			r = math.abs(r - 255);
			g = math.abs(g - 255);
			b = math.abs(b - 255);
		end

		return string.format("%02x%02x%02x", r, g, b)
	end

	local AceTab = LibStub("AceTab-3.0", true)
	function module:TabComplete(enabled)
		if not enabled then
			if AceTab:IsTabCompletionRegistered(PL["tabcomplete_name"]) then
				AceTab:UnregisterTabCompletion(PL["tabcomplete_name"])
			end
			return
		end

		servernames = servernames or Prat:GetModule("ServerNames")

		if not AceTab:IsTabCompletionRegistered(PL["tabcomplete_name"]) then
			AceTab:RegisterTabCompletion(
				PL["tabcomplete_name"],
				nil,
				function(t)
					for name in pairs(self.Classes) do
						table.insert(t, name)
					end
				end,
				function(_, cands)
					local candcount = #cands
					if candcount <= self.db.profile.tabcompletelimit then
						local text
						for key, cand in pairs(cands) do
							if servernames then
								local plr, svr = key:match("([^%-]+)%-?(.*)")

								cand = CLR:Player(cand, plr, self:getClass(key))

								if svr then
									svr = servernames:FormatServer(nil, servernames:GetServerKey(svr))
									cand = cand .. (svr and ("-" .. svr) or "")
								end
							else
								cand = CLR:Player(cand, cand, self:getClass(cand))
							end

							text = text and (text .. ", " .. cand) or cand
						end
						return "   " .. text
					else
						return "   " .. PL["Too many matches (%d possible)"]:format(candcount)
					end
				end,
				nil,
				function(name)
					return name:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1):match("^[^%-]+")
				end
			)
		end
	end

	return
end)
