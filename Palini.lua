local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Activando Imán de Rocas...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables
getgenv().autoWeight = false
getgenv().imanJungle = false
getgenv().imanKing = false

local FarmTab = Window:CreateTab("🏋️ Farm Magnet", 4483345998)

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

FarmTab:CreateSection("Imán de Rocas (Vienen a ti)")

-- FUNCIÓN MAESTRA DEL IMÁN
local function traerRoca(nombreRoca)
    pcall(function()
        local roca = workspace.machines:FindFirstChild(nombreRoca)
        if roca then
            for _, part in pairs(roca:GetChildren()) do
                if part:IsA("BasePart") then
                    -- La roca se teletransporta 3 studs frente a tu pecho
                    part.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    part.CanCollide = false -- Para que no te empuje
                end
            end
            
            -- Auto Golpe mientras la roca está ahí
            local punch = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or game.Players.LocalPlayer.Character:FindFirstChild("Punch")
            if punch then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(punch)
                punch:Activate()
            end
        end
    end)
end

-- INTERRUPTOR JUNGLE
FarmTab:CreateToggle({
   Name = "Imán: Roca Jungle (100+ Dura)",
   CurrentValue = false,
   Flag = "JungleMag",
   Callback = function(Value)
      getgenv().imanJungle = Value
      task.spawn(function()
         while getgenv().imanJungle do
            traerRoca("Gran Roca")
            task.wait(0.1)
         end
      end)
   end,
})

-- INTERRUPTOR KING
FarmTab:CreateToggle({
   Name = "Imán: Roca King (Isla Final)",
   CurrentValue = false,
   Flag = "KingMag",
   Callback = function(Value)
      getgenv().imanKing = Value
      task.spawn(function()
         while getgenv().imanKing do
            -- Intenta con los nombres comunes de la isla King
            traerRoca("Magma Rock")
            traerRoca("King Rock")
            task.wait(0.1)
         end
      end)
   end,
})

-- BOTÓN DE EMERGENCIA
FarmTab:CreateButton({
   Name = "Resetear Rocas (Si se bugean)",
   Callback = function()
       game.Players.LocalPlayer.Character.Humanoid.Health = 0
       Rayfield:Notify({Title = "pablo_DTH", Content = "Reteando posición de objetos...", Duration = 3})
   end,
})

Rayfield:Notify({
   Title = "pablo_DTH Hub v10",
   Content = "¡El imán de rocas está listo!",
   Duration = 5,
   Image = 4483345998,
})
