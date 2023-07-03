extends Path3D

@export var Num:int = 1
@export_enum("Tutorial:0", "Basic:1","Debug:-1") var List:int
@onready var timer := $MiscTimer
const Customer := preload("res://scenes/customer.tscn")

const CustomerLists := {
	-1: DEBUG,
	0: TutorialCustomers,
	1: BasicCustomers
}
const DEBUG := ["DebugDan"]
const TutorialCustomers := ["Ben", "Mary", "Emma", "Charles", "Krystal", "Jokez", "Hunter"]
const BasicCustomers := ["Ben", "Charles", "Reeseman5", "Artemis", "Emma", "Mary", "Krystal", "Krystal2", "Jokez", "Imoorzy", "Noto", "Hunter", "Formag", "Kuspy", "45Glockz"]
const MediumCustomers := ["Jokez", "High", "Kaze", "Imoorzy", "Noto", "NanoCup", "Formag", "Kuspy", "45Glockz"]
const HardCustomers := ["Slight", "Breo", "Skup", "Snipes", "Orion"]
var Spawned := []

func _ready():
	randomize()

func _start():
	timer.wait_time = randi_range(7, 10)
	timer.start()

func _on_misc_timer_timeout():
	_spawn()

func _spawn():
	if Num <= 0:
		return
	
	var CustomerRes := str("res://characters/" + str(CustomerLists[List][randi() % CustomerLists[List].size()]) + ".tres")
	
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
