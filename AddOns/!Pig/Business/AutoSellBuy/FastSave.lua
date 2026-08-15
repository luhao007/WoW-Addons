local _, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.FastSave()
	local L=addonTable.locale
	local Create=addonTable.Create
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGEnter=Create.PIGEnter
	local Show_TabBut_R=Create.Show_TabBut_R
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGFontString=Create.PIGFontString
	local PIGSlider = Create.PIGSlider
	-- 
	local Fun = addonTable.Fun
	local Data=addonTable.Data
	local bagID=Data.bagData["bagID"]
	local bankID=Data.bagData["bankID"]
	--
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.uiData)
	local _GN,_GNE = L["TRADESELLBUY_SAVE2"],"Save"
	local fujiF,fujiTabBut=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_SAVE1"],50,"Left")
	if PIG_MaxTocversion() then
		fujiF.cunGV =PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-9},L["TRADESELLBUY_TISP8"])
	else
		fujiF.cunGV =PIGFontString(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",10,-9},L["TRADESELLBUY_SAVE3"].."("..L["TRADESELLBUY_TISP8"]..")")
		fujiF.cunGVSlider = PIGSlider(fujiF,{"TOPLEFT",fujiF.cunGV,"BOTTOMLEFT",0,0},{0, 1000000000, 1000000,{["Right"]=GetMoneyString}},200)
		function fujiF.cunGVSlider:PIGOnValueChange(arg1)
			PIGA_Per["AutoSellBuy"][_GNE.."_Money"]=arg1
		end
		fujiF:HookScript("OnShow", function (self)
			self.cunGVSlider:PIGSetValue(PIGA_Per["AutoSellBuy"][_GNE.."_Money"])
		end)
	end
	BusinessInfo.ADDScroll(fujiF,_GN,_GNE,18,{true,"AutoSellBuy",_GNE.."_List"})
	--取
	local fujiF_Take,fujiTabBut_Take=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_TAKE1"],50,"Left")
	local _GN_Take,_GNE_Take = L["TRADESELLBUY_TAKE2"],"Take"
	if PIG_MaxTocversion() then
		fujiF_Take.tiquGV =PIGFontString(fujiF_Take,{"TOPLEFT",fujiF_Take,"TOPLEFT",10,-9},L["TRADESELLBUY_TISP8"])
	else
		fujiF_Take.tiquGV =PIGFontString(fujiF_Take,{"TOPLEFT",fujiF_Take,"TOPLEFT",10,-9},L["TRADESELLBUY_TAKE3"].."("..L["TRADESELLBUY_TISP8"]..")")
		fujiF_Take.tiquGVSlider = PIGSlider(fujiF_Take,{"TOPLEFT",fujiF_Take.tiquGV,"BOTTOMLEFT",0,0},{0, 1000000000, 1000000,{["Right"]=GetMoneyString}},200)
		function fujiF_Take.tiquGVSlider:PIGOnValueChange(arg1)
			PIGA_Per["AutoSellBuy"][_GNE_Take.."_Money"]=arg1
		end
		fujiF_Take:HookScript("OnShow", function (self)
			self.tiquGVSlider:PIGSetValue(PIGA_Per["AutoSellBuy"][_GNE_Take.."_Money"])
		end)
	end
	BusinessInfo.ADDScroll(fujiF_Take,_GN_Take,_GNE_Take,18,{true,"AutoSellBuy",_GNE_Take.."_List"})
	--
	local www,hhh = 25,25
	local NewItemTypeLsit = CopyTable(Data.ItemTypeLsit)
	table.insert(NewItemTypeLsit,1,{133784,"G",CUSTOM})
	table.insert(NewItemTypeLsit,{135860,"diy",CUSTOM})
	local function SavezhixingFun(typeid,itemID,bag,slot,cfvv)
		if itemID then
			local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subclassID = PIGGetItemInfoInstant(itemID) 
			-- local itemID, itemLink, icon, stackCount, quality=PIGGetContainerItemInfo(bag,slot)
			-- print(itemLink,classID, subclassID,itemType, itemSubType)
			if NewItemTypeLsit[typeid][2]=="diy" then
				for ib=1,#cfvv do
					if itemID==cfvv[ib][1] then
						PIGUseContainerItem(bag,slot);
					end
				end
			else
				for ib=1,#NewItemTypeLsit[typeid][2] do
					if NewItemTypeLsit[typeid][2][ib][2] then
						if classID==NewItemTypeLsit[typeid][2][ib][1] and subclassID==NewItemTypeLsit[typeid][2][ib][2] then
							PIGUseContainerItem(bag,slot);
						end
					else
						if classID==NewItemTypeLsit[typeid][2][ib][1] then
							PIGUseContainerItem(bag,slot);
						end
					end
				end
			end
		end
	end
	local function PIGRunUseItem(button,typeid,data)
		if PIG_MaxTocversion(20000) then PIGErrorMsg(FEATURE_NOT_YET_AVAILABLE) return end
		local shujudata={{},{}}
		if button=="LeftButton" then
			if NewItemTypeLsit[typeid][2]=="G" then
				C_Bank.DepositMoney(BankFrame:GetActiveBankType(), PIGA_Per["AutoSellBuy"][_GNE.."_Money"])
			else
				shujudata[2]=PIGA_Per["AutoSellBuy"][_GNE.."_List"]
				for bag=1,#bagID do
					local bganum=PIGGetContainerNumSlots(bagID[bag])
					for slot=1,bganum do
						local itemID=PIGGetContainerItemID(bagID[bag], slot)
						SavezhixingFun(typeid,itemID,bagID[bag], slot, shujudata[2])
					end
				end
			end
		else
			if NewItemTypeLsit[typeid][2]=="G" then
				C_Bank.WithdrawMoney(BankFrame:GetActiveBankType(), PIGA_Per["AutoSellBuy"][_GNE_Take.."_Money"]);
			else
				shujudata[2]=PIGA_Per["AutoSellBuy"][_GNE_Take.."_List"]
				local BankFrameBankType=BankFrame:GetActiveBankType()
				if BankFrameBankType==0 then
					if PIG_MaxTocversion() then
						local bganum=PIGGetContainerNumSlots(-1)
						for slot=1,bganum do
							local itemID=PIGGetContainerItemID(-1, slot)
							SavezhixingFun(typeid,itemID,-1, slot, shujudata[2])
						end
					end
					for bagid=(bagID[#bagID]+1),11 do
						local bganum=PIGGetContainerNumSlots(bagid)
						for slot=1,bganum do
							local itemID=PIGGetContainerItemID(bagid, slot)
							SavezhixingFun(typeid,itemID,bagid, slot, shujudata[2])
						end
					end
				elseif BankFrameBankType==2 then
					for bagid=12,17 do
						local bganum=PIGGetContainerNumSlots(bagid)
						for slot=1,bganum do
							local itemID=PIGGetContainerItemID(bagid, slot)
							SavezhixingFun(typeid,itemID,bagid, slot, shujudata[2])
						end
					end
				end
			end
		end
	end
	---
	local typenum = #NewItemTypeLsit
	BankFrame.typeList={}
	for ib=typenum,1,-1 do
		local savebut = CreateFrame("Button",nil,BankFrame, "TruncatedButtonTemplate",ib);
		savebut:SetHighlightTexture("Interface/Buttons/ButtonHilight-Square");
		savebut:SetNormalTexture(NewItemTypeLsit[ib][1])
		if Fun.IsElvUI() or Fun.IsNDui() then
			savebut:GetNormalTexture():SetTexCoord(0.1,0.9,0.1,0.9)
		end
		savebut:SetSize(www,hhh);
		BankFrame.typeList[ib]=savebut
		if ib==#NewItemTypeLsit then
			if PIG_MaxTocversion() then
				savebut:SetPoint("TOPRIGHT",BankFrame,"TOPRIGHT",-56,-40);
			else
				savebut:SetPoint("BOTTOMRIGHT", BankPanel, "BOTTOMRIGHT", -10, 4);
				--savebut:SetPoint("BOTTOMRIGHT", BankPanel.NineSlice, "BOTTOMRIGHT", -24, 10);
			end
			PIGEnter(savebut,string.format(L["TRADESELLBUY_SAVE6"],NewItemTypeLsit[ib][3],NewItemTypeLsit[ib][3],NewItemTypeLsit[ib][3],NewItemTypeLsit[ib][3]))
		else
			savebut:SetPoint("RIGHT",BankFrame.typeList[ib+1],"LEFT",-2,0);
			if NewItemTypeLsit[ib][2]=="G" then
				BankFrame.Gtabbut=savebut
				PIGEnter(savebut,string.format(L["TRADESELLBUY_TAKE4"],MONEY,MONEY,MONEY,MONEY))
			else
				PIGEnter(savebut,string.format(L["TRADESELLBUY_SAVE4"],NewItemTypeLsit[ib][3],NewItemTypeLsit[ib][3]))
			end
		end
		savebut:RegisterForClicks("LeftButtonUp","RightButtonUp")
		savebut.Down = savebut:CreateTexture(nil, "OVERLAY");
		savebut.Down:SetTexture(130839);
		savebut.Down:SetAllPoints(savebut)
		savebut.Down:Hide();
		savebut:SetScript("OnMouseDown", function (self)
			self.Down:Show();
		end);
		savebut:SetScript("OnMouseUp", function (self)
			self.Down:Hide();
		end);
		savebut:SetScript("OnClick", function (self,button)
			PlaySound(SOUNDKIT.IG_CHAT_EMOTE_BUTTON);
			if ib==#NewItemTypeLsit and IsShiftKeyDown() then 
				if button=="LeftButton" then
					_G[GnUI]:Show()
					Show_TabBut_R(_G[GnUI].F,fujiF,fujiTabBut)
				else
					_G[GnUI]:Show()
					Show_TabBut_R(_G[GnUI].F,fujiF_Take,fujiTabBut_Take)
				end
				return
			end
			local typeid = self:GetID()
			PIGRunUseItem(button,typeid)
		end);
	end
	local function Show_TabButtype(tabid)
		if BankFrame.Gtabbut then BankFrame.Gtabbut:SetShown(tabid==2) end
	end
	BankFrame:HookScript("OnShow", function(self,event,arg1)
		Show_TabButtype(1)
	end);
	if PIG_MaxTocversion() then
	else
		for tabID,tabbut in pairs(BankFrame.TabSystem.tabs) do
			tabbut:HookScript("OnClick", function(self,...)
				Show_TabButtype(tabID)
			end);
		end
	end
end