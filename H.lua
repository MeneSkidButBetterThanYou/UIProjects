local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Http = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Library = {Version = "1.5.3", _windows = {}, _sessionFiles = {}}
local Base, Window, Tab, Section, Control = {}, {}, {}, {}, {}
Base.__index = Base
for _, class in ipairs({Window, Tab, Section, Control}) do
    class.__index = class
    setmetatable(class, {__index = Base})
end

local DEFAULT = {
    Bg = Color3.fromRGB(13,14,17), Sidebar = Color3.fromRGB(10,11,14),
    Card = Color3.fromRGB(17,18,23), CardHover = Color3.fromRGB(24,25,33),
    Elevated = Color3.fromRGB(22,23,29), Stroke = Color3.fromRGB(32,34,43),
    StrokeDim = Color3.fromRGB(24,25,33), Text = Color3.fromRGB(255,255,255),
    TextSub = Color3.fromRGB(123,126,140), Muted = Color3.fromRGB(75,78,90),
    Accent = Color3.fromRGB(255,255,255), Danger = Color3.fromRGB(239,68,68),
    Font = Enum.Font.Ubuntu, Radius = 12, CardRadius = 8,
}

local THEMES = {["Default"] = {["Bg"] = Color3.fromRGB(13, 14, 17);
        ["Sidebar"] = Color3.fromRGB(10, 11, 14);
        ["Card"] = Color3.fromRGB(17, 18, 23);
        ["Elevated"] = Color3.fromRGB(22, 23, 29), ["Stroke"] = Color3.fromRGB(32, 34, 43), ["StrokeDim"] = Color3.fromRGB(24,
        25, 33), ["Accent"] = Color3.fromRGB(255, 255, 255);
        ["AccentCyan"] = Color3.fromRGB(240, 242, 250);
        ["AccentGreen"] = Color3.fromRGB(34, 197, 94), ["AccentRed"] = Color3.fromRGB(239, 68, 68);
        ["BgTrans"] = 0;
        ["CardTrans"] = 0, ["CardHoverTrans"] = 0, ["BorderGradEnabled"] = false}, ["Old"] = {["Bg"] = Color3.fromRGB(15,
        15, 15);
        ["Sidebar"] = Color3.fromRGB(22, 22, 22);
        ["Card"] = Color3.fromRGB(28, 28, 28);
        ["Elevated"] = Color3.fromRGB(35, 35, 35), ["Stroke"] = Color3.fromRGB(50, 50, 50), ["StrokeDim"] = Color3.fromRGB(40,
        40, 40);
        ["Accent"] = Color3.fromRGB(100, 100, 100), ["AccentCyan"] = Color3.fromRGB(120, 120, 120);
        ["AccentGreen"] = Color3.fromRGB(140, 140, 140);
        ["AccentRed"] = Color3.fromRGB(160, 160, 160);
        ["BgTrans"] = 0, ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0, ["BorderGradEnabled"] = false}, ["Neverlose"] = {["Bg"] = Color3.fromRGB(10, 12, 18),
        ["Sidebar"] = Color3.fromRGB(8, 10, 15);
        ["Card"] = Color3.fromRGB(14, 18, 26);
        ["Elevated"] = Color3.fromRGB(18, 24, 36);
        ["Stroke"] = Color3.fromRGB(28, 38, 56);
        ["StrokeDim"] = Color3.fromRGB(20, 28, 42), ["Accent"] = Color3.fromRGB(0, 162, 255), ["AccentCyan"] = Color3.fromRGB(0,
        220, 255);
        ["AccentGreen"] = Color3.fromRGB(34, 197, 94), ["AccentRed"] = Color3.fromRGB(239, 68, 68), ["BgTrans"] = 0,
        ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true};
        ["Cyberpunk"] = {["Bg"] = Color3.fromRGB(14, 11, 19);
        ["Sidebar"] = Color3.fromRGB(11, 8, 15), ["Card"] = Color3.fromRGB(20, 16, 28), ["Elevated"] = Color3.fromRGB(27,
        21, 38), ["Stroke"] = Color3.fromRGB(48, 36, 68), ["StrokeDim"] = Color3.fromRGB(32, 24, 46), ["Accent"] = Color3.fromRGB(168,
        85, 247), ["AccentCyan"] = Color3.fromRGB(192, 132, 252);
        ["AccentGreen"] = Color3.fromRGB(34, 197, 94), ["AccentRed"] = Color3.fromRGB(239, 68, 68);
        ["BgTrans"] = 0, ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true};
        ["Vampire"] = {["Bg"] = Color3.fromRGB(16, 10, 12), ["Sidebar"] = Color3.fromRGB(12, 7, 9);
        ["Card"] = Color3.fromRGB(24, 14, 17);
        ["Elevated"] = Color3.fromRGB(34, 18, 22);
        ["Stroke"] = Color3.fromRGB(56, 28, 34);
        ["StrokeDim"] = Color3.fromRGB(38, 18, 22), ["Accent"] = Color3.fromRGB(255, 42, 66), ["AccentCyan"] = Color3.fromRGB(255,
        75, 95);
        ["AccentGreen"] = Color3.fromRGB(34, 197, 94), ["AccentRed"] = Color3.fromRGB(255, 42, 66);
        ["BgTrans"] = 0, ["CardTrans"] = 0, ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true};
        ["Sakura"] = {["Bg"] = Color3.fromRGB(18, 14, 18);
        ["Sidebar"] = Color3.fromRGB(26, 20, 26), ["Card"] = Color3.fromRGB(36, 28, 36), ["Elevated"] = Color3.fromRGB(50,
        38, 50), ["Stroke"] = Color3.fromRGB(255, 180, 200);
        ["StrokeDim"] = Color3.fromRGB(120, 80, 95);
        ["Accent"] = Color3.fromRGB(255, 180, 200), ["AccentCyan"] = Color3.fromRGB(255, 210, 225), ["AccentGreen"] = Color3.fromRGB(50,
        255, 100);
        ["AccentRed"] = Color3.fromRGB(255, 50, 50), ["BgTrans"] = 0;
        ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true};
        ["Emerald"] = {["Bg"] = Color3.fromRGB(10, 15, 12);
        ["Sidebar"] = Color3.fromRGB(8, 12, 10), ["Card"] = Color3.fromRGB(14, 23, 17);
        ["Elevated"] = Color3.fromRGB(19, 32, 24);
        ["Stroke"] = Color3.fromRGB(28, 52, 38);
        ["StrokeDim"] = Color3.fromRGB(20, 36, 26);
        ["Accent"] = Color3.fromRGB(34, 197, 94), ["AccentCyan"] = Color3.fromRGB(74, 222, 128), ["AccentGreen"] = Color3.fromRGB(34,
        197, 94), ["AccentRed"] = Color3.fromRGB(239, 68, 68), ["BgTrans"] = 0, ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0, ["BorderGradEnabled"] = true}, ["Aquamarine"] = {["Bg"] = Color3.fromRGB(10, 15, 17);
        ["Sidebar"] = Color3.fromRGB(8, 12, 14), ["Card"] = Color3.fromRGB(14, 22, 26), ["Elevated"] = Color3.fromRGB(19,
        30, 36), ["Stroke"] = Color3.fromRGB(28, 48, 56);
        ["StrokeDim"] = Color3.fromRGB(20, 32, 38), ["Accent"] = Color3.fromRGB(6, 182, 212);
        ["AccentCyan"] = Color3.fromRGB(34, 211, 238);
        ["AccentGreen"] = Color3.fromRGB(34, 197, 94);
        ["AccentRed"] = Color3.fromRGB(239, 68, 68), ["BgTrans"] = 0, ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true}, ["Primordial"] = {["Bg"] = Color3.fromRGB(10, 11, 14);
        ["Sidebar"] = Color3.fromRGB(15, 16, 20), ["Card"] = Color3.fromRGB(20, 22, 27), ["Elevated"] = Color3.fromRGB(28,
        30, 38);
        ["Stroke"] = Color3.fromRGB(115, 195, 185), ["StrokeDim"] = Color3.fromRGB(50, 90, 85);
        ["Accent"] = Color3.fromRGB(115, 195, 185), ["AccentCyan"] = Color3.fromRGB(0, 220, 255), ["AccentGreen"] = Color3.fromRGB(50,
        255, 100), ["AccentRed"] = Color3.fromRGB(255, 50, 50);
        ["BgTrans"] = 0, ["CardTrans"] = 0;
        ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = true}, ["Skeet"] = {["Bg"] = Color3.fromRGB(13, 14, 17);
        ["Sidebar"] = Color3.fromRGB(10, 11, 14);
        ["Card"] = Color3.fromRGB(17, 18, 23);
        ["Elevated"] = Color3.fromRGB(22, 23, 29);
        ["Stroke"] = Color3.fromRGB(32, 34, 43);
        ["StrokeDim"] = Color3.fromRGB(24, 25, 33), ["Accent"] = Color3.fromRGB(158, 201, 80), ["AccentCyan"] = Color3.fromRGB(180,
        220, 100);
        ["AccentGreen"] = Color3.fromRGB(158, 201, 80), ["AccentRed"] = Color3.fromRGB(239, 68, 68);
        ["BgTrans"] = 0, ["CardTrans"] = 0, ["CardHoverTrans"] = 0;
        ["BorderGradEnabled"] = false}}

local function copy(t)
    local out = {}
    for k,v in pairs(t) do out[k] = v end
    return out
end
local function snapshot(v)
    if type(v) == "table" then return copy(v) end
    return v
end
local function finite(n)
    return type(n) == "number" and n == n and n > -math.huge and n < math.huge
end
local function color3(value)
    if typeof(value)=="Color3" then return value end
    if type(value)=="table" then
        local r=value.R or value[1]; local g=value.G or value[2]; local b=value.B or value[3]
        if r and g and b then return Color3.fromRGB(r<=1 and r*255 or r,g<=1 and g*255 or g,b<=1 and b*255 or b) end
    end
    return nil
end
local function call(fn, ...)
    if not fn then return end
    local ok, err = pcall(fn, ...)
    if not ok then warn("[JLXUI callback] " .. tostring(err)) end
end
local function alive(self)
    assert(not self.Destroyed, "JLXUI: this object has been destroyed")
end
local function node(class, parent, window)
    if parent then alive(parent) end
    local self = setmetatable({
        Destroyed = false, _children = {}, _connections = {}, _instances = {},
        _parent = parent, _window = window, _themeBindings = {}, _animations = {},
    }, class)
    if parent then parent._children[self] = true end
    return self
end
local function connect(owner, signal, fn)
    local c = signal:Connect(fn)
    owner._connections[c] = true
    return c
end
local function role(key) return {_themeRole = key} end
local function property(owner, obj, key, value, deferred)
    local bindings = owner._themeBindings[obj]
    if type(value) == "table" and value._themeRole then
        if not bindings then bindings = {}; owner._themeBindings[obj] = bindings end
        bindings[key] = value._themeRole
        value = owner._window.Theme[value._themeRole]
    else
        if bindings then bindings[key] = nil end
    end
    if not deferred then obj[key] = value end
    return value
end
local function stopAnimation(owner,obj,channel,finish)
    local slots=owner._animations[obj]
    local record=slots and slots[channel]
    if not record then return end
    slots[channel]=nil
    if not next(slots) then owner._animations[obj]=nil end
    record.connection:Disconnect()
    record.tween:Cancel()
    record.tween:Destroy()
    if finish then
        for key,value in pairs(record.goals) do obj[key]=value end
        if record.done then record.done() end
    end
end
local function cancelAnimations(owner,finish)
    while owner._animations and next(owner._animations) do
        local obj,slots=next(owner._animations)
        stopAnimation(owner,obj,next(slots),finish)
    end
end
local function animate(owner,obj,goals,seconds,channel,done)
    if owner.Destroyed then return end
    channel=channel or "default"
    stopAnimation(owner,obj,channel,false)
    local resolved={}
    for key,value in pairs(goals) do resolved[key]=property(owner,obj,key,value,true) end
    if owner._window.Animations==false or seconds==0 then
        for key,value in pairs(resolved) do obj[key]=value end
        if done then done() end
        return
    end
    local slots=owner._animations[obj] or {}
    owner._animations[obj]=slots
    local record={goals=resolved,done=done}
    local tween=TweenService:Create(obj,TweenInfo.new(seconds or 0.15,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut),resolved)
    record.tween=tween
    slots[channel]=record
    record.connection=tween.Completed:Connect(function(state)
        if owner.Destroyed or not owner._animations[obj] or owner._animations[obj][channel]~=record then return end
        slots[channel]=nil
        if not next(slots) then owner._animations[obj]=nil end
        record.connection:Disconnect()
        tween:Destroy()
        if state==Enum.PlaybackState.Completed and done then done() end
    end)
    tween:Play()
end
local attachRipple
local function make(owner, class, parent, props)
    local obj = Instance.new(class)
    owner._instances[obj] = true
    for k,v in pairs(props or {}) do property(owner,obj,k,v) end
    obj.Parent = parent
    return obj
end
attachRipple=function(owner,button)
    local active
    connect(owner,button.Activated,function(input)
        if owner.Destroyed or not button.Parent or owner._window.Animations==false then return end
        if active and not active.Destroyed then active:Destroy() end
        local size=button.AbsoluteSize
        if size.X<=0 or size.Y<=0 then return end
        local x,y=0.5,0.5
        if input and (input.UserInputType==Enum.UserInputType.MouseButton1 or input.UserInputType==Enum.UserInputType.Touch) then
            local p=input.Position; local origin=button.AbsolutePosition
            x=math.clamp((p.X-origin.X)/size.X,0,1)
            y=math.clamp((p.Y-origin.Y)/size.Y,0,1)
        end
        local scope=node(Base,owner,owner._window)
        active=scope
        local originalDestroy=Base.Destroy
        scope.Destroy=function(self)
            if active==self then active=nil end
            originalDestroy(self)
        end
        local layer=make(scope,"CanvasGroup",button,{Name="ClickRipple",Size=UDim2.new(1,0,1,0),Position=UDim2.new(),BackgroundTransparency=1,ClipsDescendants=true,Active=false,ZIndex=(button.ZIndex or 1)+1})
        scope.container=layer
        local corner=button:FindFirstChildOfClass("UICorner")
        if corner then make(scope,"UICorner",layer,{CornerRadius=corner.CornerRadius}) end
        local dot=make(scope,"Frame",layer,{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new(x,0,y,0),Size=UDim2.new(),BorderSizePixel=0,BackgroundColor3=role("Text"),BackgroundTransparency=0.84,ZIndex=(button.ZIndex or 1)+1})
        make(scope,"UICorner",dot,{CornerRadius=UDim.new(0.5,0)})
        connect(scope,button.Destroying,function() scope:Destroy() end)
        local dx=math.max(x,1-x)*size.X
        local dy=math.max(y,1-y)*size.Y
        local diameter=2*math.sqrt(dx*dx+dy*dy)
        animate(scope,dot,{Size=UDim2.new(diameter/size.X,0,diameter/size.Y,0),BackgroundTransparency=1},0.45,"ripple",function() scope:Destroy() end)
    end)
end
local function round(owner, obj, radius)
    make(owner, "UICorner", obj, {CornerRadius = UDim.new(0, radius or 5)})
end
local function stroke(owner, obj, color)
    return make(owner, "UIStroke", obj, {Color = color, Thickness = 0.9})
end
local function frame(owner, parent, height, transparent, class)
    local theme = owner._window.Theme
    return make(owner, class or "Frame", parent, {
        Size = UDim2.new(1,0,0,height or 0), BorderSizePixel = 0,
        BackgroundColor3=role("Card"), BackgroundTransparency = transparent and 1 or 0.5,
    })
end
local function list(owner, parent, gap)
    return make(owner, "UIListLayout", parent, {
        Padding = UDim.new(0, gap or 6), SortOrder = Enum.SortOrder.LayoutOrder,
    })
end
local function text(owner, parent, value, props, class)
    local theme = owner._window.Theme
    local p = {BackgroundTransparency = 1, BorderSizePixel = 0,
        Size = UDim2.new(1,-20,1,0), Position = UDim2.new(0,10,0,0),
        Text = tostring(value or ""), TextColor3=role("Text"), Font=role("Font"),
        TextSize = 12, TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd}
    if class == "TextButton" then p.AutoButtonColor = false end
    for k,v in pairs(props or {}) do p[k] = v end
    return make(owner, class or "TextLabel", parent, p)
end
local function smallButton(owner, parent, title, width, height)
    height=height or 22
    local b = text(owner, parent, title, {
        Size = UDim2.new(0,width or 90,0,height), Position = UDim2.new(1,-(width or 90)-10,0.5,-height/2),
        TextXAlignment = Enum.TextXAlignment.Center, BackgroundTransparency = 0,
        BackgroundColor3=role("Elevated"), TextSize = 11,
    }, "TextButton")
    round(owner,b)
    stroke(owner,b,role("Stroke"))
    connect(owner,b.MouseEnter,function() animate(owner,b,{BackgroundColor3=role("CardHover")},0.16,"button") end)
    connect(owner,b.MouseLeave,function() animate(owner,b,{BackgroundColor3=role("Elevated")},0.22,"button") end)
    return b
end
local function hover(owner, obj)
    local theme = owner._window.Theme
    connect(owner, obj.MouseEnter, function() animate(owner,obj,{BackgroundColor3=role("CardHover")},0.16,"hover") end)
    connect(owner, obj.MouseLeave, function() animate(owner,obj,{BackgroundColor3=role("Card")},0.22,"hover") end)
end
local function autoFrame(owner, parent)
    local f = frame(owner,parent,0,true)
    f.AutomaticSize = Enum.AutomaticSize.Y
    list(owner,f,4)
    return f
end

function Base:Destroy()
    if self.Destroyed then return end
    self.Destroyed = true
    cancelAnimations(self)
    local w = self._window
    if w and w._drag and w._drag.owner == self then w._drag = nil end
    if w and w._capture == self then w._capture = nil end
    local heldCallback = self._held and self._callback or nil
    self._held = false
    if self._timer then pcall(task.cancel, self._timer); self._timer = nil end
    for c in pairs(self._connections) do c:Disconnect() end
    self._connections = {}
    while next(self._children) do next(self._children):Destroy() end
    if self._parent and self._parent._children then self._parent._children[self] = nil end
    if w and self.Flag and w._flags and w._flags[self.Flag] == self then
        w._flags[self.Flag] = nil
        w.Flags[self.Flag] = nil
    end
    if w and w._binds then w._binds[self] = nil end
    if w and w._tabs and self._isTab then
        w._tabs[self] = nil
        if w._configTab == self then w._configTab=nil; w._configControls=nil end
        if w._activeTab == self then
            w._activeTab = nil
            local replacement = next(w._tabs)
            if replacement and not w.Destroyed then replacement:Select() end
        end
    end
    if self._isWindow then
        if Library._windows[self.Id] == self then Library._windows[self.Id] = nil end
        if Library._last == self then
            Library._last = select(2, next(Library._windows))
        end
    end
    for obj in pairs(self._instances) do obj:Destroy() end
    for key in pairs(self) do self[key] = nil end
    self.Destroyed = true
    call(heldCallback, false)
end
function Base:Show()
    alive(self)
    if self._isWindow then self:SetVisible(true) else self.container.Visible = true end
end
function Base:Hide()
    alive(self)
    if self._isWindow then self:SetVisible(false) else self.container.Visible = false end
end

local function isPointer(input)
    return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
end
local function drag(owner, target, update, begin)
    connect(owner, target.InputBegan, function(input)
        if not isPointer(input) then return end
        if begin then begin(input) end
        local w = owner._window
        w._drag = {owner = owner, input = input, update = update}
        update(input)
    end)
end
local function releaseHolds(w)
    for bind in pairs(w._binds) do
        if bind._held then bind._held = false; call(bind._callback, false) end
    end
end
local function cancelCapture(w)
    if w._capture and not w._capture.Destroyed then
        w._capture._button.Text = w._capture.Value==Enum.KeyCode.Unknown and "NONE" or w._capture.Value.Name
    end
    w._capture = nil
end
local function valueControl(section, title, kind, flag, callback, height)
    alive(section)
    local w = section._window
    if flag ~= nil and flag ~= "" then
        assert(type(flag) == "string", "JLXUI: flag must be a string")
        assert(not w._flags[flag], "JLXUI: duplicate flag: " .. flag)
    end
    local c = node(Control, section, w)
    c.Kind, c._callback = kind, callback
    c._searchText = tostring(title or ""):lower()
    w._searchControls = w._searchControls or {}
    w._searchControls[c] = true
    c.container = frame(c,section.content,height or 32)
    connect(c,c.container.Destroying,function() c:Destroy() end)
    if section._joined then
        c.container.BackgroundTransparency=1
    else
        round(c,c.container,w.Theme.CardRadius)
        stroke(c,c.container,role("StrokeDim"))
        hover(c,c.container)
    end
    c._title = text(c,c.container,title)
    if flag and flag ~= "" then c.Flag = flag; w._flags[flag] = c end
    return c
end
function Window:_Search(query)
    query = tostring(query or ""):lower():match("^%s*(.-)%s*$")
    self._searchQuery = query
    for control in pairs(self._searchControls or {}) do
        if not control.Destroyed then
            if control._searchOriginalVisible == nil then
                control._searchOriginalVisible = control.container.Visible
            end
            local visible = query == "" or control._searchText:find(query, 1, true) ~= nil
            control.container.Visible = visible and control._searchOriginalVisible ~= false
        end
    end
end
local function publish(c, value, silent)
    c.Value = snapshot(value)
    if c.Flag then c._window.Flags[c.Flag] = snapshot(value) end
    if not silent then call(c._callback, snapshot(value)) end
end
function Control:Get()
    alive(self)
    return snapshot(self.Value)
end
function Control:Set(value, silent)
    alive(self)
    assert(self._set, "JLXUI: this control has no value")
    self:_set(value, silent == true)
    return self
end
function Control:SetText(value)
    alive(self)
    self._title.Text = tostring(value)
    return self
end
function Control:Press()
    alive(self)
    call(self._callback)
end
function Control:Dismiss()
    alive(self)
    if self._dismiss then self:_dismiss() else self:Destroy() end
end

local function configPath(w,name)
    name=name or "default"
    assert(type(name)=="string" and name:match("^[%w_%-]+$"),"JLXUI: invalid config name")
    local folder=w.FolderToSave or "JLXUI"
    assert(type(folder)=="string" and folder:match("^[%w_%-]+$"),"JLXUI: invalid folder name")
    return folder .. "/" .. name .. ".json"
end
local function getStorage(adapter)
    if adapter then return adapter, "Custom storage" end
    if type(writefile)=="function" and type(readfile)=="function" and
        type(isfolder)=="function" and type(makefolder)=="function" then
        return {
            Write=function(path,json)
                local folder=path:match("^([^/]+)/")
                if not isfolder(folder) then makefolder(folder) end
                writefile(path,json)
            end,
            Read=function(path) return readfile(path) end,
            List=type(listfiles)=="function" and function(folder)
                if not isfolder(folder) then return {} end
                return listfiles(folder)
            end or nil,
        }, "Local files"
    end
    return {
        Write=function(path,json) Library._sessionFiles[path]=json end,
        Read=function(path) return assert(Library._sessionFiles[path],"No saved config with this name") end,
        List=function(folder)
            local paths={}
            for path in pairs(Library._sessionFiles) do
                if path:sub(1,#folder+1)==folder .. "/" then paths[#paths+1]=path end
            end
            return paths
        end,
    }, "Session only"
end

function Library:New(options)
    options = options or {}
    local id = options.Id or options.Name or "JLXUI"
    if self._windows[id] then self._windows[id]:Destroy() end
    local player = Players.LocalPlayer
    assert(player or options.Parent, "JLXUI must run on the client")
    local parent = options.Parent or player:WaitForChild("PlayerGui")
    local guiName = "JLXUI_" .. tostring(id)
    local previous = parent:FindFirstChild(guiName)
    if previous then previous:Destroy() end
    local w = node(Window)
    w._window, w._isWindow, w.Id = w, true, id
    w.Theme = copy(DEFAULT)
    w.ThemeName = type(options.Theme) == "string" and options.Theme or "Default"
    assert(THEMES[w.ThemeName], "JLXUI: unknown theme")
    for k,v in pairs(THEMES[w.ThemeName]) do w.Theme[k]=v end
    if type(options.Theme)=="table" then for k,v in pairs(options.Theme) do w.Theme[k]=v end end
    w.UserScale, w.BackgroundTransparency = 1, 0
    w.Animations = options.Animations ~= false
    w._shown = true
    w.NotificationDuration, w.NotificationsEnabled = 5, true
    w.Flags, w._flags, w._tabs, w._binds = {}, {}, {}, {}
    w.ToggleKey = options.ToggleKey or Enum.KeyCode.RightShift
    w.FolderToSave = options.FolderToSave
    w._storage, w.StorageMode = getStorage(options.Storage)
    local width, height = options.Width or 720, options.Height or 470
    assert(finite(width) and width >= 400 and finite(height) and height >= 250, "JLXUI: window size is too small")
    w.Gui = make(w,"ScreenGui",parent,{Name=guiName,ResetOnSpawn=false,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=options.DisplayOrder or 100})
    w.container = frame(w,w.Gui,height,nil,"CanvasGroup")
    w.container.Name = "Main"
    w.container.Size = UDim2.new(0,width,0,height)
    w.container.AnchorPoint = Vector2.new(0.5,0.5)
    w.container.Position = UDim2.new(0.5,0,0.5,0)
    property(w,w.container,"BackgroundColor3",role("Bg"))
    w.container.BackgroundTransparency = 0
    round(w,w.container,w.Theme.Radius)
    stroke(w,w.container,role("Stroke"))
    local scale = make(w,"UIScale",w.container,{Scale=1})
    local viewport = make(w,"Frame",w.Gui,{Size=UDim2.new(1,0,1,0),BackgroundTransparency=1,Active=false})
    local function fit()
        local size = viewport.AbsoluteSize
        if size.X > 0 and size.Y > 0 then
            scale.Scale = math.min(w.UserScale, math.max(0.1, math.min((size.X-20)/width,(size.Y-20)/height)))
        end
    end
    local originalFit=fit
    fit=function()
        originalFit()
        if w._clampRestore then w._clampRestore() end
    end
    w._fit = fit
    connect(w,viewport:GetPropertyChangedSignal("AbsoluteSize"),fit)
    fit()
    w._searchControls = {}
    w._viewport=viewport
    local title = text(w,w.container,options.Name or "JLXUI",{Size=UDim2.new(0,110,0,38),TextSize=14,Font=Enum.Font.GothamBold,TextYAlignment=Enum.TextYAlignment.Center})
    title.Active = true
    local version = text(w,w.container,options.Version or ("v" .. Library.Version),{Size=UDim2.new(0,54,0,38),Position=UDim2.new(0,0,0,0),
        TextColor3=role("TextSub"),TextSize=10,TextYAlignment=Enum.TextYAlignment.Center})
    w.VersionLabel = version
    connect(w,title:GetPropertyChangedSignal("TextBounds"),function()
        local bounds=title.TextBounds
        if bounds and bounds.X then version.Position=UDim2.new(0,16+bounds.X,0,0) end
    end)
    task.defer(function()
        if title.Parent then local bounds=title.TextBounds; if bounds and bounds.X then version.Position=UDim2.new(0,16+bounds.X,0,0) end end
    end)
    local search = text(w,w.container,"",{Size=UDim2.new(0,250,0,30),Position=UDim2.new(1,-370,0,4),
        BackgroundTransparency=0,BackgroundColor3=role("Elevated"),TextColor3=role("Text"),
        PlaceholderText="⌕  Search...  (Ctrl+F)",PlaceholderColor3=role("Muted"),
        ClearTextOnFocus=false,TextSize=11},"TextBox")
    round(w,search,7); stroke(w,search,role("StrokeDim")); make(w,"UIPadding",search,{PaddingLeft=UDim.new(0,10),PaddingRight=UDim.new(0,8)})
    w.SearchBox = search
    connect(w,search:GetPropertyChangedSignal("Text"),function() w:_Search(search.Text) end)
    local minimize = smallButton(w,w.container,"−",32,28)
    minimize.Position = UDim2.new(1,-82,0,5)
    local close = smallButton(w,w.container,"×",32,28)
    close.Position = UDim2.new(1,-42,0,5)
    minimize.TextSize=18; close.TextSize=18
    local minStroke=minimize:FindFirstChildOfClass("UIStroke")
    local closeStroke=close:FindFirstChildOfClass("UIStroke")
    if minStroke then minStroke.Transparency=0.75 end
    if closeStroke then closeStroke.Transparency=0.75 end
    w._headerLine = make(w,"Frame",w.container,{Size=UDim2.new(1,-16,0,1),Position=UDim2.new(0,8,0,38),
        BackgroundColor3=role("StrokeDim"),BackgroundTransparency=0,BorderSizePixel=0})
    w._body = frame(w,w.container,height-68,true)
    w._body.Size = UDim2.new(1,0,1,-68)
    w._body.Position = UDim2.new(0,0,0,44)
    w._sidebar = make(w,"ScrollingFrame",w._body,{Size=UDim2.new(0,44,1,-12),
        Position=UDim2.new(0,4,0,4), BackgroundColor3=role("Sidebar"),BorderSizePixel=0,
        CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=0,
        ScrollBarImageTransparency=1})
    round(w,w._sidebar,8)
    list(w,w._sidebar,4)
    w._content = frame(w,w._body,0,true)
    w._content.Size = UDim2.new(1,-62,1,-12)
    w._content.Position = UDim2.new(0,56,0,4)
    w._contentLine = make(w,"Frame",w._body,{Size=UDim2.new(0,1,1,-12),Position=UDim2.new(0,52,0,4),
        BackgroundColor3=role("StrokeDim"),BackgroundTransparency=0,BorderSizePixel=0})
    w._restore = text(w,w.Gui,"Show " .. (options.Name or "JLXUI"), {
        Size=UDim2.new(0,150,0,30),Position=UDim2.new(0,10,0.5,-15),
        TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=0,
        BackgroundColor3=role("Elevated"),Visible=false},"TextButton")
    round(w,w._restore)
    connect(w,minimize.Activated,function() w:SetVisible(false) end)
    connect(w,close.Activated,function() w:Destroy() end)
    connect(w,w._restore.Activated,function()
        if not w._restoreMoved then w:SetVisible(true) end
    end)
    local restoreStart,restoreX,restoreY
    local function placeRestore(x,y)
        local size=viewport.AbsoluteSize
        local buttonSize=w._restore.AbsoluteSize
        w._restore.Position=UDim2.new(0,math.clamp(x,8,math.max(8,size.X-buttonSize.X-8)),
            0,math.clamp(y,8,math.max(8,size.Y-buttonSize.Y-8)))
    end
    w._clampRestore=function()
        local p=w._restore.AbsolutePosition-viewport.AbsolutePosition
        placeRestore(p.X,p.Y)
    end
    drag(w,w._restore,function(input)
        local delta=input.Position-restoreStart
        if delta.X*delta.X+delta.Y*delta.Y>=36 then w._restoreMoved=true end
        if w._restoreMoved then placeRestore(restoreX+delta.X,restoreY+delta.Y) end
    end,function(input)
        w._restoreMoved=false
        restoreStart=input.Position
        local p=w._restore.AbsolutePosition-viewport.AbsolutePosition
        restoreX,restoreY=p.X,p.Y
    end)
    local dragStart, startPos
    local headerDrag=make(w,"Frame",w.container,{Name="HeaderDrag",Size=UDim2.new(1,-376,0,38),BackgroundTransparency=1,Active=true,ZIndex=4})
    w._headerDrag=headerDrag
    drag(w,headerDrag,function(input)
        local delta = input.Position - dragStart
        w.container.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,
            startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end,function(input) dragStart=input.Position; startPos=w.container.Position end)
    local resize=smallButton(w,w.container,"↘  Drag to Resize",106,26)
    resize.Position=UDim2.new(1,-114,1,-31); resize.TextSize=10; resize.BackgroundTransparency=0.12
    local resizeStart,resizeWidth,resizeHeight,resizeScale
    drag(w,resize,function(input)
        local delta=input.Position-resizeStart
        width=math.clamp(resizeWidth+delta.X/resizeScale,400,1400)
        height=math.clamp(resizeHeight+delta.Y/resizeScale,250,1000)
        w.container.Size=UDim2.new(0,width,0,height)
        fit()
    end,function(input)
        resizeStart=input.Position; resizeWidth=width; resizeHeight=height; resizeScale=scale.Scale
    end)
    connect(w,Input.InputChanged,function(input)
        local d = w._drag
        if d and not d.owner.Destroyed and (input == d.input or
            (d.input.UserInputType == Enum.UserInputType.MouseButton1 and input.UserInputType == Enum.UserInputType.MouseMovement)) then
            d.update(input)
        end
    end)
    connect(w,Input.InputEnded,function(input)
        if w._drag and (input == w._drag.input or
            (input.UserInputType == Enum.UserInputType.MouseButton1 and w._drag.input.UserInputType == Enum.UserInputType.MouseButton1)) then w._drag=nil end
        for bind in pairs(w._binds) do
            if bind._held and input.KeyCode == bind.Value then
                bind._held=false; call(bind._callback,false)
            end
        end
    end)
    connect(w,Input.InputBegan,function(input, processed)
        local captured = w._capture
        if captured then
            if input.KeyCode == Enum.KeyCode.Escape then cancelCapture(w)
            elseif input.KeyCode == Enum.KeyCode.Backspace then captured:Set(Enum.KeyCode.Unknown); w._capture=nil
            elseif input.KeyCode ~= Enum.KeyCode.Unknown then captured:Set(input.KeyCode); w._capture=nil end
            return
        end
        if input.KeyCode == Enum.KeyCode.F and (input.UserInputType == Enum.UserInputType.Keyboard) and
            (input.IsModifierKeyDown and input:IsModifierKeyDown(Enum.ModifierKey.Ctrl) or false) then
            search:CaptureFocus()
            return
        end
        if processed or Input:GetFocusedTextBox() then return end
        if input.KeyCode == w.ToggleKey then w:SetVisible(not w._shown); return end
        for bind in pairs(w._binds) do
            if bind.Value ~= Enum.KeyCode.Unknown and input.KeyCode == bind.Value then
                if bind._hold then
                    if not bind._held then bind._held=true; call(bind._callback,true) end
                else call(bind._callback) end
                if w.Destroyed then return end
            end
        end
    end)
    connect(w,Input.WindowFocusReleased,function() w._drag=nil; cancelCapture(w); releaseHolds(w) end)
    connect(w,w.Gui.Destroying,function() w:Destroy() end)
    w.ShowActiveHotkeys=options.ShowActiveHotkeys~=false
    w._hotkeyRows={}
    w._hotkeyOverlay=frame(w,w.Gui,0,true)
    w._hotkeyOverlay.Size=UDim2.new(0,190,0,0); w._hotkeyOverlay.Position=UDim2.new(1,-205,0,50); w._hotkeyOverlay.AutomaticSize=Enum.AutomaticSize.Y; w._hotkeyOverlay.Visible=true
    w._hotkeyOverlay.BackgroundTransparency=0.15
    property(w,w._hotkeyOverlay,"BackgroundColor3",role("Bg"))
    round(w,w._hotkeyOverlay,5)
    list(w,w._hotkeyOverlay,0)
    text(w,w._hotkeyOverlay,"Active Hotkeys",{Size=UDim2.new(1,0,0,26),LayoutOrder=-1,Font=Enum.Font.GothamBold,TextXAlignment=Enum.TextXAlignment.Center})
    self._windows[id], self._last = w, w
    if options.Configuration ~= false then w:_BuildConfiguration() end
    w:_RefreshHotkeys()
    w:SetAcrylic(options.Acrylic==true)
    w.container.GroupTransparency=1
    animate(w,w.container,{GroupTransparency=0},0.28,"visibility")
    return w
end
function Window:SetVisible(visible)
    alive(self)
    self._shown = visible == true
    if self._acrylicBlur then self._acrylicBlur.Enabled=self.Acrylic and self._shown end
    self._restore.Visible = not self._shown
    if self._shown then self.container.Visible=true end
    animate(self,self.container,{GroupTransparency=self._shown and 0 or 1},0.24,"visibility",function()
        if not self._shown then self.container.Visible=false end
    end)
    self._drag=nil
    cancelCapture(self)
    releaseHolds(self)
end
function Window:ToggleUI() self:SetVisible(not self._shown) end
function Window:SetAcrylic(enabled)
    alive(self)
    self.Acrylic=enabled==true
    if self.Acrylic and not self._acrylicBlur then
        self._acrylicBlur=make(self,"BlurEffect",game:GetService("Lighting"),{Name="JLXUI_Acrylic",Size=12,Enabled=false})
    end
    if self._acrylicBlur then self._acrylicBlur.Enabled=self.Acrylic and self._shown end
    self.container.BackgroundTransparency=self.Acrylic and math.max(0.22,self.BackgroundTransparency or 0) or (self.BackgroundTransparency or 0)
    if self._configControls and self._configControls.Acrylic then self._configControls.Acrylic:Set(self.Acrylic,true) end
end

Library.Icons = {
    Home="rbxassetid://7733960981", Eye="rbxassetid://7733774602",
    Zap="rbxassetid://7734091286", Activity="rbxassetid://7733655755",
    Swords="rbxassetid://10734975692", MapPin="rbxassetid://7733992789",
    Layers="rbxassetid://7743868936", Settings="rbxassetid://7734058803",
    Cloud="rbxassetid://7733746980",
}
Library.IconSource = "https://raw.githubusercontent.com/latte-soft/lucide-roblox/master/icons/compiled/48px/"
Library._iconCache = {}
function Library:SetIconResolver(resolver)
    assert(type(resolver)=="function","JLXUI: icon resolver must be a function")
    self.IconResolver=resolver
end
local function resolveIcon(icon)
    if not icon or icon=="" then return Library.Icons.Home end
    if Library.Icons[icon] then return Library.Icons[icon] end
    if tostring(icon):match("^rbxasset") or tostring(icon):match("^https?://") then return tostring(icon) end
    if Library.IconResolver then
        local ok,result=pcall(Library.IconResolver, tostring(icon))
        if ok and result then return tostring(result) end
    end
    local key=tostring(icon):gsub("%s+","-"):gsub("([a-z0-9])([A-Z])","%1-%2"):lower()
    local cached=Library._iconCache[key]
    if cached then return cached end
    local asset=(getcustomasset or (syn and syn.getcustomasset))
    if asset and writefile and isfile then
        local folder="JLXUI_Icons"
        pcall(function() if not isfolder(folder) then makefolder(folder) end end)
        local path=folder.."/"..key..".png"
        if not isfile(path) then
            local ok,data=pcall(function() return game:HttpGet(Library.IconSource..key..".png") end)
            if ok and data and #data>50 then pcall(writefile,path,data) end
        end
        if isfile(path) then
            local ok,result=pcall(asset,path)
            if ok and result then Library._iconCache[key]=result; return result end
        end
    end
    return Library.Icons.Home
end
function Window:Tab(title, icon)
    alive(self)
    local t = node(Tab,self,self)
    t._isTab, t.Name = true, tostring(title)
    self._tabs[t] = true
    t._button = text(t,self._sidebar,"",{Size=UDim2.new(0,36,0,38),Position=UDim2.new(),
        BackgroundColor3=role("Card"),BackgroundTransparency=1},"TextButton")
    round(t,t._button,7)
    local image=resolveIcon(icon)
    t._icon=make(t,"ImageLabel",t._button,{Size=UDim2.new(0,21,0,21),Position=UDim2.new(0.5,-10,0.5,-10),
        BackgroundTransparency=1,Image=tostring(image),ImageColor3=role("Text"),ImageTransparency=0.4})
    t._indicator=frame(t,t._button,24)
    t._indicator.Size=UDim2.new(0,2,0,24); t._indicator.Position=UDim2.new(0,0,0.5,-12)
    property(t,t._indicator,"BackgroundColor3",role("Accent"))
    t._indicator.BackgroundTransparency=1
    round(t,t._indicator,2)
    t._hint=text(t,self._viewport,title,{Size=UDim2.new(0,150,0,26),Position=UDim2.new(0,54,0,42),
        BackgroundTransparency=0,BackgroundColor3=role("Elevated"),ZIndex=20,Visible=false,TextTruncate=Enum.TextTruncate.None,TextWrapped=false})
    round(t,t._hint,5)
    make(t,"UIPadding",t._hint,{PaddingLeft=UDim.new(0,8),PaddingRight=UDim.new(0,8)})
    local function positionHint()
        local p=t._button.AbsolutePosition; local size=t._button.AbsoluteSize; local vp=self._viewport
        if vp then
            local bounds=game:GetService("TextService"):GetTextSize(t._hint.Text,t._hint.TextSize,t._hint.Font,Vector2.new(1000000,1000000))
            local width=math.ceil(bounds.X)+16
            t._hint.Size=UDim2.new(0,width,0,26)
            local x=math.clamp(p.X+size.X-vp.AbsolutePosition.X+8,8,math.max(8,vp.AbsoluteSize.X-width-8))
            local y=math.clamp(p.Y+size.Y/2-vp.AbsolutePosition.Y-13,8,math.max(8,vp.AbsoluteSize.Y-34))
            t._hint.Position=UDim2.new(0,x,0,y)
        end
    end
    connect(t,t._button:GetPropertyChangedSignal("AbsolutePosition"),function()
        if t._hint.Visible then positionHint() end
    end)
    for _,key in ipairs({"Text","TextSize","Font"}) do
        connect(t,t._hint:GetPropertyChangedSignal(key),function() if t._hint.Visible then positionHint() end end)
    end
    connect(t,t._button.MouseEnter,function()
        for other in pairs(self._tabs) do other._hint.Visible=false end
        positionHint()
        t._hint.Visible=true
        animate(t,t._icon,{ImageTransparency=0},0.16,"hover")
    end)
    connect(t,t._button.MouseLeave,function()
        t._hint.Visible=false
        animate(t,t._icon,{ImageTransparency=self._activeTab==t and 0 or 0.4},0.16,"hover")
    end)
    t.container = make(t,"ScrollingFrame",self._content,{Size=UDim2.new(1,0,1,0),
        BackgroundTransparency=1,BorderSizePixel=0,CanvasSize=UDim2.new(),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=3,
        ScrollBarImageColor3=role("TextSub"),Visible=false})
    list(t,t.container,10)
    make(t,"UIPadding",t.container,{PaddingLeft=UDim.new(0,2),PaddingRight=UDim.new(0,8),PaddingBottom=UDim.new(0,16)})
    t.content = t.container
    connect(t,t.container.Destroying,function() t:Destroy() end)
    connect(t,t._button.Activated,function() t:Select() end)
    if not self._activeTab or self._activeTab == self._configTab then t:Select() end
    return t
end
function Window:PlayerTeleportTab(title)
    alive(self)
    local tab=self:Tab(title or "ALL","MapPin")
    local section=tab:Section("Quick player teleports")
    local column=section:CollapsibleGroup("Teleport destinations",true)
    column._header.Visible=false
    local selector=column:Dropdown("Show",{"ALL","PLAYERS","ITEMS","GENERATORS","PALLETS","VAULTS","GATES","HOOKS"},"PLAYERS")
    column.content:FindFirstChildOfClass("UIListLayout").Padding=UDim.new(0,0)
    property(column,column.container,"BackgroundColor3",role("Card"))
    column.container.BackgroundTransparency=0.2
    round(column,column.container,6); stroke(column,column.container,role("StrokeDim"))
    local selected="PLAYERS"
    local rows={}
    local function remove(player)
        local row=rows[player]
        if row then row:Destroy(); rows[player]=nil end
    end
    local function add(player)
        if (selected~="ALL" and selected~="PLAYERS") or player==Players.LocalPlayer or rows[player] then return end
        local row=node(Control,column,self)
        row._searchText=player.Name:lower()
        self._searchControls[row]=true
        row.container=frame(row,column.content,28,true)
        local accent=make(row,"Frame",row.container,{Size=UDim2.new(0,3,0,22),Position=UDim2.new(0,8,0.5,-11),BackgroundColor3=role("Accent"),BorderSizePixel=0})
        round(row,accent,2)
        local label=text(row,row.container,player.DisplayName .. "  [" .. player.Name .. "]",{Size=UDim2.new(0.62,0,1,0),Position=UDim2.new(0,20,0,0),TextSize=11})
        local distance=text(row,row.container,"—",{Size=UDim2.new(0,72,1,0),Position=UDim2.new(0.62,0,0,0),TextXAlignment=Enum.TextXAlignment.Right,TextColor3=role("TextSub"),TextSize=10})
        row._distance=distance
        local button=smallButton(row,row.container,"TELEPORT",92); button.Position=UDim2.new(1,-102,0.5,-11)
        attachRipple(row,button)
        connect(row,button.Activated,function()
            local target=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local character=Players.LocalPlayer.Character
            if target and character then character:PivotTo(target.CFrame + Vector3.new(0,3,0)) end
        end)
        rows[player]=row
    end
    local empty=column:Label("No destinations")
    local function refresh(category)
        selected=category or selected
        for player in pairs(rows) do remove(player) end
        for _,player in ipairs(Players:GetPlayers()) do add(player) end
        empty.container.Visible=next(rows)==nil
    end
    selector._callback=refresh
    tab.Selector=selector
    tab.Refresh=function() refresh() end
    tab._destinationRows=rows
    refresh()
    connect(tab,Players.PlayerAdded,function(player) add(player); empty.container.Visible=next(rows)==nil end)
    connect(tab,Players.PlayerRemoving,function(player) remove(player); empty.container.Visible=next(rows)==nil end)
    local elapsed=0
    connect(tab,RunService.RenderStepped,function(dt)
        elapsed=elapsed+(dt or 0.25)
        if elapsed<0.25 or self._activeTab~=tab then return end
        elapsed=0
        local root=Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        for player,row in pairs(rows) do
            if row.Destroyed then rows[player]=nil else
                local target=player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if target and row._distance then row._distance.Text=string.format("%.0fm",(root.Position-target.Position).Magnitude) end
            end
        end
    end)
    tab:Select()
    return tab
end
Window.CreatePlayerTeleportTab=Window.PlayerTeleportTab
function Window:CommunityTab(options)
    alive(self)
    options=options or {}
    local tab=self:Tab(options.Title or "Community","Cloud")
    local info=tab:Section("Config hub")
    info:Label(options.Description or "Browse and share configurations with the community.")
    local share=tab:Section("Share your config")
    local configName=share:Textbox("Config title",false)
    local author=share:Textbox("Author name",false)
    local description=share:Textbox("Description",false)
    local category=share:Dropdown("Category",{"LEGIT","RAGE","FARM","SURVIVOR","KILLER"},"LEGIT")
    local status=share:Label("Ready to publish")
    share:Button("Publish config",function()
        local payload={title=configName:Get(),author=author:Get(),description=description:Get(),category=category:Get(),config=self:ExportConfig()}
        if type(options.Publish)=="function" then
            local ok,result=pcall(options.Publish,payload)
            status:Set(ok and (result or "Published") or tostring(result))
        else
            status:Set("Provide CommunityTab({Publish=function(payload) ... end})")
        end
    end)
    local feed=tab:Section("Community configurations")
    feed:Label("A server adapter can populate this section with your own feed.")
    if type(options.LoadFeed)=="function" then
        local ok,items=pcall(options.LoadFeed)
        if ok and type(items)=="table" then
            for _,item in ipairs(items) do
                local title=tostring(item.title or "Untitled")
                local row=feed:Button(title .. "  " .. tostring(item.author or ""),function()
                    if type(options.LoadConfig)=="function" then pcall(options.LoadConfig,item) end
                end)
                row:SetText(title .. "  " .. tostring(item.author or ""))
            end
        end
    end
    tab:Select()
    return tab
end
Window.CreateCommunityTab=Window.CommunityTab
function Tab:Select()
    alive(self)
    if self.Refresh then self:Refresh() end
    local w = self._window
    for tab in pairs(w._tabs) do
        if tab ~= self then tab.container.Visible = false end
        animate(tab,tab._button,{BackgroundTransparency=tab==self and 0 or 1},0.20,"selection")
        animate(tab,tab._icon,{ImageTransparency=tab==self and 0 or 0.4},0.20,"hover")
        animate(tab,tab._indicator,{BackgroundTransparency=tab==self and 0 or 1},0.20,"selection")
        tab._hint.Visible=false
        property(tab,tab._button,"TextColor3",role(tab == self and "Text" or "TextSub"))
    end
    self.container.Visible=true
    self.container.Position=UDim2.new(0,0,0,12)
    task.defer(function()
        if not self.Destroyed and w._activeTab==self then animate(self,self.container,{Position=UDim2.new()},0.26,"page") end
    end)
    w._activeTab = self
    w._drag = nil
    cancelCapture(w)
end
function Tab:Section(title)
    alive(self)
    local s = node(Section,self,self._window)
    s.container = autoFrame(s,self.content)
    s._title = text(s,s.container,string.upper(tostring(title)),{
        Size=UDim2.new(1,-8,0,24),Position=UDim2.new(),TextSize=10,TextColor3=role("TextSub"),
        TextYAlignment=Enum.TextYAlignment.Center})
    s._rule = make(s,"Frame",s.container,{Size=UDim2.new(1,-8,0,1),Position=UDim2.new(0,0,0,24),
        BackgroundColor3=role("StrokeDim"),BackgroundTransparency=0,BorderSizePixel=0})
    s.content = autoFrame(s,s.container)
    s.content.LayoutOrder=1
    s.content.Position=UDim2.new(0,0,0,28)
    connect(s,s.container.Destroying,function() s:Destroy() end)
    return s
end
Section.Section = Tab.Section

function Section:Button(title, callback)
    local c = valueControl(self,title,"Button",nil,callback)
    c._title.Visible=false
    c.container.BackgroundTransparency=1
    local outerStroke=c.container:FindFirstChildOfClass("UIStroke")
    if outerStroke then outerStroke.Transparency=1 end
    local b = text(c,c.container,title,{Size=UDim2.new(1,0,1,0),Position=UDim2.new(),TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=0,BackgroundColor3=role("Elevated"),TextSize=11},"TextButton")
    round(c,b,c._window.Theme.CardRadius); stroke(c,b,role("StrokeDim"))
    connect(c,b.MouseEnter,function() animate(c,b,{BackgroundColor3=c.HoverColor or role("CardHover")},0.16,"button") end)
    connect(c,b.MouseLeave,function() animate(c,b,{BackgroundColor3=c.ButtonColor or role("Elevated")},0.22,"button") end)
    c.button=b
    attachRipple(c,b)
    connect(c,b.Activated,function() c:Press() end)
    return c
end
function Section:Toggle(title, default, flag, callback, key)
    local c = valueControl(self,title,"Toggle",flag,callback,36)
    c._title.Size=UDim2.new(1,-110,1,0)
    local pill=frame(c,c.container,16)
    pill.Size=UDim2.new(0,32,0,16); pill.Position=UDim2.new(1,-44,0.5,-8)
    pill.BackgroundTransparency=0
    round(c,pill,8)
    local knob=frame(c,pill,12)
    knob.Size=UDim2.new(0,12,0,12); knob.Position=UDim2.new(0,2,0.5,-6)
    knob.BackgroundTransparency=0
    round(c,knob,6)
    c._pill=pill; c._knob=knob
    local hit=text(c,c.container,"",{Size=UDim2.new(1,-90,1,0),Position=UDim2.new()},"TextButton")
    local switchHit=text(c,c.container,"",{Size=UDim2.new(0,46,1,0),Position=UDim2.new(1,-46,0,0)},"TextButton")
    c._hit=hit
    c._switchHit=switchHit
    c._set=function(control,value,silent)
        assert(type(value)=="boolean","JLXUI: Toggle:Set expects a boolean")
        local seconds=silent and 0 or 0.22
        animate(control,pill,{BackgroundColor3=role(value and "Accent" or "Elevated")},seconds,"switch")
        animate(control,knob,{Position=value and UDim2.new(1,-14,0.5,-6) or UDim2.new(0,2,0.5,-6),
            BackgroundColor3=role(value and "Bg" or "TextSub")},seconds,"switch")
        publish(control,value,silent)
    end
    c:Set(default==true,true)
    local function flip() c:Set(not c.Value) end
    connect(c,hit.Activated,flip)
    connect(c,switchHit.Activated,flip)
    local bind=self:Bind(title .. " key",key or Enum.KeyCode.Unknown,false,flag and (flag .. "__Keybind") or nil,flip)
    self._children[bind]=nil; c._children[bind]=true; bind._parent=c
    bind.container.Parent=c.container; bind.container.Visible=false
    bind._button.Parent=c.container
    bind._button.Size=UDim2.new(0,46,0,24); bind._button.Position=UDim2.new(1,-96,0.5,-12)
    bind._button.BackgroundTransparency=1
    bind._button.TextSize=9
    c._inlineBind=bind
    return c
end
function Control:Keybind(key)
    alive(self)
    assert(self._inlineBind,"JLXUI: this control has no inline keybind")
    self._inlineBind:Set(key)
    return self
end
function Section:SubToggle(title, default, flag, callback)
    local c = self:Toggle(title,default,flag,callback)
    c.container.Size=UDim2.new(1,0,0,26)
    c.container.BackgroundTransparency=1
    return c
end
function Section:Slider(title, default, maximum, minimum, increment, flag, callback)
    minimum, maximum, increment = minimum or 0, maximum or 100, increment or 1
    assert(finite(minimum) and finite(maximum) and maximum>minimum,"JLXUI: max must exceed min")
    assert(finite(increment) and increment>0,"JLXUI: increment must be positive")
    local c = valueControl(self,title,"Slider",flag,callback,48)
    c._title.Size=UDim2.new(1,-130,0,22)
    local box = text(c,c.container,"",{Size=UDim2.new(0,110,0,22),Position=UDim2.new(1,-120,0,0),
        TextXAlignment=Enum.TextXAlignment.Right,TextColor3=role("TextSub"),ClearTextOnFocus=false},"TextBox")
    local hit = text(c,c.container,"",{Size=UDim2.new(1,-20,0,24),Position=UDim2.new(0,10,0,23)},"TextButton")
    local rail=frame(c,hit,3); rail.Position=UDim2.new(0,0,0.5,-2)
    property(c,rail,"BackgroundColor3",role("Stroke")); rail.BackgroundTransparency=0; round(c,rail,2)
    local fill=frame(c,rail,3); fill.BackgroundTransparency=0; property(c,fill,"BackgroundColor3",role("Accent")); round(c,fill,2)
    local knob=frame(c,rail,9); knob.Size=UDim2.new(0,9,0,9); knob.AnchorPoint=Vector2.new(0.5,0.5)
    knob.BackgroundTransparency=0; property(c,knob,"BackgroundColor3",role("Text")); round(c,knob,5)
    local function display(value) return string.format("%.6g / %.6g",value,maximum) end
    c._set=function(control,value,silent)
        assert(finite(value),"JLXUI: Slider:Set expects a finite number")
        value=math.clamp(value,minimum,maximum)
        if value~=minimum and value~=maximum then
            value=math.clamp(minimum+math.floor((value-minimum)/increment+0.5)*increment,minimum,maximum)
        end
        local ratio=(value-minimum)/(maximum-minimum)
        local duration=(silent or (control._window._drag and control._window._drag.owner==control)) and 0 or 0.12
        animate(control,fill,{Size=UDim2.new(ratio,0,1,0)},duration,"value")
        animate(control,knob,{Position=UDim2.new(ratio,0,0.5,0)},duration,"value")
        if not box:IsFocused() then box.Text=display(value) end
        publish(control,value,silent)
    end
    c:Set(default or minimum,true)
    connect(c,box.Focused,function() box.Text=tostring(c.Value) end)
    connect(c,box.FocusLost,function()
        local value=tonumber(box.Text)
        if finite(value) then c:Set(value) end
        if not c.Destroyed then box.Text=display(c.Value) end
    end)
    drag(c,hit,function(input)
        local ratio=math.clamp((input.Position.X-hit.AbsolutePosition.X)/math.max(1,hit.AbsoluteSize.X),0,1)
        c:Set(minimum+(maximum-minimum)*ratio)
    end)
    return c
end
function Section:SliderFloat(title, default, maximum, minimum, increment, flag, callback)
    return self:Slider(title,default,maximum,minimum,increment or 0.01,flag,callback)
end

local function unique(options)
    assert(type(options)=="table","JLXUI: options must be an array of strings")
    local out, seen={},{}
    for _,v in ipairs(options) do
        assert(type(v)=="string","JLXUI: options must contain strings")
        if not seen[v] then out[#out+1]=v; seen[v]=true end
    end
    return out
end
local function dropdown(section,title,options,default,flag,callback,multi)
    options=unique(options)
    local c=valueControl(section,title,multi and "MultiDropdown" or "Dropdown",flag,callback,36)
    c.container.AutomaticSize=Enum.AutomaticSize.Y
    c.container.Size=UDim2.new(1,0,0,0)
    c._title:Destroy(); c._instances[c._title]=nil; c._themeBindings[c._title]=nil
    list(c,c.container,3)
    local head=text(c,c.container,"",{Size=UDim2.new(1,0,0,36),Position=UDim2.new()},"TextButton")
    c._title=text(c,head,title,{Size=UDim2.new(1,-155,1,0)})
    local valueBox=smallButton(c,head,"",138)
    local shown=text(c,valueBox,"None",{Size=UDim2.new(1,-30,1,0),Position=UDim2.new(0,8,0,0),
        TextColor3=role("TextSub"),TextSize=11})
    local arrow=text(c,valueBox,"›",{Size=UDim2.new(0,14,1,0),Position=UDim2.new(1,-20,0,0),
        Rotation=90,TextSize=17,TextXAlignment=Enum.TextXAlignment.Center})
    local viewport=frame(c,c.container,0,true)
    viewport.LayoutOrder=1; viewport.ClipsDescendants=true; viewport.Visible=false
    local menu=make(c,"ScrollingFrame",viewport,{Size=UDim2.new(1,0,1,0),CanvasSize=UDim2.new(),
        AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2,BackgroundTransparency=1,BorderSizePixel=0})
    list(c,menu,2)
    c._options,c._multi,c._menu=options,multi,viewport
    c._open=false
    c._resizeMenu=function(control)
        local height=math.min(180,#control._options*28+4)
        animate(control,viewport,{Size=UDim2.new(1,0,0,control._open and height or 0)},0.24,"expand",function()
            if not control._open then viewport.Visible=false end
        end)
    end
    c._toggleMenu=function(control,open)
        if open==nil then open=not control._open end
        control._open=open==true
        if control._open then viewport.Visible=true end
        animate(control,arrow,{Rotation=control._open and 270 or 90},0.22,"arrow")
        control:_resizeMenu()
    end
    local function paint()
        shown.Text=(multi and (#c.Value>0 and table.concat(c.Value,", ") or "None") or (c.Value~="" and c.Value or "None"))
        for option,button in pairs(c._optionButtons or {}) do
            local selected=multi and table.find(c.Value,option)~=nil or (not multi and c.Value==option)
            button.Text=(selected and "✓  " or "    ") .. option
            property(c._optionScope,button,"TextColor3",role(selected and "Accent" or "TextSub"))
        end
    end
    c._set=function(control,value,silent)
        if multi then
            assert(type(value)=="table","JLXUI: MultiDropdown:Set expects an array")
            local selected={}
            for _,v in ipairs(value) do
                assert(table.find(control._options,v),"JLXUI: unknown option: " .. tostring(v))
                if not table.find(selected,v) then selected[#selected+1]=v end
            end
            value=selected
        else
            assert(type(value)=="string" and (value=="" or table.find(control._options,value)),"JLXUI: unknown dropdown option")
        end
        publish(control,value,true); paint()
        if not silent then call(control._callback,snapshot(control.Value)) end
    end
    c._rebuild=function(control)
        if control._optionScope then control._optionScope:Destroy() end
        control._optionScope=node(Base,control,control._window)
        control._optionButtons={}
        for index,option in ipairs(control._options) do
            local b=text(control._optionScope,menu,option,{Size=UDim2.new(1,-8,0,26),Position=UDim2.new(),LayoutOrder=index},"TextButton")
            control._optionButtons[option]=b
            connect(control._optionScope,b.Activated,function()
                if multi then
                    local selected=copy(control.Value)
                    local at=table.find(selected,option)
                    if at then table.remove(selected,at) else selected[#selected+1]=option end
                    control:Set(selected)
                else
                    control:Set(option)
                end
            end)
        end
        paint()
        if control._open then control:_resizeMenu() end
    end
    c:Set(default or (multi and {} or ""),true)
    c:_rebuild()
    connect(c,head.Activated,function() c:ToggleDropdown() end)
    connect(c,valueBox.Activated,function() c:ToggleDropdown() end)
    return c
end
function Section:Dropdown(title,options,default,flag,callback)
    return dropdown(self,title,options,default,flag,callback,false)
end
function Section:MultiDropdown(title,options,default,flag,callback)
    return dropdown(self,title,options,default,flag,callback,true)
end
function Control:Refresh(options, deletecurrent)
    alive(self)
    assert(self._options,"JLXUI: Refresh is for dropdowns")
    local nextOptions=deletecurrent and {} or copy(self._options)
    for _,v in ipairs(unique(options)) do if not table.find(nextOptions,v) then nextOptions[#nextOptions+1]=v end end
    self._options=nextOptions
    local value=self.Value
    if self._multi then
        value={}
        for _,v in ipairs(self.Value) do if table.find(nextOptions,v) then value[#value+1]=v end end
    elseif not table.find(nextOptions,value) then value="" end
    self:Set(value,true)
    self:_rebuild()
    return self
end
function Control:ToggleDropdown(open)
    alive(self)
    assert(self._toggleMenu,"JLXUI: not a dropdown")
    self:_toggleMenu(open)
end

function Section:Textbox(title,disappear,callback)
    local c=valueControl(self,title,"Textbox",nil,callback,56)
    c._title.Size=UDim2.new(1,-20,0,22)
    local box=text(c,c.container,"",{Size=UDim2.new(1,-20,0,24),Position=UDim2.new(0,10,0,26),
        BackgroundTransparency=0,BackgroundColor3=role("Elevated"),ClearTextOnFocus=false,
        PlaceholderText="Enter text...",PlaceholderColor3=role("Muted")},"TextBox")
    round(c,box,4)
    c.textBox=box
    c._set=function(control,value,silent)
        box.Text=tostring(value)
        publish(control,box.Text,silent)
    end
    c:Set("",true)
    connect(c,box.FocusLost,function()
        local submitted=box.Text
        if disappear then box.Text="" end
        publish(c,submitted,false)
    end)
    return c
end
function Section:TextboxButton(title,buttonTitle,callback)
    local c=valueControl(self,title,"TextboxButton",nil,callback,56)
    c._title.Size=UDim2.new(1,-20,0,22)
    local box=text(c,c.container,"",{Size=UDim2.new(1,-116,0,24),Position=UDim2.new(0,10,0,26),BackgroundTransparency=0,BackgroundColor3=role("Elevated"),ClearTextOnFocus=false,PlaceholderText="Enter text...",PlaceholderColor3=role("Muted")},"TextBox")
    round(c,box,4); c.textBox=box
    local button=smallButton(c,c.container,buttonTitle or "SEND",92); button.Position=UDim2.new(1,-102,0,26); c.button=button
    attachRipple(c,button)
    c._set=function(control,value,silent) box.Text=tostring(value); publish(control,box.Text,silent) end
    c:Set("",true)
    connect(c,button.Activated,function() publish(c,box.Text,false) end)
    connect(c,box.FocusLost,function() publish(c,box.Text,false) end)
    return c
end
function Section:Bind(title,default,hold,flag,callback)
    local c=valueControl(self,title,"Bind",flag,callback)
    c._title.Size=UDim2.new(1,-110,1,0)
    c._button=smallButton(c,c.container,"None",90)
    c._hold=hold==true
    c._displayTitle=title
    c._set=function(control,value,silent)
        assert(typeof(value)=="EnumItem" and value.EnumType==Enum.KeyCode,"JLXUI: Bind:Set expects Enum.KeyCode")
        if control._held then control._held=false; call(control._callback,false) end
        if control.Destroyed then return end
        control._button.Text=value==Enum.KeyCode.Unknown and "NONE" or value.Name
        publish(control,value,true)
    end
    c:Set(default or Enum.KeyCode.Unknown,true)
    c._window._binds[c]=true
    if c._window._RefreshHotkeys then c._window:_RefreshHotkeys() end
    connect(c,c._button.Activated,function()
        cancelCapture(c._window)
        releaseHolds(c._window)
        if c.Destroyed then return end
        c._window._capture=c
        c._button.Text="Press key..."
    end)
    return c
end
function Section:Label(title)
    local c=valueControl(self,title,"Label")
    c.container.BackgroundTransparency=1
    c._set=function(control,value) control._title.Text=tostring(value); control.Value=tostring(value) end
    c:Set(title,true)
    return c
end

function Section:Colorpicker(title,default,flag,callback)
    local c=valueControl(self,title,"Colorpicker",flag,callback,195)
    c._title.Size=UDim2.new(0.6,0,0,26)
    local hex=text(c,c.container,"",{Size=UDim2.new(0.35,-10,0,26),Position=UDim2.new(0.65,0,0,0),
        TextXAlignment=Enum.TextXAlignment.Right,TextColor3=role("TextSub"),TextSize=11},"TextButton")
    local hexEdit=text(c,c.container,"",{Size=UDim2.new(0,92,0,24),Position=UDim2.new(1,-102,0,1),
        BackgroundTransparency=0,BackgroundColor3=role("Elevated"),TextColor3=role("Text"),
        ClearTextOnFocus=false,Visible=false,TextSize=11},"TextBox")
    round(c,hexEdit,4); stroke(c,hexEdit,role("Stroke"))
    local square=frame(c,c.container,118)
    square.Size=UDim2.new(1,-70,0,118); square.Position=UDim2.new(0,10,0,34)
    square.BackgroundTransparency=0
    local white=frame(c,square,0); white.Size=UDim2.new(1,0,1,0)
    property(c,white,"BackgroundColor3",Color3.new(1,1,1)); white.BackgroundTransparency=0
    make(c,"UIGradient",white,{Transparency=NumberSequence.new(0,1)})
    local black=frame(c,square,0); black.Size=UDim2.new(1,0,1,0)
    property(c,black,"BackgroundColor3",Color3.new(0,0,0)); black.BackgroundTransparency=0
    make(c,"UIGradient",black,{Transparency=NumberSequence.new(1,0),Rotation=90})
    local squareHit=text(c,square,"",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(),ZIndex=3},"TextButton")
    local dot=frame(c,square,10); dot.Size=UDim2.new(0,10,0,10); dot.AnchorPoint=Vector2.new(0.5,0.5)
    property(c,dot,"BackgroundColor3",Color3.new(1,1,1)); dot.BackgroundTransparency=0; dot.ZIndex=4
    round(c,dot,5); stroke(c,dot,Color3.new(0,0,0))
    local preview=frame(c,c.container,118); preview.Size=UDim2.new(0,44,0,118)
    preview.Position=UDim2.new(1,-54,0,34); preview.BackgroundTransparency=0; round(c,preview)
    local hue=text(c,c.container,"",{Size=UDim2.new(1,-20,0,18),Position=UDim2.new(0,10,1,-28),
        BackgroundTransparency=0,BackgroundColor3=Color3.new(1,1,1)},"TextButton")
    local colors={}
    for i=0,6 do colors[#colors+1]=ColorSequenceKeypoint.new(i/6,Color3.fromHSV(i/6,1,1)) end
    make(c,"UIGradient",hue,{Color=ColorSequence.new(colors)})
    local mark=frame(c,hue,22); mark.Size=UDim2.new(0,6,0,22); mark.AnchorPoint=Vector2.new(0.5,0.5)
    property(c,mark,"BackgroundColor3",Color3.new(1,1,1)); mark.BackgroundTransparency=0
    round(c,mark,3); stroke(c,mark,Color3.new(0,0,0))
    local h,s,v=0,0,1
    local function draw(control,value,silent)
        property(c,square,"BackgroundColor3",Color3.fromHSV(h,1,1))
        property(c,preview,"BackgroundColor3",value)
        dot.Position=UDim2.new(s,0,1-v,0); mark.Position=UDim2.new(h,0,0.5,0)
        hex.Text=string.format("#%02X%02X%02X",math.floor(value.R*255+0.5),math.floor(value.G*255+0.5),math.floor(value.B*255+0.5))
        hexEdit.Text=hex.Text
        publish(control,value,silent)
    end
    c._set=function(control,value,silent)
        assert(typeof(value)=="Color3","JLXUI: Colorpicker:Set expects Color3")
        h,s,v=value:ToHSV()
        draw(control,value,silent)
    end
    c:Set(default or Color3.new(1,1,1),true)
    connect(c,hex.Activated,function()
        hex.Visible=false; hexEdit.Visible=true; hexEdit:CaptureFocus()
    end)
    connect(c,hexEdit.FocusLost,function()
        local raw=hexEdit.Text:gsub("#",""):gsub("%s","")
        if #raw==3 then raw=raw:gsub("(.)","%1%1") end
        if raw:match("^%x%x%x%x%x%x$") then
            c:Set(Color3.fromRGB(tonumber(raw:sub(1,2),16),tonumber(raw:sub(3,4),16),tonumber(raw:sub(5,6),16)))
        end
        hexEdit.Visible=false; hex.Visible=true
    end)
    drag(c,squareHit,function(input)
        s=math.clamp((input.Position.X-square.AbsolutePosition.X)/math.max(1,square.AbsoluteSize.X),0,1)
        v=1-math.clamp((input.Position.Y-square.AbsolutePosition.Y)/math.max(1,square.AbsoluteSize.Y),0,1)
        draw(c,Color3.fromHSV(h,s,v),false)
    end)
    drag(c,hue,function(input)
        h=math.clamp((input.Position.X-hue.AbsolutePosition.X)/math.max(1,hue.AbsoluteSize.X),0,1)
        draw(c,Color3.fromHSV(h,s,v),false)
    end)
    return c
end

function Section:ColorPalette(title, colors, default, flag, callback)
    local c=valueControl(self,title,"ColorPalette",flag,callback,58)
    colors=colors or {Color3.fromRGB(239,68,68),Color3.fromRGB(245,158,11),Color3.fromRGB(250,204,21),Color3.fromRGB(34,197,94),Color3.fromRGB(6,182,212),Color3.fromRGB(59,130,246),Color3.fromRGB(168,85,247),Color3.fromRGB(236,72,153),Color3.fromRGB(255,255,255),Color3.fromRGB(156,163,175)}
    local row=make(c,"Frame",c.container,{Size=UDim2.new(1,-120,0,30),Position=UDim2.new(0,110,0.5,-15),BackgroundTransparency=1})
    local layout=make(c,"UIListLayout",row,{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,Padding=UDim.new(0,7)})
    c._set=function(control,value,silent)
        value=color3(value); assert(value,"JLXUI: palette value must be Color3")
        control.Value=value
        if control.Flag then control._window.Flags[control.Flag]=value end
        if control._preview then control._preview.BackgroundColor3=value end
        if not silent then call(control._callback,value) end
    end
    local preview=frame(c,c.container,28); preview.Size=UDim2.new(0,96,0,28); preview.Position=UDim2.new(1,-106,0.5,-14); preview.BackgroundTransparency=0
    round(c,preview,6); stroke(c,preview,role("Stroke")); c._preview=preview
    for _,color in ipairs(colors) do
        local swatch=frame(c,row,22); swatch.Size=UDim2.new(0,22,0,22); swatch.BackgroundTransparency=0; swatch.BackgroundColor3=color
        round(c,swatch,11); stroke(c,swatch,role("Stroke"))
        local hit=text(c,swatch,"",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(),BackgroundTransparency=1},"TextButton")
        connect(c,hit.Activated,function() c:Set(color) end)
    end
    c:Set(default or colors[1],true)
    return c
end
function Section:ColorDropdown(title, colors, default, flag, callback)
    local c=valueControl(self,title,"ColorDropdown",flag,callback,38)
    colors=colors or {Color3.fromRGB(239,68,68),Color3.fromRGB(245,158,11),Color3.fromRGB(250,204,21),Color3.fromRGB(34,197,94),Color3.fromRGB(6,182,212),Color3.fromRGB(59,130,246),Color3.fromRGB(168,85,247),Color3.fromRGB(236,72,153),Color3.fromRGB(255,255,255),Color3.fromRGB(156,163,175)}
    local preview=frame(c,c.container,22); preview.Size=UDim2.new(0,28,0,22); preview.Position=UDim2.new(1,-72,0.5,-11); preview.BackgroundTransparency=0; round(c,preview,6); c._preview=preview
    local value=text(c,c.container,"",{Size=UDim2.new(0,26,0,26),Position=UDim2.new(1,-40,0.5,-13),Text="⌄",TextXAlignment=Enum.TextXAlignment.Center,TextSize=14},"TextButton")
    local viewport=frame(c,c.container,0,true); viewport.Position=UDim2.new(0,0,1,2); viewport.Size=UDim2.new(1,0,0,0); viewport.ClipsDescendants=true; viewport.Visible=false; round(c,viewport,5); stroke(c,viewport,role("StrokeDim")); property(c,viewport,"BackgroundColor3",role("Card"))
    local row=make(c,"Frame",viewport,{Size=UDim2.new(1,-12,0,34),Position=UDim2.new(0,6,0,6),BackgroundTransparency=1})
    make(c,"UIListLayout",row,{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Left,Padding=UDim.new(0,7)})
    local open=false
    local function resize() viewport.Size=UDim2.new(1,0,0,open and 46 or 0) end
    local function setOpen(v) open=v; viewport.Visible=true; animate(c,viewport,{Size=UDim2.new(1,0,0,v and 46 or 0)},0.2,"dropdown",function() if not open then viewport.Visible=false end end); value.Text=v and "⌃" or "⌄" end
    connect(c,value.Activated,function() setOpen(not open) end)
    c._set=function(control,color,silent)
        color=color3(color); assert(color,"JLXUI: palette value must be Color3")
        control.Value=color; if control.Flag then control._window.Flags[control.Flag]=color end; preview.BackgroundColor3=color; if not silent then call(control._callback,color) end
    end
    for _,rawColor in ipairs(colors) do
        local color=color3(rawColor) or Color3.fromRGB(255,255,255)
        local sw=frame(c,row,24); sw.Size=UDim2.new(0,24,0,24); sw.BackgroundTransparency=0; sw.BackgroundColor3=color; round(c,sw,12); stroke(c,sw,role("Stroke")); local hit=text(c,sw,"",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(),BackgroundTransparency=1},"TextButton"); connect(c,hit.Activated,function() c:Set(color) end)
    end
    c:Set(default or colors[1],true)
    return c
end

function Section:CollapsibleGroup(title, expanded)
    local s=node(Section,self,self._window)
    s.container=autoFrame(s,self.content)
    local head=text(s,s.container,"",{Size=UDim2.new(1,0,0,32),Position=UDim2.new(),
        BackgroundTransparency=0.5,BackgroundColor3=role("Card")},"TextButton")
    round(s,head,s._window.Theme.CardRadius); stroke(s,head,role("StrokeDim"))
    s._title=text(s,head,title,{Position=UDim2.new(0,28,0,0),Size=UDim2.new(1,-38,1,0)})
    local arrow=text(s,head,">",{Size=UDim2.new(0,18,1,0),Position=UDim2.new(0,8,0,0),TextSize=16,TextXAlignment=Enum.TextXAlignment.Center})
    s._header=head
    s._arrow=arrow
    local viewport=frame(s,s.container,0,true); viewport.LayoutOrder=1; viewport.ClipsDescendants=true
    s.content=autoFrame(s,viewport)
    local contentLayout=s.content:FindFirstChildOfClass("UIListLayout")
    make(s,"UIPadding",s.content,{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,2)})
    s._expand=function(group,value)
        if value==nil then value=not group.Expanded end
        group.Expanded=value==true
        group.content.Visible=true
        animate(group,arrow,{Rotation=group.Expanded and 90 or 0},0.22,"arrow")
        if group._extraArrow and not group.ToggleControl.Destroyed then
            animate(group.ToggleControl,group._extraArrow,{Rotation=group.Expanded and 90 or 0},0.22,"arrow")
        end
        animate(group,viewport,{Size=UDim2.new(1,0,0,group.Expanded and contentLayout.AbsoluteContentSize.Y or 0)},0.28,"expand",function()
            if not group.Expanded then group.content.Visible=false end
        end)
    end
    connect(s,contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"),function()
        if s.Expanded then animate(s,viewport,{Size=UDim2.new(1,0,0,contentLayout.AbsoluteContentSize.Y)},0.16,"expand") end
    end)
    s:Expand(expanded==true)
    connect(s,s.container.Destroying,function() s:Destroy() end)
    connect(s,head.Activated,function() s:Expand() end)
    return s
end
function Section:Expand(value)
    alive(self)
    assert(self._expand,"JLXUI: this section is not collapsible")
    self:_expand(value)
end
function Section:CollapsibleToggle(title,default,flag,callback,key)
    local group=self:CollapsibleGroup(title,false)
    group:_JoinCard()
    group._header.Visible=false
    local toggle=group:Toggle(title,default,flag,callback,key)
    group.ToggleControl=toggle
    toggle.container.Parent=group.container; toggle.container.LayoutOrder=0
    toggle._title.Position=UDim2.new(0,28,0,0); toggle._title.Size=UDim2.new(1,-132,1,0)
    toggle._hit.Visible=false
    group._extraArrow=text(toggle,toggle.container,">",{Size=UDim2.new(0,20,1,0),Position=UDim2.new(0,5,0,0),TextSize=16,TextXAlignment=Enum.TextXAlignment.Center,ZIndex=5})
    local expandHit=text(toggle,toggle.container,"",{Size=UDim2.new(1,-100,1,0),Position=UDim2.new()},"TextButton")
    connect(toggle,expandHit.Activated,function() group:Expand() end)
    connect(toggle,toggle.container.Destroying,function() if not group.Destroyed then group:Destroy() end end)
    return group
end
function Section:_JoinCard()
    self._joined=true
    self.container.BackgroundTransparency=0.15
    property(self,self.container,"BackgroundColor3",role("Card"))
    round(self,self.container,self._window.Theme.CardRadius)
    stroke(self,self.container,role("StrokeDim"))
    self.container:FindFirstChildOfClass("UIListLayout").Padding=UDim.new(0,0)
    self.content:FindFirstChildOfClass("UIListLayout").Padding=UDim.new(0,0)
    local padding=self.content:FindFirstChildOfClass("UIPadding")
    if padding then padding.PaddingLeft=UDim.new(0,0); padding.PaddingRight=UDim.new(0,0) end
end
function Section:CheckboxToggle(title,default,flag,callback,key)
    local toggle=self:Toggle(title,default,flag,callback,key)
    cancelAnimations(toggle)
    toggle._pill.Visible=false
    toggle._switchHit.Visible=false
    toggle._title.Position=UDim2.new(0,40,0,0)
    toggle._title.Size=UDim2.new(1,-110,1,0)
    toggle._inlineBind._button.Position=UDim2.new(1,-56,0.5,-12)
    toggle._hit.Size=UDim2.new(1,-64,1,0)
    local box=make(toggle,"Frame",toggle.container,{Name="Checkbox",Size=UDim2.new(0,20,0,20),Position=UDim2.new(0,10,0.5,-10),BorderSizePixel=0,BackgroundColor3=role("Elevated")})
    round(toggle,box,4)
    local check=make(toggle,"Frame",box,{Name="Checkmark",Size=UDim2.new(0,14,0,14),Position=UDim2.new(0,3,0,3),BackgroundTransparency=1})
    make(toggle,"Frame",check,{Size=UDim2.new(0,6,0,2),Position=UDim2.new(0,1,0,7),Rotation=45,BorderSizePixel=0,BackgroundColor3=role("Bg")})
    make(toggle,"Frame",check,{Size=UDim2.new(0,10,0,2),Position=UDim2.new(0,4,0,6),Rotation=-45,BorderSizePixel=0,BackgroundColor3=role("Bg")})
    toggle._checkbox=box; toggle._checkmark=check
    toggle._set=function(control,value,silent)
        assert(type(value)=="boolean","JLXUI: checkbox expects boolean")
        check.Visible=value
        animate(control,box,{BackgroundColor3=role(value and "Text" or "Elevated")},silent and 0 or 0.18,"check")
        publish(control,value,silent)
    end
    toggle:Set(default==true,true)
    return toggle
end
function Section:CheckboxDropdown(title,default,flag,callback,key)
    local group=self:CollapsibleGroup(title,false)
    group:_JoinCard()
    group._header.Visible=false
    local toggle=group:CheckboxToggle(title,default,flag,callback,key)
    group.ToggleControl=toggle
    toggle.container.Parent=group.container; toggle.container.LayoutOrder=0
    toggle._hit.Size=UDim2.new(0,36,1,0)
    local expand=text(toggle,toggle.container,"",{Position=UDim2.new(0,36,0,0),Size=UDim2.new(1,-140,1,0)},"TextButton")
    local arrow=text(toggle,toggle.container,">",{Position=UDim2.new(1,-98,0,0),Size=UDim2.new(0,20,1,0),TextXAlignment=Enum.TextXAlignment.Center,Font=Enum.Font.Gotham})
    group._extraArrow=arrow
    connect(toggle,expand.Activated,function() group:Expand() end)
    return group
end
Section.MasterToggle=Section.CheckboxToggle
Section.ToggleWithDropdown=Section.CollapsibleToggle

function Window:_RefreshHotkeys()
    if not self._hotkeyOverlay then return end
    for _,row in ipairs(self._hotkeyRows or {}) do row:Destroy() end
    self._hotkeyRows={}
    if self.ShowActiveHotkeys==false then self._hotkeyOverlay.Visible=false; return end
    self._hotkeyOverlay.Visible=true
    for bind in pairs(self._binds) do
        if not bind.Destroyed and bind.Value and bind.Value~=Enum.KeyCode.Unknown then
            local row=node(Control,self,self); row.container=frame(row,self._hotkeyOverlay,20,true); row.container.Size=UDim2.new(1,0,0,20)
            text(row,row.container,bind._displayTitle or "Hotkey",{Size=UDim2.new(0.68,0,1,0),TextSize=10})
            text(row,row.container,bind.Value.Name,{Size=UDim2.new(0.3,0,1,0),Position=UDim2.new(0.68,0,0,0),TextXAlignment=Enum.TextXAlignment.Right,TextSize=10,TextColor3=role("TextSub")})
            self._hotkeyRows[#self._hotkeyRows+1]=row
        end
    end
end

function Window:Notification(title,message,duration,variant)
    alive(self)
    if not self.NotificationsEnabled then return nil end
    if type(duration)=="string" then variant=duration; duration=nil end
    duration=duration or self.NotificationDuration
    assert(finite(duration) and duration>=0,"JLXUI: duration must be nonnegative")
    if not self._notifications then
        self._notifications={}
        self._notificationHost=frame(self,self.Gui,0,true)
        self._notificationHost.Size=UDim2.new(0,320,0,0)
        self._notificationHost.Position=UDim2.new(0,10,0,10)
        local layout=list(self,self._notificationHost,8)
        layout.HorizontalAlignment=Enum.HorizontalAlignment.Left
        layout.VerticalAlignment=Enum.VerticalAlignment.Top
        self._notificationSequence=0
    end
    if #self._notifications>=5 then self._notifications[1]:Destroy() end
    local n=node(Control,self,self)
    local baseDestroy=Base.Destroy
    n.Destroy=function(notice)
        if notice.Destroyed then return end
        local at=table.find(self._notifications,notice)
        if at then table.remove(self._notifications,at) end
        baseDestroy(notice)
    end
    n._dismiss=function(notice)
        if notice._timer then pcall(task.cancel,notice._timer); notice._timer=nil end
        animate(notice,notice.container,{GroupTransparency=1},0.22,"entrance",function() notice:Destroy() end)
    end
    self._notificationSequence=self._notificationSequence+1
    n.container=frame(n,self._notificationHost,80,nil,"CanvasGroup")
    n.container.Size=UDim2.new(1,0,0,80)
    make(n,"UISizeConstraint",n.container,{MaxSize=Vector2.new(320,80)})
    n.container.LayoutOrder=self._notificationSequence
    property(n,n.container,"BackgroundColor3",role("Elevated")); n.container.BackgroundTransparency=0
    round(n,n.container,8); stroke(n,n.container,role("Stroke"))
    local variantColors={success=Color3.fromRGB(34,197,94),warning=Color3.fromRGB(245,158,11),error=Color3.fromRGB(239,68,68),info=role("Accent")}
    local accent=make(n,"Frame",n.container,{Size=UDim2.new(0,3,1,-12),Position=UDim2.new(0,5,0,6),BackgroundColor3=variantColors[string.lower(tostring(variant or "info"))] or role("Accent"),BorderSizePixel=0}); round(n,accent,2)
    text(n,n.container,title,{Size=UDim2.new(1,-42,0,26),Position=UDim2.new(0,16,0,0),TextSize=13,TextColor3=variantColors[string.lower(tostring(variant or "info"))] or role("Text")})
    text(n,n.container,message,{Size=UDim2.new(1,-20,0,44),Position=UDim2.new(0,10,0,28),
        TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,TextColor3=role("TextSub")})
    local close=smallButton(n,n.container,"×",24); close.Position=UDim2.new(1,-30,0,4)
    connect(n,close.Activated,function() n:Dismiss() end)
    self._notifications[#self._notifications+1]=n
    n.container.GroupTransparency=1
    animate(n,n.container,{GroupTransparency=0},0.24,"entrance")
    if duration>0 then
        n._timer=task.delay(duration,function()
            n._timer=nil
            if not n.Destroyed then n:Dismiss() end
        end)
    end
    return n
end
function Library:Notification(title,message,duration,variant)
    assert(self._last and not self._last.Destroyed,"JLXUI: create a window first")
    return self._last:Notification(title,message,duration,variant)
end
function Library:Destroy()
    while next(self._windows) do select(2,next(self._windows)):Destroy() end
end

local THEME_COLORS={"Accent","Bg","Sidebar","Card","CardHover","Elevated","Stroke","StrokeDim","Text","TextSub","Muted"}
function Window:_SyncConfiguration()
    local controls=self._configControls
    if not controls then return end
    local function set(name,value)
        local control=controls[name]
        if control and not control.Destroyed and control.Value~=value then control:Set(value,true) end
    end
    set("Theme",self.ThemeName)
    set("ToggleKey",self.ToggleKey)
    set("Scale",self.UserScale)
    set("Transparency",self.BackgroundTransparency)
    set("Notifications",self.NotificationsEnabled)
    set("Duration",self.NotificationDuration)
    set("Animations",self.Animations)
    for _,key in ipairs(THEME_COLORS) do set(key,self.Theme[key]) end
end
function Window:_ApplyTheme()
    local function apply(owner)
        cancelAnimations(owner,true)
        if owner.Destroyed then return end
        for obj,bindings in pairs(owner._themeBindings) do
            for prop,key in pairs(bindings) do obj[prop]=self.Theme[key] end
        end
        for child in pairs(owner._children) do apply(child) end
    end
    apply(self)
    self:_SyncConfiguration()
end
function Window:SetTheme(name)
    alive(self)
    assert(THEMES[name],"JLXUI: unknown theme: " .. tostring(name))
    for key,value in pairs(DEFAULT) do self.Theme[key]=value end
    for key,value in pairs(THEMES[name]) do self.Theme[key]=value end
    self.ThemeName=name
    self:_ApplyTheme()
end
function Window:SetColor(key,color)
    alive(self)
    assert(table.find(THEME_COLORS,key) and typeof(color)=="Color3","JLXUI: invalid theme color")
    self.Theme[key]=color
    self:_ApplyTheme()
end
function Window:SetScale(value)
    alive(self)
    assert(finite(value),"JLXUI: invalid scale")
    self.UserScale=math.clamp(value,0.65,1.25)
    self._fit()
end
function Window:SetAnimations(enabled)
    alive(self)
    self.Animations=enabled==true
    if not self.Animations then
        local function settle(owner)
            cancelAnimations(owner,true)
            if owner.Destroyed then return end
            local children={}
            for child in pairs(owner._children) do children[#children+1]=child end
            for _,child in ipairs(children) do if not child.Destroyed then settle(child) end end
        end
        settle(self)
    end
end
function Window:SetToggleKey(key)
    alive(self)
    assert(typeof(key)=="EnumItem" and key.EnumType==Enum.KeyCode,"JLXUI: expected Enum.KeyCode")
    self.ToggleKey=key
    local control=self._configControls and self._configControls.ToggleKey
    if control and not control.Destroyed and control.Value~=key then control:Set(key,true) end
end
function Window:ListConfigs()
    alive(self)
    configPath(self,"default") -- Validate the folder before accessing storage.
    local found={}
    for name in pairs(self._knownConfigs or {}) do found[name]=true end
    if self._storage.List then
        for _,path in ipairs(self._storage.List(self.FolderToSave or "JLXUI")) do
            local name=tostring(path):gsub("\\","/"):match("([^/]+)%.json$")
            if name and name:match("^[%w_%-]+$") then found[name]=true end
        end
    end
    local names={}
    for name in pairs(found) do names[#names+1]=name end
    table.sort(names)
    return names
end
function Window:_BuildConfiguration()
    local tab=self:Tab("Configuration","Settings")
    self._configTab=tab
    tab._button.LayoutOrder=1000000
    local controls={}
    self._configControls=controls
    local configs=tab:Section("Configurations")
    configs:Label(self.StorageMode=="Session only" and "Saves last for this session only" or "Storage: " .. self.StorageMode)
    local status=configs:Label("Ready")
    local name=configs:Textbox("Config name",false)
    name:Set("default",true)
    local chosen=configs:Dropdown("Saved configs",{},"",nil,function(value)
        if value~="" then name:Set(value,true) end
    end)
    local function refresh()
        chosen:Refresh(self:ListConfigs(),true)
    end
    local function action(fn)
        local ok,result=pcall(fn)
        if not status.Destroyed then status:Set(ok and (result or "Done") or tostring(result)) end
    end
    configs:Button("Save config",function() action(function()
        self:SaveConfig(name.textBox.Text)
        refresh()
        return "Saved: " .. name.textBox.Text
    end) end)
    configs:Button("Load config",function() action(function()
        local selected=name.textBox.Text
        local ok,errors=self:LoadConfig(selected,false)
        if not ok then return table.concat(errors,"; ") end
        return "Loaded: " .. selected
    end) end)
    configs:Button("Refresh configs",function() action(function() refresh(); return "Config list updated" end) end)
    local jsonBox=configs:Textbox("Config JSON (copy / paste)",false)
    jsonBox.textBox.MultiLine=true
    configs:Button("Export JSON",function() action(function()
        jsonBox:Set(self:ExportConfig(),true)
        return "Select the JSON text to copy it"
    end) end)
    configs:Button("Import JSON",function() action(function()
        local ok,errors=self:ImportConfig(jsonBox.textBox.Text,false)
        return ok and "Configuration imported" or table.concat(errors,"; ")
    end) end)
    action(function() refresh(); return "Ready" end)

    local appearance=tab:Section("Appearance")
    controls.Acrylic=appearance:Toggle("Acrylic (world blur)",false,nil,function(value) self:SetAcrylic(value) end)
    appearance:Label("Acrylic adds translucent glass and blurs the whole 3D view.")
    local names={"Default","Old","Neverlose","Cyberpunk","Vampire","Sakura","Emerald","Aquamarine","Primordial","Skeet"}
    controls.Theme=appearance:Dropdown("Theme",names,self.ThemeName,nil,function(value) self:SetTheme(value) end)
    local colors=appearance:CollapsibleGroup("Custom colors",false)
    for _,key in ipairs(THEME_COLORS) do
        controls[key]=colors:Colorpicker(key,self.Theme[key],nil,function(value) self:SetColor(key,value) end)
    end
    appearance:Button("Reset theme colors",function() self:SetTheme(self.ThemeName) end)
    controls.Scale=appearance:Slider("UI scale",self.UserScale,1.25,0.65,0.05,nil,function(value) self:SetScale(value) end)
    controls.Transparency=appearance:Slider("Background transparency",0,0.8,0,0.05,nil,function(value)
        self.BackgroundTransparency=value
        self:SetAcrylic(self.Acrylic)
    end)

    local settings=tab:Section("Interface")
    controls.ToggleKey=settings:Bind("PC toggle key",self.ToggleKey,false,nil)
    self._binds[controls.ToggleKey]=nil
    local originalSet=controls.ToggleKey._set
    controls.ToggleKey._set=function(control,value,silent)
        originalSet(control,value,silent)
        self:SetToggleKey(value)
    end
    settings:Label("Mobile: minimize, then tap Show to restore")
    controls.Animations=settings:Toggle("UI animations",self.Animations,nil,function(value) self:SetAnimations(value) end)
    controls.Notifications=settings:Toggle("Notifications",true,nil,function(value) self.NotificationsEnabled=value end)
    controls.Hotkeys=settings:Toggle("Show active hotkeys",self.ShowActiveHotkeys,nil,function(value) self.ShowActiveHotkeys=value; self:_RefreshHotkeys() end)
    controls.Duration=settings:Slider("Notification seconds",5,15,1,0.5,nil,function(value) self.NotificationDuration=value end)
    settings:Button("Hide UI",function() self:SetVisible(false) end)
    settings:Button("Destroy UI",function() self:Destroy() end)
    local maintenance=tab:Section("Maintenance & Exit")
    local reset=maintenance:Button("Reset to default settings",function() self:SetTheme("Default"); self:SetScale(1); self.NotificationsEnabled=true end)
    reset.ButtonColor=Color3.fromRGB(239,68,68)
    reset.HoverColor=Color3.fromRGB(255,88,88)
    if reset.button then property(reset,reset.button,"BackgroundColor3",reset.ButtonColor); reset.button.Text="RESET TO DEFAULT SETTINGS" end
    local unload=maintenance:Button("Unload script & destroy UI",function() self:Destroy() end)
    if unload.button then unload.button.Text="UNLOAD SCRIPT & DESTROY UI" end
end

function Window:ExportConfig()
    alive(self)
    local values={}
    for flag,c in pairs(self._flags) do
        local value=c:Get()
        if c.Kind=="Colorpicker" then value={value.R,value.G,value.B}
        elseif c.Kind=="Bind" then value=value.Name end
        values[flag]={kind=c.Kind,value=value}
    end
    local colors={}
    for _,key in ipairs(THEME_COLORS) do
        local c=self.Theme[key]
        colors[key]={c.R,c.G,c.B}
    end
    return Http:JSONEncode({version=1,values=values,ui={theme=self.ThemeName,colors=colors,
        toggleKey=self.ToggleKey.Name,scale=self.UserScale,transparency=self.BackgroundTransparency,
        notifications=self.NotificationsEnabled,duration=self.NotificationDuration,animations=self.Animations,acrylic=self.Acrylic}})
end
function Window:ImportConfig(json, silent)
    alive(self)
    local data=Http:JSONDecode(json)
    assert(type(data)=="table" and data.version==1 and type(data.values)=="table","JLXUI: invalid config")
    local errors={}
    if data.ui then
        local ok,err=pcall(function()
            local ui=data.ui
            assert(type(ui)=="table","invalid UI settings")
            if ui.theme then self:SetTheme(ui.theme) end
            if ui.colors then
                assert(type(ui.colors)=="table","invalid theme colors")
                for key,rgb in pairs(ui.colors) do
                    assert(table.find(THEME_COLORS,key) and type(rgb)=="table" and #rgb==3,"invalid theme color")
                    for _,v in ipairs(rgb) do assert(finite(v) and v>=0 and v<=1,"invalid color component") end
                    self.Theme[key]=Color3.new(rgb[1],rgb[2],rgb[3])
                end
            end
            if ui.toggleKey then self:SetToggleKey(Enum.KeyCode[ui.toggleKey]) end
            if ui.scale then self:SetScale(ui.scale) end
            if ui.transparency~=nil then
                assert(finite(ui.transparency),"invalid transparency")
                self.BackgroundTransparency=math.clamp(ui.transparency,0,0.8)
                self.container.BackgroundTransparency=self.BackgroundTransparency
            end
            if ui.notifications~=nil then
                assert(type(ui.notifications)=="boolean","invalid notification preference")
                self.NotificationsEnabled=ui.notifications
            end
            if ui.duration then
                assert(finite(ui.duration),"invalid duration")
                self.NotificationDuration=math.clamp(ui.duration,1,15)
            end
            if ui.animations~=nil then
                assert(type(ui.animations)=="boolean","invalid animation preference")
                self:SetAnimations(ui.animations)
            end
            self:_ApplyTheme()
            if ui.acrylic~=nil then self:SetAcrylic(ui.acrylic==true) end
        end)
        if not ok then errors[#errors+1]="Interface: " .. tostring(err) end
    end
    for flag,item in pairs(data.values) do
        local c=self._flags[flag]
        if c then
            local ok,err=pcall(function()
                assert(type(item)=="table" and item.kind==c.Kind,"control type changed")
                local value=item.value
                if c.Kind=="Colorpicker" then
                    assert(type(value)=="table" and #value==3,"invalid color")
                    for _,v in ipairs(value) do assert(finite(v) and v>=0 and v<=1,"invalid color component") end
                    value=Color3.new(value[1],value[2],value[3])
                elseif c.Kind=="Bind" then value=Enum.KeyCode[value] end
                c:Set(value,silent)
            end)
            if not ok then errors[#errors+1]=tostring(flag) .. ": " .. tostring(err) end
            if self.Destroyed then break end
        end
    end
    return #errors==0, errors
end
function Window:SaveConfig(name)
    alive(self)
    assert(self._storage and type(self._storage.Write)=="function","JLXUI: provide Storage.Write(path, json), or use ExportConfig()")
    local result=self._storage.Write(configPath(self,name),self:ExportConfig())
    self._knownConfigs=self._knownConfigs or {}
    self._knownConfigs[name or "default"]=true
    return result
end
function Window:LoadConfig(name,silent)
    alive(self)
    assert(self._storage and type(self._storage.Read)=="function","JLXUI: provide Storage.Read(path), or use ImportConfig()")
    return self:ImportConfig(self._storage.Read(configPath(self,name)),silent)
end
function Window:GetDebugStats()
    local stats={Objects=0,Connections=0,Instances=0,Timers=0,Bindings=0,Flags=0,Animations=0}
    if self.Destroyed then return stats end
    local function count(n)
        stats.Objects=stats.Objects+1
        for _,slots in pairs(n._animations) do
            for _ in pairs(slots) do stats.Animations=stats.Animations+1; stats.Connections=stats.Connections+1 end
        end
        for c in pairs(n._connections) do if c.Connected then stats.Connections=stats.Connections+1 end end
        for _ in pairs(n._instances) do stats.Instances=stats.Instances+1 end
        if n._timer then stats.Timers=stats.Timers+1 end
        for child in pairs(n._children) do count(child) end
    end
    count(self)
    for _ in pairs(self._binds) do stats.Bindings=stats.Bindings+1 end
    for _ in pairs(self._flags) do stats.Flags=stats.Flags+1 end
    return stats
end

Window.CreateTab, Window.createTab = Window.Tab, Window.Tab
Tab.CreateSection, Tab.createSection = Tab.Section, Tab.Section
Section.CreateSection, Section.createSection = Section.Section, Section.Section
for alias, method in pairs({createButton="Button",createToggle="Toggle",createSubToggle="SubToggle",
    createSlider="Slider",createSliderFloat="SliderFloat",createSelector="Dropdown",createDropdown="Dropdown",
    createInput="Textbox",createKeybindButton="Bind",createColorWheel="Colorpicker",createHueSlider="Colorpicker",
    createCollapsibleGroup="CollapsibleGroup",createCollapsibleHeader="CollapsibleGroup",
    createCollapsibleToggle="CollapsibleToggle",createLabel="Label"}) do
    Section[alias]=Section[method]
end
Section.ColorPicker, Section.ColorWheel, Section.HueSlider = Section.Colorpicker, Section.Colorpicker, Section.Colorpicker
Section.TextBox, Section.Input, Section.Selector = Section.Textbox, Section.Textbox, Section.Dropdown
Section.CollapsibleHeader = Section.CollapsibleGroup
Control.SetColor = Control.Set
Library.CreateWindow = Library.New
return Library
