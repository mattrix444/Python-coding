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

local function createNpc(spawnLocation, npcInfo, rarity)
	local npcModel = npcFolder:FindFirstChild(npcInfo.name)
	if not npcModel then
		print("Error: NPC model not found for name:", npcInfo.name)
		return
	end
	local npc = npcModel:Clone() -- Clone the NPC model
	npc.Parent = game.Workspace
	local nameplateData = npc:FindFirstChild("NamePlateData")
	local mainNameLabel = nameplateData and nameplateData:FindFirstChild("MainNameLabel")
	local affixLabel = nameplateData and nameplateData:FindFirstChild("AffixLabel")
	local suffixLabel = nameplateData and nameplateData:FindFirstChild("SuffixLabel")

	


	local mainNameLabel = nameplateData and nameplateData:FindFirstChild("MainNameLabel")
	if mainNameLabel then
		mainNameLabel.Text = (rarity.name or "") .. " " .. (npcInfo.name or "")  -- e.g., "Rare Orc"
		mainNameLabel.TextColor3 = rarity.color
	end

	local selectedAffixes = selectAffixesForNpc()
	local selectedSuffixes = selectSuffixesForNpc()

	-- Setting up the affixes/suffixes label
	local affixLabel = nameplateData and nameplateData:FindFirstChild("AffixLabel")
	if affixLabel then
		local affixTexts = {}
		for _, affix in ipairs(selectedAffixes) do  -- Implement this function
			table.insert(affixTexts, string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
				AffixData[affix].color.R, AffixData[affix].color.G, AffixData[affix].color.B, affix))
		end
		affixLabel.RichText = true
		affixLabel.Text = table.concat(affixTexts, "")
	end

	local suffixLabel = nameplateData and nameplateData:FindFirstChild("SuffixLabel")
	if suffixLabel then
		local suffixTexts = {}
		for _, suffix in ipairs(selectedSuffixes) do  -- Implement this function
			table.insert(suffixTexts, string.format('<font color="rgb(%d,%d,%d)">%s</font>', 
				SuffixData[suffix].color.R, SuffixData[suffix].color.G, SuffixData[suffix].color.B, suffix))
		end
		suffixLabel.RichText = true
		suffixLabel.Text = table.concat(suffixTexts, "")
	end

	-- Set NPC attributes based on npcInfo and rarity
	npc:SetAttribute("Level", npcInfo.level)
	npc:SetAttribute("Damage", npcInfo.damage + (rarity.bonus.damage or 0))
	npc:SetAttribute("Experience", npcInfo.exp + (rarity.bonus.exp or 0))

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

	-- Add any additional NPC setup here, like setting AI behavior
end

local function spawnNpcsInArea(zoneFolder, areaData)
	print("Spawning NPCs in zone:", zoneFolder.Name)
	print("Area data:", areaData)
	local spawnLocation = zoneFolder:FindFirstChild("SpawnArea")
	if not spawnLocation then
		print("Error: No spawn location found in " .. zoneFolder.Name)
		return
	end

	for i = 1, areaData.maxNpcs do
		local npcInfo = areaData.npcs[math.random(#areaData.npcs)]
		local rarity = selectRarity()
		print("Rarity object in spawnNpcsInArea:", rarity)

		if not rarity then
			print("Error: Failed to select a rarity")
			return
		end

		createNpc(spawnLocation, npcInfo, rarity)
		print("Spawned NPC in " .. zoneFolder.Name .. ", Number: " .. i)

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

