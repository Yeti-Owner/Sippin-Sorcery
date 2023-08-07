extends Node3D

@onready var dialogue := get_node("/root/SceneManager/GameScene/HUD/GUI/DialogueLayer/Dialogue")#get_node(EventBus.Dialogue)
var Stage:int = 0

# This is a boss level, need to add dialogue explaining stuff and then the boss itself.

func _ready():
	EventBus.connect("DialogueFinished", _level)
	EventBus.CurrentLevel = "res://scenes/levels/Level5.tscn"
	EventBus._save()
	EventBus._update_presence()
	dialogue._talk(str("[font_size=36]Hey " + EventBus.PlayerName + ", this is the end of the play test.[/font_size]"), "Callum", 1.5)

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]I really hope you've enjoyed the game so far.[/font_size]"), "Callum", 1.5)
		2:
			dialogue._talk(str("[font_size=36]If you ran into any errors, glitches, or problems please let me know I would love to fix them.[/font_size]"), "Callum", 1.5)
		3:
			dialogue._talk(str("[font_size=36]There is more planned for the game and I hope that you have enjoyed what is currently added as well as what will be added.[/font_size]"), "Callum", 1.5)
		4:
			dialogue._talk(str("[font_size=36]Also if you decided to stream this Harper I hope it was a good stream![/font_size]"), "Callum", 4)
		5:
			dialogue._done()
			$Spawner._start()

func _on_clock_next_day():
	EventBus.DayNum += 1
	print("Go to next level")
