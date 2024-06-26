extends PathFollow3D

@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
@onready var Apparation := preload("res://scenes/apparation.tscn")
@onready var Dialogue := $SpeechBubble

const MaleNames := ["Liam", "Noah", "Ethan", "Oliver", "Ben", "Elijah", "James", "William", "Benjamin", "Lucas", "Mason", "Logan", "Alexander", "Michael", "Jose", "Jessie"]
const FemaleNames :=  ["Hannah", "Olivia", "Ava", "Isabella", "Sophia", "Mia", "Amelia", "Grace", "Evelyn", "Abigail", "Emily", "Elizabeth", "Charlotte", "Sofia", "Aria", "Jessie"]

const Problems := ["Give me a potion of strength please.","Do you have a potion of levitation?","You got a potion of charisma?","Can I get a draught of sleep potion?","Hmm have something for swimming?","Do you perchance have a potion of petrification?","Give me a potion of invisibility.","Potion of flexibility?","Potion of luck please.","Could I please buy a potion of speed?","I would like 1 potion of agility please."]
@onready var Problem:String = Problems[randi() % Problems.size()]
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
	if (randi() % 2 == 1):
		Gender = "Male"
		CharName = MaleNames[randi() % MaleNames.size()]
	else:
		Gender = "Female"
		CharName = FemaleNames[randi() % FemaleNames.size()]
	
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
			
			EventBus.emit_signal("CustomerDone")
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

const GoodResponses = ["Oh it's just juice","Oh, juice","Hmm I still don't believe you","You got lucky I bet","You pass this time","Nice one","Surprising"]
const BadResponses = ["I knew you were selling illegal potions","Nice try","Almost had us","So close yet so far","Better luck next time"]
func _result(success:bool, flavor:bool):
	var Response:String
	if success:
		# Good
		Response = GoodResponses.pick_random()
		EventBus.Balance += 10
	else:
		Response = BadResponses.pick_random()
		EventBus.Balance -= 25
		EventBus.Reputation -= 2
	
	if flavor:
		Response += ", tastes good."
		EventBus.Balance += 10
	else:
		Response += ", don't like that flavor."
	
	if success and flavor:
		$ResponseSound.stream = load("res://assets/audio/good.ogg")
		$ResponseSound.play()
	else:
		$ResponseSound.stream = load("res://assets/audio/bad.ogg")
		$ResponseSound.play()
	
	Dialogue._talk(Response)
	EventBus.emit_signal("BalanceChanged")
	$WaitTimer.start()

# New Dress Function
func _dress():
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
