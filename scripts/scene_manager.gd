extends Node

@onready var TransitionPlayer := $AnimPlayer
@onready var GameScene := $GameScene
@onready var HUD := $GameScene/HUD
@onready var Game := $GameScene/Game

@onready var BossName := $CanvasLayer/Boss/BossName

var SceneToLoad: String
var CurrentScene:Node
var NextTransition:String
var CurrentMode:String
var CurrentMouse := Input.MOUSE_MODE_VISIBLE

func _ready():
	Game.use_occlusion_culling = true
	Engine.set_max_fps(120)

func _change_scene(scene:String, type:String = "normal"):
	# Room for new transitions later
	match type:
		"normal":
			NextTransition = "fade_in"
			TransitionPlayer.play("fade_out")
			SceneToLoad = scene
		"day":
			NextTransition = "day_in"
			$CanvasLayer/Transitions/DayNum.text = str("Day " + str(EventBus.DayNum))
			TransitionPlayer.play("fade_out")
			SceneToLoad = scene
		"none":
			if CurrentScene != null:
				CurrentScene.queue_free()
			SceneToLoad = scene

func _scene_load():
	if CurrentScene != null:
		CurrentScene.queue_free()
	
	if SceneToLoad != "":
		var scene:PackedScene = load(SceneToLoad)
		var _scene:Node = scene.instantiate()
		Game.add_child(_scene, true)
		CurrentScene = _scene
	_fade_in()

func _reload_scene():
	TransitionPlayer.play("fade_out")

func _fade_in():
	if NextTransition != null:
		TransitionPlayer.play(NextTransition)

func _swap_hud(hud = null):
	# Clear out old HUD/GUI
	for child in HUD.get_children():
		child.queue_free()
	
	if hud != null:
		var scene = load(hud).instantiate()
		HUD.add_child(scene)

func _on_game_scene_mouse_entered():
	Input.set_mouse_mode(CurrentMouse)

func _on_game_scene_mouse_exited():
	CurrentMouse = Input.get_mouse_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _start_boss(Name:String, time:float):
	BossName.text = Name
	TransitionPlayer.play("boss_in")
	var tween = get_tree().create_tween()
	tween.tween_property($CanvasLayer/Boss/BossBar, "value", 0, time)
	tween.tween_callback(_end_boss(false))

func _end_boss(success:bool):
	pass



