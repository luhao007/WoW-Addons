
local Details = Details
local addonName, Details222 = ...

---@type detailsbreakdownmidnight
local breakdownMidnight = Details222.BreakdownWindowMidnight

---@type detailsframework
local detailsFramework = DetailsFramework

--create the main frame for the options panel

local createOptionsPanel = function()
    local startX = 5
    local startY = -32
    local heightSize = 540

    --local DetailsSpellBreakdownTab = DetailsSpellBreakdownTab
    local UIParent = UIParent

    local options_text_template = detailsFramework:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
    local options_dropdown_template = detailsFramework:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
    local options_switch_template = detailsFramework:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
    local options_slider_template = detailsFramework:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
    local options_button_template = detailsFramework:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")

    local optionsFrame = detailsFramework:CreateSimplePanel(UIParent, 550, 500, "Details! Breakdown Options", "DetailsMidnightBreakdownOptionsPanel")
    optionsFrame:SetFrameStrata("DIALOG")
    optionsFrame:SetPoint("topleft", UIParent, "topleft", 2, -40)
    optionsFrame.Title:SetParent(optionsFrame)
    optionsFrame.TitleBar:Hide()
    optionsFrame:Show()

    --remove the backdrop
    optionsFrame:SetBackdrop(nil)

    --apply rounded corners with the breakdown window preset
    detailsFramework:AddRoundedCornersToFrame(optionsFrame, Details.PlayerBreakdown.RoundedCornerPreset)

    local closeButton = detailsFramework:CreateCloseButton(optionsFrame, "$parentTopRightCloseButton")
    closeButton:SetPoint("topright", optionsFrame, "topright", -5, -5)

    Details:RefreshWindowColor()

    local refreshAllWindows = function()
        for i = 1, #breakdownMidnight.GetBreakdownWindows() do
            if breakdownMidnight.IsOpen(i) then
                breakdownMidnight.RefreshApocalypseBreakdown(i)
            end
        end
    end

    local updateTextSettings = function()
        breakdownMidnight.ApplyLineTextSettingsToAllLines()
        refreshAllWindows()
    end

    local resetSettings = function()
        --overwrite the settings for the spell frame
        for key, value in pairs (Details.default_global_data.breakdown_spell_tab) do
            if (type(value) == "table") then
                local t = detailsFramework.table.copy({}, value)
                Details.breakdown_spell_tab[key] = t
            else
                Details.breakdown_spell_tab[key] = value
            end
        end

        --overwrite the settings for the general frame
        for key, value in pairs (Details.default_global_data.breakdown_general) do
            if (type(value) == "table") then
                local t = detailsFramework.table.copy({}, value)
                Details.breakdown_general[key] = t
            else
                Details.breakdown_general[key] = value
            end
        end

        --force refresh the breakdown window to apply the new settings
        DetailsMidnightBreakdownOptionsPanel:RefreshOptions()
        updateTextSettings()

        Details:Msg("Settings reseted to default.")
    end

    local resetSettingsButton = detailsFramework:CreateButton(optionsFrame, resetSettings, 130, 20, "重置设置")
    resetSettingsButton:SetPoint("bottomleft", optionsFrame, "bottomleft", 5, 5)
    resetSettingsButton:SetTemplate(options_button_template)

    local subSectionTitleTextTemplate = detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE")

    local optionsTable = {
        {type = "label", get = function() return "窗口设置" end, text_template = subSectionTitleTextTemplate},
        --background color from setting Details.frame_background_color
            { --background color
                type = "color",
                get = function()
                        local colorTable = Details.frame_background_color
                        return colorTable[1], colorTable[2], colorTable[3], colorTable[4]
                    end,
                set = function(self, r, g, b, a)
                    local colorTable = Details.frame_background_color

                    --/run Details.frame_background_color = {0.1215, 0.1176, 0.1294, 0.934}

                    r = math.min(r, 0.1215)
                    g = math.min(g, 0.1176)
                    b = math.min(b, 0.1294)
                    a = math.min(a, 0.934)

                    colorTable[1] = r
                    colorTable[2] = g
                    colorTable[3] = b
                    colorTable[4] = a
                    Details:SetWindowColor(r, g, b, a)
                end,
                name = "背景颜色",
                desc = "背景颜色",
            },

        {type = "blank"},

        {type = "label", get = function() return "文本选项" end, text_template = subSectionTitleTextTemplate},
            { --font color
                type = "color",
                get = function() return Details.breakdown_general.font_color[1], Details.breakdown_general.font_color[2], Details.breakdown_general.font_color[3], Details.breakdown_general.font_color[4] end,
                set = function(self, r, g, b, a)
                    local colorTable = Details.breakdown_general.font_color
                    colorTable[1] = r
                    colorTable[2] = g
                    colorTable[3] = b
                    colorTable[4] = a
                    updateTextSettings()
                end,
                name = "文本颜色",
                desc = "文本颜色",
            },

            { --font size
                type = "range",
                get = function() return Details.breakdown_general.font_size end,
                set = function(self, fixedparam, value)
                    Details.breakdown_general.font_size = value
                    updateTextSettings()
                end,
                min = 8,
                max = 20,
                step = 1,
                name = "文本大小",
                desc = "文本大小",
            },

            { --font outline
                type = "outlinedropdown",
                get = function() return Details.breakdown_general.font_outline end,
                set = function(self, fixedparam, value)
                    Details.breakdown_general.font_outline = value
                    updateTextSettings()
                end,
                name = "文字描边",
                desc = "文字描边",
            },

            {---font face
                type = "fontdropdown",
                get = function() return Details.breakdown_general.font_face end,
                set = function(self, fixedparam, value)
                    Details.breakdown_general.font_face = value
                    updateTextSettings()
                end,
                name = "字体",
                desc = "字体",
                include_default = true,
            },


        {type = "breakline"},
        {type = "label", get = function() return "部分设置" end, text_template = subSectionTitleTextTemplate},

            { --locked -hidden = true,
                type = "toggle",
                get = function() return Details.breakdown_spell_tab.spellcontainer_islocked end,
                set = function(self, fixedparam, value)
                    ---@type df_framecontainer
                    local container = DetailsSpellBreakdownTab.GetSpellScrollContainer()
                    container:SetResizeLocked(value)

                    local container = DetailsSpellBreakdownTab.GetTargetScrollContainer()
                    container:SetResizeLocked(value)
                end,
                name = "已锁定",
                desc = "已锁定",
                hidden = true,
            },

            {--section background color
                type = "color",
                get = function()
                    local colorTable = Details.breakdown_spell_tab.section_background_color
                    return colorTable[1], colorTable[2], colorTable[3], colorTable[4]
                end,
                set = function(self, r, g, b, a)
                    local colorTable = Details.breakdown_spell_tab.section_background_color
                    r = math.min(r, 0.1215)
                    g = math.min(g, 0.1176)
                    b = math.min(b, 0.1294)
                    a = math.min(a, 0.934)

                    colorTable[1] = r
                    colorTable[2] = g
                    colorTable[3] = b
                    colorTable[4] = a

                    refreshAllWindows()
                end,
                min = 0,
                max = 1,
                step = 0.1,
                usedecimals = true,
                name = "背景颜色",
                desc = "背景颜色",
            },

        {type = "blank"},
        {hidden = true, type = "label", get = function() return "玩家技能分组:" end, text_template = subSectionTitleTextTemplate},
            { --nest player spells | merge player spells
                type = "toggle",
                get = function() return Details.breakdown_spell_tab.nest_players_spells_with_same_name end,
                set = function(self, fixedparam, value)
                    Details.breakdown_spell_tab.nest_players_spells_with_same_name = value
                    refreshAllWindows()
                end,
                name = "同名玩家技能分组",
                desc = "将玩家施放的同名技能进行归类",
                hidden = true,
            },

        {type = "blank"},
        {hidden = true, type = "label", get = function() return "宠物技能分组:" end, text_template = subSectionTitleTextTemplate},

            { --nest pet spells with the same name
                type = "toggle",
                get = function() return Details.breakdown_spell_tab.nest_pet_spells_by_name end,
                set = function(self, fixedparam, value)
                    Details.breakdown_spell_tab.nest_pet_spells_by_name = value
                end,
                name = "在宠物技能条下合并同名宠物",
                desc = "按名称分组宠物",
                hooks = {["OnSwitch"] = function()
                        if (Details.breakdown_spell_tab.nest_pet_spells_by_name) then
                            Details.breakdown_spell_tab.nest_pet_spells_by_caster = false
                            DetailsMidnightBreakdownOptionsPanel:RefreshOptions()
                        end
                    end,
                },
                hidden = true,
            },

            { --nest pet spells with the same name
                type = "toggle",
                get = function() return Details.breakdown_spell_tab.nest_pet_spells_by_caster end,
                set = function(self, fixedparam, value)
                    Details.breakdown_spell_tab.nest_pet_spells_by_caster = value

                end,
                name = "在宠物名称条下合并同名技能",
                desc = "按技能分组宠物",
                hooks = {["OnSwitch"] = function()
                        if (Details.breakdown_spell_tab.nest_pet_spells_by_caster) then
                            Details.breakdown_spell_tab.nest_pet_spells_by_name = false
                            DetailsMidnightBreakdownOptionsPanel:RefreshOptions()
                        end
                    end,
                },
                hidden = true,
            },
    }

    --build the menu
    optionsTable.always_boxfirst = true
    detailsFramework:BuildMenu(optionsFrame, optionsTable, startX, startY, heightSize, false, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)
end


function breakdownMidnight.OpenOptions()
    if (DetailsMidnightBreakdownOptionsPanel) then
        DetailsMidnightBreakdownOptionsPanel:RefreshOptions()
        DetailsMidnightBreakdownOptionsPanel:Show()
        return
    end

    createOptionsPanel()
end
