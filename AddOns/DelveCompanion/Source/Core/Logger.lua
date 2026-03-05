local addonName, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--#region Constants

local CONTROL_SAVE_KEY = "logsEnabled"
--#endregion

--- Utility class for printing debug information.
---@class (exact) Logger
---@field logsEnabled boolean Top-level toggle to control logging
local Logger = {}
DelveCompanion.Logger = Logger

--- Log a formatted string to the console if logging is enabled.
--- Acts as a wrapper around `print(string.format(...))`.
---@param self Logger
---@param stringText string The format string. Supports placeholders like %s, %d, etc.
---@param ... any Arguments to be substituted into the format string.
function Logger:Log(stringText, ...)
    if not self.logsEnabled then
        return
    end

    print(string.format(stringText, ...))
end

--- Log the contents of a table as key-value pairs.
--- Only top-level entries are shown; nested tables and functions are not recursively expanded.
---@param self Logger
---@param tbl table The table to log.
function Logger:LogTable(tbl)
    if type(tbl) ~= "table" then
        return
    end

    self:Log("==== Table dump ====")
    for key, value in pairs(tbl) do
        self:Log("Key: %s | Value: %s", key, tostring(value))
    end
    self:Log("==== End ====")
end

---@param self Logger
function Logger:Init()
    self.logsEnabled = DelveCompanionAccountData ~= nil and DelveCompanionAccountData.logsEnabled
        or DelveCompanion.Config.DEFAULT_ACCOUNT_DATA.logsEnabled

    do
        local function OnSettingChanged(_, changedVarKey, newValue)
            if changedVarKey == CONTROL_SAVE_KEY then
                self.logsEnabled = newValue
            end
        end

        EventRegistry:RegisterCallback(DelveCompanion.Definitions.Events.SETTING_CHANGE, OnSettingChanged, self)
    end
end
