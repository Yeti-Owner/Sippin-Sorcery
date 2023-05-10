extends Interactable

var CharName:String
var color

func get_interaction_text():
	return str("[center][color=" + str(color.to_html()) + "] " + str(CharName) + "[/color][/center]")

func get_interaction_icon():
	return EventBus.CrosshairTex

func interact():
	pass
