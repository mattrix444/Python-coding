local npcFolder = game.ServerStorage:FindFirstChild("Mobs")
local NpcData = require(game.ServerScriptService:FindFirstChild("NpcData")) ---------- path to NpcData module
local RarityData = require(game.ServerScriptService:FindFirstChild("NpcRarities"))  -- path to RarityData module
local AffixData = require(game.ServerScriptService:FindFirstChild("AffixData"))
local SuffixData = require(game.ServerScriptService:FindFirstChild("SuffixData"))


local currentNpcCount = 0

local function selectRarity()
	-- Calculate the total weight of all rarities
	local totalWeight = 0
	for _, rarity in ipairs(RarityData) do
		totalWeight = totalWeight + rarity.weight
	end

	-- Generate a random number within the total weight range
	local randomValue = math.random() * totalWeight

	-- Find the rarity based on the random number
	local cumulativeWeight = 0
	for _, rarity in ipairs(RarityData) do
		cumulativeWeight = cumulativeWeight + rarity.weight
		if randomValue <= cumulativeWeight then
			return rarity  -- return the full rarity object
		end
	end

	return RarityData[1] -- default to the first rarity in case of an issue
end

local function selectRandomAffix()
	local affixNames = {}
	for name in pairs(AffixData) do
		table.insert(affixNames, name)
	end
	return affixNames[math.random(#affixNames)]
end

local function selectRandomSuffix()
	local suffixNames = {}
	for name in pairs(SuffixData) do
		table.insert(suffixNames, name)
	end
	return suffixNames[math.random(#suffixNames)]
end

local function selectAffixesForNpc()
	local selectedAffixes = {}

	-- Initial affix selection with a small chance
	if math.random() < 0.05 then
		local initialAffix = selectRandomAffix()
		table.insert(selectedAffixes, initialAffix)
	end

	-- Chance to add an extra affix (0.5% probability)
	if math.random() < 0.005 then
		local extraAffix = selectRandomAffix()
		table.insert(selectedAffixes, extraAffix)
	end

	return selectedAffixes
end

local function selectSuffixesForNpc()
	local selectedSuffixes = {}

	-- Initial suffix selection with a small chance
	if math.random() < 0.05 then
		local initialSuffix = selectRandomSuffix()
		table.insert(selectedSuffixes, initialSuffix)
	end

	-- Chance to add an extra suffix (0.5% probability)
	if math.random() < 0.005 then
		local extraSuffix = selectRandomSuffix()
		table.insert(selectedSuffixes, extraSuffix)
	end

	return selectedSuffixes
end

local function updateNameplate(nameplateData, npcInfo, rarity, selectedAffixes, selectedSuffixes)
	local mainNameLabel = nameplateData:FindFirstChild("MainNameLabel")
	if mainNameLabel then
		mainNameLabel.Text = (rarity.name or "") .. " " .. (npcInfo.name or "")
		mainNameLabel.TextColor3 = rarity.color
	end

	local affixLabel = nameplateData:FindFirstChild("AffixLabel")
	if affixLabel then
		local affixTexts = {}
		for _, affix in ipairs(selectedAffixes) do
			table.insert(affixTexts, string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
				AffixData[affix].color.R, AffixData[affix].color.G, AffixData[affix].color.B, affix))
		end
		affixLabel.RichText = true
		affixLabel.Text = table.concat(affixTexts, "")
	end

	local suffixLabel = nameplateData:FindFirstChild("SuffixLabel")
	if suffixLabel then
		local suffixTexts = {}
		for _, suffix in ipairs(selectedSuffixes) do
			table.insert(suffixTexts, string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
				SuffixData[suffix].color.R, SuffixData[suffix].color.G, SuffixData[suffix].color.B, suffix))
		end
		suffixLabel.RichText = true
		suffixLabel.Text = table.concat(suffixTexts, "")
	end
end

local function createNpc(spawnLocation, npcInfo, rarity, zoneBaseHealth)
		
	-- Apply rarity bonuses
	local rarityBonus = rarity.bonus
	local finalDamage = npcInfo.damage * (rarityBonus.damage or 1)
	local finalExp = npcInfo.exp * (rarityBonus.exp or 1)
	local finalHealth = zoneBaseHealth * (rarityBonus.extraHealth or 1)

	local selectedAffixes = selectAffixesForNpc()
	local selectedSuffixes = selectSuffixesForNpc()
	
	-- Calculate the final health with Suffix modifiers
	local healthMultiplier = 1

	for _, suffix in ipairs(selectedSuffixes) do
		local suffixData = SuffixData[suffix]
		if suffixData and suffixData.extraHealth then
			if type(suffixData.extraHealth) == "number" then
				finalHealth = finalHealth * suffixData.extraHealth
			else
				print("Warning: extraHealth for suffix", suffix, "is not a number")
			end
		end
	end
	
	local npcModel = npcFolder:FindFirstChild(npcInfo.name)
	if not npcModel then
		print("Error: NPC model not found for name:", npcInfo.name)
		return
	end
	local npc = npcModel:Clone()

	local humanoid = npc:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.MaxHealth = finalHealth
		wait()  -- waiting for MaxHealth to be set before setting Health
		humanoid.Health = finalHealth
		npc:SetAttribute("Health", finalHealth)
	else
		print("Error: No Humanoid found in NPC model")
	end
	
	-- setup nameplate and other labels
	local nameplateData = npc:FindFirstChild("NamePlateData")
	if nameplateData then
		updateNameplate(nameplateData, npcInfo, rarity, selectedAffixes, selectedSuffixes)
	end

	
	-- Find the existing BillboardGui
	local billboardGui = npc:FindFirstChild("BillboardGui")
	
	if billboardGui then

		-- Create or update the health bar frame
		local healthBarFrame = billboardGui:FindFirstChild("HealthBarFrame")
		if not healthBarFrame then
			healthBarFrame = Instance.new("Frame")
			healthBarFrame.Name = "HealthBarFrame"
			healthBarFrame.Size = UDim2.new(1, 0, 0.5, 0)  -- Customize the size as needed
			healthBarFrame.BackgroundColor3 = Color3.new(1, 0, 0) -- Red color for health bar
			healthBarFrame.BorderSizePixel = 0
			healthBarFrame.Parent = billboardGui
		end
		
		local healthTextLabel = healthBarFrame:FindFirstChild("HealthTextLabel")
		if not healthTextLabel then
			healthTextLabel = Instance.new("TextLabel")
			healthTextLabel.Name = "HealthTextLabel"
			healthTextLabel.Size = UDim2.new(1, 0, 1, 0)  -- Fill the health bar frame
			healthTextLabel.BackgroundTransparency = 1  -- Make the background transparent
			healthTextLabel.TextScaled = false  -- Scale text to fit the label
			healthTextLabel.Font = Enum.Font.SourceSans  -- Choose your font
			healthTextLabel.TextColor3 = Color3.new(1, 1, 1)  -- Set text color (white here)
			healthTextLabel.Parent = healthBarFrame
		end

		-- Setting NPC Health and Updating Health Bar
		npc:SetAttribute("Health", finalHealth)
		
		local function updateHealthBar()
			local currentHealth = humanoid.Health  -- Use Humanoid's health
			local maxHealth = humanoid.MaxHealth
			local healthPercentage = currentHealth / maxHealth
			healthBarFrame.Size = UDim2.new(healthPercentage, 0, 0.1, 0)

			healthTextLabel.Text = string.format("%d / %d", currentHealth, maxHealth)
		end

		humanoid.HealthChanged:Connect(updateHealthBar)  -- Connect to Humanoid's HealthChanged event
		updateHealthBar()

		npc:GetAttributeChangedSignal("Health"):Connect(updateHealthBar)
		updateHealthBar()  -- Initial update
	end

	-- Set NPC attributes based on npcInfo and rarity
	npc:SetAttribute("Level", npcInfo.level)
	npc:SetAttribute("Damage", finalDamage)
	npc:SetAttribute("Experience", finalExp)
	npc:SetAttribute("Health", finalHealth)
	
	
	print("Health Multiplier:", healthMultiplier)
	print("Final Health:", finalHealth)

	-- Calculate random position within the spawn area
	local areaSize = spawnLocation.Size
	local areaPosition = spawnLocation.Position
	local randomX = math.random(-areaSize.X/2, areaSize.X/2)
	local randomY = math.random(-areaSize.Y/2, areaSize.Y/2)
	local randomZ = math.random(-areaSize.Z/2, areaSize.Z/2)

	if npc.PrimaryPart then
		npc:SetPrimaryPartCFrame(CFrame.new(areaPosition.X + randomX, areaPosition.Y + randomY, areaPosition.Z + randomZ))
	else
		print("Warning: NPC model does not have a PrimaryPart set")
	end

	npc.Parent = game.Workspace
	
	-- Setup Humanoid Died event for respawning the NPC
	local humanoid = npc:FindFirstChildOfClass("Humanoid")
	if humanoid then
		humanoid.Died:Connect(function()
			wait(5)  -- Wait for a set amount of time before respawning, adjust as needed
			respawnNpc(spawnLocation, npcInfo, zoneBaseHealth)  -- Call respawn function
		end)
	end
end

local function respawnNpc(spawnLocation, npcInfo, zoneBaseHealth)
	local rarity = selectRarity()  -- Re-select rarity for respawned NPC
    local selectedAffixes = selectAffixesForNpc()
    local selectedSuffixes = selectSuffixesForNpc()
	createNpc(spawnLocation, npcInfo, rarity, zoneBaseHealth)
end


local function spawnNpcsInArea(zoneFolder, areaData)
	print("Spawning NPCs in zone:", zoneFolder.Name)
	print("Area data:", areaData)
	local spawnLocation = zoneFolder:FindFirstChild("SpawnArea")
	if not spawnLocation then
		print("Error: No spawn location found in " .. zoneFolder.Name)
		return
	end
	
	print("Zone Name:", zoneFolder.Name)
	print("NPC Base Health for zone:", areaData.npcBaseHealth)

	for i = 1, areaData.maxNpcs do
		local npcInfo = areaData.npcs[math.random(#areaData.npcs)]
		local rarity = selectRarity()
		print(rarity.name, npcInfo.name)
		createNpc(spawnLocation, npcInfo, rarity, areaData.npcBaseHealth)

		local randomWaitTime = math.random(1, 3)
		wait(randomWaitTime)
	end
end

-- Function to spawn NPCs at each spawn location
local function spawnNpcs()
	local spawnLocationsFolder = workspace:FindFirstChild("NpcSpawnLocations")
	if not spawnLocationsFolder then
		print("NpcSpawnLocations folder not found.")
		return
	end

	for _, zoneFolder in pairs(spawnLocationsFolder:GetChildren()) do
		local areaData = NpcData[zoneFolder.Name]

		if not areaData then
			print("Error: No data found for area: " .. zoneFolder.Name)
		else
			coroutine.wrap(spawnNpcsInArea)(zoneFolder, areaData)
		end
	end
end

spawnNpcs()

