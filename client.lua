local QBCore = exports['qb-core']:GetCoreObject()
local SpawnVehicle = false
local currentZone, landRentalPed, airRentalPed, waterRentalPed, currentRental, _PlayerPedId, inVehicle = nil, nil, nil, nil, nil, nil, nil
local npcBlips = {}
-- Config Options 

-- Vehicle Rentals
local comma_value = function(n) -- credit http://richard.warburton.it
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

CreateThread(function()
    while true do
        _PlayerPedId = PlayerPedId()
        inVehicle = IsPedSittingInVehicle(_PlayerPedId, GetVehiclePedIsIn(_PlayerPedId))
        GetClosestRentZone()
        
        Wait(1000)
    end
end)

CreateThread(function()
   while true do
        local vehicle = GetVehiclePedIsIn(_PlayerPedId)
        local loop = 1000
        if currentZone and inVehicle and vehicle == currentRental then
            loop = 0
            local playerCoords = GetEntityCoords(PlayerPedId())
            DrawText3D(playerCoords.x, playerCoords.y, playerCoords.z + 1.2, Lang:t("task.return_veh"))
            if IsControlJustPressed(0, 74) then
                DeleteVehicle(vehicle)
            end
        else
            loop = 1000
        end
        Wait(loop)
   end
end)

-- Functions
function GetClosestRentZone()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = 15
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

function DeleteVehicle(vehicle)
    if vehicle == currentRental then
        SpawnVehicle = false
        for i = -1, 16, 1 do
            local seat = GetPedInVehicleSeat(vehicle, i)
            TaskLeaveVehicle(seat, vehicle, 0)
        end
        SetVehicleDoorsLocked(vehicle)
        Wait(1500)
        QBCore.Functions.Notify(Lang:t("info.veh_returned"), 'success')
        TriggerServerEvent('gp-rental:server:removePapers')
        local vehicleClass = GetVehicleClass(currentRental)
        local vehicleModel = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(currentRental)))
        local engineHealth = GetVehicleEngineHealth(currentRental)
        local bodyHealth = GetVehicleBodyHealth(currentRental)
        local vehicleType

        if vehicleClass ~= 14 and vehicleClass ~= 15 and vehicleClass ~= 16 then
            vehicleType = 'Land'
        elseif vehicleClass == 15 or vehicleClass == 16 then
            vehicleType = 'Air'
        elseif vehicleClass == 14 then
            vehicleType = 'Water'
        end
        NetworkFadeOutEntity(vehicle, true,false)
        QBCore.Functions.DeleteVehicle(vehicle)
        TriggerServerEvent('gp-rental:server:refundMoney', vehicleModel, vehicleType, engineHealth, bodyHealth)
        currentRental = nil
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
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
    local money = data.money
    local Model = data.Model
    local label = Lang:t("error.not_enough_space", {vehicle = menu:sub(1,1):upper()..menu:sub(2)})

    if currentZone then
        if IsAnyVehicleNearPoint(Config.LandZones[currentZone].Spawn.x, Config.LandZones[currentZone].Spawn.y, Config.LandZones[currentZone].Spawn.z, 3.0) then
            QBCore.Functions.Notify(label, "error", 4500)
        else
            TriggerServerEvent('gp-rental:server:removeMoney', money, Model)
        end
    else
        QBCore.Functions.Notify('For devs: Distance between NPC and Point must be closer then 15', "error", 4500)
    end

end)

RegisterNetEvent('gp-rental:client:spawnVehicle', function(data)
    currentRental = nil
    QBCore.Functions.SpawnVehicle(data, function(vehicle)
        SetEntityHeading(vehicle, Config.LandZones[currentZone].Spawn.w)
        TaskWarpPedIntoVehicle(_PlayerPedId, vehicle, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle))
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle, 0.0)
        exports['LegacyFuel']:SetFuel(vehicle, 100)
        SpawnVehicle = true
    end, Config.LandZones[currentZone].Spawn, true)
    Wait(1000)
    local vehicle = GetVehiclePedIsIn(_PlayerPedId, false)
    local vehicleLabel = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    local plate = GetVehicleNumberPlateText(vehicle)
    currentRental = vehicle
    TriggerServerEvent('gp-rental:server:rentalPapers', plate, vehicleLabel)

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
