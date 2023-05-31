extends Node3D

@onready var dialogue := get_node(EventBus.Dialogue)

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _tutorial)

func _tutorial():
	Stage += 1
	match Stage:
		1:
			dialogue._talk("[font_size=48]My first lesson is about your journal. Open it up and look at the ingredient list.[/font_size]", 2)
		2:
			dialogue._end()

func _on_loading_screen_loading_done():
	dialogue._start("[font_size=48]Hello! My name is bob the wizard and I am here to help you on your juice making journey![/font_size]", "[font_size=26]Bob[/font_size]", "res://assets/textures/Wizard.png", 2)
