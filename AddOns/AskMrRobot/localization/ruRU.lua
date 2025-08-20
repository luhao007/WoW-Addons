local L = LibStub("AceLocale-3.0"):NewLocale("AskMrRobot", "ruRU", false)

if L then


--[[----------------------------------------------------------------------
General
------------------------------------------------------------------------]]

L.SpecsShort = {
	[1] = "Blood", -- DeathKnightBlood
    [2] = "Frost", -- DeathKnightFrost
    [3] = "Unholy", -- DeathKnightUnholy
	[4] = "Havoc", -- DemonHunterHavoc
	[5] = "Vengeance", -- DemonHunterVengeance
    [6] = "Moon", -- DruidBalance
    [7] = "Feral", -- DruidFeral
    [8] = "Bear", -- DruidGuardian
    [9] = "Resto", -- DruidRestoration
    [10] = "Devastate", -- EvokerDevastation
    [11] = "Preserve", -- EvokerPreservation
    [12] = "Augment", -- EvokerAugmentation
    [13] = "BM", -- HunterBeastMastery
    [14] = "Marks", -- HunterMarksmanship
    [15] = "Survival", -- HunterSurvival
    [16] = "Arcane", -- MageArcane
    [17] = "Fire", -- MageFire
    [18] = "Frost", -- MageFrost
    [19] = "Brew", -- MonkBrewmaster
    [20] = "Mist", -- MonkMistweaver
    [21] = "Wind", -- MonkWindwalker
    [22] = "Holy", -- PaladinHoly
    [23] = "Prot", -- PaladinProtection
    [24] = "Ret", -- PaladinRetribution
    [25] = "Disc", -- PriestDiscipline
    [26] = "Holy", -- PriestHoly
    [27] = "Shadow", -- PriestShadow
    [28] = "Assn", -- RogueAssassination
    [29] = "Outlaw", -- RogueOutlaw
    [30] = "Sub", -- RogueSubtlety
    [31] = "Elem", -- ShamanElemental
    [32] = "Enh", -- ShamanEnhancement
    [33] = "Resto", -- ShamanRestoration
    [34] = "Aff", -- WarlockAffliction
    [35] = "Demo", -- WarlockDemonology
    [36] = "Destro", -- WarlockDestruction
    [37] = "Arms", -- WarriorArms
    [38] = "Fury", -- WarriorFury
    [39] = "Prot", -- WarriorProtection
}

-- stat strings for e.g. displaying gem/enchant abbreviations, make as short as possible without being confusing/ambiguous
L.StatsShort = {
    ["Strength"] = "Сила",
    ["Agility"] = "Аги",
    ["Intellect"] = "Инта",
    ["CriticalStrike"] = "Крит",
    ["Haste"] = "Скорость",
    ["Mastery"] = "Искусность",
    ["Multistrike"] = "Мульти",
    ["Versatility"] = "Универс",
    ["BonusArmor"] = "Бонус брони",
    ["Spirit"] = "Дух",
    ["Dodge"] = "Уклон",
    ["Parry"] = "Пари",
    ["MovementSpeed"] = "Скор. перед.",
    ["Avoidance"] = "Избегание",
    ["Stamina"] = "Вынос",
    ["Armor"] = "Броня",
    ["AttackPower"] = "СА",
    ["SpellPower"] = "СЗ",
    ["PvpResilience"] = "PvP Устойчивость",
    ["PvpPower"] = "PvP Сила",
}

L.InstanceNames = {
    [1861] = "Uldir",
    [2070] = "Dazar'alor",
    [2096] = "Crucible of Storms",
    [2164] = "The Eternal Palace",
    [2217] = "Ny'alotha",    
    [2296] = "Castle Nathria",
    [2450] = "Sanctum of Domination",
    [2481] = "Sepulcher of the First Ones",
    [2522] = "Vault of the Incarnates",
    [2569] = "Aberrus, the Shadowed Crucible",
    [2549] = "Amirdrassil, the Dream's Hope",
    [2657] = "Nerub-ar Palace",
    [2769] = "Liberation of Undermine",
    [2810] = "Manaforge Omega"
}

L.DifficultyNames = {
	[17] = "ЛФР",
	[14] = "Нормал",
	[15] = "Гер",
	[16] = "Миф"
}

L.WeaponTypes = {
	None     = "Нет",
	Axe      = "Топор",
	Mace     = "Дробящее",
	Sword    = "Меч",
	Fist     = "Кистевое",
	Dagger   = "Кинжал",
	Staff    = "Посох",
	Polearm  = "Древковое",
	OffHand  = "Левая Рука",
	Shield   = "Щит",
	Wand     = "Жезл",
	Bow      = "Лук",
	Gun      = "Огнестрельное",
	Crossbow = "Арбалет",
	Warglaive= "Боевые клинки"
}

L.ArmorTypes = {
	None    = "Нет",
	Plate   = "Латы",
	Mail    = "Кольчуга",
	Leather = "Кожа",
	Cloth   = "Ткань"
}

L.OneHand = "Одноручное"
L.TwoHand = "Двуручное"
L.OffHand = "Левая Рука"


--[[----------------------------------------------------------------------
Main UI
------------------------------------------------------------------------]]
L.AlertOk = "OK"
L.CoverCancel = "отмена"

L.MinimapTooltip = 
[[Левый клик для открытия окна Ask Mr. Robot.

Правый клик для смены спека и экипирования актуальных предметов.]]

L.MainStatusText = function(version, url)
	return version .. " загружен. Инструкции доступны на " .. url
end

L.TabExportText = "Экспорт"
L.TabGearText = "Экипировка"
L.TabLogText = "Логи"
L.TabOptionsText = "Опции"

L.VersionChatTitle = "AMR Addon Version:"
L.VersionChatNotInstalled = "НЕ УСТАНОВЛЕН"
L.VersionChatNotGrouped = "Вы находитесь вне группы или рейда!"


--[[----------------------------------------------------------------------
Export Tab
------------------------------------------------------------------------]]
L.ExportTitle = "Инструкции Экспорта"
L.ExportHelp1 = "1. Скопируйте текст ниже нажав Ctrl+C (или Cmd+C на Mac)"
L.ExportHelp2 = "2. Перейдите на https://www.askmrrobot.com и выберете своего персонажа"
L.ExportHelp3 = "3. Вставьте это в тектовое поле в разделее ADDON"

L.ExportSplashTitle = "Начало работы"
L.ExportSplashSubtitle = "Это Ваше первое использование данного аддона. Выполните следующее шаги для инициализации Ваших предметов:"
L.ExportSplash1 = "1. Активируйте каждый спек и оденьте последнюю экипировку для каждого спека"
L.ExportSplash2 = "2. Оденьте и откройте ваш Артифакт для каждого спека"
L.ExportSplash3 = "3. Откройте Ваш банк и оставьте его открытым по крайней мере на пару секунд"
L.ExportSplash4 = "4. Если вы имеете предметы экпировки, которые находятся у Вас в Хранилище бездны, то откройте его и оставьте его открытым по крайней мере на пару секунд"
L.ExportSplashClose = "Продолжить"


--[[----------------------------------------------------------------------
Gear Tab
------------------------------------------------------------------------]]
L.GearImportNote = "Нажмите на Импорт, и вставьте туда даные с сайта."
L.GearBlank = "Пока что вы ничего не загружали для этого спека."
L.GearBlank2 = "Перейдите на askmrrobot.com для оптимизации Вашей экипировки, используя кнопку Импорт левее."
L.GearButtonEquip = function(spec)
	return string.format("Активировать %s спек и одеть экипировку", spec)
end
L.GearButtonJunk = "Show Junk List"
L.GearButtonShop = "Показать список покупок"

L.GearEquipErrorCombat = "Вы не можете сменить спек/экипировку в бою!"
L.GearEquipErrorEmpty = "Нет сохраненной экипировки для этого спека."
L.GearEquipErrorNotFound = "Предметы, сохраненные у Вас в экипировке не могут быть одеты."
L.GearEquipErrorNotFound2 = "Попробуйте открыть банк и запустить команду заново, или проверьте Ваше Хранилище бездны."
L.GearEquipErrorBagFull = "У Вас не хватает места в сумках, чтобы мы могли Вас переодеть."
L.GearEquipErrorSoulbound = function(itemLink)
	return itemLink .. " не может быть одет, так как он является не персональным."
end

L.GearButtonImportText = "Импорт"
L.GearButtonCleanText = "Очистить сумки"

L.GearTipTitle = "Совет!"
L.GearTipText = 
[[В Опциях, вы можете включить автоматическое экипирование при смене спека.

Или вы можете сменить спек и надеть эквип нажав ПКМ по иконке на миникарте.

ИЛИ! Вы можете использовать слеш команды:]]

L.GearTipCommands = 
[[/amr equip [1-4]
без аргументов = циклично]]
-- note to translators: the slash commands are literal and should stay as english

L.GearTalentError1 = "Unable to load your AMR setup talents at this time."


--[[----------------------------------------------------------------------
Import Dialog on Gear Tab
------------------------------------------------------------------------]]
L.ImportHeader = "Нажмите Ctrl+V (Cmd+V на Mac), чтобы вставить данные с сайта в поле ниже."
L.ImportButtonOk = "Импорт"
L.ImportButtonCancel = "Отмена"

L.ImportErrorEmpty = "Строка данных пуста."
L.ImportErrorFormat = "Данные находятся в неверном формате."
L.ImportErrorVersion = "Эта строка для старой версии аддона.  Пожалуйста, перейдите на сайт, и попробуйте ещё раз."
L.ImportErrorChar = function(importChar, yourChar)
	return "Эти данные для персонажа " .. importChar .. ", а вы " .. yourChar .. ", не хорошо себя выдавать за других людей!"
end
L.ImportErrorRace = "Похоже, что Вы изменили расу. Пожалуйста, посетите снова сайт и заново сделайте оптимизацию."
L.ImportErrorFaction = "Похоже, что Вы изменили фракцию. Пожалуйста, посетите снова сайт и заново сделайте оптимизацию."
L.ImportErrorLevel = "Похоже, что у Вас изменился уровень.  Пожалуйста, посетите снова сайт и заново сделайте оптимизацию."

L.ImportOverwolfWait = "Выполняется оптимизация BestInBag.  Пожалуйста не нажимайте Esc и не закрывайте аддон пока операция не будет завершена!"


--[[----------------------------------------------------------------------
Junk List
------------------------------------------------------------------------]]
L.JunkTitle = "Junk List"
L.JunkEmpty = "You have no junk items"
L.JunkScrap = "Click an item to add to the scrapper"
L.JunkVendor = "Click an item to sell"
L.JunkDisenchant = "Click an item to disenchant"
L.JunkBankText = function(count)
	return count .. " junk items are not in your bags"
end
L.JunkMissingText = function(count)
    return "Warning! " .. count .. " junk items could not be found"
end
L.JunkButtonBank = "Retrieve from Bank"
L.JunkOutOfSync = "An item in your junk list could not be found. Try opening your bank for a few seconds, then export to the website, then import again."
L.JunkItemNotFound = "That item could not be found in your bags. Try closing and opening the Junk List to refresh it."


--[[----------------------------------------------------------------------
Shopping List
------------------------------------------------------------------------]]
L.ShopTitle = "Список покупок"
L.ShopEmpty = "Здесь нет списка покупок для этого игрока."
L.ShopSpecLabel = "Спек"
L.ShopHeaderGems = "Камни"
L.ShopHeaderEnchants  = "Чары"
L.ShopHeaderMaterials = "Материалы для чар"


--[[----------------------------------------------------------------------
Combat Log Tab
------------------------------------------------------------------------]]
L.LogChatStart = "Сейчас вы записываете бой, и Mr. Robot записывает данные о персонажах в бою."
L.LogChatStop = "Запись боя остановлена."

L.LogChatWipe = function(wipeTime)
	return "Последний указанный Вайп был в " .. wipeTime .. "."
end
L.LogChatUndoWipe = function(wipeTime)
	return "Вайп в " .. wipeTime .. " был удален."
end
L.LogChatNoWipes = "У Вас нет указанных Вами вайпов для удаления."

L.LogButtonStartText = "Начать запись"
L.LogButtonStopText = "Остановить запись"
L.LogButtonReloadText = "Перезагрузить UI"
L.LogButtonWipeText = "ВАЙП!!"
L.LogButtonUndoWipeText = "Отменить Wipe"

L.LogNote = "В настоящее время ведется запись боев и данных персонажей."
L.LogReloadNote = "Перед загрузкой логов, всегда перезагружайте интерфейс или выйдите из WoW."
L.LogWipeNote = "Человек записывающий логи, единственный кто использует команду Вайп."
L.LogWipeNote2 = function(cmd)
	return "'" .. cmd .. "' будет делать так же."
end
L.LogUndoWipeNote = "Последний вайп был:"
L.LogUndoWipeDate = function(day, timeOfDay)
	return day .. " в " .. timeOfDay
end

L.LogAutoTitle = "Автоматическое ведение журнала"
L.LogAutoAllText = "Выбрать всё"

L.LogInstructionsTitle = "Инструкции!"
L.LogInstructions = 
[[1.) Нажмите Начать запись или включить Автоматическое ведение журнала для нужных рейдов.

2.) Если вы закончили, и готовы загрузить логи, выйдите из World of Warcraft* или перезагрузите интерфейс.**

3.) Запустите AMR Client чтобы загрузить Ваши логи.


*Не обязательно выходить из WoW, но очень рекомендуется. Это позволит клиенту AskMrRobot не допустить очень большого размера файла логов.

**AMR собирает дополнительные данные для всех игроков в рейде кто использует AskMrRobot. Другим игрокам включать запись логов не нужно! Аддон должен быть просто установлен и включен. Эти данные сохраняются только на диске, после того как вы выйдите из WoW или перезагрузите интерфейс.
]]


--[[----------------------------------------------------------------------
Options Tab
------------------------------------------------------------------------]]
L.OptionsHeaderGeneral = "Основные настройки"

L.OptionsHideMinimapName = "Скрыть значок у миникарты"
L.OptionsHideMinimapDesc = "Значок около миникарты создан для удобства, все действия Вы также можете выполнить с помощью косой команды или пользовательского интерфейса."

L.OptionsAutoGearName = "Автоматически одевать экипировку при смене спека"
L.OptionsAutoGearDesc = "Если вы смените спек (посредством игрового меню, другого аддона, и т.д.), Ваши загруженные наборы (вкладка Экипировка) будут автоматически экипированы."

L.OptionsJunkVendorName = "Automatically show junk list at vendors and scrapper"
L.OptionsJunkVendorDesc = "Whenever you open the scrapper or a vendor, automatically show the junk list window if your list is not empty."

L.OptionsShopAhName = "Автоматически показывать список покупок при открытии аукциона"
L.OptionsShopAhDesc = "При открытии окна аукциона, автоматически показывать список покупок.  Вы можете кликнуть по предмету в списке покупок для быстрого поиска на аукционе."

L.OptionsDisableEmName = "Disable creating Equipment Manager sets"
L.OptionsDisableEmDesc = "A Blizzard Equipment Manager set is created whenever you equip an AMR gear set, useful for marking items in your optimized sets. Check to disable this behavior if desired."

L.OptionsDisableTalName = "Do not change talents when changing gear sets"
L.OptionsDisableTalDesc = "A setup sent to the addon contains the selected talents and gear for that setup. Check this if you don't want the addon to automatically choose those talents when swapping gear."

L.OptionsUiScaleName = "Ask Mr. Robot масштаб UI"
L.OptionsUiScaleDesc = "Введите занчение от 0.5 до 1.5 для изменения масштаба интерфейса Ask Mr. Robot, нажмите Enter, откройте/закройте окно для достижения эффекта. Если вдруг у Вас сбилось позиционирование, используйте команду /amr reset."

end
