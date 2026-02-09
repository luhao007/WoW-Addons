local _, ADDON = ...

local locale = GetLocale()

ADDON.L = {}
local L = ADDON.L
local GetSpellName = C_Spell.GetSpellName or GetSpellInfo

L["COMPARTMENT_TOOLTIP"] = "|cffeda55fLeft-Click|r to toggle showing the Toy Box.\n|cffeda55fRight-Click|r to open addon options."
L["FAVOR_DISPLAYED"] = "All Displayed"
L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."
L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"
L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."
L["Reset filters"] = "Reset filters"
L["Toys"] = "Toys"
L["Usable"] = "Usable"
L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"
L["FILTER_ONLY_LATEST"] = "Only latest additions"
L["FILTER_ONLY_TRADABLE"] = "Only tradable"
L["FILTER_SECRET"] = "Hidden in game"
L["FILTER_ONLY"] = "only"
L["SORT_FAVORITES_FIRST"] = "Favorites First"
L["SORT_REVERSE"] = "Reverse Sort"
L["SORT_UNOWNED_AFTER"] = "Unowned at Last"
L["FAVORITE_PROFILE"] = "Profile"
L["FAVORITE_ACCOUNT_PROFILE"] = "Account"
L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"
L["CONFIRM_FAVORITE_PROFILE_DELETION"] = "Are you sure you want to delete the profile \"%s\"?\nAll current character assignments will be reset to the default profile \"%s\"."
L["FAVOR_AUTO"] = "Add new toys automatically"
L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."
L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."
L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."
L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."

-- Settings
L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"

-- Source
L["Treasure"] = GetSpellName(225652)
L["Drop"] = BATTLE_PET_SOURCE_1
L["Quest"] = BATTLE_PET_SOURCE_2
L["Vendor"] = BATTLE_PET_SOURCE_3
L["Instance"] = INSTANCE
L["Reputation"] = REPUTATION
L["Achievement"] = BATTLE_PET_SOURCE_6
L["PvP"] = PVP
L["Order Hall"] = "Order Hall"
L["Garrison"] = GARRISON_LOCATION_TOOLTIP
L["Pick Pocket"] = GetSpellName(921)
L["Trading Post"] = BATTLE_PET_SOURCE_12
L["Black Market"] = BLACK_MARKET_AUCTION_HOUSE
L["Promotion"] = BATTLE_PET_SOURCE_10
L["Shop"] = BATTLE_PET_SOURCE_8
L["Unavailable"] = "No more available"

-- Professions
L["Archaeology"] = PROFESSIONS_ARCHAEOLOGY
L["Cooking"] = PROFESSIONS_COOKING
L["Enchanting"] = GetSpellName(7411)
L["Engineering"] = GetSpellName(4036)
L["Fishing"] = PROFESSIONS_FISHING
L["Inscription"] = INSCRIPTION
L["Jewelcrafting"] = GetSpellName(25229)
L["Leatherworking"] = GetSpellName(2108)
L["Tailoring"] = GetSpellName(3908)

-- World events
L["Brewfest"] = GetCategoryInfo(162)
L["Children's Week"] = GetCategoryInfo(163)
L["Darkmoon Faire"] = CALENDAR_FILTER_DARKMOON
L["Day of the Dead"] = "Day of the Dead"
L["Feast of Winter Veil"] = GetCategoryInfo(156)
L["Hallow's End"] = GetCategoryInfo(158)
L["Love is in the Air"] = GetCategoryInfo(187)
L["Lunar Festival"] = GetCategoryInfo(160)
L["Midsummer Fire Festival"] = GetCategoryInfo(161)
L["Noblegarden"] = GetCategoryInfo(159)
L["Pilgrim's Bounty"] = GetCategoryInfo(14981)
L["Pirates' Day"] = "Pirates' Day"
L["Secrets of Azeroth"] = "Secrets of Azeroth"
L["Timewalking"] = PLAYER_DIFFICULTY_TIMEWALKER

-- Effects
L["Act"] = "Act"
L["Aircraft"] = "Aircraft"
L["Alcohol"] = "Alcohol"
L["Appearance"] = "Appearance"
L["Ashran"] = WORLD_PVP
L["Banner"] = "Banner"
L["Battle Pet"] = TOOLTIP_BATTLE_PET
L["Bigger"] = "Bigger"
L["Chair"] = "Chair"
L["Cinematics"] = CINEMATICS
L["Clickable"] = "Clickable"
L["Clone"] = "Clone"
L["Co-op"] = "Co-op"
L["Color"] = COLOR
L["Companion"] = COMPANIONS
L["Consumable"] = "Consumable"
L["Controller"] = "Controller"
L["Cooking"] = PROFESSIONS_COOKING
L["Corpse"] = CORPSE
L["Critter"] = BATTLE_PET_NAME_5
L["Dismount"] = BINDING_NAME_DISMOUNT
L["Effect"] = "Effect"
L["Emote"] = EMOTE
L["Environment"] = ENVIRONMENT_SUBHEADER
L["Firework"] = GetSpellName(25465)
L["Fishing"] = PROFESSIONS_FISHING
L["Fly/Fall"] = "Fly/Fall"
L["Food/Water"] = MINIMAP_TRACKING_VENDOR_FOOD
L["Full"] = LOC_TYPE_FULL
L["Game"] = GAME
L["Ground"] = "Ground"
L["Jump"] = NPE_JUMP
L["Hearthstone"] = GetSpellName(8690)
L["Interactable"] = "Interactable"
L["Mail"] = MAIL_LABEL
L["Maps"] = "Maps"
L["Minor"] = "Minor"
L["Mount"] = MOUNT
L["Music"] = VOICE_MUSIC
L["NPC"] = "NPC"
L["Nearby"] = "Nearby"
L["Other"] = OTHER
L["PVP"] = PVP
L["Pennant"] = "Pennant"
L["Perception"] = ITEM_MOD_PERCEPTION_SHORT
L["Profession"] = BATTLE_PET_SOURCE_4
L["Roll"] = ROLL
L["Running"] = GetSpellName(114907)
L["Skinning"] = GetSpellName(8613)
L["Smaller"] = "Smaller"
L["Solo"] = SOLO
L["Sound"] = SOUND
L["Statue"] = GetSpellName(88640) or GetSpellName(74890)
L["Summon"] = SUMMON
L["Swimming"] = GetSpellName(333688)
L["Target Dummy"] = GetSpellName(4071)
L["Taunt"] = GetSpellName(355)
L["Teleport"] = GetSpellName(53053)
L["Tonk"] = "Tonk"
L["Transform"] = GetSpellName(39360)
L["Transportation"] = "Transportation"
L["Vision"] = "Vision"
L["Voice"] = "Voice"
L["Water Walking"] = GetSpellName(546)
L["Weather"] = PET_BATTLE_WEATHER_LABEL

if locale == "deDE" then
    L["ASK_FAVORITE_PROFILE_NAME"] = "Name des Profiles eingeben:"
L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLinksklick|r um Spielzeugsammlung anzuzeigen.
|cffeda55fRechtsklick|r um Addon-Optionen zu öffnen.]=]
L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Möchtest du wirklich das Profil "%s" entfernen?
Alle bisherigen zugewiesenen Charaktere werden auf das Standardprofil "%s" zurückgesetzt.]=]
L["Day of the Dead"] = "Tag der Toten"
L["FAVOR_AUTO"] = "Neue Spielzeuge automatisch hinzufügen"
L["FAVOR_DISPLAYED"] = "Alle Angezeigten Wählen"
L["FAVORITE_ACCOUNT_PROFILE"] = "Account"
L["FAVORITE_PROFILE"] = "Profil"
L["FILTER_HIDDEN_MANUAL"] = "Ausgeblendet von mir"
L["FILTER_ONLY"] = "nur"
L["FILTER_ONLY_LATEST"] = "Nur Neuzugänge"
L["FILTER_ONLY_TRADABLE"] = "Nur handelbare"
L["FILTER_SECRET"] = "Ausgeblendet vom Spiel"
L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Bitte wähle ein oder mehrere Spielzeuge als Favoriten aus."
L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLinksklick|r um Spielzeugkiste zu öffnen."
L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRechtsklick|r um Profil zu wechseln."
L["LDB_TIP_NO_FAVORITES_TITLE"] = "Du hast noch keine Favoriten ausgewählt."
L["Pirates' Day"] = "Piratentag"
L["RANDOM_TOY_DESCRIPTION"] = "Das Spielzeug wird zufällig aus den Favoriten ausgewählt."
L["RANDOM_TOY_LOCKED"] = "Zum freischalten bitte mindestens ein gesammeltes Spielzeug als Favorit setzen."
L["RANDOM_TOY_TITLE"] = "Zufälliges Lieblingsspielzeug benutzen"
L["Reset filters"] = "Filter zurücksetzen"
L["Secrets of Azeroth"] = "Geheimnisse von Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoriten zuerst"
L["SORT_REVERSE"] = "Sortierung umkehren"
L["SORT_UNOWNED_AFTER"] = "Nicht gesammelt nach hinten"
L["Toys"] = "Spielzeuge"
L["Usable"] = "Benutzbar"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Aktiviere Links- und Rechtspfeiltaste zum Durchblättern"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Suche auch im Beschreibungstext"

    -- Source
L["Order Hall"] = "Ordenshalle"
L["Unavailable"] = "Nicht mehr verfügbar"

    -- Effects
L["Act"] = "Verhalten"
L["Aircraft"] = "Fluggerät"
L["Alcohol"] = "Alkohol"
L["Appearance"] = "Aussehen"
L["Banner"] = "Banner"
L["Bigger"] = "Größer"
L["Chair"] = "Sitz"
L["Clickable"] = "Anklickbar"
L["Clone"] = "Ebenbild"
L["Consumable"] = "Verbrauchsgut"
L["Controller"] = "Steuerung"
L["Co-op"] = "Kooperativ"
L["Effect"] = "Effekt"
L["Fly/Fall"] = "Flug/Fall"
L["Ground"] = "Bodenobjekt"
L["Interactable"] = "Interagierbar"
L["Maps"] = "Karten"
L["Minor"] = "Teilweise"
L["Nearby"] = "In der Nähe"
L["NPC"] = "NSC"
L["Pennant"] = "Banner"
L["Smaller"] = "Kleiner"
L["Tonk"] = "Bodenfahrzeug"
L["Transportation"] = "Transport"
L["Vision"] = "Sicht"
L["Voice"] = "Stimme"

elseif locale == "esES" then
    L["ASK_FAVORITE_PROFILE_NAME"] = "Introduce el nombre del perfil:"
L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fClick-Izquierdo|r para ver/ocultar la colección de monturas.
|cffeda55fClick-Derecho|r para abrir las opciones del addon.]=]
L["CONFIRM_FAVORITE_PROFILE_DELETION"] = "¿Estás seguro de querer borrar el perfil \"%s\"? Todas las asignaciones de personajes actuales se restablecerán al perfil predeterminado \"%s\"."
L["Day of the Dead"] = "Día de los Muertos"
L["FAVOR_AUTO"] = "Añadir nuevos juguetes automáticamente"
L["FAVOR_DISPLAYED"] = "Todo mostrado"
L["FAVORITE_ACCOUNT_PROFILE"] = "Cuenta"
L["FAVORITE_PROFILE"] = "Perfil"
L["FILTER_HIDDEN_MANUAL"] = "Oculto por mi"
L["FILTER_ONLY"] = "sólo"
L["FILTER_ONLY_LATEST"] = "Sólo los últimos añadidos"
L["FILTER_ONLY_TRADABLE"] = "Sólo comerciable"
L["FILTER_SECRET"] = "Oculto en el juego"
L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Establece como favorito al menos un juguete coleccionado."
L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fClick izquierdo|r para abrir Toy Box."
L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fClick derecho|r para seleccionar un perfil distinto como favorito."
L["LDB_TIP_NO_FAVORITES_TITLE"] = "Aún no has seleccionado ningún juguete como favorito."
L["Pirates' Day"] = "Día de los Piratas"
L["RANDOM_TOY_DESCRIPTION"] = "El juguete se elegirá al azar de tus favoritos."
L["RANDOM_TOY_LOCKED"] = "Marca al menos un juguete coleccionado para desbloquear."
L["RANDOM_TOY_TITLE"] = "Usa un juguete favorito al azar"
L["Reset filters"] = "Reiniciar Filtros"
L["Secrets of Azeroth"] = "Secretos de Azeroth"
L["SORT_FAVORITES_FIRST"] = "Los favoritos primero"
L["SORT_REVERSE"] = "Ordenación inversa"
L["SORT_UNOWNED_AFTER"] = "Los que no se tienen al final"
L["Toys"] = "Juguetes"
L["Usable"] = "Utilizable"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Activa los cursores Izquierdo y Derecho para pasar páginas"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Buscar también en la descripción del juguete"

    -- Source
L["Order Hall"] = "Sede de la Orden"
L["Unavailable"] = "Ya no está disponible"

    -- Effects
L["Act"] = "Actos"
L["Aircraft"] = "Aeronaves"
L["Alcohol"] = "Alcohol"
L["Appearance"] = "Apariencia"
L["Banner"] = "Bandera"
L["Bigger"] = "Mayor"
L["Chair"] = "Sillas"
L["Clickable"] = "Clickables"
L["Clone"] = "Clones"
L["Consumable"] = "Consumibles"
L["Controller"] = "Controladores"
L["Co-op"] = "Co-operativos"
L["Effect"] = "Efecto"
L["Fly/Fall"] = "Voladores"
L["Ground"] = "Terrestres"
L["Interactable"] = "Interactibables"
L["Maps"] = "Mapas"
L["Minor"] = "Menor"
L["Nearby"] = "Cercanos"
L["NPC"] = "NPC"
L["Pennant"] = "Pendiente"
L["Smaller"] = "Más pequeño"
L["Tonk"] = "Tanques"
L["Transportation"] = "Transportes"
L["Vision"] = "Visiones"
L["Voice"] = "Voces"

elseif locale == "esMX" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
--[[Translation missing --]]
--[[ L["Day of the Dead"] = "Day of the Dead"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
--[[Translation missing --]]
--[[ L["Pirates' Day"] = "Pirates' Day"--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]] 
--[[Translation missing --]]
--[[ L["Reset filters"] = "Reset filters"--]] 
--[[Translation missing --]]
--[[ L["Secrets of Azeroth"] = "Secrets of Azeroth"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
--[[Translation missing --]]
--[[ L["Toys"] = "Toys"--]] 
--[[Translation missing --]]
--[[ L["Usable"] = "Usable"--]] 

    -- Settings
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
--[[Translation missing --]]
--[[ L["Order Hall"] = "Order Hall"--]] 
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "frFR" then
    L["ASK_FAVORITE_PROFILE_NAME"] = "Saisir le nom du profil :"
L["COMPARTMENT_TOOLTIP"] = [=[Faites un |cffeda55fclic gauche|r pour afficher le Coffre à jouets. 
Faites un |cffeda55fclic droit|r pour ouvrir les options de l'addon.]=]
L["CONFIRM_FAVORITE_PROFILE_DELETION"] = "Êtes-vous sûr de vouloir supprimer le profil \"%s\" ? Toutes les configurations du personnage actuel seront réinitialisées selon le profil par défaut \"%s\"."
L["Day of the Dead"] = "Jour des morts"
L["FAVOR_AUTO"] = "Ajouter automatiquement les nouveaux jouets"
L["FAVOR_DISPLAYED"] = "Tous les affichés"
L["FAVORITE_ACCOUNT_PROFILE"] = "Compte"
L["FAVORITE_PROFILE"] = "Profil"
L["FILTER_HIDDEN_MANUAL"] = "Caché par moi"
L["FILTER_ONLY"] = "seulement"
L["FILTER_ONLY_LATEST"] = "Uniquement les derniers ajouts"
L["FILTER_ONLY_TRADABLE"] = "Uniquement échangeable"
L["FILTER_SECRET"] = "Caché dans le jeu"
L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Veuillez mettre en favoris au moins un jouet possédé."
L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "Faites un |cffeda55fclic gauche|r pour ouvrir le Coffre à jouets."
L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "Faites un |cffeda55fclic droit|r pour sélectionner un autre profil favori."
L["LDB_TIP_NO_FAVORITES_TITLE"] = "Vous n'avez encore choisi aucun jouet comme favori."
L["Pirates' Day"] = "Jour des pirates"
L["RANDOM_TOY_DESCRIPTION"] = "Le jouet sera choisi au hasard parmi vos favoris."
L["RANDOM_TOY_LOCKED"] = "Marquez au moins un jouet collecté comme favori pour débloquer le bouton."
L["RANDOM_TOY_TITLE"] = "Utiliser un jouet favori au hasard"
L["Reset filters"] = "Réinitialiser les filtres"
L["Secrets of Azeroth"] = "Secrets d’Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoris en premier"
L["SORT_REVERSE"] = "Tri inversé"
L["SORT_UNOWNED_AFTER"] = "Non possédés en dernier"
L["Toys"] = "Jouets"
L["Usable"] = "Utilisable"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Activer les touches Gauche et Droite pour tourner les pages"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Rechercher également dans la description du jouet"

    -- Source
L["Order Hall"] = "Domaine de classe"
L["Unavailable"] = "Plus disponible"

    -- Effects
L["Act"] = "Action"
L["Aircraft"] = "Avion"
L["Alcohol"] = "Alcool"
L["Appearance"] = "Apparence"
L["Banner"] = "Bannière"
L["Bigger"] = "Plus gros"
L["Chair"] = "Siège"
L["Clickable"] = "Cliquable"
L["Clone"] = "Clone"
L["Consumable"] = "Consommable"
L["Controller"] = "Manette"
L["Co-op"] = "Coopératif"
L["Effect"] = "Effet"
L["Fly/Fall"] = "Voler/Tomber"
L["Ground"] = "Sol"
L["Interactable"] = "Interactable"
L["Maps"] = "Cartes"
L["Minor"] = "Mineure"
L["Nearby"] = "Proche"
L["NPC"] = "PNJ"
L["Pennant"] = "Pennon"
L["Smaller"] = "Plus petit"
L["Tonk"] = "Tank"
L["Transportation"] = "Transport"
L["Vision"] = "Vision"
L["Voice"] = "Voix"

elseif locale == "itIT" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
--[[Translation missing --]]
--[[ L["Day of the Dead"] = "Day of the Dead"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
--[[Translation missing --]]
--[[ L["FAVOR_DISPLAYED"] = "All Displayed"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
--[[Translation missing --]]
--[[ L["Pirates' Day"] = "Pirates' Day"--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_DESCRIPTION"] = "The toy will be chosen randomly from your favorites."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
--[[Translation missing --]]
--[[ L["RANDOM_TOY_TITLE"] = "Use Random Favorite Toy"--]] 
--[[Translation missing --]]
--[[ L["Reset filters"] = "Reset filters"--]] 
L["Secrets of Azeroth"] = "Segreti di Azeroth"
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
--[[Translation missing --]]
--[[ L["Toys"] = "Toys"--]] 
--[[Translation missing --]]
--[[ L["Usable"] = "Usable"--]] 

    -- Settings
--[[Translation missing --]]
--[[ L["SETTING_CURSOR_KEYS"] = "Enable Left&Right keys to flip pages"--]] 
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
--[[Translation missing --]]
--[[ L["Order Hall"] = "Order Hall"--]] 
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "koKR" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
L["Day of the Dead"] = "망자의 날"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
L["FAVOR_DISPLAYED"] = "모두 표시"
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
L["Pirates' Day"] = "해적의 날"
L["RANDOM_TOY_DESCRIPTION"] = "장난감이 즐겨찾기 중 랜덤으로 표시됩니다."
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "장난감 즐겨찾기 랜덤 사용"
L["Reset filters"] = "분류 초기화"
L["Secrets of Azeroth"] = "아제로스의 비밀"
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
L["Toys"] = "장난감"
L["Usable"] = "사용가능"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "왼쪽 오른쪽 키로 페이지를 넘깁니다."
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
L["Order Hall"] = "연맹 전당"
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

elseif locale == "ptBR" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
L["Day of the Dead"] = "Dia dos Mortos"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
L["FAVOR_DISPLAYED"] = "Tudo Visível"
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
L["FILTER_SECRET"] = "Oculto no jogo"
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
L["Pirates' Day"] = "Dia dos Piratas"
L["RANDOM_TOY_DESCRIPTION"] = "O brinquedo será escolhido aleatoriamente entre os favoritos."
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "Use um brinquedo favorito aleatório"
L["Reset filters"] = "Redefinir filtros"
L["Secrets of Azeroth"] = "Segredos de Azeroth"
L["SORT_FAVORITES_FIRST"] = "Favoritos primeiro"
L["SORT_REVERSE"] = "Ordem Inversa"
L["SORT_UNOWNED_AFTER"] = "Finalmente sem dono"
L["Toys"] = "Brinquedos"
L["Usable"] = "Utilizável"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Habilite as teclas Esquerda&Direita para virar as páginas"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Pesquise também na descrição do brinquedo"

    -- Source
L["Order Hall"] = "Salão de Classe"
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
L["Act"] = "Agir"
L["Aircraft"] = "Voar"
L["Alcohol"] = "Álcool"
L["Appearance"] = "Aparência"
L["Banner"] = "Bandeira"
L["Bigger"] = "Maior"
L["Chair"] = "Cadeira"
L["Clickable"] = "Clicável"
L["Clone"] = "Clone"
L["Consumable"] = "Consumível"
L["Controller"] = "Controle"
L["Co-op"] = "Cooperativo"
L["Effect"] = "Efeito"
L["Fly/Fall"] = "Voar/Cair"
L["Ground"] = "Terrestre"
L["Interactable"] = "Interativo"
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
L["Minor"] = "Menor"
L["Nearby"] = "Próximo"
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
L["Pennant"] = "Pingente"
L["Smaller"] = "Pequeno"
L["Tonk"] = "Tonque"
L["Transportation"] = "Transporte"
L["Vision"] = "Visão"
L["Voice"] = "Voz"

elseif locale == "ruRU" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
L["Day of the Dead"] = "День мертвых"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
L["FAVOR_DISPLAYED"] = "Отображать все"
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
L["FILTER_ONLY_LATEST"] = "Только последний патч"
L["FILTER_ONLY_TRADABLE"] = "Только передающиеся"
L["FILTER_SECRET"] = "Скрыто в игре"
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
L["Pirates' Day"] = "День пиратов"
L["RANDOM_TOY_DESCRIPTION"] = "Игрушка будет выбрана случайно из избранных игрушек"
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "Использовать случайную избранную игрушку."
L["Reset filters"] = "Сбросить фильтры"
L["Secrets of Azeroth"] = "Тайны Азерота"
L["SORT_FAVORITES_FIRST"] = "Избранное в первую очередь"
L["SORT_REVERSE"] = "Обратная сортировка"
L["SORT_UNOWNED_AFTER"] = "Бесхозный на последнем месте"
L["Toys"] = "Игрушки"
L["Usable"] = "Используемые"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "Включить использование кнопок Влево/Вправо для перемещения по страницам"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "Искать также в описании игрушки"

    -- Source
L["Order Hall"] = "Классовый оплот"
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
L["Act"] = "Действие"
L["Aircraft"] = "Самолет"
L["Alcohol"] = "Алкоголь"
L["Appearance"] = "Внешность"
L["Banner"] = "Баннер"
L["Bigger"] = "Больше"
L["Chair"] = "Стул"
L["Clickable"] = "Кликабельно"
L["Clone"] = "Клон"
L["Consumable"] = "Расходный материал"
L["Controller"] = "Контроллер"
L["Co-op"] = "Кооператив"
L["Effect"] = "Эффект"
L["Fly/Fall"] = "Полет/Падение"
L["Ground"] = "Земля"
L["Interactable"] = "Интерактивный"
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
L["Minor"] = "Незначительный"
L["Nearby"] = "Рядом"
L["NPC"] = "NPC"
L["Pennant"] = "Вымпел"
L["Smaller"] = "Меньше"
L["Tonk"] = "Тонк"
L["Transportation"] = "Транспорт"
L["Vision"] = "Зрение"
L["Voice"] = "Голос"

elseif locale == "zhCN" then
    L["ASK_FAVORITE_PROFILE_NAME"] = "输入配置文件名称："
L["COMPARTMENT_TOOLTIP"] = "|cffeda55f左键点击|r 打开玩具盒。|cffeda55f右键点击​​|r 打开插件选项。"
L["CONFIRM_FAVORITE_PROFILE_DELETION"] = "您确定要删除配置文件“%s ”吗？所有当前的字符分配都将重置为默认配置文件“%s”。"
L["Day of the Dead"] = "悼念日"
L["FAVOR_AUTO"] = "自动添加新玩具"
L["FAVOR_DISPLAYED"] = "显示所有"
L["FAVORITE_ACCOUNT_PROFILE"] = "帐号"
L["FAVORITE_PROFILE"] = "配置"
L["FILTER_HIDDEN_MANUAL"] = "被我隐藏了"
L["FILTER_ONLY"] = "仅"
L["FILTER_ONLY_LATEST"] = "仅最新添加"
L["FILTER_ONLY_TRADABLE"] = "仅可交易"
L["FILTER_SECRET"] = "隐藏在游戏中"
L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "请收藏至少一件收集到的玩具。"
L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55f左键点击|r打开玩具盒。"
L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55f右键点击|r，选择不同的收藏配置。"
L["LDB_TIP_NO_FAVORITES_TITLE"] = "您尚未选择任何玩具作为最爱。"
L["Pirates' Day"] = "海盗日"
L["RANDOM_TOY_DESCRIPTION"] = "玩具将从收藏中随机选择。"
L["RANDOM_TOY_LOCKED"] = "请至少收藏一个玩具来解锁。"
L["RANDOM_TOY_TITLE"] = "使用随机收藏玩具"
L["Reset filters"] = "重置过滤器"
L["Secrets of Azeroth"] = "艾泽拉斯之秘"
L["SORT_FAVORITES_FIRST"] = "收藏优先"
L["SORT_REVERSE"] = "反向排序"
L["SORT_UNOWNED_AFTER"] = "最后无结果"
L["Toys"] = "玩具"
L["Usable"] = "可用"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "启用左右键翻页"
L["SETTING_SEARCH_IN_DESCRIPTION"] = "也在玩具描述中搜索"

    -- Source
L["Order Hall"] = "职业大厅"
L["Unavailable"] = "不再可获取"

    -- Effects
L["Act"] = "动作"
L["Aircraft"] = "飞行"
L["Alcohol"] = "酒"
L["Appearance"] = "外观"
L["Banner"] = "旗帜"
L["Bigger"] = "变大"
L["Chair"] = "椅子"
L["Clickable"] = "可点击"
L["Clone"] = "复制"
L["Consumable"] = "消耗品"
L["Controller"] = "控制器"
L["Co-op"] = "合作模式"
L["Effect"] = "效果"
L["Fly/Fall"] = "飞行/降落"
L["Ground"] = "地面"
L["Interactable"] = "可互动"
L["Maps"] = "地图"
L["Minor"] = "轻微的"
L["Nearby"] = "附近的"
L["NPC"] = "NPC"
L["Pennant"] = "三角旗"
L["Smaller"] = "变小"
L["Tonk"] = "坦克"
L["Transportation"] = "交通工具"
L["Vision"] = "视野"
L["Voice"] = "语音"

elseif locale == "zhTW" then
    --[[Translation missing --]]
--[[ L["ASK_FAVORITE_PROFILE_NAME"] = "Enter Profile Name:"--]] 
--[[Translation missing --]]
--[[ L["COMPARTMENT_TOOLTIP"] = [=[|cffeda55fLeft-Click|r to toggle showing the Toy Box.
|cffeda55fRight-Click|r to open addon options.]=]--]] 
--[[Translation missing --]]
--[[ L["CONFIRM_FAVORITE_PROFILE_DELETION"] = [=[Are you sure you want to delete the profile "%s"?
All current character assignments will be reset to the default profile "%s".]=]--]] 
L["Day of the Dead"] = "亡者節"
--[[Translation missing --]]
--[[ L["FAVOR_AUTO"] = "Add new toys automatically"--]] 
L["FAVOR_DISPLAYED"] = "全部顯示"
--[[Translation missing --]]
--[[ L["FAVORITE_ACCOUNT_PROFILE"] = "Account"--]] 
--[[Translation missing --]]
--[[ L["FAVORITE_PROFILE"] = "Profile"--]] 
--[[Translation missing --]]
--[[ L["FILTER_HIDDEN_MANUAL"] = "Hidden by me"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY"] = "only"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_LATEST"] = "Only latest additions"--]] 
--[[Translation missing --]]
--[[ L["FILTER_ONLY_TRADABLE"] = "Only tradable"--]] 
--[[Translation missing --]]
--[[ L["FILTER_SECRET"] = "Hidden in game"--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_INSTRUCTION"] = "Please favor at least one collected toy."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_LEFT_CLICK"] = "|cffeda55fLeft click|r to open Toy Box."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_RIGHT_CLICK"] = "|cffeda55fRight click|r to select different Favorite Profile."--]] 
--[[Translation missing --]]
--[[ L["LDB_TIP_NO_FAVORITES_TITLE"] = "You have not selected any toy as favorite yet."--]] 
L["Pirates' Day"] = "海賊日"
L["RANDOM_TOY_DESCRIPTION"] = "玩具將從最愛中隨機選擇。"
--[[Translation missing --]]
--[[ L["RANDOM_TOY_LOCKED"] = "Please favor at least one collected toy to unlock."--]] 
L["RANDOM_TOY_TITLE"] = "使用隨機最愛玩具"
L["Reset filters"] = "重設過濾"
--[[Translation missing --]]
--[[ L["Secrets of Azeroth"] = "Secrets of Azeroth"--]] 
--[[Translation missing --]]
--[[ L["SORT_FAVORITES_FIRST"] = "Favorites First"--]] 
--[[Translation missing --]]
--[[ L["SORT_REVERSE"] = "Reverse Sort"--]] 
--[[Translation missing --]]
--[[ L["SORT_UNOWNED_AFTER"] = "Unowned at Last"--]] 
L["Toys"] = "玩具"
L["Usable"] = "可用"

    -- Settings
L["SETTING_CURSOR_KEYS"] = "啟用左右鍵可翻轉頁面"
--[[Translation missing --]]
--[[ L["SETTING_SEARCH_IN_DESCRIPTION"] = "Search also in toy description"--]] 

    -- Source
L["Order Hall"] = "職業大廳"
--[[Translation missing --]]
--[[ L["Unavailable"] = "No more available"--]] 

    -- Effects
--[[Translation missing --]]
--[[ L["Act"] = "Act"--]] 
--[[Translation missing --]]
--[[ L["Aircraft"] = "Aircraft"--]] 
--[[Translation missing --]]
--[[ L["Alcohol"] = "Alcohol"--]] 
--[[Translation missing --]]
--[[ L["Appearance"] = "Appearance"--]] 
--[[Translation missing --]]
--[[ L["Banner"] = "Banner"--]] 
--[[Translation missing --]]
--[[ L["Bigger"] = "Bigger"--]] 
--[[Translation missing --]]
--[[ L["Chair"] = "Chair"--]] 
--[[Translation missing --]]
--[[ L["Clickable"] = "Clickable"--]] 
--[[Translation missing --]]
--[[ L["Clone"] = "Clone"--]] 
--[[Translation missing --]]
--[[ L["Consumable"] = "Consumable"--]] 
--[[Translation missing --]]
--[[ L["Controller"] = "Controller"--]] 
--[[Translation missing --]]
--[[ L["Co-op"] = "Co-op"--]] 
--[[Translation missing --]]
--[[ L["Effect"] = "Effect"--]] 
--[[Translation missing --]]
--[[ L["Fly/Fall"] = "Fly/Fall"--]] 
--[[Translation missing --]]
--[[ L["Ground"] = "Ground"--]] 
--[[Translation missing --]]
--[[ L["Interactable"] = "Interactable"--]] 
--[[Translation missing --]]
--[[ L["Maps"] = "Maps"--]] 
--[[Translation missing --]]
--[[ L["Minor"] = "Minor"--]] 
--[[Translation missing --]]
--[[ L["Nearby"] = "Nearby"--]] 
--[[Translation missing --]]
--[[ L["NPC"] = "NPC"--]] 
--[[Translation missing --]]
--[[ L["Pennant"] = "Pennant"--]] 
--[[Translation missing --]]
--[[ L["Smaller"] = "Smaller"--]] 
--[[Translation missing --]]
--[[ L["Tonk"] = "Tonk"--]] 
--[[Translation missing --]]
--[[ L["Transportation"] = "Transportation"--]] 
--[[Translation missing --]]
--[[ L["Vision"] = "Vision"--]] 
--[[Translation missing --]]
--[[ L["Voice"] = "Voice"--]] 

end