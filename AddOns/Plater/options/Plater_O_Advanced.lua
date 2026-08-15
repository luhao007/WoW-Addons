
local addonId, platerInternal = ...
local Plater = Plater
---@type detailsframework
local DF = DetailsFramework
local _

local IS_WOW_PROJECT_MAINLINE = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
--local IS_WOW_PROJECT_MIDNIGHT = DF.IsAddonApocalypseWow()
local IS_WOW_PROJECT_MIDNIGHT = DF.IsMidnightWowAPI()

--font select
local on_select_blizzard_nameplate_font = function (_, _, value)
    Plater.db.profile.blizzard_nameplate_font = value
end

local on_select_blizzard_nameplate_large_font = function (_, _, value)
    Plater.db.profile.blizzard_nameplate_large_font = value
end

function platerInternal.CreateAdvancedOptions()
    if platerInternal.LoadOnDemand_IsLoaded.AdvancedOptions then return end -- already loaded
    
    --templates
    local options_text_template = DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE")
    local options_dropdown_template = DF:GetTemplate ("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
    local options_switch_template = DF:GetTemplate ("switch", "OPTIONS_CHECKBOX_TEMPLATE")
    local options_slider_template = DF:GetTemplate ("slider", "OPTIONS_SLIDER_TEMPLATE")
    local options_button_template = DF:GetTemplate ("button", "OPTIONS_BUTTON_TEMPLATE")

    local nameplate_anchor_options = {
        {label = "头", value = 0, onclick = Plater.ChangeNameplateAnchor, desc = "所有姓名版都置于角色上方."},
        {label = "头/脚", value = 1, onclick = Plater.ChangeNameplateAnchor, desc = "友方和中立的姓名版在头上, 敌人在脚下."},
        {label = "脚", value = 2, onclick = Plater.ChangeNameplateAnchor, desc = "所有姓名版都置于角色下方."},
    }

    --cvars
    local CVAR_ENABLED = "1"
    local CVAR_DISABLED = "0"
    local CVAR_MOVEMENT_SPEED = "nameplateMotionSpeed"

    ---@diagnostic disable-next-line: undefined-global
    local IS_WOW_PROJECT_MAINLINE = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
    ---@diagnostic disable-next-line: undefined-global
    local IS_WOW_PROJECT_NOT_MAINLINE = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE

    local L = DF.Language.GetLanguageTable(addonId)

    local CVarDesc = "\n\n|cFFFF7700[*]|r |cFFa0a0a0" .. L["CVar, saved within Plater profile and restored when loading the profile."] .. "|r"
    local CVarIcon = "|cFFFF7700*|r"
    local CVarNeedReload = "\n\n|cFFFF2200[*]|r |cFFa0a0a0" .. L["A /reload may be required to take effect."] .. "|r"

    local dropdownStatusBarTexture = platerInternal.Defaults.dropdownStatusBarTexture
    local dropdownStatusBarColor = platerInternal.Defaults.dropdownStatusBarColor

    --outline table
    local outline_modes = {"NONE", "MONOCHROME", "OUTLINE", "THICKOUTLINE", "OUTLINEMONOCHROME", "THICKOUTLINEMONOCHROME", "SLUG", "OUTLINE, SLUG"}
    local outline_modes_names = {"无", "单色", "轮廓", "粗轮廓", "单色轮廓", "单色粗轮廓", "实心条", "轮廓条"}
    local build_outline_modes_table = function (actorType, member)
        local t = {}
        for i = 1, #outline_modes do
            local value = outline_modes[i]
            local label = outline_modes_names[i]
            tinsert (t, {
                label = label,
                value = value,
                statusbar = dropdownStatusBarTexture,
                statusbarcolor = dropdownStatusBarColor,
                onclick = function (_, _, value)
                    if (actorType) then
                        Plater.db.profile.plate_config [actorType][member] = value
                        Plater.RefreshDBUpvalues()
                        Plater.UpdateAllPlates()
                        Plater.UpdateAllNames()
                        Plater.UpdateBlizzardNameplateFonts(true)
                    else
                        Plater.db.profile [member] = value
                        Plater.RefreshDBUpvalues()
                        Plater.UpdateAllPlates()
                        Plater.UpdateAllNames()
                        Plater.UpdateBlizzardNameplateFonts(true)
                    end
                end
            })
        end
        return t
    end

    local build_number_format_options = function()
        local number_format_options = {"西方 (1K - 1KK)"}
        local number_format_options_config = {"western", "eastasia"}

        local eastAsiaMyriads_1k, eastAsiaMyriads_10k, eastAsiaMyriads_1B
        if (GetLocale() == "koKR") then
            tinsert (number_format_options, "东亚 (1천 - 1만)")
        elseif (GetLocale() == "zhCN") then
            tinsert (number_format_options, "东亚 (1千 - 1万)")
        elseif (GetLocale() == "zhTW") then
            tinsert (number_format_options, "东亚 (1千 - 1萬)")
        else
            tinsert (number_format_options, "东亚 (1천 - 1만)")
        end

        local t = {}
        for i = 1, #number_format_options do
            tinsert (t, {
                label = number_format_options [i],
                value = number_format_options_config [i],
                onclick = function (_, _, value)
                    Plater.db.profile.number_region = value
                    Plater.RefreshDBUpvalues()
                    Plater.UpdateAllPlates()
                end
            })
        end
        return t
    end

    --anchor table
    local build_anchor_side_table = function (actorType, member)
        local anchorOptions = {}
        local phraseIdTable = Plater.AnchorNamesByPhraseId
        local languageId = DF.Language.GetLanguageIdForAddonId(addonId)

        for i = 1, 13 do
            tinsert (anchorOptions, {
                label = DF.Language.GetText(addonId, phraseIdTable[i]),
                languageId = languageId,
                phraseId = phraseIdTable[i],
                value = i,
                statusbar = dropdownStatusBarTexture,
                statusbarcolor = dropdownStatusBarColor,
                onclick = function (_, _, value)
                    if (actorType) then
                        Plater.db.profile.plate_config [actorType][member].side = value
                        Plater.RefreshDBUpvalues()

                        Plater.UpdateAllPlates()
                        Plater.UpdateAllNames()
                    else
                        Plater.db.profile [member].side = value
                        Plater.RefreshDBUpvalues()
                        Plater.UpdateAllPlates()
                        Plater.UpdateAllNames()
                    end
                end
            })
        end
        return anchorOptions
    end

    local advanced_options = {
        {type = "label", get = function() return "通用设置:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "range",
            get = function() return Plater.db.profile.update_throttle end,
            set = function (self, fixedparam, value)
                Plater.db.profile.update_throttle = value
                Plater.RefreshDBUpvalues()
            end,
            min = 0.050,
            max = 0.500,
            step = 0.050,
            name = "更新周期",
            usedecimals = true,
            desc = "姓名版每次更新之间的时间间隔(秒).\n\n|cFFFFFFFF默认: 0.25|r(每秒更新4次).",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.quick_hide end,
            set = function (self, fixedparam, value)
                Plater.db.profile.quick_hide = value
                if (value) then
                    SetCVar ("nameplateRemovalAnimation", CVAR_DISABLED)
                else
                    SetCVar ("nameplateRemovalAnimation", CVAR_ENABLED)
                end
                Plater.UpdateAllPlates()
            end,
            nocombat = true,
            name = "死亡快速隐藏",
            desc = "当单位死亡时, 立即隐藏姓名板, 不播放缩小动画.",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.show_healthbars_on_not_attackable end,
            set = function (self, fixedparam, value)
                Plater.db.profile.show_healthbars_on_not_attackable = value
                Plater.UpdateAllPlates()
            end,
            name = "在不可攻击的单位上显示血条",
            desc = "在不可攻击的单位上显示生命条而不是默认 '仅显示名称'.",
        },

        {
            type = "toggle",
            boxfirst = true,
            --get = function() return GetCVarBool ("SoftTargetIconGameObject") and tonumber(GetCVar("SoftTargetInteract") or 0) == 3 end,
            get = function() return tonumber(GetCVar("SoftTargetInteract") or 0) == 3 end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then

                    SetCVar ("SoftTargetIconGameObject", value and "1" or "0")
                    SetCVar ("SoftTargetInteract", value and "3" or "0")
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            name = "在游戏物体上显示交互" .. CVarIcon,
            desc = "在游戏物体上显示交互." .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVarBool ("SoftTargetNameplateInteract") end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("SoftTargetNameplateInteract", value and "1" or "0")
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            name = "在交互目标上强制显示姓名板" .. CVarIcon,
            desc = "强制显示交互目标的姓名板." .. CVarDesc,
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.show_healthbars_on_softinteract end,
            set = function (self, fixedparam, value)
                Plater.db.profile.show_healthbars_on_softinteract = value
                Plater.UpdateAllPlates()
            end,
            name = "始终显示交互目标",
            desc = "始终显示交互目标的名称或血条而不是在NPC上隐藏它们.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.ignore_softinteract_objects end,
            set = function (self, fixedparam, value)
                Plater.db.profile.ignore_softinteract_objects = value
                Plater.UpdateAllPlates()
            end,
            name = "对物体使用暴雪交互功能",
            desc = "仅在NPC上显示Plater交互姓名板.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.hide_name_on_game_objects end,
            set = function (self, fixedparam, value)
                Plater.db.profile.hide_name_on_game_objects = value
                Plater.UpdateAllPlates()
            end,
            name = "隐藏游戏物体的Plater姓名",
            desc = "隐藏游戏物体的Plater姓名, 如交互目标.",
        },
        {
            type = "color",
            get = function()
                local color = Plater.db.profile.name_on_game_object_color
                return {color[1], color[2], color[3], color[4]}
            end,
            set = function (self, r, g, b, a)
                local color = Plater.db.profile.name_on_game_object_color
                color[1], color[2], color[3], color[4] = r, g, b, a
            end,
            name = "OPTIONS_INTERACT_OBJECT_NAME_COLOR",
            desc = "OPTIONS_INTERACT_OBJECT_NAME_COLOR_DESC",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.show_softinteract_icons end,
            set = function (self, fixedparam, value)
                Plater.db.profile.show_softinteract_icons = value
                Plater.UpdateAllPlates()
            end,
            name = "显示交互图标",
            desc = "在交互目标上显示一个图标.",
        },

        {type = "blank"},

        {type = "label", get = function() return "客户端设置 (CVars):" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "toggle",
            get = function() return GetCVarBool ("nameplateShowOffscreen") end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowOffscreen", value and "1" or "0")
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVarBool ("nameplateShowOffscreen"))
                end
            end,
            name = "将姓名板保留在屏幕上" .. CVarIcon,
            desc = "当单位与玩家或队友交战时, 始终将姓名板显示在屏幕上." .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        
        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateOtherTopInset")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    if (value == 0) then
                        SetCVar ("nameplateOtherTopInset", -1)
                        SetCVar ("nameplateLargeTopInset", -1)

                    else
                        SetCVar ("nameplateOtherTopInset", value)
                        SetCVar ("nameplateLargeTopInset", value)
                    end
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.000,
            max = 0.1,
            step = 0.005,
            thumbscale = 1.7,
            usedecimals = true,
            name = "锁定至屏幕 (顶部)" .. CVarIcon,
            desc = "姓名版与屏幕顶部之间的最小空间. 如果姓名版的某些部分超出屏幕则增大此值.\n\n|cFFFFFFFF默认: 0.065|r\n\n|cFFFFFF00重要|r: 如果有问题, 请使用这些宏手动设置:\n/run SetCVar ('nameplateOtherTopInset', '0.065')\n/run SetCVar ('nameplateLargeTopInset', '0.065')\n\n|cFFFFFF00重要|r: 设置为0则禁用该功能." .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateOtherBottomInset")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    if (value == 0) then
                        SetCVar ("nameplateOtherBottomInset", -1)
                        SetCVar ("nameplateLargeBottomInset", -1)

                    else
                        SetCVar ("nameplateOtherBottomInset", value)
                        SetCVar ("nameplateLargeBottomInset", value)

                    end
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.000,
            max = 0.1,
            step = 0.005,
            thumbscale = 1.7,
            usedecimals = true,
            name = "锁定至屏幕 (底部)|cFFFF7700*|r",
            desc = "姓名版与屏幕底部之间的最小空间. 如果姓名版的某些部分超出屏幕则增大此值.\n\n|cFFFFFFFF默认: 0.065|r\n\n|cFFFFFF00 重要 |r: 如果有问题, 请使用这些宏手动设置:\n/run SetCVar ('nameplateOtherBottomInset', '0.1')\n/run SetCVar ('nameplateLargeBottomInset', '0.15')\n\n|cFFFFFF00 重要 |r: 设置为0则禁用该功能.\n\n|cFFFF7700[*]|r |cFFa0a0a0CVar, 保存在Plater配置文件中并在加载配置文件时恢复.|r",
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateOverlapV")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateOverlapV", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.2,
            max = 2.5,
            step = 0.05,
            thumbscale = 1.7,
            usedecimals = true,
            name = "姓名版重叠 (V)" .. CVarIcon,
            desc = "启用重叠时每个姓名版之间的垂直空间.\n\n|cFFFFFFFF默认: 1.10|r\n\n|cFFFFFF00重要|r: 如果发现该设置有问题, 请使用:\n|cFFFFFFFF/run SetCVar ('nameplateOverlapV', '1.6')|r"  .. CVarDesc,
            nocombat = true,
            --hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateOverlapH")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateOverlapH", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.2,
            max = 2.5,
            step = 0.05,
            thumbscale = 1.7,
            usedecimals = true,
            name = "姓名版重叠 (水平)" .. CVarIcon,
            desc = "启用重叠时每个姓名版之间的水平空间.\n\n|cFFFFFFFF默认: 0.8|r\n\n|cFFFFFF00重要|r: 如果发现该设置有问题, 请使用:\n|cFFFFFFFF/run SetCVar ('nameplateOverlapH', '0.8')|r"  .. CVarDesc,
            nocombat = true,
            --hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar (CVAR_MOVEMENT_SPEED)) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar (CVAR_MOVEMENT_SPEED, value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.005,
            max = 0.2,
            step = 0.005,
            thumbscale = 1.7,
            usedecimals = true,
            name = "移动速度" .. CVarIcon,
            desc = "姓名版移动的速度 (启用重叠功能时).\n\n|cFFFFFFFF默认: 0.025|r\n\n|cFFFFFFFF推荐: >=0.02|r" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateGlobalScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateGlobalScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.75,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "全局比例" .. CVarIcon,
            desc = "缩放所有姓名版.\n\n|cFFFFFFFF默认: 1|r" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateMinScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateMinScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.3,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "最小比例" .. CVarIcon,
            desc = "当姓名版远离视角时应用的比例.\n\n|cFFFFFF00重要|r: 是与视角的距离, |cFFFF4444不|r是与角色的距离.\n\n|cFFFFFFFF默认: 0.8|r" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateLargerScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateLargerScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.3,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "较大比例" .. CVarIcon,
            desc = "适用于重要怪物 (如BOSS) 的比例.\n\n|cFFFFFFFF默认: 1.2|r" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "select",
            get = function() return tonumber (GetCVar ("nameplateOtherAtBase")) end,
            values = function() return nameplate_anchor_options end,
            name = "锚点" .. CVarIcon,
            desc = "姓名版固定在.\n\n|cFFFFFFFF默认: 头|r" .. CVarDesc,
            nocombat = true,
        },
        {
            type = "toggle",
            get = function() return GetCVarBool ("nameplateShowDebuffsOnFriendly") end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowDebuffsOnFriendly", value and "1" or "0")
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVarBool ("nameplateShowDebuffsOnFriendly"))
                end
            end,
            name = "在暴雪血条上显示Debuff" .. CVarIcon,
            desc = "在地下城或团本中, 如果启用了友方姓名版则不会在姓名版上显示debuff.\n如果禁用任何Plater模块, 这些姓名版也将受到影响." .. CVarDesc .. CVarNeedReload,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "blank", hidden = not IS_WOW_PROJECT_MIDNIGHT},
        {type = "label", get = function() return "重叠大小缩放:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = not IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return Plater.db.profile.overlap_space_scale[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.overlap_space_scale[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.5,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "敌对单位姓名板重叠百分比(水平)",
            desc = "当启用堆叠功能时, 相对于点击区域, 为敌方单位每个姓名板在水平方向上占据的空间设置的缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return  Plater.db.profile.overlap_space_scale[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.overlap_space_scale[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.5,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "敌对单位姓名板重叠百分比(垂直)",
            desc = "当启用堆叠功能时, 相对于点击区域, 为敌方单位每个姓名板在垂直方向上占据的空间设置的缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.overlap_space_scale_friendly[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.overlap_space_scale_friendly[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.0,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "友方单位姓名板重叠百分比(水平)",
            desc = "当启用堆叠功能时, 相对于点击区域, 为友方单位每个姓名板在水平方向上占据的空间设置的缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return  Plater.db.profile.overlap_space_scale_friendly[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.overlap_space_scale_friendly[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.0,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "友方单位姓名板重叠百分比(垂直)",
            desc = "当启用堆叠功能时, 相对于点击区域, 为友方单位每个姓名板在垂直方向上占据的空间设置的缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "label", get = function() return "可点击区域缩放:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = not IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return Plater.db.profile.select_space_scale[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.select_space_scale[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.5,
            max = 1,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "敌方选择区域宽度%",
            desc = "相对于点击空间, 敌方单位的可点击区域宽度缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return  Plater.db.profile.select_space_scale[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.select_space_scale[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.5,
            max = 1,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "敌方选择区域高度%",
            desc = "相对于点击空间, 敌方单位的可点击区域高度缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.select_space_scale_friendly[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.select_space_scale_friendly[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.0,
            max = 1,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "友方选择区域宽度%",
            desc = "相对于点击空间, 友方单位的可点击区域宽度缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return  Plater.db.profile.select_space_scale_friendly[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.select_space_scale_friendly[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 0.0,
            max = 1,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "友方选择区域高度%",
            desc = "相对于点击空间, 友方单位的可点击区域高度缩放比例.",
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function()
                if not GetCVarDefault("NamePlateHorizontalScale") then return false end
                local hScale = GetCVarNumberOrDefault("NamePlateHorizontalScale");
                local vScale = GetCVarNumberOrDefault("NamePlateVerticalScale");
                local cScale = GetCVarNumberOrDefault("NamePlateClassificationScale");
                return not (ApproximatelyEqual(hScale, 1) and ApproximatelyEqual(vScale, 1) and ApproximatelyEqual(cScale, 1));
            end,
            set = function (self, fixedparam, value)
                if value then
                    SetCVar("NamePlateHorizontalScale", 1.4);
                    SetCVar("NamePlateVerticalScale", 2.7);
                    SetCVar("NamePlateClassificationScale", 1.25);
                else
                    SetCVar("NamePlateHorizontalScale", 1);
                    SetCVar("NamePlateVerticalScale", 1);
                    SetCVar("NamePlateClassificationScale", 1);
                end
                PlaterOptionsPanelFrame.RefreshOptionsFrame()
            end,
            name = "更大的姓名板" .. CVarIcon,
            desc = "增加暴雪基础姓名板的缩放(这会影响选择空间和默认暴雪姓名板的大小)." .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return tonumber (GetCVar ("NamePlateVerticalScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("NamePlateVerticalScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.3,
            max = 3,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "基础垂直缩放" .. CVarIcon,
            desc = "增加暴雪基础姓名板的缩放高度(这会影响选择空间和默认暴雪姓名板的大小)." .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return tonumber (GetCVar ("NamePlateHorizontalScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("NamePlateHorizontalScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.3,
            max = 2,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "基础水平缩放" .. CVarIcon,
            desc = "增加暴雪基础姓名板的缩放高度(这会影响选择空间和默认暴雪姓名板的大小)." .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return tonumber (GetCVar ("NamePlateClassificationScale")) end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("NamePlateClassificationScale", value)
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                end
            end,
            min = 0.3,
            max = 1.5,
            step = 0.1,
            thumbscale = 1.7,
            usedecimals = true,
            name = "基础分类缩放" .. CVarIcon,
            desc = "增加暴雪基础姓名板分类缩放(这会影响选择空间和默认暴雪姓名板的大小)." .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        
        {type = "blank", hidden = not IS_WOW_PROJECT_MIDNIGHT},
        {type = "label", get = function() return "姓名板选择空间:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = not IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return Plater.db.profile.click_space[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
                Plater.UpdateAllPlates()
            end,
            min = 1,
            max = 300,
            step = 1,
            name = "OPTIONS_WIDTH",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_WIDTH",
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return Plater.db.profile.click_space[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
                Plater.UpdateAllPlates()
            end,
            min = 1,
            max = 100,
            step = 1,
            name = "OPTIONS_HEIGHT",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_HEIGHT",
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        
        {type = "label", get = function() return "敌方选择框空间:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return Plater.db.profile.click_space[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 1,
            max = 300,
            step = 1,
            name = "OPTIONS_WIDTH",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_WIDTH",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return Plater.db.profile.click_space[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 1,
            max = 100,
            step = 1,
            name = "OPTIONS_HEIGHT",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_HEIGHT",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "blank", hidden = IS_WOW_PROJECT_MIDNIGHT},

        {type = "label", get = function() return "友方选择框空间:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return Plater.db.profile.click_space_friendly[1] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space_friendly[1] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 1,
            max = 300,
            step = 1,
            name = "OPTIONS_WIDTH",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_WIDTH",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "range",
            get = function() return Plater.db.profile.click_space_friendly[2] end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space_friendly[2] = value
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = 1,
            max = 100,
            step = 1,
            name = "OPTIONS_HEIGHT",
            nocombat = true,
            desc = "OPTIONS_CLICK_SPACE_HEIGHT",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "blank"},

        { --always show background
            type = "toggle",
            get = function() return Plater.db.profile.click_space_always_show end,
            set = function (self, fixedparam, value)
                Plater.db.profile.click_space_always_show = value
                Plater.UpdateAllPlates()
            end,
            nocombat = true,
            name = "OPTIONS_BACKGROUND_ALWAYSSHOW",
            desc = "OPTIONS_BACKGROUND_ALWAYSSHOW_DESC",
        },

        {type = "breakline"},
        {type = "label", get = function() return "单位类型:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowEnemyGuardians") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowEnemyGuardians", math.abs (tonumber (GetCVar ("nameplateShowEnemyGuardians"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowEnemyGuardians") == CVAR_ENABLED)
                end
            end,
            name = "显示敌人守卫" .. CVarIcon,
            desc = "显示被视为守卫的敌人宠物的姓名版" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowEnemyMinions") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowEnemyMinions", math.abs (tonumber (GetCVar ("nameplateShowEnemyMinions"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowEnemyMinions") == CVAR_ENABLED)
                end
            end,
            name = "显示敌人的爪牙" .. CVarIcon,
            desc = "显示被视为爪牙的敌人的姓名版" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowEnemyMinus") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowEnemyMinus", math.abs (tonumber (GetCVar ("nameplateShowEnemyMinus"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowEnemyMinus") == CVAR_ENABLED)
                end
            end,
            name = "显示敌方小型单位" .. CVarIcon,
            desc = "显示小型单位的姓名版 (通常是具有最高等级但生命值较低的单位)" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowEnemyPets") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowEnemyPets", math.abs (tonumber (GetCVar ("nameplateShowEnemyPets"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowEnemyPets") == CVAR_ENABLED)
                end
            end,
            name = "显示敌人的宠物" .. CVarIcon,
            desc = "显示敌方宠物的姓名版" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowEnemyTotems") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowEnemyTotems", math.abs (tonumber (GetCVar ("nameplateShowEnemyTotems"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowEnemyTotems") == CVAR_ENABLED)
                end
            end,
            name = "显示敌方图腾" .. CVarIcon,
            desc = "显示敌方图腾" .. CVarDesc,
            nocombat = true,
        },

        {type = "blank"},

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyNPCs") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyNPCs", math.abs (tonumber (GetCVar ("nameplateShowFriendlyNPCs"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyNPCs") == CVAR_ENABLED)
                end
            end,
            name = "显示友方NPC" .. CVarIcon,
            desc = "显示友方NPC的姓名版" .. CVarDesc,
            nocombat = true,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyGuardians") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyGuardians", math.abs (tonumber (GetCVar ("nameplateShowFriendlyGuardians"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyGuardians") == CVAR_ENABLED)
                end
            end,
            name = "显示友方守卫" .. CVarIcon,
            desc = "为被视为守卫的友方宠物显示姓名版" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyMinions") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyMinions", math.abs (tonumber (GetCVar ("nameplateShowFriendlyMinions"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyMinions") == CVAR_ENABLED)
                end
            end,
            name = "显示友方小型单位" .. CVarIcon,
            desc = "显示被视为爪牙的友方单位姓名版" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPets") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPets", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPets"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPets") == CVAR_ENABLED)
                end
            end,
            name = "显示友方宠物" .. CVarIcon,
            desc = "为友方宠物显示姓名版" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyTotems") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyTotems", math.abs (tonumber (GetCVar ("nameplateShowFriendlyTotems"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyTotems") == CVAR_ENABLED)
                end
            end,
            name = "显示友方图腾" .. CVarIcon,
            desc = "显示友方图腾" .. CVarDesc,
            nocombat = true,
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        
        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPlayers") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPlayers", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPlayers"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPlayers") == CVAR_ENABLED)
                end
            end,
            name = "显示友方姓名版" .. CVarIcon,
            desc = "为友方玩家显示姓名板" .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },
        
        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPlayerGuardians") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPlayerGuardians", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPlayerGuardians"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPlayerGuardians") == CVAR_ENABLED)
                end
            end,
            name = "显示友方守护" .. CVarIcon,
            desc = "为友方守护显示姓名板" .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPlayerMinions") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPlayerMinions", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPlayerMinions"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPlayerMinions") == CVAR_ENABLED)
                end
            end,
            name = "显示友方仆从" .. CVarIcon,
            desc = "为被视为仆从的友方单位显示姓名板" .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPlayerPets") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPlayerPets", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPlayerPets"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPlayerPets") == CVAR_ENABLED)
                end
            end,
            name = "显示友方宠物" .. CVarIcon,
            desc = "为友方宠物显示姓名板" .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {
            type = "toggle",
            get = function() return GetCVar ("nameplateShowFriendlyPlayerTotems") == CVAR_ENABLED end,
            set = function (self, fixedparam, value)
                if (not InCombatLockdown()) then
                    SetCVar ("nameplateShowFriendlyPlayerTotems", math.abs (tonumber (GetCVar ("nameplateShowFriendlyPlayerTotems"))-1))
                else
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (GetCVar ("nameplateShowFriendlyPlayerTotems") == CVAR_ENABLED)
                end
            end,
            name = "显示友方图腾" .. CVarIcon,
            desc = "显示友方图腾" .. CVarDesc,
            nocombat = true,
            hidden = not IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "blank"},
        {type = "label", get = function() return "暴雪姓名版字体:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "toggle",
            get = function() return Plater.db.profile.blizzard_nameplate_font_override_enabled end,
            set = function (self, fixedparam, value)
                Plater.db.profile.blizzard_nameplate_font_override_enabled = value
            end,
            name = L["OPTIONS_ENABLED"],
            desc = "启用暴雪姓名版字体覆盖." .. CVarNeedReload,
        },
        {type = "label", get = function() return "普通:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "select",
            get = function() return Plater.db.profile.blizzard_nameplate_font end,
            values = function() return DF:BuildDropDownFontList (on_select_blizzard_nameplate_font, function() Plater.UpdateBlizzardNameplateFonts(true) end) end,
            name = L["OPTIONS_FONT"],
            desc = "文字字体." .. CVarNeedReload,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.blizzard_nameplate_font_size end,
            set = function (self, fixedparam, value)
                Plater.db.profile.blizzard_nameplate_font_size = value
                Plater.UpdateBlizzardNameplateFonts(true)
            end,
            min = 6,
            max = 24,
            step = 1,
            name = L["OPTIONS_SIZE"],
            desc = "尺寸" .. CVarNeedReload,
        },
        {
            type = "select",
            get = function() return Plater.db.profile.blizzard_nameplate_font_outline end,
            values = function() return build_outline_modes_table (nil, "blizzard_nameplate_font_outline") end,
            name = L["OPTIONS_OUTLINE"],
            desc = "轮廓" .. CVarNeedReload,
        },
        {type = "label", get = function() return "大型:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "select",
            get = function() return Plater.db.profile.blizzard_nameplate_large_font end,
            values = function() return DF:BuildDropDownFontList (on_select_blizzard_nameplate_large_font, function() Plater.UpdateBlizzardNameplateFonts(true) end) end,
            name = L["OPTIONS_FONT"],
            desc = "文字字体." .. CVarNeedReload,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.blizzard_nameplate_large_font_size end,
            set = function (self, fixedparam, value)
                Plater.db.profile.blizzard_nameplate_large_font_size = value
                Plater.UpdateBlizzardNameplateFonts(true)
            end,
            min = 6,
            max = 24,
            step = 1,
            name = L["OPTIONS_SIZE"],
            desc = "尺寸" .. CVarNeedReload,
        },
        {
            type = "select",
            get = function() return Plater.db.profile.blizzard_nameplate_large_font_outline end,
            values = function() return build_outline_modes_table (nil, "blizzard_nameplate_large_font_outline") end,
            name = L["OPTIONS_OUTLINE"],
            desc = "轮廓" .. CVarNeedReload,
        },

        --{type = "breakline"},

        {type = "blank"},

        --can't go up to 100 pixels deviation due to the clicable space from the plateFrame
        --if it goes more than the plateFrame area it generates areas where isn't clicable
        {type = "label", get = function() return "全局偏移:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "range",
            get = function() return Plater.db.profile.global_offset_x end,
            set = function (self, fixedparam, value)
                Plater.db.profile.global_offset_x = value
                Plater.UpdateAllPlates()
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = -20,
            max = 20,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_XOFFSET",
            desc = "OPTIONS_NAMEPLATE_OFFSET",
        },
        {
            type = "range",
            get = function() return Plater.db.profile.global_offset_y end,
            set = function (self, fixedparam, value)
                Plater.db.profile.global_offset_y = value
                Plater.UpdateAllPlates()
                Plater.UpdatePlateClickSpace (nil, true)
            end,
            min = -20,
            max = 20,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_YOFFSET",
            desc = "OPTIONS_NAMEPLATE_OFFSET",
        },

        {type = "blank"},

        {type = "label", get = function() return "特殊单位:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "range",
            get = function() return Plater.db.profile.pet_width_scale end,
            set = function (self, fixedparam, value)
                Plater.db.profile.pet_width_scale = value
                Plater.UpdateAllPlates()
            end,
            min = 0.2,
            max = 2,
            step = 0.1,
            name = "OPTIONS_PET_SCALE_WIDTH",
            desc = "OPTIONS_PET_SCALE_DESC",
            usedecimals = true,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.pet_height_scale end,
            set = function (self, fixedparam, value)
                Plater.db.profile.pet_height_scale = value
                Plater.UpdateAllPlates()
            end,
            min = 0.2,
            max = 2,
            step = 0.1,
            name = "OPTIONS_PET_SCALE_HEIGHT",
            desc = "OPTIONS_PET_SCALE_DESC",
            usedecimals = true,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.minor_width_scale end,
            set = function (self, fixedparam, value)
                Plater.db.profile.minor_width_scale = value
                Plater.UpdateAllPlates()
            end,
            min = 0.2,
            max = 2,
            step = 0.1,
            name = "OPTIONS_MINOR_SCALE_WIDTH",
            desc = "OPTIONS_MINOR_SCALE_DESC",
            usedecimals = true,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.minor_height_scale end,
            set = function (self, fixedparam, value)
                Plater.db.profile.minor_height_scale = value
                Plater.UpdateAllPlates()
            end,
            min = 0.2,
            max = 2,
            step = 0.1,
            name = "OPTIONS_MINOR_SCALE_HEIGHT",
            desc = "OPTIONS_MINOR_SCALE_DESC",
            usedecimals = true,
        },

        {type = "breakline"},
        {type = "label", get = function() return "地域:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "select",
            get = function() return Plater.db.profile.number_region end,
            values = function() return build_number_format_options() end,
            name = "OPTIONS_FORMAT_NUMBER",
            desc = "OPTIONS_FORMAT_NUMBER",
        },

        {type = "label", get = function() return "其它:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "toggle",
            get = function() return Plater.db.profile.show_health_prediction end,
            set = function (self, fixedparam, value)
                Plater.db.profile.show_health_prediction = value
            end,
            name = "显示血量预测/吸收",
            desc = "显示额外的血量预测条和治疗吸收条.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.show_shield_prediction end,
            set = function (self, fixedparam, value)
                Plater.db.profile.show_shield_prediction = value
            end,
            name = "显示盾预测",
            desc = "为盾显示额外的条 (例如来自牧师的真言术：盾).",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.enable_masque_support end,
            set = function (self, fixedparam, value)
                Plater.db.profile.enable_masque_support = value
                Plater:Msg ("此设置需要 /reload 才能生效.")
            end,
            name = "Masque支持",
            desc = "如果安装了Masque插件, 启用此选项将使Plater使用Masque边框.\n\n|cFFFFFF00重要|r: 更改此设置后需要 /reload.",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.use_name_translit end,
            set = function (self, fixedparam, value)
                Plater.db.profile.use_name_translit = value
                Plater.RefreshDBUpvalues()
                Plater.FullRefreshAllPlates()
            end,
            name = "译名",
            desc = "使用LibTranslit翻译名称. 更改后的名称将标记为 '*'",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.use_player_combat_state end,
            set = function (self, fixedparam, value)
                Plater.db.profile.use_player_combat_state = value
            end,
            name = "进入/退出战斗设置 - 使用玩家战斗状态",
            desc = "在应用进入/退出战斗设置时使用玩家的战斗状态而不是单位的战斗状态.",
        },

        {
            type = "toggle",
            get = function() return Plater.db.profile.opt_out_auto_accept_npc_colors end,
            set = function (self, fixedparam, value)
                Plater.db.profile.opt_out_auto_accept_npc_colors = value
            end,
            name = "选择退出自动接受NPC颜色",
            desc = "不会自动接收团长发送的NPC颜色而是进行提示.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.auto_translate_npc_names end,
            set = function (self, fixedparam, value)
                Plater.db.profile.auto_translate_npc_names = value
                Plater.TranslateNPCCache()
            end,
            name = "在NPC颜色选项卡上自动翻译NPC名称.",
            desc = "将自动把名称翻译为当前的游戏语言.",
        },

        {type = "blank"},
        {type = "label", get = function() return "个人栏自定义位置:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = IS_WOW_PROJECT_NOT_MAINLINE or IS_WOW_PROJECT_MIDNIGHT},
        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateSelfTopInset")*100) end,
            set = function (self, fixedparam, value)
                --Plater.db.profile.plate_config.player.y_position_offset = value

                if (InCombatLockdown()) then
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (tonumber (GetCVar ("nameplateSelfTopInset")*100))
                    return
                end

                --SetCVar ("nameplateSelfBottomInset", value / 100)
                SetCVar ("nameplateSelfTopInset", abs (value - 99) / 100)

                if (not Plater.PersonalAdjustLocationTop) then
                    Plater.PersonalAdjustLocationTop = CreateFrame ("frame", "PlaterPersonalBarLocation", UIParent, BackdropTemplateMixin and "BackdropTemplate")
                    local frame = Plater.PersonalAdjustLocationTop
                    frame:SetWidth (GetScreenWidth())
                    frame:SetHeight (20)
                    frame.Texture = frame:CreateTexture (nil, "background")
                    frame.Texture:SetTexture ([[Interface\AddOns\Plater\images\bar4_vidro]], true)
                    frame.Texture:SetAllPoints()
                    frame.Shadow = frame:CreateTexture (nil, "border")
                    frame.Shadow:SetTexture ([[Interface\ACHIEVEMENTFRAME\UI-Achievement-RecentHeader]], true)
                    frame.Shadow:SetPoint ("center")
                    frame.Shadow:SetSize (256, 18)
                    frame.Shadow:SetTexCoord (0, 1, 0, 22/32)
                    frame.Shadow:SetVertexColor (0, 0, 0, 1)
                    frame.Text = frame:CreateFontString (nil, "artwork", "GameFontNormal")
                    frame.Text:SetText ("Plater: 顶部约束")
                    frame.Text:SetPoint ("center")

                    frame.HideAnimation = DF:CreateAnimationHub (frame, nil, function() frame:Hide() end)
                    DF:CreateAnimation (frame.HideAnimation, "Alpha", 1, 1, 1, 0)

                    frame.CancelFunction = function()
                        frame.HideAnimation:Play()
                    end
                end

                if (Plater.PersonalAdjustLocationTop.HideAnimation:IsPlaying()) then
                    Plater.PersonalAdjustLocationTop.HideAnimation:Stop()
                    Plater.PersonalAdjustLocationTop:SetAlpha (1)
                end
                Plater.PersonalAdjustLocationTop:Show()

                local percentValue = GetScreenHeight()/100
                Plater.PersonalAdjustLocationTop:SetPoint ("bottom", UIParent, "bottom", 0, percentValue * value)

                if (Plater.PersonalAdjustLocationTop.Timer) then
                    Plater.PersonalAdjustLocationTop.Timer:Cancel()
                end
                Plater.PersonalAdjustLocationTop.Timer = C_Timer.NewTimer (10, Plater.PersonalAdjustLocationTop.CancelFunction)

                Plater.UpdateAllPlates()
                Plater.UpdateSelfPlate()
            end,
            min = 2,
            max = 51,
            step = 1,
            nocombat = true,
            name = "顶部约束" .. CVarIcon,
            desc = "调整个人条不能超过的顶部限制位置.\n\n|cFFFFFFFF默认: 50|r" .. CVarDesc,
            hidden = true,
        },

        {
            type = "range",
            get = function() return tonumber (GetCVar ("nameplateSelfBottomInset")*100) end,
            set = function (self, fixedparam, value)
                --Plater.db.profile.plate_config.player.y_position_offset = value

                if (InCombatLockdown()) then
                    Plater:Msg (L["OPTIONS_ERROR_CVARMODIFY"])
                    self:SetValue (tonumber (GetCVar ("nameplateSelfBottomInset")*100))
                    return
                end

                SetCVar ("nameplateSelfBottomInset", value / 100)
                --SetCVar ("nameplateSelfTopInset", value / 100)

                if (not Plater.PersonalAdjustLocationBottom) then
                    Plater.PersonalAdjustLocationBottom = CreateFrame ("frame", "PlaterPersonalBarLocation", UIParent, BackdropTemplateMixin and "BackdropTemplate")
                    local frame = Plater.PersonalAdjustLocationBottom
                    frame:SetWidth (GetScreenWidth())
                    frame:SetHeight (20)
                    frame.Texture = frame:CreateTexture (nil, "background")
                    frame.Texture:SetTexture ([[Interface\AddOns\Plater\images\bar4_vidro]], true)
                    frame.Texture:SetAllPoints()
                    frame.Shadow = frame:CreateTexture (nil, "border")
                    frame.Shadow:SetTexture ([[Interface\ACHIEVEMENTFRAME\UI-Achievement-RecentHeader]], true)
                    frame.Shadow:SetPoint ("center")
                    frame.Shadow:SetSize (256, 18)
                    frame.Shadow:SetTexCoord (0, 1, 0, 22/32)
                    frame.Shadow:SetVertexColor (0, 0, 0, 1)
                    frame.Text = frame:CreateFontString (nil, "artwork", "GameFontNormal")
                    frame.Text:SetText ("Plater: 底部约束")
                    frame.Text:SetPoint ("center")

                    frame.HideAnimation = DF:CreateAnimationHub (frame, nil, function() frame:Hide() end)
                    DF:CreateAnimation (frame.HideAnimation, "Alpha", 1, 1, 1, 0)

                    frame.CancelFunction = function()
                        frame.HideAnimation:Play()
                    end
                end

                if (Plater.PersonalAdjustLocationBottom.HideAnimation:IsPlaying()) then
                    Plater.PersonalAdjustLocationBottom.HideAnimation:Stop()
                    Plater.PersonalAdjustLocationBottom:SetAlpha (1)
                end
                Plater.PersonalAdjustLocationBottom:Show()

                local percentValue = GetScreenHeight()/100
                Plater.PersonalAdjustLocationBottom:SetPoint ("bottom", UIParent, "bottom", 0, percentValue * value)

                if (Plater.PersonalAdjustLocationBottom.Timer) then
                    Plater.PersonalAdjustLocationBottom.Timer:Cancel()
                end
                Plater.PersonalAdjustLocationBottom.Timer = C_Timer.NewTimer (10, Plater.PersonalAdjustLocationBottom.CancelFunction)

                Plater.UpdateAllPlates()
                Plater.UpdateSelfPlate()
            end,
            min = 2,
            max = 51,
            step = 1,
            nocombat = true,
            name = "底部约束" .. CVarIcon,
            desc = "调整个人条不能超过的底部限制位置\n\n|cFFFFFFFF默认: 20|r" .. CVarDesc,
            hidden = true,
        },

        {type = "blank", hidden = IS_WOW_PROJECT_MIDNIGHT},
        {type = "label", get = function() return "动画:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE") }, --, hidden = IS_WOW_PROJECT_MIDNIGHT},

        {
            type = "toggle",
            get = function() return Plater.db.profile.use_health_animation end,
            set = function (self, fixedparam, value)
                Plater.db.profile.use_health_animation = value
                Plater.RefreshDBUpvalues()
                Plater.UpdateAllPlates()
            end,
            name = "血条动画",
            desc = "当姓名版的血值发生变化时制作流畅的动画.",
            --hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.use_color_lerp end,
            set = function (self, fixedparam, value)
                Plater.db.profile.use_color_lerp = value
                Plater.RefreshDBUpvalues()
                Plater.UpdateAllPlates()
            end,
            name = "色彩过渡动画",
            desc = "颜色变化在新旧颜色之间平稳过渡.",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.health_animation_time_dilatation end,
            set = function (self, fixedparam, value)
                Plater.db.profile.health_animation_time_dilatation = value
                Plater.RefreshDBUpvalues()
                Plater.DebugHealthAnimation()
            end,
            min = 0.35,
            max = 5,
            step = 0.1,
            usedecimals = true,
            thumbscale = 1.7,
            name = "血条动画速度",
            desc = "动画速度有多快.",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.color_lerp_speed end,
            set = function (self, fixedparam, value)
                Plater.db.profile.color_lerp_speed = value
                Plater.RefreshDBUpvalues()
                Plater.DebugColorAnimation()
            end,
            min = 1,
            max = 50,
            step = 1,
            name = "颜色动画速度",
            desc = "动画速度有多快.",
            hidden = IS_WOW_PROJECT_MIDNIGHT,
        },

        {type = "blank"},

        {type = "label", get = function() return "单位小组件条:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE"), hidden = IS_WOW_PROJECT_NOT_MAINLINE},
        {
            type = "range",
            get = function() return Plater.db.profile.widget_bar_scale end,
            set = function (self, fixedparam, value)
                Plater.db.profile.widget_bar_scale = value
                Plater.UpdateAllPlates()
            end,
            min = 0.2,
            max = 2,
            step = 0.1,
            name = "比例",
            desc = "略微调整小组件条的大小.",
            usedecimals = true,
            hidden = IS_WOW_PROJECT_NOT_MAINLINE,
        },
        {
            type = "select",
            get = function() return Plater.db.profile.widget_bar_anchor.side end,
            values = function() return build_anchor_side_table (nil, "widget_bar_anchor") end,
            name = "OPTIONS_ANCHOR",
            desc = "小组件条应安装在铭牌的哪一面.",
            hidden = IS_WOW_PROJECT_NOT_MAINLINE,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.widget_bar_anchor.x end,
            set = function (self, fixedparam, value)
                Plater.db.profile.widget_bar_anchor.x = value
                Plater.UpdateAllPlates()
            end,
            min = -20,
            max = 20,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_XOFFSET",
            desc = "OPTIONS_XOFFSET_DESC",
            hidden = IS_WOW_PROJECT_NOT_MAINLINE,
        },
        {
            type = "range",
            get = function() return Plater.db.profile.widget_bar_anchor.y end,
            set = function (self, fixedparam, value)
                Plater.db.profile.widget_bar_anchor.y = value
                Plater.UpdateAllPlates()
            end,
            min = -20,
            max = 20,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_YOFFSET",
            desc = "OPTIONS_YOFFSET_DESC",
            hidden = IS_WOW_PROJECT_NOT_MAINLINE,
        },
    }

    ---@diagnostic disable-next-line: undefined-global
    local advancedFrame = PlaterOptionsPanelContainerAdvancedConfig

    advanced_options.align_as_pairs = true
    advanced_options.align_as_pairs_string_space = 181
    advanced_options.widget_width = 150
    advanced_options.use_scrollframe = true
    advanced_options.language_addonId = addonId
    advanced_options.always_boxfirst = true
    advanced_options.Name = "高级选项"

    local canvasFrame = DF:CreateCanvasScrollBox(advancedFrame, nil, "PlaterOptionsPanelCanvasAdvancedSettings")
    canvasFrame:SetPoint("topleft", advancedFrame, "topleft", 0, platerInternal.optionsYStart)
    canvasFrame:SetPoint("bottomright", advancedFrame, "bottomright", -26, 25)
    advancedFrame.canvasFrame = canvasFrame

    --when passing a canvas frame for BuildMenu, it automatically get its childscroll and use as parent for the widgets
    --DF:BuildMenu(canvasFrame, debuff_options, startX, 0, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template, globalCallback)

    local startX, startY, heightSize = 10, platerInternal.optionsYStart, 755
    --DF:BuildMenu (advancedFrame, advanced_options, startX, startY, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template, platerInternal.OptionsGlobalCallback)
    DF:BuildMenu (canvasFrame, advanced_options, startX, 0, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template, platerInternal.OptionsGlobalCallback)

    platerInternal.LoadOnDemand_IsLoaded.AdvancedOptions = true
    ---@diagnostic disable-next-line: undefined-global
    table.insert(PlaterOptionsPanelFrame.AllSettingsTable, advanced_options)
    platerInternal.CreateAdvancedOptions = function() end
end