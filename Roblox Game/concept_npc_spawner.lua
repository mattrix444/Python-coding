local npcModel = game.ServerStorage.bloke -- Adjust the path to your NPC model

local currentNpcCount = 0
local maxNpcs = 10 -- Adjust the maximum number of NPCs

local function createNpc(spawnLocation)
    local npc = npcModel:Clone()
    npc.Parent = workspace

    currentNpcCount = currentNpcCount + 1

    -- Calculate random position within the spawn area
    local areaSize = spawnLocation.Size
    local areaPosition = spawnLocation.Position
    local randomX = math.random(-areaSize.X/2, areaSize.X/2)
    local randomY = math.random(-areaSize.Y/2, areaSize.Y/2)
    local randomZ = math.random(-areaSize.Z/2, areaSize.Z/2)
    npc.Position = areaPosition + Vector3.new(randomX, randomY, randomZ)

    -- Add any additional NPC setup here, like setting AI behavior
end

-- Function to spawn NPCs at each spawn location
local function spawnNpcs()
    local spawnLocations = workspace:FindFirstChild("NpcSpawnLocations")
    if not spawnLocations then
        print("NpcSpawnLocations folder not found.")
        return
    end

    local npcsSpawned = 0
    while npcsSpawned < maxNpcs do
        for _, spawnLocation in pairs(spawnLocations:GetChildren()) do
            if npcsSpawned >= maxNpcs then
                break
            end
            createNpc(spawnLocation)
            npcsSpawned = npcsSpawned + 1
            local randomWaitTime = math.random(1, 3)
            wait(randomWaitTime)
        end
    end
end

-- Run the spawn function
spawnNpcs()
