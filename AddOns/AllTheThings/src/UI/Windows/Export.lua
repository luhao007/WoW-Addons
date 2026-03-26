-- App locals
local _, app = ...;
local L = app.L;

local ExportStyle
local function UpdateExportStyle(row, button, styleID, active)
	ExportStyle = styleID
end
local function DoExport(t)
	if not ExportStyle then
		app.print("Please select a Style to Export")
		return
	end
	local window = app:GetWindow(t.text)
	app:ExportStylizedData(window, ExportStyle)
	app.print("Exported",window.Suffix,"as",ExportStyle,"style!")
end

-- Window
app:CreateWindow("Export", {
	Commands = {
		"attexport",
		-- "export",	-- TODO uncomment when fixing how commands are defined
	},
	OnInit = function(self, handlers)
		local styleGroup = app.CreateRawText("Style", {
			icon = app.asset("Category_TradingPost"),
			visible = true,
			expanded = true,
			back = 0.5,
			SortType = "Global",
			g = {},
		})
		-- self.StyleGroup = styleGroup
		for key in pairs(app.DataStyleExporters) do
			tinsert(styleGroup.g, app.CreateToggle(key, {
				name = key,
				parent = styleGroup,
				visible = true,
				OnUpdate = app.AlwaysShowUpdate,
				OnClickHandler = UpdateExportStyle
			}))
		end

		local windowsGroup = app.CreateRawText("Windows", {
			icon = app.asset("Category_WorldDrops"),
			visible = true,
			expanded = true,
			back = 0.5,
			g = {},
			OnUpdate = function(t)
				if not t.expanded then return end

				local rows = t.g
				wipe(rows)
				for suffix,window in pairs(app.Windows) do
					-- TODO: save a hash table of existing window-row links and just skip re-adding
					-- TODO: maybe wrap the window header data instead
					tinsert(rows, app.CreateRawText(window.Suffix, {
						OnUpdate = app.AlwaysShowUpdate,
						OnClick = DoExport,
						parent = t,
						back = 0.2,
					}))
				end
				t.SortType = "Global"
				return true
			end,
		})

		self:SetData(app.CreateRawText("Export", {
			-- icon = app.asset("Interface_Vendor"),
			description = "Allows exporting the data of an active window using a specified Style.",
			g = {
				styleGroup,
				windowsGroup,
			},
		}))
	end,
})
