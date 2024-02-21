extends Node3D

func _ready():
	get_node("/root/SceneManager/GameScene").visible =  false
	$AnimationPlayer.play("spins")
