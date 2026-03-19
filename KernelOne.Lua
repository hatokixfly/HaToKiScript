--// Nguyen Thanh Phu Developer Panel
--// Premium Developer GUI Safe Debug Version
--// Script By: KERNELX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local savedPosition = nil
local autoJump = false
local selectedWeapon = "Stick"

--====================================================
-- GUI ROOT
--====================================================

local gui = Instance.new("ScreenGui")
gui.Name = "NguyenThanhPhuPanel"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

--====================================================
-- NOTIFY
--====================================================

local function notify(text)
	pcall(function()
		local notif = Instance.new("Frame")
		notif.Parent = gui
		notif.Size = UDim2.new(0,240,0,45)
		notif.Position = UDim2.new(1,-260,0,20)
		notif.BackgroundColor3 = Color3.fromRGB(15,15,15)
		notif.BorderSizePixel = 0
		Instance.new("UICorner", notif).CornerRadius = UDim.new(0,10)

		local label = Instance.new("TextLabel")
		label.Parent = notif
		label.Size = UDim2.new(1,0,1,0)
		label.BackgroundTransparency = 1
		label.Text = text
		label.TextColor3 = Color3.new(1,1,1)
		label.Font = Enum.Font.GothamBold
		label.TextSize = 14

		notif.BackgroundTransparency = 1
		label.TextTransparency = 1

		TweenService:Create(notif,TweenInfo.new(0.25),{
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(label,TweenInfo.new(0.25),{
			TextTransparency = 0
		}):Play()

		task.wait(2)

		TweenService:Create(notif,TweenInfo.new(0.25),{
			BackgroundTransparency = 1
		}):Play()

		TweenService:Create(label,TweenInfo.new(0.25),{
			TextTransparency = 1
		}):Play()

		task.wait(0.3)
		notif:Destroy()
	end)
end

--====================================================
-- LOADING
--====================================================

local loading = Instance.new("Frame")
loading.Parent = gui
loading.Size = UDim2.new(0,300,0,120)
loading.Position = UDim2.new(0.5,-150,0.5,-60)
loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
loading.BorderSizePixel = 0
Instance.new("UICorner", loading).CornerRadius = UDim.new(0,12)

local loadingText = Instance.new("TextLabel")
loadingText.Parent = loading
loadingText.Size = UDim2.new(1,0,0,40)
loadingText.BackgroundTransparency = 1
loadingText.Text = "Loading 1%"
loadingText.TextColor3 = Color3.new(1,1,1)
loadingText.Font = Enum.Font.GothamBold
loadingText.TextSize = 18

local progressBg = Instance.new("Frame")
progressBg.Parent = loading
progressBg.Size = UDim2.new(0.8,0,0,16)
progressBg.Position = UDim2.new(0.1,0,0.65,0)
progressBg.BackgroundColor3 = Color3.fromRGB(30,30,30)
progressBg.BorderSizePixel = 0
Instance.new("UICorner", progressBg)

local progress = Instance.new("Frame")
progress.Parent = progressBg
progress.Size = UDim2.new(0,0,1,0)
progress.BackgroundColor3 = Color3.fromRGB(255,0,60)
progress.BorderSizePixel = 0
Instance.new("UICorner", progress)

for i = 1,100 do
	loadingText.Text = "Loading "..i.."%"
	progress.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.015)
end

TweenService:Create(loading,TweenInfo.new(0.35),{
	BackgroundTransparency = 1
}):Play()

task.wait(0.4)
loading:Destroy()

notify("Script By: KERNELX")

--====================================================
-- LOGO
--====================================================

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.4,0)
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.Text = "K"
logo.TextColor3 = Color3.fromRGB(255,0,80)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 28
logo.BorderSizePixel = 0
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

local draggingLogo = false
local dragStartLogo
local startPosLogo

logo.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingLogo = true
		dragStartLogo = input.Position
		startPosLogo = logo.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		draggingLogo = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingLogo and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStartLogo
		logo.Position = UDim2.new(
			startPosLogo.X.Scale,
			startPosLogo.X.Offset + delta.X,
			startPosLogo.Y.Scale,
			startPosLogo.Y.Offset + delta.Y
		)
	end
end)

--====================================================
-- MENU
--====================================================

local menu = Instance.new("Frame")
menu.Parent = gui
menu.Size = UDim2.new(0,430,0,520)
menu.Position = UDim2.new(0.5,-215,0.5,-260)
menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
menu.BorderSizePixel = 0
menu.Visible = false
Instance.new("UICorner", menu).CornerRadius = UDim.new(0,14)

-- title
local title = Instance.new("TextLabel")
title.Parent = menu
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.Font = Enum.Font.GothamBold
title.TextSize = 20

task.spawn(function()
	while true do
		for h = 0,1,0.01 do
			title.TextColor3 = Color3.fromHSV(h,1,1)
			task.wait(0.03)
		end
	end
end)

-- drag menu
local dragging = false
local dragStart
local startPos

menu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = menu.Position
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		menu.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

--====================================================
-- FUNCTIONS
--====================================================

local yPos = 55

local function createButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Parent = menu
	btn.Size = UDim2.new(0.85,0,0,35)
	btn.Position = UDim2.new(0.075,0,0,yPos)
	btn.BackgroundColor3 = Color3.fromRGB(25,25,25)
	btn.Text = text
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.BorderSizePixel = 0
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundColor3 = Color3.fromRGB(35,35,35)
		}):Play()
	end)

	btn.MouseLeave:Connect(function()
		TweenService:Create(btn,TweenInfo.new(0.15),{
			BackgroundColor3 = Color3.fromRGB(25,25,25)
		}):Play()
	end)

	btn.MouseButton1Click:Connect(callback)

	yPos += 42
	return btn
end

local function createToggle(text, callback)
	local state = false
	local btn

	btn = createButton(text.." : OFF", function()
		state = not state
		btn.Text = text.." : "..(state and "ON" or "OFF")
		callback(state)
		notify(text.." "..(state and "ON" or "OFF"))
	end)
end

local function savePosition()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		savedPosition = hrp.CFrame
		notify("Position Saved")
	end
end

local function teleportSaved()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp and savedPosition then
		hrp.CFrame = savedPosition
		notify("Teleported")
	end
end

local function getTool()
	local tool = character:FindFirstChildOfClass("Tool")
	if tool then
		return tool.Name
	end
	return "None"
end

--====================================================
-- BUTTONS
--====================================================

createButton("Save Position", savePosition)
createButton("Tele Position", teleportSaved)

createToggle("Auto Jump", function(state)
	autoJump = state
	if state then
		task.spawn(function()
			while autoJump do
				local hum = character:FindFirstChildOfClass("Humanoid")
				if hum then hum.Jump = true end
				task.wait(0.5)
			end
		end)
	end
end)

createButton("Detect Tool", function()
	notify("Tool: "..getTool())
end)

createButton("Weapon Mode Stick", function()
	selectedWeapon = "Stick"
	notify("Mode Stick")
end)

createButton("Weapon Mode Gun", function()
	selectedWeapon = "Gun"
	notify("Mode Gun")
end)

createButton("Weapon Mode Brainrot", function()
	selectedWeapon = "Brainrot"
	notify("Mode Brainrot")
end)

-- damage box
local damageBox = Instance.new("TextBox")
damageBox.Parent = menu
damageBox.Size = UDim2.new(0.85,0,0,35)
damageBox.Position = UDim2.new(0.075,0,0,yPos)
damageBox.Text = "192382832534"
damageBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
damageBox.TextColor3 = Color3.new(1,1,1)
damageBox.Font = Enum.Font.Gotham
damageBox.TextSize = 14
Instance.new("UICorner", damageBox)

yPos += 42

createButton("Damage Preview", function()
	notify("Damage: "..damageBox.Text)
end)

-- item box
local itemBox = Instance.new("TextBox")
itemBox.Parent = menu
itemBox.Size = UDim2.new(0.85,0,0,35)
itemBox.Position = UDim2.new(0.075,0,0,yPos)
itemBox.Text = "Item Name"
itemBox.BackgroundColor3 = Color3.fromRGB(20,20,20)
itemBox.TextColor3 = Color3.new(1,1,1)
itemBox.Font = Enum.Font.Gotham
itemBox.TextSize = 14
Instance.new("UICorner", itemBox)

yPos += 42

createButton("Trigger Item Placeholder", function()
	notify("Item: "..itemBox.Text)
end)

createButton("Character HP", function()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then
		notify("HP: "..math.floor(hum.Health))
	end
end)

createButton("Refresh Character", function()
	character = player.Character or player.CharacterAdded:Wait()
	notify("Refreshed")
end)

--====================================================
-- OPEN CLOSE
--====================================================

local opened = false

logo.MouseButton1Click:Connect(function()
	opened = not opened

	if opened then
		menu.Visible = true
		menu.Size = UDim2.new(0,0,0,0)

		TweenService:Create(menu,TweenInfo.new(0.35),{
			Size = UDim2.new(0,430,0,520)
		}):Play()
	else
		local tween = TweenService:Create(menu,TweenInfo.new(0.3),{
			Size = UDim2.new(0,0,0,0)
		})
		tween:Play()
		tween.Completed:Wait()
		menu.Visible = false
	end
end)
