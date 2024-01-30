extends Level

var Stage:int = 0

func _start():
	dialogue._talk(str("[font_size=36]Good morning " + EventBus.PlayerName + ", hope you slept well![/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Just the same today but I wanted to explain one last thing to you.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]If you check your ID card you'll see your reputation. Go ahead and check it now.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]...[/font_size]"), "self", 10)
			EventBus.Hint.emit(str("Press " + OS.get_keycode_string(InputMap.action_get_events("id")[0].keycode) + " to view your ID."))
		4:
			dialogue._talk(str("[font_size=36]It's " + str(EventBus.Reputation) + ".[/font_size]"))
		5:
			var Response:String
			if EventBus.Reputation <= 0:
				Response = "Yikes."
			elif EventBus.Reputation >= 5:
				Response = "Perfect!"
			elif EventBus.Reputation < 3:
				Response = "Not the best start but you'll get there."
			else:
				Response = "Well done."
			
			dialogue._talk(str("[font_size=36]" + Response + "[/font_size]"), "Bob")
		6:
			dialogue._talk(str("[font_size=36]Anyway, to increase your reputation you just need to help more customers.[/font_size]"))
		7:
			dialogue._talk(str("[font_size=36]While a customer may only REQUIRE a few effects, they will pay extra if you go above and beyond for them.[/font_size]"))
		8:
			dialogue._talk(str("[font_size=36]Got it.[/font_size]"), "Self")
		9: 
			dialogue._talk(str("[font_size=36]As your reputation increases more customers will come.[/font_size]"), "Bob")
		10:
			dialogue._talk(str("[font_size=36]If your reputation gets high enough you may even need to pass a health inspection.[/font_size]"))
		11:
			dialogue._talk(str("[font_size=36]But don't worry, I doubt you'll do that well.[/font_size]"))
			$Spawner._start()
		12:
			dialogue._talk(str("[font_size=36]Cya " + str(EventBus.PlayerName) + "![/font_size]"))
		13:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level2.tscn", "day")
