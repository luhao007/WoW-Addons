local _, private = ...

local pairs = pairs

local acr = LibStub("AceConfigRegistry-3.0")
local acd = LibStub("AceConfigDialog-3.0")

local PL = private:GetLocalizer("Options")

--[==[@debug@
PL:AddLocale("enUS", {
	prat = "Prat",
	["display_name"] = "Display Settings",
	["display_desc"] = "Chat Frame Control and Look",
	["formatting_name"] = "Chat Formatting",
	["formatting_desc"] = "Change the way the lines look and feel",
	["extras_name"] = "Extra Stuff",
	["extras_desc"] = "Msc. Modules",
	["modulecontrol_name"] = "Module Control",
	["modulecontrol_desc"] = "Control the loading and enabling of Prat's modules.",
	["reload_required"] = "This option change may not take full effect until you %s your UI.",
	load_no = "Don't Load",
	load_disabled = "Disabled",
	load_enabled = "Enabled",
	load_desc = "Control the load behavior for this module.",
	unloaded_desc = "Module is not loaded, load it to see description",
	load_disabledonrestart = "Disabled (reload)",
	load_enabledonrestart = "Enabled (reload)",
})
--@end-debug@]==]

-- These Localizations are auto-generated. To help with localization
-- please go to http://www.wowace.com/projects/prat-3-0/localization/


--@non-debug@
do
	local L
	L = {}
L["display_desc"] = "Chat Frame Control and Look"
L["display_name"] = "Display Settings"
L["extras_desc"] = "Msc. Modules"
L["extras_name"] = "Extra Stuff"
L["formatting_desc"] = "Change the way the lines look and feel"
L["formatting_name"] = "Chat Formatting"
L["load_desc"] = "Control the load behavior for this module."
L["load_disabled"] = "Disabled"
L["load_disabledonrestart"] = "Disabled (reload)"
L["load_enabled"] = "Enabled"
L["load_enabledonrestart"] = "Enabled (reload)"
L["load_no"] = "Don't Load"
L["modulecontrol_desc"] = "Control the loading and enabling of Prat's modules."
L["modulecontrol_name"] = "Module Control"
L["prat"] = "Prat"
L["reload_required"] = "This option change may not take full effect until you %s your UI."
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("enUS",L)

	L = {}
L["display_desc"] = "Comportement et apparence de la fenêtre de discussion."
L["display_name"] = "Options d'affichage"
L["extras_desc"] = "Modules divers"
L["extras_name"] = "Suppléments"
L["formatting_desc"] = "Apparence des lignes et du texte"
L["formatting_name"] = "Formatage du texte"
L["load_desc"] = "Contrôle le comportement de chargement de ce module."
L["load_disabled"] = "Désactivé"
L["load_disabledonrestart"] = "Désactivé (recharger)"
L["load_enabled"] = "Activé"
L["load_enabledonrestart"] = "Activé (recharger)"
L["load_no"] = "Ne pas charger"
L["modulecontrol_desc"] = "Contrôler le chargement et l'activation des modules de Prat"
L["modulecontrol_name"] = "Contrôle des modules"
L["prat"] = "Prat"
L["reload_required"] = "Le nouveau paramètre de cette option ne prendra pas effet intégralement tant que vous n'aurez pas %s votre interface."
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("frFR",L)

	L = {}
L["display_desc"] = "Steuerung und Darstellung des Chatfensters"
L["display_name"] = "Anzeigeeinstellungen"
L["extras_desc"] = "Verschiedene Module"
L["extras_name"] = "Sonstiges"
L["formatting_desc"] = "Ändert das Erscheinungsbild der Linien"
L["formatting_name"] = "Chat-Formatierung"
L["load_desc"] = "Steuert das Ladeverhalten dieses Moduls."
L["load_disabled"] = "Ausgeschaltet"
L["load_disabledonrestart"] = "Deaktiviert (neu laden)"
L["load_enabled"] = "Eingeschaltet"
L["load_enabledonrestart"] = "Aktiviert (neu laden)"
L["load_no"] = "Nicht laden"
L["modulecontrol_desc"] = "Steuert das Laden und Aktivieren von Prat-Modulen."
L["modulecontrol_name"] = "Modulsteuerung"
L["prat"] = "Prat"
L["reload_required"] = "Diese Änderung wird erst nach dem Neustart vollständig wirksam."
L["unloaded_desc"] = "Modul ist nicht geladen, lade es, um die Beschreibung zu sehen"

	PL:AddLocale("deDE",L)

	L = {}
L["display_desc"] = "대화창 기능 및 외형 설정"
L["display_name"] = "표시 설정"
L["extras_desc"] = "기타 모듈"
L["extras_name"] = "기타 기능"
L["formatting_desc"] = "대화창 글의 외형을 변경합니다."
L["formatting_name"] = "대화글 형식"
L["load_desc"] = "이 모듈의 로드 방식을 설정합니다."
L["load_disabled"] = "사용 안 함"
L["load_disabledonrestart"] = "비활성 (reload)"
L["load_enabled"] = "사용"
L["load_enabledonrestart"] = "활성 (reload)"
L["load_no"] = "로드 안함"
L["modulecontrol_desc"] = "Prat 모듈의 로드와 활성화를 제어합니다."
L["modulecontrol_name"] = "모듈 제어"
L["prat"] = "Prat"
L["reload_required"] = "이 옵션 변경은 UI를 %s 해야 적용됩니다."
L["unloaded_desc"] = "모듈을 불러오지 못함, 설명을 보려면 불러오세요."

	PL:AddLocale("koKR",L)

	L = {}
--[[Translation missing --]]
L["display_desc"] = "Chat Frame Control and Look"
--[[Translation missing --]]
L["display_name"] = "Display Settings"
--[[Translation missing --]]
L["extras_desc"] = "Msc. Modules"
--[[Translation missing --]]
L["extras_name"] = "Extra Stuff"
--[[Translation missing --]]
L["formatting_desc"] = "Change the way the lines look and feel"
--[[Translation missing --]]
L["formatting_name"] = "Chat Formatting"
--[[Translation missing --]]
L["load_desc"] = "Control the load behavior for this module."
--[[Translation missing --]]
L["load_disabled"] = "Disabled"
--[[Translation missing --]]
L["load_disabledonrestart"] = "Disabled (reload)"
--[[Translation missing --]]
L["load_enabled"] = "Enabled"
--[[Translation missing --]]
L["load_enabledonrestart"] = "Enabled (reload)"
--[[Translation missing --]]
L["load_no"] = "Don't Load"
--[[Translation missing --]]
L["modulecontrol_desc"] = "Control the loading and enabling of Prat's modules."
--[[Translation missing --]]
L["modulecontrol_name"] = "Module Control"
--[[Translation missing --]]
L["prat"] = "Prat"
--[[Translation missing --]]
L["reload_required"] = "This option change may not take full effect until you %s your UI."
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("esMX",L)

	L = {}
L["display_desc"] = "Настройка отображения чата"
L["display_name"] = "Настройка отображения"
L["extras_desc"] = "Различные дополнительные модули"
L["extras_name"] = "Другие модули"
L["formatting_desc"] = "Изменение отображения строк чата"
L["formatting_name"] = "Форматирование чата"
L["load_desc"] = "Настройка поведения этого модуля."
L["load_disabled"] = "Отключено"
L["load_disabledonrestart"] = "Отключён (перезагрузка)"
L["load_enabled"] = "Включено"
L["load_enabledonrestart"] = "Включён (перезагрузка)"
L["load_no"] = "Не загружать"
L["modulecontrol_desc"] = "Настройка загрузки модулей Prat"
L["modulecontrol_name"] = "Настройка модулей"
L["prat"] = "Prat"
L["reload_required"] = "Эта настройка вступит в силу только после %s вашего интерфейса."
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("ruRU",L)

	L = {}
L["display_desc"] = "聊天框管理与插件"
L["display_name"] = "显示设置"
L["extras_desc"] = "杂项模块"
L["extras_name"] = "扩展选项"
L["formatting_desc"] = "改变行的感观"
L["formatting_name"] = "聊天格式"
L["load_desc"] = "控制这个模块的载入状态"
L["load_disabled"] = "禁用"
L["load_disabledonrestart"] = "停用 (重载)"
L["load_enabled"] = "启用"
L["load_enabledonrestart"] = "启用 (重载)"
L["load_no"] = "不加载"
L["modulecontrol_desc"] = "控制Prat模块的读取和启用"
L["modulecontrol_name"] = "模块控制"
L["prat"] = "Prat"
L["reload_required"] = "在%s您的插件以前,此选项不会完全生效"
L["unloaded_desc"] = "模块未加载，请加载以查看描述"

	PL:AddLocale("zhCN",L)

	L = {}
L["display_desc"] = "Control y Aspecto del Marco del Chat"
L["display_name"] = "Mostrar Ajustes"
L["extras_desc"] = "Módulos Extra"
L["extras_name"] = "Material adicional"
L["formatting_desc"] = "Cambiar la forma del aspecto de las líneas"
L["formatting_name"] = "Formato del Chat"
L["load_desc"] = "Controla el comportamiento de carga de este módulo."
L["load_disabled"] = "Desactivado"
--[[Translation missing --]]
L["load_disabledonrestart"] = "Disabled (reload)"
L["load_enabled"] = "Activado"
--[[Translation missing --]]
L["load_enabledonrestart"] = "Enabled (reload)"
L["load_no"] = "No cargar"
L["modulecontrol_desc"] = "Control de las cargas y activaciones de los módulos de Prat"
L["modulecontrol_name"] = "Control de módulos"
L["prat"] = "Prat"
L["reload_required"] = "Esta opción requiere que reinicies la IU para que entre en funcionamiento"
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("esES",L)

	L = {}
L["display_desc"] = "控制及檢視聊天視窗"
L["display_name"] = "顯示設定"
L["extras_desc"] = "Msc. 模組"
L["extras_name"] = "附加擴充"
L["formatting_desc"] = "改變行的外觀以及感覺"
L["formatting_name"] = "聊天格式化"
L["load_desc"] = "控制此模組載入狀態。"
L["load_disabled"] = "已停用"
L["load_disabledonrestart"] = "已停用(重新載入)"
L["load_enabled"] = "已啟用"
L["load_enabledonrestart"] = "已啟用(重新載入)"
L["load_no"] = "不會載入"
L["modulecontrol_desc"] = "控制載入以及啟用的 Prat 模組。"
L["modulecontrol_name"] = "模組控制"
L["prat"] = "Prat"
L["reload_required"] = "變更此選項後仍無法發揮完整功能，除非你%s你的插件。"
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("zhTW",L)

	L = {}
--[[Translation missing --]]
L["display_desc"] = "Chat Frame Control and Look"
--[[Translation missing --]]
L["display_name"] = "Display Settings"
--[[Translation missing --]]
L["extras_desc"] = "Msc. Modules"
--[[Translation missing --]]
L["extras_name"] = "Extra Stuff"
--[[Translation missing --]]
L["formatting_desc"] = "Change the way the lines look and feel"
--[[Translation missing --]]
L["formatting_name"] = "Chat Formatting"
--[[Translation missing --]]
L["load_desc"] = "Control the load behavior for this module."
--[[Translation missing --]]
L["load_disabled"] = "Disabled"
--[[Translation missing --]]
L["load_disabledonrestart"] = "Disabled (reload)"
--[[Translation missing --]]
L["load_enabled"] = "Enabled"
--[[Translation missing --]]
L["load_enabledonrestart"] = "Enabled (reload)"
--[[Translation missing --]]
L["load_no"] = "Don't Load"
--[[Translation missing --]]
L["modulecontrol_desc"] = "Control the loading and enabling of Prat's modules."
--[[Translation missing --]]
L["modulecontrol_name"] = "Module Control"
--[[Translation missing --]]
L["prat"] = "Prat"
--[[Translation missing --]]
L["reload_required"] = "This option change may not take full effect until you %s your UI."
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("itIT",L)

	L = {}
L["display_desc"] = "Controle de Visualização de Frame de Chat"
L["display_name"] = "Configurações de Visualização"
L["extras_desc"] = "Módulos Diversos"
--[[Translation missing --]]
L["extras_name"] = "Extra Stuff"
--[[Translation missing --]]
L["formatting_desc"] = "Change the way the lines look and feel"
L["formatting_name"] = "Formatação do Chat"
--[[Translation missing --]]
L["load_desc"] = "Control the load behavior for this module."
L["load_disabled"] = "Desativado"
--[[Translation missing --]]
L["load_disabledonrestart"] = "Disabled (reload)"
L["load_enabled"] = "Ativado"
--[[Translation missing --]]
L["load_enabledonrestart"] = "Enabled (reload)"
L["load_no"] = "Não Carregar"
L["modulecontrol_desc"] = "Controla o carregamento e ativação de módulos do Prat."
L["modulecontrol_name"] = "Controle do Módulo"
L["prat"] = "Prat"
L["reload_required"] = "Essa alteração pode não ter efeitos até você %s sua IU."
--[[Translation missing --]]
L["unloaded_desc"] = "Module is not loaded, load it to see description"

	PL:AddLocale("ptBR",L)
end
--@end-non-debug@

local moduleControlArgs = {}

private.Options = {
	type = "group",
	childGroups = "tab",
	get = "GetValue",
	set = "SetValue",
	args = {
		display = {
			type = "group",
			name = PL["display_name"],
			desc = PL["display_desc"],
			get = "GetValue",
			set = "SetValue",
			args = {},
			order = 1,
		},
		formatting = {
			type = "group",
			name = PL["formatting_name"],
			desc = PL["formatting_desc"],
			get = "GetValue",
			set = "SetValue",
			args = {},
			order = 2,
		},
		extras = {
			type = "group",
			name = PL["extras_name"],
			desc = PL["extras_desc"],
			get = "GetValue",
			set = "SetValue",
			args = {},
			order = 3,
		},
		modulecontrol = {
			type = "group",
			name = PL["modulecontrol_name"],
			desc = PL["modulecontrol_desc"],
			get = "GetValue",
			set = "SetValue",
			args = moduleControlArgs,
			order = 4,
		}
	}
}

private.EnableTasks[#private.EnableTasks + 1] = function(self)
	acr:RegisterOptionsTable(PL.prat, private.Options)
	acr:RegisterOptionsTable(PL.prat .. ": " .. private.Options.args.display.name, private.Options.args.display)
	acr:RegisterOptionsTable(PL.prat .. ": " .. private.Options.args.formatting.name, private.Options.args.formatting)
	acr:RegisterOptionsTable(PL.prat .. ": " .. private.Options.args.extras.name, private.Options.args.extras)
	acr:RegisterOptionsTable(PL.prat .. ": " .. private.Options.args.modulecontrol.name, private.Options.args.modulecontrol)
	acr:RegisterOptionsTable("Prat: " .. private.Options.args.profiles.name, private.Options.args.profiles)

	acd:AddToBlizOptions(PL.prat, PL.prat)
	acd:AddToBlizOptions(PL.prat .. ": " .. private.Options.args.display.name, private.Options.args.display.name, PL.prat)
	acd:AddToBlizOptions(PL.prat .. ": " .. private.Options.args.formatting.name, private.Options.args.formatting.name, PL.prat)
	acd:AddToBlizOptions(PL.prat .. ": " .. private.Options.args.extras.name, private.Options.args.extras.name, PL.prat)
	acd:AddToBlizOptions(PL.prat .. ": " .. private.Options.args.modulecontrol.name, private.Options.args.modulecontrol.name, PL.prat)
	acd:AddToBlizOptions(PL.prat .. ": " .. private.Options.args.profiles.name, private.Options.args.profiles.name, PL.prat)

	self:RegisterChatCommand(PL.prat, function()
		private:ToggleOptionsWindow()
	end)
end

do
	local function getModuleFromShortName(shortname)
		for _, v in private.Addon:IterateModules() do
			if v.moduleName == shortname then
				return v
			end
		end
	end

	local function setValue(info, b)
		private.db.profile.modules[info[#info]] = b

		local m = getModuleFromShortName(info[#info])
		if not m then
			return
		end

		if b == 2 then
			m.db.profile.on = false
			m:Disable()
		elseif b == 3 then
			m.db.profile.on = true
			m:Enable()
		end
	end

	local function getValue(info)
		return private.db.profile.modules[info[#info]]
	end

	do
		local function getModuleDesc(info)
			local m = getModuleFromShortName(info[#info])
			local controlMsg = "\n\n" .. private.CLR:Colorize("a0a0ff", PL.load_desc)
			if not m then
				return PL.unloaded_desc .. controlMsg
			end
			return m:GetDescription() .. controlMsg
		end

		local moduleControlOption = {
			name = function(info)
				return info[#info]
			end,
			desc = getModuleDesc,
			type = "select",
			values = function()
				return {
					[2] = "|cffff8080" .. PL.load_disabled .. "|r",
					[3] = "|cff80ff80" .. PL.load_enabled .. "|r"
				}
			end,
			get = getValue,
			set = setValue
		}

		function private:CreateModuleControlOption(name)
			moduleControlArgs[name] = moduleControlOption
		end
	end
end

private.FrameList = {}
private.HookedFrameList = {}

local function updateFrameNames()
	for k, v in pairs(private.HookedFrames) do
		if v.isDocked == 1 or v:IsShown() then
			private.HookedFrameList[k] = v.name
		else
			private.HookedFrameList[k] = nil
		end
	end
	for k, v in pairs(private.Frames) do
		if v.isDocked == 1 or v:IsShown() then
			private.FrameList[k] = v.name
		else
			private.FrameList[k] = nil
		end
	end

	private:UpdateOptions()
end

function private:UpdateOptions()
	acr:NotifyChange("Prat")
end

private.EnableTasks[#private.EnableTasks + 1] = function(self)
	self:SecureHook("FCF_SetWindowName", updateFrameNames)

	FCF_SetWindowName(ChatFrame1, (GetChatWindowInfo(1)), 1)
end

function private:ToggleOptionsWindow()
	if acd.OpenFrames["Prat"] then
		acd:Close("Prat")
	else
		acd:Open("Prat")
	end
end

Prat_ToggleOptionsWindow = private.ToggleOptionsWindow
