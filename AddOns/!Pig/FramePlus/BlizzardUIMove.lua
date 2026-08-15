local _, addonTable = ...;
local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
local Fun=addonTable.Fun
local FramePlusfun=addonTable.FramePlusfun
--------
local BlizzardUIList={
	{true,  nil, "CharacterFrame",nil,"角色信息"},
	{false, nil, "DressUpFrame",nil, "试衣间"},
	{true,  nil, "SpellBookFrame",nil,"技能书"},
	{false, nil, "QuestLogFrame",nil,"任务日志"},
	{false, nil, "FriendsFrame",nil,"社交"},
	{false, nil, "LFGParentFrame",nil,"寻求组队(60)"},
	{false, nil, "PVEFrame",nil,"队伍查找器"},
	{false, nil, "MailFrame",nil,"邮箱"},
	{false, nil, "ChannelFrame",nil,"聊天频道"},
	{false, nil, "AddonList",nil,"插件列表"},
	{false, nil, "MerchantFrame",nil,"商人"},
	{false, nil, "GossipFrame",nil,"NPC对话"},
	{false, nil, "QuestFrame",nil,"NPC对话(任务)"},
	{false, nil, "BankFrame",nil,"银行"},
	{false, nil, "LootFrame",nil,"掉落列表"},
	{false, nil, "PetStableFrame",nil,"兽栏"},
	{false, nil, "WorldMapFrame",nil,"世界地图"},
	{false, nil, "WorldMapFrame", "WorldMapTitleButton", "世界地图(mini模式)"},
	{false, nil, "TradeFrame",nil, "交易界面"},
	{false, nil, "GameMenuFrame",nil, "ESC菜单"},
	{true,  nil, "SettingsPanel",nil, "设置选项"},
	{false, nil, "HelpFrame",nil, "客服支持"},
	{false, nil, "ContainerFrameCombinedBags",{"ContainerFrameCombinedBags","TitleContainer"}, "整合背包"},
	{false, "Blizzard_MacroUI","MacroFrame",nil,"宏命令"},
	{false, "Blizzard_AchievementUI","AchievementFrame",{"AchievementFrame","Header"},"成就"},
	{false, "Blizzard_Communities","CommunitiesFrame",nil,"公会与社区"},
	{true,  "Blizzard_Collections","CollectionsJournal",nil,"战团/藏品"},
	{false, "Blizzard_EncounterJournal","EncounterJournal",nil,"冒险手册"},
	{false, "Blizzard_TradeSkillUI","TradeSkillFrame",nil,"专业"},
	{true,  "Blizzard_ProfessionsBook","ProfessionsBookFrame",nil,"专业(新版)"},
	{false, "Blizzard_Professions","ProfessionsFrame",nil,"专业(新版)"},
	{false, "Blizzard_CraftUI","CraftFrame",nil,"附魔"},
	{false, "Blizzard_TrainerUI","ClassTrainerFrame",nil,"训练师"},
	{false, "Blizzard_InspectUI","InspectFrame",nil,"观察"},
	{false, "Blizzard_GuildBankUI","GuildBankFrame",nil,"公会银行"},
	{false, "Blizzard_Calendar","CalendarFrame",nil,"日历"},
	{false, "Blizzard_AuctionUI","AuctionFrame",nil,"拍卖行"},
	{false, "Blizzard_AuctionHouseUI","AuctionHouseFrame",nil,"拍卖行(新版)"},
	{false, "Blizzard_TalentUI","PlayerTalentFrame",nil,"天赋"},
	{true,  "Blizzard_PlayerSpells","PlayerSpellsFrame",nil,"天赋(新版)"},--有BUG
	{false, "Blizzard_HousingDashboard","HousingDashboardFrame",nil,"住宅"},
}
if PIG_MaxTocversion(120000,true) then
	BlizzardUIList[5][1]=true
end
FramePlusfun.BlizzardUIList=BlizzardUIList
------
local hookedFrames = {}
local FramesCombatLock = {}
local function PIG_SetPoint(UIname,MovingUI)
	if not UIname or not MovingUI or not PIGA["Blizzard_UI"][UIname] then return end
	local uixy=PIGA["Blizzard_UI"][UIname]["Point"]
	if uixy and uixy[1] and uixy[2] and uixy[3] and uixy[4] and not uixy[5] then
		local point, relativePoint, offsetX, offsetY=unpack(uixy)
		MovingUI:ClearAllPoints();
		MovingUI:SetPoint(point or "CENTER", UIParent, relativePoint or "CENTER", offsetX or 0, offsetY or 0);
		hookedFrames[UIname] = true
	else
		PIGA["Blizzard_UI"][UIname]["Point"]=nil
		hookedFrames[UIname] = nil
	end
end
local function PIG_SetPointSpecial(UIname,MovingUI)
	if UIname=="WorldMapFrame" then
		hooksecurefunc(WorldMapFrame, "OnFrameSizeChanged", function(self)
			if PIGA["Blizzard_UI"]["WorldMapFrame"] and PIGA["Blizzard_UI"]["WorldMapFrame"]["Point"] then
				PIG_SetPoint(UIname,MovingUI)
			end
		end)
	elseif UIname=="PlayerSpellsFrame" then
		--PlayerSpellsFrame:SetIgnoreParentScale(false)
	elseif UIname=="ContainerFrameCombinedBags" then
	    hooksecurefunc("UpdateContainerFrameAnchors", function()
	    	PIG_SetPoint(UIname,ContainerFrameCombinedBags)
		end)
		-- local originalSetPoint = ContainerFrameCombinedBags.SetPoint;
		-- ContainerFrameCombinedBags.SetPoint = function(self, ...)
		--     print("ContainerFrame1 SetPoint called from:", debugstack(2, 2, 0));
		--     return originalSetPoint(self, ...);
		-- end
	else
		PIG_SetPoint(UIname,MovingUI)
	end
end
local function PIG_SetScale(UIname,MovingUI)
	if not UIname or not MovingUI then return end
	if not PIGA["Blizzard_UI"][UIname] then return end
	local ScaleV=PIGA["Blizzard_UI"][UIname]["Scale"]
	if ScaleV and ScaleV~=1 then
		MovingUI:SetScale(ScaleV);
	end
end
local function funxx(UIname,MovingUI,NotSave)
	MovingUI:EnableMouse(true)
	MovingUI:SetMovable(true)
	MovingUI:SetClampedToScreen(true)
	PIG_SetScale(UIname,MovingUI)
	if not NotSave and PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
		MovingUI.ignoreFramePositionManager = true;
		MovingUI:SetAttribute("ignoreFramePositionManager", true);
		PIG_SetPointSpecial(UIname,MovingUI,NotSave)
	else
		if PIGA["Blizzard_UI"][UIname] then PIGA["Blizzard_UI"][UIname]["Point"]=nil end
   	end
end
local function MovingFun_1(protection,UIname,ClickF,MovingUI,NotSave)
	ClickF:RegisterForDrag("LeftButton")
    ClickF:HookScript("OnDragStart",function()
    	if protection and InCombatLockdown() then 
			PIGErrorMsg("战斗中无法移动")
			return
		end
        MovingUI:StartMoving();
    end)
    ClickF:HookScript("OnDragStop",function()
    	if protection and InCombatLockdown() then 
			PIGErrorMsg("战斗中无法移动")
			return
		end
        MovingUI:StopMovingOrSizing()
        MovingUI:SetUserPlaced(true)
        if not NotSave and PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
        	PIGA["Blizzard_UI"][UIname]=PIGA["Blizzard_UI"][UIname] or {}
        	local point, relativePoint, offsetX, offsetY = PIGGetPoint(MovingUI)
			if point and relativePoint and offsetX and offsetY then
				local offsetX = floor(offsetX*100+0.5)*0.01
				local offsetY = floor(offsetY*100+0.5)*0.01
				PIGA["Blizzard_UI"][UIname]["Point"]={point, relativePoint, offsetX, offsetY}
				PIG_SetPoint(UIname,MovingUI)
			end
       	end
    end)
	if protection and InCombatLockdown() then
		MovingUI:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		funxx(UIname,MovingUI,NotSave)
	end
	MovingUI:HookScript("OnEvent", function(self, event)
		if event=="PLAYER_REGEN_ENABLED" then
			funxx(UIname,self,NotSave)
		end
	end)
end
local function add_Movebiaoti(oldbiaoti)
	local Movebiaoti = CreateFrame("Frame", nil, oldbiaoti);
	Movebiaoti:SetPoint("TOPLEFT",oldbiaoti,"TOPLEFT",0,0);
	Movebiaoti:SetPoint("BOTTOMRIGHT",oldbiaoti,"BOTTOMRIGHT",0,0);
	Movebiaoti:EnableMouse(true)
	return Movebiaoti
end
local function MovingFun(protection,UIname,ClickFname,NotSave)
	if PIGA["FramePlus"]["BlizzardUI_Not"][UIname] then return end
	local MovingUI=_G[UIname]
	if MovingUI then
		if ClickFname then
			if type(ClickFname)=="table" then
				local uixxF=_G[ClickFname[1]]
				if uixxF then
					local uixxFxx=uixxF[ClickFname[2]]
					if uixxFxx then
						if UIname=="ContainerFrameCombinedBags" then		
							MovingFun_1(protection,UIname,add_Movebiaoti(uixxFxx),MovingUI)
						else
							MovingFun_1(protection,UIname,uixxFxx,MovingUI)
						end
					else
						MovingFun_1(protection,UIname,uixxF,MovingUI)
					end
				end
			else
				local ClickF=_G[ClickFname]
				if ClickF then
					MovingFun_1(protection,UIname,ClickF,MovingUI)
				end
			end
		else
			if UIname=="CollectionsJournal" then
        		if WardrobeTransmogFrame then
            		local checkBox = _G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox;
				    local label = checkBox.Label;
				    label:ClearAllPoints();
				    label:SetPoint('LEFT', checkBox, 'RIGHT', 2, 1);
				    label:SetPoint('RIGHT', checkBox, 'RIGHT', 160, 1);
				end
			end
			MovingFun_1(protection,UIname,MovingUI,MovingUI,NotSave)
		end
	end
end
local function MovingFunEvent(protection,event,UIname,ClickFname,NotSave)
	Fun.IsAddOnLoaded(event,function()
		MovingFun(protection,UIname,ClickFname,NotSave)
	end)
end
function FramePlusfun.BlizzardUI_Move()
	if not PIGA['FramePlus']['BlizzardUI_Move'] then return end
	for i=1,#BlizzardUIList do
		local protection,event,ui,tuoui,uiname,NotSave=unpack(BlizzardUIList[i])
		FramesCombatLock[ui]=protection
		if event then
			MovingFunEvent(protection,event,ui,tuoui,NotSave)
		else
			MovingFun(protection,ui,tuoui,NotSave)
		end
	end
	if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
		local oldOpenFrame={}
		hooksecurefunc("UpdateUIPanelPositions", function(frame)
			if frame then
				if not frame.GetName then return end
	            local uiName = frame:GetName()
	            if uiName and hookedFrames[uiName] then
	            	oldOpenFrame[uiName]=true
	            	if FramesCombatLock[uiName] and InCombatLockdown() then return end
	            	PIG_SetPoint(uiName, frame)
	            	for olduiname,_ in pairs(oldOpenFrame) do
	            		if olduiname~=uiName then
		            		if _G[olduiname] and _G[olduiname]:IsShown() then
		            			if FramesCombatLock[olduiname] and InCombatLockdown() then return end
		            			PIG_SetPoint(olduiname, _G[olduiname])
		            		end
		            	end
	            	end
	            end
	        else
				for olduiname,_ in pairs(oldOpenFrame) do
            		if _G[olduiname] and _G[olduiname]:IsShown() then
            			if FramesCombatLock[olduiname] and InCombatLockdown() then return end
            			PIG_SetPoint(olduiname, _G[olduiname])
            		end
	        	end		
	        end
		end)
	end
end