extends Node3D

func _on_loading_screen_loading_done():
	EventBus.Fade.emit(true)

func _on_clock_next_day():
	EventBus.Fade.emit(false)
	$TempTimer.start()

func _on_temp_timer_timeout():
	if EventBus.Reputation == 25:
		pass # go to level 3
	else:
		get_tree().change_scene_to_file("res://scenes/levels/Level2.tscn")
