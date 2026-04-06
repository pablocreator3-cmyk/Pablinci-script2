--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Kavo UI (Adaptación Visual Estilo SuperNova)
    Color: Dark & Cyan (Personalizado)
]]

-- Cargar la librería Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Definir colores personalizados para que coincidan con la imagen (Negro, Gris, Cian)
local colors = {
    SchemeColor = Color3.fromRGB(0, 255, 255), -- Cian/Neón para acentos
    Background = Color3.fromRGB(15, 15, 15),    -- Fondo oscuro casi negro
    Header = Color3.fromRGB(25, 25, 25),        -- Encabezado oscuro
    TextColor = Color3.fromRGB(255, 255, 255),  -- Texto blanco
    ElementColor = Color3.fromRGB(20, 20, 20)  -- Color de botones/toggles
}

-- Crear la Ventana (Estilo similar con barra superior)
local Window = Library.CreateLib("PABLO_DTH 🗿 | Muscle Legends", colors)

-- VARIABLES GLOBALES (Mismas funciones)
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0

-- ==========================================
-- PESTAÑAS (TABS) - Estilo Horizontal Superior
-- ==========================================
local FarmTab = Window:NewTab("Farm")
local CombatTab = Window:NewTab("Combate")
local RebirthTab = Window:NewTab("Rebirth")
-- Agregué estas vacías para imitar visualmente la cantidad de pestañas de la imagen
local CreditsTab = Window:NewTab("Creditos")

-- ==========================================
-- SECCIONES Y ELEMENTOS DE FARM
-- ==========================================
local FarmSection = FarmTab:NewSection("Entrenamiento Automático")

FarmSection:NewToggle("Auto Pesas (Fuerza)", "Entrena fuerza automáticamente", function(Value)
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
end)

FarmSection:NewToggle("Fast Punch (Animación x5)", "Acelera la animación de golpe", function(Value)
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
end)

-- ==========================================
-- SECCIONES Y ELEMENTOS DE COMBATE
-- ==========================================
local CombatSection = CombatTab:NewSection("Ghost Kill Global")

CombatSection:NewToggle("Matar a Todos (Global)", "Teletransporta enemigos y los golpea", function(Value)
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
                        task.wait(0.03)
                        enemyRoot.CFrame = oldCF
                    end
                end
            end)
            task.wait(0.3)
         end
      end)
end)

-- ==========================================
-- SECCIONES Y ELEMENTOS DE REBIRTH
-- ==========================================
local RebirthSection = RebirthTab:NewSection("Rebirth Automático")

RebirthSection:NewTextBox("Meta de Rebirths", "Escribe el número de Rebirths deseado", function(Value)
    getgenv().targetRebirths = tonumber(Value) or 0
end)

RebirthSection:NewToggle("Activar Auto Rebirth", "Hace rebirth automáticamente al llegar a la meta", function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            pcall(function()
                local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                if getgenv().targetRebirths > 0 and currentRebirths >= getgenv().targetRebirths then
                    getgenv().autoRebirth = false
                    -- Nota: Kavo no tiene notificaciones nativas como Rayfield, se desactiva el toggle simplemente.
                else
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                end
            end)
            task.wait(2)
         end
      end)
end)

-- SECCIÓN DE CRÉDITOS (Para imitar el diseño de la imagen)
CreditsTab:NewSection("Script por: pablo_DTH")
CreditsTab:NewSection("Interfaz: Kavo UI Adaptada")
