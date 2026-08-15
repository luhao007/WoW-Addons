local addonName, addonTable = ...;
local GDKPInfo = {}
addonTable.GDKPInfo=GDKPInfo
local Create, Data, Fun, L, Default, Default_Per= unpack(PIG)
local adddata=L.ExtList[addonName]
local GnName,GnUI,GnIcon,FrameLevel,QuickBut_index = adddata.nameLocale,"PIG_GDKPUI",133784,50,30
GDKPInfo.uidata={GnName,GnUI,GnIcon,FrameLevel,QuickBut_index}
----
adddata.LoadFun=function()
	GDKPInfo.ADD_UI()
end
local UIfun_yijiazai
adddata.Update_SetUI=function()
	if adddata.open==false then return end
	if UIfun_yijiazai then return end
	UIfun_yijiazai=true
	local fuFrame,fuFrameBut=unpack(adddata.SetUIData)
	----
	local PlayerInfo=Data.PlayerInfo

	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGEnter=Create.PIGEnter
	local PIGButton = Create.PIGButton
	local PIGDiyBut=Create.PIGDiyBut
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGCheckbutton_R=Create.PIGCheckbutton_R
	local PIGFontString=Create.PIGFontString
	local PIGModCheckbutton=Create.PIGModCheckbutton
	local PIGSetFont=Create.PIGSetFont

	local Key_fenge=Fun.Key_fenge
	fuFrame.Open = PIGModCheckbutton(fuFrame,{GnName,Tooltip},{"TOPLEFT",fuFrame,"TOPLEFT",20,-20})
	fuFrame.Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Open"]=true;
			GDKPInfo.ADD_UI()
		else
			PIGA["GDKP"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		Fun.QuickBut_Update()
		fuFrame.SetListF.Update_SetUI()
	end);
	fuFrame.Open.QKBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["AddBut"]=true
		else
			PIGA["GDKP"]["AddBut"]=false
		end
		Fun.QuickBut_Update()
	end);
	fuFrame.Open:SetChecked(PIGA["GDKP"]["Open"])
	fuFrame.Open.QKBut:SetChecked(PIGA["GDKP"]["AddBut"])

	---========
	fuFrame.SetListF = PIGFrame(fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT",0,-50})
	fuFrame.SetListF:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
	fuFrame.SetListF:PIGSetBackdrop(0)
	---重置
	fuFrame.SetListF.CZ = PIGButton(fuFrame.SetListF,{"BOTTOMRIGHT",fuFrame.SetListF,"TOPRIGHT",-20,10},{60,22},RESET);  
	fuFrame.SetListF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show ("PIGRESET_GDKP_INFO");
	end);
	StaticPopupDialogs["PIGRESET_GDKP_INFO"] = {
		text = string.format(L["RELOADUI2"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["GDKP"] = CopyTable(Default["GDKP"])
			PIGA["GDKP"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--
	local autofentishi = "开启后队长分配模式下且你是战利品分配人会自动分配掉落到自己背包(分配品质"..KEY_BUTTON2.."点击自己头像设置)\n"..
	"|cffFF0000不会分配任务物品，也不会分配埃提耶什的碎片/瓦兰奈尔的碎片/影霜碎片/烂肠的酸性血液/腐面的酸性血液。|r\n开启此功能后会在队伍/团队频道发送拾取明细"
	fuFrame.SetListF.autofen = PIGCheckbutton(fuFrame.SetListF,{"TOPLEFT",fuFrame.SetListF,"TOPLEFT",20,-20},{"自动分配物品给自己\124cff00FF00(你必须是战利品分配人)\124r",autofentishi})
	fuFrame.SetListF.autofen:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["autofen"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["autofen"]=false;
		end
		GDKPInfo.AutoLootfenEvent()
	end);
	fuFrame.SetListF.autofenMsg = PIGCheckbutton_R(fuFrame.SetListF,{"分配后通告","自动分配物品后通告分配物品"},true)
	fuFrame.SetListF.autofenMsg:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["autofenMsg"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["autofenMsg"]=false;
		end
	end);
	
	----副本外
	fuFrame.SetListF.fubenwai = PIGCheckbutton_R(fuFrame.SetListF,{"记录副本外拾取","开启后会记录副本外的拾取信息（默认只记录团队副本内掉落）"},true)
	fuFrame.SetListF.fubenwai:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["fubenwai"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["fubenwai"]=false;
		end
	end);

	--5人本
	fuFrame.SetListF.wurenben = PIGCheckbutton_R(fuFrame.SetListF,{"记录5人本拾取","开启后会记录5人本拾取信息（默认只记录团队副本内掉落）"},true)
	fuFrame.SetListF.wurenben:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["wurenben"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["wurenben"]=false;
		end
	end);

	--手动添加物品
	fuFrame.SetListF.shoudongloot = PIGCheckbutton_R(fuFrame.SetListF,{"手动添加物品","开启后按住shift点击聊天栏物品链接添加物品到拾取目录（注意必须保持拾取目录列表为打开状态）"},true)
	fuFrame.SetListF.shoudongloot:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["shoudongloot"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["shoudongloot"]=false;
		end
	end);
	--拾取物品倒计时
	fuFrame.SetListF.jiaoyidaojishi = PIGCheckbutton_R(fuFrame.SetListF,{"物品可交易倒计时通告","启用后，物品可交易时间低于10分钟将会在团队频道提示，预估时间仅供参考\n注意此通告不会在战斗中执行"},true)
	fuFrame.SetListF.jiaoyidaojishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["jiaoyidaojishi"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["jiaoyidaojishi"]=false;
		end
	end);

	--交易记录==================================
	local jiaoyijiluTS="1.交易拾取目录内物品自动录入成交人/成交金额(交易多件物品收到金额将会被平分)\n2.对方交易欠款时自动清欠并显示明细\n3.你发放工资时自动扣除欠款并显示明细"
	fuFrame.SetListF.jiaoyijilu = PIGCheckbutton_R(fuFrame.SetListF,{"交易智能记账清欠",jiaoyijiluTS},true)
	fuFrame.SetListF.jiaoyijilu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["jiaoyijilu"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["jiaoyijilu"]=false;
		end
	end);
	fuFrame.SetListF.tradetonggao = PIGCheckbutton_R(fuFrame.SetListF,{"通告交易详情","在团队频道通告交易详情"},true)
	fuFrame.SetListF.tradetonggao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["tradetonggao"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["tradetonggao"]=false;
		end
	end);
	--================================================
	fuFrame.SetListF.zidonghuifuYY = PIGCheckbutton_R(fuFrame.SetListF,{"自动回复语音工具\124cff00FF00(你必须是队长或团长)\124r","开启后,收到队伍或者团队人员咨询语音工具(例：TS,YY)频道ID会自动回复预设内容"},true)
	fuFrame.SetListF.zidonghuifuYY:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["GDKP"]["Rsetting"]["zidonghuifuVoice"]=true;
		else
			PIGA["GDKP"]["Rsetting"]["zidonghuifuVoice"]=false;
		end
		GDKPInfo.zidonghuifuEvent()
	end);
	--触发关键字
	fuFrame.SetListF.zidonghuifuYY.biaoti = PIGFontString(fuFrame.SetListF,{"TOPLEFT", fuFrame.SetListF.zidonghuifuYY, "BOTTOMLEFT", 0,-6},"触发关键字(用，分隔):");
	fuFrame.SetListF.zidonghuifuYY.F = PIGFrame(fuFrame.SetListF,{"TOPLEFT", fuFrame.SetListF.zidonghuifuYY.biaoti, "BOTTOMLEFT", 0,-2},{320,26});
	fuFrame.SetListF.zidonghuifuYY.F:PIGSetBackdrop()
	fuFrame.SetListF.zidonghuifuYY.E = CreateFrame("EditBox", nil, fuFrame.SetListF.zidonghuifuYY.F);
	fuFrame.SetListF.zidonghuifuYY.E:SetPoint("TOPLEFT", fuFrame.SetListF.zidonghuifuYY.F, "TOPLEFT", 8,-6);
	fuFrame.SetListF.zidonghuifuYY.E:SetPoint("BOTTOMRIGHT", fuFrame.SetListF.zidonghuifuYY.F, "BOTTOMRIGHT", -8,6);
	fuFrame.SetListF.zidonghuifuYY.E:SetFontObject(ChatFontNormal);
	fuFrame.SetListF.zidonghuifuYY.E:SetAutoFocus(false);
	fuFrame.SetListF.zidonghuifuYY.E:SetMaxLetters(22);
	fuFrame.SetListF.zidonghuifuYY.E:SetTextColor(0.6, 0.6, 0.6, 1);
	fuFrame.SetListF.zidonghuifuYY.E:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.SetListF.zidonghuifuYY.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.SetListF.zidonghuifuYY.E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.SetListF.zidonghuifuYY.E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1);
		local guanjianV = self:GetText();
		local guanjianshuzu = guanjianV:gsub("，", ",")
		local guanjianzilist = Key_fenge(guanjianshuzu, ",")
		PIGA["GDKP"]["Rsetting"]["YYguanjianzi"]=guanjianzilist;
		GDKPInfo.zidonghuifuEvent()
	end);
	--回复内容
	fuFrame.SetListF.zidonghuifuYY.NR_biaoti = PIGFontString(fuFrame.SetListF,{"TOPLEFT", fuFrame.SetListF.zidonghuifuYY.F, "BOTTOMLEFT", 0,-6},"回复内容:");
	fuFrame.SetListF.zidonghuifuYY.NR = PIGFrame(fuFrame.SetListF,{"TOPLEFT", fuFrame.SetListF.zidonghuifuYY.NR_biaoti, "BOTTOMLEFT", 0,-2},{320,26});
	fuFrame.SetListF.zidonghuifuYY.NR:PIGSetBackdrop()
	fuFrame.SetListF.zidonghuifuYY.NR_E = CreateFrame("EditBox", nil, fuFrame.SetListF.zidonghuifuYY.NR);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetPoint("TOPLEFT", fuFrame.SetListF.zidonghuifuYY.NR, "TOPLEFT", 8,-6);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetPoint("BOTTOMRIGHT", fuFrame.SetListF.zidonghuifuYY.NR, "BOTTOMRIGHT", -8,6);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetFontObject(ChatFontNormal);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetAutoFocus(false);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetMaxLetters(40);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetTextColor(0.6, 0.6, 0.6, 1);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1);
		PIGA["GDKP"]["Rsetting"]["YYneirong"]=self:GetText();
	end);

	--过滤排除物品============================================
	local paichu_Height,paichu_NUM  = 23.6, 18;
	-----------
	fuFrame.SetListF.Paichu = PIGFrame(fuFrame.SetListF,{"TOPLEFT", fuFrame.SetListF, "TOPRIGHT", -260, -28})
	fuFrame.SetListF.Paichu:SetPoint("BOTTOMRIGHT", fuFrame.SetListF, "BOTTOMRIGHT", -6, 6)
	fuFrame.SetListF.Paichu:PIGSetBackdrop()
	fuFrame.SetListF.Paichu.biaoti = PIGFontString(fuFrame.SetListF.Paichu,{"BOTTOMLEFT", fuFrame.SetListF.Paichu, "TOPLEFT", 4, 4},"\124cffFF0000拾取忽略目录\124r");
	--提示
	fuFrame.SetListF.Paichu.biaoti_tishi = CreateFrame("Frame", nil, fuFrame.SetListF.Paichu);
	fuFrame.SetListF.Paichu.biaoti_tishi:SetSize(30,30);
	fuFrame.SetListF.Paichu.biaoti_tishi:SetPoint("LEFT",fuFrame.SetListF.Paichu.biaoti,"RIGHT",-6,0);
	fuFrame.SetListF.Paichu.biaoti_tishi.Tex = fuFrame.SetListF.Paichu.biaoti_tishi:CreateTexture(nil, "BORDER");
	fuFrame.SetListF.Paichu.biaoti_tishi.Tex:SetTexture("interface/common/help-i.blp");
	fuFrame.SetListF.Paichu.biaoti_tishi.Tex:SetAllPoints(fuFrame.SetListF.Paichu.biaoti_tishi)
	PIGEnter(fuFrame.SetListF.Paichu.biaoti_tishi,"提示：","\124cff00ff00拾取记录页面"..KEY_BUTTON2.."点击物品名添加为不记录.\124r")
	fuFrame.SetListF.Paichu.Scroll = CreateFrame("ScrollFrame",nil,fuFrame.SetListF.Paichu, "FauxScrollFrameTemplate");  
	fuFrame.SetListF.Paichu.Scroll:SetPoint("TOPLEFT",fuFrame.SetListF.Paichu,"TOPLEFT",0,0);
	fuFrame.SetListF.Paichu.Scroll:SetPoint("BOTTOMRIGHT",fuFrame.SetListF.Paichu,"BOTTOMRIGHT",-19,2);
	fuFrame.SetListF.Paichu.Scroll.ScrollBar:SetScale(0.8);
	fuFrame.SetListF.Paichu.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, paichu_Height, fuFrame.SetListF.Paichu.Update_hang)
	end)
	local Paichuww = fuFrame.SetListF.Paichu:GetWidth()
	fuFrame.SetListF.Paichu.ButList = {}
	for id = 1, paichu_NUM do
		local Pcwupin = CreateFrame("Frame", nil, fuFrame.SetListF.Paichu);
		fuFrame.SetListF.Paichu.ButList[id]=Pcwupin
		Pcwupin:SetSize(Paichuww-19, paichu_Height);
		if id==1 then
			Pcwupin:SetPoint("TOPLEFT",fuFrame.SetListF.Paichu.Scroll,"TOPLEFT",0,0);
		else
			Pcwupin:SetPoint("TOP",fuFrame.SetListF.Paichu.ButList[id-1],"BOTTOM",0,0);
		end
		if id~=paichu_NUM then
			Pcwupin.line = PIGLine(Pcwupin,"BOT",nil,nil,nil,{0.3,0.3,0.3,0.3})
		end
		Pcwupin.del=PIGDiyBut(Pcwupin,{"LEFT", Pcwupin, "LEFT", 4,0},{paichu_Height-6})
		Pcwupin.del:SetScript("OnClick", function (self)
			table.remove(PIGA["GDKP"]["Rsetting"]["PaichuList"], self:GetID());
			fuFrame.SetListF.Paichu.Update_hang(fuFrame.SetListF.Paichu.Scroll);
		end);
		Pcwupin.item = CreateFrame("Frame", nil, Pcwupin);
		Pcwupin.item:SetSize(Paichuww-51,paichu_Height);
		Pcwupin.item:SetPoint("LEFT",Pcwupin.del,"RIGHT",0,0);
		Pcwupin.item.icon = Pcwupin.item:CreateTexture(nil, "BORDER");
		Pcwupin.item.icon:SetSize(paichu_Height-4,paichu_Height-4);
		Pcwupin.item.icon:SetPoint("LEFT", Pcwupin.item, "LEFT", 0,0);
		Pcwupin.item.link = PIGFontString(Pcwupin.item,{"LEFT", Pcwupin.item.icon, "RIGHT", 1,0});
	end
	fuFrame.SetListF.Paichu:HookScript("OnShow", function (self)
		fuFrame.SetListF.Paichu.Update_hang(self.Scroll);
	end)
	function fuFrame.SetListF.Paichu.Update_hang(self)
		for id = 1, paichu_NUM do
			fuFrame.SetListF.Paichu.ButList[id]:Hide();
	    end
	    local paichumulu = PIGA["GDKP"]["Rsetting"]["PaichuList"]
	    local ItemsNum = #paichumulu
		if ItemsNum>0 then
			FauxScrollFrame_Update(self, ItemsNum, paichu_NUM, paichu_Height);
			local offset = FauxScrollFrame_GetOffset(self);
			for id = 1, paichu_NUM do
				local dangqianH = id+offset;
				if paichumulu[dangqianH] then
					local fujik=fuFrame.SetListF.Paichu.ButList[id]
					fujik:Show();
					fujik.del:SetID(dangqianH);
					local itemName, itemLink, _, _, _, _, _, _,_, itemTexture=GetItemInfo(paichumulu[dangqianH]);
			    	fujik.item.icon:SetTexture(itemTexture);
					fujik.item.link:SetText(itemLink);
					fujik.item:SetScript("OnMouseDown", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
						GameTooltip:SetHyperlink(itemLink)
					end);
					fujik.item:SetScript("OnMouseUp", function ()
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				end
			end
		end
	end
	fuFrame.SetListF.Paichu.Update_hang(fuFrame.SetListF.Paichu.Scroll);
	fuFrame.SetListF.autofen:SetChecked(PIGA["GDKP"]["Rsetting"]["autofen"]);
	fuFrame.SetListF.autofenMsg:SetChecked(PIGA["GDKP"]["Rsetting"]["autofenMsg"]);
	fuFrame.SetListF.jiaoyidaojishi:SetChecked(PIGA["GDKP"]["Rsetting"]["jiaoyidaojishi"]);
	fuFrame.SetListF.fubenwai:SetChecked(PIGA["GDKP"]["Rsetting"]["fubenwai"]);
	fuFrame.SetListF.wurenben:SetChecked(PIGA["GDKP"]["Rsetting"]["wurenben"]);
	fuFrame.SetListF.shoudongloot:SetChecked(PIGA["GDKP"]["Rsetting"]["shoudongloot"]);
	fuFrame.SetListF.jiaoyijilu:SetChecked(PIGA["GDKP"]["Rsetting"]["jiaoyijilu"]);
	fuFrame.SetListF.tradetonggao:SetChecked(PIGA["GDKP"]["Rsetting"]["tradetonggao"]);
	fuFrame.SetListF.zidonghuifuYY:SetChecked(PIGA["GDKP"]["Rsetting"]["zidonghuifuVoice"]);
	local huifuYY_guanjianzineirong="";
	for i=1,#PIGA["GDKP"]["Rsetting"]["YYguanjianzi"] do
		if i~=#PIGA["GDKP"]["Rsetting"]["YYguanjianzi"] then
			huifuYY_guanjianzineirong=huifuYY_guanjianzineirong..PIGA["GDKP"]["Rsetting"]["YYguanjianzi"][i].."，"
		else
			huifuYY_guanjianzineirong=huifuYY_guanjianzineirong..PIGA["GDKP"]["Rsetting"]["YYguanjianzi"][i]
		end
	end
	fuFrame.SetListF.zidonghuifuYY.E:SetText(huifuYY_guanjianzineirong)
	fuFrame.SetListF.zidonghuifuYY.NR_E:SetText(PIGA["GDKP"]["Rsetting"]["YYneirong"])
	function fuFrame.SetListF.Update_SetUI()
		fuFrame.SetListF:SetShown(PIGA["GDKP"]["Open"])
	end
	fuFrame.SetListF.Update_SetUI()
end

-------
function PIGCompartmentClick_GDKP()
end
function PIGCompartmentEnter_GDKP(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(menuButtonFrame, "ANCHOR_BOTTOMLEFT",-2,16);
	GameTooltip:AddLine("|cffFF00FF"..addonName.."|r-"..PIGGetAddOnMetadata(addonName, "Version"))
	GameTooltip:Show();	
end
function PIGCompartmentLeave_GDKP(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end