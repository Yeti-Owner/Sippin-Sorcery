extends Level

var Stage:int = 0

func _start():
	dialogue._talk(str("[font_size=36]I heard the inspector is coming back today.[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]We need you to pass this so we can advertise to new clients.[/font_size]"))
		2:
			$Spawner._start()
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"))
		3:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten >= 0:
		SceneManager._change_scene("res://scenes/levels/Level6.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level5fail.tscn", "day")
	EventBus.emit_signal("Fuck")
