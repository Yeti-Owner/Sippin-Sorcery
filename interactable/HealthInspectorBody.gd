extends Interactable

@onready var color := Color(randf(), randf(), randf())
@onready var Dialogue := get_parent().get_node("SpeechBubble")
const Flavors := ["Strawberry","Watermelon","Orange","Blueberry","Pineapple","Banana"]
@onready var Flavor:String = Flavors[randi() % Flavors.size()]
var Talk:bool = false
var Used:bool = false

func get_interaction_text():
	if EventBus.HeldItem == "Juice" and Used == false:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to give juice to [color=" + str(color.to_html()) + "] " + str(get_parent().CharName) + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + str(get_parent().CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if Used == true:
		return
	
	if EventBus.HeldItem == "Juice":
		_check(EventBus.HeldEffect, EventBus.HeldFlavor)
		
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

func _ask_problem():
	Talk = !Talk
	Dialogue._talk(get_parent().Problem)

func _ask_flavors():
	Talk = !Talk
	Dialogue._talk(str("I would like " + Flavor + " please."))

# Check if it is just water + flavor
func _check(effects, flavor:String):
	var CorrectFlavor:bool = (flavor == Flavor)
	var success:bool = false
	if (effects.size() == 1) and (effects[0] == "water"):
		success = true
	
	get_parent()._result(success, CorrectFlavor)
