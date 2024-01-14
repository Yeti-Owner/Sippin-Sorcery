extends Interactable

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to open [color=YELLOW]order form[/color][/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	EventBus.OrderFormToggle.emit(true)

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		EventBus.OrderFormToggle.emit(false)
