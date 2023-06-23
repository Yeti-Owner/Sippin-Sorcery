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
# First step is convert CharTime to the time they have
# then find speed for it to get to certain rotation at certain time
# Shouldn't be hard just Tween ig?
func _start():
	pass
