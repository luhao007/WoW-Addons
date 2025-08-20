local _, AddonTbl = ...

---@type DelveCompanion
local DelveCompanion = AddonTbl.DelveCompanion

--- Great Vault section improvements in Delves UI.
---@class (exact) DashboardGV
---@field ParentFrame GreatVaultButtonPanel
---@field CustomDetails GVDetailsFrame
local DashboardGV = {}
DelveCompanion.DelvesDashboard.GreatVault = DashboardGV


--- Create and set all required elements.
---@param GVPanel GreatVaultButtonPanel Blizzard Great Vault section frame in Delves UI.
function DashboardGV:Init(GVPanel)
    DashboardGV.ParentFrame = GVPanel

    GVPanel:SetWidth(200)
    GVPanel.PanelTitle:SetSize(160, 30)

    do
        ---@type GVDetailsFrame
        local gvDetailsFrame = CreateFrame("Frame",
            "$parent.CustomDetails", GVPanel,
            "DelveCompanionGreatVaultDetailsFrame")

        DashboardGV.CustomDetails = gvDetailsFrame
    end
end

--#region XML Annotations

--- `GreatVaultButtonPanel` ([Blizzard frame](https://www.townlong-yak.com/framexml/live/Blizzard_DelvesDashboardUI/Blizzard_DelvesDashboardUI.xml#369)).
---@class (exact) GreatVaultButtonPanel : DelvesDashboardButtonPanelFrame
---@field layoutIndex number
---@field GreatVaultButton Frame

--#endregion
