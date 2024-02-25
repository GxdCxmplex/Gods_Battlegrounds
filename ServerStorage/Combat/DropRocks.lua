local Rock = {}
function Rock.New(parent, Num, Size,T, custom)
	game.ReplicatedStorage.Powers.DropRocks:FireAllClients(parent, Num, Size, T, custom)
end

return Rock
