local addonName, addonTable = ...;
local L =addonTable.locale
local Create=addonTable.Create
local PIGFrame=Create.PIGFrame
local PIGLine=Create.PIGLine
local PIGButton = Create.PIGButton
local PIGFontString=Create.PIGFontString
----
local Fun = addonTable.Fun
-------------
local julidi = -26
local ExportImportUI=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{800, 600},"ExportImport_UI",true)
ExportImportUI:PIGSetBackdrop(1)
ExportImportUI:PIGSetMovable()
ExportImportUI:PIGClose()
ExportImportUI:SetFrameStrata("HIGH")
ExportImportUI:SetFrameLevel(999);
ExportImportUI.biaoti=PIGFontString(ExportImportUI,{"TOP", ExportImportUI, "TOP", 0, -3})
PIGLine(ExportImportUI,"TOP",-20,1,{-1,-1})
---
local daoruTXT,daochuTXT = L["CONFIG_IMPORT"],L["CONFIG_DERIVE"]
ExportImportUI.tishitxt = PIGFontString(ExportImportUI,{"TOPLEFT",ExportImportUI,"TOPLEFT",10,julidi-2},daochuTXT)
ExportImportUI.tishitxt:SetTextColor(0, 1, 0, 1);
ExportImportUI.daoruBut = PIGButton(ExportImportUI,{"TOPLEFT",ExportImportUI,"TOPLEFT",540,julidi},{100,20},L["CONFIG_DERIVERL"])
ExportImportUI.daoruBut:Hide();
ExportImportUI.daoruBut.Error=PIGFontString(ExportImportUI.daoruBut,{"RIGHT",ExportImportUI.daoruBut,"LEFT",-4,0})
ExportImportUI.daoruBut.Error:SetTextColor(1, 0, 0, 1)
ExportImportUI.zifunumt=PIGFontString(ExportImportUI,{"TOPRIGHT",ExportImportUI,"TOPRIGHT",-60,julidi-2},"字符数:")
ExportImportUI.zifunumt:SetTextColor(1, 1, 1, 0.4)
ExportImportUI.zifunumV=PIGFontString(ExportImportUI,{"LEFT", ExportImportUI.zifunumt, "RIGHT", 0, 0},0)
ExportImportUI.zifunumV:SetTextColor(1, 1, 1, 0.4)
ExportImportUI.Line2 =PIGLine(ExportImportUI,"TOP",-50,1,{-1,-1})
ExportImportUI.NR=PIGFrame(ExportImportUI)
ExportImportUI.NR:SetPoint("TOPLEFT", ExportImportUI.Line2, "TOPLEFT", 4, -4)
ExportImportUI.NR:SetPoint("BOTTOMRIGHT", ExportImportUI, "BOTTOMRIGHT", -4, 4)
ExportImportUI.NR:PIGSetBackdrop()
ExportImportUI.NR.scroll = CreateFrame("ScrollFrame", nil, ExportImportUI.NR, "UIPanelScrollFrameTemplate")
ExportImportUI.NR.scroll:SetPoint("TOPLEFT", ExportImportUI.NR, "TOPLEFT", 6, -6)
ExportImportUI.NR.scroll:SetPoint("BOTTOMRIGHT", ExportImportUI.NR, "BOTTOMRIGHT", -26, 6)

ExportImportUI.NR.textArea = CreateFrame("EditBox", nil, ExportImportUI.NR.scroll)
ExportImportUI.NR.textArea:SetFontObject(ChatFontNormal);
ExportImportUI.NR.textArea:SetWidth(ExportImportUI.NR:GetWidth()-40)
ExportImportUI.NR.textArea:SetMultiLine(true)
ExportImportUI.NR.textArea:SetMaxLetters(99999)
ExportImportUI.NR.textArea:EnableMouse(true)
ExportImportUI.NR.textArea:SetScript("OnEscapePressed", function(self)
	self:ClearFocus()
	ExportImportUI:Hide();
end)
ExportImportUI.NR.textArea:SetScript("OnTextChanged", function(self)
	local NdataT = self:GetText()
	local NdataT = NdataT:gsub("%s+", "")
	ExportImportUI.zifunumV:SetText(#NdataT)
	if NdataT=="" then
		ExportImportUI.daoruBut:Disable()
	else
		ExportImportUI.daoruBut:Enable()
	end
end)
ExportImportUI.NR.scroll:SetScrollChild(ExportImportUI.NR.textArea)
----
ExportImportUI.TabL=PIGFrame(ExportImportUI,{"RIGHT",ExportImportUI,"LEFT",0,0},{78, 600})
ExportImportUI.TabL.Clear = PIGButton(ExportImportUI.TabL,{"TOP",ExportImportUI.TabL,"TOP",-4,julidi},{70,22},"Clear")
ExportImportUI.TabL.Clear:SetScript("OnClick", function (self)
	ExportImportUI.NR.textArea:SetText("")
end)
ExportImportUI.TabL.Copy = PIGButton(ExportImportUI.TabL,{"TOP",ExportImportUI.TabL.Clear,"BOTTOM",0,-10},{70,22},"select all")
ExportImportUI.TabL.Copy:SetScript("OnClick", function (self)
	ExportImportUI.NR.textArea:HighlightText()
end)
ExportImportUI.TabL.zhunma = PIGButton(ExportImportUI.TabL,{"TOP",ExportImportUI.TabL.Copy,"BOTTOM",0,-10},{70,22},"cmd_1")
ExportImportUI.TabL.zhunma:SetScript("OnClick", function (self)
	local data = ExportImportUI.NR.textArea:GetText()
	local Ndata = Fun.Base64_encod(data)
	ExportImportUI.NR.textArea:SetText(Ndata)
end)
ExportImportUI.TabL.huanyuan = PIGButton(ExportImportUI.TabL,{"TOP",ExportImportUI.TabL.zhunma,"BOTTOM",0,-10},{70,22},"cmd_2")
ExportImportUI.TabL.huanyuan:SetScript("OnClick", function (self)
	local data = ExportImportUI.NR.textArea:GetText()
	local Ndata = Fun.Base64_decod(data)
	ExportImportUI.NR.textArea:SetText(Ndata)
end)
function ExportImportUI:Show_HideFun()
	self.TabL:Show()
	self.NR.textArea:SetText("")
	if self:IsShown() then
		self:Hide()
	else
		self:Show()
	end
end
------
local versions,versionsV = "!P","01"
local function table_to_string(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        if type(k) == "string" then
            result = result .. '["' .. k .. '"]='
        else
            result = result .. '[' .. tostring(k) .. ']='
        end
        if type(v) == "table" then
            result = result .. table_to_string(v)
        elseif type(v) == "boolean" then
            result = result .. tostring(v)
        elseif type(v) == "string" then
            result = result .. '"' .. v .. '"'
        else
            result = result .. tostring(v)
        end
        result = result .. ","
    end
    return result .. "}"
end
local function table_to_string_ALL(str)
	local NdataT = table_to_string(str)
	local NdataT = NdataT:gsub(",}", "}")
	local NdataT = NdataT:gsub("%s+", "")
	local NdataT = Fun.yasuo_string(NdataT)
	local NdataT = Fun.Base64_encod(NdataT)
	return NdataT
end
function ExportImportUI:daochuFun(lyname,str,str_Per)
	local lyname = L["CONFIG_DAOCHU"]..lyname
	self.biaoti:SetText(lyname)
	self.tishitxt:SetText(daochuTXT)
	self.daoruBut:Hide()
	self.TabL:Hide()
	local NdataT = table_to_string_ALL(str)
	if next(str_Per) ~= nil then
		NdataT = NdataT.."@"..table_to_string_ALL(str_Per)
	end
	self.NR.textArea:SetText(versions..versionsV..NdataT)
	self.NR.textArea:HighlightText()
	self:Show()
end
--=======
function ExportImportUI:daoruFun(lyname,ClickButFunX)
	local lyname = L["CONFIG_DAORU"]..lyname
	self.biaoti:SetText(lyname)
	self.tishitxt:SetText(daoruTXT)
	self.daoruBut.Error:SetText("")
	self.NR.textArea:SetText("")
	self.daoruBut:Show()
	self.TabL:Hide()
	self.ClickButFunX=ClickButFunX
	self:Show()
end
local function deserialize(str)
    local func, err = loadstring("return " .. str)
    if not func then
        error("无效的字符串: " .. err)
    end
    return func()
end
local function string_to_table(NdataT)
	if NdataT==nil then return {} end
	local NdataT = Fun.Base64_decod(NdataT)
	local NdataT = Fun.jieya_string(NdataT)
	local NdataT = deserialize(NdataT)
	return NdataT
end
local function Load_ImportInfo2(newV,DqCF)
	for k,v in pairs(newV) do
		if DqCF[k]==nil then DqCF[k]=v end
		if type(v) == "table" then
			if next(v)==nil then
				DqCF[k]=v
			else
				Load_ImportInfo2(v,DqCF[k])
			end
		else
			DqCF[k]=v
		end
	end
end
local function ceshishuchu(dataxx)
	for k1,v1 in pairs(dataxx) do
		if type(v1) == "table" then
			for k2,v2 in pairs(v1) do
				if type(v2) == "table" then
					for k3,v3 in pairs(v2) do
						print(k1,k2,k3,v3)
						if type(v3) == "table" then
							--print(k1,k2,k3,unpack(v3))
						end
					end
				else
					print(k1,k2,v2)
				end
				
			end
		else
			print(k1,v1)
		end
	end
end
---
local function string_to_table_ALL(NdataT)
	local txtx, txtx_Per = strsplit("@", NdataT);
	local tabX=string_to_table(txtx)
	--ceshishuchu(tabX)
	local tabX_Per=string_to_table(txtx_Per)
	--ceshishuchu(tabX_Per)
	return tabX,tabX_Per
end
local function Import_ConfigData(NdataT,RL)
	local tabX,tabX_Per=string_to_table_ALL(NdataT)
	if ExportImportUI.ClickButFunX then
		local tabX,tabX_Per=ExportImportUI.ClickButFunX(tabX,tabX_Per)
		Load_ImportInfo2(tabX,PIGA)
		Load_ImportInfo2(tabX_Per,PIGA_Per)
		if RL then ReloadUI() end
	else
		Load_ImportInfo2(tabX,PIGA)
		Load_ImportInfo2(tabX_Per,PIGA_Per)
		if RL then ReloadUI() end
	end
end
function ExportImportUI.Is_PIGString(txtss,RL)
	local str=txtss or ExportImportUI.NR.textArea:GetText()
	local vn = str:sub(1,2)
	if vn==versions then
		local vv = str:sub(3,4)
		if tonumber(vv)<tonumber(versionsV) then
			return "此"..addonName.."字符串已过期"
		else
			Import_ConfigData(str:sub(5),RL)
		end
	else
		return "请导入"..addonName..ADDONS.."字符串"
	end
end
ExportImportUI.daoruBut:SetScript("OnClick", function (self)
	local errtxt = ExportImportUI.Is_PIGString(nil,true)
	if errtxt then
		self.Error:SetText(errtxt)
	end	
end);

----旧版========================================
local ConfigWWW,ConfigHHH,julidi = 800, 600, -26
local Config_Transfer=PIGFrame(UIParent,{"CENTER",UIParent,"CENTER",0,0},{ConfigWWW,ConfigHHH})
Config_Transfer:PIGSetBackdrop(1)
Config_Transfer:PIGSetMovable()
Config_Transfer:PIGClose()
Config_Transfer:SetFrameLevel(999);
Config_Transfer:Hide()
Config_Transfer.biaoti=PIGFontString(Config_Transfer,{"TOP", Config_Transfer, "TOP", 0, -4})
PIGLine(Config_Transfer,"TOP",-20,1,{-1,-20})
---
Config_Transfer.tishitxt = PIGFontString(Config_Transfer,{"TOPLEFT",Config_Transfer,"TOPLEFT",6,julidi-4},daoruTXT)
Config_Transfer.tishitxt:SetTextColor(0, 1, 0, 1);
Config_Transfer.daoruBut = PIGButton(Config_Transfer,{"TOPRIGHT",Config_Transfer,"TOPRIGHT",-40,julidi},{140,20},L["CONFIG_DERIVERL"])
Config_Transfer.daoruBut:Hide();
Config_Transfer.Line2 =PIGLine(Config_Transfer,"TOP",-50,1,{-1,-50})
--
Config_Transfer.NR=PIGFrame(Config_Transfer)
Config_Transfer.NR:SetPoint("TOPLEFT", Config_Transfer.Line2, "TOPLEFT", 4, -4)
Config_Transfer.NR:SetPoint("BOTTOMRIGHT", Config_Transfer, "BOTTOMRIGHT", -4, 4)
Config_Transfer.NR:PIGSetBackdrop()
Config_Transfer.NR.scroll = CreateFrame("ScrollFrame", nil, Config_Transfer.NR, "UIPanelScrollFrameTemplate")
Config_Transfer.NR.scroll:SetPoint("TOPLEFT", Config_Transfer.NR, "TOPLEFT", 6, -6)
Config_Transfer.NR.scroll:SetPoint("BOTTOMRIGHT", Config_Transfer.NR, "BOTTOMRIGHT", -26, 6)

Config_Transfer.NR.textArea = CreateFrame("EditBox", nil, Config_Transfer.NR.scroll)
Config_Transfer.NR.textArea:SetFontObject(ChatFontNormal);
Config_Transfer.NR.textArea:SetWidth(ConfigWWW-40)
Config_Transfer.NR.textArea:SetMultiLine(true)
Config_Transfer.NR.textArea:SetMaxLetters(99999)
Config_Transfer.NR.textArea:EnableMouse(true)
Config_Transfer.NR.textArea:SetScript("OnEscapePressed", function(self)
	self:ClearFocus()
	Config_Transfer:Hide();
end)
Config_Transfer.NR.scroll:SetScrollChild(Config_Transfer.NR.textArea)

---以下部分来自ALA大神告诉的AEC3代码
local strbyte, strchar, gsub, gmatch, format = string.byte, string.char, string.gsub, string.gmatch, string.format
local assert, error, pcall = assert, function(msg) PIG_print("|cffFF0000"..msg.."|r") end, pcall
local type, tostring, tonumber = type, tostring, tonumber
local pairs, select, frexp = pairs, select, math.frexp
local tconcat = table.concat
local function SerializeStringHelper(ch)
	local n = strbyte(ch)
	if n==30 then
		return "\126\122"
	elseif n<=32 then
		return "\126"..strchar(n+64)
	elseif n==94 then
		return "\126\125"
	elseif n==126 then
		return "\126\124"
	elseif n==127 then
		return "\126\123"
	else
		assert(false)
	end
end
--
local function SerializeValue(v, res, nres)
	local t=type(v)
	if t=="string" then
		v = gsub(v,"|", "P124")
		res[nres+1] = "^S"
		res[nres+2] = gsub(v,"[%c \94\126\127]", SerializeStringHelper)
		nres=nres+2
	elseif t=="number" then	
		local str = tostring(v)
		if tonumber(str)==v then
			res[nres+1] = "^N"
			res[nres+2] = str
			nres=nres+2
		elseif v == inf or v == -inf then
			res[nres+1] = "^N"
			res[nres+2] = v == inf and serInf or serNegInf
			nres=nres+2
		else
			local m,e = frexp(v)
			res[nres+1] = "^F"
			res[nres+2] = format("%.0f",m*2^53)	
			res[nres+4] = tostring(e-53)
			nres=nres+4
		end
	elseif t=="table" then
		nres=nres+1
		res[nres] = "^T"
		for k,v in pairs(v) do
			nres = SerializeValue(k, res, nres)
			nres = SerializeValue(v, res, nres)
		end
		nres=nres+1
		res[nres] = "^t"
	elseif t=="boolean" then
		nres=nres+1
		if v then
			res[nres] = "^B"
		else
			res[nres] = "^b"
		end
	elseif t=="nil" then
		nres=nres+1
		res[nres] = "^Z"

	else
		error("Unable to serialize the value of the type'"..t.."'")--无法序列化类型的值
	end
	return nres
end
---
local serializeTbl = { "^1" }
local tconcat = table.concat
local function Serialize(...)
	local nres = 1
	for i=1,select("#", ...) do
		local v = select(i, ...)
		nres = SerializeValue(v, serializeTbl, nres)
	end
	serializeTbl[nres+1] = "^^"	
	return tconcat(serializeTbl, "", 1, nres+1)
end
local function Config_CHU(self,peizhiInfo)
	Config_Transfer:Show()
	Config_Transfer.daoruBut:Hide();
	Config_Transfer.biaoti:SetText(self:GetText()..L["CONFIG_TABNAME"]);
	Config_Transfer.tishitxt:SetText(daochuTXT);
	local text = Serialize(peizhiInfo)
	Config_Transfer.NR.textArea:SetText(text)
	Config_Transfer.NR.textArea:HighlightText()
end
addonTable.Fun.Config_CHU=Config_CHU
--导入
local function DeserializeStringHelper(escape)
	if escape<"~\122" then
		return strchar(strbyte(escape,2,2)-64)
	elseif escape=="~\122" then
		return "\030"
	elseif escape=="~\123" then
		return "\127"
	elseif escape=="~\124" then
		return "\126"
	elseif escape=="~\125" then
		return "\94"
	end
	error("DeserializeStringHelper got called for '"..escape.."'?!?")
end
local function DeserializeNumberHelper(number)
	if number == serNegInf or number == serNegInfMac then
		return -inf
	elseif number == serInf or number == serInfMac then
		return inf
	else
		return tonumber(number)
	end
end
local function DeserializeValue(iter,single,ctl,data)
	if not single then
		ctl,data = iter()
	end
	if not ctl then 
		error("Supplied data misses AceSerializer terminator ('^^')")
	end	
	if ctl=="^^" then
		return
	end
	local res
	if ctl=="^S" then
		res = gsub(data, "~.", DeserializeStringHelper)
	elseif ctl=="^N" then
		res = DeserializeNumberHelper(data)
		if not res then
			error("Number of invalid serializations: '"..tostring(data).."'")--无效的序列化的数量
		end
	elseif ctl=="^F" then
		local ctl2,e = iter()
		if ctl2~="^f" then
			error("Invalid serialized floating point number expected , not '^f'"..tostring(ctl2).."'")--预期无效的序列化浮点数  not'^f', 
		end
		local m=tonumber(data)
		e=tonumber(e)
		if not (m and e) then
			error("Invalid serialized floating-point number, expected mantissa, and exponent'"..tostring(m).."' and '"..tostring(e).."'")--无效的序列化浮点数，期望的尾数和指数
		end
		res = m*(2^e)
	elseif ctl=="^B" then
		res = true
	elseif ctl=="^b" then
		res = false
	elseif ctl=="^Z" then
		res = nil
	elseif ctl=="^T" then
		res = {}
		local k,v
		while true do
			ctl,data = iter()
			if ctl=="^t" then break end
			k = DeserializeValue(iter,true,ctl,data)
			if k==nil then 
				error("Invalid AceSerializer format (no end-of-table flag)")--无效的AceSerializer格式(没有表结束标记)
			end
			ctl,data = iter()
			v = DeserializeValue(iter,true,ctl,data)
			if v==nil then
				error("Invalid AceSerializer format (no end-of-table flag)")--无效的AceSerializer格式(没有表结束标记)
			end
			res[k]=v
		end
	else
		error("Invalid AceSerializer control code"..ctl.."'")--无效的AceSerializer控制代码
	end
	if not single then
		return res,DeserializeValue(iter)
	else
		return res
	end
end
local function Deserialize(str)
	str = gsub(str,"P124", "|")
	str = gsub(str, "[%c ]", "")
	local iter = gmatch(str, "(^.)([^^]*)")	
	local ctl,data = iter()
	if not ctl or ctl~="^1" then
		return false, "Unknown data" --未知数据
	end
	return pcall(DeserializeValue, iter)
end
Config_Transfer.daoruBut:SetScript("OnClick", function(self, button)
	local tttxt =Config_Transfer.NR.textArea:GetText()
	local OOKK,dataff =Deserialize(tttxt)
	if OOKK then
		local peizhiInfo =self.peizhiInfo
		local jueseYN, xininfo1, xininfo2, xininfo3, xininfo4 = peizhiInfo[1],peizhiInfo[2],peizhiInfo[3],peizhiInfo[4],peizhiInfo[5];
		if jueseYN then
			if xininfo4 then
				PIGA_Per[xininfo1][xininfo2][xininfo3][xininfo4]=dataff
			elseif xininfo3 then
				PIGA_Per[xininfo1][xininfo2][xininfo3]=dataff
			elseif xininfo2 then
				PIGA_Per[xininfo1][xininfo2]=dataff
			elseif xininfo1 then
				PIGA_Per[xininfo1]=dataff
			end
		else
			if xininfo4 then
				PIGA[xininfo1][xininfo2][xininfo3][xininfo4]=dataff
			elseif xininfo3 then
				PIGA[xininfo1][xininfo2][xininfo3]=dataff
			elseif xininfo2 then
				PIGA[xininfo1][xininfo2]=dataff
			elseif xininfo1 then
				PIGA[xininfo1]=dataff
			end
		end
		ReloadUI()
	else
		message(L["CONFIG_DERIVEERROR"]);
	end
end)
----
local function Config_RU(self,peizhiInfo)
	Config_Transfer:Show()
	Config_Transfer.daoruBut:Show();
	Config_Transfer.biaoti:SetText(self:GetText()..L["CONFIG_TABNAME"]);
	Config_Transfer.tishitxt:SetText(daoruTXT);
	Config_Transfer.NR.textArea:SetText("")
	Config_Transfer.daoruBut.peizhiInfo=peizhiInfo
end
addonTable.Fun.Config_RU=Config_RU