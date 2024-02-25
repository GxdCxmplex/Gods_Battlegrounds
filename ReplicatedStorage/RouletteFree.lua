local isSpinning = false
local tweenService = game:GetService("TweenService")

local rewards = {ExpBoost = "ExpBoost", CrystalsTier1 = "CrystalsTier1", CrystalsBoost = "CrystalsBoost", CrystalsTier2 = "CrystalsTier2", CrystalsTier3 = "CrystalsTier3"}

local abbrev = {"", "K", "M", "B", "T", "Qa", "Qi", "Sx", "Sp", "Oc", "No"}
local function Format (value, idp)
	local ex = math.floor(math.log(math.max(1, math.abs(value)), 1000))
	local abbrevs = abbrev [1 + ex] or ("e+".. ex)
	local normal = math.floor(value * ((10 ^ idp) / (1000 ^ ex))) / (10 ^ idp)

	return ("%."..idp.."f%s"):format(normal, abbrevs)
end

local marketPlaceService = game:GetService("MarketplaceService")
local function ownsgamepass (userid, gamepassId)
	local s,res = pcall(marketPlaceService.UserOwnsGamePassAsync, marketPlaceService, userid, gamepassId)
	if not s then
		res = false
	end
	return res
end
local debris = game:GetService("Debris")
script.Parent.Triggered:Connect(function(player)
	if player.Name ~= script.N.Value or script.Parent.Busy.Value == true then return end
	if isSpinning then return end
	isSpinning = true

	local rew
	local rewardIndex = math.random(1, 5)

	local angle = rewardIndex / 5 * 360 - (360 / 5 / 2)
	local offset = -math.random() * 360 / 5
	local spins = math.random(0, 10) * 360
	angle += offset + spins

	local spinTime = math.random(5, 10)
	local tweenInfo = TweenInfo.new(spinTime, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
	local tween = tweenService:Create(script.Parent.Parent.Parent.SpinPart, tweenInfo, {Orientation = script.Parent.Parent.Parent.SpinPart.Orientation +  Vector3.new(angle, 0, 0)})
	tween:Play()

	tween.Completed:Wait()
	if rewardIndex == 4 then
		rew = "CrystalsTier3"
	elseif rewardIndex == 1 then
		rew = "CrystalsTier1"
	elseif rewardIndex == 2 then
		rew = "CrystalsBoost"
	elseif rewardIndex == 5 then
		rew = "ExpBoost"	
	elseif rewardIndex == 3 then
		rew = "CrystalsTier2"	
	end
	if rew == "CrystalsTier1" then
		if ownsgamepass(player.UserId, 642275171) then
			player.StatsData.Crystals.Value += 500
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 500)
		else
			player.StatsData.Crystals.Value += 250
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 250)
		end

	elseif rew == "CrystalsTier2" then
		if ownsgamepass(player.UserId, 642275171) then
			player.StatsData.Crystals.Value += 1000
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 1000)
		else
			player.StatsData.Crystals.Value += 500
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 500)
		end

	elseif rew == "CrystalsTier3" then
		if ownsgamepass(player.UserId, 642275171) then
			player.StatsData.Crystals.Value += 1500
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 1500)
		else
			player.StatsData.Crystals.Value += 750
			game.ReplicatedStorage.KillChat.Rew:FireClient(player, "Daily Roulete", "Collect", 0, 750)
		end
	elseif rew == "CrystalsBoost" then
		player.Boosts.CrystalsBoost.Value += 900
		player.PlayerGui.Magics.SpinReward.Text = "You won 15m of 3x crystals boost"
		player.PlayerGui.Magics.SpinReward.Visible = true
		wait(1)
		player.PlayerGui.Magics.SpinReward.Visible = false
	elseif rew == "HpBoost" then
		player.Boosts.ExpBoost.Value += 900
		player.PlayerGui.Magics.SpinReward.Text = "You won 15m of 2x exp boost"
		player.PlayerGui.Magics.SpinReward.Visible = true
		wait(1)
		player.PlayerGui.Magics.SpinReward.Visible = false
	end
	isSpinning = false
	script.Parent.Busy.Value = false
	game.ReplicatedStorage.ServerEvents.Roulete2:Fire(player)
end)