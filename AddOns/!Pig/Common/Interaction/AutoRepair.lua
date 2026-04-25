local _, addonTable = ...;
--=======================
MerchantFrame:HookScript("OnShow",function (self,event)
	if PIGA["Interaction"]["AutoRepair"] then
		if CanMerchantRepair() then --NPC是否可以修理
			local cost = GetRepairAllCost()--修理金额
			if cost > 0 then
				if PIG_MaxTocversion(20000,true) and PIGA["Interaction"]["AutoRepair_GUILD"] and IsInGuild() then
					local PIGguildMoney = GetGuildBankWithdrawMoney()--玩家的公会提取额度
					if PIGguildMoney > GetGuildBankMoney() then --公会金额小于提取金额
						PIGguildMoney = GetGuildBankMoney()
					end
					if PIGguildMoney >= cost and CanGuildBankRepair() then
						RepairAllItems(true);
						PIGprint(GUILDCONTROL_OPTION15..": " .. GetCoinTextureString(cost));	
						return
					end
				end
				----
				local money = GetMoney()--自身金钱
				if money >= cost then
					RepairAllItems()
					PIGprint(REPAIR_COST .. GetCoinTextureString(cost));
				else
					PIGprint(string.format(ERR_QUEST_FAILED_S,REPAIR_ITEMS)..ERR_TAXINOTENOUGHMONEY);
				end
			end
		end
	end
end)
