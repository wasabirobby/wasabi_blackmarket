-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

loadModel = function(model)
    while not HasModelLoaded(model) do Wait(0) RequestModel(model) end
    return model
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
    return dict
end

ShowHelp = function(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, false, true, -1)
end

DrawText3D = function(coords, text)
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

ShowNotification = function(msg)
	SetNotificationTextEntry('STRING')
	AddTextComponentString(msg)
	DrawNotification(0,1)
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

OpenBlackMarket = function()
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
			price = ESX.Math.GroupDigits(item.price)
		})
	end
end
bigRewards = function()
	TriggerServerEvent('wasabi_blackmarket:later')
end
