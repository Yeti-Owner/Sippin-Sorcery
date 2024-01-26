extends PathFollow3D

@export var Info:CharacterSheet
@onready var Dialogue := $SpeechBubble
@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
@onready var Apparation := preload("res://scenes/apparation.tscn")
@onready var Difficulty:int = get_parent().List
const speed := 0.04
var talked:bool = false
var walking:bool = true
var Frustrated:bool = false
var LeaveTime:int

func _ready():
	randomize()
	
	EventBus.ActiveCustomers += 1
	
	var a := Apparation.instantiate()
	add_child(a)
	
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor
	AnimPlayer.play("walk")
	_dress()
	
	match Difficulty:
		0:
			LeaveTime = 60
		1:
			LeaveTime = 50
		2:
			LeaveTime = 40
		3:
			LeaveTime = 40


func _physics_process(delta):
	if $RayCast3D.is_colliding():
		var collider = $RayCast3D.get_collider()
		var colliderName = collider.name
		
		if colliderName == "Kill":
			$BodyMeshes/Hat.set_surface_override_material(0, null)
			
			var a := Apparation.instantiate()
			a.position = self.position
			get_parent().add_child(a)
			
			EventBus.ActiveCustomers -= 1
			EventBus.emit_signal("CustomerDone")
			self.queue_free()
			return
		elif colliderName == "Stop" and not talked:
			$LeaveTimer.start(LeaveTime)
			Dialogue._talk(Info.Dialog)
			talked = true
		
		if (colliderName == "Body" or colliderName == "Stop"):
			walking = false
			AnimPlayer.play("RESET", 0.2)
			return
	
	if self.progress_ratio < 1:
		walking = true
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)

# New Dress Function
func _dress():
	$BodyMeshes/Torso.set_mesh(load(PotionInfo.TorsoList[Info.House - 1]))
	
	match Info.Gender:
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


const DIALOGUE_TEXTS = {
	0: "That's not what I wanted%s",
	1: "Thanks%s",
	2: "Perfect!%s"
}
const SuccessSounds := ["res://assets/audio/bad.ogg", "res://assets/audio/medium.ogg", "res://assets/audio/good.ogg"]

func _finished(success: int, flavor: bool):
	var correctFlavor: String = "" if flavor else " and I don't like that flavor"
	var dialogueText: String = DIALOGUE_TEXTS.get(success, "Thanks%s")
	
	EventBus.Reputation += clamp(success, 0, 4)
	$ResponseSound.stream = load(SuccessSounds[clamp(success, 0, 3)])
	$ResponseSound.play()
	
	dialogueText = dialogueText % correctFlavor
	Dialogue._talk(dialogueText)
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false

func _on_animation_player_animation_finished(_anim_name):
	if walking:
		AnimPlayer.play("walk")

func _on_anim_timer_timeout():
	if (AnimPlayer.is_playing() == false) and walking == true:
		AnimPlayer.play("walk")

func _on_leave_timer_timeout():
	if Frustrated == false:
		var HurryList := ["Mind hurrying up?","I have places to be you know.","Taking your sweet time huh.","Could you speed it up?","Dude, could you go any slower.","I'll be shriveled up and old by the time you're done.","I'm begging you to hurry up dude."]
		Dialogue._talk(HurryList[randi() % HurryList.size()])
		$LeaveTimer.start(LeaveTime)
		Frustrated = true
	else:
		var GoneList := ["Yeah I'm leaving.","This takes way too long dude.","Next time hurry up.","I'm never returning.","I hope you go out of business."]
		Dialogue._talk(GoneList[randi() % GoneList.size()])
		$WaitTimer.start()
		get_node("Body").Used = true
