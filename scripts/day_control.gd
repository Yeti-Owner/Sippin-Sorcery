extends Node3D

@export var Showcase:bool = false

@onready var WorldSun := $Sun
@onready var SpawnerAmt:float = get_parent().get_node("Spawner").Num

var RotationSteps:float
var StepAmt:float = 0

func _ready():
	EventBus.connect("CustomerDone", _next_stage)
	RotationSteps = -150/SpawnerAmt

func _set_rotation(deg):
	var tween := get_tree().create_tween()
	tween.tween_property(WorldSun, "rotation_degrees", Vector3((-15 + deg), -40, 0), 10)
	if deg == -150:
		tween.tween_callback(fin)
 
func fin():
	EventBus.emit_signal("DayDone")

func _on_loading_screen_loading_done():
	if Showcase == true:
		WorldSun.rotation_degrees = Vector3(-60, -40, 0)
		return
	

func _next_stage():
	StepAmt += 1

	# calculate the next degrees
	var d:float = RotationSteps * StepAmt
	_set_rotation(d)

