local NpcData = {}

NpcData["Zone1"] = {
	maxNpcs = 10,
    npcBaseHealth = 100,
	npcs = {
	{ name = "Goblin", level = 3, damage = 5, exp = 20 },
	{ name = "Troll", level = 5, damage = 8, exp = 35 },
	{ name = "Orc", level = 6, damage = 9, exp = 40 },
	{ name = "Ogre", level = 7, damage = 10, exp = 50 },
	{ name = "Giant", level = 8, damage = 12, exp = 60},
	{ name = "Dottie", level = 10, damage = 12, exp = 100},
		}
}

NpcData["Zone2"] = {
	maxNpcs = 10,
    npcBaseHealth = 2000,
	npcs = {
	{ name = "Dwarf", level = 14, damage = 12, exp = 60 },
	{ name = "Gnome", level = 16, damage = 14, exp = 70 },
	{ name = "Golem", level = 18, damage = 16, exp = 80 },
	{ name = "Dragon", level = 22, damage = 18, exp = 150},
		}
}

-- Add more zones and NPCs as needed

return NpcData