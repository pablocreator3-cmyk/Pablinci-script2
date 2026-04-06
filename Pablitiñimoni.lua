--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL)
    FIX: Auto Rebirth (Triple Método) & Ghost Kill Devuelto
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
-- SECCIÓN: COMBATE (DEVUELTA)
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
                        -- Trae al enemigo hacia ti para golpearlo
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
-- SECCIÓN: REBIRTH (MÉTODO ULTRA AGRESIVO)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth (Multi-Método)")

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
                local stats = lp:WaitForChild("leaderstats", 5)
                if not stats then return end
                
                local rebirths = stats.Rebirths.Value
                if getgenv().targetRebirths > 0 and rebirths >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                    return
                end

                -- MÉTODO 1: Remote Event Directo
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")

                -- MÉTODO 2: Forzar Clic en Botón de la Ventana (Confirmar)
                local mainGui = lp.PlayerGui:FindFirstChild("mainGui")
                if mainGui then
                    local rebirthWin = mainGui:FindFirstChild("rebirthWindow")
                    if rebirthWin and rebirthWin.Visible then
                        local confirm = rebirthWin:FindFirstChild("confirmBtn")
                        if confirm then
                            -- Simulación de clic real para bypass
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new(999, 999)) -- Intento genérico
                            confirm.Visible = true
                            -- Disparar todos los eventos del botón
                            for _, v in pairs(getconnections(confirm.MouseButton1Click)) do v:Fire() end
                            for _, v in pairs(getconnections(confirm.Activated)) do v:Fire() end
                        end
                    end
                end
                
                -- MÉTODO 3: Atajo de Teclado (Si el juego lo permite)
                game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.R, false, game)
            end)
            task.wait(1) -- Más rápido para no perder el ciclo de fuerza
         end
      end)
   end,
})
