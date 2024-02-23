extends Level

var Stage:int = 0

func _start():
	EventBus.BossesBeaten = 3
	dialogue._talk(str("[font_size=36]Thank you " + EventBus.PlayerName + " for playing my game.[/font_size]"), "Callum")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]I hope you enjoyed this, I enjoyed making it.[/font_size]"))
			$Spawner._start()
		2:
			dialogue._talk(str("[font_size=36]I would absolutely love some feedback. Tell me everything, what you liked/disliked, what to add/remove, any detail big or small is appreciated.[/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]I plan to add more customers, days, health inspectors, and more.[/font_size]"))
		4:
			dialogue._talk(str("[font_size=36]Thank you so much for playing![/font_size]"), "Callum")
		5:
			dialogue._talk(str("[font_size=36]Here's some new customers, have fun![/font_size]"), "Callum")
		6:
			dialogue._done()

func _on_clock_next_day():
	pass
