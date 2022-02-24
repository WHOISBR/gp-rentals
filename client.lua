local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false
local currentZone, landRentalPed, airRentalPed, waterRentalPed = nil, nil, nil, nil
local npcBlips = {}
-- Config Options 

-- Vehicle Rentals
local comma_value = function(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

CreateThread(function()
    while true do
        GetClosestRentZone()
        Wait(1000)
    end
end)

-- Functions
function GetClosestRentZone()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = 20
    for id, rentZone in pairs(Config.LandZones) do
        local distcheck = #(pos - vector3(Config.LandZones[id].Spawn.x, Config.LandZones[id].Spawn.y, Config.LandZones[id].Spawn.z))
        
        if current == nil then
            if distcheck < dist then
                current = id
            end
        end

    end
    currentZone = current
end

function _CreatePed(hash, coords, Scenario, zoneType)

    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(5)
    end

    if zoneType == 'Land' then

        landRentalPed = CreatePed(4, hash, coords.x, coords.y, coords.z - 1, coords.w, false, false)
        SetEntityAsMissionEntity(landRentalPed, true, true)
        SetPedHearingRange(landRentalPed, 0.0)
        SetPedSeeingRange(landRentalPed, 0.0)
        SetPedAlertness(landRentalPed, 0.0)
        SetPedFleeAttributes(landRentalPed, 0, 0)
        SetBlockingOfNonTemporaryEvents(landRentalPed, true)
        SetPedCombatAttributes(landRentalPed, 46, true)
        SetPedFleeAttributes(landRentalPed, 0, 0)
        TaskStartScenarioInPlace(landRentalPed, Scenario, 0, true)
        SetEntityInvincible(landRentalPed, true)
        SetEntityCanBeDamaged(landRentalPed, false)
        SetEntityProofs(landRentalPed, true, true, true, true, true, true, 1, true)
        FreezeEntityPosition(landRentalPed, true)
        SetEntityAsMissionEntity(landRentalPed, true, true)
    
    elseif zoneType == 'Air' then
        
        airRentalPed = CreatePed(4, hash, coords.x, coords.y, coords.z - 1, coords.w, false, false)
        SetEntityAsMissionEntity(airRentalPed, true, true)
        SetPedHearingRange(airRentalPed, 0.0)
        SetPedSeeingRange(airRentalPed, 0.0)
        SetPedAlertness(airRentalPed, 0.0)
        SetPedFleeAttributes(airRentalPed, 0, 0)
        SetBlockingOfNonTemporaryEvents(airRentalPed, true)
        SetPedCombatAttributes(airRentalPed, 46, true)
        SetPedFleeAttributes(airRentalPed, 0, 0)
        TaskStartScenarioInPlace(airRentalPed, Scenario, 0, true)
        SetEntityInvincible(airRentalPed, true)
        SetEntityCanBeDamaged(airRentalPed, false)
        SetEntityProofs(airRentalPed, true, true, true, true, true, true, 1, true)
        FreezeEntityPosition(airRentalPed, true)
        SetEntityAsMissionEntity(airRentalPed, true, true)

    elseif zoneType == 'Water' then
        
        waterRentalPed = CreatePed(4, hash, coords.x, coords.y, coords.z - 1, coords.w, false, false)
        SetEntityAsMissionEntity(waterRentalPed, true, true)
        SetPedHearingRange(waterRentalPed, 0.0)
        SetPedSeeingRange(waterRentalPed, 0.0)
        SetPedAlertness(waterRentalPed, 0.0)
        SetPedFleeAttributes(waterRentalPed, 0, 0)
        SetBlockingOfNonTemporaryEvents(waterRentalPed, true)
        SetPedCombatAttributes(waterRentalPed, 46, true)
        SetPedFleeAttributes(waterRentalPed, 0, 0)
        TaskStartScenarioInPlace(waterRentalPed, Scenario, 0, true)
        SetEntityInvincible(waterRentalPed, true)
        SetEntityCanBeDamaged(waterRentalPed, false)
        SetEntityProofs(waterRentalPed, true, true, true, true, true, true, 1, true)
        FreezeEntityPosition(waterRentalPed, true)
        SetEntityAsMissionEntity(waterRentalPed, true, true)
    end

    exports['qb-target']:AddTargetEntity(landRentalPed, {
        options = {
            {
                Type = "client",
                event = "gp-rental:client:openMenu",
                icon = "fas fa-car",
                label = Lang:t("task.rent_land"),
                MenuType = 'Land',
                targeticon = 'fas fa-car-side' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            },
            {
                Type = "client",
                event = "gp-rental:client:returnVehicle",
                icon = "fas fa-car",
                label = Lang:t("task.return_veh"),
                targeticon = 'fas fa-car-side' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            }
        },
        distance = 1.0
    })

    exports['qb-target']:AddTargetEntity(airRentalPed, {
        options = {
            {
                Type = "client",
                event = "gp-rental:client:openMenu",
                icon = "fas fa-plane",
                label = Lang:t("task.rent_air"),
                MenuType = 'Air',
                targeticon = 'fas fa-plane' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            },
            {
                Type = "client",
                event = "gp-rental:client:returnVehicle",
                icon = "fas fa-plane",
                label = Lang:t("task.return_veh"),
                targeticon = 'fas fa-plane' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            }
        },
        distance = 1.0
    })

    exports['qb-target']:AddTargetEntity(waterRentalPed, {
        options = {
            {
                Type = "client",
                event = "gp-rental:client:openMenu",
                icon = "fas fa-ship",
                label = Lang:t("task.rent_water"),
                MenuType = 'Water',
                targeticon = 'fas fa-ship' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            },
            {
                Type = "client",
                event = "gp-rental:client:returnVehicle",
                icon = "fas fa-ship",
                label = Lang:t("task.return_veh"),
                targeticon = 'fas fa-ship' -- This is the icon of the target itself, the icon changes to this when it turns blue on this specific option, this is OPTIONAL
            }
        },
        distance = 1.0
    })

end

function CreateZones()

    for k, v in pairs(Config.LandZones) do
        _CreatePed(GetHashKey(v.Npc.Model), v.Npc.Coord, v.Npc.Scenario, v.Type)

        if v.Npc.Blip then
            npcBlips = {}

            local npcBlip = AddBlipForCoord(v.Npc.Coord.x, v.Npc.Coord.y, v.Npc.Coord.z )
            if v.Type == 'Land' then
                SetBlipSprite(npcBlip, Config.Blip.Land.Type)
                SetBlipScale(npcBlip, Config.Blip.Land.Scale)
                SetBlipColour(npcBlip, Config.Blip.Land.Color)
                SetBlipAsShortRange(npcBlip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(Lang:t("blip.land"))
                EndTextCommandSetBlipName(npcBlip)
            elseif v.Type == 'Air' then
                SetBlipSprite(npcBlip, Config.Blip.Air.Type)
                SetBlipScale(npcBlip, Config.Blip.Air.Scale)
                SetBlipColour(npcBlip, Config.Blip.Air.Color)
                SetBlipAsShortRange(npcBlip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(Lang:t("blip.air"))
                EndTextCommandSetBlipName(npcBlip)
            elseif v.Type == 'Water' then
                SetBlipSprite(npcBlip, Config.Blip.Water.Type)
                SetBlipScale(npcBlip, Config.Blip.Water.Scale)
                SetBlipColour(npcBlip, Config.Blip.Water.Color)
                SetBlipAsShortRange(npcBlip, true)
                BeginTextCommandSetBlipName('STRING')
                AddTextComponentSubstringPlayerName(Lang:t("blip.water"))
                EndTextCommandSetBlipName(npcBlip)
            end

            table.insert(npcBlips, npcBlip)
        end

    end

end

function DeleteZones()

    for k, v in pairs(Config.LandZones) do

        if DoesEntityExist(landRentalPed) then
            DeletePed(landRentalPed)
        end

        if DoesEntityExist(airRentalPed) then
            DeletePed(airRentalPed)
        end

        if DoesEntityExist(waterRentalPed) then
            DeletePed(waterRentalPed)
        end

    end

    if npcBlips[1] then

        for i = 1, #npcBlips do
            RemoveBlip(npcBlips[i])
        end
        npcBlips = {}
    end

end

-- Events
RegisterNetEvent('gp-rental:client:openMenu', function(data)
    menu = data.MenuType
    local vehMenu = {
        [1] = {
            header = Lang:t("info.header"),
            isMenuHeader = true,
        }
    }
    
    if menu == "Land" then
        for k=1, #Config.Vehicles.Land do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.Land[k].Model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.Land[k].Model:sub(1,1):upper()..Config.Vehicles.Land[k].Model:sub(2)
            local price = math.floor(QBCore.Shared.Vehicles[Config.Vehicles.Land[k].Model].price / Config.PriceDivider)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(price)),
                params = {
                    event = "gp-rental:client:selectCar",
                    args = {
                        Model = Config.Vehicles.Land[k].Model,
                        money = price
                    }
                }
            }
        end
    elseif menu == "Air" then
        for k=1, #Config.Vehicles.Air do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.Air[k].Model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.Air[k].Model:sub(1,1):upper()..Config.Vehicles.Air[k].Model:sub(2)
            local price = math.floor(QBCore.Shared.Vehicles[Config.Vehicles.Land[k].Model].price / Config.PriceDivider)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(price)),
                params = {
                    event = "gp-rental:client:selectCar",
                    args = {
                        Model = Config.Vehicles.Air[k].Model,
                        money = price
                    }
                }
            }
        end
    elseif menu == "Water" then
        for k=1, #Config.Vehicles.Water do
            local veh = QBCore.Shared.Vehicles[Config.Vehicles.Water[k].Model]
            local name = veh and ('%s %s'):format(veh.brand, veh.name) or Config.Vehicles.Water[k].Model:sub(1,1):upper()..Config.Vehicles.Water[k].Model:sub(2)
            local price = math.floor(QBCore.Shared.Vehicles[Config.Vehicles.Land[k].Model].price / Config.PriceDivider)
            vehMenu[#vehMenu+1] = {
                id = k+1,
                header = name,
                txt = ("$%s"):format(comma_value(price)),
                params = {
                    event = "gp-rental:client:selectCar",
                    args = {
                        Model = Config.Vehicles.Water[k].Model,
                        money = price
                    }
                }
            }
        end
    end
    exports['qb-menu']:openMenu(vehMenu)

end)

RegisterNetEvent('gp-rental:client:selectCar', function(data)
    local player = PlayerPedId()
    local money = data.money
    local Model = data.Model
    local label = Lang:t("error.not_enough_space", {vehicle = menu:sub(1,1):upper()..menu:sub(2)})

    if IsAnyVehicleNearPoint(Config.LandZones[currentZone].Spawn.x, Config.LandZones[currentZone].Spawn.y, Config.LandZones[currentZone].Spawn.z, 2.0) then
        QBCore.Functions.Notify(label, "error", 4500)
    else
        TriggerServerEvent('gp-rental:server:removeMoney', money, Model)
    end

end)

RegisterNetEvent('gp-rental:client:spawnVehicle', function(data)
    local player = PlayerPedId()
    QBCore.Functions.SpawnVehicle(data, function(vehicle)
        SetEntityHeading(vehicle, Config.LandZones[currentZone].Spawn.w)
        TaskWarpPedIntoVehicle(player, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        exports['LegacyFuel']:SetFuel(vehicle, 100)
        SpawnVehicle = true
    end, Config.LandZones[currentZone].Spawn, true)
    Wait(1000)
    local vehicle = GetVehiclePedIsIn(player, false)
    local vehicleLabel = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))
    vehicleLabel = GetLabelText(vehicleLabel)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('gp-rental:server:rentalPapers', plate, vehicleLabel)

end)

RegisterNetEvent('gp-rental:client:returnVehicle', function()
    if SpawnVehicle then
        local Player = QBCore.Functions.GetPlayerData()
        QBCore.Functions.Notify(Lang:t("info.veh_returned"), 'success')
        TriggerServerEvent('gp-rental:server:removePapers')
        local vehicle = GetVehiclePedIsIn(PlayerPedId(),true)
        local vehicleClass = GetVehicleClass(vehicle)
        local vehicleModel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
        local engineHealth = GetVehicleEngineHealth(vehicle)
        local bodyHealth = GetVehicleBodyHealth(vehicle)
        local vehicleType

        if vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16 then
            vehicleType = 'Land'
        elseif vehicleClass == 15 or vehicleClass == 16 then
            vehicleType = 'Air'
        elseif vehicleClass == 14 then
            vehicleType = 'Water'
        end

        print('vehicleModel', vehicleModel)
        print('vehicleClass', vehicleClass)
        print('vehicleType', vehicleType)

        TriggerServerEvent('gp-rental:server:refoundMoney', vehicleModel, vehicleType, engineHealth, bodyHealth)
        NetworkFadeOutEntity(vehicle, true,false)
        QBCore.Functions.DeleteVehicle(vehicle)
    else 
        QBCore.Functions.Notify(Lang:t("error.no_vehicle"), "error")
    end
    SpawnVehicle = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    DeleteZones()
    Wait(100)
    CreateZones()
end)

-- Handlers
AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        CreateZones()
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        DeleteZones()
    end
end)