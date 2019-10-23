--[[
Name: LibBabble-TalentTree-3.0
Revision: $Rev: 89 $
Maintainers: ckknight, nevcairiel, Ackis
Website: http://www.wowace.com/projects/libbabble-talenttree-3-0/
Dependencies: None
License: MIT
]]

local MAJOR_VERSION = "LibBabble-TalentTree-3.0"
local MINOR_VERSION = 90000 + tonumber(("$Rev: 89 $"):match("%d+"))

if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib = LibStub("LibBabble-3.0"):New(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end

local GAME_LOCALE = GetLocale()

lib:SetBaseTranslations {
	["Affliction"] = "Affliction",
	["Arcane"] = "Arcane",
	["Arms"] = "Arms",
	["Assassination"] = "Assassination",
	["Balance"] = "Balance",
	["Beast Mastery"] = "Beast Mastery",
	["Blood"] = "Blood",
	["Brewmaster"] = "Brewmaster",
	["Combat"] = "Combat",
	["Demonology"] = "Demonology",
	["Destruction"] = "Destruction",
	["Discipline"] = "Discipline",
	["Elemental"] = "Elemental",
	["Enhancement"] = "Enhancement",
	["Feral"] = "Feral",
	["Feral Combat"] = "Feral Combat",
	["Fire"] = "Fire",
	["Frost"] = "Frost",
	["Fury"] = "Fury",
	["Guardian"] = "Guardian",
	["Havoc"] = "Havoc",
	["Holy"] = "Holy",
	["Hybrid"] = "Hybrid",
	["Marksmanship"] = "Marksmanship",
	["Mistweaver"] = "Mistweaver",
	["Protection"] = "Protection",
	["Restoration"] = "Restoration",
	["Retribution"] = "Retribution",
	["Shadow"] = "Shadow",
	["Subtlety"] = "Subtlety",
	["Survival"] = "Survival",
	["Unholy"] = "Unholy",
	["Vengeance"] = "Vengeance",
	["Windwalker"] = "Windwalker"
}

if GAME_LOCALE == "enUS" then
	lib:SetCurrentTranslations(true)

elseif GAME_LOCALE == "deDE" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Gebrechen",
	["Arcane"] = "Arkan",
	["Arms"] = "Waffen",
	["Assassination"] = "Meucheln",
	["Balance"] = "Gleichgewicht",
	["Beast Mastery"] = "Tierherrschaft",
	["Blood"] = "Blut",
	["Brewmaster"] = "Braumeister",
	["Combat"] = "Kampf",
	["Demonology"] = "Dämonologie",
	["Destruction"] = "Zerstörung",
	["Discipline"] = "Disziplin",
	["Elemental"] = "Elementar",
	["Enhancement"] = "Verstärkung",
	["Feral"] = "Wildheit",
	["Feral Combat"] = "Wilder Kampf",
	["Fire"] = "Feuer",
	["Frost"] = "Frost",
	["Fury"] = "Furor",
	["Guardian"] = "Wächter",
	["Havoc"] = "Verwüstung",
	["Holy"] = "Heilig",
	["Hybrid"] = "Hybride",
	["Marksmanship"] = "Treffsicherheit",
	["Mistweaver"] = "Nebelwirker",
	["Protection"] = "Schutz",
	["Restoration"] = "Wiederherstellung",
	["Retribution"] = "Vergeltung",
	["Shadow"] = "Schatten",
	["Subtlety"] = "Täuschung",
	["Survival"] = "Überleben",
	["Unholy"] = "Unheilig",
	["Vengeance"] = "Rachsucht",
	["Windwalker"] = "Windläufer"
}
elseif GAME_LOCALE == "frFR" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Affliction",
	["Arcane"] = "Arcane",
	["Arms"] = "Armes",
	["Assassination"] = "Assassinat",
	["Balance"] = "Equilibre",
	["Beast Mastery"] = "Maîtrise des bêtes",
	["Blood"] = "Sang",
	["Brewmaster"] = "Maître brasseur",
	["Combat"] = "Combat",
	["Demonology"] = "Démonologie",
	["Destruction"] = "Destruction",
	["Discipline"] = "Discipline",
	["Elemental"] = "Elémentaire",
	["Enhancement"] = "Amélioration",
	["Feral"] = "Farouche",
	["Feral Combat"] = "Combat farouche",
	["Fire"] = "Feu",
	["Frost"] = "Givre",
	["Fury"] = "Fureur",
	["Guardian"] = "Gardien",
	["Havoc"] = "Dévastation",
	["Holy"] = "Sacré",
	["Hybrid"] = "Hybride",
	["Marksmanship"] = "Précision",
	["Mistweaver"] = "Tisse-brume",
	["Protection"] = "Protection",
	["Restoration"] = "Restauration",
	["Retribution"] = "Vindicte",
	["Shadow"] = "Ombre",
	["Subtlety"] = "Finesse",
	["Survival"] = "Survie",
	["Unholy"] = "Impie",
	["Vengeance"] = "Vengeance",
	["Windwalker"] = "Marche-vent"
}
elseif GAME_LOCALE == "koKR" then
	lib:SetCurrentTranslations {
	["Affliction"] = "고통",
	["Arcane"] = "비전",
	["Arms"] = "무기",
	["Assassination"] = "암살",
	["Balance"] = "조화",
	["Beast Mastery"] = "야수",
	["Blood"] = "혈기",
	["Brewmaster"] = "양조",
	["Combat"] = "전투",
	["Demonology"] = "악마",
	["Destruction"] = "파괴",
	["Discipline"] = "수양",
	["Elemental"] = "정기",
	["Enhancement"] = "고양",
	["Feral"] = "야성",
	["Feral Combat"] = "야성",
	["Fire"] = "화염",
	["Frost"] = "냉기",
	["Fury"] = "분노",
	["Guardian"] = "수호",
	["Havoc"] = "파멸",
	["Holy"] = "신성",
	["Hybrid"] = "하이브리드",
	["Marksmanship"] = "사격",
	["Mistweaver"] = "운무",
	["Protection"] = "방어",
	["Restoration"] = "복원",
	["Retribution"] = "징벌",
	["Shadow"] = "암흑",
	["Subtlety"] = "잠행",
	["Survival"] = "생존",
	["Unholy"] = "부정",
	["Vengeance"] = "복수",
	["Windwalker"] = "풍운"
}
elseif GAME_LOCALE == "esES" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Aflicción",
	["Arcane"] = "Arcano",
	["Arms"] = "Armas",
	["Assassination"] = "Asesinato",
	["Balance"] = "Equilibrio",
	["Beast Mastery"] = "Dominio de bestias",
	["Blood"] = "Sangre",
	["Brewmaster"] = "Maestro cervecero",
	["Combat"] = "Combate",
	["Demonology"] = "Demonología",
	["Destruction"] = "Destrucción",
	["Discipline"] = "Disciplina",
	["Elemental"] = "Elemental",
	["Enhancement"] = "Mejora",
	["Feral"] = "Feral",
	["Feral Combat"] = "Combate Feral",
	["Fire"] = "Fuego",
	["Frost"] = "Escarcha",
	["Fury"] = "Furia",
	["Guardian"] = "Guardián",
	--[[Translation missing --]]
	--[[ ["Havoc"] = "Havoc",--]] 
	["Holy"] = "Sagrado",
	["Hybrid"] = "Híbrido",
	["Marksmanship"] = "Puntería",
	["Mistweaver"] = "Tejedor de niebla",
	["Protection"] = "Protección",
	["Restoration"] = "Restauración",
	["Retribution"] = "Reprensión",
	["Shadow"] = "Sombras",
	["Subtlety"] = "Sutileza",
	["Survival"] = "Supervivencia",
	["Unholy"] = "Profano",
	--[[Translation missing --]]
	--[[ ["Vengeance"] = "Vengeance",--]] 
	["Windwalker"] = "Viajero del viento"
}
elseif GAME_LOCALE == "esMX" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Aflicción",
	["Arcane"] = "Arcano",
	["Arms"] = "Armas",
	["Assassination"] = "Asesinato",
	["Balance"] = "Balance",
	["Beast Mastery"] = "Bestias",
	["Blood"] = "Sangre",
	["Brewmaster"] = "Maestro cervecero",
	["Combat"] = "Combate",
	["Demonology"] = "Demonología",
	["Destruction"] = "Destrucción",
	["Discipline"] = "Disciplina",
	["Elemental"] = "Elemental",
	["Enhancement"] = "Mejora",
	["Feral"] = "Feral",
	["Feral Combat"] = "Combate feral",
	["Fire"] = "Fuego",
	["Frost"] = "Escarcha",
	["Fury"] = "Furia",
	["Guardian"] = "Guardián",
	--[[Translation missing --]]
	--[[ ["Havoc"] = "Havoc",--]] 
	["Holy"] = "Sagrado",
	["Hybrid"] = "Híbrido",
	["Marksmanship"] = "Puntería",
	["Mistweaver"] = "Tejedor de niebla",
	["Protection"] = "Protección",
	["Restoration"] = "Restauración",
	["Retribution"] = "Reprensión",
	["Shadow"] = "Sombra",
	["Subtlety"] = "Sutileza",
	["Survival"] = "Supervivencia",
	["Unholy"] = "Profano",
	--[[Translation missing --]]
	--[[ ["Vengeance"] = "Vengeance",--]] 
	["Windwalker"] = "Viajero del viento"
}
elseif GAME_LOCALE == "ptBR" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Suplício",
	["Arcane"] = "Arcano",
	["Arms"] = "Armas",
	["Assassination"] = "Assassinato",
	["Balance"] = "Equilíbrio",
	["Beast Mastery"] = "Domínio das Feras",
	["Blood"] = "Sangue",
	["Brewmaster"] = "Mestre Cervejeiro",
	["Combat"] = "Combate",
	["Demonology"] = "Demonologia",
	["Destruction"] = "Destruição",
	["Discipline"] = "Disciplina",
	["Elemental"] = "Elemental",
	["Enhancement"] = "Aperfeiçoamento",
	["Feral"] = "Feral",
	["Feral Combat"] = "Combate Feral",
	["Fire"] = "Fogo",
	["Frost"] = "Gelo",
	["Fury"] = "Fúria",
	["Guardian"] = "Guardião",
	--[[Translation missing --]]
	--[[ ["Havoc"] = "Havoc",--]] 
	["Holy"] = "Sagrado",
	["Hybrid"] = "Híbrido",
	["Marksmanship"] = "Precisão",
	["Mistweaver"] = "Tecelão da Névoa",
	["Protection"] = "Proteção",
	["Restoration"] = "Restauração",
	["Retribution"] = "Retribuição",
	["Shadow"] = "Sombra",
	["Subtlety"] = "Subterfúgio",
	["Survival"] = "Sobrevivência",
	["Unholy"] = "Profano",
	--[[Translation missing --]]
	--[[ ["Vengeance"] = "Vengeance",--]] 
	["Windwalker"] = "Andarilho do Vento"
}
elseif GAME_LOCALE == "itIT" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Afflizione",
	["Arcane"] = "Arcano",
	["Arms"] = "Armi",
	["Assassination"] = "Assassinio",
	["Balance"] = "Equilibrio",
	["Beast Mastery"] = "Affinità Animale",
	["Blood"] = "Sangue",
	["Brewmaster"] = "Mastro Birraio",
	["Combat"] = "Combattimento",
	["Demonology"] = "Demonologia",
	["Destruction"] = "Distruzione",
	["Discipline"] = "Disciplina",
	["Elemental"] = "Elementale",
	["Enhancement"] = "Potenziamento",
	["Feral"] = "Aggressore Ferino",
	["Feral Combat"] = "Combattimento Ferale",
	["Fire"] = "Fuoco",
	["Frost"] = "Ghiaccio",
	["Fury"] = "Furia",
	["Guardian"] = "Guardiano Ferino",
	["Havoc"] = "Rovina",
	["Holy"] = "Sacro",
	["Hybrid"] = "Ibrido",
	["Marksmanship"] = "Precisione di tiro",
	["Mistweaver"] = "Misticismo",
	["Protection"] = "Protezione",
	["Restoration"] = "Rigenerazione",
	["Retribution"] = "Castigo",
	["Shadow"] = "Ombra",
	["Subtlety"] = "Scaltrezza",
	["Survival"] = "Sopravvivenza",
	["Unholy"] = "Empietà",
	["Vengeance"] = "Vendetta",
	["Windwalker"] = "Impeto"
}
elseif GAME_LOCALE == "ruRU" then
	lib:SetCurrentTranslations {
	["Affliction"] = "Колдовство",
	["Arcane"] = "Тайная магия",
	["Arms"] = "Оружие",
	["Assassination"] = "Убийство",
	["Balance"] = "Баланс",
	["Beast Mastery"] = "Чувство зверя",
	["Blood"] = "Кровь",
	["Brewmaster"] = "Хмелевар",
	["Combat"] = "Бой",
	["Demonology"] = "Демонология",
	["Destruction"] = "Разрушение",
	["Discipline"] = "Послушание",
	["Elemental"] = "Укрощение стихии",
	["Enhancement"] = "Совершенствование",
	["Feral"] = "Сила зверя",
	["Feral Combat"] = "Сила зверя",
	["Fire"] = "Огонь",
	["Frost"] = "Лед",
	["Fury"] = "Неистовство",
	["Guardian"] = "Страж",
	--[[Translation missing --]]
	--[[ ["Havoc"] = "Havoc",--]] 
	["Holy"] = "Свет",
	["Hybrid"] = "Гибрид",
	["Marksmanship"] = "Стрельба",
	["Mistweaver"] = "Ткач туманов",
	["Protection"] = "Защита",
	["Restoration"] = "Исцеление",
	["Retribution"] = "Возмездие",
	["Shadow"] = "Темная магия",
	["Subtlety"] = "Скрытность",
	["Survival"] = "Выживание",
	["Unholy"] = "Нечестивость",
	--[[Translation missing --]]
	--[[ ["Vengeance"] = "Vengeance",--]] 
	["Windwalker"] = "Танцующий с ветром"
}
elseif GAME_LOCALE == "zhCN" then
	lib:SetCurrentTranslations {
	["Affliction"] = "痛苦",
	["Arcane"] = "奥术",
	["Arms"] = "武器",
	["Assassination"] = "刺杀",
	["Balance"] = "平衡",
	["Beast Mastery"] = "野兽控制",
	["Blood"] = "鲜血",
	["Brewmaster"] = "酒仙",
	["Combat"] = "战斗",
	["Demonology"] = "恶魔学识",
	["Destruction"] = "毁灭",
	["Discipline"] = "戒律",
	["Elemental"] = "元素战斗",
	["Enhancement"] = "增强",
	["Feral"] = "野性",
	["Feral Combat"] = "野性战斗",
	["Fire"] = "火焰",
	["Frost"] = "冰霜",
	["Fury"] = "狂怒",
	["Guardian"] = "守护",
	["Havoc"] = "浩劫",
	["Holy"] = "神圣",
	["Hybrid"] = "混合",
	["Marksmanship"] = "射击",
	["Mistweaver"] = "织雾",
	["Protection"] = "防护",
	["Restoration"] = "恢复",
	["Retribution"] = "惩戒",
	["Shadow"] = "暗影魔法",
	["Subtlety"] = "敏锐",
	["Survival"] = "生存技能",
	["Unholy"] = "邪恶",
	["Vengeance"] = "复仇",
	["Windwalker"] = "踏风"
}
elseif GAME_LOCALE == "zhTW" then
	lib:SetCurrentTranslations {
	["Affliction"] = "痛苦",
	["Arcane"] = "秘法",
	["Arms"] = "武器",
	["Assassination"] = "刺殺",
	["Balance"] = "平衡",
	["Beast Mastery"] = "野獸控制",
	["Blood"] = "血魄",
	["Brewmaster"] = "釀酒",
	["Combat"] = "戰鬥",
	["Demonology"] = "惡魔學識",
	["Destruction"] = "毀滅",
	["Discipline"] = "戒律",
	["Elemental"] = "元素",
	["Enhancement"] = "增強",
	["Feral"] = "野性戰鬥",
	["Feral Combat"] = "野性戰鬥",
	["Fire"] = "火焰",
	["Frost"] = "冰霜",
	["Fury"] = "狂怒",
	["Guardian"] = "守護者",
	--[[Translation missing --]]
	--[[ ["Havoc"] = "Havoc",--]] 
	["Holy"] = "神聖",
	["Hybrid"] = "混合",
	["Marksmanship"] = "射擊",
	["Mistweaver"] = "織霧",
	["Protection"] = "防護",
	["Restoration"] = "恢復",
	["Retribution"] = "懲戒",
	["Shadow"] = "暗影",
	["Subtlety"] = "敏銳",
	["Survival"] = "生存",
	["Unholy"] = "穢邪",
	--[[Translation missing --]]
	--[[ ["Vengeance"] = "Vengeance",--]] 
	["Windwalker"] = "御風"
}
else
	error(("%s: Locale %q not supported"):format(MAJOR_VERSION, GAME_LOCALE))
end
