local inapartment = false

Citizen.CreateThread(function()
        local blip = AddBlipForCoord(-270.6047, -957.9693, 30.2231)

        SetBlipSprite(blip, 475)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, 2)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Apartments')
        EndTextCommandSetBlipName(blip)
end)


Citizen.CreateThread(function()
    local alreadyEnteredZone = false
    local text = nil
    while true do
        wait = 5
        local ped = PlayerPedId()
        local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(-270.6047, -957.9693, 30.2231))
        if dist <= 5.0 then
            wait = 5
            inZone  = true
            text = '<b>Apartment</b></p>[E] Press to enter your apartment'

            if IsControlJustReleased(0, 38) then
                TriggerEvent('esx_apartments:enterapartment')
            end
        else
            wait = 1000
        end

        if inZone and not alreadyEnteredZone then
            alreadyEnteredZone = true
            TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
        end

        if not inZone and alreadyEnteredZone then
            alreadyEnteredZone = false
            TriggerEvent('cd_drawtextui:HideUI')
        end
        Citizen.Wait(wait)
    end
end)

Citizen.CreateThread(function()
	local alreadyEnteredZone = false
	local text = nil
	while true do
		wait = 5
		local ped = PlayerPedId()
		local inZone = false
        local dist = #(GetEntityCoords(ped)-vector3(151.8, -1001.36, -100.0))
        if dist <= 1.5 then
            wait = 5
            inZone  = true
            text = '<b>Closet</b></p>[E] Press to open your closet'

            if IsControlJustReleased(0, 38) then
                TriggerEvent('esx_apartments:changeclothingmenu')
            end
            break
        else
            wait = 1000
        end
		
		if inZone and not alreadyEnteredZone then
			alreadyEnteredZone = true
			TriggerEvent('cd_drawtextui:ShowUI', 'show', text)
		end

		if not inZone and alreadyEnteredZone then
			alreadyEnteredZone = false
			TriggerEvent('cd_drawtextui:HideUI')
		end
		Citizen.Wait(wait)
	end
end)

Citizen.CreateThread(function()
	local playerPool = {}
	while inapartment do
		local players = GetActivePlayers()
		for i=1, #players do
			local player = players[i]
			if player ~= PlayerId() and not playerPool[player] then
				playerPool[player] = true
				NetworkConcealPlayer(player, true, true)
			end
		end
		Citizen.Wait(500)
	end
	for k in pairs(playerPool) do
		NetworkConcealPlayer(k, false, false)
	end
end)

RegisterNetEvent('esx_apartments:changeclothingmenu', function()
	TriggerEvent('nh-context:sendMenu', {
		{
			id = 1,
			header = "Change Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:pickNewOutfit",
				args = {
					number = 1,
					id = 2
				}
			}
		},
		{
			id = 2,
			header = "Save New Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:saveOutfit"
			}
		},
		{
			id = 3,
			header = "Delete Outfit",
			txt = "",
			params = {
				event = "fivem-appearance:deleteOutfitMenu",
				args = {
					number = 1,
					id = 2
				}
			}
		}
	})
end)

RegisterNetEvent('esx_apartments:exit')
AddEventHandler('esx_apartments:exit', function()
	local playerId, playerPed = PlayerId(), PlayerPedId()
    inapartment = false
	SetEntityVisible(playerPed, 1, 0)
	SetPlayerInvincible(playerId, 0)
	DoScreenFadeOut(1500)
	SetEntityCoords(PlayerPedId(), -270.6047, -957.9693, 31.2231)
	DoScreenFadeIn(1500)

end)

RegisterNetEvent('esx_apartments:enterapartment')
AddEventHandler('esx_apartments:enterapartment', function()
    inapartment = true
	DoScreenFadeOut(1500)
    SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)
	DoScreenFadeIn(1500)
	while inapartment do
		SetEntityVisible(PlayerPedId(), 0, 0)
		SetLocalPlayerVisibleLocally(1)
		SetPlayerInvincible(PlayerId(), 1)
		Citizen.Wait(0)
	end
end)


--[[
RegisterNetEvent('esx_apartments:invite')  #nh-context and right export
AddEventHandler('esx_apartments:invite', function()
	local playersInArea = ESX.Game.GetPlayersInArea(vector3(-270.6047,-957.9693,30.2231), 10.0)
	local elements = {}
		for i=1, #playersInArea, 1 do
			if playersInArea[i] ~= PlayerId() then
				table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
			end
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'apartments_invite',
			{
				title = 'Invite a friend',
				align = 'top-left',
				elements = elements,
			},
			function(data, menu)
				menu.close()

				
			end,
			function(data, menu)
				menu.close()
			end
		)
end) ]]

exports.qtarget:AddTargetModel({-1663022887}, {
    options = {
        {
            event = "esx_apartments:exit",
            icon = "fas fa-sign-out-alt",
            label = "Leave apartment",
            num = 1
        },
        --[[{
            event = "esx_apartments:invite",
            icon = "fas fa-address-book",
            label = "Invite",
            num = 2
        }, ]]
    },
    distance = 2
})
