local RarityData = {
    Common = { color = Color3.fromRGB(255, 255, 255), bonus = {} },
    Uncommon = { color = Color3.fromRGB(0, 255, 0), bonus = { extraExp = 10 } },
    Rare = { color = Color3.fromRGB(0, 0, 255), bonus = { extraExp = 20, extraDamage = 2 } },
    Epic = { color = Color3.fromRGB(255, 0, 0), bonus = { extraExp = 30, extraDamage = 4 } },
    Legendary = { color = Color3.fromRGB(255, 215, 0), bonus = { extraExp = 50, extraDamage = 6 } },
    Godly = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 100, extraDamage = 10 } },
    Transcendent = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 200, extraDamage = 20 } },
    Omega = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 500, extraDamage = 50 } },
    Celestial = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 1000, extraDamage = 100 } },
    Ascended = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 2000, extraDamage = 200 } },
    Mythical = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 5000, extraDamage = 500 } },
    Divine = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 10000, extraDamage = 1000 } },
    Ancient = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 20000, extraDamage = 2000 } },
    Immortal = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 50000, extraDamage = 5000 } },
    Eternal = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 100000, extraDamage = 10000 } },
    Radiant = { color = Color3.fromRGB(255, 0, 255), bonus = { extraExp = 200000, extraDamage = 20000 } },
}

return RarityData
