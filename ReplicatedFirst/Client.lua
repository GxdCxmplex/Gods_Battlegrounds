local Preload = game:GetService("ContentProvider")

local animations = {}
local particles = {}
local sounds = {}

for i,v in pairs(game:GetDescendants()) do
	if v:IsA("ParticleEmitter") or v:IsA("Beam") or v:IsA("Trail") then
		particles[#particles+1] = v.Texture
	end

	if v:IsA("Animation") then
		animations[#animations+1] = v.AnimationId
	end

	if v:IsA("Sound") then
		sounds[#sounds+1] = v.SoundId
	end
end

task.spawn(function()
	Preload:PreloadAsync(animations)
end)

task.spawn(function()
	Preload:PreloadAsync(particles)
end)

task.spawn(function()
	Preload:PreloadAsync(sounds)
end)

local ts = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")
local event = rs:WaitForChild("Powers"):WaitForChild("Tweens")
local dropRocks = rs:WaitForChild("Powers"):WaitForChild("DropRocks")
local baseEffects = rs:WaitForChild("Powers"):WaitForChild("BaseEffects")

local Shaker = require(game.ReplicatedStorage.Powers.CameraShaker)
local cam = game.Workspace.CurrentCamera
local camShake = Shaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
	cam.CFrame = cam.CFrame * shakeCf
end)

camShake:Start()

rs:WaitForChild("Powers"):WaitForChild("CamShake").OnClientEvent:Connect(function(n)
	if n == "Bump" then
		camShake:Shake(Shaker.Presets.Bump)
	elseif n == "Explosion" then
		camShake:Shake(Shaker.Presets.Explosion)
	end
end)

baseEffects.OnClientEvent:Connect(function(pos, rad, count, op, dist, size, sd, rot)
	if op == "Ground" then
		require(rs.Modules.Client.Effects.BaseEffects).GroundExpandV2(pos, rad, count)
	elseif op == "Line" then
		require(rs.Modules.Client.Effects.BaseEffects).CreateRockLine(pos, dist, count, size, sd, rot)
	end
end)

dropRocks.OnClientEvent:Connect(function(parent, Num, Size,T, custom)
	require(rs.Powers.Modules).DropRocks(parent, Num, Size,T, custom)
end)

event.OnClientEvent:Connect(function(instance, info, prop)
	if instance == nil then print(instance, info, prop) return end
	ts:Create(instance, TweenInfo.new(table.unpack(info)), prop):Play()
end)

