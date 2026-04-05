local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Cargando Ghost Kill...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables de Control
getgenv().autoWeight = false
getgenv().ghostKill = false
getgenv().killDistance = 100 -- Rango de detección

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)

-- SECCIÓN FARM (Fuerza)
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

-- SECCIÓN COMBATE (GHOST KILL)
CombatTab:CreateSection("Asesinato Fantasma")

CombatTab:CreateToggle({
   Name = "Ghost Kill (Pegar a Distancia Real)",
   CurrentValue = false,
   Flag = "GhostTgl",
   Callback = function(Value)
      getgenv().ghostKill = Value
      task.spawn(function()
         while getgenv().ghostKill do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local myRoot = lp.Character.HumanoidRootPart
                
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
                        local enemyRoot = player.Character.HumanoidRootPart
                        local dist = (myRoot.Position - enemyRoot.Position).Magnitude
                        
                        -- Si el enemigo está en el rango, enviamos el daño
                        if dist <= getgenv().killDistance then
                            -- Equipamos puño
                            local punch = lp.Backpack:FindFirstChild("Punch") or lp.Character:FindFirstChild("Punch")
                            if punch then
                                lp.Character.Humanoid:EquipTool(punch)
                                punch:Activate()
                                
                                -- MÉTODO GHOST: Mueve el hitbox del enemigo a tu mano por 1 milisegundo
                                local oldCF = enemyRoot.CFrame
                                enemyRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -2)
                                task.wait() -- El golpe ocurre aquí
                                enemyRoot.CFrame = oldCF
                            end
                        end
                    end
                end
            end)
            task.wait(0.05)
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Rango de Detección",
   Range = {10, 300},
   Increment = 10,
   Suffix = " Studs",
   CurrentValue = 100,
   Flag = "DistSld",
   Callback = function(Value)
      getgenv().killDistance = Value
   end,
})

CombatTab:CreateSection("Movimiento")
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
   Title = "pablo_DTH Hub v15",
   Content = "Ghost Kill Activado. ¡A dominar!",
   Duration = 5,
   Image = 4483345998,
})
