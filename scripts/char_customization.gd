extends Control

@onready var Ray := $Cam/RayCast3D
var colliding:bool = false
var Hovered := ""

@onready var Left := $Arrows/Left
@onready var Right := $Arrows/Right
var Stage:int = 5
var Direction:int = 1

const HatList := ["res://assets/models/characters/hats/Hair1.obj","res://assets/models/characters/hats/Hair2.obj","res://assets/models/characters/hats/Hair3.obj"]
const HatColor := ["res://assets/models/characters/hats/HairColor1.png","res://assets/models/characters/hats/HairColor2.png","res://assets/models/characters/hats/HairColor3.png","res://assets/models/characters/hats/HairColor4.png"]
const HeadList := ["res://assets/models/characters/heads/Head1.obj","res://assets/models/characters/heads/Head2.obj","res://assets/models/characters/heads/Head3.obj","res://assets/models/characters/heads/Head4.obj","res://assets/models/characters/heads/Head5.obj"]
const TorsoList := ["res://assets/models/characters/torsos/torso1.obj","res://assets/models/characters/torsos/torso2.obj","res://assets/models/characters/torsos/torso3.obj","res://assets/models/characters/torsos/torso4.obj"]
const PantList := ["res://assets/models/characters/pants/pants1.obj","res://assets/models/characters/pants/pants3.obj"]
const LegList := ["res://assets/models/characters/legs/leg1.obj"]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(_delta):
	Ray.target_position = $Cam.project_local_ray_normal(get_global_mouse_position())
	if not Ray.is_colliding():
		colliding = false
		Hovered = ""
		return
	
	if colliding == true:
		if Input.is_action_just_pressed("select"):
			match Hovered:
				"Up":
					_change_stage(Stage + 1)
				"Down":
					_change_stage(Stage - 1)
				"Left":
					_swap_part(Direction - 1)
				"Right":
					_swap_part(Direction + 1)
		return
	
	Hovered = Ray.get_collider().name
	colliding = true

func _change_stage(CurStage):
	CurStage = wrap(CurStage, 1, 6)
	
	var StageList := [-1.5, -0.9, -0.4, 0.3, 1]
	
	var tween = get_tree().create_tween()
	tween.tween_property(Left, "position:y", StageList[int(CurStage-1)], 0.25)
	tween.tween_property(Right, "position:y", StageList[int(CurStage-1)], 0.25)
	
	Stage = CurStage

func _swap_part(direction):
	match Stage:
		1:
			direction = wrap(direction, 0, 7) # I hate myself, just manually calculated it I'll make a smarter sys some other time
		2:
			direction = wrap(direction, 0, HeadList.size() + 1)
		3:
			direction = wrap(direction, 0, TorsoList.size() + 1)
		4:
			direction = wrap(direction, 0, PantList.size() + 1)
		5:
			direction = wrap(direction, 0, LegList.size() + 1)
	