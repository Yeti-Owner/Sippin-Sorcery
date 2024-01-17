extends Level


var Stage:int = 0
var BossStage:int = 0

func _start():
	EventBus.connect("BossProblem", _boss_help)
	dialogue._talk(str("[font_size=36]Mistakes happen don't worry about it " + EventBus.PlayerName + ".[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]The same inspector is coming back today you get another chance![/font_size]"), "Bob")
		2:
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"))
			$Spawner._start()
		3:
			dialogue._done()
		4:
			dialogue._talk(str("[font_size=36]Remember " + EventBus.PlayerName + ", search the hunter's trash and find a Nepal Orb.[/font_size]"), "Duane")
		5:
			dialogue._talk(str("[font_size=36]Just one in the juice should work.[/font_size]"))
		6:
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
