extends Control

@onready var Ray := $Camera3D/RayCast3D
var colliding:bool = false
var Hovered := ""

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(_delta):
	Ray.target_position = $Camera3D.project_local_ray_normal(get_global_mouse_position())
	if not Ray.is_colliding():
		if Hovered != "":
			var tween = get_tree().create_tween()
			tween.tween_property(get_node(str(Hovered) + "Sign"), "position", Vector3(0, 0.615, 0), 0.5)
			get_node(Hovered).get_node("Outline").visible = false
		colliding = false
		Hovered = ""
		return
	if colliding == true:
		if Input.is_action_just_pressed("select"):
			match Hovered:
				"Start":
					get_tree().change_scene_to_file("res://scenes/world.tscn")
				"Options":
					$Anims.play("options")
				"Quit":
					get_tree().quit()
		return
	
	var PossibleButtons := ["Start","Quit","Options"]
	
	if PossibleButtons.has(Ray.get_collider().name):
		Ray.get_collider().get_node("Outline").visible = true
		var tween = get_tree().create_tween()
		tween.tween_property(get_node(str(Ray.get_collider().name + "Sign")), "position", Vector3(0,0,0), 0.5)
	
	Hovered = Ray.get_collider().name
	
	colliding = true
