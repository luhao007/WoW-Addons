FlashFrames = LibStub("AceAddon-3.0"):NewAddon("FlashFrames", "AceEvent-3.0", "LibBars-1.0")
local bars = LibStub("LibBars-1.0")
local media = LibStub("LibSharedMedia-3.0")
local mod = FlashFrames

local function animateBar(self)
	mod.MaxStats:GetBar("Power"):AnimateToGroup(mod.buffList)
end

local sid = 2345
local function getSpellIcon()
	local icon
	while not icon do
		icon = select(3, GetSpellInfo(sid))
		if icon and #icon == 0 then icon = nil end
		sid = sid + 1
	end
	return sid
end

function mod:OnInitialize()
	self.MaxStats = self:NewBarGroup("Max Stats", nil, 150, 12)
	self.MaxStats:SetFont(nil, 8)
	self.MaxStats:SetColorAt(1.00, 1, 0, 0, 1)
	self.MaxStats:SetColorAt(0.66, 1, 1, 0, 1)
	self.MaxStats:SetColorAt(0.33, 0, 1, 1, 1)
	self.MaxStats:SetColorAt(0.00, 0, 0, 1, 1)
	self.MaxStats:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 100, -100)
	self.MaxStats:SetScale(0.9)
	self.MaxStats.RegisterCallback(self, "AnchorClicked")
	
	self.buffList = self:NewBarGroup("Buffs List", "RIGHT", 200, 12)
	self.buffList:SetColorAt(0.00, 1, 0, 0, 1)
	self.buffList:SetColorAt(0.33, 1, 1, 0, 1)
	self.buffList:SetColorAt(0.66, 0, 1, 1, 1)
	self.buffList:SetColorAt(1.00, 0, 0, 1, 1)
	self.buffList:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -100, -100)
	self.buffList:SetScale(1.2)	
	self.buffList:SetDisplayMax(20)

	self.vertTest = self:NewBarGroup("VertTest", bars.BOTTOM_TO_TOP, 130, 12)
	self.vertTest:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 200, 200)
	self.vertTest:NewCounterBar("VertTestBar1", "Test Bar 1", 1, 5, getSpellIcon())
	self.vertTest:NewCounterBar("VertTestBar2", "Test Bar 2", 4, 5, getSpellIcon())
	self.vertTest:NewTimerBar("VertTestBar3", "Test Bar 3", 200, 200, getSpellIcon())
	self.vertTest:NewCounterBar("VertTestBar4", "Test Bar 4", 5, 5, getSpellIcon())
	self.vertTest:SetTexture(media:Fetch("statusbar", "Minimalist"))
	self.vertTest:SetColorAt(0, 1, 0, 0, 1)
	self.vertTest:SetColorAt(1, 0, 1, 0, 1)

	local verttestbar = self:NewCounterBar("VertTestBar", "Testing", 3, 20, nil, bars.LEFT_TO_RIGHT, 130, 12)
	verttestbar.texture:SetVertexColor(1, 0, 0, 1)
	verttestbar.bgtexture:SetVertexColor(0, 0, 0, 0.3)
	verttestbar:SetTexture(media:Fetch("statusbar", "Blizzard"))
	verttestbar:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 100, 400)
	verttestbar:SetOrientation(bars.BOTTOM_TO_TOP)
	verttestbar:SetWidth(12)
	verttestbar:SetHeight(130)
	verttestbar.label:Hide()
	verttestbar.timerLabel:Hide()

	local bar = self.buffList:NewTimerBar("TimerName", 7)
	bar:SetDisplayMax(10)

	local bar2 = self.buffList:NewCounterBar("TimerName", "Foo", 12, 25)
	bar2.timerLabel:SetText("12 / 25")
	
	--[[
	local button = CreateFrame("Button", nil, UIParent, "UIPanelButtonTemplate")
	button:SetScript("OnClick", animateBar)
	button:SetWidth(100)
	button:SetHeight(20)
	button:SetPoint("CENTER", UIParent, "CENTER", 300, 300)
	]]--

	for i = 1, 20 do
		self.buffList:NewTimerBar("Bar " .. i, "Bar " .. i, i*10, 200, getSpellIcon())
	end
	self.buffList:SortBars()
	
	-- self.MaxStats:SetStartColor(1, 0, 0)
	-- self.MaxStats:SetEndColor(0, 0, 1)
end

function mod:AnchorClicked(cbk, group, button)
	Chatter:Print("Clicked", group, button)
	if button == "RightButton" then
		group:HideAnchor()
	end
end

function mod:OnEnable()
	local tex = media:Fetch("statusbar", "Minimalist")	
	self.MaxStats:SetTexture(tex)
	self.buffList:SetTexture(tex)
	
	self:RegisterEvent("UNIT_AURA")	
	self:RegisterEvent("UNIT_ATTACK_POWER")
	self:RegisterEvent("UNIT_ATTACK_SPEED")
	
	self.MaxStats:NewCounterBar("Power", nil, nil, nil, 6673)
	self.MaxStats:NewCounterBar("Haste", nil, nil, nil, 5171)
	self.MaxStats:NewCounterBar("Crit%", nil, nil, nil, 14142)	
	
	self:UNIT_AURA(nil, "player")
	self:UNIT_ATTACK_POWER()
	self:UNIT_ATTACK_SPEED(nil, "player")
end

do
	local function AP(unit)
		local a, b, c = UnitAttackPower(unit)
		return a + b - c
	end
	function mod:UNIT_ATTACK_POWER()
		local bar = self.MaxStats:GetBar("Power")
		local ap = AP("player")
		bar:SetValue(ap)
		bar:SetLabel(("Attack power: %s / %s"):format(ap, bar.maxValue))
	end
end

function mod:UNIT_ATTACK_SPEED(e, unit)
	if unit ~= "player" then return end
	local main, off = UnitAttackSpeed(unit)
	self.mainHand = self.mainHand or main
	if main > self.mainHand then
		self.mainHand = main
	end
	local haste = self.mainHand / main
	self.maxHaste = self.maxHaste or haste
	if haste > self.maxHaste then
		self.maxHaste = haste
	end
	local bar = self.MaxStats:GetBar("Haste")
	bar:SetValue(haste)
	bar:SetLabel(("Haste: %2.0f%% / %2.0f%%"):format(haste * 100, self.maxHaste * 100))
end

function mod:UNIT_AURA(e, unit)
	if unit == "player" then
		local bar = self.MaxStats:GetBar("Crit%")
		local crit = GetCritChance()
		self.maxCrit = self.maxCrit or crit
		if crit > self.maxCrit then
			self.maxCrit = crit
		end
		bar:SetValue(crit)
		bar:SetLabel(("Crit: %2.1f%% / %2.1f%%"):format(crit, self.maxCrit))
		self:CheckBuffs(self.buffList)
	end
end

function mod:CheckBuffs(list)
	for i = 1, 40 do
		local name, rank, iconTexture, count, duration, timeLeft =  UnitBuff("player", i)
		if not name then break end
		if not timeLeft then
			timeLeft = GetPlayerBuffTimeLeft(i)
		end
		if timeLeft and timeLeft > 0 then
			bar = list:NewTimerBar(
				(name or "") .. (rank or ""), 
				name .. (rank and " (" .. rank .. ")" or "") .. (count and count > 0 and " (" .. count .. ")" or ""),
				timeLeft, duration,
				iconTexture
			)
		else
			bar = list:NewCounterBar(
				(name or "") .. (rank or ""), 
				name .. (rank and " (" .. rank .. ")" or "") .. (count and count > 0 and " (" .. count .. ")" or ""),
				timeLeft, duration,
				iconTexture
			)
		end
	end
	list:SortBars()
end
