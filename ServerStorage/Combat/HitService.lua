local stunhandler = require(script.Stun)
local kill = require(script.Kill)
local module = {}

function module.Hit(player, hum, dmg, stundur, kb, f)
	if hum.Parent == nil or hum.Parent.Parent == workspace.SpawnedObjects then return end
	if game.Players:GetPlayerFromCharacter(hum.Parent) and player ~= nil then
		kill:AddTag(player, game.Players:GetPlayerFromCharacter(hum.Parent), hum, dmg)
	end
	if dmg ~= 0 then
		hum.Health -= dmg
	end
	if stundur ~= 0 then stunhandler.Stun(hum.Parent, stundur) end
	if kb then
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1,1,1) * math.huge
		bv.Velocity = kb
		
		if hum.Parent ~= nil then bv.Parent = hum.Parent.HumanoidRootPart end
		
		game.Debris:AddItem(bv, .1)
	end
	if f then
		f()
	end
end

function module.RequireDmg(player)
	return kill:RequireTemplate(player)
end

function module.Clear(player)
	kill:Clear(player)
end

return module
