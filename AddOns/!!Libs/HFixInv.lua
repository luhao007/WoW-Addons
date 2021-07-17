--[[
	@date 2021年4月9日22点03分
	@ver 0.7
	@author 上官晓雾
--]]
----加上IsForbidden()判断
----在切换地图(目前所知道的)的蓝条最后阶段,UNIT_INVENTORY_CHANGED事件会触发N次(某测试结果300+次),每次结果的GetTime()返回值相同
----用于hook所有的UNIT_INVENTORY_CHANGED事件，对UNIT_INVENTORY_CHANGED事件的触发频率进行控制
do 
	----过滤掉暴雪本身的调用，以避免污染
	----但是无法区分，等待报错后一个个添加
	local filter = {
		["ExRTConsumables"] = true,
		["MerchantFrame"] = true,
		["StatusTrackingBarManager"] = true,
		["ActionBarActionEventsFrame"] = true,
		["ArtifactLevelUpToast"] = true,
		["EquipmentFlyoutFrame"] = true,
		["ContainerFrame1"] = true,
		["ContainerFrame2"] = true,
		["ContainerFrame3"] = true,
		["ContainerFrame4"] = true,
		["ContainerFrame5"] = true,
		["ContainerFrame6"] = true,
		["ContainerFrame7"] = true,
		["ContainerFrame8"] = true,
		["ContainerFrame9"] = true,
		["ContainerFrame10"] = true,
		["ContainerFrame11"] = true,
		["ContainerFrame12"] = true,
		["Dispatcher"] = true,
		["RuneforgeFrame"] = true,
		["RaidFrame"] = true,
	}
	----调试开关
	UNIT_INVENTORY_CHANGED_Debug1 = true;
	UNIT_INVENTORY_CHANGED_Debug2 = false;
	local function print(...)
		if UNIT_INVENTORY_CHANGED_Debug1 then
			return _G.print(...)
		end
	end
	local function CheckFrame(frame)
		if not frame:IsForbidden() then
			if frame:IsEventRegistered("UNIT_INVENTORY_CHANGED") then
				return true
			end
		end
	end
	local function FrameGetName(frame)
		local name = frame:GetName() or frame:GetDebugName()
		return (not name or name=="") and "NoName" or name
	end
	local uframes={};
	----一个放在UNIT_INVENTORY_CHANGED事件后面的代码，检测UNIT_INVENTORY_CHANGED执行频率，超过.25秒直接跳出
	----用法: if not UNIT_INVENTORY_CHANGED_HELPER(self) then return end
	function UNIT_INVENTORY_CHANGED_HELPER(frame)
		if not uframes[frame] then
			uframes[frame] = {}
			uframes[frame].Elapsed = 0
		end
		if GetTime() - uframes[frame].Elapsed < 0.25 then 
			return 
		end
		uframes[frame].Elapsed = GetTime()
		if UNIT_INVENTORY_CHANGED_Debug2 then
			if type(frame) == "string" then
				print(frame,frame,"通过",GetTime())
			else
				print(FrameGetName(frame),frame,"通过",GetTime())
			end
		end
		return true
	end

	----hook frame的指定event
	 frame_handlers = {}
	local function EventHandler(self, event, ...)
		if event == 'UNIT_INVENTORY_CHANGED' then
			if not UNIT_INVENTORY_CHANGED_HELPER(self) then return end
		end
		frame_handlers[self](self, event, ...)
	end
	local function CheckFilter(frame)
		local name = frame:GetName();
		if not name or name=="" then
			name = frame:GetDebugName()
		end
		if not name or name=="" then return end
		if filter[name] then return true end
		if name then
			local t = {strsplit('.',name)};
			for i,v in pairs(t) do
				if filter[v] then
					filter[name] = true
					print("S,newFilter",name)
					return true
				end
			end
		end
	end
	local function HookFrame(frame)
		if CheckFilter(frame) then return end
		local handler = frame:GetScript('OnEvent');
		if handler == EventHandler then return end
		if handler ~= frame_handlers[frame] then
			frame_handlers[frame] = handler;
		end
		if frame_handlers[frame] then
			frame.IsSetEventHandler = true;
			print("[HookFrame]已Hook ".. FrameGetName(frame))
			frame:SetScript('OnEvent', EventHandler)
		end
		return true
	end
	local function HookFrames(...)
		for i = 1 ,select('#', ...) do
			local frame = select(i, ...)
			if HookFrame(frame) then
				print("[HookFrames]已Hook ".. FrameGetName(frame))
			end
		end
	end

	----hook SetScript和HookScript，只要出现OnEvent,就hook该frame的event
	local function Hook_metafunc_SetScript(self,script)
		if script == "OnEvent" then
			if CheckFrame(self) then
				HookFrame(self);
			end
		end
	end
	local function Hook_metafunc_HookScript(self,script,newhookfunc)
		if script == "OnEvent" then
			if CheckFrame(self) then
				if self.IsSetEventHandler then
					----这个状态下self:GetScript('OnEvent') = function(...)
					----	EventHandler(...)
					----	newhookfunc(...)
					----end
					----其中EventHandler(...)是上一次HookFrame添加的，所以需要处理掉
					local oldfunc = frame_handlers[self];	--以前的Script
					self:SetScript('OnEvent',function(...)
						oldfunc(...)		--以前的Script
						newhookfunc(...)		--最新hook的Script
					end)
				else
					HookFrame(self);
				end
			end
		end
	end
	local function Hook_metafunc_Events(self,event,unit)
		if CheckFrame(self) then
			HookFrame(self)
		end
	end	
	local function Hook_metafunc_Events1(self,event,unit)
		if CheckFrame(self) then
			-- print(self:GetName(),self:GetDebugName())
			HookFrame(self)
		end
	end
	local f=CreateFrame("frame");
	local __t = getmetatable(f);
	----hook后续所有SetScript/HookScript操作的frame
	hooksecurefunc(__t.__index,"SetScript",Hook_metafunc_SetScript)
	hooksecurefunc(__t.__index,"HookScript",Hook_metafunc_HookScript)
	----hook后续所有Events操作的frame
	hooksecurefunc(__t.__index,"RegisterAllEvents",Hook_metafunc_Events)
	hooksecurefunc(__t.__index,"RegisterEvent",Hook_metafunc_Events)
	hooksecurefunc(__t.__index,"RegisterUnitEvent",Hook_metafunc_Events1)
	-- hooksecurefunc(__t.__index,"UnregisterEvent",Hook_metafunc_Events)
	-- hooksecurefunc(__t.__index,"UnregisterAllEvents",Hook_metafunc_Events)
	
	----初始化，hook所有已经注册UNIT_INVENTORY_CHANGED事件的frame
	----本插件已!开头,优先加载,可以不需要初始化(在这之前的都是暴雪UI,或者某些特殊插件/插件合集)
	-- HookFrames(GetFramesRegisteredForEvent('UNIT_INVENTORY_CHANGED'))
	
end
