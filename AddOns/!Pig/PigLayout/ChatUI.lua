local _, PD = ...;
local L=PD.locale
local Fun=PD.Fun
local PigLayoutFun=PD.PigLayoutFun
-----
local function Update_ChatFrameL()
	if not PIGA["PigLayout"]["ChatUI"]["Zhu"] then return end
	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["PigLayout"]["ChatUI"]["FuName"])
	local W,H,X,Y = unpack(PIGA["PigLayout"]["ChatUI"]["ZhuPoint"])
	-- local screenWidth, screenHeight = GetScreenWidth(), GetScreenHeight();
	-- local X,Y = X/screenWidth,Y/screenHeight
	for id = 1,NUM_CHAT_WINDOWS do
		if id~=pindaoid then
			local Frame=_G["ChatFrame"..id]
			Frame:SetClampRectInsets(-X, 35, 26, -Y);
			if id==1 then
				SetChatWindowSavedPosition(id, "BOTTOMLEFT", 0,0);
				SetChatWindowSavedDimensions(id, W,H);
				FCF_RestorePositionAndDimensions(Frame)
			end
		end
	end
end
local function Update_ChatFrameR(set)
	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["PigLayout"]["ChatUI"]["FuName"])
	if pindaoid>0 then
		local Frame=_G["ChatFrame"..pindaoid]
		FCF_UnDockFrame(Frame);
		SetChatWindowSavedPosition(pindaoid, "BOTTOMRIGHT", 0,0);
		local W,H,X,Y = unpack(PIGA["PigLayout"]["ChatUI"]["FuPoint"])
		Frame:SetClampRectInsets(35, X, 26, -Y);--left, right, top, bottom
		SetChatWindowSavedDimensions(pindaoid, W,H);
		FCF_RestorePositionAndDimensions(Frame)
		FCF_UpdateButtonSide(Frame);
		FCF_SetTabPosition(Frame, 0);
	end
end
function PigLayoutFun.ChatFrameFun(openxx)
	if not openxx then return end
	Update_ChatFrameL()
	Update_ChatFrameR()
	C_Timer.After(1,function() Update_ChatFrameR() end)
end
function PigLayoutFun.addOptions_ChatFrame(openxx)
if not openxx then return end
---
local Create=PD.Create
local PIGFrame=Create.PIGFrame
local PIGEnter=Create.PIGEnter
local PIGButton = Create.PIGButton
local PIGDownMenu=Create.PIGDownMenu
local PIGSlider = Create.PIGSlider
local PIGCheckbutton=Create.PIGCheckbutton
local PIGCheckbutton_R=Create.PIGCheckbutton_R
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGFontString=Create.PIGFontString
local PIGFontStringBG=Create.PIGFontStringBG
-----
local RTabFrame =PigLayoutFun.RTabFrame
local fujiF,fujiBut =PIGOptionsList_R(RTabFrame,CHAT..L["LIB_LAYOUT"],90)
fujiF.PailieT = PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-20},"经典版本暴雪已增加编辑模式，聊天布局请在编辑模式调整")
fujiF.PailieT:SetTextColor(0, 1, 0, 1);
fujiF.PailieT:SetJustifyH("LEFT");
if fujiF.PailieT then return end
--设置主聊天宽度
fujiF.ZhuOpen = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-10},{L["CHAT_ZHUCHATF"].."("..L["CHAT_ZHUNAME"]..")"})
fujiF.ZhuOpen:SetChecked(PIGA["PigLayout"]["ChatUI"]["Zhu"])
fujiF.ZhuOpen:SetScript("OnClick", function (self)
	if self:GetChecked() then
		PIGA["PigLayout"]["ChatUI"]["Zhu"]=true;
		Update_ChatFrameL()
	else
		PIGA["PigLayout"]["ChatUI"]["Zhu"]=false;
	end
	fujiF.zhuF.Update_Checkbut()
end);
fujiF.zhuF = PIGFrame(fujiF,{"TOP", fujiF, "TOP", 0, -34},{fujiF:GetWidth()-10, 200})
fujiF.zhuF:PIGSetBackdrop(0)

fujiF.zhuF.cz = PIGButton(fujiF.zhuF,{"TOPRIGHT",fujiF.zhuF,"TOPRIGHT",-20,-10},{60,22},RESET);
fujiF.zhuF.cz:SetScript("OnClick", function (self)
	PIGA["PigLayout"]["ChatUI"]["ZhuPoint"]=CopyTable(PD.Default["PigLayout"]["ChatUI"]["ZhuPoint"])
	Update_ChatFrameL()
	fujiF.zhuF.Update_Checkbut()
end);
fujiF.zhuF.Width = PIGSlider(fujiF.zhuF,{"TOPLEFT",fujiF.zhuF,"TOPLEFT",10,-8},{150,800,1,{["Right"]=L["LIB_WIDTH"].."%d"}},400)
function fujiF.zhuF.Width:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["ZhuPoint"][1]=arg1;
	Update_ChatFrameL()
end
fujiF.zhuF.Height = PIGSlider(fujiF.zhuF,{"TOPLEFT",fujiF.zhuF.Width,"BOTTOMLEFT",0,-8},{120,800,1,{["Right"]=L["LIB_HEIGHT"].."%d"}},400)
function fujiF.zhuF.Height:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["ZhuPoint"][2]=arg1;
	Update_ChatFrameL()
end
fujiF.zhuF.X = PIGSlider(fujiF.zhuF,{"TOPLEFT",fujiF.zhuF.Height,"BOTTOMLEFT",0,-8},{0,500,1,{["Right"]="左边距%d"}},400)
function fujiF.zhuF.X:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["ZhuPoint"][3]=arg1;
	Update_ChatFrameL()
end
fujiF.zhuF.Y = PIGSlider(fujiF.zhuF,{"TOPLEFT",fujiF.zhuF.X,"BOTTOMLEFT",0,-8},{0,500,1,{["Right"]="下边距%d"}},400)
function fujiF.zhuF.Y:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["ZhuPoint"][4]=arg1;
	Update_ChatFrameL()
end
-----
function fujiF.zhuF.Update_Checkbut()
	fujiF.zhuF:SetShown(PIGA["PigLayout"]["ChatUI"]["Zhu"])
	local W,H,X,Y = unpack(PIGA["PigLayout"]["ChatUI"]["ZhuPoint"])
	fujiF.zhuF.Width:PIGSetValue(W)
	fujiF.zhuF.Height:PIGSetValue(H)
	fujiF.zhuF.X:PIGSetValue(X)
	fujiF.zhuF.Y:PIGSetValue(Y)
end
fujiF.zhuF.Update_Checkbut()

--设置副聊天宽度
fujiF.ChatUIList=PIGDownMenu(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-240},{260,nil})
function fujiF.ChatUIList:PIGDownMenu_Update_But()
	local info = {}
	info.func = self.PIGDownMenu_SetValue
	local chuangkoulist=Fun.GetpindaoList()
	for k,v in pairs(chuangkoulist) do
	 	info.text, info.arg1 = v, k
	 	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["PigLayout"]["ChatUI"]["FuName"])
	 	info.checked = v == pindaoname
		self:PIGDownMenu_AddButton(info)
	end 
end
function fujiF.ChatUIList:PIGDownMenu_SetValue(value,arg1)
	self:PIGDownMenu_SetText(L["CHAT_LOOTNAME"]..":"..value)
	local OLDvalue=PIGA["PigLayout"]["ChatUI"]["FuName"]
	PIGA["PigLayout"]["ChatUI"]["FuName"]=value
	if arg1==0 then
		local pindaoid,pindaoname=Fun.GetSelectpindaoID(OLDvalue)
		if pindaoid>0 then
			local Frame=_G["ChatFrame"..pindaoid]
			FCF_DockFrame(Frame,3)
		end
	else
		Update_ChatFrameR(true)
	end
	fujiF.fuF.Update_Checkbut()
	PIGCloseDropDownMenus()
end
local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["PigLayout"]["ChatUI"]["FuName"])
fujiF.ChatUIList:PIGDownMenu_SetText(L["CHAT_LOOTNAME"]..":"..pindaoname)

fujiF.fuF = PIGFrame(fujiF,{"TOP", fujiF, "TOP", 0, -270},{fujiF:GetWidth()-10, 200})
fujiF.fuF:PIGSetBackdrop(0)

fujiF.fuF.cz = PIGButton(fujiF.fuF,{"TOPRIGHT",fujiF.fuF,"TOPRIGHT",-20,-10},{60,22},RESET);
fujiF.fuF.cz:SetScript("OnClick", function (self)
	PIGA["PigLayout"]["ChatUI"]["FuPoint"]=CopyTable(PD.Default["PigLayout"]["ChatUI"]["FuPoint"])
	Update_ChatFrameR(true)
	fujiF.fuF.Update_Checkbut()
end);
fujiF.fuF.Width = PIGSlider(fujiF.fuF,{"TOPLEFT",fujiF.fuF,"TOPLEFT",10,-8},{150,800,1,{["Right"]=L["LIB_WIDTH"].."%d"}},400)
function fujiF.fuF.Width:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["FuPoint"][1]=arg1;
	Update_ChatFrameR()
end
fujiF.fuF.Height = PIGSlider(fujiF.fuF,{"TOPLEFT",fujiF.fuF.Width,"BOTTOMLEFT",0,-8},{120,800,1,{["Right"]=L["LIB_HEIGHT"].."%d"}},400)
function fujiF.fuF.Height:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["FuPoint"][2]=arg1;
	Update_ChatFrameR()
end
fujiF.fuF.X = PIGSlider(fujiF.fuF,{"TOPLEFT",fujiF.fuF.Height,"BOTTOMLEFT",0,-8},{0,500,1,{["Right"]="右边距%d"}},400)
fujiF.fuF.X.bt = PIGFontString(fujiF.fuF.X,{"RIGHT", fujiF.fuF.X, "LEFT", -10, 0},"")
function fujiF.fuF.X:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["FuPoint"][3]=arg1;
	Update_ChatFrameR()
end
fujiF.fuF.Y = PIGSlider(fujiF.fuF,{"TOPLEFT",fujiF.fuF.X,"BOTTOMLEFT",0,-8},{0,500,1,{["Right"]="下边距%d"}},400)
function fujiF.fuF.Y:PIGOnValueChange(arg1)
	PIGA["PigLayout"]["ChatUI"]["FuPoint"][4]=arg1;
	Update_ChatFrameR()
end
--
function fujiF.fuF.Update_Checkbut()
	local pindaoid,pindaoname=Fun.GetSelectpindaoID(PIGA["PigLayout"]["ChatUI"]["FuName"])
	fujiF.fuF:SetShown(pindaoid>0)
	local W,H,X,Y = unpack(PIGA["PigLayout"]["ChatUI"]["FuPoint"])
	fujiF.fuF.Width:PIGSetValue(W)
	fujiF.fuF.Height:PIGSetValue(H)
	fujiF.fuF.X:PIGSetValue(X)
	fujiF.fuF.Y:PIGSetValue(Y)
end
-----
fujiF.fuF.Update_Checkbut()


-- --LOOT=======================================
-- --FCF_ResetChatWindows();--恢复聊天设置为默认
-- --FCF_ResetChatWindows(); -- 重置聊天设置
-- --FCF_SetLocked(_G.ChatFrame1, 1) --锁定聊天窗口移动
-- --FCF_DockFrame(_G.ChatFrame2,3)  --设置窗口是否停靠参数2为停靠位置
-- --FCF_UnDockFrame(_G["ChatFrame"..NewWindow_ID]); --分离窗口
-- --FCF_NewChatWindow(L["CHAT_LOOTFNAME"])--用户手动创建新窗口
-- --FCF_OpenNewWindow(L["CHAT_LOOTFNAME"]);--创建聊天窗口 
-- --FCF_SetWindowName(_G.ChatFrame2, "记录");
-- --FCF_UpdateButtonSide(_G["ChatFrame"..id]);--刷新按钮位置

-- fujiF.LOOTF = PIGFrame(fujiF,{"TOP", fujiF, "TOP", 0, -250},{fujiF:GetWidth()-20, 150})
-- fujiF.LOOTF:PIGSetBackdrop()
-- fujiF.LOOTF.add = PIGButton(fujiF.LOOTF,{"TOPLEFT",fujiF.LOOTF,"TOPLEFT",4,-8},{150,22},L["CHAT_LOOTFADD"]);
-- --重设窗口显示内容
-- local function ShowChannelFun()
-- 	--综合
-- 	if fujiF.Chatloot and PIGA["PigLayout"]["ChatUI"]["ShowChannel"] then
-- 		local chatGroup1 = { "SYSTEM", "CHANNEL", "SAY", "EMOTE", "YELL", "WHISPER", "PARTY", "PARTY_LEADER", "RAID", "RAID_LEADER", "RAID_WARNING", "INSTANCE_CHAT", "INSTANCE_CHAT_LEADER", "GUILD", "OFFICER", "MONSTER_SAY", "MONSTER_YELL", "MONSTER_EMOTE", "MONSTER_WHISPER", "MONSTER_BOSS_EMOTE", "MONSTER_BOSS_WHISPER", "ERRORS", "AFK", "DND", "IGNORED", "BG_HORDE", "BG_ALLIANCE", "BG_NEUTRAL", "ACHIEVEMENT", "GUILD_ACHIEVEMENT", "BN_WHISPER", "BN_INLINE_TOAST_ALERT","TARGETICONS" }
-- 		ChatFrameMixin.RemoveAllMessageGroups(DEFAULT_CHAT_FRAME)
-- 		for _, v in ipairs(chatGroup1) do
-- 			ChatFrameMixin.AddMessageGroup(DEFAULT_CHAT_FRAME, v)
-- 		end
-- 		--拾取窗口
-- 		local chatGroup3 = { "COMBAT_XP_GAIN", "COMBAT_HONOR_GAIN", "COMBAT_FACTION_CHANGE", "SKILL", "MONEY", "LOOT", "TRADESKILLS", "OPENING", "PET_INFO", "COMBAT_MISC_INFO" }
-- 		for id=1,NUM_CHAT_WINDOWS,1 do
-- 			local name, __ = GetChatWindowInfo(id);
-- 			if name==L["CHAT_LOOTFNAME"] then
-- 				ChatFrameMixin.RemoveAllMessageGroups(_G["ChatFrame"..id])
-- 				for _, v in ipairs(chatGroup3) do
-- 					ChatFrameMixin.AddMessageGroup(_G["ChatFrame"..id], v)
-- 				end
-- 				break
-- 			end
-- 		end
-- 		for id=1,NUM_CHAT_WINDOWS,1 do
-- 			local name, __ = GetChatWindowInfo(id);
-- 			if name==COMBAT_LOG then
-- 				FCF_SetWindowName(_G["ChatFrame"..id], COMBAT_LABEL);
-- 				break
-- 			end
-- 		end
-- 	end
-- end
-- local tishims = {L["CHAT_LOOTFNRSET"],L["CHAT_LOOTFNRSETTIPS"]}
-- fujiF.LOOTF.ShowChannel = PIGCheckbutton(fujiF.LOOTF,{"LEFT",fujiF.LOOTF.add,"RIGHT",60,-2},tishims)
-- fujiF.LOOTF.ShowChannel:SetScript("OnClick", function (self)
-- 	if self:GetChecked() then
-- 		PIGA["PigLayout"]["ChatUI"]["ShowChannel"]=true;
-- 	else
-- 		PIGA["PigLayout"]["ChatUI"]["ShowChannel"]=false;
-- 	end
-- 	ShowChannelFun()
-- end);
-- --提示
-- fujiF.LOOTF.tishi = CreateFrame("Frame", nil, fujiF.LOOTF);
-- fujiF.LOOTF.tishi:SetSize(30,30);
-- fujiF.LOOTF.tishi:SetPoint("LEFT",fujiF.LOOTF.add,"RIGHT",0,0);
-- fujiF.LOOTF.tishi.Texture = fujiF.LOOTF.tishi:CreateTexture(nil, "BORDER");
-- fujiF.LOOTF.tishi.Texture:SetTexture("interface/common/help-i.blp");
-- fujiF.LOOTF.tishi.Texture:SetAllPoints(fujiF.LOOTF.tishi)
-- PIGEnter(fujiF.LOOTF.tishi,L["LIB_TIPS"]..": ",L["CHAT_LOOTFTIPS"])
-- fujiF.LOOTF.ShowlootF = PIGButton(fujiF.LOOTF,{"TOPLEFT",fujiF.LOOTF,"TOPLEFT",410,-8},{150,22},L["CHAT_LOOTFFENLI"]);
-- fujiF.LOOTF.ShowlootF:SetScript("OnClick", function (self)
-- 	if fujiF.ChatlootID then
-- 		local lotofa = _G["ChatFrame"..fujiF.ChatlootID]
-- 		local lotofaTab = _G["ChatFrame"..fujiF.ChatlootID.."Tab"]
-- 		if lotofa:IsShown() then
-- 			lotofa:Hide()
-- 			lotofaTab:Hide()
-- 		else
-- 			--FCF_SetLocked(lotofa, 2)
-- 			FCF_UnDockFrame(lotofa);
-- 			lotofa:Show()
-- 			lotofaTab:Show()
-- 		end
-- 	end
-- end);
-- end
-- --拾取窗口位置
-- fujiF.Chatloot = false
-- fujiF.ChatlootNum=0
-- local function LOOT_cunzai()
-- 	if NUM_CHAT_WINDOWS~=nil then
-- 		for id=1,NUM_CHAT_WINDOWS,1 do
-- 			local name, __ = GetChatWindowInfo(id);
-- 			if name==L["CHAT_LOOTFNAME"] then
-- 				--print(name)
-- 				fujiF.Chatloot = true
-- 				fujiF.ChatlootID = id
-- 				return id
-- 			end
-- 		end
-- 	end
-- end
-- local function LOOT_SetValueText()
-- 	LOOT_cunzai()
-- 	if fujiF.Chatloot then
-- 		ShowChannelFun()

-- 	else
-- 		if fujiF.ChatlootNum<10 then
-- 			C_Timer.After(1, LOOT_SetValueText)
-- 			fujiF.ChatlootNum=fujiF.ChatlootNum+1
-- 		end
-- 	end
-- end
-- --创建拾取聊天窗口
-- fujiF.LOOTF.add:SetScript("OnClick", function ()
-- 	if fujiF.Chatloot then return end
-- 	if GetScreenWidth()<1024 then PIGErrorMsg(L["CHAT_LOOTFADDERR1"]) end
-- 	if FCF_GetNumActiveChatFrames()>=10 then PIGErrorMsg(L["CHAT_LOOTFADDERR2"]) end
-- 	FCF_OpenNewWindow(L["CHAT_LOOTFNAME"]);
-- 	ShowChannelFun()
-- 	local nEWid=LOOT_cunzai()
-- 	local chfff = _G["ChatFrame"..nEWid]
-- 	FCF_UnDockFrame(chfff);
-- 	chfff:ClearAllPoints();
-- 	chfff:SetPoint("BOTTOMRIGHT",UIParent,"BOTTOMRIGHT",-PIGA["PigLayout"]["ChatUI"]["Loot_Point_X"],PIGA["PigLayout"]["ChatUI"]["Loot_Point_Y"]);
-- 	_G["ChatFrame"..nEWid.."Tab"]:ClearAllPoints();
-- 	_G["ChatFrame"..nEWid.."Tab"]:SetPoint("BOTTOMLEFT", _G["ChatFrame"..nEWid.."Background"], "TOPLEFT", 2, 0);
-- 	FCF_UpdateButtonSide(chfff);--刷新按钮位置
-- 	LOOT_Width_Heigh_Point_XY()
-- end)
-- ----
-- fujiF.LOOTF:HookScript("OnShow", function(self)
-- 	LOOT_Width_Heigh_Point_XY()
-- 	fujiF.LOOTF.ShowChannel:SetChecked(PIGA["PigLayout"]["ChatUI"]["ShowChannel"])
-- end)
-- ---重置聊天设置
-- fujiF.ReChatBut = PIGButton(fujiF,{"BOTTOMLEFT",fujiF,"BOTTOMLEFT",14,14},{120,24},L["CHAT_RECHATBUT"]);
-- fujiF.ReChatBut:SetScript("OnClick", function ()
-- 	FCF_ResetChatWindows();
-- end)
--导入其他角色聊天设置
local function SavedangqianSet()--保存当前设置
    -- local Data=PD.Data
	-- local PlayerInfo=Data.PlayerInfo
	-- local PIG_renwuming = PlayerInfo.AllName
	-- local dangqianChatSET={}
	-- --for id=1,MAX_WOW_CHAT_CHANNELS do
	-- for id=1,3 do
	-- 	local name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable = GetChatWindowInfo(id);
	-- 	--local name, __ = GetChatWindowInfo(id);
	-- 	print(name, fontSize, r, g, b, alpha, shown, locked, docked, uninteractable)
	-- 	local type1 = {GetChatWindowMessages(id)}
	-- 	for i=1,#type1 do
	-- 		print(type1[i])
	-- 	end
	-- 	print("++=====")
	-- 	local name1 = {GetChatWindowChannels(id)}
	-- 	for i=1,#name1 do
	-- 		print(name1[i])
	-- 	end
	-- end

	-- PIGA["Chat"]["ChatSetSave"][PIG_renwuming]=dangqianChatSET
end
-- fujiF.daoruqitaSet =PIGDownMenu(fujiF,{"BOTTOMLEFT",fujiF,"BOTTOMLEFT",20,14},{200,nil})
-- function fujiF.daoruqitaSet:PIGDownMenu_Update_But()
-- 	local Setinfo =PIGA["Chat"]["ChatSetSave"]
-- 	local info = {}
-- 	info.func = self.PIGDownMenu_SetValue
-- 	for k,v in pairs(Setinfo) do
-- 		print(k,v)
-- 		info.text, info.arg1 = L["CONFIG_DAORU"].."<"..k..">"..L["CONFIG_TABNAME"],v
-- 		self:PIGDownMenu_AddButton(info)
-- 	end
-- end
-- function fujiF.daoruqitaSet:PIGDownMenu_SetValue(value,arg1)
-- 	self:PIGDownMenu_SetText(L["CHAT_DAORUQITASET"])
-- 	print(value,arg1)	
-- 	PIGA["Chat"]["ChatSetSave"][PIG_renwuming]=arg1
-- 	PIGCloseDropDownMenus()
-- end
-- fujiF.daoruqitaSet:PIGDownMenu_SetText(L["CHAT_DAORUQITASET"])
end