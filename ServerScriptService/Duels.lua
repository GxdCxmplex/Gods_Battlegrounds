local ds = game:GetService("DataStoreService")
local options = Instance.new("DataStoreOptions")
options.AllScopes = true
local Data1v1 = ds:GetDataStore("cBK160H@%Ix)")
local list1v1 = ds:GetOrderedDataStore("cdK160H@%Ix)")
local Data2v2 = ds:GetDataStore("e&R$D0N48#+8")
local list2v2 = ds:GetOrderedDataStore("e&R$DoN48#+8")

local rs = game:GetService("ReplicatedStorage")
local folder = rs:WaitForChild("Duels")
local get1v1 = folder:WaitForChild("Get1v1")
local Create = folder:WaitForChild("Create")
local Cancel = folder:WaitForChild("Cancel")
local Join1v1 = folder:WaitForChild("Join1v1")
local Join2v2 = folder:WaitForChild("Join2v2")
local get2v2 = folder:WaitForChild("Get2v2")
local bossFight = folder:WaitForChild("BossFight")

local ts = game:GetService("TeleportService")

local difs = {
	Easy = "Calm",
	Medium = "Middle",
	Hard = "Aggressive",
	God = "God"
}

bossFight.OnServerEvent:Connect(function(player, boss : string, difficulty : string)
	if boss == "Water" then
		player:WaitForChild("Settings").BossDif.Value = difs[difficulty]
		local success, result = pcall(ts.TeleportPartyAsync, ts, 15479720253, {player})
		if success == false then print("Failed to Teleport") return end
	end
end)

get1v1.OnServerEvent:Connect(function(player)
	local data = list1v1:GetSortedAsync(false, 15)
	local page = data:GetCurrentPage()
	for _,v in ipairs(page) do
		local lobby = Data1v1:GetAsync(v.key)
		local name = game.Players:GetPlayerByUserId(lobby["userId"]) 
		local plrGui = player.PlayerGui.Pvp.Frame.Frame.Frame.ScrollingFrame
		if not plrGui:FindFirstChild(name.Name) then
			local frame = folder.ImageLabel:Clone()
			frame.name.Text = "@"..name.Name
			frame.Name = name.Name
			frame.level.Text = "Level: "..lobby["Level"]
			frame.magic.Text = "Current magic: "..lobby["Magic"]
			frame.Avatar.Image = game.Players:GetUserThumbnailAsync(lobby["userId"], Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
			frame.Id.Value = lobby["userId"]
			frame.Parent =  plrGui
		end
	end
end)

get2v2.OnServerEvent:Connect(function(player)
	local data = list2v2:GetSortedAsync(false, 15)
	local page = data:GetCurrentPage()
	for _,v in ipairs(page) do
		local lobby = Data2v2:GetAsync(v.key)
		local name = game.Players:GetPlayerByUserId(lobby["userId"]) 
		local plrGui = player.PlayerGui.Pvp.Frame.Frame.Frame.List2v2
		if not plrGui:FindFirstChild(name.Name) then
			local frame = folder.F2v2:Clone()
			frame.name.Text = "@"..name.Name
			frame.Name = name.Name
			frame.level.Text = "Level: "..lobby["Level"]
			frame.magic.Text = "Current magic: "..lobby["Magic"]
			frame.Players.Text = lobby["Players"].."/4"
			frame.Avatar.Image = game.Players:GetUserThumbnailAsync(lobby["userId"], Enum.ThumbnailType.AvatarThumbnail, Enum.ThumbnailSize.Size420x420)
			frame.Id.Value = lobby["userId"]
			frame.Parent =  plrGui
		end
	end
end)

Join1v1.OnServerEvent:Connect(function(player, lobbyId)
	if Data1v1:GetAsync(lobbyId) and lobbyId ~= player.UserId then
		local lobby = Data1v1:GetAsync(lobbyId)
		lobby["Players"] = 2
		task.wait(5)
		local players = {player, game.Players:GetPlayerByUserId(lobbyId)}
		local success, result = pcall(ts.TeleportPartyAsync, ts, 15490502161, players)
		if success == false then print("Failed to Teleport") return end
		task.wait(1)
		Data1v1:RemoveAsync(lobbyId)
		list1v1:RemoveAsync(lobbyId)
	end
end)

Join2v2.OnServerEvent:Connect(function(player, lobbyId)
	if Data1v1:GetAsync(lobbyId) and lobbyId ~= player.UserId then
		local lobby = Data1v1:GetAsync(lobbyId)
		if lobby["Players"] < 3 then
			lobby["Players"] += 1
			table.insert(lobby["List"], player.UserId)
			Data2v2:SetAsync(lobbyId, lobby)
			list2v2:SetAsync(lobbyId, lobby["Players"])
		elseif lobby["Players"] == 3 then
			for i,v in ipairs(lobby["List"]) do
				local success, result = pcall(ts.TeleportAsync, ts, 15490502873, {game.Players:GetPlayerByUserId(v)})
				if success == false then print("Failed to Teleport") return end
			end		
		end
		local success, result = pcall(ts.TeleportAsync, ts, 15490502873, {player})
		if success == false then print("Failed to Teleport") return end
		task.wait(1)
		Data2v2:RemoveAsync(lobbyId)
		list2v2:RemoveAsync(lobbyId)
	end
end)

Create.OnServerEvent:Connect(function(player, duel)
	if player.Settings.HasLobby.Value > 0 then return end
	if duel == "1v1" then
		local template = {}
		template["userId"] = player.UserId template["Magic"] = player.leaderstats.Magic.Value template["Level"] = player.leaderstats.Level.Value template["Players"] = 1
		print(template)
		Data1v1:SetAsync(player.UserId, template)
		list1v1:SetAsync(player.UserId, 1)
		player.Settings.HasLobby.Value = 1
		player.Settings.LobbyType.Value = 1
		Create:FireClient(player)
	elseif duel == "2v2" then
		local template = {}
		template["userId"] = player.UserId template["Magic"] = player.leaderstats.Magic.Value template["Level"] = player.leaderstats.Level.Value template["Players"] = 1 template["List"] = player.UserId
		print(template)
		Data2v2:SetAsync(player.UserId, template)
		list2v2:SetAsync(player.UserId, 1)
		player.Settings.HasLobby.Value = 1
		player.Settings.LobbyType.Value = 2
		Create:FireClient(player)
	end
end)

Cancel.OnServerEvent:Connect(function(player)
	if Data1v1:GetAsync(player.UserId) then
		Data1v1:RemoveAsync(player.UserId)
		list1v1:RemoveAsync(player.UserId)
	end
	if Data2v2:GetAsync(player.UserId) then
		Data2v2:RemoveAsync(player.UserId)
	end
	Cancel:FireClient(player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	if Data1v1:GetAsync(player.UserId) then
		Data1v1:RemoveAsync(player.UserId)
		list1v1:RemoveAsync(player.UserId)
	end
	if Data2v2:GetAsync(player.UserId) then
		Data2v2:RemoveAsync(player.UserId)
	end
end)