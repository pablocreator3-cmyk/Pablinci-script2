local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Invocando Enemigos...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().fastPunch = false
getgenv().bringKill = false

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)

-- SECCIÓN FARM (Fuerza y Velocidad)
FarmTab:CreateSection("Entrenamiento")

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
               for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(4)
               end
            end
            task.wait(0.001)
         end
      end)
   end,
})

-- SECCIÓN COMBATE (BRING KILL)
CombatTab:CreateSection("PVP Dominación")

CombatTab:CreateToggle({
   Name = "Bring Kill (Traer Jugadores)",
   CurrentValue = false,
   Flag = "BringKillTgl",
   Callback = function(Value)
      getgenv().bringKill = Value
      task.spawn(function()
         while getgenv().bringKill do
            pcall(function()
                local localPlayer = game.Players.LocalPlayer
                local myRoot = localPlayer.Character.HumanoidRootPart
                
                -- Buscar a todos los jugadores menos a ti
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
                        -- Teletransporta al enemigo justo frente a ti (solo en tu pantalla, pero cuenta el daño)
                        player.Character.HumanoidRootPart.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
                        
                        -- Atacar automáticamente
                        local punch = localPlayer.Backpack:FindFirstChild("Punch") or localPlayer.Character:FindFirstChild("Punch")
                        if punch then
                            localPlayer.Character.Humanoid:EquipTool(punch)
                            punch:Activate()
                        end
                    end
                end
            end)
            task.wait(0.1) -- Velocidad con la que los atrae
         end
      end)
   end,
})

CombatTab:CreateSection("Ajustes")
CombatTab:CreateSlider({
   Name = "Velocidad de Caminado",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "SpeedSld",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v13",
   Content = "Bring Kill Activado. ¡Trae a todos!",
   Duration = 5,
   Image = 4483345998,
})
