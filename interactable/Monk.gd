extends Interactable

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]talk[/color] to Alton[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	pass
 
