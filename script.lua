local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local player = game.Players.LocalPlayer
local window = gui:Load("kasper studios 😈", "15074833174")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "kasper studios 😈",
    Text = "by kasperenok"
})
Duration = 5;
local function notify(title, text)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = Duration
    })
end

local hacks = gui.newTab("Hacks", "15046690373")

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

hacks.newSlider("SpeedHack", "Change youre speed", 1000, false, function(num)
    speed = num
end)

hacks.newSlider("JumpHack", "Change youre jump power", 1000, false, function(num)
    jump = num
end)

local other = gui.newTab("Other", "15046690373")
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local mode_fly = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if mode_fly then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

other.newToggle("Inf. Jump", "", false, function(toggleState)
    mode_fly = toggleState
end)
other.newButton("Activate Fly", "Get the kasperfly", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/main/kasperfly.lua"))()
end)
local mode_tp = false -- Переменная для включения/выключения телепортации

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
        local pos = mouse.Hit.Position + Vector3.new(0, 2.5, 0) -- Устанавливаем позицию с небольшим смещением по Y
        Teleport(pos)
        game:GetService("ReplicatedStorage").Remotes.Location:FireServer()
    end
end)

-- Пример добавления инструмента в инвентарь
tool.Parent = game.Players.LocalPlayer.Backpack

tool.Parent = game.Players.LocalPlayer.Backpack
local mode_noclip = true
game:GetService("RunService").Stepped:Connect(function()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = mode_noclip
        end
    end
end)

other.newToggle("Noclip", "", false, function(toggleState)
    mode_noclip = not toggleState
end)

other.newToggle("ESP Players", "", false, function(toggleState)
    _G.esp = toggleState
end)
other.newButton("Rejoin", "", function()
    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
other.newButton("DEX", "explorer files game", function()
    loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
end)
other.newButton("Scan Game UI (beta)", "script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaSpEr-tv123/kas-hub-script/refs/heads/main/scan.lua"))()
end)
other.newButton("Infinite Yield", "script", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
other.newButton("Vape", "script", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"))()
end)
other.newButton("SimpleSpyMobile", "script", function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/Devzinh/Roblox/132b5cc84c60237b30b468a550f1aee4a37bcf0e/SimpleSpyMobile.lua"))()
end)

local tp = gui.newTab("TP Utility")
local position = nil
tp.newToggle("Click TP", "", false, function(toggleState)
    mode_tp = toggleState
end)
tp.newButton("Get Click TP item", "", function()
    tool.Parent = game.Players.LocalPlayer.Backpack
end)
tp.newButton("TP all to you", "", function()
    for i, v in pairs(game.Players:GetChildren()) do
        if v ~= game.Players.LocalPlayer then
            if true then
                v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end
end)
tp.newButton("Save your position", "", function()
    position = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
    notify("TP Utility", "Position saved")
end)
tp.newButton("TP in saved position", "", function()
    Teleport(position)
end)
local playerN
tp.newInput("Player", "Enter player name", function(playerName)
    playerN = playerName
end)
tp.newButton("TP to this player", "", function()
    local playerToTeleport = game.Players:FindFirstChild(playerN)
    if playerToTeleport then
        local playerCharacter = playerToTeleport.Character
        if playerCharacter then
            local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                Teleport(humanoidRootPart.Position)
            else
                notify("TP Utility", "Character not found for player: " .. playerN)
            end
        else
            notify("TP Utility", "Character not found for player: " .. playerN)
        end
    else
        notify("TP Utility", "Player not found: " .. playerN)
    end
end)

if game.GameId == 1268927906 then
    local ml = gui.newTab("Muscle Legends")
    local auto_farm = false

    ml.newToggle("Auto Farm", "", false, function(Value)
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

    ml.newToggle("Auto Rebirth", "", false, function(Value2)
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

    ml.newToggle("Auto Farm Durability", "", false, function(state)

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

    ml.newButton("TP in lobby", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.109604, 3.71060801, 282.039124)
    end)
    ml.newButton("TP in 1 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2643.46362, 3.71060801, -405.459961)
    end)
    ml.newButton("TP in 5 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2332.45288, 3.71060729, 1078.07373)
    end)
    ml.newButton("TP in 15 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6873.23535, 3.71062183, -1273.39368)
    end)
    ml.newButton("TP in 30 rebirths location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4507.60156, 987.863586, -3884.51514)
    end)
    ml.newButton("TP in Muscle King location", "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8662.07129, 13.5606356, -5782.43555)
    end)

    ml.newInput("Fake Strength", "Change your strength", function(text)
        game.Players.LocalPlayer.leaderstats.Strength.Value = tonumber(text)
    end)
    ml.newInput("Fake Kills", "Change your kills", function(text)
        game.Players.LocalPlayer.leaderstats.Kills.Value = tonumber(text)
    end)
    ml.newInput("Fake Brawls", "Change your brawls", function(text)
        game.Players.LocalPlayer.leaderstats.Brawls.Value = tonumber(text)
    end)
    ml.newInput("Fake Rebirths", "Change your rebirths", function(text)
        game.Players.LocalPlayer.leaderstats.Rebirths.Value = tonumber(text)
    end)
end

if game.GameId == 2020908522 then
    local hds = gui.newTab("Hide And Seek")
    hds.newButton("Kill all", "Kill all players for you win (if you are the seeker)", function()
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

    hds.newButton("Auto farm coins", "", function()
        afc = not afc
        if afc then
            spawn(autoFarmCoins) -- Запускаем функцию в новом потоке
        end
    end)
    hds.newButton("Unfreeze", "unfreeze all players (if you are the hider)", function()
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

if game.GameId == 111958650 then
    local ars = gui.newTab("Arsenal")
    local localPlayer = game:GetService("Players").LocalPlayer

    local function getPlayerToAim()
        local target = nil
        local minDistance = math.huge

        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if player.Name ~= localPlayer.Name and player.Character and player.Character:FindFirstChild("Head") and
                player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and
                player.TeamColor ~= localPlayer.TeamColor then
                local distance = (player.Character.Head.Position - localPlayer.Character.Head.Position).magnitude

                if distance < minDistance then
                    target = player
                    minDistance = distance
                end
            end
        end

        return target
    end

    local camera = game.Workspace.CurrentCamera
    local aim = false

    game:GetService("RunService").RenderStepped:Connect(function()
        if aim then
            local targetPlayer = getPlayerToAim()
            if targetPlayer then
                camera.CFrame = CFrame.new(camera.CFrame.Position, targetPlayer.Character.Head.Position)
            end
        end
    end)

    ars.newToggle("AimBot", "", false, function()
        aim = not aim
    end)

    local key = Enum.KeyCode.LeftAlt
    if not game.UserInputService.TouchEnabled then
        ars.newKeybind("Keybind aim", "", function(input)
            key = input.KeyCode
        end)
    end

    game.UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == key then
            aim = not aim
        end
    end)
end

if game.GameId == 3149100453 then

    local blobs = gui.newTab("Blobs")

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

    blobs.newButton("Auto farm blobs", "", function()
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

    blobs.newButton("Auto spin free", "", function()
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

    blobs.newButton("Auto spin", "", function()
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

    blobs.newButton("Auto get gifts", "", function()
        spam(autoGetGifts)
    end)

    blobs.newButton("Kill all", "", function()
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
    local bf = gui.newTab("BloxFruits")
    bf.newButton("load script for BloxFruits", "", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
    end)
    wait(5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/BloxFruits/refs/heads/main/Source.lua"))()
end

if game.GameId == 4777817887 then
    wait(5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BladeBall/main/redz9999"))()
end

local brekablesFolder = game.Workspace:WaitForChild("__THINGS"):WaitForChild("Breakables")

local function findAndClickClosestCoin()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local closestCoin = nil
    local closestDistance = math.huge

    for _, object in pairs(brekablesFolder:GetChildren()) do
        if object:IsA("Model") and object.PrimaryPart then
            local meshPart = object:FindFirstChild("1")
            if meshPart and meshPart:IsA("MeshPart") then
                local objectPosition = meshPart.Position
                local distance = (objectPosition - humanoidRootPart.Position).magnitude

                if distance < closestDistance and distance <= 220 then
                    closestDistance = distance
                    closestCoin = object
                end
            end
        end
    end

    if closestCoin then
        local meshPart = closestCoin:FindFirstChild("1")
        if meshPart then
            local rayOrigin = humanoidRootPart.Position
            local rayDirection = (meshPart.Position - rayOrigin).unit

            local ray = Ray.new(rayOrigin, rayDirection * 1000)
            local targetPosition = meshPart.Position

            local args = {
                [1] = ray,
                [2] = targetPosition
            }

            game:GetService("ReplicatedStorage").Network.Click:FireServer(unpack(args))
        end
    end
end

local autoClick = false

if game.GameId == 3317771874 then
    local other = gui.newTab("PS99")

    other.newToggle("Auto Click", "", false, function(Value)
        autoClick = Value
        notify("Settings", "Auto Click is set to: " .. tostring(autoClick))
    end)

    spawn(function()
        while wait(1) do
            if autoClick then
                findAndClickClosestCoin()
            end
        end
    end)
else
    notify("Error", "Это не Pet Simulator 99. GameId: " .. game.GameId)
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
    local tsb = gui.newTab("TSB(beta)")

    tsb.newButton("Load script for Main Account", "Телепорт и спам кликов", function()
        getgenv().teleport = not getgenv().teleport
        teleportSmoothly(targetPosition)
    end)

    tsb.newButton("Load script for Other Accounts", "Телепорт без атак", function()
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
