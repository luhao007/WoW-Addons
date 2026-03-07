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
	local module = Prat:NewModule("Fading")
	local PL = module.PL

	--[==[@debug@
	PL:AddLocale("enUS", {
		["module_name"] = "Fading",
		["module_desc"] = "Chat window text fading options.",
		["textfade_name"] = "Enable Fading",
		["textfade_desc"] = "Toggle enabling text fading for each chat window.",
		["duration_name"] = "Set Fading Delay (Seconds)",
		["duration_desc"] = "Set the number of seconds to wait before before fading text of chat windows.",
	})
	--@end-debug@]==]

	-- These Localizations are auto-generated. To help with localization
	-- please go to http://www.wowace.com/projects/prat-3-0/localization/
	--@non-debug@
	do
		local L


  L = {}
  -- Fading
L["duration_desc"] = "Set the number of seconds to wait before before fading text of chat windows."
L["duration_name"] = "Set Fading Delay (Seconds)"
L["module_desc"] = "Chat window text fading options."
L["module_name"] = "Fading"
L["textfade_desc"] = "Toggle enabling text fading for each chat window."
L["textfade_name"] = "Enable Fading"


	  PL:AddLocale("enUS",L)



  L = {}
  -- Fading
L["duration_desc"] = "Définir le nombre de secondes à attendre avant la disparition du texte de la fenêtre de chat"
L["duration_name"] = "Délai avant fondu (secondes)"
L["module_desc"] = "Option des délais de disparition."
L["module_name"] = "Fondu"
L["textfade_desc"] = "Activé le fondu pour chaque fenêtre de discussions."
L["textfade_name"] = "Activé le fondu"


	  PL:AddLocale("frFR",L)



  L = {}
  -- Fading
L["duration_desc"] = "Stellt die Anzahl der Sekunden ein ehe der Text in Chatfenstern verblasst."
L["duration_name"] = "Verzögerung des Verblassens einstellen (Sekunden)"
L["module_desc"] = "Optionen zum Verblassen des Textes in Chatfenstern."
L["module_name"] = "Verblassen"
L["textfade_desc"] = "Schaltet das Verblassen des Textes jedes Chatfenster ein/aus."
L["textfade_name"] = "Verblassen einschalten"


	  PL:AddLocale("deDE",L)



  L = {}
  -- Fading
L["duration_desc"] = "대화글이 사라질 때 까지의 대기 시간을 설정합니다."
L["duration_name"] = "사라짐 대기 시간 설정 (초)"
L["module_desc"] = "대화글의 사라짐 옵션을 설정합니다."
L["module_name"] = "사라짐 [Fading]"
L["textfade_desc"] = "각 대화창 별로 대화글 사라짐 기능을 켜고 끕니다."
L["textfade_name"] = "사라짐 켜기"


	  PL:AddLocale("koKR",L)



  L = {}
  -- Fading
--[[Translation missing --]]
L["duration_desc"] = "Set the number of seconds to wait before before fading text of chat windows."
--[[Translation missing --]]
L["duration_name"] = "Set Fading Delay (Seconds)"
--[[Translation missing --]]
L["module_desc"] = "Chat window text fading options."
--[[Translation missing --]]
L["module_name"] = "Fading"
--[[Translation missing --]]
L["textfade_desc"] = "Toggle enabling text fading for each chat window."
--[[Translation missing --]]
L["textfade_name"] = "Enable Fading"


	  PL:AddLocale("esMX",L)



  L = {}
  -- Fading
L["duration_desc"] = "Задайте значение в секундах для задержки затухания текста в окне чата."
L["duration_name"] = "Задержка затухания (в секундах)"
L["module_desc"] = "Настройки затухания текста в окне чата."
L["module_name"] = "Затухание"
L["textfade_desc"] = "Вкл/Выкл затухание текста во всех окнах чата."
L["textfade_name"] = "Включить затухание"


	  PL:AddLocale("ruRU",L)



  L = {}
  -- Fading
L["duration_desc"] = "设置聊天窗口文本消隐前等待秒数"
L["duration_name"] = "设置消隐延时(秒)"
L["module_desc"] = "聊天窗口文本消隐选项"
L["module_name"] = "消隐"
L["textfade_desc"] = "为每个聊天窗口启用文本消隐"
L["textfade_name"] = "启用消隐"


	  PL:AddLocale("zhCN",L)



  L = {}
  -- Fading
L["duration_desc"] = "Establece el número de segundos a esperar antes de desvanecer el texto de la ventana de chat."
L["duration_name"] = "Establecer Retraso Desvanecer (Segundos)"
L["module_desc"] = "Opciones de desvanecer texto en ventana de chat."
L["module_name"] = "Desvanecerse"
L["textfade_desc"] = "Alterna la activación de desvanecer texto para cada ventana de chat."
L["textfade_name"] = "Activar Desvanecerse"


	  PL:AddLocale("esES",L)



  L = {}
  -- Fading
L["duration_desc"] = "設定視窗消褪秒數"
L["duration_name"] = "設定淡化延遲（秒數）"
L["module_desc"] = "聊天室窗淡化選項"
L["module_name"] = "淡化"
L["textfade_desc"] = "切換視窗文字消褪"
L["textfade_name"] = "啟用淡化"


	  PL:AddLocale("zhTW",L)


	end
	--@end-non-debug@

	-- define the default db values
	Prat:SetModuleDefaults(module.name, {
		profile = {
			on = true,
			textfade = { ["*"] = true },
			duration = 120
		}
	})

	Prat:SetModuleOptions(module.name, {
		name = PL["module_name"],
		desc = PL["module_desc"],
		type = "group",
		args = {
			textfade = {
				name = PL["textfade_name"],
				desc = PL["textfade_desc"],
				type = "multiselect",
				values = Prat.HookedFrameList,
				get = "GetSubValue",
				set = "SetSubValue"
			},
			duration = {
				name = PL["duration_name"],
				desc = PL["duration_desc"],
				type = "range",
				order = 190,
				min = 1,
				max = 240,
				step = 1,
			},
		}
	})


	--[[------------------------------------------------
		Module Event Functions
	------------------------------------------------]] --

	-- things to do when the module is enabled
	function module:OnModuleEnable()
		self:OnValueChanged()
		Prat.RegisterChatEvent(self, Prat.Events.FRAMES_UPDATED)
	end

	-- things to do when the module is disabled
	function module:OnModuleDisable()
		for _, v in pairs(Prat.HookedFrames) do
			self:Fade(v, true)
		end
	end

	function module:Prat_FramesUpdated(_, name, chatFrame)
		self:Fade(chatFrame, self.db.profile.textfade[name])
	end

	function module:OnValueChanged()
		for k, v in pairs(Prat.HookedFrames) do
			self:Fade(v, self.db.profile.textfade[k])
		end
	end

	module.OnSubValueChanged = module.OnValueChanged


	--[[------------------------------------------------
		Core Functions
	------------------------------------------------]] --

	-- enable/disable fading
	function module:Fade(cf, textfade)
		if textfade then
			cf:SetFading(true)
			cf:SetTimeVisible(module.db.profile.duration)
		else
			cf:SetFading(false)
		end
	end

	return
end) -- Prat:AddModuleToLoad
