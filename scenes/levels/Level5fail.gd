extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = self.scene_file_path
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]I heard news that the inspector is coming back today " + EventBus.PlayerName + ".[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]We need you to pass this so we can advertise to new clients.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"))
		3:
			dialogue._done()
			$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten != 0:
		SceneManager._change_scene("res://scenes/levels/Level6.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level5fail.tscn", "day")
