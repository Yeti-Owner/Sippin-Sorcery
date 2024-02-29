extends Level

func _start():
	$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.Reputation == 50:
		SceneManager._change_scene("res://scenes/levels/Level8.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level7.tscn", "day")
	EventBus.emit_signal("Fuck")
