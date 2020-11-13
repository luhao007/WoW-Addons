HandyNotes_Draenor = LibStub("AceAddon-3.0"):NewAddon("HandyNotes_Draenor", "AceTimer-3.0", "AceBucket-3.0", "AceConsole-3.0", "AceEvent-3.0")
HandyNotes_Draenor.nodes = { nil }

HandyNotes_Draenor.DefaultIcons = {
    Icon_Treasure_Default = "Interface\\Icons\\TRADE_ARCHAEOLOGY_CHESTOFTINYGLASSANIMALS",
    Icon_Glider = "Interface\\Icons\\inv_feather_04",
    Icon_Rocket = "Interface\\Icons\\ability_mount_rocketmount",
    Icon_Skull_Blue = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconBlue.tga",
    Icon_Skull_Green = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconGreen.tga",
    Icon_Skull_Grey = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIcon.tga",
    Icon_Skull_Orange = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconOrange.tga",
    Icon_Skull_Purple = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconPurple.tga",
    Icon_Skull_Red = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconRed.tga",
    Icon_Skull_Yellow = "Interface\\Addons\\HandyNotes_Draenor\\Artwork\\RareIconYellow.tga",
    Icon_Fossil_Snail = "Interface\\Icons\\Trade_Archaeology_Fossil_SnailShell",
}

function HandyNotes_Draenor:OnInitialize()

    local Defaults = {
        profile = {
            Settings = {
                General = {
                    ShowNotes = true,
                },
                Treasures = {
                    ShowAlreadyCollected = false,
                    IconScale = 1.0,
                    IconAlpha = 1.0,
                },
                Rares = {
                    ShowAlreadyKilled = false,
                    IconScale = 1.0,
                    IconAlpha = 1.0,
                },
            },
            Zones = {
                FrostfireRidge = {
                    Rares = true,
                    Treasures = true,
                },
                ShadowmoonValley = {
                    Rares = true,
                    Treasures = true,
                },
                Nagrand = {
                    Rares = true,
                    Treasures = true,
                },
                Gorgrond = {
                    Rares = true,
                    Treasures = true,
                },
                SpiresOfArak = {
                    Rares = true,
                    Treasures = true,
                },
                Talador = {
                    Rares = true,
                    Treasures = true,
                },
                TanaanJungle = {
                    Rares = true,
                    Treasures = true,
                },
            },
            Mounts = {
                Mount_VoidTalon = true,
                Mount_Pathrunner = true,
                Mount_Terrorfist = true,
                Mount_Deathtalon = true,
                Mount_Vengeance = true,
                Mount_Doomroller = true,
                Mount_Silthide = true,
                Mount_Lukhok = true,
                Mount_NakkTheThunderer = true,
                Mount_Poundfist = true,
                Mount_Gorok = true,
                Mount_NokKarosh = true,
            },
            Integration = {
                DBM = {
                    Loaded = false,
                    ArrowCreated = false,
                    ArrowNote = nil,
                },
                TomTom = {
                    Loaded = true,
                },
            },
        },
    }

    self.db = LibStub("AceDB-3.0"):New("HandyNotesDraenorDB", Defaults, "Default")

    if HandyNotes then 
        self:RegisterEvent("PLAYER_ENTERING_WORLD", "WorldEnter")
    else
        return 
    end

end