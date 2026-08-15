local mod	= DBM:NewMod("CrucibleofStormsTrash", "DBM-Raids-BfA", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20260523021943")
mod:DisableHardcodedOptions()
--mod:SetModelID(47785)
mod.isTrashMod = true

mod:RegisterEvents(
	"SPELL_CAST_START 293957"
)

local specWarnMaddeningGaze				= mod:NewSpecialWarningDodge(293957, nil, nil, nil, 2, 2, nil, nil, "shockwave")

function mod:SPELL_CAST_START(args)
	local spellId = args.spellId
	if spellId == 293957 and self:AntiSpam(4, 1) then
		specWarnMaddeningGaze:Show()
		specWarnMaddeningGaze:Play("shockwave")
	end
end
