extends PathFollow3D

@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
@onready var Apparation := preload("res://scenes/apparation.tscn")
@onready var Dialogue := $SpeechBubble

# "Name" : Gender, Problem, Flavor, Time
const BossList := {
	"Tom": ["Male", "Give me Courage", "Orange or Banana please", 30],
	"Humphrey": ["Male", "Give me 1 of everything, and don't forget the flavor.", "Any flavor just make it snappy.", 120],
	"Sir Higgins": ["Male", "I want to turn people into monkeys, make a potion or you fail.", "I'm monkey obsessed, take a wild guess what flavor I want.", 120],
	"Garfield": ["Male", "Something to help me sleep would be great, you know the drill.", "Lasagna, make it happen.", 120]
}
# "Name" : Hat, Head, Torso, Pants, Legs
const BossDress := {
	"Tom": ["res://assets/models/characters/hats/Hair1.obj", null, null, null, null],
	"Humphrey": ["res://assets/models/characters/hats/Hair7.obj", "res://assets/models/characters/bosses/Humphrey_Head.obj", null, null, null],
	"Sir Higgins": ["res://assets/models/characters/bosses/SirHiggins_Hair.obj","res://assets/models/characters/bosses/SirHiggins_Head.obj","res://assets/models/characters/bosses/SirHiggins_Torso.obj", null, null],
	"Garfield": ["res://assets/models/characters/bosses/Garf/Garfield_Hair.obj","res://assets/models/characters/bosses/Garf/Garfield_Head.obj","res://assets/models/characters/bosses/Garf/Garfield_Torso.obj","res://assets/models/characters/bosses/Garf/Garfield_Pants.obj","res://assets/models/characters/bosses/Garf/Garfield_Leg.obj"]
}
@onready var BossId:String = (BossList.keys()[get_parent().BossSpawn]) # like "Humphrey"
var BossProblem:String
var BossTaste:String

var CharName:String
var Gender:String

const speed := 0.04
var talked:bool = false
var walking:bool = true

func _ready():
	randomize()
	
	var a := Apparation.instantiate()
	add_child(a)
	
	AnimPlayer.play("walk")
	
	$Body.CharName = BossId
	Gender = BossList[BossId][0]
	BossProblem = BossList[BossId][1]
	BossTaste = BossList[BossId][2]
	
	_dress()
	
	SceneManager._start_boss(BossId, BossList[BossId][3])

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		var collider = $RayCast3D.get_collider()
		var colliderName = collider.name
		
		if colliderName == "Kill":
			$BodyMeshes/Hat.set_surface_override_material(0, null)
			
			var a := Apparation.instantiate()
			a.position = self.position
			get_parent().add_child(a)
			
			EventBus.emit_signal("CustomerDone")
			self.queue_free()
			return
		elif colliderName == "Stop" and not talked:
			$Body._ask_problem()
			talked = true
			SceneManager.BossTimer.start()
		
		if (colliderName == "Body" or colliderName == "Stop"):
			walking = false
			AnimPlayer.play("RESET", 0.2)
			return
	
	if self.progress_ratio < 1:
		walking = true
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)

const GoodResponses = ["Alright I guess you'll pass.","Well, it's not bad.","You pass this time.","I suppose you did fine.","It's good.","That was passable."]
const BadResponses = ["Nice try, you fail this inspection.","So close but nah you fail.","Maybe next time?","Failed!","That was terrible."]
func _result(success:bool, flavor:bool):
	var Response:String
	if (success) and (flavor):
		# Good
		Response = GoodResponses.pick_random()
		EventBus.Balance += 60
		SceneManager.BossDone.emit(true)
		EventBus.BossesBeaten += 1
		$ResponseSound.stream = load("res://assets/audio/good.ogg")
		$ResponseSound.play()
	else:
		# Bad
		Response = BadResponses.pick_random()
		SceneManager.BossDone.emit(false)
		$ResponseSound.stream = load("res://assets/audio/bad.ogg")
		$ResponseSound.play()
	$Body.Used = true
	
	Dialogue._talk(Response)
	EventBus.emit_signal("BalanceChanged")
	$WaitTimer.start()

func _dress():
	if BossDress[BossId][2] != null:
		$BodyMeshes/Torso.set_mesh(load(BossDress[BossId][2]))
	else:
		$BodyMeshes/Torso.set_mesh(load("res://assets/models/characters/torsos/MinistryTorso.obj"))
	
	if BossDress[BossId][3] == null:
		match Gender:
			"Male":
				$BodyMeshes/Pants.set_mesh(load(PotionInfo.MalePantList[randi() % PotionInfo.MalePantList.size()]))
			"Female":
				$BodyMeshes/Pants.set_mesh(load(PotionInfo.FemalePantList[randi() % PotionInfo.FemalePantList.size()]))
	else:
		$BodyMeshes/Pants.set_mesh(load(BossDress[BossId][3]))
	
	if BossDress[BossId][0] != null:
		$BodyMeshes/Hat.set_mesh(load(BossDress[BossId][0]))
	
	if BossDress[BossId][1] != null:
		if BossDress[BossId][1] == "res://assets/models/characters/bosses/Garf/Garfield_Head.obj":
			$BodyMeshes/Head.position = Vector3(0.05, 0.6, -0.05)
			$BodyMeshes/Hat.position = Vector3(0.05, 1.25, -0.05)
		$BodyMeshes/Head.set_mesh(load(BossDress[BossId][1]))
	else:
		$BodyMeshes/Head.set_mesh(load(PotionInfo.HeadList[randi() % PotionInfo.HeadList.size()]))
	
	var L
	if BossDress[BossId][4] == null:
		L = load(PotionInfo.LegList[randi() % PotionInfo.LegList.size()])
	else:
		L = load(BossDress[BossId][4])
	$BodyMeshes/Leg1.set_mesh(L)
	$BodyMeshes/Leg2.set_mesh(L)
	
	if BossId == "Garfield":
		$BodyMeshes/Arm1.set_mesh(load("res://assets/models/characters/bosses/Garf/Garfield_Arm.obj"))
		$BodyMeshes/Arm2.set_mesh(load("res://assets/models/characters/bosses/Garf/Garfield_Arm.obj"))

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false

func _on_animation_player_animation_finished(_anim_name):
	if walking:
		AnimPlayer.play("walk")

func _on_anim_timer_timeout():
	if (AnimPlayer.is_playing() == false) and walking == true:
		AnimPlayer.play("walk")
