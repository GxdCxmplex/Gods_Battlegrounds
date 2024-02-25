local Kill = {}

Kill.Template = {}
function Kill:AddTag(player, enemy, hum, dmg : NumberValue)
	if Kill.Template[enemy.UserId] == nil then Kill.Template[enemy.UserId] = {} end
	if Kill.Template[enemy.UserId][player.UserId] == nil then Kill.Template[enemy.UserId][player.UserId] = {Dmg = 0, Status = "", UserId = player.UserId} end
	if hum.Health - dmg > 0 then
		Kill.Template[enemy.UserId][player.UserId]["Dmg"] += dmg
		Kill.Template[enemy.UserId][player.UserId]["Status"] = "Hit"
	else
		Kill.Template[enemy.UserId][player.UserId]["Dmg"] += dmg
		Kill.Template[enemy.UserId][player.UserId]["Status"] = "Kill"
	end
end

function Kill:RequireTemplate(player)
	return Kill.Template[player.UserId]
end

function Kill:Clear(player)
	Kill.Template[player.UserId] = {}
end

return Kill
