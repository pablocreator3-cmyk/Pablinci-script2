local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Reparando Sensores de Rocas...",
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

-- AUTO PESAS (FUERZA)
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

-- AUTO PUNCH (COMBATE)
FarmTab:CreateToggle({
   Name = "Auto Fast Punch (Animación)",
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

-- AUTO ROCA (DISTANCIA REAL)
FarmTab:CreateToggle({
   Name = "Auto Farm Roca (TP + Hit)",
   CurrentValue = false,
   Flag = "RockTgl",
   Callback = function(Value)
      getgenv().autoRock = Value
      task.spawn(function()
         while getgenv().autoRock do
            pcall(function()
                -- Buscamos la roca de 100 de durabilidad (o la más cercana)
                local rock = workspace.machines:FindFirstChild("Gran Roca") or workspace.machines:FindFirstChild("Tiny Rock")
                if rock then
                    local target = rock:FindFirstChild("TouchPart") or rock:FindFirstChildWhichIsA("BasePart")
                    if target then
                        -- Te mantiene pegado a la roca para que el golpe siempre cuente
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 0, -2)
                        
                        -- Equipar puño y pegar
                        local punch = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
                        if punch then
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(punch)
                            punch:Activate()
                        end
                    end
                end
            end)
            task.wait(0.05)
         end
      end)
   end,
})

-- Pestaña Rebirth
local MiscTab = Window:CreateTab("♻️ Rebirth", 4483345998)
MiscTab:CreateToggle({
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
   Title = "pablo_DTH Hub v6",
   Content = "Rocas y Fuerza funcionando.",
   Duration = 5,
   Image = 4483345998,
})
