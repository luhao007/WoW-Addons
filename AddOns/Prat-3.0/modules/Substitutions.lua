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

local ChatEdit_GetActiveWindow = _G.ChatEdit_GetActiveWindow or _G.ChatFrameUtil.GetActiveWindow

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("Substitutions")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Substitutions"] = true,
		["A module to provide basic chat substitutions."] = true,
		['User defined substitutions'] = true,
		['Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)'] = true,
		['Set substitution'] = true,
		['Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition).'] = true,
		['subname = text after expansion -- NOTE: sub name without the prefix "%"'] = true,
		['List substitutions'] = true,
		['Lists all current subtitutions in the default chat frame'] = true,
		['Delete substitution'] = true,
		['Deletes a user defined substitution'] = true,
		['subname -- NOTE: sub name without the prefix \'%\''] = true,
		['Are you sure?'] = true,
		['Delete all'] = true,
		['Deletes all user defined substitutions'] = true,
		['Are you sure - this will delete all user defined substitutions and reset defaults?'] = true,
		['List of available substitutions'] = true,
		['List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)'] = true,
		["NO MATCHFUNC FOUND"] = true,
		["current-prompt"] = "Current value: '%s'\nClick to paste into the chat.",
		['no substitution name given'] = true,
		['no value given for subtitution "%s"'] = true,
		['|cffff0000warning:|r subtitution "%s" already defined as "%s", overwriting'] = true,
		['defined %s: expands to => %s'] = true,
		['no substitution name suPLied for deletion'] = true,
		['no user defined subs found'] = true,
		['user defined substition "%s" not found'] = true,
		["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = true,
		["can't find substitution index for a substitution named '%s'"] = true,
		['removing user defined substitution "%s"; previously expanded to => "%s"'] = true,
		['substitution: %s defined as => %s'] = true,
		['%d total user defined substitutions'] = true,
		['module:buildUserSubsIndex(): warning: module patterns not defined!'] = true,
		["<notarget>"] = true,
		["male"] = true,
		["female"] = true,
		["unknown sex"] = true,
		["<noguild>"] = true,
		["his"] = true,
		["hers"] = true,
		["its"] = true,
		["him"] = true,
		["her"] = true,
		["it"] = true,
		['usersub_'] = true,
		["TargetHealthDeficit"] = true,
		["TargetPercentHP"] = true,
		["TargetPronoun"] = true,
		["PlayerHP"] = true,
		["PlayerName"] = true,
		["PlayerMaxHP"] = true,
		["PlayerHealthDeficit"] = true,
		["PlayerPercentHP"] = true,
		["PlayerCurrentMana"] = true,
		["PlayerMaxMana"] = true,
		["PlayerPercentMana"] = true,
		["PlayerManaDeficit"] = true,
		["TargetName"] = true,
		["TargetTargetName"] = true,
		["MouseoverTargetName"] = true,
		["TargetClass"] = true,
		["TargetHealth"] = true,
		["TargetRace"] = true,
		["TargetGender"] = true,
		["TargetLevel"] = true,
		["TargetPossesive"] = true,
		["TargetManaDeficit"] = true,
		["TargetGuild"] = true,
		["TargetIcon"] = true,
		["MapZone"] = true,
		["MapLoc"] = true,
		["MapPos"] = true,
		["MapYPos"] = true,
		["MapXPos"] = true,
		["RandNum"] = true,
		["PlayerAverageItemLevel"] = true,
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/


	--@non-debug@
  do
	  local L


  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = true
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = true
L["<noguild>"] = true
L["<notarget>"] = true
L["A module to provide basic chat substitutions."] = true
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = true
L["Are you sure?"] = true
L["can't find substitution index for a substitution named '%s'"] = true
L["current-prompt"] = [=[Current value: '%s' 
Click to paste into the chat.]=]
L["defined %s: expands to => %s"] = true
L["Delete all"] = true
L["Delete substitution"] = true
L["Deletes a user defined substitution"] = true
L["Deletes all user defined substitutions"] = true
L["female"] = true
L["her"] = true
L["hers"] = true
L["him"] = true
L["his"] = true
L["it"] = true
L["its"] = true
L["List of available substitutions"] = true
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = true
L["List substitutions"] = true
L["Lists all current subtitutions in the default chat frame"] = true
L["male"] = true
L["MapLoc"] = true
L["MapPos"] = true
L["MapXPos"] = true
L["MapYPos"] = true
L["MapZone"] = true
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = true
L["MouseoverTargetName"] = true
L["NO MATCHFUNC FOUND"] = true
L["no substitution name given"] = true
L["no substitution name supplied for deletion"] = true
L["no user defined subs found"] = true
L["no value given for subtitution \"%s\""] = true
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = true
L["PlayerAverageItemLevel"] = true
L["PlayerCurrentMana"] = true
L["PlayerHealthDeficit"] = true
L["PlayerHP"] = true
L["PlayerManaDeficit"] = true
L["PlayerMaxHP"] = true
L["PlayerMaxMana"] = true
L["PlayerName"] = true
L["PlayerPercentHP"] = true
L["PlayerPercentMana"] = true
L["RandNum"] = true
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = true
L["Set substitution"] = true
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = true
L["subname -- NOTE: sub name without the prefix '%'"] = true
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = true
L["substitution: %s defined as => %s"] = true
L["Substitutions"] = true
L["TargetClass"] = true
L["TargetGender"] = true
L["TargetGuild"] = true
L["TargetHealth"] = true
L["TargetHealthDeficit"] = true
L["TargetIcon"] = true
L["TargetLevel"] = true
L["TargetManaDeficit"] = true
L["TargetName"] = true
L["TargetPercentHP"] = true
L["TargetPossesive"] = true
L["TargetPronoun"] = true
L["TargetRace"] = true
L["TargetTargetName"] = true
L["unknown sex"] = true
L["user defined substition \"%s\" not found"] = true
L["User defined substitutions"] = true
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = true
L["usersub_"] = true

  PL:AddLocale("enUS", L)

  L = {}
  -- Substitutions
--[[Translation missing --]]
L["%d total user defined substitutions"] = "%d total user defined substitutions"
--[[Translation missing --]]
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"
--[[Translation missing --]]
L["<noguild>"] = "<noguild>"
--[[Translation missing --]]
L["<notarget>"] = "<notarget>"
--[[Translation missing --]]
L["A module to provide basic chat substitutions."] = "A module to provide basic chat substitutions."
--[[Translation missing --]]
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Are you sure - this will delete all user defined substitutions and reset defaults?"
--[[Translation missing --]]
L["Are you sure?"] = "Are you sure?"
--[[Translation missing --]]
L["can't find substitution index for a substitution named '%s'"] = "can't find substitution index for a substitution named '%s'"
--[[Translation missing --]]
L["current-prompt"] = [=[Current value: '%s' 
Click to paste into the chat.]=]
--[[Translation missing --]]
L["defined %s: expands to => %s"] = "defined %s: expands to => %s"
--[[Translation missing --]]
L["Delete all"] = "Delete all"
--[[Translation missing --]]
L["Delete substitution"] = "Delete substitution"
--[[Translation missing --]]
L["Deletes a user defined substitution"] = "Deletes a user defined substitution"
--[[Translation missing --]]
L["Deletes all user defined substitutions"] = "Deletes all user defined substitutions"
--[[Translation missing --]]
L["female"] = "female"
--[[Translation missing --]]
L["her"] = "her"
--[[Translation missing --]]
L["hers"] = "hers"
--[[Translation missing --]]
L["him"] = "him"
--[[Translation missing --]]
L["his"] = "his"
--[[Translation missing --]]
L["it"] = "it"
--[[Translation missing --]]
L["its"] = "its"
--[[Translation missing --]]
L["List of available substitutions"] = "List of available substitutions"
--[[Translation missing --]]
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["List substitutions"] = "List substitutions"
--[[Translation missing --]]
L["Lists all current subtitutions in the default chat frame"] = "Lists all current subtitutions in the default chat frame"
--[[Translation missing --]]
L["male"] = "male"
--[[Translation missing --]]
L["MapLoc"] = "MapLoc"
--[[Translation missing --]]
L["MapPos"] = "MapPos"
--[[Translation missing --]]
L["MapXPos"] = "MapXPos"
--[[Translation missing --]]
L["MapYPos"] = "MapYPos"
--[[Translation missing --]]
L["MapZone"] = "MapZone"
--[[Translation missing --]]
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): warning: module patterns not defined!"
--[[Translation missing --]]
L["MouseoverTargetName"] = "MouseoverTargetName"
--[[Translation missing --]]
L["NO MATCHFUNC FOUND"] = "NO MATCHFUNC FOUND"
--[[Translation missing --]]
L["no substitution name given"] = "no substitution name given"
--[[Translation missing --]]
L["no substitution name supplied for deletion"] = "no substitution name supplied for deletion"
--[[Translation missing --]]
L["no user defined subs found"] = "no user defined subs found"
--[[Translation missing --]]
L["no value given for subtitution \"%s\""] = "no value given for subtitution \"%s\""
--[[Translation missing --]]
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["PlayerAverageItemLevel"] = "PlayerAverageItemLevel"
--[[Translation missing --]]
L["PlayerCurrentMana"] = "PlayerCurrentMana"
--[[Translation missing --]]
L["PlayerHealthDeficit"] = "PlayerHealthDeficit"
--[[Translation missing --]]
L["PlayerHP"] = "PlayerHP"
--[[Translation missing --]]
L["PlayerManaDeficit"] = "PlayerManaDeficit"
--[[Translation missing --]]
L["PlayerMaxHP"] = "PlayerMaxHP"
--[[Translation missing --]]
L["PlayerMaxMana"] = "PlayerMaxMana"
--[[Translation missing --]]
L["PlayerName"] = "PlayerName"
--[[Translation missing --]]
L["PlayerPercentHP"] = "PlayerPercentHP"
--[[Translation missing --]]
L["PlayerPercentMana"] = "PlayerPercentMana"
--[[Translation missing --]]
L["RandNum"] = "RandNum"
--[[Translation missing --]]
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "removing user defined substitution \"%s\"; previously expanded to => \"%s\""
--[[Translation missing --]]
L["Set substitution"] = "Set substitution"
--[[Translation missing --]]
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."
--[[Translation missing --]]
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- NOTE: sub name without the prefix '%'"
--[[Translation missing --]]
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- NOTE: sub name without the prefix \"%\""
--[[Translation missing --]]
L["substitution: %s defined as => %s"] = "substitution: %s defined as => %s"
--[[Translation missing --]]
L["Substitutions"] = "Substitutions"
--[[Translation missing --]]
L["TargetClass"] = "TargetClass"
--[[Translation missing --]]
L["TargetGender"] = "TargetGender"
--[[Translation missing --]]
L["TargetGuild"] = "TargetGuild"
--[[Translation missing --]]
L["TargetHealth"] = "TargetHealth"
--[[Translation missing --]]
L["TargetHealthDeficit"] = "TargetHealthDeficit"
--[[Translation missing --]]
L["TargetIcon"] = "TargetIcon"
--[[Translation missing --]]
L["TargetLevel"] = "TargetLevel"
--[[Translation missing --]]
L["TargetManaDeficit"] = "TargetManaDeficit"
--[[Translation missing --]]
L["TargetName"] = "TargetName"
--[[Translation missing --]]
L["TargetPercentHP"] = "TargetPercentHP"
--[[Translation missing --]]
L["TargetPossesive"] = "TargetPossesive"
--[[Translation missing --]]
L["TargetPronoun"] = "TargetPronoun"
--[[Translation missing --]]
L["TargetRace"] = "TargetRace"
--[[Translation missing --]]
L["TargetTargetName"] = "TargetTargetName"
--[[Translation missing --]]
L["unknown sex"] = "unknown sex"
--[[Translation missing --]]
L["user defined substition \"%s\" not found"] = "user defined substition \"%s\" not found"
--[[Translation missing --]]
L["User defined substitutions"] = "User defined substitutions"
--[[Translation missing --]]
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "user substitutions index (usersubs_idx) doesn't exist! oh dear."
--[[Translation missing --]]
L["usersub_"] = "usersub_"

  PL:AddLocale("itIT", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "%d substituições definidas pelo usuário"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000warning:|r substituindo. \"%s\" já definido como\"%s\", sobrescrevendo"
--[[Translation missing --]]
L["<noguild>"] = "<noguild>"
--[[Translation missing --]]
L["<notarget>"] = "<notarget>"
--[[Translation missing --]]
L["A module to provide basic chat substitutions."] = "A module to provide basic chat substitutions."
--[[Translation missing --]]
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Are you sure - this will delete all user defined substitutions and reset defaults?"
--[[Translation missing --]]
L["Are you sure?"] = "Are you sure?"
--[[Translation missing --]]
L["can't find substitution index for a substitution named '%s'"] = "can't find substitution index for a substitution named '%s'"
--[[Translation missing --]]
L["current-prompt"] = [=[Current value: '%s' 
Click to paste into the chat.]=]
--[[Translation missing --]]
L["defined %s: expands to => %s"] = "defined %s: expands to => %s"
--[[Translation missing --]]
L["Delete all"] = "Delete all"
--[[Translation missing --]]
L["Delete substitution"] = "Delete substitution"
--[[Translation missing --]]
L["Deletes a user defined substitution"] = "Deletes a user defined substitution"
--[[Translation missing --]]
L["Deletes all user defined substitutions"] = "Deletes all user defined substitutions"
--[[Translation missing --]]
L["female"] = "female"
--[[Translation missing --]]
L["her"] = "her"
--[[Translation missing --]]
L["hers"] = "hers"
--[[Translation missing --]]
L["him"] = "him"
--[[Translation missing --]]
L["his"] = "his"
--[[Translation missing --]]
L["it"] = "it"
--[[Translation missing --]]
L["its"] = "its"
--[[Translation missing --]]
L["List of available substitutions"] = "List of available substitutions"
--[[Translation missing --]]
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["List substitutions"] = "List substitutions"
--[[Translation missing --]]
L["Lists all current subtitutions in the default chat frame"] = "Lists all current subtitutions in the default chat frame"
--[[Translation missing --]]
L["male"] = "male"
--[[Translation missing --]]
L["MapLoc"] = "MapLoc"
--[[Translation missing --]]
L["MapPos"] = "MapPos"
--[[Translation missing --]]
L["MapXPos"] = "MapXPos"
--[[Translation missing --]]
L["MapYPos"] = "MapYPos"
--[[Translation missing --]]
L["MapZone"] = "MapZone"
--[[Translation missing --]]
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): warning: module patterns not defined!"
--[[Translation missing --]]
L["MouseoverTargetName"] = "MouseoverTargetName"
--[[Translation missing --]]
L["NO MATCHFUNC FOUND"] = "NO MATCHFUNC FOUND"
--[[Translation missing --]]
L["no substitution name given"] = "no substitution name given"
--[[Translation missing --]]
L["no substitution name supplied for deletion"] = "no substitution name supplied for deletion"
--[[Translation missing --]]
L["no user defined subs found"] = "no user defined subs found"
--[[Translation missing --]]
L["no value given for subtitution \"%s\""] = "no value given for subtitution \"%s\""
--[[Translation missing --]]
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["PlayerAverageItemLevel"] = "PlayerAverageItemLevel"
--[[Translation missing --]]
L["PlayerCurrentMana"] = "PlayerCurrentMana"
--[[Translation missing --]]
L["PlayerHealthDeficit"] = "PlayerHealthDeficit"
--[[Translation missing --]]
L["PlayerHP"] = "PlayerHP"
--[[Translation missing --]]
L["PlayerManaDeficit"] = "PlayerManaDeficit"
--[[Translation missing --]]
L["PlayerMaxHP"] = "PlayerMaxHP"
--[[Translation missing --]]
L["PlayerMaxMana"] = "PlayerMaxMana"
--[[Translation missing --]]
L["PlayerName"] = "PlayerName"
--[[Translation missing --]]
L["PlayerPercentHP"] = "PlayerPercentHP"
--[[Translation missing --]]
L["PlayerPercentMana"] = "PlayerPercentMana"
--[[Translation missing --]]
L["RandNum"] = "RandNum"
--[[Translation missing --]]
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "removing user defined substitution \"%s\"; previously expanded to => \"%s\""
--[[Translation missing --]]
L["Set substitution"] = "Set substitution"
--[[Translation missing --]]
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."
--[[Translation missing --]]
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- NOTE: sub name without the prefix '%'"
--[[Translation missing --]]
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- NOTE: sub name without the prefix \"%\""
--[[Translation missing --]]
L["substitution: %s defined as => %s"] = "substitution: %s defined as => %s"
--[[Translation missing --]]
L["Substitutions"] = "Substitutions"
--[[Translation missing --]]
L["TargetClass"] = "TargetClass"
--[[Translation missing --]]
L["TargetGender"] = "TargetGender"
--[[Translation missing --]]
L["TargetGuild"] = "TargetGuild"
--[[Translation missing --]]
L["TargetHealth"] = "TargetHealth"
--[[Translation missing --]]
L["TargetHealthDeficit"] = "TargetHealthDeficit"
--[[Translation missing --]]
L["TargetIcon"] = "TargetIcon"
--[[Translation missing --]]
L["TargetLevel"] = "TargetLevel"
--[[Translation missing --]]
L["TargetManaDeficit"] = "TargetManaDeficit"
--[[Translation missing --]]
L["TargetName"] = "TargetName"
--[[Translation missing --]]
L["TargetPercentHP"] = "TargetPercentHP"
--[[Translation missing --]]
L["TargetPossesive"] = "TargetPossesive"
--[[Translation missing --]]
L["TargetPronoun"] = "TargetPronoun"
--[[Translation missing --]]
L["TargetRace"] = "TargetRace"
--[[Translation missing --]]
L["TargetTargetName"] = "TargetTargetName"
--[[Translation missing --]]
L["unknown sex"] = "unknown sex"
--[[Translation missing --]]
L["user defined substition \"%s\" not found"] = "user defined substition \"%s\" not found"
L["User defined substitutions"] = "Substituições definidas pelo usuário"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "índice de substituição do úsuario (usersubs_idx) não existe! Oh não!"
L["usersub_"] = true

  PL:AddLocale("ptBR", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "%s substitutions personnalisées totales"
--[[Translation missing --]]
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"
L["<noguild>"] = "<pas de guilde>"
L["<notarget>"] = "<pas de cible>"
L["A module to provide basic chat substitutions."] = "Un module qui propose quelques substitutions basiques."
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Etes-vous sûr ? Cela supprimera toutes les substitutions personnalisées et réinitialisera les valeurs par défaut."
L["Are you sure?"] = "Êtes-vous sûr ?"
--[[Translation missing --]]
L["can't find substitution index for a substitution named '%s'"] = "can't find substitution index for a substitution named '%s'"
L["current-prompt"] = [=[Valeur actuelle : '%s'
Cliquez pour coller dans le chat.]=]
--[[Translation missing --]]
L["defined %s: expands to => %s"] = "defined %s: expands to => %s"
L["Delete all"] = "Tout supprimer"
L["Delete substitution"] = "Supprimer la substitution"
L["Deletes a user defined substitution"] = "Supprime une substitution personnalisée"
L["Deletes all user defined substitutions"] = "Supprime toutes les substitutions personnalisées"
L["female"] = "femme"
--[[Translation missing --]]
L["her"] = "her"
--[[Translation missing --]]
L["hers"] = "hers"
--[[Translation missing --]]
L["him"] = "him"
--[[Translation missing --]]
L["his"] = "his"
--[[Translation missing --]]
L["it"] = "it"
--[[Translation missing --]]
L["its"] = "its"
L["List of available substitutions"] = "Liste des substitution disponibles"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Liste toutes les substitutions disponibles définies par ce module. (NB: l'utilisateur peut définir des valeurs personnalisées pour les substitutions existantes, mais celles-ci seront remisent à leurs valeurs par défaut si les options sont réinitialisées.)"
L["List substitutions"] = "Liste des substitutions"
L["Lists all current subtitutions in the default chat frame"] = "Liste toutes les substitutions dans la fenêtre de discussion"
--[[Translation missing --]]
L["male"] = "male"
L["MapLoc"] = "Localisation"
L["MapPos"] = "Position"
L["MapXPos"] = "Position X"
L["MapYPos"] = "Position Y"
L["MapZone"] = "Zone"
--[[Translation missing --]]
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): warning: module patterns not defined!"
--[[Translation missing --]]
L["MouseoverTargetName"] = "MouseoverTargetName"
L["NO MATCHFUNC FOUND"] = "PAS DE FONCTION ASSOCIÉE TROUVÉE"
--[[Translation missing --]]
L["no substitution name given"] = "no substitution name given"
--[[Translation missing --]]
L["no substitution name supplied for deletion"] = "no substitution name supplied for deletion"
--[[Translation missing --]]
L["no user defined subs found"] = "no user defined subs found"
--[[Translation missing --]]
L["no value given for subtitution \"%s\""] = "no value given for subtitution \"%s\""
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Options pour ajouter ou enlever les substitutions définies par l'utilisateur. (NB: les utilisateurs peuvent changer la valeur des substitutions existantes, mais elles seront remisent à leur valeur par défaut si les préférences de l'utilisateur sont supprimés.)"
--[[Translation missing --]]
L["PlayerAverageItemLevel"] = "PlayerAverageItemLevel"
L["PlayerCurrentMana"] = "Mana actuelle"
L["PlayerHealthDeficit"] = "Déficit de vie"
L["PlayerHP"] = "HP actuel"
L["PlayerManaDeficit"] = "Déficit de mana"
L["PlayerMaxHP"] = "HP Max"
L["PlayerMaxMana"] = "Mana Max"
L["PlayerName"] = "Nom joueur"
L["PlayerPercentHP"] = "Pourcentage HP"
L["PlayerPercentMana"] = "Pourcentage Mana"
L["RandNum"] = "Nombre aléatoire"
--[[Translation missing --]]
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "removing user defined substitution \"%s\"; previously expanded to => \"%s\""
L["Set substitution"] = "Paramétrer une substitution"
--[[Translation missing --]]
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."
--[[Translation missing --]]
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- NOTE: sub name without the prefix '%'"
--[[Translation missing --]]
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- NOTE: sub name without the prefix \"%\""
--[[Translation missing --]]
L["substitution: %s defined as => %s"] = "substitution: %s defined as => %s"
L["Substitutions"] = true
L["TargetClass"] = "Cible Classe"
L["TargetGender"] = "Cible Sexe"
L["TargetGuild"] = "Cible Guilde"
L["TargetHealth"] = "Santé Cible"
L["TargetHealthDeficit"] = "Déficit Vie Cible"
L["TargetIcon"] = "CibleIcone"
L["TargetLevel"] = "CibleNiveau"
L["TargetManaDeficit"] = "CibleManqueDeMana"
--[[Translation missing --]]
L["TargetName"] = "TargetName"
--[[Translation missing --]]
L["TargetPercentHP"] = "TargetPercentHP"
--[[Translation missing --]]
L["TargetPossesive"] = "TargetPossesive"
--[[Translation missing --]]
L["TargetPronoun"] = "TargetPronoun"
--[[Translation missing --]]
L["TargetRace"] = "TargetRace"
--[[Translation missing --]]
L["TargetTargetName"] = "TargetTargetName"
L["unknown sex"] = "sexe inconnue"
--[[Translation missing --]]
L["user defined substition \"%s\" not found"] = "user defined substition \"%s\" not found"
--[[Translation missing --]]
L["User defined substitutions"] = "User defined substitutions"
--[[Translation missing --]]
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "user substitutions index (usersubs_idx) doesn't exist! oh dear."
--[[Translation missing --]]
L["usersub_"] = "usersub_"

  PL:AddLocale("frFR", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "%d Benutzerdefinierte Ersetzungen insgesamt"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000Warnung:|r Ersetzung \"%s\" wurde bereits definiert als \"%s\", überschreibe"
L["<noguild>"] = " <keinegilde>"
L["<notarget>"] = "<keinziel>"
L["A module to provide basic chat substitutions."] = "Ein Modul zur Bereitstellung grundlegender Chat-Ersetzungen."
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Bist du sicher - dies wird alle vom Benutzer definierten Ersetzungen löschen und auf Standard zurücksetzen."
L["Are you sure?"] = "Bist du sicher?"
L["can't find substitution index for a substitution named '%s'"] = "Es kann kein Ersatzindex für eine Ersetzung mit dem Namen '%s' gefunden werden."
L["current-prompt"] = "Aktueller Wert: '%s' Anklicken, um in den Chat einzufügen."
L["defined %s: expands to => %s"] = "definiert %s: erweitert zu => %s"
L["Delete all"] = "Alles löschen"
L["Delete substitution"] = "Ersetzung löschen"
L["Deletes a user defined substitution"] = "Löscht eine vom Benutzer definierte Ersetzung"
L["Deletes all user defined substitutions"] = "Löscht alle vom Benutzer definierten Ersetzungen"
L["female"] = "weiblich"
L["her"] = "ihr"
L["hers"] = "ihr/ihre"
L["him"] = "ihn/ihm"
L["his"] = "sein/seine"
L["it"] = "es"
L["its"] = "sein"
L["List of available substitutions"] = "Liste der verfügbaren Ersetzungen"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Die List der verfügbaren Ersetzungen wird von diesem Modul definiert. (NB: Benutzer können gebräuchliche Werte für vorhandene Ersetzungen definieren, aber sie werden auf ihre Standardwerte zurückgesetzt, falls die Definitionen des Benutzers gelöscht wurde.)"
L["List substitutions"] = "Ersetzungen auflisten"
L["Lists all current subtitutions in the default chat frame"] = "Alle gegenwärtigen Ersetzungen im Standard-Chatfenster auflisten."
L["male"] = "männlich"
L["MapLoc"] = "KarteOrt"
L["MapPos"] = "KartePos"
L["MapXPos"] = "KarteXPos"
L["MapYPos"] = "KarteYPos"
L["MapZone"] = "KarteZone"
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = true
L["MouseoverTargetName"] = "Maus über Zielnamen fahren"
L["NO MATCHFUNC FOUND"] = "KEINE ÜBEREINSTIMMUNGSFUNKTION GEFUNDEN"
L["no substitution name given"] = "kein Ersetzungsname vergeben"
L["no substitution name supplied for deletion"] = "kein Ersetzungsname für Löschung geliefert"
L["no user defined subs found"] = "keine benutzerdefinierten Ersetzungen gefunden"
L["no value given for subtitution \"%s\""] = "kein Wert für Ersetzung \"%s\" gegeben"
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Optionen zum Einstellen und Entfernen benutzerdefinierter Ersetzungen. (NB: Benutzer können eigeneWerte für vorhandene Ersetzungen definieren, aber diese werden auf ihre Standardwerte zurückgesetzt, wenn die Definition des Benutzers gelöscht wurde.)"
L["PlayerAverageItemLevel"] = "Durchschnittliche Gegenstandsstufe des Spielers"
L["PlayerCurrentMana"] = "SpielerAktuellesMana"
L["PlayerHealthDeficit"] = "Gesundheitsdefizit des Spielers"
L["PlayerHP"] = "SpielerHP"
L["PlayerManaDeficit"] = "SpielerManaDefizit"
L["PlayerMaxHP"] = "SpielerMaxHP"
L["PlayerMaxMana"] = "SpielerMaxMana"
L["PlayerName"] = "Spielername"
L["PlayerPercentHP"] = "SpielerProzentHP"
L["PlayerPercentMana"] = "SpielerProzentMana"
L["RandNum"] = "ZufNum"
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "Benutzerdefinierte Ersetzung \"%s\" wird entfernt; zuvor erweitert zu => \"%s\""
L["Set substitution"] = "Ersetzung einstellen"
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Den Wert für eine benutzerdefinierte Ersetzung einstellen. (NB: dies kann einer vorhandenen Standardersetzung gleichen; um sie auf Standard zurückzusetzen, einfach die vom Benutzer erschaffene Definition entfernen.)"
L["subname -- NOTE: sub name without the prefix '%'"] = "Subname -- MERKE: Subname ohne den Vorsatz '%'"
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "Subname = Text nach Erweiterung -- MERKE: Subname ohne den Vorsatz \"%\""
L["substitution: %s defined as => %s"] = "Ersetzung: %s definiert als => %s"
L["Substitutions"] = "Ersetzungen"
L["TargetClass"] = "ZielKlasse"
L["TargetGender"] = "ZielGeschlecht"
L["TargetGuild"] = "ZielGilde"
L["TargetHealth"] = "Zielgesundheit"
L["TargetHealthDeficit"] = "Zielgesundheitsdefizit"
L["TargetIcon"] = "ZielSymbol"
L["TargetLevel"] = "ZielStufe"
L["TargetManaDeficit"] = "ZielManaDefizit"
L["TargetName"] = "ZielName"
L["TargetPercentHP"] = "ZielProzentHP"
L["TargetPossesive"] = "ZielGierig"
L["TargetPronoun"] = "ZielPronomen"
L["TargetRace"] = "ZielVolk"
L["TargetTargetName"] = "ZielZielName"
L["unknown sex"] = "Geschlecht unbekannt"
L["user defined substition \"%s\" not found"] = "Benutzerdefinierte Ersetzung \"%s\" nicht gefunden"
L["User defined substitutions"] = "Benutzerdefinierte Ersetzungen"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "Ersetzungsindex des Benutzers (usersubs_idx) existiert nicht! Oh weh!"
L["usersub_"] = "Benutzerersatz_"

  PL:AddLocale("deDE", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "총 %d개의 사용자 설정 대용어"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000경고:|r 대용어 \"%s\"|1은;는; 이미 \"%s\"|1으로;로; 정의되었습니다, 덮어씁니다"
L["<noguild>"] = "<길드없음>"
L["<notarget>"] = "<대상없음>"
L["A module to provide basic chat substitutions."] = "기본적인 대화 대용어를 제공하는 모듈입니다."
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "정말로 모든 사용자 정의 대용어를 삭제하고 기본값으로 초기화할까요?"
L["Are you sure?"] = "동의합니까?"
L["can't find substitution index for a substitution named '%s'"] = "'%s' 대용어의 값을 찾을 수 없습니다"
L["current-prompt"] = [=[현재 값: '%s'
클릭하면 대화창에 붙여 넣습니다.]=]
L["defined %s: expands to => %s"] = "'%s' 정의: 확장됨 => %s"
L["Delete all"] = "전부 삭제"
L["Delete substitution"] = "대용어 삭제"
L["Deletes a user defined substitution"] = "사용자 정의 대용어를 삭제합니다"
L["Deletes all user defined substitutions"] = "모든 사용자 정의 대용어를 삭제합니다"
L["female"] = "여자"
L["her"] = "그녀의"
L["hers"] = "그녀의 것"
L["him"] = "그"
L["his"] = "그의"
L["it"] = "그것"
L["its"] = "그것의"
L["List of available substitutions"] = "사용 가능한 대용어 목록"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "이 모듈로 사용 가능한 대용어 목록입니다. (NB: 존재하는 대용어에 사용자 설정 값을 정의 할 수 있지만, 사용자 설정 값이 삭제되면 기본 값으로 전환됩니다.)"
L["List substitutions"] = "대용어 목록"
L["Lists all current subtitutions in the default chat frame"] = "기본 대화창에 현재 모든 대용어 목록 표시"
L["male"] = "남자"
L["MapLoc"] = "지도 위치"
L["MapPos"] = "지도 좌표"
L["MapXPos"] = "지도 X좌표"
L["MapYPos"] = "지도 Y좌표"
L["MapZone"] = "지도 지역"
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): 경고: 모듈 패턴이 정의되지 않았습니다!"
L["MouseoverTargetName"] = "마우스 오버 대상 이름"
L["NO MATCHFUNC FOUND"] = "MATCHFUNC 찾을 수 없음"
L["no substitution name given"] = "주어진 대용어 이름 없음"
L["no substitution name supplied for deletion"] = "삭제할 대용어 이름 없음"
L["no user defined subs found"] = "사용자 정의 대용어 찾을 수 없음"
L["no value given for subtitution \"%s\""] = "\"%s\" 대용어에 주어진 값 없음"
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "사용자 정의 대용어을 설정하거나 제거하는 옵션입니다. (NB: 존재하는 대용어에 사용자 설정 값을 정의 할 수 있지만, 사용자 설정 값을 삭제하면 기본값으로 전환됩니다.)"
L["PlayerAverageItemLevel"] = "플레이어 평균 아이템 레벨"
L["PlayerCurrentMana"] = "플레이어 현재 마나"
L["PlayerHealthDeficit"] = "플레이어 생명력 결손치"
L["PlayerHP"] = "플레이어 생명력"
L["PlayerManaDeficit"] = "플레이어 마나 결손치"
L["PlayerMaxHP"] = "플레이어 최대 생명력"
L["PlayerMaxMana"] = "플레이어 최대 마나"
L["PlayerName"] = "플레이어 이름"
L["PlayerPercentHP"] = "플레이어 생명력 백분율"
L["PlayerPercentMana"] = "플레이어 마나 백분율"
L["RandNum"] = "무작위 숫자"
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "\"%s\" 사용자 정의 대용어를 제거합니다, 이전 값으로 복원 => \"%s\""
L["Set substitution"] = "대용어 설정"
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "사용자 정의 대용어 값 설정 (NB: 존재하는 기본 대용어와 같으면; 기본값으로 초기화하며, 사용자가 생성한 정의를 제거합니다.)"
L["subname -- NOTE: sub name without the prefix '%'"] = "대체이름 -- 참고: 접두사 '%' 없이 대체 이름"
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "대체이름 = 확장 후 문자 -- 참고: 접두사 '%' 없이 대체 이름"
L["substitution: %s defined as => %s"] = "대용어: %s 정의됨 => %s"
L["Substitutions"] = "대용어"
L["TargetClass"] = "대상 직업"
L["TargetGender"] = "대상 성별"
L["TargetGuild"] = "대상 길드"
L["TargetHealth"] = "대상 생명력"
L["TargetHealthDeficit"] = "대상 생명력 결손치"
L["TargetIcon"] = "대상 아이콘"
L["TargetLevel"] = "대상 레벨"
L["TargetManaDeficit"] = "대상 마나 결손치"
L["TargetName"] = "대상 이름"
L["TargetPercentHP"] = "대상 생명력 백분율"
L["TargetPossesive"] = "대상 소유격"
L["TargetPronoun"] = "대상 대명사"
L["TargetRace"] = "대상 종족"
L["TargetTargetName"] = "대상의 대상 이름"
L["unknown sex"] = "알 수 없는 성별"
L["user defined substition \"%s\" not found"] = "사용자 설정 대용어 \"%s\" 찾을 수 없음"
L["User defined substitutions"] = "사용자 정의 대용어"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "사용자 대용어 값 (usersubs_idx) 존재하지 않습니다!"
L["usersub_"] = true

  PL:AddLocale("koKR", L)

  L = {}
  -- Substitutions
--[[Translation missing --]]
L["%d total user defined substitutions"] = "%d total user defined substitutions"
--[[Translation missing --]]
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"
--[[Translation missing --]]
L["<noguild>"] = "<noguild>"
--[[Translation missing --]]
L["<notarget>"] = "<notarget>"
--[[Translation missing --]]
L["A module to provide basic chat substitutions."] = "A module to provide basic chat substitutions."
--[[Translation missing --]]
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Are you sure - this will delete all user defined substitutions and reset defaults?"
--[[Translation missing --]]
L["Are you sure?"] = "Are you sure?"
--[[Translation missing --]]
L["can't find substitution index for a substitution named '%s'"] = "can't find substitution index for a substitution named '%s'"
--[[Translation missing --]]
L["current-prompt"] = [=[Current value: '%s' 
Click to paste into the chat.]=]
--[[Translation missing --]]
L["defined %s: expands to => %s"] = "defined %s: expands to => %s"
--[[Translation missing --]]
L["Delete all"] = "Delete all"
--[[Translation missing --]]
L["Delete substitution"] = "Delete substitution"
--[[Translation missing --]]
L["Deletes a user defined substitution"] = "Deletes a user defined substitution"
--[[Translation missing --]]
L["Deletes all user defined substitutions"] = "Deletes all user defined substitutions"
--[[Translation missing --]]
L["female"] = "female"
--[[Translation missing --]]
L["her"] = "her"
--[[Translation missing --]]
L["hers"] = "hers"
--[[Translation missing --]]
L["him"] = "him"
--[[Translation missing --]]
L["his"] = "his"
--[[Translation missing --]]
L["it"] = "it"
--[[Translation missing --]]
L["its"] = "its"
--[[Translation missing --]]
L["List of available substitutions"] = "List of available substitutions"
--[[Translation missing --]]
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["List substitutions"] = "List substitutions"
--[[Translation missing --]]
L["Lists all current subtitutions in the default chat frame"] = "Lists all current subtitutions in the default chat frame"
--[[Translation missing --]]
L["male"] = "male"
--[[Translation missing --]]
L["MapLoc"] = "MapLoc"
--[[Translation missing --]]
L["MapPos"] = "MapPos"
--[[Translation missing --]]
L["MapXPos"] = "MapXPos"
--[[Translation missing --]]
L["MapYPos"] = "MapYPos"
--[[Translation missing --]]
L["MapZone"] = "MapZone"
--[[Translation missing --]]
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): warning: module patterns not defined!"
--[[Translation missing --]]
L["MouseoverTargetName"] = "MouseoverTargetName"
--[[Translation missing --]]
L["NO MATCHFUNC FOUND"] = "NO MATCHFUNC FOUND"
--[[Translation missing --]]
L["no substitution name given"] = "no substitution name given"
--[[Translation missing --]]
L["no substitution name supplied for deletion"] = "no substitution name supplied for deletion"
--[[Translation missing --]]
L["no user defined subs found"] = "no user defined subs found"
--[[Translation missing --]]
L["no value given for subtitution \"%s\""] = "no value given for subtitution \"%s\""
--[[Translation missing --]]
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
--[[Translation missing --]]
L["PlayerAverageItemLevel"] = "PlayerAverageItemLevel"
--[[Translation missing --]]
L["PlayerCurrentMana"] = "PlayerCurrentMana"
--[[Translation missing --]]
L["PlayerHealthDeficit"] = "PlayerHealthDeficit"
--[[Translation missing --]]
L["PlayerHP"] = "PlayerHP"
--[[Translation missing --]]
L["PlayerManaDeficit"] = "PlayerManaDeficit"
--[[Translation missing --]]
L["PlayerMaxHP"] = "PlayerMaxHP"
--[[Translation missing --]]
L["PlayerMaxMana"] = "PlayerMaxMana"
--[[Translation missing --]]
L["PlayerName"] = "PlayerName"
--[[Translation missing --]]
L["PlayerPercentHP"] = "PlayerPercentHP"
--[[Translation missing --]]
L["PlayerPercentMana"] = "PlayerPercentMana"
--[[Translation missing --]]
L["RandNum"] = "RandNum"
--[[Translation missing --]]
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "removing user defined substitution \"%s\"; previously expanded to => \"%s\""
--[[Translation missing --]]
L["Set substitution"] = "Set substitution"
--[[Translation missing --]]
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."
--[[Translation missing --]]
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- NOTE: sub name without the prefix '%'"
--[[Translation missing --]]
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- NOTE: sub name without the prefix \"%\""
--[[Translation missing --]]
L["substitution: %s defined as => %s"] = "substitution: %s defined as => %s"
--[[Translation missing --]]
L["Substitutions"] = "Substitutions"
--[[Translation missing --]]
L["TargetClass"] = "TargetClass"
--[[Translation missing --]]
L["TargetGender"] = "TargetGender"
--[[Translation missing --]]
L["TargetGuild"] = "TargetGuild"
--[[Translation missing --]]
L["TargetHealth"] = "TargetHealth"
--[[Translation missing --]]
L["TargetHealthDeficit"] = "TargetHealthDeficit"
--[[Translation missing --]]
L["TargetIcon"] = "TargetIcon"
--[[Translation missing --]]
L["TargetLevel"] = "TargetLevel"
--[[Translation missing --]]
L["TargetManaDeficit"] = "TargetManaDeficit"
--[[Translation missing --]]
L["TargetName"] = "TargetName"
--[[Translation missing --]]
L["TargetPercentHP"] = "TargetPercentHP"
--[[Translation missing --]]
L["TargetPossesive"] = "TargetPossesive"
--[[Translation missing --]]
L["TargetPronoun"] = "TargetPronoun"
--[[Translation missing --]]
L["TargetRace"] = "TargetRace"
--[[Translation missing --]]
L["TargetTargetName"] = "TargetTargetName"
--[[Translation missing --]]
L["unknown sex"] = "unknown sex"
--[[Translation missing --]]
L["user defined substition \"%s\" not found"] = "user defined substition \"%s\" not found"
--[[Translation missing --]]
L["User defined substitutions"] = "User defined substitutions"
--[[Translation missing --]]
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "user substitutions index (usersubs_idx) doesn't exist! oh dear."
--[[Translation missing --]]
L["usersub_"] = "usersub_"

  PL:AddLocale("esMX", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "всего %d пользовательских замен"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000предупреждение:|r замена \"%s\" уже определена как \"%s\", переписываем"
L["<noguild>"] = "<без гильдии>"
L["<notarget>"] = "<нет цели>"
L["A module to provide basic chat substitutions."] = "Модуль для простых замен текста в чате."
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "Вы уверены - будут удалены все пользовательские замены и установлены значения по умолчанию?"
L["Are you sure?"] = "Ты уверен?"
L["can't find substitution index for a substitution named '%s'"] = "не могу найти номер замены в списке замен для '%s'"
L["current-prompt"] = [=[Текущее значение: '%s'
Кликнуть для копирования в чат.]=]
L["defined %s: expands to => %s"] = "определено %s: раскрывается в => %s"
L["Delete all"] = "Удалить все"
L["Delete substitution"] = "Удалить замену"
L["Deletes a user defined substitution"] = "Удаляет пользовательскую замену"
L["Deletes all user defined substitutions"] = "Удалить все замены заданные пользователем"
L["female"] = "женский"
L["her"] = "её"
L["hers"] = "ей"
L["him"] = "им"
L["his"] = "его"
L["it"] = "это"
L["its"] = "его"
L["List of available substitutions"] = "Список доступных замен"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Список доступных подмен, определённых в этом модуле. (Примечание: пользователи могут присваивать собственные значения существующим подменам, но они вернутся в значения по умолчанию, если пользовательское определение будет удалено."
L["List substitutions"] = "Вывести список замен"
L["Lists all current subtitutions in the default chat frame"] = "Вывести все текущие замены в основное окно чата"
L["male"] = "мужской"
L["MapLoc"] = "Блокировка карты"
L["MapPos"] = "Позиция на карте"
L["MapXPos"] = "Позиция Х на карте"
L["MapYPos"] = "Поз.по Y"
L["MapZone"] = "Зона карты"
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): предупреждение: шаблоны модуля не определены!"
L["MouseoverTargetName"] = true
L["NO MATCHFUNC FOUND"] = "Нет соответствующих "
L["no substitution name given"] = "не задано имя замены"
L["no substitution name supplied for deletion"] = "не задано имя замены для удаления"
L["no user defined subs found"] = "не найдено замен определяемых пользователем"
L["no value given for subtitution \"%s\""] = "не задано значение для замены \"%s\""
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Опции для назначения и отмены пользовательских замен. (Внимание: пользователи могут назначать свои значения для существующих замен, однако будет использовано значение по умолчанию если определение пользователя удалено)."
L["PlayerAverageItemLevel"] = true
L["PlayerCurrentMana"] = "текушая мана игрока"
L["PlayerHealthDeficit"] = true
L["PlayerHP"] = true
L["PlayerManaDeficit"] = "нехватка маны"
L["PlayerMaxHP"] = true
L["PlayerMaxMana"] = true
L["PlayerName"] = "Имя игрока"
L["PlayerPercentHP"] = true
L["PlayerPercentMana"] = true
L["RandNum"] = true
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "удаляется определяемая пользователем замена \"%s\", раскрывавшаяся в => \"%s\""
L["Set substitution"] = "Назначить замену"
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Установить значение для определяемой пользователем замены (Внимание: может совпадать с существующей заменой по умолчанию; чтобы сбросить к первоначальному значению удалите пользовательское определение)."
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- ВАЖНО: sub name указывать без префикса '%'"
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- ВАЖНО: sub name указывать без префикса '%'"
L["substitution: %s defined as => %s"] = "замена: %s определен как => %s"
L["Substitutions"] = "Замены"
L["TargetClass"] = true
L["TargetGender"] = true
L["TargetGuild"] = "показать гильдию"
L["TargetHealth"] = "показать жизнь"
L["TargetHealthDeficit"] = "Деф. здоровья цели"
L["TargetIcon"] = "показать иконку"
L["TargetLevel"] = "показать уровень"
L["TargetManaDeficit"] = "Деф. маны цели"
L["TargetName"] = "показать имя"
L["TargetPercentHP"] = "% здоровья цели"
L["TargetPossesive"] = true
L["TargetPronoun"] = true
L["TargetRace"] = "Раса цели"
L["TargetTargetName"] = "Имя цели цели"
L["unknown sex"] = "неизвестный пол"
L["user defined substition \"%s\" not found"] = "пользовательская замена \"%s\" не найдена"
L["User defined substitutions"] = "Пользовательские подмены"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "таблица пользовательских замен (usersubs_idx) не существует! о боже."
L["usersub_"] = true

  PL:AddLocale("ruRU", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "%d 全部用户定义的置换"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000注意:|r 置换\"%s\"已定义为\"%s\",覆盖"
L["<noguild>"] = "<无公会>"
L["<notarget>"] = "<无目标>"
L["A module to provide basic chat substitutions."] = "提供基础聊天替换的模块"
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "您确定? - 这样将删除全部用户定义的替换并恢复默认"
L["Are you sure?"] = "您确定？"
L["can't find substitution index for a substitution named '%s'"] = "无法为置换名称 '%s' 找到置换索引"
L["current-prompt"] = "当前值: '%s'Click to paste into the chat."
L["defined %s: expands to => %s"] = "定义 %s: 扩展到 => %s"
L["Delete all"] = "删除全部"
L["Delete substitution"] = "删除置换"
L["Deletes a user defined substitution"] = "删除用户定义的置换"
L["Deletes all user defined substitutions"] = "删除所有用户定义的置换"
L["female"] = "女"
L["her"] = "她"
L["hers"] = "她的"
L["him"] = "他"
L["his"] = "他的"
L["it"] = "它"
L["its"] = "它的"
L["List of available substitutions"] = "列出有效替换"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "在此模块列出有效替换定义..(注:用户可以为已存在的置换定义自定义值,如果用户定义被删除将恢复默认值)"
L["List substitutions"] = "替换列表"
L["Lists all current subtitutions in the default chat frame"] = "在默认聊天框体列出所有当前替换"
L["male"] = "男"
L["MapLoc"] = "地图地点"
L["MapPos"] = "地图坐标"
L["MapXPos"] = "地图X坐标"
L["MapYPos"] = "地图Y坐标"
L["MapZone"] = "地图区域"
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "模块:buildUserSubsIndex(): 警告: 模块模板未定义!"
L["MouseoverTargetName"] = "鼠标滑过目标名"
L["NO MATCHFUNC FOUND"] = "未发现匹配函数"
L["no substitution name given"] = "无特定置换名称"
L["no substitution name supplied for deletion"] = "没有删除部分的替换名称支持"
L["no user defined subs found"] = "未发现用户定义置换"
L["no value given for subtitution \"%s\""] = "置换 \"%s\"没有赋值"
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "设置和移除用户定义置换的选项.(注:用户可以为已存在的置换定义自定义值,如果用户定义被删除将恢复默认值)"
L["PlayerAverageItemLevel"] = "替换"
L["PlayerCurrentMana"] = "玩家当前法力"
L["PlayerHealthDeficit"] = "玩家生命不足"
L["PlayerHP"] = "玩家血量"
L["PlayerManaDeficit"] = "玩家法力不足"
L["PlayerMaxHP"] = "玩家血量上限"
L["PlayerMaxMana"] = "玩家法力上限"
L["PlayerName"] = "玩家名称"
L["PlayerPercentHP"] = "玩家血量百分比"
L["PlayerPercentMana"] = "玩家法力百分比"
L["RandNum"] = "随机数字"
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "移除用户定义的置换 \"%s\"; 以前扩展到=> \"%s\""
L["Set substitution"] = "设置置换"
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "设置用户定义替换的值(注:这可能与现有的默认替换相同;若重置为默认,仅移除用户创建的定义)"
L["subname -- NOTE: sub name without the prefix '%'"] = "置换名称 -- 注意: 置换名称无前缀 '%'"
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "置换名称 = 扩展后文本-- 注意: 置换名称无前缀 \"%\""
L["substitution: %s defined as => %s"] = "替换: %s 定义为 => %s"
L["Substitutions"] = "置换"
L["TargetClass"] = "目标等级"
L["TargetGender"] = "目标性别"
L["TargetGuild"] = "目标公会"
L["TargetHealth"] = "目标生命"
L["TargetHealthDeficit"] = "目标生命不足"
L["TargetIcon"] = "目标图标"
L["TargetLevel"] = "目标等级"
L["TargetManaDeficit"] = "目标法力不足"
L["TargetName"] = "目标名称"
L["TargetPercentHP"] = "目标血量百分比"
L["TargetPossesive"] = "目标阵营"
L["TargetPronoun"] = "目标代词"
L["TargetRace"] = "目标种族"
L["TargetTargetName"] = "目标的目标名称"
L["unknown sex"] = "未知性别"
L["user defined substition \"%s\" not found"] = "未发现用户定义替换\"%s\" "
L["User defined substitutions"] = "用户自定义置换"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "用户替换指数(子用户_索引) 不存在!哦,亲爱的."
L["usersub_"] = "子用户_"

  PL:AddLocale("zhCN", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "Total de sustituciones definidas por el usuario %d"
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000advertencia:|r sustitución \"%s\" ya definida como \"%s\", sobrescribiendo"
L["<noguild>"] = "<sin hermandad>"
L["<notarget>"] = "<sin objetivo>"
L["A module to provide basic chat substitutions."] = "Un módulo que proporciona sustituciones básicas del chat."
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "¿Está seguro - esto eliminará todas las sustituciones definidas por el usuario y restablece los valores predeterminados?"
L["Are you sure?"] = "¿Está seguro?"
L["can't find substitution index for a substitution named '%s'"] = "No se encuentra el índice de sustitución para una sustitución con el nombre '%s'"
L["current-prompt"] = [=[Valor actual: '%s'
Click para pegar en el chat.]=]
L["defined %s: expands to => %s"] = "definido %s: se expande a => %s"
L["Delete all"] = "Eliminar todo"
L["Delete substitution"] = "Eliminar sustitución"
L["Deletes a user defined substitution"] = "Elimina una sustitución del usuario"
L["Deletes all user defined substitutions"] = "Elimina todas las sustituciones del usuario"
L["female"] = "Femenino"
L["her"] = "ella"
L["hers"] = "suya"
L["him"] = "él"
L["his"] = "suyo"
--[[Translation missing --]]
L["it"] = "it"
--[[Translation missing --]]
L["its"] = "its"
L["List of available substitutions"] = "Listado de sustituciones disponibles"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Lista de sustituciones definidas por este módulo. (Nota: los usuarios pueden definir valores personalizados para las sustituciones, pero volverá al valor por defecto si la definición del usuario se suprime.)"
L["List substitutions"] = "Listado de sustituciones"
L["Lists all current subtitutions in the default chat frame"] = "Lista todas las sustituciones actuales en el marco de chat por defecto."
L["male"] = "Masculino"
L["MapLoc"] = true
L["MapPos"] = true
L["MapXPos"] = true
L["MapYPos"] = true
L["MapZone"] = "MapZona"
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "módulo: buildUserSubsIndex(): advertencia: ¡patrones del módulo no definidos!"
--[[Translation missing --]]
L["MouseoverTargetName"] = "MouseoverTargetName"
L["NO MATCHFUNC FOUND"] = "SIN FUNCIONCOINCIDENCIAS ENCONTRADA"
L["no substitution name given"] = "ningún nombre de sustitución dado"
L["no substitution name supplied for deletion"] = "ningún nombre de sustitución proporcionado para su eliminación"
L["no user defined subs found"] = "sustituciones definidas por el usuario no encontradas"
L["no value given for subtitution \"%s\""] = "ningún valor dado para sustitución \"%s\""
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Opciones para establecer y eliminar sustituciones definidas por el usuario. (Nota: los usuarios pueden definir valores personalizados para las sustituciones, pero volverán al valor por defecto si las definiciones del usuario son suprimidas.)"
--[[Translation missing --]]
L["PlayerAverageItemLevel"] = "PlayerAverageItemLevel"
L["PlayerCurrentMana"] = "ManaActualJugador"
L["PlayerHealthDeficit"] = "DéficitSaludJugador"
L["PlayerHP"] = "VidaJugador"
L["PlayerManaDeficit"] = "DéficitManaJugador"
L["PlayerMaxHP"] = "VidaMaxJugador"
L["PlayerMaxMana"] = "ManaMaxJugador"
L["PlayerName"] = "NombreJugador"
L["PlayerPercentHP"] = "PorcentVidaJugador"
L["PlayerPercentMana"] = "PorcentManaJugador"
L["RandNum"] = "NumAleat"
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "Quitando sustitución definida por el usuario \"%s\"; anteriormente ampliada a => \"%s\""
L["Set substitution"] = "Establecer sustitución"
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Establecer el valor de una sustitución definida por el usuario (Nota: puede ser la misma que una sustitución predeterminada, para restablecerla a la predeterminada, sólo quitar la definición de usuario creada)."
L["subname -- NOTE: sub name without the prefix '%'"] = "subnombre -- NOTA: sub nombre sin el prefijo '%'"
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subnombre = texto después de expansión --NOTA: sub nombre sin el prefijo \"%\""
L["substitution: %s defined as => %s"] = "sustitución: %s definido como => %s"
L["Substitutions"] = "Sustituciones"
L["TargetClass"] = "ClaseObjetivo"
L["TargetGender"] = "GéneroObjetivo"
L["TargetGuild"] = "HermandadObjetivo"
L["TargetHealth"] = "SaludObjetivo"
L["TargetHealthDeficit"] = "DéficitSaludObjetivo"
L["TargetIcon"] = "IconoObjetivo"
L["TargetLevel"] = "NivelObjetivo"
L["TargetManaDeficit"] = "DéficitManaObjetivo"
L["TargetName"] = "NombreObjetivo"
L["TargetPercentHP"] = "PorcentVidaObjetivo"
L["TargetPossesive"] = "PosesiónObjetivo"
L["TargetPronoun"] = "PronombreObjetivo"
L["TargetRace"] = "RazaObjetivo"
L["TargetTargetName"] = "ObjetivoObjetivoNombre"
L["unknown sex"] = "Sexo desconocido"
L["user defined substition \"%s\" not found"] = "sustitución definida por el usuario \"%s\" no encontrada"
L["User defined substitutions"] = "Sustituciones definidas por el usuario"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "¡no existe un índice de sustituciones de usuario (usersubs_idx)!."
L["usersub_"] = "sub usuario_"

  PL:AddLocale("esES", L)

  L = {}
  -- Substitutions
L["%d total user defined substitutions"] = "%d 總使用者定義代替"
--[[Translation missing --]]
L["|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"] = "|cffff0000warning:|r subtitution \"%s\" already defined as \"%s\", overwriting"
L["<noguild>"] = "<無公會>"
L["<notarget>"] = "<無目標>"
L["A module to provide basic chat substitutions."] = "提供基本聊天標題的模組"
L["Are you sure - this will delete all user defined substitutions and reset defaults?"] = "你確定嗎 - 這將刪除所有使用者替換且重置至預設值？"
L["Are you sure?"] = "你確定嗎？"
--[[Translation missing --]]
L["can't find substitution index for a substitution named '%s'"] = "can't find substitution index for a substitution named '%s'"
L["current-prompt"] = [=[當前值：%s
點擊以在聊天視窗中貼上]=]
L["defined %s: expands to => %s"] = "定義 %s：擴張至 => %s"
L["Delete all"] = "刪除所有"
L["Delete substitution"] = "刪除標題"
L["Deletes a user defined substitution"] = "刪除一個由使用者自定義的標題"
L["Deletes all user defined substitutions"] = "刪除所有由使用者自定義的標題"
L["female"] = "女性"
L["her"] = "她"
L["hers"] = "她的"
L["him"] = "他"
L["his"] = "他的"
L["it"] = "它"
L["its"] = "它的"
L["List of available substitutions"] = "可用標題清單"
L["List of available substitutions defined by this module. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "由此模組定義的可用標題之清單"
L["List substitutions"] = "標題清單"
L["Lists all current subtitutions in the default chat frame"] = "默認聊天框中所有現用標題清單"
L["male"] = "男性"
L["MapLoc"] = true
L["MapPos"] = "地圖位置"
L["MapXPos"] = "地圖X軸"
L["MapYPos"] = "地圖Y軸"
L["MapZone"] = "地圖地區"
--[[Translation missing --]]
L["module:buildUserSubsIndex(): warning: module patterns not defined!"] = "module:buildUserSubsIndex(): warning: module patterns not defined!"
L["MouseoverTargetName"] = "鼠標懸停目標名字"
L["NO MATCHFUNC FOUND"] = true
--[[Translation missing --]]
L["no substitution name given"] = "no substitution name given"
--[[Translation missing --]]
L["no substitution name supplied for deletion"] = "no substitution name supplied for deletion"
L["no user defined subs found"] = "找不到使用者定義的代替"
--[[Translation missing --]]
L["no value given for subtitution \"%s\""] = "no value given for subtitution \"%s\""
--[[Translation missing --]]
L["Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"] = "Options for setting and removing user defined substitutions. (NB: users may define custom values for existing substitutions, but they will revert to the default value if the user definition is deleted.)"
L["PlayerAverageItemLevel"] = true
L["PlayerCurrentMana"] = "玩家當前法力值"
L["PlayerHealthDeficit"] = "玩家生命不足"
L["PlayerHP"] = "玩家生命值"
L["PlayerManaDeficit"] = "玩家法力不足"
L["PlayerMaxHP"] = "玩家最大血量"
L["PlayerMaxMana"] = "玩家最大法力"
L["PlayerName"] = "玩家名字"
L["PlayerPercentHP"] = "玩家百分比血量"
L["PlayerPercentMana"] = "玩家百分比法力"
L["RandNum"] = true
--[[Translation missing --]]
L["removing user defined substitution \"%s\"; previously expanded to => \"%s\""] = "removing user defined substitution \"%s\"; previously expanded to => \"%s\""
L["Set substitution"] = "設定代替"
--[[Translation missing --]]
L["Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."] = "Set the value of a user defined substitution (NB: this may be the same as an existing default substitution; to reset it to the default, just remove the user created definition)."
--[[Translation missing --]]
L["subname -- NOTE: sub name without the prefix '%'"] = "subname -- NOTE: sub name without the prefix '%'"
--[[Translation missing --]]
L["subname = text after expansion -- NOTE: sub name without the prefix \"%\""] = "subname = text after expansion -- NOTE: sub name without the prefix \"%\""
L["substitution: %s defined as => %s"] = "代替: %s 定義為 => %s"
L["Substitutions"] = "代替"
L["TargetClass"] = "目標職業"
L["TargetGender"] = "目標性別"
L["TargetGuild"] = "目標公會"
L["TargetHealth"] = "目標生命"
L["TargetHealthDeficit"] = "目標生命不足"
L["TargetIcon"] = "目標圖示"
L["TargetLevel"] = "目標等級"
L["TargetManaDeficit"] = "目標法力不足"
L["TargetName"] = "目標名字"
L["TargetPercentHP"] = "目標百比分血量"
--[[Translation missing --]]
L["TargetPossesive"] = "TargetPossesive"
L["TargetPronoun"] = "目標代名詞"
L["TargetRace"] = "目標種族"
L["TargetTargetName"] = "目標的目標名字"
L["unknown sex"] = "未知的性別"
L["user defined substition \"%s\" not found"] = "未搜尋到使用者自定義替換 \"%s\""
L["User defined substitutions"] = "使用者自定義的替換"
L["user substitutions index (usersubs_idx) doesn't exist! oh dear."] = "親愛的使用者自替換索引(usersubs_idx)並不存在。"
L["usersub_"] = true

  PL:AddLocale("zhTW", L)
  end
  --@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
		}
	})

	local patternPlugins = { patterns = {} }

	Prat:SetModuleOptions(module.name, {
		name = PL["Substitutions"],
		desc = PL["A module to provide basic chat substitutions."],
		type = 'group',
		plugins = patternPlugins,
		args = {}
	})

	local function subDesc(info)
		return info.handler:GetSubstDescription(info)
	end


	--[[------------------------------------------------
	Core Functions
	------------------------------------------------]] --
	function module:OnModuleEnable()
		self:BuildModuleOptions(patternPlugins.patterns)
	end

	function module:BuildModuleOptions(args)
		local modulePatterns = Prat:GetModulePatterns(self)

		self.buildingMenu = true

		for _, v in pairs(modulePatterns) do
			if v then
				local name = v.optname
				local pat = v.pattern:gsub("%%%%", "%%")

				args[name] = args[name] or {}
				local d = args[name]

				d.name = name .. " " .. pat
				d.desc = subDesc
				d.type = "execute"
				d.func = "DoPat"
			end
		end

		self.buildingMenu = false
	end

	function module:GetDescription()
		return PL["A module to provide basic chat substitutions."]
	end

	function module:GetSubstDescription(info)
		local val = self:InfoToPattern(info)

		self.buildingMenu = true

		val = val and val.matchfunc and val.matchfunc() or PL["NO MATCHFUNC FOUND"]
		val = PL["current-prompt"]:format("|cff80ff80" .. tostring(val) .. "|r"):gsub("%%%%", "%%")

		self.buildingMenu = false

		return val
	end

	function module:InfoToPattern(info)
		local modulePatterns = Prat:GetModulePatterns(self)
		local name = info[#info] or ""

		if modulePatterns then
			for _, v in pairs(modulePatterns) do
				if v and v.optname == name then
					return v
				end
			end
		end
	end

	function module:DoPat(info)
		local pat = self:InfoToPattern(info)
		pat = pat and pat.pattern or ""
		local e = ChatEdit_GetActiveWindow()
		if not e or not e:IsVisible() then
			return
		end

		e:SetText((e:GetText() or "") .. pat:gsub("[%(%)]", ""):gsub("%%%%", "%%"))
	end

	do
		local function prat_match(text)
			text = text or ""

			if module.buildingMenu then
				return text
			end

			return Prat:RegisterMatch(text, "OUTBOUND")
		end

		local function Zone()
			return prat_match(GetRealZoneText())
		end

		local function Loc()
			return prat_match(GetMinimapZoneText())
		end

		local function GetPlayerMapPosition(unit)
			return C_Map.GetPlayerMapPosition(C_Map.GetBestMapForUnit(unit), unit):GetXY()
		end

		local function Pos()
			local x, y = GetPlayerMapPosition("player")
			local str = "(" .. math.floor((x * 100) + 0.5) .. "," .. math.floor((y * 100) + 0.5) .. ")"
			return prat_match(str)
		end

		local function Ypos()
			local _, y = GetPlayerMapPosition("player")
			y = tostring(math.floor((y * 100) + 0.5))
			return prat_match(y)
		end

		local function Xpos()
			local x = GetPlayerMapPosition("player")
			x = tostring(math.floor((x * 100) + 0.5))
			return prat_match(x)
		end

		local function PlayerHP()
			return prat_match(UnitHealth("player"))
		end

		local function PlayerMaxHP()
			return prat_match(UnitHealthMax("player"))
		end

		local function PlayerPercentHP()
			return prat_match(floor(100 * (UnitHealth("player") / UnitHealthMax("player"))))
		end

		local function PlayerHealthDeficit()
			return prat_match(UnitHealthMax("player") - UnitHealth("player"))
		end

		local function PlayerCurrentMana()
			return prat_match(UnitPower("player"))
		end

		local function PlayerMaxMana()
			return prat_match(UnitPowerMax("player"))
		end

		local function PlayerPercentMana()
			return prat_match(string.format("%.0f%%%%",
				floor(100 * (UnitPower("player") / UnitPowerMax("player")))))
		end

		local function PlayerManaDeficit()
			return prat_match(UnitPowerMax("player") - UnitPower("player"))
		end

		local function TargetPercentHP()
			local str = PL["<notarget>"]
			if UnitExists("target") then
				str = string.format("%.0f%%%%", floor(100 * (UnitHealth("target") / UnitHealthMax("target"))))
			end

			return prat_match(str)
		end

		local function TargetHealth()
			local str = PL["<notarget>"]
			if UnitExists("target") then
				str = UnitHealth("target")
			end

			return prat_match(str)
		end

		local function TargetHealthDeficit()
			local str = PL["<notarget>"]
			if UnitExists("target") then
				str = UnitHealthMax("target") - UnitHealth("target")
			end

			return prat_match(str)
		end

		local function TargetManaDeficit()
			local str = PL["<notarget>"]
			if UnitExists("target") then
				str = UnitPowerMax("target") - UnitPower("target")
			end

			return prat_match(str)
		end

		local function TargetClass()
			local class = PL["<notarget>"]
			if UnitExists("target") then
				class = UnitClass("target")
			end

			return prat_match(class)
		end

		local raidiconpfx = ICON_TAG_RAID_TARGET_STAR1:sub(1, -2) or "rt"

		local function TargetIcon()
			local icon = ""
			if not Prat.IsRetail and UnitExists("target") then
				local iconnum = GetRaidTargetIndex("target")

				if type(iconnum) ~= "nil" then
					icon = ("{%s%d}"):format(raidiconpfx, tostring(iconnum))
				end
			end

			return prat_match(icon)
		end

		local function TargetRace()
			local race = PL["<notarget>"]
			if UnitExists("target") then
				if UnitIsPlayer("target") then
					race = UnitRace("target")
				else
					race = UnitCreatureFamily("target")
					if not race then
						race = UnitCreatureType("target")
					end
				end
			end
			return prat_match(race)
		end

		local function TargetGender()
			local sex = PL["<notarget>"]
			if UnitExists("target") then
				local s = UnitSex("target")
				if (s == 2) then
					sex = PL["male"]
				elseif (s == 3) then
					sex = PL["female"]
				else
					sex = PL["unknown sex"]
				end
			end

			return prat_match(sex)
		end

		local function TargetLevel()
			local level = PL["<notarget>"]
			if UnitExists("target") then
				level = UnitLevel("target")
			end
			return prat_match(level)
		end

		local function TargetGuild()
			local guild = PL["<notarget>"]
			if UnitExists("target") then
				guild = PL["<noguild>"]
				if IsInGuild("target") then
					guild = GetGuildInfo("target") or ""
				end
			end
			return prat_match(guild)
		end

		-- %tps (possesive)
		local function TargetPossesive()
			local p = PL["<notarget>"]
			if UnitExists("target") then
				local s = UnitSex("target")
				if (s == 2) then
					p = PL["his"]
				elseif (s == 3) then
					p = PL["hers"]
				else
					p = PL["its"]
				end
			end

			return prat_match(p)
		end

		-- %tpn (pronoun)
		local function TargetPronoun()
			local p = PL["<notarget>"]
			if UnitExists("target") then
				local s = UnitSex("target")
				if (s == 2) then
					p = PL["him"]
				elseif (s == 3) then
					p = PL["her"]
				else
					p = PL["it"]
				end
			end
			return prat_match(p)
		end

		-- %tn (target)
		local function TargetName()
			local t = PL['<notarget>']

			if UnitExists("target") then
				t = UnitName("target")
			end

			return prat_match(t)
		end

		-- %tt (target)
		local function TargetTargetName()
			local t = PL['<notarget>']

			if UnitExists("targettarget") then
				t = UnitName("targettarget")
			end

			return prat_match(t)
		end

		-- %mn (mouseover)
		local function MouseoverName()
			local t = PL['<notarget>']

			if UnitExists("mouseover") then
				t = UnitName("mouseover")
			end

			return prat_match(t)
		end

		-- %pn (player)
		local function PlayerName()
			local p = GetUnitName("player") or ""
			return prat_match(p)
		end

		local function PlayerAverageItemLevel()
			local avgItemLevel = GetAverageItemLevel();
			avgItemLevel = floor(avgItemLevel);

			return prat_match(avgItemLevel)
		end

		local function Rand()
			return prat_match(math.random(1, 100))
		end

		--[[
		 * %tn = current target
		 * %pn = player name
		 * %hc = your current health
		 * %hm = your max health
		 * %hp = your percentage health
		 * %hd = your current health deficit
		 * %mc = your current mana
		 * %mm = your max mana
		 * %mp = your percentage mana
		 * %md = your current mana deficit
		 * %thp = target's percentage health
		 * %th = target's current health
		 * %td = target's health deficit
		 * %tc = class of target
		 * %tr = race of target
		 * %ts = sex of target
		 * %tl = level of target
		 * %ti = raid icon of target
		 * %tps = possesive for target (his/hers/its)
		 * %tpn = pronoun for target (him/her/it)
		 * %fhp = focus's percentage health
		 * %fc = class of focus
		 * %fr = race of focus
		 * %fs = sex of focus
		 * %fl = level of focus
		 * %fps = possesive for focus (his/hers/its)
		 * %fpn = pronoun for focus (him/her/it)
		 * %tt = target of target
		 * %zon = your current zone (Dun Morogh, Hellfire Peninsula, etc.)
		 * %loc = your current subzone (as shown on the minimap)
		 * %pos = your current coordinates (x,y)
		 * %ypos = your current y coordinate
		 * %xpos = your current x coordinate
		 * %rnd = a random number between 1 and 100
		 * %ail = your average item level
		 --]]

		Prat:SetModulePatterns(module, {
			{ pattern = "(%%thd)", matchfunc = TargetHealthDeficit, optname = PL["TargetHealthDeficit"], type = "OUTBOUND" },
			{
				pattern = "(%%thp)",
				matchfunc = TargetPercentHP,
				priority = 51,
				optname = PL["TargetPercentHP"],
				type = "OUTBOUND"
			},
			{ pattern = "(%%tpn)", matchfunc = TargetPronoun, optname = PL["TargetPronoun"], type = "OUTBOUND" },

			{ pattern = "(%%hc)", matchfunc = PlayerHP, optname = PL["PlayerHP"], type = "OUTBOUND" },
			{ pattern = "(%%pn)", matchfunc = PlayerName, optname = PL["PlayerName"], type = "OUTBOUND" },
			{ pattern = "(%%hm)", matchfunc = PlayerMaxHP, optname = PL["PlayerMaxHP"], type = "OUTBOUND" },
			{ pattern = "(%%hd)", matchfunc = PlayerHealthDeficit, optname = PL["PlayerHealthDeficit"], type = "OUTBOUND" },
			{ pattern = "(%%hp)", matchfunc = PlayerPercentHP, optname = PL["PlayerPercentHP"], type = "OUTBOUND" },
			{ pattern = "(%%mc)", matchfunc = PlayerCurrentMana, optname = PL["PlayerCurrentMana"], type = "OUTBOUND" },
			{ pattern = "(%%mm)", matchfunc = PlayerMaxMana, optname = PL["PlayerMaxMana"], type = "OUTBOUND" },
			{ pattern = "(%%mp)", matchfunc = PlayerPercentMana, optname = PL["PlayerPercentMana"], type = "OUTBOUND" },
			{ pattern = "(%%pmd)", matchfunc = PlayerManaDeficit, optname = PL["PlayerManaDeficit"], type = "OUTBOUND" },

			GetAverageItemLevel and {
				pattern = "(%%ail)",
				matchfunc = PlayerAverageItemLevel,
				optname = PL["PlayerAverageItemLevel"],
				type = "OUTBOUND"
			},

			{ pattern = "(%%tn)", matchfunc = TargetName, optname = PL["TargetName"], type = "OUTBOUND" },
			{ pattern = "(%%tt)", matchfunc = TargetTargetName, optname = PL["TargetTargetName"], type = "OUTBOUND" },
			{ pattern = "(%%tc)", matchfunc = TargetClass, optname = PL["TargetClass"], type = "OUTBOUND" },
			{ pattern = "(%%th)", matchfunc = TargetHealth, optname = PL["TargetHealth"], type = "OUTBOUND" },
			{ pattern = "(%%tr)", matchfunc = TargetRace, optname = PL["TargetRace"], type = "OUTBOUND" },
			{ pattern = "(%%ts)", matchfunc = TargetGender, optname = PL["TargetGender"], type = "OUTBOUND" },
			{ pattern = "(%%ti)", matchfunc = TargetIcon, optname = PL["TargetIcon"], type = "OUTBOUND" },
			{ pattern = "(%%tl)", matchfunc = TargetLevel, optname = PL["TargetLevel"], type = "OUTBOUND" },
			{ pattern = "(%%tps)", matchfunc = TargetPossesive, optname = PL["TargetPossesive"], type = "OUTBOUND" },
			{ pattern = "(%%tmd)", matchfunc = TargetManaDeficit, optname = PL["TargetManaDeficit"], type = "OUTBOUND" },
			{ pattern = "(%%tg)", matchfunc = TargetGuild, optname = PL["TargetGuild"], type = "OUTBOUND" },

			{ pattern = "(%%mn)", matchfunc = MouseoverName, optname = PL["MouseoverTargetName"], type = "OUTBOUND" },

			{ pattern = "(%%zon)", matchfunc = Zone, optname = PL["MapZone"], type = "OUTBOUND" },
			{ pattern = "(%%loc)", matchfunc = Loc, optname = PL["MapLoc"], type = "OUTBOUND" },
			{ pattern = "(%%pos)", matchfunc = Pos, optname = PL["MapPos"], type = "OUTBOUND" },
			{ pattern = "(%%ypos)", matchfunc = Ypos, optname = PL["MapYPos"], type = "OUTBOUND" },
			{ pattern = "(%%xpos)", matchfunc = Xpos, optname = PL["MapXPos"], type = "OUTBOUND" },
			{ pattern = "(%%rnd)", matchfunc = Rand, optname = PL["RandNum"], type = "OUTBOUND" },
		}

		--[[ TODO:
				 %%fhp - focus health
				 %%fr
				 %%fc
				 %%fs
				 %%fl
				 %%fvr
				 %%fvn
				 ]])
	end

	return
end) -- Prat:AddModuleToLoad
