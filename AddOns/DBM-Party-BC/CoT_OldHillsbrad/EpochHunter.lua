local mod	= DBM:NewMod(540, "DBM-Party-BC", 11, 251)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20190417010024")
mod:SetCreatureID(18096)
mod:SetEncounterID(1906)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
)