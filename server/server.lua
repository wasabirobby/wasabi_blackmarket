-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

lib.callback.register('wasabi_blackmarket:configCallback', function(source)
    return Config
end)

lib.callback.register('wasabi_blackmarket:randomLocCB', function(source)
    return Config.randomLocation
end)

lib.callback.register('wasabi_blackmarket:canOpen', function(source)
	local location = Core.Functions.GetCoords(GetPlayer(source))
	local dist = #(Config.randomLocation.coords - location)
	if dist <= 10 then
		return true
	else
		return false
	end
end)


CreateThread(function()
	print('^1/////////////////////////////////////////////////////////////////////////////////////////////////')
	print('^4wasabi_blackmarket: Started! Location for this session: '..Config.randomLocation.coords)
	print('^1/////////////////////////////////////////////////////////////////////////////////////////////////^0')
end)


RegisterServerEvent('wasabi_blackmarket:bI')
AddEventHandler('wasabi_blackmarket:bI', function(itemName, amount, coords)
	local xPlayer = GetPlayer(source)
	local dist = #(Config.randomLocation.coords - coords)
	amount = round(amount, 1)
	if amount < 0 or dist >= 10 then
		sendToDiscord(Strings['exploit_title'], (Strings['exploit_message']):format(xPlayer.identifier), 15548997)
		print('wasabi_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		KickPlayer(source, Strings['kick_msg'])
		return
	end
	local price = 0
	local itemLabel = ''
	local itemType = ''
	for i=1, #Config.Items, 1 do
		if Config.Items[i].item == itemName then
			price = Config.Items[i].price
			itemLabel = Config.Items[i].label
			if Config.Items[i].type then
				itemType = Config.Items[i].type
			end
			break
		end
	end
	price = price * amount
	local xMoney = GetPlayerMoney(xPlayer)
	if xMoney >= price then
        if Framework == 'esx' then
            if xPlayer.canCarryItem(itemName, amount) then
                xPlayer.removeAccountMoney(Config.PayAccount, price)
                if itemType == 'weapon' then
                    xPlayer.addWeapon(itemName, 200)
                else
                    xPlayer.addInventoryItem(itemName, amount)
                end
                local label = xPlayer.getInventoryItem(itemName).label
                sendToDiscord(Strings['purchase_title'], (Strings['purchase_message']):format(xPlayer.identifier, xPlayer.getName(), amount, itemName, string.format(price), 5763719))
                TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['purchase_notify']):format(amount, label, string.format(price)))
            else
                TriggerClientEvent('wasabi_blackmarket:notify', source, Strings['no_room_notify'])
            end
        else
            xPlayer.Functions.RemoveMoney("cash", price)
            xPlayer.Functions.AddItem(itemName, amount)
            	local label = xPlayer.Functions.GetItemByName(itemName).label
                sendToDiscord(Strings['purchase_title'], (Strings['purchase_message']):format(xPlayer.identifier, xPlayer.PlayerData.charinfo.firstname .. " " .. xPlayer.PlayerData.charinfo.lastname, amount, itemName, string.format(price), 5763719))
                TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['purchase_notify']):format(amount, label, string.format(price)))
        end
    else
        local missingMoney = price - xMoney
        TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['not_enough_notify']):format((string.format(missingMoney))))
    end
end)

RegisterServerEvent('wasabi_blackmarket:later')
AddEventHandler('wasabi_blackmarket:later', function()
	local xPlayer = GetPlayer(source)
	sendToDiscord(Strings['exploit_title'], (Strings['exploit_message']):format(xPlayer.identifier), 15548997)
	--print('wasabi_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
	KickPlayer(source, Strings['kick_msg'])
end)

function sendToDiscord(name, message, color)
	local connect = {
		{
			["color"] = color,
			["title"] = "**".. name .."**",
			["description"] = message,
			["footer"] = {
				["text"] = "wasabi_blackmarket - by wasabirobby",
			},
		}
	}
	PerformHttpRequest(Config.WebhookLink, function(err, text, headers) end, 'POST', json.encode({username = 'wasabi_blackmarket', embeds = connect, avatarrl = 'https://cdn.discordapp.com/attachments/963717003351302174/963717089426804746/tebexbanner.png'}), { ['Content-Type'] = 'application/json' })
end