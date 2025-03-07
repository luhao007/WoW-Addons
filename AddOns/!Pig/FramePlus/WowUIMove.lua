local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local Create=addonTable.Create
local PIGFontString=Create.PIGFontString
local FramePlusfun=addonTable.FramePlusfun
--------
local IsAddOnLoaded=IsAddOnLoaded or C_AddOns and C_AddOns.IsAddOnLoaded
--初始系统已经加载的UI
local UINameList={
	{CharacterFrame,},
	{SpellBookFrame,},
	{QuestLogFrame,},
	{FriendsFrame,},
	{LFGParentFrame,},
	{PVEFrame,},
	{MailFrame,},
	{ChannelFrame,},--聊天频道
	{AddonList,},
	{MerchantFrame},--商人
	{GossipFrame},--NPC对话
	{QuestFrame,},--任务NPC对话
	{BankFrame},--银行
	--{LootFrame,},
	{WorldMapFrame,},--世界地图
	{WorldMapFrame,WorldMapTitleButton},--世界地图mini模式
}
if ContainerFrameCombinedBags then
	table.insert(UINameList,{ContainerFrameCombinedBags,"add",ContainerFrameCombinedBags.TitleContainer})
end
--根据事件加载的UI
local UINameList_AddOn={
	{"MacroFrame","Blizzard_MacroUI",},--宏命令UI
	{"AchievementFrame","Blizzard_AchievementUI",{"AchievementFrame","Header"}},--成就UI
	{"CommunitiesFrame","Blizzard_Communities",},--公会与社区
	{"CollectionsJournal","Blizzard_Collections",},--藏品
	{"EncounterJournal","Blizzard_EncounterJournal",},--冒险手册
	{"CraftFrame","Blizzard_CraftUI",},--附魔
	{"InspectFrame","Blizzard_InspectUI",},--观察
	{"GuildBankFrame","Blizzard_GuildBankUI",},--公会银行
}
if tocversion<50000 then
	table.insert(UINameList_AddOn,{"TradeSkillFrame","Blizzard_TradeSkillUI"})--专业面板
	table.insert(UINameList_AddOn,{"PlayerTalentFrame","Blizzard_TalentUI"})--天赋UI 
	table.insert(UINameList_AddOn,{"AuctionFrame","Blizzard_AuctionUI"})--拍卖{"AuctionFrameBrowse","piglist"}	
elseif tocversion<110000 then
	table.insert(UINameList_AddOn,{"ClassTalentFrame","Blizzard_ClassTalentUI",})--天赋UI 
else
	table.insert(UINameList_AddOn,{"ProfessionsBookFrame","Blizzard_ProfessionsBook"})--专业
	table.insert(UINameList_AddOn,{"ProfessionsFrame","Blizzard_Professions"})--专业面板
	table.insert(UINameList_AddOn,{"AuctionHouseFrame","Blizzard_AuctionHouseUI"})--拍卖
	--table.insert(UINameList_AddOn,{"PlayerSpellsFrame","Blizzard_PlayerSpells"})--天赋UI 有BUG
end
local function add_Movebiaoti(oldbiaoti,point)
	local Movebiaoti = CreateFrame("Frame", nil, oldbiaoti);
	Movebiaoti:SetPoint("TOPLEFT",oldbiaoti,"TOPLEFT",0,0);
	Movebiaoti:SetPoint("BOTTOMRIGHT",oldbiaoti,"BOTTOMRIGHT",0,0);
	Movebiaoti:EnableMouse(true)
	return Movebiaoti
end
local function PIG_SetPoint(self)
   	local point, relativeTo, relativePoint, offsetX, offsetY=unpack(PIGA["BlizzardUI"][self:GetName()]["Point"])
	self:ClearAllPoints();
	self:SetPoint(point, relativeTo, relativePoint, offsetX, offsetY);
end
local function Moving(MovingUI,Frame)
	if MovingUI then
		local Frame = Frame or MovingUI
		local MovingUIName=MovingUI:GetName()
		PIGA["BlizzardUI"][MovingUIName]=PIGA["BlizzardUI"][MovingUIName] or {}
		--位置
		MovingUI:EnableMouse(true)
		MovingUI:SetMovable(true)
	 	MovingUI:SetClampedToScreen(true)
	 	Frame:RegisterForDrag("LeftButton")
	    Frame:HookScript("OnDragStart",function()
	        MovingUI:StartMoving();
	    end)
	    Frame:HookScript("OnDragStop",function()
	        MovingUI:StopMovingOrSizing()
	        if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
	        	local point, relativeTo, relativePoint, offsetX, offsetY = MovingUI:GetPoint()
	        	PIGA["BlizzardUI"][MovingUIName]=PIGA["BlizzardUI"][MovingUIName] or {}
	       		PIGA["BlizzardUI"][MovingUIName]["Point"]={point, relativeTo, relativePoint, offsetX, offsetY}
	       	end
	    end)

	    MovingUI:HookScript("OnShow",function(self)
	    	if PIGA["BlizzardUI"][MovingUIName] and PIGA["FramePlus"]["BlizzardUI_Move_Save"] and PIGA["BlizzardUI"][self:GetName()]["Point"] and #PIGA["BlizzardUI"][self:GetName()]["Point"]>0 then
		    	PIG_SetPoint(self)
		    	C_Timer.After(0,function() PIG_SetPoint(self) end)
		    	C_Timer.After(0.001,function() PIG_SetPoint(self) end)
		    end
	    end)
	    
	    --缩放
	    if PIGA["BlizzardUI"][MovingUIName]["Scale"] then
			MovingUI:SetScale(PIGA["BlizzardUI"][MovingUIName]["Scale"]);
		end
	    MovingUI:EnableMouseWheel(true);
	    MovingUI:HookScript("OnMouseWheel", function(self, arg1)
			if IsControlKeyDown() and IsAltKeyDown() then
				PIGA["BlizzardUI"][self:GetName()]["Scale"]=PIGA["BlizzardUI"][self:GetName()]["Scale"] or 1
	    		local vera = arg1*0.1
	    		local newbvv = PIGA["BlizzardUI"][self:GetName()]["Scale"]+vera
	    		if newbvv>=1.8 then
	    			PIGTopMsg:add("已达最大缩放比例: 1.8")
	    			PIGA["BlizzardUI"][self:GetName()]["Scale"]=1.8
	    		elseif newbvv<=0.6 then
	    			PIGTopMsg:add("已达最小缩放比例: 0.6")
	    			PIGA["BlizzardUI"][self:GetName()]["Scale"]=0.6
	    		else
	    			PIGA["BlizzardUI"][self:GetName()]["Scale"]=newbvv
	    			PIGTopMsg:add("当前缩放: "..PIGA["BlizzardUI"][self:GetName()]["Scale"])
	    		end
	    		self:SetScale(PIGA["BlizzardUI"][self:GetName()]["Scale"]);
			end
		end)
	end
end
--
function FramePlusfun.BlizzardUI_Move()
	if not PIGA['FramePlus']['BlizzardUI_Move'] then return end
	if PIGA["FramePlus"]["BlizzardUI_Move_Save"] then
		local oldshowframe = nil
		hooksecurefunc("UpdateUIPanelPositions", function(Frame)
			local Frame = Frame or oldshowframe
			if Frame and PIGA["BlizzardUI"][UIName] then
				local UIName = Frame:GetName()
				if UIName then
					oldshowframe=Frame
					if PIGA["BlizzardUI"][UIName]["Point"] and #PIGA["BlizzardUI"][UIName]["Point"]>0 then
				    	PIG_SetPoint(Frame)
				    end
				end
			end
		end)
	end
	for k,v in pairs(UINameList) do
		if v[2] then
			if v[2]=="add" then
				local Movebiaoti=add_Movebiaoti(v[3],point)
				Moving(v[1],Movebiaoti)
			else
				Moving(v[1],v[2])
			end
		else
			Moving(v[1])
		end
	end
	for k,v in pairs(UINameList_AddOn) do
		if IsAddOnLoaded(v[2]) then
			if v[3] then
				if type(v[3])=="table" then
					C_Timer.After(0.1,function()
						Moving(_G[v[1]],_G[v[3][1]][v[3][2]])
					end)
				else
					Moving(_G[v[1]],_G[v[3]])
				end
			else
				Moving(_G[v[1]])
			end
	    else
	        local shequFRAME = CreateFrame("FRAME")
	        shequFRAME:RegisterEvent("ADDON_LOADED")
	        shequFRAME:SetScript("OnEvent", function(self, event, arg1)
	            if arg1 == v[2] then
	            	if arg1=="Blizzard_Collections" then
	            		if WardrobeTransmogFrame then
		            		local checkBox = _G.WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox;
						    local label = checkBox.Label;
						    label:ClearAllPoints();
						    label:SetPoint('LEFT', checkBox, 'RIGHT', 2, 1);
						    label:SetPoint('RIGHT', checkBox, 'RIGHT', 160, 1);
						end
					end
					if v[3] then
						if type(v[3])=="table" then
							C_Timer.After(0.1,function()
								Moving(_G[v[1]],_G[v[3][1]][v[3][2]])
							end)
						else
							Moving(_G[v[1]],_G[v[3]])
						end
					else
						Moving(_G[v[1]])
					end
	                shequFRAME:UnregisterEvent("ADDON_LOADED")
	            end
	        end)
	    end
	end
end