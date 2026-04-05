local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Viajando a las Islas...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_Islas" },
   Theme = "DarkRed" 
})

-- Variables de Control
getgenv().autoWeight = false
getgenv().autoPunch = false
getgenv().farmJungle = false
getgenv().farmKing = false

local FarmTab = Window:CreateTab("🏋️ Farm Islas", 4483345998)

FarmTab:CreateSection("Fuerza General")

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

FarmTab:CreateSection("Durabilidad por Islas")

-- ISLA JUNGLE
FarmTab:CreateToggle({
   Name = "Auto Farm: Roca Jungle",
   CurrentValue = false,
   Flag = "JungleTgl",
   Callback = function(Value)
      getgenv().farmJungle = Value
      task.spawn(function()
         while getgenv().farmJungle do
            pcall(function()
                -- Coordenadas aproximadas de la Roca en Jungle
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1236, 17, -542)
                
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
                if tool then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    tool:Activate()
                end
            end)
            task.wait(0.05)
         end
      end)
   end,
})

-- ISLA KING
FarmTab:CreateToggle({
   Name = "Auto Farm: Roca King",
   CurrentValue = false,
   Flag = "KingTgl",
   Callback = function(Value)
      getgenv().farmKing = Value
      task.spawn(function()
         while getgenv().farmKing do
            pcall(function()
                -- Coordenadas aproximadas de la Roca en King's Island
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3412, 107, -49)
                
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
                if tool then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    tool:Activate()
                end
            end)
            task.wait(0.05)
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
   Title = "pablo_DTH Hub v8",
   Content = "Islas Jungle y King configuradas.",
   Duration = 5,
   Image = 4483345998,
})
