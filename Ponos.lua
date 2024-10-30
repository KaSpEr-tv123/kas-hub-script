local Player = game.Players.LocalPlayer
local TPS = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Desc&limit=100" -- Начинаем с первого запроса

local minPlayers = 5
local maxPlayers = 11

local function hop()
    -- Проверяем, доступно ли событие для отправки сообщения в чат
    local chatEvent = game.ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
    if chatEvent and chatEvent:FindFirstChild("SayMessageRequest") then
        chatEvent.SayMessageRequest:FireServer("if you 30m bounty player add me in ds yupi_yoshka_nyah_ill", "All")
        print("Сообщение отправлено в чат")
    else
        warn("Событие SayMessageRequest недоступно или заблокировано")
    end

    -- Создаем ScreenGui и TextLabel для отображения уведомления
    local screenGui = Instance.new("ScreenGui")
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 0.5
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = "Ищем сервер с подходящим количеством игроков..."
    textLabel.TextScaled = true
    textLabel.Parent = screenGui
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    wait(5)
    screenGui:Destroy()

    -- Функция для получения списка серверов
    local function ListServers()
        local validServers = {}
        local cursor = nil
        local totalAttempts = 5 -- Количество попыток получить больше серверов
        local attempts = 0

        repeat
            local Raw = game:HttpGet(_servers .. ((cursor and "&cursor=" .. cursor) or ""))
            local Servers = HttpService:JSONDecode(Raw)
            if Servers then
                print("Список серверов получен, всего серверов:", #Servers.data)
                for _, server in ipairs(Servers.data) do
                    if server.playing >= minPlayers and server.playing <= maxPlayers and server.id ~= game.JobId then
                        table.insert(validServers, server)
                        print("Подходящий сервер найден:", server.id, "Игроков:", server.playing)
                    end
                end
                cursor = Servers.nextPageCursor -- Получаем курсор для следующей страницы
                attempts = attempts + 1
            else
                warn("Не удалось получить данные серверов")
                return nil
            end
        until not cursor or attempts >= totalAttempts -- Прекращаем, если курсор отсутствует или достигли максимальных попыток

        return validServers
    end

    -- Отключаем перемещение персонажа для безопасности
    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
        Player.Character.HumanoidRootPart.Anchored = true
    end

    -- Получаем список серверов и проверяем, что данные не пустые
    local validServers = ListServers()
    if not validServers or #validServers == 0 then
        warn("Ошибка получения серверов или список пуст")
        return
    end

    -- Сортируем сервера по количеству игроков в порядке убывания
    table.sort(validServers, function(a, b)
        return a.playing > b.playing
    end)

    -- Телепортируемся на сервер
    if #validServers > 0 then
        local Server = validServers[1] -- Берем сервер с наибольшим количеством игроков
        print("Телепортируемся на сервер:", Server.id)
        TPS:TeleportToPlaceInstance(_place, Server.id)
    else
        warn("Нет доступных серверов для телепортации с заданным количеством игроков")
    end
end

-- Запуск функции hop каждые 6 секунд
while wait(6) do
    hop()
end