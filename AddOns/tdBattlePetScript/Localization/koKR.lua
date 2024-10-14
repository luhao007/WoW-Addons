local L = LibStub('AceLocale-3.0'):NewLocale('PetBattleScripts', 'koKR')
if not L then return end

--[[Translation missing --]]
L["ADDON_NAME"] = "Pet Battle Scripts"
--[[Translation missing --]]
L["DATABASE_UPDATE_BASE_TO_FIRSTENEMY_NOTIFICATION"] = "Discover that you've previously used the modified version of tdBattlePetScript and have migrated some of the scripts for the modified Base Selector to firstEnemy Selector."
--[[Translation missing --]]
L["DATABASE_UPDATED_TO"] = "Addon updated to"
--[[Translation missing --]]
L["DEFAULT_NEW_SCRIPT_NAME"] = "New script"
--[[Translation missing --]]
L["DIRECTOR_TEST_NEXT_ACTION"] = "Next action"
--[[Translation missing --]]
L["EDITOR_CREATE_SCRIPT"] = "Create script"
--[[Translation missing --]]
L["EDITOR_EDIT_SCRIPT"] = "Edit script"
--[[Translation missing --]]
L["IN_BATTLE_DEBUGGING_SCRIPT"] = "Debugging script"
--[[Translation missing --]]
L["IN_BATTLE_EXECUTE"] = "Autobattle"
--[[Translation missing --]]
L["IN_BATTLE_NO_SCRIPT"] = "No script"
--[[Translation missing --]]
L["IN_BATTLE_SELECT_SCRIPT"] = "Select script"
--[[Translation missing --]]
L["OPTION_AUTO_SELECT_SCRIPT_BY_ORDER"] = "Automatically select script by script selector order"
--[[Translation missing --]]
L["OPTION_AUTO_SELECT_SCRIPT_ONLY_ONE"] = "Automatically select script by script selector priority"
--[[Translation missing --]]
L["OPTION_AUTOBUTTON_HOTKEY"] = "Autobattle Hotkey"
--[[Translation missing --]]
L["OPTION_EDITOR_FONT_FACE"] = "Font face"
--[[Translation missing --]]
L["OPTION_EDITOR_FONT_SIZE"] = "Font size"
--[[Translation missing --]]
L["OPTION_HIDE_MINIMAP"] = "Hide minimap icon"
--[[Translation missing --]]
L["OPTION_HIDE_SELECTOR_NO_SCRIPT"] = "The script selector is not displayed when there is no script"
--[[Translation missing --]]
L["OPTION_LOCK_SCRIPT_SELECTOR"] = "Lock the script selector"
--[[Translation missing --]]
L["OPTION_NO_WAIT_DELETE_SCRIPT"] = "Do not wait for the script to be deleted"
--[[Translation missing --]]
L["OPTION_NOTIFY_BUTTON_ACTIVE"] = "Play sound when \"Autobattle\" button becomes active"
--[[Translation missing --]]
L["OPTION_NOTIFY_BUTTON_ACTIVE_SOUND"] = "Sound"
--[[Translation missing --]]
L["OPTION_RESET_FRAMES"] = "Reset the panel size and position"
--[[Translation missing --]]
L["OPTION_SCRIPTSELECTOR_NOTES"] = "Here you can manage the script selector is open, and its priority."
--[[Translation missing --]]
L["OPTION_SETTINGS_HIDE_MINIMAP_TOOLTIP"] = "Changing this setting requires reloading the UI. Do you want to continue?"
--[[Translation missing --]]
L["OPTION_TEST_BREAK"] = "Let 'test' action stop script"
--[[Translation missing --]]
L["SCRIPT_EDITOR_AUTOFORMAT_SCRIPT"] = "Format script"
--[[Translation missing --]]
L["SCRIPT_EDITOR_DELETE_SCRIPT_CONFIRMATION"] = "Are you sure you want to |cffff0000delete|r the script |cffffd000[%s - %s]|r ?"
--[[Translation missing --]]
L["SCRIPT_EDITOR_FOUND_ERROR"] = "Found error"
--[[Translation missing --]]
L["SCRIPT_EDITOR_LABEL_TOGGLE_EXTRA"] = "Toggle extension information editor"
--[[Translation missing --]]
L["SCRIPT_EDITOR_NAME_TITLE"] = "Script name"
--[[Translation missing --]]
L["SCRIPT_EDITOR_RUN_BUTTON"] = "Run"
--[[Translation missing --]]
L["SCRIPT_EDITOR_SAVE_SUCCESS"] = "Save success"
--[[Translation missing --]]
L["SCRIPT_EDITOR_TEXTAREA_TITLE"] = "Script"
--[[Translation missing --]]
L["SCRIPT_EDITOR_TITLE"] = "Script editor"
--[[Translation missing --]]
L["SCRIPT_MANAGER_TITLE"] = "Script manager"
--[[Translation missing --]]
L["SCRIPT_MANAGER_TOGGLE"] = "Toggle script manager"
--[[Translation missing --]]
L["SCRIPT_SELECTOR_TITLE"] = "Script selector"
--[[Translation missing --]]
L["SCRIPT_SELECTOR_TOGGLE"] = "Toggle script selector"
--[[Translation missing --]]
L["SELECTOR_ALLINONE_NOTES"] = "This script can be used in all pet battles."
--[[Translation missing --]]
L["SELECTOR_ALLINONE_TITLE"] = "All in one"
--[[Translation missing --]]
L["SELECTOR_BASE_ALLY"] = "Ally"
--[[Translation missing --]]
L["SELECTOR_BASE_ENEMY"] = "Enemy"
--[[Translation missing --]]
L["SELECTOR_BASE_NOTES"] = "This script selector matches ally and enemy."
--[[Translation missing --]]
L["SELECTOR_BASE_TITLE"] = "Base"
--[[Translation missing --]]
L["SELECTOR_FIRSTENEMY_NOTES"] = "This script selector binds the script to the first enemy in the battle."
--[[Translation missing --]]
L["SELECTOR_FIRSTENEMY_TITLE"] = "First enemy"
--[[Translation missing --]]
L["SELECTOR_REMATCH_4_TO_5_UPDATE_NOTE"] = "Updated from Rematch 4 to Rematch 5. Please check whether your scripts are still correctly linked to teams.\\nIf the upgrade failed, restore a backup of wow/WTF/Account/<account>/SavedVariables/tdBattlePetScript.lua, or open it and search for \"Rematch\" and remove or replace with \"Rematch5\", then search for \"Rematch4\" and replace it with \"Rematch\". Then downgrade back to Rematch 4 and report a bug on https://github.com/axc450/pbs/issues/new, attaching your saved variables file for Rematch and this addon."
--[[Translation missing --]]
L["SELECTOR_REMATCH_4_TO_5_UPDATE_ORPHAN"] = [=[Found script named "%s" which is linked to the non-existent Rematch team id "%s".\n
This can indicate an issue during updating the database, or a previous corruption. If this error has happened to a lot of teams, please report it as a bug. Otherwise, just remove orphaned teams via the Script Manager and re-add them to the correct teams.]=]
--[[Translation missing --]]
L["SELECTOR_REMATCH_CANT_FORMAT_TOOLTIP_REMATCH_NOT_LOADED"] = "Can't show information: Rematch addon not loaded."
--[[Translation missing --]]
L["SELECTOR_REMATCH_NO_TEAM_FOR_SCRIPT"] = "No team matches this script"
--[[Translation missing --]]
L["SELECTOR_REMATCH_NOTES"] = "This script selector will be bound to the Rematch team."
--[[Translation missing --]]
L["SELECTOR_REMATCH_TEAM_FORMAT"] = "Team: %s"
--[[Translation missing --]]
L["SELECTOR_REMATCH_TITLE"] = "Rematch"
--[[Translation missing --]]
L["SHARE_EXPORT_SCRIPT"] = "Export"
--[[Translation missing --]]
L["SHARE_IMPORT_CHOOSE_KEY"] = "Select the key..."
--[[Translation missing --]]
L["SHARE_IMPORT_CHOOSE_SELECTOR"] = "Select the script selector..."
--[[Translation missing --]]
L["SHARE_IMPORT_LABEL_ALREADY_EXISTS_CHECKBOX"] = "Cover and continue to import"
--[[Translation missing --]]
L["SHARE_IMPORT_LABEL_ALREADY_EXISTS_WARNING"] = "The matching mode existing script, and continue to import will cover the current script."
--[[Translation missing --]]
L["SHARE_IMPORT_LABEL_HAS_EXTRA"] = "This import string will import extra data in addition to just the script, depending on the script plugin. Usually, this is information about the corresponding team."
--[[Translation missing --]]
L["SHARE_IMPORT_PLUGIN_NOT_ENABLED"] = "Can't import: Plugin is not enabled."
--[[Translation missing --]]
L["SHARE_IMPORT_REINPUT_TEXT"] = "Re-edit"
--[[Translation missing --]]
L["SHARE_IMPORT_SCRIPT"] = "Import"
--[[Translation missing --]]
L["SHARE_IMPORT_SCRIPT_EXISTS"] = "Script exists"
--[[Translation missing --]]
L["SHARE_IMPORT_SCRIPT_NOT_IMPORT_STRING_WARNING"] = "You have entered the script and are advised to import using the Share string, although you can continue to import as well."
--[[Translation missing --]]
L["SHARE_IMPORT_SCRIPT_WELCOME"] = "Copy Share string or script to edit box."
--[[Translation missing --]]
L["SHARE_IMPORT_STRING_INCOMPLETE"] = "Share string data incomplete. But you can still import it."
--[[Translation missing --]]
L["TOOLTIP_CREATE_OR_DEBUG_SCRIPT"] = "Create or debug script"

