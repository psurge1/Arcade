local window = script.Parent.Frame
local key = game:GetService("UserInputService")
local mouse = game.Players.LocalPlayer:GetMouse()
local BallVel = UDim2.fromScale(0.01, 0.02)
local scoreP = 0
local scoreC = 0
local begintime = 0

local function updateScore()
	script.Parent.Frame.ScorePlayer.Text = scoreP
	script.Parent.Frame.ScoreComputer.Text = scoreC
end

local function reset()
	updateScore()
	window.ball.Position = UDim2.fromScale(0.5, 0.5)
	window.paddle.Position = UDim2.fromScale(0, 0.35)
	window.paddle2.Position = UDim2.fromScale(0.979, 0.35)
	BallVel = UDim2.fromScale(0.01, 0.02)
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

local function offsetToScaleY(offset)
	local vpY = game.Workspace.Camera.ViewportSize.Y
	return offset/vpY
end

local function within(ball, paddle, ballWidth, paddleWidth)
	return ball.Y.Scale <= paddle.Y.Scale + paddleWidth and ball.Y.Scale + ballWidth >= paddle.Y.Scale
end

local function verticalbounce()
	print("vertical")
	-- reverse x
	-- y remains the same
	BallVel = UDim2.fromScale(-1 * BallVel.X.Scale, BallVel.Y.Scale)
end

local function horizontalbounce()
	print("horizontal")
	-- reverse y
	-- x remains the same
	BallVel = UDim2.fromScale(BallVel.X.Scale, -1 * BallVel.Y.Scale)
end

local function stoppitball()
	BallVel = UDim2.fromScale(0, 0)
end

local function bounce()
	local bPos = window.ball.Position
	local p1Pos = window.paddle.Position
	local p2Pos = window.paddle2.Position
	local bw = window.ball.Size.Y.Scale
	local pw = window.paddle.Size.Y.Scale
	if bPos.X.Scale <= 0.05 then
		if within(bPos, p2Pos, bw, pw) then
			verticalbounce()
		else
			scoreP = scoreP + 1
			updateScore()
			stoppitball()
			reset()
		end
	elseif bPos.X.Scale >= 0.95 then
		if within(bPos, p2Pos, bw, pw) then
			verticalbounce()
		else
			scoreC = scoreC + 1
			updateScore()
			stoppitball()
			reset()
		end
	elseif bPos.Y.Scale >= 0.99 or bPos.Y.Scale <= 0.01 then
		horizontalbounce()
	end
end

game.ReplicatedStorage.ShowPongGUI.OnClientEvent:Connect(function()
	show(window)
	wait(2)
	begintime = os.time()
	repeat
		window.paddle2.Position = UDim2.fromScale(window.paddle2.Position.X.Scale, offsetToScaleY(mouse.Y))
		window.paddle.Position = UDim2.fromScale(window.paddle.Position.X.Scale, window.ball.Position.Y.Scale)
		bounce()
		window.ball.Position = UDim2.fromScale(window.ball.Position.X.Scale + BallVel.X.Scale, window.ball.Position.Y.Scale + BallVel.Y.Scale)
		local t = os.time() - begintime
		--window.ScorePlayer.Text = t .. "s"
		local m = t / 100000 + 1
		BallVel = UDim2.fromScale(BallVel.X.Scale * m, BallVel.Y.Scale * m)
		wait()
	until not window.Visible
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