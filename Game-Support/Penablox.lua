-- ui lib

local Fatality = loadstring(game:HttpGet("https://raw.githubusercontent.com/4lpaca-pin/Fatality/refs/heads/main/src/source.luau"))();


if not Fatality then
    warn("Failed to load the ui library, executor is probably unsupported or the github link was deleted.")
    return
end

local thegetgenvissupportedomg = false

function checkgetgenv()
    if getgenv and type(getgenv) == "function" then
        thegetgenvissupportedomg = true
    else
        warn("getgenv is not supported. This script cant run without it.")
        return
    end
end

checkgetgenv()

if not thegetgenvissupportedomg then
    return
end

local Notification = Fatality:CreateNotifier();


if game.PlaceId ~= 122764594952227 then
    Notification:Notify({ Title = "bell", Content = "This script is for Penablox HVH only!", Icon = "alert" })
    return
end

-- check if the executor is supported

-- print("Checking if the executor is supported, this might take 1-2 seconds")

local function checkifsupported()
    local missing = {}

    local requiredFunctions = {
        "identifyexecutor",
        "getthreadidentity",
        "hookfunction",
        "getgenv",
        "getconnections",
        "require",
        "getgc",
        "getfenv",
        "hookmetamethod",
        "getupvalue",
        "debug",
        "setreadonly",
        "getrawmetatable",
    }

    for _, funcName in ipairs(requiredFunctions) do
        if getfenv()[funcName] == nil and _G[funcName] == nil then
            table.insert(missing, funcName)
        end
    end

    if #missing == 0 then
        --print("Executor Fully Supported!")

        Notification:Notify({
            Title = "NeverHit",
            Content = "Executor fully supported! Loading UI...",
            Duration = 3,
            Icon = "check"
        })

        return true
    elseif #missing > 12 then

        Notification:Notify({
            Title = "Error",
            Content = "Your executor is ass",
            Icon = "bell"
        })

        return false
    else
        --warn("Script may not work or crash. Missing functions: " .. table.concat(missing, ", "))
        --print("If hookfunction is missing, then Ragebot(Event Hook) is not gonna work.")

        Notification:Notify({
            Title = "NeverHit",
            Content = "Executor is not supported! Some features might not work or crash.",
            Duration = 20,
            Icon = "bell"
        })

        return false
    end
end

checkifsupported()

function checkspecificfunction(funcName)
    if getfenv()[funcName] == nil and _G[funcName] == nil then
        return false
    end
    return true
end

-- check

if getgenv().NeverHitIsLoaded == true then
    warn("NeverHit is already loaded!")
    return
end

-- globals

getgenv().NeverHitIsLoaded = true

if not getgenv().RageBotEnabled then
    getgenv().RageBotEnabled = false
end

if not getgenv().RageBotMethod then
    getgenv().RageBotMethod = "Event Hook"
end

if not getgenv().RageBotHitPos then
    getgenv().RageBotHitPos = "Auto"
end

if getgenv().RageBotHitPos == "Auto" then
    if game:GetService("Players").LocalPlayer:FindFirstChild("hitparts") then
        game:GetService("Players").LocalPlayer:FindFirstChild("hitparts").Value = "Legs,Torso,Arms,Head"
    end
end

if not getgenv().RageBotHitPart then
    getgenv().RageBotHitPart = "Head"
end

if not getgenv().typeofantiaim or not getgenv().antiaimjitter or not getgenv().antiaimdelayness or not getgenv().antiaimrandomness then
    getgenv().typeofantiaim = "Static"
    getgenv().antiaimjitter = 0
    getgenv().antiaimdelayness = 0
    getgenv().antiaimrandomness = 0
    getgenv().rightantiaim = 0
    getgenv().leftantiaim = 0
    getgenv().BodyYawantiaim = 0
    getgenv().Pitchantiaim = 0
end

-- functions

function disabledefaultragebot()

    if not checkspecificfunction("getconnections") then
        warn("getconnections is missing, can't disable default ragebot.")
        return
    end

    if game:GetService("Players").LocalPlayer:FindFirstChild("Mindmg") then
        game:GetService("Players").LocalPlayer:FindFirstChild("Mindmg").Value = 1
    end

    local bob = workspace:FindFirstChild("Bob")

    if not bob then
        warn("I didn't find bob")
        return
    end

    for _, conn in pairs(getconnections(bob.ChildAdded)) do
        pcall(function() conn:Disconnect() end)
    end

    for _, conn in pairs(getconnections(game:GetService("ReplicatedStorage").MainEvent.OnClientEvent)) do
        conn:Disconnect()
    end
    -- print("Disabled, dw")
end

-- Disable client anticheat

task.spawn(function()

    if not checkspecificfunction("getgc") then
        warn("getgc is missing, can't disable client checks.")
        return
    end

    for _, v in pairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "WalkspeedProtect") then
            v.WalkspeedProtect.enabled = false
            v.FlyProtect.enabled = false
            v.TeleportDetect.enabled = false
            v.CFrameMonitor.enabled = false
            v.NoClipProtect.enabled = false
            v.HitboxProtect.enabled = false

            print("Bypassed client checks.")
        end
    end

    for _, v in pairs(getgc(true)) do
        if type(v) == "function" and getfenv(v).script == nil then
            local name = debug.info(v, "n")
            if name == "sendKick" or name == "checkCFrameMovement" then
                hookfunction(v, function() return end)
                warn("Prevented: " .. name)
            end
        end
    end
end)

-- AA update

task.spawn(function()

    if not checkspecificfunction("require") then
        warn("require is missing, can't start anti-aim.")
        return
    end

    if getgenv().AAIsLooped then return end

    local AAHandler = require(game:GetService("ReplicatedFirst"):WaitForChild("AAHandler"))

    getgenv().AAIsLooped = true

    while task.wait(0.1) do
        if not AAHandler then
            warn("AAHandler is missing.")
            return
        end

        if getgenv().AntiAimEnabled then
            pcall(function()
                AAHandler.SendYawJitter(
                    nil,
                    getgenv().typeofantiaim or "Static",
                    getgenv().leftantiaim or 0,
                    getgenv().rightantiaim or 0,
                    getgenv().antiaimjitter or 0,
                    getgenv().antiaimdelayness or 0,
                    getgenv().antiaimrandomness or 0
                )
                AAHandler.SendBodyYaw(nil, getgenv().BodyYawantiaim or 0)
                AAHandler.SendPitchMode(nil, "Static", getgenv().Pitchantiaim or 0, 0, 0, 0, 0, 0)
            end)
        end
    end
end)

-- Infinite Velocity

task.spawn(function()
    if not checkspecificfunction("hookmetamethod") then
        warn("hookmetamethod is missing, can't start infinite velocity.")
        return
    end

    local oldIndex
    oldIndex = hookmetamethod(game, "__index", function(t, k)
        if getgenv().InfiniteVelocity and not checkcaller() then
            if (k == "Velocity" or k == "AssemblyLinearVelocity") and t.Name == "HumanoidRootPart" then
                return Vector3.new(math.huge, math.huge, math.huge)
            end
        end
        return oldIndex(t, k)
    end)
end)

-- find the closet player for the shot

function GetClosestPlayer()
    local Players = game:GetService("Players")
    local LocalPlayer : Player = Players.LocalPlayer
    local nearestPlayer, nearestDistance = nil, math.huge
    local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myRoot then return nil end
    for _, player in pairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        local character : Model = player.Character
        local head : Instance = character and character:FindFirstChild("Head")
        local humanoid: Humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if head and humanoid and humanoid.Health > 0 then
            local distance: float = (head.Position - myRoot.Position).Magnitude
            if distance < nearestDistance then
                nearestDistance = distance
                nearestPlayer = player
            end
        end
    end
    return nearestPlayer
end

-- encrypt and decrypt

function encryptstring(text : string)
    local json = game:GetService("TextChatService").BubbleChatConfiguration:FindFirstChild("ImageLabel"):GetAttribute("SuperSecretKey")

    local s, data = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), json)
    if not s or type(data) ~= "table" then return text end

    local result = ""
    for i = 1, #text do
        local char = text:sub(i, i)
        result = result .. (data[char] or char)
    end
    return result
end

function decryptstring(text : string)
    local json = game:GetService("TextChatService").BubbleChatConfiguration:FindFirstChild("ImageLabel"):GetAttribute("SuperSecretKey")

    local s, data = pcall(game:GetService("HttpService").JSONDecode, game:GetService("HttpService"), json)
    if not s or type(data) ~= "table" then return text end

    local rd = {}
    for real, junk in pairs(data) do rd[junk] = real end
    local decrypted = text
    for junk, real in pairs(rd) do
        local pattern = junk:gsub("([^%w])", "%%%1")
        decrypted = decrypted:gsub(pattern, real)
    end
    return decrypted
end

-- Air part

local function GetPartNameAtPos(targetPos)
    local cameraPos = workspace.CurrentCamera.CFrame.Position
    local direction = (targetPos - cameraPos)

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Include

    local targets = {}
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p.Character then table.insert(targets, p.Character) end
    end
    params.FilterDescendantsInstances = targets

    local result = workspace:Raycast(cameraPos, direction, params)

    return (result and result.Instance) and result.Instance.Name or "Torso"
end

-- Ragebot

-- forcehit method by hooking the event, changing the hit part and hitpos, and then sending it to the server, it can miss sometimes because of how the game handles hit detection.

local oldFireServer
oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(self, ...)
    local args = {...}
    if tostring(self) == "MainEvent" and getgenv().RageBotEnabled then
        if getgenv().RageBotMethod == "Event Hook" and checkspecificfunction("hookfunction") then
            local action = decryptstring(args[1])
            if action == "Shoot" or action == "MeleeHit" then

                local target = GetClosestPlayer()

                if target and target.Character and target.Character:FindFirstChild("Head") then

                    local HitPos = getgenv().RageBotHitPos or "Torso"

                    local AutoPart = nil

                    if getgenv().RageBotHitPos == "Auto" then
                        if game:GetService("Players").LocalPlayer:FindFirstChild("TargetPos") and game:GetService("Players").LocalPlayer:FindFirstChild("TargetPos").Value ~= Vector3.new(0,0,0) then
                            AutoPart = game:GetService("Players").LocalPlayer.TargetPos.Value
                        else
                            AutoPart = "Torso"
                        end
                    end

                    local dmgpart = nil

                    dmgpart = getgenv().RageBotHitPart or "Head" -- might rework this later

                    if HitPos and dmgpart then

                        args[3] = encryptstring(dmgpart)

                        if AutoPart then
                            local foolishpart = GetPartNameAtPos(AutoPart)
                            local tuffpart = target.Character:FindFirstChild(foolishpart)

                            if tuffpart and tuffpart.Position ~= Vector3.new(0,0,0) then
                                args[7] = tuffpart.Position or AutoPart

                                if typeof(args[6]) == "Vector3" and typeof(AutoPart) == "Vector3" then
                                    args[5] = (args[6] - tuffpart.Position).Magnitude
                                else
                                    warn("args[5] or tuffpart dosen't have a pos")
                                    end
                            else
                                args[7] = AutoPart

                                if typeof(args[6]) == "Vector3" and typeof(AutoPart) == "Vector3" then
                                    args[5] = (args[6] - AutoPart).Magnitude
                                else
                                    warn("args[5] or AutoPart is not a vector3")
                                end
                            end

                        else
                            args[7] = target.Character[HitPos].Position

                            if typeof(args[6]) == "Vector3" then
                                args[5] = (args[6] - target.Character[HitPos].Position).Magnitude
                            end
                        end

                        args[8] = encryptstring("nil")
                        args[9] = encryptstring("nil")

                    end
                end
            end
        end
    end

    return oldFireServer(self, unpack(args))
end)

-- Remove Velocity by hooking the movement module functions and returning values that would result in no velocity which dosen't work for now but maybe it will in some update.

task.spawn(function()
    local MovementModule = require(game:GetService("ReplicatedStorage"):WaitForChild("MovementHandler"))

    local orig_speed = MovementModule.GetPlanarSpeed
    local orig_vert = MovementModule.GetVerticalVelocity
    local orig_ground = MovementModule.IsGrounded
    local orig_crouch = MovementModule.IsCrouching

    game:GetService("RunService").Heartbeat:Connect(function()
        if getgenv().RemoveVelocity then
            MovementModule.GetPlanarSpeed = function() return 0 end
            MovementModule.GetVerticalVelocity = function() return 0 end
            MovementModule.IsGrounded = function() return true end
            MovementModule.IsCrouching = function() return true end
        else
            if MovementModule.GetPlanarSpeed ~= orig_speed then
                MovementModule.GetPlanarSpeed = orig_speed
                MovementModule.GetVerticalVelocity = orig_vert
                MovementModule.IsGrounded = orig_ground
                MovementModule.IsCrouching = orig_crouch
            end
        end
    end)
end)

task.spawn(function()
    local oldMathRandom
    oldMathRandom = hookfunction(math.random, function(...)
        local args = {...}
        
        if getgenv().RemoveMathRandom then
            if #args == 0 then
                return 0
            elseif #args == 1 then
                return 1
            elseif #args == 2 then
                return args[1] 
            end
        end
        return oldMathRandom(...)
    end)
end)

-- Infinite ammo

task.spawn(function()
    if not checkspecificfunction("FireServer") then
        warn("FireServer is missing, do infinite ammo.")
        return
    end

    while task.wait(1) do
        if getgenv().InfiniteAmmo then
            game:GetService("ReplicatedStorage"):WaitForChild("Reload"):FireServer()
        end
    end
end)

-- hitbox extender

task.spawn(function()
    while task.wait(1) do
        if not getgenv().HitboxExtenderEnabled then return end

        for _,char in pairs(game:GetService("Players"):GetChildren()) do
            if char.Character and char.Character:FindFirstChild("Head") and char.Character ~= game:GetService("Players").LocalPlayer.Character then
                local hrp = char.Character.Head
                local originalSize = hrp.Size
                game:GetService("RunService").Heartbeat:Connect(function()
                    if getgenv().HitboxExtenderEnabled then
                        hrp.CanCollide = false
                        hrp.Size = Vector3.new(50,50,50)
                    else
                        hrp.Size = originalSize
                    end
                end)
            end
        end
    end
end)

-- other stuff

-- edit game's things so it looks cool

task.spawn(function()

    repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui

    if game:GetService("Players").LocalPlayer.PlayerGui then
        local playergui = game:GetService("Players").LocalPlayer.PlayerGui

        repeat task.wait() until playergui.OtherHUD:FindFirstChild("KillInfo")

        if playergui and playergui:FindFirstChild("OtherHUD") and playergui.OtherHUD:FindFirstChild("KillInfo") and playergui.OtherHUD.KillInfo:FindFirstChild("Frame") and playergui.OtherHUD.KillInfo:FindFirstChild("UIStroke") and playergui.OtherHUD.KillInfo.Frame:FindFirstChild("Avatar") and playergui.OtherHUD.KillInfo.Frame:FindFirstChild("Text") then
            local frame = playergui.OtherHUD.KillInfo.Frame
            frame.BackgroundColor3 = Color3.new(19,22,22)
            playergui.OtherHUD.KillInfo:FindFirstChild("UIStroke").Parent = frame
            playergui.OtherHUD.KillInfo.Frame:FindFirstChild("UIStroke").Color = Color3.new(100,29,29)
            playergui.OtherHUD.KillInfo.Frame:FindFirstChild("UIStroke").Thickness = 2

            frame.Avatar.Position = UDim2.new(0.45, 0, 0.1, 0)
            frame.Avatar.Size = UDim2.new(0.1, 0, 0.5, 0)

            frame:FindFirstChild("Text").Position = UDim2.new(0, 0, 0.5, 0)
            frame:FindFirstChild("Text").Size = UDim2.new(1, 0, 0.5, 0)
        else
            warn("Couldn't change in game ui's. Something is missing.")
            Notification:Notify({
                Title = "Error",
                Content = "Couldn't change in game ui's. Something is missing.",
                Icon = "alert"
            })

        end
    end
end)


-- ui

-- wait until the player's gui is visible

repeat task.wait() until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LimoriaUI") and game:GetService("Players").LocalPlayer.PlayerGui.LimoriaUI.Window.Visible == true

-- load it

Fatality:Loader({ Name = "NEVERHIT.LUA", Duration = 3 });

Notification:Notify({
    Title = "NEVERHIT",
    Content = "Welcome back, "..game.Players.LocalPlayer.DisplayName,
    Icon = "clipboard"
})

local Window = Fatality.new({ Name = "NEVERHIT", Expire = "never" });

local RageMenu = Window:AddMenu({ Name = "Rage", Icon = "skull" })
local AntiAimMenu = Window:AddMenu({ Name = "Anti Aim", Icon = "shield" })
local VisualMenu = Window:AddMenu({ Name = "Visuals", Icon = "eye" })
local MiscMenu = Window:AddMenu({ Name = "Misc", Icon = "settings" })

-- ragebot

do
    local MainRage = RageMenu:AddSection({ Position = 'left', Name = "MAIN" });
    local ExploitSect = RageMenu:AddSection({ Position = 'center', Name = "EXPLOITS" });
    local ExtaSect = RageMenu:AddSection({ Position = 'right', Name = "CONFIGURATION" });

    MainRage:AddToggle({
        Name = "Custom resolver(didnt do it yet)",
        Callback = function(v)
            getgenv().CustomResolverEnabled = v

            if v and game:GetService("Players").LocalPlayer:FindFirstChild("ResolverEnabled") then
                game:GetService("Players").LocalPlayer.ResolverEnabled.Value = false
            end
        end
    })

    MainRage:AddDropdown({
        Name = "Resolver Mode",
        Values = {"NeverHit","Divine.lua OLD","Legit","Custom"},
        Default = "None",
        Callback = function(v)
            getgenv().CustomResolverMode = v
        end
    })

    ExploitSect:AddToggle({
        Name = "Force Hit",
        Risky = true,
        Callback = function(v)
            getgenv().RageBotEnabled = v

            if v then
                disabledefaultragebot()
            end
        end
    })

    ExploitSect:AddDropdown({
        Name = "Method",
        Values = {"Event Hook"},
        Default = "Event Hook",
        Callback = function(v)
            getgenv().RageBotMethod = v
        end
    })

    ExploitSect:AddDropdown({
        Name = "Hit Position",
        Values = {"Auto","Head","Torso","HumanoidRootPart","Arms","Legs"},
        Default = "Auto",
        Callback = function(v)
            getgenv().RageBotHitPos = v

            if v == "Auto" and game.Players.LocalPlayer:FindFirstChild("hitparts") then
                game.Players.LocalPlayer.hitparts.Value = "Legs,Torso,Arms,Head"
            end
        end
    })

    ExploitSect:AddDropdown({
        Name = "Damage Part",
        Values = {"Head","Torso","HumanoidRootPart","Arms","Legs"},
        Default = "Head",
        Callback = function(v)
            getgenv().RageBotHitPart = v
        end
    })

    ExploitSect:AddToggle({
        Name = "Infinite Ammo",
        Risky = true,
        Callback = function(v)
            getgenv().InfiniteAmmo = v
        end
    })
end

-- anti aim

do
    local AA_General = AntiAimMenu:AddSection({ Position = 'left', Name = "GENERAL" });
    local AA_Angles = AntiAimMenu:AddSection({ Position = 'center', Name = "ANGLES" });
    local AA_Extra = AntiAimMenu:AddSection({ Position = 'right', Name = "EXTRA" });

    AA_General:AddToggle({
        Name = "Enable Anti-Aim",
        Callback = function(v)
            getgenv().AntiAimEnabled = v
        end
    })

    AA_General:AddDropdown({
        Name = "Mode",
        Values = {"Static","Offset","Center","3-Way","5-Way","Off","NeverHit"},
        Default = "Static",
        Callback = function(v)
            getgenv().typeofantiaim = v
        end
    })

    AA_Angles:AddSlider({
        Name = "Yaw Left", Default = 0, Min = -180, Max = 180,
        Callback = function(v)
            getgenv().leftantiaim = v
        end
    })

    AA_Angles:AddSlider({
        Name = "Yaw Right", Default = 0, Min = -180, Max = 180,
        Callback = function(v)
            getgenv().rightantiaim = v
        end
    })

    AA_Angles:AddSlider({
        Name = "Pitch", Default = 0, Min = -90, Max = 90,
        Callback = function(v)
            getgenv().Pitchantiaim = v
        end
    })

    AA_Extra:AddSlider({
        Name = "Jitter Amount", Default = 0, Max = 180,
        Callback = function(v)
            getgenv().antiaimjitter = v
        end
    })

    AA_Extra:AddSlider({
        Name = "Delay", Default = 0, Min = 0.0 , Max = 1.0,
        Callback = function(v)
            getgenv().antiaimdelayness = v
        end
    })
end

-- visuals

do
    local ESP = VisualMenu:AddSection({ Position = 'left', Name = "ESP" });
    ESP:AddToggle({ Name = "Chinese ESP" })
end

-- misc

do
    local Exploits = MiscMenu:AddSection({ Position = 'left', Name = "EXPLOITS" });

    Exploits:AddToggle({
        Name = "Remove Velocity",
        Risky = true,
        Callback = function(v)
            getgenv().RemoveVelocity = v

            -- breaks bhop

            if not getgenv().SpreadHooked and checkspecificfunction("hookmetamethod") then
                getgenv().SpreadHooked = true
                local oldIndex
                oldIndex = hookmetamethod(game, "__index", function(t, k)
                    if getgenv().RemoveVelocity and not checkcaller() then
                        if (k == "Velocity" or k == "AssemblyLinearVelocity") and t.Name == "HumanoidRootPart" then
                            return Vector3.new(0, 0, 0)
                        end
                    end
                    return oldIndex(t, k)
                end)
            end
        end
    })

    Exploits:AddToggle({
        Name = "Remove Math.Random()",
        Risky = true,
        Callback = function(v)
            getgenv().RemoveMathRandom = v
        end
    })

    Exploits:AddToggle({
        Name = "Infinite Velocity",
        Risky = true,
        Callback = function(v)
            getgenv().InfiniteVelocity = v
        end
    })

    Exploits:AddToggle({
        Name = "Hitbox Extender(Beta)",
        Risky = true,
        Callback = function(v)
            getgenv().HitboxExtenderEnabled = v
        end
    })
end

-- rejoin on kick

game:GetService("GuiService").ErrorMessageChanged:Connect(function()
    task.wait(0.5)
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)


-- cleanup and prevent multiple loads

getgenv().ImAnewOne = true

task.wait(2)

getgenv().ImAnewOne = false

while task.wait(1) do
    if getgenv().ImAnewOne == true then
        script:Destroy()
    end
end
