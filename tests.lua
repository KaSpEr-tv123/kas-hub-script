local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local detectionRadius = 5
local dodgeDistance = 5

local function createRegion3(center, radius)
    local regionSize = Vector3.new(radius * 2, radius * 2, radius * 2)
    local regionCorner1 = center - regionSize / 2
    local regionCorner2 = center + regionSize / 2
    return Region3.new(regionCorner1, regionCorner2)
end

local function dodgeNearbyObjects()
  while wait() do
    local character = Players.LocalPlayer.Character
    if not character then return end

    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local playerPosition = humanoidRootPart.Position
    local region = createRegion3(playerPosition, detectionRadius)
    local partsInRegion = Workspace:FindPartsInRegion3(region, character, math.huge)

    for _, part in pairs(partsInRegion) do
        if part ~= humanoidRootPart then
            local dodgeDirection = (humanoidRootPart.Position - part.Position).unit * dodgeDistance
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