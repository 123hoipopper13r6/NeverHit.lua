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
    Notification:Notify({ Title = "bell", Content = "This script is for Europhium HvH only!", Icon = "alert" })
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
end)


-- Ui

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
local InfoMenu = Window:AddMenu({ Name = "Info", Icon = "info" })

do
    local RageSect = RageMenu:AddSection({ Position = 'left', Name = "Main" });
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

    ExpSect:AddToggle({
        Name = "No Spread",
        Callback = function(v)
            getgenv().NoSpread = v
        end
    })
end

do
    local InfoSect = InfoMenu:AddSection({ Position = 'left', Name = "Info" });
end
