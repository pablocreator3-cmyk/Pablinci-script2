local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Escaneando Rocas Cercanas...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_ML" },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().autoPunch = false
getgenv().autoRock = false

local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)

FarmTab:CreateSection("Fuerza y Combate")

-- AUTO PESAS
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

-- AUTO PUNCH
FarmTab:CreateToggle({
   Name = "Auto Fast Punch (Combate)",
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
               for _, anim in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                   anim:AdjustSpeed(2.5)
               end
            end
            task.wait(0.01)
         end
      end)
   end,
})

FarmTab:CreateSection("Durabilidad (Rocas)")

-- AUTO ROCA CORREGIDO (Búsqueda por proximidad)
FarmTab:CreateToggle({
   Name = "Auto Farm Roca (TP + Hit)",
   CurrentValue = false,
   Flag = "RockTgl",
   Callback = function(Value)
      getgenv().autoRock = Value
      task.spawn(function()
         while getgenv().autoRock do
            pcall(function()
                local player = game.Players.LocalPlayer
                local character = player.Character
                local rootPart = character:WaitForChild("HumanoidRootPart")
                
                -- Buscar la roca más cercana en lugar de usar un nombre fijo
                local closestRock = nil
                local shortestDistance = math.huge
                
                for _, v in pairs(workspace.machines:GetChildren()) do
                    if v:IsA("Model") and (v.Name:lower():find("rock") or v.Name:lower():find("roca")) then
                        local part = v:FindFirstChild("TouchPart") or v:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local distance = (rootPart.Position - part.Position).Magnitude
                            if distance < shortestDistance then
                                closestRock = part
                                shortestDistance = distance
                            end
                        end
                    end
                end
                
                if closestRock then
                    -- TP a la roca más cercana
                    rootPart.CFrame = closestRock.CFrame * CFrame.new(0, 0, -2)
                    
                    -- Equipar puño y golpear
                    local punch = player.Backpack:FindFirstChild("Punch") or character:FindFirstChild("Punch")
                    if punch then
                        character.Humanoid:EquipTool(punch)
                        punch:Activate()
                    end
                end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

-- Pestaña Rebirth
local ReTab = Window:CreateTab("♻️ Rebirth", 4483345998)
ReTab:CreateToggle({
   Name = "Auto Rebirth",
   CurrentValue = false,
   Callback = function(v)
      getgenv().autoRebirth = v
      task.spawn(function()
         while getgenv().autoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            task.wait(2)
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v7",
   Content = "Sistema de detección de rocas activado.",
   Duration = 5,
   Image = 4483345998,
})
