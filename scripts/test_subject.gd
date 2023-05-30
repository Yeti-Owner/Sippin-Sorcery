extends PathFollow3D

const speed := 0.14
var state := "walk"

func _physics_process(delta):
	if self.progress_ratio == 1 and state != "leave":
		state = "stop"
	elif state == "walk":
		self.progress_ratio = min(self.progress_ratio + (speed * delta), 1)
	elif self.progress_ratio == 0 and state == "leave":
		self.queue_free()
	elif state == "leave":
		self.progress_ratio = max(self.progress_ratio - (speed * delta), 0)

func _on_timer_timeout():
	state = "leave"
