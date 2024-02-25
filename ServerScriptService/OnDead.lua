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
local function Calculate(enemy, status, dmg, p)
	
	if status == "Kill" then
		enemy.leaderstats.Killstreak.Value += 1
		local role = enemy:GetRoleInGroup(14398446)
		if ownsgamepass(enemy.UserId, 651850890) or role == "Pre-Tester" or role == "Developer" or role == "Co-Owner" or role == "Owner/Developer" or enemy.Passes.Sounds.Value == 1 and enemy.Passes.KillSoundId.Value ~= 0 then
			local sounds = enemy.Passes.KillSoundId.Value
			local sound = Instance.new("Sound", c.HumanoidRootPart)
			sound.Looped = false
			sound.SoundId = "rbxassetid://"..sounds
			sound.Playing = false
			sound:Play()
		end
		local vipBoost = 1
		local cBoost = 1
		local kill2x = 1
		local clanBoost = enemy.Clan.ClanBoost.Value
		local premBoost = enemy.Boosts.PremBoost.Value
		if ownsgamepass(enemy.UserId, 196457107) or enemy.Passes.Kills.Value == 1 then
			kill2x = 2
		end
		if ownsgamepass(enemy.UserId, 196457356) or enemy.Passes.Crystals.Value == 1 then
			cBoost = 2
		end
		if ownsgamepass(enemy.UserId,196458471) or enemy.Passes.VIP.Value == 1 then
			vipBoost = 1.5
		end
		local eExpBoost = enemy.Boosts.ExpBoostMult.Value
		enemy.StatsData.Exp.Value += 25 * vipBoost * kill2x * premBoost * eExpBoost
		enemy.StatsData.Crystals.Value += 10 * enemy.Boosts.CrystalsBoostMult.Value * cBoost * kill2x * premBoost * clanBoost
		enemy.StatsData.TotalKills.Value += 1
		game.ReplicatedStorage.KillChat.Add:FireAllClients(enemy, game.Players:GetPlayerFromCharacter(c))
		game.ReplicatedStorage.KillChat.Rew:FireClient(enemy, p.DisplayName, "Kill", 25 * vipBoost * kill2x * premBoost * eExpBoost, 10 * enemy.Boosts.CrystalsBoostMult.Value * cBoost * kill2x * premBoost * clanBoost)
	elseif status == "Hit" then
		local vipBoost = 1
		local cBoost = 1
		local kill2x = 1
		local clanBoost = enemy.Clan.ClanBoost.Value
		local premBoost = enemy.Boosts.PremBoost.Value
		if ownsgamepass(enemy.UserId, 196457107) or enemy.Passes.Kills.Value == 1 then
			kill2x = 2
		end
		if ownsgamepass(enemy.UserId, 196457356) or enemy.Passes.Crystals.Value == 1 then
			cBoost = 2
		end
		if ownsgamepass(enemy.UserId,196458471) or enemy.Passes.VIP.Value == 1 then
			vipBoost = 1.5
		end
		local eExpBoost = enemy.Boosts.ExpBoostMult.Value
		enemy.StatsData.Exp.Value += 15 * vipBoost * kill2x * premBoost * eExpBoost * (dmg / 100)
		enemy.StatsData.Crystals.Value += 5 * enemy.Boosts.CrystalsBoostMult.Value * cBoost * kill2x * premBoost * clanBoost * (dmg / 100)
		game.ReplicatedStorage.KillChat.Rew:FireClient(enemy, p.DisplayName, "Assist", 15 * vipBoost * kill2x * premBoost * eExpBoost * (dmg / 100), 5 * enemy.Boosts.CrystalsBoostMult.Value * cBoost * kill2x * premBoost * clanBoost * (dmg / 100))
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
					Calculate(ep, "Kill", v["Dmg"], p)
				else
					local ep = game:GetService("Players"):GetPlayerByUserId(v["UserId"])
					Calculate(ep, "Hit", v["Dmg"], p)
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
		p.StatsData.TotalDeaths.Value += 1
		p.leaderstats.Killstreak.Value = 0	
		p.Magic.AllowPvp.Value = true
		p.Magic.CanUseSkill.Value = true
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