local _, addon = ...;
local shared = addon.Data.EventData.Shared;
local type = KrowiAF.Enum.EventType;

KrowiAF.EventData.Dragonflight = {
    { -- Kalimdor Cup
        1395, type.Calendar,
        1453,
        1100022,
		addon.L["Kalimdor Cup"],
        addon.L["Other"],
        2
    },
    { -- Secrets of Azeroth
        {1396, 1398, 1399}, type.Calendar,
        1452,
        4419345,
		addon.L["Secrets of Azeroth"],
        addon.L["Other"],
        2
    },
    { -- WoW's 19th Anniversary
        1397, type.Calendar,
        1173,
        133783,
		addon.L["WoW's 19th Anniversary"],
        addon.L["Other"],
        2,
        nil,
        true
    },
    { -- Eastern Kingdoms Cup
        1400, type.Calendar,
        1531,
        1100022,
		addon.L["Eastern Kingdoms Cup"],
        addon.L["Other"],
        2
    },
    { -- Outland Cup
        1407, type.Calendar,
        1535,
        1100022,
		addon.L["Outland Cup"],
        addon.L["Other"],
        2
    },
    { -- Turbulent Timeways
        {1425, 1458, 1459, 1460}, type.Calendar,
        1538,
        4630413,
		addon.L["Turbulent Timeways"],
        addon.L["Other"],
        2
    },
    { -- Northrend Cup
        1429, type.Calendar,
        1559,
        1100022,
		addon.L["Northrend Cup"],
        addon.L["Other"],
        2
    },
    { -- Pandaria Cup
        1430, type.Calendar,
        1560,
        1100022,
		addon.L["Pandaria Cup"],
        addon.L["Other"],
        2
    },
    { -- Broken Isles Cup
        1431, type.Calendar,
        1561,
        1100022,
		addon.L["Broken Isles Cup"],
        addon.L["Other"],
        2
    },
    { -- Hearthstone's 10th Anniversary
        1462, type.Calendar,
        1563,
        1061040,
		addon.L["Hearthstone's 10th Anniversary"],
        addon.L["Other"],
        2
    },
    { -- WoW Remix: Mists of Pandaria
        {1514, 1515, 1516, 1525}, type.Calendar,
        1578,
        5754532,
		addon.L["WoW Remix: Mists of Pandaria"],
        addon.L["Other"],
        2
    },
    { -- Community Feast: Next
        4729, type.Widget,
        1393,
        4240492,
		{addon.L["Community Feast"], addon.L["Next"]},
        addon.L["Community Feast"],
        2,
        9
    },
    { -- Community Feast: Active
        4731, type.Widget,
        1393,
        4240492,
		{addon.L["Community Feast"], addon.L["Active"]},
        addon.L["Community Feast"],
        2,
        9
    },
    { -- Time Rift: Active
        4987, type.Widget,
        1454,
        236387,
		{addon.L["Time Rift"], addon.L["Active"]},
        addon.L["Time Rift"],
        10,
        9
    },
    { -- Time Rift: Next
        4992, type.Widget,
        1454,
        236387,
		{addon.L["Time Rift"], addon.L["Next"]},
        addon.L["Time Rift"],
        10,
        9
    },
    { -- Superbloom: Next
        5157, type.Widget,
        1552,
        3939983,
		{addon.L["Superbloom"], addon.L["Next"]},
        addon.L["Superbloom"],
        12,
        9
    },
    { -- Superbloom: Active
        5323, type.Widget,
        1552,
        3939983,
		{addon.L["Superbloom"], addon.L["Active"]},
        addon.L["Superbloom"],
        12,
        9
    },
    { -- Azerothian Archives: Next
        5584, type.Widget,
        1564,
        5341597,
		{addon.L["Azerothian Archives"], addon.L["Next"]},
        addon.L["Azerothian Archives"],
        13,
        9
    },
    { -- Azerothian Archives: Soon
        5585, type.Widget,
        1564,
        5341597,
		{addon.L["Azerothian Archives"], addon.L["Soon"]},
        addon.L["Azerothian Archives"],
        13,
        9
    },
    { -- Azerothian Archives: Active
        5592, type.Widget,
        1564,
        5341597,
		{addon.L["Azerothian Archives"], addon.L["Active"]},
        addon.L["Azerothian Archives"],
        13,
        9
    },
    { -- Siege on Dragonbane Keep: Active
        7104, type.World,
        1394,
        1394891,
        {addon.L["Siege on Dragonbane Keep"], addon.L["Active"]},
        addon.L["Siege on Dragonbane Keep"],
        1,
        9,
        false,
        2057,
    },
    { -- Thunderstorms: Nokhudon Hold
        7221, type.World,
        1364,
        132845,
        {addon.L["Thunderstorms"], addon.L["Nokhudon Hold"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2023,
    },
    { -- Sandstorms: Nokhudon Hold
        7222, type.World,
        1364,
        451165,
        {addon.L["Sandstorms"], addon.L["Nokhudon Hold"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2023,
    },
    { -- Firestorms: Nokhudon Hold
        7223, type.World,
        1364,
        460952,
        {addon.L["Firestorms"], addon.L["Nokhudon Hold"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2023,
    },
    { -- Snowstorms: Nokhudon Hold
        7224, type.World,
        1364,
        135783,
        {addon.L["Snowstorms"], addon.L["Nokhudon Hold"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2023,
    },
    { -- Thunderstorms: Ohn'iri Springs
        7225, type.World,
        1364,
        132845,
        {addon.L["Thunderstorms"], addon.L["Ohn'iri Springs"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2023,
    },
    { -- Sandstorms: Ohn'iri Springs
        7226, type.World,
        1364,
        451165,
        {addon.L["Sandstorms"], addon.L["Ohn'iri Springs"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2023,
    },
    { -- Firestorms: Ohn'iri Springs
        7227, type.World,
        1364,
        460952,
        {addon.L["Firestorms"], addon.L["Ohn'iri Springs"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2023,
    },
    { -- Snowstorms: Ohn'iri Springs
        7228, type.World,
        1364,
        135783,
        {addon.L["Snowstorms"], addon.L["Ohn'iri Springs"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2023,
    },
    { -- Thunderstorms: Brackenhide Hollow
        7229, type.World,
        1365,
        132845,
        {addon.L["Thunderstorms"], addon.L["Brackenhide Hollow"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2024,
    },
    { -- Sandstorms: Brackenhide Hollow
        7230, type.World,
        1365,
        451165,
        {addon.L["Sandstorms"], addon.L["Brackenhide Hollow"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2024,
    },
    { -- Firestorms: Brackenhide Hollow
        7231, type.World,
        1365,
        460952,
        {addon.L["Firestorms"], addon.L["Brackenhide Hollow"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2024,
    },
    { -- Snowstorms: Brackenhide Hollow
        7232, type.World,
        1365,
        135783,
        {addon.L["Snowstorms"], addon.L["Brackenhide Hollow"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2024,
    },
    { -- Thunderstorms: Cobalt Assembly
        7233, type.World,
        1365,
        132845,
        {addon.L["Thunderstorms"], addon.L["Cobalt Assembly"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2024,
    },
    { -- Sandstorms: Cobalt Assembly
        7234, type.World,
        1365,
        451165,
        {addon.L["Sandstorms"], addon.L["Cobalt Assembly"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2024,
    },
    { -- Firestorms: Cobalt Assembly
        7235, type.World,
        1365,
        460952,
        {addon.L["Firestorms"], addon.L["Cobalt Assembly"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2024,
    },
    { -- Snowstorms: Cobalt Assembly
        7236, type.World,
        1365,
        135783,
        {addon.L["Snowstorms"], addon.L["Cobalt Assembly"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2024,
    },
    { -- Thunderstorms: Imbu
        7237, type.World,
        1365,
        132845,
        {addon.L["Thunderstorms"], addon.L["Imbu"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2024,
    },
    { -- Sandstorms: Imbu
        7238, type.World,
        1365,
        451165,
        {addon.L["Sandstorms"], addon.L["Imbu"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2024,
    },
    { -- Firestorms: Imbu
        7239, type.World,
        1365,
        460952,
        {addon.L["Firestorms"], addon.L["Imbu"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2024,
    },
    { -- Snowstorms: Imbu
        7240, type.World,
        1365,
        135783,
        {addon.L["Snowstorms"], addon.L["Imbu"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2024,
    },
    { -- Thunderstorms: Tyrhold
        7245, type.World,
        1366,
        132845,
        {addon.L["Thunderstorms"], addon.L["Tyrhold"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2025,
    },
    { -- Sandstorms: Tyrhold
        7246, type.World,
        1366,
        451165,
        {addon.L["Sandstorms"], addon.L["Tyrhold"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2025,
    },
    { -- Firestorms: Tyrhold
        7247, type.World,
        1366,
        460952,
        {addon.L["Firestorms"], addon.L["Tyrhold"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2025,
    },
    { -- Snowstorms: Tyrhold
        7248, type.World,
        1366,
        135783,
        {addon.L["Snowstorms"], addon.L["Tyrhold"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2025,
    },
    { -- Thunderstorms: Dragonbane Keep
        7249, type.World,
        1363,
        132845,
        {addon.L["Thunderstorms"], addon.L["Dragonbane Keep"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2022,
    },
    { -- Sandstorms: Dragonbane Keep
        7250, type.World,
        1363,
        451165,
        {addon.L["Sandstorms"], addon.L["Dragonbane Keep"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2022,
    },
    { -- Firestorms: Dragonbane Keep
        7251, type.World,
        1363,
        460952,
        {addon.L["Firestorms"], addon.L["Dragonbane Keep"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2022,
    },
    { -- Snowstorms: Dragonbane Keep
        7252, type.World,
        1363,
        135783,
        {addon.L["Snowstorms"], addon.L["Dragonbane Keep"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2022,
    },
    { -- Thunderstorms: Slagmire
        7253, type.World,
        1363,
        132845,
        {addon.L["Thunderstorms"], addon.L["Slagmire"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2022,
    },
    { -- Sandstorms: Slagmire
        7254, type.World,
        1363,
        451165,
        {addon.L["Sandstorms"], addon.L["Slagmire"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2022,
    },
    { -- Firestorms: Slagmire
        7255, type.World,
        1363,
        460952,
        {addon.L["Firestorms"], addon.L["Slagmire"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2022,
    },
    { -- Snowstorms: Slagmire
        7256, type.World,
        1363,
        135783,
        {addon.L["Snowstorms"], addon.L["Slagmire"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2022,
    },
    { -- Thunderstorms: Scalecracker Keep
        7257, type.World,
        1363,
        132845,
        {addon.L["Thunderstorms"], addon.L["Scalecracker Keep"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2022,
    },
    { -- Sandstorms: Scalecracker Keep
        7258, type.World,
        1363,
        451165,
        {addon.L["Sandstorms"], addon.L["Scalecracker Keep"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2022,
    },
    { -- Firestorms: Scalecracker Keep
        7259, type.World,
        1363,
        460952,
        {addon.L["Firestorms"], addon.L["Scalecracker Keep"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2022,
    },
    { -- Snowstorms: Scalecracker Keep
        7260, type.World,
        1363,
        135783,
        {addon.L["Snowstorms"], addon.L["Scalecracker Keep"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2022,
    },
    { -- Siege on Dragonbane Keep: Gathering
        7267, type.World,
        1394,
        1394891,
        {addon.L["Siege on Dragonbane Keep"], addon.L["Gathering"]},
        addon.L["Siege on Dragonbane Keep"],
        1,
        9,
        false,
        2057,
    },
    { -- Thunderstorms: Primalist Tomorrow
        7298, type.World,
        1366,
        132845,
        {addon.L["Thunderstorms"], addon.L["Primalist Tomorrow"]},
        addon.L["Thunderstorms"],
        4,
        9,
        false,
        2025,
    },
    { -- Sandstorms: Primalist Tomorrow
        7299, type.World,
        1366,
        451165,
        {addon.L["Sandstorms"], addon.L["Primalist Tomorrow"]},
        addon.L["Sandstorms"],
        5,
        9,
        false,
        2025,
    },
    { -- Firestorms: Primalist Tomorrow
        7300, type.World,
        1366,
        460952,
        {addon.L["Firestorms"], addon.L["Primalist Tomorrow"]},
        addon.L["Firestorms"],
        6,
        9,
        false,
        2025,
    },
    { -- Snowstorms: Primalist Tomorrow
        7301, type.World,
        1366,
        135783,
        {addon.L["Snowstorms"], addon.L["Primalist Tomorrow"]},
        addon.L["Snowstorms"],
        7,
        9,
        false,
        2025,
    },
    { -- Grand Hunts: Ohn'ahran Plains
        7342, type.World,
        1392,
        4622465,
        {addon.L["Grand Hunts"], addon.L["Ohn'ahran Plains"]},
        addon.L["Grand Hunts"],
        3,
        9,
        false,
        1978,
    },
    { -- Grand Hunts: The Waking Shore
        7343, type.World,
        1392,
        4622465,
        {addon.L["Grand Hunts"], addon.L["The Waking Shore"]},
        addon.L["Grand Hunts"],
        3,
        9,
        false,
        1978,
    },
    { -- Grand Hunts: Thaldraszus
        7344, type.World,
        1392,
        4622465,
        {addon.L["Grand Hunts"], addon.L["Thaldraszus"]},
        addon.L["Grand Hunts"],
        3,
        9,
        false,
        1978,
    },
    { -- Grand Hunts: The Azure Span
        7345, type.World,
        1392,
        4622465,
        {addon.L["Grand Hunts"], addon.L["The Azure Span"]},
        addon.L["Grand Hunts"],
        3,
        9,
        false,
        1978,
    },
    { -- Fyrakk Assaults: Azure Span
        7433, type.World,
        1425,
        4914672,
        {addon.L["Fyrakk Assaults"], addon.L["Azure Span"]},
        addon.L["Fyrakk Assaults"],
        8,
        9,
        false,
        2024,
    },
    { -- Researchers Under Fire: Titan Lockdown: Next
        7459, type.World,
        1430,
        254117,
        {addon.L["Researchers Under Fire"], addon.L["Titan Lockdown: Next"]},
        addon.L["Researchers Under Fire"],
        9,
        9,
        false,
        2133,
    },
    { -- Researchers Under Fire: Zaqali Ruin Investigation: Next
        7460, type.World,
        1429,
        4237659,
        {addon.L["Researchers Under Fire"], addon.L["Zaqali Ruin Investigation: Next"]},
        addon.L["Researchers Under Fire"],
        9,
        9,
        false,
        2133,
    },
    { -- Researchers Under Fire: Titan Lockdown: Active
        7461, type.World,
        1430,
        254117,
        {addon.L["Researchers Under Fire"], addon.L["Titan Lockdown: Active"]},
        addon.L["Researchers Under Fire"],
        9,
        9,
        false,
        2133,
    },
    { -- Researchers Under Fire: Zaqali Ruin Investigation: Active
        7462, type.World,
        1429,
        4237659,
        {addon.L["Researchers Under Fire"], addon.L["Zaqali Ruin Investigation: Active"]},
        addon.L["Researchers Under Fire"],
        9,
        9,
        false,
        2133,
    },
    { -- Fyrakk Assaults: Ohn'ahran Plains
        7471, type.World,
        1425,
        4914672,
        {addon.L["Fyrakk Assaults"], addon.L["Ohn'ahran Plains"]},
        addon.L["Fyrakk Assaults"],
        8,
        9,
        false,
        2023,
    },
	{ -- Dreamsurges: Thaldraszus: Next
		{7553, 7602}, type.World,
		1537,
		1394953,
		{addon.L["Dreamsurges"], addon.L["Thaldraszus: Next"]},
		addon.L["Dreamsurges"],
		11,
		9,
		false,
		1978,
	},
	{ -- Dreamsurges: Azure Span: Next
		{7554, 7605}, type.World,
		1537,
		1394953,
		{addon.L["Dreamsurges"], addon.L["Azure Span: Next"]},
		addon.L["Dreamsurges"],
		11,
		9,
		false,
		1978,
	},
	{ -- Dreamsurges: Ohn'ahran Plains: Next
		{7555, 7604}, type.World,
		1537,
		1394953,
		{addon.L["Dreamsurges"], addon.L["Ohn'ahran Plains: Next"]},
		addon.L["Dreamsurges"],
		11,
		9,
		false,
		1978,
	},
	{ -- Dreamsurges: Waking Shores: Next
		{7556, 7603}, type.World,
		1537,
		1394953,
		{addon.L["Dreamsurges"], addon.L["Waking Shores: Next"]},
		addon.L["Dreamsurges"],
		11,
		9,
		false,
		1978,
	},
};