-- local Players = game:GetService("Players")
-- local Workspace = game:GetService("Workspace")
-- local RunService = game:GetService("RunService")
-- 
-- local detectionRadius = 10 -- Радиус обнаружения объектов
-- local dodgeDistance = 2 -- Расстояние уклонения
-- 
-- local ignoredObjects = {
--     "Floor",
--     "Baseplate",
-- }
-- 
-- local function isBullet(part)
--     -- Проверка по имени объекта
--     if part.Name == "EnemyProjectileBomb" then
--         return true
--     end
--     for _, ignoredName in ipairs(ignoredObjects) do
--         if part.Name == ignoredName then
--             return false
--         end
--     end
--     return false -- Возвращаем false, если объект не является пулей
-- end
-- 
-- local function createRegion3(center, radius, height)
--     local regionSize = Vector3.new(radius * 2, height, radius * 2)
--     local regionCorner1 = center - regionSize / 2
--     local regionCorner2 = center + regionSize / 2
--     return Region3.new(regionCorner1, regionCorner2)
-- end
-- 
-- local function dodgeNearbyObjects()
--     while wait(0.1) do
--         local character = Players.LocalPlayer.Character
--         if not character then return end
-- 
--         local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
--         if not humanoidRootPart then return end
-- 
--         local playerPosition = humanoidRootPart.Position
--         local heightAboveGround = humanoidRootPart.Size.Y / 2
-- 
--         -- Создаем область с учетом высоты ног
--         local region = createRegion3(playerPosition, detectionRadius, heightAboveGround)
-- 
--         local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)
-- 
--         for _, part in pairs(partsInRegion) do
--             if part ~= humanoidRootPart and isBullet(part) then
--                 local dodgeDirection = (humanoidRootPart.Position - part.Position).unit * dodgeDistance
--                 -- Проверка нового положения
--                 local newPosition = humanoidRootPart.Position + dodgeDirection
--                 
--                 -- Ограничиваем перемещение по Y, чтобы не уходить за пределы карты
--                 if newPosition.Y > 0 and newPosition.Y < 1000 then -- Предположим, что карта высотой до 1000
--                     humanoidRootPart.Position = newPosition
--                 else
--                     print("Попытка уклониться заблокирована: выход за пределы карты")
--                 end
--                 print("Игрок уклонился от объекта: " .. part.Name)
--             end
--         end
--     end
-- end
-- 
-- local function teleportPlayerToTarget()
--     while wait() do
--         local character = Players.LocalPlayer.Character
--         if not character then return end
-- 
--         local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
--         if not humanoidRootPart then return end
-- 
--         for _, object in pairs(Workspace:GetChildren()) do
--             if object.Name == "InvisibleCoinPileDungeon" then
--                 local targetObject = object:FindFirstChild("Coin")
--                 if targetObject then
--                     local distance = (humanoidRootPart.Position - targetObject.Position).Magnitude
--                     if distance <= 100 and isBullet(targetObject) then
--                         humanoidRootPart.Position = targetObject.Position + Vector3.new(0, humanoidRootPart.Size.Y / 2, 0)
--                     end
--                 end
--             end
--         end
--     end
-- end
-- 
-- local function start()
--     spawn(dodgeNearbyObjects)
--     spawn(teleportPlayerToTarget)
-- end
-- 
-- startlocal Players = game:GetService("Players")
-- local Workspace = game:GetService("Workspace")
-- local RunService = game:GetService("RunService")
-- 
-- local detectionRadius = 10 -- Радиус обнаружения объектов
-- local dodgeDistance = 2 -- Расстояние уклонения
-- 
-- local ignoredObjects = {
--     "Floor",
--     "Baseplate",
-- }
-- 
Функция для определения, является ли объект пулей
-- local function isBullet(part)
--     -- Проверяем, если имя объекта содержит "EnemyProjectile"
--     if string.match(part.Name, "^EnemyProjectile") then
--         return true
--     end
--     for _, ignoredName in ipairs(ignoredObjects) do
--         if part.Name == ignoredName then
--             return false
--         end
--     end
--     return false -- Возвращаем false, если объект не является пулей
-- end
-- 
-- local function createRegion3(center, radius, height)
--     local regionSize = Vector3.new(radius * 2, height, radius * 2)
--     local regionCorner1 = center - regionSize / 2
--     local regionCorner2 = center + regionSize / 2
--     return Region3.new(regionCorner1, regionCorner2)
-- end
-- 
-- local function dodgeNearbyObjects()
--     while wait(0.1) do
--         local character = Players.LocalPlayer.Character
--         if not character then return end
-- 
--         local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
--         if not humanoidRootPart then return end
-- 
--         local playerPosition = humanoidRootPart.Position
--         local heightAboveGround = humanoidRootPart.Size.Y / 2
-- 
--         -- Создаем область с учетом высоты ног
--         local region = createRegion3(playerPosition, detectionRadius, heightAboveGround)
-- 
--         local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)
-- 
--         for _, part in pairs(partsInRegion) do
--             if part ~= humanoidRootPart and isBullet(part) then
--                 print("Обнаружена пуля: " .. part.Name) -- Отладочная информация
--                 local dodgeDirection = (humanoidRootPart.Position - part.Position).unit * dodgeDistance
--                 local newPosition = humanoidRootPart.Position + dodgeDirection
--                 
--                 -- Ограничиваем перемещение по Y, чтобы не уходить за пределы карты
--                 if newPosition.Y > 0 and newPosition.Y < 1000 then -- Предположим, что карта высотой до 1000
--                     humanoidRootPart.Position = newPosition
--                     print("Игрок уклонился от пули: " .. part.Name) -- Отладочная информация
--                 else
--                     print("Попытка уклониться заблокирована: выход за пределы карты")
--                 end
--             end
--         end
--     end
-- end
-- 
-- local function teleportPlayerToTarget()
--     while wait(1) do
--         local character = Players.LocalPlayer.Character
--         if not character then return end
-- 
--         local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
--         if not humanoidRootPart then return end
-- 
--         for _, object in pairs(Workspace:GetChildren()) do
--             if object.Name == "InvisibleCoinPileDungeon" then
--                 local targetObject = object:FindFirstChild("Coin")
--                 if targetObject then
--                     local distance = (humanoidRootPart.Position - targetObject.Position).Magnitude
--                     if distance <= 100 then
--                         humanoidRootPart.Position = targetObject.Position + Vector3.new(0, humanoidRootPart.Size.Y / 2, 0)
--                         print("Игрок телепортирован к объекту: " .. targetObject.Name) -- Отладочная информация
--                     else
--                         print("Объект слишком далеко для телепортации: " .. targetObject.Name) -- Отладочная информация
--                     end
--                 end
--             end
--         end
--     end
-- end
-- 
-- local function start()
--     spawn(dodgeNearbyObjects)
--     spawn(teleportPlayerToTarget)
-- end
-- 
-- start()
-- 
-- 

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local detectionRadius = 50 -- Радиус обнаружения
local attackInterval = 0.5 -- Время между атаками в секундах
local heightOffset = 3 -- Высота, на которую нужно поднять игрока
local hoverDuration = 1 -- Длительность зависания

-- Функция для отображения сообщения об ошибке на экране
local function showErrorMessage(message)
    local screenGui = Instance.new("ScreenGui", CoreGui)
    local textLabel = Instance.new("TextLabel", screenGui)

    textLabel.Text = message
    textLabel.Size = UDim2.new(0.5, 0, 0.1, 0) -- Ширина и высота
    textLabel.Position = UDim2.new(0.25, 0, 0.45, 0) -- Центрирование на экране
    textLabel.BackgroundColor3 = Color3.new(0, 0, 0) -- Черный фон
    textLabel.TextColor3 = Color3.new(1, 0, 0) -- Красный текст
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 24
    textLabel.TextStrokeTransparency = 0 -- Обводка текста
    textLabel.BackgroundTransparency = 0.5 -- Прозрачность фона

    -- Удаление текста через 10 секунд
    wait(10)
    screenGui:Destroy()
end

local function createRegion3(center, radius)
    local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2)
    local regionCorner1 = center - regionSize / 2
    local regionCorner2 = center + regionSize / 2
    return Region3.new(regionCorner1, regionCorner2)
end

local function check_and_destroy(bodyPosition, enemy)
    while enemy.Humanoid.Health > 0 do
        wait() -- Ждем, чтобы цикл не был бесконечным в одном кадре
    end
    -- Если здоровье врага меньше или равно 0, уничтожаем BodyPosition
    bodyPosition:Destroy()
end

local function hoverAboveEnemy(enemy)
    local player = Players.LocalPlayer
    local character = player.Character

    if character and character:FindFirstChild("HumanoidRootPart") then
        local humanoidRootPart = character.HumanoidRootPart
        local enemyHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")

        if enemyHumanoidRootPart then
            -- Определяем позицию зависания
            local hoverPosition = enemyHumanoidRootPart.Position + Vector3.new(0, heightOffset, 0)

            -- Создаем BodyPosition для удержания в воздухе
            local bodyPosition = Instance.new("BodyPosition")
            bodyPosition.Position = hoverPosition
            bodyPosition.MaxForce = Vector3.new(99999, 99999, 99999) -- Сила, удерживающая персонажа
            bodyPosition.P = 100 -- Сила сжатия
            bodyPosition.Parent = humanoidRootPart

            -- Запускаем асинхронный процесс для уничтожения BodyPosition, когда враг умирает
            spawn(function() check_and_destroy(bodyPosition, enemy) end)
        else
            showErrorMessage("Не удалось найти HumanoidRootPart у врага: " .. enemy.Name)
        end
    else
        showErrorMessage("Персонаж игрока не загружен или не имеет HumanoidRootPart.")
    end
end

local function autoAttack()
    local player = Players.LocalPlayer

    while wait(attackInterval) do
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") then
            showErrorMessage("Персонаж не найден. Попробуйте снова позже.")
            wait(1) -- Ждем перед повторной проверкой
            continue -- Пропускаем итерацию цикла
        end
        
        local humanoidRootPart = character.HumanoidRootPart
        local region = createRegion3(humanoidRootPart.Position, detectionRadius)
        local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)

        local foundEnemy = false -- Флаг для отслеживания наличия врага

        for _, part in pairs(partsInRegion) do
            local enemy = part.Parent

            if enemy:IsA("Model") and enemy:FindFirstChild("Humanoid") and enemy.Parent ~= Players then
                local enemyHumanoidRootPart = enemy:FindFirstChild("HumanoidRootPart")

                if enemyHumanoidRootPart then
                    foundEnemy = true -- Отмечаем, что враг найден
                    -- Зависаем над врагом
                    spawn(function () hoverAboveEnemy(enemy) end)

                    -- Пример атаки
                    local attackArgs = {
                        [1] = false,
                        [2] = "first", -- Убедитесь, что это правильный номер вашего оружия
                        [3] = enemyHumanoidRootPart.CFrame
                    }
                    ReplicatedStorage.Remotes.Weapon.TakeDamage:FireServer(unpack(attackArgs))
                else
                    showErrorMessage("Не удалось найти HumanoidRootPart у врага: " .. enemy.Name)
                end
            end
        end
    end
end

autoAttack()