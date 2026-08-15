local addonName, addonTable = ...;
--
local L=addonTable.locale
local Data=addonTable.Data
local Fun=addonTable.Fun
local Create=addonTable.Create
local PIGLine=Create.PIGLine
local PIGFrame=Create.PIGFrame
local PIGButton = Create.PIGButton
local PIGFontString=Create.PIGFontString
local PIGOptionsList_R=Create.PIGOptionsList_R
local PIGTabBut=Create.PIGTabBut
------
local BusinessInfo=addonTable.BusinessInfo
local shibaiERR = {
	ERR_TRADE_BAG,--"你不能交易装有物品的包";
	ERR_TRADE_BAG_FULL,--"交易失败，你没有足够的物品栏空间。";
	ERR_TRADE_BLOCKED_S,--"%s要求进行交易，你拒绝了。";
	ERR_TRADE_BOUND_ITEM,--"你不能交易一件灵魂绑定物品";
	ERR_TRADE_CANCELLED,--"交易取消。";
	ERR_TRADE_EQUIPPED_BAG,--"你无法交易已经装备的包裹。";
	ERR_TRADE_FACTION_SPECIFIC,--"你无法与对立阵营交易阵营特色物品。";
	ERR_TRADE_GROUND_ITEM,--"你不能交易一件还放在地上的物品。";
	ERR_TRADE_MAX_COUNT_EXCEEDED,--"你拥有超过一件";
	ERR_TRADE_NOT_ON_TAPLIST,--"你只能将绑定物品交易给拥有该物品起始拾取资格的玩家。";
	ERR_TRADE_QUEST_ITEM,--"你不能交易一件任务物品";
	ERR_TRADE_REQUEST_S,--"%s想要和你进行交易。";
	ERR_TRADE_SELF,--"你不能与自己交易。";
	ERR_TRADE_TARGET_BAG_FULL,--"交易失败，交易目标没有足够的物品栏空间。";
	ERR_TRADE_TARGET_DEAD,--"你不能和已死亡的玩家交易";
	ERR_TRADE_TARGET_MAX_COUNT_EXCEEDED,--"交易对象已经拥有该类唯一物品。";
	ERR_TRADE_TARGET_MAX_LIMIT_CATEGORY_COUNT_EXCEEDED_IS,--"你的交易对象只能携带%d个%s";
	ERR_TRADE_TEMP_ENCHANT_BOUND,--"你不能交易带有临时附魔的物品。";
	ERR_TRADE_TOO_FAR,--"交易目标太远";
	ERR_TRADE_WRONG_REALM,--"你只能与来自其它服务器的玩家交易魔法制造的物品";
}
local function IsErrTrade(arg2)
	for k,v in pairs(shibaiERR) do
		if arg2==v then
			return true
		end
	end
	return false
end
Fun.IsErrTrade=IsErrTrade
function BusinessInfo.Trade(StatsUI)
	local GNcfName="TradeData"
   	local PlayerData = PIGA["StatsInfo"]["Players"]
	local TradeData = PIGA["StatsInfo"][GNcfName]
	TradeData[StatsUI.allname]=TradeData[StatsUI.allname] or {}
	local MAX_RECORDS = 100
	for playerId, _ in pairs(PlayerData) do
	    local tradeInfo = TradeData[playerId]
	    if tradeInfo and #tradeInfo>0 and #tradeInfo[1] > MAX_RECORDS then
	        local excess = #tradeInfo[1] - MAX_RECORDS
	        for _ = 1, excess do
	            table.remove(tradeInfo[1], 1)
	            table.remove(tradeInfo[2], 1)
	        end
	    end
	end
	---
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsUI.F,TRADE,StatsUI.butW,"LeftH")
	---
	fujiF.LF=PIGFrame(fujiF)
	fujiF.LF:PIGSetBackdrop(0)
	fujiF.LF:SetWidth(190)
	fujiF.LF:SetPoint("TOPLEFT",fujiF,"TOPLEFT",0,0);
	fujiF.LF:SetPoint("BOTTOMLEFT",fujiF,"BOTTOMLEFT",0,0);
	fujiF.Scroll_L=BusinessInfo.addhangMode1("trade",fujiF.LF)

	--日期列表
	fujiF.TimeList=PIGFrame(fujiF)
	fujiF.TimeList:SetWidth(106)
	fujiF.TimeList:SetPoint("TOPLEFT",fujiF.LF,"TOPRIGHT",2,0);
	fujiF.TimeList:SetPoint("BOTTOMLEFT",fujiF.LF,"BOTTOMRIGHT",0,0);
	local T_hang_Height= 24
	fujiF.Scroll_R = Create.PIGScrollFrame(fujiF.TimeList,T_hang_Height)
	function fujiF.Scroll_R.Update_Hang(hangL, elementData)
		if not hangL.highlight then
			hangL.highlight = hangL:CreateTexture(nil,"HIGHLIGHT");
			hangL.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
			hangL.highlight:SetBlendMode("ADD")
			hangL.highlight:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,0);
			hangL.highlight:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,0);
			hangL.highlight:SetAlpha(0.3);
			hangL.highlight1 = hangL:CreateTexture();
			hangL.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
			hangL.highlight1:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,0);
			hangL.highlight1:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,0);
			hangL.highlight1:SetAlpha(0.8);
			hangL.highlight1:Hide();
			hangL.Title = PIGFontString(hangL,{"LEFT", hangL, "LEFT", 6, 0})
			hangL.Title:SetTextColor(0,250/255,154/255, 1);
			hangL:SetScript("OnClick", function (self)
				fujiF.SelectTime=self:GetID()
				fujiF.Scroll_R:Update_list()
				fujiF.Scroll_RR:Update_list()
			end)
		end
		local idX=elementData.id
		local dataX=elementData.data
		hangL:SetID(idX)
		hangL.Title:SetText(date("%Y-%m-%d",dataX*86400));
		hangL.highlight1:SetShown(idX==fujiF.SelectTime)
		local Color=idX==fujiF.SelectTime and {1,1,1} or {0,250/255,154/255}
		hangL.Title:SetTextColor(unpack(Color));
	end
	function fujiF.Scroll_R:Update_list()
	    local view = self.ScrollBox:GetView()
	    if not self.dataProvider then
	        self.dataProvider = CreateDataProvider()
	        view:SetDataProvider(self.dataProvider)
		end
		self.dataProvider:Flush()
		if not fujiF.SelectName then return end
		local TimeDataX=PIGA["StatsInfo"][GNcfName][fujiF.SelectName]
		if TimeDataX and TimeDataX[1] then
			local TimeNum=#TimeDataX[1]
			fujiF.SelectTime=fujiF.SelectTime and fujiF.SelectTime<=TimeNum and fujiF.SelectTime or TimeNum
		    for i = TimeNum,1,-1 do
		        self.dataProvider:Insert({id=i,data=TimeDataX[1][i]});
		    end
		end
	end

	-------
	fujiF.ListRR=PIGFrame(fujiF)
	fujiF.ListRR:PIGSetBackdrop(0)
	fujiF.ListRR:SetPoint("TOPLEFT",fujiF.TimeList,"TOPRIGHT",2,0);
	fujiF.ListRR:SetPoint("BOTTOMRIGHT",fujiF,"BOTTOMRIGHT",0,2);
	fujiF.ListRR.BotF=PIGFrame(fujiF.ListRR,{"BOTTOMLEFT",fujiF.ListRR,"BOTTOMLEFT",0,0})
	fujiF.ListRR.BotF:SetPoint("BOTTOMRIGHT",fujiF.ListRR,"BOTTOMRIGHT",0,0);
	fujiF.ListRR.BotF:PIGSetBackdrop(0)
	fujiF.ListRR.BotF:SetHeight(24)
	fujiF.ListRR.BotF.JiluNumT = PIGFontString(fujiF.ListRR.BotF,{"LEFT",fujiF.ListRR.BotF,"LEFT",10,0},L["TRADECHARDATA_TRADE1"])
	fujiF.ListRR.BotF.JiluNum = PIGFontString(fujiF.ListRR.BotF,{"LEFT",fujiF.ListRR.BotF.JiluNumT,"RIGHT",2,0},0)
	fujiF.ListRR.BotF.JiluNum:SetTextColor(1, 1, 1, 1);
	fujiF.ListRR.BotF.DELtimeall=PIGButton(fujiF.ListRR.BotF,{"RIGHT",fujiF.ListRR.BotF,"RIGHT",-140,0},{60,18},DELETE)
	fujiF.ListRR.BotF.DELtimeall:SetScript("OnClick", function(self, button)
		StaticPopup_Show("PIGTRADELISTTIMENR_DEL");
	end)
	StaticPopupDialogs["PIGTRADELISTTIMENR_DEL"] = {
		text = L["TRADECHARDATA_TRADE2"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if fujiF.SelectName and PIGA["StatsInfo"][GNcfName][fujiF.SelectName] then
				table.remove(PIGA["StatsInfo"][GNcfName][fujiF.SelectName][1],fujiF.SelectTime);
				table.remove(PIGA["StatsInfo"][GNcfName][fujiF.SelectName][2],fujiF.SelectTime);
				fujiF.Scroll_R:Update_list()
				fujiF.Scroll_RR:Update_list()
			end
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	local N_hang_Height = 40
	fujiF.Scroll_RR = Create.PIGScrollFrame(fujiF.ListRR,N_hang_Height)
	function fujiF.Scroll_RR.Update_Hang(hangL, elementData)
		local idX=elementData.id
		local dataX=elementData.data
		if not hangL.bg1 then
			hangL.bg1 = hangL:CreateTexture();
			hangL.bg1:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
			hangL.bg1:SetBlendMode("ADD")
			hangL.bg1:SetPoint("TOPLEFT", hangL, "TOPLEFT", 0,0);
			hangL.bg1:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", 0,0);
			local tmp1,tmp2 = math.modf(idX/2)
			if tmp2==0 then
				hangL.bg1:SetColorTexture(0.3, 0.3, 0.3, 0.2);
			else
				hangL.bg1:SetColorTexture(0.1, 0.1, 0.1, 0.2)
			end
			hangL.highlight = hangL:CreateTexture(nil,"HIGHLIGHT");
			hangL.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
			hangL.highlight:SetBlendMode("ADD")
			hangL.highlight:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,0);
			hangL.highlight:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,0);
			hangL.highlight:SetAlpha(0.3);
			hangL.Title = PIGFontString(hangL,{"LEFT", hangL, "LEFT", 2, 0})
			hangL.Title:SetTextColor(0.9, 0.9, 0.9, 0.9);
			hangL.Race = hangL:CreateTexture();
			hangL.Race:SetPoint("TOPLEFT", hangL, "TOPLEFT", 36, -2);
			hangL.Race:SetSize(N_hang_Height*0.5-2,N_hang_Height*0.5-2);
			hangL.Class = hangL:CreateTexture();
			hangL.Class:SetTexture("interface/glues/charactercreate/ui-charactercreate-classes.blp")
			hangL.Class:SetPoint("LEFT", hangL.Race, "RIGHT", 1,0);
			hangL.Class:SetSize(N_hang_Height*0.5-2,N_hang_Height*0.5-2);
			hangL.level = PIGFontString(hangL,{"LEFT", hangL.Class, "RIGHT", 2, 0},1,"OUTLINE")
			hangL.level:SetTextColor(1,0.843,0,1);
			hangL.Name = PIGFontString(hangL,{"LEFT", hangL.level, "RIGHT", 0, 0})
			hangL.MapName = PIGFontString(hangL,{"TOPLEFT", hangL.Race, "BOTTOMLEFT", 0, -3})
			hangL.MapName:SetTextColor(0.6,0.6,0.6,1);
			hangL.Mode = PIGFontString(hangL,{"TOPLEFT", hangL, "TOPLEFT", 250, -2},"收到:")
			hangL.Mode:SetTextColor(0,1,0,1);
			hangL.Mode1 = PIGFontString(hangL,{"TOPLEFT", hangL.Mode, "BOTTOMLEFT", 0, -5},"交出:")
			hangL.Mode1:SetTextColor(1,0,0,1);
			hangL.MoneyP = PIGFontString(hangL,{"TOPRIGHT", hangL, "TOPRIGHT", -22, -2})
			hangL.MoneyP:SetTextColor(1,0,0,1);
			hangL.MoneyT = PIGFontString(hangL,{"TOPRIGHT", hangL.MoneyP, "BOTTOMRIGHT", 0, -3})
			hangL.MoneyT:SetTextColor(0,1,0,1);
			hangL.itembuttons={{},{}}
			function hangL:additembut(butid,lyfs)
				if not hangL.itembuttons[lyfs][butid] then
					local xitembut = CreateFrame("Button",nil,hangL)
					hangL.itembuttons[lyfs][butid]=xitembut
					xitembut:Hide()
					xitembut:SetSize(N_hang_Height*0.5-2,N_hang_Height*0.5-2)
					if butid==1 then
						if lyfs==1 then
							xitembut:SetPoint("LEFT", hangL.Mode, "RIGHT", 10, 0);
						else
							xitembut:SetPoint("LEFT", hangL.Mode1, "RIGHT", 10, 0);
						end
					else
						xitembut:SetPoint("LEFT", hangL.itembuttons[lyfs][butid-1], "RIGHT", 0,0);
					end
					xitembut.numItems = PIGFontString(xitembut,{"BOTTOMRIGHT", xitembut, "BOTTOMRIGHT", 0, 0},nil,"OUTLINE",12)
					xitembut.numItems:SetTextColor(1, 1, 1, 1);
					xitembut:HookScript("OnEnter", function (self)
						GameTooltip:ClearLines();
						GameTooltip:SetOwner(self, "ANCHOR_LEFT",0,0);
						GameTooltip:SetHyperlink(self.itemlink)
						GameTooltip:Show();
					end);
					xitembut:HookScript("OnLeave", function (self)
						GameTooltip:ClearLines();
						GameTooltip:Hide() 
					end);
				end
				return hangL.itembuttons[lyfs][butid]
			end
		end
		hangL.Title:SetText(date("%H:%M",dataX["Time"]));
		if dataX["Name"]==NONE or dataX["Class"]==nil or dataX["Class"]==NONE then
			hangL.level:SetText("??");hangL.Name:SetText("??");hangL.MapName:SetText("??");hangL.MoneyP:SetText("??");hangL.MoneyT:SetText("??")
		else
			hangL.Race:SetAtlas(dataX["Race"]);
			local className, classFile, classID = PIGGetClassInfo(dataX["Class"])
			hangL.Class:SetTexCoord(unpack(CLASS_ICON_TCOORDS[classFile]));
			hangL.level:SetText(dataX["Level"]);
			local color = PIG_CLASS_COLORS[classFile or NONE];
			hangL.Name:SetText(dataX["Name"])
			hangL.Name:SetTextColor(color.r, color.g, color.b, 1);
			hangL.MapName:SetText(dataX["Map"])
			if dataX["MoneyP"] and dataX["MoneyP"]>0 then
				hangL.MoneyP:SetText(GetMoneyString(dataX["MoneyP"]))
			else
				hangL.MoneyP:SetText("")
			end
			if dataX["MoneyT"] and dataX["MoneyT"]>0 then
				hangL.MoneyT:SetText(GetMoneyString(dataX["MoneyT"]))
			else
				hangL.MoneyT:SetText("")
			end
			for _,buxx in pairs(hangL.itembuttons[1]) do
				buxx:Hide()
			end
			for _,buxx in pairs(hangL.itembuttons[2]) do
				buxx:Hide()
			end
			for butid=1,6 do
				if dataX["ItemT"][butid]~=NONE then
					local itembut=hangL:additembut(butid,1)
					local itemID, itemType, itemSubType, itemEquipLoc, icon = PIGGetItemInfoInstant(dataX["ItemT"][butid][1]) 
					local newbutid = butid+6
					itembut:Show()
					itembut:SetWidth(N_hang_Height*0.5-2)
					itembut:SetNormalTexture(icon)
					itembut.numItems:SetText(dataX["ItemT"][butid][2])
					itembut.itemlink=dataX["ItemT"][butid][1]
				end
				if dataX["ItemP"][butid]~=NONE then
					local itembut=hangL:additembut(butid,2)
					itembut:Show()
					itembut:SetWidth(N_hang_Height*0.5-2)
					local itemID, itemType, itemSubType, itemEquipLoc, icon = PIGGetItemInfoInstant(dataX["ItemP"][butid][1]) 
					itembut:SetNormalTexture(icon)
					itembut.numItems:SetText(dataX["ItemP"][butid][2])
					itembut.itemlink=dataX["ItemP"][butid][1]
				end
			end
		end
	end
	function fujiF.Scroll_RR:Update_list()
		fujiF.ListRR.BotF:Hide()
	    local view = self.ScrollBox:GetView()
	    if not self.dataProvider then
	        self.dataProvider = CreateDataProvider()
	        view:SetDataProvider(self.dataProvider)
		end
		self.dataProvider:Flush()
		if not fujiF.SelectName or not fujiF.SelectTime then return end
		local playerData=PIGA["StatsInfo"][GNcfName][fujiF.SelectName]
		if playerData and playerData[2] then
			local shujuData = playerData[2][fujiF.SelectTime]
			local DataNum = shujuData and #shujuData or 0
			if DataNum>0 then
				fujiF.ListRR.BotF:Show()
				fujiF.ListRR.BotF.JiluNum:SetText(DataNum)
			    for i = DataNum,1,-1 do
			        self.dataProvider:Insert({id=i,data=shujuData[i]});
			    end
			end
		end
	end

	function fujiF:ClickUpdateList()
		fujiF.Scroll_L:Update_list()
		fujiF.Scroll_R:Update_list()
		fujiF.Scroll_RR:Update_list()
	end

	----
	local function IsTimeDay(DQday,timelist)
		for d=#timelist, 1, -1 do
			if timelist[d]==DQday then
				return true,d
			end
		end
		return false
	end
	local IsFriend=Fun.IsFriend
	fujiF:RegisterEvent("UI_INFO_MESSAGE");
	fujiF:HookScript("OnEvent", function(self,event,arg1,arg2)
		if event~="UI_INFO_MESSAGE" then return end
		if arg2==ERR_TRADE_COMPLETE then
			local xiaoxiTime=GetServerTime()
			local MapName=GetZoneText().."-"..GetSubZoneText()
			local TradeDATA=CopyTable(Data.TradeInfo)
			TradeDATA["Time"]=xiaoxiTime
			TradeDATA["Map"]=MapName
			local YYDAY=floor(xiaoxiTime/60/60/24)
			local TimeDataX=PIGA["StatsInfo"][GNcfName][StatsUI.allname]
			if #TimeDataX>0 then
				local cunzai,xuhao=IsTimeDay(YYDAY,TimeDataX[1])
				if cunzai then
					table.insert(TimeDataX[2][xuhao], TradeDATA);
				else
					table.insert(TimeDataX[1], YYDAY);
					table.insert(TimeDataX[2], {TradeDATA});
				end
			else
				PIGA["StatsInfo"][GNcfName][StatsUI.allname]={{YYDAY},{{TradeDATA}}}
			end
			local FSmsgT = {"",""}
			if TradeDATA.MoneyP>0 then
				FSmsgT[1]=FSmsgT[1]..(TradeDATA.MoneyP*0.0001).."G"
			end
			for i=1,6 do
				if TradeDATA.ItemP[i]~=NONE then
					FSmsgT[1]=FSmsgT[1]..TradeDATA.ItemP[i][1]
					if TradeDATA.ItemP[i][2]>1 then
						FSmsgT[1]=FSmsgT[1].."×"..TradeDATA.ItemP[i][2]
					end
				end
			end
			if FSmsgT[1]~="" then FSmsgT[1]=L["TRADECHARDATA_NOTICETXT1"]..FSmsgT[1] end
			if TradeDATA.MoneyT>0 then
				FSmsgT[2]=FSmsgT[2]..(TradeDATA.MoneyT*0.0001).."G"
			end
			for i=1,6 do
				if TradeDATA.ItemT[i]~=NONE then
					FSmsgT[2]=FSmsgT[2]..TradeDATA.ItemT[i][1]
					if TradeDATA.ItemT[i][2]>1 then
						FSmsgT[2]=FSmsgT[2].."×"..TradeDATA.ItemT[i][2]
					end
				end
			end
			if FSmsgT[2]~="" and FSmsgT[1]~="" then
				FSmsgT[2]=","..L["TRADECHARDATA_NOTICETXT2"]..FSmsgT[2]
			elseif FSmsgT[2]~="" then
				FSmsgT[2]=L["TRADECHARDATA_NOTICETXT2"]..FSmsgT[2]
			end
			if FSmsgT[1]~="" or FSmsgT[2]~="" then
				local msgT = "["..addonName.."]:"..string.format(L["TRADECHARDATA_NOTICETXT3"],TradeDATA.Name,FSmsgT[1],FSmsgT[2])
				if PIGA["StatsInfo"]["TradeTongGao"] then
					if PIGA["StatsInfo"]["TradeIsFriend"] and IsFriend(TradeDATA.Name) then
					else
						if PIGA["StatsInfo"]["TradeTongGaoChannel"]=="WHISPER" then
							SendChatMessage(msgT, "WHISPER", nil, TradeDATA.Name);
						else
							if HasLFGRestrictions() then
								SendChatMessage(msgT, "INSTANCE_CHAT");
							elseif IsInRaid() then
								SendChatMessage(msgT, "RAID");
							elseif IsInGroup() then
								SendChatMessage(msgT, "PARTY");
							end
							return
						end
					end
				end
				if PIGIsAddOnLoaded(L.addnames[3]) and PIGA["GDKP"]["Rsetting"]["tradetonggao"] then
					if IsInRaid() then
						SendChatMessage(msgT, "RAID");
					elseif IsInGroup() then
						SendChatMessage(msgT, "PARTY");
					end
				end
			end
		elseif IsErrTrade(arg2) and Data.TradeInfo.Name then
			if PIGA["StatsInfo"]["TradeIsError"] then return end
			local msgT = "["..addonName.."]:"..string.format(L["TRADECHARDATA_NOTICETXT4"],Data.TradeInfo.Name,arg2)
			if PIGA["StatsInfo"]["TradeTongGao"] then
				if PIGA["StatsInfo"]["TradeIsFriend"] and IsFriend(Data.TradeInfo.Name) then
				else
					if PIGA["StatsInfo"]["TradeTongGaoChannel"]=="WHISPER" then
						SendChatMessage(msgT, "WHISPER", nil, Data.TradeInfo.Name);
					else
						if HasLFGRestrictions() then
							SendChatMessage(msgT, "INSTANCE_CHAT");
						elseif IsInRaid() then
							SendChatMessage(msgT, "RAID");
						elseif IsInGroup() then
							SendChatMessage(msgT, "PARTY");
						end
						return
					end
				end
			end
			if PIGIsAddOnLoaded(L.addnames[3]) and PIGA["GDKP"]["Rsetting"]["tradetonggao"] and IsInRaid() then
				SendChatMessage(msgT, "RAID");
			end
		end
	end)
end