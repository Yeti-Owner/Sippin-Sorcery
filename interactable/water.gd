extends Interactable

var WaterColor := Color(0, 0.5686274766922, 0.75686275959015)

func get_interaction_text():
	if EventBus.HeldItem == null:
		return str("[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to grab [color=" + str(WaterColor.to_html()) + "]Water[/color][/center]")
	elif EventBus.HeldItem == "Water":
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=" + str(WaterColor.to_html()) + "]put it back[/color][/center]"
	else:
		return "[center]your hands are [color=" + str(WaterColor.to_html()) + "]full[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if EventBus.HeldItem == null:
		$GlassSound.pitch_scale = randf_range(1.01, 1.2)
		$GlassSound.play()
		EventBus.HeldItem = "Water"
		EventBus.emit_signal("HeldItemChanged")
	elif EventBus.HeldItem == "Water":
		$GlassSound.pitch_scale = randf_range(0.8, 0.99)
		$GlassSound.play()
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")
	_reset()
