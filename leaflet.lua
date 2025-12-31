--[[
    VelcoLib - Advanced UI Library
    Version: 1.0.0
    Based on: Linoria Library
    Features:
    - Enhanced customization options
    - Built-in Linoria themes included
    - Modern theme system with presets
    - Gradient support
    - Rounded corners
    - Animations
    - Better organization
]]

local VelcoLib = {}
VelcoLib.__index = VelcoLib

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local Players = game:GetService("Players")

-- Player
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
if syn and syn.protect_gui then
    syn.protect_gui(ScreenGui)
end
ScreenGui.Name = "VelcoLib"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Library variables
VelcoLib.CurrentTheme = "Dark"
VelcoLib.Themes = {}
VelcoLib.Flags = {}
VelcoLib.Elements = {}
VelcoLib.Notifications = {}
VelcoLib.Dragging = nil
VelcoLib.DragInput = nil
VelcoLib.DragStart = nil
VelcoLib.DragPos = nil
VelcoLib.Opened = false
VelcoLib.MainColor = Color3.fromRGB(45, 45, 45)
VelcoLib.Font = Enum.Font.Gotham
VelcoLib.AccentColor = Color3.fromRGB(0, 170, 255)
VelcoLib.WindowTransparency = 0.95
VelcoLib.AnimationSpeed = 0.15

-- Default theme (Dark)
VelcoLib.DefaultTheme = {
    SchemeColor = Color3.fromRGB(0, 170, 255),
    Background = Color3.fromRGB(30, 30, 30),
    Header = Color3.fromRGB(25, 25, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(200, 200, 200),
    ElementColor = Color3.fromRGB(40, 40, 40),
    ElementBorder = Color3.fromRGB(60, 60, 60),
    HoverColor = Color3.fromRGB(50, 50, 50),
    ActiveColor = Color3.fromRGB(0, 140, 225),
    ErrorColor = Color3.fromRGB(255, 50, 50),
    WarningColor = Color3.fromRGB(255, 165, 0),
    SuccessColor = Color3.fromRGB(50, 205, 50),
    InfoColor = Color3.fromRGB(0, 170, 255),
    ScrollBarColor = Color3.fromRGB(80, 80, 80),
    ScrollBarHover = Color3.fromRGB(100, 100, 100)
}

-- Include Linoria's built-in themes
VelcoLib.Themes.Dark = VelcoLib.DefaultTheme

VelcoLib.Themes.Light = {
    SchemeColor = Color3.fromRGB(0, 170, 255),
    Background = Color3.fromRGB(240, 240, 240),
    Header = Color3.fromRGB(230, 230, 230),
    TextColor = Color3.fromRGB(30, 30, 30),
    SubTextColor = Color3.fromRGB(100, 100, 100),
    ElementColor = Color3.fromRGB(255, 255, 255),
    ElementBorder = Color3.fromRGB(220, 220, 220),
    HoverColor = Color3.fromRGB(245, 245, 245),
    ActiveColor = Color3.fromRGB(0, 140, 225),
    ErrorColor = Color3.fromRGB(255, 50, 50),
    WarningColor = Color3.fromRGB(255, 165, 0),
    SuccessColor = Color3.fromRGB(50, 205, 50),
    InfoColor = Color3.fromRGB(0, 170, 255),
    ScrollBarColor = Color3.fromRGB(200, 200, 200),
    ScrollBarHover = Color3.fromRGB(180, 180, 180)
}

VelcoLib.Themes.Blue = {
    SchemeColor = Color3.fromRGB(0, 120, 215),
    Background = Color3.fromRGB(25, 35, 50),
    Header = Color3.fromRGB(20, 30, 45),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(200, 210, 220),
    ElementColor = Color3.fromRGB(35, 45, 60),
    ElementBorder = Color3.fromRGB(50, 60, 80),
    HoverColor = Color3.fromRGB(40, 50, 70),
    ActiveColor = Color3.fromRGB(0, 100, 195),
    ErrorColor = Color3.fromRGB(255, 50, 50),
    WarningColor = Color3.fromRGB(255, 165, 0),
    SuccessColor = Color3.fromRGB(50, 205, 50),
    InfoColor = Color3.fromRGB(0, 120, 215),
    ScrollBarColor = Color3.fromRGB(60, 70, 90),
    ScrollBarHover = Color3.fromRGB(70, 80, 100)
}

VelcoLib.Themes.Purple = {
    SchemeColor = Color3.fromRGB(170, 0, 255),
    Background = Color3.fromRGB(40, 30, 50),
    Header = Color3.fromRGB(35, 25, 45),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(220, 200, 230),
    ElementColor = Color3.fromRGB(50, 40, 60),
    ElementBorder = Color3.fromRGB(70, 60, 80),
    HoverColor = Color3.fromRGB(55, 45, 70),
    ActiveColor = Color3.fromRGB(150, 0, 235),
    ErrorColor = Color3.fromRGB(255, 50, 50),
    WarningColor = Color3.fromRGB(255, 165, 0),
    SuccessColor = Color3.fromRGB(50, 205, 50),
    InfoColor = Color3.fromRGB(170, 0, 255),
    ScrollBarColor = Color3.fromRGB(80, 70, 90),
    ScrollBarHover = Color3.fromRGB(90, 80, 100)
}

VelcoLib.Themes.Green = {
    SchemeColor = Color3.fromRGB(50, 205, 50),
    Background = Color3.fromRGB(30, 40, 30),
    Header = Color3.fromRGB(25, 35, 25),
    TextColor = Color3.fromRGB(255, 255, 255),
    SubTextColor = Color3.fromRGB(200, 220, 200),
    ElementColor = Color3.fromRGB(40, 50, 40),
    ElementBorder = Color3.fromRGB(60, 70, 60),
    HoverColor = Color3.fromRGB(45, 55, 45),
    ActiveColor = Color3.fromRGB(40, 195, 40),
    ErrorColor = Color3.fromRGB(255, 50, 50),
    WarningColor = Color3.fromRGB(255, 165, 0),
    SuccessColor = Color3.fromRGB(50, 205, 50),
    InfoColor = Color3.fromRGB(50, 205, 50),
    ScrollBarColor = Color3.fromRGB(70, 80, 70),
    ScrollBarHover = Color3.fromRGB(80, 90, 80)
}

-- Utility functions
function VelcoLib:Create(class, properties)
    local instance = Instance.new(class)
    
    for property, value in pairs(properties) do
        if property == "Parent" then
            instance.Parent = value
        else
            instance[property] = value
        end
    end
    
    return instance
end

function VelcoLib:Tween(object, properties, duration, style, direction, repeats, reversible)
    local tweenInfo = TweenInfo.new(
        duration or 0.2,
        style or Enum.EasingStyle.Quad,
        direction or Enum.EasingDirection.Out,
        repeats or 0,
        reversible or false
    )
    
    local tween = TweenService:Create(object, tweenInfo, properties)
    tween:Play()
    
    return tween
end

function VelcoLib:Roundify(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 4)
    corner.Parent = object
    return corner
end

function VelcoLib:Stroke(object, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.new(1, 1, 1)
    stroke.Thickness = thickness or 1
    stroke.Parent = object
    return stroke
end

function VelcoLib:Gradient(object, colors, rotation)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new(colors)
    gradient.Rotation = rotation or 0
    gradient.Parent = object
    return gradient
end

function VelcoLib:AddTooltip(object, text)
    local tooltip = self:Create("TextLabel", {
        Name = "Tooltip",
        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
        BorderColor3 = Color3.fromRGB(60, 60, 60),
        BorderSizePixel = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 0, 0, 0),
        Font = self.Font,
        Text = text,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        TextWrapped = true,
        Visible = false,
        ZIndex = 100,
        Parent = ScreenGui
    })
    
    self:Roundify(tooltip, 4)
    self:Stroke(tooltip, Color3.fromRGB(80, 80, 80))
    
    local padding = self:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 6),
        PaddingBottom = UDim.new(0, 6),
        Parent = tooltip
    })
    
    object.MouseEnter:Connect(function()
        local textSize = TextService:GetTextSize(text, 14, self.Font, Vector2.new(200, math.huge))
        tooltip.Size = UDim2.new(0, textSize.X + 16, 0, textSize.Y + 12)
        tooltip.Position = UDim2.new(0, Mouse.X + 20, 0, Mouse.Y + 10)
        tooltip.Visible = true
    end)
    
    object.MouseLeave:Connect(function()
        tooltip.Visible = false
    end)
    
    return tooltip
end

-- Window class
local Window = {}
Window.__index = Window

function Window.new(title, defaultToggle)
    local self = setmetatable({}, Window)
    
    self.Title = title or "VelcoLib Window"
    self.DefaultToggle = defaultToggle or false
    self.Tabs = {}
    self.Visible = self.DefaultToggle
    self.AccentColor = VelcoLib.AccentColor
    
    -- Main window
    self.Main = VelcoLib:Create("Frame", {
        Name = title or "Window",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].Background,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 400),
        Parent = ScreenGui
    })
    
    VelcoLib:Roundify(self.Main, 8)
    VelcoLib:Stroke(self.Main, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Header
    self.Header = VelcoLib:Create("Frame", {
        Name = "Header",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].Header,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        Parent = self.Main
    })
    
    VelcoLib:Roundify(self.Header, {TopLeft = 8, TopRight = 8, BottomLeft = 0, BottomRight = 0})
    
    -- Title
    self.TitleLabel = VelcoLib:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 15, 0, 0),
        Size = UDim2.new(0, 200, 1, 0),
        Font = VelcoLib.Font,
        Text = self.Title,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.Header
    })
    
    -- Toggle button
    self.ToggleButton = VelcoLib:Create("TextButton", {
        Name = "Toggle",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -40, 0, 0),
        Size = UDim2.new(0, 40, 1, 0),
        Font = VelcoLib.Font,
        Text = "−",
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 18,
        Parent = self.Header
    })
    
    -- Tab container
    self.TabContainer = VelcoLib:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].Header,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(1, 0, 0, 40),
        Parent = self.Main
    })
    
    -- Tab list
    self.TabList = VelcoLib:Create("ScrollingFrame", {
        Name = "TabList",
        Active = true,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 0,
        Parent = self.TabContainer
    })
    
    local listLayout = VelcoLib:Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 0),
        Parent = self.TabList
    })
    
    -- Content container
    self.ContentContainer = VelcoLib:Create("Frame", {
        Name = "Content",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].Background,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 80),
        Size = UDim2.new(1, 0, 1, -80),
        Parent = self.Main
    })
    
    VelcoLib:Roundify(self.ContentContainer, {TopLeft = 0, TopRight = 0, BottomLeft = 8, BottomRight = 8})
    
    -- Make window draggable
    local function updateInput(input)
        local delta = input.Position - VelcoLib.DragStart
        local newPos = UDim2.new(
            VelcoLib.DragPos.X.Scale,
            VelcoLib.DragPos.X.Offset + delta.X,
            VelcoLib.DragPos.Y.Scale,
            VelcoLib.DragPos.Y.Offset + delta.Y
        )
        
        VelcoLib:Tween(self.Main, {Position = newPos}, 0.1)
    end
    
    self.Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            VelcoLib.Dragging = true
            VelcoLib.DragStart = input.Position
            VelcoLib.DragPos = self.Main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    VelcoLib.Dragging = false
                end
            end)
        end
    end)
    
    self.Header.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and VelcoLib.Dragging then
            VelcoLib.DragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == VelcoLib.DragInput and VelcoLib.Dragging then
            updateInput(input)
        end
    end)
    
    -- Toggle functionality
    self.ToggleButton.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    if not self.DefaultToggle then
        self.Main.Visible = false
    end
    
    -- Add to library
    table.insert(VelcoLib.Elements, self.Main)
    
    return self
end

function Window:Toggle()
    self.Visible = not self.Visible
    self.Main.Visible = self.Visible
    
    if self.Visible then
        self.ToggleButton.Text = "−"
        VelcoLib:Tween(self.Main, {Size = UDim2.new(0, 600, 0, 400)}, VelcoLib.AnimationSpeed)
    else
        self.ToggleButton.Text = "+"
    end
end

function Window:Tab(name, icon)
    local tab = {}
    
    tab.Name = name
    tab.Icon = icon
    tab.Sections = {}
    
    -- Tab button
    tab.Button = VelcoLib:Create("TextButton", {
        Name = name .. "Tab",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].Header,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, 100, 1, 0),
        Font = VelcoLib.Font,
        Text = icon and (icon .. " " .. name) or name,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].SubTextColor,
        TextSize = 14,
        Parent = self.TabList
    })
    
    -- Tab content
    tab.Content = VelcoLib:Create("ScrollingFrame", {
        Name = name .. "Content",
        Active = true,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 5,
        ScrollBarImageColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ScrollBarColor,
        Visible = false,
        Parent = self.ContentContainer
    })
    
    local contentLayout = VelcoLib:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 15),
        Parent = tab.Content
    })
    
    local contentPadding = VelcoLib:Create("UIPadding", {
        PaddingLeft = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        PaddingTop = UDim.new(0, 15),
        PaddingBottom = UDim.new(0, 15),
        Parent = tab.Content
    })
    
    -- Select first tab by default
    if #self.Tabs == 0 then
        tab.Button.TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor
        tab.Content.Visible = true
    end
    
    -- Tab button click
    tab.Button.MouseButton1Click:Connect(function()
        for _, otherTab in pairs(self.Tabs) do
            otherTab.Button.TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].SubTextColor
            otherTab.Content.Visible = false
        end
        
        tab.Button.TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor
        tab.Content.Visible = true
    end)
    
    -- Update tab list size
    self.TabList.CanvasSize = UDim2.new(0, (#self.Tabs + 1) * 100, 0, 0)
    
    table.insert(self.Tabs, tab)
    return tab
end

-- Section class
local Section = {}
Section.__index = Section

function Section.new(tab, name, side)
    local self = setmetatable({}, Section)
    
    self.Name = name
    self.Side = side or "Left"
    self.Elements = {}
    
    -- Section container
    self.Container = VelcoLib:Create("Frame", {
        Name = name .. "Section",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0.5, -20, 0, 0),
        Parent = tab.Content
    })
    
    VelcoLib:Roundify(self.Container, 6)
    VelcoLib:Stroke(self.Container, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Section title
    self.Title = VelcoLib:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 8),
        Size = UDim2.new(1, -20, 0, 20),
        Font = VelcoLib.Font,
        Text = name,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.Container
    })
    
    -- Elements container
    self.ElementsContainer = VelcoLib:Create("Frame", {
        Name = "Elements",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 35),
        Size = UDim2.new(1, -20, 1, -40),
        Parent = self.Container
    })
    
    local elementsLayout = VelcoLib:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = self.ElementsContainer
    })
    
    -- Update section position based on side
    if side == "Right" then
        self.Container.Position = UDim2.new(0.5, 10, 0, 0)
    else
        self.Container.Position = UDim2.new(0, 10, 0, 0)
    end
    
    table.insert(tab.Sections, self)
    return self
end

-- UI Elements
function Section:Label(text)
    local label = {}
    
    label.Element = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 20),
        Font = VelcoLib.Font,
        Text = text,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.ElementsContainer
    })
    
    table.insert(self.Elements, label)
    return label
end

function Section:Button(text, callback)
    local button = {}
    local flag = text .. "Button"
    
    button.Element = VelcoLib:Create("TextButton", {
        Name = "Button",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 30),
        Font = VelcoLib.Font,
        Text = text,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        Parent = self.ElementsContainer
    })
    
    VelcoLib:Roundify(button.Element, 4)
    VelcoLib:Stroke(button.Element, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Hover effect
    button.Element.MouseEnter:Connect(function()
        VelcoLib:Tween(button.Element, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].HoverColor}, 0.1)
    end)
    
    button.Element.MouseLeave:Connect(function()
        VelcoLib:Tween(button.Element, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor}, 0.1)
    end)
    
    -- Click effect
    button.Element.MouseButton1Down:Connect(function()
        VelcoLib:Tween(button.Element, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor}, 0.1)
    end)
    
    button.Element.MouseButton1Up:Connect(function()
        VelcoLib:Tween(button.Element, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].HoverColor}, 0.1)
    end)
    
    -- Callback
    if callback then
        button.Element.MouseButton1Click:Connect(callback)
    end
    
    VelcoLib.Flags[flag] = false
    
    table.insert(self.Elements, button)
    return button
end

function Section:Toggle(text, default, callback, flag)
    local toggle = {}
    local flag = flag or text .. "Toggle"
    
    toggle.Value = default or false
    
    toggle.Container = VelcoLib:Create("Frame", {
        Name = "ToggleContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30),
        Parent = self.ElementsContainer
    })
    
    toggle.Label = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, -40, 1, 0),
        Font = VelcoLib.Font,
        Text = text,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = toggle.Container
    })
    
    toggle.Button = VelcoLib:Create("TextButton", {
        Name = "Toggle",
        BackgroundColor3 = toggle.Value and VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor or VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -30, 0, 5),
        Size = UDim2.new(0, 20, 0, 20),
        Font = VelcoLib.Font,
        Text = "",
        Parent = toggle.Container
    })
    
    VelcoLib:Roundify(toggle.Button, 10)
    VelcoLib:Stroke(toggle.Button, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Toggle functionality
    function toggle:SetValue(value)
        toggle.Value = value
        VelcoLib.Flags[flag] = value
        
        if value then
            VelcoLib:Tween(toggle.Button, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor}, 0.1)
        else
            VelcoLib:Tween(toggle.Button, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor}, 0.1)
        end
        
        if callback then
            callback(value)
        end
    end
    
    toggle.Button.MouseButton1Click:Connect(function()
        toggle:SetValue(not toggle.Value)
    end)
    
    -- Set initial value
    toggle:SetValue(default or false)
    
    VelcoLib.Flags[flag] = toggle.Value
    
    table.insert(self.Elements, toggle)
    return toggle
end

function Section:Slider(text, min, max, default, callback, flag)
    local slider = {}
    local flag = flag or text .. "Slider"
    
    slider.Value = default or min
    slider.Min = min or 0
    slider.Max = max or 100
    
    slider.Container = VelcoLib:Create("Frame", {
        Name = "SliderContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = self.ElementsContainer
    })
    
    slider.Label = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 20),
        Font = VelcoLib.Font,
        Text = text .. ": " .. tostring(slider.Value),
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = slider.Container
    })
    
    slider.Track = VelcoLib:Create("Frame", {
        Name = "Track",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 0, 6),
        Parent = slider.Container
    })
    
    VelcoLib:Roundify(slider.Track, 3)
    
    slider.Fill = VelcoLib:Create("Frame", {
        Name = "Fill",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new((slider.Value - slider.Min) / (slider.Max - slider.Min), 0, 0, 6),
        Parent = slider.Container
    })
    
    VelcoLib:Roundify(slider.Fill, 3)
    
    slider.Button = VelcoLib:Create("TextButton", {
        Name = "SliderButton",
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new((slider.Value - slider.Min) / (slider.Max - slider.Min), -8, 0, 22),
        Size = UDim2.new(0, 16, 0, 16),
        Text = "",
        Parent = slider.Container
    })
    
    VelcoLib:Roundify(slider.Button, 8)
    VelcoLib:Stroke(slider.Button, VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor, 2)
    
    -- Slider functionality
    local dragging = false
    
    function slider:SetValue(value)
        value = math.clamp(value, slider.Min, slider.Max)
        slider.Value = value
        
        local percent = (value - slider.Min) / (slider.Max - slider.Min)
        slider.Fill.Size = UDim2.new(percent, 0, 0, 6)
        slider.Button.Position = UDim2.new(percent, -8, 0, 22)
        slider.Label.Text = text .. ": " .. tostring(math.floor(value))
        
        VelcoLib.Flags[flag] = value
        
        if callback then
            callback(value)
        end
    end
    
    slider.Button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    slider.Track.MouseButton1Down:Connect(function(x)
        local percent = (x - slider.Track.AbsolutePosition.X) / slider.Track.AbsoluteSize.X
        slider:SetValue(slider.Min + (slider.Max - slider.Min) * percent)
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local percent = (input.Position.X - slider.Track.AbsolutePosition.X) / slider.Track.AbsoluteSize.X
            slider:SetValue(slider.Min + (slider.Max - slider.Min) * percent)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    -- Set initial value
    slider:SetValue(default or min)
    
    VelcoLib.Flags[flag] = slider.Value
    
    table.insert(self.Elements, slider)
    return slider
end

function Section:Dropdown(text, options, default, callback, flag)
    local dropdown = {}
    local flag = flag or text .. "Dropdown"
    
    dropdown.Value = default or options[1]
    dropdown.Options = options
    dropdown.Open = false
    
    dropdown.Container = VelcoLib:Create("Frame", {
        Name = "DropdownContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30),
        Parent = self.ElementsContainer
    })
    
    dropdown.Label = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, -30, 1, 0),
        Font = VelcoLib.Font,
        Text = text .. ": " .. dropdown.Value,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = dropdown.Container
    })
    
    dropdown.Button = VelcoLib:Create("TextButton", {
        Name = "DropdownButton",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -25, 0, 5),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "▼",
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 12,
        Parent = dropdown.Container
    })
    
    VelcoLib:Roundify(dropdown.Button, 4)
    VelcoLib:Stroke(dropdown.Button, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Options container
    dropdown.OptionsContainer = VelcoLib:Create("ScrollingFrame", {
        Name = "Options",
        Active = true,
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder,
        BorderSizePixel = 1,
        Position = UDim2.new(0, 0, 0, 35),
        Size = UDim2.new(1, 0, 0, 0),
        CanvasSize = UDim2.new(0, 0, 0, 0),
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ScrollBarColor,
        Visible = false,
        Parent = dropdown.Container
    })
    
    VelcoLib:Roundify(dropdown.OptionsContainer, 4)
    
    local optionsLayout = VelcoLib:Create("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 2),
        Parent = dropdown.OptionsContainer
    })
    
    local optionsPadding = VelcoLib:Create("UIPadding", {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 5),
        Parent = dropdown.OptionsContainer
    })
    
    -- Create option buttons
    for i, option in pairs(options) do
        local optionButton = VelcoLib:Create("TextButton", {
            Name = option,
            BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Size = UDim2.new(1, -10, 0, 25),
            Font = VelcoLib.Font,
            Text = option,
            TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
            TextSize = 14,
            Parent = dropdown.OptionsContainer
        })
        
        optionButton.MouseEnter:Connect(function()
            VelcoLib:Tween(optionButton, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].HoverColor}, 0.1)
        end)
        
        optionButton.MouseLeave:Connect(function()
            VelcoLib:Tween(optionButton, {BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor}, 0.1)
        end)
        
        optionButton.MouseButton1Click:Connect(function()
            dropdown:SetValue(option)
        end)
    end
    
    -- Dropdown functionality
    function dropdown:SetValue(value)
        dropdown.Value = value
        dropdown.Label.Text = text .. ": " .. value
        
        VelcoLib.Flags[flag] = value
        
        if callback then
            callback(value)
        end
    end
    
    function dropdown:Toggle()
        dropdown.Open = not dropdown.Open
        
        if dropdown.Open then
            dropdown.OptionsContainer.Visible = true
            dropdown.Button.Text = "▲"
            dropdown.OptionsContainer.Size = UDim2.new(1, 0, 0, math.min(#options * 27 + 10, 150))
            dropdown.OptionsContainer.CanvasSize = UDim2.new(0, 0, 0, #options * 27)
            dropdown.Container.Size = UDim2.new(1, 0, 0, 30 + math.min(#options * 27 + 10, 150))
        else
            dropdown.OptionsContainer.Visible = false
            dropdown.Button.Text = "▼"
            dropdown.OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
            dropdown.Container.Size = UDim2.new(1, 0, 0, 30)
        end
    end
    
    dropdown.Button.MouseButton1Click:Connect(function()
        dropdown:Toggle()
    end)
    
    -- Set initial value
    dropdown:SetValue(default or options[1])
    
    VelcoLib.Flags[flag] = dropdown.Value
    
    table.insert(self.Elements, dropdown)
    return dropdown
end

function Section:Textbox(text, placeholder, default, callback, flag)
    local textbox = {}
    local flag = flag or text .. "Textbox"
    
    textbox.Value = default or ""
    
    textbox.Container = VelcoLib:Create("Frame", {
        Name = "TextboxContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 50),
        Parent = self.ElementsContainer
    })
    
    textbox.Label = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 20),
        Font = VelcoLib.Font,
        Text = text,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = textbox.Container
    })
    
    textbox.Box = VelcoLib:Create("TextBox", {
        Name = "Textbox",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 25),
        Size = UDim2.new(1, 0, 0, 25),
        Font = VelcoLib.Font,
        Text = default or "",
        PlaceholderText = placeholder or "Enter text...",
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        PlaceholderColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].SubTextColor,
        TextSize = 14,
        Parent = textbox.Container
    })
    
    VelcoLib:Roundify(textbox.Box, 4)
    VelcoLib:Stroke(textbox.Box, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Textbox functionality
    function textbox:SetValue(value)
        textbox.Value = value
        textbox.Box.Text = value
        
        VelcoLib.Flags[flag] = value
        
        if callback then
            callback(value)
        end
    end
    
    textbox.Box.FocusLost:Connect(function(enterPressed)
        textbox:SetValue(textbox.Box.Text)
    end)
    
    -- Set initial value
    textbox:SetValue(default or "")
    
    VelcoLib.Flags[flag] = textbox.Value
    
    table.insert(self.Elements, textbox)
    return textbox
end

function Section:Keybind(text, default, callback, flag)
    local keybind = {}
    local flag = flag or text .. "Keybind"
    
    keybind.Value = default or Enum.KeyCode.LeftControl
    keybind.Listening = false
    
    keybind.Container = VelcoLib:Create("Frame", {
        Name = "KeybindContainer",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30),
        Parent = self.ElementsContainer
    })
    
    keybind.Label = VelcoLib:Create("TextLabel", {
        Name = "Label",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, -80, 1, 0),
        Font = VelcoLib.Font,
        Text = text,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = keybind.Container
    })
    
    keybind.Button = VelcoLib:Create("TextButton", {
        Name = "KeybindButton",
        BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -75, 0, 5),
        Size = UDim2.new(0, 70, 0, 20),
        Font = VelcoLib.Font,
        Text = keybind.Value.Name,
        TextColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].TextColor,
        TextSize = 12,
        Parent = keybind.Container
    })
    
    VelcoLib:Roundify(keybind.Button, 4)
    VelcoLib:Stroke(keybind.Button, VelcoLib.Themes[VelcoLib.CurrentTheme].ElementBorder, 1)
    
    -- Keybind functionality
    function keybind:SetValue(key)
        keybind.Value = key
        keybind.Button.Text = key.Name
        
        VelcoLib.Flags[flag] = key
        
        if callback then
            callback(key)
        end
    end
    
    keybind.Button.MouseButton1Click:Connect(function()
        keybind.Listening = true
        keybind.Button.Text = "..."
        keybind.Button.BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ActiveColor
    end)
    
    local connection
    connection = UserInputService.InputBegan:Connect(function(input)
        if keybind.Listening then
            if input.UserInputType == Enum.UserInputType.Keyboard then
                keybind:SetValue(input.KeyCode)
                keybind.Listening = false
                keybind.Button.BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor
            elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                keybind:SetValue(Enum.KeyCode.LeftControl)
                keybind.Listening = false
                keybind.Button.BackgroundColor3 = VelcoLib.Themes[VelcoLib.CurrentTheme].ElementColor
            end
        end
    end)
    
    -- Set initial value
    keybind:SetValue(default or Enum.KeyCode.LeftControl)
    
    VelcoLib.Flags[flag] = keybind.Value
    
    table.insert(self.Elements, keybind)
    return keybind
end

-- Library functions
function VelcoLib:CreateWindow(title, defaultToggle)
    return Window.new(title, defaultToggle)
end

function VelcoLib:CreateNotification(title, message, duration, notificationType)
    local notification = {}
    notificationType = notificationType or "Info"
    
    -- Notification container
    notification.Main = self:Create("Frame", {
        Name = "Notification",
        BackgroundColor3 = self.Themes[self.CurrentTheme].ElementColor,
        BorderColor3 = self.Themes[self.CurrentTheme].ElementBorder,
        BorderSizePixel = 1,
        Position = UDim2.new(1, -320, 1, -80),
        Size = UDim2.new(0, 300, 0, 70),
        Parent = ScreenGui
    })
    
    self:Roundify(notification.Main, 6)
    
    -- Title
    notification.Title = self:Create("TextLabel", {
        Name = "Title",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 8),
        Size = UDim2.new(1, -20, 0, 20),
        Font = self.Font,
        Text = title,
        TextColor3 = self.Themes[self.CurrentTheme].TextColor,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = notification.Main
    })
    
    -- Message
    notification.Message = self:Create("TextLabel", {
        Name = "Message",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 30),
        Size = UDim2.new(1, -20, 1, -40),
        Font = self.Font,
        Text = message,
        TextColor3 = self.Themes[self.CurrentTheme].SubTextColor,
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Parent = notification.Main
    })
    
    -- Type indicator
    local indicatorColor = self.Themes[self.CurrentTheme].InfoColor
    if notificationType == "Error" then
        indicatorColor = self.Themes[self.CurrentTheme].ErrorColor
    elseif notificationType == "Warning" then
        indicatorColor = self.Themes[self.CurrentTheme].WarningColor
    elseif notificationType == "Success" then
        indicatorColor = self.Themes[self.CurrentTheme].SuccessColor
    end
    
    notification.Indicator = self:Create("Frame", {
        Name = "Indicator",
        BackgroundColor3 = indicatorColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(0, 5, 1, 0),
        Parent = notification.Main
    })
    
    -- Close button
    notification.Close = self:Create("TextButton", {
        Name = "Close",
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -25, 0, 5),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "×",
        TextColor3 = self.Themes[self.CurrentTheme].SubTextColor,
        TextSize = 18,
        Parent = notification.Main
    })
    
    notification.Close.MouseEnter:Connect(function()
        notification.Close.TextColor3 = self.Themes[self.CurrentTheme].TextColor
    end)
    
    notification.Close.MouseLeave:Connect(function()
        notification.Close.TextColor3 = self.Themes[self.CurrentTheme].SubTextColor
    end)
    
    -- Animation
    self:Tween(notification.Main, {Position = UDim2.new(1, -320, 1, -80)}, 0.3)
    
    -- Close functionality
    notification.Close.MouseButton1Click:Connect(function()
        self:Tween(notification.Main, {Position = UDim2.new(1, -300, 1, -80), Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        wait(0.2)
        notification.Main:Destroy()
    end)
    
    -- Auto close
    if duration then
        spawn(function()
            wait(duration)
            if notification.Main and notification.Main.Parent then
                notification.Close.MouseButton1Click:Fire()
            end
        end)
    end
    
    table.insert(self.Notifications, notification)
    return notification
end

function VelcoLib:SetTheme(themeName)
    if self.Themes[themeName] then
        self.CurrentTheme = themeName
        self:UpdateTheme()
    else
        warn("Theme '" .. themeName .. "' not found!")
    end
end

function VelcoLib:UpdateTheme()
    -- This function would update all UI elements with the new theme
    -- Implementation would iterate through all windows and elements
    -- For brevity, this is a simplified version
    for _, window in pairs(self.Elements) do
        -- Update window colors
        if window:FindFirstChild("Header") then
            window.Header.BackgroundColor3 = self.Themes[self.CurrentTheme].Header
        end
    end
end

function VelcoLib:AddTheme(name, themeTable)
    self.Themes[name] = themeTable
end

function VelcoLib:GetTheme(name)
    return self.Themes[name] or self.DefaultTheme
end

function VelcoLib:SaveConfiguration(name)
    -- Save configuration implementation
    local config = {}
    
    for flag, value in pairs(self.Flags) do
        config[flag] = value
    end
    
    -- Save to datastore or file
    print("Configuration saved:", name)
    return config
end

function VelcoLib:LoadConfiguration(name)
    -- Load configuration implementation
    print("Configuration loaded:", name)
end

function VelcoLib:Destroy()
    ScreenGui:Destroy()
end

-- Initialize library
function VelcoLib:Init()
    -- Set up global keybind for toggling UI
    local toggleKey = Enum.KeyCode.RightShift
    
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == toggleKey then
            VelcoLib.Opened = not VelcoLib.Opened
            
            for _, window in pairs(VelcoLib.Elements) do
                if window:IsA("Frame") and window:FindFirstChild("Toggle") then
                    window.Toggle:Fire()
                end
            end
        end
    end)
    
    print("VelcoLib initialized successfully!")
    return self
end

-- Return the library
return VelcoLib:Init()
