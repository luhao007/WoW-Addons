local addonName, PD = ...;
local TardisInfo = {}
PD.TardisInfo=TardisInfo
local Create, Data, Fun, L, Default, Default_Per= unpack(PIG)
local adddata=L.ExtList[addonName]
local GnName,GnUI,FrameLevel = adddata.nameLocale,"PIG_TardisUI",30
local GnIcon =132327
TardisInfo.uidata={GnName,GnUI,GnIcon,FrameLevel,20}
local tablists = {
	{"Farm",L["TARDIS_FARM"]},
	{"Plane",L["TARDIS_PLANE"]},
	{"Yell",L["TARDIS_YELL"]},
}
if PIG_MaxTocversion(20000) then
	table.insert(tablists,#tablists,{"Invite",GROUPS})
end
TardisInfo.tablists=tablists
------------
adddata.LoadFun=function()
	TardisInfo.ADD_UI()
end
local UIfun_yijiazai
adddata.Update_SetUI=function()
	if adddata.open==false then return end
	if UIfun_yijiazai then return end
	UIfun_yijiazai=true
	local fuFrame,fuFrameBut=unpack(adddata.SetUIData)
	----
	local PIGFrame=Create.PIGFrame
	local PIGLine=Create.PIGLine
	local PIGButton = Create.PIGButton
	local PIGOptionsList=Create.PIGOptionsList
	local PIGCheckbutton=Create.PIGCheckbutton
	local PIGModCheckbutton=Create.PIGModCheckbutton
	------
	fuFrame.Open = PIGModCheckbutton(fuFrame,{GnName,Tooltip},{"TOPLEFT",fuFrame,"TOPLEFT",20,-20})
	fuFrame.Open:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Tardis"]["Open"]=true;
			TardisInfo.ADD_UI()
		else
			PIGA["Tardis"]["Open"]=false;
			PIG_OptionsUI.RLUI:Show()
		end
		Fun.QuickBut_Update()
		fuFrame.SetListF.Update_SetUI()
	end);
	fuFrame.Open.QKBut:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIGA["Tardis"]["AddBut"]=true
		else
			PIGA["Tardis"]["AddBut"]=false
		end
		Fun.QuickBut_Update()
	end);
	fuFrame.Open:SetChecked(PIGA["Tardis"]["Open"])
	fuFrame.Open.QKBut:SetChecked(PIGA["Tardis"]["AddBut"])
	---------
	fuFrame.SetListF = PIGFrame(fuFrame,{"TOPLEFT",fuFrame,"TOPLEFT",0,-50})
	fuFrame.SetListF:SetPoint("BOTTOMRIGHT",fuFrame,"BOTTOMRIGHT",0,0);
	fuFrame.SetListF:PIGSetBackdrop(0)
	---重置
	fuFrame.SetListF.CZ = PIGButton(fuFrame.SetListF,{"BOTTOMRIGHT",fuFrame.SetListF,"TOPRIGHT",-20,10},{60,22},RESET);  
	fuFrame.SetListF.CZ:SetScript("OnClick", function ()
		StaticPopup_Show("PIGRESET_INVITE_INFO");
	end);
	StaticPopupDialogs["PIGRESET_INVITE_INFO"] = {
		text = string.format(L["RELOADUI2"],GnName),
		button1 = YES,
		button2 = NO,
		OnAccept = function()
			PIGA["Tardis"] = CopyTable(Default["Tardis"])
			PIGA["Tardis"]["Open"] = true;
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--
	local function ADD_setckbut(peizhiV,txtV,i)
		local SetListBut = PIGCheckbutton(fuFrame.SetListF,{"TOPLEFT",fuFrame.SetListF,"TOPLEFT",20,-40*(i-1)-20},{ENABLE..txtV})
		SetListBut:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["Tardis"][peizhiV]["Open"]=true
			else
				PIGA["Tardis"][peizhiV]["Open"]=false
			end
			PIG_OptionsUI.RLUI:Show()
		end);
		SetListBut:SetChecked(PIGA["Tardis"][peizhiV]["Open"])
	end
	for i=1,#tablists do
		ADD_setckbut(tablists[i][1],tablists[i][2],i)
	end
	--======
	function fuFrame.SetListF.Update_SetUI()
		fuFrame.SetListF:SetShown(PIGA["Tardis"]["Open"])
	end
	fuFrame.SetListF.Update_SetUI()
end
--============================
function PIGCompartmentClick_Tardis()
end
function PIGCompartmentEnter_Tardis(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:SetOwner(menuButtonFrame, "ANCHOR_BOTTOMLEFT",-2,16);
	GameTooltip:AddLine("|cffFF00FF"..addonName.."|r-"..PIGGetAddOnMetadata(addonName, "Version"))
	GameTooltip:Show();	
end
function PIGCompartmentLeave_Tardis(addonName, menuButtonFrame)
	GameTooltip:ClearLines();
	GameTooltip:Hide() 
end