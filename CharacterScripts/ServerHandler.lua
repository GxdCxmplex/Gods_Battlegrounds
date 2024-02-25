repeat task.wait() until game:GetService("Players"):GetPlayerFromCharacter(script.Parent):FindFirstChild("StatsData")
local overheadGUIs = game.ServerStorage:WaitForChild("OverheadGUIs")
local classesGUI = overheadGUIs:WaitForChild("ClassesOverHead")
local character = script.Parent
character.Humanoid.DisplayDistanceType = "None"

local head = character:WaitForChild("Head")
local player = game.Players:GetPlayerFromCharacter(character)
local currentTag = player:WaitForChild("Tags"):WaitForChild("HeadTag")
local cuurentName = player.DisplayName
local currentMagic = player:WaitForChild("leaderstats"):WaitForChild("Magic")
script.Parent:WaitForChild("Humanoid").BreakJointsOnDeath = false
script.Parent:WaitForChild("Humanoid").MaxHealth = 150
script.Parent:WaitForChild("Humanoid").Health = 150

local sound = Instance.new("Sound", script.Parent.HumanoidRootPart)
sound.Name = "Radio"
sound.Looped = true
if player.Passes.RadioId.Value ~= 0 then
	sound.SoundId = "rbxassetid://"..player.Passes.RadioId.Value
	sound.TimePosition = player.Passes.RadioTime.Value
	sound.Volume = .25
	if sound.SoundId ~= "rbxassetid://0" and player.Passes.Radio.Value == 1 then
		game.ReplicatedStorage.Stuff.Radio:FireAllClients(script.Parent.Name,"Play")
	end
end


local HeadText = {
	VIP = "VIP👑",
	Donator = "Donator",
	Sponsor = "Sponsor🏷",
	SuperDonator = "Super-Donator💵",
	VIPDonator = "VIP-Donator💸",
	EliteDonator = "Elite-Donator💰",
	GodOfDonation = "God Of Donation💎",
	Owner = "Owner👑/Developer🛠️",
	CoOwner = "Co-Owner👑",
	Developer = "Developer🛠️",
	PreTester = "Pre-Tester🎮",
	Member = "Member",
	None = ""
}
local magicColors = {
	None = Color3.fromRGB(255,255,255),
	Water = Color3.fromRGB(8, 198, 244)
}

local HeadColor = {
	VIP = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(252, 194, 1)),ColorSequenceKeypoint.new(.5, Color3.fromRGB(245, 220, 184)) ,ColorSequenceKeypoint.new(1,Color3.fromRGB(252, 194, 1))}),
	Donator = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	Sponsor = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	SuperDonator = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	VIPDonator = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	GodOfDonation = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	EliteDonator = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(7, 176, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(7, 176, 255))}),
	Owner = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(51, 51, 51)), ColorSequenceKeypoint.new(1,Color3.fromRGB(221, 24, 24))}),
	CoOwner = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(1,Color3.fromRGB(255, 0, 0))}),
	Developer = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(249, 116, 0)), ColorSequenceKeypoint.new(1,Color3.fromRGB(249, 116, 0))}),
	PreTester = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(0, 255, 17)), ColorSequenceKeypoint.new(1,Color3.fromRGB(0, 255, 17))}),
	Member = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1,Color3.fromRGB(255, 255, 255))}),
	None = ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(51, 51, 51)), ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))})
}


local newClassesGUI = classesGUI:Clone()
newClassesGUI.Parent = head
newClassesGUI.Name = "OverheadClassesGUI"

local TagToChnageTo = currentTag.Value
if HeadText[TagToChnageTo] == "None" then
	newClassesGUI.Tag.TextTransparency = 1
else
	newClassesGUI.Tag.TextTransparency = 0
	newClassesGUI.Tag.Text = HeadText[TagToChnageTo]
	newClassesGUI.Tag.UIGradient.Color = HeadColor[TagToChnageTo]
end
newClassesGUI.pName.Text = cuurentName
newClassesGUI.Magic.Text = currentMagic.Value
newClassesGUI.Magic.TextColor3 = magicColors[currentMagic.Value]

currentTag.Changed:Connect(function()
	local gui = head:WaitForChild("OverheadClassesGUI")
	gui:Destroy()
	task.wait(.2)
	local newClassesGUI = classesGUI:Clone()
	newClassesGUI.Parent = head
	newClassesGUI.Name = "OverheadClassesGUI"
	local magicTochangeTo = currentMagic.Value
	local TagToChnageTo = currentTag.Value
	if currentTag.Value == "" then
		newClassesGUI.Tag.TextTransparency = 1
	else
		newClassesGUI.Tag.TextTransparency = 0
		newClassesGUI.Tag.Text = HeadText[TagToChnageTo]
		newClassesGUI.Tag.UIGradient.Color = HeadColor[TagToChnageTo]
		if currentTag.Value == "VIP" then
			local clone = game.ReplicatedStorage.Tags.VIPAnim:Clone()
			clone.Parent = newClassesGUI.Tag
		else
			if newClassesGUI.Tag:FindFirstChild("VIPAnim") then
				newClassesGUI.Tag:FindFirstChild("VIPAnim"):Destroy()
			end
		end
	end
	newClassesGUI.pName.Text = cuurentName
	newClassesGUI.Magic.Text = magicTochangeTo
	newClassesGUI.Magic.TextColor3 = magicColors[magicTochangeTo]
end)


currentMagic.Changed:Connect(function()
	print(currentMagic.Value)
	local gui = head:WaitForChild("OverheadClassesGUI")
	gui:Destroy()
	task.wait(.2)
	local newClassesGUI = classesGUI:Clone()
	newClassesGUI.Parent = head
	newClassesGUI.Name = "OverheadClassesGUI"
	local TagToChnageTo = currentTag.Value
	local magicTochangeTo = currentMagic.Value
	if currentTag.Value == "" then
		newClassesGUI.Tag.TextTransparency = 1
	else
		newClassesGUI.Tag.TextTransparency = 0
		newClassesGUI.Tag.Text = HeadText[TagToChnageTo]
		newClassesGUI.Tag.UIGradient.Color = HeadColor[TagToChnageTo]
		if currentTag.Value == "VIP" then
			local clone = game.ReplicatedStorage.Tags.VIPAnim:Clone()
			clone.Parent = newClassesGUI.Tag
		else
			if newClassesGUI.Tag:FindFirstChild("VIPAnim") then
				newClassesGUI.Tag:FindFirstChild("VIPAnim"):Destroy()
			end
		end
	end
	newClassesGUI.pName.Text = cuurentName
	newClassesGUI.Magic.Text = magicTochangeTo
	newClassesGUI.Magic.TextColor3 = magicColors[magicTochangeTo]
end)

local IsAura = player.StatsData.IsAura
IsAura.Changed:Connect(function()
	if IsAura.Value == 1 then
		if character then
			for _,v in pairs(character.UpperTorso:GetChildren()) do
				if v:IsA("ParticleEmitter") then
					if v.Name == "Back" or v.Name == "Lightning" or v.Name == "Dots" or v.Name == "Lighting" then
						v:Destroy()
					end
				elseif v:IsA("Attachment") then
					if v.Name == "Attachment" or v.Name == "Aura1" then
						v:Destroy()
					end
				elseif v:IsA("PointLight") then
					v:Destroy()			
				end
			end
		end
	end
end)

local REGEN_RATE = .1/100 -- Regenerate this fraction of MaxHealth per second.
local REGEN_STEP = 10 -- Wait this long between each regeneration step.
local Humanoid = character:WaitForChild'Humanoid'

coroutine.wrap(function()
	while true do
		while Humanoid.Health < Humanoid.MaxHealth do
			local dt = wait(REGEN_STEP)
			local dh = dt*REGEN_RATE*Humanoid.MaxHealth
			Humanoid.Health = math.min(Humanoid.Health + dh, Humanoid.MaxHealth)
		end
		Humanoid.HealthChanged:Wait()
	end
end)()

local c = script.Parent
c:SetAttribute("Combo", 1)
c:SetAttribute("Ragdoll", false)
c:SetAttribute("Crouch", false)
coroutine.wrap(function()
	while wait() do
		if not c:FindFirstChild("Stun") and (c.Humanoid.WalkSpeed ~= 16 or c.Humanoid.JumpPower ~= 50) and not c:FindFirstChild("SprintTag") and not c:GetAttribute("Block") and not c:GetAttribute("Crouch") then
			c.Humanoid.WalkSpeed = 16
			c.Humanoid.JumpPower = 50
			c.Humanoid.JumpHeight = 7.2
		elseif c:FindFirstChild("Stun") then
			game.Players:GetPlayerFromCharacter(c).Magic.CanUseSkill.Value = false
			c.Humanoid.WalkSpeed = 0
			c.Humanoid.JumpPower = 0
			c.Humanoid.JumpHeight = 0
		elseif c:GetAttribute("Block") == true then
			c.Humanoid.WalkSpeed = 6
			c.Humanoid.JumpPower = 0
			c.Humanoid.JumpHeight = 0
		elseif c:GetAttribute("Crouch") == true then
			c.Humanoid.WalkSpeed = 4
			c.Humanoid.JumpPower = 0
			c.Humanoid.JumpHeight = 0
		end
	end
end)()

coroutine.wrap(function()
	while task.wait(1) do
		player.StatsData.TimePlayed.Value += 1
		if player.Magic.DemonMode.Value >= 100 then
			player.Magic.AllowDemonMode.Value = 1
		end
	end
end)()