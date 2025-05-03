local wheelStates = {}

RegisterNetEvent('egl_wheel:checkWheelServer')
AddEventHandler('egl_wheel:checkWheelServer', function(vehicle, wheelIndex, isWheelBurst)
    local wheelId = vehicle .. '_' .. wheelIndex
    wheelStates[wheelId] = isWheelBurst and 'burst' or 'fine'
    TriggerClientEvent('egl_wheel:updateWheelStateClient', source, vehicle, wheelIndex, wheelStates[wheelId])
end)

RegisterNetEvent('egl_wheel:changeWheelServer')
AddEventHandler('egl_wheel:changeWheelServer', function(vehicle, wheelIndex)

    local wheelId = vehicle .. '_' .. wheelIndex
    wheelStates[wheelId] = 'fine'

    TriggerClientEvent('egl_wheel:updateWheelStateClient', source, vehicle, wheelIndex, 'fine')
end)

RegisterNetEvent('egl_wheel:updateWheelStateServer')
AddEventHandler('egl_wheel:updateWheelStateServer', function(vehicle, wheelIndex, isWheelBurst)
    local wheelId = vehicle .. '_' .. wheelIndex
    local state = isWheelBurst and 'burst' or 'fine'

    TriggerClientEvent('egl_wheel:updateWheelStateClient', source, vehicle, wheelIndex, state)
end)

registerServerCallback('egl_wheel:checkItemsForWheelChange', function(source, cb, vehicle, wheelIndex)
    local xPlayer = getPlayerFromId(source)
    if not xPlayer then return cb(false, false) end

    local hasRepairKit = getInventoryItem(xPlayer, config.RepairKitItem) > 0
    local hasSpareTire = getInventoryItem(xPlayer, config.SpareTireItem) > 0

    cb(hasRepairKit, hasSpareTire)
end)

RegisterNetEvent('egl_wheel:useRepairItems')
AddEventHandler('egl_wheel:useRepairItems', function()
    local xPlayer = getPlayerFromId(source)

    removeInventoryItem(xPlayer, config.SpareTireItem, 1)
end)