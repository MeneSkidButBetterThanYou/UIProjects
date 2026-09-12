local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Http = game:GetService("HttpService")

local Library = {Version = "1.1.0", _windows = {}, _sessionFiles = {}}
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
        _parent = parent, _window = window, _themeBindings = {},
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
local function property(owner, obj, key, value)
    local bindings = owner._themeBindings[obj]
    if type(value) == "table" and value._themeRole then
        if not bindings then bindings = {}; owner._themeBindings[obj] = bindings end
        bindings[key] = value._themeRole
        obj[key] = owner._window.Theme[value._themeRole]
    else
        if bindings then bindings[key] = nil end
        obj[key] = value
    end
end
local function make(owner, class, parent, props)
    local obj = Instance.new(class)
    owner._instances[obj] = true
    for k,v in pairs(props or {}) do property(owner,obj,k,v) end
    obj.Parent = parent
    return obj
end
local function round(owner, obj, radius)
    make(owner, "UICorner", obj, {CornerRadius = UDim.new(0, radius or 5)})
end
local function stroke(owner, obj, color)
    return make(owner, "UIStroke", obj, {Color = color, Thickness = 0.9})
end
local function frame(owner, parent, height, transparent)
    local theme = owner._window.Theme
    return make(owner, "Frame", parent, {
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
local function smallButton(owner, parent, title, width)
    local b = text(owner, parent, title, {
        Size = UDim2.new(0,width or 90,0,22), Position = UDim2.new(1,-(width or 90)-10,0.5,-11),
        TextXAlignment = Enum.TextXAlignment.Center, BackgroundTransparency = 0,
        BackgroundColor3=role("Elevated"), TextSize = 11,
    }, "TextButton")
    round(owner,b)
    stroke(owner,b,role("Stroke"))
    return b
end
local function hover(owner, obj)
    local theme = owner._window.Theme
    connect(owner, obj.MouseEnter, function() property(owner,obj,"BackgroundColor3",role("CardHover")) end)
    connect(owner, obj.MouseLeave, function() property(owner,obj,"BackgroundColor3",role("Card")) end)
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
        w._capture._button.Text = w._capture.Value.Name
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
    c.container = frame(c,section.content,height or 32)
    connect(c,c.container.Destroying,function() c:Destroy() end)
    round(c,c.container,w.Theme.CardRadius)
    stroke(c,c.container,role("StrokeDim"))
    hover(c,c.container)
    c._title = text(c,c.container,title)
    if flag and flag ~= "" then c.Flag = flag; w._flags[flag] = c end
    return c
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
    w.NotificationDuration, w.NotificationsEnabled = 5, true
    w.Flags, w._flags, w._tabs, w._binds = {}, {}, {}, {}
    w.ToggleKey = options.ToggleKey or Enum.KeyCode.RightShift
    w.FolderToSave = options.FolderToSave
    w._storage, w.StorageMode = getStorage(options.Storage)
    local width, height = options.Width or 720, options.Height or 470
    assert(finite(width) and width >= 400 and finite(height) and height >= 250, "JLXUI: window size is too small")
    w.Gui = make(w,"ScreenGui",parent,{Name=guiName,ResetOnSpawn=false,
        ZIndexBehavior=Enum.ZIndexBehavior.Sibling, DisplayOrder=options.DisplayOrder or 100})
    w.container = frame(w,w.Gui,height)
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
    w._fit = fit
    connect(w,viewport:GetPropertyChangedSignal("AbsoluteSize"),fit)
    fit()
    local title = text(w,w.container,options.Name or "JLXUI",{Size=UDim2.new(1,-150,0,38),TextSize=14})
    title.Active = true
    local minimize = smallButton(w,w.container,"−",28)
    minimize.Position = UDim2.new(1,-74,0,8)
    local close = smallButton(w,w.container,"×",28)
    close.Position = UDim2.new(1,-38,0,8)
    w._body = frame(w,w.container,height-46,true)
    w._body.Position = UDim2.new(0,0,0,40)
    w._sidebar = make(w,"ScrollingFrame",w._body,{Size=UDim2.new(0,160,1,-8),
        Position=UDim2.new(0,8,0,0), BackgroundColor3=role("Sidebar"),BorderSizePixel=0,
        CanvasSize=UDim2.new(),AutomaticCanvasSize=Enum.AutomaticSize.Y,ScrollBarThickness=2})
    round(w,w._sidebar,8)
    list(w,w._sidebar,4)
    w._content = frame(w,w._body,0,true)
    w._content.Size = UDim2.new(1,-190,1,-8)
    w._content.Position = UDim2.new(0,180,0,0)
    w._restore = text(w,w.Gui,"Show " .. (options.Name or "JLXUI"), {
        Size=UDim2.new(0,150,0,30),Position=UDim2.new(0,10,0.5,-15),
        TextXAlignment=Enum.TextXAlignment.Center,BackgroundTransparency=0,
        BackgroundColor3=role("Elevated"),Visible=false},"TextButton")
    round(w,w._restore)
    connect(w,minimize.Activated,function() w:SetVisible(false) end)
    connect(w,close.Activated,function() w:Destroy() end)
    connect(w,w._restore.Activated,function() w:SetVisible(true) end)
    local dragStart, startPos
    drag(w,title,function(input)
        local delta = input.Position - dragStart
        w.container.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,
            startPos.Y.Scale,startPos.Y.Offset+delta.Y)
    end,function(input) dragStart=input.Position; startPos=w.container.Position end)
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
        if processed or Input:GetFocusedTextBox() then return end
        if input.KeyCode == w.ToggleKey then w:SetVisible(not w.container.Visible); return end
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
    self._windows[id], self._last = w, w
    if options.Configuration ~= false then w:_BuildConfiguration() end
    return w
end
function Window:SetVisible(visible)
    alive(self)
    self.container.Visible = visible == true
    self._restore.Visible = not self.container.Visible
    self._drag=nil
    cancelCapture(self)
    releaseHolds(self)
end
function Window:ToggleUI() self:SetVisible(not self.container.Visible) end

function Window:Tab(title, icon)
    alive(self)
    local t = node(Tab,self,self)
    t._isTab, t.Name = true, tostring(title)
    self._tabs[t] = true
    t._button = text(t,self._sidebar,title,{Size=UDim2.new(1,-8,0,34),Position=UDim2.new(),
        BackgroundColor3=role("Card"),BackgroundTransparency=1},"TextButton")
    round(t,t._button,6)
    if icon and icon ~= "" then
        make(t,"ImageLabel",t._button,{Size=UDim2.new(0,16,0,16),Position=UDim2.new(0,8,0.5,-8),
            BackgroundTransparency=1,Image=tostring(icon),ImageColor3=role("Text")})
        t._button.Text = "       " .. tostring(title)
    end
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
function Tab:Select()
    alive(self)
    local w = self._window
    for tab in pairs(w._tabs) do
        tab.container.Visible = tab == self
        tab._button.BackgroundTransparency = tab == self and 0 or 1
        property(tab,tab._button,"TextColor3",role(tab == self and "Text" or "TextSub"))
    end
    w._activeTab = self
    w._drag = nil
    cancelCapture(w)
end
function Tab:Section(title)
    alive(self)
    local s = node(Section,self,self._window)
    s.container = autoFrame(s,self.content)
    s._title = text(s,s.container,string.upper(tostring(title)),{
        Size=UDim2.new(1,-8,0,22),Position=UDim2.new(),TextSize=11,TextColor3=role("TextSub")})
    s.content = autoFrame(s,s.container)
    s.content.LayoutOrder=1
    connect(s,s.container.Destroying,function() s:Destroy() end)
    return s
end
Section.Section = Tab.Section

function Section:Button(title, callback)
    local c = valueControl(self,title,"Button",nil,callback)
    c._title.Size = UDim2.new(1,-120,1,0)
    local b = smallButton(c,c.container,"TRIGGER")
    connect(c,b.Activated,function() c:Press() end)
    return c
end
function Section:Toggle(title, default, flag, callback)
    local c = valueControl(self,title,"Toggle",flag,callback)
    c._title.Position=UDim2.new(0,34,0,0)
    c._title.Size=UDim2.new(1,-44,1,0)
    local box = frame(c,c.container,16)
    box.Size=UDim2.new(0,16,0,16); box.Position=UDim2.new(0,10,0.5,-8)
    round(c,box,4); stroke(c,box,role("Stroke"))
    local check = text(c,box,"✓",{Size=UDim2.new(1,0,1,0),Position=UDim2.new(),TextSize=13,
        TextXAlignment=Enum.TextXAlignment.Center,TextColor3=role("Bg")})
    local hit = text(c,c.container,"",{Size=UDim2.new(1,0,1,0),Position=UDim2.new()},"TextButton")
    c._set = function(control, value, silent)
        assert(type(value)=="boolean","JLXUI: Toggle:Set expects a boolean")
        property(control,box,"BackgroundColor3",role(value and "Accent" or "Elevated"))
        box.BackgroundTransparency=value and 0 or 0.6
        check.Visible=value
        publish(control,value,silent)
    end
    c:Set(default == true,true)
    connect(c,hit.Activated,function() c:Set(not c.Value) end)
    return c
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
        fill.Size=UDim2.new(ratio,0,1,0); knob.Position=UDim2.new(ratio,0,0.5,0)
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
    local c=valueControl(section,title,multi and "MultiDropdown" or "Dropdown",flag,callback)
    c.container.AutomaticSize=Enum.AutomaticSize.Y
    c.container.Size=UDim2.new(1,0,0,0)
    c._title:Destroy(); c._instances[c._title]=nil; c._themeBindings[c._title]=nil
    list(c,c.container,3)
    local head=text(c,c.container,"",{Size=UDim2.new(1,0,0,32),Position=UDim2.new()},"TextButton")
    c._title=text(c,head,title,{Size=UDim2.new(1,-155,1,0)})
    local shown=text(c,head,"None  ▾",{Size=UDim2.new(0,135,1,0),Position=UDim2.new(1,-145,0,0),
        TextXAlignment=Enum.TextXAlignment.Right,TextColor3=role("TextSub")})
    local menu=autoFrame(c,c.container); menu.LayoutOrder=1; menu.Visible=false
    c._options,c._multi,c._menu=options,multi,menu
    local function paint()
        shown.Text=(multi and (#c.Value>0 and table.concat(c.Value,", ") or "None") or (c.Value~="" and c.Value or "None")) .. "  ▾"
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
                    menu.Visible=false
                    control:Set(option)
                end
            end)
        end
        paint()
    end
    c:Set(default or (multi and {} or ""),true)
    c:_rebuild()
    connect(c,head.Activated,function() menu.Visible=not menu.Visible end)
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
    assert(self._menu,"JLXUI: not a dropdown")
    if open==nil then open=not self._menu.Visible end
    self._menu.Visible=open==true
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
function Section:Bind(title,default,hold,flag,callback)
    local c=valueControl(self,title,"Bind",flag,callback)
    c._title.Size=UDim2.new(1,-110,1,0)
    c._button=smallButton(c,c.container,"None",90)
    c._hold=hold==true
    c._set=function(control,value,silent)
        assert(typeof(value)=="EnumItem" and value.EnumType==Enum.KeyCode,"JLXUI: Bind:Set expects Enum.KeyCode")
        if control._held then control._held=false; call(control._callback,false) end
        if control.Destroyed then return end
        control._button.Text=value.Name
        publish(control,value,true)
    end
    c:Set(default or Enum.KeyCode.Unknown,true)
    c._window._binds[c]=true
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
        TextXAlignment=Enum.TextXAlignment.Right,TextColor3=role("TextSub")})
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
        publish(control,value,silent)
    end
    c._set=function(control,value,silent)
        assert(typeof(value)=="Color3","JLXUI: Colorpicker:Set expects Color3")
        h,s,v=value:ToHSV()
        draw(control,value,silent)
    end
    c:Set(default or Color3.new(1,1,1),true)
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

function Section:CollapsibleGroup(title, expanded)
    local s=node(Section,self,self._window)
    s.container=autoFrame(s,self.content)
    local head=text(s,s.container,"",{Size=UDim2.new(1,0,0,32),Position=UDim2.new(),
        BackgroundTransparency=0.5,BackgroundColor3=role("Card")},"TextButton")
    round(s,head,s._window.Theme.CardRadius); stroke(s,head,role("StrokeDim"))
    s._title=text(s,head,title,{Position=UDim2.new(0,28,0,0),Size=UDim2.new(1,-38,1,0)})
    local arrow=text(s,head,"▸",{Size=UDim2.new(0,18,1,0),Position=UDim2.new(0,8,0,0)})
    s.content=autoFrame(s,s.container); s.content.LayoutOrder=1
    make(s,"UIPadding",s.content,{PaddingLeft=UDim.new(0,12),PaddingRight=UDim.new(0,2)})
    s._expand=function(group,value)
        if value==nil then value=not group.Expanded end
        group.Expanded=value==true
        group.content.Visible=group.Expanded
        arrow.Text=group.Expanded and "▾" or "▸"
    end
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
function Section:CollapsibleToggle(title,default,flag,callback)
    local group=self:CollapsibleGroup(title,false)
    group.ToggleControl=group:Toggle("Enabled",default,flag,callback)
    return group
end

function Window:Notification(title,message,duration)
    alive(self)
    if not self.NotificationsEnabled then return nil end
    duration=duration or self.NotificationDuration
    assert(finite(duration) and duration>=0,"JLXUI: duration must be nonnegative")
    if not self._notifications then
        self._notifications={}
        self._notificationHost=frame(self,self.Gui,0,true)
        self._notificationHost.Size=UDim2.new(0.9,0,1,-20)
        self._notificationHost.Position=UDim2.new(0.1,-10,0,10)
        local layout=list(self,self._notificationHost,8)
        layout.HorizontalAlignment=Enum.HorizontalAlignment.Right
        layout.VerticalAlignment=Enum.VerticalAlignment.Bottom
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
    self._notificationSequence=self._notificationSequence+1
    n.container=frame(n,self._notificationHost,80)
    n.container.Size=UDim2.new(1,0,0,80)
    make(n,"UISizeConstraint",n.container,{MaxSize=Vector2.new(320,80)})
    n.container.LayoutOrder=self._notificationSequence
    property(n,n.container,"BackgroundColor3",role("Elevated")); n.container.BackgroundTransparency=0
    round(n,n.container,8); stroke(n,n.container,role("Stroke"))
    text(n,n.container,title,{Size=UDim2.new(1,-42,0,26),TextSize=13})
    text(n,n.container,message,{Size=UDim2.new(1,-20,0,44),Position=UDim2.new(0,10,0,28),
        TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,TextColor3=role("TextSub")})
    local close=smallButton(n,n.container,"×",24); close.Position=UDim2.new(1,-30,0,4)
    connect(n,close.Activated,function() n:Destroy() end)
    self._notifications[#self._notifications+1]=n
    if duration>0 then
        n._timer=task.delay(duration,function()
            n._timer=nil
            if not n.Destroyed then n:Destroy() end
        end)
    end
    return n
end
function Library:Notification(title,message,duration)
    assert(self._last and not self._last.Destroyed,"JLXUI: create a window first")
    return self._last:Notification(title,message,duration)
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
    for _,key in ipairs(THEME_COLORS) do set(key,self.Theme[key]) end
end
function Window:_ApplyTheme()
    local function apply(owner)
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
function Window:SetToggleKey(key)
    alive(self)
    assert(typeof(key)=="EnumItem" and key.EnumType==Enum.KeyCode,"JLXUI: expected Enum.KeyCode")
    self.ToggleKey=key
    local control=self._configControls and self._configControls.ToggleKey
    if control and not control.Destroyed and control.Value~=key then control:Set(key,true) end
end
function Window:ListConfigs()
    alive(self)
    configPath(self,"default")
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
    local tab=self:Tab("Configuration")
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
        self.container.BackgroundTransparency=value
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
    controls.Notifications=settings:Toggle("Notifications",true,nil,function(value) self.NotificationsEnabled=value end)
    controls.Duration=settings:Slider("Notification seconds",5,15,1,0.5,nil,function(value) self.NotificationDuration=value end)
    settings:Button("Hide UI",function() self:SetVisible(false) end)
    settings:Button("Destroy UI",function() self:Destroy() end)
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
        notifications=self.NotificationsEnabled,duration=self.NotificationDuration}})
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
            self:_ApplyTheme()
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
    local stats={Objects=0,Connections=0,Instances=0,Timers=0,Bindings=0,Flags=0}
    if self.Destroyed then return stats end
    local function count(n)
        stats.Objects=stats.Objects+1
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

-- Friendly aliases use the SAME argument order as the documented colon API.
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
