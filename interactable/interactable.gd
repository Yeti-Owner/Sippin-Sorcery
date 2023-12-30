extends Node

class_name Interactable

func get_interaction_text():
	return "Interact"

func get_interaction_icon():
	return EventBus.CrosshairTex

func interact():
	print("Interacted with me")

func _reset():
	$CollisionShape3D.disabled = true
	await get_tree().create_timer(0.01, true).timeout
	$CollisionShape3D.disabled = false

