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

local Prat = Prat

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("AltNames", "AceHook-3.0", "AceEvent-3.0")

	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["Start"] = true,
		["AltNames"] = true,
		["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off).",
		["quiet"] = "Be quiet",
		["quiet_name"] = true,
		["quiet_desc"] = "Whether to report to the chat frame or not.",
		["mainpos_name"] = "Main name position",
		["mainpos_desc"] = "Where to display a character's main name when on their alt.",
		["Main name position"] = true,
		["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = true,
		["Where to display a character's main name when on their alt."] = true,
		["Left"] = true,
		["Right"] = true,
		["Disabled"] = true,
		["Find characters"] = true,
		["Search the list of linked characters for matching main or alt names."] = true,
		["<search term> (eg, /altnames find fin)"] = true,
		["Link alt"] = true,
		["Link someone's alt character with the name of their main."] = true,
		["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = true,
		["Delete alt"] = true,
		["Delete a character's link to another character as their main."] = true,
		["Be quiet"] = true,
		["Whether to report to the chat frame or not."] = true,
		["You have not yet linked any alts with their mains."] = true,
		["no matches found"] = true,
		["List all"] = true,
		["List all links between alts and their main names."] = true,
		["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = true,
		["LOKWhoIsWho import"] = true,
		["Clear all"] = true,
		["Clear all links between alts and main names."] = true,
		["Colour"] = true,
		["The colour of an alt's main name that will be displayed"] = true,
		["Import from guild roster"] = true,
		['Imports alt names from the guild roster by checking for members with the rank "alt" or "alts", or guild / officer notes like "<name>\'s alt"'] = true,
		['Import from Guild Greet database'] = true,
		['Imports alt names from a Guild Greet database, if present'] = true,
		['Use class colour (from the PlayerNames module)'] = true,
		["use class colour of main"] = true,
		["use class colour of alt"] = true,
		["don't use"] = true,
		["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = true,
		["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = true,
		["Don't use data from the PlayerNames module at all"] = true,
		["Import options"] = true,
		["Various ways to import a main's alts from other addons"] = true,
		["Don't overwrite existing links"] = true,
		["Don't overwrite existing alt <-> main links when importing or adding new alts."] = true,
		[".*[Aa]lts?$"] = true,
		[".*[Tt]wink.*$"] = true,
		["(.-)'s? [Aa]lt"] = "%f[%a\192-\255]([%a\192-\255]+)%f[^%a\128-\255]'s [Aa]lt",
		["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\192-\255]([%a\192-\255]+)%f[^%a\128-\255]'s [Aa]lt",
		["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%a\192-\255]([%a\192-\255]+)%f[^%a\128-\255]",
		['ERROR: some function sent a blank message!'] = true,
		["Alts:"] = true,
		['Main:'] = true,
		["No main name suPLied to link %s to"] = true,
		['alt name exists: %s -> %s; not overwriting as set in preferences'] = true,
		['warning: alt %s already linked to %s'] = true,
		["linked alt %s => %s"] = true,
		["character removed: %s"] = true,
		['no characters called "%s" found; nothing deleted'] = true,
		['%s total alts linked to mains'] = true,
		['no alts or mains found matching "%s"'] = true,
		["searched for: %s - total matches: %s"] = true,
		['LOKWhoIsWho lua file not found, sorry.'] = true,
		["LOKWhoIsWho data not found"] = true,
		["%s alts imported from LOKWhoIsWho"] = true,
		['No Guild Greet database found'] = true,
		['You are not in a guild'] = true,
		["guild member alts found and imported: %s"] = true,
		["Fix alts"] = true,
		["Fix corrupted entries in your list of alt names."] = true,
		["Class colour"] = true,
		['Show main in tooltip'] = true,
		["Display a player's main name in the tooltip"] = true,
		['Show alts in tooltip'] = true,
		["Display a player's alts in the tooltip"] = true,
		["Found alt: %s => main: %s"] = true,
		["alt"] = true,
		["main"] = true,
		["Alt"] = true,
		["Main"] = true,
		['no alts found for character '] = true,
		['List alts'] = true,
		['List alts for a given character'] = true,
		['<main> (eg /altnames listalts Fin)'] = true,
		['%d alts found for %s: %s'] = true,
		['No arg string given to :addAlt()'] = true,
		["Use LibAlts Data"] = true,
		["Use the data available via the shared alt information library."] = true,
		["autoguildalts_name"] = "Auto Import Guild Alts",
		["autoguildalts_desc"] = "Automatically run the import from guild roster command silently",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization

	--@non-debug@
  do
		local L


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = true
L["%s alts imported from LOKWhoIsWho"] = true
L["%s total alts linked to mains"] = true
L["(.-)'s? [Aa]lt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
L[".*[Aa]lts?$"] = true
L[".*[Tt]wink.*$"] = true
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = true
L["<main> (eg /altnames listalts Fin)"] = true
L["<search term> (eg, /altnames find fin)"] = true
L["Alt"] = true
L["alt"] = true
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = true
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = true
L["Alts:"] = true
L["autoguildalts_desc"] = "Automatically run the import from guild roster command silently"
L["autoguildalts_name"] = "Auto Import Guild Alts"
L["Be quiet"] = true
L["character removed: %s"] = true
L["Class colour"] = true
L["Clear all"] = true
L["Clear all links between alts and main names."] = true
L["Colour"] = true
L["Delete a character's link to another character as their main."] = true
L["Delete alt"] = true
L["Disabled"] = true
L["Display a player's alts in the tooltip"] = true
L["Display a player's main name in the tooltip"] = true
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = true
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = true
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = true
L["Don't overwrite existing links"] = true
L["don't use"] = true
L["Don't use data from the PlayerNames module at all"] = true
L["ERROR: some function sent a blank message!"] = true
L["Find characters"] = true
L["Fix alts"] = true
L["Fix corrupted entries in your list of alt names."] = true
L["Found alt: %s => main: %s"] = true
L["guild member alts found and imported: %s"] = true
L["Import from Guild Greet database"] = true
L["Import from guild roster"] = true
L["Import options"] = true
L["Imports alt names from a Guild Greet database, if present"] = true
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = true
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = true
L["Left"] = true
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = true
L["Link alt"] = true
L["Link someone's alt character with the name of their main."] = true
L["linked alt %s => %s"] = true
L["List all"] = true
L["List all links between alts and their main names."] = true
L["List alts"] = true
L["List alts for a given character"] = true
L["LOKWhoIsWho data not found"] = true
L["LOKWhoIsWho import"] = true
L["LOKWhoIsWho lua file not found, sorry."] = true
L["Main"] = true
L["main"] = true
L["Main name position"] = true
L["Main:"] = true
L["mainpos_desc"] = "Where to display a character's main name when on their alt."
L["mainpos_name"] = "Main name position"
L["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off)."
L["no alts found for character "] = true
L["no alts or mains found matching \"%s\""] = true
L["No arg string given to :addAlt()"] = true
L["no characters called \"%s\" found; nothing deleted"] = true
L["No Guild Greet database found"] = true
L["No main name suPLied to link %s to"] = true
L["No main name supplied to link %s to"] = true
L["no matches found"] = true
L["quiet"] = "Be quiet"
L["quiet_desc"] = "Whether to report to the chat frame or not."
L["quiet_name"] = true
L["Right"] = true
L["Search the list of linked characters for matching main or alt names."] = true
L["searched for: %s - total matches: %s"] = true
L["Show alts in tooltip"] = true
L["Show main in tooltip"] = true
L["Start"] = true
L["The colour of an alt's main name that will be displayed"] = true
L["Use class colour (from the PlayerNames module)"] = true
L["use class colour of alt"] = true
L["use class colour of main"] = true
L["Use LibAlts Data"] = true
L["Use the data available via the shared alt information library."] = true
L["Various ways to import a main's alts from other addons"] = true
L["warning: alt %s already linked to %s"] = true
L["Where to display a character's main name when on their alt."] = true
L["Whether to report to the chat frame or not."] = true
L["You are not in a guild"] = true
L["You have not yet linked any alts with their mains."] = true

	  PL:AddLocale("enUS",L)


  L = {}
  -- AltNames
--[[Translation missing --]]
L["%d alts found for %s: %s"] = "%d alts found for %s: %s"
--[[Translation missing --]]
L["%s alts imported from LOKWhoIsWho"] = "%s alts imported from LOKWhoIsWho"
L["%s total alts linked to mains"] = "%s nb total de reroll liés au personnage principal"
--[[Translation missing --]]
L["(.-)'s? [Aa]lt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
--[[Translation missing --]]
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
L[".*[Aa]lts?$"] = ".*[Rr]erolls?$"
--[[Translation missing --]]
L[".*[Tt]wink.*$"] = ".*[Tt]wink.*$"
--[[Translation missing --]]
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"
--[[Translation missing --]]
L["<main> (eg /altnames listalts Fin)"] = "<main> (eg /altnames listalts Fin)"
--[[Translation missing --]]
L["<search term> (eg, /altnames find fin)"] = "<search term> (eg, /altnames find fin)"
L["Alt"] = "Reroll"
L["alt"] = "reroll"
--[[Translation missing --]]
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "alt name exists: %s -> %s; not overwriting as set in preferences"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
--[[Translation missing --]]
L["AltNames"] = "AltNames"
L["Alts:"] = "Rerolls:"
--[[Translation missing --]]
L["autoguildalts_desc"] = "Automatically run the import from guild roster command silently"
--[[Translation missing --]]
L["autoguildalts_name"] = "Auto Import Guild Alts"
L["Be quiet"] = "Soit silencieux"
L["character removed: %s"] = "Personnage supprimé : %s"
L["Class colour"] = "Couleur de classe"
L["Clear all"] = "Tout supprimer"
--[[Translation missing --]]
L["Clear all links between alts and main names."] = "Clear all links between alts and main names."
L["Colour"] = "Couleur"
--[[Translation missing --]]
L["Delete a character's link to another character as their main."] = "Delete a character's link to another character as their main."
L["Delete alt"] = "Supprimer reroll"
L["Disabled"] = "Désactiver"
L["Display a player's alts in the tooltip"] = "Afficher les rerolls d'un joueur dans la tooltip"
L["Display a player's main name in the tooltip"] = "Affiche le nom principale d'un joueur dans la tooltip"
--[[Translation missing --]]
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"
--[[Translation missing --]]
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Ne pas écraser les liens principal <-> Alternatif lors d'un import ou d'un ajout de nouveaux personnages Alternatifs"
L["Don't overwrite existing links"] = "Ne pas écraser les liens existant"
L["don't use"] = "Ne pas utiliser"
L["Don't use data from the PlayerNames module at all"] = "Ne pas utiliser les donnée du module \"PlayerNames\" du tout"
L["ERROR: some function sent a blank message!"] = "ERREUR: une fonction a envoyé un message blanc !"
L["Find characters"] = "Trouver des personnages"
L["Fix alts"] = "Réparer les personnages secondaires"
L["Fix corrupted entries in your list of alt names."] = "Réparer les entrées corrompues dans votre liste de noms alternatifs."
--[[Translation missing --]]
L["Found alt: %s => main: %s"] = "Found alt: %s => main: %s"
--[[Translation missing --]]
L["guild member alts found and imported: %s"] = "guild member alts found and imported: %s"
--[[Translation missing --]]
L["Import from Guild Greet database"] = "Import from Guild Greet database"
--[[Translation missing --]]
L["Import from guild roster"] = "Import from guild roster"
--[[Translation missing --]]
L["Import options"] = "Import options"
--[[Translation missing --]]
L["Imports alt names from a Guild Greet database, if present"] = "Imports alt names from a Guild Greet database, if present"
--[[Translation missing --]]
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""
--[[Translation missing --]]
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"
--[[Translation missing --]]
L["Link alt"] = "Link alt"
--[[Translation missing --]]
L["Link someone's alt character with the name of their main."] = "Link someone's alt character with the name of their main."
--[[Translation missing --]]
L["linked alt %s => %s"] = "linked alt %s => %s"
--[[Translation missing --]]
L["List all"] = "List all"
--[[Translation missing --]]
L["List all links between alts and their main names."] = "List all links between alts and their main names."
--[[Translation missing --]]
L["List alts"] = "List alts"
--[[Translation missing --]]
L["List alts for a given character"] = "List alts for a given character"
--[[Translation missing --]]
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho data not found"
--[[Translation missing --]]
L["LOKWhoIsWho import"] = "LOKWhoIsWho import"
--[[Translation missing --]]
L["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho lua file not found, sorry."
--[[Translation missing --]]
L["Main"] = "Main"
--[[Translation missing --]]
L["main"] = "main"
--[[Translation missing --]]
L["Main name position"] = "Main name position"
--[[Translation missing --]]
L["Main:"] = "Main:"
--[[Translation missing --]]
L["mainpos_desc"] = "Where to display a character's main name when on their alt."
--[[Translation missing --]]
L["mainpos_name"] = "Main name position"
--[[Translation missing --]]
L["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off)."
--[[Translation missing --]]
L["no alts found for character "] = "no alts found for character "
--[[Translation missing --]]
L["no alts or mains found matching \"%s\""] = "no alts or mains found matching \"%s\""
--[[Translation missing --]]
L["No arg string given to :addAlt()"] = "No arg string given to :addAlt()"
--[[Translation missing --]]
L["no characters called \"%s\" found; nothing deleted"] = "no characters called \"%s\" found; nothing deleted"
--[[Translation missing --]]
L["No Guild Greet database found"] = "No Guild Greet database found"
--[[Translation missing --]]
L["No main name suPLied to link %s to"] = "No main name suPLied to link %s to"
--[[Translation missing --]]
L["No main name supplied to link %s to"] = "No main name supplied to link %s to"
--[[Translation missing --]]
L["no matches found"] = "no matches found"
--[[Translation missing --]]
L["quiet"] = "Be quiet"
--[[Translation missing --]]
L["quiet_desc"] = "Whether to report to the chat frame or not."
--[[Translation missing --]]
L["quiet_name"] = "quiet_name"
L["Right"] = "Droite"
--[[Translation missing --]]
L["Search the list of linked characters for matching main or alt names."] = "Search the list of linked characters for matching main or alt names."
--[[Translation missing --]]
L["searched for: %s - total matches: %s"] = "searched for: %s - total matches: %s"
--[[Translation missing --]]
L["Show alts in tooltip"] = "Show alts in tooltip"
--[[Translation missing --]]
L["Show main in tooltip"] = "Show main in tooltip"
--[[Translation missing --]]
L["Start"] = "Start"
--[[Translation missing --]]
L["The colour of an alt's main name that will be displayed"] = "The colour of an alt's main name that will be displayed"
--[[Translation missing --]]
L["Use class colour (from the PlayerNames module)"] = "Use class colour (from the PlayerNames module)"
--[[Translation missing --]]
L["use class colour of alt"] = "use class colour of alt"
--[[Translation missing --]]
L["use class colour of main"] = "use class colour of main"
--[[Translation missing --]]
L["Use LibAlts Data"] = "Use LibAlts Data"
--[[Translation missing --]]
L["Use the data available via the shared alt information library."] = "Use the data available via the shared alt information library."
--[[Translation missing --]]
L["Various ways to import a main's alts from other addons"] = "Various ways to import a main's alts from other addons"
--[[Translation missing --]]
L["warning: alt %s already linked to %s"] = "warning: alt %s already linked to %s"
--[[Translation missing --]]
L["Where to display a character's main name when on their alt."] = "Where to display a character's main name when on their alt."
--[[Translation missing --]]
L["Whether to report to the chat frame or not."] = "Whether to report to the chat frame or not."
--[[Translation missing --]]
L["You are not in a guild"] = "You are not in a guild"
--[[Translation missing --]]
L["You have not yet linked any alts with their mains."] = "You have not yet linked any alts with their mains."

	  PL:AddLocale("frFR",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%d Alternativen gefunden für %s: %s"
L["%s alts imported from LOKWhoIsWho"] = "%s Alternativen importiert von LOKWhoIsWho"
L["%s total alts linked to mains"] = "%s Gesamtalternativen im Zusammenhang mit Haupt-Charakteren verknüpft"
L["(.-)'s? [Aa]lt"] = " %f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]s [Aa]lt"
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]s [Aa]lt"
L[".*[Aa]lts?$"] = true
L[".*[Tt]wink.*$"] = true
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<Alt.Name> (z.b. /alternative Namen gelöscht, Personvonderdudachtest, sieseieineAlternative, aberwirklichnichtist)"
L["<main> (eg /altnames listalts Fin)"] = "<Haupt->  (z.b. /alternative Namen Liste)"
L["<search term> (eg, /altnames find fin)"] = "<Suchbegriff> (z.b. /alternative Namen finden)"
L["Alt"] = "Alternative"
L["alt"] = "alternative"
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "Alternativname existiert: %s -> %s; nicht wie in den Einstellungen festgelegt überschreiben"
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt von %f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]"
L["AltNames"] = "Alternative Namen"
L["Alts:"] = "Alternativen:"
L["autoguildalts_desc"] = "Führe den Import aus dem Gildenplan automatisch aus"
L["autoguildalts_name"] = "Alternative Gilde automatisch importieren"
L["Be quiet"] = "Stumm schalten"
L["character removed: %s"] = "Charakter entfernt: %s"
L["Class colour"] = "Klassenfarbe"
L["Clear all"] = "Alle löschen"
L["Clear all links between alts and main names."] = "Löscht alle Verknüpfungen zwischen Alternativen und Hauptnamen."
L["Colour"] = "Farbe"
L["Delete a character's link to another character as their main."] = "Die Verknüpfung eines Charakters zu einem anderen (Haupt-)Charakter löschen."
L["Delete alt"] = "Alternative löschen"
L["Disabled"] = "Inaktiv"
L["Display a player's alts in the tooltip"] = "Zeigt die Alternativen eines Spielers im Tooltip an"
L["Display a player's main name in the tooltip"] = "Den Namen des Hauptcharakters eines Spielers im Tooltip anzeigen."
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Namen der Hauptcharaktere in Klassenfarbe des Alts anzeigen (Daten werden vom Modul PlayerNames geliefert, falls aktiviert)."
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Namen der Hauptcharaktere in Klassenfarbe des Hauptcharakters anzeigen (Daten werden vom Modul PlayerNames geliefert, falls aktiviert)."
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Vorhandenen Alt nicht überschreiben <-> Verknüpfungen zu Hauptcharakteren während des Imports oder des Hinzufügens von neuen Alts."
L["Don't overwrite existing links"] = "Überschreibe keine vorhandenen Links"
L["don't use"] = "Nicht verwenden"
L["Don't use data from the PlayerNames module at all"] = "Daten vom Modul SpielerNamen nicht verwenden."
L["ERROR: some function sent a blank message!"] = "FEHLER: Eine Funktion hat eine leere Nachricht gesendet!"
L["Find characters"] = "Charaktersuche"
L["Fix alts"] = "Alternativen reparieren"
L["Fix corrupted entries in your list of alt names."] = "Korrigiert beschädigte Einträge in der Liste der Alternativnamen."
L["Found alt: %s => main: %s"] = "Alt gefunden: %s => Haupt: %s"
L["guild member alts found and imported: %s"] = "Alt-Chars eines Gildenmitglieds gefunden und importiert: %s"
L["Import from Guild Greet database"] = "Importiere von der Gilden-Begrüßungs-Datenbank"
L["Import from guild roster"] = "Importiere von Gildenliste"
L["Import options"] = "Import-Optionen"
L["Imports alt names from a Guild Greet database, if present"] = "Importiert Alt-Namen von einer Gilden-Begrüßungs-Datenbank, wenn vorhanden."
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Importiert Alt-Namen von der Gildenliste, indem Mitglieder mit dem Rang \"alt\" oder \"alts\", oder Gilden- und Gildenoffiziersnotizen wie \"<name>s alt\" geprüft werden."
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Importiert Daten von LOKWhoIsWho, wenn vorhanden (um diese Funktion verwenden zu können, kopiere deine Datei SavedVariablesLOKWhoIsWho.lua in den Prat-Ordner!)."
L["Left"] = "Links"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "Verknüpfe <alt-name> <hauptcharname> (z.B. /altnames link Fin Finjaderaltvonfin)"
L["Link alt"] = "Alt verknüpfen"
L["Link someone's alt character with the name of their main."] = "Jemandes Alt-Charakter mit dem Namen seines Hauptcharakters verknüpfen."
L["linked alt %s => %s"] = "Altchar verknüpft %s => %s"
L["List all"] = "Alle auflisten"
L["List all links between alts and their main names."] = "Alle Verknüpfungen zwischen Alts und deren Hauptchar-Namen auflisten."
L["List alts"] = "Alts auflisten"
L["List alts for a given character"] = "Alts eines bestimmten Charakters auflisten."
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho-Daten nicht gefunden"
L["LOKWhoIsWho import"] = "LOKWhoIsWho-Import"
L["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho.lua-Datei nicht gefunden, entschuldige."
L["Main"] = "Hauptchar"
L["main"] = "Hauptchar"
L["Main name position"] = "Position des Namens eines Hauptcharakters"
L["Main:"] = "Hauptchar:"
L["mainpos_desc"] = "Wo der Name eines Hauptchars dargestellt werden soll, wenn diese mit ihrem Alt-Char zocken."
L["mainpos_name"] = "Hauptchar-Name Position"
L["module_desc"] = "Erlaubt das Verknüpfen von Alt-Chars mit deren Hauptchars, was dann neben deren Namen angezeigt werden kann, wenn sie in Chat-Mitteilungen erscheinen (standard = aus)."
L["no alts found for character "] = "Keine Alternativen für Charakter gefunden"
L["no alts or mains found matching \"%s\""] = "Es wurden keine Alternativen oder Hauptcharaktere gefunden, die mit \"%s\" übereinstimmen"
L["No arg string given to :addAlt()"] = "Kein Parameter angegeben für: :addAlt()"
L["no characters called \"%s\" found; nothing deleted"] = "Es wurden keine Charaktere mit dem Namen \"%s\" gefunden; nichts gelöscht"
L["No Guild Greet database found"] = "Keine Gildenbegrüßungs-Datenbank gefunden"
L["No main name suPLied to link %s to"] = "Es wurde kein Hauptname für den Link zu %s angegeben"
L["No main name supplied to link %s to"] = "Kein Hauptcharname geliefert, mit dem %s verknüpft werden kann."
L["no matches found"] = "Keine Übereinstimmungen gefunden"
L["quiet"] = "Sei ruhig"
L["quiet_desc"] = "Ob Meldungen an den Chat-Rahmen gesendet werden oder nicht."
L["quiet_name"] = true
L["Right"] = "Rechts"
L["Search the list of linked characters for matching main or alt names."] = "Durchsuche die Liste der verknüpften Charaktere nach passenden Hauptchar- oder Altchar-Namen."
L["searched for: %s - total matches: %s"] = "Gesucht nach: %s - gesamte Übereinstimmungen: %s"
L["Show alts in tooltip"] = "Alts im Tooltip anzeigen"
L["Show main in tooltip"] = "Hauptchar im Tooltip anzeigen"
L["Start"] = "Starte"
L["The colour of an alt's main name that will be displayed"] = "Die Farbe des Hauptcharnamens eines Alts, der dargestellt wird."
L["Use class colour (from the PlayerNames module)"] = "Klassenfarbe verwenden (vom Modul \"PlayerNames\") "
L["use class colour of alt"] = "Klassenfarbe für Alt-Char verwenden."
L["use class colour of main"] = "Klassenfarbe des Hauptchars verwenden"
L["Use LibAlts Data"] = "Daten zu liberalen Alternativen benutzen"
L["Use the data available via the shared alt information library."] = "Verwende die vorhandenen Daten über die gemeinsam genutzte Alt-Informations-Sammlung."
L["Various ways to import a main's alts from other addons"] = "Verschiedene Möglichkeiten, wie man die Alts eines Hauptchars von anderen AddOns importieren kann."
L["warning: alt %s already linked to %s"] = "Warnung: Alt %s ist bereits mit %s verknüpft!"
L["Where to display a character's main name when on their alt."] = "Wo der Name eines Hauptcharakters angezeigt werden soll, wenn diese mit ihrem Alt-Char zocken."
L["Whether to report to the chat frame or not."] = "Ob Meldungen im Chatfenster erscheinen oder nicht."
L["You are not in a guild"] = "Du bist in keiner Gilde"
L["You have not yet linked any alts with their mains."] = "Bisher hast du keine Alt-Chars mit ihren Hauptchars verknüpft."

	  PL:AddLocale("deDE",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%2$s의 부 캐릭터 %1$d개 찾음: %3$s"
L["%s alts imported from LOKWhoIsWho"] = "LOKWhoIsWho에서 %s 부 캐릭터를 가져왔습니다"
L["%s total alts linked to mains"] = "총 %s개의 부 캐릭터가 주 캐릭터와 연결되었습니다"
L["(.-)'s? [Aa]lt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]의 부캐릭터"
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]의 부 캐릭터"
L[".*[Aa]lts?$"] = ".*부캐릭터?$"
L[".*[Tt]wink.*$"] = ".*렙업.*$"
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<부 캐릭터 이름> (예, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"
L["<main> (eg /altnames listalts Fin)"] = "<주 캐릭터> (예 /altnames listalts Fin)"
L["<search term> (eg, /altnames find fin)"] = "<검색 구문> (예, /altnames find fin)"
L["Alt"] = "부 캐릭터"
L["alt"] = "부 캐릭터"
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "부 캐릭터 이름 존재: %s -> %s; 우선권 설정으로 덮어쓰지 않았습니다"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = "부 캐릭터 이름 [AltNames]"
L["Alts:"] = "부 캐릭터:"
L["autoguildalts_desc"] = "자동으로 길드 명단에서 가져오기 명령을 실행합니다"
L["autoguildalts_name"] = "자동 길드 부 캐릭터 가져오기"
L["Be quiet"] = "조용하게"
L["character removed: %s"] = "캐릭터 제거됨: %s"
L["Class colour"] = "직업 색상"
L["Clear all"] = "모두 지우기"
L["Clear all links between alts and main names."] = "부 캐릭터와 주 캐릭터 이름 사이의 모든 연결을 지웁니다."
L["Colour"] = "색상"
L["Delete a character's link to another character as their main."] = "주 캐릭터로 연결된 다른 캐릭터와의 연결을 삭제합니다."
L["Delete alt"] = "부 캐릭터 삭제"
L["Disabled"] = "비활성"
L["Display a player's alts in the tooltip"] = "툴팁에 플레이어의 부 캐릭터 표시하기"
L["Display a player's main name in the tooltip"] = "툴팁에 플레이어의 주 캐릭터 이름 표시하기"
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "부 캐릭터의 직업과 같은 색상으로 주 캐릭터 이름 표시하기 (플레이어 이름 모듈을 사용 중이면 모듈에서 데이터를 가져옵니다)"
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "주 캐릭터의 직업과 같은 색상으로 주 캐릭터 이름 표시하기 (플레이어 이름 모듈을 사용 중이면 모듈에서 데이터를 가져옵니다)"
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "새로운 부 캐릭터를 추가하거나 가져올 때 저장된 부 캐릭터 <-> 주 캐릭터 간 연결을 덮어쓰지 않습니다."
L["Don't overwrite existing links"] = "저장된 연결을 덮어쓰지 않기"
L["don't use"] = "사용하지 않음"
L["Don't use data from the PlayerNames module at all"] = "플레이어 이름 모듈의 데이터 사용하지 않기"
L["ERROR: some function sent a blank message!"] = "오류: 몇몇 함수가 빈 메시지를 보냈습니다!"
L["Find characters"] = "캐릭터 찾기"
L["Fix alts"] = "부 캐릭터 고치기"
L["Fix corrupted entries in your list of alt names."] = "당신의 부 캐릭터 이름 목록에서 잘못된 목록을 수정합니다."
L["Found alt: %s => main: %s"] = "부 캐릭터 발견: %s => 주 캐릭터: %s"
L["guild member alts found and imported: %s"] = "길드원의 부 캐릭터를 발견하고 가져옴: %s"
L["Import from Guild Greet database"] = "길드 쪽지 데이터베이스에서 가져오기"
L["Import from guild roster"] = "길드 명단에서 가져오기"
L["Import options"] = "옵션 가져오기"
L["Imports alt names from a Guild Greet database, if present"] = "길드 쪽지 데이터베이스에서 부 캐릭터 이름이 있으면 가져옵니다"
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "\"부캐\"나 \"부캐릭터\" 등급, 또는 \"<이름>의 부캐\"같은 길드 / 관리자 쪽지를 확인하여 길드 명단에서 부 캐릭터 이름을 가져옵니다"
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "존재한다면 LOKWhoIsWho에서 데이터를 가져옵니다 (SavedVariables\\LOKWhoIsWho.lua 파일을 Prat 디렉토리에 복사해야 사용 가능함)."
L["Left"] = "왼쪽"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <부 캐릭터 이름> <주 캐릭터 이름> (예, /altnames link Fin Finjathealtoffin)"
L["Link alt"] = "부 캐릭터 연결하기"
L["Link someone's alt character with the name of their main."] = "누군가의 부 캐릭터를 그의 주 캐릭터 이름과 연결시킵니다."
L["linked alt %s => %s"] = "부 캐릭터 연결됨 %s => %s"
L["List all"] = "모든 목록"
L["List all links between alts and their main names."] = "부 캐릭터와 주 캐릭터 이름 사이의 모든 연결 목록입니다."
L["List alts"] = "부 캐릭터 목록"
L["List alts for a given character"] = "주어진 캐릭터의 부 캐릭터 목록"
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho 데이터 찾을 수 없음"
L["LOKWhoIsWho import"] = "LOKWhoIsWho 가져오기"
L["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho lua 파일 찾을 수 없음."
L["Main"] = "주 캐릭터"
L["main"] = "주 캐릭터"
L["Main name position"] = "주 캐릭터 이름 위치"
L["Main:"] = "주 캐릭터:"
L["mainpos_desc"] = "부 캐릭터에 접속 중일 때 주 캐릭터의 이름을 표시할 곳"
L["mainpos_name"] = "주 캐릭터 이름 위치"
L["module_desc"] = "사람들의 부 캐릭터를 그들의 주 캐릭터와 연결합니다, 대화 메시지에서 발견됐을 때 그들의 이름 다음에 표시되게 할 수 있습니다 (기본값=끔)."
L["no alts found for character "] = "캐릭터의 부 캐릭터 찾을 수 없음"
L["no alts or mains found matching \"%s\""] = "\"%s\"|1과;와; 일치하는 부 캐릭터나 주 캐릭터를 찾을 수 없음"
L["No arg string given to :addAlt()"] = ":addAlt()에 변수 구문이 주어지지 않았습니다"
L["no characters called \"%s\" found; nothing deleted"] = "요청한 \"%s\" 캐릭터 찾을 수 없음; 삭제하지 못함"
L["No Guild Greet database found"] = "길드 쪽지 데이터베이스 찾을 수 없음"
L["No main name suPLied to link %s to"] = "%s|1을;를; 연결할 기본 이름이 없습니다."
L["No main name supplied to link %s to"] = "%s|1과;와; 연결할 주 캐릭터 이름 제공되지 않음"
L["no matches found"] = "일치 하는 것 없음"
L["quiet"] = "조용하게"
L["quiet_desc"] = "대화창에 보고할 지 안할 지 설정합니다."
L["quiet_name"] = true
L["Right"] = "오른쪽"
L["Search the list of linked characters for matching main or alt names."] = "주 캐릭터나 부 캐릭터 이름이 일치하는 연결된 캐릭터의 목록을 검색합니다."
L["searched for: %s - total matches: %s"] = "검색: %s - 총 일치: %s"
L["Show alts in tooltip"] = "툴팁에 부 캐릭터 표시"
L["Show main in tooltip"] = "툴팁에 주 캐릭터 표시"
L["Start"] = "시작"
L["The colour of an alt's main name that will be displayed"] = "표시할 주 캐릭터 이름의 색상"
L["Use class colour (from the PlayerNames module)"] = "직업 색상 사용 (플레이어 이름 모듈로부터)"
L["use class colour of alt"] = "부 캐릭터의 직업 색상 사용"
L["use class colour of main"] = "주 캐릭터의 직업 색상 사용"
L["Use LibAlts Data"] = "LibAlts 데이터 사용"
L["Use the data available via the shared alt information library."] = "공유된 부 캐릭터 정보 라이브러리를 통해 이용 가능한 데이터를 사용합니다."
L["Various ways to import a main's alts from other addons"] = "다른 애드온에서 주 캐릭터의 부 캐릭터들을 가져올 다양한 방법들"
L["warning: alt %s already linked to %s"] = "경고: 부 캐릭터 %s|1은;는; 이미 %s|1과;와; 연결됨"
L["Where to display a character's main name when on their alt."] = "부 캐릭터에 접속 중일 때 주 캐릭터의 이름을 표시할 곳"
L["Whether to report to the chat frame or not."] = "대화창에 보고 여부"
L["You are not in a guild"] = "당신은 길드에 속해 있지 않습니다"
L["You have not yet linked any alts with their mains."] = "아직 주 캐릭터에 연결한 부 캐릭터가 없습니다."

	  PL:AddLocale("koKR",L)


  L = {}
  -- AltNames
--[[Translation missing --]]
L["%d alts found for %s: %s"] = "%d alts found for %s: %s"
--[[Translation missing --]]
L["%s alts imported from LOKWhoIsWho"] = "%s alts imported from LOKWhoIsWho"
--[[Translation missing --]]
L["%s total alts linked to mains"] = "%s total alts linked to mains"
--[[Translation missing --]]
L["(.-)'s? [Aa]lt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
--[[Translation missing --]]
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]'s [Aa]lt"
--[[Translation missing --]]
L[".*[Aa]lts?$"] = ".*[Aa]lts?$"
--[[Translation missing --]]
L[".*[Tt]wink.*$"] = ".*[Tt]wink.*$"
--[[Translation missing --]]
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"
--[[Translation missing --]]
L["<main> (eg /altnames listalts Fin)"] = "<main> (eg /altnames listalts Fin)"
--[[Translation missing --]]
L["<search term> (eg, /altnames find fin)"] = "<search term> (eg, /altnames find fin)"
--[[Translation missing --]]
L["Alt"] = "Alt"
--[[Translation missing --]]
L["alt"] = "alt"
--[[Translation missing --]]
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "alt name exists: %s -> %s; not overwriting as set in preferences"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
--[[Translation missing --]]
L["AltNames"] = "AltNames"
--[[Translation missing --]]
L["Alts:"] = "Alts:"
--[[Translation missing --]]
L["autoguildalts_desc"] = "Automatically run the import from guild roster command silently"
--[[Translation missing --]]
L["autoguildalts_name"] = "Auto Import Guild Alts"
--[[Translation missing --]]
L["Be quiet"] = "Be quiet"
--[[Translation missing --]]
L["character removed: %s"] = "character removed: %s"
--[[Translation missing --]]
L["Class colour"] = "Class colour"
--[[Translation missing --]]
L["Clear all"] = "Clear all"
--[[Translation missing --]]
L["Clear all links between alts and main names."] = "Clear all links between alts and main names."
--[[Translation missing --]]
L["Colour"] = "Colour"
--[[Translation missing --]]
L["Delete a character's link to another character as their main."] = "Delete a character's link to another character as their main."
--[[Translation missing --]]
L["Delete alt"] = "Delete alt"
--[[Translation missing --]]
L["Disabled"] = "Disabled"
--[[Translation missing --]]
L["Display a player's alts in the tooltip"] = "Display a player's alts in the tooltip"
--[[Translation missing --]]
L["Display a player's main name in the tooltip"] = "Display a player's main name in the tooltip"
--[[Translation missing --]]
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"
--[[Translation missing --]]
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"
--[[Translation missing --]]
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Don't overwrite existing alt <-> main links when importing or adding new alts."
--[[Translation missing --]]
L["Don't overwrite existing links"] = "Don't overwrite existing links"
--[[Translation missing --]]
L["don't use"] = "don't use"
--[[Translation missing --]]
L["Don't use data from the PlayerNames module at all"] = "Don't use data from the PlayerNames module at all"
--[[Translation missing --]]
L["ERROR: some function sent a blank message!"] = "ERROR: some function sent a blank message!"
--[[Translation missing --]]
L["Find characters"] = "Find characters"
--[[Translation missing --]]
L["Fix alts"] = "Fix alts"
--[[Translation missing --]]
L["Fix corrupted entries in your list of alt names."] = "Fix corrupted entries in your list of alt names."
--[[Translation missing --]]
L["Found alt: %s => main: %s"] = "Found alt: %s => main: %s"
--[[Translation missing --]]
L["guild member alts found and imported: %s"] = "guild member alts found and imported: %s"
--[[Translation missing --]]
L["Import from Guild Greet database"] = "Import from Guild Greet database"
--[[Translation missing --]]
L["Import from guild roster"] = "Import from guild roster"
--[[Translation missing --]]
L["Import options"] = "Import options"
--[[Translation missing --]]
L["Imports alt names from a Guild Greet database, if present"] = "Imports alt names from a Guild Greet database, if present"
--[[Translation missing --]]
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""
--[[Translation missing --]]
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."
--[[Translation missing --]]
L["Left"] = "Left"
--[[Translation missing --]]
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"
--[[Translation missing --]]
L["Link alt"] = "Link alt"
--[[Translation missing --]]
L["Link someone's alt character with the name of their main."] = "Link someone's alt character with the name of their main."
--[[Translation missing --]]
L["linked alt %s => %s"] = "linked alt %s => %s"
--[[Translation missing --]]
L["List all"] = "List all"
--[[Translation missing --]]
L["List all links between alts and their main names."] = "List all links between alts and their main names."
--[[Translation missing --]]
L["List alts"] = "List alts"
--[[Translation missing --]]
L["List alts for a given character"] = "List alts for a given character"
--[[Translation missing --]]
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho data not found"
--[[Translation missing --]]
L["LOKWhoIsWho import"] = "LOKWhoIsWho import"
--[[Translation missing --]]
L["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho lua file not found, sorry."
--[[Translation missing --]]
L["Main"] = "Main"
--[[Translation missing --]]
L["main"] = "main"
--[[Translation missing --]]
L["Main name position"] = "Main name position"
--[[Translation missing --]]
L["Main:"] = "Main:"
--[[Translation missing --]]
L["mainpos_desc"] = "Where to display a character's main name when on their alt."
--[[Translation missing --]]
L["mainpos_name"] = "Main name position"
--[[Translation missing --]]
L["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off)."
--[[Translation missing --]]
L["no alts found for character "] = "no alts found for character "
--[[Translation missing --]]
L["no alts or mains found matching \"%s\""] = "no alts or mains found matching \"%s\""
--[[Translation missing --]]
L["No arg string given to :addAlt()"] = "No arg string given to :addAlt()"
--[[Translation missing --]]
L["no characters called \"%s\" found; nothing deleted"] = "no characters called \"%s\" found; nothing deleted"
--[[Translation missing --]]
L["No Guild Greet database found"] = "No Guild Greet database found"
--[[Translation missing --]]
L["No main name suPLied to link %s to"] = "No main name suPLied to link %s to"
--[[Translation missing --]]
L["No main name supplied to link %s to"] = "No main name supplied to link %s to"
--[[Translation missing --]]
L["no matches found"] = "no matches found"
--[[Translation missing --]]
L["quiet"] = "Be quiet"
--[[Translation missing --]]
L["quiet_desc"] = "Whether to report to the chat frame or not."
--[[Translation missing --]]
L["quiet_name"] = "quiet_name"
--[[Translation missing --]]
L["Right"] = "Right"
--[[Translation missing --]]
L["Search the list of linked characters for matching main or alt names."] = "Search the list of linked characters for matching main or alt names."
--[[Translation missing --]]
L["searched for: %s - total matches: %s"] = "searched for: %s - total matches: %s"
--[[Translation missing --]]
L["Show alts in tooltip"] = "Show alts in tooltip"
--[[Translation missing --]]
L["Show main in tooltip"] = "Show main in tooltip"
--[[Translation missing --]]
L["Start"] = "Start"
--[[Translation missing --]]
L["The colour of an alt's main name that will be displayed"] = "The colour of an alt's main name that will be displayed"
--[[Translation missing --]]
L["Use class colour (from the PlayerNames module)"] = "Use class colour (from the PlayerNames module)"
--[[Translation missing --]]
L["use class colour of alt"] = "use class colour of alt"
--[[Translation missing --]]
L["use class colour of main"] = "use class colour of main"
--[[Translation missing --]]
L["Use LibAlts Data"] = "Use LibAlts Data"
--[[Translation missing --]]
L["Use the data available via the shared alt information library."] = "Use the data available via the shared alt information library."
--[[Translation missing --]]
L["Various ways to import a main's alts from other addons"] = "Various ways to import a main's alts from other addons"
--[[Translation missing --]]
L["warning: alt %s already linked to %s"] = "warning: alt %s already linked to %s"
--[[Translation missing --]]
L["Where to display a character's main name when on their alt."] = "Where to display a character's main name when on their alt."
--[[Translation missing --]]
L["Whether to report to the chat frame or not."] = "Whether to report to the chat frame or not."
--[[Translation missing --]]
L["You are not in a guild"] = "You are not in a guild"
--[[Translation missing --]]
L["You have not yet linked any alts with their mains."] = "You have not yet linked any alts with their mains."

	  PL:AddLocale("esMX",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%d альтов найдено для %s: %s"
L["%s alts imported from LOKWhoIsWho"] = "Импортировано альтов из LOKWhoIsWho: %s"
L["%s total alts linked to mains"] = "всего альтов связано с основным %s"
L["(.-)'s? [Aa]lt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Аа]льт"
L["([^%s%p%d%c%z]+)'s alt"] = "[Аа]льт %f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]"
L[".*[Aa]lts?$"] = ".*[Аа]льты?$"
L[".*[Tt]wink.*$"] = ".*[Тв]инк.*$"
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<имя альта> (к примеру, /altnames del Загзаг)"
L["<main> (eg /altnames listalts Fin)"] = "<основной> (к примеру: /altnames listalts Загзаг)"
L["<search term> (eg, /altnames find fin)"] = "<элемент поиска> (к примеру, /altnames find Загзаг)"
L["Alt"] = "Альт"
L["alt"] = "альт"
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "имя альта уже существует: %s -> %s; перезапись запрещена настройками"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = "Имя альтов"
L["Alts:"] = "Альты:"
L["autoguildalts_desc"] = "Автоматически и без отчета выполнять команду импорта из списка гильдии"
L["autoguildalts_name"] = "Авто-импорт альтов гильдии"
L["Be quiet"] = "Молчи"
L["character removed: %s"] = "персонаж удалён: %s"
L["Class colour"] = "Окраска по классу"
L["Clear all"] = "Очистить все"
L["Clear all links between alts and main names."] = "Очистить все ссылки между альтами и основными именами."
L["Colour"] = "Цвет"
L["Delete a character's link to another character as their main."] = "Удалить ссылку персонажа на другого персонажа если он основной."
L["Delete alt"] = "Удалить альта"
L["Disabled"] = "Отключено"
L["Display a player's alts in the tooltip"] = "Отображать альтов игрока в подсказке"
L["Display a player's main name in the tooltip"] = "Отображать основных персонажей игрока в подсказке"
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Отображать имена основного персонажа по классу альта (данные берутся из модуля PlayerNames, если он включен)"
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Отображать имена основного персонажа по его основному классу (данные берутся из модуля PlayerNames, если он включен)"
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Не перезаписывать существующии связки альтов <-> основных при импортировании или добавлении нового."
L["Don't overwrite existing links"] = "Не перезаписывать существующие связки"
L["don't use"] = "не окрашивать"
L["Don't use data from the PlayerNames module at all"] = "Не использовать для всех данные из модуля PlayerNames"
L["ERROR: some function sent a blank message!"] = "ОШИБКА: одна из функций послала пустое сообщение!"
L["Find characters"] = "Найти персонажи"
L["Fix alts"] = "Исправить альтов"
L["Fix corrupted entries in your list of alt names."] = "Исправить неправельные записи в вашем списке имен альтов."
L["Found alt: %s => main: %s"] = "Альт найден: %s => основной: %s"
L["guild member alts found and imported: %s"] = "%s: найдено альтов участников гильдии и импортированно"
L["Import from Guild Greet database"] = "Импорт базы данных Guild Greet"
L["Import from guild roster"] = "Импорт из списка гильдии"
L["Import options"] = "Настройки импорта"
L["Imports alt names from a Guild Greet database, if present"] = "Импорт альтов из базы данных Guild Greet, если есть"
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Импорт имен альтов из списка гильдии определяя участника по званию \"alt\" или \"alts\", или общие / офицерские заметки типо \"<name> alt\""
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Импортировать данные из LOKWhoIsWho, если есть (перекиньте ваш SavedVariables/LOKWhoIsWho.lua в папку Pratа для использования)."
L["Left"] = "Слева"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <имя альта> <имя основного> (пример, /altnames link Загзаг Загзаговичюс)"
L["Link alt"] = "Связать альта"
L["Link someone's alt character with the name of their main."] = "Связать определённого альта с именем его основного персонажа."
L["linked alt %s => %s"] = "альт %s связан с => %s"
L["List all"] = "Весь список"
L["List all links between alts and their main names."] = "Весь список ссылок между альтами и основными именами."
L["List alts"] = "Список альтов"
L["List alts for a given character"] = "Список альтов для заданных персонажей"
L["LOKWhoIsWho data not found"] = "Данные LOKWhoIsWho не найдены"
L["LOKWhoIsWho import"] = "Импорт из LOKWhoIsWho"
L["LOKWhoIsWho lua file not found, sorry."] = "Lua файл LOKWhoIsWho не найден, извените."
L["Main"] = "Основной"
L["main"] = "основной"
L["Main name position"] = "Позиция основного имени"
L["Main:"] = "Основной:"
L["mainpos_desc"] = "Где отображать имя главного персонажа если он на альте."
L["mainpos_name"] = "Позиция основного имени"
L["module_desc"] = "Позволяет привязывать имена альтов к именам основных персонажей, а потом отображать их рядом в сообщениях в чате (по умолчанию=выключено)."
L["no alts found for character "] = "не найдено альтов для персонажа"
L["no alts or mains found matching \"%s\""] = "совпавших альтов или основных \"%s\""
L["No arg string given to :addAlt()"] = "Не задано значение строки для: :addAlt()"
L["no characters called \"%s\" found; nothing deleted"] = "не найден персонаж по имени \"%s\"; нечего удалять"
L["No Guild Greet database found"] = "База данных Guild Greet не найдена"
L["No main name suPLied to link %s to"] = "Нет основного имени, чтобы связать %s с"
L["No main name supplied to link %s to"] = "Не предоставлено основное имя для связки %s к"
L["no matches found"] = "совпадений не найдено"
L["quiet"] = "тихий"
L["quiet_desc"] = "Отчитываться о действиях в чат или нет."
L["quiet_name"] = true
L["Right"] = "Справа"
L["Search the list of linked characters for matching main or alt names."] = "Поиск в списке связанных персонажей."
L["searched for: %s - total matches: %s"] = "поиск для: %s - всего совподений: %s"
L["Show alts in tooltip"] = "Альты в подсказке"
L["Show main in tooltip"] = "Основные в подсказке"
L["Start"] = "Начать"
L["The colour of an alt's main name that will be displayed"] = "Отображать цвет имени альта по основному персонажу"
L["Use class colour (from the PlayerNames module)"] = "Использовать окраску по цвету класса (из модуля PlayerNames)"
L["use class colour of alt"] = "цвета класса для альтов"
L["use class colour of main"] = "цвета класса для основных"
L["Use LibAlts Data"] = "Использовать LibAlts"
L["Use the data available via the shared alt information library."] = "Использовать данные посредством совместно используемой библиотеки информации об альтах."
L["Various ways to import a main's alts from other addons"] = "Различные варианты импорта альтов основных персонажей из других аддонов"
L["warning: alt %s already linked to %s"] = "внимание: альт %s уже связан с %s"
L["Where to display a character's main name when on their alt."] = "Где отображать имя главного персонажа если он на альте."
L["Whether to report to the chat frame or not."] = "Сообщать в чат или нет."
L["You are not in a guild"] = "Вы не состоитев гильдии"
L["You have not yet linked any alts with their mains."] = "Вы еще не связали не одного альта с их основными."

	  PL:AddLocale("ruRU",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%d 马甲找到 %s: %s"
L["%s alts imported from LOKWhoIsWho"] = "%s马甲从LOKWhoIsWho导入"
L["%s total alts linked to mains"] = "%s全部马甲联结到本尊"
L["(.-)'s? [Aa]lt"] = true
L["([^%s%p%d%c%z]+)'s alt"] = true
L[".*[Aa]lts?$"] = true
--[[Translation missing --]]
L[".*[Tt]wink.*$"] = ".*[Tt]wink.*$"
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<马甲名称> (例, /altnames del 某个你以为是但不是的某人分身)"
L["<main> (eg /altnames listalts Fin)"] = "<本尊> (例 /altnames listalts 顶尖战士)"
L["<search term> (eg, /altnames find fin)"] = "<搜索条件>(例, /altnames find 顶尖战士)"
L["Alt"] = "马甲"
L["alt"] = "马甲"
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "马甲名称存在: %s -> %s;没有覆盖参数设置"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = "马甲名称"
L["Alts:"] = "马甲:"
L["autoguildalts_desc"] = [=[后台自动从公会信息中导入
]=]
L["autoguildalts_name"] = "自动导入公会名"
L["Be quiet"] = "禁言"
L["character removed: %s"] = "删除角色: %s"
L["Class colour"] = "职业颜色"
L["Clear all"] = "全部清除"
L["Clear all links between alts and main names."] = "清除所有马甲与本尊名称间的联结"
L["Colour"] = "颜色"
L["Delete a character's link to another character as their main."] = "删除一个角色作为另一个角色本尊的联结"
L["Delete alt"] = "删除马甲"
L["Disabled"] = "禁用"
L["Display a player's alts in the tooltip"] = "在提示里显示玩家的马甲名称"
L["Display a player's main name in the tooltip"] = "在提示里显示玩家的本尊名称"
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "用和马甲职业相同的颜色显示本尊名称(如果玩家名称模块启用,从中采集数据)"
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "用和本尊职业相同的颜色显示本尊名称(如果玩家名称模块启用,从中采集数据)"
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "不要在导入或添加新马甲时覆盖已有的马甲 <-> 本尊"
L["Don't overwrite existing links"] = "不要覆盖已有联结"
L["don't use"] = "不使用"
L["Don't use data from the PlayerNames module at all"] = "不要从玩家名称模块使用数据"
L["ERROR: some function sent a blank message!"] = "错误:一些参数发送了一条空白信息!"
L["Find characters"] = "发现角色"
L["Fix alts"] = "修复马甲"
L["Fix corrupted entries in your list of alt names."] = "在你的马甲名称列表里修复损坏的条目"
L["Found alt: %s => main: %s"] = "发现马甲: %s => 本尊: %s"
L["guild member alts found and imported: %s"] = "公会成员马甲发现并导入: %s"
L["Import from Guild Greet database"] = "从公会欢迎数据库导入"
L["Import from guild roster"] = "从工会名单导入"
L["Import options"] = "导入选项"
L["Imports alt names from a Guild Greet database, if present"] = "导入马甲名称从公会欢迎数据库,如果可以"
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "导入马甲名称从公会名单中检查到的成员头衔为“马甲”或“马甲们”的,或者公会官员备注为\"<某某>的马甲\""
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "从LOKWhoIsWho导入数据,如果可以(你的Prat目录丢失SavedVariables\\LOKWhoIsWho.lua可以使用这个)."
L["Left"] = "左边"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "联结 <马甲名称> <本尊名称>(例,/altnames link 顶尖战士 苍天哥)"
L["Link alt"] = "联结马甲"
L["Link someone's alt character with the name of their main."] = "联结某人的马甲角色与他们的本尊名称"
L["linked alt %s => %s"] = "联结的马甲 %s => %s"
L["List all"] = "全部列出"
L["List all links between alts and their main names."] = "列出所有马甲与他们的本尊名称间的联结"
L["List alts"] = "列出马甲"
L["List alts for a given character"] = "列出特定角色的马甲"
L["LOKWhoIsWho data not found"] = "未发现LOKWhoIsWho数据"
L["LOKWhoIsWho import"] = "LOKWhoIsWho导入"
L["LOKWhoIsWho lua file not found, sorry."] = "未发现LOKWhoIsWho权限文件,息怒"
L["Main"] = "本尊"
L["main"] = "本尊"
L["Main name position"] = "本尊名称位置"
L["Main:"] = "本尊:"
L["mainpos_desc"] = "当角色在马甲上时本尊名称的显示位置"
L["mainpos_name"] = "本尊名称位置"
L["module_desc"] = "把某人的马甲角色联结到他们的本尊,在聊天信息中的名字旁边显示(默认=关闭)."
L["no alts found for character "] = "未发现角色马甲"
L["no alts or mains found matching \"%s\""] = "未发现匹配\"%s\"马甲或本尊"
L["No arg string given to :addAlt()"] = "无字符串参数到:addAlt()"
L["no characters called \"%s\" found; nothing deleted"] = "未发现称作\"%s\"角色;无删除"
L["No Guild Greet database found"] = "未发现公会欢迎数据库"
--[[Translation missing --]]
L["No main name suPLied to link %s to"] = "No main name suPLied to link %s to"
L["No main name supplied to link %s to"] = "没有本尊名称以供联结%s"
L["no matches found"] = "无匹配发现"
L["quiet"] = "安静"
L["quiet_desc"] = "是否在聊天框报告"
L["quiet_name"] = "无声_名字"
L["Right"] = "右边"
L["Search the list of linked characters for matching main or alt names."] = "搜索已联结的角色列表匹配本尊或马甲名称"
L["searched for: %s - total matches: %s"] = "搜索: %s - 完全匹配: %s"
L["Show alts in tooltip"] = "在提示里显示马甲"
L["Show main in tooltip"] = "在提示里显示本尊"
L["Start"] = "起始"
L["The colour of an alt's main name that will be displayed"] = "马甲的本尊名称将显示的颜色"
L["Use class colour (from the PlayerNames module)"] = "使用职业颜色(从玩家名称模块)"
L["use class colour of alt"] = "马甲职业的颜色"
L["use class colour of main"] = "本尊职业的颜色"
L["Use LibAlts Data"] = "使用LibAlts数据"
L["Use the data available via the shared alt information library."] = "使数据可通过共享的马甲信息库"
L["Various ways to import a main's alts from other addons"] = "用各种途径从其他插件导入本尊的马甲"
L["warning: alt %s already linked to %s"] = "注意:马甲%s已联结到%s"
L["Where to display a character's main name when on their alt."] = "当角色在马甲上时本尊名称显示何处"
L["Whether to report to the chat frame or not."] = "是否报告在聊天框"
L["You are not in a guild"] = "你不在一个公会里"
L["You have not yet linked any alts with their mains."] = "尚未有任何马甲联结到他们的本尊"

	  PL:AddLocale("zhCN",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%d alternativos encontrados para %s: %s"
L["%s alts imported from LOKWhoIsWho"] = "%s alternativos importados desde LOKWhoIsWho"
L["%s total alts linked to mains"] = "alternativos total %s vinculados a principales"
L["(.-)'s? [Aa]lt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt"
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt"
L[".*[Aa]lts?$"] = true
--[[Translation missing --]]
L[".*[Tt]wink.*$"] = ".*[Tt]wink.*$"
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<nombre alt> (ej, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"
L["<main> (eg /altnames listalts Fin)"] = "<principal> (ej /altnames listalts Fin)"
L["<search term> (eg, /altnames find fin)"] = "<término búsqueda> (ej, /altnames find fin)"
L["Alt"] = true
L["alt"] = true
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "existe el nombre alternativo: %s -> %s; sin sobrescribir como está establecido en las preferencias"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = "AltNombres"
L["Alts:"] = true
--[[Translation missing --]]
L["autoguildalts_desc"] = "Automatically run the import from guild roster command silently"
--[[Translation missing --]]
L["autoguildalts_name"] = "Auto Import Guild Alts"
L["Be quiet"] = "Silencio"
L["character removed: %s"] = "Personaje eliminado: %s"
L["Class colour"] = "Color Clase"
L["Clear all"] = "Limpiar todo"
L["Clear all links between alts and main names."] = "Borrar todos los enlaces entre nombres alternativos y principales."
L["Colour"] = "Color"
--[[Translation missing --]]
L["Delete a character's link to another character as their main."] = "Delete a character's link to another character as their main."
L["Delete alt"] = "Eliminar alternativo"
L["Disabled"] = "Desactivado"
L["Display a player's alts in the tooltip"] = "Mostrar los alters de los jugadores en el tooltip"
L["Display a player's main name in the tooltip"] = "Mostrar el nombre del main del jugador en el tooltip"
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Mostrar nombres de personajes principales (mains) en el mismo color que la clase del alter (obteniendo los datos del módulo PlayerNames si está habilitado)"
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Mostrar nombres principales en el mismo color que el de su clase principal (tomando los datos del módulo PlayerNames si está habilitado)"
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "No sobreescribir enlaces alternativo <-> principal existentes al importar o añadir nuevos alternativos."
L["Don't overwrite existing links"] = "No sobreescribir enlaces existentes"
L["don't use"] = "No utilizar"
L["Don't use data from the PlayerNames module at all"] = "No utilizar datos del módulo PlayerNames en absoluto"
L["ERROR: some function sent a blank message!"] = "ERROR: alguna función envió un mensaje en blanco!"
L["Find characters"] = "Encontrar caracteres"
L["Fix alts"] = "Arreglar alternativos"
L["Fix corrupted entries in your list of alt names."] = "Arreglar entradas corruptas en su lista de nombres alternativos."
L["Found alt: %s => main: %s"] = "Alternativo encontrado: %s => principal: %s"
L["guild member alts found and imported: %s"] = "Miembros de hermandad alternativos encontrados e importados: %s"
--[[Translation missing --]]
L["Import from Guild Greet database"] = "Import from Guild Greet database"
L["Import from guild roster"] = "Importar desde la lista de la hermandad"
L["Import options"] = "Opciones de Importación"
--[[Translation missing --]]
L["Imports alt names from a Guild Greet database, if present"] = "Imports alt names from a Guild Greet database, if present"
--[[Translation missing --]]
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Importa datos de LOKWhoIsWho, si está presente (colocar su SavedVariables\\LOKWhoIsWho.lua en el directorio Prat para poder usar este)."
L["Left"] = "Izquierda"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "enlace <nombre alt> <nombre principal> (ej, /nombrealt enlace Fin Finjathealtoffin)"
--[[Translation missing --]]
L["Link alt"] = "Link alt"
--[[Translation missing --]]
L["Link someone's alt character with the name of their main."] = "Link someone's alt character with the name of their main."
L["linked alt %s => %s"] = "alternativo enlazado %s => %s"
L["List all"] = "Listar todo"
L["List all links between alts and their main names."] = "Lista todos los enlaces entre alternativos y sus nombres principales."
L["List alts"] = "Lista alternativos"
L["List alts for a given character"] = "Lista alternativos para un personaje dado"
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho datos no encontrados"
L["LOKWhoIsWho import"] = "importar LOKWhoIsWho"
L["LOKWhoIsWho lua file not found, sorry."] = "LOKWhoIsWho archivo lua no encontrado, lo siento."
L["Main"] = "Principal"
L["main"] = "principal"
L["Main name position"] = "Posición del nombre principal"
L["Main:"] = "Principal:"
L["mainpos_desc"] = "Donde mostrar nombre principal de un personaje cuando es su alternativa."
L["mainpos_name"] = "Posición del nombre principal"
--[[Translation missing --]]
L["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off)."
L["no alts found for character "] = "sin alternativos encontrados para el personaje"
L["no alts or mains found matching \"%s\""] = "sin alternativos o principales coincidentes con \"%s\" encontrados"
L["No arg string given to :addAlt()"] = "Sin cadena de argumento dado a: addAlt()"
L["no characters called \"%s\" found; nothing deleted"] = "no se han encontrado personajes llamados \"%s\"; nada eliminado"
--[[Translation missing --]]
L["No Guild Greet database found"] = "No Guild Greet database found"
--[[Translation missing --]]
L["No main name suPLied to link %s to"] = "No main name suPLied to link %s to"
L["No main name supplied to link %s to"] = "Sin nombre principal proporcionado para el enlace %s"
L["no matches found"] = "Ninguna coincidencia encontrada"
L["quiet"] = "Silencioso"
L["quiet_desc"] = "Si desea informar al marco de chat o no."
--[[Translation missing --]]
L["quiet_name"] = "quiet_name"
L["Right"] = "Derecha"
--[[Translation missing --]]
L["Search the list of linked characters for matching main or alt names."] = "Search the list of linked characters for matching main or alt names."
L["searched for: %s - total matches: %s"] = "buscado: %s - total de coincidencias: %s"
L["Show alts in tooltip"] = "Muestra alternativos en ayuda contextual"
L["Show main in tooltip"] = "Mostrar principal en ayuda contextual"
L["Start"] = "Inicio"
--[[Translation missing --]]
L["The colour of an alt's main name that will be displayed"] = "The colour of an alt's main name that will be displayed"
L["Use class colour (from the PlayerNames module)"] = "Utilizar el color de clase (desde el módulo de NombresJugador)"
L["use class colour of alt"] = "utilizar color de clase de alt"
L["use class colour of main"] = "utilizar el color de la clase principal"
L["Use LibAlts Data"] = "Utiilizar Datos de LibAlts"
L["Use the data available via the shared alt information library."] = "Utilice los datos disponibles a través de la biblioteca compartida de información alternativa."
--[[Translation missing --]]
L["Various ways to import a main's alts from other addons"] = "Various ways to import a main's alts from other addons"
L["warning: alt %s already linked to %s"] = "advertencia: alt %s ya vinculado a %s"
--[[Translation missing --]]
L["Where to display a character's main name when on their alt."] = "Where to display a character's main name when on their alt."
L["Whether to report to the chat frame or not."] = "Si se debe reportar al marco de chat o no."
L["You are not in a guild"] = "No está en una hermandad"
L["You have not yet linked any alts with their mains."] = "Aún no ha vinculado algún alternativo con su principal."

	  PL:AddLocale("esES",L)


  L = {}
  -- AltNames
L["%d alts found for %s: %s"] = "%d 分身找到於 %s: %s"
L["%s alts imported from LOKWhoIsWho"] = "%s 分身匯入來自 LOKWhoIsWho"
L["%s total alts linked to mains"] = "%s 總分身連結本尊"
L["(.-)'s? [Aa]lt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt"
L["([^%s%p%d%c%z]+)'s alt"] = "%f[%a\\192-\\255]([%a\\192-\\255]+)%f[^%a\\128-\\255]'s [Aa]lt"
L[".*[Aa]lts?$"] = true
--[[Translation missing --]]
L[".*[Tt]wink.*$"] = ".*[Tt]wink.*$"
L["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"] = "<alt name> (例如, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"
L["<main> (eg /altnames listalts Fin)"] = "<main> (例如 /altnames listalts Fin)"
L["<search term> (eg, /altnames find fin)"] = "<search term> (例如, /altnames find fin)"
L["Alt"] = "分身"
L["alt"] = "分身"
--[[Translation missing --]]
L["alt name exists: %s -> %s; not overwriting as set in preferences"] = "alt name exists: %s -> %s; not overwriting as set in preferences"
--[[Translation missing --]]
L["alt of ([^%s%p%d%c%z]+)"] = "[Aa]lt of %f[%aÀ-ÿ]([%aÀ-ÿ]+)%f[^%a-ÿ]"
L["AltNames"] = "分身名字"
L["Alts:"] = "分身:"
--[[Translation missing --]]
L["autoguildalts_desc"] = "Automatically run the import from guild roster command silently"
L["autoguildalts_name"] = "自動匯入公會分身"
L["Be quiet"] = "安靜"
L["character removed: %s"] = "已移除角色：%s"
L["Class colour"] = "職業色彩"
L["Clear all"] = "清除所有"
--[[Translation missing --]]
L["Clear all links between alts and main names."] = "Clear all links between alts and main names."
L["Colour"] = "顏色"
--[[Translation missing --]]
L["Delete a character's link to another character as their main."] = "Delete a character's link to another character as their main."
L["Delete alt"] = "刪除別稱"
L["Disabled"] = "停用"
L["Display a player's alts in the tooltip"] = "顯示在提示玩家的分身"
L["Display a player's main name in the tooltip"] = "顯示在提示玩家的本尊名稱"
--[[Translation missing --]]
L["Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the alt's class (taking the data from the PlayerNames module if it is enabled)"
--[[Translation missing --]]
L["Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"] = "Display main names in the same colour as that of the main's class (taking the data from the PlayerNames module if it is enabled)"
--[[Translation missing --]]
L["Don't overwrite existing alt <-> main links when importing or adding new alts."] = "Don't overwrite existing alt <-> main links when importing or adding new alts."
L["Don't overwrite existing links"] = "不要覆蓋現存的連接"
L["don't use"] = "不要使用"
--[[Translation missing --]]
L["Don't use data from the PlayerNames module at all"] = "Don't use data from the PlayerNames module at all"
L["ERROR: some function sent a blank message!"] = "錯誤：某些功能傳送空白訊息！"
L["Find characters"] = "搜尋角色"
L["Fix alts"] = "修正別稱"
L["Fix corrupted entries in your list of alt names."] = "修正列表中別稱損毀的項目"
L["Found alt: %s => main: %s"] = "搜尋別稱：%s => 主要名稱：%s"
L["guild member alts found and imported: %s"] = "公會成員別稱搜尋以及匯入：%s"
L["Import from Guild Greet database"] = "匯入來自公會問候資料庫"
L["Import from guild roster"] = "匯入公會名冊"
L["Import options"] = "匯入選項設定"
--[[Translation missing --]]
L["Imports alt names from a Guild Greet database, if present"] = "Imports alt names from a Guild Greet database, if present"
--[[Translation missing --]]
L["Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""] = "Imports alt names from the guild roster by checking for members with the rank \"alt\" or \"alts\", or guild / officer notes like \"<name>'s alt\""
--[[Translation missing --]]
L["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."] = "Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."
L["Left"] = "左方"
L["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"] = "link <alt name> <main name> (例如, /altnames link Fin Finjathealtoffin)"
L["Link alt"] = "連結分身"
--[[Translation missing --]]
L["Link someone's alt character with the name of their main."] = "Link someone's alt character with the name of their main."
L["linked alt %s => %s"] = "連結分身 %s=> %s"
L["List all"] = "列出所有"
--[[Translation missing --]]
L["List all links between alts and their main names."] = "List all links between alts and their main names."
L["List alts"] = "列出別稱"
--[[Translation missing --]]
L["List alts for a given character"] = "List alts for a given character"
L["LOKWhoIsWho data not found"] = "LOKWhoIsWho 資料找不到"
L["LOKWhoIsWho import"] = "LOKWhoIsWho 匯入"
L["LOKWhoIsWho lua file not found, sorry."] = " LOKWhoIsWho lua 檔案找不到, 抱歉。 "
L["Main"] = "主要"
L["main"] = "主要"
L["Main name position"] = "主要名稱位置"
L["Main:"] = "主要："
--[[Translation missing --]]
L["mainpos_desc"] = "Where to display a character's main name when on their alt."
L["mainpos_name"] = "主要名稱位置"
--[[Translation missing --]]
L["module_desc"] = "Allows people's alt characters to be linked to their mains, which can then be displayed next to their names when found in chat messages (default=off)."
L["no alts found for character "] = "未發現此角色分身"
L["no alts or mains found matching \"%s\""] = "找不到分身或本尊符合\"%s\""
--[[Translation missing --]]
L["No arg string given to :addAlt()"] = "No arg string given to :addAlt()"
L["no characters called \"%s\" found; nothing deleted"] = "找不到角色\"%s\"; 沒有刪除"
L["No Guild Greet database found"] = "找不到公會問候資料庫"
--[[Translation missing --]]
L["No main name suPLied to link %s to"] = "No main name suPLied to link %s to"
--[[Translation missing --]]
L["No main name supplied to link %s to"] = "No main name supplied to link %s to"
L["no matches found"] = "找不到符合"
L["quiet"] = "安靜"
L["quiet_desc"] = "是否回報至聊天視窗。"
L["quiet_name"] = true
L["Right"] = "右"
--[[Translation missing --]]
L["Search the list of linked characters for matching main or alt names."] = "Search the list of linked characters for matching main or alt names."
L["searched for: %s - total matches: %s"] = "搜索於: %s - 總符合: %s"
L["Show alts in tooltip"] = "顯示在提示分身"
L["Show main in tooltip"] = "顯示提示主要"
L["Start"] = "開始"
--[[Translation missing --]]
L["The colour of an alt's main name that will be displayed"] = "The colour of an alt's main name that will be displayed"
L["Use class colour (from the PlayerNames module)"] = "使用職業色彩（來自玩家名稱模組）"
L["use class colour of alt"] = "使用職業色彩於玩家次要人物"
L["use class colour of main"] = "使用職業色彩於玩家主要人物"
L["Use LibAlts Data"] = "使用 LibAlts 資料"
--[[Translation missing --]]
L["Use the data available via the shared alt information library."] = "Use the data available via the shared alt information library."
L["Various ways to import a main's alts from other addons"] = "由其他插件以各種方法匯入非主要人物。"
L["warning: alt %s already linked to %s"] = "警告: 分身 %s 已經連結至 %s"
L["Where to display a character's main name when on their alt."] = "用以顯示人物主要名稱於其其他角色名稱。"
L["Whether to report to the chat frame or not."] = "是否回報至聊天框架裡。"
L["You are not in a guild"] = "你並沒有加入任何公會"
--[[Translation missing --]]
L["You have not yet linked any alts with their mains."] = "You have not yet linked any alts with their mains."

	  PL:AddLocale("zhTW",L)
	end
	--@end-non-debug@


	local altregistry

	module.Alts = {}

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = false,
			quiet = false,
			pncol = 'no',
			altidx = {},
			mainpos = 'RIGHT',
			colour = { r = 0, g = 0, b = 0 },
			maincolour = '97ff4c', -- fairly light bright green
			altcolour = 'ff6df2', -- fairly bright light purpley pinkish
			noclobber = false,
			tooltip_showmain = false,
			tooltip_showalts = false,
			usealtlib = true,
			autoguildalts = false,
		},
		realm = {
			alts = {},
		}
	})

	Prat:SetModuleInit(module,
		function(self)
			altregistry = LibStub("LibAlts-1.0")

			if self.db.profile.alts then
				local alts = self.db.profile.alts
				self.db.profile.alts = nil
				for k, v in pairs(alts) do
					self.db.realm.alts[k] = self.db.realm.alts[k] or v
				end
			end

			-- Load shared Alts data
			for alt, main in pairs(self.db.realm.alts) do

				altregistry:SetAlt(main, alt, "Prat")
			end



			-- define a popup to get the main name
			StaticPopupDialogs['MENUITEM_LINKALT'] = {
				-- text		= "Who would you like to set as the main character of %s?",
				text = 'Mainname',
				button1 = ACCEPT,
				button2 = CANCEL,
				hasEditBox = 1,
				maxLetters = 24,
				exclusive = 0,
				preferredIndex = 3,
				OnAccept = function(this, altname)
					local mainname = this.editBox:GetText()

					altname = altname or 'xxx'

					module:addAlt(string.format('%s %s', altname, mainname))
				end,
				OnShow = function(this)
					this.editBox:SetFocus();
				end,
				OnHide = function(this)
					if (this.editBox:IsShown()) then
						this.editBox:SetFocus();
					end
					_G[this:GetName() .. "EditBox"]:SetText("");
				end,
				EditBoxOnEnterPressed = function(this, altname)
					local parent = this:GetParent()
					local editBox = parent.editBox
					local mainname = editBox:GetText()

					altname = altname or 'xxx'

					module:addAlt(string.format('%s %s', altname, mainname))

					parent:Hide()
				end,
				EditBoxOnEscapePressed = function(this)

					this:GetParent():Hide();
				end,
				timeout = 0,
				whileDead = 1,
				hideOnEscape = 1
			}
			return
		end)

	Prat:SetModuleOptions(module, {
		name = PL["AltNames"],
		desc = PL["module_desc"],
		type = "group",
		args = {
			find = {
				name = PL["Find characters"],
				desc = PL["Search the list of linked characters for matching main or alt names."],
				type = "input",
				usage = PL["<search term> (eg, /altnames find fin)"],
				order = 110,
				set = function(info, q)
					info.handler:findChars(q)
				end,
				get = false,
			},
			listalts = {
				name = PL['List alts'],
				desc = PL['List alts for a given character'],
				type = 'input',
				usage = PL['<main> (eg /altnames listalts Fin)'],
				order = 115,
				set = function(info, m)
					info.handler:listAlts(m)
				end,
				get = false,
			},
			link = {
				name = PL["Link alt"],
				desc = PL["Link someone's alt character with the name of their main."],
				type = "input",
				order = 120,
				usage = PL["link <alt name> <main name> (eg, /altnames link Fin Finjathealtoffin)"],
				-- pass	= true,
				-- set	= function(argname, argstr) self:addAlt(argstr) end,
				set = function(info, argstr)
					info.handler:addAlt(argstr)
				end,
				get = false,
				--				alias	= { 'new', 'add' },
			},
			del = {
				name = PL["Delete alt"],
				desc = PL["Delete a character's link to another character as their main."],
				type = "input",
				usage = PL["<alt name> (eg, /altnames del Personyouthoughtwassomeonesaltbutreallyisnt)"],
				order = 130,
				set = function(info, altname)
					info.handler:delAlt(altname)
				end,
				get = false,
				confirm = true,
				--				alias	= { 'remove', 'unlink' },
			},
			quiet = {
				name = PL["Be quiet"],
				desc = PL["Whether to report to the chat frame or not."],
				type = "toggle",
				order = 191, -- 19x = options
			},
			listall = {
				name = PL["List all"],
				desc = PL["List all links between alts and their main names."],
				type = "execute",
				func = "listAll",
				--				alias	= { 'list', 'all' },
			},
			clearall = {
				name = PL["Clear all"],
				desc = PL["Clear all links between alts and main names."],
				type = "execute",
				func = "clearAllAlts",
				confirm = true,
			},
			fixalts = {
				name = PL["Fix alts"],
				desc = PL["Fix corrupted entries in your list of alt names."],
				type = "execute",
				func = "fixAlts",
			},
			colour = {
				name = PL["Colour"],
				get = function(info)
					return info.handler:getColour()
				end,
				set = function(info, nr, ng, nb, na)
					info.handler.db.profile.colour = { r = nr, g = ng, b = nb, a = na }
				end,
				desc = PL["The colour of an alt's main name that will be displayed"],
				type = "color",
				order = 60,
				disabled = function(info)
					return info.handler.db.profile.pncol ~= 'no'
				end
			},
			pncol = {
				name = PL["Class colour"],
				desc = PL["Use class colour (from the PlayerNames module)"],
				type = "select",
				get = function(info)
					return info.handler.db.profile.pncol
				end,
				set = function(info, v)
					info.handler.db.profile.pncol = v
				end,
				order = 55,
				values = {
					['main'] = PL["use class colour of main"],
					['alt'] = PL["use class colour of alt"],
					['no'] = PL["don't use"],
				},
			},
			mainpos = {
				name = PL["Main name position"],
				desc = PL["Where to display a character's main name when on their alt."],
				type = "select",
				order = 50,
				get = function(info)
					return info.handler.db.profile.mainpos
				end,
				set = function(info, v)
					info.handler:setMainPos(v)
				end,
				values = {
					["LEFT"] = PL["Left"],
					["RIGHT"] = PL["Right"],
					["START"] = PL["Start"],
				},
			},
			tooltip_showmain = {
				name = PL['Show main in tooltip'],
				desc = PL["Display a player's main name in the tooltip"],
				type = 'toggle',
				order = 150,
				get = function(info)
					return info.handler.db.profile.tooltip_showmain
				end,
				set = function(info)
					info.handler.db.profile.tooltip_showmain = not info.handler.db.profile.tooltip_showmain
					info.handler.altertooltip = info.handler.db.profile.tooltip_showalts or info.handler.db.profile.tooltip_showmain

					info.handler:HookTooltip()
				end,
			},
			tooltip_showalts = {
				name = PL['Show alts in tooltip'],
				desc = PL["Display a player's alts in the tooltip"],
				type = 'toggle',
				order = 150,
				get = function(info)
					return info.handler.db.profile.tooltip_showalts
				end,
				set = function(info)
					info.handler.db.profile.tooltip_showalts = not info.handler.db.profile.tooltip_showalts
					info.handler.altertooltip = info.handler.db.profile.tooltip_showalts or info.handler.db.profile.tooltip_showmain

					info.handler:HookTooltip()
				end,
			},
			noclobber = {
				name = PL["Don't overwrite existing links"],
				desc = PL["Don't overwrite existing alt <-> main links when importing or adding new alts."],
				type = "toggle",
				order = 192, -- 19x = options
			},

			--			blankheader = {
			--				order	= 499,
			--				type	= 'header',
			--				},

			--[[ IMPORT OPTIONS ]] --
			importheader = {
				name = PL["Import options"],
				desc = PL["Various ways to import a main's alts from other addons"],
				type = 'header',
				order = 500,
			},

			-- imports: LOKWhoIsWho - SavedVariables
			importfromlok = {
				name = PL["LOKWhoIsWho import"],
				desc = PL["Imports data from LOKWhoIsWho, if present (drop your SavedVariables\\LOKWhoIsWho.lua in the Prat directory to be able to use this)."],
				type = "execute",
				func = "importFromLOK",
				confirm = true,
				order = 560,
			},

			-- imports: guild roster - officer notes, public notes, ranks
			guildimport = {
				name = PL["Import from guild roster"],
				desc = PL['Imports alt names from the guild roster by checking for members with the rank "alt" or "alts", or guild / officer notes like "<name>\'s alt"'],
				type = "execute",
				func = "importGuildAlts",
				confirm = true,
				order = 520,
			},

			-- imports: guild greet - SavedVariables
			ggimport = {
				name = PL['Import from Guild Greet database'],
				desc = PL['Imports alt names from a Guild Greet database, if present'],
				type = 'execute',
				func = "importGGAlts",
				confirm = true,
				order = 550,
			},
			usealtlib = {
				name = PL["Use LibAlts Data"],
				desc = PL["Use the data available via the shared alt information library."],
				type = "toggle",
				order = 540,
			},
			autoguildalts = {
				name = PL["autoguildalts_name"],
				desc = PL["autoguildalts_desc"],
				type = "toggle",
				order = 540,
			},
		}
	})


	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	function module:OnModuleEnable()
		-- much code ripped off from the PlayerMenu code - thanks, and sorry!

		-- things to do when the module is enabled
		for altname, mainname in pairs(self.db.realm.alts) do
			self.Alts[altname] = mainname
		end

		-- PlayerNames colour
		local pncol = self.db.profile.pncol

		if pncol == 'no' then
			self.db.profile.pncol = false
		end

		self.db.profile.pncol = self.db.profile.pncol or false

		-- for caching a main's list of alts
		self.Altlists = {}

		-- just register one area which can be used for anything
		-- (and only actually has one use at the moment)
		self.ALTNAMES = ""

		-- set position that main names are displayed in chat messages
		self:setMainPos(self.db.profile.mainpos)

		-- register events
		Prat.RegisterChatEvent(self, "Prat_PreAddMessage")

		-- hook functions
		self.altertooltip = self.db.profile.tooltip_showmain or self.db.profile.tooltip_showalts

		self:HookTooltip()

		if not self.menusAdded then
			self.menusAdded = true
		end

		if self.db.profile.autoguildalts then
			self:AutoImportGuildAlts(true)
		end

		altregistry.RegisterCallback(self, "LibAlts_SetAlt", function(_, main, alt)
			self:addAlt(alt .. " " .. main, true)
		end)
		altregistry.RegisterCallback(self, "LibAlts_RemoveAlt", function(_, _, alt)
			self:delAlt(alt, true)
		end)
	end

	function module:AutoImportGuildAlts(b)
		if b then
			self:RegisterEvent("GUILD_ROSTER_UPDATE", function()
				module:importGuildAlts(nil, true)
			end)
			C_GuildInfo.GuildRoster()
		else
			self:UnregisterEvent("GUILD_ROSTER_UPDATE")
		end
	end

	function module:OnValueChanged(info, b)
		local field = info[#info]
		if field == "autoguildalts" then
			self:AutoImportGuildAlts(b)
		end
	end

	local function NOP()
		return
	end

	function module:HookTooltip()
		if self.altertooltip then


			if Prat.IsClassic then
				self:SecureHookScript(GameTooltip, 'OnTooltipSetUnit', function()
					if self.altertooltip and not self.showingtooltip then
						-- check who / what the tooltip's being displayed for
						local _, unitid = GameTooltip:GetUnit()
						self:ModifyUnitTooltip(unitid)
					end
				end)
				self:SecureHookScript(GameTooltip, 'OnTooltipCleared', function()
					-- got to reset the flag so we know when to readd the lines
					self.showingtooltip = false
				end)
			else
				TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Unit, function(tooltip, data)
					if tooltip == GameTooltip and self.altertooltip then
						local unitid = UnitTokenFromGUID(data.guid)
						if (not issecretvalue or not issecretvalue(unitid)) and UnitIsPlayer(unitid) then
							self:ModifyUnitTooltip(unitid)
						end
					end
				end)
			end

			module.HookTooltip = NOP
		end
	end


	-- things to do when the module is disabled
	function module:OnModuleDisable()
		-- unregister events
		Prat.UnregisterAllChatEvents(self)

		altregistry.UnregisterAllCallbacks(self)
	end


	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --


	function module:print(msg, printanyway)
		-- make sure we've got a message
		if msg == nil then
			printanyway = true
			msg = PL['ERROR: some function sent a blank message!']
		end

		local verbose = (not self.db.profile.quiet)

		if (not self.silent) and (verbose or printanyway) then
			self:Output(msg)
		end
	end

	--[[ colo*u*ring and formatting ]] --

	local clrname = function(name, colour)
		return '|cff' .. (colour or 'ffffff') .. (name or "") .. '|r'
	end

	local clrmain = function(mainname, maincolour)
		mainname = mainname or ""
		maincolour = maincolour or module.db.profile.maincolour or '8080ff'

		-- 1, 0.9, 0, 0.5, 0.5, 1

		return clrname(mainname, maincolour)
	end

	local clralt = function(altname, altcolour)
		altname = altname or ""
		altcolour = altcolour or module.db.profile.altcolour or 'ff8080'

		-- 1, 0.7, 0, 1, 0.5, 0.5

		return clrname(altname, altcolour)
	end

	function module:formatCharName(name)
		-- format character names as having uppercase first letter followed by all lowercase

		if name == nil then
			return ""
		end

		name = name:gsub('[%%%[%]":|%s]', '')
		name = name:gsub("'", '')

		name = name:lower()
		name = name:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1)

		return name
	end

	--[[ alt <-> main link management ]] --


	function module:addAlt(argstr, eventGenerated)
		local mainname

		local altname = ""

		-- check we've been passed somethin
		if (argstr == nil) or (argstr == "") then
			self:print(PL['No arg string given to :addAlt()'])
			return false
		end

		-- extract the alt's name and the main name to link to
		for k, v in argstr:gmatch('(%S+)%s+(%S+)') do
			altname, mainname = k, v
		end

		-- check we've got a main name to link to
		if altname and not mainname then
			altname = argstr
			self:print(string.format(PL["No main name suPLied to link %s to"], clralt(altname)), true)
			return false
		end

		-- clean up character names
		mainname = self:formatCharName(mainname)
		altname = self:formatCharName(altname)

		if self.Alts[altname] then
			local oldmain = self.Alts[altname]

			if oldmain == mainname then
				self:print(string.format(PL['warning: alt %s already linked to %s'], clralt(altname), clrmain(mainname)))
				return false
			end

			if self.db.profile.noclobber then
				self:print(string.format(PL['alt name exists: %s -> %s; not overwriting as set in preferences'],
					clralt(altname), clrmain(oldmain)))
				return false
			end

			self:print(string.format(PL['warning: alt %s already linked to %s'], clralt(altname), clrmain(oldmain)))
		end

		-- add alt to list of alts -> mains
		self.Alts[altname] = mainname
		self.db.realm.alts[altname] = mainname

		-- make sure this character's list of alts is rebuilt next time it's needed
		if self.Altlists[mainname] then
			self.Altlists[mainname] = nil
		end

		-- publish this info globablly
		if not eventGenerated then
			altregistry:SetAlt(mainname, altname, "Prat")
		end

		self:print(string.format(PL["linked alt %s => %s"], clralt(altname), clrmain(mainname)))
	end

	function module:delAlt(altname, eventGenerated)
		local suPLiedaltname = altname

		altname = self:formatCharName(altname)

		if self.Alts[altname] then
			local mainname = self.Alts[altname]
			self.Alts[altname] = nil
			self.db.realm.alts[altname] = nil

			self:print(string.format(PL["character removed: %s"], clralt(suPLiedaltname)))

			-- make sure this character's list of alts is rebuilt next time it's needed
			if self.Altlists[mainname] then
				self.Altlists[mainname] = nil
			end

			if not eventGenerated then
				altregistry:DeleteAlt(mainname, altname, "Prat")
			end

			return true
		end

		self:print(string.format(PL['no characters called "%s" found; nothing deleted'], clralt(suPLiedaltname)))
	end

	function module:listAll()
		if not self.db.realm.alts and self.Alts then
			self:print(PL["You have not yet linked any alts with their mains."], true)
			return false
		end

		local altcount = 0

		for altname, mainname in pairs(self.Alts) do
			altcount = altcount + 1
			self:print(string.format("alt: %s => main: %s", clralt(altname), clrmain(mainname)))
		end

		self:print(string.format(PL['%s total alts linked to mains'], altcount))
	end

	function module:findChars(q)

		if not self.Alts then
			self:print(PL["You have not yet linked any alts with their mains."], true)
			return false
		else
			local matches = {}
			local numfound = 0

			for altname, mainname in pairs(self.Alts) do
				local a = string.lower(altname)
				local m = string.lower(mainname)
				local pat = string.lower(q)

				-- self:print(string.format("matching against: altname:'%s', mainname:'%s', pat:'%s'", a, m, pat))

				if (a == pat) or (m == pat) or (a:find(pat)) or (m:find(pat)) then
					matches[altname] = mainname
					numfound = numfound + 1
				end
			end

			if numfound == 0 then
				self:print(string.format(PL['no alts or mains found matching "%s"'], '|cffffb200' .. q .. '|r'), true)
			else
				for altname, mainname in pairs(matches) do
					self:print(string.format(PL["Found alt: %s => main: %s"], clralt(altname), clrmain(mainname)))
				end

				self:print(string.format(PL["searched for: %s - total matches: %s"], q, numfound))
			end

			return numfound
		end
	end

	function module:fixAlts()
		local fixedalts = {}

		for altname, mainname in pairs(self.db.realm.alts) do
			altname = self:formatCharName(altname)
			mainname = self:formatCharName(mainname)

			fixedalts[altname] = mainname
		end

		self.Alts = fixedalts
		self.db.realm.alts = fixedalts
	end

	function module:clearAllAlts()
		self.Alts = {}
		self.db.realm.alts = {}
		self.Altlists = {}
	end

	local CLR = Prat.CLR

	function module:setMainPos(pos)
		-- which item to go after, depending on our position
		local msgitems = {
			RIGHT = 'Pp',
			LEFT = 'Ff',
			START = nil,
		}

		pos = pos or 'RIGHT'

		Prat.RegisterMessageItem('ALTNAMES', msgitems[pos])

		if pos == 'RIGHT' then
			self.padfmt = ' ' .. CLR:Colorize("ffffff", "(") .. "%s" .. CLR:Colorize("ffffff", ")")
		else
			self.padfmt = CLR:Colorize("ffffff", "(") .. "%s" .. CLR:Colorize("ffffff", ")") .. ' '
		end

		self.db.profile.mainpos = pos
	end

	local function isAlt(name)
		local alt = module.Alts[name]
		if alt then
			return alt
		end

		if altregistry and altregistry:IsAlt(name) then
			return altregistry:GetMain(name)
		end

		return
	end

	local playernames
	function module:Prat_PreAddMessage(_, message)
		local hexcolour = CLR.NONE

		local mainname = message.PLAYERLINK

		local altname = isAlt(mainname) or isAlt(Ambiguate(mainname, "all"))

		if self.db.profile.on and altname then
			local padfmt = self.padfmt or ' (%s)'

			if self.db.profile.colour then
				if self.db.profile.pncol ~= 'no' then
					local charname
					local coltype = self.db.profile.pncol

					if coltype == "alt" then
						charname = mainname
					elseif coltype == "main" then
						charname = altname
					else
						charname = nil
						self.db.profile.pncol = 'no'
					end

					playernames = playernames or Prat:GetModule("PlayerNames")
					if charname and playernames then
						local class = playernames:GetData(charname)
						if class then
							local classColor = Prat.GetClassColor(class, true)
							if classColor then
								self.ALTNAMES = string.format(padfmt, classColor:WrapTextInColorCode(altname:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1)))
								message.ALTNAMES = self.ALTNAMES
								return
							end
						end
					end
				else
					hexcolour = CLR:GetHexColor(self.db.profile.colour)
				end

				hexcolour = hexcolour or CLR:GetHexColor(self.db.profile.colour)
			end

			self.ALTNAMES = string.format(padfmt, CLR:Colorize(hexcolour, altname:gsub(Prat.MULTIBYTE_FIRST_CHAR, string.upper, 1)))

			message.ALTNAMES = self.ALTNAMES
		end
	end

	function module:getColour()
		local col = self.db.profile.colour
		-- We check every component as old profiles from before 10.0 with a default
		-- colour had them all nil. In 10.0 SetVertexColor requires non-nil colour
		-- components, so we return a black.
		if not col or col.r == nil or col.g == nil or col.b == nil then
			return 0, 0, 0
		end
		return col.r, col.g, col.b, nil
	end

	function module:importFromLOK()
		if not LOKWhoIsWho_Config then
			self:print(PL['LOKWhoIsWho lua file not found, sorry.'])
			return false
		end

		local server = GetRealmName()
		local lokalts = LOKWhoIsWho_Config[server]['players']

		if lokalts == nil then
			self:print(PL["LOKWhoIsWho data not found"])
			return false
		end

		local numimported = 0

		for altname, mainname in pairs(lokalts) do
			self:addAlt(string.format("%s %s", altname, mainname))
			numimported = numimported + 1
		end

		self:print(string.format(PL["%s alts imported from LOKWhoIsWho"], numimported))
	end

	function module:importGGAlts()
		--[[
		 imports guilds from a Guild Greet database, if present
	   ]]
		if not GLDG_Data then
			self:print(PL['No Guild Greet database found'])
			return
		end

		local servername = GetRealmName()
		local mainname, altname

		for k, v in pairs(GLDG_Data) do
			if string.match(k, servername .. ' - %S+') then
				for name, player in pairs(v) do
					-- not sure whether this would be useful:
					-- if player['alt'] and player['alt'] ~= "" and not player['own'] then
					if player['alt'] and player['alt'] ~= "" then
						mainname = player['alt']
						altname = name

						self:addAlt(string.format('%s %s', altname, mainname))
					end
				end
			end
		end
	end

	function module:importGuildAlts(altrank, silently)
		if altrank == "" then
			altrank = nil
		end

		local totalmembers
		self.silent = silently

		totalmembers = GetNumGuildMembers(true)

		if totalmembers == 0 then
			self:print(PL['You are not in a guild'])
			return
		end


		-- build a list of guild members to check guild notes against later
		local guildMembers = {}

		for x = 1, totalmembers do
			local name = GetGuildRosterInfo(x)
			if name then
				--since GetGuildRosterInfo returns Playername-Realm we need to trim Realmname
				--later we can compare Playername with officernote/publicnote
				--nobody is typing Playername with realm into the notes
				local shortname, _ = strsplit("-", name, 2)
				guildMembers[string.lower(shortname)] = shortname
			end
		end


		-- loop through members and check stuff for later
		local numfound = 0

		for x = 1, totalmembers do
			local mainname

			local name, rank, _, _, _, _, publicnote, officernote = GetGuildRosterInfo(x)

			-- yeah I know the vars should be pre-lc'ed and it's not as efficient as it could be below
			-- ... feel free to clean it up

			-- untested (is there a more convenient trim function available?):
			--[[
		   officernote = gsub("^%s*", "", officernote)
		   publicnote = gsub("^%s*", "", publicnote)
		   ]]

			officernote = officernote or ""
			publicnote = publicnote or ""
			rank = rank or ""
			officernote = (officernote):match(PL["(.-)'s? [Aa]lt"]) or officernote or ""
			publicnote = (publicnote):match(PL["(.-)'s? [Aa]lt"]) or publicnote or ""

			local cleanpubnote = publicnote:match(Prat.AnyNamePattern)
			local cleanoffnote = officernote:match(Prat.AnyNamePattern)

			-- check for guild members with rank "alt" or "alts" or "officer alt" or "twink"
			if (rank:match(PL[".*[Aa]lts?$"]) or rank:match(PL[".*[Tt]wink.*$"]) or (altrank and rank == altrank)) and (cleanpubnote and
				guildMembers[cleanpubnote:lower()]) then
				-- self:print(string.format('found mainname name for member %s', name))
				mainname = cleanpubnote
				-- check whether guild note is an exact match of a member's name
			elseif cleanpubnote and guildMembers[cleanpubnote:lower()] then
				mainname = cleanpubnote
			elseif cleanoffnote and guildMembers[cleanoffnote:lower()] then
				mainname = cleanoffnote
			elseif officernote:find(PL["([^%s%p%d%c%z]+)'s alt"]) or publicnote:find(PL["([^%s%p%d%c%z]+)'s alt"]) then
				local TempName = officernote:match(PL["([^%s%p%d%c%z]+)'s alt"]) or publicnote:match(PL["([^%s%p%d%c%z]+)'s alt"])
				if TempName and guildMembers[string.lower(TempName)] then
					mainname = TempName
				end
			elseif officernote:find(PL["alt of ([^%s%p%d%c%z]+)"]) or publicnote:find(PL["alt of ([^%s%p%d%c%z]+)"]) then
				local TempName = officernote:match(PL["alt of ([^%s%p%d%c%z]+)"]) or publicnote:match(PL["alt of ([^%s%p%d%c%z]+)"])
				if TempName and guildMembers[string.lower(TempName)] then
					mainname = TempName
				end
			end

			-- set alt name if we've found their main name
			if mainname and mainname ~= "" then

				if mainname:lower() ~= name:lower() then
					numfound = numfound + 1
					self:addAlt(string.format('%s %s', name, mainname))
				end
			end
		end

		self:print(string.format(PL["guild member alts found and imported: %s"], numfound))
		self.silent = nil
	end


	-- function for showing a list of alt names in the tooltip
	function module:getAlts(mainname)
		if self.db.profile.usealtlib then
			local alts = { altregistry:GetAlts(mainname) }
			if #alts > 0 then
				return alts
			end

			return false
		end

		-- self.Alts = self.db.profile.altnames

		-- check valid mainname is being passed and that we actually have a list of alts
		if not (mainname and self.Alts) then
			return false
		end

		-- format the character name
		mainname = self:formatCharName(mainname)

		-- check mainname wasn't just made of invalid characters
		if mainname == "" then
			return false
		end

		-- check we've not already built the list of alts for this character
		if self.Altlists[mainname] then
			return self.Altlists[mainname]
		end

		local alts = {}
		local allalts = self.Alts

		-- loop through list of alts and build alts table for given mainname
		for alt, tmpmainname in pairs(allalts) do
			if mainname == tmpmainname then
				table.insert(alts, alt)
			end
		end

		-- check there we've actually found some alts
		if #alts == 0 then
			return false
		end

		-- cache this list of alts
		self.Altlists[mainname] = alts

		return alts
	end


	-- function for showing main names in the tooltip
	function module:getMain(altname)
		if self.db.profile.usealtlib then
			local main = altregistry:GetMain(altname)
			if main then
				return self:formatCharName(main)
			end

			return false
		end

		-- self.Alts = self.db.profile.altnames

		-- check for valid alt name being passed and that we actually have a list of alts
		if not altname and self.Alts then
			return false
		end

		-- format the character name
		altname = self:formatCharName(altname)

		-- check the alt name wasn't just made of invalid character
		if altname == "" then
			return false
		end

		-- check a main exists for the given alt name
		if not self.Alts[altname] then
			return false
		end

		return self.Alts[altname]
	end

	function module:nicejoin(t, glue, gluebeforelast)
		-- check we've got a table
		if type(t) ~= 'table' then
			return false
		end

		local list = {}
		local index = 1

		-- create a copy of the table with a numerical and no nested tables
		for _, v in pairs(t) do
			local vtype = type(v)
			local item = self:formatCharName(v)

			if vtype ~= 'string' then
				item = vtype
			end

			list[index] = item or vtype
			index = index + 1
		end

		-- make sure we have some items to join
		if #list == 0 then
			return ""
		end

		-- trying to join one item = that item
		if #list == 1 then
			return list[1]
		end

		-- defaults with which we will want wo woin no that's not going to work
		-- defaults
		glue = glue or ', '
		gluebeforelast = gluebeforelast or ', and '

		-- pop the last value off
		local last = table.remove(list) or "" -- shouldn't need the ' or ""'?

		-- standard way of joining a list of items together
		local str = table.concat(list, glue)

		-- return the previous list, but add the last value nicely
		return str .. gluebeforelast .. last
	end


	-- displays all alts for a given character as a list rather than seperate matches
	function module:listAlts(mainname)
		if not mainname then
			return false
		end

		mainname = self:formatCharName(mainname)

		if mainname == "" then
			return false
		end

		local alts

		alts = self:getAlts(mainname)

		if not alts or (#alts == 0) then
			self:print(PL['no alts found for character '] .. mainname)
			return
		else
			self:print(string.format(PL['%d alts found for %s: %s'], #alts, clrmain(mainname), clralt(self:nicejoin(alts))))
			return #alts
		end
	end


	-- hooked function to show mains and alts if set in preferences
	function module:ModifyUnitTooltip(unitid)
		-- check to see if it's a character
		if UnitIsPlayer(unitid) then
			-- create lines table for extra information that might be added
			local charname = UnitName(unitid)

			local tooltipaltered

			-- check if the user wants the mainame name shown on alts' tooltips
			local mainname
			if self.db.profile.tooltip_showmain then
				mainname = self:getMain(charname)

				if mainname then
					-- add the character's main name to the tooltip
					GameTooltip:AddDoubleLine(PL['Main:'] .. ' ', clrmain(mainname), 1, 0.9, 0, 0.5, 0.5, 1)
					tooltipaltered = true
				end
			end

			local width = GameTooltip:GetWidth()
			-- check if the user wants a list of alts shown on mains' tooltips
			if self.db.profile.tooltip_showalts then
				local alts = self:getAlts(charname)
				if not alts and mainname then
					alts = self:getAlts(mainname)
				end

				if alts then
					-- build the string listing alts
					--					local altstr = self:nicejoin(alts)

					-- add the list of alts to the tooltip
					GameTooltip:AddLine("|cffffc080" .. PL['Alts:'] .. "|r " .. clralt(self:nicejoin(alts)), 1, 0.5, 0.5, 1)
					tooltipaltered = true
				end
			end

			if tooltipaltered then
				GameTooltip:SetWidth(width)
				GameTooltip:Show()
			end

			self.showingtooltip = true
		end
	end

	return
end) -- Prat:AddModuleToLoad
