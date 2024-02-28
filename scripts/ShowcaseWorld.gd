extends Node3D
var counter:int = 0

func _ready():
	$Spawner._start()
	get_node("/root/SceneManager/GameScene").visible =  false
#	$AnimationPlayer.play("Forward")
	pass

func _process(_delta):
	if Input.is_action_just_pressed("debug"):
		_take_screenshot()
#		$AnimationPlayer.play("ground2")

func _take_screenshot():
	counter += 1
	await get_tree().process_frame
	var vpt = get_viewport()
	var tex:Texture = vpt.get_texture()
	var img:Image = tex.get_image()
	img.save_png(str("user://Screenshot" + str(counter) + ".png"))

