local settings = {
    scanDepth = 3,
    targetTypes = {"Script", "LocalScript", "ModuleScript"},
    logToConsole = true,
    saveToFile = true,
    outputFileName = "ScanReport.txt"
}

-- Переменные для GUI
local logBox, progressBar, depthInput, typeInput

-- Создание GUI
local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "GameScannerGUI"
    gui.Parent = game.CoreGui

    -- Фрейм
    local frame = Instance.new("Frame")
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

    -- Текстовое поле для логов
    logBox = Instance.new("TextBox")
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

    -- Прогресс-бар
    progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 0, 10)
    progressBar.Position = UDim2.new(0, 10, 0.6, 10)
    progressBar.BackgroundColor3 = Color3.new(0.3, 0.6, 0.3)
    progressBar.Parent = frame

    local progressBarBackground = Instance.new("Frame")
    progressBarBackground.Size = UDim2.new(1, -20, 0, 10)
    progressBarBackground.Position = UDim2.new(0, 10, 0.6, 10)
    progressBarBackground.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    progressBarBackground.Parent = frame

    -- Поле ввода глубины
    local depthLabel = Instance.new("TextLabel")
    depthLabel.Text = "Scan Depth:"
    depthLabel.Size = UDim2.new(0, 100, 0, 20)
    depthLabel.Position = UDim2.new(0, 10, 0.75, 0)
    depthLabel.BackgroundTransparency = 1
    depthLabel.TextColor3 = Color3.new(1, 1, 1)
    depthLabel.Font = Enum.Font.SourceSans
    depthLabel.TextSize = 14
    depthLabel.Parent = frame

    depthInput = Instance.new("TextBox")
    depthInput.Size = UDim2.new(0, 50, 0, 20)
    depthInput.Position = UDim2.new(0, 120, 0.75, 0)
    depthInput.Text = tostring(settings.scanDepth)
    depthInput.TextColor3 = Color3.new(1, 1, 1)
    depthInput.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    depthInput.Font = Enum.Font.SourceSans
    depthInput.TextSize = 14
    depthInput.Parent = frame

    -- Поле ввода типов объектов
    local typeLabel = Instance.new("TextLabel")
    typeLabel.Text = "Target Types:"
    typeLabel.Size = UDim2.new(0, 100, 0, 20)
    typeLabel.Position = UDim2.new(0, 10, 0.8, 0)
    typeLabel.BackgroundTransparency = 1
    typeLabel.TextColor3 = Color3.new(1, 1, 1)
    typeLabel.Font = Enum.Font.SourceSans
    typeLabel.TextSize = 14
    typeLabel.Parent = frame

    typeInput = Instance.new("TextBox")
    typeInput.Size = UDim2.new(0, 200, 0, 20)
    typeInput.Position = UDim2.new(0, 120, 0.8, 0)
    typeInput.Text = table.concat(settings.targetTypes, ", ")
    typeInput.TextColor3 = Color3.new(1, 1, 1)
    typeInput.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    typeInput.Font = Enum.Font.SourceSans
    typeInput.TextSize = 14
    typeInput.Parent = frame

    -- Кнопка запуска
    local scanButton = Instance.new("TextButton")
    scanButton.Text = "Start Scan"
    scanButton.Size = UDim2.new(0, 100, 0, 40)
    scanButton.Position = UDim2.new(0.5, -110, 0.9, -20)
    scanButton.BackgroundColor3 = Color3.new(0.3, 0.6, 0.3)
    scanButton.TextColor3 = Color3.new(1, 1, 1)
    scanButton.Font = Enum.Font.SourceSansBold
    scanButton.TextSize = 16
    scanButton.Parent = frame

    -- Кнопка очистки логов
    local clearButton = Instance.new("TextButton")
    clearButton.Text = "Clear Logs"
    clearButton.Size = UDim2.new(0, 100, 0, 40)
    clearButton.Position = UDim2.new(0.5, 10, 0.9, -20)
    clearButton.BackgroundColor3 = Color3.new(0.6, 0.3, 0.3)
    clearButton.TextColor3 = Color3.new(1, 1, 1)
    clearButton.Font = Enum.Font.SourceSansBold
    clearButton.TextSize = 16
    clearButton.Parent = frame

    -- Обработчики кнопок
    scanButton.MouseButton1Click:Connect(function()
        settings.scanDepth = tonumber(depthInput.Text) or settings.scanDepth
        settings.targetTypes = string.split(typeInput.Text, ", ")
        logMessage("Запуск сканирования...")
        scanAndReport()
    end)

    clearButton.MouseButton1Click:Connect(function()
        logBox.Text = ""
    end)

    return gui
end

-- Функция для добавления сообщения в лог
local function logMessage(message)
    if logBox then
        logBox.Text = logBox.Text .. message .. "\n"
        logBox.Text = string.sub(logBox.Text, -5000)
    end
    if settings.logToConsole then
        print(message)
    end
end

-- Обновление прогресс-бара
local function updateProgressBar(progress)
    if progressBar then
        progressBar.Size = UDim2.new(progress, 0, 0, 10)
    end
end

-- Функция для сканирования объектов
local function scan(parent, depth)
    if depth > settings.scanDepth then return {} end
    local results = {}
    local children = parent:GetChildren()
    for i, child in ipairs(children) do
        if table.find(settings.targetTypes, child.ClassName) then
            table.insert(results, {name = child.Name, class = child.ClassName})
            logMessage("Найдено: " .. child.Name .. " (" .. child.ClassName .. ")")
        end
        updateProgressBar(i / #children)
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
