local PlayerData = {}
local open = false

if Config.Framework == 'esx' then 
    ESX = exports.es_extended:getSharedObject()

    RegisterNetEvent('esx:playerLoaded')
    AddEventHandler('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer
    end)
elseif Config.Framework == 'qbcore' then 
    QBCore = exports['qb-core']:GetCoreObject()

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
    AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = QBCore.Functions.GetPlayerData()
    end)

    RegisterNetEvent('QBCore:Player:SetPlayerData')
    AddEventHandler('QBCore:Player:SetPlayerData', function(val)
        PlayerData = val
    end)

end

postNUI = function(data)
    SendNUIMessage(data)
end

Citizen.CreateThread(function()
    if Config.Framework == 'esx' then 
        while not ESX.IsPlayerLoaded() do 
            Citizen.Wait(100)
        end
    elseif Config.Framework == 'qbcore' then
        while not QBCore.Functions.GetPlayerData().job do 
            Citizen.Wait(100)
        end
    end
    Wait(50)
    InitShops()
    SetPlayerData()
    postNUI({
     type = "SET_LOCALES",
     locales = Config.Locales
    })
end)

GetMoney = function()
    if Config.Framework == 'esx' then 
        for k,v in pairs(PlayerData.accounts) do 
            if v.name == 'money' then 
                return v.money
            end
        end
    elseif Config.Framework == 'qbcore' then
        return PlayerData.money['cash']
    end
end

SetPlayerData = function()
    if Config.Framework == 'esx' then 
        PlayerData = ESX.GetPlayerData()
        postNUI({
            type = "SET_PLAYER_MONEY",
            money = GetMoney()
        })
    elseif Config.Framework == 'qbcore' then
        PlayerData = QBCore.Functions.GetPlayerData()
        postNUI({
            type = "SET_PLAYER_MONEY",
            money = GetMoney()
        })
    end
end

InitShops = function()
    for k,v in pairs(Config.Shops) do 
        if v.blip then 
            if v.blip.enable then 
                local blip = AddBlipForCoord(v.coords[1].x, v.coords[1].y, v.coords[1].z)
                SetBlipSprite(blip, v.blip.sprite)
                SetBlipColour(blip, v.blip.colour)
                SetBlipScale(blip, v.blip.scale)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(v.blip.label)
                EndTextCommandSetBlipName(blip)
            end
        end
        for a,b in pairs(v.coords) do 

            local point = lib.points.new({
                coords = b,
                distance = 5,
                dunak = 'nerd',
                item = v.item
            })
             
            function point:nearby()
                DrawMarker(2, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.8, 0.8, 0.8, 255,196,0, 150, true, true, 2, false, nil, nil, false)
             
                if self.currentDistance < 1 and IsControlJustReleased(0, 38) then
                    SetPlayerData()
                    OpenShop(self.item)
                end
            end
        end
    end
end

OpenShop = function(item)
    open = true
    SetNuiFocus(true, true)
    postNUI({
        type = "SET_ITEMS",
        items = item
    })
    postNUI({
        type = "OPEN"
    })
end

Citizen.CreateThread(function()
  while true do

    if open then 
        Wait(0)
        SetPlayerData()
    else
        Wait(2000)
    end

   end
end)

RegisterNUICallback('buy', function(data)
    local basket = data.basket
    local totalPrice = data.totalPrice
    TriggerServerEvent('ricky-shop:buy', totalPrice, basket)
end)

RegisterNUICallback('close', function(data, cb)
    SetNuiFocus(false, false)
    open = false
end)
