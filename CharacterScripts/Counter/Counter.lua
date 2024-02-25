local rs = game:GetService("ReplicatedStorage")
local debris = game:GetService("Debris")
local tween = game:GetService("TweenService")
local hitBox = require(game.ServerStorage.Combat.MuchachoHitbox)
local hitServer = require(game.ServerStorage.Combat.HitService)
local rocks = require(game.ServerStorage.Combat.GroundRocks)
local Rocks = require(game.ServerStorage.Combat.Rocks)
local ragdoll = require(game.ServerStorage.Combat.Ragdoll)
local dropRocks = require(game.ServerStorage.Combat.DropRocks)
local camShake = rs.Powers.CamShake
local ev = script.Parent
local md = script.Parent.Md


local res = rs.Powers.WaterPowers.Counter
local anims = res.Anims
local sfx = res.Sfx
local fx = res.Fx

script.Parent.Event:Connect(function(e)
	local c = script.Parent.Parent
	c:SetAttribute("Invinsible", true)
	e:SetAttribute("Invinsible", true)
	local p = game.Players:GetPlayerFromCharacter(c)
	local h = c.Humanoid
	local hrp = c.HumanoidRootPart
	local eh = e.Humanoid
	local ehrp = e.HumanoidRootPart
	local ep = game.Players:GetPlayerFromCharacter(e)
	if ep ~= nil then ep.Magic.CanUseSkill.Value = false end
	p.Magic.CanUseSkill.Value = false
	md:Fire(game.Players:GetPlayerFromCharacter(c), e, "Stun")
	ehrp.CFrame = CFrame.lookAt(ehrp.Position, hrp.Position)
	hrp.CFrame = CFrame.lookAt(hrp.Position, ehrp.Position)
	hrp.Anchored = true
	local soundG = sfx.Glitch:Clone()
	
	coroutine.resume(coroutine.create(function()
		local model = fx.Model
		local shockwave = model.Shockwave:Clone()
		shockwave.CFrame = hrp.CFrame
		shockwave.Parent = workspace.Fx
		tween:Create(shockwave, TweenInfo.new(.2), {Size = Vector3.new(34.031, 1.799, 35.79)}):Play()
		tween:Create(shockwave, TweenInfo.new(1.2), {Orientation = shockwave.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(shockwave, 2)
		local inwardshockwave = model.InwardShockwave:Clone()
		inwardshockwave.CFrame = hrp.CFrame
		inwardshockwave.Parent = workspace.Fx
		tween:Create(inwardshockwave, TweenInfo.new(.2), {Size = Vector3.new(26.994, 26.994, 26.994)}):Play()
		tween:Create(inwardshockwave, TweenInfo.new(1.2), {Orientation = inwardshockwave.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(inwardshockwave, 2)
		local inwardshockwave2 = model.InwardShockwave1:Clone()
		inwardshockwave2.CFrame = hrp.CFrame
		inwardshockwave2.Parent = workspace.Fx
		tween:Create(inwardshockwave2, TweenInfo.new(.2), {Size = Vector3.new(31.827, 31.827, 31.827)}):Play()
		tween:Create(inwardshockwave2, TweenInfo.new(1.2), {Orientation = inwardshockwave2.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(inwardshockwave2, 2)
		local m1 = model.m1:Clone()
		m1.CFrame = hrp.CFrame
		m1.Parent = workspace.Fx
		tween:Create(m1, TweenInfo.new(.2), {Size = Vector3.new(29.336, 29.092, 27.025)}):Play()
		tween:Create(m1, TweenInfo.new(1.2), {Orientation = m1.Orientation + Vector3.new(0, 0, 250)}):Play()
		debris:AddItem(m1, 2)
		local mesh = model.MeshPart:Clone()
		mesh.CFrame = hrp.CFrame
		mesh.Parent = workspace.Fx
		tween:Create(mesh, TweenInfo.new(.2), {Size = Vector3.new(28.19, 27.956, 25.887)}):Play()
		tween:Create(mesh, TweenInfo.new(1.2), {Orientation = mesh.Orientation + Vector3.new(0, 0, 250)}):Play()
		debris:AddItem(mesh, 2)
		local shock = model.Shock:Clone()
		shock.CFrame = hrp.CFrame
		shock.Parent = workspace.Fx
		tween:Create(shock, TweenInfo.new(.2), {Size = Vector3.new(51.776, 29.926, 56.323)}):Play()
		tween:Create(shock, TweenInfo.new(1.2), {Orientation = shock.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(shock, 2)
		local sphere = model.Sphere:Clone()
		sphere.CFrame = hrp.CFrame
		sphere.Parent = workspace.Fx
		tween:Create(sphere, TweenInfo.new(.2), {Size = Vector3.new(30.395, 30.395, 30.395)}):Play()
		tween:Create(sphere, TweenInfo.new(1.2), {Orientation = sphere.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(sphere, 2)
		local sphere1 = model.Sphere1:Clone()
		sphere1.CFrame = hrp.CFrame
		sphere1.Parent = workspace.Fx
		tween:Create(sphere1, TweenInfo.new(.2), {Size = Vector3.new(30.395, 30.395, 30.395)}):Play()
		tween:Create(sphere1, TweenInfo.new(1.2), {Orientation = sphere1.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(sphere1, 2)
		local wave1 = model.Wave1:Clone()
		wave1.CFrame = hrp.CFrame
		wave1.Parent = workspace.Fx
		tween:Create(wave1, TweenInfo.new(.2), {Size = Vector3.new(50.523, 2.447, 51.07)}):Play()
		tween:Create(wave1, TweenInfo.new(1.2), {Orientation = wave1.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(wave1, 2)
		local wave2 = model.Wave2:Clone()
		wave2.CFrame = hrp.CFrame
		wave2.Parent = workspace.Fx
		tween:Create(wave2, TweenInfo.new(.2), {Size = Vector3.new(50.2, 2.859, 50.743)}):Play()
		tween:Create(wave2, TweenInfo.new(1.2), {Orientation = wave2.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(wave2, 2)
		local wave3 = model.Wave3:Clone()
		wave3.CFrame = hrp.CFrame
		wave3.Parent = workspace.Fx
		tween:Create(wave3, TweenInfo.new(.2), {Size = Vector3.new(44.933, 2.177, 45.419)}):Play()
		tween:Create(wave3, TweenInfo.new(1.2), {Orientation = wave3.Orientation + Vector3.new(0, 250, 0)}):Play()
		debris:AddItem(wave3, 2)

		task.wait(.2)
		local aura = model.Aura:Clone()
		aura.Parent = workspace.Fx
		aura.CFrame = hrp.CFrame
		debris:AddItem(aura, 1.5)
		task.wait(1.3)
		aura:Destroy()
		tween:Create(shockwave, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = shockwave.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(inwardshockwave, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = inwardshockwave.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(inwardshockwave2, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = inwardshockwave2.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(mesh, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = mesh.Orientation + Vector3.new(0, 0, -250)}):Play()
		tween:Create(m1, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = m1.Orientation + Vector3.new(0, 0, -250)}):Play()
		tween:Create(sphere, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = sphere.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(sphere1, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = sphere1.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(wave1, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = wave1.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(wave2, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = wave2.Orientation + Vector3.new(0, -250, 0)}):Play()
		tween:Create(wave3, TweenInfo.new(.2), {Size = Vector3.new(0,0,0), Orientation = wave3.Orientation + Vector3.new(0, -250, 0)}):Play()
	end))
	
	soundG.Parent = hrp
	debris:AddItem(soundG, 15)
	local function fxFunc()
		if p.leaderstats.Magic.Value == "Water" then
			local att = rs.Powers.CombatVfx.Water.Attachment:Clone()
			local smoke = rs.Powers.CombatVfx.Water.Smoke:Clone()
			local flame = rs.Powers.CombatVfx.Water.flames:Clone()
			local flame1 = rs.Powers.CombatVfx.Water.flames2:Clone()
			att.Parent = ehrp
			flame.Parent = ehrp
			flame1.Parent = ehrp
			smoke.Parent = ehrp
			flame:Emit(5)
			flame1:Emit(5)
			smoke:Emit(8)
			att.Lightningsmall:Emit(2)
			att.Lightningsmall1:Emit(2)
			att.ParticleEmitter:Emit(1)
			att.orange:Emit(17)
			debris:AddItem(att, 1)
			debris:AddItem(smoke, 1)
			debris:AddItem(flame, 1)
			debris:AddItem(flame1, 1)
		end
	end
	
	if eh.Health - 3 > 10 then  hitServer.Hit(p, eh, 3, 0, hrp.CFrame.LookVector*150, fxFunc) else hitServer.Hit(p, eh, 0, 0, hrp.CFrame.LookVector*150, fxFunc) end
	task.wait(.8)
	local Glitch = fx.GlitchEff:Clone()
	Glitch.CFrame = hrp.CFrame
	Glitch.Parent = workspace.Fx
	local child = c:GetChildren()
	Glitch.GlitchEffect:Emit(5)
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
	soundG:Play()
	task.wait(.25)
	ehrp.Anchored = true
	hrp.CFrame = e.HumanoidRootPart.CFrame * CFrame.new(0,0,-2.5)
	hrp.CFrame = CFrame.lookAt(hrp.Position,e.HumanoidRootPart.Position)
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
	task.wait(.8)
	rocks.New(ehrp, 16, 2, 16, 3, 15)
	rocks.New(ehrp, 12, 3, 18, 3, 15)
	rocks.New(ehrp, 8, 4, 20, 3, 15)
	camShake:FireClient(p, "Bumb")
	if ep ~= nil then camShake:FireClient(ep, "Bumb") end
	if eh.Health - 6 > 10 then hitServer.Hit(p, eh, 6, 0, Vector3.new(0,0,0), fxFunc) end
	
	task.wait(.3)
	
	tween:Create(ehrp, TweenInfo.new(1.5), {CFrame = ehrp.CFrame * CFrame.new(0,5,0)}):Play()
	local att = fx.BM.Attachment:Clone()
	att.Parent = c.LeftHand
	local att2 = fx.BM.Attachment2:Clone()
	att2.Parent = ehrp
	att.Beam.Attachment0 = att att.Beam.Attachment1 = att2 att.Beam2.Attachment0 = att att.Beam2.Attachment1 = att2
	
	debris:AddItem(att2, 1.4)
	for _,v in pairs(fx.BM:GetChildren()) do
		if v:IsA("ParticleEmitter") then
			local clone = v:Clone()
			clone.Parent = c.LeftHand
			local clone2 = v:Clone()
			clone2.Parent = ehrp
			debris:AddItem(clone, 1.4)
			debris:AddItem(clone2, 1.4)
		end
	end
	debris:AddItem(att, 1.4)
	for i = 0,1.5,.1 do
		if eh.Health - 1 > 10 then hitServer.Hit(p, eh, 1, 0, Vector3.new(0,0,0)) end
		task.wait(.1)
	end
	if eh.Health <= 15 then
		task.wait(.3)
		local aura = fx.FH.Attachment:Clone()
		aura.Parent = hrp
		local  ht = fx.FH.Hit:Clone()
		ht.Parent = hrp
		debris:AddItem(ht,5) debris:AddItem(aura,5)
		ehrp.Anchored = false
		local fallDmg = script.Parent.FallDmg:Clone()
		fallDmg.Parent = e
		fallDmg.Enabled = true
		fallDmg.plrname.Value = p.Name
		for _,v in pairs(aura:GetChildren()) do
			v:Emit(v:GetAttribute("EmitCount"))
		end
		for _,v in pairs(ht:GetChildren()) do
			v:Emit(v:GetAttribute("EmitCount"))
		end
		hitServer.Hit(p, eh, 0, 0, hrp.CFrame.LookVector*100 + Vector3.new(0,200,0), fxFunc)
		eh:ChangeState(Enum.HumanoidStateType.Freefall)
	else
		ehrp.Anchored = false
	end
	hrp.Anchored = false
	c:SetAttribute("Invinsible", false)
	e:SetAttribute("Invinsible", false)
	if ep ~= nil then ep.Magic.CanUseSkill.Value = true end
	p.Magic.CanUseSkill.Value = true
end)