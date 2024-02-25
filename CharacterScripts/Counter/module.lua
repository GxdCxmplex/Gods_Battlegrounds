local event = script.Parent.Md
local hitServer = require(game.ServerStorage.Combat.HitService)
local bezier = require(game.ServerStorage.Combat.Beziers)
local fx = game:GetService("ReplicatedStorage"):WaitForChild("Powers"):WaitForChild("WaterPowers"):WaitForChild("WaterBullet"):WaitForChild("fx")

event.Event:Connect(function(p, e, n)
	if n == "Stun" then
		hitServer.Hit(p, e.Humanoid, 5, 6, Vector3.new(0,0,0))
	end
end)