local Player = game.Players.LocalPlayer
local TPS = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Api = "https://games.roblox.com/v1/games/"
local _place = game.PlaceId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Asc&limit=10"

local minPlayers = 5  -- Минимальное количество игроков
local maxPlayers = 15 -- Максимальное количество игроков

-- Функция для получения списка серверов
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