local addonName, PD = ...;
local L=PD.locale
---
local Create=PD.Create
local PIGOptionsList=Create.PIGOptionsList
local PIGOptionsList_RF=Create.PIGOptionsList_RF
---
local CombatPlusfun={}
PD.CombatPlusfun=CombatPlusfun
function PD.addOptions_CombatPlus()
	local fuFrame,fuFrameBut = PIGOptionsList(L["COMBAT_TABNAME"],"TOP")
	CombatPlusfun.fuFrame=fuFrame
	CombatPlusfun.fuFrameBut=fuFrameBut

	local RTabFrame =Create.PIGOptionsList_RF(fuFrame,30)
	CombatPlusfun.RTabFrame=RTabFrame
	CombatPlusfun.addOptions_Marker()
	CombatPlusfun.addOptions_HPMPBar()
	CombatPlusfun.addOptions_AttackBar()
	CombatPlusfun.addOptions_FastFocus()
end
--=========================
PD.CombatPlus = function()
	CombatPlusfun.Marker()
	CombatPlusfun.HPMPBar()
	CombatPlusfun.AttackBar()
	CombatPlusfun.FastFocus()
end