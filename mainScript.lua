local space = game.Workspace

--local GUIspace = game.StarterGui
--local GUIS = {
--	GUIspace.froggerGUI,
--	GUIspace.breakoutGUI,
--	GUIspace.pongGUI,
--	GUIspace.spaceinvadersGUI
--}
--local GUIS = {
--	GUIspace.froggerGUI
--}
--for i, v in ipairs(GUIS) do
--	v.Frame.Visible = false
--end

--local frogger = require(space.frogger)
--local breakout = require(space.spaceinvaders)
--local pong = require(space.ataribreakout)
--local spaceinvaders = require(space.pong)

local frogCooldown = false
local function froggerGame(player)
	if not frogCooldown then
		frogCooldown = true
		if player then
			game.ReplicatedStorage.ShowFroggerGUI:FireClient(player)
			print("event sent")
		end
		wait(4)
		frogCooldown = false
	end
end

local breakoutCooldown = false
local function breakoutGame(player)
	if not breakoutCooldown then
		breakoutCooldown = true
		if player then
			game.ReplicatedStorage.ShowBreakoutGUI:FireClient(player)
			print("sent")
		end
		wait(4)
		breakoutCooldown = false
	end
	--print("breakout")
end

local pongCooldown = false
local function pongGame(player)
	if not pongCooldown then
		pongCooldown = true
		if player then
			game.ReplicatedStorage.ShowPongGUI:FireClient(player)
		end
		wait(4)
		pongCooldown = false
	end
	--print("pong")
end

--local spaceinvadersCooldown = false
--local function spaceinvadersGame(player)
--	if not spaceinvadersCooldown then
--		spaceinvadersCooldown = true
--		if player then
--			game.ReplicatedStorage.ShowSpaceInvadersGUI:FireClient(player)
--		end
--		wait(4)
--		spaceinvadersCooldown = false
--	end
--	--print("spaceinvaders")
--end

--space.FroggerButton.ClickDetector.MouseClick:Connect(froggerGame)
--space.BreakoutButton.ClickDetector.MouseClick:Connect(breakoutGame)
--space.PongButton.ClickDetector.MouseClick:Connect(pongGame)
space.FroggerMachine1.base.ClickDetector.MouseClick:Connect(froggerGame)
space.PongMachine1.base.ClickDetector.MouseClick:Connect(pongGame)
space.PongMachine2.base.ClickDetector.MouseClick:Connect(pongGame)
space.PongMachine3.base.ClickDetector.MouseClick:Connect(pongGame)
space.PongMachine4.base.ClickDetector.MouseClick:Connect(pongGame)
space.BreakupMachine1.base.ClickDetector.MouseClick:Connect(breakoutGame)
--space.SpaceInvadersButton.ClickDetector.MouseClick:Connect(spaceinvadersGame)