local _, addonTable = ...;
local BusinessInfo=addonTable.BusinessInfo
function Pig_DelItem() end
local function shifoucunzai(beibaoInfo,dataX)
	for x=1,#beibaoInfo do
		for k=1,#dataX do
			if beibaoInfo[x]==dataX[k][1] then
				return true
			end
		end
	end
	return false
end
function BusinessInfo.FastDrop(QuickButUI_index)
	local L=addonTable.locale
	local Fun=addonTable.Fun
	local Data=addonTable.Data
	local bagIDMax= Data.bagData["bagIDMax"]

	local Create=addonTable.Create
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGQuickBut=Create.PIGQuickBut
	local Show_TabBut_R=Create.Show_TabBut_R
	--
	local GetContainerNumSlots = C_Container.GetContainerNumSlots
	local GetContainerItemID = C_Container.GetContainerItemID
	local GetContainerItemLink = C_Container.GetContainerItemLink
	local PickupContainerItem =C_Container.PickupContainerItem
	local UseContainerItem =C_Container.UseContainerItem
	
	---
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.AutoSellBuyData)
	local _GN,_GNE = L["TRADESELLBUY_DROP2"],"Diuqi"
	local BindingName = GnUI.."_".._GNE
	local fujiF,fujiTabBut=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_DROP1"],50,"Left")
	fujiF:Show()
	fujiTabBut:Selected(true)
	BusinessInfo.ADDScroll(fujiF,_GN,_GNE,17,{false,"AutoSellBuy",_GNE.."_List"})
	----
	fujiF.Bindings = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{76,20},KEY_BINDING);
	fujiF.Bindings:SetScript("OnClick", function (self)
		Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID, addonName);
	end)
	local QkButAction=CreateFrame("Button",BindingName,UIParent, "SecureActionButtonTemplate");
	QkButAction:SetAttribute("type1", "macro");
	QkButAction:SetAttribute("macrotext", [=[/run Pig_DelItem()]=]);
	Fun.PIGUseKeyDown(QkButAction)
	_G["BINDING_NAME_CLICK "..BindingName..":LeftButton"]= "PIG"..GnName.._GN
	---
	fujiF.fuzhiCDM = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",160,-10},{110,20},string.format(L["TRADESELLBUY_DROP3"],_GN));
	fujiF.fuzhiCDM:SetScript("OnClick", function(event, button)
		StaticPopup_Show ("AUTOSELLBUY_DROP");
	end)
	StaticPopupDialogs["AUTOSELLBUY_DROP"] = {
		text = string.format(L["TRADESELLBUY_DROP4"],_GN,_GN),
		button1 = OKAY,
		OnAccept = function()
			editBoxXX = ChatEdit_ChooseBoxForSend()
			ChatEdit_ActivateChat(editBoxXX)
			editBoxXX:Insert("/run Pig_DelItem()")
			editBoxXX:HighlightText()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	---
	fujiF.runFun = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",100,-46},{90,22},TRACKER_SORT_MANUAL.._GN);
	fujiF.runFun:SetScript("OnClick", function(event, button)
		Pig_DelItem()
	end)
	-----
	Pig_DelItem=function(ly)
		local dataX = PIGA["AutoSellBuy"][_GNE.."_List"]
		if #dataX>0 then
			for bag=0,bagIDMax do
				local xx=GetContainerNumSlots(bag) 
				for slot=1,xx do
					for k=1,#dataX do
						local itemID=GetContainerItemID(bag, slot)
						if itemID==dataX[k][1] then
							PickupContainerItem(bag, slot);
							DeleteCursorItem(bag, slot);
							return
						end
					end
				end 
			end
		else
			if ly==1 then
				PIG_OptionsUI:ErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN)..","..KEY_BUTTON2..SETTINGS);
			else
				PIG_OptionsUI:ErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN));
			end
		end
	end
	local QuickButUI=_G[Data.QuickButUIname]
	QuickButUI.ButList[QuickButUI_index]=function()	
		if PIGA["QuickBut"]["Open"] and PIGA["AutoSellBuy"]["Open"] and PIGA["AutoSellBuy"]["AddBut"] then
			if QuickButUI[_GNE] then return end
			QuickButUI[_GNE]=true
			local QkBut=PIGQuickBut(nil,string.format(L["TRADESELLBUY_TISP5"],_GN,GnName),GnIcon,nil,FrameLevel)
			QkBut:SetScript("OnClick", function(self,button)
				if button=="LeftButton" then
					PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
					Pig_DelItem(1)
				else
					if _G[GnUI]:IsShown() then
						_G[GnUI]:Hide();
					else
						_G[GnUI]:Show()
						Show_TabBut_R(_G[GnUI].F,fujiF,fujiTabBut)
					end
				end
			end);
		end
	end
end