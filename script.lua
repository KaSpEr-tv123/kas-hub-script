local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local player = game.Players.LocalPlayer
local Window = OrionLib:MakeWindow({Name = "Ҝ卂丂 卄ㄩ乃", HidePremium = false, SaveConfig = false, IntroEnabled = true, IntroText="Ҝ卂丂 卄ㄩ乃 script is loading...", IntroIcon="https://cdn.discordapp.com/icons/1001137956280615023/c8eaab1cf61154d18fac6bea60c683ec.png?size=1024", Icon="https://cdn.discordapp.com/icons/1001137956280615023/c8eaab1cf61154d18fac6bea60c683ec.png?size=1024"})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://15046690373",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

--[[
Title = <string> - The title of the notification.
Content = <string> - The content of the notification.
Image = <string> - The icon of the notification.
Time = <number> - The duration of the notfication.
]]

local Section = Tab:AddSection({
	Name = "Hacks"
})

--[[
Name = <string> - The name of the section.
]]



local Speed = Tab:AddSlider({
	Name = "SpeedHack",
	Min = 0,
	Max = 500,
	Default = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed value",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end
})
Tab:AddDropdown({
	Name = "Change speed",
	Default = "+1",
	Options = {"+1", "+5", "+10", "+20", "+40","+80", "+160", "+320", "-1", "-5", "-10", "-20", "-40","-80", "-160", "-320"},
	Callback = function(Value)
		if Value == "+1" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 1)
    elseif Value == "+5" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 5)
    elseif Value == "+10" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 10)
    elseif Value == "+20" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 20)
    elseif Value == "+40" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 40)
    elseif Value == "+80" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 80)
    elseif Value == "+160" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 160)
    elseif Value == "+320" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed + 320)
		elseif Value == "-1" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 1)
    elseif Value == "-5" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 5)
    elseif Value == "-10" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 10)
    elseif Value == "-20" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 20)
    elseif Value == "-40" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 40)
    elseif Value == "-80" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 80)
    elseif Value == "-160" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 160)
    elseif Value == "-320" then
      Speed:Set(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed - 320)
    end
	end    
})

--[[
Name = <string> - The name of the dropdown.
Default = <string> - The default value of the dropdown.
Options = <table> - The options in the dropdown.
Callback = <function> - The function of the dropdown.
]]
--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]
local Jump = Tab:AddSlider({
	Name = "JumpHack",
	Min = 0,
	Max = 500,
	Default = game.Players.LocalPlayer.Character.Humanoid.JumpPower,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Jump value",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
  end
})
Tab:AddDropdown({
	Name = "Change jump power",
	Default = "+1",
	Options = {"+1", "+5", "+10", "+20", "+40","+80", "+160", "+320", "-1", "-5", "-10", "-20", "-40","-80", "-160", "-320"},
	Callback = function(Value)
		if Value == "+1" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 1)
    elseif Value == "+5" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 5)
    elseif Value == "+10" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 10)
    elseif Value == "+20" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 20)
    elseif Value == "+40" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 40)
    elseif Value == "+80" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 80)
    elseif Value == "+160" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 160)
    elseif Value == "+320" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower + 320)
		elseif Value == "-1" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 1)
    elseif Value == "-5" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 5)
    elseif Value == "-10" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 10)
    elseif Value == "-20" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 20)
    elseif Value == "-40" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 40)
    elseif Value == "-80" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 80)
    elseif Value == "-160" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 160)
    elseif Value == "-320" then
      Jump:Set(game.Players.LocalPlayer.Character.Humanoid.JumpPower - 320)
    end
	end    
})

--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Callback = <function> - The function of the slider.
]]

Tab:AddSection({Name = "Other"})
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local mode_fly = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if mode_fly then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

Tab:AddToggle({
    Name = "Inf Jump",
    Default = false,
    Callback = function(Value)
        mode_fly = Value
    end
})

local function ToggleNoclip(enabled)
    Clipon = enabled
    if enabled then
        for a, b in pairs(Workspace:GetChildren()) do
            if b.Name == Plr.Name then
                for i, v in pairs(b:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end
    else
        for a, b in pairs(Workspace:GetChildren()) do
            if b.Name == Plr.Name then
                for i, v in pairs(b:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                    end
                end
            end
        end
    end
end

local mode_tp = false
local lastClickedPosition = nil

local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Equip to Click TP"

Tab:AddToggle({
    Name = "Click TP",
    Default = false,
    Callback = function(Value)
        mode_tp = Value
    end
})

local mouse = game.Players.LocalPlayer:GetMouse()

tool.Activated:Connect(function()
    local pos = mouse.Hit.Position + Vector3.new(0, 2.5, 0)
    local character = game.Players.LocalPlayer.Character
    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
    
    if mode_tp and humanoidRootPart then
        humanoidRootPart.CFrame = CFrame.new(pos)
    end
end)

tool.Parent = game.Players.LocalPlayer.Backpack

Tab:AddToggle({
    Name = "Noclip",
    Default = false,
    Callback = function(Value)
        ToggleNoclip(Value)
    end
})
OrionLib:MakeNotification({
	Name = "Ҝ卂丂 卄ㄩ乃 has loaded",
	Content = "Thanks for using this script😀",
	Image = "rbxassetid://15046690373",
	Time = 5
})

OrionLib:Init()