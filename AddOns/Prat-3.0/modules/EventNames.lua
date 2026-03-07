---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2018  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------

Prat:AddModuleToLoad(function()
	local module = Prat:NewModule("EventNames")
	local PL = module.PL


	--[==[@debug@
	PL:AddLocale("enUS", {
		["EventNames"] = true,
		["Chat window event name options."] = true,
		["Show"] = true,
		["Show events on chatframes"] = true,
		["show_name"] = "Show Event Names",
		["show_desc"] = "Toggle showing event names in each window.",
		["allevents_name"] = "Process all events",
		["allevents_desc"] = "Enable Prat processing for all chat events.",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
   do
	   local L


  L = {}
  -- EventNames
L["allevents_desc"] = "Enable Prat processing for all chat events."
L["allevents_name"] = "Process all events"
L["Chat window event name options."] = true
L["EventNames"] = true
L["Show"] = true
L["Show events on chatframes"] = true
L["show_desc"] = "Toggle showing event names in each window."
L["show_name"] = "Show Event Names"


	 PL:AddLocale("enUS",L)



  L = {}
  -- EventNames
L["allevents_desc"] = "Activer le traitement par Prat de tous les événements de discussion."
L["allevents_name"] = "Traiter tous les événements"
L["Chat window event name options."] = "Options des évènements de la fenêtre de chat"
L["EventNames"] = "Nom des évènements"
L["Show"] = "Montrer"
L["Show events on chatframes"] = "Montrer les évènements dans le cadre du chat"
L["show_desc"] = "Activer l'affichage des noms d'évènements dans chaque fenêtre"
L["show_name"] = "Montrer les noms d'évènements"


	 PL:AddLocale("frFR",L)



  L = {}
  -- EventNames
L["allevents_desc"] = "Prat-Verarbeitung für alle Chat-Ereignisse aktivieren."
L["allevents_name"] = "Alle Ereignisse verarbeiten"
L["Chat window event name options."] = "Optionen für den Namen des Chat-Fensterereignisses."
L["EventNames"] = "Ereignisnamen"
L["Show"] = "Anzeigen"
L["Show events on chatframes"] = "Ereignisse in Chatfenstern anzeigen"
L["show_desc"] = "Anzeige der Ereignisnamen in jedem Fenster ein- und ausschalten"
L["show_name"] = "Ereignisnamen anzeigen"


	 PL:AddLocale("deDE",L)



  L = {}
  -- EventNames
L["allevents_desc"] = "모든 대화 이벤트에 Prat 처리 과정을 적용시킵니다."
L["allevents_name"] = "모든 이벤트 처리"
L["Chat window event name options."] = "대화창에 이벤트 이름을 표시합니다."
L["EventNames"] = "이벤트 이름 [EventNames]"
L["Show"] = "표시"
L["Show events on chatframes"] = "대화창에 이벤트를 표시합니다."
L["show_desc"] = "각 대화창에 이벤트 이름 표시를 끄고 켭니다."
L["show_name"] = "이벤트 이름 표시"


	 PL:AddLocale("koKR",L)



  L = {}
  -- EventNames
--[[Translation missing --]]
L["allevents_desc"] = "Enable Prat processing for all chat events."
--[[Translation missing --]]
L["allevents_name"] = "Process all events"
--[[Translation missing --]]
L["Chat window event name options."] = "Chat window event name options."
--[[Translation missing --]]
L["EventNames"] = "EventNames"
--[[Translation missing --]]
L["Show"] = "Show"
--[[Translation missing --]]
L["Show events on chatframes"] = "Show events on chatframes"
--[[Translation missing --]]
L["show_desc"] = "Toggle showing event names in each window."
--[[Translation missing --]]
L["show_name"] = "Show Event Names"


	 PL:AddLocale("esMX",L)



  L = {}
  -- EventNames
L["allevents_desc"] = "Обрабатывать Prat'ом все сообщения в чате."
L["allevents_name"] = "Обрабатывать все сообщения"
L["Chat window event name options."] = "Настройки названий событий в окне чата."
L["EventNames"] = true
L["Show"] = "Отображать"
L["Show events on chatframes"] = "Отображать события в окне чата"
L["show_desc"] = "Вкл/Выкл отображение названий событий во всех окнах."
L["show_name"] = "Названия событий"


	 PL:AddLocale("ruRU",L)



  L = {}
  -- EventNames
L["allevents_desc"] = "为所有聊天事件开启Phat处理"
L["allevents_name"] = "处理所有事件"
L["Chat window event name options."] = "聊天窗口项目名称选项"
L["EventNames"] = "事件名称"
L["Show"] = "显示"
L["Show events on chatframes"] = "在聊天框显示事件"
L["show_desc"] = "显示事件名称在每个聊天窗口"
L["show_name"] = "显示事件名称"


	 PL:AddLocale("zhCN",L)



  L = {}
  -- EventNames
--[[Translation missing --]]
L["allevents_desc"] = "Enable Prat processing for all chat events."
--[[Translation missing --]]
L["allevents_name"] = "Process all events"
L["Chat window event name options."] = "Opciones de nombre de evento de la ventana del chat."
L["EventNames"] = "NombresEventos"
L["Show"] = "Mostrar"
L["Show events on chatframes"] = "Mostrar eventos en los marcos de chat"
L["show_desc"] = "Alterna el mostrar nombres de eventos en cada ventana."
L["show_name"] = "Mostrar Nombres de Eventos"


	 PL:AddLocale("esES",L)



  L = {}
  -- EventNames
--[[Translation missing --]]
L["allevents_desc"] = "Enable Prat processing for all chat events."
--[[Translation missing --]]
L["allevents_name"] = "Process all events"
L["Chat window event name options."] = "聊天視窗事件名稱選項。"
L["EventNames"] = "事件名稱"
L["Show"] = "顯示"
L["Show events on chatframes"] = "於聊天視窗顯示事件"
L["show_desc"] = "切換顯示在每個視窗事件名稱。"
L["show_name"] = "顯示事件名稱"


	 PL:AddLocale("zhTW",L)


   end
   --@end-non-debug@

	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			show = {},
			allevents = false,
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["EventNames"],
		desc = PL["Chat window event name options."],
		type = "group",
		args = {
			show = {
				name = PL["show_name"],
				desc = PL["show_desc"],
				type = "multiselect",
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			allevents = {
				name = function(info)
					return PL[info[#info] .. "_name"]
				end,
				desc = function(info)
					return PL[info[#info] .. "_desc"]
				end,
				type = "toggle"
			}
		}
	})

	function module:OnModuleEnable()
		Prat.RegisterChatEvent(self, "Prat_PreAddMessage", "Prat_PreAddMessage")
		self:SetAllEvents(self.db.profile.allevents)
	end

	function module:OnModuleDisable()
		self:SetAllEvents(false)
		Prat.UnregisterAllChatEvents(self)
	end

	function module:GetDescription()
		return PL["Chat window event name options."]
	end

	--[[------------------------------------------------
	  Core Functions
	------------------------------------------------]] --
	function module:OnValueChanged()
		self:SetAllEvents(self.db.profile.allevents)
	end

	local function allEventsEnabled()
		return Prat.EventProcessingType.Full
	end

	function module:SetAllEvents(allevents)
		if not allevents then
			Prat.EventIsProcessed = self.origEventIsProcessed or Prat.EventIsProcessed
			self.origEventIsProcessed = nil
		elseif not self.origEventIsProcessed and allevents then
			self.origEventIsProcessed = Prat.EventIsProcessed
			Prat.EventIsProcessed = allEventsEnabled
		end
	end

	do
		local CLR = Prat.CLR
		local function EventBrackets(text)
			return CLR:Colorize("ffffff", text)
		end

		local function EventName(text, c)
			return CLR:Colorize(c, text)
		end

		local desat = 192 * 0.7 + 63
		local c
		function module:Prat_PreAddMessage(_, message, frame, event, _, r, g, b)
			if self.db.profile.show[frame:GetName()] then
				c = ("%02x%02x%02x"):format((r or 1.0) * desat, (g or 1.0) * desat, (b or 1.0) * desat)
				message.POST = "  " .. EventBrackets("(") .. EventName(tostring(event), c) .. EventBrackets(")")
			end
		end
	end

	return
end) -- Prat:AddModuleToLoad
