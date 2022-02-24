# gp-rental
This is a vehicle rental script rework from Carbon05 [qb-rentals](https://github.com/Carbon05/qb-rentals) script. 

# What are the differences? 
- Multi locations
- Full language file to easy translate
- Easy config, you can choose from Land, Air, Water vehicles. 
- Calculate price from [qb-core](https://github.com/qbcore-framework/qb-core) Shared/Vehicles.lua
- Money refound on return. ( 50% of base rent price - damages )

# Important
- All your vehicle must be placed in qb-core/Shared/Vehicle.lua

# How is it work? 
- Make a new location: 
    config.lua -> Landzones
```lua
    ['MorningWood'] = { -- Name of your zone
        Type = 'Land', -- Type of the renal (Options: Land / Air / Water)
        Npc = {
            Model = 'cs_floyd', -- Model of your npc
            Coord = vector4(-1281.31, -425.64, 34.65, 121.85), -- Coords off your npc
            Blip = false, -- Want to enable blip for this location? ( Options: true / false )
            Scenario = "WORLD_HUMAN_CLIPBOARD_FACILITY" -- Npc will play this scenario
        },
        Spawn = vector4(-1284.45, -427.52, 34.75, 213.96) -- Spawn location of the vehicle
    },
```
- Set up the vehicles: 
    config.lua -> Vehicles

```lua
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
```

- Set up the blips: 
```lua
    Blip = {

        Land = {
            Type = 668, -- Type of the blip
            Scale = 0.7, -- Scale of the blip
            Color = 83 -- Color of the blip
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
```

# Language file
```lua
local Translations = {
    info = {
        ["header"] = -- Main title of the menu
        ['veh_returned'] = -- Information text about returned vehicle
        ['paid_deposit'] = -- Information text about the payment
        ['refound'] = -- Information text about the refound
    },
    error = {
        ["not_enough_space"] = -- Error message when something blocking the spot
        ["not_enough_money"] = -- Error message when player don't have money
        ["no_vehicle"] = -- Error message when there is no vehicle to return
    },
    task = {
        ["return_veh"] = -- Text on Qb-target Return vehicle
        ["rent_land"] = -- Text on Qb-target Rent a land vehicle
        ["rent_air"] = -- Text on Qb-target Rent a air vehicle
        ["rent_water"] = -- Text on Qb-target Rent a water vehicle
    },
    blip = {
        ["land"] = -- Name of the land vehicle rent zone
        ["air"] = -- Name of the land vehicle air zone
        ["water"] = -- Name of the land vehicle water zone
    }
}

Lang = Locale:new({phrases = Translations, warnOnMissing = true})
```

# Dependencies 
- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/BerkieBb/qb-target)
- [qb-menu] (https://github.com/qbcore-framework/qb-menu)

# Installation
- Drag & Drop

# Rental Papers Item - qb-core/shared.lua

```
["rentalpapers"]				 = {["name"] = "rentalpapers", 					["label"] = "Rental Papers", 			["weight"] = 0, 		["type"] = "item", 		["image"] = "rentalpapers.png", 		["unique"] = true, 		["useable"] = false, 	["shouldClose"] = false, 	["combinable"] = nil, 	["description"] = "Yea, this is my car i can prove it!"},
```
# Rental Papers Item Description - qb-inventory/html/js/app.js (Line 577)

```lua
        } else if (itemData.name == "stickynote") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p>' + itemData.info.label + '</p>');
        } else if (itemData.name == "rentalpapers") {
            $(".item-info-title").html('<p>' + itemData.label + '</p>')
            $(".item-info-description").html('<p><strong>Plate: </strong><span>'+ itemData.info.plate + '<p><strong>Model: </strong><span>'+ itemData.info.model +'</span></p>');
```

# Credits 
- [itsHyper](https://github.com/itsHyper) & elfishii 
- [Carbon05](https://github.com/Carbon05)
