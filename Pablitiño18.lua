local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Configurando Rebirths...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().fastPunch = false
getgenv().ghostKill = false
getgenv().lockPos = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0
local lockedCFrame = nil

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- PESTAÑA FARM
FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Fuerza)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoWeight = Value
      task.spawn(function()
         while getgenv().autoWeight do
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or game.Players.LocalPlayer.Character:FindFirstChild("Weight")
            if tool then 
               game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
               tool:Activate() 
            end
            task.wait(0.001)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "FAST PUNCH (Pulido)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastPunch = Value
      task.spawn(function()
         while getgenv().fastPunch do
            local char = game.Players.LocalPlayer.Character
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
            if tool then
               char.Humanoid:EquipTool(tool)
               tool:Activate()
               pcall(function()
                  for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                      anim:AdjustSpeed(5)
                  end
               end)
            end
            task.wait()
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "LOCK POSITION (Ancla)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().lockPos = Value
      if Value then
         lockedCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
         task.spawn(function()
            while getgenv().lockPos do
               game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lockedCFrame
               task.wait()
            end
         end)
      end
   end,
})

-- PESTAÑA REBIRTH (NUEVA)
RebirthTab:CreateSection("Configuración de Rebirth")

RebirthTab:CreateInput({
   Name = "Cantidad de Rebirths deseados",
   PlaceholderText = "Escribe un número (ej. 10)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().targetRebirths = tonumber(Text) or 0
      rebirthesDone = 0
      Rayfield:Notify({Title = "pablo_DTH", Content = "Objetivo: " .. getgenv().targetRebirths .. " Rebirths", Duration = 3})
   end,
})

RebirthTab:CreateToggle({
   Name = "Auto Rebirth (Infinito o por Cantidad)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            -- Si pusiste una cantidad exacta y ya llegaste, se apaga
            if getgenv().targetRebirths > 0 and rebirthesDone >= getgenv().targetRebirths then
                getgenv().autoRebirth = false
                Rayfield:Notify({Title = "pablo_DTH", Content = "¡Objetivo de Rebirths completado!", Duration = 5})
                break
            end
            
            -- Intento de Rebirth
            local success = game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            rebirthesDone = rebirthesDone + 1
            task.wait(2) -- Tiempo de espera para que el juego procese
         end
      end)
   end,
})

-- PESTAÑA COMBATE
CombatTab:CreateSection("Ghost Kill")

CombatTab:CreateToggle({
   Name = "Ghost Kill (Auto-Daño)",
   CurrentValue = false,
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
                        if (myRoot.Position - enemyRoot.Position).Magnitude <= 100 then
                            local punch = lp.Backpack:FindFirstChild("Punch") or lp.Character:FindFirstChild("Punch")
                            if punch then
                                lp.Character.Humanoid:EquipTool(punch)
                                punch:Activate()
                                local oldCF = enemyRoot.CFrame
                                enemyRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -2)
                                task.wait()
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

Rayfield:Notify({
   Title = "pablo_DTH Hub v17",
   Content = "Sistema de Rebirth y Lock Pos listos.",
   Duration = 5,
   Image = 4483345998,
})
