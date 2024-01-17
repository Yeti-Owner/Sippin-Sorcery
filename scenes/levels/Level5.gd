extends Level

var Stage:int = 0

func _start():
	dialogue._talk(str("[font_size=36]Hey " + EventBus.PlayerName + ", remember how I said those ministry people would be the last of our troubles?[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]I lied.[/font_size]"), "Bob", 1)
		2:
			dialogue._talk(str("[font_size=36]So basically we've been doing a little too well in the business and to continue on we have to pass a health inspection.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]Not to worry though! If we pass I'm sure it'll catch the eyes of new customers.[/font_size]"), "Bob")
		4:
			dialogue._talk(str("[font_size=36]We do need to pass though, that is a slight problem.[/font_size]"))
		5:
			dialogue._talk(str("[font_size=36]Remember they don't care about any silly 'regulations' so provide any effects they ask for.[/font_size]"))
		6:
			dialogue._talk(str("[font_size=36]I'm sure you've got it, good luck![/font_size]"))
			$Spawner._start()
		7:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten != 0:
		SceneManager._change_scene("res://scenes/levels/Level6.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level5fail.tscn", "day")
