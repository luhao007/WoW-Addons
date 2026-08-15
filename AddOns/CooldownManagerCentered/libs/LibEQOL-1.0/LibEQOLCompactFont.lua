local _, ns = ...

local CompactFont = {}
ns.LibEQOL.CompactFont = CompactFont

local GEAR_ATLAS = {
    normal = "common-dropdown-a-button-settings-shadowless",
    hover = "common-dropdown-a-button-settings-hover-shadowless",
    pressed = "common-dropdown-a-button-settings-pressed-shadowless",
    disabled = "common-dropdown-a-button-settings-disabled-shadowless",
}

local function resolve(value)
    if type(value) == "function" then
        return value()
    end
    return value
end

local function optionValue(option)
    if type(option) ~= "table" then
        return option
    end
    return option.value ~= nil and option.value or option.text or option.label
end

local function optionText(option)
    if type(option) ~= "table" then
        return tostring(option)
    end
    return option.text or option.label or tostring(optionValue(option) or "")
end

local function changed(data)
    if data and data.onChanged then
        data.onChanged()
    end
end

local function addRadioMenu(parent, label, options, getValue, setValue, data, height)
    if not (getValue and setValue) then
        return
    end
    options = resolve(options)
    if type(options) ~= "table" then
        return
    end

    local submenu = parent:CreateButton(label)
    if height and submenu.SetScrollMode then
        submenu:SetScrollMode(height)
    end
    for _, option in ipairs(options) do
        local value = optionValue(option)
        local text = optionText(option)
        submenu:CreateRadio(text, function()
            return getValue() == value
        end, function()
            setValue(value)
            changed(data)
        end)
    end
end

local function addFlagsMenu(parent, data)
    if not (data.getFlags and data.setFlags) then
        return
    end
    local options = resolve(data.flagOptions)
    if type(options) ~= "table" then
        return
    end

    local submenu = parent:CreateButton(data.flagsLabel or "Font Flags")
    for _, option in ipairs(options) do
        local value = optionValue(option)
        local text = optionText(option)
        submenu:CreateCheckbox(text, function()
            local selection = data.getFlags() or {}
            return selection[value] == true
        end, function()
            local current = data.getFlags() or {}
            local selection = {}
            for key, selected in pairs(current) do
                selection[key] = selected
            end
            selection[value] = not selection[value]
            data.setFlags(selection)
            changed(data)
        end)
    end
end

local function SetSliderEnabled(frame, enabled)
    if not frame then
        return
    end
    enabled = enabled ~= false
    if frame.SetEnabled then
        frame:SetEnabled(enabled)
    end
    if frame.Slider and frame.Slider.SetEnabled then
        frame.Slider:SetEnabled(enabled)
    end
    if frame.Input and frame.Input.SetEnabled then
        frame.Input:SetEnabled(enabled)
    end
    frame:SetAlpha(enabled and 1 or 0.4)
end

local function addCheckboxMenu(parent, data, checkbox)
    if not (checkbox and checkbox.get and checkbox.set) then
        return
    end

    parent:CreateCheckbox(checkbox.label or "Checkbox", function()
        return checkbox.get() and true or false
    end, function()
        local checked = checkbox.get() and true or false
        checked = not checked
        checkbox.set(checked)
        if checkbox.onChanged then
            checkbox.onChanged(checked)
        else
            changed(data)
        end
        if checkbox.slider and checkbox.slider._frame then
            SetSliderEnabled(checkbox.slider._frame, checked)
        end
    end)
end

LibEQOLCMC_CompactSliderMenuMixin = {}

function LibEQOLCMC_CompactSliderMenuMixin:OnLoad()
    self.Label = self:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    self.Label:SetPoint("LEFT", 8, 0)
    self.Label:SetWidth(16)
    self.Label:SetJustifyH("LEFT")

    self.Slider = CreateFrame("Slider", nil, self, "MinimalSliderTemplate")
    self.Slider:SetPoint("LEFT", self.Label, "RIGHT", 3, 0)
    self.Slider:SetSize(100, 19)

    self.Input = CreateFrame("EditBox", nil, self, "InputBoxTemplate")
    self.Input:SetPoint("LEFT", self.Slider, "RIGHT", 4, 0)
    self.Input:SetSize(32, 20)
    self.Input:SetAutoFocus(false)
    self.Input:SetNumeric(false)
    self.Input:SetMaxLetters(4)

    self.Value = self:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    self.Value:SetPoint("CENTER", self.Input, "CENTER", 0, 0)
    self.Value:SetWidth(32)
    self.Value:SetJustifyH("CENTER")
    self.Value:Hide()
end

function LibEQOLCMC_CompactSliderMenuMixin:Setup(data)
    self.data = data
    self.Label:SetText(data.label)

    local labelWidth = data.labelWidth or (#tostring(data.label or "") <= 2 and 16 or 44)
    local sliderWidth = data.sliderWidth or 100
    self.Label:SetWidth(labelWidth)
    self.Slider:SetWidth(sliderWidth)
    self:SetWidth(8 + labelWidth + 3 + sliderWidth + 4 + 32 + 5)

    local minValue = tonumber(data.min) or -20
    local maxValue = tonumber(data.max) or 20
    local step = tonumber(data.step) or 1
    local editable = data.editable ~= false

    local function normalize(value)
        value = Clamp(tonumber(value) or 0, minValue, maxValue)
        return Clamp(math.floor((value / step) + 0.5) * step, minValue, maxValue)
    end

    local function setVisual(value)
        self.updating = true
        self.currentValue = value
        self.Slider:SetValue(value)
        if editable then
            self.Input:SetText(tostring(value))
        else
            local text = data.formatter and data.formatter(value) or tostring(value)
            self.Value:SetText(text)
        end
        self.updating = false
    end

    local function commit(value)
        value = normalize(value)
        setVisual(value)
        data.set(value)
        changed(data.ownerData)
    end

    self.updating = true
    self.Slider:SetScript("OnValueChanged", nil)
    self.Input:SetScript("OnEnterPressed", nil)
    self.Input:SetScript("OnEscapePressed", nil)
    self.Input:SetScript("OnEditFocusLost", nil)
    self.Slider:SetMinMaxValues(minValue, maxValue)
    self.Slider:SetValueStep(step)
    self.Slider:SetObeyStepOnDrag(true)
    self.Input:SetShown(editable)
    self.Value:SetShown(not editable)
    local initialValue = normalize(data.get())
    self.currentValue = initialValue
    self.Slider:SetValue(initialValue)
    if editable then
        self.Input:SetText(tostring(initialValue))
    else
        self.Value:SetText(data.formatter and data.formatter(initialValue) or tostring(initialValue))
    end
    self.updating = false

    self.Slider:SetScript("OnValueChanged", function(_, value)
        if not self.updating then
            commit(value)
        end
    end)
    if editable then
        self.Input:SetScript("OnEnterPressed", function(input)
            input:ClearFocus()
        end)
        self.Input:SetScript("OnEscapePressed", function(input)
            setVisual(self.currentValue)
            input:ClearFocus()
        end)
        self.Input:SetScript("OnEditFocusLost", function(input)
            if self.updating then
                return
            end
            local value = tonumber(input:GetText())
            if value == nil then
                setVisual(self.currentValue)
                return
            end
            commit(value)
        end)
    end
end

local function addSliderMenu(parent, label, getValue, setValue, data, minValue, maxValue, step, editable, formatter, sliderData)
    if not (getValue and setValue) then
        return
    end

    local description = parent:CreateTemplate("LibEQOLcooldownmanagercentered_CompactSliderMenuTemplate")
    description:AddInitializer(function(frame)
        if sliderData then
            sliderData._frame = frame
        end
        frame:Setup({
            label = label,
            min = minValue,
            max = maxValue,
            step = step,
            get = getValue,
            set = setValue,
            ownerData = data,
            editable = editable,
            formatter = formatter,
        })
        if sliderData and sliderData.enabled ~= nil then
            local enabled = sliderData.enabled
            if type(enabled) == "function" then
                enabled = enabled()
            end
            SetSliderEnabled(frame, enabled ~= false)
        end
    end)
    return description
end

local function addColorMenu(parent, data, color)
    if not (color and color.get and color.set) then
        return
    end
    local fallback = color.default or { r = 1, g = 1, b = 1, a = 1 }
    local function getRGB()
        local current = color.get() or fallback
        return { current.r or 1, current.g or 1, current.b or 1 }
    end
    local function setRGB(r, g, b)
        local current = color.get() or fallback
        color.set(r or fallback.r, g or fallback.g, b or fallback.b, current.a or fallback.a)
    end
    if ns.CooldownStyle and ns.CooldownStyle.AddMenuColorButton then
        ns.CooldownStyle.AddMenuColorButton(parent, color.label or "Color", getRGB, setRGB, function()
            changed(data)
        end, { fallback.r or 1, fallback.g or 1, fallback.b or 1 })
        return
    end
    parent:CreateButton(color.label or "Color", function()
        local current = color.get() or fallback
        ColorPickerFrame:SetupColorPickerAndShow({
            r = current.r or 1,
            g = current.g or 1,
            b = current.b or 1,
            opacity = current.a or 1,
            hasOpacity = color.hasOpacity ~= false,
            swatchFunc = function()
                local r, g, b = ColorPickerFrame:GetColorRGB()
                color.set(r, g, b, ColorPickerFrame:GetColorAlpha())
                changed(data)
            end,
        })
    end)
end

function CompactFont:OpenDetails(owner, data)
    if not (owner and data and MenuUtil and MenuUtil.CreateContextMenu) then
        return
    end

    local menu = MenuUtil.CreateContextMenu(owner, function(_, rootDescription)
        rootDescription:CreateTitle(data.title or "Text Details")

        local checkboxes = resolve(data.checkboxes)
        local checkboxesBefore, checkboxesAfter = {}, {}
        if type(checkboxes) == "table" then
            for _, checkbox in ipairs(checkboxes) do
                if checkbox.afterSliders then
                    checkboxesAfter[#checkboxesAfter + 1] = checkbox
                else
                    checkboxesBefore[#checkboxesBefore + 1] = checkbox
                end
            end
            for _, checkbox in ipairs(checkboxesBefore) do
                addCheckboxMenu(rootDescription, data, checkbox)
            end
        end

        local radios = resolve(data.radios)
        if type(radios) == "table" then
            for _, radio in ipairs(radios) do
                if radio and radio.get and radio.set then
                    rootDescription:CreateRadio(radio.label or "Option", function()
                        return radio.get() == radio.value
                    end, function()
                        radio.set(radio.value)
                        changed(data)
                    end)
                end
            end
        end

        -- Only render the font picker when a font setting actually exists. The
        -- Flow / Hide abilities cogwheels don't configure fonts, so without this
        -- guard they'd show a pointless "Font" entry.
        if data.getFont and data.setFont then
            -- Fonts use the custom FontPickerMenu (fully-owned frames, so each row
            -- can render in its own font) instead of a compositor/scrollbox submenu.
            if ns.LibEQOL and ns.LibEQOL.FontPickerMenu and ns.LibEQOL.FontPickerMenu.CreateFontPickerMenu then
                ns.LibEQOL.FontPickerMenu:CreateFontPickerMenu(rootDescription, {
                    options = data.fontOptions,
                    getValue = data.getFont,
                    setValue = data.setFont,
                    getLabel = function(value)
                        if not value or value == "NIL" then
                            return "Default font"
                        end
                        return value
                    end,
                    onValueChanged = function()
                        changed(data)
                    end,
                })
            else
                addRadioMenu(rootDescription, data.fontLabel or "Font", data.fontOptions, data.getFont, data.setFont, data, data.fontMenuHeight or 240)
            end
        end
        addFlagsMenu(rootDescription, data)
        addRadioMenu(rootDescription, data.anchorLabel or "Anchor", data.anchorOptions, data.getAnchor, data.setAnchor, data, data.anchorMenuHeight)

        local sliders = resolve(data.sliders)
        if type(sliders) == "table" then
            for _, slider in ipairs(sliders) do
                addSliderMenu(
                    rootDescription,
                    slider.label,
                    slider.get,
                    slider.set,
                    data,
                    slider.min,
                    slider.max,
                    slider.step,
                    slider.editable,
                    slider.formatter,
                    slider
                )
            end
        end

        for _, checkbox in ipairs(checkboxesAfter) do
            addCheckboxMenu(rootDescription, data, checkbox)
        end

        local colors = resolve(data.colors)
        if type(colors) == "table" then
            for _, color in ipairs(colors) do
                addColorMenu(rootDescription, data, color)
            end
        end

        if data.getX and data.setX then
            addSliderMenu(rootDescription, data.xLabel or "X", data.getX, data.setX, data, data.offsetMin, data.offsetMax, data.offsetStep)
        end
        if data.getY and data.setY then
            addSliderMenu(rootDescription, data.yLabel or "Y", data.getY, data.setY, data, data.offsetMin, data.offsetMax, data.offsetStep)
        end

        if data.resetDetails then
            rootDescription:CreateDivider()
            rootDescription:CreateButton(RESET_TO_DEFAULT or "Reset to Default", function()
                data.resetDetails()
                changed(data)
            end)
        end
    end)
    return menu
end

function CompactFont:CreateDetailsButton(parent)
    local button = CreateFrame("Button", nil, parent)
    button:SetSize(22, 22)

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetPoint("CENTER", 0, -2)
    icon:SetAtlas(GEAR_ATLAS.normal, true)
    button.Icon = icon

    local function refreshAtlas()
        local atlas
        if not button:IsEnabled() then
            atlas = GEAR_ATLAS.disabled
        elseif button:IsMouseOver() then
            atlas = GEAR_ATLAS.hover
        else
            atlas = GEAR_ATLAS.normal
        end
        icon:SetAtlas(atlas, true)
    end

    button:SetScript("OnEnter", function()
        refreshAtlas()
        GameTooltip:SetOwner(button, "ANCHOR_RIGHT")
        GameTooltip:SetText("Font details")
        GameTooltip:AddLine("Font, flags and text position", 1, 1, 1)
        GameTooltip:Show()
    end)
    button:SetScript("OnLeave", function()
        refreshAtlas()
        GameTooltip_Hide()
    end)
    button:SetScript("OnMouseDown", function()
        if button:IsEnabled() then
            icon:SetAtlas(GEAR_ATLAS.pressed, true)
        end
    end)
    button:SetScript("OnMouseUp", refreshAtlas)
    button:HookScript("OnEnable", refreshAtlas)
    button:HookScript("OnDisable", refreshAtlas)

    return button
end

LibEQOLCMC_CompactFontSettingsMixin = CreateFromMixins(SettingsCheckboxDropdownControlMixin)

function LibEQOLCMC_CompactFontSettingsMixin:OnLoad()
    SettingsCheckboxDropdownControlMixin.OnLoad(self)
    self.Control.Dropdown:SetWidth(185)

    self.DetailsButton = CompactFont:CreateDetailsButton(self)
    self.DetailsButton:SetPoint("LEFT", self.Control.Dropdown, "RIGHT", 6, 0)
    self.DetailsButton:SetScript("OnClick", function()
        CompactFont:OpenDetails(self.DetailsButton, self.compactFontData)
    end)
end

function LibEQOLCMC_CompactFontSettingsMixin:Init(initializer)
    self.compactFontData = initializer and initializer.data and initializer.data.compactFont
    SettingsCheckboxDropdownControlMixin.Init(self, initializer)
    self:EvaluateState()
end

function LibEQOLCMC_CompactFontSettingsMixin:EvaluateState()
    SettingsCheckboxDropdownControlMixin.EvaluateState(self)
    local enabled = self:IsEnabled() and self.Checkbox:GetChecked()
    self.DetailsButton:SetEnabled(enabled)
end

function LibEQOLCMC_CompactFontSettingsMixin:Release()
    self.compactFontData = nil
    SettingsCheckboxDropdownControlMixin.Release(self)
end
