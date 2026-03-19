--// KernelOne Premium Safe Panel
--// Nguyen Thanh Phu Build

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false
gui.Name = "KernelOne"

local savedPosition
local multijump = false
local autoSpace = false
local currentLang = "VI"

--========================================
-- LOADING
--========================================

local loadFrame = Instance.new("Frame", gui)
loadFrame.Size = UDim2.new(0,300,0,80)
loadFrame.Position = UDim2.new(0.5,-150,0.5,-40)
loadFrame.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner", loadFrame)

local txt = Instance.new("TextLabel", loadFrame)
txt.Size = UDim2.new(1,0,0,30)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold
txt.TextSize = 16

local bar = Instance.new("Frame", loadFrame)
bar.Size = UDim2.new(0.9,0,0,18)
bar.Position = UDim2.new(0.05,0,0.6,0)
bar.BackgroundColor3 = Color3.fromRGB(25,25,25)
Instance.new("UICorner", bar)

local fill = Instance.new("Frame", bar)
fill.Size = UDim2.new(0,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(180,0,255)
Instance.new("UICorner", fill)

for i=1,100 do
	txt.Text = "Loading "..i.."%"
	fill.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.015)
end

loadFrame:Destroy()

--========================================
-- NOTIFY
--========================================

local function notify(t)
	local f = Instance.new("Frame", gui)
	f.Size = UDim2.new(0,220,0,35)
	f.Position = UDim2.new(1,-230,0,20)
	f.BackgroundColor3 = Color3.fromRGB(15,15,15)
	Instance.new("UICorner", f)

	local l = Instance.new("TextLabel", f)
	l.Size = UDim2.new(1,0,1,0)
	l.BackgroundTransparency = 1
	l.Text = t
	l.TextColor3 = Color3.new(1,1,1)
	l.Font = Enum.Font.GothamBold
	l.TextSize = 13

	task.delay(2,function()
		f:Destroy()
	end)
end

--========================================
-- BANNER FPS
--========================================

local banner = Instance.new("Frame", gui)
banner.Size = UDim2.new(0,420,0,48)
banner.Position = UDim2.new(0.5,-210,0,8)
banner.BackgroundColor3 = Color3.fromRGB(8,8,8)
banner.BorderSizePixel = 0
Instance.new("UICorner", banner)

local bannerText = Instance.new("TextLabel", banner)
bannerText.Size = UDim2.new(0.65,0,1,0)
bannerText.Position = UDim2.new(0,10,0,0)
bannerText.BackgroundTransparency = 1
bannerText.Text = "Nguyen Thanh Phu | private build"
bannerText.Font = Enum.Font.GothamBold
bannerText.TextSize = 15
bannerText.TextXAlignment = Enum.TextXAlignment.Left

local stat = Instance.new("TextLabel", banner)
stat.Size = UDim2.new(0,90,1,0)
stat.Position = UDim2.new(1,-95,0,0)
stat.BackgroundTransparency = 1
stat.Font = Enum.Font.GothamBold
stat.TextSize = 12

task.spawn(function()
	while true do
		for h=0,1,0.01 do
			local c = Color3.fromHSV(h,1,1)
			bannerText.TextColor3 = c
			stat.TextColor3 = c
			task.wait(0.03)
		end
	end
end)

RunService.RenderStepped:Connect(function()
	stat.Text = "FPS: 60\nPING: 48"
end)

--========================================
-- MENU
--========================================

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,330,0,400)
menu.Position = UDim2.new(0.5,-165,0.5,-200)
menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
menu.ClipsDescendants = true
Instance.new("UICorner", menu)

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.Font = Enum.Font.GothamBold
title.TextSize = 17
title.TextColor3 = Color3.new(1,1,1)

--========================================
-- MINIMIZE
--========================================

local mini = Instance.new("TextButton", menu)
mini.Size = UDim2.new(0,25,0,25)
mini.Position = UDim2.new(1,-30,0,5)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(25,25,25)

local minimized = false
local normalSize = UDim2.new(0,330,0,400)
local miniSize = UDim2.new(0,330,0,40)

--========================================
-- TAB SYSTEM
--========================================

local pages = {}

local function createTab(name,x)
	local b = Instance.new("TextButton", menu)
	b.Size = UDim2.new(0,60,0,25)
	b.Position = UDim2.new(0,x,0,40)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local p = Instance.new("Frame", menu)
	p.Size = UDim2.new(1,-20,1,-80)
	p.Position = UDim2.new(0,10,0,75)
	p.BackgroundTransparency = 1
	p.Visible = false

	pages[name] = p

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(pages) do
			v.Visible = false
		end
		p.Visible = true
	end)

	return p
end

local main = createTab("MAIN",10)
local playerTab = createTab("PLAYER",80)
local scriptTab = createTab("SCRIPT",150)
local settings = createTab("SETTINGS",220)

main.Visible = true

mini.MouseButton1Click:Connect(function()
	minimized = not minimized

	if minimized then
		menu.Size = miniSize
		for _,v in pairs(pages) do
			v.Visible = false
		end
	else
		menu.Size = normalSize
		main.Visible = true
	end
end)

--========================================
-- BUTTON
--========================================

local function addButton(parent,text,y,callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0.9,0,0,30)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(callback)
end

--========================================
-- MAIN
--========================================

addButton(main,"Save Position",10,function()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		savedPosition = hrp.CFrame
		notify("Saved")
	end
end)

addButton(main,"Teleport Save",50,function()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp and savedPosition then
		hrp.CFrame = savedPosition
	end
end)

addButton(main,"Multijump",90,function()
	multijump = not multijump
	notify("Multijump")
end)

UIS.JumpRequest:Connect(function()
	if multijump then
		local hum = character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
		end
	end
end)

addButton(main,"Anti AFK",130,function()
	player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end)

addButton(main,"Auto Space",170,function()
	autoSpace = not autoSpace
	task.spawn(function()
		while autoSpace do
			local hum = character:FindFirstChildOfClass("Humanoid")
			if hum then hum.Jump = true end
			task.wait(0.3)
		end
	end)
end)

--========================================
-- PLAYER
--========================================

local y = 10
for _,plr in pairs(Players:GetPlayers()) do
	addButton(playerTab,plr.Name,y,function()
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
		end
	end)
	y = y + 35
end

--========================================
-- SCRIPT
--========================================

local box = Instance.new("TextBox", scriptTab)
box.Size = UDim2.new(0.9,0,0,100)
box.Position = UDim2.new(0.05,0,0,10)
box.Text = "-- script"
box.BackgroundColor3 = Color3.fromRGB(20,20,20)
box.TextColor3 = Color3.new(1,1,1)

addButton(scriptTab,"Start",120,function()
	print(box.Text)
	notify("Executed")
end)

--========================================
-- SETTINGS
--========================================

local function applyLang()
	if currentLang == "VI" then
		title.Text = "Nguyen Thanh Phu"
	else
		title.Text = "Nguyen Thanh Phu Panel"
	end
end

addButton(settings,"VI / EN",10,function()
	if currentLang == "VI" then
		currentLang = "EN"
	else
		currentLang = "VI"
	end
	applyLang()
end)

--========================================
-- DRAG
--========================================

local dragging = false
local dragStart,startPos

menu.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = menu.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		menu.Position = UDim2.new(
			startPos.X.Scale,startPos.X.Offset + delta.X,
			startPos.Y.Scale,startPos.Y.Offset + delta.Y
		)
	end
end)
