extends CharacterBody3D

@onready var cam := $CamHolder
@onready var Camera := $CamHolder/Cam
@onready var HeldCam := $CanvasLayer/SubViewportContainer/SubViewport/Cam
@onready var Anims := $AnimationPlayer
const SPEED := 5.0
const JUMP_VELOCITY := 5.4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity:float = 15.8

func _ready():
	EventBus.EnablePlayer.connect(_toggle)
	_toggle(false)

func _physics_process(delta):
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Jump
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Movement
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = (cam.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	
	if (velocity.x != 0) or (velocity.z != 0):
		Anims.play("head_bob")

func _process(_delta):
	HeldCam.global_transform = Camera.global_transform

func _toggle(value):
	self.set_physics_process(value)
