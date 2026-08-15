local spec = LBIS:RegisterSpec(LBIS.L["Druid"], LBIS.L["Feral"], "1", 103)

-- Bonus IDs for correct item level display
LBIS.ItemBonuses[250024] = "12806:13335"
LBIS.ItemBonuses[251109] = "12806"
LBIS.ItemBonuses[50228] = "12806"
LBIS.ItemBonuses[250022] = "12806:13335"
LBIS.ItemBonuses[258575] = "12806"
LBIS.ItemBonuses[260312] = "12806"
LBIS.ItemBonuses[239656] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[250027] = "12806:13335"
LBIS.ItemBonuses[244576] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[193714] = "12806"
LBIS.ItemBonuses[250025] = "12806:13335"
LBIS.ItemBonuses[251113] = "12806"
LBIS.ItemBonuses[244575] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[251082] = "12806"
LBIS.ItemBonuses[49806] = "12806"
LBIS.ItemBonuses[250023] = "12806:13335"
LBIS.ItemBonuses[49817] = "12806"
LBIS.ItemBonuses[251087] = "12806"
LBIS.ItemBonuses[258577] = "12806"
LBIS.ItemBonuses[251093] = "12806"
LBIS.ItemBonuses[251115] = "12806"
LBIS.ItemBonuses[251217] = "12806"
LBIS.ItemBonuses[193701] = "12806"
LBIS.ItemBonuses[264507] = "12790"
LBIS.ItemBonuses[249302] = "12806:13335"
LBIS.ItemBonuses[251096] = "4786:12806"
LBIS.ItemBonuses[251092] = "12806"
LBIS.ItemBonuses[251216] = "4786:12806"
LBIS.ItemBonuses[251121] = "12806"
LBIS.ItemBonuses[250256] = "4786:12806"
LBIS.ItemBonuses[245771] = "12066:13622:9627:12693:8791"
LBIS.ItemBonuses[237847] = "12066:13622:9627:8793:12693"
LBIS.ItemBonuses[151319] = "12806"
LBIS.ItemBonuses[249638] = "12806"
LBIS.ItemBonuses[249644] = "12806"
LBIS.ItemBonuses[251099] = "12806"
LBIS.ItemBonuses[263267] = "12806"
LBIS.ItemBonuses[265739] = "12806"
LBIS.ItemBonuses[266430] = "12806"

LBIS:AddItem(spec, "250024", LBIS.L["Head"], "BIS") --Tier / Catalyst (77.1%)
LBIS:AddItem(spec, "251109", LBIS.L["Head"], "Alt") --Magisters' Terrace (6.8%)
LBIS:AddItem(spec, "266430", LBIS.L["Head"], "Alt") --(5.3%)
LBIS:AddItem(spec, "50228", LBIS.L["Neck"], "BIS") --Pit of Saron (29.6%)
LBIS:AddItem(spec, "265739", LBIS.L["Neck"], "Alt") --(14.8%)
LBIS:AddItem(spec, "251096", LBIS.L["Neck"], "Alt") --Windrunner Spire (10.7%)
LBIS:AddItem(spec, "250022", LBIS.L["Shoulder"], "BIS") --Tier / Catalyst (76.2%)
LBIS:AddItem(spec, "151319", LBIS.L["Shoulder"], "Alt") --Seat of the Triumvirate (4.9%)
LBIS:AddItem(spec, "251092", LBIS.L["Shoulder"], "Alt") --Windrunner Spire (4.7%)
LBIS:AddItem(spec, "258575", LBIS.L["Back"], "BIS") --Skyreach (24.6%)
LBIS:AddItem(spec, "260312", LBIS.L["Back"], "Alt") --Magisters' Terrace (14.1%)
LBIS:AddItem(spec, "239656", LBIS.L["Back"], "Alt") --Crafted (10.4%)
LBIS:AddItem(spec, "250027", LBIS.L["Chest"], "BIS") --Tier / Catalyst (74.9%)
LBIS:AddItem(spec, "251216", LBIS.L["Chest"], "Alt") --Nexus-Point Xenas (8.8%)
LBIS:AddItem(spec, "251099", LBIS.L["Chest"], "Alt") --Windrunner Spire (5.1%)
LBIS:AddItem(spec, "244576", LBIS.L["Wrist"], "BIS") --Crafted (31.2%)
LBIS:AddItem(spec, "193714", LBIS.L["Wrist"], "Alt") --Algeth'ar Academy (26.9%)
LBIS:AddItem(spec, "249644", LBIS.L["Wrist"], "Alt") --(10.4%)
LBIS:AddItem(spec, "250025", LBIS.L["Hands"], "BIS") --Tier / Catalyst (39.6%)
LBIS:AddItem(spec, "251113", LBIS.L["Hands"], "Alt") --Magisters' Terrace (17.0%)
LBIS:AddItem(spec, "244575", LBIS.L["Hands"], "Alt") --Crafted (9.4%)
LBIS:AddItem(spec, "251082", LBIS.L["Waist"], "BIS") --Windrunner Spire (19.6%)
LBIS:AddItem(spec, "49806", LBIS.L["Waist"], "Alt") --Pit of Saron (16.5%)
LBIS:AddItem(spec, "263267", LBIS.L["Waist"], "Alt") --(13.9%)
LBIS:AddItem(spec, "250023", LBIS.L["Legs"], "BIS") --Tier / Catalyst (79.1%)
LBIS:AddItem(spec, "49817", LBIS.L["Legs"], "Alt") --Pit of Saron (6.8%)
LBIS:AddItem(spec, "251087", LBIS.L["Legs"], "Alt") --Windrunner Spire (3.7%)
LBIS:AddItem(spec, "258577", LBIS.L["Feet"], "BIS") --Skyreach (32.3%)
LBIS:AddItem(spec, "251121", LBIS.L["Feet"], "Alt") --Magisters' Terrace (13.5%)
LBIS:AddItem(spec, "249638", LBIS.L["Feet"], "Alt") --(10.0%)
LBIS:AddItem(spec, "251093", LBIS.L["Ring"], "BIS") --Nexus-Point Xenas (44.4%)
LBIS:AddItem(spec, "251115", LBIS.L["Ring"], "BIS") --Magisters' Terrace (34.7%)
LBIS:AddItem(spec, "251217", LBIS.L["Ring"], "Alt") --Nexus-Point Xenas (34.1%)
LBIS:AddItem(spec, "193701", LBIS.L["Trinket"], "BIS") --Algeth'ar Academy (88.6%)
LBIS:AddItem(spec, "264507", LBIS.L["Trinket"], "BIS") --(25.6%)
LBIS:AddItem(spec, "250256", LBIS.L["Trinket"], "Alt") --Windrunner Spire (19.6%)
LBIS:AddItem(spec, "245771", LBIS.L["Main Hand"], "BIS") --Crafted (31.1%)
LBIS:AddItem(spec, "237847", LBIS.L["Main Hand"], "Alt") --Crafted (18.3%)
LBIS:AddItem(spec, "249302", LBIS.L["Main Hand"], "Alt") --The Voidspire (15.2%)

-- Enchants
LBIS:AddEnchant(spec, "244029", LBIS.L["Main Hand"]) --Enchant Weapon - Acuity of the Ren'dorei
LBIS:AddEnchant(spec, "244007", LBIS.L["Head"]) --Enchant Helm - Empowered Rune of Avoidance
LBIS:AddEnchant(spec, "243990", LBIS.L["Shoulder"]) --Enchant Shoulders - Amirdrassil's Grace
LBIS:AddEnchant(spec, "243977", LBIS.L["Chest"]) --Enchant Chest - Mark of the Worldsoul
LBIS:AddEnchant(spec, "244640", LBIS.L["Legs"]) --Forest Hunter's Armor Kit
LBIS:AddEnchant(spec, "243952", LBIS.L["Feet"]) --Enchant Boots - Lynx's Dexterity
LBIS:AddEnchant(spec, "243956", LBIS.L["Ring"]) --Enchant Ring - Eyes of the Eagle

-- Gems
LBIS:AddGem(spec, "240983", "4", "True") --Indecipherable Eversong Diamond
LBIS:AddGem(spec, "240892", "3", "False") --Flawless Masterful Peridot
LBIS:AddGem(spec, "240900", "3", "False") --Flawless Quick Amethyst

-- Embellishments
LBIS:AddEmbellishment(spec, "237847", "245876") --Blood Knight's Impetus + Darkmoon Sigil: Hunt
LBIS:AddEmbellishment(spec, "244570", "240167") --Silvermoon Agent's Coat + Arcanoweave Lining
LBIS:AddEmbellishment(spec, "244573", "0") --Silvermoon Agent's Utility Belt + 

-- New items from Peavers data update
LBIS.ItemBonuses[250026] = "12806"
LBIS:AddItem(spec, "250026", LBIS.L["Feet"], "Alt 3") --Rootslippers of the Luminous Bloom
LBIS:AddItem(spec, "250026", LBIS.L["Feet"], "Alt 2") --Rootslippers of the Luminous Bloom
LBIS.ItemBonuses[250019] = "12806"
LBIS:AddItem(spec, "250019", LBIS.L["Back"], "Alt 4") --Leafdrape of the Luminous Bloom

-- Apr 26
LBIS.ItemBonuses[171878] = "12806"
LBIS:AddItem(spec, "171878", LBIS.L["Head"], "Alt 4") --Stormrider's Helm
