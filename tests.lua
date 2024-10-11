local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local detectionRadius = 10 -- Радиус обнаружения объектов
local dodgeDistance = 2 -- Уменьшили расстояние для уклонения
local ignoredObjects = {
    "Floor",
    "Baseplate",
    -- Можно добавить сюда любые объекты, которые не должны считаться пулями
}

local function isBullet(part)
    -- Проверка по имени объекта
    if part.Name == "EnemyProjectileBomb" then
        return true
    end
    for _, ignoredName in ipairs(ignoredObjects) do
        if part.Name == ignoredName then
            return false
        end
    end
    return true -- Возвращаем true, если объект не в списке игнорируемых
end

local function createRegion3(center, radius, height)
    local regionSize = Vector3.new(radius * 2, height, radius * 2)
    local regionCorner1 = center - regionSize / 2
    local regionCorner2 = center + regionSize / 2
    return Region3.new(regionCorner1, regionCorner2)
end

local function dodgeNearbyObjects()
    while wait(0.1) do -- Увеличиваем время ожидания для снижения частоты проверки
        local character = Players.LocalPlayer.Character
        if not character then return end

        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        if not humanoidRootPart then return end

        local playerPosition = humanoidRootPart.Position
        local heightAboveGround = humanoidRootPart.Size.Y / 2 -- Высота ног игрока

        -- Создаем область с учетом высоты ног
        local region = createRegion3(playerPosition, detectionRadius, heightAboveGround)

        local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)

        for _, part in pairs(partsInRegion) do
            if part ~= humanoidRootPart and isBullet(part) then
                local dodgeDirection = (humanoidRootPart.Position - part.Position).unit * dodgeDistance
                -- Проверка, чтобы избежать перемещения за пределы карты
                local newPosition = humanoidRootPart.Position + dodgeDirection
                if newPosition.Y > 0 and newPosition.Y < 1000 then -- Предположим, что карта высотой до 1000
                    humanoidRootPart.Position = newPosition
                else
                    print("Попытка уклониться заблокирована: выход за пределы карты")
                end
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
                local targetObject = object:FindFirstChild("Coin") -- Убедитесь, что имя совпадает с регистром
                if targetObject then
                    local distance = (humanoidRootPart.Position - targetObject.Position).Magnitude
                    -- Проверяем, не является ли целевой объект полом
                    if distance <= 100 and isBullet(targetObject) then
                        humanoidRootPart.Position = targetObject.Position + Vector3.new(0, humanoidRootPart.Size.Y / 2, 0) -- Устанавливаем на высоту ног
                    end
                end
            end
        end
    end
end

local function start()
    -- Запускаем функции уклонения и телепортации параллельно
    spawn(dodgeNearbyObjects) -- Используем без скобок
    spawn(teleportPlayerToTarget) -- Используем без скобок
end

start()