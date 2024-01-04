local QBCore = exports['qb-core']:GetCoreObject()
local LoginSafe, Cam = nil, false
local spawns = {
    [1] = {coords = vector3(271.68, 186.82, 104.73), label = "Vinewood Blvd Taxi Stand"},
	[2] = {coords = vector3(453.16, -661.31, 27.98), label = "LS Bus Station"},
    [3] = {coords = vector3(-1833.96, -1223.5, 13.02), label = "The Boardwalk"},
    [4] = {coords = vector3(1641.71, 3583.43, 35.46), label = "Sandy Shores Motel"},
    [5] = {coords = vector3(143.91, 6564.09, 32.03), label = "Paleto Gas Station"},
    [6] = {coords = vector3(-215.08, 6178.51, 31.18), label = "Paleto Bus Stop"},
	[7] = {coords = vector3(-1267.49, 275.98, 64.77), label = "The Richman Hotel"},
	[8] = {coords = vector3(1121.82, 2664.64, 38.02), label = "Harmony Hotel"},
}

local function PreSpawnPlayer()
    SetDisplay(false)
    DoScreenFadeOut(500)
    Wait(2000)
end

local function PostSpawnPlayer(ped)
    FreezeEntityPosition(ped, false)
    RenderScriptCams(false, true, 500, true, true)
    SetCamActive(cam, false)
    DestroyCam(cam, true)
    SetCamActive(cam2, false)
    DestroyCam(cam2, true)
    SetEntityVisible(PlayerPedId(), true)
    Wait(500)
    DoScreenFadeIn(250)
end

RegisterNetEvent("spawnselector:opennui")
AddEventHandler("spawnselector:opennui", function(pos)
    SendNUIMessage({ data = spawns, lastpos = pos })
    openCam()
    SetNuiFocus(true, true)
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
    Cam = false
	DoScreenFadeOut(1000)
end)

RegisterNUICallback("spawn", function(data)
    DoScreenFadeOut(1000)
    SetNuiFocus(false, false)
    TriggerEvent("spawnselector:client:loadplayer", data.coords)
end)

RegisterNUICallback('lastpos', function(data, cb)
    DoScreenFadeOut(500)
    SetNuiFocus(false, false)
    QBCore.Functions.GetPlayerData(function(PlayerData) 
        TriggerEvent("spawnselector:client:loadplayer", PlayerData.position)
    end)
end)

RegisterNetEvent("spawnselector:client:loadplayer")
AddEventHandler("spawnselector:client:loadplayer", function(coords)
    delCam()
    doCamera(coords.x,coords.y,coords.z)
    DoScreenFadeOut(2)

	delCam()
    SetEntityCoords(PlayerPedId(),coords.x,coords.y,coords.z)
    SetEntityHeading(PlayerPedId(),coords.w)
    SetEntityVisible(PlayerPedId(), true)
    Wait(200)

    DoScreenFadeIn(2500)
    TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
    TriggerEvent('QBCore:Client:OnPlayerLoaded')
end)

function delCam()
    ClearFocus()
	DestroyAllCams(true)
	RenderScriptCams(false, true, 1, true, true)
end

function openCam()
	SetRainFxIntensity(0.0)
	SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
	LoginSafe = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	local camCoords = {-3968.85, 2015.93, 501.41}
	SetCamRot(LoginSafe, -90.0, 0.0, 250.03, 2)
	SetCamCoord(LoginSafe, camCoords[1], camCoords[2], camCoords[3])
	StopCamShaking(LoginSafe, true)
	SetCamFov(LoginSafe, 75.0)
	SetCamActive(LoginSafe, true)
	RenderScriptCams(true, false, 0, true, true)
end

cam = 0
function doCamera(x,y,z)
	SetRainFxIntensity(0.0)
	SetWeatherTypePersist('EXTRASUNNY')
    SetWeatherTypeNow('EXTRASUNNY')
    SetWeatherTypeNowPersist('EXTRASUNNY')
	DoScreenFadeOut(1)
	if(not DoesCamExist(cam)) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	i = 6400
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 do
		local factor = i / 125
		if i < 1 then i = 1 end

        if i < 90.0 then
            i = i - factor - 0.075
        else
            i = i - factor
		end
		
		SetCamCoord(cam, x,y,z+i)
		if i < 1200 then
			DoScreenFadeIn(600)
		end

		if i < 90.0 then
			camAngle = i - i - i
		end
        
		SetCamRot(cam, camAngle, 0.0, 0.0)
		Citizen.Wait(2/i)
	end
end