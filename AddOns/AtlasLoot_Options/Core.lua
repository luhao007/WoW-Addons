local _G = getfenv(0)
local LibStub = _G.LibStub

local AtlasLoot = _G.AtlasLoot
local Options = {}
local AL = AtlasLoot.Locales

AtlasLoot.Options = Options
local db = AtlasLoot.db
local Addons = _G.AtlasLoot.Addons
local FavAddon = _G.AtlasLoot.Addons:GetAddon("Favourites")

local AceGUI = LibStub("AceGUI-3.0")
local AC = LibStub("AceConfig-3.0");
local ACD = LibStub("AceConfigDialog-3.0");

local function UpdateItemFrame(addon)
	if addon then
		Addons:UpdateStatus(addon:GetName())
	end
	if AtlasLoot.GUI.frame and AtlasLoot.GUI.frame:IsShown() then
		AtlasLoot.GUI.ItemFrame:Refresh(true)
	end
end

local function ImportItemList(listName, listID, isGlobal)
	---@class AceGUIFrame
	local frame = AceGUI:Create("Frame")
	frame:SetTitle(AL["Import item list"])
	frame:SetStatusText(listName)
	frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame:SetLayout("Flow")

	---@class AceGUICheckBox
	local checkBox = AceGUI:Create("CheckBox")
	checkBox:SetValue(false)
	checkBox:SetLabel(AL["Replace existing items"])
	frame:AddChild(checkBox)

	---@class AceGUIMultiLineEditBox
	local multiEditbox = AceGUI:Create("MultiLineEditBox")
	multiEditbox:SetText("")
	multiEditbox:SetFocus()
	multiEditbox:SetFullWidth(true)
	multiEditbox:SetFullHeight(true)
	multiEditbox:SetCallback("OnEnterPressed", function(self, script, text)
		local addedItems = FavAddon:ImportItemList(listID, isGlobal, text, checkBox:GetValue())
		UpdateItemFrame(FavAddon)
		AtlasLoot:Print(format(AL["Added |cff00ff00%d|r items into list |cff00ff00%s|r."], addedItems or 0, listName))
		frame:Hide()
	end)
	frame:AddChild(multiEditbox)
end

local function ExportItemList(listName, listString)
	---@class AceGUIFrame
	local frame = AceGUI:Create("Frame")
	frame:SetTitle(AL["Export item list"])
	frame:SetStatusText(listName)
	frame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end)
	frame:SetLayout("Fill")

	---@class AceGUIMultiLineEditBox
	local multiEditbox = AceGUI:Create("MultiLineEditBox")
	multiEditbox:SetText(listString or "")
	multiEditbox:HighlightText(0)
	multiEditbox:DisableButton(true)
	multiEditbox:SetFocus()
	multiEditbox:SetFullWidth(true)
	multiEditbox:SetFullHeight(true)
	frame:AddChild(multiEditbox)
end

local options = {
	type = "group",
	name = AL["AtlasLoot"],
	args = {
		general = {
			order = 1,
			name = AL["General"],
			type = "group",
			args = {
				autoselect = {
					order = 1,
					type = "toggle",
					width = "full",
					name = AL["Auto select current instance's loot tables."],
					get = function(info) return db.GUI.autoselect end,
					set = function(info, value) db.GUI.autoselect = value end,
				},
				showbutton = {
					order = 2,
					type = "toggle",
					width = "full",
					name = AL["Show AtlasLoot button on WorldMap."],
					get = function(info) return db.WorldMap.showbutton end,
					set = function(info, value)
						db.WorldMap.showbutton = value;
						AtlasLoot.WorldMap.ToggleButtonOnChange();
					end,
				},
				ExpansionIcon = {
					order = 3,
					type = "toggle",
					width = "full",
					name = AL["Show expansion icons in module dropdown."],
					desc = AL["Change will take effect in next login."],
					get = function(info) return db.GUI.ExpansionIcon end,
					set = function(info, value) db.GUI.ExpansionIcon = value end,
				},
				shown = {
					order = 4,
					type = "toggle",
					width = "full",
					name = AL["Show minimap button."],
					get = function(info) return db.minimap.shown end,
					set = function(info, value)
						db.minimap.shown = value;
						AtlasLoot.MiniMapButton.Options_Toggle();
					end,
				},
				scale = {
					order = 5,
					type = "range",
					name = AL["Scale"],
					min = 0.5,
					max = 1.5,
					bigStep = 0.01,
					isPercent = true,
					width = "full",
					get = function(info) return db.GUI.mainFrame.scale end,
					set = function(info, value)
						db.GUI.mainFrame.scale = value
						AtlasLoot.GUI.RefreshMainFrame()
					end,
				},
			}
		},
		tooltip = {
			order = 2,
			name = AL["Tooltip"],
			type = "group",
			args = {
				useGameTooltip = {
					order = 1,
					type = "toggle",
					width = "full",
					name = AL["Use GameTooltip"],
					desc = AL["Use the standard GameTooltip instead of the custom AtlasLoot tooltip"],
					get = function(info) return db.Tooltip.useGameTooltip end,
					set = function(info, value) db.Tooltip.useGameTooltip = value end,
				},
				alwaysShowCompareTT = {
					order = 2,
					type = "toggle",
					width = "full",
					name = AL["Always show item comparison."],
					get = function(info) return db.Button.Item.alwaysShowCompareTT end,
					set = function(info, value) db.Button.Item.alwaysShowCompareTT = value end,
				},
				alwaysShowPreviewTT = {
					order = 3,
					type = "toggle",
					width = "full",
					name = AL["Always show quick preview."],
					get = function(info) return db.Button.Item.alwaysShowPreviewTT end,
					set = function(info, value) db.Button.Item.alwaysShowPreviewTT = value end,
				},
			}
		},
		bonusloot = {
			order = 3,
			name = AL["AddOn: Bonus Loot"],
			type = "group",
			args = {
				enabled = {
					order = 1,
					type = "toggle",
					width = "full",
					name = ENABLE,
					get = function(info) return db.Addons.BonusRoll.enabled end,
					set = function(info, value) db.Addons.BonusRoll.enabled = value end,
				},
			}
		},
		favourites = {
			order = 4,
			name = AL["AddOn: Favourites"],
			type = "group",
			get = function(info) return FavAddon.db[info[#info]] end,
			set = function(info, value)
				FavAddon.db[info[#info]] = value
				Addons:UpdateStatus("Favourites")
			end,
			args = {
				enabled = {
					order = 1,
					type = "toggle",
					width = "full",
					name = ENABLE,
					set = function(info, value)
						FavAddon.db[info[#info]] = value
						UpdateItemFrame(FavAddon)
					end
				},
				showIconInTT = {
					order = 2,
					type = "toggle",
					width = "full",
					name = AL["Show favourite item icon in item tooltip"],
				},
				showListInTT = {
					order = 3,
					type = "toggle",
					width = "full",
					name = AL["Show listname in item tooltip"],
				},
				global = {
					order = 4,
					type = "toggle",
					width = "full",
					name = AL["Global lists"],
					get = function(info) return FavAddon:GetDb().activeList[2] end,
					set = function(info, value)
						local db = FavAddon:GetDb()
						db.activeList[1] = value and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
						db.activeList[2] = value
						UpdateItemFrame(FavAddon)
					end
				},
				list = {
					type = "select",
					order = 5,
					name = AL["Active list"],
					width = "double",
					values = function()
						local db = FavAddon:GetDb()
						local listDb
						local list = {}
						if db.activeList[2] == true then
							listDb = FavAddon:GetGlobaleLists()
						else
							listDb = FavAddon:GetProfileLists()
						end
						for k, v in pairs(listDb) do
							list[k] = FavAddon:GetListName(k, db.activeList[2] == true, true)
						end
						return list
					end,
					sorting = function()
						local db = FavAddon:GetDb()
						local listDb
						local list = {}
						if db.activeList[2] == true then
							listDb = FavAddon:GetGlobaleLists(true)
						else
							listDb = FavAddon:GetProfileLists(true)
						end
						for k, v in ipairs(listDb) do
							list[k] = v.id
						end
						return list
					end,
					get = function(info) return FavAddon:GetDb().activeList[1] end,
					set = function(info, value)
						FavAddon:GetDb().activeList[1] = value
						UpdateItemFrame(FavAddon)
					end,
				},
				addNewList = {
					order = 6,
					type = 'execute',
					name = AL["Add new list"],
					confirm = true,
					func = function()
						local newList = FavAddon:AddNewList(FavAddon:GetDb().activeList[2])
						if newList then
							FavAddon:GetDb().activeList[1] = newList
							UpdateItemFrame(FavAddon)
						end
					end,
				},
				deleteList = {
					order = 7,
					type = 'execute',
					name = AL["Delete list"],
					confirm = true,
					disabled = function(info)
						local db = FavAddon:GetDb().activeList
						if db[1] == FavAddon.BASE_NAME_P or db[1] == FavAddon.BASE_NAME_G then
							return true
						else
							return false
						end
					end,
					func = function()
						local db = FavAddon:GetDb().activeList
						local deleted = FavAddon:RemoveList(db[1], db[2])
						if deleted then
							db[1] = db[2] and FavAddon.BASE_NAME_G or FavAddon.BASE_NAME_P
							UpdateItemFrame(FavAddon)
						end
					end,
				},
				headerSetting = {
					order = 10,
					type = "header",
					name = AL["Selected list settings"],
				},
				name = {
					order = 11,
					type = 'input',
					name = _G.NAME,
					width = "full",
					func = function() FavAddon:AddNewList() end,
					get = function(info) return FavAddon:GetActiveListName() end,
					set = function(info, value)
						FavAddon:SetActiveListName(value)
						UpdateItemFrame(FavAddon)
					end,
				},
				import = {
					order = 12,
					type = "execute",
					name = AL["Import item list"],
					func = function(info)
						local db = FavAddon:GetDb()
						ImportItemList(FavAddon:GetActiveListName(), db.activeList[1], db.activeList[2])
					end,
				},
				export = {
					order = 13,
					type = "execute",
					name = AL["Export item list"],
					func = function(info)
						local db = FavAddon:GetDb()
						ExportItemList(FavAddon:GetActiveListName(), FavAddon:ExportItemList(db.activeList[1], db.activeList[2]))
					end,
				},
				clearList = {
					order = 14,
					type = "execute",
					name = AL["Clear list"],
					desc = function() return format(AL["Remove |cffff0000%d|r items from list."], FavAddon:GetNumItemsInList()) end,
					confirm = true,
					func = function(info)
						FavAddon:ClearList()
						UpdateItemFrame()
					end,
				},
				useGlobal = {
					order = 15,
					type = "toggle",
					width = "full",
					name = AL["Always active for all Profiles."],
					desc = AL["Always marks items as favourite for every profile if enabled."],
					hidden = function(info) return not FavAddon:GetDb().activeList[2] end,
					get = function(info) return FavAddon:ListIsGlobalActive(FavAddon:GetDb().activeList[1]) end,
					set = function(info, value)
						local db = FavAddon:GetDb()
						if value then
							FavAddon:AddIntoShownList(db.activeList[1], db.activeList[2], true)
						else
							FavAddon:RemoveFromShownList(db.activeList[1], db.activeList[2], true)
						end
						UpdateItemFrame(FavAddon)
					end
				},
				useProfile = {
					order = 16,
					type = "toggle",
					width = "full",
					name = function() return format(AL["Always active for profile: |cff00ff00%s|r"], AtlasLoot.dbRaw:GetCurrentProfile()) end,
					desc = function() return format(AL["Always marks items as favourite for profile |cff00ff00%s|r if enabled."], AtlasLoot.dbRaw:GetCurrentProfile()) end,
					get = function(info) return FavAddon:ListIsProfileActive(FavAddon:GetDb().activeList[1]) end,
					set = function(info, value)
						local db = FavAddon:GetDb()
						if value then
							FavAddon:AddIntoShownList(db.activeList[1], db.activeList[2], false)
						else
							FavAddon:RemoveFromShownList(db.activeList[1], db.activeList[2], false)
						end
						UpdateItemFrame(FavAddon)
					end
				},
				iconSelection = {
					type = "group",
					name = AL["Icon"],
					inline = true,
					order = -1,
					get = function(info) return FavAddon.db[info[#info]] end,
					set = function(info, value)
						FavAddon.db[info[#info]] = value
						FavAddon:SetIcon(value)
					end,
					args = {
						useIcon = {
							order = 1,
							type = "toggle",
							width = "full",
							name = _G.DEFAULT,
							disabled = function(info) return not FavAddon:HasIcon() end,
							get = function(info) return not FavAddon:HasIcon() end,
							set = function(info, value)
								FavAddon:SetIcon(nil)
								UpdateItemFrame(FavAddon)
							end
						},
					},
				},
			},
		}
	},
}

-- icons
local args = options.args.favourites.args.iconSelection.args
local iconList = FavAddon.IconList
local count = 1
for i = 3, #iconList do
	local icon = iconList[i]
	count = count + 1
	args[icon] = {
		order = count,
		type = "execute",
		name = function(info)
			return FavAddon:GetIcon() == info[#info] and "^" or ""
		end,
		image = icon,
		imageWidth = 20,
		imageHeight = 20,
		width = 0.3,
		func = function(info)
			FavAddon:SetIcon(info[#info])
			UpdateItemFrame(FavAddon)
		end,
	}
end

AC:RegisterOptionsTable("AtlasLoot_options", options);
AtlasLoot.optionsFrame = ACD:AddToBlizOptions("AtlasLoot_options", "AtlasLoot")

local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(AtlasLoot.dbRaw);
AC:RegisterOptionsTable("AtlasLoot_Profiles", profiles)
ACD:AddToBlizOptions("AtlasLoot_Profiles", "Profiles", "AtlasLoot")
