ESX = exports["es_extended"]:getSharedObject()
HasAlreadyEnteredMarker = false
LastZone = nil
CurrentAction = nil
CurrentActionMsg = nil
CurrentActionData = nil
isInMatch = false
isReady = false
currentTeam = ""
isEnableTeamDeathmatch = true
Quit = false

local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

function notify(text,type,duration)
	lib.notify({
		description = text,
		type = type,
		duration = duration or 3000
	})
end

RegisterCommand("quitmatch", function()
    Quit = true
end, false)

Citizen.CreateThread(function()
	while not ESX.IsPlayerLoaded() do 
        Citizen.Wait(500)
	end
	
	if ESX.IsPlayerLoaded() then
		Citizen.Wait(81)
		-- Draw blip Team Deathmatch
		local blip = AddBlipForCoord(Config.TeamDeathMatchBlip.x, Config.TeamDeathMatchBlip.y, Config.TeamDeathMatchBlip.z)
		SetBlipSprite(blip, 436)
		SetBlipDisplay(blip, 4)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 49)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		-- AddTextComponentString("May Xeng")
		AddTextComponentString("<font face=\"Helvetica Neue\">Arena</font>")
		EndTextCommandSetBlipName(blip)	
		-- END draw blip
		ESX.TriggerServerCallback("esx_tpnrp_teamdeathmatch:getStatus", function(result) 
			isEnableTeamDeathmatch = result
		end)
	end
end)

AddEventHandler('gameEventTriggered', function(name, args)
    if name == "CEventNetworkEntityDamage" and args then
        local victimEntity = args[1] -- Entity ID of the victim
        local attackerEntity = args[2] -- Entity ID of the attacker
        local victimDied = args[6] -- Death indicator (or assumed to be)
		local weaponHash = args[7]
		local playerPed = PlayerPedId()

        -- Check if the victim is dead
		if victimDied == 1 then
			-- If attackerEntity is a valid entity, it means it's a player or NPC causing the damage
			if attackerEntity == -1 then
				attackerEntity = playerPed
			end
			if attackerEntity == playerPed then
				TriggerServerEvent("esx_tpnrp_teamdeathmatch:iKilled", currentTeam)
				
			end

			if victimEntity == playerPed then
				TriggerServerEvent("esx_tpnrp_teamdeathmatch:iamDead", currentTeam)
				
			end
		end
    end
end)
    


AddEventHandler('esx_tpnrp_teamdeathmatch:hasEnterMarker', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = ""
	CurrentActionData = {zone = zone}
end)

AddEventHandler('esx_tpnrp_teamdeathmatch:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		local sleep = 500
		if isEnableTeamDeathmatch then
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.Deathmatch) do
				if(GetDistanceBetweenCoords(coords, v.enter_pos.x, v.enter_pos.y, v.enter_pos.z, true) < Config.DrawDistance) then
					sleep = 1
					DrawMarker(1, v.enter_pos.x, v.enter_pos.y, v.enter_pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x + 1, Config.Size.y + 1, Config.Size.z, v.color.r, v.color.g, v.color.b, 100, false, true, 2, false, false, false, false)
					ESX.Game.Utils.DrawText3D(vector3(v.enter_pos.x, v.enter_pos.y, v.enter_pos.z + 1.7), v.name, 1)
				end
				if isInMatch then
					if(GetDistanceBetweenCoords(coords, v.game_start_pos.x, v.game_start_pos.y, v.game_start_pos.z, true) < Config.DrawDistance) then
						DrawMarker(1, v.game_start_pos.x, v.game_start_pos.y, v.game_start_pos.z - 1.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 4.5, 4.5, 1.5, v.color.r, v.color.g, v.color.b, 100, false, true, 2, false, false, false, false)
						ESX.Game.Utils.DrawText3D(vector3(v.game_start_pos.x, v.game_start_pos.y, v.game_start_pos.z + 1.7), "Zone " .. v.name, 1)
					end
				end
			end
			--
			if isInMatch then
				if(GetDistanceBetweenCoords(coords, Config.MapCenter.x, Config.MapCenter.y, Config.MapCenter.z, true) < 500.0) then
					DrawMarker(1, Config.MapCenter.x, Config.MapCenter.y, Config.MapCenter.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 200.0, 200.0, 1.5, 0, 255, 0, 100, false, true, 2, false, false, false, false)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		if isEnableTeamDeathmatch then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Deathmatch) do
				if(GetDistanceBetweenCoords(coords, v.enter_pos.x, v.enter_pos.y, v.enter_pos.z, true) < Config.Size.x) then
					isInMarker  = true
					currentZone = k
					LastZone    = k
				end
				if isInMatch then
					if(GetDistanceBetweenCoords(coords, v.game_start_pos.x, v.game_start_pos.y, v.game_start_pos.z, true) < Config.Size.x) then
						isInMarker  = true
						ESX.ShowHelpNotification("Press E to join " ..  v.name)
						if IsControlJustReleased(0, Keys['E']) then
							ShowBuyMenu()
						end
					end
					-- 
					if(GetDistanceBetweenCoords(coords, Config.MapCenter.x, Config.MapCenter.y, Config.MapCenter.z, true) >= 200.0) or Quit == true then
						TriggerServerEvent("esx_tpnrp_teamdeathmatch:quit", currentTeam)
						-- reset data
						currentTeam = ""
						isInMatch = false
						isReady = false
						Quit = false
						SendNUIMessage({
							type = "endgame"
						})
						notify("Make a full spread over the area! Chat with other questions!", "info", 5000)
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
						end)
					end
				end
			end
			if isInMarker and not HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = true
				TriggerEvent('esx_tpnrp_teamdeathmatch:hasEnterMarker', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_tpnrp_teamdeathmatch:hasExitedMarker', LastZone)
			end
		end
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isEnableTeamDeathmatch then
			if HasAlreadyEnteredMarker and not isInMatch then
				ESX.ShowHelpNotification("Press ~g~E ~w~to join " ..  Config.Deathmatch[CurrentActionData.zone].name)
			end

			if IsControlJustReleased(0, Keys['E']) and HasAlreadyEnteredMarker and not isInMatch then
				JoinTeam(CurrentActionData.zone)
			end
			if isInMatch then
				if IsControlJustPressed(0, 11) then
					ToggleScoreboard(true)
				end
				if IsControlJustReleased(0, 11) then
					ToggleScoreboard(false)
				end
			end
		end
	end
end)

function JoinTeam(name)
	local _playerPed = PlayerPedId()
	local elements = {}

    table.insert(elements, {
		label = "Yes",
		value   = "yes"
	})
	table.insert(elements, {
		label = "No",
		value   = "no"
	})

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tpnrp_deathmatch_ask1', {
        title    = "do you  want join " .. Config.Deathmatch[name].name .. "?<br/>Reason: Do not bring along!",
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if data.current.value == "yes" then
			TriggerServerEvent("inventory:save",_playerPed)
            TriggerServerEvent("esx_tpnrp_teamdeathmatch:joinTeam", name)
        end
        -- menuIsShowed = false
        menu.close()
    end, function(data, menu)
        -- menuIsShowed = false
        menu.close()
    end)
end

function ToggleScoreboard(_val)
	SendNUIMessage({
		type = "show_game_scoreboard",
		show = _val
	})
end

RegisterNetEvent("esx_tpnrp_teamdeathmatch:joinedMatch")
AddEventHandler("esx_tpnrp_teamdeathmatch:joinedMatch", function(name, game_data)
	local _playerPed = PlayerPedId()
	isInMatch = true
	ESX.Game.Teleport(_playerPed, vector3(Config.Deathmatch[name].game_start_pos.x,Config.Deathmatch[name].game_start_pos.y, Config.Deathmatch[name].game_start_pos.z),function() 
		TriggerEvent('skinchanger:getSkin', function(skin)
			if skin.sex == 0 then
				TriggerEvent('skinchanger:loadClothes', skin, Config.Deathmatch[name].skin.male)
			else
				TriggerEvent('skinchanger:loadClothes', skin, Config.Deathmatch[name].skin.female)
			end
		end)
		notify("You have participated " .. Config.Deathmatch[name].name .. " !", "info", 5000)
		currentTeam = name
		SendNUIMessage({
			type = "show_game_ui"
		})
		SendNUIMessage({
			type = "update_game_ui",
			game_ui = reMapData(game_data)
		})
		-- FreezeEntityPosition(_playerPed, true)
		notify("You need to get ready to start the game!", "info", 5000)
	end)
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:startMatch")
AddEventHandler("esx_tpnrp_teamdeathmatch:startMatch", function() 
	SendNUIMessage({
		type = "match_start"
	})
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:updateGameUI")
AddEventHandler("esx_tpnrp_teamdeathmatch:updateGameUI", function(game_data)
	SendNUIMessage({
		type = "update_game_ui",
		game_ui = reMapData(game_data)
	})
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:youWon")
AddEventHandler("esx_tpnrp_teamdeathmatch:youWon", function(game_data, winTeam)
	SendNUIMessage({
		type = "update_game_ui_win",
		game_ui = reMapData(game_data),
		win_team = winTeam
	})
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:youLose")
AddEventHandler("esx_tpnrp_teamdeathmatch:youLose", function(game_data, winTeam)
	
	SendNUIMessage({
		type = "update_game_ui_lose",
		game_ui = reMapData(game_data),
		win_team = winTeam
	})
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:newRound")
AddEventHandler("esx_tpnrp_teamdeathmatch:newRound", function(team_name)
	local _playerPed = PlayerPedId()
	SendNUIMessage({
		type = "new_round"
	})
	-- Tele player back to spawn point
	ESX.Game.Teleport(_playerPed, vector3(Config.Deathmatch[team_name].game_start_pos.x,Config.Deathmatch[team_name].game_start_pos.y, Config.Deathmatch[team_name].game_start_pos.z),function() 
		notify("New game has started!", "info", 5000)
	end)
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:endMatch")
AddEventHandler("esx_tpnrp_teamdeathmatch:endMatch", function(team_name, win_team) 
	local _playerPed = PlayerPedId()
	ESX.Game.Teleport(_playerPed, vector3(Config.Deathmatch[team_name].enter_pos.x,Config.Deathmatch[team_name].enter_pos.y, Config.Deathmatch[team_name].enter_pos.z),function() 
		ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)
		notify("" .. Config.Deathmatch[win_team].name .. " won!", "info", 5000)
		-- reset data
		currentTeam = ""
		isInMatch = false
		isReady = false
		SendNUIMessage({
			type = "endgame"
		})
	end)
	Wait(100)
	TriggerServerEvent("inventory:restore",_playerPed)
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:matchFinished")
AddEventHandler("esx_tpnrp_teamdeathmatch:matchFinished", function(game_data, win_team) 
	-- print("Win team " .. win_team)
	SendNUIMessage({
		type = "update_game_ui_win_finished",
		game_ui = reMapData(game_data),
		win_team = win_team
	})
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:doToggle")
AddEventHandler("esx_tpnrp_teamdeathmatch:doToggle", function(enable) 
	TriggerServerEvent("esx_tpnrp_teamdeathmatch:toggleTeamdeathmatch")
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:toggleTeamdeathmatch")
AddEventHandler("esx_tpnrp_teamdeathmatch:toggleTeamdeathmatch", function(enable) 
	isEnableTeamDeathmatch = enable
end)

RegisterNetEvent("esx_tpnrp_teamdeathmatch:anountVoice")
AddEventHandler("esx_tpnrp_teamdeathmatch:anountVoice", function(_type, _kill) 
	SendNUIMessage({
		type = "voice_anount",
		team = _type,
		kill = _kill
	})
end)

function ShowBuyMenu(type)
    local elements = {}
    local is_buy = false
    if type == nil then
        type = "main_buy"
        for k, v in pairs(Config.BuyMenu) do
            table.insert(elements, {
                label = v.label,
                value = k,
            })
        end
        is_buy = false
        if not isReady then
            table.insert(elements, {
                label = "Ready",
                value = "ready"
            })
        else
            -- table.insert(elements, {
            --     label = "Exit",
            --     value = "quit"
            -- })
        end
    else
        for k, v in pairs(Config.BuyMenu[type].list) do
            table.insert(elements, {
                label = v.label,
                value = v.key,
				ammoType = v.ammoType,
				ammo = v.ammo
            })
        end
        is_buy = true
    end

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_menu_' .. type, {
        title    = "Buy gun ",
        align    = 'top-left',
        elements = elements
    }, function(data, menu)
        if is_buy then
            local weaponName = data.current.value
			local ammo = data.current.ammo
            -- Call the server to buy the weapon and ammo
            TriggerServerEvent('buyWeapon', weaponName, 1, ammo) -- 1 weapon, 100 ammo as example
            menuIsShowed = false
            menu.close()
            notify("You have bought: " .. data.current.label, "success", 5000)
        else 
            if data.current.value ~= "ready" then
                ShowBuyMenu(data.current.value)
            else 
                TriggerServerEvent("esx_tpnrp_teamdeathmatch:playerReady", currentTeam)
                notify("Ready!", "success", 5000)
                isReady = true
            end
        end
    end, function(data, menu)
        menuIsShowed = false
        menu.close()
    end)
end

function reMapData(game_data)
	-- print(dump(game_data))
	-- RED
	local cntRed = 0
	local _redList = game_data["RedTeam"].player_list
	game_data["RedTeam"].player_list = {}
	for k,v in pairs(_redList) do
		cntRed = cntRed + 1
		game_data["RedTeam"].player_list[cntRed] = v
	end
	-- BLUE
	local cntBlue = 0
	local _blueList = game_data["BlueTeam"].player_list
	game_data["BlueTeam"].player_list = {}
	for k,v in pairs(_blueList) do
		cntBlue = cntBlue + 1
		game_data["BlueTeam"].player_list[cntBlue] = v
	end
	-- print(dump(game_data))
	return game_data
end

function dump(o)
	if type(o) == 'table' then
	   local s = '{ '
	   for k,v in pairs(o) do
		  if type(k) ~= 'number' then k = '"'..k..'"' end
		  s = s .. '['..k..'] = ' .. dump(v) .. ','
	   end
	   return s .. '} '
	else
	   return tostring(o)
	end
end
