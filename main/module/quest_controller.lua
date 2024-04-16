local Quest_Data = {}

Quest_Data.questList = {}
Quest_Data.activeQuest = {}
Quest_Data.availableQuest = {}

Quest_Data.npcList = {}
Quest_Data.itemList = {}
Quest_Data.propList = {}
Quest_Data.npcGoList = {}
Quest_Data.itemGoList = {}
Quest_Data.propGoList = {}

Quest_Data.inventory = {}

Quest_Data.questCompleteTarget = ""
Quest_Data.npcqid = ""
Quest_Data.npcDialog = {}
Quest_Data.itemDialog = {}

Quest_Data.event_outcome = {}
Quest_Data.quest_success_name = ""
Quest_Data.quest_success_dialog = ""

--
-- start of add functions
--
function Quest_Data.addQuest(initiator_id, quest_id, quest_name, quest_scenario, quest_actions, quest_data, quest_order, started, completed)
	local gameobject = {
		initiator_id = initiator_id,
		quest_name = quest_name,
		quest_scenario = quest_scenario,
		quest_actions = quest_actions,
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

function Quest_Data.addNPCGO(goid, npcid)
	Quest_Data.npcGoList[goid] = npcid
end

function Quest_Data.addItemGO(goid, iid)
	Quest_Data.itemGoList[goid] = iid
end

function Quest_Data.addPropGO(goid, oid)
	Quest_Data.propGoList[goid] = oid
end

function Quest_Data.addToInventory(iqid, iid, item)
	Quest_Data.inventory[iid] = item
	Quest_Data.itemList[iqid] = nil
end
--
-- end of add functions
--

--
-- start of setter functions
--
function Quest_Data.setNPCQID(npcqid)
	Quest_Data.npcqid = npcqid
end

function Quest_Data.startQuest(quest_id, started)
	local quest = Quest_Data.questList[quest_id]
	if quest then
		quest.started = started
	end
	Quest_Data.activeQuest[quest_id] = quest
	--pprint(quest.quest_data["tasks"][1]["events"])
	for _, v in pairs(quest.quest_data["tasks"][1]["events"]) do
		-- v contains the events where type is initiate, correct_item, wrong_item
		if v.type == "required_item" then
			-- pprint("Target:",v.target_1)
			Quest_Data.questCompleteTarget = v.target_1
		end
	end
end

function Quest_Data.completeQuest(quest_id, completed)
	local quest = Quest_Data.questList[quest_id]
	if quest then
		quest.completed = completed
	end
	-- table.remove(Quest_Data.activeQuest, 1)
	-- Quest_Data.availableQuest = {}
	Quest_Data.activeQuest = {}
	Quest_Data.availableQuest = {}
end

function Quest_Data.setAvailableQuest()
	local qid = ""
	local quest_list = Quest_Data.questList
	local sorted_quest_list = {}


	for qid, quest in pairs(quest_list) do
		if not quest.started and not quest.completed then
			table.insert(sorted_quest_list, {qid = qid, quest = quest})
		end
	end
	
	local function compare(a, b)
		return a.quest.quest_order < b.quest.quest_order
	end

	if next(sorted_quest_list) == nil then
		return nil
	else
		table.sort(sorted_quest_list, compare)

		qid = sorted_quest_list[1].qid
		Quest_Data.availableQuest[qid] = sorted_quest_list[1].quest
		-- pprint(sorted_quest_list[1].quest)

		return next(Quest_Data.availableQuest)
	end
end

function Quest_Data.setNPCDialog(name,dialog)
	Quest_Data.npcDialog = {name = name, dialog = dialog}
end

function Quest_Data.setItemDialog(iid, name, dialog)
	Quest_Data.itemDialog = {iid = iid, name = name, dialog = dialog}
end
--
-- end of setter functions
--


--
-- start of getter functions
--
function Quest_Data.getActiveQuest()
	return next(Quest_Data.activeQuest)
end

function Quest_Data.getAvailableQuest()
	if next(Quest_Data.availableQuest) == nil then
		return Quest_Data.setAvailableQuest()
	else
		return next(Quest_Data.availableQuest)
	end
end

function Quest_Data.getQuestNPC(npcqid)
	return next(Quest_Data.npcList[npcqid])
end

function Quest_Data.getRequiredItems(quest_data)
	local required_items = {}

	for _, task in pairs(quest_data["tasks"]) do
		if task["rules"] then
			for _, rule in ipairs(task["rules"]) do
				if rule["items"] then
					for _, item_id in ipairs(rule["items"]) do
						table.insert(required_items, item_id)
					end
				end
			end
		end
	end

	return required_items
end

function Quest_Data.getEventOutcomes(qid, event_sequence)
	local correct = {}
	local wrong = {}
	
	for _, v in pairs(event_sequence) do
		-- v contains the events where type is initiate, correct_item, wrong_item
		if v.type == "required_item" then
			correct = v.events

--			Quest_Data.quest_success_name = Quest_Data.npcList[v.target_1 .. qid].name
--			Quest_Data.quest_success_dialog = v.dialog
		elseif v.type == "wrong_item" then
			wrong = v.events
		end
	end

	local event_outcome = {correct = correct, wrong = wrong}
	
	return event_outcome
end

function Quest_Data.checkQuestCompletion(qid, quest_data, items, can_hand_in)
	local correct_event_sequence = {}
	local wrong_event_sequence = {}
	local submitted_items = {}
	local required_items = Quest_Data.getRequiredItems(quest_data)
	local is_equal = true

	Quest_Data.event_outcome = Quest_Data.getEventOutcomes(qid, quest_data["tasks"][1]["events"])

	--print(quest.quest_name)

	for _, item in pairs(items) do
		table.insert(submitted_items, item.iid)
	end

	if #submitted_items ~= #required_items then
		return false
	else
		table.sort(submitted_items)
		table.sort(required_items)

		for i, v in ipairs(submitted_items) do
			if v ~= required_items[i] then
				is_equal = false
			end
		end

		if is_equal and can_hand_in then
			Quest_Data.completeQuest(qid, true)
			--Quest_Data.setCompleteQuestNotice(quest_name, event_outcome.correct)
			--pprint(event_outcome)
			return true
		else
			--print("Incorrect items!")
			return false
		end
	end
end
--
-- end of getter functions
--

return Quest_Data