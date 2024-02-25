local rs = game:GetService("ReplicatedStorage")
local FloatRocks = require(game.ServerStorage.Combat.FloatRocks)
local hitServer = require(game.ServerStorage.Combat.HitService)
local rocks = require(game.ServerStorage.Combat.GroundRocks)
local Rocks = require(game.ServerStorage.Combat.Rocks)
local dropRocks = require(game.ServerStorage.Combat.DropRocks)
local ragdoll = require(game.ServerStorage.Combat.Ragdoll)
local hitBox = require(game.ServerStorage.Combat.MuchachoHitbox)
local onRemove = rs.DemonMode.RemoveEvent
local folder
script.Parent.OnServerEvent:Connect(function(p, n)
	p.Magic.DemonMode.Value = 0
	p.Magic.CanUseSkill.Value = false
	folder = rs.DemonMode.Water
	local c = p.Character
	local hrp = c.HumanoidRootPart
	local h = c.Humanoid
	local sound = folder.Sfx.Start:Clone()
	sound.Parent = hrp
	game:GetService("Debris"):AddItem(sound, sound.TimeLength)
	sound:Play()
	local hb = hitBox.CreateHitbox()
	hb.Size = Vector3.new(37.71, 18.37, 45.69)
	hb.Offset = CFrame.new(0,3,0)
	hb.CFrame = hrp
	hb.Visualizer = false
	hb:Start()
	hb.Touched:Connect(function(hit, hum)
		if hum == h then return end
		script.Parent.Md:Fire(nil, p, "Stun", hum)
	end)
	local RockCache =  FloatRocks.Create({
		CenterCFrame = CFrame.new(hrp.Position),
		InnerRadius = 5,
		OuterRadius = 20,
		Amount = 45,
		Size = {Min = .2, Max = 1.5},
		Fx = true,
		T = 15
	})
	RockCache.Rise({
		Velocity = {Min = 1, Max = 6},
		FloatTime = 1.5
	})

	h:LoadAnimation(folder.Animation):Play()
	hrp.Anchored = true
	task.wait(1.5)
	RockCache.Orbit({
		Duration = 6,
		OrbitTime = 3
	})
	task.wait(.3)

	folder.Aura.Lightning1:Clone().Parent = c.RightLowerArm
	folder.Aura.Smoke1:Clone().Parent = c.RightLowerArm
	folder.Aura.Specs1:Clone().Parent = c.RightLowerArm
	folder.Aura.Lightning1:Clone().Parent = c.LeftLowerArm
	folder.Aura.Smoke1:Clone().Parent = c.LeftLowerArm
	folder.Aura.Specs1:Clone().Parent = c.LeftLowerArm

	local letters = folder.Letters:Clone()
	letters.CFrame = hrp.CFrame * CFrame.new(0,.3,0)
	letters.Parent = workspace.Fx
	task.wait(1.2)
	letters:Destroy()
	task.wait(1)	
	local eye1 = folder.Eyes.Attachment:Clone()
	local eye2 = folder.Eyes.Attachment2:Clone()
	eye1.Parent = c.Head
	eye2.Parent = c.Head
	game.Debris:AddItem(eye1, 1)
	game.Debris:AddItem(eye2, 1)
	RockCache.BreakOrbit()
	RockCache.Repulse({
		VelocityLifetime = .5,
		PushVelocity = 75,
	})
	task.wait(.5)
	c.RightLowerArm.Lightning1:Destroy()
	c.RightLowerArm.Smoke1:Destroy()
	c.RightLowerArm.Specs1:Destroy()
	c.LeftLowerArm.Lightning1:Destroy()
	c.LeftLowerArm.Smoke1:Destroy()
	c.LeftLowerArm.Specs1:Destroy()
	--script.Parent:FireClient(p, "CameraAnim")
	local oldPos= hrp.Position
	local oldCf = hrp.CFrame
	local Glitch = folder.GlitchEff:Clone()
	Glitch.CFrame = hrp.CFrame
	Glitch.Parent = workspace.Fx
	game.Debris:AddItem(Glitch, 2)
	local child = c:GetChildren()
	c.Head.Attachment:Destroy()
	c.Head.Attachment2:Destroy()
	h:LoadAnimation(folder.Animation2):Play()
	hb:Stop()
	local glitchSound = folder.Sfx.Glitch:Clone()
	glitchSound.Parent = hrp
	game:GetService("Debris"):AddItem(sound, 12)
	--first
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	task.wait(.05)
	hrp.CFrame = hrp.CFrame * CFrame.new(-12,3,5)
	Glitch.CFrame = hrp.CFrame
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--second
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	hrp.CFrame = hrp.CFrame * CFrame.new(27,3,-7)
	Glitch.CFrame = hrp.CFrame
	glitchSound:Play()
	task.wait(.05)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--third
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	hrp.CFrame = hrp.CFrame * CFrame.new(-23,3,12)
	Glitch.CFrame = hrp.CFrame
	task.wait(.05)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--fourth
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	hrp.CFrame = hrp.CFrame * CFrame.new(15,3,-15)
	Glitch.CFrame = hrp.CFrame
	task.wait(.05)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--Fifth
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	hrp.CFrame = hrp.CFrame * CFrame.new(-19,3,30)
	Glitch.CFrame = hrp.CFrame
	task.wait(.05)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--Upper
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	hrp.CFrame = oldCf*CFrame.new(0,22,0)
	Glitch.CFrame = hrp.CFrame
	task.wait(.05)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end
	--End
	task.wait(.05)
	Glitch.GlitchEffect:Emit(7)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then 
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 1
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 1
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 1			
		end
	end
	glitchSound:Play()
	hrp.CFrame = oldCf
	Glitch.CFrame = hrp.CFrame
	task.wait(.15)
	local exp = folder.Exp:Clone()
	exp.CFrame = hrp.CFrame*CFrame.new(0,-3,0)
	exp.Parent = workspace.Fx
	exp.Attachment.explosion:Emit(50)
	exp.Attachment.explosion2:Emit(70)
	exp.Attachment.explosion3:Emit(40)
	exp.Attachment.explosion4:Emit(50)
	exp.Attachment.explosion5:Emit(70)
	game.Debris:AddItem(exp, 1)
	for _,v in pairs(child) do
		if v:IsA("MeshPart") then
			if v.Name ~= "WaterModel" and v.Name ~= "FireModel" then
				v.Transparency = 0
			end
		elseif v:IsA("Accessory") then
			v.Handle.Transparency = 0
		elseif v:IsA("Part") and v.Name ~= "HumanoidRootPart" then
			v.Transparency = 0			
		end
	end

	local hb = hitBox.CreateHitbox()
	hb.Size = Vector3.new(37.71, 18.37, 45.69)
	hb.Offset = CFrame.new(0,3,0)
	hb.CFrame = hrp
	hb.Visualizer = false
	hb:Start()
	local hits = {}
	hb.Touched:Connect(function(hit, hum)
		if hum ~= h then 
			table.insert(hits, hum.Parent)
			hitServer.Hit(p, hum, 35, 0, CFrame.lookAt(hum.Parent.HumanoidRootPart.Position, hrp.Position).LookVector *-(25))
			hum.JumpPower = 50
			hum.WalkSpeed = 16
		end
	end)
	rocks.New(hrp, 20, 2, 8, 3, 5, .2)
	rocks.New(hrp, 15, 3, 12, 3, 5, .2)
	rocks.New(hrp, 10, 4, 16, 3, 5, .2)
	rocks.New(hrp, 5, 5, 20, 3, 5, .2)
	dropRocks.New(hrp, 12, 1, 3)
	dropRocks.New(hrp, 6, 2, 3)
	local ladnS = folder.Sfx.Land:Clone()
	ladnS.Parent = hrp
	ladnS:Play()
	game:GetService("Debris"):AddItem(ladnS, ladnS.TimeLength)
	rs.Powers.CamShake:FireAllClients("Bump")
	hrp.Anchored = false
	task.wait(.3)
	hb:Stop()
	folder.Aura.Lightning1:Clone().Parent = c.RightLowerArm
	folder.Aura.Smoke1:Clone().Parent = c.RightLowerArm
	folder.Aura.Specs1:Clone().Parent = c.RightLowerArm
	folder.Aura.Lightning1:Clone().Parent = c.LeftLowerArm
	folder.Aura.Smoke1:Clone().Parent = c.LeftLowerArm
	folder.Aura.Specs1:Clone().Parent = c.LeftLowerArm
	script.Parent.Md:Fire(p.Character.HumanoidRootPart,c , "Destruction1")
	p.Magic.CanUseSkill.Value = true
	task.wait(1)
	script.Parent:FireClient(p, "cd")
	rs.Stats.WaterTool.Switch:FireClient(p, "Rage")
	p.Magic.InDemonMode.Value = 1
	RockCache.Cleanup()
	--task.wait(240)
	wait(60)
	rs.Stats.WaterTool.Switch:FireClient(p, "NotRage")
	p.Magic.InDemonMode.Value = 0
	p.Magic.AllowDemonMode.Value = 0
	p.Magic.DemonMode.Value = 0
	c.RightLowerArm.Lightning1:Destroy()
	c.RightLowerArm.Smoke1:Destroy()
	c.RightLowerArm.Specs1:Destroy()
	c.LeftLowerArm.Lightning1:Destroy()
	c.LeftLowerArm.Smoke1:Destroy()
	c.LeftLowerArm.Specs1:Destroy()
end)
