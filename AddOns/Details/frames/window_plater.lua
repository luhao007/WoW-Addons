

local Details = _G.Details
local DF = _G.DetailsFramework

function Details:InitializePlaterIntegrationWindow()
    local DetailsPlaterIntegrationPanel = DF:CreateSimplePanel(UIParent, 700, 480, "Details! 姓名版整合", "DetailsPlaterIntegrationPanel")
    DetailsPlaterIntegrationPanel.Frame = DetailsPlaterIntegrationPanel
    DetailsPlaterIntegrationPanel.__name = "Plater Nameplates"
    DetailsPlaterIntegrationPanel.real_name = "DETAILS_PLATERWINDOW"
    DetailsPlaterIntegrationPanel.__icon = [[Interface\AddOns\Details\images\plater_icon]]
    DetailsPlaterIntegrationPanel.__iconcoords = {0, 1, 0, 1}
    DetailsPlaterIntegrationPanel.__iconcolor = "white"
    DetailsPluginContainerWindow.EmbedPlugin (DetailsPlaterIntegrationPanel, DetailsPlaterIntegrationPanel, true)

    function DetailsPlaterIntegrationPanel.RefreshWindow()
        Details.OpenPlaterIntegrationWindow()
    end

    DetailsPlaterIntegrationPanel:Hide()
end

function Details.OpenPlaterIntegrationWindow()
    if (not DetailsPlaterIntegrationPanel or not DetailsPlaterIntegrationPanel.Initialized) then
        
        DetailsPlaterIntegrationPanel.Initialized = true
        
        local f = DetailsPlaterIntegrationPanel or DF:CreateSimplePanel(UIParent, 700, 480, "Details! 姓名版整合", "DetailsPlaterIntegrationPanel")
        
        --background
        f.bg1 = f:CreateTexture(nil, "background")
        f.bg1:SetTexture([[Interface\AddOns\Details\images\background]], true)
        f.bg1:SetAlpha(0.8)
        f.bg1:SetVertexColor(0.27, 0.27, 0.27)
        f.bg1:SetVertTile(true)
        f.bg1:SetHorizTile(true)
        f.bg1:SetSize(790, 454)
        f.bg1:SetAllPoints()
        f:SetBackdrop({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\AddOns\Details\images\background]], tileSize = 64, tile = true})
        f:SetBackdropColor(.5, .5, .5, .7)
        f:SetBackdropBorderColor(0, 0, 0, 1)

        --anchor text function
        local anchor_names = {"Top Left", "Left", "Bottom Left", "Bottom", "Bottom Right", "Right", "Top Right", "Top", "Center", "Inner Left", "Inner Right", "Inner Top", "Inner Bottom"}
        local build_anchor_side_table = function(member)
            local t = {}
            for i = 1, 13 do
                table.insert(t, {
                    label = anchor_names[i],
                    value = i,
                    onclick = function(_, _, value)
                        Details.plater [member].side = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end
                })
            end
            return t
        end				
        
        local menu_table = {
        
            {type = "label", get = function() return "在姓名版中添加实时DPS信息:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
        
            --real time dps from all sources
            {
                type = "toggle",
                get = function() return Details.plater.realtime_dps_enabled end,
                set = function(self, fixedparam, value) 
                    Details.plater.realtime_dps_enabled = value
                    
                    Details:RefreshPlaterIntegration()
                    
                    if (not value) then
                        Details:Msg("可能需要/reload来禁用这个设置.")
                    else
                        if (Plater) then
                            Plater.RefreshDBUpvalues()
                        end
                    end
                end,
                name = "显示实时Dps",
                desc = "在姓名版显示实时DPS.\n\n实时DPS是指过去5秒内对单位造成的伤害.",
            },
                --text size
                {
                    type = "range",
                    get = function() return Details.plater.realtime_dps_size end,
                    set = function(self, fixedparam, value) 
                        Details.plater.realtime_dps_size = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    min = 6,
                    max = 32,
                    step = 1,
                    name = "文字大小",
                    desc = "文字大小",
                },
                --text color
                {
                    type = "color",
                    get = function() 
                        local color = Details.plater.realtime_dps_color
                        return {color [1], color [2], color [3], color [4]}
                    end,
                    set = function(self, r, g, b, a) 
                        local color = Details.plater.realtime_dps_color
                        color[1], color[2], color[3], color[4] = r, g, b, a
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    desc = "文字颜色",
                    name = "文字颜色",
                    text_template = options_text_template,
                },
                --text shadow
                {
                    type = "toggle",
                    get = function() return Details.plater.realtime_dps_shadow end,
                    set = function(self, fixedparam, value) 
                        Details.plater.realtime_dps_shadow = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    name = "文字阴影",
                    desc = "文字阴影",
                },
                --text anchor
                    --anchor location
                    {
                        type = "select",
                        get = function() return Details.plater.realtime_dps_anchor.side end,
                        values = function() return build_anchor_side_table ("realtime_dps_anchor") end,
                        name = "锚点",
                        desc = "文字贴在姓名版的哪一面.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.realtime_dps_anchor.x end,
                        set = function(self, fixedparam, value) 
                            Details.plater.realtime_dps_anchor.x = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点X偏移",
                        desc = "稍微水平移动文本.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.realtime_dps_anchor.y end,
                        set = function(self, fixedparam, value) 
                            Details.plater.realtime_dps_anchor.y = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点Y偏移",
                        desc = "稍微垂直移动文字.",
                    },	
            
            {type = "breakline"},
            {type = "label", get = function() return "在姓名版中添加仅来自你的实时DPS信息:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
            
            --real time dps from the player only
            {
                type = "toggle",
                get = function() return Details.plater.realtime_dps_player_enabled end,
                set = function(self, fixedparam, value) 
                    Details.plater.realtime_dps_player_enabled = value
                    
                    Details:RefreshPlaterIntegration()
                    
                    if (not value) then
                        Details:Msg("可能需要/reload来禁用这个设置.")
                    else
                        if (Plater) then
                            Plater.RefreshDBUpvalues()
                        end
                    end
                end,
                name = "显示实时Dps (来自你)",
                desc = "显示你目前在单位中的实时DPS.\n\n实时DPS是指过去5秒内对单位造成的伤害.",
            },
                --text size
                {
                    type = "range",
                    get = function() return Details.plater.realtime_dps_player_size end,
                    set = function(self, fixedparam, value) 
                        Details.plater.realtime_dps_player_size = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    min = 6,
                    max = 32,
                    step = 1,
                    name = "文字大小",
                    desc = "文字大小",
                },
                --text color
                {
                    type = "color",
                    get = function() 
                        local color = Details.plater.realtime_dps_player_color
                        return {color [1], color [2], color [3], color [4]}
                    end,
                    set = function(self, r, g, b, a) 
                        local color = Details.plater.realtime_dps_player_color
                        color[1], color[2], color[3], color[4] = r, g, b, a
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    desc = "文字颜色",
                    name = "文字颜色",
                    text_template = options_text_template,
                },
                --text shadow
                {
                    type = "toggle",
                    get = function() return Details.plater.realtime_dps_player_shadow end,
                    set = function(self, fixedparam, value) 
                        Details.plater.realtime_dps_player_shadow = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    name = "文字阴影",
                    desc = "文字阴影",
                },
                --text anchor
                    --anchor location
                    {
                        type = "select",
                        get = function() return Details.plater.realtime_dps_player_anchor.side end,
                        values = function() return build_anchor_side_table ("realtime_dps_player_anchor") end,
                        name = "锚点",
                        desc = "文字贴在姓名版的哪一面.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.realtime_dps_player_anchor.x end,
                        set = function(self, fixedparam, value) 
                            Details.plater.realtime_dps_player_anchor.x = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点X偏移",
                        desc = "稍微水平移动文本.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.realtime_dps_player_anchor.y end,
                        set = function(self, fixedparam, value) 
                            Details.plater.realtime_dps_player_anchor.y = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点Y偏移",
                        desc = "稍微垂直移动文字.",
                    },	
            
            {type = "breakline"},
            {type = "label", get = function() return "在姓名版中添加收到总伤害:" end, text_template = DF:GetTemplate ("font", "ORANGE_FONT_TEMPLATE")},
            
            --total damage taken from all sources
            {
                type = "toggle",
                get = function() return Details.plater.damage_taken_enabled end,
                set = function(self, fixedparam, value) 
                    Details.plater.damage_taken_enabled = value
                    
                    Details:RefreshPlaterIntegration()
                    
                    if (not value) then
                        Details:Msg("a /reload might be needed to disable this setting.")
                    else
                        if (Plater) then
                            Plater.RefreshDBUpvalues()
                        end
                    end
                end,
                name = "显示受到的总伤害",
                desc = "显示该单位受到的总伤害",
            },
                --text size
                {
                    type = "range",
                    get = function() return Details.plater.damage_taken_size end,
                    set = function(self, fixedparam, value) 
                        Details.plater.damage_taken_size = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    min = 6,
                    max = 32,
                    step = 1,
                    name = "文字大小",
                    desc = "文字大小",
                },
                --text color
                {
                    type = "color",
                    get = function() 
                        local color = Details.plater.damage_taken_color
                        return {color [1], color [2], color [3], color [4]}
                    end,
                    set = function(self, r, g, b, a) 
                        local color = Details.plater.damage_taken_color
                        color[1], color[2], color[3], color[4] = r, g, b, a
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    desc = "文字颜色",
                    name = "文字颜色",
                    text_template = options_text_template,
                },
                --text shadow
                {
                    type = "toggle",
                    get = function() return Details.plater.damage_taken_shadow end,
                    set = function(self, fixedparam, value) 
                        Details.plater.damage_taken_shadow = value
                        if (Plater) then
                            Plater.UpdateAllPlates()
                        end
                    end,
                    name = "文字阴影",
                    desc = "文字阴影",
                },
                --text anchor
                    --anchor location
                    {
                        type = "select",
                        get = function() return Details.plater.damage_taken_anchor.side end,
                        values = function() return build_anchor_side_table ("damage_taken_anchor") end,
                        name = "锚点",
                        desc = "文字贴在姓名版的哪一面.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.damage_taken_anchor.x end,
                        set = function(self, fixedparam, value) 
                            Details.plater.damage_taken_anchor.x = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点X偏移",
                        desc = "稍微水平移动文本.",
                    },
                    --anchor x offset
                    {
                        type = "range",
                        get = function() return Details.plater.damage_taken_anchor.y end,
                        set = function(self, fixedparam, value) 
                            Details.plater.damage_taken_anchor.y = value
                            if (Plater) then
                                Plater.UpdateAllPlates()
                            end
                        end,
                        min = -20,
                        max = 20,
                        step = 1,
                        name = "锚点Y偏移",
                        desc = "稍微垂直移动文字.",
                    },
        }
        
        local options_text_template = DF:GetTemplate("font", "OPTIONS_FONT_TEMPLATE")
        local options_dropdown_template = DF:GetTemplate("dropdown", "OPTIONS_DROPDOWN_TEMPLATE")
        local options_switch_template = DF:GetTemplate("switch", "OPTIONS_CHECKBOX_TEMPLATE")
        local options_slider_template = DF:GetTemplate("slider", "OPTIONS_SLIDER_TEMPLATE")
        local options_button_template = DF:GetTemplate("button", "OPTIONS_BUTTON_TEMPLATE")
        
        local titleBackground = CreateFrame("frame", nil, f,"BackdropTemplate")
        titleBackground:SetPoint("topleft", f, "topleft", 10, -30)
        titleBackground:SetPoint("topright", f, "topright", -10, -30)
        titleBackground:SetHeight(80)
        
        --background
        titleBackground.bg1 = titleBackground:CreateTexture(nil, "background")
        titleBackground.bg1:SetTexture([[Interface\AddOns\Details\images\background]])
        titleBackground.bg1:SetAlpha(0.8)
        titleBackground.bg1:SetVertexColor(0.27, 0.27, 0.27)
        titleBackground.bg1:SetVertTile(true)
        titleBackground.bg1:SetHorizTile(true)
        titleBackground.bg1:SetSize(790, 454)
        titleBackground.bg1:SetAllPoints()
        titleBackground:SetBackdrop({edgeFile = [[Interface\Buttons\WHITE8X8]], edgeSize = 1, bgFile = [[Interface\AddOns\Details\images\background]], tileSize = 64, tile = true})
        titleBackground:SetBackdropColor(.5, .5, .5, .7)
        titleBackground:SetBackdropBorderColor(0, 0, 0, 1)
        
        local platerTitle = DF:CreateLabel(titleBackground, "姓名版整合", 16, "white")
        local platerDesc1 = DF:CreateLabel(titleBackground, "直接在姓名版上添加DPS和伤害信息", 11, "silver")
        local platerDesc2 = DF:CreateLabel(titleBackground, "实时查看敌人受到多少伤害!", 11, "silver")
        local platerImage = DF:CreateImage(titleBackground, "Interface\\AddOns\\Details\\images\\plater_image")
        platerImage:SetSize(256, 64)
        
        platerImage:SetPoint("topright", f, "topright", -150, -35)
        platerTitle:SetPoint(10, -15)
        platerDesc1:SetPoint(10, -35)
        platerDesc2:SetPoint(10, -47)
        
        DF:BuildMenu (f, menu_table, 10, -140, 460, true, options_text_template, options_dropdown_template, options_switch_template, true, options_slider_template, options_button_template)
        
        if (not Plater) then
            for _, widget in ipairs(f.widget_list) do
                if (widget.Disable) then
                    widget:Disable()
                end
            end
            
            local PlaterDisabled1 = DF:CreateLabel(f, "Plater没有安装! 你可以从Curseforge应用程序中下载它.", 16, "red")
            PlaterDisabled1:SetPoint(10, -330)
        end
        
    end
    
    DetailsPluginContainerWindow.OpenPlugin (DetailsPlaterIntegrationPanel)
end