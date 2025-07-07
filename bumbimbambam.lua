-- Модуль Bumbimbambam для Kas Hub Script
-- Агрессивная атака: кручение и влет строго в выбранного игрока с отключённой коллизией и GUI-меню

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local StarterGui = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

local bumbimbambamEnabled = false
local selectedTarget = nil

-- Настройки
local TELEPORT_DISTANCE = 10 -- Дистанция телепорта от цели (метров)
local ATTACK_SPEED = 1400 -- Скорость влёта в игрока
local ATTACK_FORCE = 1200 -- Сила отбрасывания
local ATTACK_COOLDOWN = 0.1 -- Задержка между атаками
local SPIN_TIME = 0.08 -- Время кручения перед атакой (сек)
local SPIN_SPEED = 2200 -- Скорость вращения (градусов/сек)

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
    if not targetPlayer or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    local targetRootPart = targetPlayer.Character.HumanoidRootPart
    local targetPos = targetRootPart.Position
    local attackFrom = getAttackPoint(targetPos)
    HumanoidRootPart.CFrame = CFrame.new(attackFrom)
    spinAnimation(SPIN_TIME, SPIN_SPEED)
    -- Пересчитываем направление прямо перед влетом
    local freshTargetPos = targetRootPart.Position
    local direction = (freshTargetPos - HumanoidRootPart.Position).Unit
    HumanoidRootPart.Velocity = direction * ATTACK_SPEED
    for i = 1, 10 do
        HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(36), 0)
        RunService.Heartbeat:Wait()
    end
    local knockback = Instance.new("BodyVelocity")
    knockback.MaxForce = Vector3.new(1e5, 1e5, 1e5)
    knockback.Velocity = direction * ATTACK_FORCE + Vector3.new(0, 100, 0)
    knockback.Parent = targetRootPart
    Debris:AddItem(knockback, 0.5)
end

local function startBumbimbambam()
    spawn(function()
        while bumbimbambamEnabled do
            if selectedTarget and Players:FindFirstChild(selectedTarget) then
                -- Постоянное кручение даже между атаками
                local spinStart = tick()
                while tick() - spinStart < ATTACK_COOLDOWN do
                    HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SPIN_SPEED * RunService.Heartbeat:Wait()), 0)
                end
                attackTarget(Players[selectedTarget])
            else
                -- Крутимся на месте, если нет цели
                HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                HumanoidRootPart.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(SPIN_SPEED * RunService.Heartbeat:Wait()), 0)
            end
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

-- === Фиолетовое draggable GUI ===
local function createTargetGui()
    if game.CoreGui:FindFirstChild("BumbimTargetGui") then
        game.CoreGui.BumbimTargetGui:Destroy()
    end
    local gui = Instance.new("ScreenGui")
    gui.Name = "BumbimTargetGui"
    gui.Parent = game.CoreGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 260, 0, 380)
    frame.Position = UDim2.new(0, 100, 0, 100)
    frame.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Draggable = true
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Text = "Bumbimbambam: Выбор цели"
    title.Size = UDim2.new(1, 0, 0, 36)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(220, 180, 255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 20
    title.Parent = frame

    local scroll = Instance.new("ScrollingFrame")
    scroll.Size = UDim2.new(1, -20, 1, -96)
    scroll.Position = UDim2.new(0, 10, 0, 46)
    scroll.BackgroundColor3 = Color3.fromRGB(50, 0, 100)
    scroll.BorderSizePixel = 0
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 6
    scroll.Parent = frame

    local function refreshList()
        for _, c in pairs(scroll:GetChildren()) do
            if c:IsA("TextButton") then c:Destroy() end
        end
        local y = 0
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, -8, 0, 32)
                btn.Position = UDim2.new(0, 4, 0, y)
                btn.BackgroundColor3 = (selectedTarget == plr.Name) and Color3.fromRGB(180, 0, 255) or Color3.fromRGB(120, 0, 200)
                btn.TextColor3 = Color3.fromRGB(255, 255, 255)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 16
                btn.Text = plr.Name .. ((selectedTarget == plr.Name) and "  [ЦЕЛЬ]" or "")
                btn.Parent = scroll
                btn.MouseButton1Click:Connect(function()
                    selectedTarget = plr.Name
                    refreshList()
                    StarterGui:SetCore("SendNotification", {Title="Bumbimbambam", Text="Цель: "..plr.Name, Duration=2})
                    if bumbimbambamEnabled then
                        startBumbimbambam()
                    end
                end)
                y = y + 36
            end
        end
        -- Кнопка снять цель
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -8, 0, 32)
        btn.Position = UDim2.new(0, 4, 0, y)
        btn.BackgroundColor3 = Color3.fromRGB(60, 0, 80)
        btn.TextColor3 = Color3.fromRGB(200, 200, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 16
        btn.Text = "Снять цель (никого не атаковать)"
        btn.Parent = scroll
        btn.MouseButton1Click:Connect(function()
            selectedTarget = nil
            refreshList()
            StarterGui:SetCore("SendNotification", {Title="Bumbimbambam", Text="Цель снята", Duration=2})
        end)
        y = y + 36
        scroll.CanvasSize = UDim2.new(0, 0, 0, y)
    end

    refreshList()
    Players.PlayerAdded:Connect(refreshList)
    Players.PlayerRemoving:Connect(refreshList)

    -- Кнопка стоп атаки
    local stopBtn = Instance.new("TextButton")
    stopBtn.Size = UDim2.new(1, -40, 0, 36)
    stopBtn.Position = UDim2.new(0, 20, 1, -44)
    stopBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 80)
    stopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    stopBtn.Font = Enum.Font.GothamBold
    stopBtn.TextSize = 18
    stopBtn.Text = "Стоп атаки"
    stopBtn.Parent = frame
    stopBtn.MouseButton1Click:Connect(function()
        bumbimbambamEnabled = false
        stopBumbimbambam()
        StarterGui:SetCore("SendNotification", {Title="Bumbimbambam", Text="Атака остановлена", Duration=2})
    end)
end

createTargetGui()

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