extends Interactable

var CharName:String

func get_interaction_text():
	return str("[center][color=cyan] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.CrosshairTex

func interact():
	pass
