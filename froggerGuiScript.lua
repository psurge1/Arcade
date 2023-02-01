local frogger = require(game.Workspace.frogger)
local key = game:GetService("UserInputService")
--local players = game:GetSService("Players")
local window = script.Parent.Frame
local s = 0
local gameover = false

local width = 9
local height = 6
local tiles = {}
tiles['A'] = 10
tiles['X'] = 10
tiles['L'] = 80
MapFP = frogger.MapM:new()
MapFP:setX(width)
MapFP:setY(height)
MapFP:SetBaseSquare('L')
MapFP:SetSafety('L')
MapFP:SetDanger('X')

local w = script.Parent.Frame.screen

local pixels = {
	{w.n1x1, w.n1x2, w.n1x3, w.n1x4, w.n1x5, w.n1x6, w.n1x7, w.n1x8, w.n1x9},
	{w.n2x1, w.n2x2, w.n2x3, w.n2x4, w.n2x5, w.n2x6, w.n2x7, w.n2x8, w.n2x9},
	{w.n3x1, w.n3x2, w.n3x3, w.n3x4, w.n3x5, w.n3x6, w.n3x7, w.n3x8, w.n3x9},
	{w.n4x1, w.n4x2, w.n4x3, w.n4x4, w.n4x5, w.n4x6, w.n4x7, w.n4x8, w.n4x9},
	{w.n5x1, w.n5x2, w.n5x3, w.n5x4, w.n5x5, w.n5x6, w.n5x7, w.n5x8, w.n5x9},
	{w.n6x1, w.n6x2, w.n6x3, w.n6x4, w.n6x5, w.n6x6, w.n6x7, w.n6x8, w.n6x9}
}

local function hide(element)
	--MapFP = nil
	element.Visible = false
	--local player = players.LocalPlayer
	--local playerGUI = player:WaitForChild("PlayerGUI")
	--playerGUI:FindFirstChild("Your_Gui").Enabled = false
end

local function show(element)
	element.Visible = true
	--local player = players.LocalPlayer
	--local playerGUI = player:WaitForChild("PlayerGUI")
	--playerGUI:FindFirstChild("Your_Gui").Enabled = true
end

local function pathof(c)
	local tileImg = {A="rbxassetid://10824884512", X="rbxassetid://10824881237", L="rbxassetid://10824887655"}
	return tileImg[c]
end

local function showMap()
	for h in ipairs(MapFP.map) do
		for k in ipairs(MapFP.map[h]) do
			pixels[h][k].Image = pathof(MapFP.map[h][k])
			pixels[h][k].BorderSizePixel = 0
		end
	end
	pixels[MapFP.p[2]][MapFP.p[1]].Image = "rbxassetid://10824861328"
end

local function move(direction)
	if not gameover then
		--print(direction)
		window.timer.TextLabel.Text = os.time() - s
		if direction == "up" then
			MapFP:Move("u", 1)
		elseif direction == "down" then
			MapFP:Move("d", 1)
		elseif direction == "left" then
			MapFP:Move("l", 1)
		elseif direction == "right" then
			MapFP:Move("r", 1)
		elseif direction == "jump" then
			MapFP:Move("j", 1)
		end
		showMap()
		if MapFP.p[2] == 1 then
			window.timer.TextLabel.Text = "Won: " .. os.time() - s .. "s"
			window.timer.TextLabel.TextColor3 = Color3.new(1, 0, 0)
			gameover = true
		elseif MapFP.map[MapFP.p[2]][MapFP.p[1]] == MapFP.danger then
			window.timer.TextLabel.Text = "Loss: " .. os.time() - s .. "s"
			window.timer.TextLabel.TextColor3 = Color3.new(1, 0, 0)
			gameover = true
		end
	end
end

local function play(x, y)
	gameover = false
	MapFP:SetLocation(math.floor(width/2 + 0.5), height)
	MapFP:Genmap(tiles)
	showMap()
	window.timer.TextLabel.Text = "0"
	window.timer.TextLabel.TextColor3 = Color3.new(0, 0, 0)
	s = os.time()
end

local function gamestart()
	show(window)
	--print("GUI")
	play(9, 6)
end

--if window.Visible then
key.InputBegan:Connect(function(input)
	if window.Visible then
		local k = input.KeyCode
		if k == Enum.KeyCode.Escape then
			hide(window)
		elseif k == Enum.KeyCode.W or k == Enum.KeyCode.Up then
			move("up")
		elseif k == Enum.KeyCode.A or k == Enum.KeyCode.Left then
			move("left")
		elseif k == Enum.KeyCode.S or k == Enum.KeyCode.Down then
			move("down")
		elseif k == Enum.KeyCode.D or k == Enum.KeyCode.Right then
			move("right")
		elseif k == Enum.KeyCode.Space then
			move("jump")
		end
	end
end)
script.Parent.Frame.exitbutton.TextButton.Activated:Connect(function(player)
	if player then
		hide(window)
	end
end)
script.Parent.Frame.upbutton.TextButton.Activated:Connect(function(player)
	if player then
		move("up")
	end
end)
script.Parent.Frame.downbutton.TextButton.Activated:Connect(function(player)
	if player then
		move("down")
	end
end)
script.Parent.Frame.leftbutton.TextButton.Activated:Connect(function(player)
	if player then
		move("left")
	end
end)
script.Parent.Frame.rightbutton.TextButton.Activated:Connect(function(player)
	if player then
		move("right")
	end
end)
script.Parent.Frame.jumpbutton.TextButton.Activated:Connect(function(player)
	if player then
		move("jump")
	end
end)
--script.Parent.Frame.resetbutton.TextButton.Activated:Connect(function(player)
--	if player then

--	end
--end)
--end

game.ReplicatedStorage.ShowFroggerGUI.OnClientEvent:Connect(gamestart)