local player = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local deb = false
uis.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.R or input.KeyCode == Enum.KeyCode.ButtonL2 then
		if player.Magic.AllowDemonMode.Value == 1 and deb == false and not player.Character:FindFirstChild("Stun") and player.Character:GetAttribute("Block") == false and player.Character.Humanoid.Health > 0 then
			if player.Character:FindFirstChildOfClass("Tool") then
				player.Character.Humanoid:UnequipTools()
			end
			script.RemoteEvent:FireServer("Rage")
			deb = true
		end
	end
end)

script:WaitForChild("RemoteEvent").OnClientEvent:Connect(function(n)
	if n == "CameraAnim" then
		local hrp = player.Character.HumanoidRootPart
		local cam = workspace.CurrentCamera
		cam.CameraType = Enum.CameraType.Scriptable
		local part = Instance.new("Part")
		part.Transparency = 1
		part.Anchored = true
		part.CanCollide = false
		part.CFrame = hrp.CFrame * CFrame.new(0, 10, -34)
		part.CFrame = CFrame.lookAt(part.Position, hrp.Position)
		part.Parent = workspace.Fx
		game.Debris:AddItem(part, .7)
		game.TweenService:Create(cam, TweenInfo.new(.5, Enum.EasingStyle.Back, Enum.EasingDirection.In),{CFrame = part.CFrame}):Play()
	elseif n == "cd" then
		deb = false
		script.Disabled = true
		task.wait()
		script.Disabled = false
	end
end)