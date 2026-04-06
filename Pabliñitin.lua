local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- VENTANA PRINCIPAL
local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH 🗿 Hub v22",
   LoadingSubtitle = "Cargando Sistemas de Combate y Farm...",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- VARIABLES GLOBALES
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
FarmTab:CreateSection("Entrenamiento Automático")

FarmTab:CreateToggle({
   Name = "Auto Pesas (Fuerza)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoWeight = Value
      task.spawn(function()
         while getgenv().autoWeight do
            local char = getChar()
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or char:FindFirstChild("Weight")
            if tool then 
               char.Humanoid:EquipTool(tool)
               tool:Activate() 
            end
            task.wait(0.1)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "Fast Punch (Con Animación x5)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().fastPunchAnim = Value
      task.spawn(function()
         while getgenv().fastPunchAnim do
            local char = getChar()
            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
            if tool then
               char.Humanoid:EquipTool(tool)
               tool:Activate()
               pcall(function()
                  for _, anim in pairs(char.Humanoid:GetPlayingAnimationTracks()) do
                     anim:AdjustSpeed(5)
                  end
               end)
            end
            task.wait(0.05)
         end
      end)
   end,
})

FarmTab:CreateToggle({
   Name = "Anclar Posición (Lock Pos)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().lockPos = Value
      if Value then
         local char = getChar()
         lockedCFrame = char.HumanoidRootPart.CFrame
         task.spawn(function()
            while getgenv().lockPos do
               local char = getChar()
               if char:FindFirstChild("HumanoidRootPart") then
                  char.HumanoidRootPart.CFrame = lockedCFrame
               end
               task.wait()
            end
         end)
      end
   end,
})

-- ==========================================
-- PESTAÑA COMBATE (GLOBAL)
-- ==========================================
CombatTab:CreateSection("Asesino Fantasma")

CombatTab:CreateToggle({
   Name = "Ghost Kill (Toda la Sala)",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().ghostKillGlobal = Value
      task.spawn(function()
         while getgenv().ghostKillGlobal do
            pcall(function()
                local lp = game.Players.LocalPlayer
                local myChar = getChar()
                local myRoot = myChar:FindFirstChild("HumanoidRootPart")
                local punch = lp.Backpack:FindFirstChild("Punch") or myChar:FindFirstChild("Punch")

                if punch and myRoot then
                    for _, player in pairs(game.Players:GetPlayers()) do
                        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local enemyRoot = player.Character.HumanoidRootPart
                            if player.Character.Humanoid.Health > 0 then
                                myChar.Humanoid:EquipTool(punch)
                                punch:Activate()
                                
                                local oldCF = enemyRoot.CFrame
                                enemyRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
                                task.wait() 
                                enemyRoot.CFrame = oldCF
                            end
                        end
                    end
                end
            end)
            task.wait(0.1)
         end
      end)
   end,
})

-- ==========================================
-- PESTAÑA REBIRTH (SISTEMA TRIPLE FIX)
-- ==========================================
RebirthTab:CreateSection("Auto Rebirth")

RebirthTab:CreateInput({
   Name = "Meta de Rebirths",
   PlaceholderText = "Escribe un número (0 = Infinito)",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().targetRebirths = tonumber(Text) or 0
      rebirthesDone = 0
      Rayfield:Notify({Title = "PABLO_DTH 🗿", Content = "Meta fijada en: " .. getgenv().targetRebirths, Duration = 3})
   end,
})

RebirthTab:CreateToggle({
   Name = "Activar Auto Rebirth",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            -- Chequeo de Meta
            if getgenv().targetRebirths > 0 and rebirthesDone >= getgenv().targetRebirths then
                getgenv().autoRebirth = false
                Rayfield:Notify({Title = "PABLO_DTH 🗿", Content = "¡Meta alcanzada!", Duration = 5})
                break
            end

            -- INTENTOS DE REBIRTH (SISTEMA TRIPLE)
