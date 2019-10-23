local minimapShapes = {
	-- quadrant booleans (same order as SetTexCoord)
	-- {bottom-right, bottom-left, top-right, top-left}
	-- true = rounded, false = squared
	["ROUND"] 			= {true,  true,  true,  true },
	["SQUARE"] 			= {false, false, false, false},
	["CORNER-TOPLEFT"] 		= {false, false, false, true },
	["CORNER-TOPRIGHT"] 		= {false, false, true,  false},
	["CORNER-BOTTOMLEFT"] 		= {false, true,  false, false},
	["CORNER-BOTTOMRIGHT"]	 	= {true,  false, false, false},
	["SIDE-LEFT"] 			= {false, true,  false, true },
	["SIDE-RIGHT"] 			= {true,  false, true,  false},
	["SIDE-TOP"] 			= {false, false, true,  true },
	["SIDE-BOTTOM"] 		= {true,  true,  false, false},
	["TRICORNER-TOPLEFT"] 		= {false, true,  true,  true },
	["TRICORNER-TOPRIGHT"] 		= {true,  false, true,  true },
	["TRICORNER-BOTTOMLEFT"] 	= {true,  true,  false, true },
	["TRICORNER-BOTTOMRIGHT"] 	= {true,  true,  true,  false},
}

function BtWQuestsMinimapButton_Toggle()
	BtWQuestSettingsData:SetValue("minimapShown", not BtWQuestSettingsData:GetValue("minimapShown"))

    BtWQuestsMinimapButton:SetShown(BtWQuestSettingsData:GetValue("minimapShown"))
end

function BtWQuestsMinimapButton_SetCoords(x, y)
    BtWQuests_Settings.minimapX = x
    BtWQuests_Settings.minimapY = y

    BtWQuestsMinimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end

function BtWQuestsMinimapButton_Reposition(degrees)
    local radius = 80
	local rounding = 10
    local angle = math.rad(degrees or 200)
    local x, y
	local cos = math.cos(angle)
	local sin = math.sin(angle)
	local q = 1;
	if cos < 0 then
		q = q + 1;	-- lower
	end
	if sin > 0 then
		q = q + 2;	-- right
	end
    local minimapShape = GetMinimapShape and GetMinimapShape() or "ROUND"
    
	local quadTable = minimapShapes[minimapShape];
	if quadTable[q] then
		x = cos*radius;
		y = sin*radius;
	else
		local diagRadius = math.sqrt(2*(radius)^2)-rounding
		x = math.max(-radius, math.min(cos*diagRadius, radius))
		y = math.max(-radius, math.min(sin*diagRadius, radius))
	end
    BtWQuestsMinimapButton_SetCoords(x, y)
end

function BtWQuestsMinimapButtonDraggingFrame_OnUpdate()
	local px,py = GetCursorPosition()
    local mx,my = Minimap:GetCenter()
    
    local scale = Minimap:GetEffectiveScale()
    px, py = px / scale, py / scale
    
    BtWQuestsMinimapButton_Reposition(math.deg(math.atan2(py - my, px - mx)))
end

function BtWQuestsMinimapButton_OnClick(self, button)
	if button == "RightButton" then
		BtWQuestsOptionsMenu:Toggle(self, 0, 0)
	else
		if BtWQuestsFrame:IsShown() then
			BtWQuestsFrame:Hide()
		else
			BtWQuestsFrame:Show()
		end
	end
end