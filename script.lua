local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local player = game.Players.LocalPlayer
local window = gui:Load("Ҝ卂丂 卄ㄩ乃", "15074833174")

local hacks = gui.newTab("Hacks", "15046690373")


hacks.newSlider("SpeedHack", "Change youre speed", 1000, false, function(num)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = num
end)

hacks.newSlider("JumpHack", "Change youre jump power", 1000, false, function(num)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = num
end)

local other = gui.newTab("Other", "15046690373")
local player = game.Players.LocalPlayer
local humanoid = player.Character:WaitForChild("Humanoid")
local mode_fly = false

game:GetService("UserInputService").JumpRequest:Connect(function()
    if mode_fly then
        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid'):ChangeState("Jumping")
    end
end)

other.newToggle("Inf. Jump", "", false, function(toggleState)
        mode_fly = toggleState
end)

local mode_tp = false

local tool = Instance.new("Tool")
tool.RequiresHandle = false
tool.Name = "Click TP function"

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
local mode_noclip = true
game:GetService("RunService").Stepped:Connect(function()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = mode_noclip
        end
    end
end)

other.newToggle("Noclip", "", false, function(toggleState)
      mode_noclip = not toggleState
end)

other.newToggle("ESP Players", "", false, function(toggleState)
    mode_esp = toggleState
    if toggleState == false then
          for i, child in ipairs(workspace:GetDescendants()) do
            if child:FindFirstChild("Humanoid") then
              if child:FindFirstChild("EspBox") then
                if child ~= game.Players.LocalPlayer.Character then
                  child:FindFirstChild("EspBox"):Destroy()
                end
              end
            end
          end
        else
          for i, child in ipairs(workspace:GetDescendants()) do
            if child:FindFirstChild("Humanoid") then
              if not child:FindFirstChild("EspBox") then
                for i, child in ipairs(workspace:GetDescendants()) do
                  if child:IsA("Model") and child:FindFirstChild("Humanoid") then
                    if not child:FindFirstChild("EspBox") then
                      if child ~= game.Players.LocalPlayer.Character then
                        local esp = Instance.new("BoxHandleAdornment", child)
                        esp.Adornee = child
                        esp.ZIndex = 0
                        esp.Size = Vector3.new(4, 5, 3) -- Пример масштабирования размера
                        esp.Transparency = 0.65
                        esp.Color3 = Color3.fromRGB(255, 48, 48)
                        esp.AlwaysOnTop = true
                        esp.Name = "EspBox"
                      end
                    end
                  end
                end
              end
            end
          end
        end
end)
other.newButton("Server HOP", "", function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)

local tp = gui.newTab("TP Utility")
local position = nil
tp.newToggle("Click TP", "", false, function(toggleState)
    mode_tp = toggleState
end)

tp.newButton("Get Click TP item", "", function()
    tool.Parent = game.Players.LocalPlayer.Backpack
	end)
tp.newButton("Save your position", "", function()
  position = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end)
tp.newButton("TP in saved position", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
end)
tp.newInput("TP to any player", "", function(text)
  pcall(function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Player:FindFirstChild(text).Character.HumanoidRootPart.CFrame
    end)
end)
if game.GameId == 1268927906 then
local ml = gui.newTab("Muscle Legends")
local auto_farm = false

ml.newToggle("Auto Farm", "", false, function(Value)
		elias999 = 1
		
        while elias999 == 1 do
            if Value == false then
                elias999 = 2
            end
            wait()
local args = {
    [1] = "rep"
}

game:GetService("Players").LocalPlayer.muscleEvent:FireServer(unpack(args))

        end
end)

ml.newToggle("Auto Rebirth", "", false, function(Value2)
		elias782k = 1
        while elias782k == 1 do
if Value2 == false then
    elias782k = 2
end
wait(1)
local args = {
    [1] = "rebirthRequest"
}
game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer(unpack(args))
   end
end)

ml.newToggle("Auto Farm Durability", "", false, function(state)
		
		m = game.Players.LocalPlayer:GetMouse()
		elias782k = 1
        while elias782k == 1 do
if Value2 == false then
    elias782k = 2
       end
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(284.321411, 7.33135414, -578.631897, 0.305069387, 3.63381929e-08, -0.952330112, 1.39650966e-08, 1, 4.26307203e-08, 0.952330112, -2.63047095e-08, 0.305069387)
mouse1click()

		
wait()


	
	end

	end)

ml.newButton("TP in lobby", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(141.109604, 3.71060801, 282.039124)
end)
ml.newButton("TP in 1 rebirths location", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2643.46362, 3.71060801, -405.459961)
end)
ml.newButton("TP in 5 rebirths location", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2332.45288, 3.71060729, 1078.07373)
end)
ml.newButton("TP in 15 rebirths location", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6873.23535, 3.71062183, -1273.39368)
end)
ml.newButton("TP in 30 rebirths location", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4507.60156, 987.863586, -3884.51514)
end)
ml.newButton("TP in Muscle King location", "", function()
  game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8662.07129, 13.5606356, -5782.43555)
end)

ml.newInput("Fake Strenght", "Change youre strenght", function(text)
  game.Players.LocalPlayer.leaderstats.Strength.Value = tonumber(text)
end)
ml.newInput("Fake Kills", "Change youre kills", function(text)
  game.Players.LocalPlayer.leaderstats.Kills.Value = tonumber(text)
end)
ml.newInput("Fake Brawls", "Change your brawls", function(text)
  game.Players.LocalPlayer.leaderstats.Brawls.Value = tonumber(text)
end)
ml.newInput("Fake Rebirths", "Change youre rebirths", function(text)
  game.Players.LocalPlayer.leaderstats.Rebirths.Value = tonumber(text)
end)
end

local hds = gui.newTab("Hide And Seek")
hds.newButton("kill all", "kill all players for you win(if you seeker)", function()
  for i, v in pairs(game.Players:GetChildren()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
      v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end
  end
end)

hds.newButton("invisble", "", function()
  for i, v in pairs(game.Players:GetChildren()) do
    if v.Name ~= game.Players.LocalPlayer.Name then
      v.Character.HumanoidRootPart.Transparency = 1
    end
  end
end)