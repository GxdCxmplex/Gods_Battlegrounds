local ds = game:GetService("DataStoreService")
local msgs = game:GetService("MessagingService")
local clanSearchDs = ds:GetOrderedDataStore("zJG9%ex2T9uo")
local clanDs = ds:GetDataStore("zJG9%ex2T9uo")
local rs = game:GetService("ReplicatedStorage")
local searchEvent = rs.Clan.Search
local createEvent = rs.Clan.Create
local playerEvent = rs.Clan.PlayerEvent
local playerRefresh = rs.Clan.RefreshPlayers
local joinEvent = rs.Clan.Join
local BoostEvent = rs.Clan.Boost
local leave = rs.Clan.Leave
local change = rs.Clan.Change
local kick = rs.Clan.Kick
local list = rs.Clan.list

local price = require(game.ServerStorage.ClanBoostPrices)


searchEvent.OnServerEvent:Connect(function(player, name)
	local pages = clanSearchDs:GetSortedAsync(false, 50)
	local all = pages:GetCurrentPage()
	for id, val in ipairs(all) do
		if clanDs:GetAsync(val["key"]) then
			local InGlobalDs = clanDs:GetAsync(val["key"])
			if InGlobalDs["Name"] == name then
				local ClanInfo = {Name = InGlobalDs["Name"], Image = InGlobalDs["Image"], Players = InGlobalDs["Players"], Id = val["key"], TotalLvl = InGlobalDs["TotalLvl"]}
				searchEvent:FireClient(player, ClanInfo)
			end
		end
	end
end)

list.OnServerEvent:Connect(function(player)
	local pages = clanSearchDs:GetSortedAsync(false, 15)
	local all = pages:GetCurrentPage()
	for j,k in pairs(all) do
		local id = k["key"]
		local data = clanDs:GetAsync(id)
		local info = {Name = data["Name"], Image = data["Image"], Players = data["Players"], Id = id, TotalLvl = data["TotalLvl"]}
		list:FireClient(player, info)
	end
end)

createEvent.OnServerEvent:Connect(function(player , data)
	local name = data["Name"]
	local image = data["Image"]
	local slogan = data["Slogan"]
	if name ~= nil and image ~= nil and slogan ~= nil then
		local Num = math.random(8,11)
		local id = tostring(math.random(0,9))
		for i = 0 , Num do
			local randNum = math.random(0,9)
			id = id..tostring(randNum)
			wait(.01)
		end
		if clanDs:GetAsync(id) then id += tostring(math.random(0,9)) end
		local players = 1
		local playerInfo = {player.UserId, "God", player.Name, player.leaderstats.Level.Value}
		local ToPlayerSave = {}
		ToPlayerSave[1] = playerInfo
		local clanData = {Name = name, Image = image, Slogan = slogan, Player = ToPlayerSave, Players = players, Boost = 1, TotalLvl = player.leaderstats.Level.Value}
		clanDs:SetAsync(tonumber(id), clanData)
		clanSearchDs:SetAsync(tonumber(id), player.leaderstats.Level.Value)
		createEvent:FireClient(player, "Success")
		player.Clan.Id.Value = tonumber(id)
		player.Clan.Role.Value = "God"
		player.Clan.IsIn.Value = 1
		player.Clan.ClanName.Value = name
		player.Clan.PlayerIn.Value = players
	else
		createEvent:FireClient(player, "Error")
	end
end)


playerEvent.OnServerEvent:Connect(function(player)
	local playerId = player.UserId
	local playerName = player.Name
	local playerRole = player.Clan.Role.Value

	local clanId = player.Clan.Id.Value
	if clanDs:GetAsync(clanId) then
		local getDs = clanDs:GetAsync(clanId)
		local InClanPlayers = getDs["Player"]
		for i,plr in ipairs(InClanPlayers) do
			local PlayerData = {Id = playerId, Player = getDs["Player"], Slogan = getDs["Slogan"], Image = getDs["Image"], Name = playerName, Role = playerRole, Boost = getDs["Boost"], Price = price["price"..getDs["Boost"] * 10][1], ClanName = getDs["Name"], Players = getDs["Players"], TotalLvl = getDs["TotalLvl"]}
			playerEvent:FireClient(player, PlayerData)
		end
	end
end)

msgs:SubscribeAsync("Change", function(id: NumberValue)
	if clanDs:GetAsync(id["Data"]) then
		local InGlobalDs = clanDs:GetAsync(id["Data"])
		local playersIn = InGlobalDs["Players"]
		for i = 1, playersIn do
			if game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1]) then
				local plr = game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1])
				local playerRole = plr:WaitForChild("Clan"):WaitForChild("Role").Value
				plr.Clan.ClanBoost.Value = InGlobalDs["Boost"]
				local playerData = {Player = InGlobalDs["Player"],Role = playerRole, Slogan = InGlobalDs["Slogan"], Image = InGlobalDs["Image"], Id = id["Data"], Boost = InGlobalDs["Boost"], price["price"..InGlobalDs["Boost"] * 10][1], ClanName = InGlobalDs["Name"], Players = InGlobalDs["Players"], TotalLvl = InGlobalDs["TotalLvl"]}
				rs.Clan.PlayerEvent:FireClient(plr, playerData)
			end
		end
	end
end)

msgs:SubscribeAsync("Update", function(id:NumberValue)
	local clan = clanDs:GetAsync(id["Data"])
	local lvl = 0
	for i,v in pairs(clan["Player"]) do
		lvl += v[4]
	end
	clan["TotalLvl"] = lvl
	clanDs:SetAsync(id["Data"], clan)
end)


joinEvent.OnServerEvent:Connect(function(player, id)
	local ClanToJoinDs = clanDs:GetAsync(id)
	if ClanToJoinDs["Players"] == 50 then return end	
	local playerInfo = {player.UserId, "Mortal", player.Name, player.leaderstats.Level.Value}
	local playersIn = ClanToJoinDs["Players"] + 1
	local ClanPlayerData = ClanToJoinDs["Player"]
	table.insert(ClanPlayerData, playersIn, playerInfo)
	local clanData = {Name = ClanToJoinDs["Name"], Image = ClanToJoinDs["Image"], Slogan = ClanToJoinDs["Slogan"], Player = ClanPlayerData, Players = ClanToJoinDs["Players"] + 1, Boost = ClanToJoinDs["Boost"], TotalLvl = ClanToJoinDs["TotalLvl"] + player.leaderstats.Level.Value}
	clanDs:SetAsync(id, clanData)
	table.insert(clanData, id)
	clanSearchDs:SetAsync(id, clanData["TotalLvl"])
	player.Clan.Id.Value = id
	player.Clan.Role.Value = "Mortal"
	player.Clan.IsIn.Value = 1
	player.Clan.ClanName.Value = ClanToJoinDs["Name"]
	player.Clan.PlayerIn.Value = ClanToJoinDs["Players"]
	joinEvent:FireClient(player, "Success")
	msgs:PublishAsync("Join", id)
end)


BoostEvent.OnServerEvent:Connect(function(player)
	if player.StatsData.Crystals.Value >= price["price"..player.Clan.ClanBoost.Value * 10][1] then
		local ClanToJoinDs = clanDs:GetAsync(player.Clan.Id.Value)
		local clanData = {Name = ClanToJoinDs["Name"], Image = ClanToJoinDs["Image"], Slogan = ClanToJoinDs["Slogan"], Player = ClanToJoinDs["Player"], Players = ClanToJoinDs["Players"], Boost = price["price"..ClanToJoinDs["Boost"] * 10][2], Price = price["price"..player.Clan.ClanBoost.Value * 10][1], TotalLvl = ClanToJoinDs["TotalLvl"]}
		clanDs:SetAsync(player.Clan.Id.Value, clanData)
		player.StatsData.Crystals.Value -= price["price"..player.Clan.ClanBoost.Value * 10][1]
		player.Clan.ClanBoost.Value = price["price"..ClanToJoinDs["Boost"] * 10][2]
		msgs:PublishAsync("ClanBoost", player.Clan.Id.Value)
	end
end)

rs.Clan.Promt.Event:Connect(function(player)
	rs.Clan.Bought:FireClient(player)
end)

leave.OnServerEvent:Connect(function(player)
	local clan = clanDs:GetAsync(player.Clan.Id.Value)
	local Player = clan["Players"]
	for i = 1 ,clan["Players"] do
		if clan["Player"][i][1] == player.UserId then
			table.remove(clan["Player"], i)
			break
		end
	end
	local clanData = {Name = clan["Name"], Image = clan["Image"], Slogan = clan["Slogan"], Player = clan["Player"], Players = Player - 1, Boost = clan["Boost"], TotalLvl = clan["TotalLvl"] - player.leaderstats.Level.Value}
	if clanData["Players"] == 0 or player.Clan.Role.Value == "God" then
		clanDs:RemoveAsync(player.Clan.Id.Value)
		clanSearchDs:RemoveAsync(player.Clan.Id.Value)
	else
		clanDs:SetAsync(player.Clan.Id.Value, clanData)
		clanSearchDs:SetAsync(player.Clan.Id.Value, clanData["TotalLvl"])
	end
	msgs:PublishAsync("Leave", player.Clan.Id.Value)
	table.insert(clanData, player.Clan.Id.Value)
	player.Clan.Id.Value = 0
	player.Clan.IsIn.Value = 0
	player.Clan.Role.Value = ""
	player.Clan.ClanName.Value = ""
	player.Clan.ClanBoost.Value = 1
	leave:FireClient(player)
	
end)

change.OnServerEvent:Connect(function(player, data)
	if player.Clan.Role.Value ~= "God" then return end
	local name
	local slogan
	local image
	if clanDs:GetAsync(player.Clan.Id.Value) then
		local clan = clanDs:GetAsync(player.Clan.Id.Value)
		if data["Name"] == "-" then
			name = clan["Name"]
		else
			name = data["Name"]
		end
		if data["Slogan"] == "-" then
			slogan = clan["Slogan"]
		else
			slogan = data["Slogan"]
		end
		if data["Image"] == "-" then
			image = clan["Image"]
		else
			image = data["Image"]
		end
		local clanData = {Name = name, Image = image, Slogan = slogan, Player = clan["Player"], Players = clan["Players"], Boost = clan["Boost"], TotalLvl = clan["TotalLvl"]}
		clanDs:SetAsync(player.Clan.Id.Value, clanData)
		change:FireClient(player, "Success")
		msgs:PublishAsync("Change", player.Clan.Id.Value)
	else
	end
end)

kick.OnServerEvent:Connect(function(player, name)
	if player.Name == name then return end
	local clanId = player.Clan.Id.Value
	local clan = clanDs:GetAsync(clanId)
	local Player = clan["Players"]
	print(name, clan["Player"])
	for i = 1 ,clan["Players"] do
		if clan["Player"][i][3] == name then
			msgs:PublishAsync("Kick", clan["Player"][i][1])
			local clanData = {Name = clan["Name"], Image = clan["Image"], Slogan = clan["Slogan"], Player = clan["Player"], Players = Player - 1, Boost = clan["Boost"], TotalLvl = clan["TotalLvl"] - clan["Player"][i][4]}
			msgs:PublishAsync("Kick", clan["Player"][i][1])
			table.remove(clanData["Player"], i)
			clanDs:SetAsync(clanId, clanData)
			clanSearchDs:SetAsync(clanId, clanData["TotalLvl"])
			break
		end
	end
end)

msgs:SubscribeAsync("Kick", function(id: NumberValue)
	if game.Players:GetPlayerByUserId(id["Data"]) then
		local player = game.Players:GetPlayerByUserId(id["Data"])
		player.Clan.Id.Value = 0
		player.Clan.IsIn.Value = 0
		player.Clan.Role.Value = ""
		player.Clan.ClanName.Value = ""
		player.Clan.ClanBoost.Value = 1
	end
end)


msgs:SubscribeAsync("Join", function(id: NumberValue)
	if clanDs:GetAsync(id["Data"]) then
		local InGlobalDs = clanDs:GetAsync(id["Data"])
		local playersIn = InGlobalDs["Players"]
		for i = 1, playersIn do
			if game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1]) then
				local plr = game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1])
				local playerRole = plr:WaitForChild("Clan"):WaitForChild("Role").Value
				plr.Clan.ClanBoost.Value = InGlobalDs["Boost"]
				local playerData = {Role = playerRole, Slogan = InGlobalDs["Slogan"], Image = InGlobalDs["Image"], Id = id["Data"], Boost = InGlobalDs["Boost"], Price = price["price"..InGlobalDs["Boost"] * 10][1], ClanName = InGlobalDs["Name"], Players = InGlobalDs["Players"], TotalLvl = InGlobalDs["TotalLvl"]}
				rs.Clan.Update:FireClient(plr, InGlobalDs)
			end
		end
	end
end)



msgs:SubscribeAsync("Leave", function(id: NumberValue)
	if clanDs:GetAsync(id["Data"]) then
		local InGlobalDs = clanDs:GetAsync(id["Data"])
		local playersIn = InGlobalDs["Players"]
		for i = 1, playersIn do
			if game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1]) then
				local plr = game.Players:GetPlayerByUserId(InGlobalDs["Player"][i][1])
				local playerRole = plr:WaitForChild("Clan"):WaitForChild("Role").Value
				plr.Clan.ClanBoost.Value = InGlobalDs["Boost"]
				local playerData = {Role = playerRole, Slogan = InGlobalDs["Slogan"], Image = InGlobalDs["Image"], Id = id["Data"], Boost = InGlobalDs["Boost"], Price = price["price"..InGlobalDs["Boost"] * 10][1], ClanName = InGlobalDs["Name"], Players = InGlobalDs["Players"], TotalLvl = InGlobalDs["TotalLvl"]}
				rs.Clan.Update:FireClient(plr, InGlobalDs)
			end
		end
	end
end)

msgs:SubscribeAsync("ClanBoost", function(id: NumberValue)
	local clan = clanDs:GetAsync(id["Data"])
	for i,v in pairs(game.Players:GetChildren()) do
		if v.Clan.Id.Value == id["Data"] then
			v.Clan.ClanBoost.Value = clan["Boost"]
			local playerData = {Role = v.Clan.Role.Value, Slogan = clan["Slogan"], Image = clan["Image"], Id = id["Data"], Boost = clan["Boost"], Price = price["price"..clan["Boost"] * 10][1], ClanName = clan["Name"], Players = clan["Players"], TotalLvl = clan["TotalLvl"]}
			rs.Clan.UpdatePlayerEvent:FireClient(v, playerData)
		end
	end
end)