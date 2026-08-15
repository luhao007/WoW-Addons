local spec = LBIS:RegisterSpec(LBIS.L["Shaman"], LBIS.L["Restoration"], "1", 264)

-- Bonus IDs for correct item level display
LBIS.ItemBonuses[249979] = "12806:13335"
LBIS.ItemBonuses[50228] = "12806"
LBIS.ItemBonuses[249977] = "12806:13335"
LBIS.ItemBonuses[260312] = "12806"
LBIS.ItemBonuses[249982] = "12806:13335"
LBIS.ItemBonuses[244584] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[249980] = "12806:13335"
LBIS.ItemBonuses[249303] = "12806:13335"
LBIS.ItemBonuses[49810] = "12806"
LBIS.ItemBonuses[244611] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[249978] = "12806:13335"
LBIS.ItemBonuses[251215] = "12806"
LBIS.ItemBonuses[249320] = "12806:13335"
LBIS.ItemBonuses[193708] = "12806"
LBIS.ItemBonuses[251217] = "12806"
LBIS.ItemBonuses[49812] = "12806"
LBIS.ItemBonuses[264507] = "12790"
LBIS.ItemBonuses[49824] = "12806"
LBIS.ItemBonuses[258585] = "12806"
LBIS.ItemBonuses[251096] = "4786:12806"
LBIS.ItemBonuses[251161] = "12806"
LBIS.ItemBonuses[49823] = "4786:12806"
LBIS.ItemBonuses[251079] = "12806"
LBIS.ItemBonuses[151321] = "12806"
LBIS.ItemBonuses[193715] = "12806"
LBIS.ItemBonuses[251084] = "12806"
LBIS.ItemBonuses[250256] = "4786:12806"
LBIS.ItemBonuses[193718] = "12806"
LBIS.ItemBonuses[245770] = "12066:13622:9627:8791:12693"
LBIS.ItemBonuses[249275] = "4786:12806"
LBIS.ItemBonuses[49811] = "12806"
LBIS.ItemBonuses[50233] = "12806"
LBIS.ItemBonuses[237831] = "12806"
LBIS.ItemBonuses[237844] = "12806"
LBIS.ItemBonuses[237849] = "12806"
LBIS.ItemBonuses[249647] = "12806"
LBIS.ItemBonuses[251089] = "12806"
LBIS.ItemBonuses[251097] = "12806"
LBIS.ItemBonuses[251179] = "12806"
LBIS.ItemBonuses[251202] = "12806"
LBIS.ItemBonuses[258576] = "12806"
LBIS.ItemBonuses[265739] = "12806"

LBIS:AddItem(spec, "249979", LBIS.L["Head"], "BIS") --Tier / Catalyst (47.7%)
LBIS:AddItem(spec, "49824", LBIS.L["Head"], "Alt") --Pit of Saron (13.0%)
LBIS:AddItem(spec, "258585", LBIS.L["Head"], "Alt") --Skyreach (9.8%)
LBIS:AddItem(spec, "50228", LBIS.L["Neck"], "BIS") --Pit of Saron (27.0%)
LBIS:AddItem(spec, "265739", LBIS.L["Neck"], "Alt") --(17.0%)
LBIS:AddItem(spec, "251096", LBIS.L["Neck"], "Alt") --Windrunner Spire (13.1%)
LBIS:AddItem(spec, "249977", LBIS.L["Shoulder"], "BIS") --Tier / Catalyst (78.3%)
LBIS:AddItem(spec, "50233", LBIS.L["Shoulder"], "Alt") --Pit of Saron (4.3%)
LBIS:AddItem(spec, "251097", LBIS.L["Shoulder"], "Alt") --Windrunner Spire (3.3%)
LBIS:AddItem(spec, "251161", LBIS.L["Back"], "BIS") --Maisara Caverns (19.6%)
LBIS:AddItem(spec, "49823", LBIS.L["Back"], "Alt") --Pit of Saron (19.5%)
LBIS:AddItem(spec, "260312", LBIS.L["Back"], "Alt") --Magisters' Terrace (12.0%)
LBIS:AddItem(spec, "249982", LBIS.L["Chest"], "BIS") --Tier / Catalyst (74.0%)
LBIS:AddItem(spec, "251179", LBIS.L["Chest"], "Alt") --Maisara Caverns (5.5%)
LBIS:AddItem(spec, "258576", LBIS.L["Chest"], "Alt") --Skyreach (5.4%)
LBIS:AddItem(spec, "251079", LBIS.L["Wrist"], "BIS") --Windrunner Spire (18.9%)
LBIS:AddItem(spec, "151321", LBIS.L["Wrist"], "Alt") --Seat of the Triumvirate (16.9%)
LBIS:AddItem(spec, "244584", LBIS.L["Wrist"], "Alt") --Crafted (15.3%)
LBIS:AddItem(spec, "249980", LBIS.L["Hands"], "BIS") --Tier / Catalyst (67.7%)
LBIS:AddItem(spec, "251089", LBIS.L["Hands"], "Alt") --Windrunner Spire (10.0%)
LBIS:AddItem(spec, "249647", LBIS.L["Hands"], "Alt") --(7.0%)
LBIS:AddItem(spec, "249303", LBIS.L["Waist"], "BIS") --The Voidspire (20.4%)
LBIS:AddItem(spec, "49810", LBIS.L["Waist"], "Alt") --Pit of Saron (17.0%)
LBIS:AddItem(spec, "244611", LBIS.L["Waist"], "Alt") --Tier / Catalyst (11.2%)
LBIS:AddItem(spec, "249978", LBIS.L["Legs"], "BIS") --Tier / Catalyst (77.5%)
LBIS:AddItem(spec, "49811", LBIS.L["Legs"], "Alt") --Pit of Saron (4.4%)
LBIS:AddItem(spec, "251215", LBIS.L["Legs"], "Alt") --Nexus-Point Xenas (4.4%)
LBIS:AddItem(spec, "193715", LBIS.L["Feet"], "BIS") --Algeth'ar Academy (18.9%)
LBIS:AddItem(spec, "249320", LBIS.L["Feet"], "Alt") --The Voidspire (18.6%)
LBIS:AddItem(spec, "251084", LBIS.L["Feet"], "Alt") --Windrunner Spire (15.4%)
LBIS:AddItem(spec, "193708", LBIS.L["Ring"], "BIS") --Algeth'ar Academy (33.3%)
LBIS:AddItem(spec, "251217", LBIS.L["Ring"], "BIS") --Nexus-Point Xenas (30.2%)
LBIS:AddItem(spec, "49812", LBIS.L["Ring"], "Alt") --Pit of Saron (27.2%)
LBIS:AddItem(spec, "264507", LBIS.L["Trinket"], "BIS") --(50.0%)
LBIS:AddItem(spec, "250256", LBIS.L["Trinket"], "BIS") --Windrunner Spire (23.4%)
LBIS:AddItem(spec, "193718", LBIS.L["Trinket"], "Alt") --Algeth'ar Academy (19.8%)
LBIS:AddItem(spec, "245770", LBIS.L["Main Hand"], "BIS") --Crafted (24.5%)
LBIS:AddItem(spec, "237849", LBIS.L["Main Hand"], "Alt") --Crafted (16.3%)
LBIS:AddItem(spec, "237844", LBIS.L["Main Hand"], "Alt") --Crafted (14.7%)
LBIS:AddItem(spec, "249275", LBIS.L["Off Hand"], "BIS") --The Voidspire (13.3%)
LBIS:AddItem(spec, "237831", LBIS.L["Off Hand"], "Alt") --Crafted (12.0%)
LBIS:AddItem(spec, "251202", LBIS.L["Off Hand"], "Alt") --Nexus-Point Xenas (9.0%)

-- Enchants
LBIS:AddEnchant(spec, "243950", LBIS.L["Head"]) --Enchant Helm - Empowered Hex of Leeching
LBIS:AddEnchant(spec, "244021", LBIS.L["Shoulder"]) --Enchant Shoulders - Silvermoon's Mending
LBIS:AddEnchant(spec, "240155", LBIS.L["Legs"]) --Arcanoweave Spellthread
LBIS:AddEnchant(spec, "244002", LBIS.L["Chest"]) --Enchant Chest - Mark of the Magister
LBIS:AddEnchant(spec, "243983", LBIS.L["Feet"]) --Enchant Boots - Shaladrassil's Roots
LBIS:AddEnchant(spec, "243986", LBIS.L["Ring"]) --Enchant Ring - Nature's Fury
LBIS:AddEnchant(spec, "244029", LBIS.L["Main Hand"]) --Enchant Weapon - Acuity of the Ren'dorei

-- Gems
LBIS:AddGem(spec, "240983", "4", "True") --Indecipherable Eversong Diamond
LBIS:AddGem(spec, "240968", "4", "True") --Telluric Eversong Diamond
LBIS:AddGem(spec, "240910", "3", "False") --Flawless Versatile Garnet
LBIS:AddGem(spec, "240914", "3", "False") --Flawless Deadly Lapis
LBIS:AddGem(spec, "240890", "3", "False") --Flawless Deadly Peridot
LBIS:AddGem(spec, "240898", "3", "False") --Flawless Deadly Amethyst

-- Embellishments
LBIS:AddEmbellishment(spec, "237849", "245876") --Magister's Valediction + Darkmoon Sigil: Hunt

-- New items from Peavers data update
LBIS.ItemBonuses[244578] = "12214:8960:12497:12066:13622:13667"
LBIS:AddItem(spec, "244578", LBIS.L["Chest"], "Alt 4") --Farstrider's Scouting Vest
LBIS.ItemBonuses[249975] = "12806"
LBIS:AddItem(spec, "249975", LBIS.L["Wrist"], "Alt 3") --Cuffs of the Primal Core
LBIS:AddItem(spec, "249975", LBIS.L["Wrist"], "Alt 4") --Cuffs of the Primal Core

-- New items Apr 17
LBIS.ItemBonuses[249811] = "12806:13335"
LBIS:AddItem(spec, "249811", LBIS.L["Ring"], "Alt 3") --Light of the Cosmic Crescendo

-- Apr 26
LBIS.ItemBonuses[244579] = "12214:8960:12497:12066:13622:13667"
LBIS:AddItem(spec, "244579", LBIS.L["Head"], "Alt 4") --Farstrider's Unwavering Visage

-- 2026-05-20
LBIS.ItemBonuses[252411] = "12806"
LBIS:AddItem(spec, "252411", LBIS.L["Trinket"], "Alt 4") --Radiant Sunstone
LBIS.ItemBonuses[50227] = "12806"
LBIS:AddItem(spec, "50227", LBIS.L["Main Hand"], "Alt 1") --Surgeon's Needle
LBIS.ItemBonuses[50227] = "12806"
LBIS:AddItem(spec, "50227", LBIS.L["Main Hand"], "Alt 2") --Surgeon's Needle
