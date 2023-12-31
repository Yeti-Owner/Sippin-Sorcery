extends Interactable

@onready var LeaveTimer := get_parent().get_node("LeaveTimer")

var CharName:String
var color
var Talk:bool = true
var Used:bool = false

func get_interaction_text():
	if EventBus.HeldItem == "Juice" and Used == false:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to give juice to [color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if Used == true:
		return
	
	if EventBus.HeldItem == "Juice":
		LeaveTimer.stop()
		get_parent()._finished(_check_success(), _check_flavor())
		
		EventBus.HeldEffect = null
		EventBus.HeldFlavor = ""
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
		Used = true
	else:
		if Talk:
			_ask_flavors()
		else:
			_ask_problem()
	

func _check_success() -> int:
	var success = 0
	var need = get_parent().Info.Need
	var bonus = get_parent().Info.Bonus
	var held_effects = EventBus.HeldEffect
	
	# Check if all strings in "need" are present in "held_effects"
	var all_need_present = true
	for string in need:
		if not held_effects.has(string):
			all_need_present = false
			break
	
	if all_need_present == true:
		success = 1
	
	# Check each held effect for bonus/penalty
	for string in held_effects:
		if bonus.has(string):
			success += 1
		elif need.has(string):
			success = success
		else:
			success -= 1
	
	# Make sure success is at most 0 if needed strings are missing
	if success > 0 and all_need_present == false:
		success = 0
	
	# Determine Reward
	@warning_ignore("unused_variable")
	var Budget = get_parent().Info.Budget
	var Bonus = Budget
	if success > 1:
		var Reward:int = success - 1
		
		while Reward > 0:
			Bonus += (Budget*0.35)
			Reward -= 1
	
	
	# Apply Bonus
	if all_need_present == false:
		Bonus = 0
	EventBus.Balance += Bonus
	EventBus.emit_signal("BalanceChanged")
	
	success = max(success, -1)
	return success

func _check_flavor():
	# There must be a better way but idfk
	@warning_ignore("unassigned_variable")
	var FlavorList:Array
	if get_parent().Info.Strawberry:
		FlavorList.append("Strawberry")
	if get_parent().Info.Banana:
		FlavorList.append("Banana")
	if get_parent().Info.Pineapple:
		FlavorList.append("Pineapple")
	if get_parent().Info.Blueberry:
		FlavorList.append("Blueberry")
	if get_parent().Info.Watermelon:
		FlavorList.append("Watermelon")
	if get_parent().Info.Orange:
		FlavorList.append("Orange")
	
	var success := false
	if FlavorList.has(EventBus.HeldFlavor):
		success = true
		# Player is rewarded a lil for getting at least flavor right
		EventBus.Balance += (randi() % 4 + 1)
		EventBus.emit_signal("BalanceChanged")
	
	return success

func _ask_flavors():
	Talk = !Talk
	var FlavorPreference:String
	
	@warning_ignore("unassigned_variable")
	var FlavorList:Array
	if get_parent().Info.Strawberry:
		FlavorList.append("Strawberry")
	if get_parent().Info.Banana:
		FlavorList.append("Banana")
	if get_parent().Info.Pineapple:
		FlavorList.append("Pineapple")
	if get_parent().Info.Blueberry:
		FlavorList.append("Blueberry")
	if get_parent().Info.Watermelon:
		FlavorList.append("Watermelon")
	if get_parent().Info.Orange:
		FlavorList.append("Orange")
	
	if FlavorList.size() == 1:
		FlavorPreference = str("I like " + FlavorList[0])
	elif FlavorList.size() == 2:
		FlavorPreference = str("I like " + FlavorList[0] + " and " + FlavorList[1])
	else:
		FlavorPreference = "I like "
		for taste in FlavorList.size():
			if FlavorList.size() > 1:
				FlavorPreference += str(FlavorList.pop_front() + ", ")
			else:
				FlavorPreference += str("and " + FlavorList.pop_front())
	
	get_parent().Dialogue._talk(FlavorPreference)

func _ask_problem():
	Talk = !Talk
	get_parent().Dialogue._talk(get_parent().Info.Dialog)
