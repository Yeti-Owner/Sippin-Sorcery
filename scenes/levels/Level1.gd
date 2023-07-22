extends Node3D

@onready var dialogue := get_node(EventBus.Dialogue)

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level1.tscn"

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Just the same today but I wanted to explain one last thing to you.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]If you check your ID card you'll see your reputation go ahead and check it.[/font_size]"), "Bob", 2)
		3:
			dialogue._talk(str("[font_size=36]It's " + str(EventBus.Reputation) + ".[/font_size]"), "Self")
		4:
			dialogue._talk(str("[font_size=36]Interesting, well to increase your reputation you just need to help more customers.[/font_size]"), "Bob")
		5:
			dialogue._talk(str("[font_size=36]Remember that while a customer may only require a few effects they might still benefit from additional ones and they'll be grateful.[/font_size]"), "Bob")
		6:
			dialogue._talk(str("[font_size=36]Got it.[/font_size]"), "Self", 1)
		7:
			dialogue._talk(str("[font_size=36]If your reputation goes up enough more people will visit and you might even need to pass a health inspection.[/font_size]"), "Bob")
		8:
			dialogue._talk(str("[font_size=36]But don't worry, I doubt you'll do that well.[/font_size]"), "Bob", 1)
		9:
			dialogue._talk(str("[font_size=36]Cya " + str(EventBus.PlayerName) + "![/font_size]"), "Bob", 1)
			$Spawner._start()
		10:
			dialogue._done()

func _on_loading_screen_loading_done():
	EventBus.Fade.emit("day")
	dialogue._talk(str("[font_size=36]Good morning " + EventBus.PlayerName + ", hope you slept well![/font_size]"), "Bob")

func _on_clock_next_day():
	EventBus.Fade.emit("out")
	EventBus.DayNum += 1
	$TempTimer.start()

func _on_temp_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/levels/Level2.tscn")
