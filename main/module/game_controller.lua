local Game_Data = {}

-- home wifi: 192.168.100.5
-- utb wifi: 172.16.97.17
-- Game_Data.address = "http://192.168.100.4:3000/"
Game_Data.address = "https://tiny-rose-bat-hat.cyclic.app/"
Game_Data.currentUID = ""
Game_Data.userData = {}

Game_Data.publishedGames = {}

Game_Data.gameId = ""
Game_Data.currentGame = {}
Game_Data.currentMapName = ""


Game_Data.questData = {}
Game_Data.questObjects = {}
Game_Data.npcData = {}
Game_Data.itemData = {}
Game_Data.npcGO = {}

function Game_Data.setUID(uid)
	Game_Data.currentUID = uid
end

function Game_Data.setUser(uid, username, fname, lname)
	local gameobject = {
		username = username,
		fname = fname,
		lname = lname
	}

	Game_Data.userData[uid] = gameobject
end

function Game_Data.addGame(gid, title, fname, lname)
	local gameobject = {
		title = title,
		fname = fname,
		lname = lname
	}

	Game_Data.publishedGames[gid] = gameobject
end

function Game_Data.setGameId(game_id)
	Game_Data.gameId = game_id
end

function Game_Data.setCurrentGame(gid, title, lesson, learningoutcomes, player)
	local gameobject = {
		title = title,
		lesson = lesson, 
		learningoutcomes = learningoutcomes, 
		player = player
	}
	Game_Data.currentGame[gid] = gameobject
end

function Game_Data.setMapName(name)
	Game_Data.currentMapName = name
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

function Game_Data.addNPCGO(id, npc_id)
	Game_Data.npcGO[id] = npc_id
end

return Game_Data