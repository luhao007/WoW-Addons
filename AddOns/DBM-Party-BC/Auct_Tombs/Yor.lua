local mod	= DBM:NewMod(536, "DBM-Party-BC", 8, 250)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,timewalker"

mod.statTypes = "heroic,timewalker"

mod:SetRevision("20200912133955")
mod:SetCreatureID(22930)
--mod:SetEncounterID(250)--Verify before enable

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
