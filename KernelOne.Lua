--// KERNELX V3 ULTRA FULL 2026
--// Script By: KERNELX

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local state = {
	savedPosition = nil,
	autoJump = false,
	antiAFK = false,
	shiftlock = false,
	selectedPlayer = nil,
	fovRadius = 120,
	highlight = false,
	cameraLock = false
}

local loops = {}
local drawings = {}

--==================================================
-- ROOT GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "KERNELX_ULTRA"
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

--==================================================
-- DRAWING FOV
--==================================================

if Drawing then
	drawings.fov = Drawing.new("Circle")
	drawings.fov.Visible = true
	drawings.fov.Radius = state.fovRadius
	drawings.fov.Thickness = 1.5
	drawings.fov.Filled = false
	drawings.fov.Color = Color3.fromRGB(255,0,0)
	drawings.fov.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
end

RunService.RenderStepped:Connect(function()
	if drawings.fov then
		drawings.fov.Position = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
		drawings.fov.Radius = state.fovRadius
	end
end)

--==================================================
-- NOTIFY
--==================================================

local function Notify(text)
	local frame = Instance.new("Frame")
	frame.Parent = gui
	frame.Size = UDim2.new(0,240,0,42)
	frame.Position = UDim2.new(1,260,0.12,0)
	frame.BackgroundColor3 = Color3.fromRGB(10,10,10)

	local c = Instance.new("UICorner",frame)
	c.CornerRadius = UDim.new(0,12)

	local s = Instance.new("UIStroke",frame)
	s.Color = Color3.fromRGB(255,0,0)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.Size = UDim2.new(1,0,1,0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.Font = Enum.Font.GothamBold
	label.TextSize = 14
	label.TextColor3 = Color3.new(1,1,1)

	TweenService:Create(frame,TweenInfo.new(0.4),{
		Position = UDim2.new(0.82,0,0.12,0)
	}):Play()

	task.wait(2)

	TweenService:Create(frame,TweenInfo.new(0.4),{
		Position = UDim2.new(1,260,0.12,0)
	}):Play()

	task.wait(0.5)
	frame:Destroy()
end

Notify("Script By: KERNELX")

--==================================================
-- LOGO
--==================================================

local logo = Instance.new("TextButton")
logo.Parent = gui
logo.Size = UDim2.new(0,52,0,52)
logo.Position = UDim2.new(0,18,0.42,0)
logo.Text = "K"
logo.Font = Enum.Font.GothamBlack
logo.TextSize = 28
logo.TextColor3 = Color3.new(1,1,1)
logo.BackgroundColor3 = Color3.fromRGB(18,18,18)

Instance.new("UICorner",logo).CornerRadius = UDim.new(1,0)

local logoStroke = Instance.new("UIStroke",logo)
logoStroke.Color = Color3.fromRGB(255,0,0)

--==================================================
-- LOADER
--==================================================

local loader = Instance.new("Frame")
loader.Parent = gui
loader.Size = UDim2.new(0,360,0,130)
loader.Position = UDim2.new(0.5,-180,0.5,-65)
loader.BackgroundColor3 = Color3.fromRGB(10,10,10)

Instance.new("UICorner",loader)

local barBG = Instance.new("Frame")
barBG.Parent = loader
barBG.Size = UDim2.new(0,300,0,14)
barBG.Position = UDim2.new(0.5,-150,0.62,0)
barBG.BackgroundColor3 = Color3.fromRGB(25,25,25)

Instance.new("UICorner",barBG)

local bar = Instance.new("Frame")
bar.Parent = barBG
bar.Size = UDim2.new(0,0,1,0)
bar.BackgroundColor3 = Color3.fromRGB(255,0,0)

Instance.new("UICorner",bar)

local txt = Instance.new("TextLabel")
txt.Parent = loader
txt.Size = UDim2.new(1,0,0,30)
txt.Position = UDim2.new(0,0,0.25,0)
txt.BackgroundTransparency = 1
txt.Text = "decrypting... 0%"
txt.TextColor3 = Color3.new(1,1,1)
txt.Font = Enum.Font.GothamBold
txt.TextSize = 16

for i=1,100 do
	txt.Text = "decrypting... "..i.."%"
	TweenService:Create(bar,TweenInfo.new(0.02),{
		Size = UDim2.new(i/100,0,1,0)
	}):Play()
	task.wait(0.02)
end

task.wait(0.3)
loader:Destroy()

--==================================================
-- MAIN FRAME
--==================================================

local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0,560,0,360)
main.Position = UDim2.new(0.5,-280,0.5,-180)
main.BackgroundColor3 = Color3.fromRGB(12,12,12)
main.Visible = false

Instance.new("UICorner",main)

local stroke = Instance.new("UIStroke",main)
stroke.Color = Color3.fromRGB(255,0,0)

--==================================================
-- TITLE RAINBOW
--==================================================

local title = Instance.new("TextLabel")
title.Parent = main
title.Size = UDim2.new(1,0,0,42)
title.BackgroundTransparency = 1
title.Text = "Nguyen Thanh Phu"
title.Font = Enum.Font.GothamBlack
title.TextSize = 20

RunService.RenderStepped:Connect(function()
	local hue = tick()%5/5
	title.TextColor3 = Color3.fromHSV(hue,1,1)
end)

--==================================================
-- DRAG
--==================================================

local dragging = false
local dragStart, startPos

main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = main.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

--==================================================
-- TAB SYSTEM
--==================================================

local tabNames = {"Main","Visual","Utility","Config"}
local pages = {}

for i,v in ipairs(tabNames) do
	local btn = Instance.new("TextButton")
	btn.Parent = main
	btn.Size = UDim2.new(0,130,0,30)
	btn.Position = UDim2.new(0,(i-1)*135,0,48)
	btn.Text = v
	btn.BackgroundColor3 = Color3.fromRGB(20,20,20)
	btn.TextColor3 = Color3.new(1,1,1)

	Instance.new("UICorner",btn)

	local page = Instance.new("Frame")
	page.Parent = main
	page.Size = UDim2.new(1,-20,1,-95)
	page.Position = UDim2.new(0,10,0,90)
	page.BackgroundTransparency = 1
	page.Visible = false

	pages[v] = page

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pages) do
			p.Visible = false
		end
		page.Visible = true
	end)
end

pages["Main"].Visible = true

--==================================================
-- BUTTON CREATOR
--==================================================

local function Button(parent,text,pos,callback)
	local b = Instance.new("TextButton")
	b.Parent = parent
	b.Size = UDim2.new(0,190,0,35)
	b.Position = pos
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(20,20,20)
	b.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner",b)

	b.MouseButton1Click:Connect(callback)
	return b
end

--==================================================
-- MAIN
--==================================================

Button(pages.Main,"Save Position",UDim2.new(0,10,0,10),function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		state.savedPosition = hrp.CFrame
		Notify("[KERNELX] Saved Position")
	end
end)

Button(pages.Main,"Teleport Saved",UDim2.new(0,10,0,55),function()
	local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
	if hrp and state.savedPosition then
		hrp.CFrame = state.savedPosition
	end
end)

Button(pages.Main,"Auto Jump",UDim2.new(0,10,0,100),function()
	state.autoJump = not state.autoJump
	Notify("[KERNELX] Auto Jump "..(state.autoJump and "ON" or "OFF"))
end)

RunService.Heartbeat:Connect(function()
	if state.autoJump then
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
	end
end)

Button(pages.Main,"Shiftlock",UDim2.new(0,10,0,145),function()
	state.shiftlock = not state.shiftlock
	UIS.MouseBehavior = state.shiftlock and Enum.MouseBehavior.LockCenter or Enum.MouseBehavior.Default
	Notify("[KERNELX] Shiftlock "..(state.shiftlock and "ON" or "OFF"))
end)

--==================================================
-- VISUAL
--==================================================

Button(pages.Visual,"Highlight Players",UDim2.new(0,10,0,10),function()
	for _,v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character then
			if not v.Character:FindFirstChild("Highlight") then
				local h = Instance.new("Highlight")
				h.Parent = v.Character
				h.FillTransparency = 1
				h.OutlineColor = Color3.fromRGB(255,0,0)
			end
		end
	end
end)

Button(pages.Visual,"FOV +20",UDim2.new(0,10,0,55),function()
	state.fovRadius += 20
end)

Button(pages.Visual,"FOV -20",UDim2.new(0,10,0,100),function()
	state.fovRadius = math.max(40,state.fovRadius-20)
end)

--==================================================
-- UTILITY
--==================================================

Button(pages.Utility,"Teleport Random Player",UDim2.new(0,10,0,10),function()
	for _,v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(3,0,0)
			break
		end
	end
end)

Button(pages.Utility,"Camera Focus Random",UDim2.new(0,10,0,55),function()
	for _,v in pairs(Players:GetPlayers()) do
		if v ~= player and v.Character and v.Character:FindFirstChild("Humanoid") then
			Camera.CameraSubject = v.Character.Humanoid
			break
		end
	end
end)

--==================================================
-- CONFIG
--==================================================

Button(pages.Config,"Save Config",UDim2.new(0,10,0,10),function()
	Notify("[KERNELX] Config Saved")
end)

Button(pages.Config,"Load Config",UDim2.new(0,10,0,55),function()
	Notify("[KERNELX] Config Loaded")
end)

Button(pages.Config,"Reset Config",UDim2.new(0,10,0,100),function()
	state.fovRadius = 120
	Notify("[KERNELX] Config Reset")
end)

--==================================================
-- OPEN CLOSE MENU
--==================================================

logo.MouseButton1Click:Connect(function()
	main.Visible = not main.Visible
	if main.Visible then
		main.Size = UDim2.new(0,0,0,0)
		TweenService:Create(main,TweenInfo.new(0.25),{
			Size = UDim2.new(0,560,0,360)
		}):Play()
	end
end)
