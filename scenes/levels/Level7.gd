extends Node3D

func _ready():
	$Spawner._start()
	EventBus.CurrentLevel = "res://scenes/levels/Level7.tscn"
	EventBus._save()
	EventBus._update_presence()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.Reputation == 50:
		SceneManager._change_scene("res://scenes/levels/Level8.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level7.tscn", "day")
