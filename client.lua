--Made by Vumon https://github.com/Vumono/esx_apartments/
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(PlayerData)
    PlayerData = xPlayer
end)

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
    StartScreenEffect("SuccessNeutral",  3000,  false)
	SetEntityCoords(PlayerPedId(), -270.6047, -957.9693, 31.2231)
    SetLocalPlayerVisibleLocally()
    --SetEntityLocallyVisible(PlayerPedId())
	SetEntityNoCollisionEntity(PlayerPedId(), ESX.Game.GetPlayersInArea(vector3(151.4854,-1007.5345,-99.0), 10.0), false)
end)

RegisterNetEvent('esx_apartments:enterapartment')
AddEventHandler('esx_apartments:enterapartment', function()
    StartScreenEffect("SuccessNeutral",  3000,  false)
    SetEntityCoords(PlayerPedId(), 151.38, -1007.95, -99.0 - 1.0)
    
    --SetEntityLocallyInvisible(PlayerPedId())
    SetLocalPlayerInvisibleLocally()
	SetEntityNoCollisionEntity(PlayerPedId(), ESX.Game.GetPlayersInArea(vector3(151.4854,-1007.5345,-99.0), 10.0), true)
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
