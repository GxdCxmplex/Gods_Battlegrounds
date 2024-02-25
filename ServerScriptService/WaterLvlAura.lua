local rs = game:GetService("ReplicatedStorage")
local Equip = rs.Auras.Water.Lvl


Equip.OnServerEvent:Connect(function(plr, char)
	local lvl = plr.leaderstats.Level.Value
	if lvl < 5 then
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less5:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	elseif lvl >= 5 and lvl < 10 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less10:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
		elseif lvl >= 10 and lvl < 15 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less15:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	elseif lvl >= 15 and lvl < 20 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less20.Part:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v.Name) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	elseif lvl >= 20 and lvl < 25 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less25.Part:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	elseif lvl >= 25 and lvl < 30 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less30.Part:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	elseif lvl >= 30 then	
		for i,v in pairs(rs.Auras.Water.MagicLvl.Less35.Part:GetChildren()) do
			if not char.UpperTorso:FindFirstChild(v) then
				local clone = v:Clone()
				clone.Parent = char.UpperTorso
			end
		end
	end
end)