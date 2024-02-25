local event = script.Parent.Md
local destruction = require(game.ServerStorage.Combat.DestructionObjects)
local hitServer = require(game.ServerStorage.Combat.HitService)
event.Event:Connect(function(paren,p, n, hum)
	if n == "Destruction1" then
		destruction.new(paren, .5, 150, 37.71, 18.37, 45.69, 0,0,0, p, nil, 0)
	elseif n == "Stun" then
		hitServer.Hit(p, hum, 0, 6,Vector3.new(0,0,0))
	end
end)