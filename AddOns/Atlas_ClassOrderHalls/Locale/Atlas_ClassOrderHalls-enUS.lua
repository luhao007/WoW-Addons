-- $Id: Atlas_ClassOrderHalls-enUS.lua 132 2022-02-02 17:17:58Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2016 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_ClassOrderHalls", "enUS", true, true);

if L then
-- //////////////////////////
-- Common
-- //////////////////////////
L["Class Order Hall Maps"] = "Class Order Hall Maps"
L["Class Hall"] = "Class Hall"
L["Portal to Dalaran"] = "Portal to Dalaran"
L["Training Dummies"] = "Training Dummies"
L["Travel to Dalaran"] = "Travel to Dalaran"
L["Entrance"] = "Entrance"
L["Ramp to lower floor"] = "Ramp to lower floor"
L["Ramp to top floor"] = "Ramp to top floor"
L["Champion Armaments"] = "Champion Armaments" -- Quest: 44228
L["Travel to:"] = "Travel to:"
L["Seal of Broken Fate"] = "Seal of Broken Fate"

-- //////////////////////////
-- Death Knight
-- //////////////////////////
L["Portal to another floor"] = "Portal to another floor"
L["Portal to the roof"] = "Portal to the roof"
L["Soul Forge"] = "Soul Forge"
L["Siouxsie the Banshee <Mission Specialist>"] = "Siouxsie the Banshee <Mission Specialist>" -- 93568
L["Highlord Darion Mograine"] = "Highlord Darion Mograine" -- 93437
L["Illanna Dreadmoore <Ebon Blade Archivist>"] = "Illanna Dreadmoore <Ebon Blade Archivist>" -- 97111
L["Lord Thorval"] = "Lord Thorval" -- 97134
L["Quartermaster Ozorg <Rare Goods Vendor>"] = "Quartermaster Ozorg <Rare Goods Vendor>" -- 93550
L["Grand Master Siegesmith Corvus"] = "Grand Master Siegesmith Corvus" -- 97072
L["Lady Alistra <Death Knight Trainer>"] = "Lady Alistra <Death Knight Trainer>" -- 93509
L["Dead Collector Bane <Champion Armaments>"] = "Dead Collector Bane <Champion Armaments>" -- 110410
L["Archivist Zubashi <Class Hall Upgrades>"] = "Archivist Zubashi <Class Hall Upgrades>" -- 97485
L["Amal'thazad"] = "Amal'thazad" -- 93555
L["Dark Summoner Marogh <Risen Horde Recruiter>"] = "Dark Summoner Marogh <Risen Horde Recruiter>" -- 106435
L["Korgaz Deadaxe <Ebon Soldier Recruiter>"] = "Korgaz Deadaxe <Ebon Soldier Recruiter>" -- 106436
L["Salanar the Horseman"] = "Salanar the Horseman" -- 111480
L["Thassarian"] = "Thassarian" -- 93456
L["King Thoras Trollbane"] = "King Thoras Trollbane" -- 113419
L["Requires Frost Wyrm work order advancement"] = "Requires Frost Wyrm work order advancement"
L["Frost Crux"] = "Frost Crux"
L["Requires Frost and Death order advancement"] = "Requires Frost and Death order advancement"
L["Eran Droll <Ebon Knight Frostreavers Recruiter>"] = "Eran Droll <Ebon Knight Frostreavers Recruiter>" -- 120135
L["Winter Payne"] = "Winter Payne" -- 111634

-- //////////////////////////
-- Demon Hunter
-- //////////////////////////
L["Illidari Gateway"] = "Illidari Gateway"
L["Empowered Nether Crucible"] = "Empowered Nether Crucible" -- Object: 250677
L["Cursed Forge of the Nathrezim"] = "Cursed Forge of the Nathrezim"
L["Kayn Sunfury <Illidari>"] = "Kayn Sunfury <Illidari>" -- 95240
L["Battlelord Gaardoun <Ashtongue Captain>"] = "Battlelord Gaardoun <Ashtongue Captain>" -- 103025
L["Lady S'theno <Coilskar Captain>"] = "Lady S'theno <Coilskar Captain>" -- 98624
L["Matron Mother Malevolence <Shivarra Captain>"] = "Matron Mother Malevolence <Shivarra Captain>" -- 98632
L["Falara Nightsong <Illidari Provisioner>"] = "Falara Nightsong <Illidari Provisioner>" -- 112407
L["Jace Darkweaver <Illidari>"] = "Jace Darkweaver <Illidari>" -- 98646
L["Vahu the Weathered <Illidari Researcher>"] = "Vahu the Weathered <Illidari Researcher>" -- 111736
L["Asha Ravensong <Illidari>"] = "Asha Ravensong <Illidari>" -- 108326
L["Izal Whitemoon <Illidari Trainer>"] = "Izal Whitemoon <Illidari Trainer>" -- 109965
L["Seer Akalu <Nathrezim Scholar>"] = "Seer Akalu <Nathrezim Scholar>" -- 109596
L["Kor'vas Bloodthorn <Illidari>"] = "Kor'vas Bloodthorn <Illidari>" -- 103761
L["Loramus Thalipedes <Class Hall Upgrades>"] = "Loramus Thalipedes <Class Hall Upgrades>" -- 110599
L["Belath Dawnblade <Illidari>"] = "Belath Dawnblade <Illidari>" -- 108782
L["Ariana Fireheart <Illidari>"] = "Ariana Fireheart <Illidari>" -- 103760
L["Slitesh <Armaments Requisitioner>"] = "Slitesh <Armaments Requisitioner>" -- 110433
L["Requires Fel Hammer's Wrath order advancement"] = "Requires Fel Hammer's Wrath order advancement"
L["Empowered Rift Core"] = "Empowered Rift Core"
L["Evelune Soulreaver <Wrath of the Order>"] = "Evelune Soulreaver <Wrath of the Order>" -- 111775
L["Requires Blades of Death order advancement"] = "Requires Blades of Death order advancement"
L["Tormented Shivarra <Shivarra Recruiter>"] = "Tormented Shivarra <Shivarra Recruiter>" -- 120140
L["Seer Aleis <Seal of Broken Fate Shipment>"] = "Seer Aleis <Seal of Broken Fate Shipment>" -- 112992
L["Requires Focused War Effort order advancement"] = "Requires Focused War Effort order advancement"

-- //////////////////////////
-- Druid
-- //////////////////////////
L["Portal to Emerald Dreamway"] = "Portal to Emerald Dreamway"
L["Seed of Ages"] = "Seed of Ages"
L["Amurra Thistledew <Proprietor>"] = "Amurra Thistledew <Proprietor>" -- 112323
L["Sister Lilith <Recruiter>"] = "Sister Lilith <Recruiter>" -- 108393
L["Leafbeard the Storied <Ancient of Lore>"] = "Leafbeard the Storied <Ancient of Lore>" -- 97989
L["Celadine the Fatekeeper <Dreamgrove Researcher>"] = "Celadine the Fatekeeper <Dreamgrove Researcher>" -- 111737
L["Tender Daranelle"] = "Tender Daranelle" -- 109612
L["Rensar Greathoof <Archdruid of the Grove>"] = "Rensar Greathoof <Archdruid of the Grove>" -- 101195
L["Keeper Remulos"] = "Keeper Remulos" -- 103832
L["Lyessa Bloomwatcher <Guardian of G'Hanir>"] = "Lyessa Bloomwatcher <Guardian of G'Hanir>" -- 104577
L["Skylord Omnuron <Mission Specialist>"] = "Skylord Omnuron <Mission Specialist>" -- 98002
L["Zen'kiki"] = "Zen'kiki" -- 98784
L["Yaris Darkclaw <Recruiter>"] = "Yaris Darkclaw <Recruiter>" -- 106442
L["Mylune"] = "Mylune" -- 113525
L["Requires Wardens of the Grove order advancement"] = "Requires Wardens of the Grove order advancement"
L["Shalorn Star <Dreamgrove Warden Recruiter>"] = "Shalorn Star <Dreamgrove Warden Recruiter>" -- 108391
L["Treant Sapling <Ancient of War Tender>"] = "Treant Sapling <Ancient of War Tender>" -- 111786
L["Requires Ancient of War order advancement"] = "Requires Ancient of War order advancement"
L["Almenis <Seal of Broken Fate Shipment>"] = "Almenis <Seal of Broken Fate Shipment>" -- 110810
L["Requires Elune's Chosen order advancement"] = "Requires Elune's Chosen order advancement"

-- //////////////////////////
-- Hunter
-- //////////////////////////
L["Altar of the Eternal Hunt"] = "Altar of the Eternal Hunt"
L["Tales of the Hunt"] = "Tales of the Hunt"
L["Emmarel Shadewarden <Unseen Path>"] = "Emmarel Shadewarden <Unseen Path>" -- 107317
L["Altar Keeper Biehn"] = "Altar Keeper Biehn" -- 102940
L["Outfitter Reynolds <Unseen Path>"] = "Outfitter Reynolds <Unseen Path>" -- 103693
L["Tactician Tinderfell <Unseen Path>"] = "Tactician Tinderfell <Unseen Path>" -- 103023
L["Holt Thunderhorn <Lore and Legends>"] = "Holt Thunderhorn <Lore and Legends>" -- 98737
L["Loren Stormhoof <Skyhorn Emissary>"] = "Loren Stormhoof <Skyhorn Emissary>" -- 107315
L["Lenara <Recruiter>"] = "Lenara <Recruiter>" -- 106444
L["Survivalist Bahn <Class Hall Upgrades>"] = "Survivalist Bahn <Class Hall Upgrades>" -- 108050
L["Sampson <Recruiter>"] = "Sampson <Recruiter>" -- 106446
L["Pan the Kind Hand <Stable Master>"] = "Pan the Kind Hand <Stable Master>" -- 100661
L["Great Eagle"] = "Great Eagle" -- 108552
L["Ogdrul <The Seeker>"] = "Ogdrul <The Seeker>" -- 113688
L["Image of Mimiron"] = "Image of Mimiron" -- 110424
L["Berger the Steadfast <Champion Armaments>"] = "Berger the Steadfast <Champion Armaments>" -- 110412
L["Requires Born of the Night order advancement"] = "Requires Born of the Night order advancement"
L["Nighthuntress Silus <Nightborne Hunters Recruiter>"] = "Nighthuntress Silus <Nightborne Hunters Recruiter>" -- 106445
L["Tu'Las the Gifted <Seal of Broken Fate Shipment>"] = "Tu'Las the Gifted <Seal of Broken Fate Shipment>"
L["Requires Unseen Path order advancement"] = "Requires Unseen Path order advancement"

-- //////////////////////////
-- Mage
-- //////////////////////////
L["Forge of the Guardian"] = "Forge of the Guardian"
L["Edirah <Tirisgarde Researcher>"] = "Edirah <Tirisgarde Researcher>" -- 110624
L["Jackson Watkins <Tirisgarde Quartermaster>"] = "Jackson Watkins <Tirisgarde Quartermaster>" -- 112440
L["Chronicler Elrianne <Class Hall Upgrades>"] = "Chronicler Elrianne <Class Hall Upgrades>" -- 108331
L["Archmage Omniara <Recruiter>"] = "Archmage Omniara <Recruiter>" -- 106377
L["Archmage Melis <Mistress of Flame>"] = "Archmage Melis <Mistress of Flame>" -- 108515
L["Old Fillmaff <Tirisgarde Librarian>"] = "Old Fillmaff <Tirisgarde Librarian>" -- 107452
L["Meryl Felstorm"] = "Meryl Felstorm" -- 102700
L["Archmage Kalec <Kirin Tor>"] = "Archmage Kalec <Kirin Tor>" -- 108247
L["Archmage Modera <Kirin Tor>"] = "Archmage Modera <Kirin Tor>" -- 108248
L["The Great Akazamzarak"] = "The Great Akazamzarak" -- 103092
L["Grand Conjurer Mimic <Mage Recruiter Extraordinaire>"] = "Grand Conjurer Mimic <Mage Recruiter Extraordinaire>" -- 106433
L["Esara Verrinde <Magisters>"] = "Esara Verrinde <Magisters>" -- 108380
L["Ravandwyr <Senior Kirin Tor Apprentice>"] = "Ravandwyr <Senior Kirin Tor Apprentice>" -- 108377
L["Magister Varenthas <High Forgeguard>"] = "Magister Varenthas <High Forgeguard>" -- 109642
L["Minuette <Armament Summoner>"] = "Minuette <Armament Summoner>" -- 110427
L["Ari"] = "Ari" -- 109307
L["Teleportation Nexus"] = "Teleportation Nexus"
L["Requires Guardians of the Kirin Tor order advancement"] = "Requires Guardians of the Kirin Tor order advancement"
L["Guardian Alar <Kirin Tor Guardians Recruiter>"] = "Guardian Alar <Kirin Tor Guardians Recruiter>" -- 106434
L["Conjurer Awlyn"] = "Conjurer Awlyn" -- 111734
L["Requires Might of Dalaran order advancement"] = "Requires Might of Dalaran order advancement"
L["Focusing Crystal"] = "Focusing Crystal"
L["Researcher Tulius <Seal of Broken Fate Shipment>"] = "Researcher Tulius <Seal of Broken Fate Shipment>" -- 112982
L["Requires Arcane Divination order advancement"] = "Requires Arcane Divination order advancement"

-- //////////////////////////
-- Monk
-- //////////////////////////
L["Portal to Peak of Serenity"] = "Portal to Peak of Serenity"
L["Forge of the Roaring Mountain"] = "Forge of the Roaring Mountain"
L["Transportation Mandala"] = "Transportation Mandala"
L["Caydori Brightstar <Purveyor of Rare Goods>"] = "Caydori Brightstar <Purveyor of Rare Goods>" -- 112338
L["Master Hsu <Mission Master>"] = "Master Hsu <Mission Master>" -- 99179
L["Elder Xang <Monk Trainer>"] = "Elder Xang <Monk Trainer>" -- 101749
L["Iron-Body Ponshu <Senior Master Ox>"] = "Iron-Body Ponshu <Senior Master Ox>" -- 100438
L["Lorewalker Cho <Head Archivist>"] = "Lorewalker Cho <Head Archivist>" -- 106942
L["Lao Li the Quiet <Monk Trainer>"] = "Lao Li the Quiet <Monk Trainer>" -- 101757
L["Number Nine Jia <Class Hall Upgrades>"] = "Number Nine Jia <Class Hall Upgrades>" -- 98939
L["Wise Scholar Lianji <Senior Master Serpent>"] = "Wise Scholar Lianji <Senior Master Serpent>" -- 97776
L["Tianji <Ox Troop Trainer>"] = "Tianji <Ox Troop Trainer>" -- 105015
L["High Elder Cloudfall"] = "High Elder Cloudfall" -- 104744
L["Gin Lai <Tiger Troop Trainer>"] = "Gin Lai <Tiger Troop Trainer>" -- 105019
L["Tianili <Celestial Trainer>"] = "Tianili <Celestial Trainer>" -- 106538
L["Requires Celestial Favor order advancement"] = "Requires Celestial Favor order advancement"
L["Master Swoo <Masters of Serenity Recruiter>"] = "Master Swoo <Masters of Serenity Recruiter>" -- 120145
L["Requires Masters of the Path order advancement"] = "Requires Masters of the Path order advancement"
L["Yushi <Seal of Broken Fate Shipment>"] = "Yushi <Seal of Broken Fate Shipment>" -- 110817
L["Requires One with Destiny order advancement"] = "Requires One with Destiny order advancement"

-- //////////////////////////
-- Paladin
-- //////////////////////////
L["Altar of Ancient Kings"] = "Altar of Ancient Kings"
L["Sister Elda <Keeper of the Ancient Tomes>"] = "Sister Elda <Keeper of the Ancient Tomes>" -- 91190
L["Lord Grayson Shadowbreaker <Mission Specialist>"] = "Lord Grayson Shadowbreaker <Mission Specialist>" -- 90250
L["Katherine the Pure <Paladin Trainer>"] = "Katherine the Pure <Paladin Trainer>" -- 92313
L["Vindicator Baatun <Paladin Trainer>"] = "Vindicator Baatun <Paladin Trainer>" -- 92316
L["Eadric the Pure <Quartermaster>"] = "Eadric the Pure <Quartermaster>" -- 100196
L["Kristoff <Armaments Requisitioner>"] = "Kristoff <Armaments Requisitioner>" -- 110434
L["Brandur Ironhammer <Paladin Trainer>"] = "Brandur Ironhammer <Paladin Trainer>" -- 92314
L["Sir Alamande Graythorn <Class Hall Upgrades>"] = "Sir Alamande Graythorn <Class Hall Upgrades>" -- 109901
L["Commander Ansela <Silver Hand Recruiter>"] = "Commander Ansela <Silver Hand Recruiter>" -- 106447
L["Lord Maxwell Tyrosus"] = "Lord Maxwell Tyrosus" -- 90259
L["Commander Born <Silver Hand Officer Recruiter>"] = "Commander Born <Silver Hand Officer Recruiter>" -- 106448
L["Valgar Highforge <Grand Smith of the Order>"] = "Valgar Highforge <Grand Smith of the Order>" -- 90261
L["Lord Irulon Trueblade"] = "Lord Irulon Trueblade" -- 99947
L["Charger Saddle"] = "Charger Saddle"
L["Terric the Illuminator"] = "Terric the Illuminator" -- 111772
L["Requires Grand Crusade order advancement"] = "Requires Grand Crusade order advancement"
L["Silver Hand Orders"] = "Silver Hand Orders"
L["Requires Silver Hand Crusaders order advancement"] = "Requires Silver Hand Crusaders order advancement"
L["Crusader Kern <Silver Hand Crusader Recruiter>"] = "Crusader Kern <Silver Hand Crusader Recruiter>" -- 120146
L["Librarian Lightmorne <Seal of Broken Fate Shipment>"] = "Librarian Lightmorne <Seal of Broken Fate Shipment>" -- 112986
L["Requires Holy Purpose order advancement"] = "Requires Holy Purpose order advancement"

-- //////////////////////////
-- Priest
-- //////////////////////////
L["Command Map"] = "Command Map"
L["Altar of Light and Shadow"] = "Altar of Light and Shadow"
L["Betild Deepanvil <Master Artificer>"] = "Betild Deepanvil <Master Artificer>" -- 102709
L["Juvess the Duskwhisperer <Keeper of Scrolls>"] = "Juvess the Duskwhisperer <Keeper of Scrolls>" -- 111738
L["Meridelle Lightspark <Logistics>"] = "Meridelle Lightspark <Logistics>" -- 112401
L["Alonsus Faol <Bishop of Secrets>"] = "Alonsus Faol <Bishop of Secrets>" -- 110564
L["Dark Cleric Cecille <Priest Trainer>"] = "Dark Cleric Cecille <Priest Trainer>" -- 112576
L["Grand Anchorite Gesslar <Recruiter>"] = "Grand Anchorite Gesslar <Recruiter>" -- 106450
L["Moira Thaurissan <Queen of the Dark Iron>"] = "Moira Thaurissan <Queen of the Dark Iron>" -- 109776
L["Prophet Velen"] = "Prophet Velen" -- 110557
L["Delas Moonfang <Priestess of the Moon>"] = "Delas Moonfang <Priestess of the Moon>" -- 110571
L["Archon Torias <Class Hall Upgrades>"] = "Archon Torias <Class Hall Upgrades>" -- 110725 
L["Vicar Eliza <Recruiter>"] = "Vicar Eliza <Recruiter>" -- 106451
L["Lilith <Armament Supplier>"] = "Lilith <Armament Supplier>" -- 110595
L["Truth <Seal of Broken Fate Shipment>"] = "Truth <Seal of Broken Fate Shipment>" -- 110819
L["Requires Blessed Seals order advancement"] = "Requires Blessed Seals order advancement"
L["High Priestess Mourn <Recruiter>"] = "High Priestess Mourn <Recruiter>" -- 120160
L["Requires Hooded Priests order advancement"] = "Requires Hooded Priests order advancement"

-- //////////////////////////
-- Rogue
-- //////////////////////////
L["Crucible of the Uncrowned"] = "Crucible of the Uncrowned"
L["Madam Gosu <Black Market Liaison>"] = "Madam Gosu <Black Market Liaison>" -- 103791
L["Lord Jorach Ravenholdt"] = "Lord Jorach Ravenholdt" -- 113362
L["Filius Sparkstache <Archivist>"] = "Filius Sparkstache <Archivist>" -- 102641
L["Marin Noggenfogger <Baron of Gadgetzan>"] = "Marin Noggenfogger <Baron of Gadgetzan>" -- 102594
L["Nikki the Gossip <Tales fo Adventure and Profit>"] = "Nikki the Gossip <Tales fo Adventure and Profit>" -- 98092
L["Loren the Fence <Rogue Trainer>"] = "Loren the Fence <Rogue Trainer>" -- 105989
L["Kelsey Steelspark <Quartermaster>"] = "Kelsey Steelspark <Quartermaster>" -- 105986
L["Lonika Stillblade <Rogue Academy Proprietor>"] = "Lonika Stillblade <Rogue Academy Proprietor>" -- 105979
L["Night-Stalker Ku'nanji <Rogue Trainer>"] = "Night-Stalker Ku'nanji <Rogue Trainer>" -- 105991
L["Winstone Wolfe <The Wolf>"] = "Winstone Wolfe <The Wolf>" -- 105998
L["Lorena Belle <Master Smuggler>"] = "Lorena Belle <Master Smuggler>" -- 109609
L["Yancey Grillsen <Bloodsail Recruiter>"] = "Yancey Grillsen <Bloodsail Recruiter>" -- 106083
L["Jenri <Spymaster>"] = "Jenri <Spymaster>" -- 99863
L["Valeera Sanguinar"] = "Valeera Sanguinar" -- 98102
L["Garona Halforcen"] = "Garona Halforcen" -- 94141
L["Mal <Weapons Smuggler>"] = "Mal <Weapons Smuggler>" -- 110348
L["Vanessa VanCleef"] = "Vanessa VanCleef" -- 102550
L["Knocker - %s"] = "Knocker - %s"
L["Scythe <Seal of Broken Fate Shipment>"] = "Scythe <Seal of Broken Fate Shipment>" -- 110820
L["Requires Plunder order advancement"] = "Requires Plunder order advancement"
L["Laura Stern <Recruiter>"] = "Laura Stern <Recruiter>" -- 120162
L["Requires Ravenholdt's Finest order advancement"] = "Requires Ravenholdt's Finest order advancement"
L["Mal <Weapons Smuggler>"] = "Mal <Weapons Smuggler>" -- 110348

-- //////////////////////////
-- Shaman
-- //////////////////////////
L["Maelstrom Pillar"] = "Maelstrom Pillar"
L["Ancient Elemental Altar"] = "Ancient Elemental Altar"
L["Vortex Pinnacle Portal"] = "Vortex Pinnacle Portal";
L["Aggra <Shaman Trainer>"] = "Aggra <Shaman Trainer>" -- 99531
L["Elementalist Janai <Earthen Ring>"] = "Elementalist Janai <Earthen Ring>" -- 109464
L["Puzzlemaster Lo <The Earthen Ring>"] = "Puzzlemaster Lo <The Earthen Ring>" -- 103004
L["Flamesmith Lanying <Earthen Ring Quartermaster>"] = "Flamesmith Lanying <Earthen Ring Quartermaster>" -- 112318
L["Gorma Windspeaker <Keeper of Legends>"] = "Gorma Windspeaker <Keeper of Legends>" -- 111739
L["Tribemother Torra <Shaman Trainer>"] = "Tribemother Torra <Shaman Trainer>" -- 111922
L["Advisor Sevel <The Earthen Ring>"] = "Advisor Sevel <The Earthen Ring>" -- 96746
L["Journeyman Goldmine <Class Hall Upgrades>"] = "Journeyman Goldmine <Class Hall Upgrades>" -- 112199
L["Farseer Nobundo <The Earthen Ring>"] = "Farseer Nobundo <The Earthen Ring>" -- 96528
L["Gavan Grayfeather <Ears of the Maelstrom>"] = "Gavan Grayfeather <Ears of the Maelstrom>" -- 112262
L["Orono <The Earthen Ring>"] = "Orono <The Earthen Ring>" -- 96745
L["Mackay Firebeard <The Earthen Ring>"] = "Mackay Firebeard <The Earthen Ring>" -- 96758
L["Bath'rah the Windwatcher <The Earthen Ring>"] = "Bath'rah the Windwatcher <The Earthen Ring>" -- 96747
L["Morgl the Oracle <The Earthen Ring>"] = "Morgl the Oracle <The Earthen Ring>" -- 112438
L["Summoner Morn <Elemental Summoner>"] = "Summoner Morn <Elemental Summoner>" -- 106457
L["Neptulon"] = "Neptulon" -- 106291
L["Felinda Frye <Earthwarden Recruiter>"] = "Felinda Frye <Earthwarden Recruiter>" -- 112208
L["Alexor <The Ascended>"] = "Alexor <The Ascended>" -- 109829
L["Requires \"Rise!\" order advancement"] = "Requires \"Rise!\" order advancement"
L["Bath'rah the Windwatcher <Seal of Broken Fate Shipment>"] = "Bath'rah the Windwatcher <Seal of Broken Fate Shipment>" -- 112299
L["Requires Spirit Walk order advancement"] = "Requires Spirit Walk order advancement"
L["Marick Ven <Earthen Ring Protectors Recruiter>"] = "Marick Ven <Earthen Ring Protectors Recruiter>" -- 120165
L["Requires Ring of Earth order advancement"] = "Requires Ring of Earth order advancement"

-- //////////////////////////
-- Warlock
-- //////////////////////////
L["Felblood Altar"] = "Felblood Altar"
L["Dreadscar Battle Plans"] = "Dreadscar Battle Plans"
L["Demonic Gateway"] = "Demonic Gateway"
L["Calydus"] = "Calydus" -- 101097
L["Unjari Feltongue <The Heartbearer>"] = "Unjari Feltongue <The Heartbearer>" -- 109686
L["Lurr <Dreadscar Blacksmith>"] = "Lurr <Dreadscar Blacksmith>" -- 101913
L["Ritssyn Flamescowl <Council of the Black Harvest>"] = "Ritssyn Flamescowl <Council of the Black Harvest>" -- 104795
L["Gakin the Darkbinder <Mission Strategist>"] = "Gakin the Darkbinder <Mission Strategist>" -- 106199
L["Gigi Gigavoid <Black Harvest Quartermaster>"] = "Gigi Gigavoid <Black Harvest Quartermaster>" -- 112434
L["Mile Raitheborne <Head Archivist>"] = "Mile Raitheborne <Head Archivist>" -- 111740
L["Jared <Recruiter>"] = "Jared <Recruiter>" -- 106217
L["Imp Mother Dyala <Recruiter>"] = "Imp Mother Dyala <Recruiter>" -- 106216
L["Archivist Melinda <Class Hall Upgrades>"] = "Archivist Melinda <Class Hall Upgrades>" -- 108018
L["Murr"] = "Murr" -- 110408
L["Demonia Pickerin"] = "Demonia Pickerin" -- 113371
L["Requires Unleash Infernal order advancement"] = "Requires Unleash Infernal order advancement"
L["Demonic Phylactery"] = "Demonic Phylactery"
L["Galen Foul <Demon Summoner>"] = "Galen Foul <Demon Summoner>" -- 120166
L["Requires Demonic Brutes order advancement"] = "Requires Demonic Brutes order advancement"

-- //////////////////////////
-- Warrior
-- //////////////////////////
L["Forge of Odyn"] = "Forge of Odyn"
L["Eye of Odyn"] = "Eye of Odyn"
L["Aerylia <Stormflight Master>"] = "Aerylia <Stormflight Master>" -- 96679
L["Quartermaster Durnolf"] = "Quartermaster Durnolf" -- 112392
L["Fjornson Stonecarver <Keeper of Legends>"] = "Fjornson Stonecarver <Keeper of Legends>" -- 111741
L["Master Smith Helgar"] = "Master Smith Helgar" -- 96586
L["Weaponmaster Asvard <Warrior Trainer>"] = "Weaponmaster Asvard <Warrior Trainer>" -- 112577
L["Skyseer Ghrent"] = "Skyseer Ghrent" -- 100635
L["Captain Hjalmar Stahlstrom <Recruiter>"] = "Captain Hjalmar Stahlstrom <Recruiter>" -- 106459
L["Einar the Runecaster <Class Hall Upgrades>"] = "Einar the Runecaster <Class Hall Upgrades>" -- 107994 
L["Savyn Valorborn <Recruiter>"] = "Savyn Valorborn <Recruiter>" -- 106460
L["Haklang Ulfsson <Armaments Requisitioner>"] = "Haklang Ulfsson <Armaments Requisitioner>" -- 110437
L["Hymdall"] = "Hymdall" -- 107987
L["Odyn"] = "Odyn" -- 96469
L["Requires Val'kyr Call order advancement"] = "Requires Val'kyr Call order advancement"
L["Horn of War"] = "Horn of War"
L["Matilda Skoptidottir"] = "Matilda Skoptidottir" -- 111774
L["Requires Strike Hard order advancement"] = "Requires Strike Hard order advancement"
L["Sharak Tor <Recruiter>"] = "Sharak Tor <Recruiter>" -- 106461, horde
L["Matthew Glensorrow <Recruiter>"] = "Matthew Glensorrow <Recruiter>" -- 120077, alliance
end
