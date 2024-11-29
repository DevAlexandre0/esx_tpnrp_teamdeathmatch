Config = {}

Config.DrawDistance = 100
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.BuyZoneSize  = {x = 4, y = 4, z = 4}
Config.Color        = {r = 0, g = 128, b = 255}
--Config.TeamDeathMatchBlip = { x = 2071.08, y = 2761.78, z = 50.28}
--Config.Spectate = {x = 1970.84, y = 2773.39, z = 59.38}
Config.MapCenter = {x = 2460.720, y = 4976.754, z = 51.567}

Config.Deathmatch = {
    BlueTeam = {
        name = "Blue Team",
        color = { r = 0, g = 128, b = 255},
        game_start_pos = { x = 2423.136, y = 4968.331, z = 46.119},
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
    Pistol = {
        id = 1,
        label = "Pistols",
        list = {
            {
                label = "Pistol",
                key = "WEAPON_PISTOL",
                --cost = 2
            },
            {
                label = "AP Pistol",
                key = "WEAPON_APPISTOL",
                --cost = 2
            },
        }
    },
    ShortGun = {
        id = 2,
        label = "Shotguns",
        list = {
            {
                label = "Pump Shotgun",
                key = "WEAPON_PUMPSHOTGUN",
                --cost = 4
            },
        }
    },
    SMG = {
        id = 3,
        label = "Submachine Guns",
        list = {
            {
                label = "SMG (MP5)",
                key = "WEAPON_SMG",
                --cost = 3
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
                --cost = 4
            },
            {
                label = "Assault Rifle (AK)",
                key = "WEAPON_ASSAULTRIFLE",
                --cost = 4
            },
        }
    },
    Grenade = {
        id = 5,
        label = "Grenades",
        list = {
            {
                label = "Grenade",
                key = "WEAPON_GRENADE",
                --cost = 2
            },
            {
                label = "Smoke Grenade",
                key = "WEAPON_SMOKEGRENADE",
                --cost = 1
            }
        }
    },
    Misc = {
        id = 6,
        label = "Misc",
        list = {
            {
                label = "Bandage",
                key = "bandage",
                --cost = 1
            },
            {
                label = "Bulletproof Vest",
                key = "armour",
                --cost = 2
            },
            {
                label = "M4 Scope",
                key = "COMPONENT_AT_SCOPE_MEDIUM",
                --cost = 1
            },
            {
                label = "AK Scope",
                key = "COMPONENT_AT_SCOPE_MACRO",
                --cost = 1
            },
        }
    },
    Ammo = {
        id = 7,
        label = "Ammo",
        list = {
            {
                label = "9mm",
                key = "ammo-9",
                desc ="Ammo: 20",
                amount = "20",
                --cost = 1
            },
            {
                label = "12 gauge",
                key = "ammo-shotgun",
                desc ="Ammo: 10",
                amount = "10",
                --cost = 1
            },
            {
                label = "5.56x45",
                key = "ammo-rifle",
                desc ="Ammo: 50",
                amount = "50",
                --cost = 1
            },
            {
                label = "7.62x39",
                key = "ammo-rifle2",
                desc ="Ammo: 50",
                amount = "50",
                --cost = 1
            },
        }
    }
}
