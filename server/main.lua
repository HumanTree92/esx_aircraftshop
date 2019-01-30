ESX              = nil
local Categories = {}
local Vehicles   = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	local char = Config.PlateLetters
	char = char + Config.PlateNumbers
	if Config.PlateUseSpace then char = char + 1 end

	if char > 8 then
		print(('esx_aircraftshop: ^1WARNING^7 plate character count reached, %s/8 characters.'):format(char))
	end
end)

function RemoveOwnedVehicle(plate)
	MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	})
end

MySQL.ready(function()
	Categories     = MySQL.Sync.fetchAll('SELECT * FROM aircraft_categories')
	local vehicles = MySQL.Sync.fetchAll('SELECT * FROM aircrafts')

	for i=1, #vehicles, 1 do
		local vehicle = vehicles[i]

		for j=1, #Categories, 1 do
			if Categories[j].name == vehicle.category then
				vehicle.categoryLabel = Categories[j].label
				break
			end
		end

		table.insert(Vehicles, vehicle)
	end

	-- send information after db has loaded, making sure everyone gets vehicle information
	TriggerClientEvent('esx_aircraftshop:sendCategories', -1, Categories)
	TriggerClientEvent('esx_aircraftshop:sendVehicles', -1, Vehicles)
end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function (licenses)
		TriggerClientEvent('esx_aircraftshop:loadLicenses', source, licenses)
	end)
end

if Config.LicenseEnable == true then
	AddEventHandler('esx:playerLoaded', function (source)
		LoadLicenses(source)
	end)
end

RegisterServerEvent('esx_aircraftshop:buyLicense')
AddEventHandler('esx_aircraftshop:buyLicense', function ()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.LicensePrice then
		xPlayer.removeMoney(Config.LicensePrice)

		TriggerEvent('esx_license:addLicense', _source, 'aircraft', function ()
			LoadLicenses(_source)
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

RegisterServerEvent('esx_aircraftshop:setVehicleOwned')
AddEventHandler('esx_aircraftshop:setVehicleOwned', function (vehicleProps)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, Type) VALUES (@owner, @plate, @vehicle, @Type)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@Type']    = 'aircraft'
	}, function (rowsChanged)
		TriggerClientEvent('esx:showNotification', _source, _U('aircraft_belongs', vehicleProps.plate))
	end)
end)

ESX.RegisterServerCallback('esx_aircraftshop:getCategories', function (source, cb)
	cb(Categories)
end)

ESX.RegisterServerCallback('esx_aircraftshop:getVehicles', function (source, cb)
	cb(Vehicles)
end)

ESX.RegisterServerCallback('esx_aircraftshop:buyVehicle', function (source, cb, vehicleModel)
	local xPlayer     = ESX.GetPlayerFromId(source)
	local vehicleData = nil

	for i=1, #Vehicles, 1 do
		if Vehicles[i].model == vehicleModel then
			vehicleData = Vehicles[i]
			break
		end
	end

	if xPlayer.getMoney() >= vehicleData.price then
		xPlayer.removeMoney(vehicleData.price)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_aircraftshop:resellVehicle', function (source, cb, plate, model)
	local resellPrice = 0

	-- calculate the resell price
	for i=1, #Vehicles, 1 do
		if GetHashKey(Vehicles[i].model) == model then
			resellPrice = ESX.Math.Round(Vehicles[i].price / 100 * Config.ResellPercentage)
			break
		end
	end

	if resellPrice == 0 then
		print(('esx_aircraftshop: %s attempted to sell an unknown vehicle!'):format(GetPlayerIdentifiers(source)[1]))
		cb(false)
	end

	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function (result)
		if result[1] then -- does the owner match?
			local vehicle = json.decode(result[1].vehicle)
			if vehicle.model == model then
				if vehicle.plate == plate then
					xPlayer.addMoney(resellPrice)
					RemoveOwnedVehicle(plate)
					
					cb(true)
				else
					print(('esx_aircraftshop: %s attempted to sell an vehicle with plate mismatch!'):format(xPlayer.identifier))
					cb(false)
				end
			else
				print(('esx_aircraftshop: %s attempted to sell an vehicle with model mismatch!'):format(xPlayer.identifier))
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_aircraftshop:isPlateTaken', function (source, cb, plate)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function (result)
		cb(result[1] ~= nil)
	end)
end)

ESX.RegisterServerCallback('esx_aircraftshop:retrieveJobVehicles', function (source, cb, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND type = @type AND job = @job', {
		['@owner'] = xPlayer.identifier,
		['@type'] = type,
		['@job'] = xPlayer.job.name
	}, function (result)
		cb(result)
	end)
end)

RegisterServerEvent('esx_aircraftshop:setJobVehicleState')
AddEventHandler('esx_aircraftshop:setJobVehicleState', function(plate, state)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = @stored WHERE plate = @plate AND job = @job', {
		['@stored'] = state,
		['@plate'] = plate,
		['@job'] = xPlayer.job.name
	}, function(rowsChanged)
		if rowsChanged == 0 then
			print(('esx_aircraftshop: %s exploited the garage!'):format(xPlayer.identifier))
		end
	end)
end)
