local rs = game:GetService("ReplicatedStorage")
local Zone = require(game.ServerScriptService.Zone)

local ShopModule = require(game.ServerScriptService.ZonesModules.Shop)
local Shop = workspace.Map.Spawn.Shop.Zone
local ShopZone = Zone.new(Shop)

local StatModule = require(game.ServerScriptService.ZonesModules.Stats)
local Stat = workspace.Map.Spawn.StatsMenu.Zone
local StatZone = Zone.new(Stat)

local MagicsModule = require(game.ServerScriptService.ZonesModules.Magics)
local Magics = workspace.Map.Spawn.Magics.Zone
local MagicsZone = Zone.new(Magics)

local CrystalsShopModule = require(game.ServerScriptService.ZonesModules.CrystalsShop)
local CrystalsShop = workspace.Map.Spawn.CrystalsShop.Zone
local CrystalsShopZone = Zone.new(CrystalsShop)

local PvpModule = require(game.ServerScriptService.ZonesModules.Pvp)
local Pvp = workspace.Map.Spawn.Pvp.Zone
local PvpZone = Zone.new(Pvp)

local SpawnModule = require(game.ServerScriptService.ZonesModules.Spawn)
local SpawnZ = workspace.Map.Spawn.SpawnHitBox
local SpawnZone = Zone.new(SpawnZ)

local ClanModule = require(game.ServerScriptService.ZonesModules.Clan)
local ClanZ = workspace.Map.Spawn.Clans.Zone
local ClanZone = Zone.new(ClanZ)



ClanZone.playerEntered:Connect(function(player)
	table.insert(ShopModule, player)
	if player.Character then
		if player.Clan.IsIn.Value == 1 then
			if player.PlayerGui.Clan.Clan.Visible == false then
			player.PlayerGui.Clan.Clan.Visible = true
			end
			else
			if player.PlayerGui.Clan.Create.Visible == false then
				player.PlayerGui.Clan.Create.Visible = true
			end
		end
	end
end)

ClanZone.playerExited:Connect(function(player)
	if player.Character then
		for _,v in pairs(player.PlayerGui.Clan:GetChildren()) do
			if v.Visible == true then
				v.Visible = false
			end
		end
	end
	local findPlayer = table.find(ShopModule, player)
	table.remove(ShopModule, findPlayer)
end)

SpawnZone.playerEntered:Connect(function(player)
	table.insert(SpawnModule, player)
	if player.Character then
		player:WaitForChild("PlayerGui"):WaitForChild("DemonMode"):WaitForChild("Frame").Visible = false
		player:WaitForChild("Magic"):WaitForChild("AllowPvp").Value = false
		player:WaitForChild("Magic"):WaitForChild("CanUseSkill").Value = false
		if player.Character:FindFirstChild("Punch") then player.Character:FindFirstChild("Punch"):Destroy() end
		if player.Character:FindFirstChild("RageCheck") then player.Character:FindFirstChild("RageCheck"):Destroy() end
		if player.Character:FindFirstChild("DashS") then player.Character:FindFirstChild("DashS"):Destroy() end
	end
end)

SpawnZone.playerExited:Connect(function(player)
	if player.Character then
		player.PlayerGui.DemonMode.Frame.Visible = true
		player.Magic.AllowPvp.Value = true
		player.Magic.CanUseSkill.Value = true
		game.ReplicatedStorage.Powers.Punch:Clone().Parent = player.Character
		if not player.PlayerGui:FindFirstChild("MobilePowers") then
			game.ReplicatedStorage.Powers.RageCheck:Clone().Parent = player.Character
			game.ReplicatedStorage.Powers.DashS:Clone().Parent = player.Character
		end
		player.Character:SetAttribute("Combo", 1)
		player.Character:SetAttribute("Invinsible", false)
		player.Character:SetAttribute("Ragdoll", false)
		player.Character:SetAttribute("Block", false)
		player.Character:SetAttribute("Jumped", false)
		player.Character:SetAttribute("Counter", false)
		player.Character:SetAttribute("OnSkill", false)
	end
	local findPlayer = table.find(SpawnModule, player)
	table.remove(SpawnModule, findPlayer)
end)

ShopZone.playerEntered:Connect(function(player)
	table.insert(ShopModule, player)
	if player.Character then
		if player.PlayerGui.Shop.Frame.Visible == false then
			player.PlayerGui.Shop.Frame.Visible = true
		end
	end
end)

ShopZone.playerExited:Connect(function(player)
	if player.Character then
		if player.PlayerGui.Shop.Frame.Visible == true then
			player.PlayerGui.Shop.Frame.Visible = false
		end
	end
	local findPlayer = table.find(ShopModule, player)
	table.remove(ShopModule, findPlayer)
end)

CrystalsShopZone.playerEntered:Connect(function(player)
	table.insert(CrystalsShopModule, player)
	if player.Character then
		if player.PlayerGui.CrystalsShop.Frame.Visible == false then
			player.PlayerGui.CrystalsShop.Frame.Visible = true
		end
	end
end)

CrystalsShopZone.playerExited:Connect(function(player)
	if player.Character then
		if player.PlayerGui.CrystalsShop.Frame.Visible == true then
			player.PlayerGui.CrystalsShop.Frame.Visible = false
		end
	end
	local findPlayer = table.find(CrystalsShopModule, player)
	table.remove(CrystalsShopModule, findPlayer)
end)

StatZone.playerEntered:Connect(function(player)
	table.insert(StatModule, player)
	if player.Character then
		if player.PlayerGui.Stats.Frame.Visible == false then
			player.PlayerGui.Stats.Frame.Visible = true
		end
	end
end)

StatZone.playerExited:Connect(function(player)
	if player.Character then
		if player.PlayerGui.Stats.Frame.Visible == true then
			player.PlayerGui.Stats.Frame.Visible = false
		end
	end
	local findPlayer = table.find(StatModule, player)
	table.remove(StatModule, findPlayer)
end)


MagicsZone.playerEntered:Connect(function(player)
	table.insert(MagicsModule, player)
	if player.Character then
		local plrGui = player.PlayerGui
		if plrGui.Magics.Bool.Value == false then
			plrGui.Magics.Bool.Value = true
			rs.Magics.MagicsShop:FireClient(player, "To")
		end
	end
end)

MagicsZone.playerExited:Connect(function(player)
	if player.Character then
		local plrGui = player.PlayerGui
		if plrGui.Magics.Bool.Value == true then
			plrGui.Magics.Bool.Value = false
			rs.Magics.MagicsShop:FireClient(player, "Back")
		end
	end
	local findPlayer = table.find(MagicsModule, player)
	table.remove(MagicsModule, findPlayer)
end)

PvpZone.playerEntered:Connect(function(player)
	table.insert(PvpModule, player)
	if player.Character then
		local plrGui = player.PlayerGui
		plrGui.Pvp.Enabled = true
		rs.Duels.Open:FireClient(player)
	end
end)

PvpZone.playerExited:Connect(function(player)
	if player.Character then
		local plrGui = player.PlayerGui
		plrGui.Pvp.Enabled = false
	end
	local findPlayer = table.find(PvpModule, player)
	table.remove(PvpModule, findPlayer)
end)