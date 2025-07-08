-- Новый современный GuiLibrary для главного меню с вкладками
local GuiLibrary = {}

print("[kasgui.lua] Модуль загружен (новая архитектура)")

-- Палитра
local MAIN_COLOR = Color3.fromRGB(120, 0, 200)
local GRAD_COLOR = Color3.fromRGB(180, 80, 255)
local TITLE_COLOR = Color3.fromRGB(100, 0, 180)
local TAB_COLOR = Color3.fromRGB(80, 0, 160)
local TAB_ACTIVE = Color3.fromRGB(180, 80, 255)
local WHITE = Color3.fromRGB(255,255,255)

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
    titleBar.Active = true
    titleBar.Draggable = true

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

-- Добавление кнопки
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
    return button
end

-- Добавление слайдера
function GuiLibrary:AddSlider(parent, text, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 44)
    frame.Position = UDim2.new(0, 10, 0, #parent:GetChildren()*48)
    frame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    frame.Parent = parent
    frame.ZIndex = 13
    local label = Instance.new("TextLabel")
    label.Text = text .. ": " .. tostring(default)
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 15
    label.Parent = frame
    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0.5, -10, 1, -8)
    slider.Position = UDim2.new(0.5, 5, 0, 4)
    slider.BackgroundColor3 = MAIN_COLOR
    slider.Text = tostring(default)
    slider.TextColor3 = WHITE
    slider.Font = Enum.Font.GothamBold
    slider.TextSize = 15
    slider.Parent = frame
    slider.ZIndex = 14
    slider.MouseButton1Click:Connect(function()
        local new = tonumber(game:GetService("Players").LocalPlayer:PromptInput("Введите значение (макс. "..max..")"))
        if new and new <= max then
            slider.Text = tostring(new)
            label.Text = text .. ": " .. tostring(new)
            if callback then callback(new) end
        end
    end)
    return frame
end

-- Добавление тоггла
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
    return toggle
end

-- Добавление инпута
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

-- Добавление дропдауна
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

-- Добавление хоткея
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

-- Открытие/закрытие главного меню
function GuiLibrary:ToggleWindow()
    screenGui.Enabled = not screenGui.Enabled
end

-- Экспорт
return GuiLibrary