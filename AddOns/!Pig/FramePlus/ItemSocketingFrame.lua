local _, addonTable = ...;
local FramePlusfun=addonTable.FramePlusfun

function FramePlusfun.GemUIplus()
	if not PIGA["FramePlus"]["GemUIplus"] then return end
	addonTable.Fun.IsAddOnLoaded("Blizzard_ItemSocketingUI",function()
		local Create=addonTable.Create
		local PIGDiyBut=Create.PIGDiyBut
		local PIGCheckbutton=Create.PIGCheckbutton
		-----
		local butnum=8
		local ActionW = ActionButton1:GetWidth()-6
		ItemSocketingFrame.GemUIplusQuick = PIGCheckbutton(ItemSocketingFrame,{"BOTTOMLEFT",ItemSocketingFrame,"BOTTOMLEFT",10,5},{"一键镶嵌"},nil,nil,nil,0)
		ItemSocketingFrame.GemUIplusQuick:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIGA["FramePlus"]["GemUIplusQuick"]=true;
			else
				PIGA["FramePlus"]["GemUIplusQuick"]=false
			end
		end)
		ItemSocketingFrame.GemUIplusQuick:SetScript("OnShow", function (self)
			self:SetChecked(PIGA["FramePlus"]["GemUIplusQuick"])
		end)
		for _,SocketBut in pairs(ItemSocketingFrame.SocketingContainer.SocketFrames) do
			SocketBut.X= PIGDiyBut(SocketBut,{"BOTTOM",SocketBut, "TOP", 0,0},{24})
			SocketBut.X:Hide()
			SocketBut.X:SetScript("OnClick", function(self)
				self:GetParent():ClickSocketButton();
				ClearCursor()
			end)
		end
		ItemSocketingFrame.piggemLsit={}
		for i=1,butnum do
			local ButtonUI= PIGDiyBut(ItemSocketingFrame,{"TOPLEFT",ItemSocketingFrame, "BOTTOMLEFT", (ActionW+2)*(i-1)+5,2},{ActionW,nil,nil,nil,134400})
			ItemSocketingFrame.piggemLsit[i]=ButtonUI
			ButtonUI:SetScript("OnClick", function(self, button)
				C_Container.PickupContainerItem(self.bag, self.slot)
				if PIGA["FramePlus"]["GemUIplusQuick"] then
					C_ItemSocketInfo.ClickSocketButton(1);
					ClearCursor()
				end
			end)
		end
		local bagIDMax= addonTable.Data.bagData["bagIDMax"]
		local function PIGGetBagItemsList()
			for i=1,butnum do
				ItemSocketingFrame.piggemLsit[i]:Hide()
			end
			local ItemsD={}
		    for bag=0,bagIDMax do
				local NumSlots=C_Container.GetContainerNumSlots(bag)
				for slot=1,NumSlots do
					local itemID = C_Container.GetContainerItemID(bag, slot)
					if itemID and itemID~=6948 then
						local itemID, itemType, itemSubType, itemEquipLoc, icon, classID, subClassID=C_Item.GetItemInfoInstant(itemID)
						if classID==3 then
							table.insert(ItemsD,{bag, slot})
						end
					end
				end
			end
			for i=1,butnum do
				if ItemsD[i] then
					local itemID, itemLink, icon, _,quality,_,lootable = PIGGetContainerItemInfo(ItemsD[i][1], ItemsD[i][2])
					ItemSocketingFrame.piggemLsit[i].bag=ItemsD[i][1]
					ItemSocketingFrame.piggemLsit[i].slot=ItemsD[i][2]
					ItemSocketingFrame.piggemLsit[i].icon:SetTexture(icon)
					ItemSocketingFrame.piggemLsit[i]:Show()
				end
			end
			for _,SocketBut in pairs(ItemSocketingFrame.SocketingContainer.SocketFrames) do
				if C_ItemSocketInfo.GetNewSocketLink(SocketBut:GetID()) then
					SocketBut.X:Show()
				else
					SocketBut.X:Hide()
				end
			end	
		end
		PIGGetBagItemsList()
		ItemSocketingFrame:HookScript("OnEvent", function(self,event,arg1)
			if ( event == "SOCKET_INFO_UPDATE" ) then
				PIGGetBagItemsList()
			end
		end);
	end)
end