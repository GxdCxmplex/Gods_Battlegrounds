local module = {}
function module.New(parent, size, k,t,h)
	local function RockNew(kn)
		local p = Instance.new("Part")
		game.Debris:AddItem(p, t)
		p.Anchored = true
		p.CanCollide = false
		p.Size = Vector3.new(0,0,0)
		p.CFrame = parent.CFrame * CFrame.new(kn, 0,0) * CFrame.new(math.random(-1,1),math.random(-1,1),math.random(-1,1))
		p.Orientation = Vector3.new(math.random(-180,180),math.random(-180,180),math.random(-180,180))
		local params = RaycastParams.new()
		params.IgnoreWater = false
		local ray = workspace:Raycast(p.Position, Vector3.new(0,-h,0), params)
		if ray then
			p.Parent = workspace.Fx
			p.Position = ray.Position
			p.Color = ray.Instance.Color
			p.Material = ray.Material
			game.TweenService:Create(p, TweenInfo.new(0.25), {Size = Vector3.new(size,size,size)}):Play()
			delay(t, function()
				game.TweenService:Create(p, TweenInfo.new(0.5), {Size = Vector3.new(0,0,0)}):Play()
			end)
		else
			game.Debris:AddItem(p,0)
		end
	end	
	spawn(function()
		RockNew(k)
		RockNew(-k)
	end)
end
return module
