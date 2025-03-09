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

local function teleportToClosestCoin()
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
    local other = gui.newTab("PS99")

    other.newToggle("Auto farm coins", "", false, function(Value)
        autoTeleport = Value
    end)

    spawn(function()
        while wait() do
            if autoTeleport then
                teleportToClosestCoin()
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
local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then v19=v0(v3(v30,1,1));return "";else local v81=v2(v0(v30,16));if v19 then local v92=v5(v81,v19);v19=nil;return v92;else return v81;end end end);local function v20(v31,v32,v33) if v33 then local v82=0 -0 ;local v83;while true do if (v82==(0 -0)) then v83=(v31/(2^(v32-(1 -0))))%(2^(((v33-(2 -1)) -(v32-(620 -(555 + 64)))) + 1)) ;return v83-(v83%(932 -((2494 -(1523 + 114)) + 74))) ;end end else local v84=568 -(367 + 201) ;local v85;while true do if (v84==(927 -(214 + 713))) then v85=(1 + 1)^(v32-(1 + 0 + 0)) ;return (((v31%(v85 + v85))>=v85) and (878 -(282 + 595))) or 0 ;end end end end local function v21() local v34=0;local v35;while true do if (v34==(0 -(117 -(32 + 85)))) then v35=v1(v16,v18,v18);v18=v18 + (1066 -(68 + 997)) ;v34=(1246 + 25) -(51 + 175 + 1044) ;end if (v34==(4 -3)) then return v35;end end end local function v22() local v36,v37=v1(v16,v18,v18 + (959 -(892 + 65)) );v18=v18 + (4 -2) ;return (v37 * (472 -216)) + v36 ;end local function v23() local v38,v39,v40,v41=v1(v16,v18,v18 + (4 -1) );v18=v18 + (184 -(67 + 113)) ;return (v41 * 16777216) + (v40 * 65536) + (v39 * (188 + 68)) + v38 ;end local function v24() local v42=0 -0 ;local v43;local v44;local v45;local v46;local v47;local v48;while true do if (v42==((0 -0) + 0)) then v43=v23();v44=v23();v42=3 -2 ;end if (v42==(2 + 1)) then if (v47==((375 + 577) -(802 + 150))) then if (v46==(0 -0)) then return v48 * (0 -(0 -0)) ;else v47=1 + 0 ;v45=997 -(915 + 82) ;end elseif (v47==(5796 -3749)) then return ((v46==(0 + 0)) and (v48 * (1/(0 -(1747 -(760 + 987)))))) or (v48 * NaN) ;end return v8(v48,v47-(2210 -((2982 -(1789 + 124)) + 118)) ) * (v45 + (v46/((4 -2)^(1190 -(116 + 1022))))) ;end if (v42==(8 -6)) then v47=v20(v44,45 -24 ,113 -82 );v48=((v20(v44,6 + 26 )==(1 -0)) and  -(2 -(767 -(745 + 21)))) or (1 + 0) ;v42=794 -(127 + 241 + 423) ;end if (v42==(3 -(5 -3))) then v45=19 -(10 + 8) ;v46=(v20(v44,3 -2 ,1100 -(1020 + 60) ) * (2^(1455 -(630 + 793)))) + v43 ;v42=6 -4 ;end end end local function v25(v49) local v50=0 -(0 -0) ;local v51;local v52;while true do if (v50==(1 + 2)) then return v6(v52);end if (v50==(2 + 0)) then v52={};for v93=1056 -((1904 -(1703 + 114)) + 968) , #v51 do v52[v93]=v2(v1(v3(v51,v93,v93)));end v50=13 -10 ;end if (v50==(0 + 0)) then v51=nil;if  not v49 then v49=v23();if (v49==0) then return "";end end v50=702 -(376 + 325) ;end if (v50==(2 -1)) then v51=v3(v16,v18,(v18 + v49) -(1414 -(447 + 966)) );v18=v18 + v49 ;v50=2;end end end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v53=(function() return 1835 -(274 + 1561) ;end)();local v54=(function() return;end)();local v55=(function() return;end)();local v56=(function() return;end)();local v57=(function() return;end)();local v58=(function() return;end)();local v59=(function() return;end)();local v60=(function() return;end)();while true do if (v53==(0 -0)) then local v88=(function() return 0;end)();local v89=(function() return;end)();while true do if (0==v88) then v89=(function() return 0 + 0 ;end)();while true do if (v89==(241 -(187 + 54))) then v54=(function() return function(v116,v117,v118) local v119=(function() return 780 -(162 + 618) ;end)();local v120=(function() return;end)();while true do if (v119~=0) then else v120=(function() return 0;end)();while true do if (v120==(0 + 0)) then local v169=(function() return 0 + 0 ;end)();while true do if (0==v169) then v116[v117-#"[" ]=(function() return v118();end)();return v116,v117,v118;end end end end break;end end end;end)();v55=(function() return {};end)();v89=(function() return 1 -0 ;end)();end if (v89==(1 -0)) then v56=(function() return {};end)();v53=(function() return 1 + 0 ;end)();break;end end break;end end end if (v53~=(1637 -(1373 + 263))) then else local v90=(function() return 0;end)();while true do if (v90==(1001 -(451 + 549))) then v59=(function() return v23();end)();v53=(function() return 2;end)();break;end if (v90==(0 + 0)) then v57=(function() return {};end)();v58=(function() return {v55,v56,nil,v57};end)();v90=(function() return 1 -0 ;end)();end end end if (v53~=(1386 -(746 + 638))) then else v60=(function() return {};end)();for v95= #"}",v59 do local v96=(function() return 0 + 0 ;end)();local v97=(function() return;end)();local v98=(function() return;end)();local v99=(function() return;end)();while true do if (v96==(0 -0)) then v97=(function() return 0;end)();v98=(function() return nil;end)();v96=(function() return 1;end)();end if (v96==1) then v99=(function() return nil;end)();while true do if (v97==(341 -(218 + 123))) then v98=(function() return v21();end)();v99=(function() return nil;end)();v97=(function() return 1582 -(1535 + 46) ;end)();end if (v97==1) then if (v98== #">") then v99=(function() return v21()~=(0 + 0) ;end)();elseif (v98==2) then v99=(function() return v24();end)();elseif (v98~= #"91(") then else v99=(function() return v25();end)();end v60[v95]=(function() return v99;end)();break;end end break;end end end v58[ #"91("]=(function() return v21();end)();v53=(function() return 1 + 2 ;end)();end if (v53~=3) then else for v100= #" ",v23() do local v101=(function() return v21();end)();if (v20(v101, #"[", #"}")==(560 -(306 + 254))) then local v109=(function() return 0;end)();local v110=(function() return;end)();local v111=(function() return;end)();local v112=(function() return;end)();while true do if (2==v109) then if (v20(v111, #"|", #".")== #"[") then v112[2]=(function() return v60[v112[2]];end)();end if (v20(v111,1 + 1 ,2)~= #"<") then else v112[ #"gha"]=(function() return v60[v112[ #"gha"]];end)();end v109=(function() return 5 -2 ;end)();end if (v109==(1468 -(899 + 568))) then local v113=(function() return 0;end)();while true do if (v113==(1 + 0)) then v109=(function() return 4 -2 ;end)();break;end if (v113==(603 -(268 + 335))) then local v157=(function() return 290 -(60 + 230) ;end)();while true do if (v157==(573 -(426 + 146))) then v113=(function() return 1 + 0 ;end)();break;end if (v157~=0) then else v112=(function() return {v22(),v22(),nil,nil};end)();if (v110==0) then local v170=(function() return 811 -(569 + 242) ;end)();local v171=(function() return;end)();while true do if (v170==0) then v171=(function() return 0;end)();while true do if (v171==0) then v112[ #"xnx"]=(function() return v22();end)();v112[ #"http"]=(function() return v22();end)();break;end end break;end end elseif (v110== #".") then v112[ #"gha"]=(function() return v23();end)();elseif (v110==(5 -3)) then v112[ #"nil"]=(function() return v23() -((1 + 1)^16) ;end)();elseif (v110== #"91(") then local v177=(function() return 0;end)();local v178=(function() return;end)();while true do if (v177==(1024 -(706 + 318))) then v178=(function() return 0;end)();while true do if (v178~=0) then else v112[ #"gha"]=(function() return v23() -(2^16) ;end)();v112[ #"asd1"]=(function() return v22();end)();break;end end break;end end end v157=(function() return 1;end)();end end end end end if (v109==(1254 -(721 + 530))) then if (v20(v111, #"xnx", #"-19")== #",") then v112[ #".com"]=(function() return v60[v112[ #".com"]];end)();end v55[v100]=(function() return v112;end)();break;end if (v109==(1271 -(945 + 326))) then v110=(function() return v20(v101,4 -2 , #"gha");end)();v111=(function() return v20(v101, #"?id=",6);end)();v109=(function() return 1 + 0 ;end)();end end end end for v102= #":",v23() do v56,v102,v28=(function() return v54(v56,v102,v28);end)();end return v58;end end end local function v29(v61,v62,v63) local v64=v61[739 -(542 + 196) ];local v65=v61[(434 + 268) -(271 + 429) ];local v66=v61[1 + 2 ];return function(...) local v67=v64;local v68=v65;local v69=v66;local v70=v27;local v71=1 + 0 ;local v72= -1;local v73={};local v74={...};local v75=v12("#",...) -((3162 -(1477 + 184)) -(1408 + 92)) ;local v76={};local v77={};for v86=1086 -(461 + (1763 -(782 + 356))) ,v75 do if (v86>=v69) then v73[v86-v69 ]=v74[v86 + (1289 -(993 + 295)) ];else v77[v86]=v74[v86 + (1552 -(1126 + 425)) ];end end local v78=(v75-v69) + (406 -(118 + 287)) ;local v79;local v80;while true do local v87=0 + 0 ;while true do if (v87==(1172 -(418 + (1020 -(176 + 91))))) then if ((v80<=(2 + (1 -0))) or (2408<2109)) then if (v80<=((2 -1) + 0)) then if ((v80>(0 + 0)) or (33==1455)) then local v124=v79[1 + 0 + 1 ];local v125=v77[v79[532 -(406 + 123) ]];v77[v124 + (1770 -((2577 -828) + 20)) ]=v125;v77[v124]=v125[v79[(874 -(564 + 292)) -14 ]];else v77[v79[1 + 1 ]]={};end elseif (v80>(1324 -(1249 + 73))) then v77[v79[1 + 1 ]]=v63[v79[5 -2 ]];else v77[v79[1147 -(466 + 679) ]]=v79[6 -3 ];end elseif (v80<=(14 -9)) then if (v80>(1904 -(106 + 1794))) then local v134=v79[1 + 1 ];local v135,v136=v70(v77[v134](v13(v77,v134 + 1 + 0 ,v79[8 -5 ])));v72=(v136 + v134) -(2 -(1 -0)) ;local v137=114 -((11 -7) + 110) ;for v158=v134,v72 do local v159=584 -(57 + 527) ;while true do if ((v159==(1427 -(41 + 1386))) or (443>=4015)) then v137=v137 + (104 -(17 + 86)) ;v77[v158]=v135[v137];break;end end end else local v138;local v139,v140;local v141;local v142;v77[v79[1 + 1 ]]={};v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[3 -1 ]]=v63[v79[(312 -(244 + 60)) -(4 + 1) ]];v71=v71 + ((1806 -(41 + 435)) -(797 + 532)) ;v79=v67[v71];v77[v79[(1169 -(938 + 63)) -(94 + 28 + 44) ]]=v63[v79[2 + 1 ]];v71=v71 + 1 ;v79=v67[v71];v142=v79[2 -0 ];v141=v77[v79[6 -3 ]];v77[v142 + (3 -2) ]=v141;v77[v142]=v141[v79[4 + 0 ]];v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[3 -(1126 -(936 + 189)) ]]=v79[(1877 -(157 + 1718)) + 1 ];v71=v71 + (66 -(30 + 35)) ;v79=v67[v71];v142=v79[2 + 0 ];v139,v140=v70(v77[v142](v13(v77,v142 + ((1 + 0) -0) ,v79[1260 -(1043 + 214) ])));v72=(v140 + v142) -(3 -(6 -4)) ;v138=0 -0 ;for v160=v142,v72 do v138=v138 + (1213 -(323 + 889)) ;v77[v160]=v139[v138];end v71=v71 + (2 -1) ;v79=v67[v71];v142=v79[2 + 0 ];v77[v142]=v77[v142](v13(v77,v142 + (3 -2) + 0 ,v72));v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[1506 -(363 + 1141) ]]();v71=v71 + (581 -(361 + 219)) ;v79=v67[v71];do return;end end elseif ((3382>166) and (v80<=((108 + 218) -((1666 -(1565 + 48)) + 267)))) then do return;end elseif ((v80==(2 + (1023 -(697 + 321)))) or (280==3059)) then v77[v79[415 -(15 + 398) ]]();else local v163=982 -(18 + 964) ;local v164;while true do if (v163==(0 -0)) then v164=v79[2 + 0 ];v77[v164]=v77[v164](v13(v77,v164 + (2 -1) + 0 ,v72));break;end end end v71=v71 + (851 -(20 + 830)) ;break;end if (v87==(0 + 0)) then v79=v67[v71];v80=v79[127 -(116 + 10) ];v87=1 + 0 ;end end end end;end return v29(v28(),{},v17)(...);end return v15("LOL!043Q00030A3Q006C6F616473637269707403043Q0067616D6503073Q00482Q747047657403523Q00682Q7470733A2Q2F7261772E67697468756275736572636F6E74656E742E636F6D2F4B61537045722D74763132332F6B6169662F726566732F68656164732F6D61696E2F706F6E6F73696B2Q32382E6C756100094Q00047Q00122Q000100013Q00122Q000200023Q00202Q00020002000300122Q000400046Q000200046Q00013Q00024Q0001000100016Q00017Q00",v9(),...);