-- Модуль Bumbimbambam для Kas Hub Script
-- Агрессивная атака: кручение и влет строго в игрока с отключённой коллизией

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local bumbimbambamEnabled = false

-- Настройки
local SEARCH_RADIUS = 60 -- Радиус поиска цели (метров)
local TELEPORT_DISTANCE = 25 -- Дистанция телепорта от цели (метров)
local ATTACK_SPEED = 900 -- Скорость влёта в игрока
local ATTACK_FORCE = 600 -- Сила отбрасывания
local ATTACK_COOLDOWN = 0.7 -- Задержка между атаками
local SPIN_TIME = 0.4 -- Время кручения перед атакой (сек)
local SPIN_SPEED = 1800 -- Скорость вращения (градусов/сек)

local function setLocalCollision(state)
    for _, part in pairs(Character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = state
        end
    end
end

local function toggleBumbimbambam()
    bumbimbambamEnabled = not bumbimbambamEnabled
    print("Bumbimbambam:", bumbimbambamEnabled and "ВКЛЮЧЕН" or "ВЫКЛЮЧЕН")
    if bumbimbambamEnabled then
        setLocalCollision(false)
        startBumbimbambam()
    else
        stopBumbimbambam()
        setLocalCollision(true)
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

local function getAttackPoint(targetPos)
    -- Телепорт на TELEPORT_DISTANCE от цели, на том же уровне Y
    local angle = math.random() * 2 * math.pi
    local dx = math.cos(angle) * TELEPORT_DISTANCE
    local dz = math.sin(angle) * TELEPORT_DISTANCE
    return Vector3.new(targetPos.X + dx, targetPos.Y + 2, targetPos.Z + dz)
end

local function spinAnimation(duration, speed)
    local startTime = tick()
    while tick() - startTime < duration do
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(speed * RunService.Heartbeat:Wait()), 0)
    end
end

local function attackTarget(targetPlayer)
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local targetRootPart = targetPlayer.Character.HumanoidRootPart
    local targetPos = targetRootPart.Position
    -- 1. Телепорт на 25м от цели, на том же уровне
    local attackFrom = getAttackPoint(targetPos)
    HumanoidRootPart.CFrame = CFrame.new(attackFrom)
    -- 2. Краткая раскрутка
    spinAnimation(SPIN_TIME, SPIN_SPEED)
    -- 3. Влет строго в HumanoidRootPart цели
    local direction = (targetPos - HumanoidRootPart.Position).Unit
    HumanoidRootPart.Velocity = direction * ATTACK_SPEED
    -- 4. Кручение во время полёта
    for i = 1, 10 do
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
        RunService.Heartbeat:Wait()
    end
    -- 5. Применяем отбрасывание к цели
    local knockback = Instance.new("BodyVelocity")
    knockback.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    knockback.Velocity = direction * ATTACK_FORCE + Vector3.new(0, 100, 0)
    knockback.Parent = targetRootPart
    Debris:AddItem(knockback, 0.5)
end

local function startBumbimbambam()
    spawn(function()
        while bumbimbambamEnabled do
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
        setLocalCollision(false)
        startBumbimbambam()
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