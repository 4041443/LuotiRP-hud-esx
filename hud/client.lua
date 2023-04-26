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
AddEventHandler('esx:playerLoaded', function(xPlayer) 
	local data = xPlayer
	local accounts = data.accounts
	ExecuteCommand("hud")
	for k,v in pairs(accounts) do
		local account = v
		if account.name == "bank" then
			SendNUIMessage({action = "setValue", value = ""..account.money, key = "bankmoney"})
		elseif account.name == "black_money" then
			SendNUIMessage({action = "setValue", value = ""..math.floor(account.money), key = "dirtymoney"})
		end
		SendNUIMessage({action = "setValue", value = ""..data.money, key = "money"})
	end
	-- Job
	local job = data.job
	SendNUIMessage({action = "setValue", key = "job", value = job.label.." - "..job.grade_label, icon = job.name})
	-- Money
	SendNUIMessage({action = "setValue", value = ""..data.money, key = "money"})
end)
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)
local hud = true
RegisterCommand("hud", function()
	if not hud then
		hud = true
		SendNUIMessage({action = "toggle", show = false})
		print("off")
	else
		hud = false
		print("on")
		SendNUIMessage({action = "toggle", show = true})
	end
end)
RegisterCommand("loadhud", function()
	TriggerServerEvent("hud:getStats")
end)
RegisterNetEvent('hud:retrieve')
AddEventHandler('hud:retrieve', function(money, bank, black, job, grade)
	print(money)
	if money ~= nil then
		SendNUIMessage({action = "setValue", value = ""..money, key = "money"})
	elseif bank ~= nil then
		SendNUIMessage({action = "setValue", value = ""..bank, key = "bankmoney"})
	elseif black ~= nil then
		SendNUIMessage({action = "setValue", value = ""..math.floor(black), key = "dirtymoney"})
	elseif job ~= nil then
		SendNUIMessage({action = "setValue", value = job.." - "..grade, icon = job.name, key = "job"})
	end
end)
RegisterNetEvent('esx:setAccountMoney')
AddEventHandler('esx:setAccountMoney', function(account)
	if account.name == "bank" then
		SendNUIMessage({action = "setValue", value = ""..account.money, key = "bankmoney"})
	elseif account.name == "black_money" then
		SendNUIMessage({action = "setValue", value = ""..math.floor(account.money), key = "dirtymoney"})
	elseif account.name == "money" then
		SendNUIMessage({action = "setValue", value = ""..account.money, key = "money"})
	end
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  SendNUIMessage({action = "setValue", value = job.label.." - "..job.grade_label, icon = job.name, key = "job"})
end)
RegisterNetEvent('es:activateMoney')
AddEventHandler('es:activateMoney', function(e)
	SendNUIMessage({action = "setValue", value = ""..e, key = "money"})
end)