-- PABLO_DTH 🗿 Hub v23 - Optimizado para Delta
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

-- VENTANA PRINCIPAL
local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH 🗿 Hub v23",
   LoadingSubtitle = "Optimizado para Delta Executor",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- VARIABLES
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().lockPos = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0
local lockedCFrame = nil

-- FUNCIÓN PERSONAJE SEGURO
local function getChar()
    return game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
end

-- TABS
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)
local CombatTab = Window:CreateTab("⚔️ Combate", 4483345998)
local RebirthTab = Window:CreateTab("♻️ Rebirth", 4483345998)

-- ==========================================
-- PESTAÑA FARM
-- ==========================================
FarmTab:CreateSection("Entrenamiento")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Fuerza)",
   CurrentValue = false,
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
            task.wait(0.2) -- Delay más seguro para Delta
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
   end,
})

FarmTab:CreateToggle({
   Name = "Lock Pos (Ancla)",
   CurrentValue = false,
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
   end,
})

-- ==========================================
-- PESTAÑA COMBATE (GHOST KILL GLOBAL)
-- ==========================================
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
   end,
})

-- ==========================================
-- PESTAÑA REBIRTH (SISTEMA ALTERNATIVO)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth")

RebirthTab:CreateInput({
   Name = "Cantidad deseada",
   PlaceholderText = "Escribe aquí",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().targetRebirths = tonumber(Text) or 0
      rebirthesDone = 0
   end,
})

RebirthTab:CreateToggle({
   Name = "Activar Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            if getgenv().targetRebirths > 0 and rebirthesDone >= getgenv().targetRebirths then
                getgenv().autoRebirth = false
                break
            end
            
            -- Intentamos disparar el evento directamente
            pcall(function()
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end)
            
            rebirthesDone = rebirthesDone + 1
            task.wait(3) -- Delay más largo para evitar que Delta se cierre
         end
      end)
   end,
})

Rayfield:Notify({
   Title = "PABLO_DTH 🗿 Hub",
   Content = "¡Ejecutado con éxito!",
   Duration = 5
})
