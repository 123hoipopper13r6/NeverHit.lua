-- idk why did i obfuscate it but anyways

local _0x52 = game:GetService("CoreGui")
local _0x61 = game:GetService("TweenService")
local _0x72 = game:GetService("UserInputService")
local _0x4D = game:GetService("MarketplaceService")

local _0xColors = {
    _0x1 = Color3.fromRGB(16, 16, 16),
    _0x2 = Color3.fromRGB(255, 106, 133),
    _0x3 = Color3.fromRGB(35, 35, 35),
    _0x4 = Color3.fromRGB(22, 22, 22),
    _0x5 = Color3.fromRGB(255, 255, 255),
    _0x6 = Color3.fromRGB(180, 180, 180),
    _0x7 = Color3.fromRGB(120, 255, 120)
}

local _0xFB = Font.new('rbxasset://fonts/families/GothamSSm.json', Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)

local _0xURL = "\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\49\50\51\104\111\105\112\111\112\112\101\114\49\51\114\54\47\78\101\118\101\114\72\105\116\46\108\117\97\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\71\97\109\101\45\83\117\112\112\111\114\116\47\83\116\97\116\117\115\46\108\117\97"
local _0xPT = "\40\37\100\43\41\37\115\42\61\37\115\42\34\40\91\94\34\93\43\41\34"
local _0xT1 = "\78\69\86\69\82\72\73\84\46\76\85\65"
local _0xT2 = "\76\79\65\68\69\82"
local _0xSC = {}

local function _0xUpd()
    local _0xS, _0xR = pcall(function() return game:HttpGet(_0xURL) end)
    if _0xS then
        for _0xid, _0xst in _0xR:gmatch(_0xPT) do
            _0xSC[tonumber(_0xid)] = _0xst
        end
    end
end
task.spawn(_0xUpd)

local _0xSG = Instance.new("ScreenGui", _0x52)
_0xSG.Name = "Base_" .. tostring(math.random(100,999)) .. "_F"

local _0xMF = Instance.new("Frame", _0xSG)
_0xMF.Name = "Root_" .. math.random(1,50)
_0xMF.AnchorPoint = Vector2.new(0.5, 0.5)
_0xMF.BackgroundColor3 = _0xColors._0x1
_0xMF.Position = UDim2.new(0.5, 0, 0.5, 0)
_0xMF.Size = UDim2.new(0, 560, 0, 360)
_0xMF.BorderSizePixel = 0
Instance.new("UICorner", _0xMF).CornerRadius = UDim.new(0, 4)
local _0xMS = Instance.new("UIStroke", _0xMF)
_0xMS.Color = _0xColors._0x3
_0xMS.Thickness = 1.5

local _0xTL = Instance.new("TextLabel", _0xMF)
_0xTL.Position = UDim2.new(0, 15, 0, 15)
_0xTL.Size = UDim2.new(0, 200, 0, 20)
_0xTL.BackgroundTransparency = 1
_0xTL.FontFace = _0xFB
_0xTL.Text = _0xT1
_0xTL.TextColor3 = _0xColors._0x5
_0xTL.TextSize = 18
_0xTL.TextXAlignment = Enum.TextXAlignment.Left

local _0xLL = Instance.new("TextLabel", _0xMF)
_0xLL.Position = UDim2.new(0, 15, 0, 33)
_0xLL.Size = UDim2.new(0, 200, 0, 15)
_0xLL.BackgroundTransparency = 1
_0xLL.FontFace = _0xFB
_0xLL.Text = _0xT2
_0xLL.TextColor3 = _0xColors._0x2
_0xLL.TextSize = 10
_0xLL.TextXAlignment = Enum.TextXAlignment.Left

local _0xCB = Instance.new("TextButton", _0xMF)
_0xCB.Position = UDim2.new(1, -30, 0, 10)
_0xCB.Size = UDim2.new(0, 20, 0, 20)
_0xCB.BackgroundTransparency = 1
_0xCB.Text = "X"
_0xCB.TextColor3 = _0xColors._0x6
_0xCB.FontFace = _0xFB
_0xCB.MouseButton1Click:Connect(function() _0xSG:Destroy() end)

local _0xLS = Instance.new("ScrollingFrame", _0xMF)
_0xLS.Name = "Scroll_Container"
_0xLS.Position = UDim2.new(0, 10, 0, 65)
_0xLS.Size = UDim2.new(0, 240, 1, -75)
_0xLS.BackgroundTransparency = 1
_0xLS.ScrollBarThickness = 2
_0xLS.ScrollBarImageColor3 = _0xColors._0x2
_0xLS.BorderSizePixel = 0

local _0xUL = Instance.new("UIListLayout", _0xLS)
_0xUL.Padding = UDim.new(0, 6)
_0xUL:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    _0xLS.CanvasSize = UDim2.new(0, 0, 0, _0xUL.AbsoluteContentSize.Y)
end)

local _0xPV = Instance.new("Frame", _0xMF)
_0xPV.Position = UDim2.new(0, 260, 0, 65)
_0xPV.Size = UDim2.new(1, -270, 1, -75)
_0xPV.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Instance.new("UICorner", _0xPV)
Instance.new("UIStroke", _0xPV).Color = _0xColors._0x3

local _0xGI = Instance.new("ImageLabel", _0xPV)
_0xGI.AnchorPoint = Vector2.new(0.5, 0)
_0xGI.Position = UDim2.new(0.5, 0, 0, 25)
_0xGI.Size = UDim2.new(0, 110, 0, 110)
_0xGI.BackgroundTransparency = 1
_0xGI.Image = ""
_0xGI.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", _0xGI).CornerRadius = UDim.new(0, 8)

local _0xGN = Instance.new("TextLabel", _0xPV)
_0xGN.Position = UDim2.new(0, 0, 0, 145)
_0xGN.Size = UDim2.new(1, 0, 0, 25)
_0xGN.BackgroundTransparency = 1
_0xGN.FontFace = _0xFB
_0xGN.Text = "..."
_0xGN.TextColor3 = _0xColors._0x5
_0xGN.TextSize = 15

local _0xSL = Instance.new("TextLabel", _0xPV)
_0xSL.Position = UDim2.new(0, 0, 0, 180)
_0xSL.Size = UDim2.new(1, 0, 0, 20)
_0xSL.BackgroundTransparency = 1
_0xSL.FontFace = _0xFB
_0xSL.Text = ""
_0xSL.TextColor3 = _0xColors._0x6
_0xSL.TextSize = 13
_0xSL.Visible = false

local _0xLB = Instance.new("TextButton", _0xPV)
_0xLB.AnchorPoint = Vector2.new(0.5, 1)
_0xLB.Position = UDim2.new(0.5, 0, 1, -15)
_0xLB.Size = UDim2.new(0, 200, 0, 42)
_0xLB.BackgroundColor3 = _0xColors._0x2
_0xLB.FontFace = _0xFB
_0xLB.Text = "\76\79\65\68"
_0xLB.TextColor3 = Color3.new(0,0,0)
_0xLB.TextSize = 14
_0xLB.AutoButtonColor = false
Instance.new("UICorner", _0xLB)

local _0xCS = nil

local function _0xAG(_n, _id, _c)
    local _B = Instance.new("TextButton", _0xLS)
    _B.Name = "G_" .. _id
    _B.Size = UDim2.new(1, -8, 0, 55)
    _B.BackgroundColor3 = _0xColors._0x4
    _B.Text = ""
    _B.AutoButtonColor = false
    Instance.new("UICorner", _B)
    local _s = Instance.new("UIStroke", _B)
    _s.Color = _0xColors._0x3

    local _I = Instance.new("ImageLabel", _B)
    _I.Position = UDim2.new(0, 8, 0.5, -18)
    _I.Size = UDim2.new(0, 36, 0, 36)
    _I.BackgroundTransparency = 1
    _I.Image = "rbxassetid://" .. _0x4D:GetProductInfo(_id).IconImageAssetId
    _I.ScaleType = Enum.ScaleType.Fit
    Instance.new("UICorner", _I)

    local _L = Instance.new("TextLabel", _B)
    _L.Position = UDim2.new(0, 52, 0, 0)
    _L.Size = UDim2.new(1, -55, 1, 0)
    _L.BackgroundTransparency = 1
    _L.Text = _n:upper()
    _L.FontFace = _0xFB
    _L.TextColor3 = _0xColors._0x6
    _L.TextSize = 12
    _L.TextXAlignment = Enum.TextXAlignment.Left

    _B.MouseButton1Click:Connect(function()
        _0xCS = _c
        _0xGN.Text = _n:upper()
        _0xGI.Image = _I.Image
        local _st = _0xSC[_id] or "Unknown"
        _0xSL.Text = "Status: " .. _st
        _0xSL.Visible = true
        _0xSL.TextColor3 = (_st:lower():find("working")) and _0xColors._0x7 or _0xColors._0x2
    end)
end

_0xLB.MouseButton1Click:Connect(function()
    if _0xCS then _0xSG:Destroy() task.spawn(_0xCS) end
end)

local _0xDT, _0xDS, _0xSP
_0xMF.InputBegan:Connect(function(_i) if _i.UserInputType == Enum.UserInputType.MouseButton1 then _0xDT = true _0xDS = _i.Position _0xSP = _0xMF.Position end end)
_0x72.InputChanged:Connect(function(_i) if _0xDT and _i.UserInputType == Enum.UserInputType.MouseMovement then 
    local _delta = _i.Position - _0xDS 
    _0xMF.Position = UDim2.new(_0xSP.X.Scale, _0xSP.X.Offset + _delta.X, _0xSP.Y.Scale, _0xSP.Y.Offset + _delta.Y) 
end end)
_0x72.InputEnded:Connect(function(_i) if _i.UserInputType == Enum.UserInputType.MouseButton1 then _0xDT = false end end)

_0xAG("Universal", 3392487150, function() warn("Soon") end)
_0xAG("Penablox HvH", 122764594952227, function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\49\50\51\104\111\105\112\111\112\112\101\114\49\51\114\54\47\78\101\118\101\114\72\105\116\46\108\117\97\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\71\97\109\101\45\83\117\112\112\111\114\116\47\80\101\110\97\98\108\111\120\46\108\117\97"))() end)
_0xAG("Europhium hvh", 82638711520338, function() warn("In development") end)
_0xAG("Sultanisimus HVH", 120331934510435, function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\103\105\116\104\117\98\46\99\111\109\47\49\50\51\104\111\105\112\112\101\114\49\51\114\54\47\78\101\118\101\114\72\105\116\46\108\117\97\47\98\108\111\98\47\109\97\105\110\47\71\97\109\101\45\83\117\112\112\111\114\116\47\83\117\108\116\97\110\105\115\105\109\117\115\46\108\117\97"))() end)
