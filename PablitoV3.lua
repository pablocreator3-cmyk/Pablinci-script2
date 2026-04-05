local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Activando Rango Infinito...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_ML" },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoPunch = false
getgenv().distanciaRocas = false

-- Pestaña Farm
local FarmTab = Window:CreateTab("🏋️ Farm & Distancia", 4483345998)

FarmTab:CreateSection("Golpe a Distancia")

FarmTab:CreateToggle({
   Name = "Pegar a Rocas desde Lejos",
   CurrentValue = false,
   Flag = "DistanciaTgl",
   Callback = function(Value)
      getgenv().distanciaRocas = Value
      task.spawn(function()
         while getgenv().distanciaRocas do
            pcall(function()
                -- Buscamos la roca más cercana en el mapa
                for _, v in pairs(game:GetService("Workspace").machines:GetChildren()) do
                    if v:IsA("Model") and (v.Name:find("Rock") or v.Name:find("Roca")) then
                        local touchPart = v:FindFirstChild("TouchPart") or v:FindFirstChildWhichIsA("BasePart")
                        if touchPart then
                            -- Creamos una conexión invisible entre tu puño y la roca
                            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Right Hand"), touchPart, 0)
                            firetouchinterest(game.Players.LocalPlayer.Character:WaitForChild("Right Hand"), touchPart, 1)
                        end
                    end
                end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

FarmTab:CreateSection("Auto Clicker")

FarmTab:CreateToggle({
   Name = "Auto Punch (Animación Fluida)",
   CurrentValue = false,
   Flag = "PunchTgl",
   Callback = function(Value)
      getgenv().autoPunch = Value
      task.spawn(function()
         while getgenv().autoPunch do
            local char = game.Players.LocalPlayer.Character
            local punch = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
            if punch then
               char.Humanoid:EquipTool(punch)
               punch:Activate()
               -- Aceleración de animación para que sea visualmente rápido
               for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(2.0)
               end
            end
            task.wait(0.01)
         end
      end)
   end,
})

-- Pestaña Rebirth Automático
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)
RebirthTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Flag = "RebirthTgl",
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            task.wait(2)
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v4",
   Content = "Sistema de Distancia Activado.",
   Duration = 5,
   Image = 4483345998,
})
