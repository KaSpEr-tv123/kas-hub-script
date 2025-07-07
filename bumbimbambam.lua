-- Модуль Bumbimbambam для Kas Hub Script
-- Агрессивная атака: влет с большого расстояния на огромной скорости

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local bumbimbambamEnabled = false

-- Настройки
local SEARCH_RADIUS = 50 -- Радиус поиска цели (метров)
local TELEPORT_DISTANCE = 25 -- Дистанция телепорта от цели (метров)
local ATTACK_SPEED = 800 -- Скорость влёта в игрока
local ATTACK_FORCE = 500 -- Сила отбрасывания
local ATTACK_COOLDOWN = 0.7 -- Задержка между атаками
local DISABLE_COLLISION = true
local ENABLE_COLLISION_FOR_OTHERS = true

local function toggleBumbimbambam()
    bumbimbambamEnabled = not bumbimbambamEnabled
    print("Bumbimbambam:", bumbimbambamEnabled and "ВКЛЮЧЕН" or "ВЫКЛЮЧЕН")
    if bumbimbambamEnabled then
        startBumbimbambam()
        setupCollision()
    else
        stopBumbimbambam()
        resetCollision()
    end
end

local function setupCollision()
    if DISABLE_COLLISION then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
    if ENABLE_COLLISION_FOR_OTHERS then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
end

local function resetCollision()
    if DISABLE_COLLISION then
        for _, part in pairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
end

local function getClosestPlayer()
    local closestDist = math.huge
    local closestPlayer = nil
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (player.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
            if dist < closestDist and dist <= SEARCH_RADIUS then
                closestDist = dist
                closestPlayer = player
            end
        end
    end
    return closestPlayer
end

local function getRandomPointAround(pos, distance)
    local angle = math.random() * 2 * math.pi
    local dx = math.cos(angle) * distance
    local dz = math.sin(angle) * distance
    return pos + Vector3.new(dx, 0, dz)
end

local function attackTarget(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local targetRootPart = targetPlayer.Character.HumanoidRootPart
    local targetPos = targetRootPart.Position
    -- Выбираем случайную точку на TELEPORT_DISTANCE от цели
    local attackFrom = getRandomPointAround(targetPos, TELEPORT_DISTANCE)
    -- Телепортируемся в эту точку
    HumanoidRootPart.CFrame = CFrame.new(attackFrom + Vector3.new(0, 2, 0))
    -- Считаем направление
    local direction = (targetPos - HumanoidRootPart.Position).Unit
    -- Влетаем в цель
    HumanoidRootPart.Velocity = direction * ATTACK_SPEED
    -- Крутимся во время полёта
    for i = 1, 10 do
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
        RunService.Heartbeat:Wait()
    end
    -- Применяем отбрасывание к цели
    local knockback = Instance.new("BodyVelocity")
    knockback.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    knockback.Velocity = direction * ATTACK_FORCE + Vector3.new(0, 100, 0)
    knockback.Parent = targetRootPart
    Debris:AddItem(knockback, 0.5)
end

local function startBumbimbambam()
    local running = true
    spawn(function()
        while bumbimbambamEnabled and running do
            local target = getClosestPlayer()
            if target then
                attackTarget(target)
            else
                HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            end
            wait(ATTACK_COOLDOWN)
        end
    end)
end

local function stopBumbimbambam()
    HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
end

LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    Humanoid = Character:WaitForChild("Humanoid")
    if bumbimbambamEnabled then
        startBumbimbambam()
        setupCollision()
    end
end)

return {
    toggle = toggleBumbimbambam,
    enable = function()
        if not bumbimbambamEnabled then toggleBumbimbambam() end
    end,
    disable = function()
        if bumbimbambamEnabled then toggleBumbimbambam() end
    end,
    isEnabled = function() return bumbimbambamEnabled end
}