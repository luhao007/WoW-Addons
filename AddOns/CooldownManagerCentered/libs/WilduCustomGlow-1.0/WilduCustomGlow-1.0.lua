--[[
This library contains work of Hendrick "nevcairiel" Leppkes
https://www.wowace.com/projects/libbuttonglow-1-0
]]

--[[
This is fork of LibCustomGlow 
MIT License

Copyright (c) 2022 Benjamin Staneck

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

local MAJOR_VERSION = "WilduCustomGlow-1.0" -- fork of LibCustomGlow-1.0
local MINOR_VERSION = 28
if not LibStub then
    error(MAJOR_VERSION .. " requires LibStub.")
end
local lib, oldversion = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then
    return
end
local Masque = LibStub("Masque", true)

local isRetail = WOW_PROJECT_ID == WOW_PROJECT_MAINLINE
local textureList = {
    empty = [[Interface\AdventureMap\BrokenIsles\AM_29]],
    white = [[Interface\BUTTONS\WHITE8X8]],
    shine = [[Interface\ItemSocketingFrame\UI-ItemSockets]],
}

local shineCoords = { 0.3984375, 0.4453125, 0.40234375, 0.44921875 }
if isRetail then
    textureList.shine = [[Interface\Artifacts\Artifacts]]
    shineCoords = { 0.8115234375, 0.9169921875, 0.8798828125, 0.9853515625 }
end

function lib.RegisterTextures(texture, id)
    textureList[id] = texture
end

lib.glowList = {}
lib.startList = {}
lib.stopList = {}

local GlowParent = UIParent
local GlowMaskPool = {
    createFunc = function(self)
        return self.parent:CreateMaskTexture()
    end,
    resetFunc = function(self, mask)
        mask:Hide()
        mask:ClearAllPoints()
    end,
    AddObject = function(self, object)
        local dummy = true
        self.activeObjects[object] = dummy
        self.activeObjectCount = self.activeObjectCount + 1
    end,
    ReclaimObject = function(self, object)
        tinsert(self.inactiveObjects, object)
        self.activeObjects[object] = nil
        self.activeObjectCount = self.activeObjectCount - 1
    end,
    Release = function(self, object)
        local active = self.activeObjects[object] ~= nil
        if active then
            self:resetFunc(object)
            self:ReclaimObject(object)
        end
        return active
    end,
    Acquire = function(self)
        local object = tremove(self.inactiveObjects)
        local new = object == nil
        if new then
            object = self:createFunc()
            self:resetFunc(object, new)
        end
        self:AddObject(object)
        return object, new
    end,
    Init = function(self, parent)
        self.activeObjects = {}
        self.inactiveObjects = {}
        self.activeObjectCount = 0
        self.parent = parent
    end,
}
GlowMaskPool:Init(GlowParent)

local TexPoolResetter = function(pool, tex)
    local maskNum = tex:GetNumMaskTextures()
    for i = maskNum, 1, -1 do
        tex:RemoveMaskTexture(tex:GetMaskTexture(i))
    end
    tex:Hide()
    tex:ClearAllPoints()
end
local GlowTexPool = CreateTexturePool(GlowParent, "ARTWORK", 7, nil, TexPoolResetter)
lib.GlowTexPool = GlowTexPool

local FramePoolResetter = function(framePool, frame)
    frame:SetScript("OnUpdate", nil)
    local parent = frame:GetParent()
    if parent[frame.name] then
        parent[frame.name] = nil
    end
    if frame.textures then
        for _, texture in pairs(frame.textures) do
            GlowTexPool:Release(texture)
        end
    end
    if frame.bg then
        GlowTexPool:Release(frame.bg)
        frame.bg = nil
    end
    if frame.masks then
        for _, mask in pairs(frame.masks) do
            GlowMaskPool:Release(mask)
        end
        frame.masks = nil
    end
    frame.textures = {}
    frame.info = {}
    frame.name = nil
    frame.timer = nil
    frame:Hide()
    frame:ClearAllPoints()
end
local GlowFramePool = CreateFramePool("Frame", GlowParent, nil, FramePoolResetter)
lib.GlowFramePool = GlowFramePool

local function ResolveHostSize(r)
    local width, height = r._width, r._height
    if width and height then
        return width, height
    end
    width, height = r:GetSize()
    if issecretvalue(width) then
        return 0, 0
    end
    r._width, r._height = width, height
    return width, height
end

local function addFrameAndTex(r, color, name, key, N, xOffset, yOffset, texture, texCoord, desaturated, frameLevel)
    key = key or ""
    frameLevel = frameLevel or 8
    if not r[name .. key] then
        r[name .. key] = GlowFramePool:Acquire()
        r[name .. key]:SetParent(r)
        r[name .. key].name = name .. key
    end
    local f = r[name .. key]
    f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
    f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset + 0.05, yOffset + 0.05)
    f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset + 0.05)
    f:Show()

    if not f.textures then
        f.textures = {}
    end

    for i = 1, N do
        if not f.textures[i] then
            f.textures[i] = GlowTexPool:Acquire()
            f.textures[i]:SetTexture(texture)
            f.textures[i]:SetTexCoord(texCoord[1], texCoord[2], texCoord[3], texCoord[4])
            f.textures[i]:SetDesaturated(desaturated)
            f.textures[i]:SetParent(f)
            f.textures[i]:SetDrawLayer("ARTWORK", 7)
            if not isRetail and name == "_AutoCastGlow" then
                f.textures[i]:SetBlendMode("ADD")
            end
        end
        if type(color) == "table" and color.GetRGBA then
            f.textures[i]:SetVertexColor(color:GetRGBA())
        else
            f.textures[i]:SetVertexColor(color[1], color[2], color[3], color[4])
        end
        f.textures[i]:Show()
    end
    while #f.textures > N do
        GlowTexPool:Release(f.textures[#f.textures])
        table.remove(f.textures)
    end
end

--Pixel Glow Functions--
local pCalc1 = function(progress, s, th, p)
    local c
    if progress > p[3] or progress < p[0] then
        c = 0
    elseif progress > p[2] then
        c = s - th - (progress - p[2]) / (p[3] - p[2]) * (s - th)
    elseif progress > p[1] then
        c = s - th
    else
        c = (progress - p[0]) / (p[1] - p[0]) * (s - th)
    end
    return math.floor(c + 0.5)
end

local pCalc2 = function(progress, s, th, p)
    local c
    if progress > p[3] then
        c = s - th - (progress - p[3]) / (p[0] + 1 - p[3]) * (s - th)
    elseif progress > p[2] then
        c = s - th
    elseif progress > p[1] then
        c = (progress - p[1]) / (p[2] - p[1]) * (s - th)
    elseif progress > p[0] then
        c = 0
    else
        c = s - th - (progress + 1 - p[3]) / (p[0] + 1 - p[3]) * (s - th)
    end
    return math.floor(c + 0.5)
end

local pUpdate = function(self, elapsed)
    self.timer = self.timer + elapsed / self.info.period
    if self.timer > 1 or self.timer < -1 then
        self.timer = self.timer % 1
    end
    local progress = self.timer
    local width, height = self._width, self._height
    if width and (width ~= self.info.width or height ~= self.info.height) then
        local perimeter = 2 * (width + height)
        if not (perimeter > 0) then
            return
        end
        self.info.width = width
        self.info.height = height
        self.info.pTLx = {
            [0] = (height + self.info.length / 2) / perimeter,
            [1] = (height + width + self.info.length / 2) / perimeter,
            [2] = (2 * height + width - self.info.length / 2) / perimeter,
            [3] = 1 - self.info.length / 2 / perimeter,
        }
        self.info.pTLy = {
            [0] = (height - self.info.length / 2) / perimeter,
            [1] = (height + width + self.info.length / 2) / perimeter,
            [2] = (height * 2 + width + self.info.length / 2) / perimeter,
            [3] = 1 - self.info.length / 2 / perimeter,
        }
        self.info.pBRx = {
            [0] = self.info.length / 2 / perimeter,
            [1] = (height - self.info.length / 2) / perimeter,
            [2] = (height + width - self.info.length / 2) / perimeter,
            [3] = (height * 2 + width + self.info.length / 2) / perimeter,
        }
        self.info.pBRy = {
            [0] = self.info.length / 2 / perimeter,
            [1] = (height + self.info.length / 2) / perimeter,
            [2] = (height + width - self.info.length / 2) / perimeter,
            [3] = (height * 2 + width - self.info.length / 2) / perimeter,
        }
    end
    if width and self:IsShown() then
        if not (self.masks[1]:IsShown()) then
            self.masks[1]:Show()
            self.masks[1]:SetPoint("TOPLEFT", self, "TOPLEFT", self.info.th, -self.info.th)
            self.masks[1]:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -self.info.th, self.info.th)
        end
        if self.masks[2] and not (self.masks[2]:IsShown()) then
            self.masks[2]:Show()
            self.masks[2]:SetPoint("TOPLEFT", self, "TOPLEFT", self.info.th + 1, -self.info.th - 1)
            self.masks[2]:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -self.info.th - 1, self.info.th + 1)
        end
        if self.bg and not (self.bg:IsShown()) then
            self.bg:Show()
        end
        for k, line in pairs(self.textures) do
            line:SetPoint(
                "TOPLEFT",
                self,
                "TOPLEFT",
                pCalc1((progress + self.info.step * (k - 1)) % 1, width, self.info.th, self.info.pTLx),
                -pCalc2((progress + self.info.step * (k - 1)) % 1, height, self.info.th, self.info.pTLy)
            )
            line:SetPoint(
                "BOTTOMRIGHT",
                self,
                "TOPLEFT",
                self.info.th + pCalc2((progress + self.info.step * (k - 1)) % 1, width, self.info.th, self.info.pBRx),
                -height + pCalc1((progress + self.info.step * (k - 1)) % 1, height, self.info.th, self.info.pBRy)
            )
        end
    end
end

local pUpdatePoly = function(self, elapsed)
    self.timer = self.timer + elapsed / self.info.period
    if self.timer > 1 or self.timer < -1 then
        self.timer = self.timer % 1
    end
    local progress = self.timer
    local width, height = self._width, self._height
    if width and (width ~= self.info.width or height ~= self.info.height) then
        if not (width > 0 and height > 0) then
            return
        end
        self.info.width = width
        self.info.height = height
        local verts = self.info.vertices
        local n = #verts
        local edges = {}
        local total = 0
        for i = 1, n do
            local a = verts[i]
            local b = verts[(i % n) + 1]
            local ax, ay = a.x * width, a.y * height
            local dx, dy = (b.x - a.x) * width, (b.y - a.y) * height
            local len = math.sqrt(dx * dx + dy * dy)
            edges[i] = { ax = ax, ay = ay, dx = dx, dy = dy, len = len, angle = math.atan2(-dy, dx) }
            total = total + len
        end
        self.info.edges = edges
        self.info.total = total
    end
    if not self:IsShown() then
        return
    end
    local edges = self.info.edges
    local total = self.info.total
    if not (total and total > 0) then
        return
    end
    local length = self.info.length
    local th = self.info.th
    for k, line in pairs(self.textures) do
        local target = ((progress + self.info.step * (k - 1)) % 1) * total
        local acc = 0
        local px, py, angle = edges[1].ax, edges[1].ay, edges[1].angle
        for i = 1, #edges do
            local e = edges[i]
            if acc + e.len >= target then
                local f = e.len > 0 and (target - acc) / e.len or 0
                px = e.ax + e.dx * f
                py = e.ay + e.dy * f
                angle = e.angle
                break
            end
            acc = acc + e.len
        end
        line:ClearAllPoints()
        line:SetSize(length, th)
        line:SetRotation(angle)
        line:SetPoint("CENTER", self, "TOPLEFT", px, -py)
    end
end

function lib.PixelGlow_Start(r, color, N, frequency, length, th, xOffset, yOffset, border, key, frameLevel, vertices)
    if not r then
        return
    end
    if not color then
        color = { 1, 210 / 255, 0, 1 }
    end

    if not (N and N > 0) then
        N = 8
    end

    local period
    if frequency then
        if not (frequency > 0 or frequency < 0) then
            period = 4
        else
            period = 1 / frequency
        end
    else
        period = 4
    end
    local width, height = ResolveHostSize(r)
    if not length then
        if width then
            if vertices then
                length = math.floor(min(width, height) * 0.2)
            else
                length = math.floor((width + height) * (2 / N - 0.1))
                length = min(length, min(width, height))
            end
        else
            length = 4
        end
    end
    th = th or 1
    xOffset = xOffset or 0
    yOffset = yOffset or 0
    key = key or ""

    addFrameAndTex(r, color, "_PixelGlow", key, N, xOffset, yOffset, textureList.white, { 0, 1, 0, 1 }, nil, frameLevel)
    local f = r["_PixelGlow" .. key]
    f._width, f._height = width, height

    if vertices then
        if f.masks then
            if f.masks[1] then
                for _, tex in pairs(f.textures) do
                    tex:RemoveMaskTexture(f.masks[1])
                end
                GlowMaskPool:Release(f.masks[1])
                f.masks[1] = nil
            end
            if f.masks[2] then
                GlowMaskPool:Release(f.masks[2])
                f.masks[2] = nil
            end
        end
        if f.bg then
            GlowTexPool:Release(f.bg)
            f.bg = nil
        end
        f.timer = f.timer or 0
        f.info = f.info or {}
        f.info.step = 1 / N
        f.info.period = period
        f.info.th = th
        f.info.length = length
        f.info.vertices = vertices
        f.info.width = nil
        pUpdatePoly(f, 0)
        f:SetScript("OnUpdate", pUpdatePoly)
        return
    end
    if not f.masks then
        f.masks = {}
    end
    if not f.masks[1] then
        f.masks[1] = GlowMaskPool:Acquire()
        f.masks[1]:SetTexture(textureList.empty, "CLAMPTOWHITE", "CLAMPTOWHITE")
        f.masks[1]:Show()
    end
    f.masks[1]:SetPoint("TOPLEFT", f, "TOPLEFT", th, -th)
    f.masks[1]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -th, th)

    if not (border == false) then
        if not f.masks[2] then
            f.masks[2] = GlowMaskPool:Acquire()
            f.masks[2]:SetTexture(textureList.empty, "CLAMPTOWHITE", "CLAMPTOWHITE")
        end
        f.masks[2]:SetPoint("TOPLEFT", f, "TOPLEFT", th + 1, -th - 1)
        f.masks[2]:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -th - 1, th + 1)

        if not f.bg then
            f.bg = GlowTexPool:Acquire()
            f.bg:SetColorTexture(0.1, 0.1, 0.1, 0.8)
            f.bg:SetParent(f)
            f.bg:SetAllPoints(f)
            f.bg:SetDrawLayer("ARTWORK", 6)
            f.bg:AddMaskTexture(f.masks[2])
        end
    else
        if f.bg then
            GlowTexPool:Release(f.bg)
            f.bg = nil
        end
        if f.masks[2] then
            GlowMaskPool:Release(f.masks[2])
            f.masks[2] = nil
        end
    end
    for _, tex in pairs(f.textures) do
        tex:SetRotation(0)
        if tex:GetNumMaskTextures() < 1 then
            tex:AddMaskTexture(f.masks[1])
        end
    end
    f.timer = f.timer or 0
    f.info = f.info or {}
    f.info.step = 1 / N
    f.info.period = period
    f.info.th = th
    f.info.vertices = nil
    if f.info.length ~= length then
        f.info.width = nil
        f.info.length = length
    end
    pUpdate(f, 0)
    f:SetScript("OnUpdate", pUpdate)
end

function lib.PixelGlow_Stop(r, key)
    if not r then
        return
    end
    key = key or ""
    if not r["_PixelGlow" .. key] then
        return false
    else
        GlowFramePool:Release(r["_PixelGlow" .. key])
    end
end

table.insert(lib.glowList, "Pixel Glow")
lib.startList["Pixel Glow"] = lib.PixelGlow_Start
lib.stopList["Pixel Glow"] = lib.PixelGlow_Stop

--Autocast Glow Functions--
local function acUpdate(self, elapsed)
    local width, height = self._width, self._height
    if width and (width ~= self.info.width or height ~= self.info.height) then
        if width * height == 0 then
            return
        end
        self.info.width = width
        self.info.height = height
        self.info.perimeter = 2 * (width + height)
        self.info.bottomlim = height * 2 + width
        self.info.rightlim = height + width
        self.info.space = self.info.perimeter / self.info.N
    end

    if not self.info.perimeter then
        return
    end

    local texIndex = 0
    for k = 1, 4 do
        self.timer[k] = self.timer[k] + elapsed / (self.info.period * k)
        if self.timer[k] > 1 or self.timer[k] < -1 then
            self.timer[k] = self.timer[k] % 1
        end
        for i = 1, self.info.N do
            texIndex = texIndex + 1
            local position = (self.info.space * i + self.info.perimeter * self.timer[k]) % self.info.perimeter
            if position > self.info.bottomlim then
                self.textures[texIndex]:SetPoint("CENTER", self, "BOTTOMRIGHT", -position + self.info.bottomlim, 0)
            elseif position > self.info.rightlim then
                self.textures[texIndex]:SetPoint("CENTER", self, "TOPRIGHT", 0, -position + self.info.rightlim)
            elseif position > self.info.height then
                self.textures[texIndex]:SetPoint("CENTER", self, "TOPLEFT", position - self.info.height, 0)
            else
                self.textures[texIndex]:SetPoint("CENTER", self, "BOTTOMLEFT", 0, position)
            end
        end
    end
end

local function acUpdatePoly(self, elapsed)
    local width, height = self._width, self._height
    if width and (width ~= self.info.width or height ~= self.info.height) then
        if width * height == 0 then
            return
        end
        self.info.width = width
        self.info.height = height
        local verts = self.info.vertices
        local n = #verts
        local edges = {}
        local total = 0
        for i = 1, n do
            local a = verts[i]
            local b = verts[(i % n) + 1]
            local ax, ay = a.x * width, a.y * height
            local dx, dy = (b.x - a.x) * width, (b.y - a.y) * height
            local len = math.sqrt(dx * dx + dy * dy)
            edges[i] = { ax = ax, ay = ay, dx = dx, dy = dy, len = len }
            total = total + len
        end
        self.info.edges = edges
        self.info.total = total
    end
    local edges = self.info.edges
    local total = self.info.total
    if not (total and total > 0) then
        return
    end
    local N = self.info.N
    local texIndex = 0
    for k = 1, 4 do
        self.timer[k] = self.timer[k] + elapsed / (self.info.period * k)
        if self.timer[k] > 1 or self.timer[k] < -1 then
            self.timer[k] = self.timer[k] % 1
        end
        for i = 1, N do
            texIndex = texIndex + 1
            local target = (((i / N) + self.timer[k]) % 1) * total
            local acc = 0
            local px, py = edges[1].ax, edges[1].ay
            for e = 1, #edges do
                local ed = edges[e]
                if acc + ed.len >= target then
                    local f = ed.len > 0 and (target - acc) / ed.len or 0
                    px = ed.ax + ed.dx * f
                    py = ed.ay + ed.dy * f
                    break
                end
                acc = acc + ed.len
            end
            self.textures[texIndex]:SetPoint("CENTER", self, "TOPLEFT", px, -py)
        end
    end
end

function lib.AutoCastGlow_Start(r, color, N, frequency, scale, xOffset, yOffset, key, frameLevel, vertices)
    if not r then
        return
    end

    if not color then
        color = { 1, 210 / 255, 0, 1 }
    end

    if not (N and N > 0) then
        N = 4
    end

    local period
    if frequency then
        if not (frequency > 0 or frequency < 0) then
            period = 8
        else
            period = 1 / frequency
        end
    else
        period = 8
    end
    scale = scale or 1
    xOffset = xOffset or 0
    yOffset = yOffset or 0
    key = key or ""

    addFrameAndTex(
        r,
        color,
        "_AutoCastGlow",
        key,
        N * 4,
        xOffset,
        yOffset,
        textureList.shine,
        shineCoords,
        true,
        frameLevel
    )
    local f = r["_AutoCastGlow" .. key]
    f._width, f._height = ResolveHostSize(r)
    local sizes = { 7, 6, 5, 4 }
    for k, size in pairs(sizes) do
        for i = 1, N do
            f.textures[i + N * (k - 1)]:SetSize(size * scale, size * scale)
        end
    end
    f.timer = f.timer or { 0, 0, 0, 0 }
    f.info = f.info or {}
    f.info.N = N
    f.info.period = period
    f.info.vertices = vertices
    f.info.width = nil
    if vertices then
        f:SetScript("OnUpdate", acUpdatePoly)
        acUpdatePoly(f, 0)
    else
        f:SetScript("OnUpdate", acUpdate)
        acUpdate(f, 0)
    end
end

function lib.AutoCastGlow_Stop(r, key)
    if not r then
        return
    end

    key = key or ""
    if not r["_AutoCastGlow" .. key] then
        return false
    else
        GlowFramePool:Release(r["_AutoCastGlow" .. key])
    end
end

table.insert(lib.glowList, "Autocast Shine")
lib.startList["Autocast Shine"] = lib.AutoCastGlow_Start
lib.stopList["Autocast Shine"] = lib.AutoCastGlow_Stop

-- ProcGlow

local function ProcGlowResetter(framePool, frame)
    frame:Hide()
    frame:ClearAllPoints()
    frame:SetScript("OnShow", nil)
    frame:SetScript("OnHide", nil)
    local parent = frame:GetParent()
    if frame.key and parent and parent[frame.key] then
        parent[frame.key] = nil
    end
end

local ProcGlowPool = CreateFramePool("Frame", GlowParent, nil, ProcGlowResetter)
lib.ProcGlowPool = ProcGlowPool

local function InitProcGlow(f)
    f.ProcStart = f:CreateTexture(nil, "ARTWORK")
    f.ProcStart:SetBlendMode("ADD")
    f.ProcStart:SetAtlas("UI-HUD-ActionBar-Proc-Start-Flipbook")
    f.ProcStart:SetAlpha(1)
    f.ProcStart:SetSize(150, 150)
    f.ProcStart:SetPoint("CENTER")

    f.ProcLoop = f:CreateTexture(nil, "ARTWORK")
    f.ProcLoop:SetAtlas("UI-HUD-ActionBar-Proc-Loop-Flipbook")
    f.ProcLoop:SetAlpha(0)
    f.ProcLoop:SetAllPoints()

    f.ProcLoopAnim = f:CreateAnimationGroup()
    f.ProcLoopAnim:SetLooping("REPEAT")
    f.ProcLoopAnim:SetToFinalAlpha(true)

    local alphaRepeat = f.ProcLoopAnim:CreateAnimation("Alpha")
    alphaRepeat:SetChildKey("ProcLoop")
    alphaRepeat:SetFromAlpha(1)
    alphaRepeat:SetToAlpha(1)
    alphaRepeat:SetDuration(0.001)
    alphaRepeat:SetOrder(0)
    f.ProcLoopAnim.alphaRepeat = alphaRepeat

    local flipbookRepeat = f.ProcLoopAnim:CreateAnimation("FlipBook")
    flipbookRepeat:SetChildKey("ProcLoop")
    flipbookRepeat:SetDuration(1)
    flipbookRepeat:SetOrder(0)
    flipbookRepeat:SetFlipBookRows(6)
    flipbookRepeat:SetFlipBookColumns(5)
    flipbookRepeat:SetFlipBookFrames(30)
    flipbookRepeat:SetFlipBookFrameWidth(0)
    flipbookRepeat:SetFlipBookFrameHeight(0)
    f.ProcLoopAnim.flipbookRepeat = flipbookRepeat

    f.ProcStartAnim = f:CreateAnimationGroup()
    f.ProcStartAnim:SetToFinalAlpha(true)

    local flipbookStartAlphaIn = f.ProcStartAnim:CreateAnimation("Alpha")
    flipbookStartAlphaIn:SetChildKey("ProcStart")
    flipbookStartAlphaIn:SetDuration(0.001)
    flipbookStartAlphaIn:SetOrder(0)
    flipbookStartAlphaIn:SetFromAlpha(1)
    flipbookStartAlphaIn:SetToAlpha(1)

    local flipbookStart = f.ProcStartAnim:CreateAnimation("FlipBook")
    flipbookStart:SetChildKey("ProcStart")
    flipbookStart:SetDuration(0.7)
    flipbookStart:SetOrder(1)
    flipbookStart:SetFlipBookRows(6)
    flipbookStart:SetFlipBookColumns(5)
    flipbookStart:SetFlipBookFrames(30)
    flipbookStart:SetFlipBookFrameWidth(0)
    flipbookStart:SetFlipBookFrameHeight(0)

    local flipbookStartAlphaOut = f.ProcStartAnim:CreateAnimation("Alpha")
    flipbookStartAlphaOut:SetChildKey("ProcStart")
    flipbookStartAlphaOut:SetDuration(0.001)
    flipbookStartAlphaOut:SetOrder(2)
    flipbookStartAlphaOut:SetFromAlpha(1)
    flipbookStartAlphaOut:SetToAlpha(0)

    f.ProcStartAnim.flipbookStart = flipbookStart
    f.ProcStartAnim:SetScript("OnFinished", function(self)
        self:GetParent().ProcLoopAnim:Play()
        self:GetParent().ProcLoop:Show()
    end)
end

local function SetupProcGlow(f, options)
    f.key = "_ProcGlow" .. options.key
    f:SetScript("OnHide", function(self)
        if self.ProcStartAnim:IsPlaying() then
            self.ProcStartAnim:Stop()
        end
        if self.ProcLoopAnim:IsPlaying() then
            self.ProcLoopAnim:Stop()
        end
    end)
    f:SetScript("OnShow", function(self)
        if self.startAnim then
            if not self.ProcStartAnim:IsPlaying() and not self.ProcLoopAnim:IsPlaying() then
                local width, height = self._width, self._height
                if width and width > 0 then
                    self.ProcStart:SetSize(width / 42 * 150, height / 42 * 150)
                end
                self.ProcStart:Show()
                self.ProcLoop:Hide()
                self.ProcStartAnim:Play()
            end
        else
            if not self.ProcLoopAnim:IsPlaying() then
                self.ProcStart:Hide()
                self.ProcLoop:Show()
                self.ProcLoopAnim:Play()
            end
        end
    end)
    if not options.color then
        f.ProcStart:SetDesaturated(nil)
        f.ProcStart:SetVertexColor(1, 1, 1, 1)
        f.ProcLoop:SetDesaturated(nil)
        f.ProcLoop:SetVertexColor(1, 1, 1, 1)
    else
        f.ProcStart:SetDesaturated(1)
        f.ProcStart:SetVertexColor(options.color[1], options.color[2], options.color[3], options.color[4])
        f.ProcLoop:SetDesaturated(1)
        f.ProcLoop:SetVertexColor(options.color[1], options.color[2], options.color[3], options.color[4])
    end
    f.ProcLoopAnim.flipbookRepeat:SetDuration(options.duration)
    f.startAnim = options.startAnim
end

local ProcGlowDefaults = {
    frameLevel = 8,
    color = nil,
    startAnim = true,
    xOffset = 0,
    yOffset = 0,
    duration = 1,
    key = "",
}

function lib.ProcGlow_Start(r, options)
    if not r then
        return
    end
    options = options or {}
    setmetatable(options, { __index = ProcGlowDefaults })
    local key = "_ProcGlow" .. options.key
    local f, new
    if r[key] then
        f = r[key]
    else
        f, new = ProcGlowPool:Acquire()
        if new then
            InitProcGlow(f)
        end
        r[key] = f
    end
    f:SetParent(r)
    f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)

    local width, height = ResolveHostSize(r)
    f._width, f._height = width, height
    local xOffset = options.xOffset + width * 0.2
    local yOffset = options.yOffset + height * 0.2
    f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset, yOffset)
    f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset)

    SetupProcGlow(f, options)
    f:Show()
end

function lib.ProcGlow_Stop(r, key)
    if not r then
        return
    end
    key = key or ""
    local f = r["_ProcGlow" .. key]
    if f then
        ProcGlowPool:Release(f)
    end
end

table.insert(lib.glowList, "Proc Glow")
lib.startList["Proc Glow"] = lib.ProcGlow_Start
lib.stopList["Proc Glow"] = lib.ProcGlow_Stop

-- Ants Glow
local function AntsGlowResetter(framePool, frame)
    frame:Hide()
    frame:ClearAllPoints()
    frame:SetScript("OnShow", nil)
    frame:SetScript("OnHide", nil)
    local parent = frame:GetParent()
    if frame.key and parent and parent[frame.key] then
        parent[frame.key] = nil
    end
end

local AntsGlowPool = CreateFramePool("Frame", GlowParent, nil, AntsGlowResetter)
lib.AntsGlowPool = AntsGlowPool

local ANTS_MAX_TEXTURES = 4

local function InitAntsGlow(f)
    f.AntsAnim = f:CreateAnimationGroup()
    f.AntsAnim:SetLooping("REPEAT")
    f.AntsAnim:SetToFinalAlpha(true)

    f.antsTextures = {}
    f.antsFlips = {}
    for i = 1, ANTS_MAX_TEXTURES do
        local childKey = "Ants" .. (i == 1 and "" or i)
        local tex = f:CreateTexture(nil, "OVERLAY")
        -- tex:SetBlendMode("ADD")
        tex:SetAllPoints()
        f[childKey] = tex
        f.antsTextures[i] = tex

        local alpha = f.AntsAnim:CreateAnimation("Alpha")
        alpha:SetChildKey(childKey)
        alpha:SetFromAlpha(1)
        alpha:SetToAlpha(1)
        alpha:SetDuration(0.001)
        alpha:SetOrder(0)

        local flip = f.AntsAnim:CreateAnimation("FlipBook")
        flip:SetChildKey(childKey)
        flip:SetOrder(0)
        flip:SetFlipBookFrameWidth(0)
        flip:SetFlipBookFrameHeight(0)
        f.antsFlips[i] = flip
    end
    f.Ants = f.antsTextures[1]
    f.AntsAnim.flip = f.antsFlips[1]
end

local function SetupAntsGlow(f, options)
    f.key = "_AntsGlow" .. options.key

    local count = options.count or 1
    if count < 1 then
        count = 1
    elseif count > ANTS_MAX_TEXTURES then
        count = ANTS_MAX_TEXTURES
    end

    for i = 1, ANTS_MAX_TEXTURES do
        local tex = f.antsTextures[i]
        local flip = f.antsFlips[i]
        if i <= count then
            if options.texture then
                tex:SetTexture(options.texture)
                if options.texCoords then
                    tex:SetTexCoord(
                        options.texCoords[1],
                        options.texCoords[2],
                        options.texCoords[3],
                        options.texCoords[4]
                    )
                end
                flip:SetFlipBookFrameWidth(options.frameWidth or 0)
                flip:SetFlipBookFrameHeight(options.frameHeight or 0)
            else
                tex:SetTexCoord(0, 1, 0, 1)
                tex:SetAtlas(options.atlas)
                flip:SetFlipBookFrameWidth(0)
                flip:SetFlipBookFrameHeight(0)
            end

            flip:SetFlipBookRows(options.rows)
            flip:SetFlipBookColumns(options.columns)
            flip:SetFlipBookFrames(options.frames)
            flip:SetDuration(options.duration)

            if not options.color or (count > 1 and i == 1) then
                tex:SetDesaturated(1)
                tex:SetVertexColor(1, 1, 1, 1)
            else
                tex:SetDesaturated(1)
                tex:SetVertexColor(options.color[1], options.color[2], options.color[3], options.color[4])
            end
            tex:Show()
        else
            tex:Hide()
        end
    end

    f:SetScript("OnHide", function(self)
        if self.AntsAnim:IsPlaying() then
            self.AntsAnim:Stop()
        end
    end)
    f:SetScript("OnShow", function(self)
        if not self.AntsAnim:IsPlaying() then
            self.AntsAnim:Play()
        end
    end)
end

local AntsGlowDefaults = {
    frameLevel = 8,
    color = nil,
    atlas = "RotationHelper_Ants_Flipbook_2x",
    rows = 6,
    columns = 5,
    frames = 30,
    duration = 1,
    scale = 1.4,
    xOffset = 0,
    yOffset = 0,
    count = 1,
    key = "",
}
lib.AntsGlowDefaults = AntsGlowDefaults

function lib.AntsGlow_Start(r, options)
    if not r then
        return
    end
    options = options or {}
    setmetatable(options, { __index = AntsGlowDefaults })
    local key = "_AntsGlow" .. options.key
    local f, new
    if r[key] then
        f = r[key]
    else
        f, new = AntsGlowPool:Acquire()
        if new then
            InitAntsGlow(f)
        end
        r[key] = f
    end
    f:SetParent(r)
    f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)

    local width, height = ResolveHostSize(r)

    f:SetSize(width * options.scale, height * options.scale)

    f:ClearAllPoints()
    f:SetPoint("CENTER", r, "CENTER", options.xOffset, options.yOffset)

    SetupAntsGlow(f, options)
    f:Show()
    if not f.AntsAnim:IsPlaying() then
        f.AntsAnim:Play()
    end
end

function lib.AntsGlow_Stop(r, key)
    if not r then
        return
    end
    key = key or ""
    local f = r["_AntsGlow" .. key]
    if f then
        AntsGlowPool:Release(f)
    end
end

table.insert(lib.glowList, "Ants Glow")
lib.startList["Ants Glow"] = lib.AntsGlow_Start
lib.stopList["Ants Glow"] = lib.AntsGlow_Stop

-- Slot Glow
local function SlotGlowResetter(framePool, frame)
    frame:Hide()
    frame:ClearAllPoints()
    frame:SetAlpha(1)
    local parent = frame:GetParent()
    if frame.key and parent and parent[frame.key] then
        parent[frame.key] = nil
    end
    frame.key = nil
end

local SlotGlowPool = CreateFramePool("Frame", GlowParent, nil, SlotGlowResetter)
lib.SlotGlowPool = SlotGlowPool

local function InitSlotGlow(f)
    f.Texture = f:CreateTexture(nil, "OVERLAY")
    f.Texture:SetAllPoints()
    f.Texture:SetBlendMode("ADD")
end

local SlotGlowDefaults = {
    frameLevel = 1,
    atlas = "newplayertutorial-drag-slotblue",
    color = nil,
    scale = 1.9,
    xOffset = 0,
    yOffset = 0,
    key = "",
}
lib.SlotGlowDefaults = SlotGlowDefaults

function lib.SlotGlow_Start(r, options)
    if not r then
        return
    end
    options = options or {}
    setmetatable(options, { __index = SlotGlowDefaults })

    local key = "_SlotGlow" .. options.key
    local f, new
    if r[key] then
        f = r[key]
    else
        f, new = SlotGlowPool:Acquire()
        if new then
            InitSlotGlow(f)
        end
        r[key] = f
    end

    f.key = key
    f:SetParent(r)
    f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)

    local width, height = ResolveHostSize(r)
    f:SetSize(width * options.scale, height * options.scale)
    f:ClearAllPoints()
    f:SetPoint("CENTER", r, "CENTER", options.xOffset, options.yOffset)

    local tex = f.Texture
    tex:SetAtlas(options.atlas, false)
    if options.color then
        tex:SetDesaturated(true)
        tex:SetVertexColor(options.color[1], options.color[2], options.color[3], options.color[4] or 1)
    else
        tex:SetDesaturated(false)
        tex:SetVertexColor(1, 1, 1, 1)
    end

    f:Show()
end

function lib.SlotGlow_Stop(r, key)
    if not r then
        return
    end
    key = key or ""
    local f = r["_SlotGlow" .. key]
    if f then
        SlotGlowPool:Release(f)
    end
end

table.insert(lib.glowList, "Slot Glow")
lib.startList["Slot Glow"] = lib.SlotGlow_Start
lib.stopList["Slot Glow"] = lib.SlotGlow_Stop

-- Shape Glow
local function ShapeGlowResetter(framePool, frame)
    if frame.Anim and frame.Anim:IsPlaying() then
        frame.Anim:Stop()
    end
    frame:Hide()
    frame:ClearAllPoints()
    frame:SetAlpha(1)
    if frame.Texture then
        frame.Texture:Hide()
        frame.Texture:ClearAllPoints()
    end
    local parent = frame:GetParent()
    if frame.key and parent and parent[frame.key] then
        parent[frame.key] = nil
    end
    frame.key = nil
end

local ShapeGlowPool = CreateFramePool("Frame", GlowParent, nil, ShapeGlowResetter)
lib.ShapeGlowPool = ShapeGlowPool

local function InitShapeGlow(f)
    f.Texture = f:CreateTexture(nil, "OVERLAY")
    f.Texture:SetBlendMode("ADD")

    f.Anim = f:CreateAnimationGroup()
    f.Anim:SetLooping("BOUNCE")
    f.ScaleAnim = f.Anim:CreateAnimation("Scale")
    f.ScaleAnim:SetOrigin("CENTER", 0, 0)
end

local ShapeGlowDefaults = {
    frameLevel = 1,
    color = nil,
    bloom = 0.2,
    duration = 0.5,
    speedFactor = 1,
    scaleTo = 1.06,
    texCoords = { 0.00781250, 0.50781250, 0.27734375, 0.52734375 },
    key = "",
}
lib.ShapeGlowDefaults = ShapeGlowDefaults

function lib.ShapeGlow_Start(r, options)
    if not r then
        return
    end
    options = options or {}
    setmetatable(options, { __index = ShapeGlowDefaults })
    if not options.texture then
        return
    end

    local key = "_ShapeGlow" .. options.key
    local f, new
    if r[key] then
        f = r[key]
    else
        f, new = ShapeGlowPool:Acquire()
        if new then
            InitShapeGlow(f)
        end
        r[key] = f
    end

    f.key = key
    f:SetParent(r)
    f:SetFrameLevel(r:GetFrameLevel() + options.frameLevel)
    f:ClearAllPoints()
    f:SetAllPoints(r)

    local width, height = ResolveHostSize(r)
    local bx, by = width * options.bloom, height * options.bloom
    local tex = f.Texture
    tex:ClearAllPoints()
    tex:SetPoint("TOPLEFT", f, "TOPLEFT", -bx, by)
    tex:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", bx, -by)
    tex:SetTexture(options.texture)
    tex:SetTexCoord(options.texCoords[1], options.texCoords[2], options.texCoords[3], options.texCoords[4])
    if options.color then
        tex:SetVertexColor(options.color[1], options.color[2], options.color[3], options.color[4] or 1)
    else
        tex:SetVertexColor(1, 1, 1, 1)
    end
    tex:Show()

    f.ScaleAnim:SetScaleTo(options.scaleTo, options.scaleTo)
    f.ScaleAnim:SetDuration(options.duration * options.speedFactor)
    f:Show()
    if not f.Anim:IsPlaying() then
        f.Anim:Play()
    end
end

function lib.ShapeGlow_Stop(r, key)
    if not r then
        return
    end
    key = key or ""
    local f = r["_ShapeGlow" .. key]
    if f then
        ShapeGlowPool:Release(f)
    end
end

table.insert(lib.glowList, "Shape Glow")
lib.startList["Shape Glow"] = lib.ShapeGlow_Start
lib.stopList["Shape Glow"] = lib.ShapeGlow_Stop
