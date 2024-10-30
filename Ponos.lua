local Player = game.Players.LocalPlayer
local TPS = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=10"

local minPlayers = 5
local maxPlayers = 10

local function hop()
game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer("ПОНОС", "All")
-- Создаем ScreenGui и TextLabel
local screenGui = Instance.new("ScreenGui")
local textLabel = Instance.new("TextLabel")

-- Настраиваем TextLabel
textLabel.Size = UDim2.new(1, 0, 1, 0) -- На весь экран
textLabel.BackgroundTransparency = 0.5 -- Прозрачность фона (0 - непрозрачный, 1 - полностью прозрачный)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Черный фон
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255) -- Белый текст
textLabel.Text = "Сообщение в чат отправлено, телепорт на следующий сервер..."
textLabel.TextScaled = true -- Масштабирование текста под размер
textLabel.Parent = screenGui

-- Встраиваем ScreenGui в игрока
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Настраиваем длительность показа уведомления
local notificationDuration = 5 -- Уведомление будет видно 5 секунды

-- Удаляем уведомление через указанное время
wait(notificationDuration)
screenGui:Destroy()
function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
    return HttpService:JSONDecode(Raw)
end

-- Отключаем перемещение персонажа
if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
    Player.Character.HumanoidRootPart.Anchored = true
end

local Servers = ListServers()
local validServers = {}

-- Фильтруем сервера по количеству игроков
for _, server in ipairs(Servers.data) do
    if server.playing >= minPlayers and server.playing <= maxPlayers and server.id ~= game.JobId then
        table.insert(validServers, server)
    end
end

-- Проверяем, что есть подходящие сервера
if #validServers > 0 then
    local Server = validServers[math.random(1, #validServers)]
    TPS:TeleportToPlaceInstance(_place, Server.id)
else
    print("Нет доступных серверов с подходящим количеством игроков")
end

end