--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Orion Lib (LA MEJOR PARA MÓVIL / DELTA)
    Color: Cyan & Black
]]

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Crear la Ventana (Se puede mover arrastrando el título)
local Window = OrionLib:MakeWindow({
    Name = "PABLO_DTH 🗿 | Muscle Legends", 
    HidePremium = false, 
    SaveConfig = false, 
    IntroText = "PABLO_DTH Hub v32",
    ConfigFolder = "OrionTest"
})

-- VARIABLES GLOBALES
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0

-- ==========================================
-- PESTAÑAS (TABS)
-- ==========================================
local FarmTab = Window:MakeTab({
	Name = "Farm",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local CombatTab = Window:MakeTab({
	Name = "Combate",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

local RebirthTab = Window:MakeTab({
	Name = "Rebirth",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

-- ==========================================
-- SECCIÓN DE FARM
-- ==========================================
FarmTab:AddSection({
	Name = "Entrenamiento Automático"
})

FarmTab:AddToggle({
	Name = "Auto Pesas (Fuerza)",
	Default = false,
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
                    local char = game.Players.LocalPlayer.Character
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    for _, anim in pairs(hum:GetPlayingAnimationTracks()) do
                        anim:AdjustSpeed(5)
                    end
                end)
                task.wait(0.1)
            end
        end)
	end    
})

-- ==========================================
-- SECCIÓN DE COMBATE
-- ==========================================
CombatTab:AddSection({
	Name = "Ghost Kill Global"
})

CombatTab:AddToggle({
	Name = "Matar a Todos (Global)",
	Default = false,
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
                            local enemyRoot = v.Character.HumanoidRootPart
                            local oldCF = enemyRoot.CFrame
                            enemyRoot.CFrame = lp.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
                            task.wait(0.05)
                            enemyRoot.CFrame = oldCF
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
	end    
})

-- ==========================================
-- SECCIÓN DE REBIRTH
-- ==========================================
RebirthTab:AddSection({
	Name = "Configuración de Rebirth"
})

RebirthTab:AddTextbox({
	Name = "Meta de Rebirths",
	Default = "0",
	TextDisappear = false,
	Callback = function(Value)
		getgenv().targetRebirths = tonumber(Value) or 0
	end	  
})

RebirthTab:AddToggle({
	Name = "Activar Auto Rebirth",
	Default = false,
	Callback = function(Value)
		getgenv().autoRebirth = Value
        task.spawn(function()
            while getgenv().autoRebirth do
                pcall(function()
                    local currentRebirths = game.Players.LocalPlayer.leaderstats.Rebirths.Value
                    if getgenv().targetRebirths > 0 and currentRebirths >= getgenv().targetRebirths then
                        getgenv().autoRebirth = false
                        OrionLib:MakeNotification({
                            Name = "Meta Alcanzada",
                            Content = "Has llegado a los " .. tostring(getgenv().targetRebirths) .. " rebirths.",
                            Image = "rbxassetid://4483345998",
                            Time = 5
                        })
                    else
                        game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                    end
                end)
                task.wait(2)
            end
        end)
	end    
})

-- Inicializar la librería (Esto hace que aparezca el botón para minimizar)
OrionLib:Init()
