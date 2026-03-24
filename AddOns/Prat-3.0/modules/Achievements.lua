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

local SendChatMessage = C_ChatInfo.SendChatMessage or SendChatMessage

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("Achievements")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["module_name"] = "Achievements",
		["module_desc"] = "Achievement related customizations",
		["grats_link"] = "say grats",
		["completed"] = "Completed %s",
		["showCompletedDate_name"] = "Show completed date",
		["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link",
		["showGratsLink_name"] = "Show grats link",
		["showGratsLink_desc"] = "Show a clickable link which sends a grats message",
		["dontShowAchievements_name"] = "Don't show achievements",
		["dontShowAchievements_desc"] = "Hide all achievement messages",
		["customGrats_defualt"] = "Grats %s",
		["customGrats_name"] = "Use Custom Grats Message",
		["customGrats_desc"] = "Use a custom grats message instead of a random one",
		["customGratsText_name"] = "Grats Message",
		["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder",
		["grats_have_1"] = "Grats %s",
		["grats_have_2"] = "Gz %s, I have that one too",
		["grats_have_3"] = "Wow %s that's great",
		["grats_have_4"] = "Welcome to the club %s",
		["grats_have_5"] = "I can still rememeber getting that one %s",
		["grats_have_6"] = "That one is a rite of passage %s",
		["grats_have_7"] = "I worked on that for ages %s, grats!",
		["grats_have_8"] = "I remember doing that, %s, grats!",
		["grats_have_9"] = "Nicely done %s",
		["grats_have_10"] = "Good work %s, now we both have it",
		["grats_donthave_1"] = "Grats %s",
		["grats_donthave_2"] = "Gz %s, I still need that",
		["grats_donthave_3"] = "I want that one %s, grats!",
		["grats_donthave_4"] = "Wow %s that's great",
		["grats_donthave_5"] = "I'm jealous %s, grats!",
		["grats_donthave_6"] = "I have been working on that for ages %s",
		["grats_donthave_7"] = "Still need that one %s, grats!",
		["grats_donthave_8"] = "WTB your achievement %s",
		["grats_donthave_9"] = "Looking forward to that one myself %s, good job!",
		["grats_donthave_10"] = "I can't wait to get that one %s",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
  local L
  L = {}
  -- Achievements
L["completed"] = "Completed %s"
L["customGrats_defualt"] = "Grats %s"
L["customGrats_desc"] = "Use a custom grats message instead of a random one"
L["customGrats_name"] = "Use Custom Grats Message"
L["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder"
L["customGratsText_name"] = "Grats Message"
L["dontShowAchievements_desc"] = "Hide all achievement messages"
L["dontShowAchievements_name"] = "Don't show achievements"
L["grats_donthave_1"] = "Grats %s"
L["grats_donthave_10"] = "I can't wait to get that one %s"
L["grats_donthave_2"] = "Gz %s, I still need that"
L["grats_donthave_3"] = "I want that one %s, grats!"
L["grats_donthave_4"] = "Wow %s that's great"
L["grats_donthave_5"] = "I'm jealous %s, grats!"
L["grats_donthave_6"] = "I have been working on that for ages %s"
L["grats_donthave_7"] = "Still need that one %s, grats!"
L["grats_donthave_8"] = "WTB your achievement %s"
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
L["grats_have_1"] = "Grats %s"
L["grats_have_10"] = "Good work %s, now we both have it"
L["grats_have_2"] = "Gz %s, I have that one too"
L["grats_have_3"] = "Wow %s that's great"
L["grats_have_4"] = "Welcome to the club %s"
L["grats_have_5"] = "I can still rememeber getting that one %s"
L["grats_have_6"] = "That one is a rite of passage %s"
L["grats_have_7"] = "I worked on that for ages %s, grats!"
L["grats_have_8"] = "I remember doing that, %s, grats!"
L["grats_have_9"] = "Nicely done %s"
L["grats_link"] = "say grats"
L["module_desc"] = "Achievement related customizations"
L["module_name"] = "Achievements"
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
L["showCompletedDate_name"] = "Show completed date"
L["showGratsLink_desc"] = "Show a clickable link which sends a grats message"
L["showGratsLink_name"] = "Show grats link"

  PL:AddLocale("enUS", L)


  L = {}
  -- Achievements
--[[Translation missing --]]
L["completed"] = "Completed %s"
--[[Translation missing --]]
L["customGrats_defualt"] = "Grats %s"
--[[Translation missing --]]
L["customGrats_desc"] = "Use a custom grats message instead of a random one"
--[[Translation missing --]]
L["customGrats_name"] = "Use Custom Grats Message"
--[[Translation missing --]]
L["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder"
--[[Translation missing --]]
L["customGratsText_name"] = "Grats Message"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
--[[Translation missing --]]
L["grats_donthave_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_donthave_10"] = "I can't wait to get that one %s"
--[[Translation missing --]]
L["grats_donthave_2"] = "Gz %s, I still need that"
--[[Translation missing --]]
L["grats_donthave_3"] = "I want that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_4"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_donthave_5"] = "I'm jealous %s, grats!"
--[[Translation missing --]]
L["grats_donthave_6"] = "I have been working on that for ages %s"
--[[Translation missing --]]
L["grats_donthave_7"] = "Still need that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_8"] = "WTB your achievement %s"
--[[Translation missing --]]
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
--[[Translation missing --]]
L["grats_have_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_have_10"] = "Good work %s, now we both have it"
--[[Translation missing --]]
L["grats_have_2"] = "Gz %s, I have that one too"
--[[Translation missing --]]
L["grats_have_3"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_have_4"] = "Welcome to the club %s"
--[[Translation missing --]]
L["grats_have_5"] = "I can still rememeber getting that one %s"
--[[Translation missing --]]
L["grats_have_6"] = "That one is a rite of passage %s"
--[[Translation missing --]]
L["grats_have_7"] = "I worked on that for ages %s, grats!"
--[[Translation missing --]]
L["grats_have_8"] = "I remember doing that, %s, grats!"
--[[Translation missing --]]
L["grats_have_9"] = "Nicely done %s"
--[[Translation missing --]]
L["grats_link"] = "say grats"
--[[Translation missing --]]
L["module_desc"] = "Achievement related customizations"
--[[Translation missing --]]
L["module_name"] = "Achievements"
--[[Translation missing --]]
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
--[[Translation missing --]]
L["showCompletedDate_name"] = "Show completed date"
--[[Translation missing --]]
L["showGratsLink_desc"] = "Show a clickable link which sends a grats message"
--[[Translation missing --]]
L["showGratsLink_name"] = "Show grats link"

  PL:AddLocale("itIT", L)


  L = {}
  -- Achievements
--[[Translation missing --]]
L["completed"] = "Completed %s"
--[[Translation missing --]]
L["customGrats_defualt"] = "Grats %s"
--[[Translation missing --]]
L["customGrats_desc"] = "Use a custom grats message instead of a random one"
--[[Translation missing --]]
L["customGrats_name"] = "Use Custom Grats Message"
--[[Translation missing --]]
L["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder"
--[[Translation missing --]]
L["customGratsText_name"] = "Grats Message"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
L["grats_donthave_1"] = "Parabéns %s"
L["grats_donthave_10"] = "Não vejo a hora de ter esse, %s"
L["grats_donthave_2"] = "Boa %s, eu ainda preciso desse"
L["grats_donthave_3"] = "Eu também quero esse, %s. Parabéns!"
L["grats_donthave_4"] = "Nossa %s, que incrível."
--[[Translation missing --]]
L["grats_donthave_5"] = "I'm jealous %s, grats!"
--[[Translation missing --]]
L["grats_donthave_6"] = "I have been working on that for ages %s"
--[[Translation missing --]]
L["grats_donthave_7"] = "Still need that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_8"] = "WTB your achievement %s"
--[[Translation missing --]]
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
--[[Translation missing --]]
L["grats_have_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_have_10"] = "Good work %s, now we both have it"
--[[Translation missing --]]
L["grats_have_2"] = "Gz %s, I have that one too"
--[[Translation missing --]]
L["grats_have_3"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_have_4"] = "Welcome to the club %s"
--[[Translation missing --]]
L["grats_have_5"] = "I can still rememeber getting that one %s"
--[[Translation missing --]]
L["grats_have_6"] = "That one is a rite of passage %s"
--[[Translation missing --]]
L["grats_have_7"] = "I worked on that for ages %s, grats!"
--[[Translation missing --]]
L["grats_have_8"] = "I remember doing that, %s, grats!"
--[[Translation missing --]]
L["grats_have_9"] = "Nicely done %s"
--[[Translation missing --]]
L["grats_link"] = "say grats"
--[[Translation missing --]]
L["module_desc"] = "Achievement related customizations"
--[[Translation missing --]]
L["module_name"] = "Achievements"
--[[Translation missing --]]
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
--[[Translation missing --]]
L["showCompletedDate_name"] = "Show completed date"
--[[Translation missing --]]
L["showGratsLink_desc"] = "Show a clickable link which sends a grats message"
--[[Translation missing --]]
L["showGratsLink_name"] = "Show grats link"

  PL:AddLocale("ptBR", L)



  L = {}
  -- Achievements
--[[Translation missing --]]
L["completed"] = "Completed %s"
L["customGrats_defualt"] = "GG %s !"
L["customGrats_desc"] = "Utiliser un message personnalisé à la place d'un message aléatoire "
L["customGrats_name"] = "Utiliser un message personnalisé de félicitations"
L["customGratsText_desc"] = "Message de félicitations personnalisé. Tapez n'importe quel texte, vous pouvez ajouter le nom du joueur avec la variable '%s'"
L["customGratsText_name"] = "Message de gratification"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
L["grats_donthave_1"] = "Félicitations %s !"
L["grats_donthave_10"] = "Il faut aussi que je fasse ce haut fait %s"
L["grats_donthave_2"] = "GG %s, je ne l'ai pas encore fini celui là"
L["grats_donthave_3"] = "Il faut aussi que je le fasse celui là %s, gg !"
L["grats_donthave_4"] = "Bien joué %s"
L["grats_donthave_5"] = "Je suis trop jaloux %s, gg !  :)"
L["grats_donthave_6"] = "Ça fait un baille que je tente de l'avoir celui là %s ^^"
L["grats_donthave_7"] = "Il me manque toujours celui là %s, gg !"
L["grats_donthave_8"] = "Tu ne veux pas aussi me le faire %s ? xD"
L["grats_donthave_9"] = "Vivement que je le fasse aussi %s, bien joué !"
L["grats_have_1"] = "Félicitations %s"
L["grats_have_10"] = "Bien joué %s, maintenant on l'a tous les deux :)"
L["grats_have_2"] = "GG %s, je l'ai aussi validé"
L["grats_have_3"] = "Waw %s, c'est bien joué !"
L["grats_have_4"] = "Bienvenue au club %s"
L["grats_have_5"] = "Je me souviens encore de la fois où j'ai réalisé ce HF %s"
L["grats_have_6"] = "Celui là est un incontournable %s"
L["grats_have_7"] = "J'ai mis du temps à l'obtenir celui là %s, gg !"
L["grats_have_8"] = "Je me souviens encore de la fois où je l'ai réalisé, %s, gg !"
L["grats_have_9"] = "Bien joué %s"
L["grats_link"] = "dire gg"
--[[Translation missing --]]
L["module_desc"] = "Achievement related customizations"
--[[Translation missing --]]
L["module_name"] = "Achievements"
--[[Translation missing --]]
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
--[[Translation missing --]]
L["showCompletedDate_name"] = "Show completed date"
L["showGratsLink_desc"] = "Montrer un lien clicable qui envoie des messages de félicitations"
L["showGratsLink_name"] = "Montrer un lien de félicitations"

  PL:AddLocale("frFR", L)


  L = {}
  -- Achievements
L["completed"] = "Abgeschlossen %s"
L["customGrats_defualt"] = "Grats %s"
L["customGrats_desc"] = "Verwende eine eigene Glückwunsch-Nachricht anstelle einer zufälligen"
L["customGrats_name"] = "Verwende eine eigene Glückwunsch-Nachricht"
L["customGratsText_desc"] = "Eigene Glückwunsch-Nachricht. Gib einen beliebigen Text für die Glückwunsch-Nachricht ein. Wenn du den Namen des Spielers einfügen möchtest, verwende '%s' als Platzhalter."
L["customGratsText_name"] = "Glückwunsch-Nachricht"
L["dontShowAchievements_desc"] = "Verstecke alle Erfolgsmeldungen"
L["dontShowAchievements_name"] = "Zeige keine Erfolge"
L["grats_donthave_1"] = "Grats %s"
L["grats_donthave_10"] = "Ich kann es kaum erwarten, diesen %s zu bekommen"
L["grats_donthave_2"] = "Gz %s, diesen brauche ich noch"
L["grats_donthave_3"] = "Ich will diesen auch %s, grats!"
L["grats_donthave_4"] = "Wow %s, der ist großartig"
L["grats_donthave_5"] = "Ich bin neidisch %s, grats!"
L["grats_donthave_6"] = "Daran arbeite ich schon seit Ewigkeiten %s"
L["grats_donthave_7"] = "Brauche den noch %s, grats!"
L["grats_donthave_8"] = "WTB dein Erfolg %s"
L["grats_donthave_9"] = "Ich freue mich darauf %s, gute Arbeit!"
L["grats_have_1"] = "Grats %s"
L["grats_have_10"] = "Gute Arbeit %s, jetzt haben wir beide den"
L["grats_have_2"] = "Gz %s, ich habe den auch"
L["grats_have_3"] = "Wow %s, der ist großartig"
L["grats_have_4"] = "Willkommen im Club %s"
L["grats_have_5"] = "Ich kann mich immer noch daran erinnern, diesen %s bekommen zu haben"
L["grats_have_6"] = "Das ist ein Übergangsritus %s"
L["grats_have_7"] = "Ich habe ewig daran gearbeitet %s, grats!"
L["grats_have_8"] = "Ich erinnere mich, als ich den gemacht habe, %s, grats!"
L["grats_have_9"] = "Schön gemacht %s"
L["grats_link"] = "sag grats"
L["module_desc"] = "Erfolgsbezogene Anpassungen"
L["module_name"] = "Erfolge"
L["showCompletedDate_desc"] = "Zeigt neben dem Link das Datum an, an dem du diesen Erfolg abgeschlossen hast"
L["showCompletedDate_name"] = "Abschließungsdatum anzeigen"
L["showGratsLink_desc"] = "Zeigt einen anklickbaren Link an, der eine Grats-Nachricht sendet"
L["showGratsLink_name"] = "Grats Link anzeigen"

  PL:AddLocale("deDE", L)


  L = {}
  -- Achievements
L["completed"] = "%s 완료"
L["customGrats_defualt"] = "%s님 축하!"
L["customGrats_desc"] = "임의의 메시지 대신 사용자 정의 축하 메시지를 사용하십시오."
L["customGrats_name"] = "사용자 정의 축하 메세지 사용"
L["customGratsText_desc"] = "사용자 정의 축하 메시지. 플레이어의 이름을 포함하려면 '%s' 변수를 사용하고 축하 메시지에 원하는 텍스트를 입력하십시오."
L["customGratsText_name"] = "축하 메세지"
L["dontShowAchievements_desc"] = "모든 업적 메세지 숨기기"
L["dontShowAchievements_name"] = "업적 보이지 않기"
L["grats_donthave_1"] = "%s님 축하해요."
L["grats_donthave_10"] = "난 하나뿐인 %s님을 얻기 위해 기다릴 수 없어요."
L["grats_donthave_2"] = "%s님 축하, 난 아직도 그게 필요해요."
L["grats_donthave_3"] = "나는 %s님을 원해요, 축하!"
L["grats_donthave_4"] = "와우 %s님 대단하심."
L["grats_donthave_5"] = "난 %s님이 질투나, 축하!"
L["grats_donthave_6"] = "나는 %s님을 위해 그 작업을 해왔어요."
L["grats_donthave_7"] = "아직 %s님이 필요함. 축하!"
L["grats_donthave_8"] = "%s님 업적을 사고싶어요."
L["grats_donthave_9"] = "나도 %s님을 기대하고 있어요. 잘했어요!"
L["grats_have_1"] = "%s님 축하해요."
L["grats_have_10"] = "%s님 잘했어요. 이제 우리 둘 다 갖고 있네요."
L["grats_have_2"] = "%s님 축하! 나도 마찬가지죠."
L["grats_have_3"] = "와우 %s님 대단하심."
L["grats_have_4"] = "%s님 클럽에 오신 것을 환영합니다."
L["grats_have_5"] = "나는 여전히 %s님께 받은 것을 기억할 수 있어요."
L["grats_have_6"] = "저건 %s님의 통과 의례다."
L["grats_have_7"] = "%s님 오랫동안 작업했죠. 축하해요!"
L["grats_have_8"] = "%s님 나도 기억나요. 축하!"
L["grats_have_9"] = "%s님 잘하셨어요."
L["grats_link"] = "축하한다고 말함"
L["module_desc"] = "업적 관련 사용자 설정"
L["module_name"] = "업적 [Achievements]"
L["showCompletedDate_desc"] = "링크 옆에 업적을 완료 한 날짜 표시"
L["showCompletedDate_name"] = "완료 날짜 표시"
L["showGratsLink_desc"] = "축하 메시지를 보내는 클릭 가능한 링크 표시"
L["showGratsLink_name"] = "축하 링크 표시"

  PL:AddLocale("koKR",  L)


  L = {}
  -- Achievements
--[[Translation missing --]]
L["completed"] = "Completed %s"
--[[Translation missing --]]
L["customGrats_defualt"] = "Grats %s"
--[[Translation missing --]]
L["customGrats_desc"] = "Use a custom grats message instead of a random one"
--[[Translation missing --]]
L["customGrats_name"] = "Use Custom Grats Message"
--[[Translation missing --]]
L["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder"
--[[Translation missing --]]
L["customGratsText_name"] = "Grats Message"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
--[[Translation missing --]]
L["grats_donthave_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_donthave_10"] = "I can't wait to get that one %s"
--[[Translation missing --]]
L["grats_donthave_2"] = "Gz %s, I still need that"
--[[Translation missing --]]
L["grats_donthave_3"] = "I want that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_4"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_donthave_5"] = "I'm jealous %s, grats!"
--[[Translation missing --]]
L["grats_donthave_6"] = "I have been working on that for ages %s"
--[[Translation missing --]]
L["grats_donthave_7"] = "Still need that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_8"] = "WTB your achievement %s"
--[[Translation missing --]]
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
--[[Translation missing --]]
L["grats_have_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_have_10"] = "Good work %s, now we both have it"
--[[Translation missing --]]
L["grats_have_2"] = "Gz %s, I have that one too"
--[[Translation missing --]]
L["grats_have_3"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_have_4"] = "Welcome to the club %s"
--[[Translation missing --]]
L["grats_have_5"] = "I can still rememeber getting that one %s"
--[[Translation missing --]]
L["grats_have_6"] = "That one is a rite of passage %s"
--[[Translation missing --]]
L["grats_have_7"] = "I worked on that for ages %s, grats!"
--[[Translation missing --]]
L["grats_have_8"] = "I remember doing that, %s, grats!"
--[[Translation missing --]]
L["grats_have_9"] = "Nicely done %s"
--[[Translation missing --]]
L["grats_link"] = "say grats"
--[[Translation missing --]]
L["module_desc"] = "Achievement related customizations"
--[[Translation missing --]]
L["module_name"] = "Achievements"
--[[Translation missing --]]
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
--[[Translation missing --]]
L["showCompletedDate_name"] = "Show completed date"
--[[Translation missing --]]
L["showGratsLink_desc"] = "Show a clickable link which sends a grats message"
--[[Translation missing --]]
L["showGratsLink_name"] = "Show grats link"

  PL:AddLocale("esMX",  L)

  L = {}
  -- Achievements
L["completed"] = "сделано"
L["customGrats_defualt"] = "Поздравляю %s "
L["customGrats_desc"] = "Использовать персональное сообщение вместо рандомного "
L["customGrats_name"] = "Использовать своё ПОЗДРАВИТЕЛЬНОЕ сообщение "
L["customGratsText_desc"] = "Стандартное ГРАЦ сообщение. Напишите свой текст ГРАЦ сообщения. Если хотите включить имя игрока в сообщение - то добавьте %s  "
L["customGratsText_name"] = "Поздравительное сообщение "
L["dontShowAchievements_desc"] = "Скрыть все сообщения о достижениях"
L["dontShowAchievements_name"] = "Не показывать достижения "
L["grats_donthave_1"] = "Поздравляю %s "
L["grats_donthave_10"] = "Я не могу дождаться, когда тоже получу его %s "
L["grats_donthave_2"] = "Гц %s, мне всё ещё нужно это достижение "
L["grats_donthave_3"] = "Я тоже его хочу %s, гц! "
L["grats_donthave_4"] = "Ого %s, гц!  "
L["grats_donthave_5"] = "Как же я завидую %s, гц!  "
L["grats_donthave_6"] = "Я столько лет работаю над ним %s, гц!  "
L["grats_donthave_7"] = "Мне всё ещё нужно это достижение %s, гц! "
L["grats_donthave_8"] = "Жду ещё достижений %s, гц!  "
L["grats_donthave_9"] = "С нетерпением хочу получить такую же %s, гц! "
L["grats_have_1"] = "Гц %s "
L["grats_have_10"] = "Отличная работа %s, теперь у нас обоих есть это достижение "
L["grats_have_2"] = "Гц %s, я такую уже сделал "
L["grats_have_3"] = "Вау %s, зачётно! "
L["grats_have_4"] = "Да светится сие достижение на глубине твоего моря ачив %s "
L["grats_have_5"] = "Не могу забыть, как трудно получал её %s . "
L["grats_have_6"] = "%s, сделал дело - гуляй смело!  "
L["grats_have_7"] = "Я столько лет трудился над ним %s, гц! "
L["grats_have_8"] = "Я помню, как это делалось,% s, Грац! "
L["grats_have_9"] = "Красиво сделано %s"
L["grats_link"] = "GRATS "
L["module_desc"] = "Индивидуальные настройки, связанные с достижениями "
L["module_name"] = "Достижения "
L["showCompletedDate_desc"] = "Показывать дату, когда вы сделали достижение, рядом с ссылкой "
L["showCompletedDate_name"] = "Показывать дату завершения "
L["showGratsLink_desc"] = "Показывать ссылку GRATS для поздравления "
L["showGratsLink_name"] = "Показывать GRATS ссылку "

  PL:AddLocale("ruRU",  L)


  L = {}
  -- Achievements
L["completed"] = "已完成 %s"
L["customGrats_defualt"] = "恭喜 %s"
L["customGrats_desc"] = "使用自定义的恭喜消息替代随机的消息"
L["customGrats_name"] = "使用自定义的恭喜消息"
L["customGratsText_desc"] = "自定义恭喜消息。编辑输入任意文字成为你的恭喜消息，如果要包含玩家名字 请在文字中使用“％s”代替名字。"
L["customGratsText_name"] = "恭喜消息"
L["dontShowAchievements_desc"] = "隐藏所有与成就相关的消息"
L["dontShowAchievements_name"] = "不显示成就"
L["grats_donthave_1"] = "恭喜 %s"
L["grats_donthave_10"] = "我急切的希望收到那个 %s"
L["grats_donthave_2"] = "恭贺 %s, 我仍需完成"
L["grats_donthave_3"] = "我也想完成 %s, 恭喜!"
L["grats_donthave_4"] = "哇 %s 太棒了"
L["grats_donthave_5"] = "好羡慕 %s, 恭喜!"
L["grats_donthave_6"] = "这段时间我一直在努力 %s"
L["grats_donthave_7"] = "仍需努力完成 %s, 恭喜!"
L["grats_donthave_8"] = "好像拿到你获得的成就 %s"
L["grats_donthave_9"] = "期待自己是下一个完成的 %s, 好厉害!"
L["grats_have_1"] = "恭喜 %s"
L["grats_have_10"] = "好样的 %s, 现在我们都共享到了"
L["grats_have_2"] = "敬贺 %s, 我也有了"
L["grats_have_3"] = "哇 %s 太棒了"
L["grats_have_4"] = "欢迎加入成就党 %s"
L["grats_have_5"] = "我始终心心念念想获得那个 %s"
L["grats_have_6"] = "那是一种仪式般的历程 %s"
L["grats_have_7"] = "我已经做了很久了 %s, 恭喜!"
L["grats_have_8"] = "我一直没忘做那个, %s,恭喜!"
L["grats_have_9"] = "干得漂亮 %s"
L["grats_link"] = "表示恭喜"
L["module_desc"] = "与成就相关的自定义"
L["module_name"] = "成就"
L["showCompletedDate_desc"] = "在链接旁边显示你的成就完成日期"
L["showCompletedDate_name"] = "显示完成日期"
L["showGratsLink_desc"] = "显示发送恭喜消息的可点击链接"
L["showGratsLink_name"] = "显示恭喜链接"

  PL:AddLocale("zhCN",  L)


  L = {}
  -- Achievements
L["completed"] = "Completado %s"
L["customGrats_defualt"] = "Felicidades %s"
L["customGrats_desc"] = "Usar un mensaje de felicitación personalizado en lugar de uno aleatorio"
L["customGrats_name"] = "Mensaje de felicitación personalizado"
L["customGratsText_desc"] = "Mensaje de felicitación personalizado. Escriba el mensaje de felicitación que usted desee, si quiere incluir el nombre del jugador use '%s' como indicador"
L["customGratsText_name"] = "Mensaje de felicitación"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
L["grats_donthave_1"] = "Felicidades %s"
L["grats_donthave_10"] = "No puedo esperar a obtener ese %s"
L["grats_donthave_2"] = "Felicidades %s, yo aún necesito ese"
--[[Translation missing --]]
L["grats_donthave_3"] = "I want that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_4"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_donthave_5"] = "I'm jealous %s, grats!"
--[[Translation missing --]]
L["grats_donthave_6"] = "I have been working on that for ages %s"
--[[Translation missing --]]
L["grats_donthave_7"] = "Still need that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_8"] = "WTB your achievement %s"
--[[Translation missing --]]
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
--[[Translation missing --]]
L["grats_have_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_have_10"] = "Good work %s, now we both have it"
--[[Translation missing --]]
L["grats_have_2"] = "Gz %s, I have that one too"
--[[Translation missing --]]
L["grats_have_3"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_have_4"] = "Welcome to the club %s"
--[[Translation missing --]]
L["grats_have_5"] = "I can still rememeber getting that one %s"
--[[Translation missing --]]
L["grats_have_6"] = "That one is a rite of passage %s"
--[[Translation missing --]]
L["grats_have_7"] = "I worked on that for ages %s, grats!"
--[[Translation missing --]]
L["grats_have_8"] = "I remember doing that, %s, grats!"
--[[Translation missing --]]
L["grats_have_9"] = "Nicely done %s"
L["grats_link"] = "Felicitar"
L["module_desc"] = "Ajustes relacionados a logros"
L["module_name"] = "Logros"
L["showCompletedDate_desc"] = "Muestra la fecha en la que se completo el logro luego del enlace"
L["showCompletedDate_name"] = "Mostrar fecha de finalización"
L["showGratsLink_desc"] = "Muestra a enlace clickable para enviar un mensaje de felicitación"
L["showGratsLink_name"] = "Mostrar enlace de felicitación"

  PL:AddLocale("esES",  L)


  L = {}
  -- Achievements
--[[Translation missing --]]
L["completed"] = "Completed %s"
--[[Translation missing --]]
L["customGrats_defualt"] = "Grats %s"
--[[Translation missing --]]
L["customGrats_desc"] = "Use a custom grats message instead of a random one"
--[[Translation missing --]]
L["customGrats_name"] = "Use Custom Grats Message"
--[[Translation missing --]]
L["customGratsText_desc"] = "Custom grats message. Type any text you wish for your grats message, if you want to include the player's name use '%s' as a placeholder"
--[[Translation missing --]]
L["customGratsText_name"] = "Grats Message"
--[[Translation missing --]]
L["dontShowAchievements_desc"] = "Hide all achievement messages"
--[[Translation missing --]]
L["dontShowAchievements_name"] = "Don't show achievements"
--[[Translation missing --]]
L["grats_donthave_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_donthave_10"] = "I can't wait to get that one %s"
--[[Translation missing --]]
L["grats_donthave_2"] = "Gz %s, I still need that"
--[[Translation missing --]]
L["grats_donthave_3"] = "I want that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_4"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_donthave_5"] = "I'm jealous %s, grats!"
--[[Translation missing --]]
L["grats_donthave_6"] = "I have been working on that for ages %s"
--[[Translation missing --]]
L["grats_donthave_7"] = "Still need that one %s, grats!"
--[[Translation missing --]]
L["grats_donthave_8"] = "WTB your achievement %s"
--[[Translation missing --]]
L["grats_donthave_9"] = "Looking forward to that one myself %s, good job!"
--[[Translation missing --]]
L["grats_have_1"] = "Grats %s"
--[[Translation missing --]]
L["grats_have_10"] = "Good work %s, now we both have it"
--[[Translation missing --]]
L["grats_have_2"] = "Gz %s, I have that one too"
--[[Translation missing --]]
L["grats_have_3"] = "Wow %s that's great"
--[[Translation missing --]]
L["grats_have_4"] = "Welcome to the club %s"
--[[Translation missing --]]
L["grats_have_5"] = "I can still rememeber getting that one %s"
--[[Translation missing --]]
L["grats_have_6"] = "That one is a rite of passage %s"
--[[Translation missing --]]
L["grats_have_7"] = "I worked on that for ages %s, grats!"
--[[Translation missing --]]
L["grats_have_8"] = "I remember doing that, %s, grats!"
--[[Translation missing --]]
L["grats_have_9"] = "Nicely done %s"
--[[Translation missing --]]
L["grats_link"] = "say grats"
--[[Translation missing --]]
L["module_desc"] = "Achievement related customizations"
--[[Translation missing --]]
L["module_name"] = "Achievements"
--[[Translation missing --]]
L["showCompletedDate_desc"] = "Show the date you completed the achievement next to the link"
--[[Translation missing --]]
L["showCompletedDate_name"] = "Show completed date"
--[[Translation missing --]]
L["showGratsLink_desc"] = "Show a clickable link which sends a grats message"
--[[Translation missing --]]
L["showGratsLink_name"] = "Show grats link"

  PL:AddLocale("zhTW",  L)
  end
  --@end-non-debug@


	local repeatPrevention = {}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			dontShowAchievements = false,
			showCompletedDate = true,
			showGratsLink = false,
			customGrats = true,
			customGratsText = PL.customGrats_defualt
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL.module_name,
		desc = PL.module_desc,
		type = "group",
		args = {
			dontShowAchievements = {
				name = PL.dontShowAchievements_name,
				desc = PL.dontShowAchievements_desc,
				type = "toggle",
				order = 90
			},
			showCompletedDate = {
				name = PL.showCompletedDate_name,
				desc = PL.showCompletedDate_desc,
				type = "toggle",
				order = 100
			},
			showGratsLink = {
				name = PL.showGratsLink_name,
				desc = PL.showGratsLink_desc,
				type = "toggle",
				order = 110
			},
			customGrats = {
				name = PL.customGrats_name,
				desc = PL.customGrats_desc,
				type = "toggle",
				order = 120
			},
			customGratsText = {
				name = PL.customGratsText_name,
				desc = PL.customGratsText_desc,
				type = "input",
				order = 130,
				disabled = function()
					return not module.db.profile.customGrats
				end
			}
		}
	})

	local gratsVariantsHave = {
		PL.grats_have_1,
		PL.grats_have_2,
		PL.grats_have_3,
		PL.grats_have_4,
		PL.grats_have_5,
		PL.grats_have_6,
		PL.grats_have_7,
		PL.grats_have_8,
		PL.grats_have_9,
		PL.grats_have_10,
	}
	local gratsVariantsDontHave = {
		PL.grats_donthave_1,
		PL.grats_donthave_2,
		PL.grats_donthave_3,
		PL.grats_donthave_4,
		PL.grats_donthave_5,
		PL.grats_donthave_6,
		PL.grats_donthave_7,
		PL.grats_donthave_8,
		PL.grats_donthave_9,
		PL.grats_donthave_10,
	}

	local function white(text)
		return Prat.CLR:Colorize("ffffff", text)
	end

	local regexp = "(|cffffff00|Hachievement:([0-9]+):(.+):([%-0-9]+):([%-0-9]+):([%-0-9]+):([%-0-9]+):([%-0-9]+):([%-0-9]+):([%-0-9]+):([%-0-9]+)|h%[([^]]+)%]|h|r)"
	local gratsLinkType = "gratsl"

	local function buildGratsLink(name, group, channel, achievementId)
		if type(name) ~= "nil" and type(group) ~= "nil" then
			return Prat.BuildLink(gratsLinkType, ("%s:%s:%s:%s"):format(name, group, channel or "", tostring(achievementId)), PL.grats_link, "2080a0")
		end

		return ""
	end

	local function ShowOurCompletion(text, theirId, theirPlayerGuid, theirDone)
		local type = Prat.CurrentMessage.CHATTYPE
		if type == "WHISPER_INFORM" then
			return
		end

		if theirPlayerGuid == "0000000000000000" or tostring(theirPlayerGuid):len() <= 3 then
			return
		end

		local _, _, _, completed, month, day, year = GetAchievementInfo(theirId)

		local _, _, _, _, _, theirName, _ = GetPlayerInfoByGUID(theirPlayerGuid)
		local group = Prat.CurrentMessage.CHATGROUP
		local channelNum = Prat.CurrentMessage.CHATTARGET

		if group == "CHANNEL" and not tonumber(channelNum) then
			return
		end

		if completed then
			return Prat:RegisterMatch(text .. module:addDate(day, month, year) .. (theirDone and module:addGrats(theirName, group, channelNum, theirId, Prat.CurrentMessage)) or "")
		elseif theirDone then
			return Prat:RegisterMatch(text .. module:addGrats(theirName, group, channelNum, theirId, Prat.CurrentMessage))
		end
	end

	Prat:SetModulePatterns(module, {
		{ pattern = regexp, matchfunc = ShowOurCompletion, priority = 42 },
	})

	function module:OnModuleEnable()
		Prat.EnableProcessingForEvent("CHAT_MSG_GUILD_ACHIEVEMENT")
		Prat.EnableProcessingForEvent("CHAT_MSG_ACHIEVEMENT")
		Prat.RegisterChatEvent(self, "Prat_FrameMessage")
		Prat.RegisterLinkType({ linkid = gratsLinkType, linkfunc = self.OnGratsLink, handler = self }, self.name)
	end

	function module:OnModuleDisable()
		Prat.UnregisterAllChatEvents(self)
	end

	function module:addGrats(name, group, channel, achievementId)
		if self.db.profile.showGratsLink then
			return " " .. buildGratsLink(name, group, channel, achievementId)
		end

		return ""
	end

	function module:addDate(day, month, year)
		if self.db.profile.showCompletedDate then
			return " " .. white("(") .. PL.completed:format(FormatShortDate(day, month, year)) .. white(")")
		end

		return ""
	end

	function module:OnGratsLink(link)
		if Prat.IsRetail and InCombatLockdown() then
			return false
		end

		local theirName, group, _, id = strsub(link, gratsLinkType:len() + 2):match("([^:]*):([^:]*):([^:]*):([^:]*)")

		local grats

		if self.db.profile.customGrats then
			grats = self.db.profile.customGratsText
		else
			id = tonumber(id)

			local _, _, _, _, _, _, _, _, _, _, _, _, wasEarnedByMe = GetAchievementInfo(id)

			local gratsVariants = wasEarnedByMe and gratsVariantsHave or gratsVariantsDontHave

			local last = repeatPrevention[wasEarnedByMe and 1 or 2]
			local next = math.random(#gratsVariants)

			while next == last do
				next = math.random(#gratsVariants)
			end

			grats = gratsVariants[next]
			repeatPrevention[wasEarnedByMe and 1 or 2] = last
		end

		if group == "WHISPER" or not Prat.CanSendChatMessage(group) then
			SendChatMessage(grats:format(theirName), "WHISPER", nil, theirName)
		elseif Prat.CanSendChatMessage(group) then
			SendChatMessage(grats:format(theirName), group)
		end

		return false
	end

	function module:Prat_FrameMessage(_, message, _, event)
		if self.db.profile.dontShowAchievements and event == "CHAT_MSG_GUILD_ACHIEVEMENT" then
			message.DONOTPROCESS = true
		end
	end
end)
