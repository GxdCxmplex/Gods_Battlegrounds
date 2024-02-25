local rs = game:GetService("ReplicatedStorage")
local runs = game:GetService("RunService")
local debris = game:GetService("Debris")
local Rocks = require(game.ServerStorage.Combat.Rocks)
local hitBox = require(game.ServerStorage.Combat.MuchachoHitbox)
local hitServer = require(game.ServerStorage.Combat.HitService)

local PlayerHit = {}
local event = script.Parent
local resource = rs.Powers.Dash
local fx = resource.fx
local sfx = resource.Sfx
local anim = resource.Anims

local params = RaycastParams.new()
params.IgnoreWater = false

local function waterStart(hrp)
	local fd = fx.WaterStart
	local coolLightning = fd.CoolLightning:Clone() coolLightning.Parent = hrp debris:AddItem(coolLightning, 1)
	local dashlines = fd.DashLines:Clone() dashlines.Parent = hrp debris:AddItem(dashlines, 1)
	local floor = fd.Floor:Clone() floor.Parent = hrp debris:AddItem(floor, 1)
	local start = fd.Start:Clone() start.Parent = hrp debris:AddItem(start, 1)
	coolLightning:Emit(2)
	dashlines:Emit(20)
	for _,v in pairs(floor:GetChildren()) do
		v:Emit(v:GetAttribute("EmitCount"))
	end
	for _,v in pairs(start:GetChildren()) do
		v:Emit(v:GetAttribute("EmitCount"))
	end
end

local function Forward(p)
	local c = p.Character
	local h = c.Humanoid
	local hrp = c.HumanoidRootPart
	local Runservice
	local loadAnim
	local func = coroutine.create(function()
		loadAnim = h:LoadAnimation(anim.Forward)
		if loadAnim ~= nil then loadAnim:Play() end
		if p.leaderstats.Magic.Value == "Water" then waterStart(hrp) end
		local ray = workspace:Raycast(hrp.Position, Vector3.new(0,15,0), params)
		if ray then
			local dust = fx.Dust.Attachment:Clone()
			dust.Parent = hrp
			dust.Dust.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ray.Instance.Color), ColorSequenceKeypoint.new(1, ray.Instance.Color)}
			dust.Dust.Enabled = true
			debris:AddItem(dust, .8)
		end
		local sound = sfx.Swoosh:Clone()
		sound.Parent = hrp
		sound:Play()
		debris:AddItem(sound, sound.TimeLength)

		if p.leaderstats.Magic.Value == "Water" then
			local beam = fx.Dust.trail1:Clone() local att1 = fx.Dust:FindFirstChild("1"):Clone() local att2 = fx.Dust:FindFirstChild("2"):Clone() local beam2 = fx.Dust.trail2:Clone() local att3 = fx.Dust:FindFirstChild("1"):Clone() local att4 = fx.Dust:FindFirstChild("2"):Clone()
			beam.Parent = c.RightHand beam2.Parent = c.RightHand att1.Parent = c.RightHand att2.Parent = c.RightHand att3.Parent = c.RightHand att4.Parent = c.RightHand
			beam.Attachment0 = att1 beam.Attachment1 = att2 beam2.Attachment0 = att3 beam2.Attachment1 = att4
			local aura1= fx.aura:Clone() local aura2 = fx.aura2:Clone() local specs = fx.Specs:Clone() local l = fx.Lightning:Clone()
			aura1.Parent = c.RightHand aura2.Parent = c.RightHand specs.Parent = c.RightHand l.Parent = c.RightHand
			debris:AddItem(aura1, .8) debris:AddItem(aura2, .8) debris:AddItem(specs, .8) debris:AddItem(l, .8)
			debris:AddItem(beam, .8) debris:AddItem(beam2, .8) debris:AddItem(att1, .8) debris:AddItem(att2, .8) debris:AddItem(att3, .8) debris:AddItem(att4, .8)
		end
		local vel = 85; local tm = .4
		local v = Instance.new("BodyVelocity", hrp)
		v.MaxForce = Vector3.new(40000,0,40000)
		v.Velocity = hrp.CFrame.LookVector * vel
		debris:AddItem(v, tm)
		Runservice = runs.Stepped:Connect(function()
			v.Velocity = hrp.CFrame.LookVector * vel
			Rocks.New(hrp, .6, 4.5, 1, 5)
		end)
		wait(.5)
		Runservice:Disconnect()

		if p.leaderstats.Magic.Value == "Water" then
			local ht = fx.Dust.Hit:Clone()
			ht.Parent = hrp
			for _,v in pairs(ht:GetChildren()) do
				v:Emit(v:GetAttribute("EmitCount"))
			end
		end

		local hb = hitBox.CreateHitbox()
		hb.Size = Vector3.new(4,5,4)
		hb.Offset = CFrame.new(0,0,-3.5)
		hb.CFrame = hrp
		hb.Visualizer = false
		hb:Start()
		hb.Touched:Connect(function(hit, hum)
			if hum == h then return end

			local function FXFunc()
				if p.leaderstats.Magic.Value == "Water" then
					local att = rs.Powers.CombatVfx.Water.Attachment:Clone()
					local smoke = rs.Powers.CombatVfx.Water.Smoke:Clone()
					local flame = rs.Powers.CombatVfx.Water.flames:Clone()
					local flame1 = rs.Powers.CombatVfx.Water.flames2:Clone()
					att.Parent = hum.Parent.HumanoidRootPart
					flame.Parent = hum.Parent.HumanoidRootPart
					flame1.Parent = hum.Parent.HumanoidRootPart
					smoke.Parent = hum.Parent.HumanoidRootPart
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

			local function Block()
				local guard = rs.Powers.CombatVfx.Block.Guard:Clone()
				guard.Parent = hum.Parent.HumanoidRootPart
				debris:AddItem(guard, 1)
				for _,v in pairs(guard:GetChildren()) do
					if v:IsA("ParticleEmitter") then
						v:Emit()
					end
				end
			end

			if hum.Parent:GetAttribute("Block") == false or hum.Parent:GetAttribute("Block") == nil then
				local hitsound = rs.Powers.CombatVfx.Sfx.punch1:Clone()
				hitsound.Parent = hum.Parent.HumanoidRootPart
				hitsound:Play()
				debris:AddItem(hitsound, sound.TimeLength)
				local hitanims = rs.HitAnims:FindFirstChild("Combo1"):FindFirstChild("1")
				local hitanim = hum:LoadAnimation(hitanims)
				hitanim:Play()
				if hum.Health - 10 > 10 then
					hitServer.Hit(p,hum, 10, 0, hrp.CFrame.LookVector*3, FXFunc)
					script.Parent.Md:Fire(p,hum,0,1)
				else
					hitServer.Hit(p,hum, hum.Health, 0, hrp.CFrame.LookVector*75 + Vector3.new(0,45,0), FXFunc)
				end
			else
				local hitsound = rs.Powers.CombatVfx.Sfx.Block1:Clone()
				hitsound.Parent = hum.Parent.HumanoidRootPart
				hitsound:Play()
				debris:AddItem(hitsound, sound.TimeLength)
				hitServer.Hit(p,hum, 0, 0, Vector3.new(0,0,0), Block)
				c:SetAttribute("Block", false)
			end
		end)
		task.wait(.3)
		hb:Stop()
	end)
	coroutine.resume(func)
	h.HealthChanged:Connect(function()
		coroutine.close(func)
		Runservice:Disconnect()
		if hrp:FindFirstChild("BodyVelocity") then hrp:FindFirstChild("BodyVelocity"):Destroy() end
		if loadAnim ~= nil then
			loadAnim:Stop()
		end
	end)
end

local function Backward(p)
	local c = p.Character
	local h = c.Humanoid
	local hrp = c.HumanoidRootPart
	local Runservice
	local loadAnim
	local func = coroutine.create(function()
		loadAnim = h:LoadAnimation(anim.Backward)
		if loadAnim ~= nil then loadAnim:Play() end
		local ray = workspace:Raycast(hrp.Position, Vector3.new(0,15,0), params)
		if ray then
			local dust = fx.Dust.Attachment:Clone()
			dust.Parent = hrp
			dust.Dust.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ray.Instance.Color), ColorSequenceKeypoint.new(1, ray.Instance.Color)}
			dust.Dust.Enabled = true
			debris:AddItem(dust, .8)
		end
		local sound = sfx.Swoosh:Clone()
		sound.Parent = hrp
		sound:Play()
		debris:AddItem(sound, sound.TimeLength)
		local vel = 75; local tm = .35
		local v = Instance.new("BodyVelocity", hrp)
		v.MaxForce = Vector3.new(40000,0,40000)
		v.Velocity = hrp.CFrame.LookVector * vel
		debris:AddItem(v, tm)
		Runservice = runs.Stepped:Connect(function()
			v.Velocity = hrp.CFrame.LookVector * -vel
			Rocks.New(h.Parent.HumanoidRootPart, .6, 4.5, 1, 5)

		end)
		wait(.45)
		Runservice:disconnect()
	end)
	coroutine.resume(func)
	h.HealthChanged:Connect(function()
		coroutine.close(func)
		Runservice:Disconnect()
		if hrp:FindFirstChild("BodyVelocity") then hrp:FindFirstChild("BodyVelocity"):Destroy() end
		if loadAnim ~= nil then
			loadAnim:Stop()
		end
	end)
end

local function Right(p)
	local c = p.Character
	local h = c.Humanoid
	local hrp = c.HumanoidRootPart
	local loadAnim
	local Runservice
	local func = coroutine.create(function()
		loadAnim = h:LoadAnimation(anim.Right)
		if loadAnim ~= nil then loadAnim:Play() end
		local ray = workspace:Raycast(hrp.Position, Vector3.new(0,15,0), params)
		if ray then
			local dust = fx.Dust.Attachment:Clone()
			dust.Parent = hrp
			dust.Dust.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ray.Instance.Color), ColorSequenceKeypoint.new(1, ray.Instance.Color)}
			dust.Dust.Enabled = true
			debris:AddItem(dust, .8)
		end
		local sound = sfx.Swoosh:Clone()
		sound.Parent = hrp
		sound:Play()
		debris:AddItem(sound, sound.TimeLength)
		local vel = 65; local tm = .3
		local v = Instance.new("BodyVelocity", hrp)
		v.MaxForce = Vector3.new(40000,0,40000)
		v.Velocity = hrp.CFrame.RightVector * vel
		debris:AddItem(v, tm)
		Runservice = runs.Stepped:Connect(function()
			v.Velocity = hrp.CFrame.RightVector * vel
			Rocks.New(h.Parent.HumanoidRootPart, .6, 4.5, 1, 5)

		end)
		wait(.4)
		Runservice:disconnect()
	end)
	coroutine.resume(func)
	h.HealthChanged:Connect(function()
		coroutine.close(func)
		Runservice:Disconnect()
		if hrp:FindFirstChild("BodyVelocity") then hrp:FindFirstChild("BodyVelocity"):Destroy() end
		if loadAnim ~= nil then
			loadAnim:Stop()
		end
	end)
end

local function Left(p)
	local c = p.Character
	local h = c.Humanoid
	local hrp = c.HumanoidRootPart
	local loadAnim
	local Runservice
	local func = coroutine.create(function()
		loadAnim = h:LoadAnimation(anim.Left)
	if loadAnim ~= nil then loadAnim:Play() end
	local ray = workspace:Raycast(hrp.Position, Vector3.new(0,15,0), params)
	if ray then
		local dust = fx.Dust.Attachment:Clone()
		dust.Parent = hrp
		dust.Dust.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ray.Instance.Color), ColorSequenceKeypoint.new(1, ray.Instance.Color)}
		dust.Dust.Enabled = true
		debris:AddItem(dust, .8)
	end
	local sound = sfx.Swoosh:Clone()
	sound.Parent = hrp
	sound:Play()
	debris:AddItem(sound, sound.TimeLength)
	local vel = 65; local tm = .3
	local v = Instance.new("BodyVelocity", hrp)
	v.MaxForce = Vector3.new(40000,0,40000)
	v.Velocity = hrp.CFrame.RightVector * vel
	debris:AddItem(v, tm)
	Runservice = runs.Stepped:Connect(function()
		v.Velocity = hrp.CFrame.RightVector * -vel
		Rocks.New(h.Parent.HumanoidRootPart, .6, 4.5, 1, 5)

	end)
	wait(.4)
	Runservice:disconnect()
	end)
	coroutine.resume(func)
	h.HealthChanged:Connect(function()
		coroutine.close(func)
		Runservice:Disconnect()
		if hrp:FindFirstChild("BodyVelocity") then hrp:FindFirstChild("BodyVelocity"):Destroy() end
		if loadAnim ~= nil then
			loadAnim:Stop()
		end
	end)
end

local function createTag(name, t)
	local tag = Instance.new("StringValue", script)
	tag.Name = name
	debris:AddItem(tag, t)
end

event.OnServerEvent:Connect(function(player, data)
	local c = player.Character
	if player.Magic.CanUseSkill.Value == true and c.Humanoid.Health > 0 and player.Magic.AllowPvp.Value == true and not c:FindFirstChild("Stun") and c:GetAttribute("Attacking") ~= true and c:GetAttribute("Block") == false then
		if data.Shift == "On" then
			local hMove = c.Humanoid.MoveDirection
			if (hMove == Vector3.new(0,0,0) or data.w == true) and not script:FindFirstChild("Str") then
				createTag("Str", 4.5)
				Forward(player)
			elseif data.s == true and not script:FindFirstChild("Str") then
				createTag("Str", 4.5)
				Backward(player)
			elseif data.d == true and not script:FindFirstChild("Idk") then
				createTag("Idk", 2.5)
				Right(player)
			elseif data.a == true and not script:FindFirstChild("Idk") then
				createTag("Idk", 2.5)
				Left(player)
			end
		else
			if not script:FindFirstChild("Str") then
				createTag("Str", 5.5)
				Forward(player)
			end
		end
	end
end)