Config = {}

Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.BuyZoneSize  = {x = 4, y = 4, z = 4}
Config.Color        = {r = 0, g = 128, b = 255}
Config.TeamDeathMatchBlip = { x = 2071.08, y = 2761.78, z = 50.28}
Config.Spectate = {x = 1970.84, y = 2773.39, z = 59.38}
Config.MapCenter = {x = 2460.720, y = 4976.754, z = 51.567}

Config.Deathmatch = {
    BlueTeam = {
        name = "Blue Team",
        color = { r = 0, g = 128, b = 255},
        game_start_pos = { x = 2418.695, y = 4962.189, z = 46.099},
        enter_pos = { x = 2393.350, y = 4846.089, z = 39.918},
    },
    RedTeam = {
        name = "Red Team",
        color = { r = 255, g = 0, b = 0},
        game_start_pos = { x = 2534.001, y = 4977.588, z = 44.743},
        enter_pos = { x = 2388.086, y = 4845.651, z = 39.918},
    }
}

-- Config.Uniforms = 

Config.BuyMenu = {
    Knife = {
        id = 0,
        label = "Melee",
        list = {
            {
                label = "Battle Axe",
                key = "WEAPON_BATTLEAXE"
            },
            {
                label = "Machete",
                key = "WEAPON_MACHETE"
            },
            {
                label = "Switchblade",
                key = "WEAPON_SWITCHBLADE"
            }
        }
    },
    Pistol = {
        id = 1,
        label = "Pistols",
        list = {
            {
                label = "Pistol",
                key = "WEAPON_PISTOL",
                ammoType = "ammo-9",
                ammo = 100
            },
            {
                label = "AP Pistol",
                key = "WEAPON_APPISTOL",
                ammoType = "ammo-9",
                ammo = 100
            },
        }
    },
    ShortGun = {
        id = 2,
        label = "Shotguns",
        list = {
            {
                label = "Sawed-off Shotgun",
                key = "WEAPON_SAWNOFFSHOTGUN",
                ammoType = "ammo-shotgun",
                ammo = 50
            },
            {
                label = "Pump Shotgun",
                key = "WEAPON_PUMPSHOTGUN",
                ammoType = "ammo-shotgun",
                ammo = 50
            },
        }
    },
    SMG = {
        id = 3,
        label = "Submachine Guns",
        list = {
            {
                label = "Micro SMG (Uzi)",
                key = "WEAPON_MICROSMG",
                ammoType = "ammo-45",
                ammo = 50
            },
            {
                label = "SMG (MP5)",
                key = "WEAPON_SMG",
                ammoType = "ammo-9",
                ammo = 50
            }
        }
    },
    Rifle = {
        id = 4,
        label = "Rifles",
        list = {
            {
                label = "Carbine Rifle (M4)",
                key = "WEAPON_CARBINERIFLE",
                ammoType = "ammo-rifle",
                ammo = 200
            },
            {
                label = "Assault Rifle (AK)",
                key = "WEAPON_ASSAULTRIFLE",
                ammoType = "ammo-rifle2",
                ammo = 200
            },
            {
                label = "Sniper Rifle (M82)",
                key = "WEAPON_HEAVYSNIPER",
                ammoType = "ammo-heavysniper",
                ammo = 20
            }
        }
    },
    Grenade = {
        id = 5,
        label = "Grenades",
        list = {
            {
                label = "Grenade",
                key = "WEAPON_GRENADE",
                ammo = 2
            },
            {
                label = "Molotov Cocktail",
                key = "WEAPON_MOLOTOV",
                ammo = 2
            },
            {
                label = "Smoke Grenade",
                key = "WEAPON_SMOKEGRENADE",
                ammo = 2
            }
        }
    },
    Misc = {
        id = 6,
        label = "Misc",
        list = {
            {
                label = "Bandage",
                key = "bandage"
            },
            {
                label = "Medikit",
                key = "medikit"
            },
            {
                label = "Bulletproof Vest",
                key = "armour"
            },
        }
    }
}
