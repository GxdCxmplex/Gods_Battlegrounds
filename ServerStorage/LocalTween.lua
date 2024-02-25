local module = {}

local event = game.ReplicatedStorage.Powers.Tweens
local threads = {}

module.Tween = function(inst, info, prop)
	event:FireAllClients(inst, info, prop)
end

return module
