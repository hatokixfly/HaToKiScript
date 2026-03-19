--// Nguyen Thanh Phu Developer Panel
--// Premium Safe Developer Version
--// Script By: KERNELX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local gui = Instance.new("ScreenGui")
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local savedPosition
local multijump = false
local autoSpace = false

--====================================================
-- NOTIFY
--====================================================

local function notify(t)
	local f = Instance.new("Frame", gui)
	f.Size = UDim2.new(0,220,0,40)
	f.Position = UDim2.new(1,-240,0,20)
	f.BackgroundColor3 = Color3.fromRGB(15,15,15)
	f.BorderSizePixel = 0
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

--====================================================
-- TOP BANNER
--====================================================

local banner = Instance.new("Frame", gui)
banner.Size = UDim2.new(0,500,0,60)
banner.Position = UDim2.new(0.5,-250,0,10)
banner.BackgroundColor3 = Color3.fromRGB(8,8,8)
banner.BorderSizePixel = 0
Instance.new("UICorner", banner)

local titleBanner = Instance.new("TextLabel", banner)
titleBanner.Size = UDim2.new(0.7,0,1,0)
titleBanner.Position = UDim2.new(0,10,0,0)
titleBanner.BackgroundTransparency = 1
titleBanner.Text = "Nguyen Thanh Phu Panel | private build"
titleBanner.TextColor3 = Color3.fromRGB(180,0,255)
titleBanner.Font = Enum.Font.GothamBold
titleBanner.TextSize = 18
titleBanner.TextXAlignment = Enum.TextXAlignment.Left

local stats = Instance.new("TextLabel", banner)
stats.Size = UDim2.new(0,120,1,0)
stats.Position = UDim2.new(1,-120,0,0)
stats.BackgroundTransparency = 1
stats.TextColor3 = Color3.fromRGB(255,220,100)
stats.Font = Enum.Font.GothamBold
stats.TextSize = 14

RunService.RenderStepped:Connect(function()
	stats.Text = "FPS: "..math.floor(1 / RunService.RenderStepped:Wait()).."\nPING: 48ms"
end)

--====================================================
-- MENU
--====================================================

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,360,0,430)
menu.Position = UDim2.new(0.5,-180,0.5,-215)
menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
menu.BorderSizePixel = 0
Instance.new("UICorner", menu)

local title = Instance.new("TextLabel", menu)
title.Size = UDim2.new(1,0,0,35)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.Font = Enum.Font.GothamBold
title.TextSize = 18

task.spawn(function()
	while true do
		for h=0,1,0.01 do
			title.TextColor3 = Color3.fromHSV(h,1,1)
			task.wait(0.03)
		end
	end
end)

--====================================================
-- MINIMIZE
--====================================================

local minus = Instance.new("TextButton", menu)
minus.Size = UDim2.new(0,25,0,25)
minus.Position = UDim2.new(1,-60,0,5)
minus.Text = "-"
minus.BackgroundColor3 = Color3.fromRGB(25,25,25)

local plus = Instance.new("TextButton", menu)
plus.Size = UDim2.new(0,25,0,25)
plus.Position = UDim2.new(1,-30,0,5)
plus.Text = "+"
plus.BackgroundColor3 = Color3.fromRGB(25,25,25)

minus.MouseButton1Click:Connect(function()
	menu.Size = UDim2.new(0,360,0,40)
end)

plus.MouseButton1Click:Connect(function()
	menu.Size = UDim2.new(0,360,0,430)
end)

--====================================================
-- DRAG
--====================================================

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

--====================================================
-- TAB SYSTEM
--====================================================

local pages={}

local function tab(name,x)
	local b=Instance.new("TextButton",menu)
	b.Size=UDim2.new(0,65,0,28)
	b.Position=UDim2.new(0,x,0,45)
	b.Text=name
	b.BackgroundColor3=Color3.fromRGB(20,20,20)

	local p=Instance.new("Frame",menu)
	p.Size=UDim2.new(1,-20,1,-90)
	p.Position=UDim2.new(0,10,0,85)
	p.BackgroundTransparency=1
	p.Visible=false

	pages[name]=p

	b.MouseButton1Click:Connect(function()
		for _,v in pairs(pages) do v.Visible=false end
		p.Visible=true
	end)

	return p
end

local main=tab("MAIN",10)
local esp=tab("ESP",80)
local server=tab("SERVER",150)
local playerTab=tab("PLAYER",230)
local scriptTab=tab("SCRIPT",300)

main.Visible=true

local function btn(parent,text,y,cb)
	local b=Instance.new("TextButton",parent)
	b.Size=UDim2.new(0.9,0,0,30)
	b.Position=UDim2.new(0.05,0,0,y)
	b.Text=text
	b.BackgroundColor3=Color3.fromRGB(25,25,25)
	b.TextColor3=Color3.new(1,1,1)
	Instance.new("UICorner",b)
	b.MouseButton1Click:Connect(cb)
end

--====================================================
-- MAIN
--====================================================

btn(main,"Lưu vị trí",10,function()
	local hrp=character:FindFirstChild("HumanoidRootPart")
	if hrp then
		savedPosition=hrp.CFrame
		notify("Đã lưu vị trí")
	end
end)

btn(main,"Quay lại vị trí",50,function()
	local hrp=character:FindFirstChild("HumanoidRootPart")
	if hrp and savedPosition then
		hrp.CFrame=savedPosition
	end
end)

btn(main,"Multijump",90,function()
	multijump = not multijump
	notify("Multijump "..(multijump and "ON" or "OFF"))
end)

UIS.JumpRequest:Connect(function()
	if multijump then
		local hum=character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

btn(main,"Anti AFK",130,function()
	player.Idled:Connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)
	notify("Anti AFK ON")
end)

btn(main,"Auto Space",170,function()
	autoSpace = not autoSpace
	task.spawn(function()
		while autoSpace do
			local hum=character:FindFirstChildOfClass("Humanoid")
			if hum then hum.Jump=true end
			task.wait(0.3)
		end
	end)
end)

--====================================================
-- ESP (placeholder safe)
--====================================================

btn(esp,"ESP BOX",10,function()
	notify("ESP Box placeholder")
end)

btn(esp,"ESP LINE",50,function()
	notify("ESP Line placeholder")
end)

btn(esp,"ESP HP",90,function()
	notify("ESP HP placeholder")
end)

--====================================================
-- SERVER SAFE
--====================================================

btn(server,"Đổi server",10,function()
	game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)

btn(server,"Mô phỏng mất kết nối",50,function()
	local fake = Instance.new("TextLabel", gui)
	fake.Size=UDim2.new(1,0,0,50)
	fake.Position=UDim2.new(0,0,0.4,0)
	fake.BackgroundTransparency=1
	fake.Text="SERVER CONNECTION LOST"
	fake.TextColor3=Color3.new(1,0,0)
	fake.Font=Enum.Font.GothamBold
	fake.TextSize=32
	task.wait(5)
	fake:Destroy()
end)

--====================================================
-- PLAYER
--====================================================

local y=10
for _,plr in pairs(Players:GetPlayers()) do
	btn(playerTab,plr.Name,y,function()
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
		end
	end)
	y += 35
end

--====================================================
-- SCRIPT
--====================================================

local box = Instance.new("TextBox", scriptTab)
box.Size=UDim2.new(0.9,0,0,100)
box.Position=UDim2.new(0.05,0,0,10)
box.Text="-- nhập script test"
box.BackgroundColor3=Color3.fromRGB(20,20,20)
box.TextColor3=Color3.new(1,1,1)

btn(scriptTab,"Start",120,function()
	print(box.Text)
	notify("Script captured")
end)

local logoBox = Instance.new("TextBox", scriptTab)
logoBox.Size=UDim2.new(0.9,0,0,30)
logoBox.Position=UDim2.new(0.05,0,0,160)
logoBox.Text="Nhập Logo ID"
logoBox.BackgroundColor3=Color3.fromRGB(20,20,20)
logoBox.TextColor3=Color3.new(1,1,1)
