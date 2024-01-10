extends CharacterBody3D

@onready var CamHolder := $CamHolder
@onready var Camera := $CamHolder/Cam
@onready var HeldCam := $CanvasLayer/SubViewportContainer/SubViewport/Cam
const SPRINT_SPEED := 6.4
const WALK_SPEED := 5.0
const JUMP_VELOCITY := 5.4
const gravity:float = 15.8
var Speed := WALK_SPEED

# Head bob
const freq := 2.25
const amp := 0.04
var tBob := 0.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		Camera.rotate_x(deg_to_rad(-event.relative.y * EventBus.MouseSens))
		CamHolder.rotate_y(deg_to_rad(-event.relative.x * EventBus.MouseSens))
		Camera.rotation_degrees.x = clamp(Camera.rotation_degrees.x, -89, 89)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("sprint"): 
		Speed = SPRINT_SPEED 
	else: 
		Speed = WALK_SPEED
	
	# Movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (CamHolder.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * Speed
			velocity.z = direction.z * Speed
		else:
			velocity.x = lerp(velocity.x, direction.x * Speed, delta * 9.0)
			velocity.z = lerp(velocity.z, direction.z * Speed, delta * 9.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * Speed, delta * 5.0)
		velocity.z = lerp(velocity.z, direction.z * Speed, delta * 5.0)
	
	# head bob
	tBob += delta * velocity.length() * float(is_on_floor())
	CamHolder.transform.origin = _head_bob(tBob)
	
	move_and_slide()
	HeldCam.global_transform = Camera.global_transform

func _head_bob(time) -> Vector3:
	var pos := Vector3.ZERO
	pos.y = sin(time * freq) * amp
	pos.x = cos(time * freq / 2.5) * amp
	return pos
