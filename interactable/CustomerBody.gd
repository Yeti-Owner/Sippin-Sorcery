extends Interactable

var CharName:String
var color

func get_interaction_text():
	if EventBus.HeldItem == "Juice":
		return str("[center]Press E to give juice to [color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.CrosshairTex

func interact():
	if EventBus.HeldItem == "Juice":
		for ingredient in get_parent().Info.Need:
			if not EventBus.HeldEffect.has(ingredient):
				_fail()
				return
		_success()
 
func _fail():
	print("Failed")
	EventBus.HeldEffect = null
	EventBus.HeldItem = null
	EventBus.emit_signal("HeldItemChanged")

func _success():
	var reward = get_parent().Info.Budget
	for ingredient in get_parent().Info.Bonus:
		if EventBus.HeldEffect.has(ingredient):
			reward = reward + (reward*0.5)
	print("Succeeded with $" + str(reward))
	EventBus.HeldEffect = null
	EventBus.HeldItem = null
	EventBus.emit_signal("HeldItemChanged")
