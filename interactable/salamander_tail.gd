extends Interactable


func get_interaction_text():
	return "[center]Press E to grab [color=DARK_VIOLET]Salamander Tail[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	EventBus.HeldItem = "SalamanderTail"
