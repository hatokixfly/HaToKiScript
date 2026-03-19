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
	local notif = Instance.new("Frame")
	notif.Parent = gui
	notif.Size = UDim2.new(0,220,0,40)
	notif.Position = UDim2.new(1,-240,0,20)
	notif.BackgroundColor3 = Color3.fromRGB(15,15,15)
	notif.BorderSizePixel = 0
	Instance.new("UICorner", notif)

	local txt = Instance.new("TextLabel")
	txt.Parent = notif
	txt.Size = UDim2.new(1,0,1,0)
	txt.BackgroundTransparency = 1
	txt.Text = text
	txt.TextColor3 = Color3.new(1,1,1)
	txt.Font = Enum.Font.GothamBold
	txt.TextSize = 13

	notif.BackgroundTransparency = 1
	txt.TextTransparency = 1

	TweenService:Create(notif,TweenInfo.new(0.25),{BackgroundTransparency=0}):Play()
	TweenService:Create(txt,TweenInfo.new(0.25),{TextTransparency=0}):Play()

	task.wait(2)

	TweenService:Create(notif,TweenInfo.new(0.25),{BackgroundTransparency=1}):Play()
	TweenService:Create(txt,TweenInfo.new(0.25),{TextTransparency=1}):Play()

	task.wait(0.3)
	notif:Destroy()
end

--====================================================
-- LOADING
--====================================================

local loading = Instance.new("Frame", gui)
loading.Size = UDim2.new(0,260,0,100)
loading.Position = UDim2.new(0.5,-130,0.5,-50)
loading.BackgroundColor3 = Color3.fromRGB(10,10,10)
loading.BorderSizePixel = 0
Instance.new("UICorner", loading)

local txt = Instance.new("TextLabel", loading)
txt.Size = UDim2.new(1,0,0,35)
txt.BackgroundTransparency = 1
txt.Text = "Loading 1%"
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold
txt.TextSize = 17

local bg = Instance.new("Frame", loading)
bg.Size = UDim2.new(0.8,0,0,14)
bg.Position = UDim2.new(0.1,0,0.65,0)
bg.BackgroundColor3 = Color3.fromRGB(25,25,25)
bg.BorderSizePixel = 0
Instance.new("UICorner", bg)

local fill = Instance.new("Frame", bg)
fill.Size = UDim2.new(0,0,1,0)
fill.BackgroundColor3 = Color3.fromRGB(255,0,60)
fill.BorderSizePixel = 0
Instance.new("UICorner", fill)

for i=1,100 do
	txt.Text = "Loading "..i.."%"
	fill.Size = UDim2.new(i/100,0,1,0)
	task.wait(0.01)
end

loading:Destroy()
notify("Script By: KERNELX")

--====================================================
-- LOGO
--====================================================

local logo = Instance.new("TextButton", gui)
logo.Size = UDim2.new(0,50,0,50)
logo.Position = UDim2.new(0,20,0.4,0)
logo.BackgroundColor3 = Color3.fromRGB(20,20,20)
logo.Text = "K"
logo.TextColor3 = Color3.fromRGB(255,0,80)
logo.Font = Enum.Font.GothamBold
logo.TextSize = 26
logo.BorderSizePixel = 0
Instance.new("UICorner", logo).CornerRadius = UDim.new(1,0)

--====================================================
-- MENU
--====================================================

local menu = Instance.new("Frame", gui)
menu.Size = UDim2.new(0,330,0,400)
menu.Position = UDim2.new(0.5,-165,0.5,-200)
menu.BackgroundColor3 = Color3.fromRGB(12,12,12)
menu.Visible = false
menu.BorderSizePixel = 0
Instance.new("UICorner", menu)

-- title
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

-- minimize
local mini = Instance.new("TextButton", menu)
mini.Size = UDim2.new(0,30,0,25)
mini.Position = UDim2.new(1,-35,0,5)
mini.Text = "-"
mini.BackgroundColor3 = Color3.fromRGB(25,25,25)
mini.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", mini)

local minimized = false
mini.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		TweenService:Create(menu,TweenInfo.new(0.25),{Size=UDim2.new(0,330,0,40)}):Play()
	else
		TweenService:Create(menu,TweenInfo.new(0.25),{Size=UDim2.new(0,330,0,400)}):Play()
	end
end)

-- draggable
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
		menu.Position = UDim2.new(startPos.X.Scale,startPos.X.Offset+delta.X,startPos.Y.Scale,startPos.Y.Offset+delta.Y)
	end
end)

--====================================================
-- TAB SYSTEM
--====================================================

local tabs = {}
local pages = {}

local function createTab(name,x)
	local btn = Instance.new("TextButton", menu)
	btn.Size = UDim2.new(0,90,0,30)
	btn.Position = UDim2.new(0,x,0,45)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn)

	local page = Instance.new("Frame", menu)
	page.Size = UDim2.new(1,-20,1,-90)
	page.Position = UDim2.new(0,10,0,85)
	page.BackgroundTransparency = 1
	page.Visible = false

	tabs[name]=btn
	pages[name]=page

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do p.Visible=false end
		page.Visible=true
	end)

	return page
end

local mainPage = createTab("MAIN",10)
local weaponPage = createTab("WEAPON",110)
local debugPage = createTab("DEBUG",210)

pages["MAIN"].Visible=true

--====================================================
-- BUTTON CREATOR
--====================================================

local function addButton(parent,text,y,callback)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(0.9,0,0,32)
	b.Position = UDim2.new(0.05,0,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(25,25,25)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", b)
	b.MouseButton1Click:Connect(callback)
end

-- MAIN TAB
addButton(mainPage,"Save Position",10,function()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp then
		savedPosition = hrp.CFrame
		notify("Position Saved")
	end
end)

addButton(mainPage,"Teleport Saved",50,function()
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if hrp and savedPosition then
		hrp.CFrame = savedPosition
		notify("Teleported")
	end
end)

addButton(mainPage,"Auto Jump Toggle",90,function()
	autoJump = not autoJump
	notify("Auto Jump "..(autoJump and "ON" or "OFF"))
	if autoJump then
		task.spawn(function()
			while autoJump do
				local hum = character:FindFirstChildOfClass("Humanoid")
				if hum then hum.Jump=true end
				task.wait(0.5)
			end
		end)
	end
end)

-- WEAPON TAB (safe placeholder only)
addButton(weaponPage,"Mode Stick",10,function()
	selectedWeapon="Stick"
	notify("Stick")
end)

addButton(weaponPage,"Mode Gun",50,function()
	selectedWeapon="Gun"
	notify("Gun")
end)

addButton(weaponPage,"Mode Brainrot",90,function()
	selectedWeapon="Brainrot"
	notify("Brainrot")
end)

addButton(weaponPage,"Damage Preview",130,function()
	notify("Damage Placeholder")
end)

-- DEBUG TAB
addButton(debugPage,"Detect Tool",10,function()
	local tool = character:FindFirstChildOfClass("Tool")
	notify(tool and tool.Name or "None")
end)

addButton(debugPage,"Character HP",50,function()
	local hum = character:FindFirstChildOfClass("Humanoid")
	if hum then notify("HP "..math.floor(hum.Health)) end
end)

addButton(debugPage,"Refresh Character",90,function()
	character = player.Character or player.CharacterAdded:Wait()
	notify("Refreshed")
end)

--====================================================
-- OPEN CLOSE
--====================================================

local opened = false
logo.MouseButton1Click:Connect(function()
	opened = not opened
	menu.Visible = opened
end)
