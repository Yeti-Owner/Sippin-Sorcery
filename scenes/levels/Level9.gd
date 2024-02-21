extends Level

var Stage:int = 0

func _start():
	EventBus.BossesBeaten = 3
	dialogue._talk(str("[font_size=36]Another completion for the books " + EventBus.PlayerName + "![/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			$Spawner._start()
			dialogue._talk(str("[font_size=36]That was a tough one but very well done.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]You'll probably attract some new customers after this.[/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]But back to business as usual![/font_size]"))
		4:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level10.tscn", "day")
