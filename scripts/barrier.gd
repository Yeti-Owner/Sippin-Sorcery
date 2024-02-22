extends Node3D

var MaxRange:float = 5.0

func _ready():
	EventBus.connect("RemoveBarrier", _remove_self)

func _on_check_timer_timeout():
	if get_node_or_null(EventBus.PlayerPath) != null:
		var DistanceAway:float = self.position.distance_to(get_node(EventBus.PlayerPath).position)
		if (DistanceAway < MaxRange): # if within range change transparency
			var NewAlpha = 0.8 - (DistanceAway - 2.4) * (0.8 / (MaxRange - 2.4))
			$Wall1.mesh.material.albedo_color = Color(0.08627451211214, 1, 1, NewAlpha)
		else:
			$Wall1.mesh.material.albedo_color = Color(0.08627451211214, 1, 1, 0)
#		get_node(EventBus.PlayerPath) # gets player

func _remove_self():
	self.queue_free()
