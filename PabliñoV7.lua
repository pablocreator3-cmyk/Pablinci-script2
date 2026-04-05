local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Activando Kill Aura...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().fastPunch = false
getgenv().killAura = false
getgenv().auraRange = 50 -- Distancia del golpe

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)

-- SECCIÓN FARM
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

-- SECCIÓN COMBATE (KILL AURA / DISTANCIA)
CombatTab:CreateSection("Asesinato a Distancia")

CombatTab:CreateToggle({
   Name = "Kill Aura (Golpe a Distancia)",
   CurrentValue = false,
   Flag = "KillAuraTgl",
   Callback = function(Value)
      getgenv().killAura = Value
      task.spawn(function()
         while getgenv().killAura do
            pcall(function()
                local localPlayer = game.Players.LocalPlayer
                local myRoot = localPlayer.Character.HumanoidRootPart
                
                -- Buscar jugadores en el rango
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.Humanoid.Health > 0 then
                        local enemyRoot = player.Character.HumanoidRootPart
                        local distance = (myRoot.Position - enemyRoot.Position).Magnitude
                        
                        -- Si está dentro del rango, le pegamos sin movernos
                        if distance <= getgenv().auraRange then
                            -- Equipar puño
                            local punch = localPlayer.Backpack:FindFirstChild("Punch") or localPlayer.Character:FindFirstChild("Punch")
                            if punch then
                                localPlayer.Character.Humanoid:EquipTool(punch)
                                punch:Activate()
                                -- Truco de "Reach": Registra el toque en el enemigo
                                firetouchinterest(localPlayer.Character:WaitForChild("Right Hand"), enemyRoot, 0)
                                firetouchinterest(localPlayer.Character:WaitForChild("Right Hand"), enemyRoot, 1)
                            end
                        end
                    end
                end
            end)
            task.wait(0.05) -- Velocidad de los golpes
         end
      end)
   end,
})

CombatTab:CreateSlider({
   Name = "Rango del Aura",
   Range = {10, 200},
   Increment = 10,
   Suffix = " Studs",
   CurrentValue = 50,
   Flag = "RangeSld",
   Callback = function(Value)
      getgenv().auraRange = Value
   end,
})

CombatTab:CreateSection("Velocidad")
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
   Title = "pablo_DTH Hub v14",
   Content = "Kill Aura (Reach) Activado.",
   Duration = 5,
   Image = 4483345998,
})
