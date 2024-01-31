extends Level

var Stage:int = 0

func _start():
	EventBus.BossesBeaten = 2
	dialogue._talk(str("[font_size=36]Thank you " + EventBus.PlayerName + " for playing my game.[/font_size]"), "Callum")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]This is far from done but I think you get the idea.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]I would absolutely love some feedback.[/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]Tell me absolutely everything, what you liked/disliked, what to add/remove, any detail big or small is appreciated.[/font_size]"))
		4:
			dialogue._talk(str("[font_size=36]I hope you enjoyed this, I loved making it.[/font_size]"))
		5:
			dialogue._talk(str("[font_size=36]Here are some more customers, some should be new and unique yet again.[/font_size]"))
		6:
			dialogue._talk(str("[font_size=36]Thank you for playing![/font_size]"), "Callum")
			$Spawner._start()
		7:
			dialogue._done()

func _on_clock_next_day():
	pass
