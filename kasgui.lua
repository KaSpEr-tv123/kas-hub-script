-- Custom GUI Library for Roblox

local GuiLibrary = {}

-- Function to apply modern styles to a GUI element
local function applyModernStyles(guiElement)
    guiElement.BackgroundColor3 = Color3.fromRGB(75, 0, 130) -- Purple color
    guiElement.BorderSizePixel = 0
    guiElement.BackgroundTransparency = 0.1
    
    -- Add shadow effect
    local shadow = Instance.new("ImageLabel")
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.Image = "rbxassetid://1316045217" -- Example shadow asset
    shadow.ImageTransparency = 0.5
    shadow.BackgroundTransparency = 1
    shadow.ZIndex = guiElement.ZIndex - 1
    shadow.Parent = guiElement
end

-- Function to create a new GUI window with modern styles
function GuiLibrary:CreateWindow(title, iconId)
    local window = Instance.new("ScreenGui")
    local frame = Instance.new("Frame")
    local icon = Instance.new("ImageLabel")
    
    -- Set up the window
    window.Name = title
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Set up the frame with modern styles
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    applyModernStyles(frame)
    frame.Parent = window
    
    -- Set up the icon
    icon.Size = UDim2.new(0, 50, 0, 50)
    icon.Position = UDim2.new(0, 10, 0, 10)
    icon.Image = "rbxassetid://" .. iconId
    icon.Parent = frame
    
    return window
end

-- Function to toggle the visibility of the GUI window
function GuiLibrary:ToggleWindow(window)
    window.Enabled = not window.Enabled
end

-- Function to make a GUI element draggable
local function makeDraggable(guiElement)
    local dragging = false
    local dragInput, mousePos, framePos
    
    guiElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = guiElement.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    guiElement.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            guiElement.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

-- Function to make a GUI element resizable
local function makeResizable(guiElement)
    local resizing = false
    local resizeInput, startSize, startPos
    
    guiElement.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            startSize = guiElement.Size
            startPos = input.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if resizing then
            local delta = input.Position - startPos
            guiElement.Size = UDim2.new(startSize.X.Scale, startSize.X.Offset + delta.X, startSize.Y.Scale, startSize.Y.Offset + delta.Y)
        end
    end)
end

-- Глобальная иконка для открытия/закрытия главного меню (теперь emoji)
if not GuiLibrary._mainMenuIcon then
    GuiLibrary._mainMenuIcon = Instance.new("TextButton")
    GuiLibrary._mainMenuIcon.Name = "KasHubMenuIcon"
    GuiLibrary._mainMenuIcon.Size = UDim2.new(0, 64, 0, 64)
    GuiLibrary._mainMenuIcon.Position = UDim2.new(0.5, -32, 0.5, -32)
    GuiLibrary._mainMenuIcon.BackgroundTransparency = 0.2
    GuiLibrary._mainMenuIcon.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    GuiLibrary._mainMenuIcon.Text = "😈"
    GuiLibrary._mainMenuIcon.TextSize = 48
    GuiLibrary._mainMenuIcon.TextColor3 = Color3.fromRGB(255,255,255)
    GuiLibrary._mainMenuIcon.Font = Enum.Font.GothamBlack
    GuiLibrary._mainMenuIcon.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    GuiLibrary._mainMenuIcon.ZIndex = 9999
    GuiLibrary._mainMenuIcon.Draggable = true
end

-- Переопределяем CreateDefaultLayout для компактного окна
function GuiLibrary:CreateDefaultLayout()
    local window = Instance.new("ScreenGui")
    window.Name = "Default Layout"
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 500)
    frame.Position = UDim2.new(0.5, -175, 0.5, -250)
    applyModernStyles(frame)
    frame.Parent = window
    -- Titlebar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(100, 0, 180)
    titleBar.Parent = frame
    titleBar.Active = true
    titleBar.Draggable = true
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -40, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = "kas-hub menu"
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -36, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function()
        window.Enabled = false
    end)
    -- Контейнер для контента
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -50)
    contentFrame.Position = UDim2.new(0, 10, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = frame
    makeDraggable(frame)
    -- Изначально скрыто
    window.Enabled = false
    -- Клик по иконке открывает/закрывает меню
    GuiLibrary._mainMenuIcon.MouseButton1Click:Connect(function()
        window.Enabled = not window.Enabled
    end)
    return window
end

-- Example usage
local myLayout = GuiLibrary:CreateDefaultLayout()

-- Keybind to toggle the GUI
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.F and not gameProcessed then
        GuiLibrary:ToggleWindow(myLayout)
    end
end)

-- Function to customize the tab layout
function GuiLibrary:CustomizeTabLayout(window, layoutType, tabSize)
    local tabFrame = window:FindFirstChild("Frame")
    if not tabFrame then return end
    
    if layoutType == "horizontal" then
        tabFrame.Size = UDim2.new(1, 0, 0, tabSize)
        tabFrame.Position = UDim2.new(0, 0, 0, 0)
    else -- default to vertical
        tabFrame.Size = UDim2.new(0, tabSize, 1, 0)
        tabFrame.Position = UDim2.new(0, 0, 0, 0)
    end
end

-- Example usage of customization
GuiLibrary:CustomizeTabLayout(myLayout, "horizontal", 50)

-- Function to create a custom notification
function GuiLibrary:CreateNotification(message, duration)
    local notification = Instance.new("TextLabel")
    notification.Size = UDim2.new(0, 200, 0, 50)
    notification.Position = UDim2.new(0.5, -100, 0, 10)
    notification.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    notification.TextColor3 = Color3.fromRGB(255, 255, 255)
    notification.Text = message
    notification.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    -- Tween to fade out
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
    local tween = tweenService:Create(notification, tweenInfo, {BackgroundTransparency = 1, TextTransparency = 1})
    
    tween:Play()
    tween.Completed:Connect(function()
        notification:Destroy()
    end)
end

-- Example usage of notification
GuiLibrary:CreateNotification("Hello, World!", 3)

-- Таб-менеджер
GuiLibrary._tabs = {}

-- Создание вкладки
function GuiLibrary:AddTab(tabName, iconId)
    local tab = Instance.new("Frame")
    tab.Name = tabName
    tab.Size = UDim2.new(0, 100, 0, 40)
    tab.BackgroundTransparency = 1
    tab.Parent = nil -- будет добавлен в layout

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 24, 0, 24)
    icon.Position = UDim2.new(0, 8, 0, 8)
    icon.BackgroundTransparency = 1
    icon.Image = iconId and ("rbxassetid://"..iconId) or ""
    icon.Parent = tab

    local label = Instance.new("TextLabel")
    label.Text = tabName
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 18
    label.Parent = tab

    -- Добавляем в список вкладок
    table.insert(GuiLibrary._tabs, tab)
    return tab
end

-- Добавление кнопки
function GuiLibrary:AddButton(parent, text, desc, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 36)
    button.Position = UDim2.new(0, 10, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 16
    button.Text = text
    button.AutoButtonColor = true
    button.Parent = parent
    button.MouseButton1Click:Connect(function()
        if callback then callback() end
    end)
    -- Tooltip/desc (по желанию)
    if desc and desc ~= "" then
        button.MouseEnter:Connect(function()
            GuiLibrary:CreateNotification(desc, 2)
        end)
    end
    return button
end

-- Баннер/реклама
function GuiLibrary:SetBanner(text)
    if not self._banner then
        self._banner = Instance.new("TextLabel")
        self._banner.Size = UDim2.new(1, 0, 0, 36)
        self._banner.Position = UDim2.new(0, 0, 0, 0)
        self._banner.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
        self._banner.TextColor3 = Color3.fromRGB(255, 255, 255)
        self._banner.Font = Enum.Font.GothamBlack
        self._banner.TextSize = 20
        self._banner.TextStrokeTransparency = 0.7
        self._banner.TextStrokeColor3 = Color3.fromRGB(80, 0, 160)
        self._banner.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        self._banner.ZIndex = 1000
    end
    self._banner.Text = text
end

-- Добавление тоггла
function GuiLibrary:AddToggle(parent, text, desc, default, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -20, 0, 36)
    toggle.Position = UDim2.new(0, 10, 0, 0)
    toggle.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.Font = Enum.Font.GothamBold
    toggle.TextSize = 16
    toggle.Text = text .. (default and " [ON]" or " [OFF]")
    toggle.AutoButtonColor = true
    toggle.Parent = parent
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

-- Добавление слайдера
function GuiLibrary:AddSlider(parent, text, max, default, callback)
    local sliderFrame = Instance.new("Frame")
    sliderFrame.Size = UDim2.new(1, -20, 0, 36)
    sliderFrame.Position = UDim2.new(0, 10, 0, 0)
    sliderFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    sliderFrame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Text = text .. ": " .. tostring(default)
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = sliderFrame
    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(0.4, -10, 1, -8)
    slider.Position = UDim2.new(0.6, 5, 0, 4)
    slider.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    slider.Text = tostring(default)
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.Font = Enum.Font.GothamBold
    slider.TextSize = 14
    slider.Parent = sliderFrame
    slider.MouseButton1Click:Connect(function()
        local new = tonumber(game:GetService("Players").LocalPlayer:PromptInput("Введите значение (макс. "..max..")"))
        if new and new <= max then
            slider.Text = tostring(new)
            label.Text = text .. ": " .. tostring(new)
            if callback then callback(new) end
        end
    end)
    return sliderFrame
end

-- Добавление инпута
function GuiLibrary:AddInput(parent, text, placeholder, callback)
    local inputFrame = Instance.new("Frame")
    inputFrame.Size = UDim2.new(1, -20, 0, 36)
    inputFrame.Position = UDim2.new(0, 10, 0, 0)
    inputFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    inputFrame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = inputFrame
    local input = Instance.new("TextBox")
    input.Size = UDim2.new(0.6, -10, 1, -8)
    input.Position = UDim2.new(0.4, 5, 0, 4)
    input.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    input.Text = ""
    input.PlaceholderText = placeholder or ""
    input.TextColor3 = Color3.fromRGB(255, 255, 255)
    input.Font = Enum.Font.Gotham
    input.TextSize = 14
    input.Parent = inputFrame
    input.FocusLost:Connect(function(enter)
        if enter and callback then callback(input.Text) end
    end)
    return inputFrame
end

-- Добавление дропдауна
function GuiLibrary:AddDropdown(parent, text, options, callback)
    local dropdownFrame = Instance.new("Frame")
    dropdownFrame.Size = UDim2.new(1, -20, 0, 36)
    dropdownFrame.Position = UDim2.new(0, 10, 0, 0)
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    dropdownFrame.Parent = parent
    local label = Instance.new("TextLabel")
    label.Text = text
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Parent = dropdownFrame
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(0.6, -10, 1, -8)
    dropdown.Position = UDim2.new(0.4, 5, 0, 4)
    dropdown.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    dropdown.Text = options[1] or "Выбрать"
    dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdown.Font = Enum.Font.GothamBold
    dropdown.TextSize = 14
    dropdown.Parent = dropdownFrame
    dropdown.MouseButton1Click:Connect(function()
        -- Простое меню выбора (можно доработать)
        local menu = Instance.new("Frame")
        menu.Size = UDim2.new(0, 120, 0, #options*28)
        menu.Position = UDim2.new(0, dropdown.AbsolutePosition.X, 0, dropdown.AbsolutePosition.Y+36)
        menu.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
        menu.Parent = game.Players.LocalPlayer.PlayerGui
        for i, opt in ipairs(options) do
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 28)
            btn.Position = UDim2.new(0, 0, 0, (i-1)*28)
            btn.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
            btn.Text = opt
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
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
    return dropdownFrame
end

-- Добавление хоткея
function GuiLibrary:AddKeybind(parent, text, desc, callback)
    local keybind = Instance.new("TextButton")
    keybind.Size = UDim2.new(1, -20, 0, 36)
    keybind.Position = UDim2.new(0, 10, 0, 0)
    keybind.BackgroundColor3 = Color3.fromRGB(80, 0, 160)
    keybind.TextColor3 = Color3.fromRGB(255, 255, 255)
    keybind.Font = Enum.Font.GothamBold
    keybind.TextSize = 16
    keybind.Text = text .. " [Key]"
    keybind.AutoButtonColor = true
    keybind.Parent = parent
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

-- Менеджер отдельных окон
GuiLibrary._functionWindows = {}

-- Создание отдельного окна для функции
function GuiLibrary:CreateFunctionWindow(title, iconId)
    local window = Instance.new("ScreenGui")
    window.Name = title .. "Window"
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    applyModernStyles(frame)
    frame.Parent = window
    
    -- Заголовок окна
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(100, 0, 180)
    titleBar.Parent = frame
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 1, 0)
    titleLabel.Position = UDim2.new(0, 10, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.Parent = titleBar
    
    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function()
        window.Enabled = false
    end)
    
    -- Контейнер для контента
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -50)
    contentFrame.Position = UDim2.new(0, 10, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = frame
    
    -- Делаем окно перетаскиваемым
    makeDraggable(frame)
    
    -- Сохраняем окно в менеджере
    GuiLibrary._functionWindows[title] = {
        window = window,
        content = contentFrame,
        isOpen = false
    }
    
    return GuiLibrary._functionWindows[title]
end

-- Открытие/закрытие окна функции
function GuiLibrary:ToggleFunctionWindow(title)
    local windowData = GuiLibrary._functionWindows[title]
    if windowData then
        windowData.isOpen = not windowData.isOpen
        windowData.window.Enabled = windowData.isOpen
        return windowData.isOpen
    end
    return false
end

-- Получение окна функции
function GuiLibrary:GetFunctionWindow(title)
    return GuiLibrary._functionWindows[title]
end

-- Универсальный метод создания кастомного окна
function GuiLibrary:CreateCustomWindow(title, iconId)
    local window = Instance.new("ScreenGui")
    window.Name = title .. "Window"
    window.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    applyModernStyles(frame)
    frame.Parent = window
    -- Titlebar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(100, 0, 180)
    titleBar.Parent = frame
    titleBar.Active = true
    titleBar.Draggable = true
    -- Emoji вместо иконки
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 28, 0, 28)
    icon.Position = UDim2.new(0, 6, 0, 6)
    icon.BackgroundTransparency = 1
    icon.Text = "😈"
    icon.TextSize = 24
    icon.TextColor3 = Color3.fromRGB(255,255,255)
    icon.Font = Enum.Font.GothamBlack
    icon.Parent = titleBar
    -- Заголовок
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -110, 1, 0)
    titleLabel.Position = UDim2.new(0, 40, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 18
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = titleBar
    -- Кнопка свернуть
    local minimizeBtn = Instance.new("TextButton")
    minimizeBtn.Size = UDim2.new(0, 32, 0, 32)
    minimizeBtn.Position = UDim2.new(1, -96, 0, 4)
    minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
    minimizeBtn.Text = "_"
    minimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    minimizeBtn.Font = Enum.Font.GothamBold
    minimizeBtn.TextSize = 24
    minimizeBtn.Parent = titleBar
    -- Кнопка развернуть (максимизация)
    local maximizeBtn = Instance.new("TextButton")
    maximizeBtn.Size = UDim2.new(0, 32, 0, 32)
    maximizeBtn.Position = UDim2.new(1, -64, 0, 4)
    maximizeBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
    maximizeBtn.Text = "☐"
    maximizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeBtn.Font = Enum.Font.GothamBold
    maximizeBtn.TextSize = 20
    maximizeBtn.Parent = titleBar
    -- Кнопка закрытия
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 32, 0, 32)
    closeBtn.Position = UDim2.new(1, -32, 0, 4)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.Parent = titleBar
    -- Контейнер для контента
    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, -20, 1, -50)
    contentFrame.Position = UDim2.new(0, 10, 0, 40)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = frame
    makeDraggable(frame)
    -- Анимация сворачивания/разворачивания
    local minimized = false
    local origSize = frame.Size
    local origContentVisible = true
    minimizeBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            contentFrame.Visible = false
            frame:TweenSize(UDim2.new(origSize.X.Scale, origSize.X.Offset, 0, 40), "Out", "Quad", 0.2, true)
        else
            frame:TweenSize(origSize, "Out", "Quad", 0.2, true)
            contentFrame.Visible = true
        end
    end)
    -- Максимизация/восстановление
    local maximized = false
    local prevSize, prevPos
    maximizeBtn.MouseButton1Click:Connect(function()
        maximized = not maximized
        if maximized then
            prevSize = frame.Size
            prevPos = frame.Position
            frame:TweenSize(UDim2.new(1, -60, 1, -60), "Out", "Quad", 0.2, true)
            frame:TweenPosition(UDim2.new(0, 30, 0, 30), "Out", "Quad", 0.2, true)
        else
            frame:TweenSize(prevSize or origSize, "Out", "Quad", 0.2, true)
            frame:TweenPosition(prevPos or UDim2.new(0.5, -150, 0.5, -200), "Out", "Quad", 0.2, true)
        end
    end)
    -- Закрытие
    closeBtn.MouseButton1Click:Connect(function()
        window.Enabled = false
    end)
    return {
        window = window,
        content = contentFrame,
        close = function() window.Enabled = false end,
        open = function() window.Enabled = true end
    }
end

-- Loading overlay
function GuiLibrary:ShowLoading(text)
    if self._loadingGui then self._loadingGui:Destroy() end
    local loadingGui = Instance.new("ScreenGui")
    loadingGui.Name = "KasHubLoading"
    loadingGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    loadingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(60, 0, 120)
    bg.BackgroundTransparency = 0.3
    bg.Parent = loadingGui
    local spinner = Instance.new("ImageLabel")
    spinner.Size = UDim2.new(0, 64, 0, 64)
    spinner.Position = UDim2.new(0.5, -32, 0.5, -64)
    spinner.BackgroundTransparency = 1
    spinner.Image = "rbxassetid://6031091009" -- стандартный Roblox спиннер
    spinner.Parent = bg
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0, 300, 0, 40)
    label.Position = UDim2.new(0.5, -150, 0.5, 16)
    label.BackgroundTransparency = 1
    label.Text = text or "Загрузка..."
    label.TextColor3 = Color3.fromRGB(220, 180, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 22
    label.Parent = bg
    self._loadingGui = loadingGui
    -- Анимация спиннера
    spawn(function()
        while loadingGui.Parent do
            spinner.Rotation = (spinner.Rotation + 6) % 360
            wait(0.03)
        end
    end)
end

function GuiLibrary:HideLoading()
    if self._loadingGui then self._loadingGui:Destroy() self._loadingGui = nil end
end

-- Error overlay/уведомление
function GuiLibrary:ShowError(text)
    self:CreateNotification("[ОШИБКА] "..text, 5)
    self:LogError(text)
end

-- Окно логов ошибок
function GuiLibrary:LogError(text)
    if not self._errorLogWindow then
        self._errorLogWindow = self:CreateCustomWindow("KasHub Errors", "15074833174")
        self._errorLogWindowLogs = Instance.new("ScrollingFrame")
        self._errorLogWindowLogs.Size = UDim2.new(1, 0, 1, 0)
        self._errorLogWindowLogs.Position = UDim2.new(0, 0, 0, 0)
        self._errorLogWindowLogs.BackgroundTransparency = 1
        self._errorLogWindowLogs.CanvasSize = UDim2.new(0, 0, 0, 0)
        self._errorLogWindowLogs.ScrollBarThickness = 6
        self._errorLogWindowLogs.Parent = self._errorLogWindow.content
    end
    local y = 0
    for _, c in ipairs(self._errorLogWindowLogs:GetChildren()) do
        if c:IsA("TextLabel") then y = y + 26 end
    end
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -8, 0, 24)
    label.Position = UDim2.new(0, 4, 0, y)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 80, 80)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.Text = os.date("[%H:%M:%S] ")..text
    label.Parent = self._errorLogWindowLogs
    self._errorLogWindowLogs.CanvasSize = UDim2.new(0, 0, 0, y+26)
end

return GuiLibrary