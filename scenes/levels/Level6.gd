extends Level

var Stage:int = 0

func _start():
	EventBus.BossesBeaten = 1
	dialogue._talk(str("[font_size=36]Congrats " + EventBus.PlayerName + " we passed inspection! It's marked on your ID card.[/font_size]"), "Bob")
	EventBus.connect("DayDone", _customers_done)

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]I think I've taught you just about everything now.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]It's up to you now to keep the shop running even as you encounter more difficult customers.[/font_size]"))
		3:
			$Spawner._start()
			dialogue._talk(str("[font_size=36]I wish you luck, goodbye for now friend![/font_size]"))
		4:
			$DelayTimer.start()
			dialogue._done()
			$Spawner._start()
		5:
			dialogue._talk(str("[font_size=36]Before the day ends I wish to speak to you.[/font_size]"), "Alton")
		6:
			dialogue._done()
		7:
			dialogue._talk(str("[font_size=36]Hello " + EventBus.PlayerName + ", I am but a humble man who seeks to help you.[/font_size]"), "Alton")
		8:
			dialogue._talk(str("[font_size=36]I can help you clarify any confusing entries in your journal.[/font_size]"))
		9:
			dialogue._talk(str("[font_size=36]I don't give charity however, it will not be for free.[/font_size]"))
		10:
			dialogue._talk(str("[font_size=36]Find me tomorrow, it is late and I grow tired.[/font_size]"))
		11:
			EventBus.MetAlton = true
			if not (EventBus.UnlockedHelp.has("res://assets/textures/help/HelpPage7.png")):
				EventBus.UnlockedHelp.append("res://assets/textures/help/HelpPage7.png")
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level7.tscn", "day")

func _on_delay_timer_timeout():
	_level()

func _customers_done():
	_level()
