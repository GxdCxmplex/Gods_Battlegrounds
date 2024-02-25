--Variables
local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Cases").RemoteEvents
local Emotes = rs:WaitForChild("Cases").EmotesFolder.Rarities
local Auras = rs:WaitForChild("Cases").AurasFolder.Rarities
local crates = rs:WaitForChild("Cases")
local message = rs:WaitForChild("Cases"):WaitForChild("RemoteEvents"):WaitForChild("ServerMessage")

local rnd = Random.new()

local playersUnboxing = {}
local AurasUnboxing = {}
local unboxTime = 1

--Unboxing a crate
remotes:WaitForChild("BuyCrate").OnServerEvent:Connect(function(plr, crateName)
	
	local plrCash = plr.StatsData.Crystals
	
	if crates:FindFirstChild(crateName) and not playersUnboxing[plr] then
		local crateProperties = require(crates[crateName])
		if crateName == "Emotes" then

			if plrCash.Value >= crateProperties["Price"] then
				plrCash.Value -= crateProperties["Price"]

				local chances = crateProperties["Chances"]
				local plrChance = rnd:NextNumber() * 100

				local n = 0
				local rarityChosen = nil

				for rarity, chance in pairs(chances) do	
					n += chance
					if plrChance <= n then
						rarityChosen = rarity
						break
					end
				end

				local unboxableItems = crateProperties["Items"]

				for i = #unboxableItems, 2, -1 do
					local j = rnd:NextInteger(1, i)
					unboxableItems[i], unboxableItems[j] = unboxableItems[j], unboxableItems[i]
				end

				local itemChosen = nil

				for _, itemName in pairs(unboxableItems) do
					if Emotes:FindFirstChild(itemName, true).Rarity.Value == rarityChosen then
						itemChosen = Emotes:FindFirstChild(itemName, true)
						break
					end
				end
				playersUnboxing[plr] = itemChosen.Name
				print(rarityChosen, itemChosen)
				if rarityChosen == "Legendary" then
					message:FireAllClients(plr.Name.." has got Legendary "..itemChosen.Name.." from "..crateName.." create", "Leg")
				elseif rarityChosen == "Epic" then
					message:FireAllClients(plr.Name.." has got Epic "..itemChosen.Name.." from "..crateName.." create", "Ep")
				end
				remotes:WaitForChild("CrateOpened"):FireClient(plr, crateName, itemChosen, itemChosen.Name, unboxTime, rarityChosen)

				local timeStarted = tick()
				while true do
					if (tick() - timeStarted >= unboxTime) or (not plr.Character) then
						break
					end
					game:GetService("RunService").Heartbeat:Wait()
				end
				playersUnboxing[plr] = nil
				plr.Emotes:WaitForChild(itemChosen.Name).Value += 1
				
			end
		elseif crateName == "Auras" then
			
			if plrCash.Value >= crateProperties["Price"] then
				plrCash.Value -= crateProperties["Price"]

				local chances = crateProperties["Chances"]
				local plrChance = rnd:NextNumber() * 100

				local n = 0
				local rarityChosen = nil

				for rarity, chance in pairs(chances) do	
					n += chance
					if plrChance <= n then
						rarityChosen = rarity
						break
					end
				end

				local unboxableItems = crateProperties["Items"]

				for i = #unboxableItems, 2, -1 do
					local j = rnd:NextInteger(1, i)
					unboxableItems[i], unboxableItems[j] = unboxableItems[j], unboxableItems[i]
				end

				local itemChosen = nil

				for _, itemName in pairs(unboxableItems) do
					if Auras:FindFirstChild(itemName, true).Value == rarityChosen then
						itemChosen = Auras:FindFirstChild(itemName, true)
						break
					end
				end
				print(rarityChosen, itemChosen)
				AurasUnboxing[plr] = itemChosen.Name
				if rarityChosen == "Legendary" then
					message:FireAllClients(plr.Name.." has got Legendary "..itemChosen.Name.." from "..crateName.." create")
				end
				remotes:WaitForChild("CrateOpened"):FireClient(plr, crateName, itemChosen, itemChosen.Name, unboxTime, rarityChosen)

				local timeStarted = tick()
				while true do
					if (tick() - timeStarted >= unboxTime) or (not plr.Character) then
						break
					end
					game:GetService("RunService").Heartbeat:Wait()
				end

				AurasUnboxing[plr] = nil
				plr.Auras:WaitForChild(itemChosen.Name).Value += 1
				
			end
		
		end
		
	end
end)