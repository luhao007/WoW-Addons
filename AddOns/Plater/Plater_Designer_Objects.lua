
local _
local addonName, platerInternal = ...
---@type plater
local Plater = Plater
---@type detailsframework
local detailsFramework = _G.DetailsFramework
local _
local LSM = LibStub:GetLibrary ("LibSharedMedia-3.0")
local designer = platerInternal.Designer
local L = detailsFramework.Language.GetLanguageTable(addonName)

local PixelUtil = PixelUtil
local CreateFrame = CreateFrame
local C_Timer = C_Timer
local UnitName = UnitName

---@class plater_designer_options : table

local options = designer.Options

function designer.CreateSettings(parentFrame)
    options.WidgetSettingsMapTables = {
        UnitName = {
            --text = UnitName("player"),
            size = "actorname_text_size",
            font = "actorname_text_font",
            color = "actorname_text_color",
            outline = "actorname_text_outline",
            shadowcolor = "actorname_text_shadow_color",
            shadowoffsetx = "actorname_text_shadow_color_offset[1]",
            shadowoffsety = "actorname_text_shadow_color_offset[2]",
            anchor = "actorname_text_anchor.side",
            anchoroffsetx = "actorname_text_anchor.x",
            anchoroffsety = "actorname_text_anchor.y",
            --name_attach_to_role_icon = "name_attach_to_role_icon",
            --layer = "name_layer",
            --classcolor = "name_classcolor",
        },

        CastBarTargetName = {
            size = "castbar_target_text_size",
            font = "castbar_target_font",
            color = "castbar_target_color",
            outline = "castbar_target_outline",
            shadowcolor = "castbar_target_shadow_color",
            shadowoffsetx = "castbar_target_shadow_color_offset[1]",
            shadowoffsety = "castbar_target_shadow_color_offset[2]",
            anchor = "castbar_target_anchor.side",
            anchoroffsetx = "castbar_target_anchor.x",
            anchoroffsety = "castbar_target_anchor.y",
        },

        LifePercent = {
            text = "80",
            size = "percent_text_size",
            font = "percent_text_font",
            color = "percent_text_color",
            outline = "percent_text_outline",
            percent_text_shadow_color = "percent_text_shadow_color",
            shadowoffsetx = "percent_text_shadow_color_offset[1]",
            shadowoffsety = "percent_text_shadow_color_offset[2]",
            anchor = "percent_text_anchor.side",
            anchoroffsetx = "percent_text_anchor.x",
            anchoroffsety = "percent_text_anchor.y",
            alpha = "percent_text_alpha",
        },

        SpellName = {
            --text = UnitName("player"),
            size = "spellname_text_size",
            font = "spellname_text_font",
            color = "spellname_text_color",
            outline = "spellname_text_outline",
            shadowcolor = "spellname_text_shadow_color",
            shadowoffsetx = "spellname_text_shadow_color_offset[1]",
            shadowoffsety = "spellname_text_shadow_color_offset[2]",
            anchor = "spellname_text_anchor.side",
            anchoroffsetx = "spellname_text_anchor.x",
            anchoroffsety = "spellname_text_anchor.y",
            --name_attach_to_role_icon = "name_attach_to_role_icon",
            --layer = "name_layer",
            --classcolor = "name_classcolor",
        },

        CastBarSpark = {
            --texture = "cast_statusbar_spark_texture", --it'll need a feed of textures, perhaps a function
            width = "cast_statusbar_spark_width",
            vertexcolor = "cast_statusbar_spark_color",
            alpha = "cast_statusbar_spark_alpha",
            --["height"] = 0,
            --["anchor"] = 0,
            --["anchoroffsetx"] = 0,
            --["anchoroffsety"] = 0,

            --cast_statusbar_spark_texture = [[Interface\AddOns\Plater\images\spark1]],
        },

        UnitLevel = {
            --text = "80",
            size = "level_text_size",
            font = "level_text_font",
            --color = "level_text_color",
            outline = "level_text_outline",
            shadowcolor = "level_text_shadow_color",
            shadowoffsetx = "level_text_shadow_color_offset[1]",
            shadowoffsety = "level_text_shadow_color_offset[2]",
            anchor = "level_text_anchor.side",
            anchoroffsetx = "level_text_anchor.x",
            anchoroffsety = "level_text_anchor.y",
            alpha = "level_text_alpha",
            --name_attach_to_role_icon = "name_attach_to_role_icon",
            --layer = "name_layer",
            --classcolor = "name_classcolor",
        },

        SpellCastTime = {
            --text = "3.2s",
            size = "spellpercent_text_size",
            font = "spellpercent_text_font",
            color = "spellpercent_text_color",
            outline = "spellpercent_text_outline",
            shadowcolor = "spellpercent_text_shadow_color",
            shadowoffsetx = "spellpercent_text_shadow_color_offset[1]",
            shadowoffsety = "spellpercent_text_shadow_color_offset[2]",
            anchor = "spellpercent_text_anchor.side",
            anchoroffsetx = "spellpercent_text_anchor.x",
            anchoroffsety = "spellpercent_text_anchor.y",
            --alpha = "spellpercent_text_alpha",
        },

        BigUnitName = {
            can_move = false,
            size = "big_actorname_text_size",
            font = "big_actorname_text_font",
            color = "big_actorname_text_color",
            outline = "big_actorname_text_outline",
            shadowcolor = "big_actorname_text_shadow_color",
            shadowoffsetx = "big_actorname_text_shadow_color_offset[1]",
            shadowoffsety = "big_actorname_text_shadow_color_offset[2]",
        },

        BigActorTitle = {
            can_move = false,
            size = "big_actortitle_text_size",
            font = "big_actortitle_text_font",
            outline = "big_actortitle_text_outline",
            shadowcolor = "big_actortitle_text_shadow_color",
            shadowoffsetx = "big_actortitle_text_shadow_color_offset[1]",
            shadowoffsety = "big_actortitle_text_shadow_color_offset[2]",
        },

        QuestOptions = {},

        CastBar = {
            --values from PlaterDB.profile.plate_config[unittype]
            width = "cast_incombat[1]", --plate_config.enemynpc.
            height = "cast_incombat[2]", --plate_config.enemynpc.
        },

        NameplateSize = {
            --values from PlaterDB.profile.plate_config[unittype]
            width = "health_incombat[1]", --plate_config.enemynpc.
            height = "health_incombat[2]", --plate_config.enemynpc.
        },

        ExecuteRange = {},

        Target = {},

        Focus = {},

        --indicator_raidmark_anchor is a {side, x, y} table on profile root; mapping anchor +
        --offsets here lets the editor's built-in anchor handling (mover, side dropdown, offset
        --sliders) drive the raid mark's PlaterRaidTargetFrame container.
        RaidMark = {
            anchor = "indicator_raidmark_anchor.side",
            anchoroffsetx = "indicator_raidmark_anchor.x",
            anchoroffsety = "indicator_raidmark_anchor.y",
        },

        Colors = {},
        MidnightMobColors = {},
        Auras = {},
        AuraTracking = {},
        AuraBorderColors = {},
        StackCounter = {},
        AuraTimer = {},
        Indicators = {},
    }

    --in-memory mirror of target-related CVars. used as the profileTable override on Target's
    --CVar extras because the editor needs a non-nil value at registration time and the actual
    --CVar lives outside Plater.db.profile. seeded once when the designer first opens; the
    --setters keep it in sync alongside SetCVar() so re-opens stay consistent within the session.
    local cvarMirror = {
        nameplateTargetRadialPosition = GetCVarBool("nameplateTargetRadialPosition"),
        nameplateTargetBehindMaxDistance = tonumber(GetCVar("nameplateTargetBehindMaxDistance")),
        nameplateSelectedScale = tonumber(GetCVar("nameplateSelectedScale")),
    }

    --decorates a color option with the live hover preview (paints the preview's healthBar
    --while hovering or while the picker is open). composes with the option's existing setter
    --so options that also call Plater.UpdateAllNameplateColors etc. keep working unchanged.
    local addColorPreview = function(option)
        local profilePath = option.key
        local originalSetter = option.setter

        local paintPreview = function()
            local healthBar = designer.plateFrame.unitFrame.healthBar
            local color = detailsFramework.table.getfrompath(Plater.db.profile, profilePath)
            healthBar:SetStatusBarColor(color[1], color[2], color[3], color[4] or 1)
        end

        option.setter = function(colors, value)
            if (originalSetter) then
                originalSetter(colors, value)
            end
            --keep painting while the picker is open (the preview plate is not in GetAllShownPlates).
            if (ColorPickerFrame:IsShown()) then
                paintPreview()
            end
        end

        option.onenter = function(widget)
            local healthBar = designer.plateFrame.unitFrame.healthBar
            --save the original color only on the first enter so a second hover during a
            --picker session does not overwrite it with the in-progress preview color.
            if (not widget.savedHealthBarColor) then
                widget.savedHealthBarColor = {healthBar:GetStatusBarColor()}
            end
            paintPreview()

            --install once per pooled widget. fires on any picker close (ok, cancel, dismiss)
            --and restores the bar to the pre-hover color. scoped via savedHealthBarColor so
            --it no-ops for other widgets sharing the global ColorPickerFrame.
            if (not widget.colorPickerHideHookInstalled) then
                widget.colorPickerHideHookInstalled = true
                ColorPickerFrame:HookScript("OnHide", function()
                    if (widget.savedHealthBarColor) then
                        designer.plateFrame.unitFrame.healthBar:SetStatusBarColor(unpack(widget.savedHealthBarColor))
                        widget.savedHealthBarColor = nil
                    end
                end)
            end
        end

        option.onleave = function(widget)
            --keep the preview active while the picker is up so moving the mouse off the
            --colorpick button (onto the picker frame) does not revert mid-pick.
            if (ColorPickerFrame:IsShown()) then
                return
            end
            local healthBar = designer.plateFrame.unitFrame.healthBar
            if (widget.savedHealthBarColor) then
                healthBar:SetStatusBarColor(unpack(widget.savedHealthBarColor))
                widget.savedHealthBarColor = nil
            end
        end

        return option
    end

    options.WidgetSettingsExtraOptions = {
        HealthBar = {
            {
                key = "health_statusbar_texture",
                label = "材质",
                widget = "selectstatusbartexture",
                default = Plater.db.profile.health_statusbar_texture,
                setter = function(healthBar, value) healthBar:SetTexture(LSM:Fetch("statusbar", value)); designer.UpdateAllNameplates() end,
            },

            {
                key = "health_statusbar_bgcolor",
                label = "背景颜色",
                widget = "color",
                default = Plater.db.profile.health_statusbar_bgcolor,
                setter = function(healthBar, color)
                    local r, g, b, a = unpack(color)
                    healthBar.background:SetVertexColor(r, g, b, a); designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            {
                key = "border_color",
                label = "边框颜色",
                widget = "color",
                default = Plater.db.profile.border_color,
                setter = function(healthBar, color)
                    local r, g, b, a = unpack(color)
                    Plater.UpdatePlateBorders(healthBar.unitFrame.PlateFrame) designer.UpdateAllNameplates()
                end,
            },

            {
                key = "border_thickness",
                label = "边框粗细",
                widget = "slider",
                minvalue = 0,
                maxvalue = 10,
                step = 1,
                default = Plater.db.profile.border_thickness,
                setter = function(healthBar, value)
                    Plater.UpdatePlateBorders(healthBar.unitFrame.PlateFrame) designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            --hover over hightlight
            {
                key = "hover_highlight",
                label = "鼠标悬停高亮",
                widget = "toggle",
                default = Plater.db.profile.hover_highlight,
                setter = function(healthBar, value)
                    if value then
                        Plater.EnableHighlight(healthBar.unitFrame)
                    else
                        Plater.DisableHighlight(healthBar.unitFrame)
                    end
                    designer.UpdateAllNameplates()
                end,
            },
            --hover_highlight_alpha
            {
                key = "hover_highlight_alpha",
                label = "鼠标悬停高亮透明度",
                widget = "slider",
                minvalue = 0,
                maxvalue = 1,
                step = 0.1,
                usedecimals = true,
                default = Plater.db.profile.hover_highlight_alpha,
                setter = function(healthBar, value)
                    healthBar.unitFrame.HighlightFrame.HighlightTexture:SetAlpha(Plater.db.profile.hover_highlight_alpha); designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},


        },

        ExecuteRange = {
            --execution range (health cutoff)
            {
                key = "health_cutoff",
                label = L["OPTIONS_EXECUTERANGE"],
                widget = "toggle",
                default = Plater.db.profile.health_cutoff,
                setter = function(healthBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "health_cutoff_upper",
                label = L["OPTIONS_EXECUTERANGE_HIGH_HEALTH"],
                widget = "toggle",
                default = Plater.db.profile.health_cutoff_upper,
                setter = function(healthBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "health_cutoff_extra_glow",
                label = "在斩杀阶段添加额外发光效果",
                widget = "toggle",
                default = Plater.db.profile.health_cutoff_extra_glow,
                setter = function(healthBar, value) designer.UpdateAllNameplates() end,
            },
        },

            --{
            --    key = "health_cutoff_hide_divisor",
            --    label = L["OPTIONS_EXECUTERANGE_HIDE_DIVISOR"],
            --    widget = "toggle",
            --    default = Plater.db.profile.health_cutoff_hide_divisor,
            --    setter = function(healthBar, value) designer.UpdateAllNameplates() end,
            --},

            --[=[
                {
                add:
                health bar 
                    use_health_animation = false, profile root

                health cut off (execute settings) -> profile root
                    health_cutoff = true,
                    health_cutoff_upper = true,
                    health_cutoff_extra_glow = false,
                    health_cutoff_hide_divisor = false,

                border se0ttings
		focus_indicator_enabled = true,
		focus_color = {0, 0, 0, 0.5},
		focus_texture = "PlaterFocus",
                
                aggro flash

                new object for target settings

                new object for raid target
        target_highlight = true,
		target_highlight_alpha = 0.75,
		target_highlight_height = 14,
		target_highlight_color = {0, 0.521568, 1, 1},
		target_highlight_texture = [[Interface\AddOns\Plater\images\selection_indicator3]],
		target_shady_alpha = 0.6,
		target_shady_enabled = true,
		target_shady_combat_only = true,



                new object for indicators fro the main settings window
        		indicator_faction = true,
		indicator_friendlyfaction = false,
		indicator_spec = true,
		indicator_spec_always = false,
		indicator_friendlyspec = false,
		indicator_worldboss = true,
		indicator_elite = true,
		indicator_rare = true,
		indicator_quest = true,
		indicator_pet = true,
		indicator_enemyclass = false,
		indicator_friendlyclass = false,
		indicator_anchor = {side = 2, x = -2, y = 0},
		indicator_scale = 1,
		indicator_shield = false,
		indicator_extra_raidmark = true,
		indicator_raidmark_scale = 1,
		indicator_raidmark_anchor = {side = 2, x = -1, y = 0},
        target_indicator = "Silver",

                new object for theat colors.

                new object for buff settings? there is way too much options there.


                an object for range check and transparency control, those that are  in the main settings tab 

                key = "../../../health_statusbar_texture", --the name of the option in the profile table
                label = "材质",
                widget = "selectstatusbartexture",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
                tableName = "health_statusbar_texture",
            },
            --]=]
        

        --tableName is not a field that is used by the designer in the framework
        --it is here so the Plater_Designer can know which field to update in the profile table

        CastBar = {
            {
                key = "castbar_offset_x", --the name of the option in the profile table
                label = "水平偏移量",
                widget = "slider",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
                minvalue = -16,
                maxvalue = 16,
                step = 1,
                tableName = "castbar_offset_x",
            },
            {
                key = "castbar_offset", --without Y
                label = "垂直偏移量",
                widget = "slider",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
                minvalue = -16,
                maxvalue = 16,
                step = 1,
                tableName = "castbar_offset_y",
            },

            {type = "blank"},

            --root-level cast bar appearance. profileTable override points reads/writes at Plater.db.profile
            --since Cast Bar's registration is bound to plate_config.<actorType>.
            {
                key = "cast_statusbar_texture",
                label = "材质",
                widget = "selectstatusbartexture",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_texture,
                setter = function(castBar, value)
                    castBar:SetStatusBarTexture(LSM:Fetch("statusbar", value))
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "cast_statusbar_bgtexture",
                label = "背景材质",
                widget = "selectstatusbartexture",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_bgtexture,
                setter = function(castBar, value)
                    castBar.background:SetTexture(LSM:Fetch("statusbar", value))
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            {
                key = "cast_statusbar_use_fade_effects",
                label = "启用淡入淡出动画",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_use_fade_effects,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_fadein_time",
                label = "开始时",
                widget = "slider",
                minvalue = 0.01,
                maxvalue = 1,
                step = 0.01,
                usedecimals = true,
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_fadein_time,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_fadeout_time",
                label = "结束时",
                widget = "slider",
                minvalue = 0.01,
                maxvalue = 2,
                step = 0.01,
                usedecimals = true,
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_fadeout_time,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},

            {
                key = "show_interrupt_author",
                label = "显示打断者",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.show_interrupt_author,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_interrupt_anim",
                label = "播放打断动画",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_interrupt_anim,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_spark_filloninterrupt",
                label = "打断时填充施法条",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_spark_filloninterrupt,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_quickhide",
                label = "快速隐藏施法条",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_quickhide,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "hide_friendly_castbars",
                label = "隐藏友方施法条",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.hide_friendly_castbars,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "hide_enemy_castbars",
                label = "隐藏敌方施法条",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.hide_enemy_castbars,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},
            {type = "label", get = function() return "OPTIONS_CASTBAR_COLORS" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "cast_statusbar_color",
                label = "常规",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_channeling",
                label = "引导",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_channeling,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_empowered",
                label = "蓄力",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_empowered,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_important",
                label = "重要",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_important,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_nointerrupt",
                label = "不可打断",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_nointerrupt,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_interrupted",
                label = "已打断",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_interrupted,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_color_finished",
                label = "成功",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_color_finished,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_bgcolor",
                label = "背景颜色",
                widget = "color",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.cast_statusbar_bgcolor,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},
            {type = "label", get = function() return "OPTIONS_CASTBAR_SPELLICON" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "castbar_icon_customization_enabled",
                label = "启用自定义图标",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_customization_enabled,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "castbar_icon_show",
                label = "显示图标",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_show,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "castbar_icon_attach_to_side",
                label = "图标位置",
                widget = "dropdown",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_attach_to_side,
                dropdownFunc = function()
                    return {
                        {value = "left", label = "左侧"},
                        {value = "right", label = "右侧"},
                    }
                end,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "castbar_icon_size",
                label = "图标大小",
                widget = "dropdown",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_size,
                dropdownFunc = function()
                    return {
                        {value = "same as castbar", label = "施法条大小"},
                        {value = "same as castbar plus healthbar", label = "施法条+生命条大小"},
                    }
                end,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "castbar_icon_x_offset",
                label = "水平偏移",
                widget = "slider",
                minvalue = -20,
                maxvalue = 20,
                step = 1,
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_x_offset,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "castbar_icon_showshield",
                label = "显示护盾",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.castbar_icon_showshield,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},
            {type = "label", get = function() return "OPTIONS_CASTBAR_BLIZZCASTBAR" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "hide_blizzard_castbar",
                label = "隐藏暴雪施法条",
                widget = "toggle",
                profileTable = Plater.db.profile,
                default = Plater.db.profile.hide_blizzard_castbar,
                setter = function(castBar, value) designer.UpdateAllNameplates() end,
            },
        },

        CastBarSpark = {
            {
                key = "cast_statusbar_spark_hideoninterrupt", --the name of the option in the profile table
                label = "打断时隐藏火花",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_spark_half", --the name of the option in the profile table
                label = "半长火花",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "cast_statusbar_spark_offset", --the name of the option in the profile table
                label = "偏移量",
                widget = "slider",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
                minvalue = -16,
                maxvalue = 16,
                step = 1,
            }
        },

        QuestOptions = {
            {
                key = "quest_enabled", --the name of the option in the profile table
                label = "启用",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "quest_color_enabled", --the name of the option in the profile table
                label = "更改颜色",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "quest_color_enemy", --the name of the option in the profile table
                label = "敌对任务目标颜色",
                widget = "color",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "quest_color_neutral", --the name of the option in the profile table
                label = "中立任务目标颜色",
                widget = "color",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },

        UnitName = {},

        CastBarTargetName = {
            {
                key = "castbar_target_show", --the name of the option in the profile table
                label = "启用",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },

            {
                key = "castbar_target_notank", --the name of the option in the profile table
                label = "不显示坦克",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },

        BigUnitName = {},
        BigActorTitle = {},

        UnitLevel = {
            {
                key = "level_text_enabled", --the name of the option in the profile table
                label = "启用",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },

        SpellCastTime = {
            {
                key = "spellpercent_text_enabled", --the name of the option in the profile table
                label = "启用",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },

        SpellName = {},

        --all options copied from the options panel "colors / threat" section (Plater_OptionsPanel.lua
        --thread_options table). settings are global, so they read and write at profile root.
        Colors = {
            {type = "label", get = function() return "威胁修改" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "aggro_modifies.health_bar_color",
                label = "血条颜色",
                widget = "toggle",
                default = Plater.db.profile.aggro_modifies.health_bar_color,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "aggro_modifies.border_color",
                label = "边框颜色",
                widget = "toggle",
                default = Plater.db.profile.aggro_modifies.border_color,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "aggro_modifies.actor_name_color",
                label = "名字颜色",
                widget = "toggle",
                default = Plater.db.profile.aggro_modifies.actor_name_color,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},
            {type = "label", get = function() return "坦克角色时的颜色" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            addColorPreview({
                key = "tank.colors.aggro",
                label = "你获得仇恨",
                desc = "该单位正在攻击你, 并且你有稳定的仇恨.",
                widget = "color",
                default = Plater.db.profile.tank.colors.aggro,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "tank.colors.anothertank",
                label = "另一坦克获得仇恨",
                desc = "该单位正被你队伍中的另一坦克拉住.",
                widget = "color",
                default = Plater.db.profile.tank.colors.anothertank,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "tank.colors.pulling",
                label = "你获得仇恨但即将丢失",
                desc = "该单位正在攻击你, 但其他人即将拉走仇恨.",
                widget = "color",
                default = Plater.db.profile.tank.colors.pulling,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "tank.colors.noaggro",
                label = "无仇恨",
                desc = "该单位没有对你产生仇恨.",
                widget = "color",
                default = Plater.db.profile.tank.colors.noaggro,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "tank.colors.pulling_from_tank",
                label = "从另一坦克处拉取",
                desc = "该单位对另一坦克有仇恨, 而你即将拉走它.",
                widget = "color",
                default = Plater.db.profile.tank.colors.pulling_from_tank,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),

            {type = "blank"},
            {type = "label", get = function() return "DPS或治疗角色时的颜色" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            addColorPreview({
                key = "dps.colors.aggro",
                label = "你获得仇恨",
                desc = "该单位正在攻击你.",
                widget = "color",
                default = Plater.db.profile.dps.colors.aggro,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "dps.colors.pulling",
                label = "高威胁",
                desc = "该单位即将开始攻击你.",
                widget = "color",
                default = Plater.db.profile.dps.colors.pulling,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "dps.colors.noaggro",
                label = "无仇恨",
                desc = "该单位没有攻击你.",
                widget = "color",
                default = Plater.db.profile.dps.colors.noaggro,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            {
                key = "dps.use_aggro_solo",
                label = "使用'单人'颜色",
                desc = "不在队伍时使用'单人'颜色.",
                widget = "toggle",
                default = Plater.db.profile.dps.use_aggro_solo,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },
            addColorPreview({
                key = "dps.colors.solo",
                label = "单人颜色",
                desc = "不在队伍时使用的颜色.",
                widget = "color",
                default = Plater.db.profile.dps.colors.solo,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),

            {type = "blank"},

            {
                key = "aggro_can_check_notank",
                label = "检测非坦克仇恨",
                desc = "当你作为治疗或DPS没有仇恨时, 检查敌人是否在攻击一个非坦克单位.",
                widget = "toggle",
                default = Plater.db.profile.aggro_can_check_notank,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },
            addColorPreview({
                key = "dps.colors.notontank",
                label = "非坦克仇恨",
                desc = "该单位没有攻击你或坦克, 很可能正在攻击你队伍中的另一治疗或DPS.",
                widget = "color",
                default = Plater.db.profile.dps.colors.notontank,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),

            {type = "blank"},

            addColorPreview({
                key = "tank.colors.nocombat",
                label = "未进入战斗",
                desc = "该单位未进入战斗.",
                widget = "color",
                default = Plater.db.profile.tank.colors.nocombat,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),
            addColorPreview({
                key = "tap_denied_color",
                label = "单位已被标记",
                desc = "当其他人已经获得了该单位(你击杀它将无法获得经验或战利品).",
                widget = "color",
                default = Plater.db.profile.tap_denied_color,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            }),

            {type = "blank"},
            {type = "label", get = function() return "坦克或DPS颜色:" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            --this toggle is hidden on retail in the options panel (classic only setting). kept here
            --so all options are reachable from the editor.
            {
                key = "tank_threat_colors",
                label = "使用坦克威胁颜色",
                widget = "toggle",
                default = Plater.db.profile.tank_threat_colors,
                setter = function(colors, value)
                    Plater.RefreshTankCache()
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},
            {type = "label", get = function() return "覆盖默认颜色" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "color_override",
                label = "启用",
                desc = "修改游戏为中立, 敌对和友好单位设置的默认颜色. 战斗中, 如果允许威胁颜色改变血条颜色, 这些颜色也会被覆盖.",
                widget = "toggle",
                default = Plater.db.profile.color_override,
                setter = function(colors, value)
                    Plater.RefreshColorOverride()
                    designer.UpdateAllNameplates()
                end,
            },
            addColorPreview({
                key = "color_override_colors[3]",
                label = "敌对",
                desc = "敌对",
                widget = "color",
                default = Plater.db.profile.color_override_colors[3],
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),
            addColorPreview({
                key = "color_override_colors[4]",
                label = "中立",
                desc = "中立",
                widget = "color",
                default = Plater.db.profile.color_override_colors[4],
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),
            addColorPreview({
                key = "color_override_colors[5]",
                label = "友好",
                desc = "友好",
                widget = "color",
                default = Plater.db.profile.color_override_colors[5],
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),

            {type = "blank"},
            {type = "label", get = function() return "杂项:" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            {
                key = "show_aggro_flash",
                label = "启用仇恨闪烁",
                desc = "启用DPS获得仇恨时姓名板上的 -仇恨- 闪烁动画.",
                widget = "toggle",
                default = Plater.db.profile.show_aggro_flash,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "show_aggro_glow",
                label = "启用血条仇恨发光",
                desc = "启用DPS获得仇恨或坦克失去仇恨时血条的发光效果.",
                widget = "toggle",
                default = Plater.db.profile.show_aggro_glow,
                setter = function(colors, value) designer.UpdateAllNameplates() end,
            },

        },

        --unit-type coloring extras, surfaced as their own widget (Midnight Mob Colors).
        --kept separate from Colors so the threat/override section stays focused on threat.
        MidnightMobColors = {
            {
                key = "unit_type_coloring_enabled",
                label = "启用",
                desc = "使用下方的颜色启用单位类型着色. 仅在地下城和团队副本中生效. 不良的威胁状态会覆盖此颜色.",
                widget = "toggle",
                default = Plater.db.profile.unit_type_coloring_enabled,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "unit_type_coloring_no_override_threat",
                label = "威胁覆盖单位类型",
                desc = "威胁着色将优先于单位类型颜色.",
                widget = "toggle",
                default = Plater.db.profile.unit_type_coloring_no_override_threat,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            addColorPreview({
                key = "unit_type_coloring_boss",
                label = "首领",
                desc = "团队或地下城首领的颜色.",
                widget = "color",
                default = Plater.db.profile.unit_type_coloring_boss,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),
            addColorPreview({
                key = "unit_type_coloring_miniboss",
                label = "小首领",
                desc = "小首领的颜色.",
                widget = "color",
                default = Plater.db.profile.unit_type_coloring_miniboss,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),
            addColorPreview({
                key = "unit_type_coloring_caster",
                label = "施法者",
                desc = "施法者单位的颜色.",
                widget = "color",
                default = Plater.db.profile.unit_type_coloring_caster,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),

            {type = "blank"},

            {
                key = "unit_type_coloring_enable_elite",
                label = "启用精英",
                desc = "将非精英颜色覆盖为'精英'.",
                widget = "toggle",
                default = Plater.db.profile.unit_type_coloring_enable_elite,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            },
            addColorPreview({
                key = "unit_type_coloring_elite",
                label = "精英",
                desc = "精英单位的颜色.",
                widget = "color",
                default = Plater.db.profile.unit_type_coloring_elite,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),

            {type = "blank"},

            {
                key = "unit_type_coloring_enable_trivial",
                label = "启用普通",
                desc = "将非精英颜色覆盖为'普通'.",
                widget = "toggle",
                default = Plater.db.profile.unit_type_coloring_enable_trivial,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            },
            addColorPreview({
                key = "unit_type_coloring_trivial",
                label = "普通",
                desc = "非精英/普通单位的颜色.",
                widget = "color",
                default = Plater.db.profile.unit_type_coloring_trivial,
                setter = function(colors, value)
                    Plater.UpdateAllNameplateColors()
                    designer.UpdateAllNameplates()
                end,
            }),
        },

        --all options copied from the options panel "buffs" section (Plater_OptionsPanel.lua
        --debuff_options table). settings are global, so they read and write at profile root.
        Auras = (function()
            --setter helpers (closures captured below). most aura settings need to refresh DB
            --upvalues and force a full plate update, sometimes also rebuilding the icon pool.
            local refreshAuraDB = function()
                Plater.RefreshDBUpvalues()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local refreshAuraDBAndIcons = function()
                Plater.RefreshDBUpvalues()
                Plater.RefreshAuras()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local updateAllPlatesOnly = function()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local refreshAndUpdateAuras = function()
                Plater.RefreshAuras()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end

            --dropdown option builders. anchor sides + outline modes + grow directions match
            --the values Plater itself uses (see build_anchor_side_table / build_outline_modes_table
            --/ build_grow_direction_options in Plater_OptionsPanel.lua).
            local anchorSideOptions = function()
                return {
                    {value = 1, label = "左上"},
                    {value = 2, label = "左"},
                    {value = 3, label = "左下"},
                    {value = 4, label = "下"},
                    {value = 5, label = "右下"},
                    {value = 6, label = "右"},
                    {value = 7, label = "右上"},
                    {value = 8, label = "上"},
                    {value = 9, label = "居中"},
                }
            end
            local outlineOptions = function()
                return {
                    {value = "NONE", label = "无"},
                    {value = "MONOCHROME", label = "单色"},
                    {value = "OUTLINE", label = "描边"},
                    {value = "THICKOUTLINE", label = "粗描边"},
                    {value = "MONOCHROME, OUTLINE", label = "单色+描边"},
                    {value = "MONOCHROME, THICKOUTLINE", label = "单色+粗描边"},
                }
            end
            --grow direction values are numeric (Plater stores 1/2/3, see grow_direction_names
            --in Plater_OptionsPanel.lua near line 1689). using strings here would leave the
            --dropdown showing "no option selected" since the profile value never matches.
            local growDirectionOptions = function()
                return {
                    {value = 1, label = "左"},
                    {value = 2, label = "居中"},
                    {value = 3, label = "右"},
                }
            end
            local fontOptions = function()
                local opts = {}
                for fontName in pairs(LSM:HashTable("font")) do
                    opts[#opts + 1] = {value = fontName, label = fontName}
                end
                return opts
            end

            return {
                {type = "label", get = function() return "通用设置" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

                {
                    key = "aura_enabled",
                    label = "启用",
                    desc = "光环系统的总开关.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_enabled,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_tooltip",
                    label = "显示提示信息",
                    desc = "悬停在光环图标上时显示提示信息.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_tooltip,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_alpha",
                    label = "透明度",
                    desc = "光环图标的整体透明度.",
                    widget = "slider",
                    minvalue = 0, maxvalue = 1, step = 0.01, usedecimals = true,
                    default = Plater.db.profile.aura_alpha,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_padding",
                    label = "图标间距",
                    desc = "光环图标之间的水平间距.",
                    widget = "slider",
                    minvalue = 0, maxvalue = 10, step = 0.01, usedecimals = true,
                    default = Plater.db.profile.aura_padding,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_breakline_space",
                    label = "图标行间距",
                    desc = "光环图标行之间的垂直间距.",
                    widget = "slider",
                    minvalue = 0, maxvalue = 15, step = 0.01, usedecimals = true,
                    default = Plater.db.profile.aura_breakline_space,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_consolidate",
                    label = "堆叠相似光环",
                    desc = "相同名称的光环(例如术士的痛苦无常减益效果)会被堆叠在一起.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_consolidate,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_consolidate_timeleft_lower",
                    label = "显示堆叠光环的最短时间",
                    desc = "显示堆叠光环中最短的剩余时间(禁用时显示最长时间).",
                    widget = "toggle",
                    default = Plater.db.profile.aura_consolidate_timeleft_lower,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_sort",
                    label = "排序光环",
                    desc = "光环按剩余时间排序(默认).",
                    widget = "toggle",
                    default = Plater.db.profile.aura_sort,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_max_shown_limit",
                    label = "最大显示数量",
                    desc = "限制显示的光环数量. 负数: 过滤最短的. 正数: 过滤最长的. 0 = 不过滤.",
                    widget = "slider",
                    minvalue = -8, maxvalue = 8, step = 1,
                    default = Plater.db.profile.aura_max_shown_limit,
                    setter = function(auras, value) refreshAuraDB() end,
                },

                {type = "blank"},
                {type = "label", get = function() return "光环框架 1" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

                {
                    key = "aura_width",
                    label = "宽度",
                    desc = "减益效果图标的宽度.",
                    widget = "slider",
                    minvalue = 4, maxvalue = 80, step = 1,
                    default = Plater.db.profile.aura_width,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "aura_height",
                    label = "高度",
                    desc = "减益效果图标的高度.",
                    widget = "slider",
                    minvalue = 4, maxvalue = 80, step = 1,
                    default = Plater.db.profile.aura_height,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "aura_border_thickness",
                    label = "边框厚度",
                    desc = "每个光环图标周围的边框厚度.",
                    widget = "slider",
                    minvalue = 1, maxvalue = 5, step = 1,
                    default = Plater.db.profile.aura_border_thickness,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "aura_grow_direction",
                    label = "增长方向",
                    desc = "光环图标应该向哪一侧增长. 减益效果先添加, 然后是增益效果.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_grow_direction,
                    dropdownFunc = growDirectionOptions,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_frame1_anchor.side",
                    label = "锚点",
                    desc = "此光环框架附着在姓名板的哪一侧.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_frame1_anchor.side,
                    dropdownFunc = anchorSideOptions,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_frame1_anchor.x",
                    label = "水平偏移",
                    desc = "距离锚点的水平偏移.",
                    widget = "slider",
                    minvalue = -200, maxvalue = 200, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_frame1_anchor.x,
                    setter = function(auras, value)
                        --keep the legacy mirror in sync (Plater reads both keys in places).
                        Plater.db.profile.aura_x_offset = Plater.db.profile.aura_frame1_anchor.x
                        refreshAuraDB()
                    end,
                },
                {
                    key = "aura_frame1_anchor.y",
                    label = "垂直偏移",
                    desc = "距离锚点的垂直偏移.",
                    widget = "slider",
                    minvalue = -200, maxvalue = 200, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_frame1_anchor.y,
                    setter = function(auras, value)
                        Plater.db.profile.aura_y_offset = Plater.db.profile.aura_frame1_anchor.y
                        refreshAuraDB()
                    end,
                },

                {type = "blank"},
                {type = "label", get = function() return "光环框架 2" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

                {
                    key = "aura_width2",
                    label = "宽度",
                    desc = "第二个光环框架的图标宽度.",
                    widget = "slider",
                    minvalue = 4, maxvalue = 80, step = 1,
                    default = Plater.db.profile.aura_width2,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "aura_height2",
                    label = "高度",
                    desc = "第二个光环框架的图标高度.",
                    widget = "slider",
                    minvalue = 4, maxvalue = 80, step = 1,
                    default = Plater.db.profile.aura_height2,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "aura_border_thickness2",
                    label = "边框厚度",
                    desc = "第二个光环框架的边框厚度.",
                    widget = "slider",
                    minvalue = 1, maxvalue = 5, step = 1,
                    default = Plater.db.profile.aura_border_thickness2,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "buffs_on_aura2",
                    label = "启用",
                    desc = "启用后, 增益效果将放置在第二个框架上, 减益效果放在第一个框架上.",
                    widget = "toggle",
                    default = Plater.db.profile.buffs_on_aura2,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura2_grow_direction",
                    label = "增长方向",
                    desc = "光环图标应该向哪一侧增长.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura2_grow_direction,
                    dropdownFunc = growDirectionOptions,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_frame2_anchor.side",
                    label = "锚点",
                    desc = "此光环框架附着在姓名板的哪一侧.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_frame2_anchor.side,
                    dropdownFunc = anchorSideOptions,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_frame2_anchor.x",
                    label = "水平偏移",
                    desc = "距离锚点的水平偏移.",
                    widget = "slider",
                    minvalue = -200, maxvalue = 200, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_frame2_anchor.x,
                    setter = function(auras, value)
                        Plater.db.profile.aura2_x_offset = Plater.db.profile.aura_frame2_anchor.x
                        refreshAuraDB()
                    end,
                },
                {
                    key = "aura_frame2_anchor.y",
                    label = "垂直偏移",
                    desc = "距离锚点的垂直偏移.",
                    widget = "slider",
                    minvalue = -200, maxvalue = 200, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_frame2_anchor.y,
                    setter = function(auras, value)
                        Plater.db.profile.aura2_y_offset = Plater.db.profile.aura_frame2_anchor.y
                        refreshAuraDB()
                    end,
                },

                {type = "blank"},
                {type = "label", get = function() return "每行光环数" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

                {
                    key = "auras_per_row_auto",
                    label = "自动",
                    desc = "根据血条宽度自动将光环拆分为多行.",
                    widget = "toggle",
                    default = Plater.db.profile.auras_per_row_auto,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "auras_per_row_amount",
                    label = "每行光环数 1",
                    desc = "光环框架 1在自动模式禁用时每行的光环数.",
                    widget = "slider",
                    minvalue = 1, maxvalue = 10, step = 1,
                    default = Plater.db.profile.auras_per_row_amount,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
                {
                    key = "auras_per_row_amount2",
                    label = "每行光环数 2",
                    desc = "光环框架 2在自动模式禁用时每行的光环数.",
                    widget = "slider",
                    minvalue = 1, maxvalue = 10, step = 1,
                    default = Plater.db.profile.auras_per_row_amount2,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },

                {type = "blank"},
                {type = "label", get = function() return "扫光动画" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

                {
                    key = "aura_cooldown_show_swipe",
                    label = "显示扫光闭合材质",
                    desc = "在图标上方显示一层深色材质. 该图层会随着扫光移动而应用或移除.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_cooldown_show_swipe,
                    setter = function(auras, value)
                        Plater.IncreaseRefreshID()
                        updateAllPlatesOnly()
                    end,
                },
                {
                    key = "aura_cooldown_reverse",
                    label = "扫光闭合反转",
                    desc = "启用后, 扫光闭合材质会在扫光移动时反向应用.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_cooldown_reverse,
                    setter = function(auras, value)
                        Plater.IncreaseRefreshID()
                        updateAllPlatesOnly()
                    end,
                },
            }
        end)(),

        --automatic aura tracking toggles (which buffs/debuffs Plater picks up). lifted out of
        --the Auras Layout widget so the user can pick this group separately in the sidebar.
        AuraTracking = (function()
            local refreshAuraDB = function()
                Plater.RefreshDBUpvalues()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end

            return {
                {
                    key = "aura_show_aura_by_the_player",
                    label = "显示你施放的光环",
                    desc = "显示你和你的宠物施放的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_aura_by_the_player,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_debuff_as_blizzard_does",
                    label = "显示暴雪姓名板显示的减益效果",
                    desc = "按照暴雪姓名板显示的方式显示减益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_debuff_as_blizzard_does,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_debuff_by_the_player",
                    label = "显示你施放的所有减益效果",
                    desc = "显示你和你的宠物施放的所有减益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_debuff_by_the_player,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_buff_by_the_player",
                    label = "显示你施放的增益效果",
                    desc = "显示你和你的宠物施放的增益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_buff_by_the_player,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_aura_by_other_players",
                    label = "显示其他玩家施放的光环",
                    desc = "显示其他玩家施放的光环. 可能会导致显示大量光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_aura_by_other_players,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_important",
                    label = "显示重要光环",
                    desc = "显示游戏标记为重要的增益和减益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_important,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_dispellable",
                    label = "显示可驱散的增益效果",
                    desc = "显示可以被驱散或偷取的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_dispellable,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_raid",
                    label = "显示团队增益/减益效果",
                    desc = "显示标记为'团队'的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_raid,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_only_short_dispellable_on_players",
                    label = "O仅显示玩家身上的短时可驱散增益",
                    desc = "仅在持续时间低于120秒时显示玩家身上可驱散或可偷取的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_only_short_dispellable_on_players,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_enrage",
                    label = "显示激怒增益",
                    desc = "显示属于激怒类别的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_enrage,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_magic",
                    label = "显示魔法增益",
                    desc = "显示属于魔法类型类别的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_magic,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_crowdcontrol",
                    label = "显示群体控制",
                    desc = "显示群体控制效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_crowdcontrol,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_buff_by_the_unit",
                    label = "显示NPC施放的增益效果",
                    desc = "显示NPC自身施放的增益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_buff_by_the_unit,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_buff_as_blizzard_does",
                    label = "显示暴雪姓名板显示的增益效果",
                    desc = "按照暴雪姓名板显示的方式显示增益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_buff_as_blizzard_does,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_buff_on_enemy_npc",
                    label = "显示敌方NPC上的所有增益效果",
                    desc = "显示敌方NPC上的所有增益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_buff_on_enemy_npc,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_debuff_by_the_unit",
                    label = "显示NPC施放的减益效果",
                    desc = "显示NPC自身施放的减益效果.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_debuff_by_the_unit,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_aura_by_other_npcs",
                    label = "显示其他NPC施放的光环",
                    desc = "显示既不是玩家也不是单位自身施放的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_aura_by_other_npcs,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_offensive_cd",
                    label = "显示进攻性玩家技能冷却",
                    desc = "显示敌方/友方玩家身上的进攻性技能冷却.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_offensive_cd,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "aura_show_defensive_cd",
                    label = "显示防御性玩家技能冷却",
                    desc = "显示敌方/友方玩家身上的防御性技能冷却.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_show_defensive_cd,
                    setter = function(auras, value) refreshAuraDB() end,
                },
                {
                    key = "debuff_hide_permanent",
                    label = "隐藏永久光环",
                    desc = "隐藏没有持续时间的光环.",
                    widget = "toggle",
                    default = Plater.db.profile.debuff_hide_permanent,
                    setter = function(auras, value) refreshAuraDB() end,
                },
            }
        end)(),

        --aura border colors. lifted out of the Auras Layout widget so the user can pick this
        --group separately in the sidebar.
        AuraBorderColors = (function()
            local updateAllPlatesOnly = function()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local refreshAuraDBAndIcons = function()
                Plater.RefreshDBUpvalues()
                Plater.RefreshAuras()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end

            return {
                {
                    key = "aura_border_colors.is_show_all",
                    label = "重要光环边框颜色",
                    desc = "重要光环的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.is_show_all,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.steal_or_purge",
                    label = "可驱散增益边框颜色",
                    desc = "可驱散或可偷取增益的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.steal_or_purge,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.enrage",
                    label = "激怒增益边框颜色",
                    desc = "激怒增益的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.enrage,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.is_buff",
                    label = "增益边框颜色",
                    desc = "增益效果的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.is_buff,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.is_debuff",
                    label = "减益边框颜色",
                    desc = "减益效果的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.is_debuff,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.crowdcontrol",
                    label = "群体控制边框颜色",
                    desc = "群体控制效果的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.crowdcontrol,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.offensive",
                    label = "进攻性技能冷却边框颜色",
                    desc = "进攻性技能冷却的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.offensive,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.defensive",
                    label = "防御性技能冷却边框颜色",
                    desc = "防御性技能冷却的边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.defensive,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors.default",
                    label = "默认边框颜色",
                    desc = "没有特定类别匹配时的默认边框颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_border_colors.default,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_border_colors_by_type",
                    label = "用基于类型的边框颜色",
                    desc = "使用暴雪减益效果类型颜色作为边框.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_border_colors_by_type,
                    setter = function(auras, value) refreshAuraDBAndIcons() end,
                },
            }
        end)(),

        --stack counter (number over the aura icon). lifted out of the Auras Layout widget so
        --the user can pick this group separately in the sidebar.
        StackCounter = (function()
            local updateAllPlatesOnly = function()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local anchorSideOptions = function()
                return {
                    {value = 1, label = "左上"},
                    {value = 2, label = "左"},
                    {value = 3, label = "左下"},
                    {value = 4, label = "下"},
                    {value = 5, label = "右下"},
                    {value = 6, label = "右"},
                    {value = 7, label = "右上"},
                    {value = 8, label = "上"},
                    {value = 9, label = "居中"},
                }
            end
            local outlineOptions = function()
                return {
                    {value = "NONE", label = "无"},
                    {value = "MONOCHROME", label = "单色"},
                    {value = "OUTLINE", label = "描边"},
                    {value = "THICKOUTLINE", label = "粗描边"},
                    {value = "MONOCHROME, OUTLINE", label = "单色+描边"},
                    {value = "MONOCHROME, THICKOUTLINE", label = "单色+粗描边"},
                }
            end
            local fontOptions = function()
                local opts = {}
                for fontName in pairs(LSM:HashTable("font")) do
                    opts[#opts + 1] = {value = fontName, label = fontName}
                end
                return opts
            end

            return {
                {
                    key = "aura_stack_font",
                    label = "字体",
                    desc = "层数计数文本使用的字体.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_stack_font,
                    dropdownFunc = fontOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_size",
                    label = "大小",
                    desc = "层数计数文本的大小.",
                    widget = "slider",
                    minvalue = 6, maxvalue = 24, step = 1,
                    default = Plater.db.profile.aura_stack_size,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_outline",
                    label = "描边",
                    desc = "层数计数文本的描边样式.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_stack_outline,
                    dropdownFunc = outlineOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_shadow_color",
                    label = "阴影颜色",
                    desc = "层数计数背后的投影颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_stack_shadow_color,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_color",
                    label = "颜色",
                    desc = "层数计数文本的颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_stack_color,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_anchor.side",
                    label = "锚点",
                    desc = "层数计数器附着在增益图标的哪一侧.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_stack_anchor.side,
                    dropdownFunc = anchorSideOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_anchor.x",
                    label = "水平偏移",
                    desc = "层数计数器的水平偏移.",
                    widget = "slider",
                    minvalue = -20, maxvalue = 20, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_stack_anchor.x,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_stack_anchor.y",
                    label = "垂直偏移",
                    desc = "层数计数器的垂直偏移.",
                    widget = "slider",
                    minvalue = -20, maxvalue = 20, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_stack_anchor.y,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
            }
        end)(),

        --aura timer (time left over the aura icon). lifted out of the Auras Layout widget so
        --the user can pick this group separately in the sidebar.
        AuraTimer = (function()
            local updateAllPlatesOnly = function()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local refreshAndUpdateAuras = function()
                Plater.RefreshAuras()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local anchorSideOptions = function()
                return {
                    {value = 1, label = "左上"},
                    {value = 2, label = "左"},
                    {value = 3, label = "左下"},
                    {value = 4, label = "下"},
                    {value = 5, label = "右下"},
                    {value = 6, label = "右"},
                    {value = 7, label = "右上"},
                    {value = 8, label = "上"},
                    {value = 9, label = "居中"},
                }
            end
            local outlineOptions = function()
                return {
                    {value = "NONE", label = "无"},
                    {value = "MONOCHROME", label = "单色"},
                    {value = "OUTLINE", label = "描边"},
                    {value = "THICKOUTLINE", label = "粗描边"},
                    {value = "MONOCHROME, OUTLINE", label = "单色+描边"},
                    {value = "MONOCHROME, THICKOUTLINE", label = "单色+粗描边"},
                }
            end
            local fontOptions = function()
                local opts = {}
                for fontName in pairs(LSM:HashTable("font")) do
                    opts[#opts + 1] = {value = fontName, label = fontName}
                end
                return opts
            end

            return {
                {
                    key = "aura_timer",
                    label = "启用",
                    desc = "增益或减益的剩余时间.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_timer,
                    setter = function(auras, value) refreshAndUpdateAuras() end,
                },
                {
                    key = "aura_timer_pandemic_color",
                    label = "疫病颜色",
                    desc = "根据剩余时间对计时器着色. 高于25%: 默认, 低于25%: 橙色, 低于15%: 红色.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_timer_pandemic_color,
                    setter = function(auras, value) refreshAndUpdateAuras() end,
                },
                {
                    key = "aura_timer_decimals",
                    label = "显示小数",
                    desc = "剩余时间低于10秒时显示小数.",
                    widget = "toggle",
                    default = Plater.db.profile.aura_timer_decimals,
                    setter = function(auras, value) refreshAndUpdateAuras() end,
                },
                {
                    key = "disable_omnicc_on_auras",
                    label = "隐藏OmniCC/TullaCC计时器",
                    desc = "OmniCC/TullaCC计时器将不会在光环中显示. 切换后需要/reload.",
                    widget = "toggle",
                    default = Plater.db.profile.disable_omnicc_on_auras,
                    setter = function(auras, value) Plater.RefreshOmniCCGroup() end,
                },
                {
                    key = "aura_timer_text_font",
                    label = "字体",
                    desc = "计时器文本使用的字体.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_timer_text_font,
                    dropdownFunc = fontOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_size",
                    label = "大小",
                    desc = "计时器文本大小.",
                    widget = "slider",
                    minvalue = 7, maxvalue = 40, step = 1,
                    default = Plater.db.profile.aura_timer_text_size,
                    setter = function(auras, value) refreshAndUpdateAuras() end,
                },
                {
                    key = "aura_timer_text_outline",
                    label = "描边",
                    desc = "计时器文本的描边样式.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_timer_text_outline,
                    dropdownFunc = outlineOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_shadow_color",
                    label = "阴影颜色",
                    desc = "计时器文本背后的投影颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_timer_text_shadow_color,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_color",
                    label = "颜色",
                    desc = "计时器文本颜色.",
                    widget = "color",
                    default = Plater.db.profile.aura_timer_text_color,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_anchor.side",
                    label = "锚点",
                    desc = "计时器附着在增益图标的哪一侧.",
                    widget = "dropdown",
                    default = Plater.db.profile.aura_timer_text_anchor.side,
                    dropdownFunc = anchorSideOptions,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_anchor.x",
                    label = "水平偏移",
                    desc = "计时器文本的水平偏移.",
                    widget = "slider",
                    minvalue = -20, maxvalue = 20, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_timer_text_anchor.x,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
                {
                    key = "aura_timer_text_anchor.y",
                    label = "垂直偏移",
                    desc = "计时器文本的垂直偏移.",
                    widget = "slider",
                    minvalue = -20, maxvalue = 20, step = 1, usedecimals = true,
                    default = Plater.db.profile.aura_timer_text_anchor.y,
                    setter = function(auras, value) updateAllPlatesOnly() end,
                },
            }
        end)(),

        --indicator icons (pet, execute range, world boss, class/spec/faction, etc.). copied
        --from the options panel "General Settings" indicators section (Plater_OptionsPanel.lua).
        --settings are global, so they read and write at profile root.
        Indicators = (function()
            local updatePlates = function()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            --execute range toggles also need the cutoff value recomputed.
            local updateExecuteRange = function()
                Plater.GetHealthCutoffValue()
                Plater.UpdateAllPlates()
                designer.UpdateAllNameplates()
            end
            local anchorSideOptions = function()
                return {
                    {value = 1, label = "左上"},
                    {value = 2, label = "左"},
                    {value = 3, label = "左下"},
                    {value = 4, label = "下"},
                    {value = 5, label = "右下"},
                    {value = 6, label = "右"},
                    {value = 7, label = "右上"},
                    {value = 8, label = "上"},
                    {value = 9, label = "居中"},
                    {value = 10, label = "内部左侧"},
                    {value = 11, label = "内部右侧"},
                    {value = 12, label = "内部顶部"},
                    {value = 13, label = "内部底部"},
                }
            end

            --hover preview helpers. onEnter shows the hovered indicator's icon on the preview,
            --onLeave reverts to the default (elite). the string is the indicator type that
            --Plater.AddIndicator uses. only icon-type indicators get a hover (shield/execute
            --range are not icons, so they are left without a hover preview).
            local showIndicatorOnEnter = function(indicatorType)
                return function() designer.SetIndicatorPreview(indicatorType) end
            end
            local revertIndicatorOnLeave = function()
                designer.SetIndicatorPreview("elite")
            end

            --re-anchor and re-scale the preview indicator so the anchor/scale sliders move it
            --live, then push the change to the nameplates.
            local reanchorIndicator = function()
                local previewPlate = designer.plateFrame
                if (previewPlate and previewPlate.unitFrame) then
                    local selector = previewPlate.unitFrame.healthBar.dummyIndicators
                    if (selector) then
                        Plater.SetAnchor(selector, Plater.db.profile.indicator_anchor)
                        selector:SetScale(Plater.db.profile.indicator_scale)
                    end
                end
                updatePlates()
            end

            return {
                {
                    key = "indicator_pet",
                    label = "宠物图标",
                    desc = "宠物图标",
                    onenter = showIndicatorOnEnter("pet"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_pet,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_shield",
                    label = "护盾条",
                    desc = "护盾条",
                    widget = "toggle",
                    default = Plater.db.profile.indicator_shield,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "health_cutoff",
                    label = "斩杀范围",
                    desc = "当目标单位处于'斩杀'范围内时显示指示器.",
                    widget = "toggle",
                    default = Plater.db.profile.health_cutoff,
                    setter = function(indicators, value) updateExecuteRange() end,
                },
                {
                    key = "health_cutoff_upper",
                    label = "斩杀范围(高治疗)",
                    desc = "为高血量部分显示斩杀指示器.",
                    widget = "toggle",
                    default = Plater.db.profile.health_cutoff_upper,
                    setter = function(indicators, value) updateExecuteRange() end,
                },
                {
                    key = "health_cutoff_extra_glow",
                    label = "为斩杀范围添加额外发光",
                    desc = "为斩杀范围添加额外发光",
                    widget = "toggle",
                    default = Plater.db.profile.health_cutoff_extra_glow,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_worldboss",
                    label = "世界首领图标",
                    desc = "世界首领图标",
                    onenter = showIndicatorOnEnter("worldboss"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_worldboss,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_elite",
                    label = "精英图标",
                    desc = "精英图标",
                    onenter = showIndicatorOnEnter("elite"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_elite,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_rare",
                    label = "稀有图标",
                    desc = "稀有图标",
                    onenter = showIndicatorOnEnter("rare"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_rare,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_quest",
                    label = "任务图标",
                    desc = "任务图标",
                    onenter = showIndicatorOnEnter("quest"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_quest,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_faction",
                    label = "敌对阵营图标",
                    desc = "敌对阵营图标",
                    onenter = showIndicatorOnEnter("Horde"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_faction,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_enemyclass",
                    label = "敌对职业图标",
                    desc = "敌对职业图标",
                    onenter = showIndicatorOnEnter("classicon"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_enemyclass,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_spec",
                    label = "敌对专精图标",
                    desc = "敌对专精图标",
                    onenter = showIndicatorOnEnter("specicon"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_spec,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_friendlyfaction",
                    label = "友方阵营图标",
                    desc = "友方阵营图标",
                    onenter = showIndicatorOnEnter("Alliance"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_friendlyfaction,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_friendlyclass",
                    label = "友方职业",
                    desc = "友方职业",
                    onenter = showIndicatorOnEnter("classicon"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_friendlyclass,
                    setter = function(indicators, value) updatePlates() end,
                },
                {
                    key = "indicator_friendlyspec",
                    label = "友方专精图标",
                    desc = "友方专精图标",
                    onenter = showIndicatorOnEnter("specicon"),
                    onleave = revertIndicatorOnLeave,
                    widget = "toggle",
                    default = Plater.db.profile.indicator_friendlyspec,
                    setter = function(indicators, value) updatePlates() end,
                },

                {type = "blank"},

                {
                    key = "indicator_scale",
                    label = "缩放",
                    desc = "缩放",
                    widget = "slider",
                    minvalue = 0.2, maxvalue = 3, step = 0.01, usedecimals = true,
                    default = Plater.db.profile.indicator_scale,
                    setter = function(indicators, value) reanchorIndicator() end,
                },
                {
                    key = "indicator_anchor.side",
                    label = "锚点",
                    desc = "此控件附着在哪一侧.",
                    widget = "dropdown",
                    default = Plater.db.profile.indicator_anchor.side,
                    dropdownFunc = anchorSideOptions,
                    setter = function(indicators, value) reanchorIndicator() end,
                },
                {
                    key = "indicator_anchor.x",
                    label = "水平偏移",
                    desc = "水平移动.",
                    widget = "slider",
                    minvalue = -100, maxvalue = 100, step = 1, usedecimals = true,
                    default = Plater.db.profile.indicator_anchor.x,
                    setter = function(indicators, value) reanchorIndicator() end,
                },
                {
                    key = "indicator_anchor.y",
                    label = "垂直偏移",
                    desc = "垂直移动.",
                    widget = "slider",
                    minvalue = -100, maxvalue = 100, step = 1, usedecimals = true,
                    default = Plater.db.profile.indicator_anchor.y,
                    setter = function(indicators, value) reanchorIndicator() end,
                },

                {type = "blank"},

                {
                    key = "health_cutoff_alpha",
                    label = "斩杀透明度",
                    desc = "斩杀透明度",
                    widget = "slider",
                    minvalue = 0, maxvalue = 1, step = 0.01, usedecimals = true,
                    default = Plater.db.profile.health_cutoff_alpha,
                    setter = function(indicators, value)
                        Plater.RefreshDBUpvalues()
                        Plater.GetHealthCutoffValue()
                        designer.UpdateAllNameplates()
                    end,
                },
            }
        end)(),

        Target = {
            --target overlay (acts on the same texture HealthBar's "Target Overlay" exposes; included here per parity with the Plater options panel)
            {
                key = "health_selection_overlay",
                label = "目标覆盖",
                widget = "selectstatusbartexture",
                default = Plater.db.profile.health_selection_overlay,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "health_selection_overlay_alpha",
                label = "目标覆盖透明度",
                widget = "slider",
                minvalue = 0, maxvalue = 1, step = 0.1, usedecimals = true,
                default = Plater.db.profile.health_selection_overlay_alpha,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "health_selection_overlay_color",
                label = "目标覆盖颜色",
                widget = "color",
                default = Plater.db.profile.health_selection_overlay_color,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},

            --target highlight (rectangle that appears around the current target)
            {
                key = "target_highlight",
                label = "目标高亮",
                widget = "toggle",
                default = Plater.db.profile.target_highlight,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "target_highlight_texture",
                label = "高亮材质",
                widget = "dropdown",
                default = Plater.db.profile.target_highlight_texture,
                dropdownFunc = function()
                    local opts = {}
                    for index, texturePath in ipairs(Plater.TargetHighlights) do
                        opts[#opts + 1] = {value = texturePath, label = "高亮" .. index, centerTexture = texturePath}
                    end
                    return opts
                end,
                setter = function(target, value)
                    if target.NeonUp then target.NeonUp:SetTexture(value) end
                    if target.NeonDown then target.NeonDown:SetTexture(value) end
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "target_highlight_alpha",
                label = "高亮透明度",
                widget = "slider",
                minvalue = 0, maxvalue = 1, step = 0.1, usedecimals = true,
                default = Plater.db.profile.target_highlight_alpha,
                setter = function(target, value)
                    if target.NeonUp then target.NeonUp:SetAlpha(value) end
                    if target.NeonDown then target.NeonDown:SetAlpha(value) end
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "target_highlight_height",
                label = "高亮尺寸",
                widget = "slider",
                minvalue = 2, maxvalue = 60, step = 1,
                default = Plater.db.profile.target_highlight_height,
                setter = function(target, value)
                    if target.NeonUp then target.NeonUp:SetHeight(value) end
                    if target.NeonDown then target.NeonDown:SetHeight(value) end
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "target_highlight_color",
                label = "高亮颜色",
                widget = "color",
                default = Plater.db.profile.target_highlight_color,
                setter = function(target, color)
                    local r, g, b, a = unpack(color)
                    if target.NeonUp then target.NeonUp:SetVertexColor(r, g, b, a) end
                    if target.NeonDown then target.NeonDown:SetVertexColor(r, g, b, a) end
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            --bracket indicator on the sides of the target's health bar
            {
                key = "target_indicator",
                label = "目标边框指示器",
                widget = "dropdown",
                default = Plater.db.profile.target_indicator,
                dropdownFunc = function()
                    local opts = {}
                    --each preset carries a texture path plus a coords table (one set per corner).
                    --pass the first corner as the option icon so the dropdown shows a preview.
                    for name, indicatorTable in pairs(Plater.TargetIndicators) do
                        opts[#opts + 1] = {
                            value = name,
                            label = name,
                            icon = indicatorTable.path,
                            texcoord = indicatorTable.coords[1],
                        }
                    end
                    return opts
                end,
                setter = function(target, value)
                    --redraw the brackets on the preview plate so the pick shows right away
                    Plater.UpdateTargetIndicator(designer.plateFrame)
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},

            --target shading (dims non-target plates)
            {
                key = "target_shady_enabled",
                label = "目标着色",
                widget = "toggle",
                default = Plater.db.profile.target_shady_enabled,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "target_shady_combat_only",
                label = "仅战斗中目标着色",
                widget = "toggle",
                default = Plater.db.profile.target_shady_combat_only,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "target_shady_alpha",
                label = "目标着色程度",
                widget = "slider",
                minvalue = 0, maxvalue = 1, step = 0.1, usedecimals = true,
                default = Plater.db.profile.target_shady_alpha,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },

            {type = "blank"},
            {type = "label", get = function() return "鼠标悬停:" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            --the preview's hover highlight texture lives on healthBar (target.HoverHighlight where
            --target is the dummyTarget bar). its visibility is driven by the moveUpFrame OnUpdate
            --in Plater_Designer.lua; this setter only updates the alpha so a slider drag is live.
            {
                key = "hover_highlight",
                label = "悬停高亮",
                widget = "toggle",
                default = Plater.db.profile.hover_highlight,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "hover_highlight_alpha",
                label = "悬停高亮透明度",
                widget = "slider",
                minvalue = 0, maxvalue = 1, step = 0.1, usedecimals = true,
                default = Plater.db.profile.hover_highlight_alpha,
                setter = function(target, value)
                    target.HoverHighlight:SetAlpha(value)
                    designer.UpdateAllNameplates()
                end,
            },

            {type = "blank"},
            {type = "label", get = function() return "CVars:" end, text_template = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")},

            --CVar-backed extras. profileTable points at the in-memory cvarMirror declared at the
            --top of CreateSettings since the editor needs a non-nil profile-style value to render.
            --setters call SetCVar and mirror the value back. nocombat behavior is handled inline.
            {
                key = "nameplateTargetRadialPosition",
                label = "始终显示在屏幕上",
                widget = "toggle",
                profileTable = cvarMirror,
                default = cvarMirror.nameplateTargetRadialPosition,
                setter = function(target, value)
                    if (InCombatLockdown()) then
                        Plater:Msg(L["OPTIONS_ERROR_CVARMODIFY"])
                        return
                    end
                    SetCVar("clampTargetNameplateToScreen", value and "1" or "0")
                    SetCVar("nameplateTargetRadialPosition", value and "1" or "0")
                end,
            },
            {
                key = "nameplateTargetBehindMaxDistance",
                label = "身后目标最大距离",
                widget = "slider",
                minvalue = 5, maxvalue = 50, step = 1,
                profileTable = cvarMirror,
                default = cvarMirror.nameplateTargetBehindMaxDistance,
                setter = function(target, value)
                    if (InCombatLockdown()) then
                        Plater:Msg(L["OPTIONS_ERROR_CVARMODIFY"])
                        return
                    end
                    SetCVar("nameplateTargetBehindMaxDistance", value)
                end,
            },
            {
                key = "nameplateSelectedScale",
                label = "目标缩放",
                widget = "slider",
                minvalue = 0.75, maxvalue = 1.75, step = 0.1, usedecimals = true,
                profileTable = cvarMirror,
                default = cvarMirror.nameplateSelectedScale,
                setter = function(target, value)
                    if (InCombatLockdown()) then
                        Plater:Msg(L["OPTIONS_ERROR_CVARMODIFY"])
                        return
                    end
                    SetCVar("nameplateSelectedScale", value)
                end,
            },
        },

        Focus = {
            {
                key = "focus_indicator_enabled",
                label = "显示焦点叠加层",
                widget = "toggle",
                default = Plater.db.profile.focus_indicator_enabled,
                setter = function(target, value)
                    --turning the toggle off while the focus is still on a unit leaves the
                    --texture shown until the next target sweep, so clear it explicitly.
                    if (not value) then
                        Plater.HideFocusIndicator()
                    end
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "focus_color",
                label = "焦点颜色",
                widget = "color",
                default = Plater.db.profile.focus_color,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "focus_texture",
                label = "焦点材质",
                widget = "selectstatusbartexture",
                default = Plater.db.profile.focus_texture,
                setter = function(target, value) designer.UpdateAllNameplates() end,
            },
        },

        --anchor/offset extras are intentionally omitted - they're driven by the built-in
        --anchor/anchoroffsetx/anchoroffsety attributes from RaidMark's map.
        RaidMark = {
            {
                key = "indicator_raidmark_scale",
                label = "缩放",
                widget = "slider",
                minvalue = 0.2, maxvalue = 2, step = 0.1, usedecimals = true,
                default = Plater.db.profile.indicator_raidmark_scale,
                setter = function(raidMark, value)
                    raidMark:SetScale(value)
                    designer.UpdateAllNameplates()
                end,
            },
            {
                key = "indicator_extra_raidmark",
                label = "额外团队标记",
                widget = "toggle",
                default = Plater.db.profile.indicator_extra_raidmark,
                setter = function(raidMark, value) designer.UpdateAllNameplates() end,
            },
        },

        LifePercent = {
            { --enabled
                key = "percent_text_enabled", --the name of the option in the profile table
                label = "启用",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {--out oc combat
                key = "percent_text_ooc", --the name of the option in the profile table
                label = "显示脱离战斗状态",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {--show percent
                key = "percent_show_percent", --the name of the option in the profile table
                label = "显示百分比",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {--show decimals
                key = "percent_text_show_decimals", --the name of the option in the profile table
                label = "显示小数位",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {--show health value
                key = "percent_show_health", --the name of the option in the profile table
                label = "显示生命值",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },


        --[[
        UnitName = {
            {
                key = "layer",
                label = "层",
                widget = "slider",
                setter = function(widget, value) value = math.floor(value); designer.UpdateAllNameplates() end,
                minvalue = 1,
                maxvalue = 5,
            },
            {
                key = "classcolor", --the name of the option in the profile table
                label = "使用职业颜色",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
            {
                key = "name_attach_to_role_icon",
                label = "吸附至职责图标",
                widget = "toggle",
                setter = function(widget, value) designer.UpdateAllNameplates() end,
            },
        },
        --]]
    }

end