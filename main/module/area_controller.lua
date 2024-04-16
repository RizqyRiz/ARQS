local Area_Data = {}

Area_Data.currentLocationName = ""
Area_Data.currentRoom = ""
Area_Data.currentRoomName = ""
Area_Data.currentLevel = ""
Area_Data.connectors = {}
Area_Data.locationData = {}
Area_Data.roomHeight = nil
Area_Data.objectList = {}

function Area_Data.setCurrentLocationName(name)
	Area_Data.currentLocationName = name
end

function Area_Data.setCurrentRoom(room_id)
	Area_Data.currentRoom = room_id
end

function Area_Data.setCurrentRoomName(name)
	Area_Data.currentRoomName = name
end

function Area_Data.setCurrentLevel(level)
	Area_Data.currentLevel = level
end

function Area_Data.setRoomHeight(height)
	Area_Data.roomHeight = height
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

function Area_Data.addObjects(id, x, y, foreaft)
	local gameobject = {
		x = x,
		y = y,
		foreaft = foreaft
	}
	Area_Data.objectList[id] = gameobject
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