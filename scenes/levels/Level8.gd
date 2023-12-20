extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level5.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]We've got another inspection today " + EventBus.PlayerName + ".[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Keep up the great work and I'm not worried at all![/font_size]"), "Bob", 1.5)
		2:
			dialogue._done()
			$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten != 1:
		SceneManager._change_scene("res://scenes/levels/Level9.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level8fail.tscn", "day")
