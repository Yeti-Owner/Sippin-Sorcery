extends Interactable

var CharName:String
var color

func get_interaction_text():
	if EventBus.HeldItem == "Juice":
		return str("[center]Press E to give juice to [color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if EventBus.HeldItem == "Juice":
		get_parent()._finished(_check_success())
		
		EventBus.HeldEffect = null
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")

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
	if success > 0 and not all_need_present:
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
	EventBus.Balance += Bonus
	EventBus.emit_signal("BalanceChanged")
	
	return success
