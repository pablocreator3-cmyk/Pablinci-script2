--[[
    pablo_DTH Hub - Muscle Legends
    Interfaz: Rojo y Negro
    Funciones: Auto-Equip, Auto-Farm, Auto-Click
]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "pablo_DTH Hub | Muscle Legends",
   LoadingTitle = "Iniciando Sistema...",
   LoadingSubtitle = "por pablo_DTH",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "pablo_DTH_Configs"
   },
   Theme = "DarkRed" -- Tema Rojo y Negro
})

-- Variables Globales
getgenv().autoWeight = false
getgenv().autoPunch = false

-- Pestaña de Entrenamiento
local FarmTab = Window:CreateTab("🏋️ Farm", 4483345998)

FarmTab:CreateSection("Entrenamiento Principal")

-- Toggle Pesas
FarmTab:CreateToggle({
   Name = "Auto Pesas (Equip + Click)",
   CurrentValue = false,
   Flag = "PesaToggle",
   Callback = function(Value)
      getgenv().autoWeight = Value
      if Value then
         task.spawn(function()
            while getgenv().autoWeight do
               local char = game.Players.LocalPlayer.Character
               local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Weight") or char:FindFirstChild("Weight")
               
               if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
               end
               task.wait(0.01)
            end
         end)
      end
   end,
})

-- Toggle Puños
FarmTab:CreateToggle({
   Name = "Auto Puños (Equip + Click)",
   CurrentValue = false,
   Flag = "PunoToggle",
   Callback = function(Value)
      getgenv().autoPunch = Value
      if Value then
         task.spawn(function()
            while getgenv().autoPunch do
               local char = game.Players.LocalPlayer.Character
               local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Punch") or char:FindFirstChild("Punch")
               
               if tool then
                  char.Humanoid:EquipTool(tool)
                  tool:Activate()
               end
               task.wait(0.01)
            end
         end)
      end
   end,
})

-- Pestaña de Ajustes Personaje
local MiscTab = Window:CreateTab("⚙️ Ajustes", 4483345998)

MiscTab:CreateSlider({
   Name = "Velocidad (WalkSpeed)",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WS_Slider",
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Notificación Final
Rayfield:Notify({
   Title = "pablo_DTH Hub",
   Content = "Script cargado con éxito. ¡A entrenar!",
   Duration = 6.5,
   Image = 4483345998,
})
