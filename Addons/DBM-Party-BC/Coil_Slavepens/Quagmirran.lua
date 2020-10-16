local mod	= DBM:NewMod(572, "DBM-Party-BC", 4, 260)
local L		= mod:GetLocalizedStrings()

mod.statTypes = "normal,heroic,timewalker"

mod:SetRevision("20200912133955")
mod:SetCreatureID(17942)
mod:SetEncounterID(1940)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)
