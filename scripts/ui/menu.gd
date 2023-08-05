extends Control

@onready var Ray := $Camera3D/RayCast3D
@onready var Click := $ClickSound
@onready var Back := $BackSound
var colliding:bool = false
var Hovered := ""

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_physics_process(false)
	$Anims.play("Start")

func _physics_process(_delta):
	Ray.target_position = $Camera3D.project_local_ray_normal(get_global_mouse_position())
	if not Ray.is_colliding():
		if Hovered != "":
			if has_node((str(Hovered) + "Sign")):
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
					Click.play()
#					get_tree().change_scene_to_file("res://scenes/levels/Tutorial.tscn")
					$Anims.play("End")
				"Credits":
					Click.play()
					$Anims.play("credits")
				"Quit":
					Back.play()
					EventBus._save()
					get_tree().quit()
				"Feedback":
					Click.play()
					$CreditsSection/FeedbackText.text = str("WIP, dm me")
					print("-- Feedback Clicked --")
				"Back":
					Back.play()
					$Anims.play("Back")
		return
	
	var PossibleButtons := ["Start","Quit","Credits", "Feedback", "Back"]
	
	if PossibleButtons.has(Ray.get_collider().name):
		Ray.get_collider().get_node("Outline").visible = true
		if has_node((str(Ray.get_collider().name + "Sign"))):
			var tween = get_tree().create_tween()
			tween.tween_property(get_node(str(Ray.get_collider().name + "Sign")), "position", Vector3(0,0,0), 0.5)
	
	Hovered = Ray.get_collider().name
	
	colliding = true

func _on_anims_animation_finished(anim_name):
	if anim_name == "Start":
		set_physics_process(true)
	elif anim_name == "End":
		SceneManager._change_scene(EventBus.CurrentLevel)

