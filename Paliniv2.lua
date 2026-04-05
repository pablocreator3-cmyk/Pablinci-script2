local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Cargando Puños Rápidos...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables de estado
getgenv().autoWeight = false
getgenv().autoPunch = false
getgenv().fastPunch = false
getgenv().autoRebirth = false

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)

FarmTab:CreateSection("Entrenamiento Principal")

-- OPCIÓN: PESAS
FarmTab:CreateToggle({
   Name = "Auto Pesas (Fuerza)",
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
            task.wait(0.01)
         end
      end)
   end,
})

FarmTab:CreateSection("Sistemas de Golpeo")

-- OPCIÓN: AUTO PUNCH (Normal)
FarmTab:CreateToggle({
   Name = "Auto Punch (Normal)",
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
            end
            task.wait(0.1)
         end
      end)
   end,
})

-- OPCIÓN: AUTO FAST PUNCH (Velocidad Aumentada)
FarmTab:CreateToggle({
   Name = "Auto Fast Punch (Súper Rápido)",
   CurrentValue = false,
   Flag = "FastPunchTgl",
   Callback = function(Value)
      getgenv().fastPunch = Value
      task.spawn(function()
         while getgenv().fastPunch do
            local char = game.Players.LocalPlayer.Character
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
            
            if tool then
               char.Humanoid:EquipTool(tool)
               tool:Activate()
               -- Aceleramos las animaciones de los brazos
               for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(3.5) -- 3.5 veces más rápido que lo normal
               end
            end
            task.wait(0.001) -- Tiempo de espera casi nulo
         end
      end)
   end,
})

-- PESTAÑA REBIRTH
local MiscTab = Window:CreateTab("♻️ Extras", 4483345998)

MiscTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "RebirthTgl",
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            task.wait(3)
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v11",
   Content = "Fast Punch y Auto Punch listos.",
   Duration = 5,
   Image = 4483345998,
})
