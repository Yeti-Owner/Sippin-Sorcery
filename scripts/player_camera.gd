extends Node3D

@onready var _cam := $Cam

var mouse_sensitivity = 0.36*1.5


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_cam.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		_cam.rotation_degrees.x = clamp(_cam.rotation_degrees.x, -89.9, 89.9)

