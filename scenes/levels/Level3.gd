extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)

var Stage:int = 0

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level3.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Hey " + EventBus.PlayerName + ", so we have a minor problem but don't worry![/font_size]"), "Bob")

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]That sounds bad.[/font_size]"), "Self")
		2:
			dialogue._talk(str("[font_size=36]Nonsense just remember those Ministry of Magic agents I mentioned earlier? The legal fellows?[/font_size]"), "Bob")
		3:
			dialogue._talk(str("[font_size=36]Yeah.[/font_size]"), "Self")
		4:
			dialogue._talk(str("[font_size=36]Do you also remember how I jokingly said for legal reasons we sell juice not potions?[/font_size]"), "Bob")
		5:
			dialogue._talk(str("[font_size=36]Yup.[/font_size]"), "Self")
		6:
			dialogue._talk(str("[font_size=36]Well it wasn't really a joke, some Ministry of Magic agents might drop by and ask for some samples.[/font_size]"), "Bob")
		7:
			dialogue._talk(str("[font_size=36]But, under NO CIRCUSTANCES can you sell them working potions.[/font_size]"))
		8:
			dialogue._talk(str("[font_size=36]I've added some water below the counter and if they come actually give them juice.[/font_size]"))
		9:
			dialogue._talk(str("[font_size=36]I'll say it again, if any official types come around give them actual juice not potions or we may be in serious trouble.[/font_size]"))
		10:
			dialogue._talk(str("[font_size=36]Got it.[/font_size]"), "Self")
		11:
			dialogue._talk(str("[font_size=36]Good luck![/font_size]"), "Bob")
			$Spawner._start()
		12:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	SceneManager._change_scene("res://scenes/levels/Level4.tscn", "day")
