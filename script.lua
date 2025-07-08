local GuiLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/refs/heads/main/kasgui.lua"))()
local bumbimbambam = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/refs/heads/main/bumbimbambam.lua"))()
local kasperfly = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/main/kasperfly.lua"))()
local partscan = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/refs/heads/main/partscan.lua"))()
local player = game.Players.LocalPlayer

-- Создание главного окна и вкладок
local mainLayout = GuiLibrary:CreateDefaultLayout()
local hacksTab = GuiLibrary:AddTab("Hacks", "15046690373")
local otherTab = GuiLibrary:AddTab("Other", "15046690373")
local tpTab = GuiLibrary:AddTab("TP Utility", "15046690373")
-- Установка баннера
GuiLibrary:SetBanner("discord.gg/dYStejMq6d")

-- Пример уведомления
GuiLibrary:CreateNotification("kasper studios 😈, by kasperenok", 5)
-- Проверка наличия Frame в mainLayout
local tabFrame = mainLayout:FindFirstChild("Frame")
if tabFrame then
    print("[script.lua] Frame найден в mainLayout: ", tabFrame.Name)
else
    warn("[script.lua] Frame НЕ найден в mainLayout! CustomizeTabLayout вызван не будет.")
end

-- Кастомизация вкладок
if tabFrame then
    GuiLibrary:CustomizeTabLayout(mainLayout, "vertical", 100)
else
    -- Можно добавить обработку ошибки или альтернативное поведение
end

-- Переключение GUI по клавише F
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
        GuiLibrary:ToggleWindow(mainLayout)
    end
end)

-- puk
local hui = false
local speed = 16
local jump = 20

local add_speed = function()
    while wait() do
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
end

local add_jump = function()
    while wait() do
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
    end
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jump
end

GuiLibrary:AddSlider(hacksTab, "SpeedHack", "Change your speed", 1000, speed, function(num)
    speed = num
end)

GuiLibrary:AddSlider(hacksTab, "JumpHack", "Change your jump power", 1000, jump, function(num)
    jump = num
end)

local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local mode_fly = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if mode_fly then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

-- Кастомное окно для флая
local flyWindow = nil
GuiLibrary:AddToggle(otherTab, "Fly Menu", "Открыть меню флая", false, function(toggleState)
    if toggleState then
        flyWindow = GuiLibrary:CreateCustomWindow("KasperFly", "15074833174")
        kasperfly.toggle(flyWindow)
        flyWindow.open()
    else
        if flyWindow then flyWindow.close() end
    end
end)

GuiLibrary:AddToggle(otherTab, "Inf. Jump", "", false, function(toggleState)
    mode_fly = toggleState
end)

GuiLibrary:AddButton(otherTab, "Activate Fly", "Get the kasperfly", function()
    flyWindow = GuiLibrary:CreateCustomWindow("KasperFly", "15074833174")
    kasperfly.toggle(flyWindow)
    flyWindow.open()
end)

local mode_tp = false

-- Создаем инструмент (Tool)
local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click TP function"

local mouse = game.Players.LocalPlayer:GetMouse()

-- Получаем сервисы
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = game.Players.LocalPlayer

-- Функция для включения/выключения режима телепортации
local function toggleTeleportMode()
    mode_tp = not mode_tp
    if mode_tp then
        print("Телепорт включен")
    else
        print("Телепорт выключен")
    end
end

-- Функция для плавного телепорта
local function Teleport(targetPosition)
    local character = player.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoidRootPart then
        local currentCFrame = humanoidRootPart.CFrame
        local targetCFrame = CFrame.new(targetPosition)

        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenGoal = {
            CFrame = targetCFrame
        }
        local tween = TweenService:Create(humanoidRootPart, tweenInfo, tweenGoal)

        tween:Play()
        tween.Completed:Wait()
    end
end

tool.Activated:Connect(function()
    if mode_tp then
        local pos = mouse.Hit.Position + Vector3.new(0, 2.5, 0)
        Teleport(pos)
        game:GetService("ReplicatedStorage").Remotes.Location:FireServer()
    end
end)

tool.Parent = game.Players.LocalPlayer.Backpack

local mode_noclip = true
game:GetService("RunService").Stepped:Connect(function()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = mode_noclip
        end
    end
end)

-- Кастомное окно для бумбимбамбама
local bumbimbambamWindow = nil
local function toggleBumbimbambam()
    print("toggleBumbimbambam: старт")
    if not bumbimbambamWindow then
        bumbimbambamWindow = GuiLibrary:CreateCustomWindow("Bumbimbambam", "15074833174")
    end
    bumbimbambam.toggle(bumbimbambamWindow)
    print("toggleBumbimbambam: конец")
end

local partscanWindow = nil
GuiLibrary:AddToggle(otherTab, "Part Scan Attack", "Сканирует и атакует объектами", false, function(toggleState)
    if toggleState then
        partscanWindow = GuiLibrary:CreateCustomWindow("PartScan", "15074833174")
        partscan.toggle(partscanWindow)
    else
        if partscanWindow then partscanWindow.close() end
        partscan.toggle(partscanWindow)
    end
end)

GuiLibrary:AddToggle(otherTab, "Noclip", "", false, function(toggleState)
    mode_noclip = not toggleState
end)

GuiLibrary:AddToggle(otherTab, "ESP Players", "", false, function(toggleState)
    _G.esp = toggleState
end)

GuiLibrary:AddButton(otherTab, "Rejoin", "", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

GuiLibrary:AddButton(otherTab, "DEX", "explorer files game", function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
end)

GuiLibrary:AddButton(otherTab, "Scan Game UI (beta)", "script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/refs/heads/main/scan.lua"))()
end)

GuiLibrary:AddButton(otherTab, "Infinite Yield", "script", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)

GuiLibrary:AddButton(otherTab, "Vape", "script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"))()
end)

GuiLibrary:AddButton(otherTab, "SimpleSpyMobile", "script", function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Devzinh/Roblox/132b5cc84c60237b30b468a550f1aee4a37bcf0e/SimpleSpyMobile.lua"))()
end)

local position = nil
GuiLibrary:AddToggle(tpTab, "Click TP", "", false, function(toggleState)
    mode_tp = toggleState
end)

GuiLibrary:AddButton(tpTab, "Get Click TP item", "", function()
    tool.Parent = game.Players.LocalPlayer.Backpack
end)

GuiLibrary:AddButton(tpTab, "TP all to you", "", function()
    for i, v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer then
            if true then
                v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)

GuiLibrary:AddButton(tpTab, "Save your position", "", function()
    position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    GuiLibrary:CreateNotification("Position saved", 3)
end)

GuiLibrary:AddButton(tpTab, "TP in saved position", "", function()
    Teleport(position)
end)

local playerN
GuiLibrary:AddInput(tpTab, "Player", "Enter player name", function(playerName)
    playerN = playerName
end)

GuiLibrary:AddButton(tpTab, "TP to this player", "", function()
    local playerToTeleport = game.Players:FindFirstChild(playerN)
    if playerToTeleport then
        local playerCharacter = playerToTeleport.Character
        if playerCharacter then
            local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                Teleport(humanoidRootPart.Position)
            else
                GuiLibrary:CreateNotification("Character not found for player: " .. playerN, 3)
            end
        else
            GuiLibrary:CreateNotification("Character not found for player: " .. playerN, 3)
        end
    else
        GuiLibrary:CreateNotification("Player not found: " .. playerN, 3)
    end
end)

if game.GameId == 1268927906 then
    local ml = GuiLibrary:AddTab("Muscle Legends")
    local auto_farm = false

    GuiLibrary:AddToggle(ml, "Auto Farm", "", false, function(Value)
        elias999 = 1

        while elias999 == 1 do
            if Value == false then
                elias999 = 2
            end
            wait()
            local args = {
                [1] = "rep"
            }

            game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

        end
    end)

    GuiLibrary:AddToggle(ml, "Auto Rebirth", "", false, function(Value2)
        elias782k = 1
        while elias782k == 1 do
            if Value2 == false then
                elias782k = 2
            end
            wait(1)
            local args = {
                [1] = "rebirthRequest"
            }
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer(unpack(args))
        end
    end)

    GuiLibrary:AddToggle(ml, "Auto Farm Durability", "", false, function(state)

        m = game.Players.LocalPlayer:GetMouse()
        elias782k = 1
        while elias782k == 1 do
            if Value2 == false then
                elias782k = 2
            end
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                CFrame.new(284.321411, 7.33135414, -578.631897, 0.305069387, 3.63381929e-08, -0.952330112,
                    1.39650966e-08, 1, 4.26307203e-08, 0.952330112, -2.63047095e-08, 0.305069387)
            mouse1click()

            wait()

        end

    end)

    GuiLibrary:AddButton(ml, "TP in lobby", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.109604, 3.71060801, 282.039124)
    end)
    GuiLibrary:AddButton(ml, "TP in 1 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2643.46362, 3.71060801, -405.459961)
    end)
    GuiLibrary:AddButton(ml, "TP in 5 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2332.45288, 3.71060729, 1078.07373)
    end)
    GuiLibrary:AddButton(ml, "TP in 15 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6873.23535, 3.71062183, -1273.39368)
    end)
    GuiLibrary:AddButton(ml, "TP in 30 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4507.60156, 987.863586, -3884.51514)
    end)
    GuiLibrary:AddButton(ml, "TP in Muscle King location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8662.07129, 13.5606356, -5782.43555)
    end)

    GuiLibrary:AddInput(ml, "Fake Strength", "Change your strength", function(text)
        game.Players.LocalPlayer.leaderstats.Strength.Value = tonumber(text)
    end)
    GuiLibrary:AddInput(ml, "Fake Kills", "Change your kills", function(text)
        game.Players.LocalPlayer.leaderstats.Kills.Value = tonumber(text)
    end)
    GuiLibrary:AddInput(ml, "Fake Brawls", "Change your brawls", function(text)
        game.Players.LocalPlayer.leaderstats.Brawls.Value = tonumber(text)
    end)
    GuiLibrary:AddInput(ml, "Fake Rebirths", "Change your rebirths", function(text)
        game.Players.LocalPlayer.leaderstats.Rebirths.Value = tonumber(text)
    end)
end

if game.GameId == 2020908522 then
    local hds = GuiLibrary:AddTab("Hide And Seek")
    GuiLibrary:AddButton(hds, "Kill all", "Kill all players for you win (if you are the seeker)", function()
        -- kill, not tp
        for i, v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                if not v.Character.Head:FindFirstChild("SeekerTitle") then
                    v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end)
    local afc = false

    local function autoFarmCoins()
        repeat
            wait(0.5)
            local coinsFolder = game.Workspace:FindFirstChild("MapHolder")
            if coinsFolder then
                local minDistance = math.huge
                local nearestCoin = nil

                for _, coin in ipairs(coinsFolder:GetChildren()) do
                    if coin.Name == "Coin" then
                        local distance =
                            (coin.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if distance < minDistance then
                            minDistance = distance
                            nearestCoin = coin
                        end
                    end
                end

                if nearestCoin then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame
                else
                    local warningGui = Instance.new("ScreenGui")
                    warningGui.Parent = game.Players.LocalPlayer.PlayerGui

                    local warningLabel = Instance.new("TextLabel")
                    warningLabel.Text = "Монеты не найдены."
                    warningLabel.Size = UDim2.new(0, 200, 0, 50)
                    warningLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
                    warningLabel.BackgroundColor3 = Color3.new(0.3686274509803922, 0.023529411764705882,
                        0.42745098039215684)
                    warningLabel.TextColor3 = Color3.new(0.19607843137254902, 0.023529411764705882, 0.2235294117647059)
                    warningLabel.Parent = warningGui
                    -- afc = false
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
                        CFrame.new(35.8843689, 4.00753164, 65.9930344)
                    wait(3)
                    warningGui:Destroy()
                end
            else
                warn("Папка с монетами не найдена.")
            end
        until not afc
    end

    GuiLibrary:AddButton(hds, "Auto farm coins", "", function()
        afc = not afc
        if afc then
            spawn(autoFarmCoins) -- Запускаем функцию в новом потоке
        end
    end)
    GuiLibrary:AddButton(hds, "Unfreeze", "unfreeze all players (if you are the hider)", function()
        for i, v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                if not v.Character.Head:FindFirstChild("SeekerTitle") then
                    wait(0.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end)
end
local ars = GuiLibrary:AddTab("aimtools")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local aim = false
local key = Enum.KeyCode.LeftAlt
local aimMode = 1

local function getHeadPosition(player)
    local char = player.Character
    if char and char:FindFirstChild("Head") then
        return char.Head.CFrame.p
    end
    return nil
end

local function isInFOV(targetPos, fovDegrees)
    local camPos = camera.CFrame.Position
    local camLook = camera.CFrame.LookVector

    local directionToTarget = (targetPos - camPos).Unit
    local dot = camLook:Dot(directionToTarget)
    
    local angle = math.acos(dot) * (180 / math.pi)

    return angle <= fovDegrees
end

local function getTargetPlayer()
    local shortestDistance = math.huge
    local nearest = nil

    local localChar = localPlayer.Character
    if not localChar or not localChar:FindFirstChild("Head") then return nil end
    local myHeadPos = localChar.Head.Position

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= localPlayer then
            local char = player.Character
            if char and char:FindFirstChild("Head") then
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    if aimMode == 2 or player.TeamColor ~= localPlayer.TeamColor then
                        local headPos = char.Head.Position
                        local dist = (headPos - myHeadPos).Magnitude
                        if dist < shortestDistance then
                            shortestDistance = dist
                            nearest = player
                        end
                    end
                end
            end
        end
    end

    return nearest
end

RunService.RenderStepped:Connect(function()
    if aim then
        local target = getTargetPlayer()

        if target then
            local targetHeadPos = getHeadPosition(target)
            if targetHeadPos then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetHeadPos)
            end
        end
    end
end)


-- Вкл/выкл аима
GuiLibrary:AddToggle(ars, "AimBot", "Включить/выключить прицел", false, function(state)
    aim = state
end)

-- Назначение клавиши
if not UserInputService.TouchEnabled then
    GuiLibrary:AddKeybind(ars, "Keybind Aim", "Клавиша для аимбота", function(input)
        key = input.KeyCode
    end)
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == key then
        aim = not aim
    end
end)

-- Режим прицеливания с описанием
GuiLibrary:AddDropdown(ars, "Режим прицеливания", "Выберите метод прицеливания", {"По команде", "Ближайший"}, function(selected)
    if selected == "По команде" then
        aimMode = 1
        print("[AIM] Режим: По команде")
    elseif selected == "Ближайший" then
        aimMode = 2
        print("[AIM] Режим: По ближайшему")
    end
end)


if game.GameId == 3149100453 then

    local blobs = GuiLibrary:AddTab("Blobs")

    local afb = false

    function autoFarmBlobs()
        repeat
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 1000
            local coinsFolder = game.Workspace:FindFirstChild("Orbs")
            if coinsFolder then
                local minDistance = math.huge
                local nearestCoin = nil

                for _, coin in ipairs(coinsFolder:GetChildren()) do
                    if coin.Name == "Orb" then
                        local distance =
                            (coin.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if distance < minDistance then
                            minDistance = distance
                            nearestCoin = coin
                        end
                    end
                end

                if nearestCoin then
                    local playersNearby = game.Players:GetPlayers()
                    local teleportAllowed = true

                    for _, player in ipairs(playersNearby) do
                        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                            local playerDistance = (player.Character.HumanoidRootPart.Position -
                                                       game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                            if playerDistance < 300 and player ~= game.Players.LocalPlayer then
                                teleportAllowed = false
                                break
                            end
                        end
                    end

                    if teleportAllowed then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame
                    end
                else
                    local warningGui = Instance.new("ScreenGui")
                    warningGui.Parent = game.Players.LocalPlayer.PlayerGui

                    local warningLabel = Instance.new("TextLabel")
                    warningLabel.Text = "Монеты не найдены."
                    warningLabel.Size = UDim2.new(0, 200, 0, 50)
                    warningLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
                    warningLabel.BackgroundColor3 = Color3.new(0.3686274509803922, 0.023529411764705882,
                        0.42745098039215684)
                    warningLabel.TextColor3 = Color3.new(0.19607843137254902, 0.023529411764705882, 0.2235294117647059)
                    warningLabel.Parent = warningGui

                    wait(3)
                    warningGui:Destroy()
                end
            else
                warn("Папка с монетами не найдена.")
            end
            wait(0.005)
        until not afb
    end

    GuiLibrary:AddButton(blobs, "Auto farm blobs", "", function()
        afb = not afb
        if afb then
            spawn(autoFarmBlobs) -- Запускаем функцию в новом потоке
        else
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        end
    end)

    local freespin = false
    function autoSpinFree()
        while freespin == true do
            game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
                .SpinService.RE.FreeSpinButtonPressed:FireServer()
            wait(5)
        end
    end

    GuiLibrary:AddButton(blobs, "Auto spin free", "", function()
        freespin = not freespin
        if freespin then
            spawn(autoSpinFree)
        end
    end)

    local spin = false

    function autoSpin(mode)
        while spin == true do
            game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
                .SpinService.RE.SkullSpinButtonPressed:FireServer()
            wait(5)
        end
    end

    GuiLibrary:AddButton(blobs, "Auto spin", "", function()
        spin = not spin
        if spin then
            spawn(autoSpin)
        end
    end)

    function autoGetGifts()
        wait(12)
        local args = {
            [1] = 12
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(136)
        local args = {
            [1] = 136
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(250)
        local args = {
            [1] = 250
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(441)
        local args = {
            [1] = 441
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(589)
        local args = {
            [1] = 589
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(723)
        local args = {
            [1] = 723
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(893)
        local args = {
            [1] = 893
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(1006)
        local args = {
            [1] = 1006
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(1147)
        local args = {
            [1] = 1147
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(1280)
        local args = {
            [1] = 1280
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(1427)
        local args = {
            [1] = 1427
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
        wait(2000)
        local args = {
            [1] = 2000
        }

        game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services
            .GiftService.RF.RequestGift:InvokeServer(unpack(args))
    end

    GuiLibrary:AddButton(blobs, "Auto get gifts", "", function()
        spam(autoGetGifts)
    end)

    GuiLibrary:AddButton(blobs, "Kill all", "", function()
        for i, v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                if game.Players.LocalPlayer.Character.HumanoidRootPart.RealSize.Value >
                    v.Character.HumanoidRootPart.RealSize.Value then
                    wait(0.1)
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
                end
            end
        end
    end)
end

if game.GameId == 994732206 then
    local bf = GuiLibrary:AddTab("BloxFruits")
    GuiLibrary:AddButton(bf, "load script for BloxFruits", "", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)
    wait(5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end

if game.GameId == 4777817887 then
    wait(5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BladeBall/main/redz9999"))()
end

local function teleportToClosestCoin()
    local brekablesFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Breakables")
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local closestCoin = nil
    local closestDistance = math.huge

    for _, object in pairs(brekablesFolder:GetChildren()) do
        if object:IsA("Model") and object.PrimaryPart then
            local objectPosition = object.PrimaryPart.Position
            local distance = (objectPosition - humanoidRootPart.Position).magnitude

            if distance < closestDistance then
                closestDistance = distance
                closestCoin = object
            end
        end
    end

    if closestCoin then
        Teleport(closestCoin.PrimaryPart.Position)
    end
end

local autoTeleport = false

if game.GameId == 3317771874 then
    local other = GuiLibrary:AddTab("PS99")

    GuiLibrary:AddToggle(other, "Auto farm coins", "", false, function(Value)
        autoTeleport = Value
    end)

    spawn(function()
        while wait() do
            if autoTeleport then
                teleportToClosestCoin()
            end
        end
    end)
end

getgenv().teleport = false
getgenv().teleportOther = false

local TweenService = game:GetService("TweenService")
local targetPosition = Vector3.new(-12, 652, -422)

local function teleportSmoothly(targetPos)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local currentCFrame = humanoidRootPart.CFrame
    local rotation = currentCFrame - currentCFrame.Position

    local randomOffset = Vector3.new(math.random(-2, 2), 0, math.random(-2, 2)) * 0.2
    local targetCFrame = CFrame.new(targetPos + randomOffset) * rotation

    local duration = math.random(8, 20) / 10

    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local tween = TweenService:Create(humanoidRootPart, tweenInfo, {
        CFrame = targetCFrame
    })

    tween:Play()
    tween.Completed:Wait()
    while getgenv().teleport do

        local args = {
            [1] = {
                ["Mobile"] = UserInputService.TouchEnabled,
                ["Goal"] = "LeftClick"
            }
        }

        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

        wait(0.1)
    end
end

if game.GameId == 3808081382 then
    local tsb = GuiLibrary:AddTab("TSB(beta)")

    GuiLibrary:AddButton(tsb, "Load script for Main Account", "Телепорт и спам кликов", function()
        getgenv().teleport = not getgenv().teleport
        teleportSmoothly(targetPosition)
    end)

    GuiLibrary:AddButton(tsb, "Load script for Other Accounts", "Телепорт без атак", function()
        getgenv().teleportOther = not getgenv().teleportOther
        teleportSmoothly(targetPosition)
    end)
end

function tpp()
    while wait() do
        pcall(function()
            if getgenv().teleportOther then
                teleportSmoothly(targetPosition, false)
            end
        end)
    end
end

function tppp()
    while wait() do
        pcall(function()
            if getgenv().teleport then
                teleportSmoothly(targetPosition, true)
            end
        end)
    end
end

spawn(tppp)
spawn(tpp)
spawn(add_jump)
spawn(add_speed)
loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/main/kasperesp.lua"))()
