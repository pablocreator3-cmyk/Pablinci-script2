local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Optimizando Golpes...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_ML" },
   Theme = "DarkRed" 
})

-- Variables de Control
getgenv().autoWeight = false
getgenv().autoPunch = false
getgenv().autoDurability = false
getgenv().autoRebirth = false

-- Pestaña Farm
local FarmTab = Window:CreateTab("🏋️ Farm Principal", 4483345998)

FarmTab:CreateSection("Entrenamiento de Fuerza")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Equipar + Click)",
   CurrentValue = false,
   Flag = "WeightTgl",
   Callback = function(Value)
      getgenv().autoWeight = Value
      task.spawn(function()
         while getgenv().autoWeight do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or game.Players.LocalPlayer.Character:FindFirstChild("Weight")
            if tool then 
               game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
               tool:Activate() 
            end
            task.wait(0.05)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "FAST PUNCH (Animación Rápida)",
   CurrentValue = false,
   Flag = "PunchTgl",
   Callback = function(Value)
      getgenv().autoPunch = Value
      task.spawn(function()
         while getgenv().autoPunch do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
            if tool then
               game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
               tool:Activate()
               -- Aceleramos la animación sin cancelarla para que no se trabe
               for _, anim in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(2.5) -- 2.5 veces más rápido
               end
            end
            task.wait(0.01) -- Click muy rápido
         end
      end)
   end,
})

FarmTab:CreateSection("Entrenamiento de Durabilidad")

FarmTab:CreateToggle({
   Name = "Auto Durabilidad (Rocas)",
   CurrentValue = false,
   Flag = "DuraToggle",
   Callback = function(Value)
      getgenv().autoDurability = Value
      task.spawn(function()
         while getgenv().autoDurability do
            -- En Muscle Legends, para la roca solo necesitas clickear con el puño cerca
            local punch = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
            if punch then
               game.Players.LocalPlayer.Character.Humanoid:EquipTool(punch)
               punch:Activate()
            end
            task.wait(0.05)
         end
      end)
   end,
})

-- Pestaña Rebirth
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

RebirthTab:CreateToggle({
   Name = "Auto Rebirth Automático",
   CurrentValue = false,
   Flag = "RebirthTgl",
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            task.wait(3) -- Reintenta cada 3 segundos
         end
      end)
   end,
})

-- Notificación de Inicio
Rayfield:Notify({
   Title = "pablo_DTH Hub",
   Content = "Fast Punch y Auto Rebirth listos.",
   Duration = 5,
   Image = 4483345998,
})
