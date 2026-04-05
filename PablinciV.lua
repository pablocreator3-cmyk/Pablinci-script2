local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Localizando Rocas...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = true, FolderName = "pablo_DTH_Fix" },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().farmJungle = false
getgenv().farmKing = false

local FarmTab = Window:CreateTab("🏋️ Farm Islas", 4483345998)

FarmTab:CreateSection("Fuerza")

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

FarmTab:CreateSection("Durabilidad (TP Automático)")

-- FUNCIÓN PARA TELETRANSPORTAR Y PEGAR
local function farmRock(rockName)
    pcall(function()
        local rock = workspace.machines:FindFirstChild(rockName)
        if rock then
            local target = rock:FindFirstChild("TouchPart") or rock:FindFirstChildWhichIsA("BasePart")
            if target then
                -- Te pone exactamente sobre la roca
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame * CFrame.new(0, 5, 0)
                
                -- Equipar puño y pegar
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
                if tool then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    tool:Activate()
                end
            end
        end
    end)
end

-- BOTÓN JUNGLE (Busca la roca de 100 de durabilidad)
FarmTab:CreateToggle({
   Name = "Farm: Roca Jungle",
   CurrentValue = false,
   Flag = "JungleTgl",
   Callback = function(Value)
      getgenv().farmJungle = Value
      task.spawn(function()
         while getgenv().farmJungle do
            farmRock("Gran Roca") -- El nombre interno suele ser este
            task.wait(0.05)
         end
      end)
   end,
})

-- BOTÓN KING (Busca la roca de la isla final)
FarmTab:CreateToggle({
   Name = "Farm: Roca King",
   CurrentValue = false,
   Flag = "KingTgl",
   Callback = function(Value)
      getgenv().farmKing = Value
      task.spawn(function()
         while getgenv().farmKing do
            -- En la isla King, las rocas tienen nombres específicos
            farmRock("Magma Rock") or farmRock("King Rock")
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
   Title = "pablo_DTH Hub Actualizado",
   Content = "TP por nombre de objeto activado.",
   Duration = 5,
   Image = 4483345998,
})
