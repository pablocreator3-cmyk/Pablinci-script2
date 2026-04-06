--[[
    ⚡ SÚPER DTH HUB - MUSCLE LEGENDS ⚡
    Desarrollado para: Pablito_DTH
    Funciones: Auto-Farm Rocks (0 a 10M), TP Areas, Gift System.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Variables de Estado
getgenv().autoFarm = false
local selectrock = ""

-- [ Función para equipar Punch ]
local function gettool()
    local punch = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
    if punch then
        punch.Parent = LocalPlayer.Character
    end
end

-- [ Función de Teletransporte ]
local function TP(cframe, name)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = cframe
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Teletransporte",
            Text = "Viajando a: " .. name,
            Duration = 2
        })
    end
end

---
--- CONFIGURACIÓN DE LA UI (Library)
---
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SadOz8/U/main/I", true))()
local window = library:AddWindow("⚡ Súper DTH Hub | By Pablito ⚡", {
    main_color = Color3.fromRGB(255, 0, 0), -- Rojo Pablito
    min_size = Vector2.new(650, 870),
    can_resize = false,
})

local farmTab = window:AddTab("Farm Rocks")
local teleport = window:AddTab("TP Areas")
local giftTab = window:AddTab("Gift")

---
--- PESTAÑA: FARM ROCKS (Auto-Touch Logic)
---
local function CreateRockSwitch(name, durability)
    farmTab:AddSwitch(name .. " [" .. tostring(durability) .. "]", function(bool)
        selectrock = name
        getgenv().autoFarm = bool
        if bool then
            task.spawn(function()
                while getgenv().autoFarm and selectrock == name do
                    task.wait()
                    if LocalPlayer.Durability.Value >= durability then
                        for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                            if v.Name == "neededDurability" and v.Value == durability then
                                local char = LocalPlayer.Character
                                if char and char:FindFirstChild("LeftHand") and char:FindFirstChild("RightHand") then
                                    firetouchinterest(v.Parent.Rock, char.RightHand, 0)
                                    firetouchinterest(v.Parent.Rock, char.RightHand, 1)
                                    firetouchinterest(v.Parent.Rock, char.LeftHand, 0)
                                    firetouchinterest(v.Parent.Rock, char.LeftHand, 1)
                                    gettool()
                                end
                            end
                        end
                    end
                end
            end)
        end
    end)
end

-- Generar Switches de Rocas
CreateRockSwitch("Tiny Island Rock", 0)
CreateRockSwitch("Starter Island Rock", 100)
CreateRockSwitch("Legend Beach Rock", 5000)
CreateRockSwitch("Frost Gym Rock", 150000)
CreateRockSwitch("Mythical Gym Rock", 400000)
CreateRockSwitch("Eternal Gym Rock", 750000)
CreateRockSwitch("Legend Gym Rock", 1000000)
CreateRockSwitch("Ancient Jungle Rock", 10000000)

---
--- PESTAÑA: TP AREAS
---
teleport:AddButton("Spawn", function() TP(CFrame.new(2, 8, 115), "Spawn") end)
teleport:AddButton("Secret Area", function() TP(CFrame.new(1947, 2, 6191), "Secret Area") end)
teleport:AddButton("Tiny Island", function() TP(CFrame.new(-34, 7, 1903), "Tiny Island") end)
teleport:AddButton("Frozen Island", function() TP(CFrame.new(-2600, 4, -404), "Frozen Island") end)
teleport:AddButton("Mythical Island", function() TP(CFrame.new(2255, 7, 1071), "Mythical Island") end)
teleport:AddButton("Hell Island", function() TP(CFrame.new(-6768, 7, -1287), "Hell Island") end)
teleport:AddButton("Legend Island", function() TP(CFrame.new(4604, 991, -3887), "Legend Island") end)
teleport:AddButton("Muscle King Island", function() TP(CFrame.new(-8646, 17, -5738), "Muscle King") end)
teleport:AddButton("Jungle Island", function() TP(CFrame.new(-8659, 6, 2384), "Jungle Island") end)
teleport:AddButton("Brawl Lava", function() TP(CFrame.new(4471, 119, -8836), "Brawl Lava") end)
teleport:AddButton("Brawl Desert", function() TP(CFrame.new(960, 17, -7398), "Brawl Desert") end)
teleport:AddButton("Brawl Regular", function() TP(CFrame.new(-1849, 20, -6335), "Brawl Regular") end)

---
--- PESTAÑA: GIFT SYSTEM
---
local selectedEggPlayer, eggCount = nil, 0
local selectedShakePlayer, shakeCount = nil, 0

giftTab:AddLabel("🎁 Gift Protein Eggs").TextSize = 20
local eggDropdown = giftTab:AddDropdown("Select Player", function(val)
    for _, p in ipairs(Players:GetPlayers()) do if p.DisplayName == val then selectedEggPlayer = p end end
end)

giftTab:AddTextBox("Amount", function(t) eggCount = tonumber(t) or 0 end)
giftTab:AddButton("Send Eggs", function()
    if selectedEggPlayer and eggCount > 0 then
        for i = 1, eggCount do
            local item = LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
            if item then ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", selectedEggPlayer, item) task.wait(0.1) else break end
        end
    end
end)

giftTab:AddLabel("🥤 Gift Tropical Shakes").TextSize = 20
local shakeDropdown = giftTab:AddDropdown("Select Player", function(val)
    for _, p in ipairs(Players:GetPlayers()) do if p.DisplayName == val then selectedShakePlayer = p end end
end)

giftTab:AddTextBox("Amount", function(t) shakeCount = tonumber(t) or 0 end)
giftTab:AddButton("Send Shakes", function()
    if selectedShakePlayer and shakeCount > 0 then
        for i = 1, shakeCount do
            local item = LocalPlayer.consumablesFolder:FindFirstChild("Tropical Shake")
            if item then ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", selectedShakePlayer, item) task.wait(0.1) else break end
        end
    end
end)

-- Actualizar Dropdowns de Jugadores
local function RefreshPlayers()
    eggDropdown:Clear()
    shakeDropdown:Clear()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            eggDropdown:Add(p.DisplayName)
            shakeDropdown:Add(p.DisplayName)
        end
    end
end

Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)
RefreshPlayers()

---
--- SISTEMA ANTI-CAÍDA (WalkParts)
---
local function AntiFall()
    local folder = Instance.new("Folder", workspace)
    folder.Name = "DTH_Platforms"
    local platforms = {
        {Vector3.new(-110, -9, -10999), Vector3.new(10000, 1, 10000)},
        {Vector3.new(-8922, -9, -6233),
