extends Node3D

@onready var _cam := $Cam

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventBus.EnablePlayer.connect(_toggle)
	_toggle(false)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_cam.rotate_x(deg_to_rad(-event.relative.y * EventBus.MouseSens))
		rotate_y(deg_to_rad(-event.relative.x * EventBus.MouseSens))
		_cam.rotation_degrees.x = clamp(_cam.rotation_degrees.x, -89.9, 89.9)

func _toggle(value):
	set_process_input(value)
