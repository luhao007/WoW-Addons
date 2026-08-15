local addonName, PD = ...;

---
function PIGSetTexAtlas(fujik,iconID)
	if type(iconID)=="number" then
		fujik:SetTexture(iconID)
	else
		fujik:SetAtlas(iconID)
	end
end
-- function Fun.PIGSetAtlas(buticon,Atlas,useAtlasSize,hWrapMode,vWrapMode)
-- 	if not PD.Data.AtlasInfo then return false end
-- 	for k,v in pairs(PD.Data.AtlasInfo) do
-- 		if v[Atlas] then
-- 			buticon:SetTexture(k,hWrapMode,vWrapMode)
-- 			buticon:SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
-- 			return true
-- 		end
-- 	end
-- 	return false
-- end
-- function Fun.PIGSetButtonNormalAtlas(buticon,Atlas)
-- 	if not PD.Data.AtlasInfo then return false end
-- 	for k,v in pairs(PD.Data.AtlasInfo) do
-- 		if v[Atlas] then
-- 			buticon:SetNormalTexture(k)
-- 			buticon:GetNormalTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
-- 		end
-- 	end
-- end
-- function Fun.PIGSetButtonPushedAtlas(buticon,Atlas)
-- 	if not PD.Data.AtlasInfo then return false end
-- 	for k,v in pairs(PD.Data.AtlasInfo) do
-- 		if v[Atlas] then
-- 			buticon:SetPushedTexture(k)
-- 			buticon:GetPushedTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
-- 		end
-- 	end
-- end
-- function Fun.PIGSetButtonDisabledAtlas(buticon,Atlas)
-- 	if not PD.Data.AtlasInfo then return false end
-- 	for k,v in pairs(PD.Data.AtlasInfo) do
-- 		if v[Atlas] then
-- 			buticon:SetDisabledTexture(k)
-- 			buticon:GetDisabledTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
-- 		end
-- 	end
-- end
-- function Fun.PIGSetButtonHighlightAtlas(buticon,Atlas)
-- 	if not PD.Data.AtlasInfo then return false end
-- 	for k,v in pairs(PD.Data.AtlasInfo) do
-- 		if v[Atlas] then
-- 			buticon:SetHighlightTexture(k)
-- 			buticon:GetHighlightTexture():SetTexCoord(v[Atlas][3], v[Atlas][4], v[Atlas][5], v[Atlas][6])
-- 		end
-- 	end
-- end