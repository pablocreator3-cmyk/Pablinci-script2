--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (Optimizado para Mobile/Delta)
    Color: Blue (Azul)
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH Hub v32",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "Blue", -- Cambio de color a Azul
   KeybindSource = "RightControl" 
})

-- VARIABLES GLOBALES
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- SECCIÓN: ENTRENAMIENTO
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

-- SECCIÓN: COMBATE
CombatTab:CreateSection("Ghost Kill Global")

CombatTab:CreateToggle({
   Name = "Matar a Todos (Global)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ghostKillGlobal = Value
      task.spawn(function()
         while getgenv().ghostKillGlobal do
            pcall(function()
                local lp = game.Players.
