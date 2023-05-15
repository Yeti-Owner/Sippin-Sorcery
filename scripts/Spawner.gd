extends Path3D

@export var Num:int = 1
@onready var timer := $MiscTimer
const Customer := preload("res://scenes/customer.tscn")
const CustomerList := ["Ben", "Charles", "Reeseman5"]
var Spawned := []

func _ready():
	randomize()
	timer.wait_time = randi_range(3, 8)
	timer.start()

func _on_misc_timer_timeout():
	_spawn()

func _spawn():
	var CustomerRes := str("res://characters/" + str(CustomerList[randi() % CustomerList.size()]) + ".tres")
	
	if Spawned.has(CustomerRes):
		_spawn()
		return
	else:
		Spawned.append(CustomerRes)
	
	var c = Customer.instantiate()
	c.Info = load(CustomerRes)
	add_child(c)
	
	Num -= 1
	if Num > 0: 
		timer.wait_time = randi_range(10, 20)
		timer.start()
