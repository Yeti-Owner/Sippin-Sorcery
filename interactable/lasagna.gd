extends Interactable

func _ready():
	randomize()

func get_interaction_text():
	if EventBus.HeldItem != null:
		return "[center][color=YELLOW]Lasagna[/color][/center]"
	else:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=YELLOW]grab[/color] Lasagna[/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if EventBus.HeldItem == null:
		$GrabSound.pitch_scale = randf_range(0.8, 1)
		$GrabSound.play()
		EventBus.HeldItem = "Lasagna"
		EventBus.emit_signal("HeldItemChanged")
		_reset()
 
