-- Nyx Textures Library
-- by Vildiesel EU - Well of Eternity


if NyxTL and NyxTL.v[NyxTLmajor] and NyxTL.v[NyxTLmajor].minor >= NyxTLminor then
 NyxTLPass = true -- let the other scripts know that we don't need them
 return
elseif NyxTL then
 NyxTL.v[NyxTLmajor] = { minor = NyxTLminor }
else
 NyxTL = { v = { [NyxTLmajor] = { minor = NyxTLminor } } }

 setmetatable(NyxTL, { 
                        __tostring = function(self)
                                      local s = "|cff00FF00"
                                      for k in pairs(self.v) do
									   s = s..k.." "
									  end
									  return s:sub(1, #s - 1).."|r"
                                     end,

                        __call     = function(self, s)
						              if s == nil then
									   local latest = ""
									   local result
									   for k,v in pairs(self.v) do
									    if k > latest then 
										 latest = k
										 result = v 
										end
									   end
									   return result
									  end

                                      assert(self.v[s], "NyxTL Version '"..s.."' does not exist (available versions: "..tostring(self)..")")
                                      return self.v[s]
                                 	 end })
end

--[[
    lists:
     icons
]]

local _G, lower = _G, string.lower
local ntl = NyxTL(NyxTLmajor)

local lists = {}

function ntl:GetList(l)
 if not l then return end
 
 if lists[l] then return lists[l] end
 
 local t = _G["NyxTL_"..l]
 
 if type(t) == "string" then
  RunScript(t)
  t = _G["NyxTL_"..l]
 end
 
 lists[l] = t
 return t
end

function ntl:FilterList(l, filter, cache)
 local t = ntl:GetList(l)
 
 if not filter or filter == "" then return t end

 if not cache then
  cache = {}
 else
  wipe(cache)
 end
 
 for k,v in pairs(t) do
  if v:find(lower(filter)) then
   cache[#cache + 1] = v
  end
 end
 return cache
end





