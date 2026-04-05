local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Cargando Versión Pro...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_ML" },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().autoPunch = false
getgenv().autoRebirth = false

-- Pestaña Farm
local FarmTab = Window:CreateTab("🏋️ Farm Principal", 4483345998)

FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Equip + Click)",
   CurrentValue = false,
   Flag = "WeightTgl",
   Callback = function(Value)
      getgenv().autoWeight = Value
      if Value then
         task.spawn(function()
            while getgenv().autoWeight do
               local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or game.Players.LocalPlayer.Character:FindFirstChild("Weight")
               if tool then 
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                  tool:Activate() 
               end
               task.wait(0.001) -- Velocidad extrema
            end
         end)
      end
   end,
})

FarmTab:CreateToggle({
   Name = "FAST PUNCH (No Bug)",
   CurrentValue = false,
   Flag = "PunchTgl",
   Callback = function(Value)
      getgenv().autoPunch = Value
      if Value then
         task.spawn(function()
            while getgenv().autoPunch do
               local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
               if tool then
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                  -- Usamos un pequeño truco para que pegue más rápido saltando animaciones
                  tool:Activate()
                  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
               end
               task.wait() -- Espera mínima del motor (aprox 0.03)
            end
         end)
      end
   end,
})

-- Pestaña Rebirth
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

RebirthTab:CreateSection("Renacimiento Automático")

RebirthTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "RebirthTgl",
   Callback = function(Value)
      getgenv().autoRebirth = Value
      if Value then
         task.spawn(function()
            while getgenv().autoRebirth do
               -- Dispara el evento de Rebirth del juego
               game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
               task.wait(2) -- Espera 2 segundos entre intentos para no saturar
            end
         end)
      end
   end,
})

-- Pestaña Ajustes
local MiscTab = Window:CreateTab("⚙️ Ajustes", 4483345998)
MiscTab:CreateSlider({
   Name = "Velocidad",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v2",
   Content = "Auto Rebirth y Fast Punch añadidos.",
   Duration = 5,
   Image = 4483345998,
})
