local player = game.Players.LocalPlayer
local surfaceGui = script.Parent
local multiplierLabel = surfaceGui:WaitForChild("MultiplierLabel") -- Rename as per your GUI
local costLabel = surfaceGui:WaitForChild("CostLabel") -- Rename as per your GUI

local function updateGUI()
	local multiplier = player:GetAttribute("Multiplier") or 1
	local etherium = player.leaderstats and player.leaderstats.Etherium.Value or 0
	local nextUpgradeCost = -- Calculate the cost for the next upgrade

		multiplierLabel.Text = "Multiplier: " .. multiplier .. "x"
	costLabel.Text = "Next Upgrade: " .. nextUpgradeCost .. " Etherium"
end

-- Update GUI initially
updateGUI()

-- Set up event listeners to update GUI when player stats change
player.leaderstats.Etherium.Changed:Connect(updateGUI)
player:GetAttributeChangedSignal("Multiplier"):Connect(updateGUI)