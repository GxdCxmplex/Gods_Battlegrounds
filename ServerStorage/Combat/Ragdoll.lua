local ragdoll = {}

function ragdoll.Start(character)
	if character:GetAttribute("Ragdoll") or character == nil then return end
	character:SetAttribute("Ragdoll", true)
	for i, joint in pairs(character:GetDescendants()) do
		if joint:IsA("Motor6D") then
			local socket = Instance.new("BallSocketConstraint")
			local a0 = Instance.new("Attachment")
			local a1 = Instance.new("Attachment")
			a0.Parent = joint.Part0
			a1.Parent = joint.Part1
			socket.Parent = joint.Parent
			socket.Attachment0 = a0
			socket.Attachment1 = a1
			a0.CFrame = joint.C0
			a1.CFrame = joint.C1
			socket.LimitsEnabled = true
			socket.TwistLimitsEnabled = true

			joint.Enabled = false
		end
	end

	character.Humanoid.WalkSpeed = 0
	character.Humanoid.JumpPower = 0

	character.Humanoid.PlatformStand = true

	character.Humanoid.AutoRotate = false
end

function ragdoll.Stop(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	local hum = character:FindFirstChild("Humanoid")

	hum.PlatformStand = false

	for i, joint in pairs(character:GetDescendants()) do
		if joint:IsA("BallSocketConstraint") then
			joint:Destroy()
		end

		if joint:IsA("Motor6D") then
			joint.Enabled = true
		end
	end

	character:SetAttribute("Ragdoll", false)

	hum:ChangeState(Enum.HumanoidStateType.GettingUp)

	hum.WalkSpeed = 16
	hum.JumpPower = 50

	hum.AutoRotate = true
end

return ragdoll
