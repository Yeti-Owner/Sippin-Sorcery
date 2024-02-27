extends Interactable

@onready var Apparation := preload("res://scenes/apparation.tscn")

func _ready():
	randomize()
	var a := Apparation.instantiate()
	add_child(a)
	_frog_noise()

func get_interaction_text():
	if EventBus.HeldItem != null:
		return "[center][color=GREEN]Frog :)[/color][/center]"
	else:
		return "[center]Press " + OS.get_keycode_string(InputMap.action_get_events("interact")[0].keycode) + " to [color=GREEN]grab Frog :)[/color][/center]"

func get_interaction_icon():
	return EventBus.GrabTex

func interact():
	if EventBus.HeldItem == null:
		EventBus.HeldItem = "Frog"
		EventBus.emit_signal("HeldItemChanged")
		_reset()
		get_parent()._stop()
		_remove()
 
func _frog_noise():
	$FrogSound.pitch_scale = randf_range(0.8, 1)
	$FrogSound.play()

func _remove():
	_frog_noise()
	var a := Apparation.instantiate()
	get_parent().add_child(a)
	a.position = self.position
	self.queue_free()
