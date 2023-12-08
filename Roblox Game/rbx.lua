-- Color to Etherium value mapping
local colorValues = {
	{Color = Color3.fromRGB(255, 0, 0), Value = 1}, -- Red
	{Color = Color3.fromRGB(0, 255, 0), Value = 2}, -- Green
	{Color = Color3.fromRGB(0, 0, 255), Value = 4}, -- Blue
	{Color = Color3.fromRGB(128, 0, 128), Value = 8} -- Purple
}

local function createBall(spawnLocation)
	local ball = Instance.new("Part")
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(2, 2, 2)
	ball.Anchored = true
	ball.CanCollide = false
	ball.CanTouch = true -- enable touch events
	ball.Transparency = 0 -- Set to 0 for visible balls
	ball.Parent = workspace

	-- Calculate random position within the spawn area
	local areaSize = spawnLocation.Size
	local areaPosition = spawnLocation.Position
	local randomX = math.random(-areaSize.X/2, areaSize.X/2)
	local randomY = math.random(-areaSize.Y/2, areaSize.Y/2)
	local randomZ = math.random(-areaSize.Z/2, areaSize.Z/2)
	ball.Position = areaPosition + Vector3.new(randomX, randomY, randomZ)

	-- Randomly select a color and its corresponding Etherium value
	local colorIndex = math.random(1, #colorValues)
	local chosenColor = colorValues[colorIndex]
	ball.Color = chosenColor.Color
	ball.Name = "EtheriumBall" -- Naming the ball for easy identification
	ball:SetAttribute("EtheriumValue", chosenColor.Value) -- Storing Etherium value as an attribute

	-- Collect the ball
	ball.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			local etheriumValue = ball:GetAttribute("EtheriumValue") or 1 -- Default to 1 if not set
			ball:Destroy()
			-- Update player's Etherium
			local leaderstats = player:FindFirstChild("leaderstats")
			local score = leaderstats and leaderstats:FindFirstChild("Etherium")
			if score then
				score.Value = score.Value + etheriumValue
			end
		end
	end)
end

local maxBalls = 100

-- Function to spawn balls at each spawn location
local function spawnBalls()
	local spawnLocations = workspace:FindFirstChild("BallSpawnLocations")
	if not spawnLocations then
		print("BallSpawnLocations folder not found.")
		return
	end

	local ballsSpawned = 0
	while ballsSpawned < maxBalls do
		for _, spawnLocation in pairs(spawnLocations:GetChildren()) do
			if ballsSpawned >= maxBalls then
				break
			end
			createBall(spawnLocation)
			ballsSpawned = ballsSpawned + 1
			wait(1.0) -- Adjust the wait time as needed
		end
	end
end

-- Run the spawn function
spawnBalls()
