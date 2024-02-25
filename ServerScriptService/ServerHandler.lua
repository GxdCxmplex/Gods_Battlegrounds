local msgs = game:GetService("MessagingService")
local marketPlaceService = game:GetService("MarketplaceService")
local dataStoreService = game:GetService("DataStoreService")
local rs = game:GetService("ReplicatedStorage")
local tps = game:GetService("TeleportService")

local IsPrivate = false
if game.PrivateServerId ~= "" and game.PrivateServerOwnerId ~= 0 then
	IsPrivate = true
end
local regular = script:WaitForChild("Regular")
local vip = script:WaitForChild("VIP")

local ds = dataStoreService:GetDataStore("34H*s7Ykq6eg")
local giftedData = dataStoreService:GetDataStore("g5-M78v(Zu`T")
local clanDs = dataStoreService:GetDataStore("zJG9%ex2T9uo")
local banDs = dataStoreService:GetDataStore("PiCY040&Pp0")

local loaded = {}
local bans = {}

local banEvent = game:GetService("ReplicatedStorage").ServerMessages.BanMessage
local Time = rs.Stats.Boosts
local radio = rs.Stuff.Radio
local event = rs.ServerMessages.JoinMessage
local Chat = rs.Tags.ChatTags.Equip
local kill = rs.KillChat.Equip
local kick = rs.PrivateControl.Kick
local Emotes = rs.Emotes.Equip
local Codes = rs.RedeemCode
local MagicEquip = rs.Magics.Change
local upgrades = rs.Stats.Upgrades
local Aura = rs.Auras.Turn

local passes = require(rs.GiftGamepass.GiftableGamepasses)

local CrystalsId = passes[1][1]
local KillsId = passes[2][1]
local VIPId = passes[3][1]
local RadioId = passes[4][1]
local SoundsId = passes[5][1]
BadgeID = 2908432950671408
local placeId = 15216873648

local function ownsgamepass (userid, gamepassId)
	local s,res = pcall(marketPlaceService.UserOwnsGamePassAsync, marketPlaceService, userid, gamepassId)
	if not s then
		res = false
	end
	return res
end

local function getban(player)
	if banDs:GetAsync(player.UserId) then
		return true
	end
	return false
end

coroutine.wrap(function()
	while wait(.01) do
		game.Lighting.ClockTime = game.Lighting.ClockTime + .001
	end
end)()

local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No", "Dc", "Ud", "Dd", "Td", "Qad", "Qtd", "Sxd","Spd", "Ocd", "Nod", "Vg", "UVg", "DVg"}
local function Format (value, idp)
	local ex = math.floor(math.log(math.max(1, math.abs(value)), 1000))
	local abbrevs = abbrev [1 + ex] or ("e+".. ex)
	local normal = math.floor(value * ((10 ^ idp) / (1000 ^ ex))) / (10 ^ idp)

	return ("%."..idp.."f%s"):format(normal, abbrevs)
end

local function ClanCheck(player)
	local True = false
	if clanDs:GetAsync(player.Clan.Id.Value) then
		local clan = clanDs:GetAsync(player.Clan.Id.Value)
		for i = 1 ,clan["Players"] do
			if clan["Player"][i][1] == player.UserId then
				if player.leaderstats.Level.Value ~= clan["Player"][i][4] then
					clan["Player"][i][4] = player.leaderstats.Level.Value
					clanDs:SetAsync(player.Clan.Id.Value, clan)
					msgs:PublishAsync("Update", player.Clan.Id.Value)
				end
				True = true
			end
		end
	end
	if not True then
		player.Clan.Id.Value = 0
		player.Clan.IsIn.Value = 0
		player.Clan.Role.Value = ""
		player.Clan.ClanName.Value = ""
		player.Clan.ClanBoost.Value = 1
	end
end

local function OnAdded(player)
	local success, value = pcall(ds.GetAsync, ds, player.UserId)
	if success == false then player:Kick("DataStore failed to load") return end	
	local data = value or {}
	print("Loaded: ", data)
	rs.Stuff.Join:FireClient(player)
	rs.Stuff.JoinWater:FireClient(player)
	rs.Stuff.JoinFire:FireClient(player)
	for i,folder in game.ServerStorage.PlayerData:GetChildren() do
		local subData = data[folder.Name] or {}
		local clone = folder:Clone()
		for i, child in clone:GetChildren() do
			child.Value = subData[child.Name] or child.Value
		end
		clone.Parent = player
	end
	loaded[player] = true
	player.Magic.AllowDemonMode.Value = 0
	player.Magic.DemonMode.Value = 0
	player.Magic.InDemonMode.Value = 0
	player.Magic.InSkill.Value = 0
	player.Magic.CanUseSkill.Value = true
	player.Passes.RadioTime.Value = 0
	player.Settings.HasLobby.Value = 0
	player.Settings.LobbyType.Value = 0
	event:FireAllClients(player,player.Name.." has joined server👋")

	local ownsCrystals = marketPlaceService:UserOwnsGamePassAsync(player.UserId, CrystalsId)
	local ownsKills = marketPlaceService:UserOwnsGamePassAsync(player.UserId, KillsId)
	local ownsVIP = marketPlaceService:UserOwnsGamePassAsync(player.UserId, VIPId)
	local ownsRadio = marketPlaceService:UserOwnsGamePassAsync(player.UserId, RadioId)
	local ownsSounds = marketPlaceService:UserOwnsGamePassAsync(player.UserId, SoundsId)

	if not ownsVIP then
		local data = giftedData:GetAsync(player.UserId .. "-" .. VIPId)
		if data then ownsVIP = true end
	end

	if not ownsCrystals then
		local data = giftedData:GetAsync(player.UserId .. "-" .. CrystalsId)
		if data then ownsCrystals = true end
	end

	if not ownsKills then
		local data = giftedData:GetAsync(player.UserId .. "-" .. KillsId)
		if data then ownsKills = true end
	end

	if not ownsRadio then
		local data = giftedData:GetAsync(player.UserId .. "-" .. RadioId)
		if data then ownsRadio = true end
	end

	if not ownsSounds then
		local data = giftedData:GetAsync(player.UserId .. "-" .. SoundsId)
		if data then ownsSounds = true end
	end

	if ownsVIP and player.Passes.VIP.Value == 0 then
		player.Passes.VIP.Value = 1
	end
	if ownsCrystals and player.Passes.Crystals.Value == 0 then
		player.Passes.Crystals.Value = 1
	end
	if ownsKills and player.Passes.Kills.Value == 0 then
		player.Passes.Kills.Value = 1
	end
	if ownsRadio and player.Passes.RadioGP.Value == 0 then
		player.Passes.RadioGP.Value = 1
	end
	if ownsSounds and player.Passes.Sounds.Value == 0 then
		player.Passes.Sounds.Value = 1
	end
	ClanCheck(player)
end

local function OnRemoving(player)
	if loaded[player] == nil then return end
	local data = {}
	for i,folder in game.ServerStorage.PlayerData:GetChildren() do
		local subData = {}
		for i,child in player[folder.Name]:GetChildren() do
			subData[child.Name] = child.Value
		end
		data[folder.Name] = subData
		player[folder.Name]:Destroy()
	end
	local success, value = pcall(ds.SetAsync, ds, player.UserId, data)
	print("Saved: ", data)
	loaded[player] = nil
end

game:BindToClose(function()
	coroutine.wrap(function()
		for i, player in pairs(game.Players:GetPlayers()) do
			player.PlayerGui.ShutdownGui.Enabled = true
		end
		wait(10)
		tps:TeleportAsync(placeId, game.Players:GetPlayers())
		wait(5)
	end)()
	while next(loaded) ~= nil do
		task.wait()
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		if getban(player) then
			player:Kick("You've got banned from this game")
			return
		end
		OnAdded(player)
		task.spawn(function()
			while task.wait() do
				if player.Character then
					local Exp = player.StatsData.Exp
					local Levels = player.leaderstats.Level
					local neededExp = math.floor(Levels.Value ^ 1.5 + 0.5) * 250
					if Exp.Value >= neededExp then
						player.leaderstats.Level.Value += 1
					end
				end
			end
		end)
		if IsPrivate then
			local onDead = vip.Character.OnDead:Clone()
			onDead.Parent = player.Character
			onDead.Disabled = false
			if game.PrivateServerOwnerId == player.UserId or player.UserId == 1512671144 then
				if not player.PlayerGui:FindFirstChild("PrivateServerControl") then vip.PlayerGui.PrivateServerControl:Clone().Parent = player.PlayerGui end
			end
		else
			local onDead = regular.Character.OnDead:Clone()
			onDead.Parent = player.Character
			onDead.Disabled = false
		end
		if player.UserId == 1512671144 then
			if not player.PlayerGui:FindFirstChild("PrivateServerControl") then vip.PlayerGui.PrivateServerControl:Clone().Parent = player.PlayerGui end
		end
		local b = game:GetService("BadgeService")
		local success, hasBadge = pcall(function()
			return b:UserHasBadgeAsync(player.UserId, BadgeID)
		end)
		if not hasBadge then
			b:AwardBadge(player.UserId, BadgeID)
		end
		player.Chatted:Connect(function(msg)
			if player.UserId == 1512671144 or player.UserId == 875019340 or player.UserId == 1544238921 then
				if msg:match("/kick") then
					local playerToKick = msg:split(' ')[2]
					if playerToKick ~= "foshifjwgfwgduogw" and playerToKick ~="rey22890" and playerToKick ~= "ArtGam1ng" then
						if game.Players:FindFirstChild(playerToKick) then
							game.Players:FindFirstChild(playerToKick):Kick("You have been kicked by an Admin")
						else 
							warn(playerToKick, "is not valid player")
						end
					end

				elseif msg:match("/ban") then
					local playerToBan = msg:split(' ')[2]
					if playerToBan ~= "foshifjwgfwgduogw" and playerToBan ~="rey22890" and playerToBan ~= "ArtGam1ng" then
						if game.Players:FindFirstChild(playerToBan) then
							ds:SetAsync(game.Players:FindFirstChild(playerToBan).UserId, true)
							banEvent:FireAllClients(player ,game.Players:FindFirstChild(playerToBan).Name.." have been banned by owner!👋")
							game.Players:FindFirstChild(playerToBan):Kick("You have been banned by owner")
						else
							local Players = game:GetService("Players")
							local id = Players:GetUserIdFromNameAsync(playerToBan)
							ds:SetAsync(id, true)
						end
					end
				elseif msg:match("/unban") then
					local playerToBan = msg:split(' ')[2]
					if game.Players:FindFirstChild(playerToBan) then
						ds:RemoveAsync(game.Players:FindFirstChild(playerToBan).UserId)
					else
						local Players = game:GetService("Players")
						local id = Players:GetUserIdFromNameAsync(playerToBan)
						ds:RemoveAsync(id)
					end
				elseif msg:match("/pos") then
					local playerToTeleport = msg:split(' ')[2]
					if game.Players:FindFirstChild(playerToTeleport) then
						player.Character.HumanoidRootPart.CFrame = workspace:FindFirstChild(playerToTeleport).HumanoidRootPart.CFrame * CFrame.new(0,5,0)
					end
				end
			end
		end)
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	task.spawn(function()
		OnRemoving(player)
	end)
end)

event.OnServerEvent:Connect(function(player, text)
	local codesModule = require(game.ServerStorage.codesModule)
	local ExpModule = require(game.ServerStorage.ExpModule)
	local RC = player.StatsData.RedeemedCode
	for i,v in pairs(codesModule) do
		if text == v.Code and not RC.Value:match(v.Code) then 
			player.StatsData.Crystals.Value += v.reward
			player.PlayerGui.SettingGui.Frame.ScrollingFrame.Codes.CodeHandler.Text = "+"..Format(v.reward, 0).." Crystals"
			RC.Value = RC.Value..v.Code.." "
		elseif text == v.Code and RC.Value:match(v.Code) then
			player.PlayerGui.SettingGui.Frame.ScrollingFrame.Codes.CodeHandler.Text = "Already redeemed"
		end
	end

	for i,v in pairs(ExpModule) do
		if text == v.Code and not RC.Value:match(v.Code) then 
			player.leaderstats.Level.Value += v.reward
			player.PlayerGui.SettingGui.Frame.ScrollingFrame.Codes.CodeHandler.Text = "+"..Format(v.reward, 0).." Exp"
			RC.Value = RC.Value..v.Code.." "
		elseif text == v.Code and RC.Value:match(v.Code) then
			player.PlayerGui.SettingGui.Frame.ScrollingFrame.Codes.CodeHandler.Text = "Already redeemed"	
		end
	end
end)

MagicEquip.OnServerEvent:Connect(function(p, op)
	if op == "Water" then
		if p.leaderstats.Level.Value >= 0 then
			p.leaderstats.Magic.Value = "Water"
		end
	end
end)

event.OnServerEvent:Connect(function(player, val, value)
	local crystals = player.StatsData.Crystals.Value
	if val == "SoundId" then
		local has2x = ownsgamepass(player.UserId, 651850890)
		local role = player:GetRoleInGroup(14398446)
		if not has2x and role ~= "Pre-Tester" and role ~= "Developer" and role ~= "Co-Owner" and role ~= "Owner/Developer" then 
			game:GetService("MarketplaceService"):PromptGamePassPurchase(player, 651850890)
			return
		end
		player.Passes.KillSoundId.Value = value
	end
end)

Time.OnServerEvent:Connect(function(player, op, text)
	if op == "CrystalBoost" then
		if player.Boosts.CrystalsBoost.Value ~= 0 then
			player.Boosts.CrystalsBoost.Value -= 1
			player.Boosts.CrystalsBoostMult.Value = 2
		else
			player.Boosts.CrystalsBoost.Value = 0
			player.Boosts.CrystalsBoostMult.Value = 1
		end
	elseif op == "Exp" then
		if player.Boosts.ExpBoost.Value ~= 0 then
			player.Boosts.ExpBoost.Value -= 1
			player.Boosts.ExpBoostMult.Value = 2
		else
			player.Boosts.ExpBoost.Value = 0
			player.Boosts.ExpBoostMult.Value = 1
		end
	elseif op == "SoundId" then
		local has = ownsgamepass(player.UserId, 651850890)
		if has or player.Passes.Sounds.Value == 1 then
			player.Passes.KillSoundId.Value = text
		end
	end
end)


radio.OnServerEvent:Connect(function(player, id, todo)
	local isInGroup = player:GetRoleInGroup(14398446)
	if isInGroup == "Owner/Developer" or isInGroup == "Co-Owner" or isInGroup == "Pre-Tester" or player.Passes.RadioGP.Value == 1 or ownsgamepass(player.UserId, 652979875) then
		if todo == "Play" and id ~= 0 then
			player.Passes.Radio.Value = 1
			player.Passes.RadioId.Value = id
			local sound = player.Character.HumanoidRootPart:FindFirstChild("Radio")
			sound.SoundId = "rbxassetid://"..id
			sound.TimePosition = 0
			radio:FireAllClients(player.Character.Name, "Play")
		elseif todo == "Pause" then
			player.Passes.Radio.Value = 0
			radio:FireAllClients(player.Character.Name,"Pause")
		elseif todo == "Off" then
			if player.Settings.RadioOn.Value == 1 then
				player.Settings.RadioOn.Value = 0
			else
				player.Settings.RadioOn.Value = 1
			end
		end 
	end
end)

Aura.OnServerEvent:Connect(function(player, op)
	if op == "Off" then
		player.StatsData.IsAura.Value = 1
	else
		player.StatsData.IsAura.Value = 0
	end
end)

Chat.OnServerEvent:Connect(function(player, stat, val, op)
	local isInGroup = player:GetRoleInGroup(14398446)
	if op == "check" then
		local tags = player.Tags
		if tags.ChatTag.Value == "" or tags.ChatTag.Value == "None" then
			if isInGroup == "Owner/Developer" then
				tags.ChatTag.Value = "Owner"
			elseif isInGroup == "Co-Owner" then
				tags.ChatTag.Value = "CoOwner"
			elseif isInGroup == "Developer" then
				tags.ChatTag.Value = "Developer"
			elseif isInGroup == "Pre-Tester" then
				tags.ChatTag.Value = "PreTester"
			elseif isInGroup == "Member" then
				tags.ChatTag.Value = "Member"
			end
		end
		if tags.HeadTag.Value == "" or tags.HeadTag.Value == "None" then
			if isInGroup == "Owner/Developer" then
				tags.HeadTag.Value = "Owner"
			elseif isInGroup == "Co-Owner" then
				tags.HeadTag.Value = "CoOwner"
			elseif isInGroup == "Developer" then
				tags.HeadTag.Value = "Developer"
			elseif isInGroup == "Pre-Tester" then
				tags.HeadTag.Value = "PreTester"
			elseif isInGroup == "Member" then
				tags.HeadTag.Value = "Member"
			end
		end

	elseif op == "set" then
		if stat == "ChatTag" then
			if val == "Member" then
				if isInGroup == "Member" or isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
					player.Tags.ChatTag.Value = "Member"
				end
			elseif val == "PreTester" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
					player.Tags.ChatTag.Value = "PreTester"
				end
			elseif val == "Developer" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Developer" then
					player.Tags.ChatTag.Value = "Developer"
				end
			elseif val == "CoOwner" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" then
					player.Tags.ChatTag.Value = "CoOwner"
				end
			elseif val == "Owner" then
				if isInGroup == "Owner/Developer" then
					player.Tags.ChatTag.Value = "Owner"
				end
			elseif val == "VIP" then
				if ownsgamepass(player.UserId, 196458471) or player.Passes.VIP.Value == 1 then
					player.Tags.ChatTag.Value = "VIP"
				end
			elseif val == "Donator" then
				if player.StatsData.RobuxSpent.Value > 0 then
					player.Tags.ChatTag.Value = "Donator"
				end
			elseif val == "Sponsor" then
				if player.StatsData.RobuxSpent.Value >= 50 then
					player.Tags.ChatTag.Value = "Sponsor"
				end
			elseif val == "SuperDonator" then
				if player.StatsData.RobuxSpent.Value >= 100 then
					player.Tags.ChatTag.Value = "SuperDonator"
				end
			elseif val == "VIPDonator" then
				if player.StatsData.RobuxSpent.Value >= 250 then
					player.Tags.ChatTag.Value = "VIPDonator"
				end
			elseif val == "EliteDonator" then
				if player.StatsData.RobuxSpent.Value >= 500 then
					player.Tags.ChatTag.Value = "EliteDonator"
				end
			elseif val == "GodOfDonation" then
				if player.StatsData.RobuxSpent.Value >= 1000 then
					player.Tags.ChatTag.Value = "GodOfDonation"
				end
			elseif val == "None" then
				player.Tags.ChatTag.Value = "None"
			end
		elseif stat == "HeadTag" then
			if val == "Member" then
				if isInGroup == "Member" or isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
					player.Tags.HeadTag.Value = "Member"
				end
			elseif val == "PreTester" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
					player.Tags.HeadTag.Value = "PreTester"
				end
			elseif val == "Developer" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Developer" then
					player.Tags.HeadTag.Value = "Developer"
				end
			elseif val == "CoOwner" then
				if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" then
					player.Tags.HeadTag.Value = "CoOwner"
				end
			elseif val == "Owner" then
				if isInGroup == "Owner/Developer" then
					player.Tags.HeadTag.Value = "Owner"
				end
			elseif val == "VIP" then
				if ownsgamepass(player.UserId, 196458471) or player.Passes.VIP.Value == 1 then
					player.Tags.HeadTag.Value = "VIP"
				end
			elseif val == "Donator" then
				if player.StatsData.RobuxSpent.Value > 0 then
					player.Tags.HeadTag.Value = "Donator"
				end
			elseif val == "Sponsor" then
				if player.StatsData.RobuxSpent.Value >= 50 then
					player.Tags.HeadTag.Value = "Sponsor"
				end
			elseif val == "Super-Donator" then
				if player.StatsData.RobuxSpent.Value >= 100 then
					player.Tags.HeadTag.Value = "SuperDonator"
				end
			elseif val == "VIP-Donator" then
				if player.StatsData.RobuxSpent.Value >= 250 then
					player.Tags.HeadTag.Value = "VIPDonator"
				end
			elseif val == "Elite-Donator" then
				if player.StatsData.RobuxSpent.Value >= 500 then
					player.Tags.HeadTag.Value = "EliteDonator"
				end
			elseif val == "God Of Donation" then
				if player.StatsData.RobuxSpent.Value >= 1000 then
					player.Tags.HeadTag.Value = "GodOfDonation"
				end
			elseif val == "None" then
				player.Tags.HeadTag.Value = "None"
			end
		end
	end
end)

kill.OnServerEvent:Connect(function(player, val)
	local isInGroup = player:GetRoleInGroup(14398446)
	if val == "Member" then
		if isInGroup == "Member" or isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
			player.KillChat.KillChat.Value = "Member"
		end
	elseif val == "PreTester" then
		if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Pre-Tester" or isInGroup == "Developer" then
			player.KillChat.KillChat.Value = "PreTester"
		end
	elseif val == "Developer" then
		if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" or isInGroup == "Developer" then
			player.KillChat.KillChat.Value = "Developer"
		end
	elseif val == "CoOwner" then
		if isInGroup == "Co-Owner" or isInGroup == "Owner/Developer" then
			player.KillChat.KillChat.Value = "CoOwner"
		end
	elseif val == "Owner" then
		if isInGroup == "Owner/Developer" then
			player.KillChat.KillChat.Value = "Owner"
		end
	elseif val == "VIP" then
		if ownsgamepass(player.UserId, 196458471) or player.Passes.VIP.Value == 1 then
			player.KillChat.KillChat.Value = "VIP"
		end
	elseif val == "Donator" then
		if player.StatsData.RobuxSpent.Value > 0 then
			player.KillChat.KillChat.Value = "Donator"
		end
	elseif val == "Sponsor" then
		if player.StatsData.RobuxSpent.Value >= 50 then
			player.KillChat.KillChat.Value = "Sponsor"
		end
	elseif val == "Super-Donator" then
		if player.StatsData.RobuxSpent.Value >= 100 then
			player.KillChat.KillChat.Value = "SuperDonator"
		end
	elseif val == "VIP-Donator" then
		if player.StatsData.RobuxSpent.Value >= 250 then
			player.KillChat.KillChat.Value = "VIPDonator"
		end
	elseif val == "Elite-Donator" then
		if player.StatsData.RobuxSpent.Value >= 500 then
			player.KillChat.KillChat.Value = "EliteDonator"
		end
	elseif val == "God Of Donation" then
		if player.StatsData.RobuxSpent.Value >= 1000 then
			player.KillChat.KillChat.Value = "GodOfDonation"
		end
	elseif val == "Default" then
		player.KillChat.KillChat.Value = "Default"
	end
end)


Emotes.OnServerEvent:Connect(function(p, Dance, Slot)
	if p.Emotes:WaitForChild(Dance).Value >= 1 then
		p.Emotes:WaitForChild("Equipped"..Slot).Value = Dance
	end
end)

kick.OnServerEvent:Connect(function(player, op, playerToKick)
	if game.PrivateServerOwnerId == player.UserId or player.UserId == 1512671144 then
		if op == "Kick" then
			game.Players:FindFirstChild(playerToKick):Kick("You have been kicked by server owner")
		elseif op == "Teleport" then
			player.Character.HumanoidRootPart.CFrame = game.Workspace:FindFirstChild(playerToKick).HumanoidRootPart.CFrame * CFrame.new(0,5,0)
		end
	end
end)