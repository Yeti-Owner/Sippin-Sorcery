extends Node3D

func _ready():
	$Spawner._start()
	EventBus.CurrentLevel = "res://scenes/levels/Level2.tscn"
	EventBus._save()
	EventBus._discord_presence()

func _on_loading_screen_loading_done():
	EventBus.Fade.emit("day")

func _on_clock_next_day():
	EventBus.Fade.emit("out")
	$TempTimer.start()
	EventBus.DayNum += 1

func _on_temp_timer_timeout():
	if EventBus.Reputation == 15:
		get_tree().change_scene_to_file("res://scenes/levels/Level3.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/levels/Level2.tscn")
