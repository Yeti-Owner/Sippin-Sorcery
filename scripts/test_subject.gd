extends PathFollow3D

const speed := 0.14
var deltaMultiplier: float = 0
var state := "walk"

func _physics_process(delta):
	if deltaMultiplier == 0:
		deltaMultiplier = speed * delta
	
	match state:
		"walk":
			if self.progress_ratio < 1:
				self.progress_ratio += deltaMultiplier
				self.progress_ratio = min(self.progress_ratio, 1)
			else:
				state = "stop"
		"leave":
			if self.progress_ratio > 0:
				self.progress_ratio -= deltaMultiplier
				self.progress_ratio = max(self.progress_ratio, 0)
			else:
				self.queue_free()
		_:
			if self.progress_ratio == 1:
				state = "stop"
			elif self.progress_ratio == 0 and state == "leave":
				self.queue_free()

func _on_timer_timeout():
	state = "leave"
