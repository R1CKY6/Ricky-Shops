if Config.Framework == 'esx' then 
    ESX = exports.es_extended:getSharedObject()
elseif Config.Framework == 'qbcore' then 
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterServerEvent('ricky-shop:buy')
AddEventHandler('ricky-shop:buy', function(totalPrice, basket)
    totalPrice = tonumber(totalPrice)

    if Config.Framework == 'esx' then 
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.getAccount('money').money >= totalPrice then
            xPlayer.removeAccountMoney('money', totalPrice)
            for k,v in pairs(basket) do 
                xPlayer.addInventoryItem(v.name, tonumber(v.quantity))
            end
        end
    elseif Config.Framework == 'qbcore' then
        local xPlayer = QBCore.Functions.GetPlayer(source)
        if xPlayer.Functions.GetMoney('cash') >= totalPrice then
            xPlayer.Functions.RemoveMoney('cash', totalPrice)
            for k,v in pairs(basket) do 
                xPlayer.Functions.AddItem(v.name, tonumber(v.quantity))
            end
        end
    end


end)

