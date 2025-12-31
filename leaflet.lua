--[[
    LeafletUI Library
    Modified from Octohook UI Library
    Mobile Supported & Enhanced Features
    Developed by tatar0071#0627
]]

-- // Load
local startupArgs = ({...})[1] or {}

if getgenv().LeafletUI ~= nil then
    getgenv().LeafletUI:Unload();
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local function gs(a)
    return game:GetService(a)
end

-- // Variables
local players, http, runservice, inputservice, tweenService, stats, actionservice, guiService = 
    gs('Players'), gs('HttpService'), gs('RunService'), gs('UserInputService'), gs('TweenService'), gs('Stats'), gs('ContextActionService'), gs('GuiService')
local localplayer = players.LocalPlayer

local setByConfig = false
local floor, ceil, huge, pi, clamp, min, max = math.floor, math.ceil, math.huge, math.pi, math.clamp, math.min, math.max
local c3new, fromrgb, fromhsv = Color3.new, Color3.fromRGB, Color3.fromHSV
local next, newInstance, newUDim2, newVector2, newColor3 = next, Instance.new, UDim2.new, Vector2.new, Color3.new
local isexecutorclosure = isexecutorclosure or is_synapse_function or is_sirhurt_closure or iskrnlclosure;
local executor = (
    syn and 'syn' or
    getexecutorname and getexecutorname() or
    'unknown'
)

local LeafletUI = {
    windows = {};
    indicators = {};
    flags = {};
    options = {};
    connections = {};
    drawings = {};
    instances = {};
    utility = {};
    notifications = {};
    tweens = {};
    theme = {};
    zindexOrder = {
        ['indicator'] = 950;
        ['window'] = 1000;
        ['dropdown'] = 1200;
        ['colorpicker'] = 1100;
        ['watermark'] = 1300;
        ['notification'] = 1400;
        ['cursor'] = 1500;
        ['mobile'] = 1600;
    },
    stats = {
        ['fps'] = 0;
        ['ping'] = 0;
    };
    images = {
        ['gradientp90'] = 'https://raw.githubusercontent.com/portallol/luna/main/modules/gradient90.png';
        ['gradientp45'] = 'https://raw.githubusercontent.com/portallol/luna/main/modules/gradient45.png';
        ['colorhue'] = 'https://raw.githubusercontent.com/portallol/luna/main/modules/lgbtqshit.png';
        ['colortrans'] = 'https://raw.githubusercontent.com/portallol/luna/main/modules/trans.png';
    };
    numberStrings = {['Zero'] = 0, ['One'] = 1, ['Two'] = 2, ['Three'] = 3, ['Four'] = 4, ['Five'] = 5, ['Six'] = 6, ['Seven'] = 7, ['Eight'] = 8, ['Nine'] = 9};
    signal = loadstring(game:HttpGet('https://raw.githubusercontent.com/Quenty/NevermoreEngine/main/src/signal/src/Shared/Signal.lua'))();
    open = false;
    opening = false;
    hasInit = false;
    cheatname = startupArgs.cheatname or 'leafletui';
    gamename = startupArgs.gamename or 'universal';
    fileext = startupArgs.fileext or '.txt';
    mobile = startupArgs.mobile or false;
    mobileControls = {};
}

LeafletUI.themes = {
    {
        name = 'Default',
        theme = {
            ['Accent']                    = fromrgb(255,135,255);
            ['Background']                = fromrgb(18,18,18);
            ['Border']                    = fromrgb(0,0,0);
            ['Border 1']                  = fromrgb(60,60,60);
            ['Border 2']                  = fromrgb(35,35,35);
            ['Border 3']                  = fromrgb(10,10,10);
            ['Primary Text']              = fromrgb(235,235,235);
            ['Group Background']          = fromrgb(35,35,35);
            ['Selected Tab Background']   = fromrgb(35,35,35);
            ['Unselected Tab Background'] = fromrgb(18,18,18);
            ['Selected Tab Text']         = fromrgb(245,245,245);
            ['Unselected Tab Text']       = fromrgb(145,145,145);
            ['Section Background']        = fromrgb(18,18,18);
            ['Option Text 1']             = fromrgb(245,245,245);
            ['Option Text 2']             = fromrgb(195,195,195);
            ['Option Text 3']             = fromrgb(145,145,145);
            ['Option Border 1']           = fromrgb(50,50,50);
            ['Option Border 2']           = fromrgb(0,0,0);
            ['Option Background']         = fromrgb(35,35,35);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Tokyo Night',
        theme = {
            ['Accent']                    = fromrgb(103,89,179);
            ['Background']                = fromrgb(22,22,31);
            ['Border']                    = fromrgb(0,0,0);
            ['Border 1']                  = fromrgb(50,50,50);
            ['Border 2']                  = fromrgb(24,25,37);
            ['Border 3']                  = fromrgb(10,10,10);
            ['Primary Text']              = fromrgb(235,235,235);
            ['Group Background']          = fromrgb(24,25,37);
            ['Selected Tab Background']   = fromrgb(24,25,37);
            ['Unselected Tab Background'] = fromrgb(22,22,31);
            ['Selected Tab Text']         = fromrgb(245,245,245);
            ['Unselected Tab Text']       = fromrgb(145,145,145);
            ['Section Background']        = fromrgb(22,22,31);
            ['Option Text 1']             = fromrgb(245,245,245);
            ['Option Text 2']             = fromrgb(195,195,195);
            ['Option Text 3']             = fromrgb(145,145,145);
            ['Option Border 1']           = fromrgb(50,50,50);
            ['Option Border 2']           = fromrgb(0,0,0);
            ['Option Background']         = fromrgb(24,25,37);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Nekocheat',
        theme = {
            ["Accent"]                    = fromrgb(226, 30, 112);
            ["Background"]                = fromrgb(18,18,18);
            ["Border"]                    = fromrgb(0,0,0);
            ["Border 1"]                  = fromrgb(60,60,60);
            ["Border 2"]                  = fromrgb(18,18,18);
            ["Border 3"]                  = fromrgb(10,10,10);
            ["Primary Text"]              = fromrgb(255,255,255);
            ["Group Background"]          = fromrgb(18,18,18);
            ["Selected Tab Background"]   = fromrgb(18,18,18);
            ["Unselected Tab Background"] = fromrgb(18,18,18);
            ["Selected Tab Text"]         = fromrgb(245,245,245);
            ["Unselected Tab Text"]       = fromrgb(145,145,145);
            ["Section Background"]        = fromrgb(18,18,18);
            ["Option Text 1"]             = fromrgb(255,255,255);
            ["Option Text 2"]             = fromrgb(255,255,255);
            ["Option Text 3"]             = fromrgb(255,255,255);
            ["Option Border 1"]           = fromrgb(50,50,50);
            ["Option Border 2"]           = fromrgb(0,0,0);
            ["Option Background"]         = fromrgb(23,23,23);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Nekocheat Blue',
        theme = {
            ["Accent"]                    = fromrgb(0, 247, 255);
            ["Background"]                = fromrgb(18,18,18);
            ["Border"]                    = fromrgb(0,0,0);
            ["Border 1"]                  = fromrgb(60,60,60);
            ["Border 2"]                  = fromrgb(18,18,18);
            ["Border 3"]                  = fromrgb(10,10,10);
            ["Primary Text"]              = fromrgb(255,255,255);
            ["Group Background"]          = fromrgb(18,18,18);
            ["Selected Tab Background"]   = fromrgb(18,18,18);
            ["Unselected Tab Background"] = fromrgb(18,18,18);
            ["Selected Tab Text"]         = fromrgb(245,245,245);
            ["Unselected Tab Text"]       = fromrgb(145,145,145);
            ["Section Background"]        = fromrgb(18,18,18);
            ["Option Text 1"]             = fromrgb(255,255,255);
            ["Option Text 2"]             = fromrgb(255,255,255);
            ["Option Text 3"]             = fromrgb(255,255,255);
            ["Option Border 1"]           = fromrgb(50,50,50);
            ["Option Border 2"]           = fromrgb(0,0,0);
            ["Option Background"]         = fromrgb(23,23,23);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Fatality',
        theme = {
            ['Accent']                    = fromrgb(197,7,83);
            ['Background']                = fromrgb(25,19,53);
            ['Border']                    = fromrgb(0,0,0);
            ['Border 1']                  = fromrgb(60,53,93);
            ['Border 2']                  = fromrgb(29,23,66);
            ['Border 3']                  = fromrgb(10,10,10);
            ['Primary Text']              = fromrgb(235,235,235);
            ['Group Background']          = fromrgb(29,23,66);
            ['Selected Tab Background']   = fromrgb(29,23,66);
            ['Unselected Tab Background'] = fromrgb(25,19,53);
            ['Selected Tab Text']         = fromrgb(245,245,245);
            ['Unselected Tab Text']       = fromrgb(145,145,145);
            ['Section Background']        = fromrgb(25,19,53);
            ['Option Text 1']             = fromrgb(245,245,245);
            ['Option Text 2']             = fromrgb(195,195,195);
            ['Option Text 3']             = fromrgb(145,145,145);
            ['Option Border 1']           = fromrgb(60,53,93);
            ['Option Border 2']           = fromrgb(0,0,0);
            ['Option Background']         = fromrgb(29,23,66);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Gamesense',
        theme = {
            ['Accent']                    = fromrgb(147,184,26);
            ['Background']                = fromrgb(17,17,17);
            ['Border']                    = fromrgb(0,0,0);
            ['Border 1']                  = fromrgb(47,47,47);
            ['Border 2']                  = fromrgb(17,17,17);
            ['Border 3']                  = fromrgb(10,10,10);
            ['Primary Text']              = fromrgb(235,235,235);
            ['Group Background']          = fromrgb(17,17,17);
            ['Selected Tab Background']   = fromrgb(17,17,17);
            ['Unselected Tab Background'] = fromrgb(17,17,17);
            ['Selected Tab Text']         = fromrgb(245,245,245);
            ['Unselected Tab Text']       = fromrgb(145,145,145);
            ['Section Background']        = fromrgb(17,17,17);
            ['Option Text 1']             = fromrgb(245,245,245);
            ['Option Text 2']             = fromrgb(195,195,195);
            ['Option Text 3']             = fromrgb(145,145,145);
            ['Option Border 1']           = fromrgb(47,47,47);
            ['Option Border 2']           = fromrgb(0,0,0);
            ['Option Background']         = fromrgb(35,35,35);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    {
        name = 'Twitch',
        theme = {
            ['Accent']                    = fromrgb(169,112,255);
            ['Background']                = fromrgb(14,14,14);
            ['Border']                    = fromrgb(0,0,0);
            ['Border 1']                  = fromrgb(45,45,45);
            ['Border 2']                  = fromrgb(31,31,35);
            ['Border 3']                  = fromrgb(10,10,10);
            ['Primary Text']              = fromrgb(235,235,235);
            ['Group Background']          = fromrgb(31,31,35);
            ['Selected Tab Background']   = fromrgb(31,31,35);
            ['Unselected Tab Background'] = fromrgb(17,17,17);
            ['Selected Tab Text']         = fromrgb(225,225,225);
            ['Unselected Tab Text']       = fromrgb(160,170,175);
            ['Section Background']        = fromrgb(17,17,17);
            ['Option Text 1']             = fromrgb(245,245,245);
            ['Option Text 2']             = fromrgb(195,195,195);
            ['Option Text 3']             = fromrgb(145,145,145);
            ['Option Border 1']           = fromrgb(45,45,45);
            ['Option Border 2']           = fromrgb(0,0,0);
            ['Option Background']         = fromrgb(24,24,27);
            ["Risky Text"]                = fromrgb(175, 21, 21);
            ["Risky Text Enabled"]        = fromrgb(255, 41, 41);
        }
    },
    -- New Themes
    {
        name = 'Midnight',
        theme = {
            ['Accent']                    = fromrgb(0, 150, 255);
            ['Background']                = fromrgb(10, 10, 20);
            ['Border']                    = fromrgb(0, 0, 0);
            ['Border 1']                  = fromrgb(40, 40, 60);
            ['Border 2']                  = fromrgb(20, 20, 30);
            ['Border 3']                  = fromrgb(5, 5, 10);
            ['Primary Text']              = fromrgb(240, 240, 255);
            ['Group Background']          = fromrgb(20, 20, 30);
            ['Selected Tab Background']   = fromrgb(20, 20, 30);
            ['Unselected Tab Background'] = fromrgb(10, 10, 20);
            ['Selected Tab Text']         = fromrgb(255, 255, 255);
            ['Unselected Tab Text']       = fromrgb(150, 150, 170);
            ['Section Background']        = fromrgb(10, 10, 20);
            ['Option Text 1']             = fromrgb(255, 255, 255);
            ['Option Text 2']             = fromrgb(200, 200, 220);
            ['Option Text 3']             = fromrgb(150, 150, 170);
            ['Option Border 1']           = fromrgb(40, 40, 60);
            ['Option Border 2']           = fromrgb(0, 0, 0);
            ['Option Background']         = fromrgb(25, 25, 35);
            ["Risky Text"]                = fromrgb(255, 50, 50);
            ["Risky Text Enabled"]        = fromrgb(255, 100, 100);
        }
    },
    {
        name = 'Forest',
        theme = {
            ['Accent']                    = fromrgb(76, 175, 80);
            ['Background']                = fromrgb(15, 25, 15);
            ['Border']                    = fromrgb(0, 0, 0);
            ['Border 1']                  = fromrgb(40, 60, 40);
            ['Border 2']                  = fromrgb(25, 35, 25);
            ['Border 3']                  = fromrgb(10, 15, 10);
            ['Primary Text']              = fromrgb(240, 255, 240);
            ['Group Background']          = fromrgb(25, 35, 25);
            ['Selected Tab Background']   = fromrgb(25, 35, 25);
            ['Unselected Tab Background'] = fromrgb(15, 25, 15);
            ['Selected Tab Text']         = fromrgb(255, 255, 255);
            ['Unselected Tab Text']       = fromrgb(150, 200, 150);
            ['Section Background']        = fromrgb(15, 25, 15);
            ['Option Text 1']             = fromrgb(255, 255, 255);
            ['Option Text 2']             = fromrgb(200, 220, 200);
            ['Option Text 3']             = fromrgb(150, 180, 150);
            ['Option Border 1']           = fromrgb(40, 60, 40);
            ['Option Border 2']           = fromrgb(0, 0, 0);
            ['Option Background']         = fromrgb(30, 40, 30);
            ["Risky Text"]                = fromrgb(255, 87, 34);
            ["Risky Text Enabled"]        = fromrgb(255, 138, 101);
        }
    },
    {
        name = 'Sunset',
        theme = {
            ['Accent']                    = fromrgb(255, 87, 34);
            ['Background']                = fromrgb(30, 20, 25);
            ['Border']                    = fromrgb(0, 0, 0);
            ['Border 1']                  = fromrgb(70, 50, 55);
            ['Border 2']                  = fromrgb(40, 30, 35);
            ['Border 3']                  = fromrgb(15, 10, 12);
            ['Primary Text']              = fromrgb(255, 240, 245);
            ['Group Background']          = fromrgb(40, 30, 35);
            ['Selected Tab Background']   = fromrgb(40, 30, 35);
            ['Unselected Tab Background'] = fromrgb(30, 20, 25);
            ['Selected Tab Text']         = fromrgb(255, 255, 255);
            ['Unselected Tab Text']       = fromrgb(200, 180, 190);
            ['Section Background']        = fromrgb(30, 20, 25);
            ['Option Text 1']             = fromrgb(255, 255, 255);
            ['Option Text 2']             = fromrgb(220, 200, 210);
            ['Option Text 3']             = fromrgb(180, 160, 170);
            ['Option Border 1']           = fromrgb(70, 50, 55);
            ['Option Border 2']           = fromrgb(0, 0, 0);
            ['Option Background']         = fromrgb(45, 35, 40);
            ["Risky Text"]                = fromrgb(255, 61, 0);
            ["Risky Text Enabled"]        = fromrgb(255, 111, 67);
        }
    },
    {
        name = 'Ocean',
        theme = {
            ['Accent']                    = fromrgb(33, 150, 243);
            ['Background']                = fromrgb(10, 20, 35);
            ['Border']                    = fromrgb(0, 0, 0);
            ['Border 1']                  = fromrgb(40, 60, 90);
            ['Border 2']                  = fromrgb(20, 35, 55);
            ['Border 3']                  = fromrgb(5, 10, 18);
            ['Primary Text']              = fromrgb(240, 248, 255);
            ['Group Background']          = fromrgb(20, 35, 55);
            ['Selected Tab Background']   = fromrgb(20, 35, 55);
            ['Unselected Tab Background'] = fromrgb(10, 20, 35);
            ['Selected Tab Text']         = fromrgb(255, 255, 255);
            ['Unselected Tab Text']       = fromrgb(150, 200, 255);
            ['Section Background']        = fromrgb(10, 20, 35);
            ['Option Text 1']             = fromrgb(255, 255, 255);
            ['Option Text 2']             = fromrgb(200, 220, 255);
            ['Option Text 3']             = fromrgb(150, 180, 220);
            ['Option Border 1']           = fromrgb(40, 60, 90);
            ['Option Border 2']           = fromrgb(0, 0, 0);
            ['Option Background']         = fromrgb(25, 45, 70);
            ["Risky Text"]                = fromrgb(244, 67, 54);
            ["Risky Text Enabled"]        = fromrgb(239, 154, 154);
        }
    }
}

local blacklistedKeys = {
    Enum.KeyCode.Unknown,
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D,
    Enum.KeyCode.Slash,
    Enum.KeyCode.Tab,
    Enum.KeyCode.Escape
}

local whitelistedBoxKeys = {
    Enum.KeyCode.Zero,
    Enum.KeyCode.One,
    Enum.KeyCode.Two,
    Enum.KeyCode.Three,
    Enum.KeyCode.Four,
    Enum.KeyCode.Five,
    Enum.KeyCode.Six,
    Enum.KeyCode.Seven,
    Enum.KeyCode.Eight,
    Enum.KeyCode.Nine
}

local keyNames = {
    [Enum.KeyCode.LeftControl] = 'LCTRL';
    [Enum.KeyCode.RightControl] = 'RCTRL';
    [Enum.KeyCode.LeftShift] = 'LSHIFT';
    [Enum.KeyCode.RightShift] = 'RSHIFT';
    [Enum.UserInputType.MouseButton1] = 'MB1';
    [Enum.UserInputType.MouseButton2] = 'MB2';
    [Enum.UserInputType.MouseButton3] = 'MB3';
}

LeafletUI.button1down = LeafletUI.signal.new()
LeafletUI.button1up   = LeafletUI.signal.new()
LeafletUI.mousemove   = LeafletUI.signal.new()
LeafletUI.unloaded    = LeafletUI.signal.new();
LeafletUI.touchinput  = LeafletUI.signal.new();

local button1down, button1up, mousemove = LeafletUI.button1down, LeafletUI.button1up, LeafletUI.mousemove
local mb1down = false;

local utility = LeafletUI.utility
do

    function utility:Connection(signal, func)
        local c = signal:Connect(func)
        table.insert(LeafletUI.connections, c)
        return c
    end

    function utility:Instance(class, properties)
        local inst = newInstance(class)
        for prop, val in next, properties or {} do
            local s,e = pcall(function()
                inst[prop] = val
            end)
            if not s then
                printconsole(e, 255,0,0)
            end
        end
        return inst
    end

    function utility:HasProperty(obj, prop)
        return ({(pcall(function() local a = obj[prop] end))})[1]
    end

    function utility:ToRGB(c3)
        return c3.R*255,c3.G*255,c3.B*255
    end

    function utility:AddRGB(a,b)
        local r1,g1,b1 = self:ToRGB(a);
        local r2,g2,b2 = self:ToRGB(b);
        return fromrgb(clamp(r1+r2,0,255),clamp(g1+g2,0,255),clamp(b1+b2,0,255))
    end

    function utility:ConvertNumberRange(val,oldmin,oldmax,newmin,newmax)
        return (((val - oldmin) * (newmax - newmin)) / (oldmax - oldmin)) + newmin
    end

    function utility:UDim2ToVector2(udim2, vector2)
        local x,y
        x = udim2.X.Offset + self:ConvertNumberRange(udim2.X.Scale,0,1,0,vector2.X)
        y = udim2.Y.Offset + self:ConvertNumberRange(udim2.Y.Scale,0,1,0,vector2.Y)
        return newVector2(x,y)
    end

    function utility:Lerp(a,b,c)
        return a + (b-a) * c
    end

    function utility:Tween(obj, prop, val, time, direction, style)
        if self:HasProperty(obj, prop) then
            if LeafletUI.tweens[obj] then
                if LeafletUI.tweens[obj][prop] then
                    LeafletUI.tweens[obj][prop]:Cancel()
                end
            end

            local startVal = obj[prop];
            local a = 0;
            local tween = {
                Completed = LeafletUI.signal.new();
            };

            LeafletUI.tweens[obj] = LeafletUI.tweens[obj] or {};
            LeafletUI.tweens[obj][prop] = tween;

            tween.Connection = self:Connection(runservice.RenderStepped, function(dt)
                a = a + (dt / time);
                if a >= 1 or obj == nil then
                    tween:Cancel();
                end
                pcall(function()
                    local progress = tweenService:GetValue(a, style or Enum.EasingStyle.Linear, direction or Enum.EasingDirection.In)
                    local newVal
                    if typeof(startVal) == 'number' then
                        newVal = utility:Lerp(startVal, val, progress);
                    else
                        newVal = startVal:Lerp(val, progress);
                    end
                    obj[prop] = newVal;
                end)
            end)

            function tween:Cancel()
                tween.Connection:Disconnect();
                tween.Completed:Fire();
                table.clear(tween);
                LeafletUI.tweens[obj][prop] = nil;
            end
            
            return tween;
        else
            printconsole('unable to tween: invalid property '..tostring(prop)..' for object '..tostring(obj), 255,0,0)
        end
    end

    function utility:DetectTableChange(indexcallback,newindexcallback)
        if indexcallback == nil then
            warn('DetectTableChange: Argument #1 (indexcallback) is nil, function may not work as expected.')
        elseif newindexcallback == nil then
            warn('DetectTableChange: Argument #2 (newindexcallback) is nil, function may not work as expected.')
        end
        local proxy = newproxy(true);
        local mt = getmetatable(proxy);
        mt.__index = indexcallback
        mt.__newindex = newindexcallback
        return proxy
    end

    function utility:IsMobile()
        return LeafletUI.mobile or inputservice.TouchEnabled
    end

    function utility:GetInputPosition()
        if self:IsMobile() and inputservice:GetTouchCount() > 0 then
            return inputservice:GetTouchPosition(1)
        else
            return inputservice:GetMouseLocation()
        end
    end

    function utility:MouseOver(obj)
        local inputPos = self:GetInputPosition();
        local x1 = obj.Position.X
        local y1 = obj.Position.Y
        local x2 = x1 + obj.Size.X
        local y2 = y1 + obj.Size.Y
        return (inputPos.X >= x1 and inputPos.Y >= y1 and inputPos.X <= x2 and inputPos.Y <= y2)
    end

    function utility:GetHoverObject()
        local objects = {}
        for i,v in next, LeafletUI.drawings do
            if v.Object.Visible and v.Class == 'Square' and self:MouseOver(v.Object) then
                table.insert(objects,v.Object)
            end
        end
        table.sort(objects,function(a,b)
            return a.ZIndex > b.ZIndex
        end)
        return objects[1]
    end

    function utility:Draw(class, properties)
        local blacklistedProperties = {'Object','Children','Class'}
        local drawing = {
            Object = Drawing.new(class);
            Children = {};
            ThemeColor = '';
            OutlineThemeColor = '';
            ThemeColorOffset = 0;
            OutlineThemeColorOffset = 0;
            Parent = nil;
            Size = newUDim2(0,0,0,0);
            Position = newUDim2(0,0,0,0);
            AbsoluteSize = newVector2(0,0);
            AbsolutePosition = newVector2(0,0);
            Hover = false;
            Visible = true;
            MouseButton1Down = LeafletUI.signal.new();
            MouseButton2Down = LeafletUI.signal.new();
            MouseButton1Up = LeafletUI.signal.new();
            MouseButton2Up = LeafletUI.signal.new();
            MouseEnter = LeafletUI.signal.new();
            MouseLeave = LeafletUI.signal.new();
            Class = class;
        }

        function drawing:Update()
            local parent = drawing.Parent ~= nil and LeafletUI.drawings[drawing.Parent.Object] or nil
            local parentSize,parentPos,parentVis = workspace.CurrentCamera.ViewportSize, Vector2.new(0,0), true;
            if parent ~= nil then
                parentSize = (parent.Class == 'Square' or parent.Class == 'Image') and parent.Object.Size or parent.Class == 'Text' and parent.TextBounds or workspace.CurrentCamera.ViewportSize
                parentPos = parent.Object.Position
                parentVis = parent.Object.Visible
            end

            if drawing.Class == 'Square' or drawing.Class == 'Image' then
                drawing.Object.Size = typeof(drawing.Size) == 'Vector2' and drawing.Size or typeof(drawing.Size) == 'UDim2' and utility:UDim2ToVector2(drawing.Size,parentSize)
            end

            if drawing.Class == 'Square' or drawing.Class == 'Image' or drawing.Class == 'Circle' or drawing.Class == 'Text' then
                drawing.Object.Position = parentPos + (typeof(drawing.Position) == 'Vector2' and drawing.Position or utility:UDim2ToVector2(drawing.Position,parentSize))
            end

            drawing.Object.Visible = (parentVis and drawing.Visible) and true or false

            drawing:UpdateChildren()
        end

        function drawing:UpdateChildren()
            for i,v in next, drawing.Children do
                v:Update()
            end
        end

        function drawing:GetDescendants()
            local descendants = {};
            local function a(t)
                for _,v in next, t.Children do
                    table.insert(descendants, v);
                    a(v)
                end
            end
            a(self)
            return descendants;
        end

        LeafletUI.drawings[drawing.Object] = drawing

        local proxy = utility:DetectTableChange(
        function(obj,i)
            return drawing[i] == nil and drawing.Object[i] or drawing[i]
        end,
        function(obj,i,v)
            if not table.find(blacklistedProperties,i) then

                local lastval = drawing[i]

                if i == 'Size' and (class == 'Square' or class == 'Image') then
                    drawing.Object.Size = utility:UDim2ToVector2(v,drawing.Parent == nil and workspace.CurrentCamera.ViewportSize or drawing.Parent.Object.Size);
                    drawing.AbsoluteSize = drawing.Object.Size;
                elseif i == 'Position' and (class == 'Square' or class == 'Image' or class == 'Text') then
                    drawing.Object.Position =  utility:UDim2ToVector2(v,drawing.Parent == nil and newVector2(0,0) or drawing.Parent.Object.Position);
                    drawing.AbsolutePosition = drawing.Object.Position;
                elseif i == 'Parent' then
                    if drawing.Parent ~= nil then
                        drawing.Parent.Children[drawing] = nil
                    end
                    if v ~= nil then
                        table.insert(v.Children,drawing)
                    end
                elseif i == 'Visible' then
                    drawing.Visible = v
                elseif i == 'Font' and v == 2 and executor == 'ScriptWare' then
                    v = 1
                end

                pcall(function()
                    drawing.Object[i] = v
                end)
                if drawing[i] ~= nil or i == 'Parent' then
                    drawing[i] = v
                end

                if table.find({'Size','Position','Position','Visible','Parent'},i) then
                    drawing:Update()
                end
                if table.find({'ThemeColor','OutlineThemeColor','ThemeColorOffset','OutlineThemeColorOffset'},i) and lastval ~= v then
                    LeafletUI.UpdateThemeColors()
                end

            end
        end)

        function drawing:Remove()
            for i,v in next, self.Children do
                v:Remove();
            end

            if drawing.Parent then
                drawing.Parent.Children[drawing.Object] = nil;
            end

            LeafletUI.drawings[drawing.Object] = nil;
            drawing.Object:Remove();
            table.clear(drawing);
        end

        properties = typeof(properties) == 'table' and properties or {}

        if class == 'Square' and properties.Filled == nil then
            properties.Filled = true;
        end

        if properties.Visible == nil then
            properties.Visible = true;
        end

        for i,v in next, properties do
            proxy[i] = v
        end

        drawing:Update()
        return proxy
    end
end

LeafletUI.utility = utility

function LeafletUI:Unload()
    LeafletUI.unloaded:Fire();
    for _,c in next, self.connections do
        c:Disconnect()
    end
    for obj in next, self.drawings do
        obj:Remove()
    end
    table.clear(self.drawings)
    table.clear(self.mobileControls)
    getgenv().LeafletUI = nil
end

function LeafletUI:init()
    if self.hasInit then
        return
    end

    local tooltipObjects = {};

    makefolder(self.cheatname)
    makefolder(self.cheatname..'/assets')
    makefolder(self.cheatname..'/'..self.gamename)
    makefolder(self.cheatname..'/'..self.gamename..'/configs');

    function self:SetTheme(theme)
        for i,v in next, theme do
            self.theme[i] = v;
        end
        self.UpdateThemeColors();
    end

    function self:GetConfig(name)
        if isfile(self.cheatname..'/'..self.gamename..'/configs/'..name..self.fileext) then
            return readfile(self.cheatname..'/'..self.gamename..'/configs/'..name..self.fileext);
        end
    end

    function self:LoadConfig(name)
        local cfg = self:GetConfig(name)
        if not cfg then
            self:SendNotification('Error loading config: Config does not exist. ('..tostring(name)..')', 5, c3new(1,0,0));
            return
        end

        local s,e = pcall(function()
            setByConfig = true
            for flag,value in next, http:JSONDecode(cfg) do
                local option = LeafletUI.options[flag]
                if option ~= nil then
                    if option.class == 'toggle' then
                        option:SetState(value == nil and false or (value == 1 and true or false));
                    elseif option.class == 'slider' then
                        option:SetValue(value == nil and 0 or value)
                    elseif option.class == 'bind' then
                        option:SetBind(value == nil and 'none' or (utility:HasProperty(Enum.KeyCode, value) and Enum.KeyCode[value] or Enum.UserInputType[value]));
                    elseif option.class == 'color' then
                        option:SetColor(value == nil and c3new(1,1,1) or c3new(value[1], value[2], value[3]));
                        option:SetTrans(value == nil and 1 or value[4]);
                    elseif option.class == 'list' then
                        option:Select(value == nil and '' or value);
                    elseif option.class == 'box' then
                        option:SetInput(value == nil and '' or value)
                    end
                end
            end
            setByConfig = false
        end)

        if s then
            self:SendNotification('Successfully loaded config: '..name, 5, c3new(0,1,0));
        else
            self:SendNotification('Error loading config: '..tostring(e)..'. ('..tostring(name)..')', 5, c3new(1,0,0));
        end
    end

    function self:SaveConfig(name)
        if not self:GetConfig(name) then
            self:SendNotification('Error saving config: Config does not exist. ('..tostring(name)..')', 5, c3new(1,0,0));
            return
        end

        local s,e = pcall(function()
            local cfg = {};
            for flag,option in next, self.options do
                if option.class == 'toggle' then
                    cfg[flag] = option.state and 1 or 0;
                elseif option.class == 'slider' then
                    cfg[flag] = option.value;
                elseif option.class == 'bind' then
                    cfg[flag] = option.bind.Name;
                elseif option.class == 'color' then
                    cfg[flag] = {
                        option.color.r,
                        option.color.g,
                        option.color.b,
                        option.trans,
                    }
                elseif option.class == 'list' then
                    cfg[flag] = option.selected;
                elseif option.class == 'box' then
                    cfg[flag] = option.input
                end
            end
            writefile(self.cheatname..'/'..self.gamename..'/configs/'..name..self.fileext, http:JSONEncode(cfg));
        end)

        if s then
            self:SendNotification('Successfully saved config: '..name, 5, c3new(0,1,0));
        else
            self:SendNotification('Error saving config: '..tostring(e)..'. ('..tostring(name)..')', 5, c3new(1,0,0));
        end
    end

    for i,v in next, self.images do
        if not isfile(self.cheatname..'/assets/'..i..'.leaflet') then
            writefile(self.cheatname..'/assets/'..i..'.leaflet', game:HttpGet(v))
        end
        self.images[i] = readfile(self.cheatname..'/assets/'..i..'.leaflet');
    end

    -- Mobile controls setup
    if utility:IsMobile() then
        self:CreateMobileControls()
    end

    local screenGui = Instance.new('ScreenGui');
    if syn then syn.protect_gui(screenGui); end
    screenGui.Parent = game:GetService('CoreGui');
    screenGui.Enabled = true;
    utility:Instance('ImageButton', {
        Parent = screenGui,
        Visible = true,
        Modal = true,
        Size = UDim2.new(1,0,1,0),
        ZIndex = 9999999999,
        Transparency = 1;
    })

    utility:Connection(LeafletUI.unloaded, function()
        screenGui:Destroy()
    end)

    -- Input handling for mobile
    if utility:IsMobile() then
        utility:Connection(inputservice.TouchStarted, function(touch, processed)
            if not processed and LeafletUI.hasInit then
                local touchPos = touch.Position
                LeafletUI.touchinput:Fire(touchPos)
                
                local hoverObj = utility:GetHoverObject();
                local hoverObjData = LeafletUI.drawings[hoverObj];
                
                if hoverObj and hoverObjData then
                    hoverObjData.MouseButton1Down:Fire(touchPos)
                    mb1down = true;
                    button1down:Fire()
                    
                    -- Update Sliders Click for mobile
                    if LeafletUI.draggingSlider ~= nil then
                        local rel = touchPos - LeafletUI.draggingSlider.objects.background.Object.Position;
                        local val = utility:ConvertNumberRange(rel.X, 0 , LeafletUI.draggingSlider.objects.background.Object.Size.X, 
                            LeafletUI.draggingSlider.min, LeafletUI.draggingSlider.max);
                        LeafletUI.draggingSlider:SetValue(val)
                    end
                end
            end
        end)

        utility:Connection(inputservice.TouchEnded, function(touch, processed)
            if not processed and LeafletUI.hasInit then
                mb1down = false;
                button1up:Fire();
                
                local hoverObj = utility:GetHoverObject();
                local hoverObjData = LeafletUI.drawings[hoverObj];
                
                if hoverObj and hoverObjData then
                    hoverObjData.MouseButton1Up:Fire(touch.Position)
                end
            end
        end)

        utility:Connection(inputservice.TouchMoved, function(touch, processed)
            if not processed and LeafletUI.hasInit and LeafletUI.open then
                local touchPos = touch.Position
                mousemove:Fire(touchPos);
                
                -- Mobile controls update
                for _,control in next, self.mobileControls do
                    if control.dragging then
                        control:UpdatePosition(touchPos)
                    end
                end
                
                -- Update Sliders Drag for mobile
                if mb1down and LeafletUI.draggingSlider ~= nil then
                    local rel = touchPos - LeafletUI.draggingSlider.objects.background.Object.Position;
                    local val = utility:ConvertNumberRange(rel.X, 0 , LeafletUI.draggingSlider.objects.background.Object.Size.X, 
                        LeafletUI.draggingSlider.min, LeafletUI.draggingSlider.max);
                    LeafletUI.draggingSlider:SetValue(val)
                end
                
                -- Hover detection
                local hoverObj = utility:GetHoverObject();
                for _,v in next, LeafletUI.drawings do
                    local hover = hoverObj == v.Object;
                    if hover and not v.Hover then
                        v.Hover = true;
                        v.MouseEnter:Fire(touchPos);
                    elseif not hover and v.Hover then
                        v.Hover = false;
                        v.MouseLeave:Fire(touchPos);
                    end
                end
            end
        end)
    else
        -- Desktop input handling
        utility:Connection(inputservice.InputBegan, function(input, gpe)
            if self.hasInit then
                if input.KeyCode == self.toggleKey and not LeafletUI.opening and not gpe then
                    self:SetOpen(not self.open)
                    task.spawn(function()
                        LeafletUI.opening = true;
                        task.wait(.15);
                        LeafletUI.opening = false;
                    end)
                end
                if LeafletUI.open then
                    local hoverObj = utility:GetHoverObject();
                    local hoverObjData = LeafletUI.drawings[hoverObj];
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        mb1down = true;
                        button1down:Fire()
                        if hoverObj and hoverObjData then
                            hoverObjData.MouseButton1Down:Fire(inputservice:GetMouseLocation())
                        end

                        -- Update Sliders Click
                        if LeafletUI.draggingSlider ~= nil then
                            local rel = inputservice:GetMouseLocation() - LeafletUI.draggingSlider.objects.background.Object.Position;
                            local val = utility:ConvertNumberRange(rel.X, 0 , LeafletUI.draggingSlider.objects.background.Object.Size.X, 
                                LeafletUI.draggingSlider.min, LeafletUI.draggingSlider.max);
                            LeafletUI.draggingSlider:SetValue(val)
                        end

                    elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                        if hoverObj and hoverObjData then
                            hoverObjData.MouseButton2Down:Fire(inputservice:GetMouseLocation())
                        end
                    end
                end
            end
        end)

        utility:Connection(inputservice.InputEnded, function(input, gpe)
            if self.hasInit and LeafletUI.open then
                local hoverObj = utility:GetHoverObject();
                local hoverObjData = LeafletUI.drawings[hoverObj];

                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    mb1down = false;
                    button1up:Fire();
                    if hoverObj and hoverObjData then
                        hoverObjData.MouseButton1Up:Fire(inputservice:GetMouseLocation())
                    end
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    if hoverObj and hoverObjData then
                        hoverObjData.MouseButton2Up:Fire(inputservice:GetMouseLocation())
                    end
                end
            end
        end)

        utility:Connection(inputservice.InputChanged, function(input, gpe)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                if LeafletUI.open then
                    mousemove:Fire(inputservice:GetMouseLocation());
                    
                    local hoverObj = utility:GetHoverObject();
                    for _,v in next, LeafletUI.drawings do
                        local hover = hoverObj == v.Object;
                        if hover and not v.Hover then
                            v.Hover = true;
                            v.MouseEnter:Fire(inputservice:GetMouseLocation());
                        elseif not hover and v.Hover then
                            v.Hover = false;
                            v.MouseLeave:Fire(inputservice:GetMouseLocation());
                        end
                    end

                    if mb1down then
                        -- Update Sliders Drag
                        if LeafletUI.draggingSlider ~= nil then
                            local rel = inputservice:GetMouseLocation() - LeafletUI.draggingSlider.objects.background.Object.Position;
                            local val = utility:ConvertNumberRange(rel.X, 0 , LeafletUI.draggingSlider.objects.background.Object.Size.X, 
                                LeafletUI.draggingSlider.min, LeafletUI.draggingSlider.max);
                            LeafletUI.draggingSlider:SetValue(val)
                        end
                    end
                end
            end
        end)
    end

    -- Mobile toggle button
    if utility:IsMobile() then
        self.mobileToggleButton = self:CreateMobileToggleButton()
    end
    
    function self:SetOpen(bool)
        self.open = bool;
        screenGui.Enabled = bool;

        if bool and self.flags.disablemenumovement then
            actionservice:BindAction(
                'FreezeMovement',
                function()
                    return Enum.ContextActionResult.Sink
                end,
                false,
                unpack(Enum.PlayerActions:GetEnumItems())
            )
        else
            actionservice:UnbindAction('FreezeMovement');
        end

        -- Update mobile controls visibility
        if utility:IsMobile() then
            self.mobileToggleButton.Visible = not bool
            for _,control in next, self.mobileControls do
                control.Visible = not bool
            end
        end

        for _,window in next, self.windows do
            window:SetOpen(bool);
        end

        LeafletUI.CurrentTooltip = nil;
        tooltipObjects.background.Visible = false
    end

    function self.UpdateThemeColors()
        for _,v in next, LeafletUI.drawings do
            if v.ThemeColor and LeafletUI.theme[v.ThemeColor] then
                v.Object.Color = utility:AddRGB(LeafletUI.theme[v.ThemeColor],fromrgb(v.ThemeColorOffset,v.ThemeColorOffset,v.ThemeColorOffset))
            end
            if v.ThemeColorOutline and LeafletUI.theme[v.ThemeColorOutline] then
                v.Object.OutlineColor = utility:AddRGB(LeafletUI.theme[v.ThemeColorOutline],fromrgb(v.OutlineThemeColorOffset,v.OutlineThemeColorOffset,v.OutlineThemeColorOffset))
            end
        end
    end

    function self:SendNotification(message, time, color)
        time = time or 5
        if typeof(message) ~= 'string' then
            return error(string.format('invalid message type, got %s, expected string', typeof(message)))
        elseif typeof(time) ~= 'number' then
            return error(string.format('invalid time type, got %s, expected number', typeof(time)))
        elseif color ~= nil and typeof(color) ~= 'Color3' then
            return error(string.format('invalid color type, got %s, expected color3', typeof(time)))
        end

        local notification = {};

        self.notifications[notification] = true

        do
            local objs = notification;
            local z = self.zindexOrder.notification;

            notification.holder = utility:Draw('Square', {
                Position = newUDim2(0, 0, 0, 75);
                Transparency = 0;
            })
            
            notification.background = utility:Draw('Square', {
                Size = newUDim2(1,0,1,0);
                Position = newUDim2(0, -500, 0, 0);
                Parent = notification.holder;
                ThemeColor = 'Background';
                ZIndex = z;
            })

            notification.border1 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 2';
                Parent = notification.background;
                ZIndex = z-1;
            })

            objs.border2 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                Parent = objs.border1;
                ZIndex = z-2;
            })

            notification.gradient = utility:Draw('Image', {
                Size = newUDim2(1,0,1,0);
                Data = self.images.gradientp90;
                Parent = notification.background;
                Transparency = .5;
                ZIndex = z+1;
            })

            notification.accentBar = utility:Draw('Square',{
                Size = newUDim2(0,5,1,4);
                Position = newUDim2(0,0,0,-2);
                Parent = notification.background;
                ThemeColor = color == nil and 'Accent' or '';
                ZIndex = z+5;
            })

            notification.text = utility:Draw('Text', {
                Position = newUDim2(0,13,0,2);
                ThemeColor = 'Primary Text';
                Text = message;
                Outline = true;
                Font = 2;
                Size = 13;
                ZIndex = z+4;
                Parent = notification.background;
            })

            if color then
                notification.accentBar.Color = color;
            end

        end

        function notification:Remove()
            LeafletUI.notifications[notification] = nil;
            self.holder:Remove();
            LeafletUI:UpdateNotifications()
        end

        task.spawn(function()
            self:UpdateNotifications();
            notification.background.Size = newUDim2(0, notification.text.TextBounds.X + 20, 0, 19)
            task.wait();
            utility:Tween(notification.background, 'Position', newUDim2(0,0,0, 0), .1);
            task.wait(time);
            for i,v in next, notification do
                if typeof(v) ~= 'function' then
                    utility:Tween(v, 'Transparency', 0, .15);
                end
            end
            utility:Connection(utility:Tween(notification.background, 'Position', newUDim2(0,-500,0, 0), .25).Completed, (function()
                notification:Remove();
            end))
        end)

    end

    function self:UpdateNotifications()
        local i = 0
        for v in next, self.notifications do
            utility:Tween(v.holder, 'Position', newUDim2(0,0,0, 75 + (i * 30)), .15)
            i += 1
        end
    end

    function self.NewIndicator(data)
        local indicator = {
            title = data.title or 'indicator',
            enabled = data.enabled or false,
            position = data.position or newUDim2(0,15,0,300),
            values = {},
            objects = {valueObjects = {}},
            spacing = '   ',
        };

        table.insert(self.indicators, indicator)

        -- Create Objects --
        do
            local z = self.zindexOrder.indicator;
            local objs = indicator.objects;

            objs.background = utility:Draw('Square', {
                Size = newUDim2(0, 200, 0, 16);
                Position = indicator.position;
                ThemeColor = 'Background';
                ZIndex = z;
            })

            objs.border1 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 2';
                Parent = objs.background;
                ZIndex = z-1;
            })

            objs.border2 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                Parent = objs.border1;
                ZIndex = z-2;
            })

            objs.topborder = utility:Draw('Square', {
                Size = newUDim2(1,0,0,1);
                ThemeColor = 'Accent';
                Parent = objs.background;
                ZIndex = z+1;
            })

            objs.textlabel = utility:Draw('Text', {
                Position = newUDim2(.5,0,0,1);
                ThemeColor = 'Primary Text';
                Text = indicator.title;
                Size = 13;
                Font = 2;
                ZIndex = z+2;
                Center = true;
                Outline = true;
                Parent = objs.background;
            });

        end
        --------------------

        function indicator:Update()
            local xSize  = 125
            local yPos  = 0
            table.sort(self.values, function(a,b)
                return a.order < b.order;
            end)

            for _,v in next, self.values do
                v.objects.keyLabel.Text = tostring(v.key);
                v.objects.valueLabel.Text = tostring(v.value);
            
                v.objects.valueLabel.Position = newUDim2(1,-(v.objects.valueLabel.TextBounds.X + 3),0,0)
                v.objects.background.Position = newUDim2(0,0,1,3 + yPos)
                v.objects.background.Visible = v.enabled

                if v.enabled then
                    yPos = yPos + 16 + 3
                    local x = (v.objects.keyLabel.TextBounds.X + 10 + v.objects.valueLabel.TextBounds.X)
                    if x > xSize then
                        xSize = x
                    end
                end
            end

            self.objects.background.Size = newUDim2(0,xSize + 8,0,16)
            self.objects.background.Position = self.position
        end

        function indicator:AddValue(data)
            local value = {
                key = data.key or '',
                value = data.value or '',
                order = data.order or #self.values+1,
                enabled = data.enabled == nil and true or data.enabled,
                objects = {},
            }

            table.insert(self.values, value);

            -- Create Objects --
            do
                local z = LeafletUI.zindexOrder.indicator;
                local objs = value.objects;

                objs.background = utility:Draw('Square', {
                    Size = newUDim2(1, 0, 0, 16);
                    ThemeColor = 'Background';
                    ZIndex = z;
                    Parent = indicator.objects.background;
                })
    
                objs.border1 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 2';
                    Parent = objs.background;
                    ZIndex = z-1;
                })
    
                objs.border2 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 3';
                    Parent = objs.border1;
                    ZIndex = z-2;
                })
    
                objs.keyLabel = utility:Draw('Text', {
                    Position = newUDim2(0,3,0,1);
                    ThemeColor = 'Option Text 2';
                    Size = 13;
                    Font = 2;
                    ZIndex = z+2;
                    Outline = true;
                    Parent = objs.background;
                });

                objs.valueLabel = utility:Draw('Text', {
                    Position = newUDim2(0,0,0,1);
                    ThemeColor = 'Option Text 2';
                    Size = 13;
                    Font = 2;
                    ZIndex = z+2;
                    Outline = true;
                    Parent = objs.background;
                });

            end
            --------------------

            function value:Remove()
                table.remove(indicator.values, table.find(indicator.values, value))
                self.objects.background:Remove()
                table.clear(self)
                indicator:Update();
            end

            function value:SetEnabled(bool)
                if typeof(bool) == 'boolean' then
                    self.enabled = bool
                    indicator:Update()
                end
            end

            function value:SetValue(str)
                if typeof(str) == 'string' then
                    self.value = str
                    indicator:Update()
                end
            end

            function value:SetKey(str)
                if typeof(str) == 'string' then
                    self.key = str
                    indicator:Update()
                end
            end

            self:Update()
            return value
        end

        function indicator:GetValue(idx)
            if typeof(idx) == 'number' then
                return self.values[idx]
            else
                for i,v in next, self.values do
                    if v.key == idx then
                        return v
                    end
                end
            end
        end

        function indicator:SetEnabled(bool)
            if typeof(bool) == 'boolean' then
                self.enabled = bool;
                self.objects.background.Visible = bool;
                self:Update();
            end
        end

        function indicator:SetPosition(udim2)
            if typeof(udim2) == 'UDim2' then
                self.position = udim2
                self.objects.background.Position = udim2;
            end
        end

        for i,v in next, data.values or {} do
            indicator:AddValue({key = tostring(i), value = tostring(v)})
        end

        indicator:SetEnabled(indicator.enabled);
        return indicator
    end

    function self:CreateMobileControls()
        -- Create joystick for movement
        local joystick = {
            dragging = false,
            startPos = Vector2.new(0,0),
            currentPos = Vector2.new(0,0),
            radius = 40,
            objects = {},
            Visible = true,
            callback = function(dir) end
        }
        
        -- Joystick base
        joystick.objects.base = utility:Draw('Circle', {
            Position = newUDim2(0, 60, 1, -140),
            Radius = joystick.radius,
            ThemeColor = 'Background',
            Filled = true,
            ZIndex = self.zindexOrder.mobile,
            Visible = joystick.Visible
        })
        
        joystick.objects.baseBorder = utility:Draw('Circle', {
            Position = newUDim2(0, 60, 1, -140),
            Radius = joystick.radius,
            ThemeColor = 'Border 2',
            Filled = false,
            Thickness = 3,
            ZIndex = self.zindexOrder.mobile - 1,
            Visible = joystick.Visible
        })
        
        -- Joystick handle
        joystick.objects.handle = utility:Draw('Circle', {
            Position = newUDim2(0, 60, 1, -140),
            Radius = 20,
            ThemeColor = 'Accent',
            Filled = true,
            ZIndex = self.zindexOrder.mobile + 1,
            Visible = joystick.Visible
        })
        
        function joystick:UpdatePosition(touchPos)
            if not self.dragging then return end
            
            local basePos = self.objects.base.Position
            local delta = touchPos - basePos
            local distance = delta.Magnitude
            
            if distance > self.radius then
                delta = delta.Unit * self.radius
            end
            
            self.currentPos = basePos + delta
            self.objects.handle.Position = self.currentPos
            
            -- Normalized direction vector
            local dir = delta / self.radius
            self.callback(dir)
        end
        
        function joystick:StartDrag(pos)
            self.dragging = true
            self.startPos = pos
            self.objects.base.Position = pos
            self.objects.baseBorder.Position = pos
            self.objects.handle.Position = pos
        end
        
        function joystick:EndDrag()
            self.dragging = false
            self.objects.handle.Position = self.objects.base.Position
            self.callback(Vector2.new(0,0))
        end
        
        function joystick:SetVisible(bool)
            self.Visible = bool
            for _,obj in next, self.objects do
                obj.Visible = bool
            end
        end
        
        table.insert(self.mobileControls, joystick)
        
        -- Create jump button
        local jumpButton = {
            pressed = false,
            objects = {},
            Visible = true,
            callback = function(state) end
        }
        
        jumpButton.objects.background = utility:Draw('Circle', {
            Position = newUDim2(1, -80, 1, -80),
            Radius = 35,
            ThemeColor = 'Background',
            Filled = true,
            ZIndex = self.zindexOrder.mobile,
            Visible = jumpButton.Visible
        })
        
        jumpButton.objects.border = utility:Draw('Circle', {
            Position = newUDim2(1, -80, 1, -80),
            Radius = 35,
            ThemeColor = 'Border 2',
            Filled = false,
            Thickness = 3,
            ZIndex = self.zindexOrder.mobile - 1,
            Visible = jumpButton.Visible
        })
        
        jumpButton.objects.text = utility:Draw('Text', {
            Position = newUDim2(1, -80, 1, -80),
            Text = "JUMP",
            ThemeColor = 'Primary Text',
            Size = 13,
            Font = 2,
            Center = true,
            Outline = true,
            ZIndex = self.zindexOrder.mobile + 1,
            Visible = jumpButton.Visible
        })
        
        function jumpButton:Press()
            self.pressed = true
            self.objects.background.ThemeColor = 'Accent'
            self.objects.background.ThemeColorOffset = -55
            self.callback(true)
        end
        
        function jumpButton:Release()
            self.pressed = false
            self.objects.background.ThemeColor = 'Background'
            self.objects.background.ThemeColorOffset = 0
            self.callback(false)
        end
        
        function jumpButton:SetVisible(bool)
            self.Visible = bool
            for _,obj in next, self.objects do
                obj.Visible = bool
            end
        end
        
        table.insert(self.mobileControls, jumpButton)
        
        return {joystick = joystick, jumpButton = jumpButton}
    end

    function self:CreateMobileToggleButton()
        local toggleButton = {
            objects = {},
            Visible = true
        }
        
        toggleButton.background = utility:Draw('Circle', {
            Position = newUDim2(0, 20, 0, 20),
            Radius = 25,
            ThemeColor = 'Background',
            Filled = true,
            ZIndex = self.zindexOrder.mobile + 5,
            Visible = toggleButton.Visible
        })
        
        toggleButton.border = utility:Draw('Circle', {
            Position = newUDim2(0, 20, 0, 20),
            Radius = 25,
            ThemeColor = 'Border 2',
            Filled = false,
            Thickness = 3,
            ZIndex = self.zindexOrder.mobile + 4,
            Visible = toggleButton.Visible
        })
        
        toggleButton.text = utility:Draw('Text', {
            Position = newUDim2(0, 20, 0, 20),
            Text = "☰",
            ThemeColor = 'Primary Text',
            Size = 20,
            Font = 2,
            Center = true,
            ZIndex = self.zindexOrder.mobile + 6,
            Visible = toggleButton.Visible
        })
        
        function toggleButton:SetVisible(bool)
            self.Visible = bool
            self.background.Visible = bool
            self.border.Visible = bool
            self.text.Visible = bool
        end
        
        utility:Connection(toggleButton.background.MouseButton1Down, function()
            self:SetOpen(not self.open)
        end)
        
        return toggleButton
    end

    function self.NewWindow(data)
        local window = {
            title = data.title or '',
            selectedTab = nil;
            tabs = {},
            objects = {},
            colorpicker = {
                objects = {};
                color = c3new(1,0,0);
                trans = 0;
            };
            dropdown = {
                objects = {
                    values = {};
                };
                max = 5;
            }
        };

        table.insert(LeafletUI.windows, window);

        ----- Create Objects ----
        do
            local size = data.size or newUDim2(0, 525, 0, 650);
            local position = data.position or newUDim2(0, 250, 0, 150);
            local objs = window.objects;
            local z = LeafletUI.zindexOrder.window;

            objs.background = utility:Draw('Square', {
                Size = size;
                Position = position;
                ThemeColor = 'Background';
                ZIndex = z;
            })

            objs.innerBorder1 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                ZIndex = z-1;
                Parent = objs.background;
            })

            objs.innerBorder2 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 1';
                ZIndex = z-2;
                Parent = objs.innerBorder1;
            })

            objs.midBorder = utility:Draw('Square', {
                Size = newUDim2(1,10,1,25);
                Position = newUDim2(0,-5,0,-20);
                ThemeColor = 'Border 2';
                ZIndex = z-3;
                Parent = objs.innerBorder2;
            })

            objs.outerBorder1 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 1';
                ZIndex = z-4;
                Parent = objs.midBorder;
            })

            objs.outerBorder2 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                ZIndex = z-5;
                Parent = objs.outerBorder1;
            })

            objs.topBorder = utility:Draw('Square', {
                Size = newUDim2(1,0,0,1);
                ThemeColor = 'Accent';
                ZIndex = z+1;
                Parent = objs.background;
            })

            objs.title = utility:Draw('Text', {
                Position = newUDim2(0,7,0,2);
                ThemeColor = 'Primary Text';
                Text = window.title;
                Font = 2;
                Size = 13;
                ZIndex = z+1;
                Outline = true;
                Parent = objs.midBorder;
            })

            objs.groupBackground = utility:Draw('Square', {
                Size = newUDim2(1,-16,1,-(16+23));
                Position = newUDim2(0,8,0,8+23);
                ThemeColor = 'Group Background';
                ZIndex = z+5;
                Parent = objs.background;
            })

            objs.groupInnerBorder = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 1';
                ZIndex = z+4;
                Parent = objs.groupBackground;
            })

            objs.groupOuterBorder = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                ZIndex = z+3;
                Parent = objs.groupInnerBorder;
            })

            objs.tabHolder = utility:Draw('Square', {
                Size = newUDim2(1,0,0,20);
                Position = newUDim2(0,0,0,-21);
                Parent = objs.groupBackground;
                Transparency = 0;
                ZIndex = z+1;
            })

            objs.columnholder1 = utility:Draw('Square', {
                Size = newUDim2(.48, 0, .96, 0);
                Position = newUDim2(.01, 0, .02, 0);
                Transparency = 0;
                ZIndex = z+6;
                Parent = objs.groupBackground;
            })

            objs.columnholder2 = utility:Draw('Square', {
                Size = newUDim2(.48, 0, .96, 0);
                Position = newUDim2(1 - (.48 + .01), 0, .02, 0);
                Transparency = 0;
                ZIndex = z+6;
                Parent = objs.groupBackground;
            })


            objs.dragdetector = utility:Draw('Square',{
                Size = newUDim2(1,0,1,0);
                Parent = objs.midBorder;
                Transparency = 0;
                ZIndex = z+2;
            })

            local dragging, mouseStart, objStart;

            utility:Connection(objs.dragdetector.MouseButton1Down, function(pos)
                dragging = true;
                mouseStart = newUDim2(0, pos.X, 0, pos.Y);
                objStart = objs.background.Position;
            end)

            utility:Connection(button1up, function()
                dragging = false;
            end)

            utility:Connection(mousemove, function(pos)
                if dragging then
                    if window.open then
                        objs.background.Position = objStart + newUDim2(0, pos.X, 0, pos.Y) - mouseStart;
                    else
                        dragging = false
                    end
                end
            end)

        end
        -------------------------

        -- Create Color Picker --
        do
            -- Objects
            do
                local objs = window.colorpicker.objects;
                local z = LeafletUI.zindexOrder.colorpicker;

                objs.background = utility:Draw('Square', {
                    Visible = false;
                    Size = newUDim2(0,200,0,242);
                    Position = newUDim2(1,-200,1,10);
                    ThemeColor = 'Background';
                    ZIndex = z;
                    Parent = window.objects.background;
                })

                objs.border1 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z-1;
                    Parent = objs.background;
                })

                objs.border2 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 1';
                    ZIndex = z-2;
                    Parent = objs.border1;
                })

                objs.border3 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z-3;
                    Parent = objs.border2;
                })

                objs.statusText = utility:Draw('Text', {
                    Position = newUDim2(0,5,0,4);
                    Text = 'colorpicker_status_text';
                    ThemeColor = 'Option Text 1';
                    Size = 13;
                    Font = 2;
                    Outline = true;
                    ZIndex = z+1;
                    Parent = objs.background;
                })

                objs.mainColor = utility:Draw('Square', {
                    Size = newUDim2(0, 175, 0, 175);
                    Position = newUDim2(0, 5, 0, 25);
                    Color = c3new(1,0,0);
                    ZIndex = z+2;
                    Parent = objs.background;
                })

                objs.sat1 = utility:Draw('Image', {
                    Size = newUDim2(1,0,1,0);
                    Data = syn.crypt.base64.decode"iVBORw0KGgoAAAANSUhEUgAAAaQAAAGkCAQAAADURZm+AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQflBwwSLzK3wl3KAAADrElEQVR42u3ZOQ6DQBBAQSR6//9jdodQJdCgCYZgPL8zeYWBGmRXbzZju+nM99Xb+vfm2r2fq3/d7/p8ef2+8/fSd7+8/2uLcP5yP5/9rXf/H1yPr+d+zq/P3fPvuz9/1/W/ru6/+/l37+v5/v/69/O173d31/O9u8/pP+d96f5qP78evz2/03/z/XH+bv/xnO9/nv/S7vO90e3c3/n7o/v7/nz+7rjj/u3+un6v8/ivz+P+fP/5+b59/+5+78/vX/+/9Jfz//Pz3t99b7afH8P75/r3/z+v36+d+/P/Pc+X6/l9Pb69/3j/7fe/3z9ufw8kewcA4wFw/WIA==;"
                    ZIndex = z+3;
                    Parent = objs.mainColor;
                })

                objs.sat2 = utility:Draw('Image', {
                    Size = newUDim2(1,0,1,0);
                    Data = syn.crypt.base64.decode"iVBORw0KGgoAAAANSUhEUgAAAaQAAAGkCAQAAADURZm+AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JQAAgIMAAPn/AACA6QAAdTAAAOpgAAA6mAAAF2+SX8VGAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQflBwwSLyBEeyyCAAAD4klEQVR42u3YwQnAQAhFQTek/5pz9eBtEYzMlBD4PDcRADDBieMjwK3HJwBDghFepx0oEhgSOO0ARQJDAqcdKBJgSGBI4I0EhgQ47cCQwJDAGwlQJDAkcNqBIgGKBIoEhgROO0CRQJFAkQBDAqcdGBI47QBFAkUCQwKnHaBIoEigSKBIgCKBIYHTDhQJUCQwJHDagSIBigSGBE47UCRAkcCQwGkHKBIoEigSGBLgtANDAkMCbyTAkMBpB4oEigQoEhgSOO1AkQBDAqcdKBIoEqBIYEjgtANFUiRQJFAkMCTAaQeKBIoEigQYEjjtQJFAkQBFAkMCpx0oEmBI4LQDRQJFAhQJDAmcdqBIgCKBIoEhAU47UCRQJFAkwJDAaQeKBIYEOO1AkUCRYHuRTAmcduC0A0UCFAkUCQwJnHaAIoEigSKBIQFOO2gvkimBIoE3EhgS4LQDRQJDAqcdoEigSKBIYEiAIYEhwXx+NoAigSGB0w5QJDAkMCQwJKDiZwMoEhgSOO0ARQJFgnlFMiVw2oHTDhQJUCRQJDAkcNoBVZFMCRQJvJHAkACnHSgSKBIoElANSZPAaQdOOzAkwGkHigSGBIYEGBK08LMBFAkUCRQJMCQwJDAkWMjPBlAkMCRw2gG5SKYEigTeSGBIgNMOFAkMCQwJMCRo4WcDKBIYEjjtgFwkUwJFAm8kMCTAaQeKBIoEigRUQ9IkcNqB0w4MCXDagSKBIsHCIpkSOO3AaQeKBCgSKBIYEhgSYEjQws8GUCQwJHDaAblIpgSKBN5IYEiA0w4UCQwJDAkwJGjhZwMoEhgSOO0ARQJDAkMCQwIqfjaAIoEigSIBhgROO5hXJFMCpx047UCRAEUCRQJDAqcdUBXJlECRwBsJDAlw2oEigSKBIgGGBIYEhgSL+dkAigSGBE47QJHAkMBpB4oEGBIYEhgSrOZnAygSKBIoEmBI4LQDRQJFAhQJDAmcdrC8SKYEigTeSGBIgNMOFAkMCZx2gCKBIoEigSEBTjtQJFAkUCTAkMBpB4oEigQoEhgSOO1AkQBDAqcdKBKgSKBIYEjgtAMUCRQJFAkMCXDagSKBIoEiAYYETjtQJFAkQJHAkMBpB4oEGBI47UCRQJEARQJDAqcdoEigSGBI4LQDFAkUCRQJFAkwJHDagSKBIQFOOzAkMCTwRgIMCZx2oEigSIAigSKBIYHTzkcARQJFAkMCnHZgSGBI4I0EGBI47UCRQJEAQwKnHSgSKBKgSGBI4LQDRQIUCRQJDAmcdoAigSGB0w5QJFAkUCQwJMBpB4oEhgROO0CRwJDAkMAbCVAkMCT4gw/reQYigE05fAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMS0wNy0xMlQxODo0NzozMiswMDowMN2VK3MAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjEtMDctMTJUMTg6NDc6MzIrMDA6MDCsyJPPAAAAAElFTkSuQmCC";
                    ZIndex = z+4;
                    Parent = objs.mainColor;
                })

                objs.colorBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z+1;
                    Parent = objs.mainColor;
                })

                objs.mainDetector = utility:Draw('Square',{
                    Size = newUDim2(1,0,1,0);
                    Transparency = 0;
                    ZIndex = z+10;
                    Parent = objs.mainColor;
                })

                objs.hue = utility:Draw('Image', {
                    Size = newUDim2(0,175,0,10);
                    Position = newUDim2(0,5,0,205);
                    Data = LeafletUI.images.colorhue;
                    ZIndex = z+2;
                    Parent = objs.background;
                })

                objs.hueBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z+1;
                    Parent = objs.hue;
                })

                objs.hueDetector = utility:Draw('Square',{
                    Size = newUDim2(1,0,1,0);
                    Transparency = 0;
                    ZIndex = z+10;
                    Parent = objs.hue;
                })

                objs.transColor = utility:Draw('Square', {
                    Size = newUDim2(0,10,0,175);
                    Position = newUDim2(0,185,0,25);
                    Color = c3new(1,0,0);
                    ZIndex = z+2;
                    Parent = objs.background;
                })

                objs.trans = utility:Draw('Image', {
                    Size = newUDim2(1,0,1,0);
                    Data = LeafletUI.images.colortrans;
                    ZIndex = z+3;
                    Parent = objs.transColor;
                })

                objs.transBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z+1;
                    Parent = objs.transColor;
                })

                objs.transDetector = utility:Draw('Square',{
                    Size = newUDim2(1,0,1,0);
                    Transparency = 0;
                    ZIndex = z+10;
                    Parent = objs.transColor;
                })

                objs.pointer = utility:Draw('Square', {
                    Size = newUDim2(0,2,0,2);
                    Position = newUDim2(0,0,0,0);
                    Color = c3new(1,1,1);
                    ZIndex = z+6;
                    Parent = objs.mainColor;
                })

                objs.pointerBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+5;
                    Parent = objs.pointer;
                })

                objs.hueSlider = utility:Draw('Square', {
                    Size = newUDim2(0,1,1,0);
                    Color = c3new(1,1,1);
                    ZIndex = z+4;
                    Parent = objs.hue;
                })

                objs.hueSliderBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+3;
                    Parent = objs.hueSlider;
                })

                objs.transSlider = utility:Draw('Square', {
                    Size = newUDim2(1,0,0,1);
                    Color = c3new(1,1,1);
                    ZIndex = z+5;
                    Parent = objs.trans;
                })

                objs.transSliderBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+4;
                    Parent = objs.transSlider;
                })

                objs.rBackground = utility:Draw('Square', {
                    Size = newUDim2(0, 60, 0, 15);
                    Position = newUDim2(0, 5, 1, - 20);
                    ThemeColor = 'Option Background';
                    Parent = objs.background;
                    ZIndex = z+5;
                })

                objs.rBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+4;
                    Parent = objs.rBackground;
                })

                objs.rText = utility:Draw('Text', {
                    Position = newUDim2(.5,0,0,0);
                    Color = c3new(1,.1,.1);
                    Text = 'R';
                    Size = 13;
                    Font = 2;
                    Outline = true;
                    Center = true;
                    ZIndex = z+6;
                    Parent = objs.rBackground;
                })

                objs.gBackground = utility:Draw('Square', {
                    Size = newUDim2(0, 60, 0, 15);
                    Position = newUDim2(0, 70, 1, - 20);
                    ThemeColor = 'Option Background';
                    Parent = objs.background;
                    ZIndex = z+5;
                })

                objs.gBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+4;
                    Parent = objs.gBackground;
                })

                objs.gText = utility:Draw('Text', {
                    Position = newUDim2(.5,0,0,0);
                    Color = c3new(.1,1,.1);
                    Text = 'G';
                    Size = 13;
                    Font = 2;
                    Outline = true;
                    Center = true;
                    ZIndex = z+6;
                    Parent = objs.gBackground;
                })

                objs.bBackground = utility:Draw('Square', {
                    Size = newUDim2(0, 60, 0, 15);
                    Position = newUDim2(0, 135, 1, - 20);
                    ThemeColor = 'Option Background';
                    Parent = objs.background;
                    ZIndex = z+5;
                })

                objs.bBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    Color = c3new(0,0,0);
                    ZIndex = z+4;
                    Parent = objs.bBackground;
                })

                objs.bText = utility:Draw('Text', {
                    Position = newUDim2(.5,0,0,0);
                    Color = c3new(.1,.1,1);
                    Text = 'B';
                    Size = 13;
                    Font = 2;
                    Outline = true;
                    Center = true;
                    ZIndex = z+6;
                    Parent = objs.bBackground;
                })

                local draggingHue, draggingSat, draggingTrans = false, false, false;

                local function updateSatVal(pos)
                    if window.colorpicker.selected ~= nil then
                        local hue, sat, val = window.colorpicker.selected.color:ToHSV()
                        X = (objs.mainColor.Object.Position.X + objs.mainColor.Object.Size.X) - objs.mainColor.Object.Position.X
                        Y = (objs.mainColor.Object.Position.Y + objs.mainColor.Object.Size.Y) - objs.mainColor.Object.Position.Y
                        X = math.clamp((pos.X - objs.mainColor.Object.Position.X) / X, 0, 0.995)
                        Y = math.clamp((pos.Y - objs.mainColor.Object.Position.Y) / Y, 0, 0.995)
                        sat, val = 1 - X, 1 - Y;
                        window.colorpicker.selected:SetColor(fromhsv(hue,sat,val));
                        window.colorpicker:Visualize(fromhsv(hue, sat, val), window.colorpicker.selected.trans);
                    end
                end

                local function updateHue(pos)
                    if window.colorpicker.selected ~= nil then
                        local hue, sat, val = window.colorpicker.selected.color:ToHSV()
                        X = (objs.hue.Object.Position.X + objs.hue.Object.Size.X) - objs.hue.Object.Position.X
                        X = math.clamp((pos.X - objs.hue.Object.Position.X) / X, 0, 0.995)
                        hue = 1 - X
                        window.colorpicker.selected:SetColor(fromhsv(hue,sat,val));
                        window.colorpicker:Visualize(fromhsv(hue, sat, val), window.colorpicker.selected.trans);
                    end
                end

                local function updateTrans(pos)
                    if window.colorpicker.selected ~= nil then
                        Y = (objs.trans.Object.Position.Y + objs.trans.Object.Size.Y) - objs.trans.Object.Position.Y
                        Y = math.clamp((pos.Y - objs.transColor.Object.Position.Y) / Y, 0, 0.995)
                        window.colorpicker.selected:SetTrans(Y);
                        window.colorpicker:Visualize(window.colorpicker.selected.color, Y);
                    end
                end

                utility:Connection(objs.mainDetector.MouseButton1Down, function(pos)
                    draggingSat = true;
                    updateSatVal(pos)
                end)

                utility:Connection(objs.hueDetector.MouseButton1Down, function(pos)
                    draggingHue = true;
                    updateHue(pos)
                end)

                utility:Connection(objs.transDetector.MouseButton1Down, function(pos)
                    draggingTrans = true;
                    updateTrans(pos)
                end)

                utility:Connection(mousemove, function(pos)
                    if LeafletUI.open then
                        if draggingSat then
                            updateSatVal(pos)
                        elseif draggingHue then
                            updateHue(pos)
                        elseif draggingTrans then
                            updateTrans(pos)
                        end
                    end
                end)

                utility:Connection(button1up, function()
                    draggingSat = false;
                    draggingHue = false;
                    draggingTrans = false;
                end)

            end

            function window.colorpicker:Visualize(c3, a)
                if typeof(c3) ~= 'Color3' then return end
                if typeof(a) ~= 'number' then return end
                local h,s,v = c3:ToHSV();
                h = h == 0 and 1 or h;
                self.color = c3;
                self.trans = a;
                self.objects.mainColor.Color = fromhsv(h,1,1);
                self.objects.transColor.Color = fromhsv(h,s,v);
                self.objects.hueSlider.Position = newUDim2(1 - h, 0,0,0);
                self.objects.transSlider.Position = newUDim2(0,0,a,0);
                self.objects.pointer.Position = newUDim2(1 - s, 0, 1 - v, 0);
                self.objects.statusText.Text = 'Editing : Unknown';
                if self.selected ~= nil then
                    local txt = 'Editing : Unknown';
                    if self.selected.text ~= nil and self.selected.text ~= '' then
                        txt = tostring(self.selected.text)
                    elseif self.selected.flag ~= nil and self.selected.flag ~= '' then
                        txt = tostring(self.selected.flag)
                    end
                    self.objects.statusText.Text = tostring(txt);
                end
            end
            
            window.colorpicker:Visualize(window.colorpicker.color, window.colorpicker.trans)

        end
        -------------------------

        ---- Create Dropdown ----
        do
            -- Default Objects
            do
                local objs = window.dropdown.objects;
                local z = LeafletUI.zindexOrder.dropdown;

                objs.background = utility:Draw('Square', {
                    Visible = false;
                    Size = newUDim2(1,-3,0,50);
                    Position = newUDim2(0,3,1,0);
                    ThemeColor = 'Background';
                    ZIndex = z;
                    Parent = window.objects.background;
                })

                objs.border1 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z-1;
                    Parent = objs.background;
                })

                objs.border2 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 1';
                    ZIndex = z-2;
                    Parent = objs.border1;
                })

                objs.border3 = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border';
                    ZIndex = z-3;
                    Parent = objs.border2;
                })

            end

            function window.dropdown:Refresh()
                if self.selected ~= nil then
                    local list = self.selected
                    for idx, value in next, list.values do
                        local valueObject = self.objects.values[idx]
                        if valueObject == nil then
                            valueObject = {};
                            valueObject.background = utility:Draw('Square', {
                                Size = newUDim2(1,-4,0,18);
                                Color = Color3.new(.25,.25,.25);
                                Transparency = 0;
                                ZIndex = LeafletUI.zindexOrder.dropdown+1;
                                Parent = self.objects.background;
                            })
                            valueObject.text = utility:Draw('Text', {
                                Position = newUDim2(0,3,0,1);
                                ThemeColor = 'Option Text 2';
                                Text = tostring(value);
                                Size = 13;
                                Font = 2;
                                ZIndex = LeafletUI.zindexOrder.dropdown+2;
                                Parent = valueObject.background;
                            })
                            valueObject.connection = utility:Connection(valueObject.background.MouseButton1Down, function()
                                local currentList = self.selected
                                if currentList then
                                    local val = currentList.values[idx]
                                    local currentSelected = currentList.selected;
                                    local newSelected = currentList.multi and {} or val;
                                    
                                    if currentList.multi then
                                        for i,v in next, currentSelected do
                                            if v == "none" then continue end
                                            newSelected[i] = v;
                                        end
                                        if table.find(newSelected, val) then
                                            table.remove(newSelected, table.find(newSelected, val));
                                        else
                                            table.insert(newSelected, val)
                                        end
                                    end

                                    currentList:Select(newSelected);
                                    if not currentList.multi then
                                        currentList.open = false;
                                        currentList.objects.openText.Text = '+';
                                        window.dropdown.selected = nil;
                                        window.dropdown.objects.background.Visible = false;
                                    end

                                    for idx, val in next, currentList.values do
                                        local valueObj = self.objects.values[idx]
                                        if valueObj then
                                            valueObj.background.Transparency = (typeof(newSelected) == 'table' and table.find(newSelected, val) or newSelected == val) and 1 or 0
                                        end
                                    end

                                end
                            end)
                            self.objects.values[idx] = valueObject
                        end
                    end

                    for idx, val in next, list.values do
                        local valueObj = self.objects.values[idx]
                        if valueObj then
                            valueObj.background.Transparency = (typeof(list.selected) == 'table' and table.find(list.selected, val) or list.selected == val) and 1 or 0
                        end
                    end

                    local y,padding = 2,2
                    for idx, obj in next, self.objects.values do
                        local valueStr = list.values[idx]
                        obj.background.Visible = valueStr ~= nil
                        if valueStr ~= nil then
                            obj.background.Position = newUDim2(0,2,0,y);
                            obj.text.Text = valueStr;
                            y = y + obj.background.Object.Size.Y + padding;
                        end
                    end

                    self.objects.background.Size = newUDim2(1,-6,0,y);    

                end
            end
        
            window.dropdown:Refresh();
        end
        -------------------------

        local function tooltip(option)
            utility:Connection(option.objects.holder.MouseEnter, function()
                tooltipObjects.background.Visible = (not (option.tooltip == '' or option.tooltip == nil)) and true or false;
                tooltipObjects.riskytext.Visible = option.risky;
                tooltipObjects.text.Position = option.risky and newUDim2(0,60,0,0) or newUDim2(0,3,0,0)
                tooltipObjects.text.Text = tostring(option.tooltip);
                LeafletUI.CurrentTooltip = option;
            end)
            utility:Connection(option.objects.holder.MouseLeave, function()
                if LeafletUI.CurrentTooltip == option then
                    LeafletUI.CurrentTooltip = nil;
                    tooltipObjects.background.Visible = false
                end
            end)
        end


        local visValues = {};

        function window:SetOpen(bool)
            if typeof(bool) == 'boolean' then
                self.open = bool;

                local objs = self.objects.background:GetDescendants()
                table.insert(objs, self.objects.background)

                task.spawn(function()
                    if not bool then
                        task.wait(.1);
                    end
                    self.objects.background.Visible = bool;
                end)

                for _,v in next, objs do
                    if v.Object.Transparency ~= 0 then
                        task.spawn(function()
                            if bool then
                                utility:Tween(v.Object, 'Transparency', visValues[v] or 1, .1);
                            else
                                visValues[v] = v.Object.Transparency;
                                utility:Tween(v.Object, 'Transparency', .05, .1);
                            end
                        end)
                    end
                end
            end
        end

        function window:AddTab(text, order)
            local tab = {
                text = text;
                order = order or #self.tabs+1;
                callback = function() end;
                objects = {};
                sections = {};
            }

            table.insert(self.tabs, tab);

            --- Create Objects ---
            do
                local objs = tab.objects;
                local z = LeafletUI.zindexOrder.window + 5;

                objs.background = utility:Draw('Square', {
                    Size = newUDim2(0,50,1,0);
                    Parent = self.objects.tabHolder;
                    ThemeColor = 'Unselected Tab Background';
                    ZIndex = z;
                })

                objs.innerBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 1';
                    ZIndex = z-1;
                    Parent = objs.background;
                })
    
                objs.outerBorder = utility:Draw('Square', {
                    Size = newUDim2(1,2,1,2);
                    Position = newUDim2(0,-1,0,-1);
                    ThemeColor = 'Border 3';
                    ZIndex = z-2;
                    Parent = objs.innerBorder;
                })

                objs.topBorder = utility:Draw('Square', {
                    Size = newUDim2(1,0,0,1);
                    ThemeColor = 'Unselected Tab Background';
                    ZIndex = z+1;
                    Parent = objs.background;
                })

                objs.text = utility:Draw('Text', {
                    ThemeColor = 'Unselected Tab Text';
                    Text = text;
                    Size = 13;
                    Font = 2;
                    ZIndex = z+1;
                    Outline = true;
                    Center = true;
                    Parent = objs.background;
                })

                utility:Connection(objs.background.MouseButton1Down, function()
                    tab:Select();
                end)

            end
            ----------------------

            function tab:AddSection(text, side, order)
                local section = {
                    text = tostring(text);
                    side = side == nil and 1 or clamp(side,1,2);
                    order = order or #self.sections+1;
                    enabled = true;
                    objects = {};
                    options = {};
                };

                table.insert(self.sections, section);

                --- Create Objects ---
                do
                    local objs = section.objects;
                    local z = LeafletUI.zindexOrder.window+15;

                    objs.background = utility:Draw('Square', {
                        ThemeColor = 'Section Background';
                        ZIndex = z;
                        Parent = window.objects['columnholder'..(section.side)];
                    })

                    objs.innerBorder = utility:Draw('Square', {
                        Size = newUDim2(1,2,1,1);
                        Position = newUDim2(0,-1,0,0);
                        ThemeColor = 'Border 3';
                        ZIndex = z-1;
                        Parent = objs.background;
                    })

                    objs.outerBorder = utility:Draw('Square', {
                        Size = newUDim2(1,2,1,1);
                        Position = newUDim2(0,-1,0,0);
                        ThemeColor = 'Border 1';
                        ZIndex = z-2;
                        Parent = objs.innerBorder;
                    })

                    objs.topBorder1 = utility:Draw('Square', {
                        Size = newUDim2(.025,1,0,1);
                        Position = newUDim2(0,-1,0,0);
                        ThemeColor = 'Accent';
                        ZIndex = z+1;
                        Parent = objs.background;
                    })

                    objs.topBorder2 = utility:Draw('Square', {
                        ThemeColor = 'Accent';
                        ZIndex = z+1;
                        Parent = objs.background;
                    })

                    objs.textlabel = utility:Draw('Text', {
                        Position = newUDim2(.0425,0,0,-7);
                        ThemeColor = 'Primary Text';
                        Size = 13;
                        Font = 2;
                        ZIndex = z+1;
                        Parent = objs.background;
                    })

                    objs.optionholder = utility:Draw('Square',{
                        Size = newUDim2(1-.03,0,1,-15);
                        Position = newUDim2(.015,0,0,13);
                        Transparency = 0;
                        ZIndex = z+1;
                        Parent = objs.background;
                    })
                    
                end
                ----------------------

                function section:SetText(text)
                    self.text = tostring(text);
                    self.objects.textlabel.Text = self.text;
                    local x = self.objects.background.Object.Size.X - self.objects.textlabel.TextBounds.X - 13
                    self.objects.topBorder2.Size = newUDim2(0, x, 0, 1)
                    self.objects.topBorder2.Position = newUDim2(1, 1 + -x, 0, 0)
                end

                function section:UpdateOptions()
                    table.sort(self.options, function(a,b)
                        return a.order < b.order
                    end)

                    local ySize, padding = 15, 0;
                    for i,option in next, self.options do
                        option.objects.holder.Visible = option.enabled
                        if option.enabled then
                            option.objects.holder.Position = newUDim2(0,0,0,ySize-15);
                            ySize += option.objects.holder.Object.Size.Y + padding;
                        end
                    end

                    self.objects.background.Size = newUDim2(1,0,0,ySize);

                end

                function section:SetEnabled(bool)
                    if typeof(bool) == 'boolean' then
                        section.enabled = bool;
                        tab:UpdateSections();
                    end
                end

                ------- Options -------

                -- // Toggle
                function section:AddToggle(data)
                    local toggle = {
                        class = 'toggle';
                        flag = data.flag;
                        text = '';
                        tooltip = '';
                        order = #self.options+1;
                        state = false;
                        risky = false;
                        callback = function() end;
                        enabled = true;
                        options = {};
                        objects = {};
                    };

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) ~= toggle[i] ~= nil then
                            toggle[i] = v
                        end
                    end

                    table.insert(self.options, toggle)

                    if toggle.flag then
                        LeafletUI.flags[toggle.flag] = toggle.state;
                        LeafletUI.options[toggle.flag] = toggle;
                    end

                    --- Create Objects ---
                    do
                        local objs = toggle.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,17);
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(0,8,0,8);
                            Position = newUDim2(0,2,0,4);
                            ThemeColor = 'Option Background';
                            ZIndex = z+3;
                            Parent = objs.holder;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp45;
                            Transparency = .25;
                            ZIndex = z+4;
                            Parent = objs.background;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+2;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z+1;
                            Parent = objs.border1;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,19,0,1);
                            ThemeColor = 'Option Text 3';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = toggle.state and 'Accent' or 'Option Border 1';
                        end)

                        utility:Connection(objs.holder.MouseButton1Down, function()
                            toggle:SetState(not toggle.state);
                        end)

                    end
                    ----------------------

                    function toggle:SetState(bool, nocallback)
                        if typeof(bool) == 'boolean' then
                            self.state = bool;
                            if self.flag then
                                LeafletUI.flags[self.flag] = bool;
                            end

                            self.objects.border1.ThemeColor = bool and 'Accent' or (self.objects.holder.Hover and 'Accent' or 'Option Border 1');
                            self.objects.text.ThemeColor = bool and (self.risky and 'Risky Text Enabled' or 'Option Text 1') or (self.risky and 'Risky Text' or 'Option Text 3');
                            self.objects.background.ThemeColor = bool and 'Accent' or 'Option Background';
                            self.objects.background.ThemeColorOffset = bool and -55 or 0

                            if not nocallback then
                                self.callback(bool);
                            end

                        end
                    end

                    function toggle:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                        end
                    end

                    function toggle:UpdateOptions()
                        table.sort(self.options, function(a,b)
                            return a.order < b.order
                        end)

                        local x, y = 0, 0
                        for i,option in next, self.options do
                            option.objects.holder.Visible = option.enabled
                            if option.enabled then
                                if option.class == 'color' or option.class == 'bind' then
                                    option.objects.holder.Position = newUDim2(1,-option.objects.holder.Object.Size.X-x,0,0);
                                    x = x + option.objects.holder.Object.Size.X;
                                elseif option.class == 'slider' or option.class == 'list' then
                                    option.objects.holder.Position = newUDim2(0,0,1,-option.objects.holder.Object.Size.Y-y);
                                    y = y + option.objects.holder.Object.Size.Y;
                                end
                            end
                        end

                        self.objects.holder.Size = newUDim2(1,0,0,17 + y);
                        section:UpdateOptions()

                    end

                    -- // Toggle Addons
                    function toggle:AddColor(data)
                        local color = {
                            class = 'color';
                            flag = data.flag;
                            text = '';
                            tooltip = '';
                            order = #self.options+1;
                            callback = function() end;
                            color = Color3.new(1,1,1);
                            trans = 0;
                            open = false;
                            enabled = true;
                            objects = {};
                        };
    
                        local blacklist = {'objects'};
                        for i,v in next, data do
                            if not table.find(blacklist, i) and color[i] ~= nil then
                                color[i] = v
                            end
                        end
                        
                        table.insert(self.options, color)
    
                        if color.flag then
                            LeafletUI.flags[color.flag] = color.color;
                            LeafletUI.options[color.flag] = color;
                        end
    
                        --- Create Objects ---
                        do
                            local objs = color.objects;
                            local z = LeafletUI.zindexOrder.window+25;
    
                            objs.holder = utility:Draw('Square', {
                                Size = newUDim2(0,21,0,17);
                                Transparency = 0;
                                ZIndex = z+6;
                                Parent = self.objects.holder;
                            })
    
                            objs.background = utility:Draw('Square', {
                                Size = newUDim2(0,15,0,8);
                                Position = newUDim2(0,4,0,5);
                                ZIndex = z+3;
                                Parent = objs.holder;
                            })
    
                            objs.gradient = utility:Draw('Image', {
                                Size = newUDim2(1,0,1,0);
                                Data = LeafletUI.images.gradientp45;
                                Transparency = .25;
                                ZIndex = z+4;
                                Parent = objs.background;
                            })
    
                            objs.border1 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 1';
                                ZIndex = z+2;
                                Parent = objs.background;
                            })
    
                            objs.border2 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 2';
                                ZIndex = z+1;
                                Parent = objs.border1;
                            })
    
                            utility:Connection(objs.holder.MouseEnter, function()
                                objs.border1.ThemeColor = 'Accent';
                            end)
    
                            utility:Connection(objs.holder.MouseLeave, function()
                                objs.border1.ThemeColor = color.state and 'Accent' or 'Option Border 1';
                            end)
    
                            utility:Connection(objs.holder.MouseButton1Down, function()
                                color:SetOpen(not color.open);
                            end)
    
                        end
                        ----------------------

    
                        function color:SetColor(c3, nocallback)
                            if typeof(c3) == 'Color3' then
                                local h,s,v = c3:ToHSV(); c3 = fromhsv(h, clamp(s,.005,.995), clamp(v,.005,.995))
                                self.color = c3;
                                self.objects.background.Color = c3;
                                if not nocallback then
                                    self.callback(c3, self.trans);
                                end
                                if self.open then
                                    window.colorpicker:Visualize(self.color, self.trans);
                                end
                                if self.flag then
                                    LeafletUI.flags[self.flag] = c3;
                                end
                            end
                        end
    
                        function color:SetTrans(trans, nocallback)
                            if typeof(trans) == 'number' then
                                self.trans = trans;
                                if not nocallback then
                                    self.callback(self.color, trans);
                                end
                                if self.open then
                                    window.colorpicker:Visualize(self.color, self.trans);
                                end
                            end
                        end
    
                        function color:SetOpen(bool)
                            if typeof(bool) == 'boolean' then
                                self.open = bool
                                if bool then
                                    if window.colorpicker.selected then
                                        window.colorpicker.selected.open = false;
                                    end
                                    window.colorpicker.selected = color
                                    window.colorpicker.objects.background.Parent = self.objects.background;
                                    window.colorpicker.objects.background.Visible = true;
                                    window.colorpicker:Visualize(color.color, color.trans)
                                elseif window.colorpicker.selected == color then
                                    window.colorpicker.selected = nil;
                                    window.colorpicker.objects.background.Parent = window.objects.background;
                                    window.colorpicker.objects.background.Visible = false;
                                end
                            end
                        end
    
                        tooltip(color);
                        color:SetColor(color.color, true);
                        color:SetTrans(color.trans, true);
                        self:UpdateOptions();
                        return color
                    end

                    function toggle:AddBind(data)
                        local bind = {
                            class = 'bind';
                            flag = data.flag;
                            text = '';
                            tooltip = '';
                            bind = 'none';
                            mode = 'toggle';
                            order = #self.options+1;
                            callback = function() end;
                            keycallback = function() end;
                            indicatorValue = LeafletUI.keyIndicator:AddValue({value = 'value', key = 'key', enabled = false});
                            noindicator = false;
                            invertindicator = false;
                            state = false;
                            nomouse = false;
                            enabled = true;
                            binding = false;
                            objects = {};
                        };
    
                        local blacklist = {'objects'};
                        for i,v in next, data do
                            if not table.find(blacklist, i) and bind[i] ~= nil then
                                bind[i] = v
                            end
                        end
                        
                        table.insert(self.options, bind)
    
                        if bind.flag then
                            LeafletUI.options[bind.flag] = bind;
                        end

                        if bind.bind == 'none' then
                            bind.state = true
                            if bind.flag then
                                LeafletUI.flags[bind.flag] = bind.state;
                            end
                            bind.callback(true)
                            local display = bind.state; if bind.invertindicator then display = not bind.state; end
                            bind.indicatorValue:SetEnabled(display and not bind.noindicator);
                            bind.indicatorValue:SetKey((bind.text == nil or bind.text == '') and (bind.flag == nil and 'unknown' or bind.flag) or bind.text); -- this is so dumb
                            bind.indicatorValue:SetValue('[Always]');
                        end
    
                        --- Create Objects ---
                        do
                            local objs = bind.objects;
                            local z = LeafletUI.zindexOrder.window+25;
    
                            objs.holder = utility:Draw('Square', {
                                Size = newUDim2(0,0,0,17);
                                Transparency = 0;
                                ZIndex = z+6;
                                Parent = self.objects.holder;
                            })
    
                            objs.keyText = utility:Draw('Text', {
                                ThemeColor = 'Option Text 3';
                                Size = 13;
                                Font = 2;
                                ZIndex = z+1;
                                Parent = objs.holder;
                            })
    
                            utility:Connection(objs.holder.MouseEnter, function()
                                objs.keyText.ThemeColor = 'Accent';
                            end)
    
                            utility:Connection(objs.holder.MouseLeave, function()
                                objs.keyText.ThemeColor = bind.binding and 'Accent' or 'Option Text 3';
                            end)
    
                            utility:Connection(objs.holder.MouseButton1Down, function()
                                if not bind.binding then
                                    bind:SetKeyText('...');
                                    bind.binding = true;
                                end
                            end)
    
                        end
                        ----------------------
    
                        local c
                        function bind:SetBind(keybind)
                            if c then
                                c:Disconnect();
                                if bind.flag then
                                    LeafletUI.flags[bind.flag] = false;
                                end
                                bind.callback(false);
                            end
                            local keyName = 'NONE'
                            self.bind = (keybind and keybind) or keybind or self.bind
                            if self.bind == Enum.KeyCode.Backspace then
                                self.bind = 'none';
                                bind.state = true
                                if bind.flag then
                                    LeafletUI.flags[bind.flag] = bind.state;
                                end
                                self.callback(true)
                                local display = bind.state; if bind.invertindicator then display = not bind.state; end
                                bind.indicatorValue:SetEnabled(display and not bind.noindicator);
                            else
                                keyName = keyNames[keybind] or keybind.Name or keybind
                            end
                            if self.bind ~= 'none' then
                                bind.state = false
                                if bind.flag then
                                    LeafletUI.flags[bind.flag] = bind.state;
                                end
                                self.callback(false)
                                local display = bind.state; if bind.invertindicator then display = not bind.state; end
                                bind.indicatorValue:SetEnabled(display and not bind.noindicator);
                            end
                            self.keycallback(self.bind);
                            self:SetKeyText(keyName:upper());
                            self.indicatorValue:SetKey((self.text == nil or self.text == '') and (self.flag == nil and 'unknown' or self.flag) or self.text); -- this is so dumb
                            self.indicatorValue:SetValue('['..keyName:upper()..']');
                            if self.bind == 'none' then
                                self.indicatorValue:SetValue('[Always]');
                            end
                            self.objects.keyText.ThemeColor = self.objects.holder.Hover and 'Accent' or 'Option Text 3';
                        end
    
                        function bind:SetKeyText(str)
                            str = tostring(str);
                            self.objects.keyText.Text = '['..str..']';
                            self.objects.keyText.Position = newUDim2(0, 2, 0, 2);
                            self.objects.holder.Size = newUDim2(0,self.objects.keyText.TextBounds.X+2,0,17)
                            toggle:UpdateOptions();
                        end
    
                        utility:Connection(inputservice.InputBegan, function(inp)
                            if inputservice:GetFocusedTextBox() then
                                return
                            elseif bind.binding then
                                local key = (table.find({Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}, inp.UserInputType) and not bind.nomouse) and inp.UserInputType
                                bind:SetBind(key or (not table.find(blacklistedKeys, inp.KeyCode)) and inp.KeyCode)
                                bind.binding = false
                            elseif not bind.binding and self.bind == 'none' then
                                bind.state = true
                                LeafletUI.flags[bind.flag] = bind.state
                                local display = bind.state; if bind.invertindicator then display = not bind.state; end
                                bind.indicatorValue:SetEnabled(display and not bind.noindicator)
                            elseif (inp.KeyCode == bind.bind or inp.UserInputType == bind.bind) and not bind.binding then
                                if bind.mode == 'toggle' then
                                    bind.state = not bind.state
                                    if bind.flag then
                                        LeafletUI.flags[bind.flag] = bind.state;
                                    end
                                    bind.callback(bind.state)
                                    local display = bind.state; if bind.invertindicator then display = not bind.state; end
                                    bind.indicatorValue:SetEnabled(display and not bind.noindicator);
                                elseif bind.mode == 'hold' then
                                    if bind.flag then
                                        LeafletUI.flags[bind.flag] = true;
                                    end
                                    bind.indicatorValue:SetEnabled((not bind.invertindicator and true or false) and not bind.noindicator);
                                    c = utility:Connection(runservice.RenderStepped, function()
                                        if bind.callback then
                                            bind.callback(true);
                                        end
                                    end)
                                end
                            end
                        end)
    
                        utility:Connection(inputservice.InputEnded, function(inp)
                            if bind.bind ~= 'none' then
                                if inp.KeyCode == bind.bind or inp.UserInputType == bind.bind then
                                    if c then
                                        c:Disconnect();
                                        if bind.flag then
                                            LeafletUI.flags[bind.flag] = false;
                                        end
                                        if bind.callback then
                                            bind.callback(false);
                                        end
                                        bind.indicatorValue:SetEnabled(bind.invertindicator and true or false);
                                    end
                                end
                            end
                        end)
    
                        tooltip(bind);
                        bind:SetBind(bind.bind);
                        self:UpdateOptions();
                        return bind
                    end

                    function toggle:AddSlider(data)
                        local slider = {
                            class = 'slider';
                            flag = data.flag;
                            suffix = '';
                            tooltip = '';
                            order = #self.options+1;
                            value = 0;
                            min = 0;
                            max = 100;
                            increment = 1;
                            callback = function() end;
                            enabled = true;
                            dragging = false;
                            focused = false;
                            objects = {};
                        };
    
                        local blacklist = {'objects', 'dragging'};
                        for i,v in next, data do
                            if not table.find(blacklist, i) and (slider[i] ~= nil and typeof(slider[i]) == typeof(v)) then
                                slider[i] = v;
                            end
                        end
                
                        table.insert(self.options, slider)

                        if slider.flag then
                            LeafletUI.flags[slider.flag] = slider.value;
                            LeafletUI.options[slider.flag] = slider;
                        end

                        --- Create Objects ---
                        do
                            local objs = slider.objects;
                            local z = LeafletUI.zindexOrder.window+25;

                            objs.holder = utility:Draw('Square', {
                                Size = newUDim2(1,0,0,20);
                                Transparency = 0;
                                ZIndex = z+6;
                                Parent = toggle.objects.holder;
                            })

                            objs.background = utility:Draw('Square', {
                                Size = newUDim2(1,-4,1,-8);
                                Position = newUDim2(0,2,0,4);
                                ThemeColor = 'Option Background';
                                ZIndex = z+2;
                                Parent = objs.holder;
                            })

                            objs.slider = utility:Draw('Square', {
                                Size = newUDim2(0,0,1,0);
                                ThemeColor = 'Accent';
                                ZIndex = z+3;
                                Parent = objs.background;
                            })

                            objs.border1 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 1';
                                ZIndex = z+1;
                                Parent = objs.background;
                            })

                            objs.border2 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 2';
                                ZIndex = z;
                                Parent = objs.border1;
                            })
    
                            objs.gradient = utility:Draw('Image', {
                                Size = newUDim2(1,0,1,0);
                                Data = LeafletUI.images.gradientp90;
                                Transparency = .65;
                                ZIndex = z+4;
                                Parent = objs.background;
                            })
    
                            objs.text = utility:Draw('Text', {
                                Position = newUDim2(.5,0,0,-1);
                                ThemeColor = 'Option Text 3';
                                Size = 13;
                                Font = 2;
                                ZIndex = z+5;
                                Outline = true;
                                Center = true;
                                Parent = objs.background;
                            })

                            utility:Connection(objs.holder.MouseEnter, function()
                                objs.border1.ThemeColor = 'Accent';
                            end)
    
                            utility:Connection(objs.holder.MouseLeave, function()
                                objs.border1.ThemeColor = slider.dragging and 'Accent' or 'Option Border 1';
                            end)
    
                            local c;
                            local inputNumber = '';
                            utility:Connection(slider.objects.holder.MouseButton1Down, function()
                                if inputservice:IsKeyDown(Enum.KeyCode.LeftControl) then
                                    if slider.focused then
                                        slider.focused = false;
                                        c:Disconnect();
                                    else
                                        objs.text.Text = tostring(slider.value)..tostring(slider.suffix)..'/'..tostring(slider.max)..tostring(slider.suffix)..' []';
                                        slider.focused = true;
                                        inputNumber = '';
                                        c = utility:Connection(inputservice.InputBegan, function(inp)
                                            if LeafletUI.numberStrings[inp.KeyCode.Name] then
                                                local number = LeafletUI.numberStrings[inp.KeyCode.Name];
                                                inputNumber = inputNumber..tostring(number);
                                                objs.text.Text = string.format("%.14g", slider.value) .. tostring(slider.suffix) .. "/" .. slider.max .. tostring(slider.suffix) .. " [" .. inputNumber .. "]";
                                            elseif inp.KeyCode == Enum.KeyCode.Backspace then
                                                inputNumber = inputNumber:sub(1,-2);
                                                objs.text.Text = string.format("%.14g", slider.value)..tostring(slider.suffix)..'/'..slider.max..tostring(slider.suffix)..' ['..inputNumber..']';
                                            elseif inp.KeyCode == Enum.KeyCode.Return then
                                                slider:SetValue(tonumber(inputNumber))
                                                slider.focused = false;
                                                c:Disconnect();
                                            elseif inp.KeyCode == Enum.KeyCode.Escape then
                                                slider:SetValue(slider.value, true)
                                                slider.focused = false;
                                                c:Disconnect();
                                            end
                                        end)
                                    end
                                else
                                    slider.dragging = true;
                                    LeafletUI.draggingSlider = slider;
                                end
                            end)
    
                            utility:Connection(button1up, function()
                                objs.border1.ThemeColor = objs.holder.Hover and 'Accent' or 'Option Border 1';
                                slider.dragging = false;
                                LeafletUI.draggingSlider = nil;
                            end)
    
                        end
                        ----------------------
    
                        function slider:SetValue(value, nocallback)
                            if typeof(value) == 'number' then
                                local newValue = clamp(self.increment * floor(value/self.increment), self.min, self.max);
                                local size, pos = self.objects.slider.Size, self.objects.slider.Position;
    
                                if self.min >= 0 then
                                    size = newUDim2((newValue - self.min) / (self.max - self.min), 0, 1, 0);
                                else
                                    size = newUDim2(newValue / (self.max - self.min), 0, 1, 0);
                                    pos = newUDim2((0 - self.min) / (self.max - self.min), 0, 0, 0);
                                end
    
                                utility:Tween(self.objects.slider, 'Size', size, .05, Enum.EasingDirection.Out, Enum.EasingStyle.Quad);
                                utility:Tween(self.objects.slider, 'Position', pos, .05, Enum.EasingDirection.Out, Enum.EasingStyle.Quad);
    
                                self.value = newValue;
                                LeafletUI.flags[self.flag] = newValue;
                                self.objects.text.Text = string.format("%.14g",newValue)..tostring(self.suffix)..'/'..self.max..tostring(self.suffix);
                                self.objects.text.ThemeColor = (self.min < 0 and newValue == 0 or newValue == self.min)  and (self.risky and 'Risky Text' or 'Option Text 3') or (self.risky and 'Risky Text Enabled' or 'Option Text 1');
    
                                if not nocallback then
                                    self.callback(newValue);
                                end
    
                            end
                        end

                        tooltip(slider);
                        slider:SetValue(slider.value, true);
                        self:UpdateOptions();
                        return slider
                    end

                    function toggle:AddList(data)
                        local list = {
                            class = 'list';
                            flag = data.flag;
                            text = '';
                            selected = '';
                            tooltip = '';
                            order = #self.options+1;
                            callback = function() end;
                            enabled = true;
                            multi = false;
                            open = false;
                            values = {};
                            objects = {};
                        }
    
                        table.insert(self.options, list);
    
                        local blacklist = {'objects'};
                        for i,v in next, data do
                            if not table.find(blacklist, i) ~= list[i] ~= nil then
                                list[i] = v
                            end
                        end
    
                        if list.flag then
                            LeafletUI.flags[list.flag] = list.selected;
                            LeafletUI.options[list.flag] = list;
                        end
    
                        -- Create Objects --
                        do
                            local objs = list.objects;
                            local z = LeafletUI.zindexOrder.window+25;
    
                            objs.holder = utility:Draw('Square', {
                                Size = newUDim2(1,0,0,22);
                                Transparency = 0;
                                ZIndex = z+6;
                                Parent = toggle.objects.holder;
                            })
    
                            objs.background = utility:Draw('Square', {
                                Size = newUDim2(1,-4,1,-8);
                                Position = newUDim2(0,2,0,4);
                                ThemeColor = 'Option Background';
                                ZIndex = z+2;
                                Parent = objs.holder;
                            })
    
                            objs.border1 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 1';
                                ZIndex = z+1;
                                Parent = objs.background;
                            })
    
                            objs.border2 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 2';
                                ZIndex = z;
                                Parent = objs.border1;
                            })
    
                            objs.gradient = utility:Draw('Image', {
                                Size = newUDim2(1,0,1,0);
                                Data = LeafletUI.images.gradientp90;
                                Transparency = .65;
                                ZIndex = z+4;
                                Parent = objs.background;
                            })
    
                            objs.inputText = utility:Draw('Text', {
                                Position = newUDim2(0,4,0,0);
                                ThemeColor = 'Option Text 2';
                                Text = 'none',
                                Size = 13;
                                Font = 2;
                                ZIndex = z+5;
                                Outline = true;
                                Parent = objs.background;
                            })
    
                            objs.openText = utility:Draw('Text', {
                                Position = newUDim2(1,-10,0,0);
                                ThemeColor = 'Option Text 3';
                                Text = '+';
                                Size = 13;
                                Font = 2;
                                ZIndex = z+5;
                                Outline = true;
                                Parent = objs.background;
                            })
    
                            utility:Connection(objs.holder.MouseEnter, function()
                                objs.border1.ThemeColor = 'Accent';
                            end)
    
                            utility:Connection(objs.holder.MouseLeave, function()
                                objs.border1.ThemeColor = 'Option Border 1';
                            end)
    
                            utility:Connection(objs.holder.MouseButton1Down, function()
                                if list.open then
                                    list.open = false;
                                    objs.openText.Text = '+';
                                    if window.dropdown.selected == list then
                                        window.dropdown.selected = nil;
                                        window.dropdown.objects.background.Visible = false;
                                    end
                                else
                                    if window.dropdown.selected ~= nil then
                                        window.dropdown.selected.open = false
                                    end
                                    list.open = true;
                                    objs.openText.Text = '-';
                                    window.dropdown.selected = list;
                                    window.dropdown.objects.background.Visible = true;
                                    window.dropdown.objects.background.Parent = objs.holder;
                                    window.dropdown:Refresh();
                                end
                            end)
    
    
                        end
                        --------------------
    
                        function list:Select(option, nocallback)
                            option = typeof(option) == 'table' and (self.multi == true and option or (#option == 0 and nil or option[1])) or self.multi == true and {option} or option;
                            if option ~= nil then
                                self.selected = option;
                                local text = typeof(option) == 'table' and (#option == 0 and "none" or table.concat(option, ', ')) or tostring(option);
                                local label = self.objects.inputText
                                label.Text = text;
                                if label.TextBounds.X > self.objects.background.Object.Size.X - 10 then
                                    local split = text:split('');
                                    for i = 1,#split do
                                        label.Text = table.concat(split, '', 1, i)
                                        if label.TextBounds.X > self.objects.background.Object.Size.X - 10 then
                                            label.Text = label.Text:sub(1,-6)..'...';
                                            break
                                        end
                                    end
                                end
                                if self.flag then
                                    LeafletUI.flags[self.flag] = self.selected
                                end
                                if not nocallback then
                                    self.callback(self.selected);
                                end
                            end
                        end
    
                        function list:AddValue(value)
                            table.insert(list.values, tostring(value));
                            if window.dropdown.selected == list then
                                window.dropdown:Refresh()
                            end
                        end
    
                        function list:RemoveValue(value)
                            if table.find(list.values, value) then
                                table.remove(list.values, table.find(list.values, value));
                                if window.dropdown.selected == list then
                                    window.dropdown:Refresh()
                                end
                            end
                        end
    
                        function list:ClearValues()
                            table.clear(list.values);
                            if window.dropdown.selected == list then
                                window.dropdown:Refresh()
                            end
                        end
    
                        tooltip(list);
                        list:Select((data.value or data.selected) or (list.multi and 'none' or list.values[1]), true);
                        self:UpdateOptions();
                        return list
                    end

                    tooltip(toggle);
                    toggle:SetText(toggle.text);
                    toggle:SetState(toggle.state, true);
                    self:UpdateOptions();
                    return toggle
                end

                -- // Slider
                function section:AddSlider(data)
                    local slider = {
                        class = 'slider';
                        flag = data.flag;
                        text = '';
                        tooltip = '';
                        suffix = '';
                        order = #self.options+1;
                        value = 0;
                        min = 0;
                        max = 100;
                        increment = 1;
                        callback = function() end;
                        enabled = true;
                        dragging = false;
                        focused = false;
                        risky = false;
                        objects = {};
                    };

                    local blacklist = {'objects', 'dragging'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and (slider[i] ~= nil and typeof(slider[i]) == typeof(v)) then
                            slider[i] = v;
                        end
                    end
                    
                    table.insert(self.options, slider)

                    if slider.flag then
                        LeafletUI.flags[slider.flag] = slider.value;
                        LeafletUI.options[slider.flag] = slider;
                    end

                    --- Create Objects ---
                    do
                        local objs = slider.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,32);
                            Transparency = 0;
                            ZIndex = z+4;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(1,-4,0,11);
                            Position = newUDim2(0,2,1,-14);
                            ThemeColor = 'Option Background';
                            ZIndex = z+2;
                            Parent = objs.holder;
                        })

                        objs.slider = utility:Draw('Square', {
                            Size = newUDim2(0,0,1,0);
                            ThemeColor = 'Accent';
                            ZIndex = z+3;
                            Parent = objs.background;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+1;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.border1;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp90;
                            Transparency = .65;
                            ZIndex = z+4;
                            Parent = objs.background;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,1);
                            ThemeColor = 'Option Text 3';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        objs.plusDetector = utility:Draw('Square', {
                            Size = newUDim2(0,14,0,14);
                            Position = newUDim2(1,-28,0,1);
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = objs.holder;
                        })

                        objs.minusDetector = utility:Draw('Square', {
                            Size = newUDim2(0,14,0,14);
                            Position = newUDim2(1,-14,0,1);
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = objs.holder;
                        })

                        objs.plusText = utility:Draw('Text', {
                            Position = newUDim2(.5,0,0,-1);
                            ThemeColor = 'Option Text 3';
                            Text = '+';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+4;
                            Center = true;
                            Outline = true;
                            Parent = objs.plusDetector;
                        })

                        objs.minusText = utility:Draw('Text', {
                            Position = newUDim2(.5,0,0,-1);
                            ThemeColor = 'Option Text 3';
                            Text = '-';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+4;
                            Center = true;
                            Outline = true;
                            Parent = objs.minusDetector;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = slider.dragging and 'Accent' or 'Option Border 1';
                        end)

                        utility:Connection(slider.objects.plusDetector.MouseButton1Down,function()
                            slider:SetValue(slider.value + (inputservice:IsKeyDown(Enum.KeyCode.LeftShift) and 10 or slider.increment))
                        end)
    
                        utility:Connection(slider.objects.minusDetector.MouseButton1Down,function()
                            slider:SetValue(slider.value - (inputservice:IsKeyDown(Enum.KeyCode.LeftShift) and 10 or slider.increment))
                        end)


                        local c;
                        local inputNumber = '';
                        utility:Connection(slider.objects.holder.MouseButton1Down, function()
                            if inputservice:IsKeyDown(Enum.KeyCode.LeftControl) then
                                if slider.focused then
                                    slider.focused = false;
                                    c:Disconnect();
                                else
                                    objs.text.Text = slider.text..': '..tostring(slider.value)..tostring(slider.suffix)..' []';
                                    slider.focused = true;
                                    inputNumber = '';
                                    c = utility:Connection(inputservice.InputBegan, function(inp)
                                        if LeafletUI.numberStrings[inp.KeyCode.Name] then
                                            local number = LeafletUI.numberStrings[inp.KeyCode.Name];
                                            inputNumber = inputNumber..tostring(number);
                                            objs.text.Text = slider.text..': '..string.format("%.14g",slider.value)..tostring(slider.suffix)..' ['..inputNumber..']';
                                        elseif inp.KeyCode == Enum.KeyCode.Backspace then
                                            inputNumber = inputNumber:sub(1,-2);
                                            objs.text.Text = slider.text..': '..string.format("%.14g",slider.value)..tostring(slider.suffix)..' ['..inputNumber..']';
                                        elseif inp.KeyCode == Enum.KeyCode.Return then
                                            slider:SetValue(tonumber(inputNumber))
                                            slider.focused = false;
                                            c:Disconnect();
                                        elseif inp.KeyCode == Enum.KeyCode.Escape then
                                            slider:SetValue(slider.value, true)
                                            slider.focused = false;
                                            c:Disconnect();
                                        end
                                    end)

                                end


                            else
                                slider.dragging = true;
                                LeafletUI.draggingSlider = slider;
                            end
                        end)

                        utility:Connection(button1up, function()
                            objs.border1.ThemeColor = objs.holder.Hover and 'Accent' or 'Option Border 1';
                            slider.dragging = false;
                            LeafletUI.draggingSlider = nil;
                        end)

                    end
                    ----------------------

                    function slider:SetValue(value, nocallback)
                        if typeof(value) == 'number' then
                            local newValue = clamp(self.increment * floor(value/self.increment), self.min, self.max);
                            local size, pos = self.objects.slider.Size, self.objects.slider.Position;

                            if self.min >= 0 then
                                size = newUDim2((newValue - self.min) / (self.max - self.min), 0, 1, 0);
                            else
                                size = newUDim2(newValue / (self.max - self.min), 0, 1, 0);
                                pos = newUDim2((0 - self.min) / (self.max - self.min), 0, 0, 0);
                            end

                            utility:Tween(self.objects.slider, 'Size', size, .05, Enum.EasingDirection.Out, Enum.EasingStyle.Quad);
                            utility:Tween(self.objects.slider, 'Position', pos, .05, Enum.EasingDirection.Out, Enum.EasingStyle.Quad);

                            self.value = newValue;
                            LeafletUI.flags[self.flag] = newValue;
                            self.objects.text.Text = slider.text..': '..string.format("%.14g",newValue)..tostring(self.suffix);
                            self.objects.text.ThemeColor = (self.min < 0 and newValue == 0 or newValue == self.min)  and (self.risky and 'Risky Text' or 'Option Text 3') or (self.risky and 'Risky Text Enabled' or 'Option Text 1');

                            if not nocallback then
                                self.callback(newValue);
                            end

                        end
                    end

                    function slider:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str..': '..tostring(self.value)..tostring(self.suffix);
                        end
                    end

                    tooltip(slider);
                    slider:SetText(slider.text);
                    slider:SetValue(slider.value, true);
                    self:UpdateOptions();
                    return slider
                end

                -- // Button
                function section:AddButton(data)
                    local button = {
                        class = 'button';
                        flag = data.flag;
                        text = '';
                        suffix = '';
                        tooltip = '';
                        order = #self.options+1;
                        callback = function() end;
                        confirm = false;
                        enabled = true;
                        risky = false;
                        objects = {};
                        subbuttons = {};
                    };

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and button[i] ~= nil then
                            button[i] = v;
                        end
                    end
        
                    table.insert(self.options, button)

                    if button.flag then
                        LeafletUI.options[button.flag] = button;
                    end

                    --- Create Objects ---
                    do
                        local objs = button.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,22);
                            Transparency = 0;
                            ZIndex = z+4;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(1,-4,0,14);
                            Position = newUDim2(0,2,0,4);
                            ThemeColor = 'Option Background';
                            ZIndex = z+2;
                            Parent = objs.holder;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+1;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.border1;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp90;
                            Transparency = .65;
                            ZIndex = z+3;
                            Parent = objs.background;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(.5,0,0,0);
                            ThemeColor = 'Option Text 3';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+4;
                            Outline = true;
                            Center = true;
                            Parent = objs.background;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = 'Option Border 1';
                            objs.text.ThemeColor = self.risky and 'Risky Text' or 'Option Text 3';
                            objs.background.ThemeColor = 'Option Background';
                            objs.background.ThemeColorOffset = 0;
                        end)

                        utility:Connection(objs.holder.MouseButton1Up, function()
                            objs.text.ThemeColor = self.risky and 'Risky Text' or  'Option Text 3';
                            objs.background.ThemeColor = 'Option Background';
                            objs.background.ThemeColorOffset = 0;
                        end)

                        local clicked, counting = false, false
                        utility:Connection(objs.holder.MouseButton1Down, function()
                            objs.text.ThemeColor = self.risky and 'Risky Text Enabled' or 'Option Text 2';
                            objs.background.ThemeColor = 'Accent';
                            objs.background.ThemeColorOffset = -95;

                            task.spawn(function() -- this is ugly and i do not care :)
                                if button.confirm then
                                    if clicked then
                                        clicked = false
                                        counting = false
                                        objs.text.Text = button.text
                                        button.callback()
                                    else
                                        clicked = true
                                        counting = true
                                        for i = 3,1,-1 do
                                            if not counting then
                                                break
                                            end
                                            objs.text.Text = 'Confirm '..button.text..'? '..tostring(i)
                                            wait(1)
                                        end
                                        clicked = false
                                        counting = false
                                        objs.text.Text = button.text
                                    end
                                else
                                    button.callback()
                                end
                            end)

                        end)

                    end
                    ----------------------
                    function button:AddButton(data)
                        local button = {
                            class = 'button';
                            flag = data.flag;
                            text = '';
                            suffix = '';
                            tooltip = '';
                            order = #self.subbuttons+1;
                            callback = function() end;
                            confirm = false;
                            enabled = true;
                            objects = {};
                        };
    
                        local blacklist = {'objects'};
                        for i,v in next, data do
                            if not table.find(blacklist, i) and button[i] ~= nil then
                                button[i] = v;
                            end
                        end
            
                        table.insert(self.subbuttons, button)
    
                        if button.flag then
                            LeafletUI.options[button.flag] = button;
                        end
    
                        --- Create Objects ---
                        do
                            local objs = button.objects;
                            local z = LeafletUI.zindexOrder.window+25;
    
                            objs.holder = utility:Draw('Square', {
                                Size = newUDim2(1,0,1,0);
                                Transparency = 0;
                                ZIndex = z+5;
                                Parent = self.objects.holder;
                            })
    
                            objs.background = utility:Draw('Square', {
                                Size = newUDim2(1,-4,1,-8);
                                Position = newUDim2(0,2,0,4);
                                ThemeColor = 'Option Background';
                                ZIndex = z+2;
                                Parent = objs.holder;
                            })
    
                            objs.border1 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 1';
                                ZIndex = z+1;
                                Parent = objs.background;
                            })
    
                            objs.border2 = utility:Draw('Square', {
                                Size = newUDim2(1,2,1,2);
                                Position = newUDim2(0,-1,0,-1);
                                ThemeColor = 'Option Border 2';
                                ZIndex = z;
                                Parent = objs.border1;
                            })
    
                            objs.gradient = utility:Draw('Image', {
                                Size = newUDim2(1,0,1,0);
                                Data = LeafletUI.images.gradientp90;
                                Transparency = .65;
                                ZIndex = z+3;
                                Parent = objs.background;
                            })
    
                            objs.text = utility:Draw('Text', {
                                Position = newUDim2(.5,0,0,0);
                                ThemeColor = 'Option Text 3';
                                Size = 13;
                                Font = 2;
                                ZIndex = z+4;
                                Outline = true;
                                Center = true;
                                Parent = objs.background;
                            })
    
                            utility:Connection(objs.holder.MouseEnter, function()
                                objs.border1.ThemeColor = 'Accent';
                            end)
    
                            utility:Connection(objs.holder.MouseLeave, function()
                                objs.border1.ThemeColor = 'Option Border 1';
                                objs.text.ThemeColor = self.risky and 'Risky Text' or 'Option Text 3';
                                objs.background.ThemeColor = 'Option Background';
                                objs.background.ThemeColorOffset = 0;
                            end)
    
                            utility:Connection(objs.holder.MouseButton1Up, function()
                                objs.text.ThemeColor = self.risky and 'Risky Text' or 'Option Text 3';
                                objs.background.ThemeColor = 'Option Background';
                                objs.background.ThemeColorOffset = 0;
                            end)
    
                            local clicked, counting = false, false
                            utility:Connection(objs.holder.MouseButton1Down, function()
                                objs.text.ThemeColor = self.risky and 'Risky Text Enabled' or 'Option Text 2';
                                objs.background.ThemeColor = 'Accent';
                                objs.background.ThemeColorOffset = -95;
    
                                task.spawn(function() -- this is ugly and i do not care :)
                                    if button.confirm then
                                        if clicked then
                                            clicked = false
                                            counting = false
                                            objs.text.Text = button.text
                                            button.callback()
                                        else
                                            clicked = true
                                            counting = true
                                            for i = 3,1,-1 do
                                                if not counting then
                                                    break
                                                end
                                                objs.text.Text = 'Confirm '..button.text..'? '..tostring(i)
                                                wait(1)
                                            end
                                            clicked = false
                                            counting = false
                                            objs.text.Text = button.text
                                        end
                                    else
                                        button.callback()
                                    end
                                end)
    
                            end)
    
                        end
                        ----------------------
    
                        function button:SetText(str)
                            if typeof(str) == 'string' then
                                self.text = str;
                                self.objects.text.Text = str;
                            end
                        end
    
                        tooltip(button);
                        button:SetText(button.text);
                        self:UpdateOptions();
                        return button
                    end
                    ----------------------

                    function button:UpdateOptions() -- this so dumb XD
                        local buttons = 1 + #self.subbuttons;
                        local buttonSize = (1 / buttons) - .005;
                        self.objects.background.Size = newUDim2(buttonSize,-4,0,14);
                        for i,v in next, self.subbuttons do
                            v.objects.holder.Size = newUDim2(buttonSize,0,1,0);
                            v.objects.holder.Position = newUDim2(i * buttonSize + .01, 0, 0, 0)
                        end
                    end

                    function button:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                        end
                    end

                    tooltip(button);
                    button:SetText(button.text);
                    self:UpdateOptions();
                    return button
                end

                -- // Separator
                function section:AddSeparator(data)
                    local separator = {
                        class = 'separator';
                        flag = data.flag;
                        text = '';
                        order = #self.options+1;
                        enabled = true;
                        objects = {};
                    };

                    local blacklist = {'objects', 'dragging'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and (separator[i] ~= nil and typeof(separator[i]) == typeof(v)) then
                            separator[i] = v;
                        end
                    end
        
                    table.insert(self.options, separator)

                    --- Create Objects ---
                    do
                        local objs = separator.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,18);
                            Transparency = 0;
                            ZIndex = z;
                            Parent = section.objects.optionholder;
                        })

                        objs.line1 = utility:Draw('Square', {
                            Position = newUDim2(0,0,0,1);
                            ThemeColor = 'Option Background';
                            ZIndex = z+1;
                            Parent = objs.holder;
                        })

                        objs.line2 = utility:Draw('Square', {
                            Position = newUDim2(0,0,0,1);
                            ThemeColor = 'Option Background';
                            ZIndex = z+1;
                            Parent = objs.holder;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.line1;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.line2;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(.5,0,0,1);
                            ThemeColor = 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z;
                            Outline = true;
                            Center = true;
                            Parent = objs.holder;
                        })

                    end
                    ----------------------

                    function separator:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                            local xScale = ( 1- utility:ConvertNumberRange(self.objects.text.TextBounds.X, 0, self.objects.holder.Object.Size.X, 0, 1)) / 2 - (str == '' and 0 or .04)
                            self.objects.line1.Size = newUDim2(xScale, 0, 0, 1)
                            self.objects.line2.Size = newUDim2(xScale, 0, 0, 1)
                            self.objects.line1.Position = newUDim2(0,1,.5,-1)
                            self.objects.line2.Position = newUDim2(1 - self.objects.line2.Size.X.Scale,-1,.5,-1)
                        end
                    end

                    separator:SetText(separator.text);
                    self:UpdateOptions();
                    return separator
                end

                -- // Color Picker
                function section:AddColor(data)
                    local color = {
                        class = 'color';
                        flag = data.flag;
                        text = '';
                        tooltip = '';
                        order = #self.options+1;
                        callback = function() end;
                        color = Color3.new(1,1,1);
                        trans = 0;
                        open = false;
                        enabled = true;
                        risky = false;
                        objects = {};
                    };

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and color[i] ~= nil then
                            color[i] = v
                        end
                    end
                    
                    table.insert(self.options, color)

                    if color.flag then
                        LeafletUI.flags[color.flag] = color.color;
                        LeafletUI.options[color.flag] = color;
                    end

                    --- Create Objects ---
                    do
                        local objs = color.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,19);
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(0,15,0,8);
                            Position = newUDim2(1,-16,0,5);
                            ZIndex = z+3;
                            Parent = objs.holder;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp45;
                            Transparency = .25;
                            ZIndex = z+4;
                            Parent = objs.background;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+2;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z+1;
                            Parent = objs.border1;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,2);
                            ThemeColor = color.risky and 'Risky Text Enabled' or 'Option Text 3';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = color.state and 'Accent' or 'Option Border 1';
                        end)

                        utility:Connection(objs.holder.MouseButton1Down, function()
                            color:SetOpen(not color.open);
                        end)

                    end
                    ----------------------

                    function color:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                        end
                    end

                    function color:SetColor(c3, nocallback)
                        if typeof(c3) == 'Color3' then
                            local h,s,v = c3:ToHSV(); c3 = fromhsv(h, clamp(s,.005,.995), clamp(v,.005,.995));
                            self.color = c3;
                            self.objects.background.Color = c3;
                            if not nocallback then
                                self.callback(c3, self.trans);
                            end
                            if self.open then
                                window.colorpicker:Visualize(self.color, self.trans);
                            end
                            if self.flag then
                                LeafletUI.flags[self.flag] = c3;
                            end
                        end
                    end

                    function color:SetTrans(trans, nocallback)
                        if typeof(trans) == 'number' then
                            self.trans = trans;
                            if not nocallback then
                                self.callback(self.color, trans);
                            end
                            if self.open then
                                window.colorpicker:Visualize(self.color, self.trans);
                            end
                        end
                    end

                    function color:SetOpen(bool)
                        if typeof(bool) == 'boolean' then
                            self.open = bool
                            if bool then
                                if window.colorpicker.selected then
                                    window.colorpicker.selected.open = false;
                                end
                                window.colorpicker.selected = color
                                window.colorpicker.objects.background.Parent = self.objects.background;
                                window.colorpicker.objects.background.Visible = true;
                                window.colorpicker:Visualize(color.color, color.trans)
                            elseif window.colorpicker.selected == color then
                                window.colorpicker.selected = nil;
                                window.colorpicker.objects.background.Parent = window.objects.background;
                                window.colorpicker.objects.background.Visible = false;
                            end
                        end
                    end

                    tooltip(color);
                    color:SetText(color.text);
                    color:SetColor(color.color, true);
                    color:SetTrans(color.trans, true);
                    self:UpdateOptions();
                    return color
                end

                -- // Text Box
                function section:AddBox(data)
                    local box = {
                        class = 'box';
                        flag = data.flag;
                        text = '';
                        input = '';
                        order = #self.options+1;
                        callback = function() end;
                        enabled = true;
                        focused = false;
                        risky = false;
                        objects = {};
                    };

                    local blacklist = {'objects', 'dragging'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and box[i] ~= nil then
                            box[i] = v;
                        end
                    end
                    
                    table.insert(self.options, box)

                    if box.flag then
                        LeafletUI.flags[box.flag] = box.input;
                        LeafletUI.options[box.flag] = box;
                    end

                    --- Create Objects ---
                    do
                        local objs = box.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,37);
                            Transparency = 0;
                            ZIndex = z+4;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(1,-4,0,15);
                            Position = newUDim2(0,2,1,-17);
                            ThemeColor = 'Option Background';
                            ZIndex = z+2;
                            Parent = objs.holder;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+1;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.border1;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp90;
                            Transparency = .65;
                            ZIndex = z+4;
                            Parent = objs.background;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,2);
                            ThemeColor = box.risky and 'Risky Text Enabled' or 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        objs.inputText = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,0);
                            ThemeColor = 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+5;
                            Outline = true;
                            Parent = objs.background;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = 'Option Border 1';
                        end)

                        utility:Connection(objs.holder.MouseButton1Down, function()
                            if box.focused then
                                box:ReleaseFocus();
                                actionservice:UnbindAction('FreezeMovement');
                            else
                                actionservice:BindAction(
                                    'FreezeMovement',
                                    function()
                                        return Enum.ContextActionResult.Sink
                                    end,
                                    false,
                                    unpack(Enum.PlayerActions:GetEnumItems())
                                )
                                box:CaptureFocus(inputservice:IsKeyDown(Enum.KeyCode.LeftControl));
                                if inputservice:IsKeyDown(Enum.KeyCode.LeftControl) then
                                    objs.inputText.Text = '';
                                end
                            end
                        end)

                    end
                    ----------------------

                    function box:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                        end
                    end

                    function box:SetInput(str, nocallback)
                        if typeof(str) == 'string' then
                            self.input = str;
                            self.objects.inputText.Text = str;
                            if not nocallback then
                                self.callback(str);
                            end
                            if self.flag then
                                LeafletUI.flags[self.flag] = str;
                            end
                        end
                    end

                    local c
                    local input = box.input;
                    function box:CaptureFocus(clear)
                        box.focused = true

                        if clear then
                            input = '';
                        end

                        self.objects.inputText.ThemeColor = 'Option Text 1';
                        c = utility:Connection(inputservice.InputBegan, function(inp)
                            if inp.KeyCode == Enum.KeyCode.Return or inp.UserInputType == Enum.UserInputType.MouseButton1 then
                                box:ReleaseFocus(true);
                            elseif inp.KeyCode == Enum.KeyCode.Escape then
                                input = self.input
                                self.objects.inputText.Text = input;
                                box:ReleaseFocus();
                            elseif inp.KeyCode == Enum.KeyCode.Backspace then
                                input = input:sub(1,-2);
                                self.objects.inputText.Text = input;
                            elseif #inp.KeyCode.Name == 1 or table.find(whitelistedBoxKeys, inp.KeyCode) or inp.KeyCode.Name == 'Space' or inp.KeyCode.Name == 'Minus' or inp.KeyCode.Name == 'Equals' or inp.KeyCode.Name == 'Backquote' then
                                local wlIdx = table.find(whitelistedBoxKeys, inp.KeyCode)
                                local keyString = inp.KeyCode.Name == 'Space' and ' ' or inp.KeyCode.Name == 'Minus' and '_' or inp.KeyCode.Name == 'Equals' and '+' or inp.KeyCode.Name == 'Backquote' and '~' or wlIdx ~= nil and tostring(wlIdx-1) or inp.KeyCode.Name
                                if not (inputservice:IsKeyDown(Enum.KeyCode.LeftShift) and not inputservice:IsKeyDown(Enum.KeyCode.RightShift)) then
                                    keyString = keyString:lower();
                                    if inp.KeyCode.Name == 'Minus' then
                                        keyString = '-'
                                    elseif inp.KeyCode.Name == 'Equals' then
                                        keyString = '='
                                    elseif inp.KeyCode.Name == 'Backquote' then
                                        keyString = '`'
                                    end
                                else
                                    if keyString == '1' then
                                        keyString = '!'
                                    elseif keyString == '2' then
                                        keyString = '@'
                                    elseif keyString == '3' then
                                        keyString = '#'
                                    elseif keyString == '4' then
                                        keyString = '$'
                                    elseif keyString == '5' then
                                        keyString = '%'
                                    elseif keyString == '6' then
                                        keyString = '^'
                                    elseif keyString == '7' then
                                        keyString = '&'
                                    elseif keyString == '8' then
                                        keyString = '*'
                                    elseif keyString == '9' then
                                        keyString = '('
                                    elseif keyString == '0' then
                                        keyString = ')'
                                    end
                                end
                                input = input..keyString;
                                self.objects.inputText.Text = input;
                            end
                        end)

                    end

                    function box:ReleaseFocus(apply)
                        box.focused = false;
                        self.objects.inputText.ThemeColor = 'Option Text 2';
                        if apply then
                            box:SetInput(input);
                        end
                        c:Disconnect();
                    end

                    tooltip(box);
                    box:SetText(box.text);
                    box:SetInput(box.input, true);
                    self:UpdateOptions();
                    return box
                end

                -- // Keybind
                function section:AddBind(data)
                    local bind = {
                        class = 'bind';
                        flag = data.flag;
                        text = '';
                        tooltip = '';
                        bind = 'none';
                        mode = 'toggle';
                        order = #self.options+1;
                        callback = function() end;
                        keycallback = function() end;
                        indicatorValue = LeafletUI.keyIndicator:AddValue({value = 'value', key = 'key', enabled = false});
                        noindicator = false;
                        state = false;
                        nomouse = false;
                        enabled = true;
                        binding = false;
                        risky = false;
                        objects = {};
                    };

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and bind[i] ~= nil then
                            bind[i] = v
                        end
                    end
                    
                    table.insert(self.options, bind)

                    if bind.flag then
                        LeafletUI.options[bind.flag] = bind;
                    end

                    --- Create Objects ---
                    do
                        local objs = bind.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,19);
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = section.objects.optionholder;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,2);
                            ThemeColor = bind.risky and 'Risky Text' or 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        objs.keyText = utility:Draw('Text', {
                            ThemeColor = 'Option Text 3';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Parent = objs.holder;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.keyText.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.keyText.ThemeColor = bind.binding and 'Accent' or 'Option Text 3';
                        end)

                        utility:Connection(objs.holder.MouseButton1Down, function()
                            if not bind.binding then
                                bind:SetKeyText('...');
                                bind.binding = true;
                            end
                        end)

                    end
                    ----------------------

                    local c

                    function bind:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                            self.indicatorValue:SetKey(str);
                        end
                    end

                    function bind:SetBind(keybind)
                        if c then
                            c:Disconnect();
                            if bind.flag then
                                LeafletUI.flags[bind.flag] = false;
                            end
                            bind.callback(false);
                        end
                        local keyName = 'NONE'
                        self.bind = (keybind and keybind) or keybind or self.bind
                        if self.bind == Enum.KeyCode.Backspace then
                            self.bind = 'none';
                        else
                            keyName = keyNames[keybind] or keybind.Name or keybind
                        end
                        self.keycallback(self.bind);
                        self:SetKeyText(keyName:upper());
                        self.indicatorValue:SetKey((self.text == nil or self.text == '') and (self.flag == nil and 'unknown' or self.flag) or self.text); -- this is so dumb
                        self.indicatorValue:SetValue('['..keyName:upper()..']');
                        self.objects.keyText.ThemeColor = self.objects.holder.Hover and 'Accent' or 'Option Text 3';
                    end

                    function bind:SetKeyText(str)
                        str = tostring(str);
                        self.objects.keyText.Text = '['..str..']';
                        self.objects.keyText.Position = newUDim2(1,-self.objects.keyText.TextBounds.X, 0, 2);
                    end

                    utility:Connection(inputservice.InputBegan, function(inp)
                        if inputservice:GetFocusedTextBox() then
                            return
                        elseif bind.binding then
                            local key = (table.find({Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3}, inp.UserInputType) and not bind.nomouse) and inp.UserInputType
                            bind:SetBind(key or (not table.find(blacklistedKeys, inp.KeyCode)) and inp.KeyCode)
                            bind.binding = false
                        elseif not bind.binding and self.bind == 'none' then
                            bind.state = true
                            LeafletUI.flags[bind.flag] = bind.state
                        elseif (inp.KeyCode == bind.bind or inp.UserInputType == bind.bind) and not bind.binding then
                            if bind.mode == 'toggle' then
                                bind.state = not bind.state
                                if bind.flag then
                                    LeafletUI.flags[bind.flag] = bind.state;
                                end
                                bind.callback(bind.state)
                                bind.indicatorValue:SetEnabled(bind.state and not bind.noindicator);
                            elseif bind.mode == 'hold' then
                                if bind.flag then
                                    LeafletUI.flags[bind.flag] = true;
                                end
                                bind.indicatorValue:SetEnabled(true and not bind.noindicator);
                                c = utility:Connection(runservice.RenderStepped, function()
                                    bind.callback(true);
                                end)
                            end
                        end
                    end)

                    utility:Connection(inputservice.InputEnded, function(inp)
                        if bind.bind ~= 'none' then
                            if inp.KeyCode == bind.bind or inp.UserInputType == bind.key then
                                if c then
                                    c:Disconnect();
                                    if bind.flag then
                                        LeafletUI.flags[bind.flag] = false;
                                    end
                                    bind.callback(false);
                                    bind.indicatorValue:SetEnabled(false);
                                end
                            end
                        end
                    end)

                    tooltip(bind);
                    bind:SetBind(bind.bind);
                    bind:SetText(bind.text);
                    self:UpdateOptions();
                    return bind
                end

                -- // Dropdown
                function section:AddList(data)
                    local list = {
                        class = 'list';
                        flag = data.flag;
                        text = '';
                        selected = '';
                        tooltip = '';
                        order = #self.options+1;
                        callback = function() end;
                        enabled = true;
                        multi = false;
                        open = false;
                        risky = false;
                        values = {};
                        objects = {};
                    }

                    table.insert(self.options, list);

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) ~= list[i] ~= nil then
                            list[i] = v
                        end
                    end

                    if list.flag then
                        LeafletUI.flags[list.flag] = list.selected;
                        LeafletUI.options[list.flag] = list;
                    end

                    -- Create Objects --
                    do
                        local objs = list.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Size = newUDim2(1,0,0,40);
                            Transparency = 0;
                            ZIndex = z+4;
                            Parent = section.objects.optionholder;
                        })

                        objs.background = utility:Draw('Square', {
                            Size = newUDim2(1,-4,0,15);
                            Position = newUDim2(0,2,1,-19);
                            ThemeColor = 'Option Background';
                            ZIndex = z+2;
                            Parent = objs.holder;
                        })

                        objs.border1 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 1';
                            ZIndex = z+1;
                            Parent = objs.background;
                        })

                        objs.border2 = utility:Draw('Square', {
                            Size = newUDim2(1,2,1,2);
                            Position = newUDim2(0,-1,0,-1);
                            ThemeColor = 'Option Border 2';
                            ZIndex = z;
                            Parent = objs.border1;
                        })

                        objs.gradient = utility:Draw('Image', {
                            Size = newUDim2(1,0,1,0);
                            Data = LeafletUI.images.gradientp90;
                            Transparency = .65;
                            ZIndex = z+4;
                            Parent = objs.background;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,2);
                            ThemeColor = list.risky and 'Risky Text Enabled' or 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })

                        objs.inputText = utility:Draw('Text', {
                            Position = newUDim2(0,4,0,0);
                            ThemeColor = 'Option Text 2';
                            Text = 'none',
                            Size = 13;
                            Font = 2;
                            ZIndex = z+5;
                            Outline = true;
                            Parent = objs.background;
                        })

                        objs.openText = utility:Draw('Text', {
                            Position = newUDim2(1,-10,0,0);
                            ThemeColor = 'Option Text 3';
                            Text = '+';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+5;
                            Outline = true;
                            Parent = objs.background;
                        })

                        utility:Connection(objs.holder.MouseEnter, function()
                            objs.border1.ThemeColor = 'Accent';
                        end)

                        utility:Connection(objs.holder.MouseLeave, function()
                            objs.border1.ThemeColor = 'Option Border 1';
                        end)

                        utility:Connection(objs.holder.MouseButton1Down, function()
                            if list.open then
                                list.open = false;
                                objs.openText.Text = '+';
                                if window.dropdown.selected == list then
                                    window.dropdown.selected = nil;
                                    window.dropdown.objects.background.Visible = false;
                                end
                            else
                                if window.dropdown.selected ~= nil then
                                    window.dropdown.selected.open = false
                                end
                                list.open = true;
                                objs.openText.Text = '-';
                                window.dropdown.selected = list;
                                window.dropdown.objects.background.Visible = true;
                                window.dropdown.objects.background.Parent = objs.holder;
                                window.dropdown:Refresh();
                            end
                        end)


                    end
                    --------------------

                    function list:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                        end
                    end

                    function list:Select(option, nocallback)
                        option = typeof(option) == 'table' and (self.multi == true and option or (#option == 0 and nil or option[1])) or self.multi == true and {option} or option;
                        if option ~= nil then
                            self.selected = option;
                            local text = typeof(option) == 'table' and (#option == 0 and "none" or table.concat(option, ', ')) or tostring(option);
                            local label = self.objects.inputText
                            label.Text = text;
                            if label.TextBounds.X > self.objects.background.Object.Size.X - 10 then
                                local split = text:split('');
                                for i = 1,#split do
                                    label.Text = table.concat(split, '', 1, i)
                                    if label.TextBounds.X > self.objects.background.Object.Size.X - 10 then
                                        label.Text = label.Text:sub(1,-6)..'...';
                                        break
                                    end
                                end
                            end
                            if self.flag then
                                LeafletUI.flags[self.flag] = self.selected
                            end
                            if not nocallback then
                                self.callback(self.selected);
                            end
                        end
                    end

                    function list:AddValue(value)
                        table.insert(list.values, tostring(value));
                        if window.dropdown.selected == list then
                            window.dropdown:Refresh()
                        end
                    end

                    function list:RemoveValue(value)
                        if table.find(list.values, value) then
                            table.remove(list.values, table.find(list.values, value));
                            if window.dropdown.selected == list then
                                window.dropdown:Refresh()
                            end
                        end
                    end

                    function list:ClearValues()
                        table.clear(list.values);
                        if window.dropdown.selected == list then
                            window.dropdown:Refresh()
                        end
                    end

                    tooltip(list);
                    list:Select((data.value or data.selected) or (list.multi and 'none' or list.values[1]), true);
                    list:SetText(list.text);
                    self:UpdateOptions();
                    return list
                end

                -- Text
                function section:AddText(data)
                    local text = {
                        class = 'text';
                        flag = data.flag;
                        text = '';
                        tooltip = '';
                        order = #self.options+1;
                        enabled = true;
                        risky = false;
                        objects = {};
                    };

                    local blacklist = {'objects'};
                    for i,v in next, data do
                        if not table.find(blacklist, i) and text[i] ~= nil then
                            text[i] = v
                        end
                    end

                    if data.flag then
                        LeafletUI.options[data.flag] = text;
                    end

                    table.insert(self.options, text)

                    --- Create Objects ---
                    do
                        local objs = text.objects;
                        local z = LeafletUI.zindexOrder.window+25;

                        objs.holder = utility:Draw('Square', {
                            Transparency = 0;
                            ZIndex = z+5;
                            Parent = section.objects.optionholder;
                        })

                        objs.text = utility:Draw('Text', {
                            Position = newUDim2(0,2,0,2);
                            ThemeColor = text.risky and 'Risky Text Enabled' or 'Option Text 2';
                            Size = 13;
                            Font = 2;
                            ZIndex = z+1;
                            Outline = true;
                            Parent = objs.holder;
                        })
                    end
                    ----------------------

                    function text:SetText(str)
                        if typeof(str) == 'string' then
                            self.text = str;
                            self.objects.text.Text = str;
                            self.objects.holder.Size = newUDim2(1,0,0,self.objects.text.TextBounds.Y + 6);
                            section:UpdateOptions();
                        end
                    end

                    text:SetText(text.text);
                    self:UpdateOptions();
                    return text
                end

                -----------------------

                section:UpdateOptions();
                section:SetText(section.text);
                self:UpdateSections();
                return section;
            end

            function tab:UpdateSections()
                table.sort(self.sections, function(a,b)
                    return a.order < b.order
                end)

                local last1,last2;
                local padding = 15;
                for _,section in next, self.sections do

                    if section.objects.background.Visible ~= (section.enabled and tab.selected) then
                        section.objects.background.Visible = section.enabled and tab.selected
                        section:UpdateOptions();
                    end
                    
                    if section.enabled then
                        if section.side == 1 then
                            if last1 then
                                section.objects.background.Position = last1.objects.background.Position + newUDim2(0,0,0,last1.objects.background.Object.Size.Y + padding);
                            end
                            last1 = section;
                        elseif section.side == 2 then
                            if last2 then
                                section.objects.background.Position = last2.objects.background.Position + newUDim2(0,0,0,last2.objects.background.Object.Size.Y + padding);
                            end
                            last2 = section;
                        end
                    end

                    section:SetText(section.text)
                    
                end
            end

            function tab:SetText(str)
                if typeof(str) == 'string' then
                    self.text = str;
                    self.objects.text.Text = str;
                    window:UpdateTabs();
                end
            end

            function tab:Select()
                window.selectedTab = tab;
                window:UpdateTabs();
                for i,v in next, window.tabs do
                    if v.callback then
                        v.callback(v == tab)
                    end
                end
            end

            if window.selectedTab == nil then
                tab:Select();
            end

            tab:SetText(tab.text);
            window:UpdateTabs();
            return tab;
        end

        function window:UpdateTabs()
            table.sort(self.tabs, function(a,b)
                return a.order < b.order
            end)
            local pos = 0;
            for i,v in next, self.tabs do
                local objs = v.objects;
                v.selected = v == self.selectedTab;
                objs.background.ThemeColor = v.selected and 'Selected Tab Background' or 'Unselected Tab Background';
                objs.background.Size = newUDim2(0, objs.text.TextBounds.X + 14, 1, v.selected and 1 or 0);
                objs.background.Position = newUDim2(0, pos, 0, 0)

                objs.text.ThemeColor = v.selected and 'Selected Tab Text' or 'Unselected Tab Text';
                objs.text.Position = newUDim2(.5, 0, 0, 3);

                objs.topBorder.ThemeColor = v.selected and 'Accent' or 'Unselected Tab Background';

                pos += objs.background.Size.X.Offset + 1

                v:UpdateSections();

            end
        end

        window:SetOpen(true);
        return window;
    end

    -- Tooltip
    do
        local z = LeafletUI.zindexOrder.window + 2000;
        tooltipObjects.background = utility:Draw('Square', {
            ThemeColor = 'Group Background';
            ZIndex = z;
            Visible = false;
        })

        tooltipObjects.border1 = utility:Draw('Square', {
            Size = UDim2.new(1,2,1,2);
            Position = UDim2.new(0,-1,0,-1);
            ThemeColor = 'Border 1';
            ZIndex = z-1;
            Parent = tooltipObjects.background;
        })

        tooltipObjects.border2 = utility:Draw('Square', {
            Size = UDim2.new(1,4,1,4);
            Position = UDim2.new(0,-2,0,-2);
            ThemeColor = 'Border 3';
            ZIndex = z-2;
            Parent = tooltipObjects.background;
        })

        tooltipObjects.text = utility:Draw('Text', {
            Position = UDim2.new(0,3,0,0);
            ThemeColor = 'Primary Text';
            Size = 13;
            Font = 2;
            ZIndex = z+1;
            Outline = true;
            Parent = tooltipObjects.background;
        })

        tooltipObjects.riskytext = utility:Draw('Text', {
            Position = UDim2.new(0,3,0,0);
            ThemeColor = 'Risky Text Enabled';
            Text = '[RISKY]';
            Size = 13;
            Font = 2;
            ZIndex = z+1;
            Outline = true;
            Parent = tooltipObjects.background;
        })

    end
    
    -- Watermark
    do
        if not IonHub_User then
            getgenv().IonHub_User = {
                UID = 0, 
                User = "admin"
            }
        end
        self.watermark = {
            objects = {};
            text = {
                {self.cheatname, true},
                {("%s (uid %s)"):format(IonHub_User.User, tostring(IonHub_User.UID)), true},
                {self.gamename, true},
                {'0 fps', true},
                {'0ms', true},
                {'00:00:00', true},
                {'M, D, Y', true},
            };
            lock = 'custom';
            position = newUDim2(0,0,0,0);
            refreshrate = 25;
        }

        function self.watermark:Update()
            self.objects.background.Visible = LeafletUI.flags.watermark_enabled
            if LeafletUI.flags.watermark_enabled then
                local date = {os.date('%b',os.time()), os.date('%d',os.time()), os.date('%Y',os.time())}
                local daySuffix = math.floor(date[2]%10)
                date[2] = date[2]..(daySuffix == 1 and 'st' or daySuffix == 2 and 'nd' or daySuffix == 3 and 'rd' or 'th')

                self.text[4][1] = LeafletUI.stats.fps..' fps'
                self.text[5][1] = floor(LeafletUI.stats.ping)..'ms'
                self.text[6][1] = os.date('%X', os.time())
                self.text[7][1] = table.concat(date, ', ')

                local text = {};
                for _,v in next, self.text do
                    if v[2] then
                        table.insert(text, v[1]);
                    end
                end

                self.objects.text.Text = table.concat(text,' | ')
                self.objects.background.Size = newUDim2(0, self.objects.text.TextBounds.X + 10, 0, 17)

                local size = self.objects.background.Object.Size;
                local screensize = workspace.CurrentCamera.ViewportSize;

                self.position = (
                    self.lock == 'Top Right' and newUDim2(0, screensize.X - size.X - 15, 0, 15) or
                    self.lock == 'Top Left' and newUDim2(0, 15, 0, 15) or
                    self.lock == 'Bottom Right' and newUDim2(0, screensize.X - size.X - 15, 0, screensize.Y - size.Y - 15) or
                    self.lock == 'Bottom Left' and newUDim2(0, 15, 0, screensize.Y - size.Y - 15) or
                    self.lock == 'Top' and newUDim2(0, screensize.X / 2 - size.X / 2, 0, 15) or
                    newUDim2(LeafletUI.flags.watermark_x / 100, 0, LeafletUI.flags.watermark_y / 100, 0)
                )

                self.objects.background.Position = self.position
            end
        end

        do
            local objs = self.watermark.objects;
            local z = self.zindexOrder.watermark;
            
            objs.background = utility:Draw('Square', {
                Visible = false;
                Size = newUDim2(0, 200, 0, 17);
                Position = newUDim2(0,800,0,100);
                ThemeColor = 'Background';
                ZIndex = z;
            })

            objs.border1 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 2';
                Parent = objs.background;
                ZIndex = z-1;
            })

            objs.border2 = utility:Draw('Square', {
                Size = newUDim2(1,2,1,2);
                Position = newUDim2(0,-1,0,-1);
                ThemeColor = 'Border 3';
                Parent = objs.border1;
                ZIndex = z-2;
            })
            
            objs.topbar = utility:Draw('Square', {
                Size = newUDim2(1,0,0,1);
                ThemeColor = 'Accent';
                ZIndex = z+1;
                Parent = objs.background;
            })

            objs.text = utility:Draw('Text', {
                Position = newUDim2(.5,0,0,2);
                ThemeColor = 'Primary Text';
                Text = 'Watermark Text';
                Size = 13;
                Font = 2;
                ZIndex = z+1;
                Outline = true;
                Center = true;
                Parent = objs.background;
            })

        end
    end

    local lasttick = tick();
    utility:Connection(runservice.RenderStepped, function(step)
        LeafletUI.stats.fps = floor(1/step)
        LeafletUI.stats.ping = stats.Network.ServerStatsItem["Data Ping"]:GetValue()
        LeafletUI.stats.sendkbps = stats.DataSendKbps
        LeafletUI.stats.receivekbps = stats.DataReceiveKbps

        if (tick()-lasttick)*1000 > LeafletUI.watermark.refreshrate then
            lasttick = tick()
            LeafletUI.watermark:Update()
        end
    end)

    self.keyIndicator = self.NewIndicator({title = 'Keybinds', pos = newUDim2(0,15,0,325), enabled = false});
    
    self.targetIndicator = self.NewIndicator({title = 'Target Info', pos = newUDim2(0,15,0,350), enabled = false});
    self.targetName = self.targetIndicator:AddValue({key = 'Name     :', value = 'nil'})
    self.targetDisplay = self.targetIndicator:AddValue({key = 'DName    :', value = 'nil'})
    self.targetHealth = self.targetIndicator:AddValue({key = 'Health   :', value = '0'})
    self.targetDistance = self.targetIndicator:AddValue({key = 'Distance :', value = '0m'})
    self.targetTool = self.targetIndicator:AddValue({key = 'Weapon   :', value = 'nil'})

    self:SetTheme(LeafletUI.theme);
    self:SetOpen(true);
    self.hasInit = true

end

function LeafletUI:CreateSettingsTab(menu)
    local settingsTab = menu:AddTab('Settings', 999);
    local configSection = settingsTab:AddSection('Config', 2);
    local mainSection = settingsTab:AddSection('Main', 1);

    configSection:AddBox({text = 'Config Name', flag = 'configinput'})
    configSection:AddList({text = 'Config', flag = 'selectedconfig'})

    local function refreshConfigs()
        LeafletUI.options.selectedconfig:ClearValues();
        for _,v in next, listfiles(self.cheatname..'/'..self.gamename..'/configs') do
            local ext = '.'..v:split('.')[#v:split('.')];
            if ext == self.fileext then
                LeafletUI.options.selectedconfig:AddValue(v:split('\\')[#v:split('\\')]:sub(1,-#ext-1))
            end
        end
    end

    configSection:AddButton({text = 'Load', confirm = true, callback = function()
        LeafletUI:LoadConfig(LeafletUI.flags.selectedconfig);
    end}):AddButton({text = 'Save', confirm = true, callback = function()
        LeafletUI:SaveConfig(LeafletUI.flags.selectedconfig);
    end})

    configSection:AddButton({text = 'Create', confirm = true, callback = function()
        if LeafletUI:GetConfig(LeafletUI.flags.configinput) then
            LeafletUI:SendNotification('Config \''..LeafletUI.flags.configinput..'\' already exists.', 5, c3new(1,0,0));
            return
        end
        writefile(self.cheatname..'/'..self.gamename..'/configs/'..LeafletUI.flags.configinput.. self.fileext, http:JSONEncode({}));
        refreshConfigs()
    end}):AddButton({text = 'Delete', confirm = true, callback = function()
        if LeafletUI:GetConfig(LeafletUI.flags.selectedconfig) then
            delfile(self.cheatname..'/'..self.gamename..'/configs/'..LeafletUI.flags.selectedconfig.. self.fileext);
            refreshConfigs()
        end
    end})

    refreshConfigs()

    mainSection:AddBind({text = 'Open / Close', flag = 'togglebind', nomouse = true, noindicator = true, bind = Enum.KeyCode.End, callback = function()
        LeafletUI:SetOpen(not LeafletUI.open)
    end});

    mainSection:AddToggle({text = 'Disable Movement If Open', flag = 'disablemenumovement', callback = function(bool)
        if bool and LeafletUI.open then
            actionservice:BindAction(
                'FreezeMovement',
                function()
                    return Enum.ContextActionResult.Sink
                end,
                false,
                unpack(Enum.PlayerActions:GetEnumItems())
            )
        else
            actionservice:UnbindAction('FreezeMovement');
        end
    end})

    mainSection:AddButton({text = 'Join Discord', flag = 'joindiscord', confirm = true, callback = function()
        local res = syn.request({
            Url = 'http://127.0.0.1:6463/rpc?v=1',
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json',
                Origin = 'https://discord.com'
            },
            Body = game:GetService('HttpService'):JSONEncode({
                cmd = 'INVITE_BROWSER',
                nonce = game:GetService('HttpService'):GenerateGUID(false),
                args = {code = 'leafletui'}
            })
        })
        if res.Success then
            LeafletUI:SendNotification(self.cheatname..' | joined discord', 3);
        end
    end})
    
    mainSection:AddButton({text = 'Copy Discord', flag = 'copydiscord', callback = function()
        setclipboard('discord.gg/leafletui')
    end})

    mainSection:AddButton({text = 'Rejoin Server', confirm = true, callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId);
    end})

    mainSection:AddButton({text = 'Rejoin Game', confirm = true, callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId);
    end})

    mainSection:AddButton({text = 'Copy Join Script', callback = function()
        setclipboard(([[game:GetService("TeleportService"):TeleportToPlaceInstance(%s, "%s")]]):format(game.PlaceId, game.JobId))
    end})

    mainSection:AddButton({text = 'Copy Game Invite', callback = function()
        setclipboard(([[Roblox.GameLauncher.joinGameInstance(%s, "%s"))]]):format(game.PlaceId, game.JobId))
    end})

    mainSection:AddButton({text = 'Unload', confirm = true, callback = function()
        LeafletUI:Unload();
    end})

    mainSection:AddSeparator({text = 'Keybinds'});
    mainSection:AddToggle({text = 'Keybind Indicator', flag = 'keybind_indicator', callback = function(bool)
        self.keyIndicator:SetEnabled(bool);
    end})
    mainSection:AddSlider({text = 'Position X', flag = 'keybind_indicator_x', min = 0, max = 100, increment = .1, value = .5, callback = function()
        self.keyIndicator:SetPosition(newUDim2(LeafletUI.flags.keybind_indicator_x / 100, 0, LeafletUI.flags.keybind_indicator_y / 100, 0));    
    end});
    mainSection:AddSlider({text = 'Position Y', flag = 'keybind_indicator_y', min = 0, max = 100, increment = .1, value = 35, callback = function()
        self.keyIndicator:SetPosition(newUDim2(LeafletUI.flags.keybind_indicator_x / 100, 0, LeafletUI.flags.keybind_indicator_y / 100, 0));    
    end});

    mainSection:AddSeparator({text = 'Watermark'})
    mainSection:AddToggle({text = 'Enabled', flag = 'watermark_enabled'});
    mainSection:AddList({text = 'Position', flag = 'watermark_pos', selected = 'Custom', values = {'Top', 'Top Left', 'Top Right', 'Bottom Left', 'Bottom Right', 'Custom'}, callback = function(val)
        self.watermark.lock = val;
    end})
    mainSection:AddSlider({text = 'Custom X', flag = 'watermark_x', suffix = '%', min = 0, max = 100, increment = .1});
    mainSection:AddSlider({text = 'Custom Y', flag = 'watermark_y', suffix = '%', min = 0, max = 100, increment = .1});

    -- Mobile Settings
    if self.utility:IsMobile() then
        mainSection:AddSeparator({text = 'Mobile Controls'})
        mainSection:AddToggle({text = 'Show Controls', flag = 'mobile_controls_enabled', callback = function(bool)
            for _,control in next, self.mobileControls do
                control:SetVisible(bool)
            end
            self.mobileToggleButton:SetVisible(bool)
        end})
    end

    local themeStrings = {"Custom"};
    for _,v in next, LeafletUI.themes do
        table.insert(themeStrings, v.name)
    end
    local themeTab = menu:AddTab('Theme', 990);
    local themeSection = themeTab:AddSection('Theme', 1);
    local setByPreset = false

    themeSection:AddList({text = 'Presets', flag = 'preset_theme', values = themeStrings, callback = function(newTheme)
        if newTheme == "Custom" then return end
        setByPreset = true
        for _,v in next, LeafletUI.themes do
            if v.name == newTheme then
                for x, d in pairs(LeafletUI.options) do
                    if v.theme[tostring(x)] ~= nil then
                        d:SetColor(v.theme[tostring(x)])
                    end
                end
                LeafletUI:SetTheme(v.theme)
                break
            end
        end
        setByPreset = false
    end}):Select('Default');

    for i, v in pairs(LeafletUI.theme) do
        themeSection:AddColor({text = i, flag = i, color = LeafletUI.theme[i], callback = function(c3)
            LeafletUI.theme[i] = c3
            LeafletUI:SetTheme(LeafletUI.theme)
            if not setByPreset and not setByConfig then 
                LeafletUI.options.preset_theme:Select('Custom')
            end
        end});
    end

    return settingsTab;
end

getgenv().LeafletUI = LeafletUI
return LeafletUI
