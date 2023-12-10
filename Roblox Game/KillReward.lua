local player = game.Players.LocalPlayer
local Humanoid = script.Parent.Humanoid
local current_multi = player.leaderstats.Multiplier.Value

function PwntX_X() 
local tag = Humanoid:findFirstChild("creator") 
if tag ~= nil then 
if tag.Value ~= nil then 
local Leaderstats = tag.Value:findFirstChild("leaderstats") 
if Leaderstats ~= nil then 
Leaderstats.Etherium.Value = Leaderstats.Etherium.Value + (10*current_multi)  --Change Money to the stat that is increased. 
wait(0.1) 
script:remove() 
end 
end 
end 
end 
Humanoid.Died:connect(PwntX_X)


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

ball.Touched:Connect(function(hit)
    local player = game.Players:GetPlayerFromCharacter(hit.Parent)
    if player then
        local etheriumValue = ball:GetAttribute("EtheriumValue") or 1 -- Default Etherium value from the ball

        -- Retrieve multiplier from player's leaderstats
        local leaderstats = player:FindFirstChild("leaderstats")
        local multiplierStat = leaderstats and leaderstats:FindFirstChild("Multiplier")
        local current_multi = multiplierStat and multiplierStat.Value or 1 -- Default to 1 if not set

        -- Apply multiplier to the Etherium value
        local totalEtherium = etheriumValue * current_multi

        -- Update player's Etherium
        local score = leaderstats and leaderstats:FindFirstChild("Etherium")
        if score then
            score.Value = score.Value + totalEtherium
        end

        -- play sound and destroy the ball
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

        -- Play sound and destroy the ball
        playSound()
        ball:Destroy()

        currentBallCount = currentBallCount - 1
    end
end)