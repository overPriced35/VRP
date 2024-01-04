local QBCore = exports['qb-core']:GetCoreObject()
local LoginSafe, Cam = nil, false
local spawns = {
    [1] = {coords = vector3(282.60, -619.21, 42.020), label = "South Rockford Drive"},
	[2] = {coords = vector3(1811.14, 3677.75, 34.27), label = "Morningwood Blvd"},
    [3] = {coords = vector3(-1833.96, -1223.5, 13.02), label = "Integrity Way"},
    [4] = {coords = vector3(949.94, 117.59, 80.75), label = "Tinsel Towers"},
    [5] = {coords = vector3(145.62, 6563.19, 32.0), label = "Fantastic Plaza"},
}

RegisterNetEvent("apartmentspawn:opennui")
AddEventHandler("apartmentspawn:opennui", function(pos)
    SendNUIMessage({ data = spawns, lastpos = pos })
    openCam()
    SetNuiFocus(true, true)
end)

RegisterNUICallback("spawn", function(data)
	data.apartmentId = data.apartmentId + 1

	if spawns[data.apartmentId].label == "South Rockford Drive" then
		TriggerEvent("qb-spawn:client:chooseApart", "apartment1")
	elseif spawns[data.apartmentId].label == "Morningwood Blvd" then
		TriggerEvent("qb-spawn:client:chooseApart", "apartment2")
	elseif spawns[data.apartmentId].label == "Integrity Way" then
		TriggerEvent("qb-spawn:client:chooseApart", "apartment3")
	elseif spawns[data.apartmentId].label == "Tinsel Towers" then
		TriggerEvent("qb-spawn:client:chooseApart", "apartment4")
	elseif spawns[data.apartmentId].label == "Fantastic Plaza" then
		TriggerEvent("qb-spawn:client:chooseApart", "apartment5")
	end
end)

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
    Cam = false
	DoScreenFadeOut(1000)
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

	i = 3200
	SetFocusArea(x, y, z, 0.0, 0.0, 0.0)
	SetCamActive(cam,  true)
	RenderScriptCams(true,  false,  0,  true,  true)
	DoScreenFadeIn(1500)
	local camAngle = -90.0
	while i > 1 do
		local factor = i / 50
		if i < 1 then i = 1 end
		i = i - factor
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