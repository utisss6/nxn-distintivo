--[[
    per mostrare il distintivo usa:
        TriggerServerEvent('nxn_sv', id di chi lo mostra,  id a chi lo vuoi mostrare) -- GetPlayerServerId(...)
    per aprire il menu di gestione delle matricole utilliza (ad esempio per metterlo nell'f6 per il comandate):
        TriggerEvent('nxn_gestione_matricola')
        
]]

NXN = {}

NXN.JobName = 'police'
NXN.EnableCommand = true -- abilita il comando /daimatricola (ti apre il menu per gestire le matricole)