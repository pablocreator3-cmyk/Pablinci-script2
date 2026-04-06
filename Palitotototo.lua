--[[
    PABLO_DTH 🗿 Hub v28 | Muscle Legends
    Librería: Orion (La más estable para Delta + GitHub)
    Tema: DarkRed (Rojo y Negro)
]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- CREACIÓN DE VENTANA
local Window = OrionLib:MakeWindow({
    Name = "PABLO_DTH 🗿 | Muscle Legends", 
    HidePremium = false, 
    SaveConfig = false, 
    IntroText = "PABLO_DTH Hub v28",
    Theme = "DarkRed"
})

-- --- VARIABLES ---
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().lockPos = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0
local lockedCFrame = nil

-- --- FUNCIÓN PERSONAJE ---
local function getChar()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- --- PESTAÑAS ---
local FarmTab = Window:MakeTab({ Name = "🏋️ Farm", Icon = "rbxassetid://4483345998" })
local CombatTab = Window:MakeTab({ Name = "⚔️ Combate", Icon = "rbxassetid://4483345998" })
local RebirthTab = Window:MakeTab({ Name = "♻️ Rebirth", Icon = "rbxassetid://4483345998" })

-- ==========================================
-- PESTAÑA FARM
-- ==========================================
FarmTab:AddToggle({
    Name = "Auto Pesas (Fuerza)",
    Default = false,
    Callback = function(Value)
        getgenv().autoWeight = Value
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
    end    
})

FarmTab:AddToggle({
    Name = "Fast Punch (Animación x5)",
    Default = false,
    Callback = function(Value)
        getgenv().fastPunchAnim = Value
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
    end    
})

FarmTab:AddToggle({
    Name = "Lock Pos (Ancla)",
    Default = false,
    Callback = function(Value)
        getgenv().lockPos = Value
        if Value then
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
    end    
})

-- ==========================================
-- PESTAÑA COMBATE (GHOST KILL GLOBAL)
-- ==========================================
CombatTab:AddToggle({
    Name = "Ghost Kill Global (Toda la Sala)",
    Default = false,
    Callback = function(Value)
        getgenv().ghostKillGlobal = Value
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
                            enemyRoot.CFrame = myChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                            task.wait(0.05)
                            enemyRoot.CFrame = oldCF
                        end
                    end
                end)
                task.wait(0.5)
            end
        end)
    end    
})

-- ==========================================
-- PESTAÑA REBIRTH (FIXED)
-- ==========================================
RebirthTab:AddTextbox({
    Name = "Meta de Rebirths",
    Default = "0",
    TextDisappear = false,
    Callback = function(Value)
        getgenv().targetRebirths = tonumber(Value) or 0
        rebirthesDone = 0
    end	  
})

RebirthTab:AddToggle({
    Name = "Activar Auto Rebirth",
    Default = false,
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
                task.wait(2.5)
            end
        end)
    end    
})

-- INICIALIZAR LIBRERÍA
OrionLib:Init()
