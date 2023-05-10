extends PathFollow3D

@export var Info:CharacterSheet 
const speed := 0.2

func _ready():
	$Dialogue.text = Info.Dialog
	$Body.CharName = Info.Name
	$Body.color = Info.FavColor

func _physics_process(delta):
	if self.progress_ratio < 1:
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)
	elif self.progress_ratio == 1:
		set_physics_process(false)
