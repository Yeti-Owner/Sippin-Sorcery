extends Control

@onready var Anims := $AnimPlayer
@onready var Click := $ClickSound

@onready var Ray := $Cam/RayCast3D
var colliding: bool = false
var Hovered: String = ""

@onready var Left := $Arrows/Left
@onready var Right := $Arrows/Right
var Stage: int = 6

@onready var OutfitParts := {
	6: {
		"list": ["res://assets/models/characters/hats/HairColor1.png","res://assets/models/characters/hats/HairColor2.png","res://assets/models/characters/hats/HairColor3.png","res://assets/models/characters/hats/HairColor4.png","res://assets/models/characters/hats/HairColor5.png","res://assets/models/characters/hats/HairColor6.png"],
		"node": $Character/HatColor
	},
	5: {
		"list": ["res://assets/models/characters/hats/Hair1.obj", "res://assets/models/characters/hats/Hair2.obj", "res://assets/models/characters/hats/Hair3.obj","res://assets/models/characters/hats/Hair4.obj","res://assets/models/characters/hats/Hair5.obj"],
		"node": $Character/Hat
	},
	4: {
		"list": ["res://assets/models/characters/heads/Head1.obj", "res://assets/models/characters/heads/Head2.obj", "res://assets/models/characters/heads/Head3.obj", "res://assets/models/characters/heads/Head4.obj", "res://assets/models/characters/heads/Head5.obj","res://assets/models/characters/heads/Head6.obj"],
		"node": $Character/Head
	},
	3: {
		"list": ["res://assets/models/characters/torsos/torso1.obj", "res://assets/models/characters/torsos/torso2.obj", "res://assets/models/characters/torsos/torso3.obj", "res://assets/models/characters/torsos/torso4.obj"],
		"node": $Character/Torso
	},
	2: {
		"list": ["res://assets/models/characters/pants/pants1.obj", "res://assets/models/characters/pants/pants3.obj"],
		"node": $Character/Pants
	},
	1: {
		"list": ["res://assets/models/characters/legs/leg1.obj","res://assets/models/characters/legs/leg2.obj","res://assets/models/characters/legs/leg3.obj","res://assets/models/characters/legs/leg4.obj"],
		"node": $Character/Leg1
	}
}

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_off()
	Anims.play("Start")

func _on_name_text_submitted(new_text):
	$CenterContainer/VBoxContainer/Name.editable = false
	EventBus.PlayerName = new_text
	$Text.text = str("Please customize your character " + new_text)
	Anims.play("Next")

func _physics_process(_delta):
	Ray.target_position = $Cam.project_local_ray_normal(get_global_mouse_position())
	if not Ray.is_colliding():
		colliding = false
		Hovered = ""
		return
	
	if colliding:
		if Input.is_action_just_pressed("select"):
			match Hovered:
				"Up":
					Click.play()
					_change_stage(Stage + 1)
				"Down":
					Click.play()
					_change_stage(Stage - 1)
				"Left":
					Click.play()
					_swap_part(-1)
				"Right":
					Click.play()
					_swap_part(1)
				"RotateR":
					Click.play()
					$Character.rotation_degrees.y += 45
				"RotateL":
					Click.play()
					$Character.rotation_degrees.y -= 45
				"Done":
					Click.play()
					_ending()
					_off()
		return
	
	Hovered = Ray.get_collider().name
	colliding = true

func _change_stage(CurStage):
	CurStage = wrap(CurStage, 1, 7)
	
	var StageList := [-1.5, -0.9, -0.4, 0.3, 1, 1.4]
	
	var tween = get_tree().create_tween()
	tween.tween_property(Left, "position:y", StageList[int(CurStage-1)], 0.25)
	tween.tween_property(Right, "position:y", StageList[int(CurStage-1)], 0.25)
	
	Stage = CurStage

func _swap_part(direction: int):
	var outfitPart = OutfitParts[Stage]
	var partList = outfitPart["list"]
	var partNode = outfitPart["node"]
	
	var b = partList.bsearch(EventBus.PlayerOutfit[Stage - 1])
	direction += b
	direction = wrap(direction, 0, partList.size())
	EventBus.PlayerOutfit[Stage - 1] = partList[direction]
	if Stage == 6:
		var mat = StandardMaterial3D.new()
		mat.albedo_texture = load(EventBus.PlayerOutfit[Stage - 1])
		partNode.set_surface_override_material(0, mat)
		$Character/Hat.set_surface_override_material(0, mat)
	elif Stage == 1:
		partNode.set_mesh(load(EventBus.PlayerOutfit[Stage - 1]))
		$Character/Leg2.set_mesh(load(EventBus.PlayerOutfit[Stage - 1]))
	else:
		partNode.set_mesh(load(EventBus.PlayerOutfit[Stage - 1]))

func _capture_headshot():
	# Setup Scene for capture
	$PicViewport/FaceCam.visible = true
	$Cam.visible = false
	
	# Viewport pic shenanigans
	await get_tree().process_frame
	var vpt:SubViewport = $PicViewport
	var tex:Texture = vpt.get_texture()
	var img:Image = tex.get_image()
	img.save_png("user://PlayerHeadshot.png")
	
	EventBus._player_headshot()

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "Next":
		_on()
		$CenterContainer/VBoxContainer/Name.queue_free()
	elif anim_name == "NewEnd":
		SceneManager._change_scene("res://scenes/levels/Tutorial.tscn")
		SceneManager._swap_hud("res://scenes/ui/gui.tscn")

func _on():
	set_physics_process(true)

func _off():
	set_physics_process(false)

func _ending():
	var tween = get_tree().create_tween()
	tween.tween_property($Text, "modulate", Color(1, 1, 1, 0), 1)
	tween.tween_property(Left, "position:y", 1.4, 0.5)
	tween.tween_property(Right, "position:y", 1.4, 0.5)
	tween.tween_property($Character, "rotation_degrees:y", 0, 0.5)
	tween.tween_callback(_test)

func _test():
	Anims.play("NewEnd")
