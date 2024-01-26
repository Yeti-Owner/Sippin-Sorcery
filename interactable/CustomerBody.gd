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
	# return 0, 1, 2 for bad, okay, good
	# return 0 if needs not met, 1 if they are, 2 if met + some bonus
	
	var Success:int = 1
	var Budget:int = get_parent().Info.Budget
	var Reward:int = 0 # Used to calculate Reward value
	var HeldEffects:Array = EventBus.HeldEffect # Effects given to customer
	
	# Get from CustomerSheet then sort, resource script does heavy lifting
	var Judgement:Array = get_parent().Info._get_judgement()
	var Bad:Array = Judgement[0]
	var Bonus:Array = Judgement[1]
	var NeedOr:Array = Judgement[2]
	var NeedAnd:Array = Judgement[3]
	
	while (NeedAnd.size() > 0):
		if HeldEffects.has(NeedAnd[0]):
			Reward += 1
		else:
			Success = 0
		NeedAnd.pop_front()
	
	var Count:int = 0
	for i in NeedOr:
		if HeldEffects.has(i):
			Count += 1
	if (Count == 0) and (NeedOr.size() > 0):
		Success = 0
	elif (Count > 0):
		Reward += Count
	
	# Check all HeldEffects for Bonus/Bad then apply to BonusReward
	var Rating:int = 0
	for i in HeldEffects:
		if Bonus.has(i):
			Rating += 1
		elif Bad.has(i):
			Rating -= 1
	
	# Success = 2 if rating > 0, if success 0 it is unchanged
	Success *= (clampi(Rating, 0, 1) + 1)
	
	# Add to Bonus reward if good
	Reward += clampi(Rating, 0, 10)
	
	# give money based off Reward and Budget
	if (Success > 0):
		var Payment:float = float(Reward) / 1.5
		Payment *= Budget
		Payment += (float(Budget) / 1.5)
		
		# Seems like a lot but it's fair since you pay to restock items
		@warning_ignore("narrowing_conversion")
		EventBus.Balance += ceilf(Payment) # just in case
	
	EventBus.emit_signal("BalanceChanged")
	return Success


func _check_flavor():
	var FlavorList:Array = get_parent().Info._get_flavors()
	
	var success := false
	if FlavorList.has(EventBus.HeldFlavor):
		success = true
		# Player is rewarded between 4 and 7 just for flavor
		EventBus.Balance += (randi() % 3 + 4)
		EventBus.emit_signal("BalanceChanged")
	
	return success

func _ask_flavors():
	Talk = !Talk
	var FlavorPreference:String = ""
	var FlavorList:Array = get_parent().Info._get_flavors()
	var FlavorPrefix:String = get_parent().Info.TastePrefix
	
	if FlavorList.size() == 1:
		FlavorPreference = str(FlavorPrefix + FlavorList[0] + ".")
	elif FlavorList.size() == 2:
		FlavorPreference = str(FlavorPrefix + FlavorList[0] + " and " + FlavorList[1] + ".")
	elif FlavorList.size() == 6:
		FlavorPreference = str(FlavorPrefix + "any flavor.")
	else:
		FlavorPreference = FlavorPrefix
		for taste in FlavorList.size():
			if FlavorList.size() > 1:
				FlavorPreference += str(FlavorList.pop_front() + ", ")
			else:
				FlavorPreference += str("and " + FlavorList.pop_front() + ".")
	
	get_parent().Dialogue._talk(FlavorPreference)

func _ask_problem():
	Talk = !Talk
	get_parent().Dialogue._talk(get_parent().Info.Dialog)
