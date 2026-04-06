-- [[ ⚡ SÚPER DTH HUB - VERSIÓN ESTABLE ⚡ ]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Variables de Estado
getgenv().autoFarm = false
local selectrock = ""

-- Función para equipar Punch
local function gettool()
    local p = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
    if p then p.Parent = LocalPlayer.Character end
end

-- UI Setup
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/SadOz8/U/main/I", true))()
local window = library:AddWindow("⚡ Súper DTH Hub | By Pablito ⚡", {
    main_color = Color3.fromRGB(255, 0, 0),
    min_size = Vector2.new(600, 700),
    can_resize = false,
})

local farmTab = window:AddTab("Farm Rocks")
local teleport = window:AddTab("TP Areas")
local giftTab = window:AddTab("Gift")

-- --- SECCIÓN: FARM ROCKS ---
local function AddRock(name, dur)
    farmTab:AddSwitch(name, function(bool)
        selectrock = name
        getgenv().autoFarm = bool
        task.spawn(function()
            while getgenv().autoFarm and selectrock == name do
                task.wait()
                if LocalPlayer.Durability.Value >= dur then
                    for _, v in pairs(workspace.machinesFolder:GetDescendants()) do
                        if v.Name == "neededDurability" and v.Value == dur then
                            local char = LocalPlayer.Character
                            if char and char:FindFirstChild("RightHand") then
                                firetouchinterest(v.Parent.Rock, char.RightHand, 0)
                                firetouchinterest(v.Parent.Rock, char.RightHand, 1)
                                gettool()
                            end
                        end
                    end
                end
            end
        end)
    end)
end

AddRock("Tiny Island (0)", 0)
AddRock("Starter (100)", 100)
AddRock("Beach (5k)", 5000)
AddRock("Frost (150k)", 150000)
AddRock("Mythical (400k)", 400000)
AddRock("Eternal (750k)", 750000)
AddRock("Legend (1M)", 1000000)
AddRock("Jungle (10M)", 10000000)

-- --- SECCIÓN: TP AREAS ---
local function CreateTP(name, cf)
    teleport:AddButton(name, function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = cf
        end
    end)
end

CreateTP("Spawn", CFrame.new(2, 8, 115))
CreateTP("Secret Area", CFrame.new(1947, 2, 6191))
CreateTP("Legend Island", CFrame.new(4604, 991, -3887))
CreateTP("Muscle King", CFrame.new(-8646, 17, -5738))

-- --- SECCIÓN: GIFT SYSTEM ---
local selectedTarget = nil
local eggAmount = 0

-- Dropdown manual para evitar errores de carga
local giftDropdown = giftTab:AddDropdown("Seleccionar Jugador", function(val)
    for _, p in ipairs(Players:GetPlayers()) do
        if p.DisplayName == val then selectedTarget = p end
    end
end)

-- Botón para actualizar la lista de jugadores manualmente si no aparecen
giftTab:AddButton("Actualizar Lista Jugadores", function()
    giftDropdown:Clear()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then giftDropdown:Add(p.DisplayName) end
    end
end)

giftTab:AddTextBox("Cantidad", function(t) eggAmount = tonumber(t) or 0 end)

giftTab:AddButton("Regalar Protein Eggs", function()
    if selectedTarget and eggAmount > 0 then
        for i = 1, eggAmount do
            local item = LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
            if item then 
                ReplicatedStorage.rEvents.giftRemote:InvokeServer("giftRequest", selectedTarget, item)
                task.wait(0.1)
            else break end
        end
    end
end)

-- Plataformas Anti-Caída
local plat = Instance.new("Part", workspace)
plat.Size = Vector3.new(25000, 1, 25000)
plat.Position = Vector3.new(0, -20, 0)
plat.Anchored = true
plat.Transparency = 1

print("Script cargado. Si los jugadores no aparecen en Gift, dale al botón Actualizar.")
