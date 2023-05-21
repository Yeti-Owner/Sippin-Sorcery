extends Interactable

func get_interaction_text():
	return "[center]Press E to [rainbow freq=0.3 sat=0.8 val=0.8]Grab Journal[/rainbow][/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	EventBus.JournalToggle.emit(true)

func _on_area_3d_body_exited(body):
	if body.name == "Player":
		EventBus.JournalToggle.emit(false)
