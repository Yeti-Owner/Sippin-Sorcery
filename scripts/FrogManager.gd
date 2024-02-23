extends Node3D

var Stop:bool = false
@onready var Frog := preload("res://scenes/objects/frog.tscn")
var Positions:Array = [Vector3(19.8,0,-3), Vector3(-3.8,0,-7.3), Vector3(-10.4,0,-3.7),Vector3(-9.1,0,24),Vector3(-37.2,0,17.1),Vector3(-33.9,0,-0.3),Vector3(0.7,0,51),Vector3(15.8,0,53.5),Vector3(12.6,0,39.4),Vector3(-10.9,0,32),Vector3(-9.8,0,27.8),Vector3(-0.3,0,-22.7)]

func _ready():
	randomize()

func _start():
	$SpawnTimer.wait_time = randi_range(12, 16)
	$SpawnTimer.start()

func _spawn_frog():
	var f := Frog.instantiate()
	self.add_child(f, true)
	f.position = Positions.pick_random()
	f.rotation_degrees = Vector3(0, randi_range(1, 360), 0)

func _remove_frog():
	get_node("Frog")._remove()

func _on_spawn_timer_timeout():
	if Stop:
		return
	
	# remove frog if there, else spawn
	if get_node_or_null("Frog") != null:
		_remove_frog()
		$SpawnTimer.wait_time = randi_range(2, 4)
		$SpawnTimer.start()
	else:
		_spawn_frog()
		$SpawnTimer.wait_time = randi_range(8, 12)
		$SpawnTimer.start()

func _stop():
	$SpawnTimer.stop()
