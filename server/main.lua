-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('wasabi_blackmarket:configCallback', function(source, cb)
    cb(Config)
end)

ESX.RegisterServerCallback('wasabi_blackmarket:randomLocCB', function(source, cb)
    cb(Config.randomLocation)
end)

ESX.RegisterServerCallback('wasabi_blackmarket:canOpen', function(source, cb, location)
	local dist = #(Config.randomLocation.coords - location)
	if dist <= 10 then
		cb(true)
	else
		cb(false)
	end
end)

CreateThread(function()
	print('^1/////////////////////////////////////////////////////////////////////////////////////////////////')
	print('^4wasabi_blackmarket: Started! Location for this session: '..Config.randomLocation.coords)
	print('^1/////////////////////////////////////////////////////////////////////////////////////////////////^0')
end)


RegisterServerEvent('wasabi_blackmarket:bI')
AddEventHandler('wasabi_blackmarket:bI', function(itemName, amount, coords)
	local xPlayer = ESX.GetPlayerFromId(source)
	local dist = #(Config.randomLocation.coords - coords)
	amount = ESX.Math.Round(amount)
	if amount < 0 or dist >= 10 then
		sendToDiscord(Strings['exploit_title'], (Strings['exploit_message']):format(xPlayer.identifier), 15548997)
		print('wasabi_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
		xPlayer.kick(Strings['kick_msg'])
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
	local xMoney = xPlayer.getAccount(Config.PayAccount).money
	if xMoney >= price then
        if Config.OldESX then
            xPlayer.removeAccountMoney(Config.PayAccount, price)
            if itemType == 'weapon' then
                xPlayer.addWeapon(itemName, 200)
            else
                xPlayer.addInventoryItem(itemName, amount)
            end
            local label = xPlayer.getInventoryItem(itemName).label
            sendToDiscord(Strings['purchase_title'], (Strings['purchase_message']):format(xPlayer.identifier, xPlayer.getName(), amount, itemName, ESX.Math.GroupDigits(price), 5763719))
            TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['purchase_notify']):format(amount, label, ESX.Math.GroupDigits(price)))
        else
            if xPlayer.canCarryItem(itemName, amount) then
                xPlayer.removeAccountMoney(Config.PayAccount, price)
                if itemType == 'weapon' then
                    xPlayer.addWeapon(itemName, 200)
                else
                    xPlayer.addInventoryItem(itemName, amount)
                end
                local label = xPlayer.getInventoryItem(itemName).label
                sendToDiscord(Strings['purchase_title'], (Strings['purchase_message']):format(xPlayer.identifier, xPlayer.getName(), amount, itemName, ESX.Math.GroupDigits(price), 5763719))
                TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['purchase_notify']):format(amount, label, ESX.Math.GroupDigits(price)))
            else
                TriggerClientEvent('wasabi_blackmarket:notify', source, Strings['no_room_notify'])
            end
        end
    else
        local missingMoney = price - xMoney
        TriggerClientEvent('wasabi_blackmarket:notify', source, (Strings['not_enough_notify']):format((ESX.Math.GroupDigits(missingMoney))))
    end
end)

RegisterServerEvent('wasabi_blackmarket:later')
AddEventHandler('wasabi_blackmarket:later', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	sendToDiscord(Strings['exploit_title'], (Strings['exploit_message']):format(xPlayer.identifier), 15548997)
	print('wasabi_blackmarket: ' .. xPlayer.identifier .. ' attempted to exploit the shop!')
	xPlayer.kick(Strings['kick_msg'])
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
