--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (CON BOTÓN PARA MINIMIZAR)
    Color: DarkRed | Optimizado para Delta & GitHub
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH Hub v32",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed",
   -- ESTO PERMITE HACERLA MÁS PEQUEÑA
   KeybindSource = "RightControl" 
})

-- VARIABLES
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- ==========================================
-- BOTÓN PARA MINIMIZAR (HACER PEQUEÑA)
-- ==========================================
-- Rayfield crea automáticamente un botón flotante pequeño 
-- si la librería carga correctamente en Delta.

FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Fuerza)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoWeight = Value
      task.spawn(function()
         while getgenv().autoWeight do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char:FindFirstChild("Weight") or game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
                if tool then 
                   char.Humanoid:EquipTool(tool)
                   tool:Activate() 
                end
            end)
            task.wait(0.2)
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
                local tool = char:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
                if tool then
                   char.Humanoid:EquipTool(tool)
                   tool:Activate()
                   for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                      anim:AdjustSpeed(5)
                   end
                end
            end)
            task.wait(0.05)
         end
      end)
   end,
})

-- ==========================================
-- GHOST KILL GLOBAL
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
                local myChar = lp.Character
                local punch = myChar:FindFirstChild("Punch") or lp.Backpack:FindFirstChild("Punch")
                
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                        myChar.Humanoid:EquipTool(punch)
                        punch:Activate()
                        local enemyRoot = v.Character.HumanoidRootPart
                        local oldCF = enemyRoot.CFrame
                        enemyRoot.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        task.wait(0.05)
                        enemyRoot.CFrame = oldCF
                    end
                end
            end)
            task.wait(0.5)
         end
      end)
   end,
})

-- ==========================================
-- AUTO REBIRTH
-- ==========================================
RebirthTab:CreateSection("Rebirth Automático")

RebirthTab:CreateInput({
   Name = "Meta de Rebirths",
   PlaceholderText = "Escribe número",
   Callback = function(Value)
      getgenv().targetRebirths = tonumber(Value) or 0
      rebirthesDone = 0
   end,
})

RebirthTab:CreateToggle({
   Name = "Activar Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            if getgenv().targetRebirths > 0 and rebirthesDone >= getgenv().targetRebirths then
                getgenv().autoRebirth = false
                break
            end
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end)
            rebirthesDone = rebirthesDone + 1
            task.wait(3)
         end
      end)
   end,
})
