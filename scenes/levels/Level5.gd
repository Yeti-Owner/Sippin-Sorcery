extends Level

var Stage:int = 0

func _start():
	dialogue._talk(str("[font_size=36]So " + EventBus.PlayerName + "... How's it going?[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]So basically, we've been doing a little too well in the business and to continue we need to pass a health inspection.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]Not to worry though! If we pass I'm sure it'll catch the eyes of new customers.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]We absolutely NEED to pass though, that is a slight problem.[/font_size]"))
		4:
			dialogue._talk(str("[font_size=36]Remember, they don't care about any silly 'regulations' so provide any effects they ask for.[/font_size]"))
			if not (EventBus.UnlockedHelp.has("res://assets/textures/help/HelpPage6.png")):
				EventBus.UnlockedHelp.append("res://assets/textures/help/HelpPage6.png")
		5:
			dialogue._talk(str("[font_size=36]I'm sure you've got it, good luck![/font_size]"))
			$Spawner._start()
		6:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten > 0:
		SceneManager._change_scene("res://scenes/levels/Level6.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level5fail.tscn", "day")
