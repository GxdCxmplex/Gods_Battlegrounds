local module = {}

function module.Stun(c, t)
	coroutine.wrap(function()
		local inst = Instance.new("BoolValue", c)
		inst.Value = true
		inst.Name = "Stun"
		game.Debris:AddItem(inst, t)
		task.wait(t+.05)
		if game.Players:GetPlayerFromCharacter(c) then
			game.Players:GetPlayerFromCharacter(c).Magic.CanUseSkill.Value = true
		end
	end)()
end

return module
