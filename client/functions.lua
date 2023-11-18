-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

if GetResourceState('qb-core') == 'started' then  
	Core = exports['qb-core']:GetCoreObject()
	Framework = 'qb'
elseif GetResourceState('es_extended') == 'started' then 
	Core = exports['es_extended']:getSharedObject()
	Framework = 'esx'
else 
	print("No FrameWork Found")
end

function loadModel(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

function loadDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

function ShowHelp(msg)
    lib.notify({
        title = 'Black Market',
        description = msg,
        type = 'success'
    })
end

function DrawText3D(coords, text)
    local str = text

    local start, stop = string.find(text, "~([^~]+)~")
    if start then
        start = start - 1
        stop = stop + 1
        str = ""
        str = str .. string.sub(text, 0, start) .. "   " .. string.sub(text, start+1, stop-1) .. string.sub(text, stop, #text)
    end

    AddTextEntry(GetCurrentResourceName(), str)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(2, false, false, -1)

	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
end

function ShowNotification(msg)
	lib.notify({
        title = 'Black Market',
        description = msg,
        type = 'success'
    })
end

CreateBlip = function(coords, sprite, colour, text, scale)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
end

function OpenBlackMarket()
    print('test ok')
	local elements = {}
	SetNuiFocus(true, true)
	SendNUIMessage({
		display = true,
	})
	for i=1, #Config.Items, 1 do
		local item = Config.Items[i]
		SendNUIMessage({
			itemLabel = item.label,
			item = item.item,
			price = string.format(item.price)
		})
	end
end

function bigRewards()
	TriggerServerEvent('wasabi_blackmarket:later')
end
