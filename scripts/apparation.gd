extends Node3D

func _ready():
	$particles.set_emitting(true)

func _on_end_timer_timeout():
	self.queue_free()
