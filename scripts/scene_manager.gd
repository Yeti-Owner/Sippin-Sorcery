extends Node

@onready var TransitionPlayer := $AnimPlayer
@onready var GameScene := $GameScene
@onready var HUD := $GameScene/HUD
@onready var Game := $GameScene/Game
@onready var Dialogue := $GameScene/Dialogue

var SceneToLoad: String
var CurrentScene:Node
var NextTransition:String
var CurrentMode:String

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

func _scene_load():
	if CurrentScene != null:
		CurrentScene.queue_free()
	
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

func _swap_hud(hud):
	# Clear out old HUD/GUI
	for child in HUD.get_children():
		child.queue_free()
	
	var scene:PackedScene = load(hud)
	var _scene:Node = scene.instantiate()
	HUD.add_child(_scene)
