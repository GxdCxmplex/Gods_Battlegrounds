local marketPlaceService = game:GetService("MarketplaceService")
local dataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local serverMessage = game:GetService("ReplicatedStorage").ServerMessages.DonateMessage

local purchHistory = dataStoreService:GetDataStore("PurchaseHistory")

local productFunctions = {}

local marketPlaceService = game:GetService("MarketplaceService")

local function ownsgamepass (userid, gamepassId)
	local s,res = pcall(marketPlaceService.UserOwnsGamePassAsync, marketPlaceService, userid, gamepassId)
	if not s then
		res = false
	end
	return res
end

-- roulete
productFunctions[1695467571] = function(receipt, player)
	player.StatsData.RobuxSpent.Value += 49
	game.ReplicatedStorage.ServerEvents.Bought:Fire(player)
	return true
end

--clan
productFunctions[1713550287] = function(receipt, player)
	player.StatsData.RobuxSpent.Value += 59
	game.ReplicatedStorage.Clan.Promt:Fire(player)
	return true
end

--Crystals
productFunctions[1711735517] = function(receipt, player)
	local stat = player.StatsData:FindFirstChild("Crystals")
	if stat then
		local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 2000 * CrystalsBoost
		else
			stat.Value += 1000 * CrystalsBoost
		end
		player.StatsData.RobuxSpent.Value += 59
		return true
	end
end

productFunctions[1711738465] = function(receipt, player)
		local stat = player.StatsData:FindFirstChild("Crystals")
		if stat then
			local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 5000 * CrystalsBoost
		else
			stat.Value += 2500 * CrystalsBoost
		end
			player.StatsData.RobuxSpent.Value += 99
			return true
		end
end

productFunctions[1711739243] = function(receipt, player)
	local stat = player.StatsData:FindFirstChild("Crystals")
	if stat then
		local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 10000 * CrystalsBoost
		else
			stat.Value += 5000 * CrystalsBoost
		end
		player.StatsData.RobuxSpent.Value += 199
		return true
	end
end

productFunctions[1711740401] = function(receipt, player)
	local stat = player.StatsData:FindFirstChild("Crystals")
	if stat then
		local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 20000 * CrystalsBoost
		else
			stat.Value += 10000 * CrystalsBoost
		end
		player.StatsData.RobuxSpent.Value += 399
		return true
	end
end

productFunctions[1711741813] = function(receipt, player)
	local stat = player.StatsData:FindFirstChild("Crystals")
	if stat then
		local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 50000 * CrystalsBoost
		else
			stat.Value += 25000 * CrystalsBoost
		end
		player.StatsData.RobuxSpent.Value += 699
		return true
	end
end

productFunctions[1711742511] = function(receipt, player)
	local stat = player.StatsData:FindFirstChild("Crystals")
	if stat then
		local CrystalsBoost = player.Boosts.CrystalsBoostMult.Value
		if ownsgamepass(player.UserId, 642275171) or player.Passes.Crystals.Value == 1 then
			stat.Value += 100000 * CrystalsBoost
		else
			stat.Value += 50000 * CrystalsBoost
		end
		player.StatsData.RobuxSpent.Value += 999
		return true
	end
end


-- boosts
productFunctions[1711747681] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("ExpBoost")
	if boost then
		boost.Value += 900
		player.StatsData.RobuxSpent.Value += 99
		return true
	end
end

productFunctions[1711748212] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("ExpBoost")
	if boost then
		boost.Value += 3600
		player.StatsData.RobuxSpent.Value += 299
		return true
	end
end

productFunctions[1711748308] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("ExpBoost")
	if boost then
		boost.Value += 21600
		player.StatsData.RobuxSpent.Value += 599
		return true
	end
end

productFunctions[1711744288] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("CrystalsBoost")
	if boost then
		boost.Value += 900
		player.StatsData.RobuxSpent.Value += 99
		return true
	end
end

productFunctions[1711746706] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("CrystalsBoost")
	if boost then
		boost.Value += 3600
		player.StatsData.RobuxSpent.Value += 299
		return true
	end
end

productFunctions[1711747316] = function(receipt, player)
	local boost = player.Boosts:FindFirstChild("CrystalsBoost")
	if boost then
		boost.Value += 21600
		player.StatsData.RobuxSpent.Value += 599
		return true
	end
end

-- donation

productFunctions[1694802281] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 2
		serverMessage:FireAllClients(player, player.Name.." has donated 2 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694802536] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 5
		serverMessage:FireAllClients(player, player.Name.." has donated 5 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694802810] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 10
		serverMessage:FireAllClients(player, player.Name.." has donated 10 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694805676] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 25
		serverMessage:FireAllClients(player, player.Name.." has donated 25 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694806362] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 50
		serverMessage:FireAllClients(player, player.Name.." has donated 50 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694808641] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 75
		serverMessage:FireAllClients(player, player.Name.." has donated 75 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694810772] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 100
		serverMessage:FireAllClients(player, player.Name.." has donated 100 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694810248] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 250
		serverMessage:FireAllClients(player, player.Name.." has donated 250 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694811194] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 300
		serverMessage:FireAllClients(player, player.Name.." has donated 300 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694811560] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 500
		serverMessage:FireAllClients(player, player.Name.." has donated 500 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694811930] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 750
		serverMessage:FireAllClients(player, player.Name.." has donated 750 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694812599] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 1000
		serverMessage:FireAllClients(player, player.Name.." has donated 1000 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694815271] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 1500
		serverMessage:FireAllClients(player, player.Name.." has donated 1500 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694817603] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 2000
		serverMessage:FireAllClients(player, player.Name.." has donated 2000 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694818140] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 2500
		serverMessage:FireAllClients(player, player.Name.." has donated 2500 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694818586] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 5000
		serverMessage:FireAllClients(player, player.Name.." has donated 5000 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694818922] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 7500
		serverMessage:FireAllClients(player, player.Name.." has donated 7500 robux. Thanks for support ❤️", "Green")
		return true
	end
end

productFunctions[1694819551] = function(receipt, player)
	local RobuxSpent = player.StatsData:FindFirstChild("RobuxSpent")
	if RobuxSpent then
		player.StatsData.RobuxSpent.Value += 10000
		serverMessage:FireAllClients(player, player.Name.." has donated 10000 robux. Thanks for support ❤️", "Green")
		return true
	end
end
local dss = game:GetService("DataStoreService")
local giftedData = dss:GetDataStore("g5-M78v(Zu`T")
local re = game.ReplicatedStorage:WaitForChild("GiftGamepass"):WaitForChild("GiftRE")
local gamepasses = require(game.ReplicatedStorage.GiftGamepass:WaitForChild("GiftableGamepasses"))
local playersGifted = {}

re.OnServerEvent:Connect(function(plr, pass, userId)
	if not game.Players:GetNameFromUserIdAsync(userId) then return end

	for i, gamepass in pairs(gamepasses) do
		if gamepass[1] == pass[1] and gamepass[2] == pass[2] then

			if plr.UserId ~= userId then
				local owns = false

				local gamepassId = pass[1]
				local productId = pass[2]

				if marketPlaceService:UserOwnsGamePassAsync(userId, gamepassId) then
					owns = true

				else
					local data = giftedData:GetAsync(userId .. "-" .. pass[1])
					if data then 
						owns = true 
					end
				end
				if not owns then
					playersGifted[plr.UserId] = {plr.Name, pass, userId}
					marketPlaceService:PromptProductPurchase(plr, pass[2])
				end
			end
		end
	end
end)

local http = game:GetService("HttpService")
local link = 'https://discord.com/api/webhooks/1192864713047023666/nmNaLNrfyc_az0tK3OITj-JimKYxEbEuEdX2RQClbE4EynEAyj34x2faVHjzbx-W1nbR'

local function processReceipt(receiptInfo)
	if receiptInfo.ProductId ~= 1682516053 and receiptInfo.ProductId ~= 1682516775 and receiptInfo.ProductId ~= 1682516188 then
		local playerProductKey = receiptInfo.PlayerId .. "_".. receiptInfo.PurchaseId
		local purchased = false
		local success , errorMasage = pcall(function()
			purchased = purchHistory:GetAsync(playerProductKey)
		end)

		if success and purchased then
			return Enum.ProductPurchaseDecision.PurchaseGranted
		elseif not success then
			error("Data store error".. errorMasage)
		end

		local player = Players:GetPlayerByUserId(receiptInfo.PlayerId)
		if not player then
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end

		local handler = productFunctions[receiptInfo.ProductId]

		local success, result = pcall(handler, receiptInfo , player)
		if not success or not result then
			warn("Error occurred while processing a product purchase")
			print("\nProductId:", receiptInfo.ProductId)
			print("\nPlayer:", player)
			return Enum.ProductPurchaseDecision.NotProcessedYet
		end

		local succes , errorMasage = pcall(function()
			purchased = purchHistory:SetAsync(playerProductKey, true)
		end)
		if not succes then
			error("Cannot save Purchase Data" .. errorMasage)
		end
		local Data = {
			["content"] = player.Name.." bought "..marketPlaceService:GetProductInfo(receiptInfo.ProductId, Enum.InfoType.Product).Name.." worth "..marketPlaceService:GetProductInfo(receiptInfo.ProductId, Enum.InfoType.Product).PriceInRobux.." Robux"
		}
		Data = http:JSONEncode(Data)
		http:PostAsync("https://discord.com/api/webhooks/1192864713047023666/nmNaLNrfyc_az0tK3OITj-JimKYxEbEuEdX2RQClbE4EynEAyj34x2faVHjzbx-W1nbR", Data)
		return Enum.ProductPurchaseDecision.PurchaseGranted
	else
		local plrId = receiptInfo.PlayerId
		local purchasedId = receiptInfo.ProductId
		for i, pass in pairs(gamepasses) do

			local passId = pass[1]
			local productId = pass[2]
			local price = pass[3]

			if purchasedId == productId then
				local giftUserId = playersGifted[plrId][3]

				if giftUserId then
					local success, err = pcall(function()
						giftedData:SetAsync(giftUserId .. "-" .. passId, true)
					end)

					if success then
						print("succ33d")
						local giftName = game.Players:GetPlayerByUserId(playersGifted[plrId][3])
						game.ReplicatedStorage.ServerMessages.GiftMessage:FireAllClients(playersGifted[plrId][1], playersGifted[plrId][1].." gifted "..playersGifted[plrId][2].." to "..giftName)
						playersGifted[plrId][1].StatsData.RobuxSpent.Value += price
						playersGifted[plrId] = nil
						return Enum.ProductPurchaseDecision.PurchaseGranted
					else
						print("err")
						return Enum.ProductPurchaseDecision.NotProcessedYet
					end

				else
					return Enum.ProductPurchaseDecision.NotProcessedYet
				end
			end
		end
	end
end

marketPlaceService.ProcessReceipt = processReceipt