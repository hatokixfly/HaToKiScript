--// KernelOne Safe Dev Panel
--// Full Functional Safe Version

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local VirtualUser = game:GetService("VirtualUser")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Parent = player.PlayerGui
gui.ResetOnSpawn = false

local savedPosition
local multijump = false
local autoSpace = false
local noclip = false
local currentLang = "VI"

--========================================
-- LOADING
--========================================

local load = Instance.new("Frame",gui)
load.Size = UDim2.new(0,300,0,80)
load.Position = UDim2.new(0.5,-150,0.5,-40)
load.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner",load)

local txt = Instance.new("TextLabel",load)
txt.Size = UDim2.new(1,0,0,30)
txt.BackgroundTransparency = 1
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold

local bar = Instance.new("Frame",load)
bar.Size = UDim2.new(0.9,0,0,18)
bar.Position = UDim2.new(0.05,0,0.6,0)
bar.BackgroundColor3 = Color3.fromRGB(20,20,20)
Instance.new("UICorner",bar)

local fill = Instance.new("Frame",bar)
fill.Size = UDim2.new(0,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(180,0,255)
Instance.new("UICorner",fill)

for i=1,100 do
	txt.Text = "Loading "..i.."%"
	fill.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.01)
end
load:Destroy()

--========================================
-- BANNER
--========================================

local banner = Instance.new("Frame",gui)
banner.Size = UDim2.new(0,420,0,48)
banner.Position = UDim2.new(0.5,-210,0,8)
banner.BackgroundColor3 = Color3.fromRGB(8,8,8)
Instance.new("UICorner",banner)

local b1 = Instance.new("TextLabel",banner)
b1.Size = UDim2.new(0.65,0,1,0)
b1.Position = UDim2.new(0,10,0,0)
b1.BackgroundTransparency = 1
b1.Text = "Nguyen Thanh Phu | private build"
b1.Font = Enum.Font.GothamBold
b1.TextSize = 15
b1.TextXAlignment = Enum.TextXAlignment.Left

local stat = Instance.new("TextLabel",banner)
stat.Size = UDim2.new(0,90,1,0)
stat.Position = UDim2.new(1,-95,0,0)
stat.BackgroundTransparency = 1
stat.Font = Enum.Font.GothamBold
stat.TextSize = 12

task.spawn(function()
	while true do
		for h=0,1,0.01 do
			local c = Color3.fromHSV(h,1,1)
			b1.TextColor3 = c
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

local menu = Instance.new("Frame",gui)
menu.Size = UDim2.new(0,340,0,420)
menu.Position = UDim2.new(0.5,-170,0.5,-210)
menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
menu.ClipsDescendants = true
Instance.new("UICorner",menu)

local title = Instance.new("TextLabel",menu)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold

--========================================
-- MINIMIZE
--========================================

local mini = Instance.new("TextButton",menu)
mini.Size = UDim2.new(0,25,0,25)
mini.Position = UDim2.new(1,-30,0,5)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(25,25,25)

local pages = {}

local function createTab(name,x)
	local b = Instance.new("TextButton",menu)
	b.Size = UDim2.new(0,65,0,25)
	b.Position = UDim2.new(0,x,0,40)
	b.Text = name
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)

	local p = Instance.new("ScrollingFrame",menu)
	p.Size = UDim2.new(1,-20,1,-80)
	p.Position = UDim2.new(0,10,0,75)
	p.CanvasSize = UDim2.new(0,0,0,600)
	p.BackgroundTransparency = 1
	p.Visible = false
	p.ScrollBarThickness = 4

	pages[name]=p

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(pages) do
			v.Visible=false
		end
		p.Visible=true
	end)

	return p
end

local main = createTab("MAIN",10)
local playerTab = createTab("PLAYER",80)
local scriptTab = createTab("SCRIPT",150)
local settings = createTab("SETTINGS",220)

main.Visible = true

mini.MouseButton1Click:Connect(function()
	if menu.Size.Y.Offset > 40 then
		menu.Size = UDim2.new(0,340,0,40)
		for _,v in pairs(pages) do v.Visible=false end
	else
		menu.Size = UDim2.new(0,340,0,420)
		main.Visible=true
	end
end)

--========================================
-- BUTTON
--========================================

local function addButton(parent,text,y,callback)
	local b = Instance.new("TextButton",parent)
	b.Size = UDim2.new(0.9,0,0,30)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",b)
	b.MouseButton1Click:Connect(callback)
end

--========================================
-- MAIN
--========================================

addButton(main,"Save Position",10,function()
	savedPosition = character.HumanoidRootPart.CFrame
end)

addButton(main,"Teleport Save",50,function()
	if savedPosition then
		character.HumanoidRootPart.CFrame = savedPosition
	end
end)

addButton(main,"Multijump",90,function()
	multijump = not multijump
end)

UIS.JumpRequest:Connect(function()
	if multijump then
		character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

addButton(main,"Auto Space",130,function()
	autoSpace = not autoSpace
	task.spawn(function()
		while autoSpace do
			character.Humanoid.Jump = true
			task.wait(0.3)
		end
	end)
end)

addButton(main,"Anti AFK",170,function()
	player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
end)

addButton(main,"Noclip Local",210,function()
	noclip = not noclip
	RunService.Stepped:Connect(function()
		if noclip then
			for _,v in pairs(character:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end
	end)
end)

addButton(main,"Reset Character",250,function()
	character:BreakJoints()
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
	y += 35
end

--========================================
-- SCRIPT
--========================================

local box = Instance.new("TextBox",scriptTab)
box.Size = UDim2.new(0.9,0,0,100)
box.Position = UDim2.new(0.05,0,0,10)
box.Text = "Utility Script Ready"
box.BackgroundColor3 = Color3.fromRGB(20,20,20)
box.TextColor3 = Color3.new(1,1,1)

addButton(scriptTab,"Start",120,function()
	local p = Instance.new("Part",workspace)
	p.Size = Vector3.new(4,1,4)
	p.Position = character.HumanoidRootPart.Position + Vector3.new(0,5,0)
	p.Anchored = true
end)

--========================================
-- SETTINGS
--========================================

addButton(settings,"VI / EN",10,function()
	if currentLang=="VI" then
		currentLang="EN"
		title.Text="Developer Panel"
	else
		currentLang="VI"
		title.Text="Nguyen Thanh Phu"
	end
end)

addButton(settings,"WalkSpeed 50",50,function()
	character.Humanoid.WalkSpeed = 50
end)

addButton(settings,"JumpPower 100",90,function()
	character.Humanoid.JumpPower = 100
end)

addButton(settings,"Default Speed",130,function()
	character.Humanoid.WalkSpeed = 16
	character.Humanoid.JumpPower = 50
end)

--========================================
-- DRAG
--========================================

local dragging=false
local dragStart,startPos

menu.InputBegan:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=true
		dragStart=input.Position
		startPos=menu.Position
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType==Enum.UserInputType.MouseButton1 then
		dragging=false
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
		local delta=input.Position-dragStart
		menu.Position=UDim2.new(
			startPos.X.Scale,startPos.X.Offset+delta.X,
			startPos.Y.Scale,startPos.Y.Offset+delta.Y
		)
	end
end)
