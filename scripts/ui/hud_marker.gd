extends Node3D

@onready var MarkerTex := $OnScreen
var MarkerOffset := Vector2(16, 16)
var ViewportPadding := Vector2(16, 22)
var ViewportCenter
var MaxViewport
var Camera 

func _ready():
	Camera = get_viewport().get_camera_3d()
	ViewportCenter = Vector2(get_viewport().size) / 2.0
	MaxViewport = ViewportCenter - ViewportPadding

func _process(delta):
	if Camera.is_position_in_frustum(global_position):
		var MarkerPosition = Camera.unproject_position(global_position)
		MarkerTex.set_global_position(MarkerPosition - MarkerOffset)
	else:
		var LocalToCamera = Camera.to_local(global_position)
		var MarkerPosition = Vector2(LocalToCamera.x, -LocalToCamera.y)
		if MarkerPosition.abs().aspect() > ViewportCenter.aspect():
			MarkerPosition *= MaxViewport.x / abs(MarkerPosition.x)
		else:
			MarkerPosition *= MaxViewport.y / abs(MarkerPosition.y)
		MarkerTex.set_global_position(ViewportCenter + MarkerPosition - MarkerOffset)
