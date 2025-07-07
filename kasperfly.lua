local function createFlyGui(windowObj)
	local content = windowObj and windowObj.content
	if not content then return end
	for _, child in ipairs(content:GetChildren()) do child:Destroy() end

	-- Заголовок
	local header = Instance.new("TextLabel")
	header.Size = UDim2.new(1, 0, 0, 36)
	header.Position = UDim2.new(0, 0, 0, 0)
	header.BackgroundTransparency = 1
	header.Text = "KasperFly 2.0"
	header.TextColor3 = Color3.fromRGB(200, 160, 255)
	header.Font = Enum.Font.GothamBlack
	header.TextSize = 22
	header.Parent = content

	-- Кнопка включения/выключения флая
	local flyBtn = Instance.new("TextButton")
	flyBtn.Size = UDim2.new(1, -20, 0, 40)
	flyBtn.Position = UDim2.new(0, 10, 0, 50)
	flyBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
	flyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	flyBtn.Font = Enum.Font.GothamBold
	flyBtn.TextSize = 18
	flyBtn.Text = "Включить флай 🥵"
	flyBtn.Parent = content

	local isFlying = false
	flyBtn.MouseButton1Click:Connect(function()
		isFlying = not isFlying
		flyBtn.Text = isFlying and "Выключить флай" or "Включить флай 🥵"
		-- Здесь логика включения/выключения флая
		if isFlying then
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = "KasperFly", Text = "Флай включён!", Duration = 2})
		else
			game:GetService("StarterGui"):SetCore("SendNotification", {Title = "KasperFly", Text = "Флай выключен!", Duration = 2})
		end
	end)

	-- Слайдер скорости
	local speedLabel = Instance.new("TextLabel")
	speedLabel.Size = UDim2.new(0.5, -15, 0, 32)
	speedLabel.Position = UDim2.new(0, 10, 0, 100)
	speedLabel.BackgroundTransparency = 1
	speedLabel.Text = "Скорость: 1x"
	speedLabel.TextColor3 = Color3.fromRGB(220, 180, 255)
	speedLabel.Font = Enum.Font.Gotham
	speedLabel.TextSize = 16
	speedLabel.Parent = content

	local plusBtn = Instance.new("TextButton")
	plusBtn.Size = UDim2.new(0, 40, 0, 32)
	plusBtn.Position = UDim2.new(0.5, 5, 0, 100)
	plusBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	plusBtn.Text = "➕"
	plusBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	plusBtn.Font = Enum.Font.GothamBold
	plusBtn.TextSize = 20
	plusBtn.Parent = content

	local minusBtn = Instance.new("TextButton")
	minusBtn.Size = UDim2.new(0, 40, 0, 32)
	minusBtn.Position = UDim2.new(0.5, 55, 0, 100)
	minusBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 80)
	minusBtn.Text = "➖"
	minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	minusBtn.Font = Enum.Font.GothamBold
	minusBtn.TextSize = 20
	minusBtn.Parent = content

	local speedValue = 1
	plusBtn.MouseButton1Click:Connect(function()
		speedValue = speedValue + 1
		speedLabel.Text = "Скорость: " .. tostring(speedValue) .. "x"
	end)
	minusBtn.MouseButton1Click:Connect(function()
		if speedValue > 1 then
			speedValue = speedValue - 1
			speedLabel.Text = "Скорость: " .. tostring(speedValue) .. "x"
	end
end)

	-- Минимизация
	local miniBtn = Instance.new("TextButton")
	miniBtn.Size = UDim2.new(0, 40, 0, 32)
	miniBtn.Position = UDim2.new(1, -50, 0, 10)
	miniBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
	miniBtn.Text = "_"
	miniBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
	miniBtn.Font = Enum.Font.GothamBold
	miniBtn.TextSize = 24
	miniBtn.Parent = content
	local minimized = false
	miniBtn.MouseButton1Click:Connect(function()
		minimized = not minimized
		for _, el in ipairs(content:GetChildren()) do
			if el ~= header and el ~= miniBtn then
				el.Visible = not minimized
			end
		end
		miniBtn.Text = minimized and "[]" or "_"
	end)

	-- Кастомный футер
	local footer = Instance.new("TextLabel")
	footer.Size = UDim2.new(1, 0, 0, 24)
	footer.Position = UDim2.new(0, 0, 1, -24)
	footer.BackgroundTransparency = 1
	footer.Text = "kasperfly | v2.0"
	footer.TextColor3 = Color3.fromRGB(180, 120, 255)
	footer.Font = Enum.Font.Gotham
	footer.TextSize = 14
	footer.Parent = content
end

-- Экспортируем функцию toggle
return {
	toggle = function(windowObj)
		createFlyGui(windowObj)
		if windowObj then windowObj.open() end
	end
}