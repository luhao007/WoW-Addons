
local Plater = _G.Plater
local addonName, platerInternal = ...
local detailsFramework = DetailsFramework
local GetErrorHandler = platerInternal.GetErrorHandler
local _

--create a namespace for plugins
platerInternal.Plugins = {}
--a table to store plugins installed
platerInternal.Plugins.Installed = {}
--store the plugin.Frame
platerInternal.Plugins.OptionFrames = {}
--used to save on profile.plugin_data
platerInternal.Plugins.DataPrototype = {
	enabled = true,
}

--the frame from Plater Options Panel
local pluginFrameOptions

function platerInternal.Plugins.GetPluginList()
	return platerInternal.Plugins.Installed
end

function platerInternal.Plugins.GetPluginAreaFrame()
	return pluginFrameOptions
end

function platerInternal.Plugins.GetPluginObjectByPluginUniqueName(pluginUniqueName)
	local allPluginsInstalled = platerInternal.Plugins.GetPluginList()
	for i = 1, #allPluginsInstalled do
		local pluginObject = allPluginsInstalled[i]
		if (pluginObject.UniqueName == pluginUniqueName) then
			return pluginObject
		end
	end
end

function platerInternal.Plugins.GetPluginFrameByPluginUniqueName(pluginUniqueName)
	local pluginObject = platerInternal.Plugins.GetPluginObjectByPluginUniqueName(pluginUniqueName)
	return pluginObject.Frame
end

do
	--[[
		the state of 'Plater.db.profile.plugins_data[pluginUniqueName].enabled' is already set when the functions below are called
	]]

	--called after the plugin was installed
	--the Plater.InstallPlugin() call does not check if the plugin is enabled or not
	--this has to be done on this function
	function platerInternal.Plugins.PluginInstalled(pluginUniqueName)
		if (Plater.db.profile.plugins_data[pluginUniqueName].enabled) then
			platerInternal.Plugins.PluginEnabled(pluginUniqueName)
		else
			platerInternal.Plugins.PluginDisabled(pluginUniqueName)
		end
	end

	--called after the plugin is installed or by user interaction on the enabled checkbox from the plugin panel
	function platerInternal.Plugins.PluginEnabled(pluginUniqueName)
		local pluginObject = platerInternal.Plugins.GetPluginObjectByPluginUniqueName(pluginUniqueName)
		if (pluginObject) then
			if (pluginObject.OnEnable) then
				xpcall(pluginObject.OnEnable, GetErrorHandler("启用Plater插件的错误为 '" .. (pluginUniqueName or "错误: 没有名字").. "':"), pluginUniqueName)
			end
		else
			error("Plater插件OnEnabled(): 无法找到插件对象: " .. (pluginUniqueName or "-插件名称为nil"))
		end
	end

	--called after the plugin is disabled by the user from the enabled checkbox on plugin panel
	function platerInternal.Plugins.PluginDisabled(pluginUniqueName)
		local pluginObject = platerInternal.Plugins.GetPluginObjectByPluginUniqueName(pluginUniqueName)
		if (pluginObject) then
			if (pluginObject.OnDisable) then
				xpcall(pluginObject.OnDisable, GetErrorHandler("启用Plater插件的错误为 '" .. (pluginUniqueName or "错误: 没有名字").. "':"), pluginUniqueName)
			end
		else
			error("Plater插件OnDisable(): 无法找到插件对象: " .. (pluginUniqueName or "-插件名称为nil"))
		end
	end
end

--install plugin on main plater object
function Plater.InstallPlugin(pluginObject, silent)
	assert(type(pluginObject) == "table", "使用: Plater.InstallPlugin(pluginObject)")
	assert(type(pluginObject.OnEnable) == "function", "pluginObject需要一个关于pluginObject['OnEnable']的函数, 当该插件从插件菜单中被启用时(或安装后)这个函数将被调用.")
	assert(type(pluginObject.OnDisable) == "function", "pluginObject需要一个关于pluginObject['OnDisable']的函数, 当该插件从插件菜单中被禁用时会调用这个函数.")
	assert(type(pluginObject.Frame) == "table" and pluginObject.Frame:GetObjectType() == "Frame", "pluginObject需要pluginObject['Frame'], 这个框架附着在Plater的插件标签中以显示插件选项.")
	assert(type(pluginObject.Name) == "string" and pluginObject.Name:len() >= 4, "pluginObject需要pluginObject['Name'], 这是一个本地化的名称会在Plater的插件标签中显示.")
	assert(type(pluginObject.UniqueName) == "string" and pluginObject.Name:len() >= 8, "pluginObject需要pluginObject['UniqueName'], 这是一个内部名称用于比较插件是否已经安装并保存启用/禁用状态.")

	if (platerInternal.Plugins.Installed[pluginObject.UniqueName]) then
		if (not silent) then
			error("Plater.InstallPlugin(): this plugin is already installed.")
		end
		return
	end

    if (not pluginObject.Icon or (type(pluginObject.Icon) ~= "number" and type(pluginObject.Icon) ~= "string")) then
        pluginObject.Icon = [[Interface\ICONS\INV_Misc_QuestionMark]]
    end

	local pluginData = Plater.db.profile.plugins_data[pluginObject.UniqueName]
	if (not pluginData) then
		--create the plugin data if absent
		pluginData = DetailsFramework.table.copy({}, platerInternal.Plugins.DataPrototype)
		Plater.db.profile.plugins_data[pluginObject.UniqueName] = pluginData
	end

	--copy new values from the prototype into the plugin data
	DetailsFramework.table.deploy(pluginData, platerInternal.Plugins.DataPrototype)

	--saving as an indexed table to make it easy to sort by name
	platerInternal.Plugins.Installed[#platerInternal.Plugins.Installed+1] = pluginObject
	table.sort(platerInternal.Plugins.Installed, function(t1, t2)
		return t1.Name < t2.Name
	end)

    platerInternal.Plugins.OptionFrames[#platerInternal.Plugins.OptionFrames+1] = pluginObject.Frame

    local pluginsFrame = PlaterOptionsPanelContainerPluginsFrame
    if (pluginsFrame) then
        if (pluginsFrame:IsShown()) then
            pluginsFrame.PluginsScrollBox:Refresh()
        end
    end

	platerInternal.Plugins.PluginInstalled(pluginObject.UniqueName)

	return true
end

function platerInternal.Plugins.CreatePluginsOptionsTab(pluginsFrame)
    --_G.PlaterOptionsPanelContainerPluginsFrame
    local scrollbox_size = {200, 475}
    local scrollBoxHeight = scrollbox_size[2]
    local scrollbox_line_height = 28.7
    local scrollbox_lines = floor(scrollBoxHeight / scrollbox_line_height)
    local scrollbox_line_backdrop_color = {0, 0, 0, 0.5}
    local scrollbox_line_backdrop_color_selected = {.6, .6, .1, 0.7}

	pluginFrameOptions = pluginsFrame

    pluginsFrame.OnShowCallback = function(self)
        self.PluginsScrollBox:SetData(platerInternal.Plugins.GetPluginList())
        self.PluginsScrollBox:Refresh()
    end

    pluginsFrame:SetScript("OnShow", pluginsFrame.OnShowCallback)

    pluginsFrame:SetScript("OnHide", function(self)
        return "smile face"
    end)

    --store the UniqueName of the current plugin selected
    local currentPluginSelected = false

	local f = PlaterOptionsPanelFrame
	local mainFrame = PlaterOptionsPanelContainer

    local hideAllPluginOptionsFrame = function()
        for i = 1, #platerInternal.Plugins.OptionFrames do
            platerInternal.Plugins.OptionFrames[i]:Hide()
        end
    end

    local showOptionsFrameForPlugin = function(pluginUniqueName)
		local pluginFrame = platerInternal.Plugins.GetPluginFrameByPluginUniqueName(pluginUniqueName)

		pluginFrame:SetParent(PlaterOptionsPanelContainerPluginsFramePluginOptionsArea)
		pluginFrame:SetAllPoints(PlaterOptionsPanelContainerPluginsFramePluginOptionsArea)

		pluginFrame:Show()
    end

    local checkBoxCallback = function(checkBox)
		local pluginObject = platerInternal.Plugins.GetPluginObjectByPluginUniqueName(checkBox.pluginUniqueName)
        Plater.db.profile.plugins_data[pluginObject.UniqueName].enabled = not Plater.db.profile.plugins_data[pluginObject.UniqueName].enabled

		if (Plater.db.profile.plugins_data[pluginObject.UniqueName].enabled) then
			--user enabled the plugin
			platerInternal.Plugins.PluginEnabled(checkBox.pluginUniqueName)
		else
			--use disabled the plugin
			platerInternal.Plugins.PluginDisabled(checkBox.pluginUniqueName)
		end
    end

	--set points
	local startX = 10
	local startY = platerInternal.optionsYStart --menu and settings panel
	local startYGeneralSettings = -150

	function pluginsFrame.RefreshPluginSelectScrollBox(self, data, offset, totalLines) --~refresh
		--update the scroll
		for i = 1, totalLines do
			local index = i + offset
			local pluginObject = data[index]
			if (pluginObject) then
				--update the line
				local line = self:GetLine(i)
                line:UpdateLine(pluginObject)

				if (pluginObject.UniqueName == currentPluginSelected) then
					line:SetBackdropColor(unpack(scrollbox_line_backdrop_color_selected))
				else
					line:SetBackdropColor(unpack(scrollbox_line_backdrop_color))
				end
			end
		end
	end

	function pluginsFrame.OnEnterScrollSelectionLine(self)
		self:SetBackdropColor(.3, .3, .3, .6)
	end

	function pluginsFrame.OnLeaveScrollSelectionLine(self)
		--check if the hover overed button is the current plugin being edited
		if (currentPluginSelected == self.pluginUniqueName) then
			self:SetBackdropColor(unpack(scrollbox_line_backdrop_color_selected))
		else
			self:SetBackdropColor(unpack(scrollbox_line_backdrop_color))
		end
	end

    function pluginsFrame.OnClickScrollSelectionLine(self) --~õnclick ~onclick
		local pluginUniqueName = self.pluginUniqueName
		if (pluginUniqueName) then
            --open options to plugin
            hideAllPluginOptionsFrame()
            showOptionsFrameForPlugin(pluginUniqueName)
            currentPluginSelected = pluginUniqueName
			pluginsFrame.PluginsScrollBox:Refresh()
        end
    end

	--update a single line in the scroll list
	function pluginsFrame.UpdateScrollLine(line, pluginObject) --~updateline
		line.Icon:SetTexture(pluginObject.Icon)
		line.Icon:SetTexCoord(.1, .9, .1, .9)
		line.PluginName:SetText(pluginObject.Name)
		line.pluginUniqueName = pluginObject.UniqueName
		local isEnabled = Plater.db.profile.plugins_data[pluginObject.UniqueName].enabled
		line.EnabledCheckbox:SetValue(isEnabled)
		line.EnabledCheckbox.pluginUniqueName = pluginObject.UniqueName
	end

	--scrollbox to select the plugin to edit its options
	local pluginsLabel = detailsFramework:CreateLabel(pluginsFrame, "Select a Plugin:", detailsFramework:GetTemplate("font", "ORANGE_FONT_TEMPLATE"))
	pluginsLabel:SetPoint("topleft", pluginsFrame, "topleft", startX, startY)

	local pluginSelectScrollBox = detailsFramework:CreateScrollBox(pluginsFrame, "$parentScrollBox", pluginsFrame.RefreshPluginSelectScrollBox, {}, 200, scrollBoxHeight, scrollbox_lines, scrollbox_line_height) --~scroll
	pluginSelectScrollBox:SetPoint("topleft", pluginsLabel.widget, "bottomleft", 0, -2)
	detailsFramework:ReskinSlider(pluginSelectScrollBox)
	pluginsFrame.PluginsScrollBox = pluginSelectScrollBox

	local gapBetweenScrollBoxAndOptionsPanel = 30
	local pluginOptionsArea = CreateFrame("frame", "$parentPluginOptionsArea", pluginsFrame)
	pluginOptionsArea:SetPoint("topleft", pluginSelectScrollBox, "topright", gapBetweenScrollBoxAndOptionsPanel, 0)
	pluginOptionsArea:SetPoint("bottomleft", pluginSelectScrollBox, "bottomright", gapBetweenScrollBoxAndOptionsPanel, 0)
	detailsFramework:ApplyStandardBackdrop(pluginOptionsArea)
	pluginOptionsArea:SetWidth(838)

	local createNewLineFunc = function(self, index)
		--create a new line
		local line = CreateFrame("button", "$parentLine" .. index, self, BackdropTemplateMixin and "BackdropTemplate")

		--set its parameters 
		line:SetPoint("topleft", self, "topleft", 1, -((index-1) *(scrollbox_line_height+1)) - 1)
		line:SetSize(scrollbox_size[1]-2, scrollbox_line_height)
		line:RegisterForClicks("LeftButtonDown", "RightButtonDown")

		line:SetScript("OnEnter",	pluginsFrame.OnEnterScrollSelectionLine)
		line:SetScript("OnLeave",	pluginsFrame.OnLeaveScrollSelectionLine)
		line:SetScript("OnClick",	pluginsFrame.OnClickScrollSelectionLine)

        detailsFramework:ApplyStandardBackdrop(line)

		local icon = line:CreateTexture("$parentIcon", "overlay") --~create
		icon:SetSize(scrollbox_line_height-4, scrollbox_line_height-4)

		local pluginName = detailsFramework:CreateLabel(line, "", detailsFramework:GetTemplate("font", "PLATER_SCRIPTS_NAME"))

        local enabledCheckBox = detailsFramework:CreateSwitch(line, checkBoxCallback, true, _, _, _, _, "EnabledCheckbox", "$parentEnabledToggle" .. index, _, _, _, nil, detailsFramework:GetTemplate ("switch", "OPTIONS_CHECKBOX_BRIGHT_TEMPLATE"))
        enabledCheckBox:SetAsCheckBox()

		--setup anchors
		icon:SetPoint("left", line, "left", 2, 0)
		pluginName:SetPoint("topleft", icon, "topright", 2, -2)
		enabledCheckBox:SetPoint("right", line, "right", -2, 0)

		line.Icon = icon
		line.PluginName = pluginName
        line.EnabledCheckbox = enabledCheckBox
		line.UpdateLine = pluginsFrame.UpdateScrollLine

		return line
	end

	--create the scrollbox lines
	for i = 1, scrollbox_lines do
		pluginSelectScrollBox:CreateLine(createNewLineFunc)
	end
end

------------------------------------------------------------------------------------------
--create two test plugins
--[=[

C_Timer.After(1, function()
	local plugin1 = {
		Frame = CreateFrame("frame", "FrameName1"),
		Name = "测试插件1",
		UniqueName = "TESTPLUGIN1",
		Icon = [[Interface\ICONS\6BF_Explosive_Shard]],
		OnEnable = function() print("启用插件")end,
		OnDisable = function() print("禁用插件")end,
	}
	Plater.InstallPlugin(plugin1, false)

	local plugin2 = {
		Frame = CreateFrame("frame", "MyPluginFrame", UIParent),
		Name = "我的测试插件",
		UniqueName = "testplifdf 2",
		Icon = [[Interface\ICONS\70_inscription_deck_dominion_3]],
		OnEnable = function()end,
		OnDisable = function()end,
	}
	Plater.InstallPlugin(plugin2)
end)
--]=]