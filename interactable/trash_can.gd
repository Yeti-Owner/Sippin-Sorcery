extends Interactable

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]trash[/color] held item[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	EventBus.HeldItem = null
	EventBus.emit_signal("HeldItemChanged")
 
