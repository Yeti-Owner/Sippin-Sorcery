extends Level

var Stage:int = -1

func _start():
	dialogue._talk(str("[font_size=36]Hello " + EventBus.PlayerName + "! Welcome to the juice shop. I'm Bob, your partner in this business venture![/font_size]"), "Bob")
	EventBus.connect("DayDone", _customers_done)

func _level():
	Stage += 1
	match Stage:
		0:
			dialogue._talk(str("[font_size=36]Your job while you're here is to mix potions, or rather juices.[/font_size]"))
		1:
			dialogue._talk(str("[font_size=36]For legal reasons this is a juice shop and you sell juice, but don't worry about it.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]Mixing juice is simple, you just need a flavor, at least 1 ingredient, and you're done![/font_size]"))
		3:
			dialogue._talk(str("[font_size=36]Go ahead and grab an ingredient now, any will work...[/font_size]"), "Bob", 4)
			$IngredientMarkers.visible = true
		4:
			dialogue._talk(str("[font_size=36]Add it to the cauldron...[/font_size]"), "Bob", 4)
			$IngredientMarkers.queue_free()
			$CauldronMarkers.visible = true
		5:
			dialogue._talk(str("[font_size=36]Add in a flavor...[/font_size]"), "Bob", 4)
			$FlavorMarkers.visible = true
			$CauldronMarkers.visible = false
		6:
			dialogue._talk(str("[font_size=36]Then mix it in the cauldron![/font_size]"), "Bob", 4)
			$FlavorMarkers.queue_free()
			$CauldronMarkers.visible = true
		7:
			dialogue._talk(str("[font_size=36]Congrats " + EventBus.PlayerName + "! You can now make juice![/font_size]"))
			$CauldronMarkers.queue_free()
		8:
			dialogue._talk(str("[font_size=20]There's no customers around so you can only trash juice...[/font_size]"), "Bob", 4)
			$TrashcanMarkers.visible = true
		9:
			dialogue._talk(str("[font_size=36]Every ingredient has 3 effects and it changes as you add more. Adding just 1 gives effect 1, 2 gives the 2nd, and so on.[/font_size]"))
			$TrashcanMarkers.queue_free()
		10:
			dialogue._talk(str("[font_size=36]There isn't a trick to know what effect(s) a customer needs, just talk to them and give them what fits their needs.[/font_size]"))
		11:
			dialogue._talk(str("[font_size=36]Flavors are another matter though, every customer has unique tastes so make sure to ask![/font_size]"))
		12:
			dialogue._talk(str("[font_size=36]How do I know what ingredients have what effects?[/font_size]"), "Self")
		13:
			dialogue._talk(str("[font_size=36]Very good question " + EventBus.PlayerName + ", for that you need to check your journal.[/font_size]"), "Bob", 6)
			$JournalMarker.visible = true
		14:
			dialogue._talk(str("[font_size=36]Customers will be arriving soon I've taught you everything you need, good luck![/font_size]"))
			$JournalMarker.queue_free()
		15:
			dialogue._talk(str("[font_size=36]Wait![/font_size]"), "Self", 3)
		16:
			dialogue._done()
			EventBus.Hint.emit(str("You can press " + OS.get_keycode_string(InputMap.action_get_events("pause")[0].keycode) + " to open the pause menu and find help."))
			$Pause.start(3)
		18:
			dialogue._talk(str("[font_size=36]Hey there, the name's Duane and I believe you have a slight problem.[/font_size]"), "Duane")
		19:
			dialogue._talk(str("[font_size=36]Don't ask how I know your journal is completely empty... but I can fix that.[/font_size]"))
		20:
			dialogue._talk(str("[font_size=20]It'll cost you though.[/font_size]"), "Duane", 1)
		21:
			_duane_journal()
			dialogue._talk(str("[font_size=36]Go ahead and check your journal now, that should get you started.[/font_size]"), "Duane", 8)
		22:
			dialogue._talk(str("[font_size=36]Oh, thank you![/font_size]"), "Self")
		23:
			EventBus.Balance = 25
			EventBus.emit_signal("BalanceChanged")
			# Some money sound maybe?
			dialogue._talk(str("[font_size=36]I'll be taking my cut now.[/font_size]"), "Duane", 2)
		24:
			dialogue._talk(str("[font_size=36]I'll leave you with some free advice though.[/font_size]"))
		25:
			dialogue._talk(str("[font_size=36]Right outside by the exit portal you'll find first-year Hogwarts students hiding out.[/font_size]"))
		26:
			dialogue._talk(str("[font_size=36]They'll be willing to test out juices for you, for a price of course.[/font_size]"))
			$Spawner._start()
		27:
			dialogue._talk(str("[font_size=36]That's all, cya![/font_size]"))
		28:
			dialogue._done()
			EventBus.Hint.emit(str("You'll have time to research ingredients at the end of the day."))
		29:
			dialogue._talk(str("[font_size=36]Well done " + EventBus.PlayerName + "![/font_size]"), "Bob")
		30:
			dialogue._talk(str("[font_size=36]It's too late for any more customers to arrive now.[/font_size]"))
		31:
			dialogue._talk(str("[font_size=36]Go ahead and fill out the order form over there and I'll restock whatever you used in the morning.[/font_size]"))
			$OrderformMarker.visible = true
		32:
			$OrderformMarker.queue_free()
			dialogue._talk(str("[font_size=36]A last friendly tip for you, I recommend you research some ingredients too, go for quanitity over quality.[/font_size]"))
		33:
			dialogue._talk(str("[font_size=36]You did good " + EventBus.PlayerName + ", close shop whenever you're done.[/font_size]"), "Bob", 7)
			$ClockMarker.visible = true
		34:
			EventBus.Hint.emit(str("The help section will update as you learn more."))
			$ClockMarker.queue_free()
			dialogue._done()

func _customers_done():
	_level()

func _duane_journal():
	# Maybe play a scribbling/writing sound
	PotionInfo.JournalIngredients["MermaidScale"] = PotionInfo.JournalIngredients["MermaidScale"].format({"swimming": str("Enhanced swimming ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["GriffinFeather"] = PotionInfo.JournalIngredients["GriffinFeather"].format({"alertness": str("Increased alertness ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["MandrakeRoot"] = PotionInfo.JournalIngredients["MandrakeRoot"].format({"resistance": str("Overall resistance to common illnesses ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["TrollBlood"] = PotionInfo.JournalIngredients["TrollBlood"].format({"courage": str("Courage ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["PhoenixFeather"] = PotionInfo.JournalIngredients["PhoenixFeather"].format({"sleep": str("Potent sleep effect ([color=DARK_GRAY]Duane[/color]" + ")")})
	PotionInfo.JournalIngredients["CentaurHoof"] = PotionInfo.JournalIngredients["CentaurHoof"].format({"speed": str("Speed boost ([color=DARK_GRAY]Duane[/color]" + ")")})

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level1.tscn", "day")

func _on_pause_timeout():
	Stage += 1
	_level()
