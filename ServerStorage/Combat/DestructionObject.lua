local Obj = {}
function Obj.new(pos, t, PushVel, sx,sy,sz, cfx, cfy, cfz, c, enemy, dmg)
	local hb = Instance.new("Part")
	hb.Transparency = 1
	hb.Color = Color3.fromRGB(255,0,0)
	hb.CanCollide = false
	hb.Anchored = true
	hb.Size = Vector3.new(sx,sy,sz)
	hb.CFrame = pos.CFrame * CFrame.new(cfx or 0,cfy or 0,cfz or 0)
	hb.Name = "hb"
	hb.Parent = workspace.Fx
	game:GetService("Debris"):AddItem(hb, 1.3)
	local con
	con = hb.Touched:Connect(function()
		con:Disconnect()
	end)

	local hits = {}
	for i,v in pairs(hb:GetTouchingParts()) do
		if (pos.Position - game.Workspace.Map.Spawn.SpawnHitBox.Position).Magnitude <= 200 then break end
		if v == nil or v.Parent == nil or v.Parent.Parent == nil then break end
		if table.find(hits, v) == nil and (v.Parent.Name == "Floor" or v.Parent.Name == "Bench" or v.Parent.Name == "TrashCan") then
			if v:IsA("Model") then
				for p in pairs(v:GetChildren()) do
					table.insert(hits, v)
				end
			else
				table.insert(hits, v)
			end
			task.spawn(function()
				v.CollisionGroup = "Destruct"
				v.Anchored = false
				local BodyVelocity = Instance.new("BodyVelocity") do
					BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 4e4
					BodyVelocity.Velocity = CFrame.lookAt(v.Position, pos.Position).LookVector * -(PushVel or 75) + Vector3.new(0,45,0)
					BodyVelocity.Parent = v
					game.Debris:AddItem(BodyVelocity, t or .25)
				end
				task.wait(.3)
				v.Position += Vector3.new(0,1,0)
			end)
			
		elseif v.Parent:FindFirstChildOfClass("Humanoid") and v.Parent ~= enemy and table.find(hits, v.Parent) == nil and v.Parent ~= c then
			table.insert(hits, v.Parent)
			if not v.Parent:GetAttribute("Block") and not v.Parent:GetAttribute("Invinsible") then 
				v.Parent:FindFirstChildOfClass("Humanoid"):TakeDamage(dmg or 10)
				local BodyVelocity = Instance.new("BodyVelocity") do
					BodyVelocity.MaxForce = Vector3.new(1, 1, 1) * 4e4
					BodyVelocity.Velocity = CFrame.lookAt(v.Position, pos.Position).LookVector * -(PushVel or 75)
					BodyVelocity.Parent = v
					game.Debris:AddItem(BodyVelocity, t or .25)
				end
			end
		end
	end
	hits = nil
end
return Obj
--module.new(script.Parent, .25,125, 25, 35, 83, 0, 15, 35) example