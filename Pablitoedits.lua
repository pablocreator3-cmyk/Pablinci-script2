--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL)
    ACTUALIZADO: Fast Punch Ultra & Fast Weight Fix
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
getgenv().fastWeight = false
getgenv().fastPunch = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- ==========================================
-- SECCIÓN: FARM
-- ==========================================
FarmTab:CreateSection("Entrenamiento Extremo")

-- AUTO FAST WEIGHT (CORREGIDO)
FarmTab:CreateToggle({
   Name = "🔥 AUTO FAST WEIGHT (Ultra)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastWeight = Value
      task.spawn(function()
         while getgenv().fastWeight do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local char = lp.Character
                local tool = char:FindFirstChild("Weight") or lp.Backpack:FindFirstChild("Weight")
                if tool then 
                   if not char:FindFirstChild("Weight") then char.Humanoid:EquipTool(tool) end
                   tool:Activate()
                   for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                       anim:AdjustSpeed(10)
                   end
                end
            end)
            task.wait(0.001) -- Velocidad máxima de envío
         end
      end)
   end,
})

-- AUTO FAST PUNCH (RECONSTRUIDO)
FarmTab:CreateToggle({
   Name = "🥊 AUTO FAST PUNCH (X10 Velocidad)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastPunch = Value
      task.spawn(function()
         while getgenv().fastPunch do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local char = lp.Character
                local punch = char:FindFirstChild("Punch") or lp.Backpack:FindFirstChild("Punch")
                
                if punch then
                   if not char:FindFirstChild("Punch") then char.Humanoid:EquipTool(punch) end
                   punch:Activate()
                   -- Forzar velocidad de todas las animaciones de golpe
                   local hum = char:FindFirstChildOfClass("Humanoid")
                   for _, track in pairs(hum:GetPlayingAnimationTracks()) do
                       track:AdjustSpeed(10) 
                   end
                end
            end)
            task.wait(0.001) -- Bypass de espera
         end
      end)
   end,
})

-- ==========================================
-- SECCIÓN: COMBATE
-- ==========================================
CombatTab:CreateSection("Combate")

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
                        v.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                    end
                end
            end)
            task.wait(0.3)
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
                local stats = game.Players.LocalPlayer:WaitForChild("leaderstats")
                local current = stats.Rebirths.Value
                if getgenv().targetRebirths > 0 and current >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                else
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                end
            end)
            task.wait(2)
         end
      end)
   end,
})
