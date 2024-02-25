local uis = game:GetService("UserInputService")
local rs = game:GetService("ReplicatedStorage")
local event = rs.Auras.Turn
local block = script:WaitForChild("Block")
local WaterEvent = rs.Auras.Water.Lvl
local c = script.Parent
coroutine.wrap(function()
	while wait(1) do
		local player = game.Players.LocalPlayer
		local IsAura = player.StatsData.IsAura
		local char = script.Parent
		if IsAura.Value == 0 then
			if player.Character then
				if player.leaderstats.Magic.Value ~= "None" then
					if player.leaderstats.Magic.Value == "Water" then
						if not char.UpperTorso:FindFirstChild("Back") then
							WaterEvent:FireServer(char)
						end
					end
				end

			end 
		end
	end	
end)()

local deb = false
local BlockinUse = false

uis.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	local player = game.Players.LocalPlayer
	local IsAura = player:WaitForChild("StatsData"):WaitForChild("IsAura")
	if input.KeyCode == Enum.KeyCode.B or input.KeyCode == Enum.KeyCode.DPadUp then
		if deb == false then
			deb = true
			if IsAura.Value == 0 then
				event:FireServer("Off")
			else
				if player.leaderstats.Magic.Value == "Water" then
					rs.Auras.Water.Lvl:FireServer(player.Character)
				end
				event:FireServer("On")
			end
			task.wait(.5)
			deb = false
		end
	end
	if input.KeyCode == Enum.KeyCode.F and not c:FindFirstChild("Stun") and c:GetAttribute("Block") == false and game.Players.LocalPlayer.Magic.CanUseSkill.Value == true and c.Humanoid.Health > 0 then
		BlockinUse = true
		block:FireServer("Block")
	end
	if input.KeyCode == Enum.KeyCode.ButtonL3 then
		if not c:FindFirstChild("Stun") and not c:FindFirstChild("SprintTag") and c.Humanoid.WalkSpeed == 16 and c:GetAttribute("Block") == false then
			script.Sprint:FireServer(25)
		elseif (not c:FindFirstChild("Stun") and c:FindFirstChild("SprintTag") and c.Humanoid.WalkSpeed ~= 16) or c:GetAttribute("Block") == true then
			script.Sprint:FireServer(16)
		end
	elseif input.KeyCode == Enum.KeyCode.LeftShift and not c:FindFirstChild("Stun") and not c:FindFirstChild("SprintTag") then
		script.Sprint:FireServer(25)
	end
end)

uis.InputEnded:Connect(function(input, gpe)
	print(input.KeyCode)
	local state = uis:GetGamepadState(Enum.UserInputType.Gamepad1)
	if ((input.KeyCode == Enum.KeyCode.F or input.KeyCode == Enum.KeyCode.ButtonX) and (BlockinUse or game.Players.LocalPlayer.Character:GetAttribute("Block"))) then
		block:FireServer("Stop")
		BlockinUse = false
	end
	if input.KeyCode == Enum.KeyCode.LeftShift and not c:FindFirstChild("Stun") and c:FindFirstChild("SprintTag") and c.Humanoid.WalkSpeed ~= 16 then
		script.Sprint:FireServer(16)
	end
end)

local FloatRocks = require(game.ReplicatedStorage.Powers.WaterPowers.Tornado.FloatRocks)

game.ReplicatedStorage.Powers.WaterPowers.Tornado.Forrocks.OnClientEvent:Connect(function(hrp)
	local RockCache =  FloatRocks.Create({
		CenterCFrame = CFrame.new(hrp.Position),
		InnerRadius = 5,
		OuterRadius = 45,
		Amount = 100,
		Size = {Min = .5, Max = 3.5},
		Fx = true,
		T = 15
	})
	RockCache.Rise({
		Velocity = {Min = 2, Max = 15},
		FloatTime = 1.5
	})
	task.wait(1.5)
	RockCache.Orbit({
		Duration = 25,
		OrbitTime = 2
	})
end)