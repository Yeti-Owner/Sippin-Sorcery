extends Interactable


func get_interaction_text():
	return "[center]Press E to [color=BLACK]trash[/color] held item[/center]"

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	EventBus.HeldItem = null
	EventBus.emit_signal("HeldItemChanged")
 
