local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('prescription_pad', function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.PlayerData.job.type == 'ems' then 
		TriggerClientEvent("md-drugs:client:prescriptionpad", src, item)
	end	
end)

RegisterServerEvent('md-drugs:server:giveprescription', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem(item, 1)
	Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Made A Prescription Of ' .. item .. '!', 'pharma')
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", 1)
end)

RegisterServerEvent('md-drugs:server:unbottle', function(item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local amount = math.random(10,30)
	Player.Functions.AddItem(item, amount)
	Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. ' Unbottled '.. amount .. ' Of ' .. item .. '!', 'pharma')
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item], "add", amount)
end)

local pharmabottle = {'vicodinbottle', 'adderalbottle','morphinebottle','xanaxbottle'}
for m, d in pairs (pharmabottle) do
QBCore.Functions.CreateUseableItem(d, function(source, item)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player.Functions.RemoveItem(d, 1) then
		TriggerClientEvent("md-drugs:client:unbottle", src, item)
		TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[d], "remove", 1)
	end	
end)
end

local pharmadrugs = { "adderal", "vicodin", "xanax", "morphine"}
for k, v in pairs (pharmadrugs) do QBCore.Functions.CreateUseableItem(v, function(source, item)
local src = source
local Player = QBCore.Functions.GetPlayer(src)

if TriggerClientEvent('md-drugs:client:takepharma', src, item.name) then
	Player.Functions.RemoveItem(item.name, 1)
	Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. 'Took ' .. item.name .. '!', 'pharma')
	TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[item.name], "remove", 1)
	
	end
end)
end
RegisterServerEvent('md-drugs:server:fillprescription', function()
	local src = source
    	local Player = QBCore.Functions.GetPlayer(src)
	local vic = Player.Functions.GetItemByName('vicodin_prescription')
	local add = Player.Functions.GetItemByName('adderal_prescription')
	local mor = Player.Functions.GetItemByName('morphine_prescription')
	local xan = Player.Functions.GetItemByName('xanax_prescription')	
	if vic then
		RemoveItem('vicodin_prescription', 1 ) 
		AddItem('vicodinbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
	elseif add then
		RemoveItem('adderal_prescription', 1 ) 
		AddItem('adderalbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
	elseif mor then
		RemoveItem('morphine_prescription', 1 ) 
		AddItem('morphinebottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
		
	elseif xan then
		RemoveItem('xanax_prescription', 1 ) 
		AddItem('xanaxbottle', 1) 
		Notifys(Lang.Pharma.pills, "success")
		
	else
		Notifys(Lang.Pharma.no, "error")
	end
	Log(Player.PlayerData.charinfo.firstname .. ' ' ..  Player.PlayerData.charinfo.lastname .. 'Filled A Prescription!', 'pharma')
end)
