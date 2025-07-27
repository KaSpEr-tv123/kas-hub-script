-- Новый современный GuiLibrary для главного меню с вкладками
local GuiLibrary = {}

print("[kasgui.lua] Модуль загружен (новая архитектура)")

-- Обновленная палитра
local MAIN_COLOR = Color3.fromRGB(100, 150, 250)
local GRAD_COLOR = Color3.fromRGB(150, 200, 255)
local TITLE_COLOR = Color3.fromRGB(80, 130, 230)
local TAB_COLOR = Color3.fromRGB(60, 110, 210)
local TAB_ACTIVE = Color3.fromRGB(150, 200, 255)
local WHITE = Color3.fromRGB(255, 255, 255)

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KasHubMainGui"
screenGui.Parent = game:GetService("CoreGui")
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame-контейнер
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 420, 0, 540)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -270)
mainFrame.BackgroundColor3 = MAIN_COLOR
mainFrame.BackgroundTransparency = 0.08
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.ZIndex = 10
mainFrame.Active = true
mainFrame.Draggable = true

-- Градиент
local grad = Instance.new("UIGradient")
grad.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, GRAD_COLOR),
    ColorSequenceKeypoint.new(1, MAIN_COLOR)
}
grad.Rotation = 45
grad.Parent = mainFrame

-- Тень
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Size = UDim2.new(1, 32, 1, 32)
shadow.Position = UDim2.new(0, -16, 0, -16)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://1316045217"
shadow.ImageTransparency = 0.7
shadow.ZIndex = 9
shadow.Parent = mainFrame

-- TitleBar
    local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 48)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = TITLE_COLOR
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
titleBar.ZIndex = 11

    local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -48, 1, 0)
titleLabel.Position = UDim2.new(0, 16, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "kas-hub menu"
titleLabel.TextColor3 = WHITE
    titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 22
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
titleLabel.ZIndex = 12

    local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -44, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
closeBtn.TextColor3 = WHITE
    closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 22
    closeBtn.Parent = titleBar
closeBtn.ZIndex = 13
    closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false
end)

-- TabBar
local tabBar = Instance.new("Frame")
tabBar.Name = "TabBar"
tabBar.Size = UDim2.new(0, 120, 1, -48)
tabBar.Position = UDim2.new(0, 0, 0, 48)
tabBar.BackgroundColor3 = TAB_COLOR
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame
tabBar.ZIndex = 11

-- ContentFrame (контейнер для контента вкладок)
    local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -120, 1, -48)
contentFrame.Position = UDim2.new(0, 120, 0, 48)
    contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame
contentFrame.ZIndex = 11

-- Таб-менеджер
local tabs = {}
local activeTab = nil

-- Добавление анимации для открытия/закрытия окна
function GuiLibrary:ToggleWindow()
    if screenGui.Enabled then
        mainFrame:TweenSize(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.3, true, function()
            screenGui.Enabled = false
        end)
    else
        screenGui.Enabled = true
        mainFrame:TweenSize(UDim2.new(0, 420, 0, 540), "Out", "Quad", 0.3, true)
    end
end

-- Добавление анимации для переключения вкладок
function GuiLibrary:AddTab(tabName, iconId)
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 48)
    tabBtn.Position = UDim2.new(0, 0, 0, #tabs*52)
    tabBtn.BackgroundColor3 = TAB_COLOR
    tabBtn.TextColor3 = WHITE
    tabBtn.Font = Enum.Font.GothamBold
    tabBtn.TextSize = 18
    tabBtn.Text = tabName
    tabBtn.Parent = tabBar
    tabBtn.ZIndex = 12
    tabBtn.AutoButtonColor = true
    -- Иконка (если есть)
    if iconId then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 28, 0, 28)
        icon.Position = UDim2.new(0, 8, 0, 10)
        icon.BackgroundTransparency = 1
        icon.Image = "rbxassetid://"..iconId
        icon.Parent = tabBtn
        icon.ZIndex = 13
    end
    -- Контент для вкладки
    local tabContent = Instance.new("Frame")
    tabContent.Name = tabName.."Content"
    tabContent.Size = UDim2.new(1, 0, 1, 0)
    tabContent.Position = UDim2.new(0, 0, 0, 0)
    tabContent.BackgroundTransparency = 1
    tabContent.Visible = false
    tabContent.Parent = contentFrame
    tabContent.ZIndex = 12
    -- Переключение вкладки
    tabBtn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.btn.BackgroundColor3 = TAB_COLOR
            t.content.Visible = false
        end
        tabBtn.BackgroundColor3 = TAB_ACTIVE
        tabContent.Visible = true
        activeTab = tabContent
        tabContent:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.2, true)
    end)
    -- Добавляем в список
    table.insert(tabs, {btn = tabBtn, content = tabContent})
    -- Если это первая вкладка — активируем
    if #tabs == 1 then
        tabBtn.BackgroundColor3 = TAB_ACTIVE
        tabContent.Visible = true
        activeTab = tabContent
    end
    return tabContent
end

-- Обновление кнопок
function GuiLibrary:AddButton(parent, text, desc, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*44)
    button.BackgroundColor3 = MAIN_COLOR
    button.TextColor3 = WHITE
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = text
    button.AutoButtonColor = true
    button.Parent = parent
    button.ZIndex = 13
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    if desc and desc ~= "" then
        button.MouseEnter:Connect(function()
            GuiLibrary:CreateNotification(desc, 2)
        end)
    end
    -- Анимация нажатия
    button.MouseButton1Down:Connect(function()
        button:TweenSize(UDim2.new(1, -24, 0, 36), "Out", "Quad", 0.1, true)
    end)
    button.MouseButton1Up:Connect(function()
        button:TweenSize(UDim2.new(1, -20, 0, 40), "Out", "Quad", 0.1, true)
    end)
    return button
end

-- Обновление слайдеров
function GuiLibrary:AddSlider(parent, text, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 54)
    frame.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*58)
    frame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    frame.Parent = parent
    frame.ZIndex = 13

    local label = Instance.new("TextLabel")
    label.Text = text .. ": " .. tostring(default)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.Parent = frame

    local sliderBar = Instance.new("Frame")
    sliderBar.Size = UDim2.new(1, -40, 0, 8)
    sliderBar.Position = UDim2.new(0, 20, 0, 28)
    sliderBar.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    sliderBar.BorderSizePixel = 0
    sliderBar.Parent = frame
    sliderBar.ZIndex = 14

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default/max), 0, 1, 0)
    fill.Position = UDim2.new(0, 0, 0, 0)
    fill.BackgroundColor3 = Color3.fromRGB(180, 80, 255)
    fill.BorderSizePixel = 0
    fill.Parent = sliderBar
    fill.ZIndex = 15

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 18, 0, 18)
    knob.Position = UDim2.new((default/max), -9, 0.5, -9)
    knob.BackgroundColor3 = Color3.fromRGB(255,255,255)
    knob.BorderSizePixel = 0
    knob.Parent = sliderBar
    knob.ZIndex = 16
    knob.Active = true

    local dragging = false
    local value = default

    local function setValueFromX(x)
        local rel = math.clamp((x - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
        value = math.floor(rel * max + 0.5)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -9, 0.5, -9)
        label.Text = text .. ": " .. tostring(value)
        if callback then callback(value) end
    end

    knob.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    knob.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            setValueFromX(input.Position.X)
        end
    end)
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            setValueFromX(input.Position.X)
        end
    end)
    game:GetService("UserInputService").InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return frame
end

-- Обновление тогглов
function GuiLibrary:AddToggle(parent, text, desc, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -20, 0, 40)
    toggle.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*44)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    toggle.TextColor3 = WHITE
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 16
    toggle.Text = text .. (default and " [ON]" or " [OFF]")
    toggle.AutoButtonColor = true
    toggle.Parent = parent
    toggle.ZIndex = 13
    local state = default
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text .. (state and " [ON]" or " [OFF]")
        if callback then callback(state) end
    end)
    if desc and desc ~= "" then
        toggle.MouseEnter:Connect(function()
            GuiLibrary:CreateNotification(desc, 2)
        end)
    end
    -- Анимация переключения
    toggle.MouseButton1Down:Connect(function()
        toggle:TweenSize(UDim2.new(1, -24, 0, 36), "Out", "Quad", 0.1, true)
    end)
    toggle.MouseButton1Up:Connect(function()
        toggle:TweenSize(UDim2.new(1, -20, 0, 40), "Out", "Quad", 0.1, true)
    end)
    return toggle
end

-- Обновление инпутов
function GuiLibrary:AddInput(parent, text, placeholder, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*44)
    frame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    frame.Parent = parent
    frame.ZIndex = 13
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.6, -10, 1, -8)
    input.Position = UDim2.new(0.4, 5, 0, 4)
    input.BackgroundColor3 = MAIN_COLOR
    input.Text = ""
    input.PlaceholderText = placeholder or ""
    input.TextColor3 = WHITE
    input.Font = Enum.Font.Gotham
    input.TextSize = 14
    input.Parent = frame
    input.ZIndex = 14
    input.FocusLost:Connect(function(enter)
        if enter and callback then callback(input.Text) end
    end)
    return frame
end

-- Обновление дропдаунов
function GuiLibrary:AddDropdown(parent, text, options, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 40)
    frame.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*44)
    frame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    frame.Parent = parent
    frame.ZIndex = 13
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = frame
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.6, -10, 1, -8)
    dropdown.Position = UDim2.new(0.4, 5, 0, 4)
    dropdown.BackgroundColor3 = MAIN_COLOR
    dropdown.Text = options[1] or "Выбрать"
    dropdown.TextColor3 = WHITE
    dropdown.Font = Enum.Font.GothamBold
    dropdown.TextSize = 14
    dropdown.Parent = frame
    dropdown.ZIndex = 14
    dropdown.MouseButton1Click:Connect(function()
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 120, 0, #options*28)
        menu.Position = UDim2.new(0, dropdown.AbsolutePosition.X, 0, dropdown.AbsolutePosition.Y+36)
        menu.BackgroundColor3 = TAB_COLOR
        menu.Parent = game:GetService("CoreGui")
        for i, opt in ipairs(options) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 28)
            btn.Position = UDim2.new(0, 0, 0, (i-1)*28)
            btn.BackgroundColor3 = MAIN_COLOR
            btn.Text = opt
            btn.TextColor3 = WHITE
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Parent = menu
            btn.MouseButton1Click:Connect(function()
                dropdown.Text = opt
                if callback then callback(opt) end
                menu:Destroy()
            end)
        end
    end)
    return frame
end

-- Обновление хоткеев
function GuiLibrary:AddKeybind(parent, text, desc, callback)
    local keybind = Instance.new("TextButton")
    keybind.Size = UDim2.new(1, -20, 0, 40)
    keybind.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*44)
    keybind.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    keybind.TextColor3 = WHITE
    keybind.Font = Enum.Font.GothamBold
    keybind.TextSize = 16
    keybind.Text = text .. " [Key]"
    keybind.AutoButtonColor = true
    keybind.Parent = parent
    keybind.ZIndex = 13
    keybind.MouseButton1Click:Connect(function()
        keybind.Text = text .. " [Нажмите клавишу]"
        local conn
        conn = game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
            if not gpe then
                keybind.Text = text .. " ["..input.KeyCode.Name.."]"
                if callback then callback(input) end
                conn:Disconnect()
            end
        end)
    end)
    if desc and desc ~= "" then
        keybind.MouseEnter:Connect(function()
            GuiLibrary:CreateNotification(desc, 2)
        end)
    end
    -- Анимация нажатия
    keybind.MouseButton1Down:Connect(function()
        keybind:TweenSize(UDim2.new(1, -24, 0, 36), "Out", "Quad", 0.1, true)
    end)
    keybind.MouseButton1Up:Connect(function()
        keybind:TweenSize(UDim2.new(1, -20, 0, 40), "Out", "Quad", 0.1, true)
    end)
    return keybind
end

-- Уведомления
function GuiLibrary:CreateNotification(message, duration)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 320, 0, 48)
    notification.Position = UDim2.new(0.5, -160, 0, 80)
    notification.BackgroundColor3 = MAIN_COLOR
    notification.TextColor3 = WHITE
    notification.Text = message
    notification.Parent = screenGui
    notification.ZIndex = 10001
    notification.BackgroundTransparency = 0.1
    notification.Font = Enum.Font.GothamBold
    notification.TextSize = 18
    notification.TextStrokeTransparency = 0.7
    notification.TextStrokeColor3 = Color3.fromRGB(80, 0, 160)
    -- Анимация исчезновения
    spawn(function()
        wait(duration or 2)
        for i = 1, 10 do
            notification.TextTransparency = i*0.1
            notification.BackgroundTransparency = 0.1 + i*0.09
            wait(0.03)
        end
        notification:Destroy()
    end)
end

-- Функция для смены размера главного окна
function GuiLibrary:SetMainWindowSize(sizeName)
    local sizes = {
        Small = {size = UDim2.new(0, 320, 0, 360), pos = UDim2.new(0.5, -160, 0.5, -180)},
        Medium = {size = UDim2.new(0, 420, 0, 540), pos = UDim2.new(0.5, -210, 0.5, -270)},
        Large = {size = UDim2.new(0, 600, 0, 700), pos = UDim2.new(0.5, -300, 0.5, -350)}
    }
    local preset = sizes[sizeName] or sizes["Medium"]
    mainFrame:TweenSize(preset.size, "Out", "Quad", 0.18, true)
    mainFrame:TweenPosition(preset.pos, "Out", "Quad", 0.18, true)
end

-- Пример использования (добавить в нужную вкладку):
-- GuiLibrary:AddDropdown(otherTab, "Размер окна", {"Small", "Medium", "Large"}, function(opt)
--     GuiLibrary:SetMainWindowSize(opt)
-- end)

-- Экспорт
function GuiLibrary:CreateWindow(title)
    local win = Instance.new("Frame")
    win.Size = UDim2.new(0, 340, 0, 320)
    win.Position = UDim2.new(0.5, -170, 0.5, -160)
    win.BackgroundColor3 = MAIN_COLOR
    win.BackgroundTransparency = 0.08
    win.BorderSizePixel = 0
    win.Parent = game:GetService("CoreGui")
    win.ZIndex = 100
    win.Active = true
    win.Draggable = true

    local grad = Instance.new("UIGradient")
    grad.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, GRAD_COLOR),
        ColorSequenceKeypoint.new(1, MAIN_COLOR)
    }
    grad.Rotation = 45
    grad.Parent = win

    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.BackgroundColor3 = TITLE_COLOR
    titleBar.Parent = win
    titleBar.ZIndex = 101

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = WHITE
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    titleLabel.ZIndex = 102

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -36, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = WHITE
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 18
    closeBtn.Parent = titleBar
    closeBtn.ZIndex = 103
    closeBtn.MouseButton1Click:Connect(function()
        win.Visible = false
    end)

    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -50)
    content.Position = UDim2.new(0, 10, 0, 40)
    content.BackgroundTransparency = 1
    content.Parent = win
    content.ZIndex = 101

    win.Visible = false

    return {
        window = win,
        content = content,
        open = function() win.Visible = true end,
        close = function() win.Visible = false end
    }
end

return GuiLibrary