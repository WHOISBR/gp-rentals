local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("rentalpapers", function(source, item, plate)
    TriggerEvent("vehiclekeys:client:SetOwner", plate)
end)

RegisterServerEvent('gp-rental:server:rentalPapers', function(plate, Model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local info = {}
    info.plate = plate
    info.Model = Model
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["rentalpapers"], 'add')
    Player.Functions.AddItem('rentalpapers', 1, false, info)
end)

RegisterServerEvent('gp-rental:server:removePapers', function(plate, Model)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    TriggerClientEvent('inventory:client:ItemBox', src,  QBCore.Shared.Items["rentalpapers"], 'remove')
    Player.Functions.RemoveItem('rentalpapers', 1, false, info)
end)

RegisterNetEvent('gp-rental:server:removeMoney', function(vehCost, vehModel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= vehCost then
        Player.Functions.RemoveMoney('cash', vehCost)
        TriggerClientEvent('gp-rental:client:spawnVehicle', src, vehModel)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.paid_deposit", {value = vehCost}), 'success')
    elseif Player.PlayerData.money.bank >= vehCost then
        Player.Functions.RemoveMoney('bank', vehCost)
        TriggerClientEvent('QBCore:Notify', src, Lang:t("info.paid_deposit", {value = vehCost}), 'success')
        TriggerClientEvent('gp-rental:client:spawnVehicle', src, vehModel)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.not_enough_money"), 'error')
    end

end)

RegisterNetEvent('gp-rental:server:refoundMoney', function(vehModel, vehType, engineHealth, bodyHealth)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    for i = 1, #Config.Vehicles[vehType] do
        if Config.Vehicles[vehType][i].Model == vehModel then
            local rentPrice = math.floor(QBCore.Shared.Vehicles[vehModel].price / Config.PriceDivider)
            local vehicleHealth = (engineHealth + bodyHealth) / 20
            local refound = math.ceil((vehicleHealth / 100) * (rentPrice / 2)) 

            Player.Functions.AddMoney('cash', refound)
            TriggerClientEvent('QBCore:Notify', src, tostring(refound)..Lang:t("info.refound"), 'success')
        end
    end
end)