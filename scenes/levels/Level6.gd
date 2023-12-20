extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

func _ready():
	EventBus.BossesBeaten = 1
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level6.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Congrats " + EventBus.PlayerName + ", we passed inspection and it's marked on your ID card![/font_size]"), "Bob", 4)

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Very well done.[/font_size]"), "Bob")
		2:
			dialogue._talk(str("[font_size=36]I think I've taught you just about everything now.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]It's up to you now to keep the shop running even as you encounter more difficult customers.[/font_size]"), "Bob")
		4:
			dialogue._talk(str("[font_size=36]I wish you luck, goodbye for now friend![/font_size]"), "Bob", 4)
		5:
			dialogue._done()
			$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level7.tscn", "day")
