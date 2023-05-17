extends Node3D

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _tutorial)
	SceneManager.Dialogue._start("[font_size=48]Hello! My name is bob the wizard and I am here to help you on your juice making journey![/font_size]", "[font_size=26]Bob[/font_size]", "res://assets/textures/Wizard.png", 1.5)

func _tutorial():
	Stage += 1
	match Stage:
		1:
			SceneManager.Dialogue._talk("[font_size=48]My first lesson is about your journal. Open it up and look at the ingredient list.[/font_size]", 3)
		2:
			SceneManager.Dialogue._end()
