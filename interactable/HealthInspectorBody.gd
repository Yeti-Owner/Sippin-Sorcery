extends Interactable

@onready var color := Color(randf(), randf(), randf())
@onready var Dialogue := get_parent().get_node("SpeechBubble")



var Talk:bool = true
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
		# Check if it is just water + flavor
		
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

# Dialogue._talk(Info.Dialog)

func _ask_problem():
	Talk = !Talk
	# Say problem

func _ask_flavors():
	Talk = !Talk
	# Say flavor
