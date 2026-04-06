--[[
    PABLO_DTH 🗿 Hub v31 | Muscle Legends
    Librería: Kavo UI (Optimización Extrema para Delta)
    Tema: BloodTheme (Rojo y Negro)
    Estado: GitHub Ready / Anti-Crash
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("PABLO_DTH 🗿 Hub | Muscle Legends", "BloodTheme")

-- --- VARIABLES GLOBALES ---
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().lockPos = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0
local lockedCFrame = nil

-- --- FUNCIÓN PERSONAJE SEGURO ---
local function getChar()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- --- PESTAÑAS (TABS) ---
local FarmTab = Window:NewTab("🏋️ Farm")
local CombatTab = Window:NewTab("⚔️ Combate")
local RebirthTab = Window:NewTab("♻️ Rebirth")

-- ==========================================
-- SECCIÓN DE FARM
-- ==========================================
local FarmSection = FarmTab:NewSection("Entrenamiento Automático")

FarmSection:NewToggle("Auto Pesas (Fuerza)", "Levanta pesas automáticamente", function(state)
    getgenv().autoWeight = state
    task.spawn(function()
        while getgenv().autoWeight do
            pcall(function()
                local char = getChar()
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or char:FindFirstChild("Weight")
                if tool then 
                   char.Humanoid:EquipTool(tool)
                   tool:Activate() 
                end
            end)
            task.wait(0.2)
        end
    end)
end)

FarmSection:NewToggle("Fast Punch (Animación x5)", "Golpea rápido con animación acelerada", function(state)
    getgenv().fastPunchAnim = state
    task.spawn(function()
        while getgenv().fastPunchAnim do
            pcall(function()
                local char = getChar()
                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
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
end)

FarmSection:NewToggle("Anclar Posición (Lock Pos)", "Evita que te muevan o empujen", function(state)
    getgenv().lockPos = state
    if state then
        local char = getChar()
        lockedCFrame = char.HumanoidRootPart.CFrame
        task.spawn(function()
            while getgenv().lockPos do
                pcall(function()
                    getChar().HumanoidRootPart.CFrame = lockedCFrame
                end)
                task.wait()
            end
        end)
    end
end)

-- ==========================================
-- SECCIÓN DE COMBATE (GHOST KILL GLOBAL)
-- ==========================================
local CombatSection = CombatTab:NewSection("Asesino Fantasma")

CombatSection:NewToggle("Ghost Kill Global", "Ataca a todos los jugadores del mapa", function(state)
    getgenv().ghostKillGlobal = state
    task.spawn(function()
        while getgenv().ghostKillGlobal do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local myChar = getChar()
                local punch = lp.Backpack:FindFirstChild("Punch") or myChar:FindFirstChild("Punch")
                
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                        myChar.Humanoid:EquipTool(punch)
                        punch:Activate()
                        local enemyRoot = v.Character.HumanoidRootPart
                        local oldCF = enemyRoot.CFrame
                        -- TP temporal al frente para registrar el hit
                        enemyRoot.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                        task.wait(0.05)
                        enemyRoot.CFrame = oldCF
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- ==========================================
-- SECCIÓN DE REBIRTH
-- ==========================================
local RebirthSection = RebirthTab:NewSection("Gestión de Rebirths")

RebirthSection:NewTextBox("Meta de Rebirths", "Pon el número de rebirths", function(txt)
    getgenv().targetRebirths = tonumber(txt) or 0
    rebirthesDone = 0
end)

RebirthSection:NewToggle("Activar Auto Rebirth", "Hace rebirth solo al tener fuerza", function(state)
    getgenv().autoRebirth = state
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
end)

-- --- SECCIÓN DE INFO ---
local InfoSection = Window:NewTab("Info"):NewSection("Creado por PABLO_DTH 🗿")
