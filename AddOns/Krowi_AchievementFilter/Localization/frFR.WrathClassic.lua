local addonName, addon = ...;
if not addon.Util.IsClassicWithAchievements then
    return;
end
local L = LibStub(addon.Libs.AceLocale):NewLocale(addonName, "frFR");
if not L then return end

-- [[ https://legacy.curseforge.com/wow/addons/krowi-achievement-filter/localization ]] --
-- [[ Everything after this line is automatically generated from CurseForge and is not meant for manual edit - SOURCETOKEN - AUTOGENTOKEN ]] --

-- [[ Exported at 2025-05-17 22-06-28 ]] --
L["Completed"] = "Complété"
L["EJ_GetInstanceInfo230"] = "Haches-Tripes"
L["EJ_GetInstanceInfo246"] = "Scholomance"
L["EJ_GetInstanceInfo247"] = "Cryptes Auchenaï"
L["EJ_GetInstanceInfo248"] = "Remparts des Flammes infernales"
L["EJ_GetInstanceInfo249"] = "Terrasse des Magistères"
L["EJ_GetInstanceInfo250"] = "Tombes-mana"
L["EJ_GetInstanceInfo251"] = "Contreforts de Hautebrande d’antan"
L["EJ_GetInstanceInfo252"] = "Les salles de Sethekk"
L["EJ_GetInstanceInfo253"] = "Labyrinthe des Ombres"
L["EJ_GetInstanceInfo254"] = "L'Arcatraz"
L["EJ_GetInstanceInfo255"] = "Le Noir marécage"
L["EJ_GetInstanceInfo256"] = "La Fournaise du sang"
L["EJ_GetInstanceInfo257"] = "La Botanica"
L["EJ_GetInstanceInfo258"] = "Le Méchanar"
L["EJ_GetInstanceInfo259"] = "Les salles Brisées"
L["EJ_GetInstanceInfo260"] = "Les enclos aux esclaves"
L["EJ_GetInstanceInfo261"] = "Le caveau de la Vapeur"
L["EJ_GetInstanceInfo262"] = "La Basse-tourbière"
L["EJ_GetInstanceInfo271"] = "Ahn’kahet : l’Ancien royaume"
L["EJ_GetInstanceInfo272"] = "Azjol-Nérub"
L["EJ_GetInstanceInfo273"] = "Donjon de Drak'Tharon"
L["EJ_GetInstanceInfo274"] = "Gundrak"
L["EJ_GetInstanceInfo275"] = "Les salles de Foudre"
L["EJ_GetInstanceInfo276"] = "Les salles des Reflets"
L["EJ_GetInstanceInfo277"] = "Les salles de Pierre"
L["EJ_GetInstanceInfo278"] = "La fosse de Saron"
L["EJ_GetInstanceInfo279"] = "L'épuration de Stratholme"
L["EJ_GetInstanceInfo280"] = "La forge des Âmes"
L["EJ_GetInstanceInfo281"] = "Le Nexus"
L["EJ_GetInstanceInfo282"] = "L'Oculus"
L["EJ_GetInstanceInfo283"] = "Le fort Pourpre"
L["EJ_GetInstanceInfo284"] = "L'épreuve du champion"
L["EJ_GetInstanceInfo285"] = "Donjon d'Utgarde"
L["EJ_GetInstanceInfo286"] = "Cime d'Utgarde"
L["EJ_GetInstanceInfo311"] = "Salles Écarlates"
L["EJ_GetInstanceInfo316"] = "Monastère Écarlate"
L["EJ_GetInstanceInfo559"] = "Sommet du pic Rochenoire"
L["EJ_GetInstanceInfo63"] = "Les Mortemines"
L["EJ_GetInstanceInfo64"] = "Donjon d’Ombrecroc"
L["EJ_GetInstanceInfo741"] = "Cœur du Magma"
L["EJ_GetInstanceInfo742"] = "Repaire de l'Aile noire"
L["EJ_GetInstanceInfo743"] = "Ruines d'Ahn'Qiraj"
L["EJ_GetInstanceInfo744"] = "Temple d'Ahn'Qiraj"
L["EJ_GetInstanceInfo745"] = "Karazhan"
L["EJ_GetInstanceInfo746"] = "Repaire de Gruul"
L["EJ_GetInstanceInfo747"] = "Le repaire de Magtheridon"
L["EJ_GetInstanceInfo748"] = "Caverne du sanctuaire du Serpent"
L["EJ_GetInstanceInfo749"] = "Donjon de la Tempête"
L["EJ_GetInstanceInfo750"] = "La bataille du Mont Hyjal"
L["EJ_GetInstanceInfo751"] = "Temple Noir"
L["EJ_GetInstanceInfo752"] = "Plateau du Puits de soleil"
L["EJ_GetInstanceInfo753"] = "Caveau d'Archavon"
L["EJ_GetInstanceInfo754"] = "Naxxramas"
L["EJ_GetInstanceInfo755"] = "Le sanctum Obsidien"
L["EJ_GetInstanceInfo756"] = "L’Œil de l’éternité"
L["EJ_GetInstanceInfo757"] = "L’épreuve du croisé"
L["EJ_GetInstanceInfo758"] = "Citadelle de la Couronne de glace"
L["EJ_GetInstanceInfo759"] = "Ulduar"
L["EJ_GetInstanceInfo76"] = "Zul'Gurub"
L["EJ_GetInstanceInfo760"] = "Le repaire d'Onyxia"
L["EJ_GetInstanceInfo761"] = "Le sanctum Rubis"
L["EJ_GetInstanceInfo77"] = "Zul'Aman"
L["GetCategoryInfo15071"] = "Archéologie"
L["GetCategoryInfo15072"] = "Cataclysm"
L["GetCategoryInfo15073"] = "Bataille de Gilnéas"
L["GetCategoryInfo15074"] = "Pics-Jumeaux"
L["GetCategoryInfo15101"] = "Foire de Sombrelune"
L["GetCategoryInfo15117"] = "Combats de mascotte"
L["GetCategoryInfo15118"] = "Collecter"
L["GetCategoryInfo15119"] = "Bataille"
L["GetCategoryInfo15120"] = "Niveau"
L["GetCategoryInfo15162"] = "Mines d’Éclargent"
L["GetCategoryInfo15163"] = "Temple de Kotmogu"
L["GetCategoryInfo15164"] = "Mists of Pandaria"
L["GetCategoryInfo15218"] = "Gorge de Vent-Caverneux"
L["GetCategoryInfo15233"] = "Warlords of Draenor"
L["GetCategoryInfo15234"] = "Héritage"
L["GetCategoryInfo15246"] = "Collections"
L["GetCategoryInfo15258"] = "Legion"
L["GetCategoryInfo15266"] = "Honneur"
L["GetCategoryInfo15268"] = "Promotions"
L["GetCategoryInfo15271"] = "Raids"
L["GetCategoryInfo15272"] = "Donjons"
L["GetCategoryInfo15283"] = "Monde"
L["GetCategoryInfo15292"] = "Rivage Bouillonnant"
L["GetCategoryInfo15305"] = "Battle for Azeroth"
L["GetCategoryInfo15414"] = "Ashran"
L["GetCategoryInfo15417"] = "Cœur d'Azeroth"
L["GetCategoryInfo15426"] = "Vision de N'Zoth"
L["GetCategoryInfo15439"] = "Shadowlands"
L["GetCategoryInfo15440"] = "Tourment"
L["GetCategoryInfo15441"] = "Sanctums des Congrégations"
L["GetCategoryInfo15454"] = "Marcheurs du temps"
L["GetCategoryInfo15489"] = "Alchimie"
L["GetCategoryInfo15490"] = "Forge"
L["GetCategoryInfo15491"] = "Enchantement"
L["GetCategoryInfo15492"] = "Ingénierie"
L["GetCategoryInfo15493"] = "Calligraphie"
L["GetCategoryInfo15494"] = "Joaillerie"
L["GetCategoryInfo15495"] = "Travail du cuir"
L["GetCategoryInfo15496"] = "Couture"
L["GetCategoryInfo15497"] = "Minage"
L["Not Completed"] = "Non complété"