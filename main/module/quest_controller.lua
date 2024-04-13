local Quest_Data = {}

Quest_Data.questList = {}
Quest_Data.npcList = {}
Quest_Data.itemList = {}
Quest_Data.propList = {}

--
-- start of add functions
--
function Quest_Data.addQuest(initiator_id, quest_id, quest_data, quest_order, started, completed)
	local gameobject = {
		initiator_id = initiator_id,
		quest_data = quest_data,
		quest_order = quest_order,
		started = started,
		completed = completed
	}
	Quest_Data.questList[quest_id] = gameobject
end

function Quest_Data.addNPC(qid, npcid, name, background, gender, age, prototype, npc_visuals)
	local npcqid = npcid .. qid
	local gameobject = {
		qid = qid,
		npcid = npcid,
		name = name,
		background = background,
		gender = gender,
		age = age,
		prototype = prototype,
		npc_visuals = npc_visuals
	}

	Quest_Data.npcList[npcqid] = gameobject
end

function Quest_Data.addItem(qid, iid, name, description, link, readable, destroyable, content, prototype)
	local iqid = iid .. qid
	local gameobject = {
		qid = qid,
		iid = iid,
		name = name, 
		description = description, 
		link = link, 
		readable = readable, 
		destroyable = destroyable, 
		content = content,
		prototype = prototype
	}

	Quest_Data.itemList[iqid] = gameobject
end

function Quest_Data.addProp(qid, oid, name, description, prototype)
	local oqid = oid .. qid
	local gameobject = {
		qid = qid,
		oid = oid,
		name = name, 
		description = description,
		prototype = prototype
	}

	Quest_Data.propList[oqid] = gameobject
end
--
-- end of add functions
--

--
-- start of setter functions
--
function Quest_Data.startQuest(quest_id, started)
	local quest = Quest_Data.questList[quest_id]
	if quest then
		quest.started = started
	end
end

function Quest_Data.completeQuest(quest_id, completed)
	local quest = Quest_Data.questList[quest_id]
	if quest then
		quest.completed = completed
	end
end
--
-- end of setter functions
--


--
-- start of getter functions
--
function Quest_Data.getCurrentQuest()
	local current_quest_id = nil
	local current_quest = nil
	local go = {}

	for i, v in pairs(Quest_Data.questList) do
		--print(i, v.quest_order, v.completed)
		if v.started and not v.completed then
			current_quest_id = i
			current_quest = v
		end
	end

	if current_quest_id then
		go[current_quest_id] = current_quest
		return next(go)
	else
		return nil
	end
end

function Quest_Data.getNextQuest()
	local next_quest = nil
	local next_quest_id = nil
	local go = {}

	for i, v in pairs(Quest_Data.questList) do
		if not v.started and not v.completed then
			if not next_quest or v.quest_order < next_quest.quest_order then
				next_quest = v
				next_quest_id = i
			end
		end
	end

	if next_quest_id then
		go[next_quest_id] = next_quest
		return next(go)
	else
		return nil
	end
end
--
-- end of getter functions
--

return Quest_Data