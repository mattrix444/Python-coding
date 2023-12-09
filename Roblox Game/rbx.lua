local ColorValueWeights = require(game.ServerScriptService.ColorValueWeights) -- Adjust the path as necessary
local DENSITY = 0.3
local FRICTION = 0.1
local ELASTICITY = 1
local FRICTION_WEIGHT = 1
local ELASTICITY_WEIGHT = 1
local physProperties = PhysicalProperties.new(DENSITY, FRICTION, ELASTICITY, FRICTION_WEIGHT, ELASTICITY_WEIGHT)

local currentBallCount = 0
local maxBalls = 100

local function createBall(spawnLocation)
	local ball = Instance.new("Part")
	ball.Shape = Enum.PartType.Ball
	ball.Size = Vector3.new(2, 2, 2)
	ball.Anchored = false
	ball.CanCollide = false
	wait(0.5)
	ball.CanCollide = true
	ball.CanTouch = true -- This should be true for the Touched event to work
	ball.CustomPhysicalProperties = physProperties
	ball.Transparency = 0 -- Set to 0 for visible balls
	ball.Parent = workspace
	
	currentBallCount = currentBallCount + 1

	-- Calculate random position within the spawn area
	local areaSize = spawnLocation.Size
	local areaPosition = spawnLocation.Position
	local randomX = math.random(-areaSize.X/2, areaSize.X/2)
	local randomY = math.random(-areaSize.Y/2, areaSize.Y/2) - 10 -- Add height for dropping
	local randomZ = math.random(-areaSize.Z/2, areaSize.Z/2)
	ball.Position = areaPosition + Vector3.new(randomX, randomY, randomZ)

	-- Function to select a color based on weights
	local function selectColorWeighted()
		local totalWeight = 0
		for _, colorInfo in ipairs(ColorValueWeights.colors) do
			totalWeight = totalWeight + colorInfo.Weight
		end
		local randomWeight = math.random(1, totalWeight)
		local cumulativeWeight = 0
		for _, colorInfo in ipairs(ColorValueWeights.colors) do
			cumulativeWeight = cumulativeWeight + colorInfo.Weight
			if randomWeight <= cumulativeWeight then
				return colorInfo
			end
		end
	end

	-- Randomly select a color and its corresponding Etherium value using weights
	local chosenColor = selectColorWeighted()

	ball.Color = chosenColor.Color
	ball.Name = "EtheriumBall"
	ball:SetAttribute("EtheriumValue", chosenColor.Value)

	-- Collect the ball
	ball.Touched:Connect(function(hit)
		local player = game.Players:GetPlayerFromCharacter(hit.Parent)
		if player then
			local etheriumValue = ball:GetAttribute("EtheriumValue") or 1 -- Default to 1 if not set
			-- function to play a sound when collecting a ball
			local function playSound()
				local sound = Instance.new("Sound")
				sound.SoundId = "rbxassetid://662290183"
				sound.Volume = 0.5
				sound.Parent = ball
				sound:Play()
				sound.Ended:Connect(function()
					sound:Destroy()
				end)
			end
			ball:Destroy()
			-- Update player's Etherium
			local leaderstats = player:FindFirstChild("leaderstats")
			local score = leaderstats and leaderstats:FindFirstChild("Etherium")
			if score then
				score.Value = score.Value + etheriumValue
			end
			currentBallCount = currentBallCount - 1


		end
	end)
end


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
			local randomWaitTime = math.random(1, 3)
			wait(randomWaitTime)
		end
	end
end

-- Run the spawn function
spawnBalls()
