extends Interactable

@onready var Apparation := preload("res://scenes/apparation.tscn")
var GivenFrog:bool = false

func _ready():
	randomize()
	var a := Apparation.instantiate()
	add_child(a)

func get_interaction_text():
	if (EventBus.HeldItem == null) or (EventBus.HeldItem == "Frog"):
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=GREEN]talk[/color] to Witch[/center]"
	else:
		return "[center][color=GREEN]Witch[/color][/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if (EventBus.HeldItem == null and GivenFrog == false):
#		$WitchSound.pitch_scale = randf_range(0.8, 1)
#		$WitchSound.play()
		$SpeechBubble._talk("Get me a frog and I'll share my Lasagna.")
	elif (EventBus.HeldItem == "Frog" and GivenFrog == false):
		GivenFrog = true
#		$WitchSound.pitch_scale = randf_range(0.8, 1)
#		$WitchSound.play()
		$SpeechBubble._talk("Thanks! Feel free to take a slice.")
		EventBus.emit_signal("RemoveBarrier")
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
	else:
		$SpeechBubble._talk("Feel free to take a slice of the Lasagna.")

func _process(_delta):
	if get_node_or_null(EventBus.PlayerPath) != null:
		$BodyMeshes/LookMeshes.look_at(get_node(EventBus.PlayerPath).position)
