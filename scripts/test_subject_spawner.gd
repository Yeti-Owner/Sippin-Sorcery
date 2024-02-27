extends Path3D

@onready var SpawnTimer := $SpawnTimer
const TestSubject := preload("res://scenes/characters/test_subject.tscn")

func _ready():
	randomize()
	SpawnTimer.wait_time = randi_range(10, 18)
	SpawnTimer.start()

func _on_spawn_timer_timeout():
	if self.get_child_count() == 1:
		var t = TestSubject.instantiate()
		add_child(t)
	SpawnTimer.wait_time = 5
	SpawnTimer.start()
