extends Node3D

func _ready():
	$Spawner._start()
	EventBus.CurrentLevel = self.scene_file_path
	EventBus._save()
	EventBus._update_presence()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.Reputation == 25:
		SceneManager._change_scene("res://scenes/levels/Level5.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level4.tscn", "day")
