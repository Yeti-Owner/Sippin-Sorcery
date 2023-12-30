extends Node3D


func _ready():
	EventBus.connect("HeldItemChanged", _new_item)

func _new_item():
	for child in self.get_children():
		child.queue_free()
	if EventBus.HeldItem != null:
		var Location = str("res://scenes/helditems/" + str(EventBus.HeldItem) + ".tscn")
		var item = load(Location).instantiate()
		add_child(item)
