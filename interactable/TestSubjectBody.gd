extends Interactable

@onready var color := Color(randf(), randf(), randf())
var CharName := ["Jack", "Emily", "Thomas", "Jessica", "James", "Charlotte", "Daniel", "Sophie", "Joshua", "Olivia", "Matthew", "Emma", "William", "Hannah", "Joseph", "Amy", "Benjamin", "Lucy", "Samuel", "Rebecca", "David", "Megan", "Oliver", "Lauren", "Christopher", "Katie", "Alexander", "Ellie", "Ryan", "Grace"]
var Char:String = CharName[randi() % CharName.size()]

func _ready():
	randomize()

func get_interaction_text():
	if EventBus.HeldItem == "Juice":
		return str("[center]Press E to test juice with [color=" + str(color.to_html()) + "] " + Char + "[/color][/center]")
	else:
		return str("[center][color=" + str(color.to_html()) + "] " + Char + "[/color][/center]")

func get_interaction_icon():
	return EventBus.ActionTex

func interact():
	if EventBus.HeldItem == "Juice":
		_test_juice(EventBus.HeldEffect)
		EventBus.HeldEffect = null
		EventBus.HeldItem = null
		EventBus.emit_signal("HeldItemChanged")

func _test_juice(effects:Array):
	print(effects)
	
	$Timer.start()

func _record_journal():
	pass
