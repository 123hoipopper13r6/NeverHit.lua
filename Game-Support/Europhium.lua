-- ui lib

-- https://cat-sus.gitbook.io/fatality
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

--https://www.roblox.com/games/82638711520338/europhium-hvh
if game.PlaceId ~= 82638711520338 then
    Notification:Notify({ Title = "Notification", Content = "This script is for Europhium HvH only!", Icon = "bell" })
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

    Notification:Notify({
        Title = "Warning",
        Content = "Im already loaded!",
        Icon = "bell"
    })

    warn("NeverHit is already loaded!")
    return
end

-- Gloabls

getgenv().NeverHitIsLoaded = true

getgenv().RageBotMethod = "Event Hook"

-- ForceHit

local oldFireServer
oldFireServer = hookfunction(Instance.new("RemoteEvent").FireServer, newcclosure(function(self, ...)

    if not getgenv().ForceHit then
        return oldFireServer(self, ...)
    end

    if getgenv().RageBotMethod == "Event Hook" then
        local args = {...}
        local PartToHit = getgenv().RageBotPart or "Head"

        if not checkcaller() and self.Name == "sOwop02SPqas" then
            local hitPart = args[1]
            if hitPart and hitPart.Parent and hitPart.Parent:FindFirstChild(PartToHit) then
                args[1] = hitPart.Parent[PartToHit]
            end
        end

        return oldFireServer(self, unpack(args))
    else
        return oldFireServer(self, ...)
    end

end))

-- No Spread

do
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "function" and islclosure(v) then

                local constants = debug.getconstants(v)
                
                if table.find(constants, "SpreadJumping") then
                    hookfunction(v, function()
                        if getgenv().NoSpread then
                            return 0
                        else
                            return v
                        end
                    end)
                end

            end
        end
    end)
end

--[[
local oldMathRandom
oldMathRandom = hookfunction(math.random, function(...)
    local args = {...}

    if getgenv().NoSpread and not checkcaller() then
        if #args == 0 then
            return 0
        elseif #args == 1 then
            return 1
        elseif #args == 2 then
            return args[1] 
        end
    end
    return oldMathRandom(...)
end)]]

-- NaN Pitch

do 
    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
        local args = {...}
        local method = getnamecallmethod()

        if method == "FireServer" and tostring(self) == "ConfigUpdateEvent" then
            if getgenv().AntiAim and getgenv().AntiAim.NaNPitch then
                if type(args[1]) == "table" and args[1].Pitch ~= nil then
                    args[1].Pitch = 0/0
                end
            end
        end

        return oldNamecall(self, unpack(args))
    end))
end


-- Gun Mods

function applyGunMod(gun, mod, value)

    local ScoutStats = {
        ["Firerate"] = 0.8,
        ["SpreadStanding"] = 0.4,
        ["SpreadWalking"] = 1,
        ["SpreadJumping"] = 8,
        ["Damage"] = 84,
        ["AutoStopHoldTime"] = 0.25,
        ["MoveSpreadMultiplier"] = 0.02,
        ["ReloadTime"] = 3.5,
        ["Ammo"] = 10,
        ["CanScope"] = true
    }

    local DeagleStats = {
        ["Firerate"] = 3,
        ["SpreadStanding"] = 0.6,
        ["SpreadWalking"] = 1.5,
        ["SpreadJumping"] = 15,
        ["Damage"] = 63,
        ["AutoStopHoldTime"] = 0.25,
        ["MoveSpreadMultiplier"] = 0.05,
        ["ReloadTime"] = 2.5,
        ["Ammo"] = 7,
        ["CanScope"] = false
    }

    local deagle, scout

    local s,e = pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" then
                if rawget(v, "SpreadStanding") and rawget(v, "Firerate") then
                    if v.Firerate == ScoutStats.Firerate and v.SpreadStanding == ScoutStats.SpreadStanding and v.CanScope == ScoutStats.CanScope then
                        scout = v
                    elseif v.Firerate == DeagleStats.Firerate and v.SpreadStanding == DeagleStats.SpreadStanding and v.CanScope == DeagleStats.CanScope then
                        deagle = v
                    end
                end
            end
        end

        if gun == "All" and scout and deagle then
            if mod == "InfiniteAmmo" then
                scout.Ammo = 0/0
                deagle.Ammo = 0/0
            elseif mod == "DamageMultiplier" and value then
                scout.Damage = ScoutStats.Damage * value
                deagle.Damage = DeagleStats.Damage * value
            elseif mod == "FastFireRate" then
                scout.Firerate = 0/0
                deagle.Firerate = 0/0
            elseif mod == "InstaReload" then
                scout.ReloadTime = 0.01
                deagle.ReloadTime = 0.01
            end
        end

        if gun == "Scout" and scout then
            if mod == "InfiniteAmmo" then
                scout.Ammo = 0/0
            elseif mod == "DamageMultiplier" and value then
                scout.Damage = ScoutStats.Damage * value
            elseif mod == "FastFireRate" then
                scout.Firerate = 0/0
            elseif mod == "InstaReload" then
                scout.ReloadTime = 0.01
            end
        end

        if gun == "Deagle" and deagle then
            if mod == "InfiniteAmmo" then
                deagle.Ammo = 0/0
            elseif mod == "DamageMultiplier" and value then
                deagle.Damage = DeagleStats.Damage * value
            elseif mod == "FastFireRate" then
                deagle.Firerate = 0/0
            elseif mod == "InstaReload" then
                deagle.ReloadTime = 0.01
            end
        end

        if gun == "Reset" then
            if scout then
                for stat, val in pairs(ScoutStats) do
                    scout[stat] = val
                end
            end

            if deagle then
                for stat, val in pairs(DeagleStats) do
                    deagle[stat] = val
                end
            end
        end
    end)

    if not s then
        Notification:Notify({
            Title = "Error",
            Content = ("Failed to apply gun mod," .. tostring(e)),
            Icon = "bell"
        })

        --warn("Failed to apply gun mod: " .. tostring(e))
    end

end

-- Ui

Fatality:Loader({ Name = "NEVERHIT.LUA", Duration = 3 });

Notification:Notify({
    Title = "NEVERHIT",
    Content = "Welcome back, "..game.Players.LocalPlayer.DisplayName,
    Icon = "clipboard"
})

local Window = Fatality.new({ Name = "NEVERHIT", Expire = "Free" });

local RageMenu = Window:AddMenu({ Name = "Rage", Icon = "skull" })
local AntiAimMenu = Window:AddMenu({ Name = "Anti Aim", Icon = "shield" })
local VisualMenu = Window:AddMenu({ Name = "Visuals", Icon = "eye" })
local MiscMenu = Window:AddMenu({ Name = "Misc", Icon = "settings" })

do
    local RageSect = RageMenu:AddSection({ Position = 'left', Name = "Main" });
    local GunSect = RageMenu:AddSection({ Position = 'left', Name = "Gun Mods" });
    local ExpSect = RageMenu:AddSection({ Position = 'center', Name = "Exploits" });
    local ConfigSect = RageMenu:AddSection({ Position = 'right', Name = "Configs" });

    local ForceHitToggle = ExpSect:AddToggle({
        Name = "Force Hit",
        Option = true,

        Callback = function(v)
            getgenv().ForceHit = v
        end
    })

    ForceHitToggle.Option:AddDropdown({
        Name = "Method",
        Values = {"Event Hook"},
        Default = "Event Hook",
        Callback = function(v)
            getgenv().RageBotMethod = v
        end
    })

    ForceHitToggle.Option:AddDropdown({
        Name = "Part",
        Values = {"Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"},
        Default = "Head",
        Callback = function(v)
            getgenv().RageBotPart = v
        end
    })

    GunSect:AddDropdown({
        Name = "Gun",
        Values = {"All", "Scout", "Deagle"},
        Default = "All",
        Callback = function(v)
            getgenv().SelectedGun = v
        end
    })

    GunSect:AddToggle({
        Name = "Inf Ammo",
        Callback = function(v)
            applyGunMod("All", "InfiniteAmmo", v)
        end
    })

    GunSect:AddToggle({
        Name = "Damage Multiplier",
        Callback = function(v)
            pcall(function()
                applyGunMod(getgenv().SelectedGun or "All", "DamageMultiplier", v and 5 or 1)
            end)
        end
    })

    GunSect:AddSlider({
        Name = "Damage Multiplier",
        Min = 1,
        Max = 100,
        Default = 1,
        Callback = function(v)
            pcall(function()
                applyGunMod(getgenv().SelectedGun or "All", "DamageMultiplier", v)
            end)
        end
    })

    GunSect:AddToggle({
        Name = "Fast Firerate",
        Callback = function(v)
            pcall(function()
                applyGunMod(getgenv().SelectedGun or "All", "FastFireRate", v)
            end)
        end
    })

    GunSect:AddToggle({
        Name = "Insta Reload",
        Callback = function(v)
            pcall(function()
                applyGunMod(getgenv().SelectedGun or "All", "InstaReload", v)
            end)
        end
    })

    GunSect:AddButton({
        Name = "Reset Gun Mods",
        Callback = function(v)
            pcall(function()
                applyGunMod("Reset")
            end)
        end
    })

    ExpSect:AddToggle({
        Name = "No Spread",
        Callback = function(v)
            getgenv().NoSpread = v
        end
    })
end

do
    local AntiAimSect = AntiAimMenu:AddSection({ Position = 'left', Name = "Main" });
    local ExploitSect = AntiAimMenu:AddSection({ Position = 'center', Name = "Exploits" });

    ExploitSect:AddToggle({
        Name = "NaN pitch",
        Callback = function(v)
            getgenv().AntiAim = getgenv().AntiAim or {}
            getgenv().AntiAim.NaNPitch = v
        end
    })
end

local InfoMenu = Window:AddMenu({ Name = "Info", Icon = "info" })

do
    local InfoSect = InfoMenu:AddSection({ Position = 'left', Name = "Info" });

    InfoSect:AddButton({
        Name = "Discord Server",
        Callback = function()
            local s,f = pcall(function()
                setclipboard("https://discord.gg/sMv9YeXbYR")

                Notification:Notify({
                    Title = "NeverHit",
                    Content = "Discord server link copied to clipboard!",
                })
            end)

            if not s then
                Notification:Notify({
                    Title = "Error",
                    Content = "Failed to copy to clipboard, get it manually: https://discord.gg/sMv9YeXbYR",
                    Icon = "bell"
                })
            end
            
        end
    })
end
