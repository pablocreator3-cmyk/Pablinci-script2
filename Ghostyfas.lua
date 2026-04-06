--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (EDICIÓN AZUL)
    ULTRA FIX: Auto Rebirth (Metodo de Limpieza de GUI)
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
-- SECCIÓN: FARM & COMBATE (Mantenidos)
-- ==========================================
FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "🔥 AUTO FAST WEIGHT",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastWeight = Value
      task.spawn(function()
         while getgenv().fastWeight do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local tool = char:FindFirstChild("Weight") or game.Players.LocalPlayer.Backpack:FindFirstChild("Weight")
                if tool then 
                   char.Humanoid:EquipTool(tool)
                   tool:Activate()
                end
            end)
            task.wait(0.001)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "🥊 AUTO FAST PUNCH",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastPunch = Value
      task.spawn(function()
         while getgenv().fastPunch do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local punch = char:FindFirstChild("Punch") or char.Parent.Backpack:FindFirstChild("Punch")
                if punch then
                   char.Humanoid:EquipTool(punch)
                   punch:Activate()
                end
            end)
            task.wait(0.001)
         end
      end)
   end,
})

CombatTab:CreateSection("Ghost Kill")
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
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        punch:Activate()
                    end
                end
            end)
            task.wait(0.3)
         end
      end)
   end,
})

-- ==========================================
-- SECCIÓN: REBIRTH (MÉTODO DE LIMPIEZA TOTAL)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth Force")

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

                -- PASO 1: Enviar Petición al Servidor
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                
                -- PASO 2: Forzar cierre de GUI por visibilidad y estado
                local playerGui = lp.PlayerGui
                local mainGui = playerGui:FindFirstChild("mainGui")
                if mainGui then
                    local rbWin = mainGui:FindFirstChild("rebirthWindow")
                    if rbWin then
                        -- Si la ventana es visible, la forzamos a cerrarse
                        if rbWin.Visible == true then
                            local confirmBtn = rbWin:FindFirstChild("confirmBtn")
                            if confirmBtn then
                                -- Disparar evento de clic directamente en la lógica del juego
                                firesignal(confirmBtn.MouseButton1Click)
                                firesignal(confirmBtn.Activated)
                            end
                            -- Forzar invisibilidad para limpiar la pantalla
                            rbWin.Visible = false
                        end
                    end
                end
            end)
            task.wait(0.5) -- Ciclo muy rápido
         end
      end)
   end,
})
