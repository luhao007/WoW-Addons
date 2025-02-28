local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
local L=addonTable.locale
local Fun=addonTable.Fun
local Create=addonTable.Create
local PIGLine=Create.PIGLine
local PIGFrame=Create.PIGFrame
local PIGFontString=Create.PIGFontString
local PIGOptionsList_R=Create.PIGOptionsList_R
--------
local BusinessInfo=addonTable.BusinessInfo
function BusinessInfo.Time()
	local StatsInfo = StatsInfo_UI
	local fujiF,fujiTabBut=PIGOptionsList_R(StatsInfo.F,"时\n光",StatsInfo.butW,"Left")
	---
	-- 	local hang_NUMLS=8
	-- for id = 1, hang_NUMLS, 1 do
	-- 	local hang = CreateFrame("Button", "PIG_lixianAHList_LS_"..id, fujiF.PListR.TOP);
	-- 	hang:SetSize(fujiF.PListR.TOP:GetWidth()-4,hang_Height+2);
	-- 	if id==1 then
	-- 		hang:SetPoint("TOPLEFT", fujiF.PListR.TOP.Scroll, "TOPLEFT", 0, 0);
	-- 	else
	-- 		hang:SetPoint("TOPLEFT", _G["PIG_lixianAHList_LS_"..id-1], "BOTTOMLEFT", 0, -2);
	-- 	end
	-- 	hang.highlight = hang:CreateTexture();
	-- 	hang.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
	-- 	hang.highlight:SetBlendMode("ADD")
	-- 	hang.highlight:SetPoint("TOPLEFT", hang, "TOPLEFT", 0,0);
	-- 	hang.highlight:SetPoint("BOTTOMRIGHT", hang, "BOTTOMRIGHT", 0,0);
	-- 	hang.highlight:SetAlpha(0.4);
	-- 	hang.highlight:SetDrawLayer("BORDER", -2)
	-- 	hang.highlight:Hide();
	-- 	hang.itemG = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiListLS[1][2], 0},nil,"OUTLINE")
	-- 	hang.itemG:SetTextColor(0, 1, 1, 1); 
	-- 	hang.time = PIGFontString(hang,{"RIGHT", hang, "RIGHT", biaotiListLS[2][2], 0},nil,"OUTLINE")
	-- 	hang.time:SetTextColor(0.8, 0.8, 0.8, 0.9);
	-- end
	-- function fujiF.gengxin_ListLS(self)
	-- 	if not fujiF.PListR.TOP:IsVisible() then return end
	-- 	for id = 1, hang_NUMLS, 1 do
	-- 		local fujix = _G["PIG_lixianAHList_LS_"..id]
	-- 		fujix:Hide();
	-- 	end
	-- 	fujiF.DQShowData = {}
	-- 	if PIGA["AHPlus"]["CacheData"][Pig_OptionsUI.Realm] then
	-- 		fujiF.DQShowData=PIGA["AHPlus"]["CacheData"][Pig_OptionsUI.Realm]
	-- 	else
	-- 		fujiF.DQShowData=PIGA["AHPlus"]["CacheData"]
	-- 	end
	-- 	local itemData = fujiF.DQShowData[fujiF.collname]
	-- 	local itemDataL = itemData[2]	
	-- 	local ItemsNum = #itemDataL;
	--     FauxScrollFrame_Update(self, ItemsNum, hang_NUMLS, hang_Height);
	--     local offset = FauxScrollFrame_GetOffset(self);
	--     for id = 1, hang_NUMLS do
	--     	local dangqian = (ItemsNum+1)-id-offset;
	-- 		if itemDataL[dangqian] then
	-- 			local fujix = _G["PIG_lixianAHList_LS_"..id]
	-- 			fujix:Show();
	-- 			fujix.itemG:SetText(GetMoneyString(itemDataL[dangqian][1]))
	-- 			local jiluTime = date("%m-%d %H:%M",itemDataL[dangqian][2])
	-- 			fujix.time:SetText(jiluTime)
	-- 		end
	-- 	end
	-- 	fujiF.PListR.BOTTOM.qushitu(itemDataL)
	-- end
	-- --
	-- fujiF:HookScript("OnShow", function(self)
	-- 	fujiF.gengxin_List(self.PList.BOTTOM.Scroll);
	-- end)
	-- fujiF.shiguang=PIGFrame(fujiF)
	-- fujiF.shiguang:SetPoint("TOPRIGHT",fujiF,"TOPRIGHT",-4,-2);
	-- fujiF.shiguang:SetPoint("BOTTOMLEFT",fujiF.lineC,"BOTTOMRIGHT",4,2);
	-- fujiF.shiguang.title = PIGFontString(fujiF.shiguang,{"TOP", fujiF.shiguang, "TOP", 0, -2},TOKEN_FILTER_LABEL)
	-- fujiF.shiguang.title:SetTextColor(0, 1, 0, 1);
	-- fujiF.shiguang.lineTOP = PIGLine(fujiF.shiguang,"TOP",-20,nil,nil,{0.3,0.3,0.3,0.3})
	-- local allhangshu = 48
	-- for i = 1, allhangshu do
	-- 	local shiguangG = PIGFontString(fujiF.shiguang,nil,"",nil,14,"shiguangG_"..i)
	-- 	if i==1 then
	-- 		shiguangG:SetPoint("TOPLEFT",fujiF.shiguang.lineTOP,"BOTTOMLEFT",4,-4);
	-- 	elseif i==25 then
	-- 		shiguangG:SetPoint("TOPLEFT",fujiF.shiguang.lineTOP,"BOTTOMLEFT",200,-4);
	-- 	else
	-- 		shiguangG:SetPoint("TOPLEFT",_G["shiguangG_"..(i-1)],"BOTTOMLEFT",0,-5);
	-- 	end
	-- 	shiguangG:SetJustifyH("LEFT");
	-- end
	-- local function Update_huizhangG()
	-- 	local lishihuizhangG = PIGA["AHPlus"].Tokens
	-- 	local SHUJUNUM = #lishihuizhangG
	-- 	local shujukaishiid = 0
	-- 	if SHUJUNUM>allhangshu then
	-- 		shujukaishiid=SHUJUNUM-allhangshu
	-- 	end
	-- 	for i = 1, allhangshu do
	-- 		local shujuid = i+shujukaishiid
	-- 		if lishihuizhangG[shujuid] then
	-- 			local tiem1 = date("%Y-%m-%d %H:%M",lishihuizhangG[shujuid][1])
	-- 			local jinbiV = lishihuizhangG[shujuid][2] or 0
	-- 			local jinbiV = (jinbiV/10000)
	-- 			_G["shiguangG_"..i]:SetText("|cffEEEEEE"..tiem1..":|r|cffFFFF00"..jinbiV.."G|r")
	-- 		end
	-- 	end
	-- end
	-- --
	-- fujiF:HookScript("OnShow", function(self)
	-- 	gengxin_SkillCD(self.SkillCD.Scroll);
	-- 	Update_huizhangG()
	-- end)
	-- fujiF:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- fujiF:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED","player");              
	-- fujiF:RegisterEvent(SkillData.event)
	-- fujiF:SetScript("OnEvent", function(self,event,arg1,_,arg3)
	-- 	if event=="PLAYER_ENTERING_WORLD" then
	-- 		C_Timer.After(1,xieru_SkillCD)
	-- 	end
	-- 	if event==SkillData.event then
	-- 		C_Timer.After(1,Get_SkillCD)
	-- 	end
	-- 	if event=="UNIT_SPELLCAST_SUCCEEDED" then
	-- 		for k,v in pairs(SkillData.SkillID) do
	-- 			if arg3==k then
	-- 				C_Timer.After(0.8, function()
	-- 					local nametxt =PIGGetSpellInfo(arg3)
	-- 					local start, duration = PIGGetSpellCooldown(arg3);
	-- 					PIGA["StatsInfo"]["SkillCD"][StatsInfo.allname][nametxt][2]=true
	-- 					PIGA["StatsInfo"]["SkillCD"][StatsInfo.allname][nametxt][4]=duration
	-- 					PIGA["StatsInfo"]["SkillCD"][StatsInfo.allname][nametxt][6]=start
	-- 					gengxin_SkillCD(self.SkillCD.Scroll);
	-- 				end)
	-- 				return
	-- 			end
	-- 		end
	-- 	end
	-- end)
end
