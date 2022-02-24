local Translations = {
    info = {
        ["header"] = "Vehicle Rentals",
        ['veh_returned'] = "Vehicle Returned!",
        ['paid_deposit'] = "Paid $%{value} deposit", 
        ['refound'] = " $ refounded in cash"
    },
    error = {
        ["not_enough_space"] = "Something blocking the way!",
        ["not_enough_money"] = "You do not have enough money!",
        ["no_vehicle"] = "No vehicle to return!"
    },
    task = {
        ["return_veh"] = "Return vehicle",
        ["rent_land"] = "Rent a car",
        ["rent_air"] = "Rent a plane",
        ["rent_water"] = "Rent a boat",
    },
    blip = {
        ["land"] = 'Vehicle rental',
        ["air"] = 'Airplane rental',
        ["water"] = 'Boat rental'
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})
