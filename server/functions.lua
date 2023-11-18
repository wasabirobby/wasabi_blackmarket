if GetResourceState('qb-core') == 'started' then  
	Core = exports['qb-core']:GetCoreObject()
	Framework = 'qb'
elseif GetResourceState('qes_extended') == 'started' then 
	Core = exports['es_extended']:getSharedObject()
	Framework = 'esx'
else 
	print("No FrameWork Found")
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult 
end

function GetPlayer(source)
    if Framework == 'esx' then
        return Core.GetPlayerFromId(source)
    else
        return Core.Functions.GetPlayer(source) 
    end    
end

function KickPlayer(source, reason)
    local player = GetPlayer(source)
    if Framework == 'esx' then
        return player.kick(reason)
    else
       return  Core.Functions.Kick(player, reason)
    end
end

function GetPlayerMoney(xPlayer)
    if Framework == 'esx' then
        return xPlayer.getAccount(Config.PayAccount).money
    else 
        return xPlayer.PlayerData.money.cash
    end    
end
