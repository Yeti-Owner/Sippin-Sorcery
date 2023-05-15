extends Node3D

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _tutorial)
	SceneManager.Dialogue._start("Hello! My name is bob the wizard and I am here to help you on your juice making journey!")

func _tutorial():
	Stage += 1
	match Stage:
		1:
			SceneManager.Dialogue._talk("My first lesson is about Lorem Ipsum", 2.5)
		2:
			SceneManager.Dialogue._end()
