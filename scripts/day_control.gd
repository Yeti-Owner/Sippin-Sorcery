extends Node3D

@export var Showcase:bool = false

@onready var WorldSun := $Sun
@onready var SpawnerAmt:int = (get_parent().get_node("Spawner").Num * 2) # doubling bc frustration timer on customer runs twice
@onready var CharTime:int = get_parent().get_node("Spawner").List

func _ready():
	match CharTime:
		-1:
			CharTime = 90 # Debug
		0:
			CharTime = 120 # Tutorial
		1:
			CharTime = 30 # Basic
		2:
			pass

func _set_speed(duration):
	var tween := get_tree().create_tween()
	tween.tween_property(WorldSun, "rotation_degrees", Vector3(-165, -40, 0), float(duration))
	tween.tween_callback(temp)
 
func temp():
	EventBus.emit_signal("DayDone")
	print("Day Done")

func _on_loading_screen_loading_done():
	if Showcase == true:
		WorldSun.rotation_degrees = Vector3(-60, -40, 0)
		return
	
	# Enough time for all customers to leave on their own, plus 30 seconds.
	_set_speed(((CharTime * SpawnerAmt) + 30))
