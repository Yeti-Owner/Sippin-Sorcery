extends Node3D

@onready var SpawnerAmt:int = (get_parent().get_node("Spawner").Num * 2) # doubling bc frustration timer on customer runs twice
@onready var CharTime:int = get_parent().get_node("Spawner").List

func _ready():
	match CharTime:
		-1:
			CharTime = 90
		0:
			CharTime = 60
		1:
			CharTime = 30
		2:
			pass
	# Needs to have enough time for all customers to leave on their own, plus 30 seconds.
	_set_speed(((CharTime * SpawnerAmt) + 30))

func _set_speed(duration):
	duration = 20
#	print(duration)
	var tween := get_tree().create_tween()
	tween.tween_property($DirectionalLight3D, "rotation", Vector3(-175, 0, 0), float(duration))
	tween.tween_callback(temp)

func temp():
	EventBus.emit_signal("DayDone")
	print("Day Done")
