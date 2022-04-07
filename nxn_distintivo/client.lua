ESX = exports.es_extended:getSharedObject()
local open = false

RegisterNetEvent('nxn_clopen')
AddEventHandler('nxn_clopen', function(matricola)
	open = true
	SendNUIMessage({
		action = "open",
		matricola = matricola,
	})
end)

RegisterCommand('vedimat', function()
	TriggerServerEvent('nxn_sv', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
end)
RegisterKeyMapping('+chiudimat', 'Chiudi', 'keyboard', "BACK")
RegisterCommand('+chiudimat', function()
	if open then
		SendNUIMessage({
			action = "close"
		})
		open = false
	end
end)

RegisterCommand('daimatricola', function()
	TriggerEvent('nxn_gestione_matricola')
end)

RegisterNetEvent("nxn_gestione_matricola", function()
	NXN_DaiMatricola()
end)
NXN_DaiMatricola = function()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'utis', {
		title = '',
		align = 'top-right',
		elements = {
			{label = 'Dai matricola', value = 'dai'},
			{label = 'Revoca matricola', value = ''},
		}
	},     function(data, menu)
			local verifica = data.current.value
			local c, dis = ESX.Game.GetClosestPlayer()
			if dis ~= -1 and dis <= 3.0 then
				if verifica == 'dai' then
					TriggerServerEvent("nxn_dumpamitutto", GetPlayerServerId(c))
				else
					TriggerServerEvent("nxn_revoca", GetPlayerServerId(c))
				end
			else
				ESX.ShowNotification('Nessun player vicino')
			end
		end, 
		function(data, menu)
			menu.close()
	end)
end

an = false
RegisterNetEvent('nxn_usa')
AddEventHandler('nxn_usa', function()
	if not an then
		local c, dis = ESX.Game.GetClosestPlayer()
		if dis ~= -1 and dis <= 4.0 then
			TriggerServerEvent('nxn_sv', GetPlayerServerId(PlayerId()), GetPlayerServerId(c))
			TriggerServerEvent('nxn_sv', GetPlayerServerId(PlayerId()),  GetPlayerServerId(PlayerId()))
			an = true
			local pp = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(pp))
			prop = CreateObject(GetHashKey('prop_fib_badge'), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, pp, GetPedBoneIndex(pp, 57005), 0.12, -0.03, -0.048, 60.0, 100.0, 40.0, 1, 1, 0, 0, 2, 1)
			RequestAnimDict('paper_1_rcm_alt1-9')
			while not HasAnimDictLoaded('paper_1_rcm_alt1-9') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(pp, 'paper_1_rcm_alt1-9', 'player_one_dual-9', 8.0, -8, -1, 49, 0, 0, 0, 0)
			Citizen.Wait(3650)
			an = false
			ClearPedSecondaryTask(pp)
			DeleteObject(prop)
		else
			TriggerServerEvent('nxn_sv', GetPlayerServerId(PlayerId()),  GetPlayerServerId(PlayerId()))
			ESX.ShowNotification('Nessuno vicino')
		end
	end
end)