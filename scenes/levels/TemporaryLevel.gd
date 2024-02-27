extends Level

var Stage:int = 0

func _start():
	EventBus.BossesBeaten = 2
	EventBus.Balance = 9999
	EventBus.Reputation = 60
	EventBus.emit_signal("BalanceChanged")
	dialogue._talk(str("[font_size=36]This is a short level Reese.[/font_size]"), "Callum")
	$Spawner._start()

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]You should have a lot of money and there is only one customer.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]Doesn't matter if you pass or fail the customer.[/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]Just use money to research more ingredients or whatever.[/font_size]"))
		4:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum = 16
	SceneManager._change_scene("res://scenes/levels/Level9.tscn", "day")
