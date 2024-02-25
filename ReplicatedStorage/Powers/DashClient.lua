local uis = game:GetService("UserInputService")
local deb = false

uis.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.Q or input.KeyCode == Enum.KeyCode.ButtonB then
		local player = game.Players.LocalPlayer
		local c = player.Character
		local mouse = player:GetMouse()
		local mb 
		if uis.MouseBehavior == Enum.MouseBehavior.LockCenter then
			mb = "On"
		else
			mb = "Off"
		end
		if c.Humanoid.Health > 0 and player.Magic.CanUseSkill.Value == true and player.Magic.AllowPvp.Value == true and not c:FindFirstChild("Stun") and c:GetAttribute("Block") == false then
			local data = {C = c, Shift = mb ,w = uis:IsKeyDown(Enum.KeyCode.W), s = uis:IsKeyDown(Enum.KeyCode.S), d = uis:IsKeyDown(Enum.KeyCode.D), a = uis:IsKeyDown(Enum.KeyCode.A) }
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
			script.RemoteEvent:FireServer(data)
			task.wait(1)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
			game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
		end
	end
end)


