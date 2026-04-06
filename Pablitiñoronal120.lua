--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL)
    FIX: Auto Rebirth con Confirmación Automática
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
            task.wait(0.001)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "🥊 AUTO FAST PUNCH (X10)",
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
                   for _, track in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                       track:AdjustSpeed(10) 
                   end
                end
            end)
            task.wait(0.001)
         end
      end)
   end,
})

-- ==========================================
-- SECCIÓN: REBIRTH (CORREGIDO)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth Fix")

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
                local player = game.Players.LocalPlayer
                local rebirths = player.leaderstats.Rebirths.Value
                
                -- Verificar meta
                if getgenv().targetRebirths > 0 and rebirths >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                    return
                end

                -- 1. Intentar por Remote Event
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                
                -- 2. Intentar forzar el clic en el botón de Confirmar (Bypass de GUI)
                local mainGui = player.PlayerGui:FindFirstChild("mainGui")
                if mainGui then
                    local rebirthWindow = mainGui:FindFirstChild("rebirthWindow")
                    if rebirthWindow and rebirthWindow.Visible then
                        -- Forzamos la visibilidad y el clic en el botón Confirmar
                        local confirmBtn = rebirthWindow:FindFirstChild("confirmBtn")
                        if confirmBtn then
                            -- Usamos una función de Roblox para simular el clic en el botón
                            for _, connection in pairs(getconnections(confirmBtn.MouseButton1Click)) do
                                connection:Fire()
                            end
                        end
                    end
                end
            end)
            task.wait(1.5) -- Tiempo de espera para que no se trabe la GUI
         end
      end)
   end,
})
