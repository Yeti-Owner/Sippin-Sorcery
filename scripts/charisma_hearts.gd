extends GPUParticles3D


func _ready():
	await get_tree().create_timer(1.5, true)
	self.queue_free()
