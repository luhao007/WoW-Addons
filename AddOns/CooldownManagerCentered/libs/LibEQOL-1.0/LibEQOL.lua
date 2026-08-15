-- Private LibEQOL module namespace. Concrete modules are loaded directly by the
-- addon TOC and attach themselves here; nothing is registered through LibStub.
local _, ns = ...

ns.LibEQOL = ns.LibEQOL or {}

function ns.LibEQOL:GetModule(name)
    return self[name]
end
