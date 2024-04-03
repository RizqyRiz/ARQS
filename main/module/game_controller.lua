local Game_Data = {}

-- home wifi: 192.168.100.4
-- utb wifi: 172.16.97.17
Game_Data.address = "http://localhost:3000/"
Game_Data.gameId = ""
Game_Data.questData = {}
Game_Data.questObjects = {}
Game_Data.npcData = {}
Game_Data.itemData = {}
Game_Data.npcGO = {}

function Game_Data.setGameId(game_id)
	Game_Data.gameId = game_id
end

function Game_Data.setQuestData(initiator_id, quest_id, quest_data)
	local gameobject = {
		quest_id = quest_id,
		quest_data = quest_data
	}
	Game_Data.questData[initiator_id] = gameobject
end

function Game_Data.setQuestObjects(go_id, loc_id, area_id, x, y, foreaft, inside_object, quest_id)
	local gameobject = {
		quest_id = quest_id,
		location = loc_id,
		area = area_id,
		x = x,
		y = y,
		foreaft = foreaft,
		inside_object = inside_object
	}

	Game_Data.questObjects[go_id] = gameobject
end

function Game_Data.addNPCs(npcid, name, background, gender, age, prototype, npc_visuals)
	local gameobject = {
		name = name,
		background = background,
		gender = gender,
		age = age,
		prototype = prototype,
		npc_visuals = npc_visuals
	}

	Game_Data.npcData[npcid] = gameobject
end

function Game_Data.addItems(itemId, name, description, link, readable, destroyable, content, prototype)
	local gameobject = {
		name = name, 
		description = description, 
		link = link, 
		readable = readable, 
		destroyable = destroyable, 
		content = content,
		prototype = prototype
	}
	
	Game_Data.itemData[itemId] = gameobject
end

function Game_Data.addNPCGO(id, npc_id)
	Game_Data.npcGO[id] = npc_id
end

return Game_Data