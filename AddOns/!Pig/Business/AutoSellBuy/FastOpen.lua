local _, PD = ...;
local BusinessInfo=PD.BusinessInfo
function BusinessInfo.FastOpen(QuickButUI_index)
	local L=PD.locale
	local Fun=PD.Fun
	local Data=PD.Data
	local bagIDMax= Data.bagData["bagIDMax"]

	local Create=PD.Create
	local PIGButton = Create.PIGButton
	local PIGOptionsList_R=Create.PIGOptionsList_R
	local PIGEnter=Create.PIGEnter
	local PIGQuickBut=Create.PIGQuickBut
	local Show_TabBut_R=Create.Show_TabBut_R
	local PIGCheckbutton=Create.PIGCheckbutton
	--
	local GnName,GnUI,GnIcon,FrameLevel = unpack(BusinessInfo.uiData)
	local _GN,_GNE = L["TRADESELLBUY_OPEN2"],"Open"
	local BindingName = GnUI.."_".._GNE
	local fujiF,fujiTabBut=PIGOptionsList_R(_G[GnUI].F,L["TRADESELLBUY_OPEN1"],50,"Left")
	BusinessInfo.ADDScroll(fujiF,_GN,_GNE,17,{false,"AutoSellBuy",_GNE.."_List"})
	------
	fujiF.Bindings = PIGButton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",20,-10},{76,20},KEY_BINDING);
	fujiF.Bindings:SetScript("OnClick", function (self)
		Settings.OpenToCategory(Settings.KEYBINDINGS_CATEGORY_ID, addonName);
	end)
	local QkButAction=CreateFrame("Button",BindingName,UIParent, "SecureActionButtonTemplate");
	QkButAction:SetAttribute("type1", "item")
	Fun.PIGUseKeyDown(QkButAction,true)
	_G["BINDING_NAME_CLICK "..BindingName..":LeftButton"]= "PIG"..GnName.._GN
	local function zhixingClick(self,button,ly)
		if button=="LeftButton" then
			if InCombatLockdown() then
				PIGErrorMsg(ERR_NOT_IN_COMBAT)
			else
				local shujuy =PIGA["AutoSellBuy"][_GNE.."_List"]
				if #shujuy>0 then
					for bag=0,bagIDMax do			
						local bganum=PIGGetContainerNumSlots(bag)
						for slot=1,bganum do	
							local itemID=PIGGetContainerItemID(bag, slot)
							if itemID then
								for k=1,#shujuy do
									if itemID==shujuy[k][1] then
										local itemLink = PIGGetContainerItemLink(bag, slot);
										self:SetAttribute("item1", itemLink)
										return
									end
								end
							end
						end
					end
					PIGErrorMsg(string.format(L["TRADESELLBUY_TISP6"],_GN))
				else
					if ly==1 then
						PIGErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN)..","..KEY_BUTTON2..SETTINGS);
					else
						PIGErrorMsg(string.format(L["TRADESELLBUY_TISP4"],_GN));
					end
				end	
			end
		end
	end
	QkButAction:HookScript("PreClick",  function (self,button)
		zhixingClick(self,button)
	end);
	---
	fujiF.QkBut = PIGCheckbutton(fujiF,{"TOPLEFT",fujiF,"TOPLEFT",150,-10},{L["ACTION_ADDQUICKBUT"],string.format(L["ACTION_ADDQUICKBUTTIS"],_GN)})
	fujiF.QkBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["AutoSellBuy"][_GNE.."_QkBut"]=true;
		else
			PIGA["AutoSellBuy"][_GNE.."_QkBut"]=false;
		end
		Fun.QuickBut_Update()
	end);
	fujiF.QkBut.RL = PIGButton(fujiF.QkBut,{"LEFT",fujiF.QkBut.Text,"RIGHT",4,0},{80,20},RELOADUI)
	fujiF.QkBut.RL:Hide()
	fujiF.QkBut.RL:SetScript("OnClick", function (self)
		ReloadUI()
	end)
	fujiF:HookScript("OnShow", function (self)
		self.QkBut:SetChecked(PIGA["AutoSellBuy"][_GNE.."_QkBut"])
	end);
	Create.PIGaddQuickBut(QuickButUI_index,{
		Open=function()
			return PIGA["QuickBut"]["Open"] and PIGA["AutoSellBuy"]["Open"] and PIGA["AutoSellBuy"][_GNE.."_QkBut"]
		end,
		Icon=136058,
		FrameLevel=FrameLevel,
		Tooltip=string.format(L["TRADESELLBUY_TISP5"],_GN,GnName),
		Template="SecureActionButtonTemplate",
		fun=function(QkBut)
			QkBut:SetAttribute("type1", "item")
			QkBut:HookScript("PreClick",  function (self,button)
				zhixingClick(self,button,1)
			end);
			QkBut:HookScript("OnClick", function(self,button)
				if button=="RightButton" then
					if _G[GnUI]:IsShown() then
						_G[GnUI]:Hide();
					else
						_G[GnUI]:Show();
						Show_TabBut_R(_G[GnUI].F,fujiF,fujiTabBut)
					end
				end
			end);
		end,
	})
end