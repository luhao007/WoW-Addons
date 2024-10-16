local inited = false
local function registerTdScript()
    local tdBattlePetScriptAddon = tdBattlePetScript or PetBattleScripts
    if tdBattlePetScriptAddon then
        if inited then
            return
        end
        tdBattlePetScriptAddon:RegisterCondition(
            "count",
            {type = "compare", arg = false},
            function(owner, pet)
                return C_PetBattles.GetNumPets(owner)
            end
        )

        tdBattlePetScriptAddon:RegisterCondition(
            "hp.explode",
            {type = "boolean", arg = false},
            function(owner, pet)
                local player, enemy
                if owner == LE_BATTLE_PET_ENEMY then
                    player = C_PetBattles.GetActivePet(LE_BATTLE_PET_ALLY)
                    enemy = pet
                else
                    player = pet
                    enemy = C_PetBattles.GetActivePet(LE_BATTLE_PET_ENEMY)
                end
                return C_PetBattles.GetHealth(LE_BATTLE_PET_ENEMY, enemy) <
                    floor(C_PetBattles.GetMaxHealth(LE_BATTLE_PET_ALLY, player) * 0.4)
            end
        )
        inited = true
    end
end

local frame = CreateFrame("FRAME", nil, UIParent)
frame:SetScript(
    "OnEvent",
    function()
        registerTdScript()
    end
)
frame:RegisterEvent("ADDON_LOADED")
