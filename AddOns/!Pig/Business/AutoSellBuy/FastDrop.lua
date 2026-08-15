local _, PD = ...;
local BusinessInfo=PD.BusinessInfo
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
function BusinessInfo.FastDrop()
	local L=PD.locale
	local Fun=PD.Fun
	local Data=PD.Data
	local bagIDMax= Data.bagData["bagIDMax"]

	local Create=PD.Create
	local PIGButton = Create.PIGButton
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGQuickBut=Create.PIGQuickBut
	local Show_TabBut_R=Create.Show_TabBut_R
	---
	local GnName,GnUI,GnIcon,FrameLevel,QuickButUI_index = unpack(BusinessInfo.uiData)
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
	fujiF.runFun = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-40},{90,20},TRACKER_SORT_MANUAL.._GN);
	fujiF.runFun:SetScript("OnClick", function(event, button)
		Pig_DelItem()
	end)
	---
	fujiF.fuzhiCDM = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",150,-40},{110,20},string.format(L["TRADESELLBUY_DROP3"],_GN));
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
	-----
	Pig_DelItem=function(ly)
		local dataX = PIGA["AutoSellBuy"][_GNE.."_List"]
		if #dataX>0 then
			for bag=0,bagIDMax do
				local xx=PIGGetContainerNumSlots(bag) 
				for slot=1,xx do
					for k=1,#dataX do
						local itemID=PIGGetContainerItemID(bag, slot)
						if itemID==dataX[k][1] then
							PIGPickupContainerItem(bag, slot);
							DeleteCursorItem(bag, slot);
							return
						end
					end
				end 
			end
		else
			if ly==1 then
				PIGErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN)..","..KEY_BUTTON2..SETTINGS);
			else
				PIGErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN));
			end
		end
	end
	fujiF.QkBut = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",150,-10},{L["ACTION_ADDQUICKBUT"],string.format(L["ACTION_ADDQUICKBUTTIS"],_GN)})
	fujiF.QkBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"]["AddBut"]=true;
		else
			PIGA["AutoSellBuy"]["AddBut"]=false;
		end
		Fun.QuickBut_Update()
	end);
	fujiF.QkBut.RL = PIGButton(fujiF.QkBut,{"LEFT",fujiF.QkBut.Text,"RIGHT",4,0},{80,20},RELOADUI)
	fujiF.QkBut.RL:Hide()
	fujiF.QkBut.RL:SetScript("OnClick", function (self)
		ReloadUI()
	end)
	fujiF:HookScript("OnShow", function (self)
		self.QkBut:SetChecked(PIGA["AutoSellBuy"]["AddBut"])
	end);
	Create.PIGaddQuickBut(QuickButUI_index,{
		Open=function()
			return PIGA["QuickBut"]["Open"] and PIGA["AutoSellBuy"]["Open"] and PIGA["AutoSellBuy"]["AddBut"]
		end,
		Icon=GnIcon,
		FrameLevel=FrameLevel,
		Tooltip=string.format(L["TRADESELLBUY_TISP5"],_GN,GnName),
		fun=function(QkBut)
			QkBut:HookScript("OnClick", function(self,button)
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
		end,
	})
end