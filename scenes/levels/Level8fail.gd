extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level8fail.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Mistakes happen don't worry about it " + EventBus.PlayerName + ".[/font_size]"), "Bob", 2)

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]The same inspector is coming back today you get another chance![/font_size]"), "Bob", 2)
		2:
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"), "Bob", 2)
			$Spawner._start()
		3:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten != 1:
		SceneManager._change_scene("res://scenes/levels/Level9.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level8fail.tscn", "day")
