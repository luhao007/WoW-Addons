--[===[ File
This file contains routines used by Titan to show and process the Titan options.
Titan uses Ace libraries to place the Titan options within the Blizzard option screens.

Most routines in this file are local because they create the Titan options.
These routines are called first when Titan processes the 'player entering world' event.
If an options list (skins, extra, etc) is changed by the user then the Ace table needs to be updated and WoW server is informed to 'redraw'.
--]===]

local L = LibStub("AceLocale-3.0"):GetLocale(TITAN_ID, true)
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local media = LibStub("LibSharedMedia-3.0")

local font_list = {} -- filled later

local TitanSkinToRemove = "None";
local TitanSkinName, TitanSkinPath = "", "";

TITAN_PANEL_CONFIG = {
	topic = {
		About      = L["TITAN_PANEL"],
		top        = L["TITAN_PANEL_MENU_OPTIONS_BARS"],
		globals    = L["TITAN_PANEL_MENU_OPTIONS_BARS_ALL"],
		plugins    = L["TITAN_PANEL_MENU_PLUGINS"],
		profiles   = L["TITAN_PANEL_MENU_PROFILES"],
		tooltips   = L["TITAN_PANEL_MENU_OPTIONS_SHORT"],
		scale      = L["TITAN_PANEL_UISCALE_MENU_TEXT_SHORT"],
		trans      = L["TITAN_PANEL_TRANS_MENU_TEXT_SHORT"],
		skins      = L["TITAN_PANEL_MENU_TEXTURE_SETTINGS"],
		skinscust  = L["TITAN_PANEL_SKINS_OPTIONS_CUSTOM"],
		extras     = L["TITAN_PANEL_EXTRAS_SHORT"],
		attempts   = L["TITAN_PANEL_ATTEMPTS_SHORT"],
		advanced   = L["TITAN_PANEL_MENU_ADV"],
		changes    = L["TITAN_PANEL_MENU_CHANGE_HISTORY"],
		slash      = L["TITAN_PANEL_MENU_SLASH_COMMAND"],
		help_list  = "Help List", --L["TITAN_PANEL_MENU_HELP"],
		im_ex_port = "Import / Export", --L["TITAN_PANEL_MENU_HELP"],
		adjust     = "Frame Adjustment",
	}
}

-- Titan local helper funcs
local function GetTitle()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "Title") or L["TITAN_PANEL_NA"];
end

local function GetAuthor()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "Author") or L["TITAN_PANEL_NA"];
end

local function GetCredits()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "X-Credits") or L["TITAN_PANEL_NA"];
end

local function GetCategory()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "X-Category") or L["TITAN_PANEL_NA"];
end

local function GetEmail()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "X-Email") or L["TITAN_PANEL_NA"];
end

local function GetLicense()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "X-License") or L["TITAN_PANEL_NA"];
end

local function GetDiscord()
	return TitanUtils_GetAddOnMetadata(TITAN_ID, "X-Discord") or L["TITAN_PANEL_NA"];
end

local function ScreenAdjustReload()
	if TitanPanelGetVar("ScreenAdjust") then
		-- if set then clear it - the screen will adjust
		TitanPanelBarButton_ToggleScreenAdjust()
	else
		-- if NOT set then need a reload - the screen will NOT adjust
		StaticPopupDialogs["TITAN_RELOAD"] = {
			text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]) .. "\n\n"
				.. L["TITAN_PANEL_RELOAD"],
			button1 = ACCEPT,
			button2 = CANCEL,
			OnAccept = function(self)
				TitanPanelToggleVar("ScreenAdjust");
				ReloadUI();
			end,
			showAlert = 1,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = 1
		};
		StaticPopup_Show("TITAN_RELOAD");
	end
end

local function AuxScreenAdjustReload()
	if TitanPanelGetVar("AuxScreenAdjust") then
		-- if set then clear it - the screen will adjust
		TitanPanelBarButton_ToggleAuxScreenAdjust()
	else
		-- if NOT set then need a reload - the screen will NOT adjust
		StaticPopupDialogs["TITAN_RELOAD"] = {
			text = TitanUtils_GetNormalText(L["TITAN_PANEL_MENU_TITLE"]) .. "\n\n"
				.. L["TITAN_PANEL_RELOAD"],
			button1 = ACCEPT,
			button2 = CANCEL,
			OnAccept = function(self)
				TitanPanelToggleVar("AuxScreenAdjust");
				ReloadUI();
				--				TitanPanelBarButton_ToggleAuxScreenAdjust();
			end,
			showAlert = 1,
			timeout = 0,
			whileDead = 1,
			hideOnEscape = 1
		};
		StaticPopup_Show("TITAN_RELOAD");
	end
end

--============= Titan Panel entry / About
--
--[[ local
NAME: titan_entry
DESC: Local table to hold the 'about' Titan info in the options.
--]]
local titan_entry = {
	name = TITAN_PANEL_CONFIG.topic.About,
	desc = L["TITAN_PANEL"],
	type = "group",
	args = {
		confgendesc = {
			name = "Description",
			order = 1,
			type = "group",
			inline = true,
			args = {
				confdesc = {
					order = 1,
					type = "description",
					name = ""
						..
						"Titan Panel is an Interface Enhancement addon which allows you to add short display bars to the UI as well as bars to the top and bottom of your game screen."
						.. "\n\n"
						..
						"This addon does not interfere with, enhance, or replace any of your actual gameplay within the game. Titan Panel is meant to give you a quick visual point or click-on access to see the data related to your character without having to open other dialog boxes in the game or, in some cases, other addons."
						.. "\n\n"
						.. "Our main program allows you to add bars to the UI as well as the top and bottom of your game screen."
						.. "\n\n"
						..
						"Over the years, we have been able to add some other features, but only if they do not interfere with your actual game experience.",
					cmdHidden = true
				},
			}
		},
		confinfodesc = {
			name = L["TITAN_PANEL_ABOUT"],
			order = 7,
			type = "group",
			inline = true,
			args = {
				confversiondesc = {
					order = 1,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_VERSION"] .. ": ")
						.. TitanUtils_GetGreenText(TitanPanel_GetVersion()),
					cmdHidden = true
				},
				confauthordesc = {
					order = 2,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_AUTHOR"] .. ": ")
						.. TitanUtils_GetGreenText(GetAuthor()),
					cmdHidden = true
				},
				confcreditsdesc = {
					order = 3,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_CREDITS"] .. ": ")
						.. TitanUtils_GetGreenText(GetCredits()),
					cmdHidden = true
				},
				confcatdesc = {
					order = 4,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_CATEGORY"] .. ": ")
						.. TitanUtils_GetGreenText(GetCategory()),
					cmdHidden = true
				},
				confemaildesc = {
					order = 5,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_EMAIL"] .. ": ")
						.. TitanUtils_GetGreenText(GetEmail()),
					cmdHidden = true
				},
				confdiscorddesc = {
					order = 5,
					type = "description",
					name = TitanUtils_GetGoldText("Discord Site: ") --(L["TITAN_PANEL_ABOUT_EMAIL"] .. ": ")
						.. TitanUtils_GetGreenText(GetDiscord()),
					cmdHidden = true
				},
				conflicensedesc = {
					order = 7,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_ABOUT_LICENSE"] .. ": ")
						.. TitanUtils_GetGreenText(GetLicense()),
					cmdHidden = true
				},
			}
		},
	}
}

--============= Frame Adjust
--
--[[ local
NAME: optionsAdjust
DESC: Bar control for the main (top) bars:
Each bar:
- Show
- Auto hide
- Center text (plugins)
Main (top) controls:
- Disable screen adjust - allows character frame and minimap to be 'over' the Titan bars
- Disable minimap adjust - allows the minimap to be 'over' the Titan bars
- Ticket frame adjust - adjusts the Blizz open ticket frame to be under the Titan bar(s)
:DESC
--]]
local optionsAdjust = {
	name = TITAN_PANEL_CONFIG.topic.adjust,
	type = "group",
	args = {
	}
}

local function ColorAdjShown(frame_str)
	local res = ""
	if TitanAdjustSettings[frame_str].adjust then
		res = frame_str -- leave as is
	else
		res = TitanUtils_GetGrayText(frame_str)
	end

	return res
end

--[[ local
NAME: TitanUpdateAdj
DESC: Allow the user to control each Titan bar.
:DESC
VAR:  None
OUT:  None
--]]
local function TitanUpdateAdj(t, pos)
	local args = t
	local position = pos

	-- sort the bar data by their intended order
	local bar_list = {}
	local i = 0
	for idx, v in pairs(Titan_Global.AdjList) do
		i = i + 1
		bar_list[i] = v
	end
	table.sort(bar_list, function(a, b)
		return a.frame_name < b.frame_name
	end)

	wipe(args)

	for idx = 1, #bar_list do
		-- ======
		-- Build the frame adjust list in order (left side)
		-- NOTE: v.name is the 'group' name which is the table passed to callbacks : info[1]
		local f_name = bar_list[idx].frame_name
		local v = TitanAdjustSettings[f_name] -- process this frame
		position = position + 1
		args[f_name] = {
			type = "group",
			name = ColorAdjShown(f_name),
			order = position,
		}
		-- ======
		-- adjust options (right side)
		args[f_name].args = {} -- .args caused the nesting / right side
		position = position + 1 -- Title divider
		args[f_name].args.title = {
			type = "header",
			name = bar_list[idx].purpose,
			order = position,
			width = "full",
		}
		position = position + 1 -- Show toggle
		args[f_name].args.show = {
			type = "toggle",
			width = .75, --"fill",
			name = Titan_Global.literals.use,
			order = position,
			get = function(info)
				local frame_str = f_name
				return TitanAdjustSettings[frame_str].adjust
			end,
			set = function(info, val)
				local frame_str                       = f_name
				TitanAdjustSettings[frame_str].adjust = not TitanAdjustSettings[frame_str].adjust
				TitanPanel_AdjustFrame(frame_str,
					"Adjust show changed : " .. tostring(TitanAdjustSettings[frame_str].adjust))
				TitanUpdateAdj(optionsAdjust.args, 1000)
			end,
		}
		-- ======
		position = position + 1 -- offset
		args[f_name].args.offset = {
			type = "range",
			width = "full",
			name = "Vertical Adjustment",
			order = position,
			min = -200,
			max = 600,
			step = 1,
			get = function(info)
				local frame_str = f_name
				return TitanAdjustSettings[frame_str].offset
			end,
			set = function(info, a)
				local frame_str                       = f_name
				TitanAdjustSettings[frame_str].offset = a
				TitanPanel_AdjustFrame(frame_str, "Adjust offset changed : " .. tostring(a))
			end,
		}
		position = position + 1 -- spacer
		args[f_name].args.colorspacer = {
			order = position,
			type = "description",
			width = "full",
			name = " ",
		}
	end

	-- Config Tables changed!
	AceConfigRegistry:NotifyChange("Titan Panel Bars")
end

local function BuildAdj()
	TitanUpdateAdj(optionsAdjust.args, 1000)
	AceConfigRegistry:NotifyChange("Titan Panel Adjust")
end

--============= Bars
--
--[[ local
NAME: optionsBars
DESC: Bar control for the main (top) bars:
Each bar:
- Show
- Auto hide
- Center text (plugins)
Main (top) controls:
- Disable screen adjust - allows character frame and minimap to be 'over' the Titan bars
- Disable minimap adjust - allows the minimap to be 'over' the Titan bars
- Ticket frame adjust - adjusts the Blizz open ticket frame to be under the Titan bar(s)
:DESC
--]]
local optionsBars = {
	name = TITAN_PANEL_CONFIG.topic.top,
	type = "group",
	args = {
	}
}

local function ColorShown(bar)
	local res = bar.locale_name
	local frame_str = bar.frame_name
	if TitanBarDataVars[frame_str].show then
		-- leave as is
	else
		res = TitanUtils_GetGrayText(res)
	end

	return res
end

---X or Y into a string (<num>.yy)
---@param coord number
---@return string
local function Format_coord(coord)
	return (tostring(format("%0.2f", coord)))
end

--[[ local
NAME: TitanUpdateConfigBars
DESC: Allow the user to control each Titan bar.
:DESC
VAR:  None
OUT:  None
--]]
local function TitanUpdateConfigBars(t, pos)
	local function IfColor(info, bar_short)
		local frame_str = TitanVariables_GetFrameName(bar_short)
		return (TitanBarDataVars[frame_str].texure == Titan_Global.COLOR)
	end

	local args = t
	local position = pos

	-- sort the bar data by their intended order
	local bar_list = {}
	for _, v in pairs(TitanBarData) do
		bar_list[v.order] = v
	end
	table.sort(bar_list, function(a, b)
		return a.order < b.order
	end)

	local label = "Bar"

	wipe(args)

	for idx = 1, #bar_list do
		-- ======
		-- Build the bar list in order (left side)
		-- NOTE: v.name is the 'group' name which is the table passed to callbacks : info[1]
		local v = bar_list[idx] -- process this bar
		position = position + 1
		args[v.name] = {
			type = "group",
			name = ColorShown(v),
			order = position,
		}
		-- ======
		-- Build bar options (right side)
		args[v.name].args = {} -- args[].args causes the nesting on right side
		position = position + 1 -- Title divider
		args[v.name].args.title = {
			type = "header",
			name = v.locale_name,
			order = position,
			width = "full",
		}
		position = position + 1 -- Show toggle
		args[v.name].args.show = {
			type = "toggle",
			width = .75, --"fill",
			name = L["TITAN_PANEL_MENU_DISPLAY_BAR"],
			order = position,
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return TitanBarDataVars[frame_str].show
			end,
			set = function(info, val)
				local frame_str                  = TitanVariables_GetFrameName(v.name)
				TitanBarDataVars[frame_str].show = not TitanBarDataVars[frame_str].show
				TitanPanelBarButton_DisplayBarsWanted(v.name .. "Show " .. tostring(val))
				TitanUpdateConfigBars(optionsBars.args, 1000)
			end,
		}
		position = position + 1 -- Auto hide toggle
		args[v.name].args.autohide = {
			type = "toggle",
			width = .75, --"fill",
			name = L["TITAN_PANEL_MENU_AUTOHIDE"],
			order = position,
			disabled = (v.hider == nil),
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return TitanBarDataVars[frame_str].auto_hide
			end,
			set = function(info, val)
				Titan_AutoHide_ToggleAutoHide(v.name) -- short bar name
			end,
		}
		position = position + 1 -- Center toggle
		args[v.name].args.center = {
			type = "toggle",
			width = .75, --"fill",
			name = L["TITAN_PANEL_MENU_CENTER_TEXT"],
			order = position,
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return (TitanBarDataVars[frame_str].align == TITAN_PANEL_BUTTONS_ALIGN_CENTER)
			end,
			set = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				if (TitanBarDataVars[frame_str].align == TITAN_PANEL_BUTTONS_ALIGN_CENTER) then
					TitanBarDataVars[frame_str].align = TITAN_PANEL_BUTTONS_ALIGN_LEFT
				else
					TitanBarDataVars[frame_str].align = TITAN_PANEL_BUTTONS_ALIGN_CENTER
				end

				-- Justify button position
				TitanPanelButton_Justify();
			end,
		}
		position = position + 1 -- Combat hide toggle
		args[v.name].args.hideincombat = {
			type = "toggle",
			width = .75, --"fill",
			name = L["TITAN_PANEL_MENU_HIDE_IN_COMBAT"],
			desc = L["TITAN_PANEL_MENU_HIDE_IN_COMBAT_DESC"],
			order = position,
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return TitanBarDataVars[frame_str].hide_in_combat
			end,
			set = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				TitanBarDataVars[frame_str].hide_in_combat =
					not TitanBarDataVars[frame_str].hide_in_combat
			end,
		}
		position = position + 1 -- PvP hide toggle
		args[v.name].args.hideinpvp = {
			type = "toggle",
			width = .75, --"fill",
			name = L["TITAN_PANEL_MENU_HIDE_IN_COMBAT"] .. " " .. Titan_Global.literals.pvp,
			desc = L["TITAN_PANEL_MENU_HIDE_IN_COMBAT_DESC"] .. " " .. Titan_Global.literals.pvp,
			order = position,
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return TitanBarDataVars[frame_str].hide_in_pvp
			end,
			set = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				TitanBarDataVars[frame_str].hide_in_pvp =
					not TitanBarDataVars[frame_str].hide_in_pvp
			end,
		}
		position = position + 1 -- spacer
		args[v.name].args.resetposspacer = {
			order = position,
			type = "description",
			width = "full",
			name = " ",
		}
		position = position + 1 -- reset pos
		args[v.name].args.resetbar = {
			type = "execute",
			width = "Full",
			name = L["TITAN_PANEL_MENU_RESET_POSITION"],
			order = position,
			disabled = (v.vert == TITAN_TOP or v.vert == TITAN_BOTTOM),
			func = function(info, arg1)
				local frame_str = TitanVariables_GetFrameName(v.name)
				TitanVariables_SetBarPos(_G[frame_str], true)
				TitanPanelBarButton_DisplayBarsWanted("Bar reset to default position - " .. tostring(v.name))
			end,
		}
--[[
		position = position + 1 -- spacer
		args[v.name].args.offsetyspacer1 = {
			type = "header",
			name = "-",
			order = position,
			width = "full",
		}
		position = position + 1 -- spacer
		args[v.name].args.yoffset = {
			type = "range",
			width = "full",
			name = "Plugin Y Offset",
			order = position,
			min = -12,
			max = 12,
			step = .5,
			get = function(info)
				local frame_str = TitanVariables_GetFrameName(v.name)
				return TitanBarDataVars[frame_str].plugin_off_y
			end,
			set = function(info, a)
				local frame_str = TitanVariables_GetFrameName(v.name)

print("Config Y"
.." "..tostring(v.name)..""
.." "..tostring(frame_str)..""
.." "..tostring(a)..""
)				TitanBarDataVars[frame_str].plugin_off_y = a
				-- Justify button position
				TitanPanelButton_Justify();
			end,
		}
--]]

		position = position + 1 -- background
		args[v.name].args.background = {
			name = BACKGROUND,
			type = "group",
			inline = true,
			order = position,
			--[[
			hidden = function(info)
				local hide = false
				if TitanBarDataVars["Global"].texure == Titan_Global.NONE then
					hide = false
				else
					hide = true -- skin or color is set global
				end
				return hide
			end,
			--]]
			args = {
				settextousebar = {
					name = "",
					desc = "",
					order = 110,
					type = "select",
					width = "full",
					style = "radio",
					get = function(info)
						local frame_str = TitanVariables_GetFrameName(v.name)
						return TitanBarDataVars[frame_str].texure
					end,
					set = function(info, val)
						local frame_str = TitanVariables_GetFrameName(v.name)
						TitanBarDataVars[frame_str].texure = val
						TitanPanel_SetBarTexture(frame_str)
					end,
					values = {
						[Titan_Global.SKIN] = L["TITAN_PANEL_SKINS_TITLE"],
						[Titan_Global.COLOR] = COLOR,
					},
				},
				colorgroup = {
					name = "",
					type = "group",
					inline = true,
					hidden = function(info)
						return not IfColor(info, v.name)
					end,
					order = 110,
					args = {
						colortitle = {
							type = "header",
							name = COLOR,
							order = 320,
							width = "full",
						},
						colorselect = {
							type = "color",
							width = "normal",
							name = L["TITAN_PANEL_BAR_COLOR"],
							order = 340,
							--				disabled = (v.vert == TITAN_TOP or v.vert == TITAN_BOTTOM),
							hasAlpha = true,
							get = function(info)
								local frame_str = TitanVariables_GetFrameName(v.name)
								local color     = TitanBarDataVars[frame_str].color
								return color.r,
									color.g,
									color.b,
									color.alpha
							end,
							set = function(info, r, g, b, a)
								local frame_str                         = TitanVariables_GetFrameName(v.name)

								TitanBarDataVars[frame_str].color.r     = r
								TitanBarDataVars[frame_str].color.g     = g
								TitanBarDataVars[frame_str].color.b     = b
								TitanBarDataVars[frame_str].color.alpha = a
								TitanPanel_SetBarTexture(frame_str)
							end,
						},
						showborder = {
							type = "toggle",
							width = "normal",
							name = "Show Border", --L["TITAN_PANEL_MENU_DISPLAY_BAR"],
							order = 350,
							get = function(info)
								local frame_str = TitanVariables_GetFrameName(v.name)
								return TitanBarDataVars[frame_str].color_border
							end,
							set = function(info, val)
								local frame_str = TitanVariables_GetFrameName(v.name)
								TitanBarDataVars[frame_str].color_border = not TitanBarDataVars[frame_str].color_border
								TitanPanel_SetBarTexture(frame_str)
								--								TitanUpdateConfigBars(optionsBars.args, 1000)
							end,
						}
					},
				},
				skingroup = {
					name = "",
					type = "group",
					inline = true,
					hidden = function(info)
						return IfColor(info, v.name)
					end,
					order = 111,
					args = {
						skintitle = {
							type = "header",
							name = L["TITAN_PANEL_SKINS_TITLE"],
							order = 120,
							width = "full",
						},
						skinselect = {
							type = "select",
							width = "normal",
							name = "",
							order = 130,
							get = function(info)
								local frame_str = TitanVariables_GetFrameName(v.name)
								return TitanBarDataVars[frame_str].skin.path
							end,
							set = function(info, val)
								local frame_str                       = TitanVariables_GetFrameName(v.name)
								TitanBarDataVars[frame_str].skin.path = val
								TitanPanel_SetBarTexture(frame_str)
								if TitanSkinToRemove == TitanPanelGetVar("Texture" .. v.name) then
									TitanSkinToRemove = "None"
								end
							end,
							values = function(info)
								local Skinlist  = {}
								local frame_str = TitanVariables_GetFrameName(v.name)
								for _, val in pairs(TitanSkins) do
									if val.path ~= TitanBarDataVars[frame_str].skin.path then
										--						if val.path ~= TitanPanelGetVar("Texture"..v.name) then
										Skinlist[val.path] = TitanUtils_GetHexText(val.name, Titan_Global.colors.green)
									else
										Skinlist[val.path] = TitanUtils_GetHexText(val.name, Titan_Global.colors.yellow)
									end
								end
								table.sort(Skinlist, function(a, b)
									return string.lower(TitanSkins[a].name)
										< string.lower(TitanSkins[b].name)
								end)
								return Skinlist
							end,
						},
						skinspacer = {
							order = 200,
							type = "description",
							width = "5",
							name = " ",
						},
						skinselected = {
							name = "",
							image = function(info)
								local frame_str = TitanVariables_GetFrameName(v.name)
								local vert      = TitanBarData[frame_str].vert
								if vert == TITAN_SHORT then
									vert = TITAN_TOP
								else
									-- Use it as is
								end
								return TitanBarDataVars[frame_str].skin.path .. "TitanPanelBackground" .. vert .. "0"
							end,
							imageWidth = 256,
							order = 300,
							type = "description",
							width = .5, --"60",
						},
						trans = {
							type = "range",
							width = "full",
							name = L["TITAN_PANEL_TRANS_MENU_TEXT_SHORT"],
							order = 310,
							min = 0,
							max = 1,
							step = 0.01,
							get = function(info)
								local frame_str = TitanVariables_GetFrameName(v.name)
								return TitanBarDataVars[frame_str].skin.alpha
							end,
							set = function(info, a)
								local frame_str = TitanVariables_GetFrameName(v.name)
								_G[frame_str]:SetAlpha(a)
								TitanBarDataVars[frame_str].skin.alpha = a
							end,
						},
					},
				},
			},
		}
	end
end

local function BuildBars()
	TitanUpdateConfigBars(optionsBars.args, 1000)
	AceConfigRegistry:NotifyChange("Titan Panel Bars")
end

--============= Bars - All

local optionsGlobals = {
	name = TITAN_PANEL_CONFIG.topic.globals,
	type = "group",
	args = {}
}

local function ConfigBarsAll(t, pos)
	local args = t
	local position = pos

	wipe(args)

	--====== New group of options
	position = position + 1
	args.hidecombatspacer = { -- spacer
		order = position,
		type = "description",
		width = "full",
		name = " ",
	}

	position = position + 1
	args.conftopbardesc = {
		order = position,
		width = "full",
		type = "header",
		name = L["TITAN_PANEL_MENU_TOP_BARS"],
	}
	position = position + 1
	args.settopbar = {
		name = L["TITAN_PANEL_MENU_TOP_BARS"] .. " " .. L["TITAN_PANEL_MENU_DISABLE_PUSH"],
		--		desc = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
		order = position,
		type = "toggle",
		width = "full",
		disabled = (Titan_Global.switch.can_edit_ui == true),
		get = function() return TitanPanelGetVar("ScreenAdjust") end,
		set = function() ScreenAdjustReload() end,
	}
	position = position + 1
	args.bottombarspacer = { -- spacer
		order = position,
		type = "description",
		width = "full",
		name = " ",
	}
	position = position + 1
	args.confbottombardesc = {
		order = position,
		width = "full",
		type = "header",
		name = L["TITAN_PANEL_MENU_BOTTOM_BARS"],
	}
	position = position + 1
	args.setbottombar = {
		name = L["TITAN_PANEL_MENU_BOTTOM_BARS"] .. " " .. L["TITAN_PANEL_MENU_DISABLE_PUSH"],
		--		desc = L["TITAN_PANEL_MENU_DISABLE_PUSH"],
		order = position,
		type = "toggle",
		width = "full",
		disabled = (Titan_Global.switch.can_edit_ui == true),
		get = function() return TitanPanelGetVar("AuxScreenAdjust") end,
		set = function() AuxScreenAdjustReload() end,
	}
end

local function BuildBarsAll()
	ConfigBarsAll(optionsGlobals.args, 1000)
	AceConfigRegistry:NotifyChange("Titan Panel Globals")
end

--============= Plugins

---The plugin controls will be added here.
local optionsAddons = {
	name = TITAN_PANEL_CONFIG.topic.plugins,
	type = "group",
	args = {}
}

---Color the list - is shown versus not shown
---@param id string
---@param name string
---@return string colorized
local function ColorVisible(id, name)
	local res = "?"
	if TitanPanel_IsPluginShown(id) then
		res = (name or "")
	else
		res = TitanUtils_GetGrayText(name)
	end

	return res
end

--[[ local
Controls honored from the plugin .registry:
- Show
- Show label text
- Right side
- Show icon
- Show text
Position:
- Shift left one plugin position on the bar
- Shift right one plugin position on the bar
- The shift is on the same bar
- The shift will not move a plugin from one side to the other
Bar:
- Drop down so the user can pick the bar the plugin is to be shown on.
- The list contains only the bars the user has selected to be shown.
- The user can not move a plugin to a hidden bar to 'hide' it. The user should ensure "Show Plugin" is unchecked.
--]]

---Allow the user to control each plugin registered to Titan.
local function UpdateConfigAddons()
	local args = optionsAddons.args
	local plug_in = nil
	local plug_category = ""
	local plug_version = ""
	local plug_ldb = ""
	local plug_notes = ""

	wipe(args)

	for idx, value in pairs(TitanPluginsIndex) do
		plug_in = TitanUtils_GetPlugin(TitanPluginsIndex[idx])
		if plug_in then
			local header = (plug_in.menuText or "")
			args[plug_in.id] = {
				type = "group",
				name = ColorVisible(plug_in.id, plug_in.menuText_NC or ""),
				order = idx,
				args = {
					name = {
						type = "header",
						name = header,
						order = 1,
					},
					show = {
						type = "toggle",
						name = L["TITAN_PANEL_MENU_SHOW"],
						order = 3,
						get = function(info) 
							return (TitanPanel_IsPluginShown(info[1])) end,
						set = function(info, v)
							local name = info[1]
							if v then -- Show / add
								local bar = (TitanGetVar(name, "ForceBar") or TitanUtils_PickBar())
								if type(bar) == 'string' then -- sanity and IDE
									---@diagnostic disable-next-line: param-type-mismatch
									TitanUtils_AddButtonOnBar(bar, name)
								end
							else -- Hide / remove
								TitanPanel_RemoveButton(name)
							end
							UpdateConfigAddons()
						end,
					},
				}
			}

			--ShowIcon
			if plug_in.controlVariables and plug_in.controlVariables.ShowIcon then
				args[plug_in.id].args.icon =
				{
					type = "toggle",
					name = L["TITAN_PANEL_MENU_SHOW_ICON"],
					order = 4,
					get = function(info) return (TitanGetVar(info[1], "ShowIcon")) end,
					set = function(info, v)
						TitanToggleVar(info[1], "ShowIcon");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end

			--ShowLabel
			if plug_in.controlVariables and plug_in.controlVariables.ShowLabelText then
				args[plug_in.id].args.label = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_SHOW_LABEL_TEXT"],
					order = 5,
					get = function(info) return (TitanGetVar(info[1], "ShowLabelText")) end,
					set = function(info, v)
						TitanToggleVar(info[1], "ShowLabelText");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end

			--ShowRegularText (LDB data sources only atm)
			if plug_in.controlVariables and plug_in.controlVariables.ShowRegularText then
				args[plug_in.id].args.regular_text =
				{
					type = "toggle",
					name = L["TITAN_PANEL_MENU_SHOW_PLUGIN_TEXT"],
					order = 6,
					get = function(info) return (TitanGetVar(info[1], "ShowRegularText")) end,
					set = function(info, v)
						TitanToggleVar(info[1], "ShowRegularText");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end

			--ShowColoredText
			if plug_in.controlVariables and plug_in.controlVariables.ShowColoredText then
				args[plug_in.id].args.color_text = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_SHOW_COLORED_TEXT"],
					order = 7,
					get = function(info) return (TitanGetVar(info[1], "ShowColoredText")) end,
					set = function(info, v)
						TitanToggleVar(info[1], "ShowColoredText");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end

			-- Right-side plugin
			if plug_in.controlVariables and plug_in.controlVariables.DisplayOnRightSide then
				args[plug_in.id].args.right_side = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_LDB_SIDE"],
					order = 8,
					get = function(info) return (TitanGetVar(info[1], "DisplayOnRightSide")) end,
					set = function(info, v)
						local bar = TitanUtils_GetWhichBar(info[1])
						TitanToggleVar(info[1], "DisplayOnRightSide");
						TitanPanel_RemoveButton(info[1]);
						TitanUtils_AddButtonOnBar(bar, info[1]);
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end
			-- Shift R / L
			args[plug_in.id].args.plugin_position = {
				order = 50,
				type = "header",
				name = L["TITAN_PANEL_MENU_POSITION"],
			}
			args[plug_in.id].args.shift_left = {
				type = "execute",
				name = "< " .. L["TITAN_PANEL_SHIFT_LEFT"] .. "  ",
				order = 51,
				func = function(info, arg1)
					local name = info[1]
					if TitanPanel_IsPluginShown(name) then
						TitanUtils_ShiftButtonOnBarLeft(name)
					end
				end,
			}
			args[plug_in.id].args.shift_right = {
				type = "execute",
				name = "> " .. L["TITAN_PANEL_SHIFT_RIGHT"],
				order = 52,
				func = function(info, arg1)
					local name = info[1]
					if TitanPanel_IsPluginShown(info[1]) then
						TitanUtils_ShiftButtonOnBarRight(name)
					end
				end,
			}
			args[plug_in.id].args.space_50_1 = {
				order = 53,
				type = "header",
				name = L["TITAN_PANEL_MENU_BAR"],
			}
			if not TitanVarExists(plug_in.id, "ForceBar") then
				args[plug_in.id].args.top_bottom = {
					order = 54,
					type = "select",
					name = L["TITAN_PANEL_MENU_BAR"],
					desc = L["TITAN_PANEL_MENU_DISPLAY_ON_BAR"],
					get = function(info)
						return TitanUtils_GetWhichBar(info[1])
					end,
					set = function(info, v)
						local name = info[1]
						if TitanPanel_IsPluginShown(name) then
							TitanUtils_AddButtonOnBar(v, name)
						end
					end,
					values = function()
						local Locationlist = {}
						local v
						for idx, v in pairs(TitanBarData) do
							if TitanBarDataVars[idx].show then
								--							if TitanPanelGetVar(TitanBarData[idx].name.."_Show") then
								Locationlist[TitanBarData[idx].name] = TitanBarData[idx].locale_name
							end
						end
						return Locationlist
					end,
				}
			else
				args[plug_in.id].args.top_bottom = {
					order = 54,
					type = "description",
					name = TitanUtils_GetGoldText(L["TITAN_PANEL_MENU_BAR_ALWAYS"] ..
						" " .. TitanGetVar(plug_in.id, "ForceBar")),
					cmdHidden = true,
				}
			end
			args[plug_in.id].args.space_50_2 = {
				order = 59,
				type = "description",
				name = "  ",
				cmdHidden = true,
			}
			-- Notes, if available
			args[plug_in.id].args.custom_notes = {
				order = 60,
				type = "header",
				name = L["TITAN_PANEL_MENU_ADV_NOTES_PLUGIN"],
			}
			if plug_in.version then
				plug_version = TitanUtils_GetGreenText(" (" .. plug_in.version .. ")")
			else
				plug_version = ""
			end
			if plug_in.category then
				plug_category = TitanUtils_GetGreenText(" " .. plug_in.category .. "")
			else
				plug_category = ""
			end
			if plug_in.notes then
				plug_notes = TitanUtils_GetGreenText("" .. plug_in.notes .. "")
			else
				plug_notes = ""
			end
			if plug_in.ldb then
				plug_ldb = TitanUtils_GetGreenText(" [LDB]")
			else
				plug_ldb = ""
			end
			local str = ""
				.. plug_version
				.. plug_category
				.. _G["GREEN_FONT_COLOR_CODE"] .. plug_ldb .. "|r"
				.. "\n"
				.. plug_notes
			if plug_in.notes then
				args[plug_in.id].args.notes = {
					type = "description",
					order = 61,
					name = str,
					cmdHidden = true,
				}
			else
				args[plug_in.id].args.notes = {
					type = "description",
					order = 61,
					name = str,
					cmdHidden = true,
				}
			end
			--
			-- Custom Labels 1 - 4
			local num_labels = tonumber(TitanGetVar(plug_in.id, "NumLabelsSeen") or 1)

			if num_labels >= 1 then
				args[plug_in.id].args.custom_labels = {
					order = 70,
					type = "header",
					name = L["TITAN_PANEL_MENU_ADV_LABEL"],
				}
				args[plug_in.id].args.custom_label_show = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_ADV_LABEL_SHOW"] .. " 1",
					order = 71,
					get = function(info) return (TitanGetVar(info[1], "CustomLabelTextShow") or false) end,
					set = function(info, v)
						TitanToggleVar(info[1], "CustomLabelTextShow");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
				args[plug_in.id].args.custom_label_text = {
					order = 72,
					name = L["TITAN_PANEL_MENU_ADV_CUSTOM"],
					desc = L["TITAN_PANEL_MENU_ADV_CUSTOM_DESC"],
					type = "input",
					width = "full",
					get = function(info) return (TitanGetVar(info[1], "CustomLabelText") or "") end,
					set = function(info, v)
						TitanSetVar(info[1], "CustomLabelText", v);
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end
			if num_labels >= 2 then
				args[plug_in.id].args.custom_label2_show = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_ADV_LABEL_SHOW"] .. " 2",
					order = 73,
					get = function(info) return (TitanGetVar(info[1], "CustomLabel2TextShow") or false) end,
					set = function(info, v)
						TitanToggleVar(info[1], "CustomLabel2TextShow");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
				args[plug_in.id].args.custom_label2_text = {
					order = 74,
					name = L["TITAN_PANEL_MENU_ADV_CUSTOM"],
					desc = L["TITAN_PANEL_MENU_ADV_CUSTOM_DESC"],
					type = "input",
					width = "full",
					get = function(info) return (TitanGetVar(info[1], "CustomLabel2Text") or "") end,
					set = function(info, v)
						TitanSetVar(info[1], "CustomLabel2Text", v);
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end
			if num_labels >= 3 then
				args[plug_in.id].args.custom_label3_show = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_ADV_LABEL_SHOW"] .. " 3",
					order = 75,
					get = function(info) return (TitanGetVar(info[1], "CustomLabel3TextShow") or false) end,
					set = function(info, v)
						TitanToggleVar(info[1], "CustomLabel3TextShow");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
				args[plug_in.id].args.custom_label3_text = {
					order = 76,
					name = L["TITAN_PANEL_MENU_ADV_CUSTOM"],
					desc = L["TITAN_PANEL_MENU_ADV_CUSTOM_DESC"],
					type = "input",
					width = "full",
					get = function(info) return (TitanGetVar(info[1], "CustomLabel3Text") or "") end,
					set = function(info, v)
						TitanSetVar(info[1], "CustomLabel3Text", v);
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end
			if num_labels >= 4 then
				args[plug_in.id].args.custom_label4_show = {
					type = "toggle",
					name = L["TITAN_PANEL_MENU_ADV_LABEL_SHOW"] .. " 4",
					order = 77,
					get = function(info) return (TitanGetVar(info[1], "CustomLabel4TextShow") or false) end,
					set = function(info, v)
						TitanToggleVar(info[1], "CustomLabel4TextShow");
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
				args[plug_in.id].args.custom_label4_text = {
					order = 78,
					name = L["TITAN_PANEL_MENU_ADV_CUSTOM"],
					desc = L["TITAN_PANEL_MENU_ADV_CUSTOM_DESC"],
					type = "input",
					width = "full",
					get = function(info) return (TitanGetVar(info[1], "CustomLabel4Text") or "") end,
					set = function(info, v)
						TitanSetVar(info[1], "CustomLabel4Text", v);
						TitanPanelButton_UpdateButton(info[1])
					end,
				}
			end
		end
	end

	-- Config Tables changed!
	AceConfigRegistry:NotifyChange("Titan Panel Addon Control")
end

--============= Profiles

---The toon profile info will be added here
local optionsChars = {
	name = TITAN_PANEL_CONFIG.topic.profiles,
	type = "group",
	args = {}
}

local function SummaryText(profile)
	local res = ""

	if profile.ptype == Titan_Global.profile.GLOBAL then
		res = L["TITAN_PANEL_GLOBAL"] .. " : " .. profile.cname
	elseif profile.ptype == Titan_Global.profile.SYNC then
		res = L["TITAN_PANEL_MENU_PROFILE_SYNC"] .. " : " .. profile.cname
	elseif profile.ptype == Titan_Global.profile.TOON then
		res = L["TITAN_PANEL_MENU_PROFILE_CHARS"] .. " : " .. Titan_Global.profile.NONE
	else
		res = "?" .. " : " .. Titan_Global.profile.NONE
	end

	return res
end

local function EndProfileText(profile)
	local res = ""

	if profile.ptype == Titan_Global.profile.GLOBAL then
		res = " : " .. profile.cname
	elseif profile.ptype == Titan_Global.profile.SYNC then
		res = " : " .. profile.cname
	elseif profile.ptype == Titan_Global.profile.TOON then
		res = " : " .. Titan_Global.profile.NONE
	else
		res = " : ?" .. Titan_Global.profile.NONE
	end

	return res
end

---Allow the user to load / delete / reset / sync profile data
local function TitanUpdateChars()
	local p_info = {} -- used to hold info about each toon in players
	local p_sync = {} -- profiles used as Sync

	-- Rip through the players (with server name) to sort them
	for index, id in pairs(TitanSettings.Players) do
		-- collect some info on THIS toon for the config
		local this_toon = {}

		local _, server, is_custom = TitanUtils_ParseName(index)
		-- color code the name
		-- - gold for normal profiles
		-- - green for custom profiles
		if is_custom then
			this_toon.fancy_name = TitanUtils_GetGreenText((index or "?"))
			this_toon.is_custom = true
		else
			this_toon.fancy_name = TitanUtils_GetGoldText((index or "?"))
			this_toon.is_custom = false
		end

		this_toon.name = index
		this_toon.profile = TitanVariables_GetProfile(index)
		this_toon.summary = SummaryText(this_toon.profile)
		this_toon.toon_header = this_toon.fancy_name .. EndProfileText(this_toon.profile)
		this_toon.is_player = (index == TitanUtils_GetPlayer())
		this_toon.sync_set = not (id.Panel["SyncWithProfile"] == Titan_Global.profile.NONE)
		this_toon.sync_name = id.Panel["SyncWithProfile"]
		table.insert(p_info, this_toon) -- table index matches players table...

		p_sync[this_toon.sync_name] = this_toon.sync_set
	end
	--Sort the toons...
	table.sort(p_info, function(a, b)
		return a.name < b.name
	end)

	-- set up the options for the user
	local args = optionsChars.args
	local position = 100

	wipe(args)

	local header = ""
	header = header .. L["TITAN_PANEL_CHARS_DESC"] .. "\n"

	args["desc"] = {
		order = 1,
		type = "description",
		name = header .. "\n",
		cmdHidden = true,
	}
	args["profile_header"] = {
		order = 30,
		type = "header",
		name = L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		cmdHidden = true
	}

	for idx = 1, #p_info do
		local this_toon = p_info[idx]
		-- Check for global profile being set
		local g_sync = (this_toon.profile.ptype == Titan_Global.profile.GLOBAL)

		args[this_toon.name] = {
			type = "group",
			name = this_toon.fancy_name,
			desc = "",
			order = position,
			args = {}
		}
		local p_args = args[this_toon.name].args -- shortcut for right side

		-- assemble the profile section
		position = position + 1
		p_args.name = {
			type = "header",
			name = TitanUtils_GetGoldText(this_toon.toon_header or "?"),
			cmdHidden = true,
			order = position,
		}

		do -- profile toon info
			local custom_toon, toon_info = TitanUtils_GetPlayerInfo(this_toon.name)
			if custom_toon then
				-- Cannot login; There is no info to show.
			elseif toon_info == nil then
				-- For now show nothing
			else -- display
				local itoon = toon_info
				local logout = (itoon.logoutStr == nil) and L["TITAN_PANEL_NA"] or itoon.logoutStr
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = "Last Logout : " .. logout,
					--width = "0.5",
					cmdHidden = true,
					order = position,
				}
				if itoon.zoneText == nil or itoon.subZoneText == nil then
					-- not filled in
				else
					position = position + 1
					p_args[tostring(position)] = {
						type = "description",
						name = "@ : " .. itoon.zoneText .. " " .. itoon.subZoneText,
						--width = "0.5",
						cmdHidden = true,
						order = position,
					}
				end
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = "Level : " .. itoon.levelText,
					width = "0.5",
					cmdHidden = true,
					order = position,
				}
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = "Faction : " .. itoon.faction,
					width = "0.5",
					cmdHidden = true,
					order = position,
				}
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = "Class : " .. itoon.class,
					width = "0.5",
					cmdHidden = true,
					order = position,
				}
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = "Race : " .. itoon.race,
					width = "0.5",
					cmdHidden = true,
					order = position,
				}
			end
		end

		do           -- profile Gold
			if TitanGold then -- at least loaded
				if this_toon.is_custom then
					-- Cannot login; There is no info to show.
				else
					if TitanGold.GetInfo then -- it is at least loaded
						position = position + 1
						p_args[tostring(position)] = {
							name = TitanGold.GetInfo(this_toon.name, true), -- Let Gold decide what to display
							order = position,
							type = "description",
						}
					end
				end
			end
		end

		do -- profile Mail
			--[[
			position = position + 1
			p_args[tostring(position)] = {
				type = "header",
				name = TitanUtils_GetGoldText("TitanPost"),
				cmdHidden = true,
				order = position,
			}
			--]]

			if TitanPost then -- it is at least loaded
				if this_toon.is_custom then
					-- can not log in to custom so NA
				else
					local post_str = ""
					local post_button = TitanUtils_GetButton("Post")
					post_str = L["TITAN_PANEL_NA"]
					if post_button and post_button:IsShown() then
						post_str = TitanPost.GetInfo(this_toon.name, true)

						position = position + 1
						p_args[tostring(position)] = {
							name = post_str,
							order = position,
							type = "description",
						}

						position = position + 1
						p_args.mailClear = {
							name = "Clear", --L["TITAN_PANEL_MENU_LOAD_SETTINGS"],
							desc = "Clear Mail info for this toon",
							order = position,
							type = "execute",
							func = function(info, v)
								TitanPost.ClearMailInfo(this_toon.name)
								TitanPrint(
									"Clear Mail info"
									.. " > " .. this_toon.name .. ""
									, "info")
								AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
							end,
							-- Should be able to clear any specific toon info
							--disabled = (this_toon.is_player or g_sync),
						}

						position = position + 1
						p_args[tostring(position)] = {
							type = "description",
							name = "",
							cmdHidden = true,
							order = position,
						}
					else
						-- not enabled
						post_str = L["TITAN_PANEL_MENU_DISABLED"]
					end
				end
			end
		end

		do -- profile load / delete
			position = position + 1
			p_args.prof_title = {
				type = "header",
				name = TitanUtils_GetGoldText("Profile"),
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			p_args.sp_1 = {
				type = "description",
				name = "",
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			local l_reason = ""
			if g_sync then
				l_reason = "Sync All set"
			elseif this_toon.is_player then
				l_reason = L["TITAN_PANEL_MENU_LOAD_SETTINGS_ERR1"]
			else
				l_reason = "."
			end
			p_args.optionload = {
				name = L["TITAN_PANEL_MENU_LOAD_SETTINGS"],
				desc = L["TITAN_PANEL_MENU_LOAD_SETTINGS_DESC"],
				order = position,
				type = "execute",
				--						width = "0.4",
				func = function(info, v)
					TitanVariables_UseSettings(this_toon.name, TitanUtils_GetPlayer(), TITAN_PROFILE_USE)
					TitanPrint(
						L["TITAN_PANEL_MENU_LOAD_SETTINGS"]
						.. " > " .. this_toon.name .. ""
						, "info")
				end,
				-- does not make sense to load current character profile
				disabled = (this_toon.is_player or g_sync),
			}

			position = position + 1
			local del_reason = ""
			if g_sync then
				del_reason = "" -- set above
			elseif p_sync[this_toon.name] then
				del_reason = L["TITAN_PANEL_MENU_PROFILE_DELETE_SETTINGS_ERR1"]
			elseif this_toon.is_player then
				del_reason = L["TITAN_PANEL_MENU_PROFILE_DELETE_SETTINGS_ERR2"]
			else
				del_reason = ""
			end

			p_args.optiondelete = {
				name = L["TITAN_PANEL_MENU_PROFILE_DELETE_SETTINGS"],
				desc = L["TITAN_PANEL_MENU_PROFILE_DELETE_SETTINGS_DESC"],
				order = position,
				type = "execute",
				--						width = "0.4",
				func = function(info, v)
					TitanSettings.Players[this_toon.name] = nil -- delete the entry
					TitanPrint(
						L["TITAN_PANEL_MENU_PROFILE"]
						.. "  " .. this_toon.name .. " "
						.. L["TITAN_PANEL_MENU_PROFILE_DELETED"]
						, "info")
					TitanUpdateChars() -- rebuild the toons
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				-- can not delete current character profile
				disabled = (this_toon.is_player
					or g_sync
					or p_sync[this_toon.name]),
			}
			position = position + 1
			p_args.sp_30 = {
				type = "description",
				name = " " .. TitanUtils_GetHexText(l_reason, Titan_Global.colors.orange) .. "\n",
				cmdHidden = true,
				order = position,
			}
			p_args.sp_31 = {
				type = "description",
				name = " " .. TitanUtils_GetHexText(del_reason, Titan_Global.colors.orange) .. "\n",
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			p_args.sp_35 = {
				type = "description",
				name = "\n",
				cmdHidden = true,
				order = position,
			}
		end

		do -- profile reset
			position = position + 1
			p_args.reset_this = {
				--name = L["TITAN_PANEL_MENU_PROFILE_RESET"].." : "..this_toon.profile.cname, --
				--desc = L["TITAN_PANEL_MENU_PROFILE_RESET_DESC"],
				name = "Reset Profile in Use", --
				desc = "Will reset" .. " : " .. this_toon.profile.cname,
				order = position,
				type = "execute",
				--width = "1.0",
				func = function(info, v)
					local selected = this_toon.name
					local str = ""
					str = str
						.. " " .. tostring(selected) .. ""
						.. " > '" .. tostring(this_toon.profile.cname) .. "'"
						.. " : '" .. tostring(TITAN_PROFILE_RESET) .. "'"

					Titan_Debug.Out('titan', 'profile', str)

					-- Disabled if not current toon, otherwise it gets way complicated...
					TitanVariables_UseSettings(nil, TitanUtils_GetPlayer(), TITAN_PROFILE_RESET)

					TitanPrint(
						L["TITAN_PANEL_MENU_PROFILE_RESET"]
						.. " " .. selected
						, "info")

					TitanUpdateChars()
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				disabled = not (this_toon.is_player),
			}
			position = position + 1
			p_args[tostring(position)] = {
				type = "description",
				name = " ",
				cmdHidden = true,
				order = position,
			}
		end

		do -- profile save as
			position = position + 1
			p_args.optionsave = {
				order = position,
				type = "execute",
				name = L["TITAN_PANEL_MENU_PROFILE_SAVE"] .. " " .. L["TITAN_PANEL_MENU_PROFILE_CUSTOM"],
				desc = L["TITAN_PANEL_MENU_PROFILE_SAVE_DESC"],
				func = function(info, v)
					TitanPanel_SaveCustomProfile(this_toon.name) -- will output message on write
					TitanUpdateChars()            -- rebuild the toons
				end,
			}
			position = position + 1
			p_args[tostring(position)] = {
				type = "description",
				name = " ",
				cmdHidden = true,
				order = position,
			}
		end

		do -- profile Sync
			position = position + 1
			p_args.sync_title = {
				type = "header",
				name = TitanUtils_GetGoldText("Sync"),
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			local s_reason = ""
			if g_sync then
				s_reason = "" -- set above
			elseif this_toon.sync_set then
				s_reason = L["TITAN_PANEL_MENU_PROFILE_SYNC_ERR1"]
			elseif this_toon.is_player then
				s_reason = L["TITAN_PANEL_MENU_PROFILE_SYNC_ERR2"]
			else
				s_reason = "" -- no error
			end
			p_args.sync_with = {
				name = L["TITAN_PANEL_MENU_PROFILE_SYNC"],
				desc = L["TITAN_PANEL_MENU_PROFILE_SYNC_DESC"],
				order = position,
				type = "execute",
				--width = "full",
				func = function(info, v)
					local str = ""
					TitanVariables_SetProfile(TitanUtils_GetPlayer(), Titan_Global.profile.SYNC, this_toon.name)
					str = str
						.. " " .. tostring(Titan_Global.profile.SYNC) .. ""
						.. " > '" .. tostring(this_toon.name) .. "'"
						.. " : '" .. tostring(TITAN_PROFILE_USE) .. "'"

					Titan_Debug.Out('titan', 'profile', str)
					TitanPrint(""
						.. "" .. L["TITAN_PANEL_MENU_PROFILE_SYNC"] .. ""
						.. " '" .. TitanUtils_GetPlayer() .. "'"
						.. " > '" .. tostring(this_toon.name) .. "'"
						, "info")

					-- Change over to new profile
					--				TitanVariables_UseSettings(nil, this_toon.name, TITAN_PROFILE_USE)
					TitanVariables_UseSettings(nil, TitanUtils_GetPlayer(), TITAN_PROFILE_USE)
					TitanUpdateChars()
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				-- cannot sync to yourself or if sync already set
				disabled = (this_toon.is_player or this_toon.sync_set or g_sync),
			}

			position = position + 1
			p_args.sync_clear = {
				name = L["TITAN_PANEL_MENU_PROFILE_CLEAR_SYNC"],
				desc = L["TITAN_PANEL_MENU_PROFILE_CLEAR_SYNC_DESC"],
				order = position,
				type = "execute",
				func = function(info, v)
					local str = ""
					TitanVariables_SetProfile(this_toon.name, Titan_Global.profile.SYNC, Titan_Global.profile.NONE)
					str = str
						.. " " .. tostring(Titan_Global.profile.SYNC) .. ""
						.. " > '" .. tostring(this_toon.name) .. "'"
						.. " : '" .. tostring(Titan_Global.profile.NONE) .. "'"
						.. " | '" .. tostring(this_toon.name == TitanUtils_GetPlayer()) .. "'"

					Titan_Debug.Out('titan', 'profile', str)

					if this_toon.name == TitanUtils_GetPlayer() then
						-- Change over to new profile
						TitanVariables_UseSettings(nil, TitanUtils_GetPlayer(), TITAN_PROFILE_USE)
					else
						-- Not this toon
					end

					TitanPrint(""
						.. "" .. L["TITAN_PANEL_MENU_PROFILE_CLEAR_SYNC"] .. ""
						.. " '" .. tostring(this_toon.name) .. "'"
						, "info")

					TitanUpdateChars()
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				disabled = (not this_toon.sync_set) or g_sync,
			}
			position = position + 1
			p_args[tostring(position)] = {
				type = "description",
				name = " " .. TitanUtils_GetHexText(s_reason, Titan_Global.colors.orange) .. "\n",
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			p_args[tostring(position)] = {
				type = "description",
				name = " ", --..TitanUtils_GetHexText(cs_reason, Titan_Global.colors.orange).."\n",
				cmdHidden = true,
				order = position,
			}
		end

		do -- profile global
			position = position + 1
			p_args.sync_all_title = {
				type = "header",
				name = TitanUtils_GetGoldText("Global"),
				cmdHidden = true,
				order = position,
			}
			position = position + 1
			p_args.sync_all_with = {
				name = "Sync All",            --L["TITAN_PANEL_MENU_PROFILE_SYNC"],
				desc = "Sync every toon to this profile", --L["TITAN_PANEL_MENU_PROFILE_SYNC_DESC"],
				order = position,
				type = "execute",
				--width = "full",
				func = function(info, v)
					local str = ""
					TitanVariables_SetProfile(TitanUtils_GetPlayer(), Titan_Global.profile.GLOBAL, this_toon.name)
					str = str
						.. " " .. tostring(Titan_Global.profile.GLOBAL) .. ""
						.. " > '" .. tostring(this_toon.name) .. "'"
						.. " : '" .. tostring(TITAN_PROFILE_USE) .. "'"

					Titan_Debug.Out('titan', 'profile', str)

					TitanPrint(""
						.. "" .. "Sync All" .. ""
						.. " > '" .. tostring(this_toon.name) .. "'"
						, "info")

					-- Change over to new profile
					TitanVariables_UseSettings(nil, TitanUtils_GetPlayer(), TITAN_PROFILE_USE)
					TitanUpdateChars()
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				-- Can allows set global sync
				--disabled = this_toon.is_player or this_toon.sync_set,
			}
			position = position + 1
			p_args.sync_all_clear = {
				name = "Clear Sync All",     --L["TITAN_PANEL_MENU_PROFILE_CLEAR_SYNC"],
				desc = "Revert to each toon's settings", --L["TITAN_PANEL_MENU_PROFILE_CLEAR_SYNC_DESC"],
				order = position,
				type = "execute",
				func = function(info, v)
					local str = ""
					TitanVariables_SetProfile(TitanUtils_GetPlayer(), Titan_Global.profile.GLOBAL,
						Titan_Global.profile.NONE)
					str = str
						.. " " .. tostring(Titan_Global.profile.GLOBAL) .. ""
						.. " : '" .. tostring(Titan_Global.profile.NONE) .. "'"
					Titan_Debug.Out('titan', 'profile', str)

					TitanPrint(""
						.. "" .. "Clear Sync All" .. ""
						.. " > '" .. tostring(this_toon.name) .. "'"
						, "info")

					-- Change over to new profile
					TitanVariables_UseSettings(nil, TitanUtils_GetPlayer(), TITAN_PROFILE_USE)

					TitanUpdateChars()
					AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
				end,
				disabled = (not g_sync),
			}
		end

		do
			position = position + 1
			p_args.sync_all_title = {
				type = "header",
				name = TitanUtils_GetGoldText("Uses as Sync"),
				cmdHidden = true,
				order = position,
			}
			if g_sync and (TitanAllGetVar("GlobalProfileName") == this_toon.name) then
				position = position + 1
				p_args[tostring(position)] = {
					type = "description",
					name = ALL or "ALL",
					cmdHidden = true,
					order = position,
				}
			else
				local has_sync = false
				for index, id in pairs(TitanSettings.Players) do
					if id.Panel["SyncWithProfile"] == this_toon.name then
						-- This profile uses this toon as a Sync
						position = position + 1
						p_args[tostring(position)] = {
							type = "description",
							name = tostring(index),
							cmdHidden = true,
							order = position,
						}
						has_sync = true
					else
						-- Any output would be confusing...
					end
				end

				if has_sync then
					-- already listed
				else
					position = position + 1
					p_args[tostring(position)] = {
						type = "description",
						name = NONE or "None",
						cmdHidden = true,
						order = position,
					}
				end
			end
		end

		-- tell the options screen there is a new list
		AceConfigRegistry:NotifyChange("Titan Panel Addon Chars")
	end
end

--============= Import / Export Profiles

---The toon profile import / exportsa will be added here
local optionsImportExport = {
	name = TITAN_PANEL_CONFIG.topic.im_ex_port,
	type = "group",
	args = {}
}
local export_str = "" -- hold export string
local import_str = "" -- hold import string

---Allow the user to load / delete / reset / sync profile data
local function TitanToonList()
	local players = {} -- used for list of profiles
	local export  = {} -- used for selected profiles
	local p_info  = {} -- used to hold info about each toon in players

	-- Rip through the players (with server name) to sort them
	for index, id in pairs(TitanSettings.Players) do
		--		table.insert(players, {index = index});
		--		table.insert(export, {index = false});
		players[index] = index
		export[index] = false

		-- collect some info on THIS toon for the config
		local this_toon = {}

		local _, server, is_custom = TitanUtils_ParseName(index)
		-- color code the name
		-- - gold for normal profiles
		-- - green for custom profiles
		if is_custom then
			this_toon.fancy_name = TitanUtils_GetGreenText((index or "?"))
		else
			this_toon.fancy_name = TitanUtils_GetGoldText((index or "?"))
		end

		this_toon.name = index
		this_toon.is_player = (index == TitanUtils_GetPlayer())
		this_toon.sync_set = not (id.Panel["SyncWithProfile"] == Titan_Global.profile.NONE)
		this_toon.sync_name = id.Panel["SyncWithProfile"]
		table.insert(p_info, this_toon) -- table index matches players table...
	end
	--Ace or Blizz sorts the toons...
	--	table.sort(players, function(a, b)
	--		return a < b
	--	end)
	--TitanDumpTable(players)
	--TitanDumpTable(export)
	-- set up the options for the user
	local args = optionsImportExport.args

	wipe(args)
	local position = 100
	--[[
	local header = ""
	header = header .. L["TITAN_PANEL_CHARS_DESC"] .. "\n"

	position = position + 1
	args["desc"] = {
		order = position,
		type = "description",
		name = header .. "\n",
		cmdHidden = true,
	}
--]]
	position = position + 1
	args["export_header"] = {
		order = position,
		type = "header",
		name = "Export \n", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		cmdHidden = true
	}
	local ex_desc = ""
		.. "To create a Titan Export : \n"
		.. "Select the toons you want to export. \n"
		.. "Click Export - Ignore the Accept button, it is part of the Ace lib.\n"
		.. "To copy the string from the Export box; Click in the Export box; Then control-A; Then control-C.\n"
		.. "Paste (control-V) the string somewhere safe. Ensure no stray characters will be added. \n"
	position = position + 1
	args["exportdesc"] = {
		order = position,
		type = "description",
		name = ex_desc, -- .. "\n",
		cmdHidden = true,
	}
	position = position + 1
	args["export_multi"] = {
		order = position,
		type = "multiselect",
		name = "", --"Export", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		desc = "", --"Select all the toons you want to export.", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		--		cmdHidden = true,
		--		style = "radio",
		values = players,
		get = function(info, v)
			-- Get from list...
			local toon = v
			local res = export[toon]

			local str = "Export get :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(res) .. ""
			Titan_Debug.Out('titan', 'profile', str)

			return res
		end,
		set = function(info, v, k)
			-- Put in list...
			local toon = v
			export[toon] = k
			local res = export[toon]

			local str = "Import get :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(res) .. ""
			Titan_Debug.Out('titan', 'profile', str)
		end,
	}

	position = position + 1
	args["export_cmd"] = {
		name = "Export",              --L["TITAN_PANEL_MENU_LOAD_SETTINGS"],
		desc = "Export the selected toons", --L["TITAN_PANEL_MENU_LOAD_SETTINGS_DESC"],
		order = position,
		type = "execute",
		func = function(info, v)
			--			TitanDumpTable(export)
			export_str = TitanVariables_CreateExport(export, false)
		end,
	}

	position = position + 1
	args["export_text"] = {
		order = position,
		type = "input",
		name = "Export box",                                                        --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		desc = "To copy the string; Click in the string; Then control-A; Then control-C", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		multiline = 10,
		width = 'full',
		get = function(info, v)
			local str = "Export str get :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(string.len(export_str)) .. ""
			Titan_Debug.Out('titan', 'profile', str)

			return export_str
		end,
		set = function(info, v, k)
			export_str = v

			local str = "Export str set :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(string.len(export_str)) .. ""
				.. " k'" .. tostring(k) .. "'"
			Titan_Debug.Out('titan', 'profile', str)
		end,
	}

	position = position + 1
	args["import_header"] = {
		order = position,
		type = "header",
		name = "Import \n", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		cmdHidden = true
	}
	local im_desc = ""
		.. "To Import a Titan export : \n"
		.. "Copy (control-C) the Titan Export from a safe source.\n"
		.. "Click in the Import box; Then control-A; then Paste (control-V).\n"
		.. "Click Accept to trigger the Import. The text will disappear!\n"
		.. "Click Import : If successful Titan will Reload to ensure the Import is saved and operational. \n"
	position = position + 1
	args["importdesc"] = {
		order = position,
		type = "description",
		name = im_desc, -- .. "\n",
		cmdHidden = true,
	}

	position = position + 1
	args["import_text"] = {
		order = position,
		type = "input",
		name = "Import box",                                            --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		desc = "To copy the export string; Click in the box; Then control-V", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		width = 'full',
		multiline = 10,
		get = function(info, v)
			local str = "Import str set :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(string.len(import_str)) .. ""
			Titan_Debug.Out('titan', 'profile', str)

			return ""
		end,
		set = function(info, v, k)
			import_str = v

			local str = "Import str set :"
			str = str
				.. " " .. tostring(v) .. ""
				.. " " .. tostring(string.len(import_str)) .. ""
				.. " k'" .. tostring(k) .. "'"
			Titan_Debug.Out('titan', 'profile', str)
		end,
	}
	position = position + 1
	args["import_cmd"] = {
		name = "Import",                              --L["TITAN_PANEL_MENU_LOAD_SETTINGS"],
		desc = "Import the Titan export in the input box.", --L["TITAN_PANEL_MENU_PROFILES"] .. "\n",
		order = position,
		type = "execute",
		func = function(info, v)
			-- FORMAT export into proper form!!!!
			local ok = TitanVariables_ProcessImport(import_str)
			if ok then
				ReloadUI()
			else
				-- User should have been given an error msg
			end
		end,
	}
end

--============= Tooltips and Frames

--[[ local
Tooltips:
- Hide in combat
- Show (or not)
Frames (bars):
- Lock buttons (plugins) - do not allow plugins to be moved via drag & drop. Shift left / right is still allowwed.
- Show plugin versions - show the version in the tooltips
Actions:
- Force LDB laucnhers to right side - This will move all converted LDB plugins of type launcher to the right side of the Titan bar.
- Refresh plugins - This can be used when a plugin has not updated its text. It may allow a plugin to show if it is not visible but the user has selected show.
- Reset Titan to default - used when the user wants to reset Titan options to a fresh install state. No plugins are removed by this.
--]]

---Show the general Titan options that the user can change.
local optionsFrames = {
	name = TITAN_PANEL_CONFIG.topic.tooltips,
	type = "group",
	args = {
		confdesc2 = {
			order = 200,
			type = "header",
			name = L["TITAN_PANEL_MENU_OPTIONS_TOOLTIPS"],
		},
		optiontooltiptimer = {
			name = "Tooltip Timeout",                --L["TITAN_PANEL_UISCALE_CONTROL_TITLE_UI"],
			desc = "Time Tooltip stays after cursor leaves.", --L["TITAN_PANEL_UISCALE_SLIDER_DESC"],
			order = 203,
			type = "range",
			width = "full",
			min = 0.0,
			max = 10.0,
			step = 0.25,
			get = function() return TitanPanelGetVar("TooltipTimeout") end,
			set = function(_, a)
				TitanPanelSetVar("TooltipTimeout", a);
			end,
		},
		optiontooltip = {
			name = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN"],
			--			desc = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN"],
			order = 205,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("ToolTipsShown") end,
			set = function() TitanPanelToggleVar("ToolTipsShown"); end,
		},
		optiontooltipcombat = {
			name = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT"],
			--			desc = L["TITAN_PANEL_MENU_TOOLTIPS_SHOWN_IN_COMBAT"],
			order = 210,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("HideTipsInCombat") end,
			set = function() TitanPanelToggleVar("HideTipsInCombat"); end,
		},
		conftooltipdesc = {
			name = L["TITAN_PANEL_TOOLTIP_MODIFIER"],
			type = "group",
			inline = true,
			order = 220,
			args = {
				confdesc = {
					order = 110,
					type = "description",
					name = "",
					cmdHidden = true,
				},
				advname = {
					name = L["TITAN_PANEL_MENU_TOOLTIP_MOD"],
					desc = "", -- L[""],
					order = 120,
					type = "toggle",
					width = "full",
					get = function() return TitanAllGetVar("UseTooltipModifer") end,
					set = function(_, a)
						TitanAllSetVar("UseTooltipModifer", a);
					end,
				},
				tooltipmod = {
					name = "",
					type = "group",
					inline = true,
					order = 140,
					args = {
						alt_key = {
							name = _G["ALT_KEY_TEXT"],
							desc = _G["ALT_KEY"],
							order = 110,
							type = "toggle", --width = "full",
							get = function() return TitanAllGetVar("TooltipModiferAlt") end,
							set = function(_, a)
								TitanAllSetVar("TooltipModiferAlt", a);
							end,
						},
						ctrl_key = {
							name = _G["CTRL_KEY_TEXT"],
							desc = _G["CTRL_KEY"],
							order = 120,
							type = "toggle", --width = "full",
							get = function() return TitanAllGetVar("TooltipModiferCtrl") end,
							set = function(_, a)
								TitanAllSetVar("TooltipModiferCtrl", a);
							end,
						},
						shift_key = {
							name = _G["SHIFT_KEY_TEXT"],
							desc = _G["SHIFT_KEY"],
							order = 130,
							type = "toggle", --width = "full",
							get = function() return TitanAllGetVar("TooltipModiferShift") end,
							set = function(_, a)
								TitanAllSetVar("TooltipModiferShift", a);
							end,
						},
					},
				},
			},
		},
		confdesc = {
			order = 300,
			type = "header",
			name = L["TITAN_PANEL_MENU_OPTIONS_FRAMES"],
		},
		optionlock = {
			name = L["TITAN_PANEL_MENU_LOCK_BUTTONS"],
			order = 301,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("LockButtons") end,
			set = function() TitanPanelToggleVar("LockButtons") end,
		},
		optionversions = {
			name = L["TITAN_PANEL_MENU_VERSION_SHOWN"],
			order = 302,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("VersionShown") end,
			set = function() TitanPanelToggleVar("VersionShown") end,
		},
		autohidelock = {
			name = L["TITAN_PANEL_MENU_AUTOHIDE_IN_COMBAT"],
			order = 303,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("LockAutoHideInCombat") end,
			set = function() TitanPanelToggleVar("LockAutoHideInCombat") end,
		},
	}
}

--============= Scale and Font

---Show the Titan options that allow a user to adjust Titan scale and font
local optionsUIScale = {
	name = TITAN_PANEL_CONFIG.topic.scale,
	type = "group",
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = L["TITAN_PANEL_UISCALE_MENU_DESC"] .. "\n",
			cmdHidden = true
		},
		uiscale = {
			name = L["TITAN_PANEL_UISCALE_CONTROL_TITLE_UI"],
			desc = L["TITAN_PANEL_UISCALE_SLIDER_DESC"],
			order = 2,
			type = "range",
			width = "full",
			min = 0.64,
			max = 1,
			step = 0.01,
			get = function() return UIParent:GetScale() end,
			set = function(_, a)
				SetCVar("useUiScale", 1);
				SetCVar("uiScale", a);
			end,
		},
		panelscale = {
			name = L["TITAN_PANEL_UISCALE_CONTROL_TITLE_PANEL"],
			desc = L["TITAN_PANEL_UISCALE_PANEL_SLIDER_DESC"],
			order = 3,
			type = "range",
			width = "full",
			min = 0.75,
			max = 1.25,
			step = 0.01,
			get = function() return TitanPanelGetVar("Scale") end,
			set = function(_, a)
				TitanPanelSetVar("Scale", a)
				TitanPanel_InitPanelBarButton("Config scale change " .. a)
			end,
			disabled = function()
				if InCombatLockdown() then
					return true
				else
					return false
				end
			end,
		},
		buttonspacing = {
			name = L["TITAN_PANEL_UISCALE_CONTROL_TITLE_BUTTON"],
			desc = L["TITAN_PANEL_UISCALE_BUTTON_SLIDER_DESC"],
			order = 4,
			type = "range",
			width = "full",
			min = 5,
			max = 80,
			step = 1,
			get = function() return TitanPanelGetVar("ButtonSpacing") end,
			set = function(_, a)
				TitanPanelSetVar("ButtonSpacing", a);
				TitanPanel_InitPanelButtons();
			end,
		},
		iconspacing = {
			name = L["TITAN_PANEL_UISCALE_CONTROL_TITLE_ICON"],
			desc = L["TITAN_PANEL_UISCALE_ICON_SLIDER_DESC"],
			order = 5,
			type = "range",
			width = "full",
			min = 0,
			max = 20,
			step = 1,
			get = function() return TitanPanelGetVar("IconSpacing") end,
			set = function(_, a)
				TitanPanelSetVar("IconSpacing", a);
				TitanPanel_InitPanelButtons();
			end,
		},
		spacer01 = {
			type = "description",
			name = "\n\n",
			imageHeight = 0,
			order = 10,
			width = "full",
		},
		tooltipdesc = {
			order = 20,
			width = "full",
			type = "header",
			name = L["TITAN_PANEL_TOOLTIP"],
		},
		tooltipfont = {
			name = L["TITAN_PANEL_UISCALE_CONTROL_TOOLTIP_TOOLTIPFONT"],
			desc = L["TITAN_PANEL_UISCALE_TOOLTIP_SLIDER_DESC"],
			order = 21,
			type = "range",
			width = "full",
			min = 0.5,
			max = 1.3,
			step = 0.01,
			get = function() return TitanPanelGetVar("TooltipFont") end,
			set = function(_, a)
				TitanPanelSetVar("TooltipFont", a);
			end,
		},
		tooltipfontdisable = {
			name = L["TITAN_PANEL_UISCALE_TOOLTIP_DISABLE_TEXT"],
			desc = L["TITAN_PANEL_UISCALE_DISABLE_TOOLTIP_DESC"],
			order = 22,
			type = "toggle",
			width = "full",
			get = function() return TitanPanelGetVar("DisableTooltipFont") end,
			set = function()
				TitanPanelToggleVar("DisableTooltipFont");
			end,
		},
		fontdesc = {
			order = 30,
			width = "full",
			type = "header",
			name = "Font",
		},
		fontselection = {
			name = L["TITAN_PANEL_MENU_LSM_FONTS"],
			desc = L["TITAN_PANEL_MENU_LSM_FONTS_DESC"],
			order = 31,
			type = "select",
--			width = ".5",
			--dialogControl = "LSM30_Font",
			get = function()
				local f_name = TitanPanelGetVar("FontName")
				return f_name
			end,
			set = function(_, v)
				TitanPanelSetVar("FontName", v)
-- "Friz Quadrata TT"
				TitanSetPanelFont(v, TitanPanelGetVar("FontSize"))
			end,
			values = font_list,
--			values = media:List("font"), --AceGUIWidgetLSMlists.font,
--			values = media:HashTable("font"), --AceGUIWidgetLSMlists.font,
		},
		fontsize = {
			name = L["TITAN_PANEL_MENU_FONT_SIZE"],
			desc = L["TITAN_PANEL_MENU_FONT_SIZE_DESC"],
			order = 33,
			type = "range",
--			width = ".5",
			min = 7,
			max = 15,
			step = 1,
			get = function() return TitanPanelGetVar("FontSize") end,
			set = function(_, v)
				TitanPanelSetVar("FontSize", v);
				TitanSetPanelFont(TitanPanelGetVar("FontName"), v)
			end,
		},
		fontspacer = {
			order = 35,
			type = "description",
			width = "full",
			name = "* Could include Fonts from other addons.",
		},
		paneldesc = {
			order = 40,
			width = "full",
			type = "header",
			name = "Strata",
		},
		panelstrata = {
			name = L["TITAN_PANEL_MENU_FRAME_STRATA"],
			desc = L["TITAN_PANEL_MENU_FRAME_STRATA_DESC"],
			order = 41,
			width = ".5",
			type = "select",
			get = function()
				return TitanPanelGetVar("FrameStrata")
			end,
			set = function(_, v)
				TitanPanelSetVar("FrameStrata", v)
				TitanVariables_SetPanelStrata(v)
			end,
			values = {
				["BACKGROUND"] = "BACKGROUND",
				["LOW"] = "LOW",
				["MEDIUM"] = "MEDIUM",
				["HIGH"] = "HIGH",
				["DIALOG"] = "DIALOG",
				["FULLSCREEN"] = "FULLSCREEN",
			},
		},
		panelstrataorder = {
			width = ".5",
			order = 42,
			type = "description",
			name = "Order of Strata\n"
				.. "- BACKGROUND\n"
				.. "- LOW - default\n"
				.. "- MEDIUM\n"
				.. "- HIGH\n"
				.. "- DIALOG\n"
				.. "- FULLSCREEN\n",
			cmdHidden = true
		},
	}
}

--============= Skins

---
local optionsSkins = {
	name = TITAN_PANEL_CONFIG.topic.skins,
	type = "group",
	args = {
	}
}

---Show the default Titan skins and any custom skins the user has added.
local function Show_Skins(t, position)
	local skin = "Skin"
	t[skin .. position] = {
		type = "description",
		name = ""
			.. L["TITAN_PANEL_MENU_SKIN_CHANGE"] .. "\n"
			.. "- " .. L["TITAN_PANEL_MENU_OPTIONS_BARS"] .. "\n"
			.. "- " .. L["TITAN_PANEL_MENU_OPTIONS_BARS_ALL"] .. "\n"
			.. "",
		cmdHidden = true,
		order = position,
	}

	for idx, v in pairs(TitanSkins) do
		position = position + 1 -- spacer
		t[skin .. position] = {
			type = "header",
			name = "",
			order = position,
			width = "full",
		}

		position = position + 1 -- Name of skin (col 1)
		t[skin .. position] = {
			type = "description",
			name = TitanUtils_GetHexText(v.name, Titan_Global.colors.green),
			order = position,
			width = "30",
		}

		position = position + 1 -- Top image (col 2)
		t[skin .. position] = {
			type = "description",
			name = "",
			image = v.path .. "TitanPanelBackgroundTop0",
			imageWidth = 256,
			order = position,
			width = "50",
		}

		position = position + 1 -- spacer
		t[skin .. position] = {
			type = "description",
			name = "",
			imageHeight = 0,
			order = position,
			width = "full",
		}

		position = position + 1 -- Bottom (col 1)
		t[skin .. position] = {
			type = "description",
			name = "",
			order = position,
			width = "30",
		}
		position = position + 1 -- Bottom image (col 2)
		t[skin .. position] = {
			type = "description",
			name = "",
			image = v.path .. "TitanPanelBackgroundBottom0",
			imageWidth = 256,
			order = position,
			width = "50",
		}

		position = position + 1 -- final spacer - bottom of config
		t[skin .. position] = {
			type = "description",
			name = "",
			imageHeight = 0,
			order = position,
			width = "full",
		}
	end

	position = position + 1 -- final spacer - bottom of config
	t[skin .. position] = {
		type = "description",
		name = "",
		order = position,
		width = "full",
	}
end

local function BuildSkins()
	optionsSkins.args = {}

	Show_Skins(optionsSkins.args, 100) -- the current list of skins with images
	AceConfigRegistry:NotifyChange("Titan Panel Skin Control")
end

--============= Skins - Custom

---Helper to add each skin to the options list.
---@param skinname string Shown to user
---@param skin_path string folder name of skin ONLY; prefix (Titan path) will be added
local function AddNewSkin(skinname, skin_path)
	local out_str = "Start : "
	local msg_type = "warning" -- assume something went wrong :)

	local skinpath = TitanSkinsCustomPath .. skin_path .. TitanSkinsPathEnd
	-- name and path must be provided
	if skinname and skinpath then -- continue
		-- name cannot be empty or "None", path cannot be empty
		if skinname == "" or skinname == L["TITAN_PANEL_NONE"] or skinpath == "" then
			out_str = L["TITAN_PANEL_SKINS_BLANK_VALUE"]
		else
			-- Assume the skin is already in the Titan saved variables list
			local found
			for _, i in pairs(TitanSkins) do
				if i.name == skinname or i.path == skinpath then
					found = true
					break
				end
			end

			-- The skin is new so add it to the Titan saved variables list
			if found then
				out_str = L["TITAN_PANEL_SKINS_ALREADY_LISTED"]
			else
				table.insert(TitanSkins, { name = skinname, path = skinpath })
				msg_type = "info"
				out_str = L["TITAN_PANEL_SKINS_ADDED"]
			end
		end
	else
		out_str = L["TITAN_PANEL_SKINS_NO_VALUE"]
	end

	-- Regardless of result, rebuild Skin list
	BuildSkins()

	out_str = out_str
		.. " '" .. tostring(skinname) .. "'"
		.. "\n Full Path:" .. tostring(skinpath) .. ""
	TitanPrint(out_str, msg_type)
end

---Remove requested skin from selectable list.
---@param skinname string Shown to user
local function Remove_Skin(skinname)
	local out_str = "Start : "
	local msg_type = "warning" -- assume something went wrong :)
	local found = false

	if skinname == "None" then
		out_str = L["TITAN_PANEL_SKINS_NONE_SELECTED"]
	else
		local k, v;
		for k, v in pairs(TitanSkins) do
			if v.name == skinname then
				table.remove(TitanSkins, k)
				found = true
				break
			end
		end
		if found then
			msg_type = "info"
			out_str = L["TITAN_PANEL_SKINS_REMOVED"]
		else
			out_str = L["TITAN_PANEL_SKINS_NONE_SELECTED"]
		end
	end

	out_str = out_str
		.. " '" .. tostring(skinname) .. "'"
	TitanPrint(out_str, msg_type)
end

---hold the Titan custom skins options that allow a user to add or delete skins.
local optionsSkinsCustom = {
	name = TITAN_PANEL_CONFIG.topic.skinscust, --L["TITAN_PANEL_SKINS_TITLE_CUSTOM"],
	type = "group",
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = L["TITAN_PANEL_SKINS_MAIN_DESC"] .. "\n",
			cmdHidden = true
		},
		nulloption1 = {
			order = 5,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		addskinheader = {
			order = 10,
			type = "header",
			name = L["TITAN_PANEL_SKINS_NEW_HEADER"],
		},
		newskinname = {
			order = 11,
			name = L["TITAN_PANEL_SKINS_NAME_TITLE"],
			desc = L["TITAN_PANEL_SKINS_NAME_DESC"],
			type = "input",
			width = "full",
			get = function() return TitanSkinName end,
			set = function(_, v) TitanSkinName = v end,
		},
		newskinpath = {
			order = 12,
			name = L["TITAN_PANEL_SKINS_PATH_TITLE"],
			desc = L["TITAN_PANEL_SKINS_PATH_DESC"],
			type = "input",
			width = "full",
			get = function() return TitanSkinPath end,
			set = function(_, v) TitanSkinPath = v end,

		},
		addnewskin = {
			order = 13,
			name = L["TITAN_PANEL_SKINS_ADD_HEADER"],
			type = "execute",
			desc = L["TITAN_PANEL_SKINS_ADD_DESC"],
			func = function()
				AddNewSkin(TitanSkinName, TitanSkinPath)
				TitanSkinName = ""
				TitanSkinPath = ""
				-- Config Tables changed!
				AceConfigRegistry:NotifyChange("Titan Panel Skin Custom")
			end,
		},
		nulloption2 = {
			order = 14,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		removeskinheader = {
			order = 20,
			type = "header",
			name = L["TITAN_PANEL_SKINS_REMOVE_HEADER"],
		},
		removeskinlist = {
			order = 21,
			type = "select",
			width = "full",
			name = L["TITAN_PANEL_SKINS_REMOVE_HEADER"],
			desc = L["TITAN_PANEL_SKINS_REMOVE_DESC"],
			get = function() return TitanSkinToRemove end,
			set = function(_, v)
				TitanSkinToRemove = v
			end,
			values = function()
				local Skinlist = {}
				local v;
				for _, v in pairs(TitanSkins) do
					if v.path ~= TitanPanelGetVar("TexturePath")
						and v.path ~= "Interface\\AddOns\\Titan\\Artwork\\"
						and v.titan ~= true
					then
						Skinlist[v.name] = TitanUtils_GetHexText(v.name, Titan_Global.colors.green)
					end
					if v.path == TitanSkinToRemove then
						Skinlist[v.name] = TitanUtils_GetHexText(v.name, Titan_Global.colors.yellow)
					end
				end
				if TitanSkinToRemove ~= "None" then
					Skinlist["None"] = TitanUtils_GetHexText(L["TITAN_PANEL_NONE"], Titan_Global.colors.green)
				else
					Skinlist["None"] = TitanUtils_GetHexText(L["TITAN_PANEL_NONE"], Titan_Global.colors.yellow)
				end
				table.sort(Skinlist, function(a, b)
					return string.lower(a)
						< string.lower(b)
				end)
				return Skinlist
			end,
		},
		removeskin = {
			order = 22,
			type = "execute",
			name = L["TITAN_PANEL_SKINS_REMOVE_BUTTON"],
			desc = L["TITAN_PANEL_SKINS_REMOVE_BUTTON_DESC"],
			func = function()
				Remove_Skin(TitanSkinToRemove)
				TitanSkinToRemove = "None"
				-- Config Tables changed!
				AceConfigRegistry:NotifyChange("Titan Panel Skin Custom")
			end,
		},
		nulloption4 = {
			order = 24,
			type = "description",
			name = "   ",
			cmdHidden = true
		},
		resetskinhdear = {
			order = 200,
			type = "header",
			name = L["TITAN_PANEL_SKINS_RESET_HEADER"],
		},
		defaultskins = {
			order = 201,
			name = L["TITAN_PANEL_SKINS_RESET_DEFAULTS_TITLE"],
			type = "execute",
			desc = L["TITAN_PANEL_SKINS_RESET_DEFAULTS_DESC"],
			func = function()
				TitanSkins = TitanSkinsDefault;
				BuildSkins()
			end,
		},
		notes_delete = {
			order = 999,
			type = "description",
			name = "\n\n" .. L["TITAN_PANEL_SKINS_REMOVE_NOTES"] .. "\n",
			cmdHidden = true
		},
	}
}

--============= Extras

local optionsExtras = {
	name = TITAN_PANEL_CONFIG.topic.extras,
	type = "group",
	args = {}
}

---Show plugins that are not registered (loaded) but have config data. The data can be deleted by the user.
local function TitanUpdateExtras()
	local args = optionsExtras.args
	local plug_in = nil

	wipe(args)

	args["desc"] = {
		order = 1,
		type = "description",
		name = L["TITAN_PANEL_EXTRAS_DESC"] .. "\n",
		cmdHidden = true
	}
	for idx, value in pairs(TitanPluginExtras) do
		if TitanPluginExtras[idx] then
			local num = TitanPluginExtras[idx].num
			local name = TitanPluginExtras[idx].id
			args[name] = {
				type = "group",
				name = TitanUtils_GetGoldText(tostring(num) .. ": " .. (name or "?")),
				order = idx,
				args = {
					name = {
						type = "description",
						name = TitanUtils_GetGoldText(name or "?"),
						cmdHidden = true,
						order = 10,
					},
					optionreset = {
						name = L["TITAN_PANEL_EXTRAS_DELETE_BUTTON"],
						order = 15,
						type = "execute",
						width = "full",
						func = function(info, v)
							TitanPluginSettings[name] = nil -- delete the config entry
							TitanPrint(
								" '" .. name .. "' " .. L["TITAN_PANEL_EXTRAS_DELETE_MSG"]
								, "info")
							--							TitanVariables_ExtraPluginSettings() -- rebuild the list
							TitanUpdateExtras()                   -- rebuild the options config
							AceConfigRegistry:NotifyChange("Titan Panel Addon Extras") -- tell Ace to redraw
						end,
					},
				}
			}
		end
	end

	AceConfigRegistry:NotifyChange("Titan Panel Addon Extras")
end
-------------

--============= Attempts

local optionsAddonAttempts = {
	name = TITAN_PANEL_CONFIG.topic.attempts,
	type = "group",
	args = {}
}

---Show the each plugin that attempted to register with Titan.
local function TitanUpdateAddonAttempts()
	local args = optionsAddonAttempts.args
	local plug_in = nil

	--[[ NOTE:
- This is called after the plugins are registered in the 'player entering world' event. It can be called again as plugins registered.
- Any plugins that attempted to register are shown. See the Titan Utils section for more details on plugin registration.
- This option page is for display only. The user can take not action.
- This can be used by plugin developers as the create / update plugins (Titan or LDB).
- It can also be used by user to attempt to figure out why a plugin is not shown or to report an issue to Titan.
--]]

	wipe(args)

	args["desc"] = {
		order = 0,
		type = "description",
		name = L["TITAN_PANEL_ATTEMPTS_DESC"],
		cmdHidden = true
	}
	for idx, value in pairs(TitanPluginToBeRegistered) do
		if TitanPluginToBeRegistered[idx]
		then
			local num = tostring(idx)
			local button = TitanPluginToBeRegistered[idx].button
			local name = (TitanPluginToBeRegistered[idx].name or "?")
			local reason = TitanPluginToBeRegistered[idx].status
			local issue = TitanPluginToBeRegistered[idx].issue
			local notes = TitanPluginToBeRegistered[idx].notes or ""
			local category = TitanPluginToBeRegistered[idx].category
			local ptype = TitanPluginToBeRegistered[idx].plugin_type
			local btype = TitanPanelButton_GetType(idx)
			local title = TitanPluginToBeRegistered[idx].name
			if reason ~= TITAN_REGISTERED then
				title = TitanUtils_GetRedText(title)
				issue = TitanUtils_GetRedText(issue)
			end

			args[num] = {
				type = "group",
				name = title,
				order = idx,
				args = {
					name = {
						type = "description",
						name = TitanUtils_GetGoldText("") .. name,
						cmdHidden = true,
						order = 1,
					},
					reason = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_STATUS"] .. ": ") .. reason,
						cmdHidden = true,
						order = 2,
					},
					issue = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_ISSUE"] .. ": \n") .. issue,
						cmdHidden = true,
						order = 3,
					},
					notes = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_NOTES"] .. ": \n") .. notes,
						cmdHidden = true,
						order = 4,
					},
					sp_1 = {
						type = "description",
						name = "",
						cmdHidden = true,
						order = 5,
					},
					category = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_CATEGORY"] .. ": ") .. category,
						cmdHidden = true,
						order = 10,
					},
					ptype = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_TYPE"] .. ": ") .. ptype, --.." "..btype,
						cmdHidden = true,
						order = 11,
					},
					button = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_BUTTON"] .. ": ") .. button,
						cmdHidden = true,
						order = 12,
					},
					num_val = {
						type = "description",
						name = TitanUtils_GetGoldText(L["TITAN_PANEL_ATTEMPTS_TABLE"] .. ": ") .. num,
						cmdHidden = true,
						order = 13,
					},
				}
			}
		end
	end

	-- Config Tables changed!
	AceConfigRegistry:NotifyChange(L["TITAN_PANEL"])
end
-------------

--============= Advanced

local conftimerdesc = {
	name = L["TITAN_PANEL_MENU_ADV_TIMER"],
	type = "group",
	inline = true,
	order = 1,
	args = {
		confdesc = {
			order = 10,
			type = "description",
			name = L["TITAN_PANEL_MENU_ADV_TIMER_DESC"],
			cmdHidden = true
		},
		advtimerpew = {
			name = L["TITAN_PANEL_MENU_ADV_PEW"],
			desc = L["TITAN_PANEL_MENU_ADV_PEW_DESC"],
			order = 20,
			type = "range",
			width = "full",
			min = 1,
			max = 10,
			step = 0.5,
			get = function() return TitanAllGetVar("TimerPEW") end,
			set = function(_, a)
				TitanAllSetVar("TimerPEW", a);
				TitanTimers["EnterWorld"].delay = a
			end,
		},
		advtimervehicle = {
			name = L["TITAN_PANEL_MENU_ADV_VEHICLE"],
			desc = L["TITAN_PANEL_MENU_ADV_VEHICLE_DESC"],
			order = 50,
			type = "range",
			width = "full",
			min = 1,
			max = 10,
			step = 0.5,
			get = function() return TitanAllGetVar("TimerVehicle") end,
			set = function(_, a)
				TitanAllSetVar("TimerVehicle", a);
				TitanTimers["Vehicle"].delay = a
			end,
		},
	},
}
local confbuffdesc = {
	name = L["TITAN_PANEL_MENU_ADV_BUFF"],
	type = "group",
	inline = true,
	order = 2,
	args = {
		confbuffdesc = {
			order = 110,
			type = "description",
			name = L["TITAN_PANEL_MENU_ADV_BUFF_DESC"],
			cmdHidden = true
		},
		advbuffadj = {
			name = " ",
			desc = "",
			order = 120,
			type = "range",
			width = "full",
			min = -100,
			max = 100,
			step = 1,
			get = function() return TitanPanelGetVar("BuffIconVerticalAdj") end,
			set = function(_, a)
				TitanPanelSetVar("BuffIconVerticalAdj", a);
				-- Adjust frame positions
				TitanPanel_AdjustFrames(true, "BuffIconVerticalAdj")
			end,
		},
	},
}

local optionsAdvanced = {
	name = TITAN_PANEL_CONFIG.topic.advanced, --L["TITAN_PANEL_MENU_ADV"],
	type = "group",
	args = {
		confoutputdesc = {
			name = L["TITAN_PANEL_MENU_ADV_OUTPUT"],
			type = "group",
			inline = true,
			order = 100,
			args = {
				confdesc = {
					order = 110,
					type = "description",
					name = L["TITAN_PANEL_MENU_ADV_OUTPUT_DESC"],
					cmdHidden = true
				},
				advname = {
					name = L["TITAN_PANEL_MENU_ADV_NAME"],
					desc = L["TITAN_PANEL_MENU_ADV_NAME_DESC"],
					order = 120,
					type = "toggle",
					width = "full",
					get = function() return not TitanAllGetVar("Silenced") end, -- yes, we did it to ourselves...
					set = function(_, a)
						TitanAllSetVar("Silenced", not a);
					end,
				},
				advplugins = {
					name = L["TITAN_PANEL_MENU_ADV_PLUGINS"],
					desc = L["TITAN_PANEL_MENU_ADV_PLUGINS_DESC"],
					order = 120,
					type = "toggle",
					width = "full",
					get = function() return TitanAllGetVar("Registered") end,
					set = function(_, a)
						TitanAllSetVar("Registered", a);
					end,
				},
			},
		},
		confadvanved = {
			name = L["TITAN_PANEL_MENU_ADV"],
			type = "group",
			inline = true,
			order = 100,
			args = {
				space_400_1 = {
					order = 400,
					type = "description",
					name = "  ",
					cmdHidden = true,
				},
				optionlaunchers = {
					name = L["TITAN_PANEL_MENU_LDB_FORCE_LAUNCHER"],
					order = 401,
					type = "execute",
					width = "full",
					func = function() TitanPanelBarButton_ForceLDBLaunchersRight() end,
				},
				space_500_1 = {
					order = 500,
					type = "description",
					name = "  ",
					cmdHidden = true,
				},
				pluginreset = {
					name = L["TITAN_PANEL_MENU_PLUGIN_RESET"],
					desc = L["TITAN_PANEL_MENU_PLUGIN_RESET_DESC"],
					order = 501,
					type = "execute",
					width = "full",
					func = function() TitanPanel_InitPanelButtons() end,
				},
				space_600_1 = {
					order = 600,
					type = "description",
					name = "  ",
					cmdHidden = true,
				},
				optionreset = {
					name = L["TITAN_PANEL_MENU_RESET"] .. " "
						.. TitanUtils_GetGreenText(L["TITAN_PANEL_MENU_RELOADUI"]),
					order = 601,
					type = "execute",
					width = "full",
					func = function() TitanPanel_ResetTitanToDefault() end,
				}
			},
		},
	},
}

---Allow the user to control advanced features.
local function BuildAdv()
	if Titan_Global.switch.can_edit_ui then
	else
		optionsAdvanced.args.conftimerdesc = conftimerdesc
		optionsAdvanced.args.confbuffdesc = confbuffdesc
	end

	AceConfigRegistry:NotifyChange("Titan Panel Advanced")
end

--============= Change History

---Recent change history; stored in History.lua
local changeHistory = {
	name = TITAN_PANEL_CONFIG.topic.changes,
	type = "group",
	args = {
		confchanges = {
			order = 7,
			name = " ",
			type = "group",
			inline = true,
			args = {
				confversiondesc = {
					order = 1,
					type = "description",
					name = "" .. Titan_Global.recent_changes,
					cmdHidden = true
				},
			}
		},
	},
}


--============= / Help

---Format a known table - topic, subtopic, lines
---@param topic table
---@return string topic Single formatted string
local function ParseHelp(topic)
	-- Topic header is green
	-- Subtopic is gold
	-- Lines are white (highlight)
	local str = ""
	str = str .. TitanUtils_GetGreenText(topic.topic .. " : \n")

	for idx = 1, #topic.subs do
		local stopic = topic.subs[idx]
		str = str .. " \n" -- space before sub topic
		str = str .. TitanUtils_GetGoldText(stopic.sub .. " : \n")
		local lineout = ""
		for line = 1, #stopic.lines do -- Details
			lineout = lineout .. stopic.lines[line] .. " \n"
		end
		str = str .. TitanUtils_GetHighlightText(lineout .. "\n")
	end

	return str
end

-- carriage returns (backslash n) are needed only inside line text.
-- A blank line is added before each sub topic.
-- A carriage return is added after each topic, sub topic, and string in lines.
local help_list_topics = {
	{ -- plugins
		topic = L["TITAN_PANEL_MENU_PLUGINS"],
		subs = {
			{
				sub = "Show / Hide Plugins",
				lines = {
					"Use one of the methods below:",
					"- Open the Titan menu; find the plugin in a category then click to toggle Show on the plugin.",
					"- Open Titan Configuration > Plugins then select the plugin by name then toggle Show. Use the Bar dropdown to select the Bar the plugin should be on.",
				},
			},
			{
				sub = "Moving Plugins",
				lines = {
					" Use one of the methods below:",
					"- Open the Titan menu of the Bar you want the plugin on; find the plugin in a category then toggle Show.",
					"-- If plugin is already shown on another Bar then toggle again to have it appear on the desired Bar.",
					"- Open Titan Configuration > Plugins.",
					"-- Use the Bar dropdown to change bars.",
					"-- Use Right / Left buttons to place the plugin as desired.",
					"- Drag and drop : Drag (hold left mouse button on plugin) to another bar (any where, even over a plugin).",
					"-- The plugin will drop at the end of the plugin list, it will not attempt to insert between plugins.",
					"-- If right side, it will be left of right side plugins. Otherwise right of left side plugins.",
					"-- This honors right side setting.",
					"-- This honors 'force bar' such as auto hide 'pins'.",
					"-- If not over a bar, the plugin will return to the bar it came from at 'end'.",
				},
			},
		},
	},
	{ -- bars overview
		topic = L["TITAN_PANEL_MENU_OPTIONS_BARS_ALL"],
		subs = {
			{
				sub = "Overview",
				lines = {
					"- Titan Bars include 2 top bars, 2 bottom bars, and 10 short bars.",
					"- The top and bottom bars are screen width. They can not be moved.",
					"- Short bars are movable and have a changeable width.",
					"- The Titan menu shows the name of the Bar in the menu title.",
					"- All Bars can be shown or hidden from the Titan menu or Titan Config.",
				},
			},
			{
				sub = "Enable",
				lines = {
					"Open Titan > Configuration > Bars then select the Bar then select Show to show or deselect to hide.",
					"OR use Titan menu to Show or Hide each bar.",
				},
			},
			{
				sub = "Configure",
				lines = {
					"Open Titan > Configuration > Bar to change options for each Bar.",
					"Here you can show / hide; change the justify; change skin or color; and other features.",
					"   ",
					"Notes:  ",
					"- See Short Bars help on how to move and resize Short Bars. ",
				},
			},
		},
	},
	{ -- short bars
		topic = "Short Bars",
		subs = {
			{
				sub = "Overview",
				lines = {
					"- Short bars are 10 shorter Titan bars that the user can place and change width.",
					"- Short bars are independent and may be moved on the WoW UI.",
					"- Titan does not restrict plugins to fit within the visible width (background).",
					" Plugins can be assigned well beyond the visible bar. This may be desirable for some users.",
					"- Setting a plugin to right-side will use the visible right side (background); and may overlap with left or center aligned plugins.",
				},
			},
			{
				sub = "Change Size",
				lines = {
					"- Change width by 1 : Use Shift + mouse wheel.",
					"- Change width by 10: Use Shift + Ctrl + mouse wheel.",
					"- WIll not go beyond right side of screen.",
				},
			},
			{
				sub = "Move",
				lines = {
					"- Use Shift + left mouse on Bar, not plugins, and drag.",
					"- When dragging, best to place your mouse over the left side padding before moving or changing width.",
					"- When dragging stops, if the Short Bar is beyond the screen edge the Short Bar should 'snap' to the edge.",
				},
			},
			{
				sub = "Reset",
				lines = {
					"- In case a Short bar gets messed up, ",
					"-- use Titan > Config > Bar >  then select the Bar",
					"-- then click Reset Position to place it at its default position and width.",
				},
			},
			{
				sub = "Limitations",
				lines = {
					"- Min width : Left side padding plus one icon width.",
					"- Max width : Screen width.",
					"- There is no 'snap together' or grid for placing Short Bars.",
					"- Can select Skin per Short bar BUT only the 'top' skin is used; some skins have a different top & bottom.",
				},
			},
		},
	},
	{ -- profiles
		topic = L["TITAN_PANEL_MENU_PROFILES"],
		subs = {
			{
				sub = "Overview",
				lines = {
					"- Every toon logged into has a profile that stores the settings on next login / reload.",
					"- Profiles are part of Titan saved vars which are saved to disk on logout or reload.",
					" ",
					"- Profiles can be changed by :",
					" Using Titan > Config > Profiles ",
					" Or clicking Profile Configuration in the Titan menu",
					"- The Titan menu will show the profile being used under Profile Configuration.",
					" ",
					"- Titan 9.* Changed from a Global profile to a Sync and Sync All scheme for greater flexibility.",
				},
			},
			{
				sub = "Sync a profile",
				lines = {
					"- You may Sync a profile or multiple profiles to a profile. When you sync a profile any changes to bars and plugins are made to the Sync profile.",
					"- Select the profile to use for your current toon. Then click Sync.",
					"- Titan changes will be made to the Sync profile. ",
					"- The settings for the current toon will be used when the Sync is cleared.",
				},
			},
			{
				sub = "Clear Sync a profile",
				lines = {
					"- You may Clear Sync (remove) the current Sync being used by a profile.",
					"- Select the profile to use. Then click Clear Sync.",
					"- The settings prior to the Sync will be shown and can be changed.",
				},
			},
			{
				sub = "Sync All a profile",
				lines = {
					"- You may Sync All profiles to a profile. When you sync a profile any changes to bars and plugins are made to the Sync profile.",
					"- Select the profile to use for all toons, even newly created toons. Then click Sync All.",
					"- Now Titan changes will be made to the Sync All profile. ",
					"- The settings for the non Sync All toon will be used when the Sync All is cleared.",
				},
			},
			{
				sub = "Clear Sync All profile",
				lines = {
					"- Select the profile to use. Then click Clear Sync All.",
					"- The settings prior to the Sync All for all toons will be shown and can be changed.",
				},
			},
			{
				sub = "Load a Profile",
				lines = {
					"- Select the profile you want then click Load. The current profile is gray to prevent loading.",
					"- Load will COPY the profile over the logged in toon.",
				},
			},
			{
				sub = "Delete a Profile",
				lines = {
					"- Select the profile you want then click Delete. The current profile is gray to prevent deleting.",
					"- On delete the profile will disappear from the config profile list.",
					"- Delete of a profile should be done on a toon that was deleted from the game.",
					"- Delete can act as a Titan reset for that toon.",
				},
			},
			{
				sub = "Reset a Profile in Use",
				lines = {
					"- The reset will be done on the profile in use - current, Sync, or Sync All profile.",
					"- On the current profile, it will just reset that profile.",
					"- On a profile using a Sync or Sync All profile, it will reset the Sync profile leaving the Sync relationships in place.",
				},
			},
			{
				sub = "Custom Profile",
				lines = {
					"- Select the profile you want to save as a custom profile then click Save Custom.",
					"- Name the profile. It will be saved with a 'server' of 'TitanCustomProfile'.",
					" ",
					"- There are two ways to change a custom profile.",
					"-- Sync a toon to the custom profile then update the profile while logged into that toon.",
					"-- Overwrite the profile by using Save Custom again then input the same name. An 'are you sure' prompt will appear.",
					" ",
					"- On create or overwrite of a custom profile, Titan will reload to ensure the profile is saved.",
				},
			},
		},
	},
	{                        -- export / import profiles
		topic = "Export / Import", --L["TITAN_PANEL_MENU_PROFILES"],
		subs = {
			{
				sub = "Overview",
				lines = {
					"- The export / input feature is intended as a backup method or a way to transfer from one system or account to another.",
					"   ",
					"- An export file is a compressed string that must be stored safely be the user.",
					"- An export file can contain 1 or more toon profiles.",
					"- The key is <toon>@<server> which is exported or imported regardless of the current profile list.",
				},
			},
			{
				sub = "Export",
				lines = {
					"- You may Export a profile or multiple profiles from Titan Panel.",
					"- To create an Export use Titan > Config > Export / Import .",
					"  Then select the profile(s) to Export.",
					"  Then click Export.",
					"  The Export string will appear in the Export box.",
					"  The user is responsible for storing the Export string safely without changes or extra characters.",
				},
			},
			{
				sub = "Import",
				lines = {
					"- You may Import an export file into Titan Panel.",
					"- To Import use Titan > Config > Export / Import .",
					"  Get the Export string from a safe place.",
					"  Copy it into the Export box.",
					"  Then click Import.",
					"  If the string was valid, Titan will reload to ensure the profiles are saved. ",
					"   ",
					"Notes: ",
					"- Any valid export file will be loaded, regardless whether the toon exists.",
					"- A profile can easily be deleted, if not wanted after an Import.",
				},
			},
		},
	},
	{ -- slash commands
		topic = L["TITAN_PANEL_MENU_SLASH_COMMAND"],
		subs = {
			{
				sub = L["TITAN_PANEL_MENU_HELP"],
				lines = {
					TitanUtils_GetGoldText("reset"),
					L["TITAN_PANEL_SLASH_RESET_0"],
					L["TITAN_PANEL_SLASH_RESET_1"],
					L["TITAN_PANEL_SLASH_RESET_2"],
					L["TITAN_PANEL_SLASH_RESET_3"],
					L["TITAN_PANEL_SLASH_RESET_4"],
					L["TITAN_PANEL_SLASH_RESET_5"],
					L["TITAN_PANEL_SLASH_RESET_6"],
					"",
					TitanUtils_GetGoldText("gui"),
					L["TITAN_PANEL_SLASH_GUI_0"],
					L["TITAN_PANEL_SLASH_GUI_1"],
					L["TITAN_PANEL_SLASH_GUI_2"],
					L["TITAN_PANEL_SLASH_GUI_3"],
					"",
					TitanUtils_GetGoldText("profile"),
					L["TITAN_PANEL_SLASH_PROFILE_0"],
					L["TITAN_PANEL_SLASH_PROFILE_1"],
					L["TITAN_PANEL_SLASH_PROFILE_2"],
					L["TITAN_PANEL_SLASH_PROFILE_3"],
					"",
					TitanUtils_GetGoldText("silent"),
					L["TITAN_PANEL_SLASH_SILENT_0"],
					L["TITAN_PANEL_SLASH_SILENT_1"],
					"",
					TitanUtils_GetGoldText("orderhall"),
					L["TITAN_PANEL_SLASH_ORDERHALL_0"],
					L["TITAN_PANEL_SLASH_ORDERHALL_1"],
					"",
					TitanUtils_GetGoldText("help"),
					L["TITAN_PANEL_SLASH_HELP_0"],
					L["TITAN_PANEL_SLASH_HELP_1"],
					"",
					TitanUtils_GetGoldText("all"),
					L["TITAN_PANEL_SLASH_ALL_0"],
					L["TITAN_PANEL_SLASH_ALL_1"],
					" ",
				},
			},
		},
	},
	{ -- notes
		topic = "Addon Files",
		subs = {
			{
				sub = "WoW structure",
				lines = {
					"WoW is installed in different folders on Windows, iOS, or Linux.",
					"It is installed as ../World of Warcraft/<version>/",
					"Where <version> can be _retail_ | _classic_ | _classic_era_ | etc.",
				},
			},
			{
				sub = "Addon location",
				lines = {
					"Addons are under each <version> as <version>/interface/AddOns ",
					"such as Titan and its various built-in plugins released by the Titan dev team.",
				},
			},
			{
				sub = "Saved vars location",
				lines = {
					"There are two types of saved vars - 'account' or 'per character'.\n",
					" 'account' is under <version>/WTF/Account/<your account>/SavedVariables \n",
					" 'per character' is under <version>/WTF/Account/<server>/<toon name>/SavedVariables \n",
				},
			},
			{
				sub = "Notes",
				lines = {
					"- WoW addon load process loads the proper saved vars into memory at login and reload. \n",
					"- On log out or exit or reload WoW writes the saved vars to disk. \n",
					"- WoW allows addons NO access to the file system. An addon cannot trigger a read or a write. \n",
				},
			},
		},
	},
	{ -- notes
		topic = "Notes",
		subs = {
			{
				sub = "Changing Titan Scaling",
				lines = {
					"Short bars will move on screen. They should not go off screen. ",
					"If Short bars move then drag to desired location. You may have to Reset the Short bar or temporarily disable top or bottom bars to drag the Short bar.",
				},
			},
		},
	},
	{ -- issues
		topic = "Known Issues",
		subs = {
			{
				sub = "Titan",
				lines = {
					"No known major issues.",
				},
			},
			{
				sub = "Repair",
				lines = {
					"Selling all grey items may take 2, possibly 3 clicks. There is no known fix atm.",
				},
			},
		},
	},
	{ -- TY
		topic = "Thank You",
		subs = {
			{
				sub = "From Titan Dev Team",
				lines = {
					"We would like to thank all of the users of TitanPanel.",
				},
			},
		},
	},
}

local helplist = {
	name = TITAN_PANEL_CONFIG.topic.help_list,
	type = "group",
	args = {}
}

---Format the help to display in Config
local function BuildHelpList()
	local args = helplist.args
	-- list element

	for idx = 1, #help_list_topics do
		-- Create the list of topics
		local index = tostring(idx)
		args[index] = {
			name = help_list_topics[idx].topic,
			order = idx,
			type = "group",
			args = {},
		}
		-- Add the text...
		args[index].args.show = {
			order = 1,
			type = "description",
			name = ParseHelp(help_list_topics[idx]),
			cmdHidden = true
		}
	end
end

local titan_options = {
	name = "Titan structure",
	type = "group",
	childGroups = "tab",
	args = {}
}
local function BuiltTitanStructure()
	do -- create for config frame; using most of the Blizz config structure
		-- This is called from Titan menu and the slash command
		titan_options.args = {
			titan_entry = {
				name = titan_entry.name,
				order = 10,
				type = "group",
				args = titan_entry.args
			},
			optionsBars = {
				name = optionsBars.name,
				order = 20,
				type = "group",
				args = optionsBars.args
			},
			optionsGlobals = {
				name = optionsGlobals.name,
				order = 30,
				type = "group",
				args = optionsGlobals.args
			},
			optionsAdjust = {
				name = optionsAdjust.name,
				order = 40,
				type = "group",
				args = optionsAdjust.args
			},
			optionsFrames = {
				name = optionsFrames.name,
				order = 50,
				type = "group",
				args = optionsFrames.args
			},
			optionsUIScale = {
				name = optionsUIScale.name,
				order = 60,
				type = "group",
				args = optionsUIScale.args
			},
			optionsSkins = {
				name = optionsSkins.name,
				order = 70,
				type = "group",
				args = optionsSkins.args
			},
			optionsSkinsCustom = {
				name = optionsSkinsCustom.name,
				order = 80,
				type = "group",
				args = optionsSkinsCustom.args
			},
			optionsAddons = {
				name = optionsAddons.name,
				order = 90,
				type = "group",
				args = optionsAddons.args
			},
			optionsAddonAttempts = {
				name = optionsAddonAttempts.name,
				order = 100,
				type = "group",
				args = optionsAddonAttempts.args
			},
			optionsExtras = {
				name = optionsExtras.name,
				order = 110,
				type = "group",
				args = optionsExtras.args
			},
			optionsChars = {
				name = optionsChars.name,
				order = 120,
				type = "group",
				args = optionsChars.args
			},
			optionsImportExport = {
				name = optionsImportExport.name,
				order = 130,
				type = "group",
				args = optionsImportExport.args
			},
			optionsAdvanced = {
				name = optionsAdvanced.name,
				order = 140,
				type = "group",
				args = optionsAdvanced.args
			},
			changeHistory = {
				name = changeHistory.name,
				order = 150,
				type = "group",
				args = changeHistory.args
			},
			helplist = {
				name = helplist.name,
				order = 160,
				type = "group",
				args = helplist.args
			},
		}
	end
end

--============= Build the config
---Build the entire Config table Ace will display
local function BuildAll()
	-- Update font list
	
	for idx, font in pairs (media:List("font")) do
--		local path = media:Fetch('font', font)
--		print(idx, font, path)

		font_list[font] = font
	end
	table.sort(font_list)

	
	-- Update the tables for the latest lists
	UpdateConfigAddons()
	TitanUpdateAddonAttempts()
	TitanUpdateExtras()
	TitanUpdateChars()
	TitanToonList()
	BuildSkins()
	BuildBars()
	BuildBarsAll()
	BuildAdj()
	BuildAdv()
	BuildHelpList()
	BuiltTitanStructure()
end

---Titan This routine will handle the requests to build or clear the Titan Config screens.
--- This is called after the plugins are registered in the 'player entering world' event. It can be called again as more plugins are registered.
---@param action string "init" or "nuke"
function TitanUpdateConfig(action)
	if action == "init" then
		BuildAll()
	end

	if action == "nuke" then
		local nuked = {
			name = "Titan could not initialize properly.",
			type = "group",
			args = {}
		}

		TitanPrint("-- Clearing Titan options...", "warning")
		-- Use the same group as below!!
		--		AceConfig:RegisterOptionsTable("Titan Panel Main", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Bars", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Globals", nuked)
		--		AceConfig:RegisterOptionsTable("Titan Panel Aux Bars", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Frames", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Transparency Control", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Panel Control", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Skin Control", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Skin Custom", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Control", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Attempts", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Extras", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Chars", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Advanced", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Changes", nuked)
		AceConfig:RegisterOptionsTable("Titan Panel Addon Slash", nuked)
	end
end

do -- Register Titan main options list
	-- Register the options tables with Ace then register the options with Blizz so the user can use them.
	-- Add Blizzard Configuration Panels
	-- The first param needs to used for the 'add to options'
	-- The second param must be the table Ace will use to create the user options
	--
	AceConfig:RegisterOptionsTable("Titan Panel About", titan_entry)
	AceConfig:RegisterOptionsTable("Titan Panel Bars", optionsBars)
	AceConfig:RegisterOptionsTable("Titan Panel Globals", optionsGlobals)
	AceConfig:RegisterOptionsTable("Titan Panel Adjust", optionsAdjust)
	AceConfig:RegisterOptionsTable("Titan Panel Frames", optionsFrames)
	AceConfig:RegisterOptionsTable("Titan Panel Panel Control", optionsUIScale)
	AceConfig:RegisterOptionsTable("Titan Panel Skin Control", optionsSkins)
	AceConfig:RegisterOptionsTable("Titan Panel Skin Custom", optionsSkinsCustom)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Control", optionsAddons)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Attempts", optionsAddonAttempts)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Extras", optionsExtras)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Chars", optionsChars)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Im_Ex", optionsImportExport)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Advanced", optionsAdvanced)
	AceConfig:RegisterOptionsTable("Titan Panel Addon Changes", changeHistory)
	--	AceConfig:RegisterOptionsTable("Titan Panel Addon Slash", slashHelp)
	AceConfig:RegisterOptionsTable("Titan Panel Help List", helplist)

	AceConfigRegistry:RegisterOptionsTable("Titan", titan_options)
end

do -- Register the options for each entry in Titan option list
	-- Set the main options pages
	-- The first param must be the same as the cooresponding 'Ace RegisterOptionsTable'
	-- The second param should be the same as the .name of the cooresponding table that was registered,
	-- if not, any 'open' may fail.
	--

	AceConfigDialog:AddToBlizOptions("Titan Panel About", titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Bars", optionsBars.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Globals", optionsGlobals.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Adjust", optionsAdjust.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Control", optionsAddons.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Chars", optionsChars.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Im_Ex", optionsImportExport.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Frames", optionsFrames.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Panel Control", optionsUIScale.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Skin Control", optionsSkins.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Skin Custom", optionsSkinsCustom.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Extras", optionsExtras.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Attempts", optionsAddonAttempts.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Advanced", optionsAdvanced.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Changes", changeHistory.name, titan_entry.name)
	--	AceConfigDialog:AddToBlizOptions("Titan Panel Addon Slash", slashHelp.name, titan_entry.name)
	AceConfigDialog:AddToBlizOptions("Titan Panel Help List", helplist.name, titan_entry.name)

--	AceConfigDialog:AddToBlizOptions("Titan_Panel", "Titan")
end
