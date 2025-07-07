-- Модуль Bumbimbambam для Kas Hub Script
-- Функция: закручивание игрока для "разноса" других игроков

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

-- Переменная для включения/выключения модуля
local bumbimbambamEnabled = false

-- Настройки
local SPIN_SPEED = 200 -- Скорость вращения (увеличена для бешеной скорости)
local SPIN_RADIUS = 8 -- Радиус вращения вокруг других игроков
local KNOCKBACK_FORCE = 150 -- Сила отбрасывания
local KNOCKBACK_UPWARD_FORCE = 80 -- Сила подкидывания вверх
local ANTIFLING_PROTECTION = true -- Защита от флинга
local NOCLIP_ENABLED = true -- Включить ноклип

-- Функция для включения/выключения модуля
local function toggleBumbimbambam()
    bumbimbambamEnabled = not bumbimbambamEnabled
    print("Bumbimbambam:", bumbimbambamEnabled and "ВКЛЮЧЕН" or "ВЫКЛЮЧЕН")
    
    if bumbimbambamEnabled then
        startBumbimbambam()
        setupAntifling()
    else
        stopBumbimbambam()
    end
end

-- Функция для получения ближайших игроков
local function getNearbyPlayers()
    local nearbyPlayers = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if distance <= 20 then -- Радиус поиска игроков
                table.insert(nearbyPlayers, player)
            end
        end
    end
    return nearbyPlayers
end

-- Функция для применения силы к игроку
local function applyKnockback(player)
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    
    local targetRootPart = player.Character.HumanoidRootPart
    local direction = (targetRootPart.Position - HumanoidRootPart.Position).Unit
    
    -- Создаем BodyVelocity для отбрасывания
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    bodyVelocity.Velocity = direction * KNOCKBACK_FORCE + Vector3.new(0, KNOCKBACK_UPWARD_FORCE, 0)
    bodyVelocity.Parent = targetRootPart
    
    -- Удаляем BodyVelocity через некоторое время
    game:GetService("Debris"):AddItem(bodyVelocity, 0.5)
end

-- Функция для антифлинг защиты
local function setupAntifling()
    if not ANTIFLING_PROTECTION then return end
    
    -- Создаем невидимый щит для защиты от флинга
    local antiflingPart = Instance.new("Part")
    antiflingPart.Name = "AntiflingShield"
    antiflingPart.Transparency = 1
    antiflingPart.CanCollide = false
    antiflingPart.Anchored = true
    antiflingPart.Size = Vector3.new(1, 1, 1)
    antiflingPart.Parent = workspace
    
    local antiflingConnection
    antiflingConnection = RunService.Heartbeat:Connect(function()
        if not bumbimbambamEnabled or not Character or not HumanoidRootPart then
            if antiflingConnection then antiflingConnection:Disconnect() end
            antiflingPart:Destroy()
            return
        end
        
        -- Размещаем щит рядом с игроком для защиты
        antiflingPart.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, 0)
        
        -- Дополнительная защита через BodyVelocity
        local bodyVelocity = HumanoidRootPart:FindFirstChild("BodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end)
end

local function getClosestPlayerCFrame()
    local closestDist = math.huge
    local closestCFrame = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closestCFrame = player.Character.HumanoidRootPart.CFrame
            end
        end
    end
    return closestCFrame
end

-- Основная функция закручивания
local function startBumbimbambam()
    local connection
    local spinAngle = 0
    
    connection = RunService.Heartbeat:Connect(function()
        if not bumbimbambamEnabled or not Character or not HumanoidRootPart then
            if connection then connection:Disconnect() end
            return
        end

        -- Вращаемся на месте
        spinAngle = spinAngle + SPIN_SPEED * RunService.Heartbeat:Wait()
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SPIN_SPEED), 0)

        -- Находим ближайшего игрока
        local closestDist = math.huge
        local closestPos = nil
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local pos = player.Character.HumanoidRootPart.Position
                local dist = (pos - HumanoidRootPart.Position).Magnitude
                if dist < closestDist then
                    closestDist = dist
                    closestPos = pos
                end
            end
        end

        -- Если есть цель — двигаемся к ней
        if closestPos then
            local direction = (closestPos - HumanoidRootPart.Position).Unit
            local speed = 80 -- скорость влёта, можно менять
            HumanoidRootPart.Velocity = direction * speed
        else
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end)
end

-- Функция остановки
local function stopBumbimbambam()
    -- Останавливаем все анимации и эффекты
    if HumanoidRootPart then
        -- Сбрасываем BodyVelocity если есть
        local bodyVelocity = HumanoidRootPart:FindFirstChild("BodyVelocity")
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end

-- Обработка пересоздания персонажа
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    
    if bumbimbambamEnabled then
        startBumbimbambam()
        setupAntifling()
    end
end)

-- Создание щитка (один раз при включении)
local shield = Instance.new("Part")
shield.Size = Vector3.new(5, 5, 1)
shield.Transparency = 0.5
shield.Anchored = false
shield.CanCollide = true
shield.Massless = false
shield.Parent = workspace
shield.Name = "BumbimShield"

-- Weld к HumanoidRootPart
local weld = Instance.new("WeldConstraint")
weld.Part0 = HumanoidRootPart
weld.Part1 = shield
weld.Parent = shield

-- Позиция щитка (например, сбоку)
shield.Position = HumanoidRootPart.Position + Vector3.new(5, 0, 0)

local angle = 0
RunService.Heartbeat:Connect(function(dt)
    if not bumbimbambamEnabled then return end
    angle = angle + dt * 5 -- скорость вращения
    local offset = Vector3.new(math.cos(angle) * 5, 0, math.sin(angle) * 5)
    shield.Position = HumanoidRootPart.Position + offset
end)

-- Экспортируем функцию для внешнего вызова
return {
    toggle = toggleBumbimbambam,
    enable = function() 
        if not bumbimbambamEnabled then 
            toggleBumbimbambam() 
        end 
    end,
    disable = function() 
        if bumbimbambamEnabled then 
            toggleBumbimbambam() 
        end 
    end,
    isEnabled = function() return bumbimbambamEnabled end
}