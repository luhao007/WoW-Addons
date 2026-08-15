
local addonId, platerInternal = ...
local Plater = Plater
---@type detailsframework
local DF = DetailsFramework
local _

--font select
local on_select_blizzard_nameplate_font = function (_, _, value)
    Plater.db.profile.blizzard_nameplate_font = value
end

local on_select_blizzard_nameplate_large_font = function (_, _, value)
    Plater.db.profile.blizzard_nameplate_large_font = value
end

function platerInternal.CreateBossModOptions()
	if platerInternal.LoadOnDemand_IsLoaded.BossModOptions then return end -- already loaded
	
    --templates
    local options_text_template = DF:GetTemplate ("font", "OPTIONS_FONT_TEMPLATE")
    local options_dropdown_template = DF:GetTemplate ("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
    local options_switch_template = DF:GetTemplate ("switch", "OPTIONS_CHECKBOX_TEMPLATE")
    local options_slider_template = DF:GetTemplate ("slider", "OPTIONS_SLIDER_TEMPLATE")
    local options_button_template = DF:GetTemplate ("button", "OPTIONS_BUTTON_TEMPLATE")

    ---@diagnostic disable-next-line: undefined-global
    local IS_WOW_PROJECT_MAINLINE = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
    ---@diagnostic disable-next-line: undefined-global
    local IS_WOW_PROJECT_NOT_MAINLINE = WOW_PROJECT_ID ~= WOW_PROJECT_MAINLINE

    local dropdownStatusBarTexture = platerInternal.Defaults.dropdownStatusBarTexture
    local dropdownStatusBarColor = platerInternal.Defaults.dropdownStatusBarColor

    local L = DF.Language.GetLanguageTable(addonId)

	--outline table
	local outline_modes = {"NONE", "MONOCHROME", "OUTLINE", "THICKOUTLINE", "MONOCHROME, OUTLINE", "MONOCHROME, THICKOUTLINE"}
	local outline_modes_names = {"无", "单色", "轮廓", "粗体轮廓", "单色轮廓", "单色粗体轮廓"}
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
					else
						Plater.db.profile [member] = value
						Plater.RefreshDBUpvalues()
						Plater.UpdateAllPlates()
						Plater.UpdateAllNames()
					end
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
	
	-- glow types
	local glow_types = { "Pixel", "Proc", "Ants", "Button"}
	local build_glow_types_table = function (option)
		local glow_types_table = {}

		for index, name in ipairs (glow_types) do
			tinsert (glow_types_table, {
				label = name,
				value = index,
				onclick = function (_, _, value)
					if (option) then
						Plater.db.profile [option] = value
						Plater.UpdateAllPlates()
					end
				end
			})
		end
		return glow_types_table
	end

    local bossmod_options = {
        {type = "label", get = function() return "DBM / BigWigs支持:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},

        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_support_enabled end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_support_enabled = value
                Plater.UpdateAllPlates()
            end,
            name = "OPTIONS_ENABLED",
            desc = "启用BigWigs和DBM的首领模块图标支持.",
        },
        
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_castrename_enabled end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_castrename_enabled = value
                --Plater.UpdateAllPlates()
            end,
            name = "启用首领模块施法技能重命名",
            desc = "根据BigWigs或DBM施法名称启用施法重命名.",
        },
        
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_castrename_priority end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_castrename_priority = value
                --Plater.UpdateAllPlates()
            end,
            name = "优先使用首领模块的施法重命名",
            desc = "优先采用基于BigWigs或DBM技能名称的施法重命名, 而非Plater默认的施法名称.",
        },
        
        {type = "blank"},
        
        {type = "label", get = function() return "全局图标设置:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        
        --width
        {
            type = "range",
            get = function() return Plater.db.profile.bossmod_aura_width end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_aura_width = value
                Plater.UpdateAllPlates()
            end,
            min = 8,
            max = 64,
            step = 1,
            name = "OPTIONS_WIDTH",
            desc = "OPTIONS_WIDTH",
        },
        --height
        {
            type = "range",
            get = function() return Plater.db.profile.bossmod_aura_height end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_aura_height = value
                Plater.UpdateAllPlates()
            end,
            min = 8,
            max = 64,
            step = 1,
            name = "OPTIONS_HEIGHT",
            desc = "OPTIONS_HEIGHT",
        },
        
        --anchor
        {
			type = "select",
            get = function() return Plater.db.profile.bossmod_icons_anchor.side end,
            values = function() return build_anchor_side_table (nil, "bossmod_icons_anchor") end,
            name = "OPTIONS_ANCHOR",
            desc = "图标应依附姓名板的哪一侧.",
        },
        --x offset
        {
            type = "range",
            get = function() return Plater.db.profile.bossmod_icons_anchor.x end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_icons_anchor.x = value
                Plater.UpdateAllPlates()
            end,
            min = -40,
            max = 40,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_XOFFSET",
            desc = "OPTIONS_XOFFSET_DESC",
        },
        --y offset
        {
            type = "range",
            get = function() return Plater.db.profile.bossmod_icons_anchor.y end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_icons_anchor.y = value
                Plater.UpdateAllPlates()
            end,
            min = -60,
            max = 60,
            step = 1,
            usedecimals = true,
            name = "OPTIONS_YOFFSET",
            desc = "OPTIONS_YOFFSET_DESC",
        },
        
        {type = "blank"},
        {type = "label", get = function() return "图标法术名称文本:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        --text enabled
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_support_bars_text_enabled end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_support_bars_text_enabled = value
                Plater.UpdateAllPlates()
            end,
            name = "图标文本已启用",
            desc = "启用条文本(法术名称).",
        },
        
        {type = "blank"},
        
        {type = "label", get = function() return "图标冷却时间文本:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_cooldown_text_enabled end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_cooldown_text_enabled = value
                Plater.UpdateAllPlates()
            end,
            name = "OPTIONS_ENABLED",
            desc = "启用冷却时间文本.",
        },
        --cd text size
        {
            type = "range",
            get = function() return Plater.db.profile.bossmod_cooldown_text_size end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_cooldown_text_size = value
                Plater.RefreshAuras()
                Plater.UpdateAllPlates()
            end,
            min = 6,
            max = 32,
            step = 1,
            name = "OPTIONS_SIZE",
            desc = "尺寸",
        },
        
        {type = "breakline"},
        {type = "label", get = function() return "DBM设置:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_support_bars_enabled end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_support_bars_enabled = value
                Plater.UpdateAllPlates()
            end,
            name = "已启用DBM冷却条图标",
            desc = "启用DBM的首领模块条支持, 以在姓名板上显示计时条图标.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_aura_glow_cooldown end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_aura_glow_cooldown = value
                Plater.UpdateAllPlates()
            end,
            name = "冷却图标发光",
            desc = "启用即将到期的冷却计时器图标发光.",
        },
        {
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_aura_glow_important_only end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_aura_glow_important_only = value
                Plater.UpdateAllPlates()
            end,
            name = "仅在重要冷却技能上启用发光",
            desc = "仅在重要即将到期的计时器图标上启用发光.",
        },
		{
            type = "toggle",
            get = function() return Plater.db.profile.bossmod_aura_glow_casts end,
            set = function (self, fixedparam, value) 
                Plater.db.profile.bossmod_aura_glow_casts = value
                Plater.UpdateAllPlates()
            end,
            name = "施法图标发光",
            desc = "启用即将到期的施法计时器图标发光.",
        },
		{
			type = "select",
			get = function() return Plater.db.profile.bossmod_aura_glow_cooldown_glow_type end,
			values = function() return build_glow_types_table ("bossmod_aura_glow_cooldown_glow_type") end,
			name = "冷却图标发光类型",
            desc = "选择重要即将到期的计时器图标的发光类型.",
		},
		{
			type = "select",
			get = function() return Plater.db.profile.bossmod_aura_glow_casts_glow_type end,
			values = function() return build_glow_types_table ("bossmod_aura_glow_casts_glow_type") end,
			name = "施法图标发光类型",
            desc = "选择即将到期的计时器图标的发光类型.",
		},
    }

    ---@diagnostic disable-next-line: undefined-global
    local bossmodFrame = PlaterOptionsPanelContainerBossModConfig

	--bossmod_options.align_as_pairs = true
	--bossmod_options.align_as_pairs_string_space = 181
	--bossmod_options.widget_width = 150
	--bossmod_options.use_scrollframe = true
    bossmod_options.language_addonId = addonId
    bossmod_options.always_boxfirst = true
    bossmod_options.Name = "Boss-Mods"

    --local canvasFrame = DF:CreateCanvasScrollBox(bossmodFrame, nil, "PlaterOptionsPanelCanvasBossModConfig")
    --canvasFrame:SetPoint("topleft", bossmodFrame, "topleft", 0, platerInternal.optionsYStart)
    --canvasFrame:SetPoint("bottomright", bossmodFrame, "bottomright", -26, 25)
	--bossmodFrame.canvasFrame = canvasFrame

    local startX, startY, heightSize = 10, platerInternal.optionsYStart, 755
    --DF:BuildMenu (canvasFrame, bossmod_options, startX, 0, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template, platerInternal.OptionsGlobalCallback)
    DF:BuildMenu (bossmodFrame, bossmod_options, startX, startY, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template, platerInternal.OptionsGlobalCallback)
    

    platerInternal.LoadOnDemand_IsLoaded.BossModOptions = true
    ---@diagnostic disable-next-line: undefined-global
    table.insert(PlaterOptionsPanelFrame.AllSettingsTable, bossmod_options)
	platerInternal.CreateBossModOptions = function() end
end