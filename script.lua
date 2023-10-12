local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

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



Tab:AddSlider({
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

Tab:AddSlider({
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

--[[
Name = <string> - The name of the slider.
Min = <number> - The minimal value of the slider.
Max = <number> - The maxium value of the slider.
Increment = <number> - How much the slider will change value when dragging.
Default = <number> - The default value of the slider.
ValueName = <string> - The text after the value number.
Callback = <function> - The function of the slider.
]]

OrionLib:MakeNotification({
	Name = "Ҝ卂丂 卄ㄩ乃 has loaded",
	Content = "Thanks for using this script😀",
	Image = "rbxassetid://15046690373",
	Time = 5
})

OrionLib:Init()