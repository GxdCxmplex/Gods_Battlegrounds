if not game:GetService("UserInputService").TouchEnabled then
	script.Parent:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController"):WaitForChild("BoundKeys").Value = "LeftControl,DPadDown"
end
local sg = game:GetService("StarterGui")
sg:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
local marketPlaceService = game:GetService("MarketplaceService")
local function ownsgamepass (userid, gamepassId)
	local s,res = pcall(marketPlaceService.UserOwnsGamePassAsync, marketPlaceService, userid, gamepassId)
	if not s then
		res = false
	end
	return res
end
local rs = game:GetService("ReplicatedStorage")
local event = rs.Tags.ChatTags.Equip
local folder = rs.Tags.ChatTags
local folder2 = rs.Tags.HeadTags
repeat wait() until game.Players.LocalPlayer:WaitForChild("StatsData")
while wait(1) do
	local player = game.Players.LocalPlayer
	local robux = player.StatsData.RobuxSpent.Value
	local chat = player.Tags.ChatTag.Value
	local head = player.Tags.HeadTag.Value
	local plrGui = player.PlayerGui:WaitForChild("Stats", 10).Frame.Frame.MoveFrane.Tags.ChatTags
	local plrGui2 = player.PlayerGui.Stats.Frame.Frame.MoveFrane.Tags.HeadTags
	local isInGroup = player:GetRoleInGroup(14398446)
	if player.StatsData.TimePlayed.Value < 60 or player.Tags.ChatTag.Value == "" then
		event:FireServer("check")
	end
	local CrystalBoost = player.Boosts.CrystalsBoost.Value
	local CrystalMult = player.Boosts.CrystalsBoostMult.Value

	local Exp = player.Boosts.ExpBoost.Value
	local ExpMult = player.Boosts.ExpBoostMult.Value

	if CrystalBoost ~= 0 then
		event:FireServer("CrystalBoost")
	elseif CrystalBoost == 0 and CrystalMult == 3 then
		event:FireServer("CrystalBoost")
	end

	if Exp ~= 0 then
		event:FireServer("Exp")
	elseif Exp == 0 and ExpMult == 2 then
		event:FireServer("Exp")
	end
	if isInGroup == "Owner/Developer" then
		for i,v in pairs(folder.GroupTags:GetChildren()) do
			if v:IsA("Frame") and not plrGui:FindFirstChild(v.Name)then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.GroupTags:GetChildren()) do
			if v:IsA("Frame") and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	elseif isInGroup == "Co-Owner" then
		for i,v in pairs(folder.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and not plrGui:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	elseif isInGroup == "Developer" then
		for i,v in pairs(folder.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and v.Name ~= "Co-Owner" and not plrGui:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and v.Name ~= "Co-Owner" and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	elseif isInGroup == "Pre-Tester" then
		for i,v in pairs(folder.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and v.Name ~= "Co-Owner" and v.Name ~= "Developer" and not plrGui:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.GroupTags:GetChildren()) do
			if v:IsA("Frame") and v.Name ~= "Owner/Developer" and v.Name ~= "Co-Owner"  and v.Name ~= "Developer" and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end

	elseif isInGroup == "Member" then
		if not plrGui:FindFirstChild("Member") and not plrGui2:FindFirstChild("Member") then
			local clone = folder.GroupTags.Member:Clone()
			clone.Parent = plrGui
			local clone2 = folder2.GroupTags.Member:Clone()
			clone2.Parent = plrGui2
		end

	end

	if ownsgamepass(player.UserId, 196458471) or player.Passes.VIP.Value == 1 then
		if not plrGui:FindFirstChild("VIP") and not plrGui2:FindFirstChild("VIP") then
			local clone1 = folder.VIP:Clone()
			clone1.Parent = plrGui

			local clone2 = folder2.VIP:Clone()
			clone2.Parent = plrGui2
		end
	end

	if robux >0 and robux < 50 then
		if not plrGui:FindFirstChild("RobuxTier1") and not plrGui2:FindFirstChild("RobuxTier1") then
			local clone1 = folder.Donate.RobuxTier1:Clone()
			clone1.Parent = plrGui
			local clone2 = folder2.Donate.RobuxTier1:Clone()
			clone2.Parent = plrGui2
		end


	elseif robux >= 50 and robux < 100 then
		if not plrGui:FindFirstChild("RobuxTier1") and not plrGui2:FindFirstChild("RobuxTier1") then
			local cloneC = folder.Donate.RobuxTier1:Clone()
			cloneC.Parent = plrGui
			local cloneH = folder2.Donate.RobuxTier1:Clone()
			cloneH.Parent = plrGui2
		end
		if not plrGui:FindFirstChild("RobuxTier2") and not plrGui2:FindFirstChild("RobuxTier2") then
			local cloneC2 = folder.Donate.RobuxTier2:Clone()
			cloneC2.Parent = plrGui
			local cloneH2 = folder2.Donate.RobuxTier2:Clone()
			cloneH2.Parent = plrGui2
		end

	elseif robux >= 100 and robux < 250 then
		if not plrGui:FindFirstChild("RobuxTier1") and not plrGui2:FindFirstChild("RobuxTier1") then
			local cloneC = folder.Donate.RobuxTier1:Clone()
			cloneC.Parent = plrGui
			local cloneH = folder2.Donate.RobuxTier1:Clone()
			cloneH.Parent = plrGui2
		end
		if not plrGui:FindFirstChild("RobuxTier2") and not plrGui2:FindFirstChild("RobuxTier2") then
			local cloneC2 = folder.Donate.RobuxTier2:Clone()
			cloneC2.Parent = plrGui
			local cloneH2 = folder2.Donate.RobuxTier2:Clone()
			cloneH2.Parent = plrGui2
		end
		if not plrGui:FindFirstChild("RobuxTier3") and not plrGui2:FindFirstChild("RobuxTier3") then
			local cloneC3 = folder.Donate.RobuxTier3:Clone()
			cloneC3.Parent = plrGui
			local cloneH3 = folder2.Donate.RobuxTier3:Clone()
			cloneH3.Parent = plrGui2
		end
	elseif robux >= 250 and robux < 500 then
		for i,v in pairs(folder.Donate:GetChildren()) do
			if v.Name ~= "RobuxTier5" and v.Name ~= "RobuxTier6"  and not plrGui:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.Donate:GetChildren()) do
			if v.Name ~= "RobuxTier5" and v.Name ~= "RobuxTier6"  and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	elseif robux >= 500 and robux < 1000 then
		for i,v in pairs(folder.Donate:GetChildren()) do
			if v.Name ~= "RobuxTier6" and not plrGui:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.Donate:GetChildren()) do
			if v.Name ~= "RobuxTier6" and not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	elseif robux >= 1000 then
		for i,v in pairs(folder.Donate:GetChildren()) do
			if not plrGui:FindFirstChild(v.Name)  then
				local clone = v:Clone()
				clone.Parent = plrGui
			end
		end
		for i,v in pairs(folder2.Donate:GetChildren()) do
			if not plrGui2:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = plrGui2
			end
		end
	end
end
