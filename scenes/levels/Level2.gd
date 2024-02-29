extends Level

func _start():
	$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	
	if EventBus.Reputation >= 15:
		SceneManager._change_scene("res://scenes/levels/Level3.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level2.tscn", "day")
	EventBus.emit_signal("Fuck")
