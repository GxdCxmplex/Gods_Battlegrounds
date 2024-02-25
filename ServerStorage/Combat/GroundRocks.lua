local Rock = {}
function Rock.New(parent, Num, Size, Room, T,h, ti)
	local ori = 0
	local model = Instance.new("Model", workspace.Fx)
	model.Name = "GroundRocks"
	for i=1,Num do
		local Procks = Instance.new("Part")
		Procks.Anchored = true
		Procks.CanCollide = false
		Procks.Size = Vector3.new(Size,Size,Size)
		Procks.CFrame = parent.CFrame * CFrame.fromEulerAnglesXYZ(0,math.rad(ori), 0) * CFrame.new(Room,2,-Room)
		Procks.Orientation = Vector3.new(math.random(-40,40),math.random(-40,40),math.random(-40,40))
		game.Debris:AddItem(Procks, 15)
		game.Debris:AddItem(model, 15)
		local params = RaycastParams.new()
		params.IgnoreWater = false
		local ray = workspace:Raycast(Procks.Position, Vector3.new(0,-h,0), params)
		if ray then
			Procks.Parent = model
			Procks.Position = ray.Position - Vector3.new(0,Size,0)
			Procks.Color = ray.Instance.Color
			Procks.Material = ray.Material
			game.TweenService:Create(Procks, TweenInfo.new(ti or .2,Enum.EasingStyle.Linear), {Position = ray.Position}):Play()
			delay(T, function()
				game.TweenService:Create(Procks, TweenInfo.new(ti or .2,Enum.EasingStyle.Linear), {Transparency = 1, Position = ray.Position - Vector3.new(0,Size,0)}):Play()
			end)
		else
			game.Debris:AddItem(Procks, 0)
		end
		ori+=360/Num
	end
end
return Rock
--module.New(script.Parent, 15, 2, 6, 1, 5, .2)