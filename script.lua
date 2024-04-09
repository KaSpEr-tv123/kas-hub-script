local gui = loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/DrRay-UI-Library/main/DrRay.lua"))()
local player = game.Players.LocalPlayer
local window = gui:Load("Ҝ卂丂 卄ㄩ乃", "15074833174")

local hacks = gui.newTab("Hacks", "15046690373")

-- puk

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

local mode_esp = false

other.newToggle("ESP Players", "", false, function(toggleState)
    mode_esp = toggleState
    if toggleState == false then
        for i, child in ipairs(workspace:GetDescendants()) do
            if child:FindFirstChild("EspBox") then
                if child ~= game.Players.LocalPlayer.Character then
                    child:FindFirstChild("EspBox"):Destroy()
                end
            end
        end
    else
      while mode_esp do
        for _, player in ipairs(game.Players:GetPlayers()) do
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local espBox = character:FindFirstChild("EspBox")
                if not espBox then
                    local esp = Instance.new("BoxHandleAdornment", character)
                    esp.Adornee = character:FindFirstChild("HumanoidRootPart")
                    esp.ZIndex = 0
                    esp.Size = Vector3.new(4, 5, 3)
                    esp.Transparency = 0.65
                    if character.Head:FindFirstChild("SeekerTitle") then
                        esp.Color3 = Color3.fromRGB(255, 0, 0)
                    else
                        esp.Color3 = Color3.fromRGB(0, 140, 255)
                    end
                    esp.AlwaysOnTop = true
                    esp.Name = "EspBox"
                end
            end
        end
        wait(3)
        for i, child in ipairs(workspace:GetDescendants()) do
          if child:FindFirstChild("EspBox") then
              if child ~= game.Players.LocalPlayer.Character then
                  child:FindFirstChild("EspBox"):Destroy()
              end
          end
        end
      end
    end
end)
other.newButton("Rejoin", "", function()
  game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
end)
other.newButton("DEX", "explorer files game", function()
  loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/Dex%20Explorer.txt"))()
end)
other.newButton("Infinite Yield", "script", function()
  loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
end)
other.newButton("Vape", "script", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua"))()
end)
other.newButton("SimpleSpyMobile", "script", function()
  loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RS/main/SimpleSpyMobile"))()
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
tp.newInput("TP to any player", "Enter player name", function(playerName)
  local playerToTeleport = game.Players:FindFirstChild(playerName)
  if playerToTeleport then
      local playerCharacter = playerToTeleport.Character
      if playerCharacter then
          local humanoidRootPart = playerCharacter:FindFirstChild("HumanoidRootPart")
          if humanoidRootPart then
              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = humanoidRootPart.CFrame
          else
              warn("HumanoidRootPart not found for player:", playerName)
          end
      else
          warn("Character not found for player:", playerName)
      end
  else
      warn("Player not found:", playerName)
  end
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

ml.newInput("Fake Strength", "Change your strength", function(text)
  game.Players.LocalPlayer.leaderstats.Strength.Value = tonumber(text)
end)
ml.newInput("Fake Kills", "Change your kills", function(text)
  game.Players.LocalPlayer.leaderstats.Kills.Value = tonumber(text)
end)
ml.newInput("Fake Brawls", "Change your brawls", function(text)
  game.Players.LocalPlayer.leaderstats.Brawls.Value = tonumber(text)
end)
ml.newInput("Fake Rebirths", "Change your rebirths", function(text)
  game.Players.LocalPlayer.leaderstats.Rebirths.Value = tonumber(text)
end)
end

if game.GameId == 2020908522 then
  local hds = gui.newTab("Hide And Seek")
  hds.newButton("Kill all", "Kill all players for you win (if you are the seeker)", 
  function()
    -- kill, not tp
    for i, v in pairs(game.Players:GetChildren()) do
      if v ~= game.Players.LocalPlayer then
        if not v.Character.Head:FindFirstChild("SeekerTitle") then
          v.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        end
      end
    end
  end)
  local afc = false

local function autoFarmCoins()
    repeat
        wait(0.5)
        local coinsFolder = game.Workspace:FindFirstChild("MapHolder")
        if coinsFolder then
            local minDistance = math.huge
            local nearestCoin = nil
            
            for _, coin in ipairs(coinsFolder:GetChildren()) do
                if coin.Name == "Coin" then
                    local distance = (coin.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                    if distance < minDistance then
                        minDistance = distance
                        nearestCoin = coin
                    end
                end
            end
            
            if nearestCoin then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame
            else
                local warningGui = Instance.new("ScreenGui")
                warningGui.Parent = game.Players.LocalPlayer.PlayerGui

                local warningLabel = Instance.new("TextLabel")
                warningLabel.Text = "Монеты не найдены."
                warningLabel.Size = UDim2.new(0, 200, 0, 50)
                warningLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
                warningLabel.BackgroundColor3 = Color3.new(0.3686274509803922, 0.023529411764705882, 0.42745098039215684)
                warningLabel.TextColor3 = Color3.new(0.19607843137254902, 0.023529411764705882, 0.2235294117647059)
                warningLabel.Parent = warningGui
               -- afc = false
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(35.8843689, 4.00753164, 65.9930344)
                wait(3)
                warningGui:Destroy()
            end
        else
            warn("Папка с монетами не найдена.")
        end
    until not afc
end

hds.newButton("Auto farm coins", "", function()
    afc = not afc
    if afc then
        spawn(autoFarmCoins) -- Запускаем функцию в новом потоке
    end
end)
  hds.newButton("Unfreeze", "unfreeze all players (if you are the hider)", 
  function()
    for i, v in pairs(game.Players:GetChildren()) do
      if v ~= game.Players.LocalPlayer then
        if not v.Character.Head:FindFirstChild("SeekerTitle") then
          wait(0.1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
      end
    end
  end)
end

if game.GameId == 111958650 then
  local ars = gui.newTab("Arsenal")
  local localPlayer = game:GetService("Players").LocalPlayer
  
  local function getPlayerToAim()
      local target = nil
      local minDistance = math.huge
      
      for _, player in pairs(game:GetService("Players"):GetPlayers()) do
          if player.Name ~= localPlayer.Name and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.TeamColor ~= localPlayer.TeamColor then
              local distance = (player.Character.Head.Position - localPlayer.Character.Head.Position).magnitude
              
              if distance < minDistance then
                  target = player
                  minDistance = distance
              end
          end
      end
      
      return target
  end
  
  local camera = game.Workspace.CurrentCamera
  local aim = false
  
  game:GetService("RunService").RenderStepped:Connect(function()
      if aim then
          local targetPlayer = getPlayerToAim()
          if targetPlayer then
              camera.CFrame = CFrame.new(camera.CFrame.Position, targetPlayer.Character.Head.Position)
          end
      end
  end)
  
  ars.newToggle("AimBot", "", false, function()
      aim = not aim
  end)

  local key = Enum.KeyCode.LeftAlt
  if not game.UserInputService.TouchEnabled then
    ars.newKeybind("Keybind aim", "", function(input)
      key = input.KeyCode
    end)
  end

  game.UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == key then
      aim = not aim
    end
  end)
end


if game.GameId == 3149100453 then

local blobs = gui.newTab("Blobs") 

local afb = false

function autoFarmBlobs()
    repeat
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 1000
        local coinsFolder = game.Workspace:FindFirstChild("Orbs")
        if coinsFolder then
            local minDistance = math.huge
            local nearestCoin = nil

            for _, coin in ipairs(coinsFolder:GetChildren()) do
                if coin.Name == "Orb" then
                    local distance = (coin.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                    if distance < minDistance then
                        minDistance = distance
                        nearestCoin = coin
                    end
                end
            end

            if nearestCoin then
                local playersNearby = game.Players:GetPlayers()
                local teleportAllowed = true
                
                for _, player in ipairs(playersNearby) do
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local playerDistance = (player.Character.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude
                        if playerDistance < 300 and player ~= game.Players.LocalPlayer then
                            teleportAllowed = false
                            break
                        end
                    end
                end

                if teleportAllowed then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = nearestCoin.CFrame
                end
            else
                local warningGui = Instance.new("ScreenGui")
                warningGui.Parent = game.Players.LocalPlayer.PlayerGui

                local warningLabel = Instance.new("TextLabel")
                warningLabel.Text = "Монеты не найдены."
                warningLabel.Size = UDim2.new(0, 200, 0, 50)
                warningLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
                warningLabel.BackgroundColor3 = Color3.new(0.3686274509803922, 0.023529411764705882, 0.42745098039215684)
                warningLabel.TextColor3 = Color3.new(0.19607843137254902, 0.023529411764705882, 0.2235294117647059)
                warningLabel.Parent = warningGui

                wait(3)
                warningGui:Destroy()
            end
        else
            warn("Папка с монетами не найдена.")
        end
        wait(0.005)
    until not afb
end

blobs.newButton("Auto farm blobs", "", function()
    afb = not afb
    if afb then
        spawn(autoFarmBlobs) -- Запускаем функцию в новом потоке
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)

local freespin = false
function autoSpinFree()
  while freespin == true do
      game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.SpinService.RE.FreeSpinButtonPressed:FireServer()
      wait(5)
  end
end

blobs.newButton("Auto spin free", "", function()
  freespin = not freespin
  if freespin then
    spawn(autoSpinFree)
  end
end)

local spin = false

function autoSpin(mode)
  while spin == true do
      game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.SpinService.RE.SkullSpinButtonPressed:FireServer()
      wait(5)
  end
end

blobs.newButton("Auto spin", "", function()
  spin = not spin
  if spin then
    spawn(autoSpin)
  end
end)

function autoGetGifts()
  wait(12)
    local args = {
      [1] = 12
  }
  
  game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(136)
  local args = {
    [1] = 136
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(250)
  local args = {
    [1] = 250
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(441)
  local args = {
    [1] = 441
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(589)
  local args = {
    [1] = 589
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(723)
  local args = {
    [1] = 723
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(893)
  local args = {
    [1] = 893
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(1006)
  local args = {
    [1] = 1006
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(1147)
  local args = {
    [1] = 1147
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(1280)
  local args = {
    [1] = 1280
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(1427)
  local args = {
    [1] = 1427
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
  wait(2000)
  local args = {
    [1] = 2000
}

game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.5.1").knit.Services.GiftService.RF.RequestGift:InvokeServer(unpack(args))
end

blobs.newButton("Auto get gifts", "", function()
  spam(autoGetGifts)
end)

blobs.newButton("Kill all", "", function()
    for i, v in pairs(game.Players:GetChildren()) do
      if v ~= game.Players.LocalPlayer then
        if game.Players.LocalPlayer.Character.HumanoidRootPart.RealSize.Value > v.Character.HumanoidRootPart.RealSize.Value then
          wait(0.1)
          game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame
        end
      end
    end
  end)
end       

if game.GameId == 994732206 then
  local bf = gui.newTab("Blox Fruits")
  bf.newButton("Load Script For Blox Fruits", "", function() 
    loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
  end)
end

if game.GameId == 4777817887 then
  local bb = gui.newTab("Blade Ball")

  bb.newButton("Load Script For Blade Ball", "", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/BladeBall/main/redz9999"))()
  end)
end