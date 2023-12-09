local pad = script.Parent
local multiplierCost = 10 -- Cost of the multiplier
local multiplierAmount = 2 -- Multiplier to be applied

local function onPadTouched(other)
	local player = game.Players:GetPlayerFromCharacter(other.Parent)
	if player then
		local etherium = player.leaderstats and player.leaderstats.Etherium
		local currentMultiplier = player:GetAttribute("Multiplier") or 1

		if etherium and etherium.Value >= multiplierCost then
			etherium.Value = etherium.Value - multiplierCost
			player:SetAttribute("Multiplier", currentMultiplier + multiplierAmount)
			print(player.Name .. " has purchased a multiplier. New Multiplier: " .. player:GetAttribute("Multiplier"))
            multiplierCost = multiplierCost * 2
            
			-- Add additional effects or notifications here if needed
		else
			print(player.Name .. " does not have enough Etherium to purchase the multiplier.")
			-- Notify the player they don't have enough Etherium
		end
	end
end

pad.Touched:Connect(onPadTouched)
