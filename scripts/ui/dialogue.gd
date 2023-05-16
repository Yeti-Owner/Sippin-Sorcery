extends Control

@onready var Anims := $AnimPlayer
@onready var Name := $Bg/Name
@onready var Text := $Bg/HBoxContainer/Text
@onready var Headshot := $Bg/HBoxContainer/Headshot
var lines
var time

func _start(_lines:String, _name:String, _icon:String, _time := 1):
	lines = _lines
	time = _time
	Name.text = str("[center]" + _name + "[/center]")
	Headshot.texture = load(_icon)
	Anims.play("start")

func _talk(_lines:String, _time := 1.0):
	Text.text = str("[center]" + str(_lines) + "[/center]")
	Anims.play("talk", -1, _time)

func _end():
	Anims.play("end", 1)

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "start":
		_talk(lines, time)
	elif anim_name == "talk":
		$DelayTimer.start(2)

func _on_delay_timer_timeout():
	EventBus.emit_signal("DialogueFinished")
