local addonName, PD = ...;
local BusinessInfo=PD.BusinessInfo
function BusinessInfo.Mail(StatsUI)
	local L=PD.locale
	local Data=PD.Data
	local Fun=PD.Fun
	local HY_ItemLinkJJ=Fun.HY_ItemLinkJJ
	local Create=PD.Create
	local PIGLine=Create.PIGLine
	local PIGFrame=Create.PIGFrame
	local PIGButton = Create.PIGButton
	local PIGFontString=Create.PIGFontString
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGTabBut=Create.PIGTabBut
	--
	local GNcfName="MailData"
	local PlayerData = PIGA["StatsInfo"]["Players"]
	local MailData = PIGA["StatsInfo"][GNcfName]
	local MAX_RECORDS = 100
	for playerId, _ in pairs(PlayerData) do
	    local tradeInfo = MailData[playerId]
	    if tradeInfo and tradeInfo.dayList and #tradeInfo.dayList > MAX_RECORDS then
	        local excess = #tradeInfo.dayList - MAX_RECORDS
	        for id = 1, excess do
	        	tradeInfo.data[tradeInfo.dayList[id]]=nil
	            table.remove(tradeInfo.dayList, 1)
	        end
	    end
	end
	---
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsUI.F,BUTTON_LAG_MAIL,StatsUI.butW,"LeftH")
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
				fujiF.SelectTime=self.dataX
				fujiF.Scroll_R:Update_list()
				fujiF.Scroll_RR:Update_list()
			end)
		end
		local idX=elementData.id
		local dataX=elementData.data
		hangL.dataX=dataX
		hangL.Title:SetText(date("%Y-%m-%d",dataX*86400));
		hangL.highlight1:SetShown(dataX==fujiF.SelectTime)
		local Color=dataX==fujiF.SelectTime and {1,1,1} or {0,250/255,154/255}
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
		if TimeDataX and TimeDataX.dayList then
			local TimeNum=#TimeDataX.dayList
			if not fujiF.SelectTime then
				fujiF.SelectTime = TimeDataX.dayList[TimeNum]
			end
		    for i = TimeNum,1,-1 do
		        self.dataProvider:Insert({id=i,data=TimeDataX.dayList[i]});
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
	fujiF.ListRR.BotF.JiluNumT = PIGFontString(fujiF.ListRR.BotF,{"LEFT",fujiF.ListRR.BotF,"LEFT",10,0},BUTTON_LAG_MAIL)
	fujiF.ListRR.BotF.JiluNum = PIGFontString(fujiF.ListRR.BotF,{"LEFT",fujiF.ListRR.BotF.JiluNumT,"RIGHT",2,0},0)
	fujiF.ListRR.BotF.JiluNum:SetTextColor(1, 1, 1, 1);
	fujiF.ListRR.BotF.DELtimeall=PIGButton(fujiF.ListRR.BotF,{"RIGHT",fujiF.ListRR.BotF,"RIGHT",-140,0},{60,18},DELETE)
	fujiF.ListRR.BotF.DELtimeall:SetScript("OnClick", function(self, button)
		StaticPopup_Show("PIG_MAILLISTTIMENR_DEL");
	end)
	StaticPopupDialogs["PIG_MAILLISTTIMENR_DEL"] = {
		text = L["TRADECHARDATA_TRADE2"],
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			if not fujiF.SelectName then return end
			local tradeInfo=PIGA["StatsInfo"][GNcfName][fujiF.SelectName]
			if tradeInfo then
				for id = 1, #tradeInfo.dayList do
					if tradeInfo.dayList[id]==fujiF.SelectTime then
	        			tradeInfo.data[fujiF.SelectTime]=nil
	            		table.remove(tradeInfo.dayList, id)
	            		fujiF.SelectTime=nil
	            		if id>1 then fujiF.SelectTime=tradeInfo.dayList[id-1] end
	            		fujiF.Scroll_R:Update_list()
						fujiF.Scroll_RR:Update_list()
	            		return 
	            	end
	        	end	
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
		if not hangL.bg1line then
			hangL.bg1line = PIGLine(hangL,"BOT",0,nil,nil,{0.3,0.3,0.3,0.5})	
			hangL.highlight = hangL:CreateTexture(nil,"HIGHLIGHT");
			hangL.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
			hangL.highlight:SetBlendMode("ADD")
			hangL.highlight:SetPoint("TOPLEFT", hangL, "TOPLEFT", 2,0);
			hangL.highlight:SetPoint("BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -2,0);
			hangL.highlight:SetAlpha(0.3);
			hangL.Title = PIGFontString(hangL,{"LEFT", hangL, "LEFT", 2, 0})
			hangL.Title:SetTextColor(0.9, 0.9, 0.9, 0.9);
			hangL.Mode = PIGFontString(hangL,{"TOPLEFT", hangL, "TOPLEFT", 36, -2},"收件:")
			hangL.Mode:SetTextColor(0,1,0,1);
			hangL.Mode1 = PIGFontString(hangL,{"BOTTOMLEFT", hangL, "BOTTOMLEFT", 36, 2},"寄出:")
			hangL.Mode1:SetTextColor(1,0,0,1);
			hangL.Money1 = PIGFontString(hangL,{"TOPRIGHT", hangL, "TOPRIGHT", -350, -2})
			hangL.Money1:SetTextColor(0,1,0,1);
			hangL.Money2 = PIGFontString(hangL,{"BOTTOMRIGHT", hangL, "BOTTOMRIGHT", -350, 2})
			hangL.Money2:SetTextColor(1,0,0,1);
			hangL:HookScript("OnEnter", function (self)
				GameTooltip:ClearLines();
				GameTooltip:SetOwner(self, "ANCHOR_LEFT",0,0);
				GameTooltip:AddLine("收寄件明细")
				for leid=1,2 do
					if self.NewdataX[leid] then
						local yanse=leid==1 and "|cff00FF00%s|r" or "|cffFF0000%s|r"
						GameTooltip:AddLine(leid==1 and string.format(yanse,"收件:") or string.format(yanse,"寄件:"))
						for wname,ddd in pairs(self.NewdataX[leid]) do
							local wnamtxtL,wnamtxtR=wname..":",""
							if ddd.money>0 then wnamtxtL=wnamtxtL..GetMoneyString(ddd.money) end
							for linjj,itdata in pairs(ddd.items) do
								local itemTexture = select(5,PIGGetItemInfoInstant(itdata.itemID))
								wnamtxtR=wnamtxtR.."|T"..itemTexture..":0|tx"..itdata.count.." "
							end
							GameTooltip:AddDoubleLine(string.format(yanse,wnamtxtL),string.format(yanse,wnamtxtR))
						end
					end
				end
				GameTooltip:Show();
			end);
			hangL:HookScript("OnLeave", function (self)
				GameTooltip:ClearLines();
				GameTooltip:Hide() 
			end);
			hangL.itembuttons={{},{}}
			function hangL:additembut(butid,lyfs)
				if not hangL.itembuttons[lyfs][butid] then
					local xitembut = CreateFrame("Button",nil,hangL)
					hangL.itembuttons[lyfs][butid]=xitembut
					xitembut:Hide()
					xitembut:SetSize(N_hang_Height*0.5-2,N_hang_Height*0.5-2)
					if butid==1 then
						if lyfs==1 then
							xitembut:SetPoint("TOPLEFT", hangL, "TOPLEFT", 220, -2);
						else
							xitembut:SetPoint("BOTTOMLEFT", hangL, "BOTTOMLEFT", 220, 2);
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
		hangL.NewdataX=dataX
		hangL.Title:SetText(dataX.Time and date("%H:%M",dataX.Time) or "??");
		for leid=1,2 do
			for _,buxx in pairs(hangL.itembuttons[leid]) do
				buxx:Hide()
			end
			hangL["Money"..leid]:SetShown(false)
			if dataX[leid] then
				local butid,allmoney=0,0
				for wname,dd in pairs(dataX[leid]) do
					allmoney=allmoney+dd.money
					for linjj,itdata in pairs(dd.items) do
						butid=butid+1
						local itembut=hangL:additembut(butid,leid)
						itembut:Show()
						local itemID, itemType, itemSubType, itemEquipLoc, icon = PIGGetItemInfoInstant(itdata.itemID) 
						itembut:SetWidth(N_hang_Height*0.5-2)
						itembut:SetNormalTexture(icon)
						itembut.numItems:SetText(itdata.count)
						itembut.itemlink=HY_ItemLinkJJ(linjj)
					end
				end
				hangL["Money"..leid]:SetShown(allmoney>0)
				hangL["Money"..leid]:SetText(GetMoneyString(allmoney))
			end
		end
	end
	function fujiF.Scroll_RR:Update_list()
		self.fenli=0
		fujiF.ListRR.BotF:Hide()
	    local view = self.ScrollBox:GetView()
	    if not self.dataProvider then
	        self.dataProvider = CreateDataProvider()
	        view:SetDataProvider(self.dataProvider)
		end
		self.dataProvider:Flush()
		if not fujiF.SelectName or not fujiF.SelectTime then return end
		local playerData=PIGA["StatsInfo"][GNcfName][fujiF.SelectName]
		if playerData and playerData.data then
			local shujuData = playerData.data[fujiF.SelectTime]
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

	function BusinessInfo.addMailRecord(dataX)
		local xiaoxiTime=GetServerTime()
		dataX.Time=xiaoxiTime
		local YYDAY=floor(xiaoxiTime/60/60/24)
		local TimeDataX=PIGA["StatsInfo"][GNcfName][StatsUI.allname]
		if TimeDataX then
			if TimeDataX.data[YYDAY] then
				table.insert(TimeDataX.data[YYDAY], dataX);
			else
				table.insert(TimeDataX.dayList, YYDAY);
				TimeDataX.data[YYDAY]={dataX}
			end
		else
			PIGA["StatsInfo"][GNcfName][StatsUI.allname]={dayList={YYDAY},data={[YYDAY]={dataX}}}
		end
	end
	function BusinessInfo.ClickMailRecord()
		Create.Show_TabBut_R(StatsUI.F,fujiF,fujiTabBut)
	end
end
