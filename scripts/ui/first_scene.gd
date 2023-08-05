extends Control


func _ready():
	SceneManager._change_scene("res://scenes/ui/menu.tscn")
	queue_free()
