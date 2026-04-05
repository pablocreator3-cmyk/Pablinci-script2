local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Actualizando Sensores...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_ML" },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoPunch = false
getgenv().magneticRocks = false

local FarmTab = Window:CreateTab("🏋️ Farm Pro", 4483345998)

FarmTab:CreateSection("Golpe a Distancia (Rocas Magnéticas)")

FarmTab:CreateToggle({
   Name = "Atraer Rocas / Pegar Distancia",
   CurrentValue = false,
   Flag = "MagRockTgl",
   Callback = function(Value)
      getgenv().magneticRocks = Value
      task.spawn(function()
         while getgenv().magneticRocks do
            pcall(function()
                local playerPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                -- Buscamos las máquinas/rocas en el mapa
                for _, v in pairs(workspace.machines:GetChildren()) do
                    if v:IsA("Model") and (v.Name:find("Rock") or v.Name:find("Roca")) then
                        -- Movemos la roca visualmente hacia nosotros para que el golpe detecte
                        for _, part in pairs(v:GetChildren()) do
                            if part:IsA("BasePart") then
                                -- Esto hace que la roca 'exista' justo frente a ti
                                part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                            end
                        end
                    end
                end
            end)
            task.wait(0.5) -- No lo pongas muy rápido para evitar lag
         end
      end)
   end,
})

FarmTab:CreateSection("Auto Clicker")

FarmTab:CreateToggle({
   Name = "Auto Punch (Animación)",
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
               -- Velocidad de brazo aumentada
               for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(2.2)
               end
            end
            task.wait(0.01)
         end
      end)
   end,
})

-- Botón de ayuda si se queda trabada la roca
FarmTab:CreateButton({
   Name = "Arreglar Rocas (Si se bugean)",
   Callback = function()
       -- Esto recarga tu personaje para que las rocas vuelvan a su sitio original
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v5",
   Content = "Sistema de Rocas Magnéticas Cargado.",
   Duration = 5,
   Image = 4483345998,
})
