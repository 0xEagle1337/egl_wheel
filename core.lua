if config.Core == 'QB' then
	Core = exports['qb-core']:GetCoreObject()
else
	Core = exports['es_extended']:getSharedObject()
end

function getPlayerFromId(source)
	if config.Core == 'QB' then
		return Core.Functions.GetPlayer(source)
	else
		return Core.GetPlayerFromId(source)
	end
end

function showNotification(message, type)
	if config.Core == 'QB' then
		Core.Functions.Notify(message, type)
	else
		Core.ShowNotification(message)
	end
end

function getInventoryItem(player, itemName)
    if config.Core == 'QB' then
        local item = player.Functions.GetItemByName(itemName)
        return (item and item.amount) or 0
    else
        return player.getInventoryItem(itemName).count
    end
end

function removeInventoryItem(player, itemName, count)
	if config.Core == 'QB' then
		return player.Functions.RemoveItem(itemName, amount)
	else
		return player.removeInventoryItem(itemName, count)
	end
end

function registerServerCallback(name, cb)
    if config.Core == 'QB' then
        Core.Functions.CreateCallback(name, function(source, cbf, ...)
            cb(source, cbf, ...)
        end)
    else
        Core.RegisterServerCallback(name, cb)
    end
end

function triggerServerCallback(name, cb, ...)
    if config.Core == 'QB' then
        Core.Functions.TriggerCallback(name, function(...)
            cb(...)
        end, ...)
    else
        Core.TriggerServerCallback(name, function(...)
            cb(...)
        end, ...)
    end
end

function getClosestVehicle()
	if config.Core == 'QB' then
		return Core.Functions.GetClosestVehicle()
	else
		return Core.Game.GetClosestVehicle()
	end
end