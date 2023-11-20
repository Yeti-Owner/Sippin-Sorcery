extends PathFollow3D

@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
@onready var Apparation := preload("res://scenes/apparation.tscn")
@onready var Dialogue := $SpeechBubble

# "Name" : Gender, Problem, Flavor
const BossList := {
	"Humphrey": ["Male", "Give me 1 of everything, and quickly or I'll fail you", "Any flavor just make it snappy"],
	"Monkey": ["Male", "I want to turn people into monkeys, make a potion", "banana"],
	"Garfield": ["Male"]
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
	
	CharName = BossId
	Gender = BossList[BossId][0]
	BossProblem = BossList[BossId][1]
	BossTaste = BossList[BossId][2]
	
	_dress()

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		var collider = $RayCast3D.get_collider()
		var colliderName = collider.name
		
		if colliderName == "Kill":
			$BodyMeshes/Hat.set_surface_override_material(0, null)
			
			var a := Apparation.instantiate()
			a.position = self.position
			get_parent().add_child(a)
			
			self.queue_free()
			return
		elif colliderName == "Stop" and not talked:
			$Body._ask_problem()
			talked = true
		
		if (colliderName == "Body" or colliderName == "Stop"):
			walking = false
			AnimPlayer.play("RESET", 0.2)
			return
	
	if self.progress_ratio < 1:
		walking = true
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)

func _result(success:bool, flavor:bool):
	var Response:String
	if (success) and (flavor):
		# Good
		Response = "Alright I guess you'll pass"
		EventBus.Balance += 15
	else:
		Response = "Nice try, you fail this inspection"
		EventBus.Balance -= 35
		EventBus.Reputation -= 15
	
	Dialogue._talk(Response)
	EventBus.emit_signal("BalanceChanged")
	$WaitTimer.start()

# In future they have whole weird models or something idk
func _dress():
	
	# Change to some boss exclusive torso instead of ministry
	$BodyMeshes/Torso.set_mesh(load("res://assets/models/characters/torsos/MinistryTorso.obj"))
	
	match Gender:
		"Male":
			$BodyMeshes/Hat.set_mesh(load(PotionInfo.MaleHatList[randi() % PotionInfo.MaleHatList.size()]))
			$BodyMeshes/Pants.set_mesh(load(PotionInfo.MalePantList[randi() % PotionInfo.MalePantList.size()]))
		"Female":
			$BodyMeshes/Hat.set_mesh(load(PotionInfo.FemaleHatList[randi() % PotionInfo.FemaleHatList.size()]))
			$BodyMeshes/Pants.set_mesh(load(PotionInfo.FemalePantList[randi() % PotionInfo.FemalePantList.size()]))
	
	var mat = StandardMaterial3D.new()
	mat.albedo_texture = load(PotionInfo.HatColorList[randi() % PotionInfo.HatColorList.size()])
	$BodyMeshes/Hat.set_surface_override_material(0, mat)
	
	
	$BodyMeshes/Head.set_mesh(load(PotionInfo.HeadList[randi() % PotionInfo.HeadList.size()]))
	var L = load(PotionInfo.LegList[randi() % PotionInfo.LegList.size()])
	$BodyMeshes/Leg1.set_mesh(L)
	$BodyMeshes/Leg2.set_mesh(L)
#	$BodyMeshes/Arm1.set_mesh(load("res://assets/models/characters/arm.obj"))
#	$BodyMeshes/Arm2.set_mesh(load("res://assets/models/characters/arm.obj"))

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false

func _on_animation_player_animation_finished(_anim_name):
	if walking:
		AnimPlayer.play("walk")

func _on_anim_timer_timeout():
	if (AnimPlayer.is_playing() == false) and walking == true:
		AnimPlayer.play("walk")
