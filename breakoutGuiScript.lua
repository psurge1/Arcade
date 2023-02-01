local window = script.Parent.Frame
local key = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local BallVel = UDim2.fromScale(0.01, -0.02)
local scoreP = 0
local scoreC = 0
local gameover = false
local begintime = 0

local function updateScore()
	script.Parent.Frame.ScorePlayer.Text = scoreP
end

local function reset()
	updateScore()
	gameover = false
	window.ball.Position = UDim2.fromScale(0.5, 0.5)
	window.paddle2.Position = UDim2.fromScale(0.45, 0.96)
	BallVel = UDim2.fromScale(0.01, -0.02)
end

local function hide(element)
	--game.Workspace.BreakoutButton.Transparency = 0
	--game.Workspace.FroggerButton.Transparency = 0
	--game.Workspace.PongButton.Transparency = 0
	--game.Workspace.SpaceInvadersButton.Transparency = 0
	element.Visible = false
end

local function show(element)
	scoreP = 0
	scoreC = 0
	reset()
	--game.Workspace.BreakoutButton.Transparency = 1
	--game.Workspace.FroggerButton.Transparency = 1
	--game.Workspace.PongButton.Transparency = 1
	--game.Workspace.SpaceInvadersButton.Transparency = 1
	element.Visible = true
end

local function offsetToScaleX(offset)
	local vpX = game.Workspace.Camera.ViewportSize.X
	return offset/vpX
end

local function within(ball, paddle, ballWidth, paddleWidth)
	return ball.X.Scale <= paddle.X.Scale + paddleWidth and ball.X.Scale + ballWidth >= paddle.X.Scale
end

local function verticalbounce()
	-- reverse x
	-- y remains the same
	BallVel = UDim2.fromScale(-1 * BallVel.X.Scale, BallVel.Y.Scale)
end

local function horizontalbounce()
	-- reverse y
	-- x remains the same
	BallVel = UDim2.fromScale(BallVel.X.Scale, -1 * BallVel.Y.Scale)
end

local function stoppitball()
	BallVel = UDim2.fromScale(0, 0)
end

local function bounce()
	local bPos = window.ball.Position
	local p2Pos = window.paddle2.Position
	local bw = window.ball.Size.X.Scale
	local pw = window.paddle2.Size.X.Scale
	--print(bPos.X.Scale .. ", " .. bPos.Y.Scale)
	if bPos.Y.Scale <= 0.01 then
		horizontalbounce()
	elseif bPos.Y.Scale >= 1 - (window.paddle2.Size.Y.Scale + window.ball.Size.Y.Scale) then
		if within(bPos, p2Pos, bw, pw) then
			horizontalbounce()
		else
			scoreC = scoreC + 1
			updateScore()
			stoppitball()
			gameover = true
			--reset()
		end
	elseif bPos.X.Scale >= 1 - window.ball.Size.X.Scale or bPos.X.Scale <= 0.01 then
		verticalbounce()
	end
end

game.ReplicatedStorage.ShowBreakoutGUI.OnClientEvent:Connect(function()
	show(window)
	wait(2)
	begintime = os.time()
	repeat
		--print(mouse.X .. ", " .. offsetToScaleX(mouse.X))
		window.paddle2.Position = UDim2.fromScale(offsetToScaleX(mouse.X) - window.paddle2.Size.X.Scale / 2, window.paddle2.Position.Y.Scale)
		bounce()
		window.ball.Position = UDim2.fromScale(window.ball.Position.X.Scale + BallVel.X.Scale, window.ball.Position.Y.Scale + BallVel.Y.Scale)
		local t = os.time() - begintime
		window.ScorePlayer.Text = t .. "s"
		local m = t / 10000 + 1
		BallVel = UDim2.fromScale(BallVel.X.Scale * m, BallVel.Y.Scale * m)
		wait()
	until gameover or not window.Visible
end)

key.InputBegan:Connect(function(input)
	if window.Visible then
		local k = input.KeyCode
		if k == Enum.KeyCode.Escape then
			hide(window)
		end
	end
end)

--if window.Visible then
window.exitbutton.Activated:Connect(function(player)
	if player then
		hide(window)
	end
end)
--end