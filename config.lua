Config = {

    PriceDivider = 100,

    LandZones = {
        ['MorningWood'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(-1281.31, -425.64, 34.65, 121.85),
                Blip = false,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(-1284.45, -427.52, 34.75, 213.96)
        },

        ['Tinsel'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(-619.35, 56.42, 43.74, 83.03),
                Blip = false,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(-619.83, 59.99, 43.72, 106.21)
        },

        ['Legion'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(213.78, -809.12, 31.01, 336.01),
                Blip = false,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(220.66, -809.39, 30.64, 247.93)
        },

        ['South_Rockford'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(-679.17, -1110.38, 14.53, 63.2),
                Blip = false,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(-683.65, -1111.93, 14.5, 33.0)
        },

        ['Fantastic_Hotel'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(311.03, -1075.41, 29.41, 84.96),
                Blip = false,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(306.69, -1081.03, 29.34, 122.9)
        },

        ['Harmony'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(1184.17, 2656.09, 37.81, 70.83),
                Blip = true,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(1181.21, 2660.42, 37.92, 89.5)
        },

        ['Paleto'] = {
            Type = 'Land',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(83.82, 6420.52, 31.76, 338.87),
                Blip = true,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(59.52, 6400.19, 31.13, 212.95)
        },

        ['SandyAir'] = {
            Type = 'Air',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(1760.51, 3296.87, 41.14, 137.1),
                Blip = true,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(1754.03, 3286.33, 41.92, 128.59)
        },

        ['SandyWater'] = {
            Type = 'Water',
            Npc = {
                Model = 'cs_floyd',
                Coord = vector4(1331.01, 4270.4, 31.5, 251.56),
                Blip = true,
                Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY"
            },
            Spawn = vector4(1332.36, 4264.97, 30.18, 264.63)
        },


    },

    Vehicles = {
        Land = {
            {
                Model = 'futo',
            },
            {
                Model = 'bison',
            },
            {
                Model = 'faggio3',
            },
        },

        Air = {
            {
                Model = 'dodo',
            },
        },

        Water = {
            {
                Model = 'seashark',
            },
        }
    },

    Blip = {

        Land = {
            Type = 668,
            Scale = 0.7,
            Color = 83
        },

        Air = {
            Type = 640,
            Scale = 0.7,
            Color = 83
        },

        Water = {
            Type = 471,
            Scale = 0.7,
            Color = 83
        }
    }
    
}