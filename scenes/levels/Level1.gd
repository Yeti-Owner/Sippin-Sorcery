extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = self.scene_file_path
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Good morning " + EventBus.PlayerName + ", hope you slept well![/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]Just the same today but I wanted to explain one last thing to you.[/font_size]"))
		2:
			dialogue._talk(str("[font_size=36]If you check your ID card you'll see your reputation. Go ahead and check it now.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]It's " + str(EventBus.Reputation) + ".[/font_size]"), "Self")
		4:
			dialogue._talk(str("[font_size=36]Interesting, well to increase your reputation you just need to help more customers.[/font_size]"), "Bob")
		5:
			dialogue._talk(str("[font_size=36]Remember, while a customer may only require a few effects they may benefit from additional unasked ones, and they'll be grateful if you do it right.[/font_size]"), "Bob")
		6:
			dialogue._talk(str("[font_size=36]Got it.[/font_size]"), "Self")
		7:
			dialogue._talk(str("[font_size=36]If your reputation goes up enough more people will visit and you might even need to pass a health inspection.[/font_size]"), "Bob")
		8:
			dialogue._talk(str("[font_size=36]But don't worry, I doubt you'll do that well.[/font_size]"))
		9:
			dialogue._talk(str("[font_size=36]Cya " + str(EventBus.PlayerName) + "![/font_size]"))
			$Spawner._start()
		10:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level2.tscn", "day")
