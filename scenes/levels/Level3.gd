extends Level

var Stage:int = 0

func _start():
	dialogue._talk(str("[font_size=36]Hey " + EventBus.PlayerName + ", so we have a minor problem.[/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]?[/font_size]"), "Self", 1.5)
		2:
			dialogue._talk(str("[font_size=36]You remember how I jokingly said for legal reasons we sell juice not potions?[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]Well it wasn't a joke we are being sued.[/font_size]"))
		4:
			dialogue._talk(str("[font_size=36]It's not a big deal though! We just have to make sure we don't give them any evidence.[/font_size]"))
		5:
			dialogue._talk(str("[font_size=36]Some Ministry of Magic agents might show up and ask for a potion, under NO CIRCUMSTANCES do you give them one.[/font_size]"))
		6:
			dialogue._talk(str("[font_size=36]Instead give them actual juice.[/font_size]"))
		7:
			dialogue._talk(str("[font_size=36]I added water to the shop, just mix that with a flavor and you're set.[/font_size]"))
			$WaterMarker.visible = true
		8:
			$WaterMarker.queue_free()
			dialogue._talk(str("[font_size=36]You can probably tell it's an agent by the way they look and talk.[/font_size]"))
			if not (EventBus.UnlockedHelp.has("res://assets/textures/help/HelpPage5.png")):
				EventBus.UnlockedHelp.append("res://assets/textures/help/HelpPage5.png")
		9:
			dialogue._talk(str("[font_size=36]Got it.[/font_size]"), "Self")
			$Spawner._start()
		10:
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"), "Bob")
		11:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level4.tscn", "day")
	EventBus.emit_signal("Fuck")
