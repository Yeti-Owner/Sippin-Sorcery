extends Level

func _start():
	$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.Reputation >= 75:
		SceneManager._change_scene("res://scenes/levels/Level11.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level10.tscn", "day")
