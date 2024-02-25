local hitServer = require(game.ServerStorage.Combat.HitService)
local rocks = require(game.ServerStorage.Combat.GroundRocks)
local ragdoll = require(game.ServerStorage.Combat.Ragdoll)
local c = script.Parent
while task.wait() do
	if c.Humanoid.FloorMaterial ~= Enum.Material.Air then
		ragdoll.Start(c)
		local height = -c.HumanoidRootPart.Velocity.Y
		local dmg = (height / 2) 
		if c.Humanoid.Health <= 15 then dmg = 25 end
		local sound = game:GetService("ReplicatedStorage").Powers.WaterPowers.WaterPunch.Sfx.hammerThrow:Clone()
		sound.Parent = c.HumanoidRootPart
		game:GetService("Debris"):AddItem(sound, sound.TimeLength)
		hitServer.Hit(game.Players:FindFirstChild(script.plrname.Value), c.Humanoid, dmg, 0, Vector3.new(0,0,0))
		sound:Play()
		if game.Players:GetPlayerFromCharacter(c) then game:GetService("ReplicatedStorage").Powers.CamShake:FireClient(game.Players:GetPlayerFromCharacter(c), "Explosion") end
		rocks.New(c.HumanoidRootPart, 23, 1, 4, 2, 15, .1)
		rocks.New(c.HumanoidRootPart, 18, 2, 6, 2, 15, .1)
		rocks.New(c.HumanoidRootPart, 13, 3, 8, 2, 15, .1)
		repeat task.wait() until sound ~= nil
		break
	end
end
script:Destroy()