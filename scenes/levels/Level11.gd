extends Level

@onready var Witch := preload("res://scenes/characters/witch.tscn")
var Stage:int = 0
var BossStage:int = 0

func _start():
	EventBus.connect("BossProblem", _boss_help)
	dialogue._talk(str("[font_size=36]Yet another inspection " + EventBus.PlayerName + ".[/font_size]"), "Bob")
	$Spawner._start()

func _level():
	Stage += 1
	match Stage:
		1:
			dialogue._talk(str("[font_size=36]You know the drill, good luck![/font_size]"))
		2:
			dialogue._done()

func _on_clock_next_day():
	EventBus.DayNum += 1
	if EventBus.BossesBeaten > 2: # Success
		SceneManager._change_scene("res://scenes/levels/EndLevel.tscn", "day")
	else: # Fail
		SceneManager._change_scene("res://scenes/levels/Level11fail.tscn", "day")
	EventBus.emit_signal("Fuck")

func _on_witch_timer_timeout():
	# Instance in Witch
	var w := Witch.instantiate()
	self.add_child(w)
	w.position = Vector3(23.3, 1, 17.7)
	w.rotation_degrees = Vector3(0, -90, 0)

func _boss_help():
	if BossStage == 0:
		BossStage += 1
		$WitchTimer.start()
		$FrogManager._start()
