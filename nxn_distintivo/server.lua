ESX = exports.es_extended:getSharedObject()

RegisterServerEvent('nxn_sv')
AddEventHandler('nxn_sv', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false
    if ESX.GetPlayerFromId(source).getInventoryItem("distintivo").count >= 1 then 
		local matricola = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] =  ESX.GetPlayerFromId(ID).identifier})
		if matricola[1].matricola == nil then
			TriggerClientEvent('esx:showNotification', source, "Non hai una matricola, richiedila al tuo comandante !")
		else
			TriggerClientEvent('nxn_clopen', _source, matricola[1].matricola)
		end
	else 
		TriggerClientEvent('esx:showNotification', source, "Non il distintivo")
	end
end)
ESX.RegisterUsableItem('distintivo', function(source)
   	local _source  = source
   	local xPlayer  = ESX.GetPlayerFromId(_source)
	local matricola = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] =  xPlayer.identifier})
	if matricola[1].matricola == nil then
		xPlayer.showNotification("Non ha una matricola")
	else
		TriggerClientEvent("nxn_usa", source)
	end
end)

RegisterServerEvent('nxn_dumpamitutto', function(t)
	local me = ESX.GetPlayerFromId(source)
    if ESX.GetPlayerFromId(t) then
        local xPlayer = ESX.GetPlayerFromId(t)
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
		if result[1].matricola == nil then
            local matricola = math.random(0,999)..'-'..math.random(0,999)
            MySQL.Async.execute('UPDATE users SET matricola = ? WHERE identifier = ?', {matricola, xPlayer.identifier})
			xPlayer.showNotification("Hai ricevuto la matricola: "..matricola)
			me.showNotification("Hai dato la matricola: "..matricola.. " a "..xPlayer.getName())
		else
			me.showNotification("Ha già una matricola")
		end
    else
        me.showNotification("Giocatore offline")
    end
end)


RegisterServerEvent('nxn_revoca', function(t)
	local me = ESX.GetPlayerFromId(source)
    if ESX.GetPlayerFromId(t) then
        local xPlayer = ESX.GetPlayerFromId(t)
        local result = MySQL.Sync.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayer.identifier})
		if result[1].matricola ~= nil then
            MySQL.Async.execute('UPDATE users SET matricola = ? WHERE identifier = ?', {nil, xPlayer.identifier})
			xPlayer.showNotification("Ti è stata tolta la matricola")
			me.showNotification("Hai ritirato la matricola a "..xPlayer.getName())
		else
			me.showNotification("Non ha una matricola")
		end
    else
        me.showNotification("Giocatore offline")
    end
end)