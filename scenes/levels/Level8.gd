extends Level

var Stage:int = 0
var BossStage:int = 0

func _start():
	EventBus.connect("BossProblem", _boss_help)
	dialogue._talk(str("[font_size=36]We've got another inspection today " + EventBus.PlayerName + ".[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Keep up the great work and I'm not worried at all![/font_size]"), "Bob", 1.5)
		2:
			dialogue._done()
			$Spawner._start()
		3:
			dialogue._talk(str("[font_size=36]Hey I couldn't help but notice you have a small problem.[/font_size]"), "Duane")
		4:
			dialogue._talk(str("[font_size=36]I'm vaguely familiar with all the ingredients behind you and none could turn someone to a monkey.[/font_size]"))
		5:
			dialogue._talk(str("[font_size=36]Of course I'll help you, but you'll owe me. Deal?[/font_size]"))
		6:
			dialogue._talk(str("[font_size=36]Fine, what do I do?[/font_size]"), "Self")
		7:
			dialogue._talk(str("[font_size=36]Somewhere in this town is a hunter, search his trash and find a Nepal Orb.[/font_size]"), "Duane")
		8:
			dialogue._talk(str("[font_size=36]One orb should do the job, better hurry![/font_size]"))
		9:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten != 1:
		SceneManager._change_scene("res://scenes/levels/Level9.tscn", "day")
	else:
		SceneManager._change_scene("res://scenes/levels/Level8fail.tscn", "day")

func _boss_help():
	if BossStage == 0:
		BossStage += 1
		$MiscTimer.start()

func _on_misc_timer_timeout():
	_level()
