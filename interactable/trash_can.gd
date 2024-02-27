extends Interactable

const BannedList := ["Frog","NepalOrb","Lasagna"]

func _ready():
	randomize()

func get_interaction_text():
	if EventBus.HeldItem == null:
		return "[center][color=BLACK]Trash[/color][/center]"
	else:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]trash[/color] held item[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if (EventBus.HeldItem != null) and not (BannedList.has(EventBus.HeldItem)):
		$TrashSound.pitch_scale = randf_range(0.8, 1)
		$TrashSound.play()
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
		_reset()
 
