extends Level

func _start():
	$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	# SceneManager._change_scene("res://scenes/levels/Level10.tscn", "day")
	if EventBus.Reputation == 75:
		pass # Goto 11
	else:
		SceneManager._change_scene("res://scenes/levels/Level10.tscn", "day")
