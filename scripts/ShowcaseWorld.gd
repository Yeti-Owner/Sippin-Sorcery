extends Node3D
var counter:int = 0

func _process(delta):
	if Input.is_action_just_pressed("dialogue"):
		$AnimationPlayer.play("Showcase")
	
	if Input.is_action_just_pressed("pause"):
		_take_screenshot()

func _take_screenshot():
	counter += 1
	await get_tree().process_frame
	var vpt = get_viewport()
	var tex:Texture = vpt.get_texture()
	var img:Image = tex.get_image()
	img.save_png(str("user://Screenshot" + str(counter) + ".png"))
