local dataStoreService = game:GetService("DataStoreService")
local treasureTimeStore = dataStoreService:GetDataStore("71e43P^9%FBu")

function Format(Int)
	return string.format("%02i", Int)
end

function convertToH(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours)
end

function convertToM(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Minutes)
end

function convertToS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Seconds)
end

game:GetService("Players").PlayerAdded:Connect(function(Player)

	local foundTiming
	local foundGlobal 

	local UserId = Player.UserId

	local successData,ErrorData = pcall(function()
		foundTiming = treasureTimeStore:GetAsync(UserId)
	end)
	if successData and foundTiming ~= nil then
		local oldSeconds = os.time() - foundTiming

		local Hours = convertToH(oldSeconds)
		local Minutes = convertToM(oldSeconds)
		local Seconds = convertToS(oldSeconds)

		
		if tonumber(Hours) >= 12 then
			game:GetService("ReplicatedStorage").ServerEvents.Roulete:FireClient(Player,0,0,0,"First")
			if workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Buy") then
				workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Buy"):Destroy()
			end
			local clone = game.ReplicatedStorage.ServerEvents.FreeScript:Clone()
			clone.N.Value = Player.Name
			clone.Name = Player.Name.."Free"
			clone.Parent =  workspace.DailyRoulete.Click.ProximityPrompt
		else
			game:GetService("ReplicatedStorage").ServerEvents.Roulete:FireClient(Player,Hours,Minutes,Seconds,"Deduct")
			if workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Free") then
				workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Free"):Destroy()
			end
			local clone = game.ReplicatedStorage.ServerEvents.Buy:Clone()
			clone.N.Value = Player.Name
			clone.Name = Player.Name.."Buy"
			clone.Parent =  workspace.DailyRoulete.Click.ProximityPrompt
		end

	else
		game:GetService("ReplicatedStorage").ServerEvents.Roulete:FireClient(Player,0,0,0,"First")
		if workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Buy") then
			workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Buy"):Destroy()
		end
		local clone = game.ReplicatedStorage.ServerEvents.FreeScript:Clone()
		clone.N.Value = Player.Name
		clone.Name = Player.Name.."Free"
		clone.Parent =  workspace.DailyRoulete.Click.ProximityPrompt
	end
end)


game:GetService("ReplicatedStorage").ServerEvents.Roulete2.Event:Connect(function(Player)
	local UserId = Player.UserId
	local savedData,failedData = pcall(function()
		treasureTimeStore:SetAsync(UserId,os.time())
	end)
	if not savedData then
		warn(failedData)
	end
	game:GetService("ReplicatedStorage").ServerEvents.Roulete:FireClient(Player,12,0,0,"Deduct")
	if workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Free") then
		workspace.DailyRoulete.Click.ProximityPrompt:FindFirstChild(Player.Name.."Free"):Destroy()
		local clone = game.ReplicatedStorage.ServerEvents.Buy:Clone()
		clone.N.Value = Player.Name
		clone.Name = Player.Name.."Buy"
		clone.Parent =  workspace.DailyRoulete.Click.ProximityPrompt
	end
end)
