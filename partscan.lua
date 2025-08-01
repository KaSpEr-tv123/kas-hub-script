-- Модуль Scan для Kas Hub Script
-- Функция: сканирование игры и использование незакрепленных объектов для атаки

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Переменная для включения/выключения модуля
local scanEnabled = false

-- Настройки
local SCAN_RADIUS = 100 -- Радиус сканирования
local ATTACK_FORCE = 200 -- Сила атаки объектами
local OBJECT_SPEED = 150 -- Скорость полета объектов
local MAX_OBJECTS = 10 -- Максимальное количество объектов для атаки
local SCAN_INTERVAL = 0.5 -- Интервал сканирования в секундах

-- Таблица для хранения найденных объектов
local foundObjects = {}
local attackObjects = {}

local scanWindow = nil
local scanInfoLabel, scanTargetList

-- Функция обновления окна сканера
local function updateScanWindow()
    if not scanWindow or not scanWindow.content then return end
    if not scanInfoLabel or not scanTargetList then return end
    scanInfoLabel.Text = "Найдено объектов: " .. tostring(#foundObjects)
    -- Очищаем список целей
    for _, c in ipairs(scanTargetList:GetChildren()) do if c:IsA("TextLabel") then c:Destroy() end end
    local y = 0
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance <= SCAN_RADIUS then
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, -8, 0, 24)
                label.Position = UDim2.new(0, 4, 0, y)
                label.BackgroundTransparency = 1
                label.TextColor3 = Color3.fromRGB(255, 255, 255)
                label.Font = Enum.Font.Gotham
                label.TextSize = 14
                label.Text = player.Name .. " (" .. math.floor(distance) .. "м)"
                label.Parent = scanTargetList
                y = y + 26
            end
        end
    end
    scanTargetList.CanvasSize = UDim2.new(0, 0, 0, y)
end

-- Функция для создания окна сканера
local function createScanWindow(windowObj)
    local content = windowObj and windowObj.content
    if not content then return end
    for _, child in ipairs(content:GetChildren()) do child:Destroy() end
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundTransparency = 1
    header.Text = "PartScan: Информация"
    header.TextColor3 = Color3.fromRGB(220, 180, 255)
    header.Font = Enum.Font.GothamBold
    header.TextSize = 16
    header.Parent = content
    scanInfoLabel = Instance.new("TextLabel")
    scanInfoLabel.Size = UDim2.new(1, 0, 0, 28)
    scanInfoLabel.Position = UDim2.new(0, 0, 0, 36)
    scanInfoLabel.BackgroundTransparency = 1
    scanInfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanInfoLabel.Font = Enum.Font.Gotham
    scanInfoLabel.TextSize = 15
    scanInfoLabel.Text = "Найдено объектов: 0"
    scanInfoLabel.Parent = content
    scanTargetList = Instance.new("ScrollingFrame")
    scanTargetList.Size = UDim2.new(1, 0, 0, 120)
    scanTargetList.Position = UDim2.new(0, 0, 0, 70)
    scanTargetList.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
    scanTargetList.BorderSizePixel = 0
    scanTargetList.CanvasSize = UDim2.new(0, 0, 0, 0)
    scanTargetList.ScrollBarThickness = 6
    scanTargetList.Parent = content
    updateScanWindow()
end

-- Функция для включения/выключения модуля с окном
local function toggleScan(windowObj)
    scanEnabled = not scanEnabled
    print("Scan:", scanEnabled and "ВКЛЮЧЕН" or "ВЫКЛЮЧЕН")
    if scanEnabled then
        if windowObj then
            scanWindow = windowObj
            createScanWindow(scanWindow)
            scanWindow.open()
        end
        startScanning()
    else
        if scanWindow then scanWindow.close() end
        stopScanning()
    end
end

-- Функция для поиска незакрепленных объектов
local function findUnanchoredObjects()
    local objects = {}
    local playerPos = HumanoidRootPart.Position
    
    -- Сканируем workspace
    local function scanPart(part)
        if part:IsA("BasePart") and not part.Anchored then
            local distance = (part.Position - playerPos).Magnitude
            if distance <= SCAN_RADIUS then
                -- Проверяем, что объект не принадлежит игроку
                local isPlayerPart = false
                for _, player in pairs(Players:GetPlayers()) do
                    if player.Character and part:IsDescendantOf(player.Character) then
                        isPlayerPart = true
                        break
                    end
                end
                
                if not isPlayerPart then
                    table.insert(objects, part)
                end
            end
        end
        
        -- Рекурсивно сканируем дочерние объекты
        for _, child in pairs(part:GetChildren()) do
            scanPart(child)
        end
    end
    
    -- Сканируем workspace
    for _, item in pairs(workspace:GetChildren()) do
        scanPart(item)
    end
    
    return objects
end

-- Функция для атаки игрока объектом
local function attackPlayerWithObject(object, targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local targetRootPart = targetPlayer.Character.HumanoidRootPart
    local direction = (targetRootPart.Position - object.Position).Unit
    
    -- Создаем BodyVelocity для движения объекта
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = direction * OBJECT_SPEED
    bodyVelocity.Parent = object
    
    -- Создаем BodyGyro для стабилизации
    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
    bodyGyro.D = 1000
    bodyGyro.P = 2000
    bodyGyro.CFrame = CFrame.new()
    bodyGyro.Parent = object
    
    -- Удаляем объект через некоторое время
    Debris:AddItem(object, 3)
    
    -- Применяем урон к игроку при столкновении
    local connection
    connection = object.Touched:Connect(function(hit)
        if hit.Parent == targetPlayer.Character then
            -- Создаем BodyVelocity для отбрасывания игрока
            local knockback = Instance.new("BodyVelocity")
            knockback.MaxForce = Vector3.new(1e5, 1e5, 1e5)
            knockback.Velocity = direction * ATTACK_FORCE + Vector3.new(0, 50, 0)
            knockback.Parent = targetRootPart
            Debris:AddItem(knockback, 0.5)
            
            -- Удаляем объект
            object:Destroy()
            if connection then connection:Disconnect() end
        end
    end)
end

-- Функция для атаки всех ближайших игроков
local function attackNearbyPlayers()
    local nearbyPlayers = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance <= SCAN_RADIUS then
                table.insert(nearbyPlayers, player)
            end
        end
    end
    
    -- Атакуем каждого игрока объектами
    for i, player in pairs(nearbyPlayers) do
        if i <= MAX_OBJECTS and #foundObjects > 0 then
            local object = table.remove(foundObjects, 1)
            if object and object.Parent then
                attackPlayerWithObject(object, player)
            end
        end
    end
    updateScanWindow()
end

-- Основная функция сканирования
local function startScanning()
    local scanConnection
    local attackConnection
    
    scanConnection = RunService.Heartbeat:Connect(function()
        if not scanEnabled or not Character or not HumanoidRootPart then
            if scanConnection then scanConnection:Disconnect() end
            if attackConnection then attackConnection:Disconnect() end
            return
        end
        
        -- Сканируем каждые SCAN_INTERVAL секунд
        if tick() % SCAN_INTERVAL < RunService.Heartbeat:Wait() then
            foundObjects = findUnanchoredObjects()
            updateScanWindow()
        end
    end)
    
    -- Атакуем игроков каждые 2 секунды
    attackConnection = RunService.Heartbeat:Connect(function()
        if not scanEnabled or not Character or not HumanoidRootPart then
            if scanConnection then scanConnection:Disconnect() end
            if attackConnection then attackConnection:Disconnect() end
            return
        end
        
        if tick() % 2 < RunService.Heartbeat:Wait() then
            attackNearbyPlayers()
        end
    end)
end

-- Функция остановки
local function stopScanning()
    -- Очищаем все найденные объекты
    foundObjects = {}
    attackObjects = {}
end

-- Обработка пересоздания персонажа
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    
    if scanEnabled then
        startScanning()
    end
end)

-- Экспортируем функцию для внешнего вызова
return {
    toggle = toggleScan,
    enable = function(windowObj)
        if not scanEnabled then toggleScan(windowObj) end
    end,
    disable = function(windowObj)
        if scanEnabled then toggleScan(windowObj) end
    end,
    isEnabled = function() return scanEnabled end,
    getObjectCount = function() return #foundObjects end
}