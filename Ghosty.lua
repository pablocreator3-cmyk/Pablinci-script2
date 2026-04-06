--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL)
    ULTRA FIX: Auto Rebirth (Detección de Botón Real)
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
FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "🔥 AUTO FAST WEIGHT (Ultra)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastWeight = Value
      task.spawn(function()
         while getgenv().fastWeight do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char:FindFirstChild("Weight") or game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
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
                local char = game.Players.LocalPlayer.Character
                local punch = char:FindFirstChild("Punch") or game.Players.LocalPlayer.Backpack:FindFirstChild("Punch")
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
-- SECCIÓN: REBIRTH (MÉTODO DE CLIC REAL)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth (Bypass de Ventana)")

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
                local lp = game.Players.LocalPlayer
                local rebirths = lp.leaderstats.Rebirths.Value
                
                if getgenv().targetRebirths > 0 and rebirths >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                    return
                end

                -- 1. Enviar petición al servidor
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                
                -- 2. Forzar el cierre de la ventana de confirmación
                local playerGui = lp:WaitForChild("PlayerGui")
                local mainGui = playerGui:FindFirstChild("mainGui")
                if mainGui then
                    local rbWin = mainGui:FindFirstChild("rebirthWindow")
                    if rbWin and rbWin.Visible then
                        local btn = rbWin:FindFirstChild("confirmBtn")
                        if btn then
                            -- Usamos el simulador de clics de Delta para presionar el botón real
                            local vim = game:GetService("VirtualInputManager")
                            vim:SendMouseButtonEvent(btn.AbsolutePosition.X + (btn.AbsoluteSize.X / 2), btn.AbsolutePosition.Y + (btn.AbsoluteSize.Y / 2) + 50, 0, true, game, 1)
                            vim:SendMouseButtonEvent(btn.AbsolutePosition.X + (btn.AbsoluteSize.X / 2), btn.AbsolutePosition.Y + (btn.AbsoluteSize.Y / 2) + 50, 0, false, game, 1)
                            
                            -- Respaldo de clic por conexión de Lua
                            for _, v in pairs(getconnections(btn.MouseButton1Click)) do v:Fire() end
                            for _, v in pairs(getconnections(btn.Activated)) do v:Fire() end
                        end
                    end
                end
            end)
            task.wait(0.8) -- Ciclo rápido para no perder tiempo
         end
      end)
   end,
})
