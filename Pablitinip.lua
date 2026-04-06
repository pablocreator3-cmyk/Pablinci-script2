local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- CREACIÓN DE VENTANA
local Window = Rayfield:CreateWindow({
   Name = "PABLO_DTH 🗿 | Muscle Legends",
   LoadingTitle = "PABLO_DTH 🗿 Hub",
   LoadingSubtitle = "Ghost Kill Global Activado",
   ConfigurationSaving = { Enabled = false },
   Theme = "DarkRed" 
})

-- Variables Globales
getgenv().autoWeight = false
getgenv().fastPunchAnim = false
getgenv().ghostKillGlobal = false
getgenv().lockPos = false
getgenv().autoRebirth = false
getgenv().targetRebirths = 0
local rebirthesDone = 0
local lockedCFrame = nil

-- Función para obtener el Personaje
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
   Name = "Fast Punch (Con Animación)",
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
   Name = "LOCK POSITION (Ancla)",
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
-- PESTAÑA COMBATE (GHOST KILL GLOBAL)
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
                        if player ~= lp and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
                            local enemyRoot = player.Character.HumanoidRootPart
                            local enemyHum = player.Character.Humanoid

                            if enemyHum.Health > 0 then
                                -- Acción rápida
                                myChar.Humanoid:EquipTool(punch)
                                punch:Activate()

                                -- Traer al enemigo al frente, golpearlo y regresarlo
                                local oldCF = enemyRoot.CFrame
                                enemyRoot.CFrame = myRoot.CFrame * CFrame.new(0, 0, -3)
                                task.wait() -- Milisegundo para que el server registre el hit
                                enemyRoot.CFrame = oldCF
                            end
                        end
                    end
                end
            end)
            task.wait(0.1) -- Tiempo entre cada barrido de la sala
         end
      end)
   end,
})

-- ==========================================
-- PESTAÑA REBIRTH
-- ==========================================
RebirthTab:CreateSection("Configuración")

RebirthTab:CreateInput({
   Name = "Cantidad de Rebirths",
   PlaceholderText = "Ej: 10",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      getgenv().targetRebirths = tonumber(Text) or 0
      rebirthesDone = 0
      Rayfield:Notify({Title = "PABLO_DTH 🗿", Content = "Objetivo: " .. getgenv().targetRebirths, Duration = 3})
   end,
})

RebirthTab:CreateToggle({
   Name = "Auto Rebirth Activo",
   CurrentValue = false,
   Callback = function(Value)
      getgenv().autoRebirth = Value
      task.spawn(function()
         while getgenv().autoRebirth do
            if getgenv().targetRebirths > 0 and rebirthesDone >= getgenv().targetRebirths then
                getgenv().autoRebirth = false
                Rayfield:Notify({Title = "PABLO_DTH 🗿", Content = "¡Objetivo completado!", Duration = 5})
                break
            end
            game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            rebirthesDone = rebirthesDone + 1
            task.wait(1.5) 
         end
      end)
   end,
})

-- NOTIFICACIÓN FINAL
Rayfield:Notify({
   Title = "PABLO_DTH 🗿 Hub v20",
   Content = "Ghost Kill Global activado. Atacando a todos...",
   Duration = 5,
   Image = 4483345998,
})
