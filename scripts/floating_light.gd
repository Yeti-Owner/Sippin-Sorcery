extends Node3D


func _ready():
	randomize()
	$Timer.wait_time = randf_range(0.05, 4.5)
#	print($Timer.wait_time)
	$Timer.start()

func _on_timer_timeout():
	$AnimationPlayer.play("idle")
