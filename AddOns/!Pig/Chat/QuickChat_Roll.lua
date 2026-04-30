local addonName, addonTable = ...;
local QuickChatfun=addonTable.QuickChatfun
function QuickChatfun.QuickBut_Roll()
	local QuickUI=QuickChatfun.TabButUI
	QuickUI.ROLL=QuickUI:ADD_chatbutExt("interface/buttons/ui-grouploot-dice-up.blp",-8,-4, 0,-1,"|cff00FFff"..KEY_BUTTON1.."-|r|cffFFFF00Roll"..GUILD_BANK_LOG.."|r\n|cff00FFff"..KEY_BUTTON2.."-|r|cffFFFF00Roll")
	QuickUI.ROLL.X:Hide();
	QuickUI.ROLL:SetScript("OnClick", function(self, but)
		if but=="LeftButton" then
			ToggleLootHistoryFrame()
		else
			RandomRoll(1, 100)
		end
	end);
end