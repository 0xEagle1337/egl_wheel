function addSphereZone(coords, radius, debug, options)
    if config.Target == 'ox_target' then
        return exports.ox_target:addSphereZone({
            coords = coords,
            radius = radius,
            debug = debug,
            options = options
        })

    elseif config.Target == 'qb-target' then
        for _, opt in ipairs(options) do
            opt.type = opt.type or 'client'
            
            opt.args = {
                wheelIndex = opt.wheelIndex,
                vehicle = opt.vehicle
            }
        end
        
        local zoneName = ('wheel_zone_%d_%d_%d'):format(
            math.floor(coords.x*100),
            math.floor(coords.y*100),
            math.floor(coords.z*100)
        )
            
        exports['qb-target']:AddCircleZone(zoneName, coords, radius, {
            name = zoneName,
            debugPoly = debug,
            useZ = false,
            options = options,
        })

        return true
    end

    return false
end

function removeZone(id)
    if config.Target == 'ox_target' then
        exports.ox_target:removeZone(id)
    
    elseif config.Target == 'qb-target' then
        exports['qb-target']:RemoveZone(id)
    end
end

function addEntity(entity, id, options, distance)
    distance = distance or 1.0

    if config.Target == 'ox_target' then
        exports.ox_target:addEntity({entity = entity, id = id, options = options})
    
    elseif config.Target == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(entity)

        for _, opt in ipairs(options) do
            opt.type = opt.type or 'client'
            
            opt.args = {
                wheelIndex = opt.wheelIndex,
                vehicle = opt.vehicle
            }
        end

        exports['qb-target']:AddTargetEntity(entity, {
            options = options,
            distance = distance,
        })
    end
end

function removeEntity(entity, id)
    if config.Target == 'ox_target' then
        exports.ox_target:removeEntity({entity = entity, id = id})

    elseif config.Target == 'qb-target' then
        exports['qb-target']:RemoveTargetEntity(entity)
    end
end