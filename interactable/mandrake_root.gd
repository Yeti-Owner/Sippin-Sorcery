extends Interactable


func get_interaction_text():
	return "[center]Press E to grab [color=cyan]Mandrake Root[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	EventBus.HeldItem = "MandrakeRoot"
