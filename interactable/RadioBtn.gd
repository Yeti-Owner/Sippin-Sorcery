extends Interactable

func get_interaction_text():
	return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=BLACK]change song.[/color][/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	match self.name:
		"BackBtn":
			get_parent()._back()
		"NextBtn":
			get_parent()._next()
	
