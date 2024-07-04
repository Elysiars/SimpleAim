local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local AimbotButton = Instance.new("TextButton")
local ESPButton = Instance.new("TextButton")
local SpeedButton = Instance.new("TextButton")
local InfiniteJumpButton = Instance.new("TextButton")
local CFrameFlyButton = Instance.new("TextButton")

-- Properties
ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui
ScreenGui.Name = "CheatGUI"

MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 200, 0, 300)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BackgroundTransparency = 0.5

-- Button Setup
local function createButton(name, position, callback)
    local button = Instance.new("TextButton")
    button.Parent = MainFrame
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = name
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Aimbot
local aimbotEnabled = false
local teamBased = false

local function toggleAimbotMode()
    local TeamBasedFrame = Instance.new("Frame", ScreenGui)
    TeamBasedFrame.Size = UDim2.new(0, 200, 0, 100)
    TeamBasedFrame.Position = UDim2.new(0, 220, 0, 10)
    TeamBasedFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TeamBasedFrame.BackgroundTransparency = 0.5

    local TeamBasedButton = createButton("Team-Based", UDim2.new(0, 0, 0, 10), function()
        teamBased = true
        TeamBasedFrame:Destroy()
    end)

    local FreeForAllButton = createButton("Free-For-All", UDim2.new(0, 0, 0, 60), function()
        teamBased = false
        TeamBasedFrame:Destroy()
    end)
    TeamBasedButton.Parent = TeamBasedFrame
    FreeForAllButton.Parent = TeamBasedFrame
end

createButton("Aimbot", UDim2.new(0, 0, 0, 10), function()
    toggleAimbotMode()
end)

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

local function getClosestPlayerToCursor()
    local closestPlayer, closestDistance = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if teamBased and player.Team == LocalPlayer.Team then
                continue
            end
            local screenPoint = Camera:WorldToScreenPoint(player.Character.HumanoidRootPart.Position)
            local distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(screenPoint.X, screenPoint.Y)).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local function aimbot()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getClosestPlayerToCursor()
        if target then
            Camera.CFrame = CFrame.new(Camera.CFrame.p, target.Character.HumanoidRootPart.Position)
        end
    end
end

UIS.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.E then
        aimbotEnabled = not aimbotEnabled
    end
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if aimbotEnabled then
        aimbot()
    end
end)

local espEnabled = false

local function createESP(player)
    local character = player.Character
    if character and character:FindFirstChild("Head") then
        local nameTag = Instance.new("BillboardGui")
        nameTag.Adornee = character.Head
        nameTag.Size = UDim2.new(0, 100, 0, 50)
        nameTag.StudsOffset = Vector3.new(0, 2, 0)
        nameTag.Parent = character.Head

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = player.Name
        textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Parent = nameTag
        local box = Instance.new("BoxHandleAdornment")
        box.Adornee = character
        box.Size = character:GetExtentsSize()
        box.Transparency = 0.5
        box.Color3 = Color3.fromRGB(255, 0, 0)
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Parent = character
    end
end

local function updateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            createESP(player)
        end
    end
end

createButton("ESP", UDim2.new(0, 0, 0, 60), function()
    espEnabled = not espEnabled
    if espEnabled then
        updateESP()
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                for _, child in pairs(player.Character:GetChildren()) do
                    if child:IsA("BillboardGui") or child:IsA("BoxHandleAdornment") then
                        child:Destroy()
                    end
                end
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(player)
    if espEnabled then
        player.CharacterAdded:Connect(function()
            wait(1) 
            createESP(player)
        end)
    end
end)

--fix
createButton("Unfinished", UDim2.new(0, 0, 0, 110), function()
    print("placeholder")
end)

--fix
createButton("Unfinished", UDim2.new(0, 0, 0, 160), function()
    print("placeholder")
end)

--fix
createButton("Unfinished", UDim2.new(0, 0, 0, 210), function()
print("placeholder")
end)
