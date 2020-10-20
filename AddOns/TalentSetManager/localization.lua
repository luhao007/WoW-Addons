-- Talent Set Manager
-- by Vildiesel - EU Well of Eternity

local addonName, addonTable = ...

local locale = GetLocale()
addonTable.L = {}
local L = addonTable.L

--local debug
--[===[@debug@
--debug = true
--@end-debug@]===]

-- let's set them twice to be sure (in v1.1.5 the repository missed some languages)

--if debug then
 L["set_already_exists"] = "A talent set with that name already exists"
 L["sets_limit_reached"] = "You cannot create any more new talent sets."
 L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
 L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
 L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
 L["link_equipment"] = "Link Equipment"
 L["current_equipment"] = "Current: %s"
 L["equipment_menu_title1"] = "Select an equipment set to be equipped"
 L["equipment_menu_title2"] = "along with this set of talents:"
 L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
 L["no_talent_sets"] = "No %s talent sets available"
 L["macro_comment"] = "automatically generated, do not modify"
 L["macro_limit_reached"] = "Macro limit reached"
 L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
 L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
 L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
 L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
 L["not_available_in_combat"] = "Not available in combat"
 L["help_title1"] = "Right click to ignore tiers"
 L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
 L["talents_changed"] = "Talents Changed"
 
 L["options_talent_highlight_icon"] = "Talent Highlight Icon"
 L["options_chat_filter"] = "Talent chat message filter"
 L["options_chat_filter_show"] = "Do not filter"
 L["options_chat_filter_group"] = "Group into a single line"
 L["options_chat_filter_hide"] = "Hide entirely"
 L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
 L["options_hide_info_button"] = "Hide Info Button"
 L["options_auto_equip_chatmsg"] = "Chat notification"

 L["search_icon"] = "Search Icon"
 L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
 L["autoequip_equipment_msg"] = "Using equipment set %s"
 L["autoequip_specs_description"] = "Main talent group:"
 L["autoequip_no_linked_equip_found"] = "No linked equipment found"
 
 L["quick_talent_selection"] = "Quick Talent Selection"
 L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
 L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
 --return
--end

if locale == "esES" then 
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
--[[Translation missing --]]
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
--[[Translation missing --]]
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
--[[Translation missing --]]
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
--[[Translation missing --]]
L["current_equipment"] = "Current: %s"
--[[Translation missing --]]
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
--[[Translation missing --]]
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
--[[Translation missing --]]
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
--[[Translation missing --]]
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
--[[Translation missing --]]
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
--[[Translation missing --]]
L["equipment_menu_title2"] = "along with this set of talents:"
--[[Translation missing --]]
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
--[[Translation missing --]]
L["help_title1"] = "Right click to ignore tiers"
--[[Translation missing --]]
L["link_equipment"] = "Link Equipment"
--[[Translation missing --]]
L["macro_comment"] = "automatically generated, do not modify"
--[[Translation missing --]]
L["macro_limit_reached"] = "Macro limit reached"
--[[Translation missing --]]
L["no_talent_sets"] = "No %s talent sets available"
--[[Translation missing --]]
L["not_available_in_combat"] = "Not available in combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
--[[Translation missing --]]
L["set_already_exists"] = "A talent set with that name already exists"
--[[Translation missing --]]
L["sets_limit_reached"] = "You cannot create any more new talent sets."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

elseif locale == "esMX" then 
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
--[[Translation missing --]]
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
--[[Translation missing --]]
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
--[[Translation missing --]]
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
--[[Translation missing --]]
L["current_equipment"] = "Current: %s"
--[[Translation missing --]]
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
--[[Translation missing --]]
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
--[[Translation missing --]]
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
--[[Translation missing --]]
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
--[[Translation missing --]]
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
--[[Translation missing --]]
L["equipment_menu_title2"] = "along with this set of talents:"
--[[Translation missing --]]
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
--[[Translation missing --]]
L["help_title1"] = "Right click to ignore tiers"
--[[Translation missing --]]
L["link_equipment"] = "Link Equipment"
--[[Translation missing --]]
L["macro_comment"] = "automatically generated, do not modify"
--[[Translation missing --]]
L["macro_limit_reached"] = "Macro limit reached"
--[[Translation missing --]]
L["no_talent_sets"] = "No %s talent sets available"
--[[Translation missing --]]
L["not_available_in_combat"] = "Not available in combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
--[[Translation missing --]]
L["set_already_exists"] = "A talent set with that name already exists"
--[[Translation missing --]]
L["sets_limit_reached"] = "You cannot create any more new talent sets."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

elseif locale == "itIT" then 
L["autoequip_equipment_msg"] = "Utilizzando il set equipaggiamento %s"
L["autoequip_equipment_opt"] = "Indossa automaticamente l'equipaggiamento collegato quando cambi specializzazione"
L["autoequip_no_linked_equip_found"] = "Nessun collegamento ad un equipaggiamento trovato"
L["autoequip_specs_description"] = "Gruppo di talenti principale:"
L["confirm_delete_set"] = "Sei sicuro di voler eliminare il set di talenti %s?"
L["confirm_overwrite_set"] = "Hai già un set di talenti chiamato %s. Vuoi sovrascriverlo?"
L["confirm_save_set"] = "Vuoi salvare il set di talenti '%s'?"
L["current_equipment"] = "Attuale: %s"
L["custom_macro_desc_lc"] = "|cff00ffffClick-Sinistro|r per informazioni."
L["custom_macro_desc_rc"] = "|cff00ffffClick-Destro|r su questo pulsante per eliminare la macro"
L["custom_macro_desc1"] = "Per essere usato nelle barre delle azioni, un set di talenti ha bisogno di una propria macro."
L["custom_macro_desc2"] = "Trascinando il set di talenti ne verrà creata automaticamente una tra le macro del personaggio."
L["equipment_menu_title1"] = "Seleziona un set di equipaggiamento da indossare"
L["equipment_menu_title2"] = "insieme a questo set di talenti:"
L["equipment_not_found"] = "Il set di equipaggiamento %s non è stato trovato ed è stato scollegato dal set di talenti %s"
L["help_string1"] = "Facendo click-destro su qualsiasi talento nel Riquadro dei Talenti, la sua riga diventerà rossa e non verrà salvata tramite il pulsante 'Salva'. Imparando un set contenente righe ignorate, solo i talenti nelle righe disponibili (ovvero quelle senza lo sfondo rosso) saranno cambiati."
L["help_title1"] = "Click destro per ignorare righe di talenti"
L["link_equipment"] = "Collega equipaggiamento"
L["macro_comment"] = "generato automaticamente, non modificare"
L["macro_limit_reached"] = "Limite macro raggiunto"
L["no_talent_sets"] = "Nessun set di talenti %s disponibile"
L["not_available_in_combat"] = "Non disponibile in combattimento"
L["options_auto_equip_chatmsg"] = "Notifica in chat"
L["options_chat_filter"] = "Filtro dei messaggi in chat dei talenti"
L["options_chat_filter_group"] = "Raggruppa in una riga"
L["options_chat_filter_hide"] = "Nascondi del tutto"
L["options_chat_filter_show"] = "Non filtrare"
L["options_hide_info_button"] = "Nascondi Pulsante Info"
L["options_ignored_tiers_background_color"] = "Colore di sfondo delle righe ignorate"
L["options_talent_highlight_icon"] = "Icona dei talenti evidenziati"
L["quick_talent_selection"] = "Selezione Rapida Talenti"
L["quick_talent_selection_canchange"] = "|cff00ff00I talenti possono essere modificati|r"
L["quick_talent_selection_cannotchange"] = "|cffff0000I talenti non possono essere modificati|r"
L["search_icon"] = "Cerca Icona"
L["set_already_exists"] = "Un set di talenti con quel nome esiste già."
L["sets_limit_reached"] = "Non puoi creare ulteriori set di talenti."
L["talents_changed"] = "Talenti Cambiati"

elseif locale == "ptBR" then 
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
--[[Translation missing --]]
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
--[[Translation missing --]]
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
--[[Translation missing --]]
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
--[[Translation missing --]]
L["current_equipment"] = "Current: %s"
--[[Translation missing --]]
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
--[[Translation missing --]]
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
--[[Translation missing --]]
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
--[[Translation missing --]]
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
--[[Translation missing --]]
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
--[[Translation missing --]]
L["equipment_menu_title2"] = "along with this set of talents:"
--[[Translation missing --]]
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
--[[Translation missing --]]
L["help_title1"] = "Right click to ignore tiers"
--[[Translation missing --]]
L["link_equipment"] = "Link Equipment"
--[[Translation missing --]]
L["macro_comment"] = "automatically generated, do not modify"
--[[Translation missing --]]
L["macro_limit_reached"] = "Macro limit reached"
--[[Translation missing --]]
L["no_talent_sets"] = "No %s talent sets available"
--[[Translation missing --]]
L["not_available_in_combat"] = "Not available in combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
--[[Translation missing --]]
L["set_already_exists"] = "A talent set with that name already exists"
--[[Translation missing --]]
L["sets_limit_reached"] = "You cannot create any more new talent sets."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

elseif locale == "frFR" then
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
L["confirm_delete_set"] = "Êtes-vous sûr de vouloir supprimer l'ensemble des talents %s?"
L["confirm_overwrite_set"] = "Vous avez déjà un ensemble de talents nommé %s. Voulez-vous le remplacer?"
L["confirm_save_set"] = "Voulez-vous enregistrer l'ensemble des talents '%s'?"
L["current_equipment"] = "Actuellement: %s"
L["custom_macro_desc_lc"] = "|cff00ffffClic gauche|r pour plus d'info."
L["custom_macro_desc_rc"] = "|cff00ffffClic droit|r pour supprimer la macro"
L["custom_macro_desc1"] = "Pour être utilisé dans les barres d'action, un ensemble de talents a besoin de sa propre macro."
L["custom_macro_desc2"] = "Faire glisser l'ensemble des talents, crée automatiquement dans vos macros."
L["equipment_menu_title1"] = "Sélectionnez un équipement prévu pour être équipé"
L["equipment_menu_title2"] = "ainsi que cet ensemble de talents:"
L["equipment_not_found"] = "L'équipement %s n'a pas été trouvé et a été dissocié de l'ensemble des talents %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
L["help_title1"] = "Clic droit pour ignorer les niveaux"
L["link_equipment"] = "Lien équipement"
L["macro_comment"] = "généré automatiquement, ne pas modifier"
L["macro_limit_reached"] = "Limite atteinte pour la macro"
L["no_talent_sets"] = "Le talent %s est disponible"
L["not_available_in_combat"] = "Pas dispo en combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
L["set_already_exists"] = "Un talent avec ce nom existe déjà"
L["sets_limit_reached"] = "Vous ne pouvez pas créer de nouveaux ensembles de talents."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

elseif locale == "deDE" then 
L["autoequip_equipment_msg"] = "Ausrüstungsset %s wird genutzt"
L["autoequip_equipment_opt"] = "Verknüpfte Ausrüstung bei Spezialisierungswechsel automatisch anlegen"
L["autoequip_no_linked_equip_found"] = "Es wurde keine verknüpfte Ausrüstung gefunden"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
L["confirm_delete_set"] = "Soll das Talentset \"%s\" wirklich gelöscht werden?"
L["confirm_overwrite_set"] = "Ein Talentset mit dem Namen \"%s\" existiert bereits. Möchtest du es überschreiben?"
L["confirm_save_set"] = "Soll das Talentset \"%s\" gespeichert werden?"
L["current_equipment"] = "Momentan: %s"
L["custom_macro_desc_lc"] = "|cff00ffffLinksklick|r für mehr Informationen."
L["custom_macro_desc_rc"] = "|cff00ffffRechtsklick|r auf diesen Button, um das Makro zu löschen"
L["custom_macro_desc1"] = "Zur Verwendung in Aktionsleisten, ein Talentset benötigt ein eigenes Makro."
L["custom_macro_desc2"] = "Das Verschieben eines Talentsets erstellt automatisch ein charakterspezifisches Makro."
L["equipment_menu_title1"] = "Wähle das Ausrüstungsset, das zusammen mit dieser "
L["equipment_menu_title2"] = "Zusammenstellung der Talente angelegt werden soll:"
L["equipment_not_found"] = "Das Ausrüstungsset %s wurde nicht gefunden und wurde daher vom Talentset %s getrennt"
L["help_string1"] = "Du kannst auf ein beliebiges Talent im Talentfenster mit der rechten Maustaste klicken, um diese Talentstufe nicht zu speichern, wenn du auf den Speichern-Knopf drückst (dies wird durch den roten Hintergrund einer Stufe angezeigt). Wenn du ein Set erlernst, das ignorierte Talentstufen enthält, werden nur die Talente in den verfügbaren Stufen (nur die Talente, deren Hintergrund nicht rot ist) geändert."
L["help_title1"] = "Rechtsklick, um diese Stufe zu ignorieren"
L["link_equipment"] = "Ausrüstung verknüpfen"
L["macro_comment"] = "automatisch erzeugt, nicht verändern"
L["macro_limit_reached"] = "Maximale Makroanzahl erreicht"
L["no_talent_sets"] = "Keine %s-Talentsets vorhanden"
L["not_available_in_combat"] = "Im Kampf nicht verfügbar"
L["options_auto_equip_chatmsg"] = "Chatbenachrichtigung"
L["options_chat_filter"] = "Talentbezogene Nachrichten filtern "
L["options_chat_filter_group"] = "Einzeilig ausgeben"
L["options_chat_filter_hide"] = "Vollständig ausblenden"
L["options_chat_filter_show"] = "Nicht filtern"
L["options_hide_info_button"] = "Infobutton ausblenden"
L["options_ignored_tiers_background_color"] = "Hintergrundfarbe ignorierter Stufen"
L["options_talent_highlight_icon"] = "Talenthervorhebungssymbol"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
L["quick_talent_selection_canchange"] = "|cff00ff00Talente können geändert werden|r"
L["quick_talent_selection_cannotchange"] = "|cffff0000Talente können nicht geändert werden|r"
L["search_icon"] = "Nach Symbol suchen"
L["set_already_exists"] = "Ein Talentset mit diesem Namen existiert bereits."
L["sets_limit_reached"] = "Es können keine weiteren Talentsets angelegt werden."
L["talents_changed"] = "Talente geändert"

elseif locale == "ruRU" then 
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
L["confirm_delete_set"] = "Вы уверены, что хотите удалить набор талантов %s?"
L["confirm_overwrite_set"] = "Набор талантов с именем %s уже существует. Перезаписать его?"
L["confirm_save_set"] = "Сохранить набор талантов '%s'?"
L["current_equipment"] = "Текущий: %s"
L["custom_macro_desc_lc"] = "|cff00ffffЛевый клик:|r подробнее..."
L["custom_macro_desc_rc"] = "|cff00ffffПравый клик|r чтобы удалить макрос"
L["custom_macro_desc1"] = "Набору талантов необходим отдельный макрос, чтобы быть использованным на панелях действий"
L["custom_macro_desc2"] = "При перетаскивании набора талантов будет автоматически создан макрос для вашего персонажа."
L["equipment_menu_title1"] = "Выберите набор экипировки, который будет надет"
L["equipment_menu_title2"] = "с этим набором талантов:"
L["equipment_not_found"] = "Набор экипировки %s не был найден и был отвязан от набора талантов %s"
L["help_string1"] = "Если нажать правой кнопкой по любому таланту в окне талантов, ряд этого таланта подсветится красным и не будет сохранен при нажатии на кнопку \"сохранить\". При применении набора талантов, который содержит игнорируемые ряды, только ряды талантов без красной подсветки будут изменены."
L["help_title1"] = "Правый клик чтобы игнорировать ряд"
L["link_equipment"] = "Связать с набором экипировки"
L["macro_comment"] = "создан автоматически, не изменять"
L["macro_limit_reached"] = "Достигнут лимит макросов"
L["no_talent_sets"] = "Нет ни одного набора талантов для %s "
L["not_available_in_combat"] = "Недоступно в бою"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
L["options_chat_filter"] = "Фильтр для сообщений в чате о талантах"
L["options_chat_filter_group"] = "Сгруппировать в одну строку"
L["options_chat_filter_hide"] = "Полностью скрыть"
L["options_chat_filter_show"] = "Не фильтровать"
L["options_hide_info_button"] = "Скрыть кнопку инфо"
L["options_ignored_tiers_background_color"] = "Цвет фона игнорируемых рядов"
L["options_talent_highlight_icon"] = "Иконка для выделяемого таланта"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
L["search_icon"] = "Поиск иконок"
L["set_already_exists"] = "Набор талантов с этим именем уже существует"
L["sets_limit_reached"] = "Вы не можете создать больше наборов талантов"
L["talents_changed"] = "Таланты изменены"

elseif locale == "zhCN" then 
L["autoequip_equipment_msg"] = "使用装备方案 %s"
L["autoequip_equipment_opt"] = "切换专精后自动穿上相关装备"
L["autoequip_no_linked_equip_found"] = "未发现相关装备"
L["autoequip_specs_description"] = "主天赋群组："
--[[Translation missing --]]
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
--[[Translation missing --]]
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
--[[Translation missing --]]
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
--[[Translation missing --]]
L["current_equipment"] = "Current: %s"
--[[Translation missing --]]
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
--[[Translation missing --]]
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
--[[Translation missing --]]
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
--[[Translation missing --]]
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
--[[Translation missing --]]
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
--[[Translation missing --]]
L["equipment_menu_title2"] = "along with this set of talents:"
--[[Translation missing --]]
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
--[[Translation missing --]]
L["help_title1"] = "Right click to ignore tiers"
--[[Translation missing --]]
L["link_equipment"] = "Link Equipment"
--[[Translation missing --]]
L["macro_comment"] = "automatically generated, do not modify"
--[[Translation missing --]]
L["macro_limit_reached"] = "Macro limit reached"
--[[Translation missing --]]
L["no_talent_sets"] = "No %s talent sets available"
--[[Translation missing --]]
L["not_available_in_combat"] = "Not available in combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
--[[Translation missing --]]
L["set_already_exists"] = "A talent set with that name already exists"
--[[Translation missing --]]
L["sets_limit_reached"] = "You cannot create any more new talent sets."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

elseif locale == "zhTW" then 
L["autoequip_equipment_msg"] = "使用套裝設定 %s"
L["autoequip_equipment_opt"] = "當改變專精時自動穿上連結的套裝"
L["autoequip_no_linked_equip_found"] = "未找到連結的套裝"
L["autoequip_specs_description"] = "主天賦群組:"
L["confirm_delete_set"] = "你確定要刪除此天賦設定 %s嗎？"
L["confirm_overwrite_set"] = "你已經有個天賦設定名為 %s，你想要覆寫它嗎？"
L["confirm_save_set"] = "你想要儲存天賦設定'%s'嗎？"
L["current_equipment"] = "目前：%s"
L["custom_macro_desc_lc"] = "|cff00ffff左鍵點擊|r獲得更多資訊。"
L["custom_macro_desc_rc"] = "|cff00ffff右鍵點擊|r此按鈕以刪除巨集"
L["custom_macro_desc1"] = "要使用在快捷列上，一個天賦設定需要有它自己的巨集。"
L["custom_macro_desc2"] = "拖曳此天賦設定，自動建立你角色專屬的巨集。"
L["equipment_menu_title1"] = "選擇一個套裝設定來裝備"
L["equipment_menu_title2"] = "天賦單獨的套裝設定："
L["equipment_not_found"] = "此套裝設定 %s 沒找到並且未連結至天賦 %s"
L["help_string1"] = "在天賦視窗中藉由右鍵點擊任何天賦，它的套裝背景將會變回紅色並且按下儲存按鈕也不會儲存。當學習一個設定包含忽略的套裝，只有此天賦有可用的套裝 (例如：有一個設定沒有紅色背景的)會被更換。"
L["help_title1"] = "右鍵點擊來忽略套裝"
L["link_equipment"] = "連結裝備"
L["macro_comment"] = "已自動生成，請勿修改"
L["macro_limit_reached"] = "巨集限制已達"
L["no_talent_sets"] = "無 %s 天賦設定可用"
L["not_available_in_combat"] = "戰鬥中不可使用"
L["options_auto_equip_chatmsg"] = "聊天提醒"
L["options_chat_filter"] = "天賦聊天訊息過濾"
L["options_chat_filter_group"] = "群組縮為單行"
L["options_chat_filter_hide"] = "完全隱藏"
L["options_chat_filter_show"] = "不過濾"
L["options_hide_info_button"] = "隱藏資訊按鈕"
L["options_ignored_tiers_background_color"] = "忽略套裝背景顏色"
L["options_talent_highlight_icon"] = "天賦高亮圖示"
L["quick_talent_selection"] = "快速選擇天賦"
L["quick_talent_selection_canchange"] = "|cff00ff00天賦可以更改|r"
L["quick_talent_selection_cannotchange"] = "|cffff0000天賦無法更改|r"
L["search_icon"] = "搜尋圖標"
L["set_already_exists"] = "此天賦設定的名稱已經存在"
L["sets_limit_reached"] = "你不能在創建更多新天賦設定。"
L["talents_changed"] = "天賦已改變"

elseif locale == "koKR" then
--[[Translation missing --]]
L["autoequip_equipment_msg"] = "Using equipment set %s"
--[[Translation missing --]]
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
--[[Translation missing --]]
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
--[[Translation missing --]]
L["autoequip_specs_description"] = "Main talent group:"
--[[Translation missing --]]
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
--[[Translation missing --]]
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
--[[Translation missing --]]
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
--[[Translation missing --]]
L["current_equipment"] = "Current: %s"
--[[Translation missing --]]
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
--[[Translation missing --]]
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
--[[Translation missing --]]
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
--[[Translation missing --]]
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
--[[Translation missing --]]
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
--[[Translation missing --]]
L["equipment_menu_title2"] = "along with this set of talents:"
--[[Translation missing --]]
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
--[[Translation missing --]]
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
--[[Translation missing --]]
L["help_title1"] = "Right click to ignore tiers"
--[[Translation missing --]]
L["link_equipment"] = "Link Equipment"
--[[Translation missing --]]
L["macro_comment"] = "automatically generated, do not modify"
--[[Translation missing --]]
L["macro_limit_reached"] = "Macro limit reached"
--[[Translation missing --]]
L["no_talent_sets"] = "No %s talent sets available"
--[[Translation missing --]]
L["not_available_in_combat"] = "Not available in combat"
--[[Translation missing --]]
L["options_auto_equip_chatmsg"] = "Chat notification"
--[[Translation missing --]]
L["options_chat_filter"] = "Talent chat message filter"
--[[Translation missing --]]
L["options_chat_filter_group"] = "Group into a single line"
--[[Translation missing --]]
L["options_chat_filter_hide"] = "Hide entirely"
--[[Translation missing --]]
L["options_chat_filter_show"] = "Do not filter"
--[[Translation missing --]]
L["options_hide_info_button"] = "Hide Info Button"
--[[Translation missing --]]
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
--[[Translation missing --]]
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
--[[Translation missing --]]
L["quick_talent_selection"] = "Quick Talent Selection"
--[[Translation missing --]]
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
--[[Translation missing --]]
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
--[[Translation missing --]]
L["search_icon"] = "Search Icon"
--[[Translation missing --]]
L["set_already_exists"] = "A talent set with that name already exists"
--[[Translation missing --]]
L["sets_limit_reached"] = "You cannot create any more new talent sets."
--[[Translation missing --]]
L["talents_changed"] = "Talents Changed"

else -- enUS
L["autoequip_equipment_msg"] = "Using equipment set %s"
L["autoequip_equipment_opt"] = "Automatically wear linked equipment when changing specialization"
L["autoequip_no_linked_equip_found"] = "No linked equipment found"
L["autoequip_specs_description"] = "Main talent group:"
L["confirm_delete_set"] = "Are you sure you want to delete the talent set %s?"
L["confirm_overwrite_set"] = "You already have a talent set named %s. Would you like to overwrite it?"
L["confirm_save_set"] = "Would you like to save the talent set '%s'?"
L["current_equipment"] = "Current: %s"
L["custom_macro_desc_lc"] = "|cff00ffffLeft-Click|r for more info."
L["custom_macro_desc_rc"] = "|cff00ffffRight-Click|r this button to delete the macro"
L["custom_macro_desc1"] = "To be used in actionbars, a talent set needs its own macro."
L["custom_macro_desc2"] = "Dragging the talent set, automatically creates it in your character macros."
L["equipment_menu_title1"] = "Select an equipment set to be equipped"
L["equipment_menu_title2"] = "along with this set of talents:"
L["equipment_not_found"] = "The equipment set %s was not found and has been unlinked from the talent set %s"
L["help_string1"] = "By right-clicking on any talent in the Talent Frame, its tier's background will become red and will not be saved when clicking the save button. When learning a set containing ignored tiers, only the talents on the available tiers (i.e. the ones that don't have a red background) will be changed."
L["help_title1"] = "Right click to ignore tiers"
L["link_equipment"] = "Link Equipment"
L["macro_comment"] = "automatically generated, do not modify"
L["macro_limit_reached"] = "Macro limit reached"
L["no_talent_sets"] = "No %s talent sets available"
L["not_available_in_combat"] = "Not available in combat"
L["options_auto_equip_chatmsg"] = "Chat notification"
L["options_chat_filter"] = "Talent chat message filter"
L["options_chat_filter_group"] = "Group into a single line"
L["options_chat_filter_hide"] = "Hide entirely"
L["options_chat_filter_show"] = "Do not filter"
L["options_hide_info_button"] = "Hide Info Button"
L["options_ignored_tiers_background_color"] = "Ignored tiers background color"
L["options_talent_highlight_icon"] = "Talent Highlight Icon"
L["quick_talent_selection"] = "Quick Talent Selection"
L["quick_talent_selection_canchange"] = "|cff00ff00Talents can be changed|r"
L["quick_talent_selection_cannotchange"] = "|cffff0000Talents cannot be changed|r"
L["search_icon"] = "Search Icon"
L["set_already_exists"] = "A talent set with that name already exists"
L["sets_limit_reached"] = "You cannot create any more new talent sets."
L["talents_changed"] = "Talents Changed"

end
