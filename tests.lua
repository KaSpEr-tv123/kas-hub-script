local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local detectionRadius = 10 -- Радиус зоны поиска объектов вокруг игрока
local dodgeDistance = 5 -- Расстояние для уклонения

-- Функция для создания Region3 на основе позиции игрока
local function createRegion3(center, radius)
    local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2) -- Размер региона по всем осям
    local regionCorner1 = center - regionSize / 2 -- Нижний левый угол
    local regionCorner2 = center + regionSize / 2 -- Верхний правый угол
    return Region3.new(regionCorner1, regionCorner2)
end

-- Функция для уклонения от объектов в зоне Region3
local function dodgeNearbyObjects()
  while wait() do
    local character = Players.LocalPlayer.Character
    if not character then return end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local playerPosition = humanoidRootPart.Position
    local region = createRegion3(playerPosition, detectionRadius)

    -- Находим все объекты в зоне Region3
    local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)

    for _, part in pairs(partsInRegion) do
        -- Проверяем, является ли объект физическим объектом (BasePart) и не является частью игрока
        if part:IsA("BasePart") and part ~= humanoidRootPart then
            -- Рассчитываем направление для уклонения от объекта
            local dodgeDirection = (humanoidRootPart.Position - part.Position).unit * dodgeDistance

            -- Телепортируем игрока в сторону от объекта
            humanoidRootPart.CFrame = humanoidRootPart.CFrame + dodgeDirection
            print("Игрок уклонился от объекта: " .. part.Name)
        end
    end
  end
end

local function teleportPlayerToTarget()
  while wait() do
    local character = Players.LocalPlayer.Character
    if not character then return end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    for _, object in pairs(Workspace:GetChildren()) do
        if object.Name == "InvisibleCoinPileDungeon" then
            local targetObject = object:FindFirstChild("Coin")
            if targetObject then
                local distance = (humanoidRootPart.Position - targetObject.Position).Magnitude
                if distance <= 100 then
                    humanoidRootPart.CFrame = targetObject.CFrame
                end
            end
        end
    end
  end
end

local function start()
    spawn(dodgeNearbyObjects())
    spawn(teleportPlayerToTarget())
end

start()