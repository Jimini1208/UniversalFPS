-- Developed by Jimini1208(UncensoredUsers)

local CoastingLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/GhostDuckyy/UI-Libraries/main/Coasting%20Ui%20Lib/source.lua"))()
local UIS = game:GetService("UserInputService")
local Camera = game:GetService("Workspace").CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Aimbot Function
function getClosest()
    local closestDistance = math.huge
    local closestPlayer = nil
    for i, v in pairs(Players:GetChildren()) do
        if v ~= LocalPlayer and v.Team ~= LocalPlayer.Team then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = v
            end
        end
    end
    return closestPlayer
end

UIS.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        _G.aim = true
        while task.wait() do
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, getClosest().Head.Position)
            if _G.aim == false then 
                return
            end
        end
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton2 then
        _G.aim = false
    end
end)

-- ESP Function
function executeESP(selection)
    local highlight = Instance.new("Highlight")
    highlight.Name = "HighLight"
    if selection == true then
        for i, v in pairs(Players) do
            repeat task.wait() until v.Character
            if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = v.Character
                highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
            end
        end

        game.Players.PlayerAdded:Connect(function(player)
            repeat task.wait() until player.Character
            if not player.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                local highlightClone = highlight:Clone()
                highlightClone.Adornee = player.Character
                highlightClone.Parent = player.Character:FindFirstChild("HumanoidRootPart")
                highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlightClone.Name = "Highlight"
            end
        end)

        game.Players.PlayerRemoving:Connect(function(playerRemoved)
            playerRemoved.Character:FindFirstChild("HumanoidRootPart").Highlight:Destory()
        end)

        RunService.HeartBeat:Connect(function()
            for i, v in pairs(Players) do
                repeat task.wait() until v.Character
                if not v.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("Highlight") then
                    local highlightClone = highlight:Clone()
                    highlightClone.Adornee = v.Character
                    highlightClone.Parent = v.Character:FindFirstChild("HumanoidRootPart")
                    highlightClone.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    highlightClone.Name = "Highlight"
                    task.wait()
                end
            end
        end)
    end
    if selection == true then
        highlight:Destroy()
    end
end

-- Aimbot Tabs
local AimbotTab = CoastingLibrary:CreateTab("Aimbot")
local aMainSection = AimbotTab:CreateSection("Main")
local aConfigSection = AimbotTab:CreateSection("Config")

-- ESP Tabs
local ESPTab = CoastingLibrary:CreateTab("ESP")
local eMainSection = AimbotTab:CreateSection("Main")
local eConfigSection = ESPTab:CreateSection("Config")

aMainSection:CreateToggle("Aimbot", function(Value)
    if Value == true then
        _G.aim = true
    end
    if Value == false then
        _G.aim = false
    end
end)

eMainSection:CreateToggle("ESP", function(Value)
    if Value == true then
        executeESP(false)
    end
    if Value == false then
        executeESP(true)
    end
end)
