local spec = LBIS:RegisterSpec(LBIS.L["Monk"], LBIS.L["Mistweaver"], "1", 270)

-- Bonus IDs for correct item level display
LBIS.ItemBonuses[250015] = "12806:13335"
LBIS.ItemBonuses[151336] = "12806"
LBIS.ItemBonuses[50228] = "12806"
LBIS.ItemBonuses[151309] = "12806"
LBIS.ItemBonuses[250013] = "12806:13335"
LBIS.ItemBonuses[260312] = "12806"
LBIS.ItemBonuses[250010] = "12806:13335"
LBIS.ItemBonuses[250018] = "12806:13335"
LBIS.ItemBonuses[151313] = "12806"
LBIS.ItemBonuses[50264] = "12806"
LBIS.ItemBonuses[244576] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[250016] = "12806:13335"
LBIS.ItemBonuses[49806] = "12806"
LBIS.ItemBonuses[249374] = "12806:13335"
LBIS.ItemBonuses[250014] = "12806:13335"
LBIS.ItemBonuses[251087] = "12806"
LBIS.ItemBonuses[49817] = "12806"
LBIS.ItemBonuses[251210] = "12806"
LBIS.ItemBonuses[250017] = "12806:13335"
LBIS.ItemBonuses[249334] = "12806:13335"
LBIS.ItemBonuses[49812] = "12806"
LBIS.ItemBonuses[251217] = "12806"
LBIS.ItemBonuses[151311] = "12806"
LBIS.ItemBonuses[249808] = "12806:13335"
LBIS.ItemBonuses[258050] = "12806"
LBIS.ItemBonuses[245769] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[251094] = "12806"
LBIS.ItemBonuses[251096] = "4786:12806"
LBIS.ItemBonuses[193712] = "12806"
LBIS.ItemBonuses[151318] = "12806"
LBIS.ItemBonuses[251166] = "4786:12806"
LBIS.ItemBonuses[250256] = "4786:12806"
LBIS.ItemBonuses[249341] = "12806"
LBIS.ItemBonuses[245770] = "12066:13622:9627:8791:12693"
LBIS.ItemBonuses[251201] = "12806"
LBIS.ItemBonuses[193709] = "12806"
LBIS.ItemBonuses[249642] = "12806"
LBIS.ItemBonuses[251103] = "12806"
LBIS.ItemBonuses[251171] = "12806"
LBIS.ItemBonuses[251204] = "12806"
LBIS.ItemBonuses[258586] = "12806"
LBIS.ItemBonuses[266430] = "12806"

LBIS:AddItem(spec, "250015", LBIS.L["Head"], "BIS") --Tier / Catalyst (62.9%)
LBIS:AddItem(spec, "151336", LBIS.L["Head"], "Alt") --Seat of the Triumvirate (11.3%)
LBIS:AddItem(spec, "266430", LBIS.L["Head"], "Alt") --(7.8%)
LBIS:AddItem(spec, "50228", LBIS.L["Neck"], "BIS") --Pit of Saron (29.8%)
LBIS:AddItem(spec, "251096", LBIS.L["Neck"], "Alt") --Windrunner Spire (17.7%)
LBIS:AddItem(spec, "151309", LBIS.L["Neck"], "Alt") --Seat of the Triumvirate (16.5%)
LBIS:AddItem(spec, "250013", LBIS.L["Shoulder"], "BIS") --Tier / Catalyst (52.8%)
LBIS:AddItem(spec, "251171", LBIS.L["Shoulder"], "Alt") --Maisara Caverns (13.2%)
LBIS:AddItem(spec, "249642", LBIS.L["Shoulder"], "Alt") --(9.2%)
LBIS:AddItem(spec, "260312", LBIS.L["Back"], "BIS") --Magisters' Terrace (27.3%)
LBIS:AddItem(spec, "193712", LBIS.L["Back"], "Alt") --Algeth'ar Academy (18.1%)
LBIS:AddItem(spec, "250010", LBIS.L["Back"], "Alt") --(9.4%)
LBIS:AddItem(spec, "250018", LBIS.L["Chest"], "BIS") --Tier / Catalyst (72.3%)
LBIS:AddItem(spec, "258586", LBIS.L["Chest"], "Alt") --Skyreach (6.2%)
LBIS:AddItem(spec, "151313", LBIS.L["Chest"], "Alt") --Seat of the Triumvirate (5.9%)
LBIS:AddItem(spec, "50264", LBIS.L["Wrist"], "BIS") --Pit of Saron (35.3%)
LBIS:AddItem(spec, "251103", LBIS.L["Wrist"], "Alt") --Magisters' Terrace (18.1%)
LBIS:AddItem(spec, "244576", LBIS.L["Wrist"], "Alt") --Crafted (12.0%)
LBIS:AddItem(spec, "250016", LBIS.L["Hands"], "BIS") --Tier / Catalyst (53.9%)
LBIS:AddItem(spec, "251204", LBIS.L["Hands"], "Alt") --Nexus-Point Xenas (16.3%)
LBIS:AddItem(spec, "151318", LBIS.L["Hands"], "Alt") --Seat of the Triumvirate (10.7%)
LBIS:AddItem(spec, "49806", LBIS.L["Waist"], "BIS") --Pit of Saron (35.5%)
LBIS:AddItem(spec, "251166", LBIS.L["Waist"], "Alt") --Maisara Caverns (20.9%)
LBIS:AddItem(spec, "249374", LBIS.L["Waist"], "Alt") --The Dreamrift (17.5%)
LBIS:AddItem(spec, "250014", LBIS.L["Legs"], "BIS") --Tier / Catalyst (56.6%)
LBIS:AddItem(spec, "251087", LBIS.L["Legs"], "Alt") --Windrunner Spire (20.5%)
LBIS:AddItem(spec, "49817", LBIS.L["Legs"], "Alt") --Pit of Saron (5.9%)
LBIS:AddItem(spec, "251210", LBIS.L["Feet"], "BIS") --Nexus-Point Xenas (27.9%)
LBIS:AddItem(spec, "250017", LBIS.L["Feet"], "Alt") --(11.9%)
LBIS:AddItem(spec, "249334", LBIS.L["Feet"], "Alt") --The Voidspire (11.6%)
LBIS:AddItem(spec, "49812", LBIS.L["Ring"], "BIS") --Pit of Saron (48.6%)
LBIS:AddItem(spec, "251217", LBIS.L["Ring"], "BIS") --Nexus-Point Xenas (37.7%)
LBIS:AddItem(spec, "151311", LBIS.L["Ring"], "Alt") --Seat of the Triumvirate (37.6%)
LBIS:AddItem(spec, "250256", LBIS.L["Trinket"], "BIS") --Windrunner Spire (48.0%)
LBIS:AddItem(spec, "249808", LBIS.L["Trinket"], "BIS") --The Voidspire (38.4%)
LBIS:AddItem(spec, "249341", LBIS.L["Trinket"], "Alt") --The Voidspire (20.7%)
LBIS:AddItem(spec, "245770", LBIS.L["Main Hand"], "BIS") --Crafted (72.7%)
LBIS:AddItem(spec, "251201", LBIS.L["Main Hand"], "Alt") --Nexus-Point Xenas (3.3%)
LBIS:AddItem(spec, "258050", LBIS.L["Main Hand"], "Alt") --Skyreach (3.0%)
LBIS:AddItem(spec, "193709", LBIS.L["Off Hand"], "BIS") --Algeth'ar Academy (3.8%)
LBIS:AddItem(spec, "245769", LBIS.L["Off Hand"], "Alt") --Crafted (2.0%)
LBIS:AddItem(spec, "251094", LBIS.L["Off Hand"], "Alt") --Windrunner Spire (1.8%)

-- Enchants
LBIS:AddEnchant(spec, "244029", LBIS.L["Main Hand"]) --Enchant Weapon - Acuity of the Ren'dorei
LBIS:AddEnchant(spec, "243950", LBIS.L["Head"]) --Enchant Helm - Empowered Hex of Leeching
LBIS:AddEnchant(spec, "244021", LBIS.L["Shoulder"]) --Enchant Shoulders - Silvermoon's Mending
LBIS:AddEnchant(spec, "243977", LBIS.L["Chest"]) --Enchant Chest - Mark of the Worldsoul
LBIS:AddEnchant(spec, "240155", LBIS.L["Legs"]) --Arcanoweave Spellthread
LBIS:AddEnchant(spec, "243983", LBIS.L["Feet"]) --Enchant Boots - Shaladrassil's Roots
LBIS:AddEnchant(spec, "244014", LBIS.L["Ring"]) --Enchant Ring - Silvermoon's Alacrity
LBIS:AddEnchant(spec, "240167", LBIS.L["Back"]) --Arcanoweave Lining

-- Embellishments
LBIS:AddEmbellishment(spec, "245770", "245874") --Aln'hara Cane + Darkmoon Sigil: Void
LBIS:AddEmbellishment(spec, "244569", "240167") --Silvermoon Agent's Sneakers + Arcanoweave Lining
LBIS:AddEmbellishment(spec, "244573", "0") --Silvermoon Agent's Utility Belt + 

-- New items from Peavers data update
LBIS.ItemBonuses[244572] = "12214:8960:12497:12066:13622:13667"
LBIS:AddItem(spec, "244572", LBIS.L["Shoulder"], "Alt 3") --Silvermoon Agent's Mantle
LBIS.ItemBonuses[249913] = "12806:13335"
LBIS:AddItem(spec, "249913", LBIS.L["Head"], "Alt 2") --Mask of Darkest Intent
LBIS:AddItem(spec, "244572", LBIS.L["Shoulder"], "Alt 1") --Silvermoon Agent's Mantle
