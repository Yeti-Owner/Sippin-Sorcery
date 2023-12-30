extends PathFollow3D

@onready var AnimPlayer := $BodyMeshes/AnimationPlayer
@onready var Apparation := preload("res://scenes/apparation.tscn")

const MaleNames := ["Jack","Thomas","James","Daniel", "Joshua","Matthew","William","David","Joseph","Benjamin","Oliver","Ryan","Alexander","Christopher","Samuel","Michael","Smith","Larry","Drew"]
const FemaleNames := ["Emily","Jessica", "Charlotte","Sophie", "Olivia", "Emma", "Hannah", "Amy", "Lucy", "Rebecca", "Megan", "Lauren", "Katie", "Ellie", "Grace","Bianca","Maggie","Taylor"]
var CharName:String
var Gender:String

var speed := 0.14
var state := "walk"


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
	match state:
		"walk":
			if self.progress_ratio < 1:
				self.progress_ratio = min((self.progress_ratio + (speed * delta)), 1)
			else:
				state = "stop"
		"leave":
			if self.progress_ratio > 0:
				self.progress_ratio = max((self.progress_ratio - (speed * delta)), 0)
			else:
				var a := Apparation.instantiate()
				a.position = self.position
				get_parent().add_child(a)
				
				$BodyMeshes/Hat.set_surface_override_material(0, null)
				
				self.queue_free()
		"stop":
			if self.progress_ratio == 1:
				state = "stop"
				AnimPlayer.play("RESET", 0.2)

func _on_timer_timeout():
	state = "leave"
	$BodyMeshes.rotation_degrees.y += 180

func _on_animation_player_animation_finished(_anim_name):
	if state == "walk" or state == "leave":
		AnimPlayer.play("walk")

func _on_anim_timer_timeout():
	if (state == "walk" or state == "leave") and (AnimPlayer.is_playing() == false):
		AnimPlayer.play("walk")

func _dress():
	$BodyMeshes/Torso.set_mesh(load(PotionInfo.TorsoList[randi() % PotionInfo.TorsoList.size()]))
	
	match Gender:
		"Male":
			$BodyMeshes/Hat.set_mesh(load(PotionInfo.MaleHatList[randi() % PotionInfo.MaleHatList.size()]))
			$BodyMeshes/Pants.set_mesh(load(PotionInfo.MalePantList[randi() % PotionInfo.MalePantList.size()]))
		"Female":
			$BodyMeshes/Hat.set_mesh(load(PotionInfo.FemaleHatList[randi() % PotionInfo.FemaleHatList.size()]))
			$BodyMeshes/Pants.set_mesh(load(PotionInfo.FemalePantList[randi() % PotionInfo.FemalePantList.size()]))
	
	var mat := StandardMaterial3D.new()
	@warning_ignore("int_as_enum_without_cast")
	mat.set_texture(0, load(PotionInfo.HatColorList[randi() % PotionInfo.HatColorList.size()]))
	$BodyMeshes/Hat.set_surface_override_material(0, mat)
	
	
	$BodyMeshes/Head.set_mesh(load(PotionInfo.HeadList[randi() % PotionInfo.HeadList.size()]))
	var L = load(PotionInfo.LegList[randi() % PotionInfo.LegList.size()])
	$BodyMeshes/Leg1.set_mesh(L)
	$BodyMeshes/Leg2.set_mesh(L)
#	$BodyMeshes/Arm1.set_mesh(load("res://assets/models/characters/arm.obj"))
#	$BodyMeshes/Arm2.set_mesh(load("res://assets/models/characters/arm.obj"))
