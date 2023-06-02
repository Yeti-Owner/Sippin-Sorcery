extends PathFollow3D

@export var Info:CharacterSheet
@onready var Dialogue := $SpeechBubble
@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
const speed := 0.04
var talked:bool = false
var walking:bool = true

func _ready():
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor
	AnimPlayer.play("walk")
	_dress()

func _physics_process(delta):
	if $RayCast3D.is_colliding() and ($RayCast3D.get_collider().name == "Body" or $RayCast3D.get_collider().name == "Stop"):
		if $RayCast3D.get_collider().name == "Stop" and talked == false:
			Dialogue._talk(Info.Dialog)
			talked = true
		walking = false
		AnimPlayer.play("RESET", 0.2)
		return
	elif self.progress_ratio < 1:
		walking = true
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)
	elif self.progress_ratio == 1:
		return
	
	if $RayCast3D.is_colliding() and $RayCast3D.get_collider().name == "Kill":
		self.queue_free()

func _dress():
	$BodyMeshes/Hat.set_mesh(Info.Hat)
	$BodyMeshes/Head.set_mesh(Info.Head)
	$BodyMeshes/Torso.set_mesh(Info.Torso)
	$BodyMeshes/Arm1.set_mesh(Info.Arm)
	$BodyMeshes/Arm2.set_mesh(Info.Arm)
	$BodyMeshes/Pants.set_mesh(Info.Pants)
	$BodyMeshes/Leg1.set_mesh(Info.Leg)
	$BodyMeshes/Leg2.set_mesh(Info.Leg)

func _finished(success:int, flavor:bool):
	match success:
		-1:
			var CorrectFlavor:String = " but it tastes good" if flavor == true else " and I don't like that flavor"
			Dialogue._talk(str("That's not what I wanted" + CorrectFlavor))
		0:
			var CorrectFlavor:String = ", tastes good I guess" if flavor == true else ", don't like that flavor"
			Dialogue._talk(str("okay then" + CorrectFlavor))
		1:
			var CorrectFlavor:String = " and it tastes great" if flavor == true else " but use a different flavor next time"
			Dialogue._talk(str("Thanks" + CorrectFlavor))
		2:
			var CorrectFlavor:String = " and it tastes perfect!!" if flavor == true else " almost perfect but not that flavor"
			Dialogue._talk(str("Thank you!!" + CorrectFlavor))
		3:
			var CorrectFlavor:String = " love the flavor!!" if flavor == true else " hate that taste though"
			Dialogue._talk(str("Thank you so much!!" + CorrectFlavor))
		4:
			var CorrectFlavor:String = " tastes awesome!!" if flavor == true else " almost got it perfect, but use a new flavor"
			Dialogue._talk(str("Awesome!! Thank you so much!!" + CorrectFlavor))
		_:
			var CorrectFlavor:String = " LOVE THIS FLAVOR" if flavor == true else " except the flavor..."
			Dialogue._talk(str("PERFECT!!!" + CorrectFlavor))
	
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false

func _on_animation_player_animation_finished(_anim_name):
	if walking:
		AnimPlayer.play("walk")

func _on_anim_timer_timeout():
	if (AnimPlayer.is_playing() == false) and walking == true:
		AnimPlayer.play("walk")
