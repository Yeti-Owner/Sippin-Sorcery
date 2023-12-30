extends Node

@onready var TransitionPlayer := $AnimPlayer
@onready var GameScene := $GameScene
@onready var HUD := $GameScene/HUD
@onready var Game := $GameScene/Game

@onready var BossName := $CanvasLayer/Boss/BossName
@onready var BossBar := $CanvasLayer/Boss/BossBar
@onready var BossTimer := $Timer
signal BossDone(Success:bool)
var BossTime := 0

var SceneToLoad: String
var CurrentScene:Node
var NextTransition:String
var CurrentMode:String
var CurrentMouse := Input.MOUSE_MODE_VISIBLE

func _ready():
	Game.use_occlusion_culling = true
	Engine.set_max_fps(120)
	BossDone.connect(_end_boss)

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


# To be fixed or removed, supposed to make mouse come back in when
# alt-tabbing out but just bugs stuff
func _on_game_scene_mouse_entered():
	return
	Input.set_mouse_mode(CurrentMouse)

func _on_game_scene_mouse_exited():
	return
	CurrentMouse = Input.get_mouse_mode()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Start the boss, just needs name and time
# Time is an amount in seconds
func _start_boss(Name:String, time:int = 100):
	BossBar.max_value = 100
	BossName.text = Name
	TransitionPlayer.play("boss_in")
	BossTime = time

# Call this with success being true (good) or false (bad)
func _end_boss(success:bool):
	if success:
		# Good ending, tween whatever value is in the healthbar to 0
		BossTimer.stop()
		var tween := get_tree().create_tween()
		tween.tween_property(BossBar, "value", 0, 3)
		tween.tween_callback(_end_boss.bind(false))
	else: # bad ending, just fade transition is called
		TransitionPlayer.play("boss_out")

func _on_timer_timeout(): # happens every second, just takes from boss hp
	BossBar.value = max(0, BossBar.value - 1)
	if BossBar.value > 0:
		BossTimer.start()
	else: 
		# if value reaches zero emits signal
		# if signal called some things will happen fs but within SceneManager
		# only _end_boss is called with a false value
		BossDone.emit(false)

func _on_anim_player_animation_finished(anim_name):
	if anim_name == "boss_in": 
		# when boss transition ends it sets the
		# "time" value in _start_boss and then starts timer
		BossBar.max_value = BossTime
		BossBar.value = BossTime 
#		BossTimer.start()

func _stop_boss():
	BossTimer.stop()
	BossBar.visible = false
	BossName.visible = false
