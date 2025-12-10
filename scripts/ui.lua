---------------------------------------------------------------------
-- BACKGROUND FOTO KANAN (RAW GITHUB KAMU)
---------------------------------------------------------------------
local BG_URL = "https://raw.githubusercontent.com/https-hyyykkkkshahahaban/cdn/main/images/ketua1.jpg"

---------------------------------------------------------------------
-- THEME
---------------------------------------------------------------------
local THEME = {
	Accent = Color3.fromRGB(0,170,255),
	Text = Color3.fromRGB(255,255,255)
}

---------------------------------------------------------------------
-- RGB BORDER ANIMATION
---------------------------------------------------------------------
local function RGBStroke(stroke)
	task.spawn(function()
		local h = 0
		while stroke do
			h = (h + .002) % 1
			stroke.Color = Color3.fromHSV(h,1,1)
			task.wait()
		end
	end)
end

---------------------------------------------------------------------
-- ESP MULTI SELECT
---------------------------------------------------------------------
local espActive = {}

local function ToggleESP(pl)
	if not pl.Character then return end

	if espActive[pl] then
		espActive[pl]:Destroy()
		espActive[pl] = nil
	else
		local h = Instance.new("Highlight")
		h.FillColor = Color3.fromRGB(0,255,0)
		h.FillTransparency = 0.5
		h.OutlineColor = Color3.fromRGB(255,255,255)
		h.Parent = pl.Character
		espActive[pl] = h
	end
end

---------------------------------------------------------------------
-- UI ROOT
---------------------------------------------------------------------
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", gethui and gethui() or game.CoreGui)

---------------------------------------------------------------------
-- MAIN FRAME (FLOATING + CENTERED)
---------------------------------------------------------------------
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0, 360, 0, 560)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.52, 0)
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.Active = true
Main.Draggable = true
Main.Visible = false
Instance.new("UICorner", Main)

local border = Instance.new("UIStroke", Main)
border.Thickness = 3
RGBStroke(border)

---------------------------------------------------------------------
-- AUTO RESIZE UI BIAR TIDAK KEPANJANGAN
---------------------------------------------------------------------
local cam = workspace.CurrentCamera

local function ResizeUI()
	local screen = cam.ViewportSize
	local height = math.floor(screen.Y * 0.78)
	Main.Size = UDim2.new(0,360,0,height)
end

ResizeUI()
cam:GetPropertyChangedSignal("ViewportSize"):Connect(ResizeUI)

---------------------------------------------------------------------
-- LEFT PANEL (HITAM)
---------------------------------------------------------------------
local Left = Instance.new("Frame", Main)
Left.Size = UDim2.new(0.5,0,1,0)
Left.BackgroundColor3 = Color3.fromRGB(10,10,10)
Instance.new("UICorner", Left)

local leftScroll = Instance.new("ScrollingFrame", Left)
leftScroll.Size = UDim2.new(1,0,1,0)
leftScroll.CanvasSize = UDim2.new(0,0,3,0)
leftScroll.ScrollBarThickness = 4
leftScroll.BackgroundTransparency = 1

local leftLayout = Instance.new("UIListLayout", leftScroll)
leftLayout.Padding = UDim.new(0,10)
leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

---------------------------------------------------------------------
-- RIGHT PANEL (FOTO)
---------------------------------------------------------------------
local Right = Instance.new("Frame", Main)
Right.Size = UDim2.new(0.5,0,1,0)
Right.Position = UDim2.new(0.5,0,0,0)
Right.BackgroundColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", Right)

local Bg = Instance.new("ImageLabel", Right)
Bg.Size = UDim2.new(1,0,1,0)
Bg.BackgroundTransparency = 1
Bg.Image = BG_URL
Bg.ScaleType = Enum.ScaleType.Crop
Bg.ZIndex = 0

local rightScroll = Instance.new("ScrollingFrame", Right)
rightScroll.Size = UDim2.new(1,0,1,0)
rightScroll.CanvasSize = UDim2.new(0,0,3,0)
rightScroll.ScrollBarThickness = 4
rightScroll.BackgroundTransparency = 1
rightScroll.ZIndex = 5

local rightLayout = Instance.new("UIListLayout", rightScroll)
rightLayout.Padding = UDim.new(0,10)
rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

---------------------------------------------------------------------
-- BUTTON CREATOR
---------------------------------------------------------------------
local function LButton(txt)
	local b = Instance.new("TextButton", leftScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = THEME.Accent
	b.TextColor3 = THEME.Text
	b.Text = txt
	Instance.new("UICorner", b)
	return b
end

local function RButton(txt)
	local b = Instance.new("TextButton", rightScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = THEME.Accent
	b.TextColor3 = THEME.Text
	b.Text = txt
	Instance.new("UICorner", b)
	return b
end

local function RBox(txt)
	local b = Instance.new("TextBox", rightScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = Color3.fromRGB(40,40,40)
	b.TextColor3 = THEME.Text
	b.PlaceholderText = txt
	Instance.new("UICorner", b)
	return b
end

---------------------------------------------------------------------
-- OPEN/CLOSE UI
---------------------------------------------------------------------
local Toggle = Instance.new("TextButton", gui)
Toggle.Size = UDim2.new(0,70,0,35)
Toggle.Position = UDim2.new(0.05,0,0.1,0)
Toggle.BackgroundColor3 = THEME.Accent
Toggle.TextColor3 = THEME.Text
Toggle.Text = "OPEN"
Instance.new("UICorner", Toggle)

local opened = false
Toggle.MouseButton1Click:Connect(function()
	opened = not opened
	Main.Visible = opened
	Toggle.Text = opened and "CLOSE" or "OPEN"
end)

---------------------------------------------------------------------
-- LEFT PANEL FEATURES (TITIK & SPEED)
---------------------------------------------------------------------
local t1, t2

LButton("Ambil Titik 1").MouseButton1Click:Connect(function()
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then t1 = hrp.CFrame end
end)

LButton("Teleport Titik 1").MouseButton1Click:Connect(function()
	if t1 then plr.Character.HumanoidRootPart.CFrame = t1 end
end)

LButton("Ambil Titik 2").MouseButton1Click:Connect(function()
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then t2 = hrp.CFrame end
end)

LButton("Teleport Titik 2").MouseButton1Click:Connect(function()
	if t2 then plr.Character.HumanoidRootPart.CFrame = t2 end
end)

local speedBtn = LButton("Input Speed")
local speedBox = Instance.new("TextBox", speedBtn)
speedBox.BackgroundTransparency = 1
speedBox.Size = UDim2.new(1,0,1,0)
speedBox.PlaceholderText = "1-100"
speedBox.TextColor3 = Color3.fromRGB(255,255,255)

speedBox.FocusLost:Connect(function()
	local n = tonumber(speedBox.Text)
	if n then plr.Character.Humanoid.WalkSpeed = math.clamp(n,1,100) end
end)

local resetSpeed = LButton("Reset Speed")
resetSpeed.BackgroundColor3 = Color3.fromRGB(200,50,50)
resetSpeed.MouseButton1Click:Connect(function()
	plr.Character.Humanoid.WalkSpeed = 16
end)

---------------------------------------------------------------------
-- RIGHT PANEL FEATURES
---------------------------------------------------------------------

-------------------- TELEPORT PLAYER ---------------------
local selectedTP
local tpDrop = RButton("Teleport Player")

local tpFrame = Instance.new("ScrollingFrame", rightScroll)
tpFrame.Size = UDim2.new(0,150,0,120)
tpFrame.Visible = false
tpFrame.CanvasSize = UDim2.new(0,0,0,0)
tpFrame.ScrollBarThickness = 4
tpFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", tpFrame)

local tpLayout = Instance.new("UIListLayout", tpFrame)
tpLayout.Padding = UDim.new(0,5)

tpDrop.MouseButton1Click:Connect(function()
	tpFrame.Visible = not tpFrame.Visible
end)

local function RefreshTP()
	for _,v in ipairs(tpFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end

	for _,p in ipairs(game.Players:GetPlayers()) do
		if p ~= plr then
			local b = RButton(p.Name)
			b.Parent = tpFrame
			b.MouseButton1Click:Connect(function()
				selectedTP = p
				tpDrop.Text = "TP: "..p.Name
				tpFrame.Visible = false
			end)
		end
	end

	task.wait()
	tpFrame.CanvasSize = UDim2.new(0,0,0,tpLayout.AbsoluteContentSize.Y)
end
RefreshTP()

-------------------- TELEPORT NOW ---------------------
RButton("Teleport Now").MouseButton1Click:Connect(function()
	if selectedTP and selectedTP.Character then
		plr.Character.HumanoidRootPart.CFrame =
			selectedTP.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
	end
end)

-------------------- ESP PLAYER ---------------------
local espDrop = RButton("ESP Player")

local espFrame = Instance.new("ScrollingFrame", rightScroll)
espFrame.Size = UDim2.new(0,150,0,120)
espFrame.Visible = false
espFrame.CanvasSize = UDim2.new(0,0,0,0)
espFrame.ScrollBarThickness = 4
espFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", espFrame)

local espLayout = Instance.new("UIListLayout", espFrame)
espLayout.Padding = UDim.new(0,5)

espDrop.MouseButton1Click:Connect(function()
	espFrame.Visible = not espFrame.Visible
end)

local function RefreshESP()
	for _,v in ipairs(espFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end

	for _,p in ipairs(game.Players:GetPlayers()) do
		if p ~= plr then
			local b = RButton(p.Name)
			b.Parent = espFrame

			if espActive[p] then
				b.BackgroundColor3 = Color3.fromRGB(0,200,0)
			end

			b.MouseButton1Click:Connect(function()
				ToggleESP(p)
				b.BackgroundColor3 =
					espActive[p] and Color3.fromRGB(0,200,0) or THEME.Accent
			end)
		end
	end

	task.wait()
	espFrame.CanvasSize = UDim2.new(0,0,0,espLayout.AbsoluteContentSize.Y)
end
RefreshESP()

-------------------- THEME RGB ---------------------
local themeBox = RBox("R,G,B")
themeBox.FocusLost:Connect(function()
	local r,g,b = themeBox.Text:match("(%d+),(%d+),(%d+)")

	if r then
		local new = Color3.fromRGB(r,g,b)
		THEME.Accent = new

		for _,v in gui:GetDescendants() do
			if v:IsA("TextButton") then v.BackgroundColor3 = new end
		end
	end
end)		espActive[pl]:Destroy()
		espActive[pl] = nil
	else
		local h = Instance.new("Highlight")
		h.FillColor = Color3.fromRGB(0,255,0)
		h.FillTransparency = 0.5
		h.OutlineColor = Color3.fromRGB(255,255,255)
		h.Parent = pl.Character
		espActive[pl] = h
	end
end

---------------------------------------------------------------------
-- UI ROOT
---------------------------------------------------------------------
local plr = game.Players.LocalPlayer
local gui = Instance.new("ScreenGui", gethui and gethui() or game.CoreGui)

---------------------------------------------------------------------
-- MAIN FRAME (FLOATING + CENTERED)
---------------------------------------------------------------------
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0, 360, 0, 560)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.52, 0) -- sedikit di bawah tengah
Main.BackgroundColor3 = Color3.fromRGB(0,0,0)
Main.Active = true
Main.Draggable = true
Main.Visible = false
Instance.new("UICorner", Main)

local border = Instance.new("UIStroke", Main)
border.Thickness = 3
RGBStroke(border)

---------------------------------------------------------------------
-- AUTO RESIZE UI (BIAR TIDAK KEPANJANGAN)
---------------------------------------------------------------------
local cam = workspace.CurrentCamera

local function ResizeUI()
	local screen = cam.ViewportSize
	local H = math.floor(screen.Y * 0.78)
	Main.Size = UDim2.new(0, 360, 0, H)
end

ResizeUI()
cam:GetPropertyChangedSignal("ViewportSize"):Connect(ResizeUI)

---------------------------------------------------------------------
-- LEFT PANEL (HITAM)
---------------------------------------------------------------------
local Left = Instance.new("Frame", Main)
Left.Size = UDim2.new(0.5,0,1,0)
Left.BackgroundColor3 = Color3.fromRGB(10,10,10)
Left.ZIndex = 1
Instance.new("UICorner", Left)

local leftScroll = Instance.new("ScrollingFrame", Left)
leftScroll.Size = UDim2.new(1,0,1,0)
leftScroll.CanvasSize = UDim2.new(0,0,3,0)
leftScroll.ScrollBarThickness = 4
leftScroll.BackgroundTransparency = 1

local leftLayout = Instance.new("UIListLayout", leftScroll)
leftLayout.Padding = UDim.new(0,10)
leftLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

---------------------------------------------------------------------
-- RIGHT PANEL (FOTO)
---------------------------------------------------------------------
local Right = Instance.new("Frame", Main)
Right.Size = UDim2.new(0.5,0,1,0)
Right.Position = UDim2.new(0.5,0,0,0)
Right.BackgroundColor3 = Color3.fromRGB(0,0,0)
Instance.new("UICorner", Right)

local Bg = Instance.new("ImageLabel", Right)
Bg.Size = UDim2.new(1,0,1,0)
Bg.BackgroundTransparency = 1
Bg.Image = BG_URL
Bg.ScaleType = Enum.ScaleType.Crop
Bg.ZIndex = 0

local rightScroll = Instance.new("ScrollingFrame", Right)
rightScroll.Size = UDim2.new(1,0,1,0)
rightScroll.CanvasSize = UDim2.new(0,0,3,0)
rightScroll.ScrollBarThickness = 4
rightScroll.BackgroundTransparency = 1
rightScroll.ZIndex = 5

local rightLayout = Instance.new("UIListLayout", rightScroll)
rightLayout.Padding = UDim.new(0,10)
rightLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

---------------------------------------------------------------------
-- BUTTON MAKERS
---------------------------------------------------------------------
local function LButton(text)
	local b = Instance.new("TextButton", leftScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = THEME.Accent
	b.TextColor3 = THEME.Text
	b.Text = text
	Instance.new("UICorner", b)
	return b
end

local function RButton(text)
	local b = Instance.new("TextButton", rightScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = THEME.Accent
	b.TextColor3 = THEME.Text
	b.Text = text
	Instance.new("UICorner", b)
	return b
end

local function RBox(text)
	local b = Instance.new("TextBox", rightScroll)
	b.Size = UDim2.new(0,150,0,35)
	b.BackgroundColor3 = Color3.fromRGB(50,50,50)
	b.TextColor3 = THEME.Text
	b.PlaceholderText = text
	Instance.new("UICorner", b)
	return b
end

---------------------------------------------------------------------
-- OPEN/CLOSE BUTTON
---------------------------------------------------------------------
local Toggle = Instance.new("TextButton", gui)
Toggle.Size = UDim2.new(0,70,0,35)
Toggle.Position = UDim2.new(0.05,0,0.1,0)
Toggle.BackgroundColor3 = THEME.Accent
Toggle.TextColor3 = THEME.Text
Toggle.Text = "OPEN"
Instance.new("UICorner", Toggle)

local opened = false
Toggle.MouseButton1Click:Connect(function()
	opened = not opened
	Toggle.Text = opened and "CLOSE" or "OPEN"
	Main.Visible = opened
end)

---------------------------------------------------------------------
-- LEFT SIDE FEATURES (TITIK & SPEED)
---------------------------------------------------------------------
local t1, t2

LButton("Ambil Titik 1").MouseButton1Click:Connect(function()
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then t1 = hrp.CFrame end
end)

LButton("Teleport Titik 1").MouseButton1Click:Connect(function()
	if t1 then plr.Character.HumanoidRootPart.CFrame = t1 end
end)

LButton("Ambil Titik 2").MouseButton1Click:Connect(function()
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
	if hrp then t2 = hrp.CFrame end
end)

LButton("Teleport Titik 2").MouseButton1Click:Connect(function()
	if t2 then plr.Character.HumanoidRootPart.CFrame = t2 end
end)

local speedBox = LButton("Input Speed")
local box = Instance.new("TextBox", speedBox)
box.BackgroundTransparency = 1
box.Size = UDim2.new(1,0,1,0)
box.PlaceholderText = "1-100"
box.Text = ""
box.TextColor3 = Color3.fromRGB(255,255,255)

box.FocusLost:Connect(function()
	local n = tonumber(box.Text)
	if n then plr.Character.Humanoid.WalkSpeed = math.clamp(n,1,100) end
end)

local reset = LButton("Reset Speed")
reset.BackgroundColor3 = Color3.fromRGB(200,50,50)
reset.MouseButton1Click:Connect(function()
	plr.Character.Humanoid.WalkSpeed = 16
end)

---------------------------------------------------------------------
-- RIGHT SIDE FEATURES
---------------------------------------------------------------------

-------------------- TELEPORT PLAYER ---------------------
local selectedTP = nil
local tpDrop = RButton("Teleport Player")

local tpFrame = Instance.new("ScrollingFrame", rightScroll)
tpFrame.Size = UDim2.new(0,150,0,120)
tpFrame.Visible = false
tpFrame.CanvasSize = UDim2.new(0,0,0,0)
tpFrame.ScrollBarThickness = 4
tpFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", tpFrame)

local tpLayout = Instance.new("UIListLayout", tpFrame)
tpLayout.Padding = UDim.new(0,5)

tpDrop.MouseButton1Click:Connect(function()
	tpFrame.Visible = not tpFrame.Visible
end)

local function RefreshTP()
	for _,v in ipairs(tpFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end

	for _,p in ipairs(game.Players:GetPlayers()) do
		if p ~= plr then
			local b = RButton(p.Name)
			b.Parent = tpFrame
			b.MouseButton1Click:Connect(function()
				selectedTP = p
				tpDrop.Text = "TP: "..p.Name
				tpFrame.Visible = false
			end)
		end
	end

	task.wait()
	tpFrame.CanvasSize = UDim2.new(0,0,0,tpLayout.AbsoluteContentSize.Y)
end
RefreshTP()

-------------------- TELEPORT NOW ---------------------
RButton("Teleport Now").MouseButton1Click:Connect(function()
	if selectedTP and selectedTP.Character then
		plr.Character.HumanoidRootPart.CFrame =
			selectedTP.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
	end
end)

-------------------- ESP PLAYER ---------------------
local espDrop = RButton("ESP Player")

local espFrame = Instance.new("ScrollingFrame", rightScroll)
espFrame.Size = UDim2.new(0,150,0,120)
espFrame.Visible = false
espFrame.ScrollBarThickness = 4
espFrame.CanvasSize = UDim2.new(0,0,0,0)
espFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
Instance.new("UICorner", espFrame)

local espLayout = Instance.new("UIListLayout", espFrame)
espLayout.Padding = UDim.new(0,5)

espDrop.MouseButton1Click:Connect(function()
	espFrame.Visible = not espFrame.Visible
end)

local function RefreshESP()
	for _,v in ipairs(espFrame:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end

	for _,p in ipairs(game.Players:GetPlayers()) do
		if p ~= plr then
			local b = RButton(p.Name)
			b.Parent = espFrame

			if espActive[p] then
				b.BackgroundColor3 = Color3.fromRGB(0,200,0)
			end

			b.MouseButton1Click:Connect(function()
				ToggleESP(p)
				b.BackgroundColor3 = espActive[p] and Color3.fromRGB(0,200,0) or THEME.Accent
			end)
		end
	end

	task.wait()
	espFrame.CanvasSize = UDim2.new(0,0,0,espLayout.AbsoluteContentSize.Y)
end
RefreshESP()

-------------------- THEME RGB ---------------------
local themeBox = RBox("R,G,B")
themeBox.FocusLost:Connect(function()
	local r,g,b = themeBox.Text:match("(%d+),(%d+),(%d+)")
	if r then
		local new = Color3.fromRGB(r,g,b)
		THEME.Accent = new

		for _,v in gui:GetDescendants() do
			if v:IsA("TextButton") then
				v.BackgroundColor3 = new
			end
		end
	end
end)
