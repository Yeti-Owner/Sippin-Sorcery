extends PathFollow3D

@export var Info:CharacterSheet
@onready var Dialogue := $SpeechBubble
const speed := 0.04
var talked:bool = false

func _ready():
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor

func _physics_process(delta):
	if $RayCast3D.is_colliding() and ($RayCast3D.get_collider().name == "Body" or $RayCast3D.get_collider().name == "Stop"):
		if $RayCast3D.get_collider().name == "Stop" and talked == false:
			Dialogue._talk(Info.Dialog)
			talked = true
		return
	elif self.progress_ratio < 1:
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)
	elif self.progress_ratio == 1:
		return
	
	if $RayCast3D.is_colliding() and $RayCast3D.get_collider().name == "Kill":
		self.queue_free()

func _finished(success:int, flavor:bool):
	# I should add some sort of check for this so each 
	# flavor response matches the success response.
	# Not too hard, just add to each match entry and make
	# CorrectFlavor a bool to check which one to use.
	var CorrectFlavor:String = ", tastes good" if flavor == true else ", I don't like that flavor"
	match success:
		-1:
			Dialogue._talk(str("That's not what I wanted" + CorrectFlavor))
		0:
			Dialogue._talk(str("okay then" + CorrectFlavor))
		1:
			Dialogue._talk(str("Thank you" + CorrectFlavor))
		2:
			Dialogue._talk(str("Thank you!!" + CorrectFlavor))
		3:
			Dialogue._talk(str("Thank you so much!" + CorrectFlavor))
		4:
			Dialogue._talk(str("Awesome! Thank you so much!" + CorrectFlavor))
		_:
			Dialogue._talk(str("PERFECT!!!" + CorrectFlavor))
	
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false
