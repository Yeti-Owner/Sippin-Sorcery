extends PathFollow3D

@export var Info:CharacterSheet
@onready var Dialogue := $Text
const speed := 0.2

func _ready():
	Dialogue.mesh.text = Info.Dialog
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor

func _physics_process(delta):
	if $RayCast3D.is_colliding() and ($RayCast3D.get_collider().name == "Body" or $RayCast3D.get_collider().name == "Stop"):
		return
	elif self.progress_ratio < 1:
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)
	elif self.progress_ratio == 1:
		return
	
	if $RayCast3D.is_colliding() and $RayCast3D.get_collider().name == "Kill":
		self.queue_free()

func _finished(success:int):
	match success:
		-1:
			Dialogue.mesh.text = "Ew"
		0:
			Dialogue.mesh.text = "okay then"
		1:
			Dialogue.mesh.text = "Thank you"
		2:
			Dialogue.mesh.text = "Thank you!"
		3:
			Dialogue.mesh.text = "Thank you so much!"
		4:
			Dialogue.mesh.text = "Thank you so much!!"
		_:
			Dialogue.mesh.text = "PERFECT!"
	
	$WaitTimer.start()

func _on_wait_timer_timeout():
	$RayCast3D.collide_with_bodies = false
