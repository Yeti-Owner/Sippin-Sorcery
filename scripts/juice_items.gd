extends Node3D

@export var HasWater:bool = true

func _ready():
	if HasWater == false:
		$Water.queue_free()
