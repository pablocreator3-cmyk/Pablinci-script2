--[[
    PABLO_DTH 🗿 Hub v32 | Muscle Legends
    Librería: Rayfield (Azul)
    ESTADO: Rebirth & Lock Position ACTIVOS
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH Hub v32",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = { Enabled = false },
   Theme = "Ocean", 
   KeybindSource = "RightControl" 
})

-- VARIABLES
getgenv().fastWeight = false
getgenv().fastPunch = false
getgenv().ghostKillGlobal = false
getgenv().autoRebirth = false
getgenv().lockPos = false
getgenv().targetRebirths = 0
local lockedCFrame = nil

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm")
local CombatTab = Window:CreateTab("⚔️ Combate")
local RebirthTab = Window:CreateTab("♻️ Rebirth")
local MiscTab = Window:CreateTab("📍 Misc")

-- FARM
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
                if tool then char.Humanoid:EquipTool(tool) tool:Activate() end
            end)
            task.wait(0.001)
         end
      end)
   end,
})

-- COMBATE
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

-- REBIRTH (MÉTODO REFORZADO)
RebirthTab:CreateInput({
   Name = "Meta de Rebirths",
   PlaceholderText = "Escribe número",
   Callback = function(Value) getgenv().targetRebirths = tonumber(Value) or 0 end,
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
                if lp.leaderstats.Rebirths.Value < (getgenv().targetRebirths > 0 and getgenv().targetRebirths or 9e9) then
                    -- Intento de Rebirth
                    game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
                    
                    -- Detección y Clic Forzado en GUI
                    local mainGui = lp.PlayerGui:FindFirstChild("mainGui")
                    local rbWin = mainGui and mainGui:FindFirstChild("rebirthWindow")
                    if rbWin and rbWin.Visible then
                        local btn = rbWin:FindFirstChild("confirmBtn")
                        if btn then
                            firesignal(btn.MouseButton1Click)
                            rbWin.Visible = false
                        end
                    end
                else
                    getgenv().autoRebirth = false
                end
            end)
            task.wait(0.5)
         end
      end)
   end,
})

-- MISC (LOCK POSITION)
MiscTab:CreateToggle({
   Name = "📍 Lock Position",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().lockPos = Value
      if Value then
          lockedCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
      end
      task.spawn(function()
         while getgenv().lockPos do
            pcall(function()
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = lockedCFrame
                game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
            end)
            task.wait()
         end
      end)
   end,
})
