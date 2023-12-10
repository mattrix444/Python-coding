local Affixata = {
    Volatile = { ExplodeOnDeath = True, Weight = 1000 },
    Burning = { BurnOnHit = True, Weight = 100 },
    Freezing = { FreezeOnHit = True, Weight = 100 },
    Poisonous = { PoisonOnHit = True, Weight = 100 },
    Shocking = { ShockOnHit = True, Weight = 100 },
    Healing = { HealOnHit = True, Weight = 50 },
    Regenerating = { Regening = True, Weight = 200 },
    Reflecting = { Reflect = True, Weight = 50 },
    Chaotic = { ExtraProjectiles = random(1, 3), Weight = 100 },
    Piercing = { Pierce = True, Weight = 100 },
    Immunity = { Immune = True, Weight = 100},

}

return AffixData
