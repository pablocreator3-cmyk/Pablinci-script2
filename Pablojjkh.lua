--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL - MOVIBLE)
    Nueva Función: AUTO FAST WEIGHT (X10 Velocidad)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH Hub v32",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "Ocean", 
   DisableBuildWarnings = true,
   KeybindSource = "RightControl" 
})

-- VARIABLES GLOBALES
getgenv().autoWeight = false
getgenv().fastWeight = false -- Nueva Variable
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- ==========================================
-- SECCIÓN: FARM (ENTRENAMIENTO)
-- ==========================================
FarmTab:CreateSection("Entrenamiento Rápido")

-- NUEVA FUNCIÓN: AUTO FAST WEIGHT
FarmTab:CreateToggle({
   Name = "🔥 AUTO FAST WEIGHT (Ultra Rápido)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastWeight = Value
      task.spawn(function()
         while getgenv().fastWeight do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char:FindFirstChild("Weight") or game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
                if tool then 
                   if not char:FindFirstChild("Weight") then
                      char.Humanoid:EquipTool(tool)
                   end
                   tool:Activate()
                   -- Bypass de animación y velocidad extrema
                   for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                       anim:AdjustSpeed(10) -- Animación x10
                   end
                end
            end)
            task.wait(0.01) -- Sin espera para máximo spam de fuerza
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "Auto Pesas (Normal)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoWeight = Value
      task.spawn(function()
         while getgenv().autoWeight do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char:FindFirstChild("Weight") or game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
                if tool then 
                   if not char:FindFirstChild("Weight") then
                      char.Humanoid:EquipTool(tool)
                   end
                   tool:Activate() 
                end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "Fast Punch (Animación x5)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastPunchAnim = Value
      task.spawn(function()
         while getgenv().fastPunchAnim do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local hum = char:FindFirstChildOfClass("Humanoid")
                for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                    anim:AdjustSpeed(5)
                end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

-- ==========================================
-- SECCIÓN: COMBATE
-- ==========================================
CombatTab:CreateSection("Ghost Kill Global")

CombatTab:CreateToggle({
   Name = "Matar a Todos (Global)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ghostKillGlobal = Value
      task.spawn(function()
         while getgenv().ghostKillGlobal do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local punch = lp.Character:FindFirstChild("Punch") or lp.Backpack:FindFirstChild("Punch")
                
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                        lp.Character.Humanoid:EquipTool(punch)
                        punch:Activate()
                        local enemyRoot = v.Character.HumanoidRootPart
                        local oldCF = enemyRoot.CFrame
                        enemyRoot.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        task.wait(0.05)
                        enemyRoot.CFrame = oldCF
                    end
                end
            end)
            task.wait(0.4)
         end
      end)
   end,
})

-- ==========================================
-- SECCIÓN: REBIRTH
-- ==========================================
RebirthTab:CreateSection("Configuración")

RebirthTab:CreateInput({
   Name = "Meta de Rebirths",
   PlaceholderText = "Escribe número",
   Callback = function(Value)
      getgenv().targetRebirths = tonumber(Value) or 0
   end,
})

RebirthTab:CreateToggle({
   Name = "Activar Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            pcall(function()
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                if getgenv().targetRebirths > 0 and currentRebirths >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                    Rayfield:Notify({
                        Title = "Meta Alcanzada",
                        Content = "Llegaste a " .. tostring(getgenv().targetRebirths) .. " rebirths.",
                        Duration = 5,
                        Image = 4483345998,
                    })
                else
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                end
            end)
            task.wait(2.5)
         end
      end)
   end,
})
