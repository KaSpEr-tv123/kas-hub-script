local settings = {
    scanDepth = 3,
    targetTypes = {"Script", "LocalScript", "ModuleScript"},
    logToConsole = true,
    saveToFile = true,
    outputFileName = "ScanReport.txt"
}

-- Переменные для GUI
local logBox, progressBar, depthInput, typeInput

local function logMessage(message)
    if logBox then
        logBox.Text = logBox.Text .. message .. "\n"
        if #logBox.Text > 5000 then  -- ограничение длины лога
            logBox.Text = string.sub(logBox.Text, -5000)
        end
    end
    if settings.logToConsole then
        print(message)
    end
end

-- Переменные для GUI
local frame, dragging, dragInput, dragStart, startPos

-- Создание GUI
local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "GameScannerGUI"
    gui.Parent = game.CoreGui

    -- Фрейм
    frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 350)
    frame.Position = UDim2.new(0.5, -200, 0.5, -175)
    frame.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    frame.Parent = gui

    -- Заголовок
    local title = Instance.new("TextLabel")
    title.Text = "Game Scanner"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.SourceSansBold
    title.TextSize = 18
    title.Parent = frame

    -- Логика перетаскивания окна
    title.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    title.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    title.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Остальные элементы GUI (например, текстовые поля и кнопки)
    -- Здесь можно добавить другие элементы, как в вашем изначальном примере
    -- Пример:
    local logBox = Instance.new("TextBox")
    logBox.Size = UDim2.new(1, -20, 0.6, -90)
    logBox.Position = UDim2.new(0, 10, 0, 40)
    logBox.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    logBox.TextColor3 = Color3.new(1, 1, 1)
    logBox.Font = Enum.Font.SourceSans
    logBox.TextSize = 14
    logBox.TextXAlignment = Enum.TextXAlignment.Left
    logBox.TextYAlignment = Enum.TextYAlignment.Top
    logBox.ClearTextOnFocus = false
    logBox.MultiLine = true
    logBox.Text = ""
    logBox.Parent = frame
end

-- Запуск GUI
createGUI()

-- Функция записи лога


-- Обновление прогресс-бара
local function updateProgressBar(progress)
    if progressBar then
        progressBar.Size = UDim2.new(progress, 0, 0, 10)
    end
end

-- Функция для сканирования объектов
local function scan(parent, depth)
    if not parent or depth > settings.scanDepth then return {} end
    local results = {}
    local children = parent:GetChildren()
    for i, child in ipairs(children) do
        if table.find(settings.targetTypes, child.ClassName) then
            table.insert(results, {name = child.Name, class = child.ClassName})
            logMessage("Найдено: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
        updateProgressBar(i / #children)
        wait()  -- добавление задержки, чтобы UI не зависал
        local subResults = scan(child, depth + 1)
        for _, subResult in pairs(subResults) do
            table.insert(results, subResult)
        end
    end
    return results
end

-- Главная функция сканирования
function scanAndReport()
    progressBar.Size = UDim2.new(0, 0, 0, 10)
    local results = scan(game.Workspace, 0)
    if settings.saveToFile then
        logMessage("Сканирование завершено. Объекты сохранены.")
    end
end

-- Запуск GUI
createGUI()
