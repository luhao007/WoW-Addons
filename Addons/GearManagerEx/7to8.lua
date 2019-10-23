-- Use C_EquipmentSet.SaveEquipmentSet(equipmentSetID[, newIcon]) instead
function SaveEquipmentSet(equipmentSetName, newIcon)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    C_EquipmentSet.SaveEquipmentSet(equipmentSetID, newIcon);
end
-- Use C_EquipmentSet.DeleteEquipmentSet(equipmentSetID) instead
function DeleteEquipmentSet(equipmentSetName)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    C_EquipmentSet.DeleteEquipmentSet(equipmentSetID);
end
-- Use C_EquipmentSet.ModifyEquipmentSet(equipmentSetID, newName, newIcon) instead
function ModifyEquipmentSet(oldName, newName, newIcon)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(oldName);
    C_EquipmentSet.ModifyEquipmentSet(equipmentSetID, newName, newIcon);
end
-- Use C_EquipmentSet.IgnoreSlotForSave(slot) instead
function EquipmentManagerIgnoreSlotForSave(slot)

end
-- Use C_EquipmentSet.IsSlotIgnoredForSave(slot) instead
function EquipmentManagerIsSlotIgnoredForSave(slot)
    return C_EquipmentSet.IsSlotIgnoredForSave(slot);
end
-- Use C_EquipmentSet.ClearIgnoredSlotsForSave() instead
function EquipmentManagerClearIgnoredSlotsForSave()
    C_EquipmentSet.ClearIgnoredSlotsForSave();
end
-- Use C_EquipmentSet.UnignoreSlotForSave(slot) instead
function EquipmentManagerUnignoreSlotForSave(slot)
    C_EquipmentSet.UnignoreSlotForSave(slot);
end
-- Use C_EquipmentSet.GetNumEquipmentSets() instead
function GetNumEquipmentSets()
    return C_EquipmentSet.GetNumEquipmentSets();
end
-- Use C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID) instead
function GetEquipmentSetInfo(equipmentSetIndex)
    local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs();
    if type(equipmentSetIDs[equipmentSetIndex]) == "number" then
        return C_EquipmentSet.GetEquipmentSetInfo(equipmentSetIDs[equipmentSetIndex]);
    end
end
-- Use C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID) instead
function GetEquipmentSetInfoByName(equipmentSetName)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    return C_EquipmentSet.GetEquipmentSetInfo(equipmentSetID);
end
-- Use C_EquipmentSet.EquipmentSetContainsLockedItems(equipmentSetID) instead
function EquipmentSetContainsLockedItems(equipmentSetName)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    return C_EquipmentSet.EquipmentSetContainsLockedItems(equipmentSetID);
end
-- Use C_EquipmentSet.PickupEquipmentSet(equipmentSetID) instead
function PickupEquipmentSetByName(equipmentSetName)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    C_EquipmentSet.PickupEquipmentSet(equipmentSetID);
end
-- Use C_EquipmentSet.PickupEquipmentSet(equipmentSetID) instead
function PickupEquipmentSet(equipmentSetIndex)
    local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs();
    C_EquipmentSet.PickupEquipmentSet(equipmentSetIDs[equipmentSetIndex]);
end
-- Use C_EquipmentSet.UseEquipmentSet(equipmentSetID) instead
function UseEquipmentSet(equipmentSetName)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    C_EquipmentSet.UseEquipmentSet(equipmentSetID);
end
-- Use C_EquipmentSet.CanUseEquipmentSets() instead
function CanUseEquipmentSets()
    return C_EquipmentSet.CanUseEquipmentSets();
end
-- Use C_EquipmentSet.GetItemIDs(equipmentSetID) instead
function GetEquipmentSetItemIDs(equipmentSetName, returnTable)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    returnTable = returnTable or {};
    return Mixin(returnTable, C_EquipmentSet.GetItemIDs(equipmentSetID));
end
-- Use C_EquipmentSet.GetItemLocations(equipmentSetID) instead
function GetEquipmentSetLocations(equipmentSetName, returnTable)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    returnTable = returnTable or {};
    return Mixin(returnTable, C_EquipmentSet.GetItemLocations(equipmentSetID));
end

-- Use C_EquipmentSet.GetIgnoredSlots(equipmentSetID) instead
function GetEquipmentSetIgnoreSlots(equipmentSetName, returnTable)
    local equipmentSetID = C_EquipmentSet.GetEquipmentSetID(equipmentSetName);
    returnTable = returnTable or {};
    return Mixin(returnTable, C_EquipmentSet.GetIgnoredSlots(equipmentSetID));
end
