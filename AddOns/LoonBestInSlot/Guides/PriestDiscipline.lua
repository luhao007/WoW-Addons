local spec = LBIS:RegisterSpec(LBIS.L["Priest"], LBIS.L["Discipline"], "1", 256)

-- Bonus IDs for correct item level display
LBIS.ItemBonuses[50228] = "12806"
LBIS.ItemBonuses[260312] = "12806"
LBIS.ItemBonuses[258575] = "12806"
LBIS.ItemBonuses[249315] = "12806:13335"
LBIS.ItemBonuses[258580] = "12806"
LBIS.ItemBonuses[251090] = "12806"
LBIS.ItemBonuses[258584] = "12806"
LBIS.ItemBonuses[251217] = "12806"
LBIS.ItemBonuses[251093] = "12806"
LBIS.ItemBonuses[49812] = "12806"
LBIS.ItemBonuses[249808] = "12806:13335"
LBIS.ItemBonuses[264507] = "12790"
LBIS.ItemBonuses[245769] = "12214:8960:12497:12066:13622:13667"
LBIS.ItemBonuses[250051] = "12806"
LBIS.ItemBonuses[251096] = "4786:12806"
LBIS.ItemBonuses[250049] = "12806"
LBIS.ItemBonuses[251213] = "12806"
LBIS.ItemBonuses[193712] = "12806"
LBIS.ItemBonuses[250054] = "12806"
LBIS.ItemBonuses[49825] = "12806"
LBIS.ItemBonuses[250052] = "12806"
LBIS.ItemBonuses[251172] = "12806"
LBIS.ItemBonuses[251102] = "12806"
LBIS.ItemBonuses[249319] = "12806"
LBIS.ItemBonuses[50263] = "12806"
LBIS.ItemBonuses[250050] = "12806"
LBIS.ItemBonuses[251167] = "12806"
LBIS.ItemBonuses[250256] = "4786:12806"
LBIS.ItemBonuses[245770] = "12066:13622:9627:8791:12693"
LBIS.ItemBonuses[251201] = "12806"
LBIS.ItemBonuses[258472] = "12806"
LBIS.ItemBonuses[193709] = "12806"
LBIS.ItemBonuses[49805] = "12806"
LBIS.ItemBonuses[49809] = "12806"
LBIS.ItemBonuses[151303] = "12806"
LBIS.ItemBonuses[193703] = "12806"
LBIS.ItemBonuses[237838] = "12806"
LBIS.ItemBonuses[251211] = "12806"
LBIS.ItemBonuses[258574] = "12806"
LBIS.ItemBonuses[258578] = "12806"
LBIS.ItemBonuses[265739] = "12806"
LBIS.ItemBonuses[266429] = "12806"

LBIS:AddItem(spec, "250051", LBIS.L["Head"], "BIS") --Tier / Catalyst (69.5%)
LBIS:AddItem(spec, "193703", LBIS.L["Head"], "Alt") --Algeth'ar Academy (9.4%)
LBIS:AddItem(spec, "266429", LBIS.L["Head"], "Alt") --(6.6%)
LBIS:AddItem(spec, "50228", LBIS.L["Neck"], "BIS") --Pit of Saron (28.7%)
LBIS:AddItem(spec, "265739", LBIS.L["Neck"], "Alt") --(20.7%)
LBIS:AddItem(spec, "251096", LBIS.L["Neck"], "Alt") --Windrunner Spire (12.1%)
LBIS:AddItem(spec, "250049", LBIS.L["Shoulder"], "BIS") --Tier / Catalyst (63.4%)
LBIS:AddItem(spec, "251213", LBIS.L["Shoulder"], "Alt") --Nexus-Point Xenas (9.0%)
LBIS:AddItem(spec, "258578", LBIS.L["Shoulder"], "Alt") --Skyreach (8.0%)
LBIS:AddItem(spec, "260312", LBIS.L["Back"], "BIS") --Magisters' Terrace (22.7%)
LBIS:AddItem(spec, "193712", LBIS.L["Back"], "Alt") --Algeth'ar Academy (17.3%)
LBIS:AddItem(spec, "258575", LBIS.L["Back"], "Alt") --Skyreach (10.6%)
LBIS:AddItem(spec, "250054", LBIS.L["Chest"], "BIS") --Tier / Catalyst (66.0%)
LBIS:AddItem(spec, "49825", LBIS.L["Chest"], "Alt") --Pit of Saron (8.6%)
LBIS:AddItem(spec, "151303", LBIS.L["Chest"], "Alt") --Seat of the Triumvirate (5.6%)
LBIS:AddItem(spec, "49809", LBIS.L["Wrist"], "BIS") --Pit of Saron (20.5%)
LBIS:AddItem(spec, "249315", LBIS.L["Wrist"], "Alt") --The Voidspire (14.2%)
LBIS:AddItem(spec, "258580", LBIS.L["Wrist"], "Alt") --Skyreach (12.2%)
LBIS:AddItem(spec, "250052", LBIS.L["Hands"], "BIS") --Tier / Catalyst (57.2%)
LBIS:AddItem(spec, "251172", LBIS.L["Hands"], "Alt") --Maisara Caverns (11.9%)
LBIS:AddItem(spec, "251211", LBIS.L["Hands"], "Alt") --Nexus-Point Xenas (6.8%)
LBIS:AddItem(spec, "251102", LBIS.L["Waist"], "BIS") --Magisters' Terrace (15.3%)
LBIS:AddItem(spec, "249319", LBIS.L["Waist"], "Alt") --The Voidspire (14.3%)
LBIS:AddItem(spec, "50263", LBIS.L["Waist"], "Alt") --Pit of Saron (14.3%)
LBIS:AddItem(spec, "250050", LBIS.L["Legs"], "BIS") --Tier / Catalyst (73.8%)
LBIS:AddItem(spec, "258574", LBIS.L["Legs"], "Alt") --Skyreach (5.6%)
LBIS:AddItem(spec, "251090", LBIS.L["Legs"], "Alt") --Windrunner Spire (5.3%)
LBIS:AddItem(spec, "258584", LBIS.L["Feet"], "BIS") --Skyreach (21.7%)
LBIS:AddItem(spec, "49805", LBIS.L["Feet"], "Alt") --Pit of Saron (21.1%)
LBIS:AddItem(spec, "251167", LBIS.L["Feet"], "Alt") --Maisara Caverns (15.6%)
LBIS:AddItem(spec, "251217", LBIS.L["Ring"], "BIS") --Nexus-Point Xenas (42.6%)
LBIS:AddItem(spec, "251093", LBIS.L["Ring"], "BIS") --Nexus-Point Xenas (33.1%)
LBIS:AddItem(spec, "49812", LBIS.L["Ring"], "Alt") --Pit of Saron (28.3%)
LBIS:AddItem(spec, "250256", LBIS.L["Trinket"], "BIS") --Windrunner Spire (31.4%)
LBIS:AddItem(spec, "249808", LBIS.L["Trinket"], "BIS") --The Voidspire (25.4%)
LBIS:AddItem(spec, "264507", LBIS.L["Trinket"], "Alt") --(22.4%)
LBIS:AddItem(spec, "245770", LBIS.L["Main Hand"], "BIS") --Crafted (73.4%)
LBIS:AddItem(spec, "251201", LBIS.L["Main Hand"], "Alt") --Nexus-Point Xenas (3.8%)
LBIS:AddItem(spec, "237838", LBIS.L["Main Hand"], "Alt") --Crafted (3.0%)
LBIS:AddItem(spec, "245769", LBIS.L["Off Hand"], "BIS") --Crafted (7.6%)
LBIS:AddItem(spec, "258472", LBIS.L["Off Hand"], "Alt") --Skyreach (1.4%)
LBIS:AddItem(spec, "193709", LBIS.L["Off Hand"], "Alt") --Algeth'ar Academy (1.1%)

-- Enchants
LBIS:AddEnchant(spec, "244014", LBIS.L["Ring"]) --Enchant Ring - Silvermoon's Alacrity
LBIS:AddEnchant(spec, "244029", LBIS.L["Main Hand"]) --Enchant Weapon - Acuity of the Ren'dorei
LBIS:AddEnchant(spec, "243950", LBIS.L["Head"]) --Enchant Helm - Empowered Hex of Leeching
LBIS:AddEnchant(spec, "244021", LBIS.L["Shoulder"]) --Enchant Shoulders - Silvermoon's Mending
LBIS:AddEnchant(spec, "244002", LBIS.L["Chest"]) --Enchant Chest - Mark of the Magister
LBIS:AddEnchant(spec, "240155", LBIS.L["Legs"]) --Arcanoweave Spellthread
LBIS:AddEnchant(spec, "243983", LBIS.L["Feet"]) --Enchant Boots - Shaladrassil's Roots
LBIS:AddEnchant(spec, "243973", LBIS.L["Main Hand"]) --Enchant Weapon - Berserker's Rage

-- Gems
LBIS:AddGem(spec, "240983", "4", "True") --Indecipherable Eversong Diamond
LBIS:AddGem(spec, "240890", "3", "False") --Flawless Deadly Peridot

-- Embellishments
LBIS:AddEmbellishment(spec, "245770", "245876") --Aln'hara Cane + Darkmoon Sigil: Hunt
LBIS:AddEmbellishment(spec, "239664", "239664") --Arcanoweave Cord + Arcanoweave Cord

-- New items from Peavers data update
LBIS.ItemBonuses[239649] = "12214:8960:12497:12066:13622:13667"
LBIS:AddItem(spec, "239649", LBIS.L["Waist"], "Alt 4") --Martyr's Waistwrap
LBIS.ItemBonuses[249912] = "12806:13335"
LBIS:AddItem(spec, "249912", LBIS.L["Chest"], "Alt 4") --Robes of Endless Oblivion

-- New items Apr 17
LBIS.ItemBonuses[249328] = "12806:13335"
LBIS:AddItem(spec, "249328", LBIS.L["Shoulder"], "Alt 3") --Echoing Void Mantle
