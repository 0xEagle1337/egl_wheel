local language = config.Locales
local locale = Locales[language]

local currentVehicle = nil
local wheelZones = {} 
local wheelStates = {}

local function checkWheel(vehicle, wheelIndex)
    local playerPed = PlayerPedId()
    local vehiclePos = GetEntityCoords(vehicle)
    local playerPos = GetEntityCoords(playerPed)

    local angle = math.atan2(vehiclePos.y - playerPos.y, vehiclePos.x - playerPos.x) * 180.0 / math.pi
    TaskTurnPedToFaceCoord(playerPed, vehiclePos.x, vehiclePos.y, vehiclePos.z, 1000)
    Wait(150)
    
    local isChecking = progressBar(5000, locale['checking'], false, true, 'amb@medic@standing@kneel@enter', 'enter', 49, true, true, true)

    if isChecking then
        local isWheelBurst = IsVehicleTyreBurst(vehicle, wheelIndex, false)
        TriggerServerEvent('egl_wheel:updateWheelStateServer', vehicle, wheelIndex, isWheelBurst)
    else
        ClearPedTasksImmediately(PlayerPedId())
        showNotification(locale['cancel'], 'info')
    end
end

local function removeWheelZones()
    for _, zoneId in ipairs(wheelZones) do
        removeZone(zoneId)
    end
    wheelZones = {}
end

local function createWheelZones(vehicle)
    local wheelBones = {'wheel_lf', 'wheel_rf', 'wheel_lr', 'wheel_rr'}
    local wheelIndices = {0, 1, 4, 5}

    for i, bone in ipairs(wheelBones) do
        local boneIndex = GetEntityBoneIndexByName(vehicle, bone)
        local boneCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
        local wheelIndex = wheelIndices[i]
        local wheelId = vehicle .. '_' .. wheelIndex
        local state = wheelStates[wheelId] or 'fine'

        local options = {}

        if state == 'burst' then
            table.insert(options, {
                event = 'egl_wheel:changeWheel',
                icon = 'fa-solid fa-wrench',
                label = locale['change_wheel'],
                wheelIndex = wheelIndex,
                vehicle = vehicle
            })
        else
            table.insert(options, {
                event = 'egl_wheel:checkWheel',
                icon = 'fa-solid fa-screwdriver-wrench',
                label = locale['check_wheel'],
                wheelIndex = wheelIndex,
                vehicle = vehicle
            })
        end

        local zoneId = addSphereZone(boneCoords, 0.5, false, options)
        table.insert(wheelZones, zoneId)
    end
end

local function updateWheelState(vehicle, wheelIndex, state)
    local wheelId = vehicle .. '_' .. wheelIndex

    wheelStates[wheelId] = state

    removeWheelZones()
    createWheelZones(vehicle)
end

RegisterNetEvent('egl_wheel:checkWheel', function(data)
    local vehicle = data.vehicle
    if vehicle and DoesEntityExist(vehicle) then
        checkWheel(vehicle, data.wheelIndex)
    end
end)

RegisterNetEvent('egl_wheel:changeWheel', function(data)
    local vehicle = data.vehicle
    local wheelIndex = data.wheelIndex

    if vehicle and DoesEntityExist(vehicle) then
        triggerServerCallback('egl_wheel:checkItemsForWheelChange', function(hasRepairKit, hasSpareTire)
            if hasRepairKit and hasSpareTire then
                local playerPed = PlayerPedId()
                local vehiclePos = GetEntityCoords(vehicle)
                local playerPos = GetEntityCoords(playerPed)

                local angle = math.atan2(vehiclePos.y - playerPos.y, vehiclePos.x - playerPos.x) * 180.0 / math.pi
                TaskTurnPedToFaceCoord(playerPed, vehiclePos.x, vehiclePos.y, vehiclePos.z, 1000)
                Wait(150)

                local isChecking = progressBar(10000, locale['changing_wheel'], false, true, 'mp_intro_seq@', 'mp_mech_fix', 49, true, true, true)

                ClearPedTasksImmediately(playerPed)

                SetVehicleTyreFixed(vehicle, wheelIndex)
                updateWheelState(vehicle, wheelIndex, 'fine')
                TriggerServerEvent('egl_wheel:updateWheelStateServer', vehicle, wheelIndex, false)
                TriggerServerEvent('egl_wheel:useRepairItems')
                showNotification(locale['success'], 'info')
            elseif not hasRepairKit and not hasSpareTire then
                showNotification(locale['sparekit_tire_needed'], 'info')
            elseif not hasRepairKit then
                showNotification(locale['sparekit_needed'], 'info')
            else
                showNotification(locale['tire_needed'], 'info')
            end
        end, vehicle, wheelIndex)
    end
end)

RegisterNetEvent('egl_wheel:updateWheelStateClient')
AddEventHandler('egl_wheel:updateWheelStateClient', function(vehicle, wheelIndex, newState)
    updateWheelState(vehicle, wheelIndex, newState)
    if newState == 'burst' then
        showNotification(locale['burst'], 'info')
    else
        showNotification(locale['not_burst'], 'info')
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local playerPed = PlayerPedId()
        local vehicle = getClosestVehicle()
        local playerCoords = GetEntityCoords(playerPed)
        local vehicleCoords = GetEntityCoords(vehicle)

        if vehicle and DoesEntityExist(vehicle) and #(playerCoords - vehicleCoords) < 3.0 then
            if currentVehicle ~= vehicle then
                removeWheelZones()
                createWheelZones(vehicle)
                currentVehicle = vehicle
            end
        elseif currentVehicle then
            removeWheelZones()
            currentVehicle = nil
        end
    end
end)