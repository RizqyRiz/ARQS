local Player = {}

Player.goid = nil
Player.pgid = ""
Player.avatar = {}
Player.stats = {}
Player.location = {}
Player.inventory = {}
Player.quest = {}

function Player.setGoId(goid)
	Player.goid = goid
end

function Player.setLocation(x,y)
	local pos = {
		x = x, 
		y = y
	}
	Player.location = pos
end

function Player.addItem(iid, details)
	local go = {
		details = details
	}
	Player.inventory[iid] = go
end

return Player