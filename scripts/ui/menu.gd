extends Control

@onready var Ray := $Camera3D/RayCast3D
@onready var Click := $ClickSound
@onready var Back := $BackSound
var colliding:bool = false
var Hovered := ""

func _ready():
	if has_node("/root/FirstScene"): get_node("/root/FirstScene").queue_free()
	
	EventBus.CurrentLevel = "res://scenes/ShowcaseWorld.tscn"
	
	_audio_settings()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	set_physics_process(false)
	$Anims.play("Start")
	_sib()

func _process(_delta):
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
#					$CreditsSection/FeedbackText.text = str("WIP, dm me")
#					return
					if EventBus.SentFeedback == false:
						SceneManager._change_scene("", "none")
						SceneManager._swap_hud("res://scenes/ui/feedback.tscn")
					else:
						$CreditsSection/FeedbackText.text = str("Completed")
				"Back":
					Back.play()
					$Anims.play("Back")
				"SiB":
					OS.shell_open("https://www.esportssib.com/")
		return
	
	var PossibleButtons := ["Start","Quit","Credits", "Feedback", "Back", "SiB"]
	
	if PossibleButtons.has(Ray.get_collider().name):
		Ray.get_collider().get_node("Outline").visible = true
		if has_node((str(Ray.get_collider().name + "Sign"))):
			var tween = get_tree().create_tween()
			tween.tween_property(get_node(str(Ray.get_collider().name + "Sign")), "position", Vector3(0,0,0), 0.5)
	
	Hovered = Ray.get_collider().name
	
	colliding = true

func _audio_settings():
	if EventBus.MasterVolume == -15:
		AudioServer.set_bus_mute(0, true)
	else:
		AudioServer.set_bus_mute(0, false)
	AudioServer.set_bus_volume_db(0, EventBus.MasterVolume)
	
	if EventBus.MusicVolume == -15:
		AudioServer.set_bus_mute(1, true)
	else:
		AudioServer.set_bus_mute(1, false)
	AudioServer.set_bus_volume_db(1, EventBus.MusicVolume)
	
	if EventBus.SfxVolume == -15:
		AudioServer.set_bus_mute(2, true)
	else:
		AudioServer.set_bus_mute(2, false)
	AudioServer.set_bus_volume_db(2, EventBus.SfxVolume)

func _on_anims_animation_finished(anim_name):
	if anim_name == "Start":
		set_physics_process(true)
	elif anim_name == "End":
		if EventBus.CurrentLevel != "res://scenes/char_customization.tscn":
			$SceneTimer.start()
			SceneManager._change_scene(EventBus.CurrentLevel, "day")
		else:
			SceneManager._change_scene(EventBus.CurrentLevel)

func _on_scene_timer_timeout():
	SceneManager._swap_hud("res://scenes/ui/gui.tscn")

func _on_music_finished():
	$Music.play()

func _sib():
	await get_tree().create_timer(1, true).timeout
	var tween := get_tree().create_tween()
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property($SiB, "position", Vector3(0, 0.695, 0), 1)

func _on_new_save_pressed():
	set_process(false)
	$ClearSave/ConfirmBox.visible = true

func _on_no_pressed():
	set_process(true)
	$ClearSave/ConfirmBox.visible = false

func _on_yes_pressed():
	for file in DirAccess.get_files_at("user://"):
		DirAccess.remove_absolute(str("user://" + file))
	get_tree().quit()
	set_process(true)
	$ClearSave/ConfirmBox.visible = false
