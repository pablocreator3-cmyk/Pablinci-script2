-- [[ ⚡ SÚPER DTH HUB - VERSIÓN FINAL RAYFIELD ⚡ ]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "⚡ Súper DTH Hub | By Pablito ⚡",
   LoadingTitle = "Cargando Script de Pablito...",
   LoadingSubtitle = "Muscle Legends Edition",
   ConfigurationSaving = {
      Enabled = false
   },
   KeySystem = false
})

-- Variables
getgenv().autoFarm = false
local selectrock = ""
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Tabs
local MainTab = Window:CreateTab("Farm Rocks", 4483362458) 
local TPTab = Window:CreateTab("TP Areas", 4483362458)
local GiftTab = Window:CreateTab("Gift System", 4483362458)

-- Función equipar Punch
local function gettool()
    local p = LocalPlayer.Backpack:FindFirstChild("Punch") or LocalPlayer.Character:FindFirstChild("Punch")
    if p then p.Parent = LocalPlayer.Character end
end

-- --- SECCIÓN: FARM ROCKS ---
local function AddRock(name, dur)
    MainTab:CreateToggle({
       Name = name .. " (" .. tostring(dur) .. ")",
       CurrentValue = false,
       Callback = function(Value)
           getgenv().autoFarm = Value
           selectrock = name
           if Value then
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
           end
       end,
    })
end

AddRock("Tiny Island", 0)
AddRock("Starter Island", 100)
AddRock("Beach Rock", 5000)
AddRock("Frost Gym", 150000)
AddRock("Mythical Gym", 400000)
AddRock("Eternal Gym", 750000)
AddRock("Legend Gym", 1000000)
AddRock("Ancient Jungle", 10000000)

-- --- SECCIÓN: TELEPORTS ---
local locations = {
    ["Spawn"] = CFrame.new(2, 8, 115),
    ["Secret Area"] = CFrame.new(1947, 2, 6191),
    ["Tiny Island"] = CFrame.new(-34, 7, 1903),
    ["Muscle King"] = CFrame.new(-8646, 17, -5738),
    ["Legend Island"] = CFrame.new(4604, 991, -3887)
}

for name, cf in pairs(locations) do
    TPTab:CreateButton({
       Name = "Ir a: " .. name,
       Callback = function()
           if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
               LocalPlayer.Character.HumanoidRootPart.CFrame = cf
           end
       end,
    })
end

-- --- SECCIÓN: GIFT SYSTEM ---
local selectedTarget = nil
local eggAmount = 0

local playerNames = {}
for _, p in ipairs(Players:GetPlayers()) do
    if p ~= LocalPlayer then table.insert(playerNames, p.DisplayName) end
end

local GiftDropdown = GiftTab:CreateDropdown({
   Name = "Seleccionar Jugador",
   Options = playerNames,
   CurrentOption = {""},
   MultipleOptions = false,
   Callback = function(Option)
       for _, p in ipairs(Players:GetPlayers()) do
           if p.DisplayName == Option[1] then selectedTarget = p end
       end
   end,
})

GiftTab:CreateInput({
   Name = "Cantidad de Regalos",
   PlaceholderText = "Escribe un número...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
       eggAmount = tonumber(Text) or 0
   end,
})

GiftTab:CreateButton({
   Name = "Regalar Protein Eggs",
   Callback = function()
       if selectedTarget and eggAmount > 0 then
           for i = 1, eggAmount do
               local item = LocalPlayer.consumablesFolder:FindFirstChild("Protein Egg")
               if item then 
                   game:GetService("ReplicatedStorage").rEvents.giftRemote:InvokeServer("giftRequest", selectedTarget, item)
                   task.wait(0.1)
               else break end
           end
       end
   end,
})

-- Plataforma de seguridad
local p = Instance.new("Part", workspace)
p.Size, p.Position, p.Anchored, p.Transparency = Vector3.new(5000, 1, 5000), Vector3.new(0, -10, 0), true, 1

Rayfield:Notify({
   Title = "DTH HUB LISTO",
   Content = "Script cargado correctamente, Pablito.",
   Duration = 5,
   Image = 4483362458,
})
