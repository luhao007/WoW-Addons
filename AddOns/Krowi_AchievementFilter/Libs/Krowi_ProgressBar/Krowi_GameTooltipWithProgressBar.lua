--[[
    Copyright (c) 2023 Krowi
    Licensed under the terms of the LICENSE file in this repository.
]]

---@diagnostic disable: undefined-global

local sub, parent = KROWI_LIBMAN:NewSubmodule('GameTooltipWithProgressBar', 1)
if not sub or not parent then return end

sub.Tooltip = Krowi_ProgressBarTooltip
sub.ProgressBar = parent:GetNew(Krowi_ProgressBarTooltip)
local progressBar = sub.ProgressBar

function sub:Show(ownerFrame, anchor, title, min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	local tooltip = Krowi_ProgressBarTooltip
	tooltip:SetOwner(ownerFrame, anchor or 'ANCHOR_NONE')
	if anchor == nil then
		tooltip:SetPoint('TOPLEFT', ownerFrame, 'TOPRIGHT', -3, -3)
	end
	tooltip:SetMinimumWidth(128, true)
	GameTooltip_SetTitle(tooltip, title)
	progressBar:Reset()
	progressBar:Add(min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	progressBar:Show()
	tooltip:SetMinimumWidth(140)
	tooltip:Show()
end

function sub:Hide()
	Krowi_ProgressBarTooltip:Hide()
end

function progressBar:Add(min, max, value1, value2, value3, value4, color1, color2, color3, color4, text)
	local tooltip = Krowi_ProgressBarTooltip
	GameTooltip_AddBlankLinesToTooltip(tooltip, 1)
	local numLines = tooltip:NumLines()
	if not text then
		text = ''
	end
	self:ClearAllPoints()
	self:SetPoint('LEFT', tooltip:GetName() .. 'TextLeft' .. numLines, 'LEFT', 0, -2)
	self:SetPoint('RIGHT', tooltip, 'RIGHT', -9, 0)
	self:SetHeight(25)
	self.TextLeft:SetText(text)
	self:SetMinMaxValues(min, max)
	self:SetValues(value1, value2, value3, value4)
	self:SetColors(color1, color2, color3, color4)
	self:UpdateTextures()
end