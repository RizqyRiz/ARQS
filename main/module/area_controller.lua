local Area_Data = {}

Area_Data.currentRoom = ""
Area_Data.connectors = {}
Area_Data.locationData = {}

function Area_Data.setCurrentRoom(room_id)
	Area_Data.currentRoom = room_id
end

function Area_Data.addConnectors(id, adjacent_area, x, y, direction)
	local gameobject = {
		adjacent_area = adjacent_area,
		x = x,
		y = y,
		direction = direction
	}
	Area_Data.connectors[id] = gameobject
end

function Area_Data.addLocations(loc_id, name, x, y, player_start_point)
	local gameobject = {
		name = name,
		x = x,
		y = y,
		player_start_point = player_start_point
	}
	Area_Data.locationData[loc_id] = gameobject
end

return Area_Data