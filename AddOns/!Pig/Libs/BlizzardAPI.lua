local addonName, addonTable = ...;

----
function PIGGetMerchantItemInfo(index)
	local name, price, stackCount, numAvailable, spellID, texture
	if C_MerchantFrame and C_MerchantFrame.GetItemInfo then
		local info = C_MerchantFrame.GetItemInfo(index);
		if info then
			name=info.name
			price=info.price
			stackCount=info.stackCount
			numAvailable=info.numAvailable
			spellID=info.spellID
			texture=info.texture
		end
	else
		local name, texture, price, quantity, numAvailable, isPurchasable, isUsable, extendedCost, currencyID, spellID=GetMerchantItemInfo(index)
		name=name
		price=price
		numAvailable=numAvailable
		stackCount=quantity
		spellID=spellID
		texture=texture
	end
	return name, price, stackCount, numAvailable, spellID, texture
end
