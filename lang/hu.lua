local Translations = {
    info = {
        ["header"] = "Jármű bérlés",
        ['veh_returned'] = "A jármű visszaadva!",
        ['paid_deposit'] = "Fizettél %{value}-$ letétet", 
        ['refound'] = " $ kaució visszafizetve készpénzben"
    },
    error = {
        ["not_enough_space"] = "Valami útban van!",
        ["not_enough_money"] = "Nincs elég pénz nálad!",
        ["no_vehicle"] = "Nincs jármű amit vissza adhatnál!"
    },
    task = {
        ["return_veh"] = "Bérelt jármű visszaadása.",
        ["rent_land"] = "Jármű bérlés",
        ["rent_air"] = "Repülő bérlés",
        ["rent_water"] = "Hajó bérlés",
    },
    blip = {
        ["land"] = 'Jármü bérlés',
        ["air"] = 'Repülö bérlés',
        ["water"] = 'Hajó bérlés'
    }
}
Lang = Locale:new({phrases = Translations, warnOnMissing = true})