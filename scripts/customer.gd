extends PathFollow3D

@export var Info:CharacterSheet
@onready var Dialogue := $SpeechBubble
@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
const speed := 0.04
var talked:bool = false
var walking:bool = true

func _ready():
	randomize()
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor
	AnimPlayer.play("walk")
	_dress()

func _physics_process(delta):
	if $RayCast3D.is_colliding():
		var collider = $RayCast3D.get_collider()
		var colliderName = collider.name
		
		if colliderName == "Kill":
			self.queue_free()
			return
		elif colliderName == "Stop" and not talked:
			Dialogue._talk(Info.Dialog)
			talked = true
		
		if (colliderName == "Body" or colliderName == "Stop"):
			walking = false
			AnimPlayer.play("RESET", 0.2)
			return
	
	if self.progress_ratio < 1:
		walking = true
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)

# Old Dress Function
#func _dress():
#	$BodyMeshes/Hat.set_mesh(Info.Hat)
#
#	var mat = StandardMaterial3D.new()
#	mat.albedo_texture = Info.HatColor
#	$BodyMeshes/Hat.set_surface_override_material(0, mat)
#
#	$BodyMeshes/Head.set_mesh(Info.Head)
#	$BodyMeshes/Torso.set_mesh(Info.Torso)
#	$BodyMeshes/Arm1.set_mesh(Info.Arm)
#	$BodyMeshes/Arm2.set_mesh(Info.Arm)
#	$BodyMeshes/Pants.set_mesh(Info.Pants)
#	$BodyMeshes/Leg1.set_mesh(Info.Leg)
#	$BodyMeshes/Leg2.set_mesh(Info.Leg)

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
	-1: "That's not what I wanted%s",
	0: "okay then%s",
	1: "Thanks%s",
	2: "Thank you!!%s",
	3: "Thank you so much!!%s",
	4: "Awesome!! Thank you so much!!%s",
}

func _finished(success: int, flavor: bool):
	var correctFlavor: String = "" if flavor else " and I don't like that flavor"
	var dialogueText: String = DIALOGUE_TEXTS.get(success, "PERFECT!!!%s")
	
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
