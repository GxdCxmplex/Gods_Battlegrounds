local c = script.Parent
local marketPlaceService = game:GetService("MarketplaceService")
local hitService = require(game.ServerStorage.Combat.HitService)
local rocks = require(game.ServerStorage.Combat.GroundRocks)
local function ownsgamepass (userid, gamepassId)
	local s,res = pcall(marketPlaceService.UserOwnsGamePassAsync, marketPlaceService, userid, gamepassId)
	if not s then
		res = false
	end
	return res
end 
local kill = false
local function Calculate(enemy, status, dmg)
	if status == "Kill" then
		local role = enemy:GetRoleInGroup(14398446)
		if ownsgamepass(enemy.UserId, 651850890) or role == "Pre-Tester" or role == "Developer" or role == "Co-Owner" or role == "Owner/Developer" or enemy.Passes.Sounds.Value == 1 and enemy.Passes.KillSoundId.Value ~= 0 then
			local sounds = enemy.Passes.KillSoundId.Value
			local sound = Instance.new("Sound", c.HumanoidRootPart)
			sound.Looped = false
			sound.SoundId = "rbxassetid://"..sounds
			sound.Playing = false
			sound:Play()
		end
		game.ReplicatedStorage.KillChat.Add:FireAllClients(enemy, game.Players:GetPlayerFromCharacter(c))
	end
end
c.Humanoid.Died:Connect(function()
	local p = game.Players:GetPlayerFromCharacter(c)
	local template = hitService.RequireDmg(p)
	if template ~= nil then
		for i,v in pairs(template) do
			if game:GetService("Players"):GetPlayerByUserId(v["UserId"]) then
				if v["Status"] == "Kill" then
					kill = true
					local ep = game:GetService("Players"):GetPlayerByUserId(v["UserId"])
					Calculate(ep, "Kill", v["Dmg"])
					game.ReplicatedStorage.KillChat.Rew:FireClient(ep, p.DisplayName, "Kill", 0, 0)
				else
					local ep = game:GetService("Players"):GetPlayerByUserId(v["UserId"])
					Calculate(ep, "Hit", v["Dmg"])
					game.ReplicatedStorage.KillChat.Rew:FireClient(ep, p.DisplayName, "Assist", 0, 0)
				end
			end
		end
		if not kill then
			game.ReplicatedStorage.KillChat.Add:FireAllClients(p, p)
			local role = p:GetRoleInGroup(14398446)
			if ownsgamepass(p.UserId, 651850890) or role == "Pre-Tester" or role == "Developer" or role == "Co-Owner" or role == "Owner/Developer" or p.Passes.Sounds.Value == 1 then
				local sounds = p.Passes.KillSoundId.Value
				local sound = Instance.new("Sound", c.HumanoidRootPart)
				sound.Looped = false
				sound.SoundId = "rbxassetid://"..sounds
				sound.Playing = false
				sound:Play()
			end
		end
	else
		game.ReplicatedStorage.KillChat.Add:FireAllClients(p, p)
		local role = p:GetRoleInGroup(14398446)
		if ownsgamepass(p.UserId, 651850890) or role == "Pre-Tester" or role == "Developer" or role == "Co-Owner" or role == "Owner/Developer" or p.Passes.Sounds.Value == 1 then
			local sounds = p.Passes.KillSoundId.Value
			local sound = Instance.new("Sound", c.HumanoidRootPart)
			sound.Looped = false
			sound.SoundId = "rbxassetid://"..sounds
			sound.Playing = false
			sound:Play()
		end
	end	
	if p.Passes.RadioId.Value ~= 0 then
		p.Passes.RadioTime.Value = math.floor(c.HumanoidRootPart.Radio.TimeLength - c.HumanoidRootPart.Radio.TimePosition)
	end
	hitService.Clear(p)
end)
