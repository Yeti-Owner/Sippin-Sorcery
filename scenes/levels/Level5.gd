extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level5.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Hey " + EventBus.PlayerName + ", remember how I said those ministry people would be the last of our troubles?[/font_size]"), "Bob", 4)

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]I lied.[/font_size]"), "Bob", 1.5)
		2:
			dialogue._talk(str("[font_size=36]So basically we've been doing a little too well in the business and to continue on we have to pass a health inspection.[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]Not to worry though! If we pass I'm sure it'll catch the eyes of new customers.[/font_size]"), "Bob")
		4:
			dialogue._talk(str("[font_size=36]We do need to pass though, that is a slight problem.[/font_size]"), "Bob", 3)
		5:
			dialogue._talk(str("[font_size=36]Remember they don't care about any silly 'regulations' so provide any effects they ask for.[/font_size]"), "Bob")
		6:
			dialogue._talk(str("[font_size=36]I'm sure you've got it, good luck![/font_size]"), "Bob")
			$Spawner._start()
		7:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	print("Go to next level")
